Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE059C88E56
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4FCF10E3B9;
	Fri, 11 Sep 2026 12:18:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aAQ+hldR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAD2110E3B9
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 12:18:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4EDB24060F;
 Fri, 11 Sep 2026 12:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E6E1F000FF;
 Fri, 11 Sep 2026 12:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789129091;
 bh=jHKVUDAo0z6whhrbNJF6SbfebzVXyt+Gb9SGUTy+yyQ=;
 h=From:Date:Subject:To:Cc;
 b=aAQ+hldRYIpJ6p0ID74ri/6MY9oOOJ8vjpAHP+ZrrTZLv7SfQowrcHJlh3wDdz1a2
 54aXH7q0KVSmzSdCkwanyJyTX2iLlYstI6vKa9u6pG8/SnxhFq6UTGsJfIryByNXNH
 78vFSRtqG9f9dlTi66FjFrgNn5JUF0DqgD0gJmbzt/svJb2nVhXZUGjQwr1EuYuooK
 +zhSiGLj5WSmnfJADDSnS/gYBeSJUaixEwlzhylE1YJnuip3YI1XCReighjjEBapGk
 3snE4TF89RgAyKlIS8nwufk6i80XVEXkDc9Nhr+MOPtP7gD2wPgwPF3psWnUAroxOI
 qkZBdg3ZYVELg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 11 Sep 2026 14:18:04 +0200
Subject: [PATCH v2] drm/ci: Add CI pipeline for drm-misc branches
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-drm-drm-misc-ci-v2-1-1847f89585cb@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ7CIBBEf6XZs2sosUQ8+R+mhwpru9GCWQzRN
 Py7yN3DHN5MZmaDRMKU4NRtIJQ5cQwV9K4Dt0xhJmRfGbTSRlml0cvatHJy6BjJGWfsoEyNoba
 eQjd+t8XLWHnh9IryaQe5/7n/t3KPPR6sVwNpfaTper6TBHrso8wwllK+UEnhjq8AAAA=
X-Change-ID: 20260902-drm-drm-misc-ci-ec6c69506609
To: Helen Koike <helen.fornazier@gmail.com>, 
 Vignesh Raman <vignesh.raman@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 llvm@lists.linux.dev, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6653; i=mripard@kernel.org;
 h=from:subject:message-id; bh=NzzY7RUdWhKU2ZfFof5lCsnTC/UnuSb4itF8/l+oQfY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmLP9ZVSdxuWVafcuJbwOo58YpOL/9fDXl2Lp9Jecr/t
 6btObIqHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAimZcZa6Xm/Jzdn3XT+IqV
 Rt1XKa2m+9XeEloqf3T2bn37p3TRxym5m1Inqaf7T2pav2O+7VS3RMaGbZ/Pden8u6+/QZgzq4G
 5JiDmxq5lx36E/WpPsVsrlvj8wraHRhKdDOuv7ZNymDA71M4dAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The DRM CI infrastructure builds upon Mesa's CI to run IGT tests on
hardware. Its focus is on functional testing on a selected number of
targets.

The concern for drm-misc is different: it merges a large number of
patches across many platforms, and build or unit test breakages happen
on a regular basis. Adding build and unit testing for drm-misc has been
on the back of our minds, and a first attempt was made last year. The
feedback was to rely more on the existing infrastructure.

Introduce a CI entry point that runs on pushes to drm-misc-next,
drm-misc-fixes, and drm-misc-next-fixes. It reuses kunit.yml,
check-devicetrees.yml, and the freedesktop ci-templates, while defining
build templates inline to avoid pulling in the Mesa pipeline.

A single Debian container with LLVM handles cross-compilation to all
three architectures. The pipeline compiles the kernel using defconfigs
from the drm/tip rerere-cache branch, runs the DRM KUnit tests, and
checks device tree bindings.

Link: https://lore.kernel.org/all/20250319-greedy-sturgeon-from-avalon-ac758f@houat/
Acked-by: Vignesh Raman <vignesh.raman@collabora.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Changes in v2:
- Run dt_bindings_check
- Run on push instead of MR after some discussions with Dave and Sima
- Test run here: https://gitlab.freedesktop.org/mripard/kernel/-/pipelines/1744733
- Link to v1: https://lore.kernel.org/r/20260902-drm-drm-misc-ci-v1-1-49d05e228eab@kernel.org
---
 drivers/gpu/drm/ci/drm-misc-ci.yml | 147 +++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/drivers/gpu/drm/ci/drm-misc-ci.yml b/drivers/gpu/drm/ci/drm-misc-ci.yml
new file mode 100644
index 000000000000..4ab87547794e
--- /dev/null
+++ b/drivers/gpu/drm/ci/drm-misc-ci.yml
@@ -0,0 +1,147 @@
+# CI pipeline for drm-misc-next, drm-misc-fixes, and drm-misc-next-fixes.
+#
+# Runs on pushes to drm-misc-next, drm-misc-fixes, and
+# drm-misc-next-fixes. Compiles the kernel for arm, arm64, and
+# x86_64, runs the DRM KUnit tests, and checks device tree bindings.
+#
+# A single container image is built using freedesktop ci-templates with
+# the packages needed for kernel compilation and LLVM for
+# cross-compilation. QEMU is installed at runtime by the KUnit jobs.
+#
+# check-devicetrees.yml and kunit.yml are included directly. build.yml
+# and the Mesa container/build pipelines are not:
+# they pull in hundreds of Mesa-specific jobs and templates that would
+# each need to be individually stubbed or disabled. The build templates
+# (.build:arm32, .build:arm64, .build:x86_64) are defined inline.
+
+variables:
+  CI_TEMPLATES_COMMIT: &ci-templates-commit aec7a6ce7bb38902c70641526f6611e27141784a
+  # Project whose container registry stores the built images
+  FDO_UPSTREAM_REPO: mripard/kernel
+  KERNEL_BUILD_CONTAINER_TAG: "2026-09-11-01"
+  LLVM_VERSION: "19"
+
+default:
+  before_script: []
+
+include:
+  - project: 'freedesktop/ci-templates'
+    ref: *ci-templates-commit
+    file:
+      - '/templates/debian.yml'
+  - local: drivers/gpu/drm/ci/check-devicetrees.yml
+  - local: drivers/gpu/drm/ci/kunit.yml
+
+stages:
+  - container
+  - build
+  - static-checks
+  - kunit
+
+# --- Pipeline rules ---
+workflow:
+  rules:
+    - if: $CI_PIPELINE_SOURCE == "push" && $CI_COMMIT_BRANCH =~ /^drm-misc-(next|fixes|next-fixes)$/
+      when: always
+
+# kunit.yml's jobs inherit .build-rules through the .build:* chain.
+# Pass everything through since the pipeline is already gated by
+# workflow:rules.
+.build-rules:
+  rules:
+    - when: on_success
+
+# --- Container build job ---
+# Single container with all build tools. LLVM handles cross-compilation
+# to arm and arm64, so no architecture-specific containers are needed.
+debian/kernel-build:
+  extends: .fdo.container-build@debian
+  stage: container
+  variables:
+    FDO_DISTRIBUTION_VERSION: trixie
+    FDO_DISTRIBUTION_TAG: "${KERNEL_BUILD_CONTAINER_TAG}"
+    FDO_DISTRIBUTION_PACKAGES: >-
+      bc bison ca-certificates cpio curl
+      clang-${LLVM_VERSION} flex gcc gzip
+      lld-${LLVM_VERSION} llvm-${LLVM_VERSION}
+      libelf-dev libssl-dev
+      make perl pkg-config
+      python3 python3-dev python3-pip python3-venv
+      swig xz-utils yamllint
+
+# --- Build templates ---
+# Stubs for templates referenced by check-devicetrees.yml. The
+# originals live in build.yml and container.yml which we do not
+# include.
+.build:
+  extends: .build-rules
+
+.use-debian/x86_64_build:
+  extends: .build-base
+
+.build-base:
+  image: "${CI_REGISTRY}/${FDO_UPSTREAM_REPO}/debian/trixie:${KERNEL_BUILD_CONTAINER_TAG}"
+  needs: ["debian/kernel-build"]
+
+.build:arm32:
+  extends: .build-base
+  variables:
+    KERNEL_ARCH: "arm"
+    DEFCONFIG_ARCH: "arm"
+
+.build:arm64:
+  extends: .build-base
+  variables:
+    KERNEL_ARCH: "arm64"
+    DEFCONFIG_ARCH: "arm64"
+
+.build:x86_64:
+  extends: .build-base
+  variables:
+    KERNEL_ARCH: "x86_64"
+    DEFCONFIG_ARCH: "x86"
+
+# --- Kernel-wide build jobs (LLVM) ---
+.kernel-build:
+  stage: build
+  timeout: 45m
+  variables:
+    GIT_DEPTH: 1
+    DEFCONFIG_URL: https://gitlab.freedesktop.org/drm/tip/-/raw/rerere-cache/drm-misc-${DEFCONFIG_ARCH}_defconfig
+  artifacts: {}
+  before_script:
+    - drivers/gpu/drm/ci/setup-llvm-links.sh
+    - curl -L --retry 4 -f --retry-all-errors --retry-delay 60 -o .config "${DEFCONFIG_URL}"
+
+kernel-build:arm32:
+  extends: [.build:arm32, .kernel-build]
+  script:
+    - make ARCH=arm LLVM=1 olddefconfig
+    - make ARCH=arm LLVM=1 -j$(nproc)
+
+kernel-build:arm64:
+  extends: [.build:arm64, .kernel-build]
+  script:
+    - make ARCH=arm64 LLVM=1 olddefconfig
+    - make ARCH=arm64 LLVM=1 -j$(nproc)
+
+kernel-build:x86_64:
+  extends: [.build:x86_64, .kernel-build]
+  script:
+    - make ARCH=x86 LLVM=1 olddefconfig
+    - make ARCH=x86 LLVM=1 -j$(nproc)
+
+# --- Disable dtbs-check jobs ---
+# dtbs-check validates compiled DTBs which may produce warnings from
+# code we are not responsible for. Keep dt-binding-check only.
+dtbs-check:arm32:
+  rules:
+    - when: never
+
+dtbs-check:arm64:
+  rules:
+    - when: never
+
+# --- KUnit jobs ---
+# kunit:arm32, kunit:arm64, and kunit:x86_64 are defined in kunit.yml
+# and implicitly enabled here through the .build:* templates above.

---
base-commit: 99c95ce1b07081d7944d637ba7d72d835c0d520a
change-id: 20260902-drm-drm-misc-ci-ec6c69506609

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

