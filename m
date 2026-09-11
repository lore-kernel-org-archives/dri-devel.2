Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C929C88E56
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B71CB10F58D;
	Fri, 11 Sep 2026 12:29:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SdMBmG5d";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A08F110F58D
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 12:29:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 556994064F
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 12:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD331F000FF;
 Fri, 11 Sep 2026 12:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789129755;
 bh=LNkVi/SzAEw92ZiuG3ruZ05MVvsT/C0vQie7kpQ5YMs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SdMBmG5doIfZggeCroZeuznr+vsO/cySqXi5PJqCuqWD+COdXu+54l/vcAIrJdL71
 9Vi/zQU72RKjZR9OE0ECep7wIeLFiKP5yvHKDY1PD1T1El9XMLtDlbMUDIoxkqHGws
 3g9hOZ8lXxELOsRkx6U53WphZDESFF+MWwc9bxzBLf6U7UuEbpTRdENh+SYp0anBsx
 zYWtjwBDgmOX9U1+HApCdmqnw44oFzfeahJIGxDqoDtn7Ou4GsCU7yD+jp1VtWHT3Y
 gGw03nsRMbw8pBLBDtMqs1nOd62OsAZ9R5ZD/PGMMKD+h1C8gMYdD9VIIwYztFhPz6
 zeMLmGjfMOMDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/ci: Add CI pipeline for drm-misc branches
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260911-drm-drm-misc-ci-v2-1-1847f89585cb@kernel.org>
References: <20260911-drm-drm-misc-ci-v2-1-1847f89585cb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:29:14 +0000
Message-Id: <20260911122915.0DD331F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The CI configuration hardcodes `FDO_UPSTREAM_REPO` to a personal r=
epository (`mripard/kernel`), breaking fork-based workflows and pointing th=
e subsystem's CI to a personal fork.

Pre-existing issues:
- [High] The `kunit:arm64` job attempts to install `qemu-system-aarch64`, w=
hich is not a valid Debian package, breaking the ARM64 KUnit pipeline.
--

commit 1c7dfd00b5030cd66091b90d1334fd1443f5c314
Author: Maxime Ripard <mripard@kernel.org>

drm/ci: Add CI pipeline for drm-misc branches

Introduce a CI entry point that runs on pushes to drm-misc branches.
The pipeline cross-compiles the kernel using LLVM on a Debian container,
runs DRM KUnit tests, and checks device tree bindings.

Link: https://lore.kernel.org/all/20250319-greedy-sturgeon-from-avalon-ac75=
8f@houat/

> diff --git a/drivers/gpu/drm/ci/drm-misc-ci.yml b/drivers/gpu/drm/ci/drm-=
misc-ci.yml
> new file mode 100644
> index 0000000000000..4ab87547794e8
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/drm-misc-ci.yml
[ ... ]
> +variables:
> +  CI_TEMPLATES_COMMIT: &ci-templates-commit aec7a6ce7bb38902c70641526f66=
11e27141784a
> +  # Project whose container registry stores the built images
> +  FDO_UPSTREAM_REPO: mripard/kernel

[Severity: High]
Does this hardcoded personal repository break fork-based CI workflows?

If a developer modifies the container in their own fork and updates the
tag, the build step will push the container to their registry. However,
downstream jobs using the .build-base template will still attempt to pull
from the mripard/kernel path because of how FDO_UPSTREAM_REPO is used here:

.build-base:
  image: "${CI_REGISTRY}/${FDO_UPSTREAM_REPO}/debian/trixie:${KERNEL_BUILD_=
CONTAINER_TAG}"

Should this variable be set to the generic upstream project path instead?

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

[Severity: High]
This is a pre-existing issue, but including kunit.yml here exposes a failure
in the kunit:arm64 job.

That job contains the following step in its before_script:

apt-get install -y --no-install-recommends qemu-system-aarch64

Is this package name correct? On Debian systems, the emulator for AArch64 is
typically provided by the qemu-system-arm package. Attempting to install
qemu-system-aarch64 directly will fail and break the ARM64 KUnit pipeline r=
un
when executed inside this Debian environment.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-drm-drm-mi=
sc-ci-v2-1-1847f89585cb@kernel.org?part=3D1
