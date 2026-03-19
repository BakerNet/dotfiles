-- Test-related plugins
return {
    {
        dir = "~/Projects/test-at-point",
        config = function()
            require('test-at-point').setup({
                -- Key mappings
                keymaps = {
                    run_test = "<leader>tt",
                    run_last = "<leader>tr",
                    debug_test = "<leader>td",
                    select_test = "<leader>ts",
                },
                -- Language-specific settings
                languages = {
                    python = {
                        commands = {
                            "docker compose run --rm test --reuse-db --nomigrations --no-cov %s::%s",
                            "python -m pytest -xvs %s::%s"
                        },
                        debug_commands = {
                            "python -m debugpy --listen 5678 --wait-for-client -m pytest -xvs %s::%s"
                        },
                    },
                    typescript = {
                        patterns = {
                            "test%s*%(%s*['\"]([^'\"]+)['\"]",
                            "it%s*%(%s*['\"]([^'\"]+)['\"]"
                        },
                        commands = {
                            "yarn test -- --testNamePattern='%s'",
                            "npm test -- --testNamePattern='%s'",
                            "vitest run -t '%s'"
                        },
                        root_markers = { "package.json", "vitest.config.ts" },
                        test_file_patterns = { "**/*.test.ts", "**/*.test.tsx", "**/*.spec.ts", "**/*.spec.tsx" }
                    }
                    ,
                    typescriptreact = {
                        patterns = {
                            "test%s*%(%s*['\"]([^'\"]+)['\"]",
                            "it%s*%(%s*['\"]([^'\"]+)['\"]"
                        },
                        commands = {
                            "yarn test -- --testNamePattern='%s'",
                            "npm test -- --testNamePattern='%s'",
                            "vitest run -t '%s'"
                        },
                        root_markers = { "package.json", "vitest.config.ts" },
                        test_file_patterns = { "**/*.test.ts", "**/*.test.tsx", "**/*.spec.ts", "**/*.spec.tsx" }
                    }
                }
            })
        end
    },
}
