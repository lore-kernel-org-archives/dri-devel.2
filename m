Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C75CCF2DA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA75610E4D5;
	Mon, 19 Oct 2026 10:01:05 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 101E910E4D5
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1792404058;
 bh=egbULZ03EDGavKIkuF8cK7yURukL6dKszh6+khdiwR8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZNjfAR8SD5Lkd9jrByeIce9HaMAGkCY4vqO6CS7559mRXv3Ga2iFSGBBcslFCW6NE
 td8U+ifFP43HwTtuBt4wUVeVibnPfVqh3Hm5NFWjfAxbn7PAYoSJo/CUDaFd7OLVjZ
 c+W8b9wS/UHIzli85r1XGtSXHixpT3BB1Ju7I7Ig/OQfHh4LFr5dLgNe1OUK39cZOP
 Smzb1E/zhiSN8MpdLc1rNrh/OxgW7HZFdrjhMJW8dauxDevZcZo7SgiNpjrNK/ENGj
 tESGEFPkPGQXetNEOsCNLhGZfDhuk720xgyS8nXD5TjXonR+GR44moEtm9G2Fceguc
 kvGTJvCMy6QNQ==
Received: from [100.64.0.157] (unknown [100.64.0.157])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: vignesh)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 511A917E04B2;
 Mon, 19 Oct 2026 12:00:56 +0200 (CEST)
Message-ID: <9e1fc5c6-53ff-4a4d-9744-77bcf6a0325e@collabora.com>
Date: Mon, 19 Oct 2026 15:30:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/ci: Add CI pipeline for drm-misc branches
To: Maxime Ripard <mripard@kernel.org>,
 Helen Koike <helen.fornazier@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 llvm@lists.linux.dev
References: <20260911-drm-drm-misc-ci-v2-1-1847f89585cb@kernel.org>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <20260911-drm-drm-misc-ci-v2-1-1847f89585cb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

On 11/09/26 17:48, Maxime Ripard wrote:
> The DRM CI infrastructure builds upon Mesa's CI to run IGT tests on
> hardware. Its focus is on functional testing on a selected number of
> targets.
> 
> The concern for drm-misc is different: it merges a large number of
> patches across many platforms, and build or unit test breakages happen
> on a regular basis. Adding build and unit testing for drm-misc has been
> on the back of our minds, and a first attempt was made last year. The
> feedback was to rely more on the existing infrastructure.
> 
> Introduce a CI entry point that runs on pushes to drm-misc-next,
> drm-misc-fixes, and drm-misc-next-fixes. It reuses kunit.yml,
> check-devicetrees.yml, and the freedesktop ci-templates, while defining
> build templates inline to avoid pulling in the Mesa pipeline.
> 
> A single Debian container with LLVM handles cross-compilation to all
> three architectures. The pipeline compiles the kernel using defconfigs
> from the drm/tip rerere-cache branch, runs the DRM KUnit tests, and
> checks device tree bindings.
> 
> Link: https://lore.kernel.org/all/20250319-greedy-sturgeon-from-avalon-ac758f@houat/
> Acked-by: Vignesh Raman <vignesh.raman@collabora.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Changes in v2:
> - Run dt_bindings_check
> - Run on push instead of MR after some discussions with Dave and Sima
> - Test run here: https://gitlab.freedesktop.org/mripard/kernel/-/pipelines/1744733
> - Link to v1: https://lore.kernel.org/r/20260902-drm-drm-misc-ci-v1-1-49d05e228eab@kernel.org

Acked-by: Vignesh Raman <vignesh.raman@collabora.com>

Regards,
Vignesh

> ---
>   drivers/gpu/drm/ci/drm-misc-ci.yml | 147 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 147 insertions(+)
> 
> diff --git a/drivers/gpu/drm/ci/drm-misc-ci.yml b/drivers/gpu/drm/ci/drm-misc-ci.yml
> new file mode 100644
> index 000000000000..4ab87547794e
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/drm-misc-ci.yml
> @@ -0,0 +1,147 @@
> +# CI pipeline for drm-misc-next, drm-misc-fixes, and drm-misc-next-fixes.
> +#
> +# Runs on pushes to drm-misc-next, drm-misc-fixes, and
> +# drm-misc-next-fixes. Compiles the kernel for arm, arm64, and
> +# x86_64, runs the DRM KUnit tests, and checks device tree bindings.
> +#
> +# A single container image is built using freedesktop ci-templates with
> +# the packages needed for kernel compilation and LLVM for
> +# cross-compilation. QEMU is installed at runtime by the KUnit jobs.
> +#
> +# check-devicetrees.yml and kunit.yml are included directly. build.yml
> +# and the Mesa container/build pipelines are not:
> +# they pull in hundreds of Mesa-specific jobs and templates that would
> +# each need to be individually stubbed or disabled. The build templates
> +# (.build:arm32, .build:arm64, .build:x86_64) are defined inline.
> +
> +variables:
> +  CI_TEMPLATES_COMMIT: &ci-templates-commit aec7a6ce7bb38902c70641526f6611e27141784a
> +  # Project whose container registry stores the built images
> +  FDO_UPSTREAM_REPO: mripard/kernel
> +  KERNEL_BUILD_CONTAINER_TAG: "2026-09-11-01"
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
> +  - local: drivers/gpu/drm/ci/check-devicetrees.yml
> +  - local: drivers/gpu/drm/ci/kunit.yml
> +
> +stages:
> +  - container
> +  - build
> +  - static-checks
> +  - kunit
> +
> +# --- Pipeline rules ---
> +workflow:
> +  rules:
> +    - if: $CI_PIPELINE_SOURCE == "push" && $CI_COMMIT_BRANCH =~ /^drm-misc-(next|fixes|next-fixes)$/
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
> +      clang-${LLVM_VERSION} flex gcc gzip
> +      lld-${LLVM_VERSION} llvm-${LLVM_VERSION}
> +      libelf-dev libssl-dev
> +      make perl pkg-config
> +      python3 python3-dev python3-pip python3-venv
> +      swig xz-utils yamllint
> +
> +# --- Build templates ---
> +# Stubs for templates referenced by check-devicetrees.yml. The
> +# originals live in build.yml and container.yml which we do not
> +# include.
> +.build:
> +  extends: .build-rules
> +
> +.use-debian/x86_64_build:
> +  extends: .build-base
> +
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
> +# --- Disable dtbs-check jobs ---
> +# dtbs-check validates compiled DTBs which may produce warnings from
> +# code we are not responsible for. Keep dt-binding-check only.
> +dtbs-check:arm32:
> +  rules:
> +    - when: never
> +
> +dtbs-check:arm64:
> +  rules:
> +    - when: never
> +
> +# --- KUnit jobs ---
> +# kunit:arm32, kunit:arm64, and kunit:x86_64 are defined in kunit.yml
> +# and implicitly enabled here through the .build:* templates above.
> 
> ---
> base-commit: 99c95ce1b07081d7944d637ba7d72d835c0d520a
> change-id: 20260902-drm-drm-misc-ci-ec6c69506609
> 
> Best regards,

