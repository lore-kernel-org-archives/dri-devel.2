Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFF0C61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:17:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D01510F05F;
	Wed,  2 Sep 2026 08:17:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M+gx8d/w";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A99A610F051
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 08:17:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 89A0B600C8;
 Wed,  2 Sep 2026 08:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF79E1F000E9;
 Wed,  2 Sep 2026 08:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788337036;
 bh=pVE2qTsB0mK6s2rRiXMfL8ZarYqiiXhFuJg8Bj9f++c=;
 h=From:Date:Subject:To:Cc;
 b=M+gx8d/w06R2s4CJEPm2iclJUby+/xjc+h7L6rm79z17Za2E6fgQuAPOfjwadeTYV
 jeDiyVFEB0+enpjCaG6YC3M21ckM4Deco+8SNcjXGkSnown/Ovm6r0xrPhrQOBnweR
 MhOMeuZ3vxImdPMFg77smOZYVd5shz4RRFZCp+Rgg2Fwq//VP61dWdaImhhK7B1ayV
 oXlZv4GykMhqQaHfs2P0QSqNjv+5sj1+0O8qenXY4wWeQ53EVqtvl0isXEjSReHBHa
 Xh2gcqoBufHR6FUc18wuojm5Q8mIw3I+MmOASaCsJorq5t6mcRkR2ugadDtwC8+n6U
 aiPhbTJdKul4w==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 02 Sep 2026 10:17:09 +0200
Subject: [PATCH] drm/ci: Add CI pipeline for drm-misc branches
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-drm-drm-misc-ci-v1-1-49d05e228eab@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSwMj3ZSiXDDOzSxO1k3O1E1NNks2szQ1MANKKwF1FRSlpmVWgE2Mjq2
 tBQAg1iAAYQAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5559; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Ovo5Mcq/jYwM8ezUqUEBJTNujsmMpJ978tHQdMnoGg8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnTb3f8NH+t5vz4Bb9yItuO7+aSV6dmVHBv0F3YM+d0X
 62GZWdTx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjIRxPGhq+renbp3zz9b1Nt
 Ut1JCffXf79/mv1DIGO5nMpuO4s9e8ydxJjCXOsO8Ys/n6x8b9mUnYwNuz4z7WPSMF5g4SHTVe2
 8r/f7EdVTaie2Ty3mDbsZ/2b+nG+mQve+HQopDt7G217iENgKAA==
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

The DRM CI infrastructure [1] builds upon Mesa's CI to run IGT tests
on hardware. Its focus is on functional testing on a selected number
of targets.

The concern for drm-misc is different: it merges a large number of
patches across many platforms, and build or unit test breakages happen
on a regular basis. Adding build and unit testing for drm-misc has
been on the back of our minds, and a first attempt was made last year.
The feedback was to rely more on the existing infrastructure.

Introduce a CI entry point for merge requests targeting drm-misc-next,
drm-misc-fixes, and drm-misc-next-fixes. It reuses kunit.yml and the
freedesktop ci-templates, while defining build templates inline to
avoid pulling in the Mesa pipeline.

A single Debian container with LLVM handles cross-compilation to all
three architectures. The pipeline compiles the kernel using defconfigs
from the drm/tip rerere-cache branch and runs the DRM KUnit tests.

Link: https://lore.kernel.org/all/20250319-greedy-sturgeon-from-avalon-ac758f@houat/
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/ci/drm-misc-ci.yml | 123 +++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/drivers/gpu/drm/ci/drm-misc-ci.yml b/drivers/gpu/drm/ci/drm-misc-ci.yml
new file mode 100644
index 000000000000..40c6d7ba1afb
--- /dev/null
+++ b/drivers/gpu/drm/ci/drm-misc-ci.yml
@@ -0,0 +1,123 @@
+# CI pipeline for drm-misc-next, drm-misc-fixes, and drm-misc-next-fixes.
+#
+# Runs on merge requests only. Compiles the kernel for arm, arm64, and
+# x86_64, and executes the DRM KUnit tests on each architecture.
+#
+# A single container image is built using freedesktop ci-templates with
+# the packages needed for kernel compilation and LLVM for
+# cross-compilation. QEMU is installed at runtime by the KUnit jobs.
+#
+# build.yml and the Mesa container/build pipelines are not included
+# here: they pull in hundreds of Mesa-specific jobs and templates that
+# would each need to be individually stubbed or disabled. The few
+# templates we need (.build:arm32, .build:arm64, .build:x86_64) are
+# simple enough to define inline.
+
+variables:
+  CI_TEMPLATES_COMMIT: &ci-templates-commit aec7a6ce7bb38902c70641526f6611e27141784a
+  # Project whose container registry stores the built images
+  FDO_UPSTREAM_REPO: mripard/kernel
+  KERNEL_BUILD_CONTAINER_TAG: "2026-09-02-01"
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
+  - local: drivers/gpu/drm/ci/kunit.yml
+
+stages:
+  - container
+  - build
+  - kunit
+
+# --- Pipeline rules ---
+workflow:
+  rules:
+    - if: $CI_PIPELINE_SOURCE == "merge_request_event" && $CI_MERGE_REQUEST_TARGET_BRANCH_NAME =~ /^drm-misc-(next|fixes|next-fixes)$/
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
+      clang-${LLVM_VERSION} flex gzip
+      lld-${LLVM_VERSION} llvm-${LLVM_VERSION}
+      libelf-dev libssl-dev
+      make perl pkg-config python3
+      xz-utils
+
+# --- Build templates ---
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
+# --- KUnit jobs ---
+# kunit:arm32, kunit:arm64, and kunit:x86_64 are defined in kunit.yml
+# and implicitly enabled here through the .build:* templates above.

---
base-commit: 0116f19db5931348c937eafa1f76a9a19bf82c81
change-id: 20260902-drm-drm-misc-ci-ec6c69506609

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

