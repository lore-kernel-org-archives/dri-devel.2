Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDA9606A339
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kMScttj5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E848A10E635;
	Tue, 17 Nov 2026 15:25:36 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C9AE10E633;
 Tue, 17 Nov 2026 15:25:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 26DA0408AA;
 Tue, 17 Nov 2026 15:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D051F000C5;
 Tue, 17 Nov 2026 15:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794929130;
 bh=bafEnHj9OQp2os8W30yYIs+yQ2nbAuaGSL1q+Ya78F4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kMScttj50pgYGX4tOqXNqQxBd14vvfsQSvpxUJxIyXUsxkpzfQGWZIr0cscd0qvto
 gT+R3gWwCzzJQA67X5fOYCjp2EP2k/ry806XWY3RacEvaiB7/uwm3KdH9ybfnROD5W
 BDJH3wKectxTh4DNlslQFwJqDLHzR2KjxF98wOwKaaZQx9xL7snwWjwmEpMoIRexVw
 BTy7GZQg2jsisz14TT8XNU9xjSkHzrX0HSU8iilG89Vj+H8V25rUVnyxUeH9c7MCmM
 L8fg8kiH86uvVraA0q+HIag+smt1jTCNYbxa9FIaKvr0Sz5K8aGfIhDqRnoxvhorwM
 jpidpahhrSJCQ==
Message-ID: <sashiko-outbox-219063@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] PM: runtime: fix stub pm_runtime_get_if_in_use()
 for !CONFIG_PM
To: Frank.Li@oss.nxp.com
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-sound@vger.kernel.org,
 imx@lists.linux.dev, Frank.Li@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261116152513.2676573-2-Frank.Li@oss.nxp.com>
References: <20261116152513.2676573-1-Frank.Li@oss.nxp.com>
 <20261116152513.2676573-2-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 15:25:29 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PM: runtime: inaccurate Fixes trailers and caller notes in
  commit message
--

commit 48057d65d03972fb7f912d84a7a35bf1b15bba82
Author: Frank Li <Frank.Li@nxp.com>

> PM: runtime: fix stub pm_runtime_get_if_in_use() for !CONFIG_PM
>
> The stub for pm_runtime_get_if_in_use() under !CONFIG_PM currently
> returns -EINVAL.  The real implementation returns:
>   1  - device is active and its usage counter is non-zero (bumped)
>   0  - device is not in use or not active (counter not bumped)
>  -EINVAL - runtime PM disabled for this device
>
> When CONFIG_PM is not set every device is permanently "active" and
> always considered "in use", so the stub must return 1, mirroring
> __pm_runtime_resume() which already returns 1 in the same build.
>
> Returning -EINVAL breaks callers that test the return value with
> comparisons other than "!=3D 0 / =3D=3D 0":
>
> drivers/gpu/drm/i915/intel_runtime_pm.c:
>   if (intel_runtime_pm_get_if_in_use(rpm))
>   which wraps to: ret =3D pm_runtime_get_if_in_use(); return ret > 0;
>   With -EINVAL the wrapper returns false, causing an incorrect error
>   path in the GT fence revocation code.
>
> drivers/gpu/drm/xe/xe_pm.c:
>   if (pm_runtime_get_if_in_use(xe->drm.dev) > 0)
>   With -EINVAL the condition is false; xe_pm_runtime_get_if_in_use()
>   returns false, so callers believe the device is not usable.
>
> drivers/gpu/drm/gma500/power.c:
>   return pm_runtime_get_if_in_use(dev) =3D=3D 1;
>   -EINVAL !=3D 1, so the helper always returns false when !CONFIG_PM.
>
> drivers/gpu/drm/imagination/pvr_power.c:
>   if (pm_runtime_get_if_in_use(...) <=3D 0)
>   -EINVAL <=3D 0 is true, so the driver always takes the "requeue" error
>   path instead of proceeding with the active device.
>
> sound/soc/sof/debug.c:
>   if (pm_runtime_get_if_in_use(sdev->dev) =3D=3D 1)
>   -EINVAL !=3D 1, so d3_prevented is never set, corrupting exception
>   debug accounting.
>
> drivers/iommu/mtk_iommu.c:
>   if (pm_runtime_get_if_in_use(dom->plat_dev->dev) <=3D 0)
>   -EINVAL <=3D 0 skips the TLB flush, leaving stale IOMMU mappings.
>
> drivers/iommu/rockchip-iommu.c:
>   Three call sites use WARN_ON_ONCE(err < 0) or similar patterns.
>   -EINVAL < 0 triggers a spurious WARNING on every call.
>
> drivers/media/i2c/isl7998x.c:
>   if (pm_runtime_get_if_in_use(dev) <=3D 0)  (two call sites)
>   -EINVAL <=3D 0 causes the driver to always skip register programming
>   when !CONFIG_PM.
>
> drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c:
>   if (pm_runtime_get_if_in_use(dev) <=3D 0)  (two call sites)
>   -EINVAL <=3D 0 prevents any debug statistics from being collected.
>
> Fixes: 9d58aa46291d ("drm/i915: Fix the GT fence revocation runtime PM lo=
gic")
> Fixes: cbb6a7413b17 ("drm/xe: Introduce xe_pm_runtime_get_noresume for in=
ner callers")
> Fixes: 672c473576ca ("drm/gma500: Rewrite power management code")
> Fixes: 727538a4bbff ("drm/imagination: Implement power management")
> Fixes: b30289e7fa92 ("ASoC: SOF: Fix runtime pm usage counter balance aft=
er fw exception")
> Fixes: c0b57581b73b ("iommu/mediatek: Add power-domain operation")
> Fixes: 0f181d3cf7d9 ("iommu/rockchip: Add runtime PM support")
> Fixes: 51ef2be546e2 ("media: i2c: isl7998x: Add driver for Intersil ISL79=
98x")
> Fixes: cbb819c363c5 ("media: rkisp1: debug: Collect input status by sampl=
ing ISP_FLAGS_SHD")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

[Severity: Low]
Are the Fixes tags and caller descriptions in the commit message accurate?

The !CONFIG_PM stub for pm_runtime_get_if_in_use() returning -EINVAL was
introduced in a436b6a19f57 ("PM / runtime: Add new helper for conditional
usage count incrementation"), which is missing from the Fixes tags.

For i915, __intel_runtime_pm_get_if_active() guards the call to
pm_runtime_get_if_in_use() with if (IS_ENABLED(CONFIG_PM)), so the
!CONFIG_PM stub is never called there, and 9d58aa46291d ("drm/i915: Fix the
GT fence revocation runtime PM logic") switched i915_vma_revoke_fence() to
with_intel_runtime_pm_if_active, which calls pm_runtime_get_if_active().

For imagination, DRM_POWERVR in drivers/gpu/drm/imagination/Kconfig has
"depends on PM" (added in 727538a4bbff ("drm/imagination: Implement power
management")), so pvr_power.c cannot be built with !CONFIG_PM.

Also, several of the remaining Fixes tags do not point to the commits that
introduced the affected checks:
- In drivers/gpu/drm/xe/xe_pm.c, the pm_runtime_get_if_in_use() > 0 check
  in xe_pm_runtime_get_if_in_use() was added by 3b85b7bcccf4 ("drm/xe: Fix
  display runtime_pm handling"), whereas cbb6a7413b17 ("drm/xe: Introduce
  xe_pm_runtime_get_noresume for inner callers") only added a caller.
- In drivers/iommu/rockchip-iommu.c, 0f181d3cf7d9 ("iommu/rockchip: Add
  runtime PM support") used boolean checks where -EINVAL evaluated to true;
  the WARN_ON_ONCE() checks on negative or non-positive returns were added
  by 3fc7c5c0cff3 ("iommu/rockchip: Handle errors returned from PM
  framework").
- In drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c, the first
  pm_runtime_get_if_in_use() <=3D 0 check in rkisp1_debug_dump_regs() was
  added earlier by 2a6b586035ec ("media: rkisp1: debug: Add debugfs files
  to dump core and ISP registers").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116152513.2676=
573-1-Frank.Li@oss.nxp.com?part=3D2
