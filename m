Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8576EC79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 05:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACC7A10E9CC;
	Tue,  8 Sep 2026 05:55:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=vignesh.raman@collabora.com header.b="Bw6/daUO";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24ABA10E836
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 05:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788846908; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cUWkgscG8AHsvrcfFpG5VMmsMQomZokJ4Z2tfqrkCrr/K6HjKc8SQ0/ai+1Y66am7X8Q06+MDus+Y4XM5eC92LLTo0AH8vlKK34j0atW1nD3RpEZIA2HiJSTL/XNCA2i0YD9wo8tsO7JyabqIVLGcJrjAXotUpF6258EYS5NIV8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788846908;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=6Lg+hZBGT7qrSYitLwz/FL+6Ch1zpGqQ0ojp5/EMqiU=; 
 b=VFYkrqkR5K2Y76t6UI2UzNDvz0Sncz5cjAVHmRY4yn0ca/eSnGpXUBx23RNEQ1N83jlukS0oH1WUWKVYRbYYrlIt1YhdlJbvFQTynZEHbYCd8VX7Pp2w7YMsaDyBYAK3xqv+ko8pdytVM4p8uSX/S+6R27uUuhe9u1lAFwOj6Ls=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=vignesh.raman@collabora.com;
 dmarc=pass header.from=<vignesh.raman@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788846908; 
 s=zohomail; d=collabora.com; i=vignesh.raman@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=6Lg+hZBGT7qrSYitLwz/FL+6Ch1zpGqQ0ojp5/EMqiU=;
 b=Bw6/daUOQ5yHGfII7Si24GunSW/8R8ctachyJNhQcZ8ddBSdL01IpC2ay2WlhMay
 RQf6dldbd1Xch5ziujy9ZyZF+7hzqeUc+l45fC88E19WtK+axr1uFeK/wRdPmNwCNrK
 meOO8LS6fNNDn79ulj2VMgmMOaFohzoruRG/5cO8=
Received: by mx.zohomail.com with SMTPS id 1788846906556533.9074319549773;
 Mon, 7 Sep 2026 22:55:06 -0700 (PDT)
Message-ID: <84bd2c70-360a-4c25-a73c-70eca291c99b@collabora.com>
Date: Tue, 8 Sep 2026 11:25:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ci: Add CI pipeline for drm-misc branches
To: Maxime Ripard <mripard@kernel.org>,
 Helen Koike <helen.fornazier@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 llvm@lists.linux.dev
References: <20260902-drm-drm-misc-ci-v1-1-49d05e228eab@kernel.org>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <20260902-drm-drm-misc-ci-v1-1-49d05e228eab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
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

Hi Maxime,

On 02/09/26 13:47, Maxime Ripard wrote:
> The DRM CI infrastructure [1] builds upon Mesa's CI to run IGT tests
> on hardware. Its focus is on functional testing on a selected number
> of targets.
> 
> The concern for drm-misc is different: it merges a large number of
> patches across many platforms, and build or unit test breakages happen
> on a regular basis. Adding build and unit testing for drm-misc has
> been on the back of our minds, and a first attempt was made last year.
> The feedback was to rely more on the existing infrastructure.
> 
> Introduce a CI entry point for merge requests targeting drm-misc-next,
> drm-misc-fixes, and drm-misc-next-fixes. It reuses kunit.yml and the
> freedesktop ci-templates, while defining build templates inline to
> avoid pulling in the Mesa pipeline.
> 
> A single Debian container with LLVM handles cross-compilation to all
> three architectures. The pipeline compiles the kernel using defconfigs
> from the drm/tip rerere-cache branch and runs the DRM KUnit tests.

Thanks for the patch. We can reuse the check-patch and dtbs jobs as 
well. This can be done as a separate patch.

Acked-by: Vignesh Raman <vignesh.raman@collabora.com>

> 
> Link: https://lore.kernel.org/all/20250319-greedy-sturgeon-from-avalon-ac758f@houat/
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/ci/drm-misc-ci.yml | 123 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 123 insertions(+)
> 
> diff --git a/drivers/gpu/drm/ci/drm-misc-ci.yml b/drivers/gpu/drm/ci/drm-misc-ci.yml
> new file mode 100644
> index 000000000000..40c6d7ba1afb
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/drm-misc-ci.yml
> @@ -0,0 +1,123 @@
> +# CI pipeline for drm-misc-next, drm-misc-fixes, and drm-misc-next-fixes.
> +#
> +# Runs on merge requests only. Compiles the kernel for arm, arm64, and
> +# x86_64, and executes the DRM KUnit tests on each architecture.
> +#
> +# A single container image is built using freedesktop ci-templates with
> +# the packages needed for kernel compilation and LLVM for
> +# cross-compilation. QEMU is installed at runtime by the KUnit jobs.
> +#
> +# build.yml and the Mesa container/build pipelines are not included
> +# here: they pull in hundreds of Mesa-specific jobs and templates that
> +# would each need to be individually stubbed or disabled. The few
> +# templates we need (.build:arm32, .build:arm64, .build:x86_64) are
> +# simple enough to define inline.
> +
> +variables:
> +  CI_TEMPLATES_COMMIT: &ci-templates-commit aec7a6ce7bb38902c70641526f6611e27141784a
> +  # Project whose container registry stores the built images
> +  FDO_UPSTREAM_REPO: mripard/kernel
> +  KERNEL_BUILD_CONTAINER_TAG: "2026-09-02-01"
> +  LLVM_VERSION: "19"
> +
> +default:
> +  before_script: []
> +
> +include:
> +  - project: 'freedesktop/ci-templates'
> +    ref: *ci-templates-commit
> +    file:
> +      - '/templates/debian.yml'
> +  - local: drivers/gpu/drm/ci/kunit.yml
> +
> +stages:
> +  - container
> +  - build
> +  - kunit
> +
> +# --- Pipeline rules ---
> +workflow:
> +  rules:
> +    - if: $CI_PIPELINE_SOURCE == "merge_request_event" && $CI_MERGE_REQUEST_TARGET_BRANCH_NAME =~ /^drm-misc-(next|fixes|next-fixes)$/
> +      when: always
> +
> +# kunit.yml's jobs inherit .build-rules through the .build:* chain.
> +# Pass everything through since the pipeline is already gated by
> +# workflow:rules.
> +.build-rules:
> +  rules:
> +    - when: on_success
> +
> +# --- Container build job ---
> +# Single container with all build tools. LLVM handles cross-compilation
> +# to arm and arm64, so no architecture-specific containers are needed.
> +debian/kernel-build:
> +  extends: .fdo.container-build@debian
> +  stage: container
> +  variables:
> +    FDO_DISTRIBUTION_VERSION: trixie
> +    FDO_DISTRIBUTION_TAG: "${KERNEL_BUILD_CONTAINER_TAG}"
> +    FDO_DISTRIBUTION_PACKAGES: >-
> +      bc bison ca-certificates cpio curl
> +      clang-${LLVM_VERSION} flex gzip
> +      lld-${LLVM_VERSION} llvm-${LLVM_VERSION}
> +      libelf-dev libssl-dev
> +      make perl pkg-config python3
> +      xz-utils
> +
> +# --- Build templates ---
> +.build-base:
> +  image: "${CI_REGISTRY}/${FDO_UPSTREAM_REPO}/debian/trixie:${KERNEL_BUILD_CONTAINER_TAG}"
> +  needs: ["debian/kernel-build"]
> +
> +.build:arm32:
> +  extends: .build-base
> +  variables:
> +    KERNEL_ARCH: "arm"
> +    DEFCONFIG_ARCH: "arm"
> +
> +.build:arm64:
> +  extends: .build-base
> +  variables:
> +    KERNEL_ARCH: "arm64"
> +    DEFCONFIG_ARCH: "arm64"
> +
> +.build:x86_64:
> +  extends: .build-base
> +  variables:
> +    KERNEL_ARCH: "x86_64"
> +    DEFCONFIG_ARCH: "x86"
> +
> +# --- Kernel-wide build jobs (LLVM) ---
> +.kernel-build:
> +  stage: build
> +  timeout: 45m
> +  variables:
> +    GIT_DEPTH: 1
> +    DEFCONFIG_URL: https://gitlab.freedesktop.org/drm/tip/-/raw/rerere-cache/drm-misc-${DEFCONFIG_ARCH}_defconfig
> +  artifacts: {}
> +  before_script:
> +    - drivers/gpu/drm/ci/setup-llvm-links.sh
> +    - curl -L --retry 4 -f --retry-all-errors --retry-delay 60 -o .config "${DEFCONFIG_URL}"
> +
> +kernel-build:arm32:
> +  extends: [.build:arm32, .kernel-build]
> +  script:
> +    - make ARCH=arm LLVM=1 olddefconfig
> +    - make ARCH=arm LLVM=1 -j$(nproc)
> +
> +kernel-build:arm64:
> +  extends: [.build:arm64, .kernel-build]
> +  script:
> +    - make ARCH=arm64 LLVM=1 olddefconfig
> +    - make ARCH=arm64 LLVM=1 -j$(nproc)
> +
> +kernel-build:x86_64:
> +  extends: [.build:x86_64, .kernel-build]
> +  script:
> +    - make ARCH=x86 LLVM=1 olddefconfig
> +    - make ARCH=x86 LLVM=1 -j$(nproc)
> +
> +# --- KUnit jobs ---
> +# kunit:arm32, kunit:arm64, and kunit:x86_64 are defined in kunit.yml
> +# and implicitly enabled here through the .build:* templates above.
> 
> ---
> base-commit: 0116f19db5931348c937eafa1f76a9a19bf82c81
> change-id: 20260902-drm-drm-misc-ci-ec6c69506609
> 
> Best regards,

