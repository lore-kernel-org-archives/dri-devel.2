Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43C0606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akJKf4vk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA7FD10E633;
	Tue, 17 Nov 2026 15:25:35 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36C9E10E632;
 Tue, 17 Nov 2026 15:25:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 642F4635AD;
 Tue, 17 Nov 2026 15:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE9B1F000C7;
 Tue, 17 Nov 2026 15:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794929129;
 bh=geAZF0Il5WD1+26bR5uT5bi5MaP/KecTvi/DYJOMYhE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=akJKf4vkqfnvJ5nLABh28AJjppT5zPwlLXoXjZQB/2wXkKK4pB8bQUdHm8STv03w2
 v5x2dHdQszcgDmB2oabeMJALqxf0f2VyWG8bpxGzpFr+hskhv12JpBI7BKlsXcsjGX
 8e2nkqOgP6TX6bFXvqLEEKhIzUiL7UmgMpLnDsaL9c+jVZyknVNz00Y7tUtCI98DHE
 WcuE8fpSI3e5Zvbsj2hE1Pt7Hk/vt8UnlBgl+Ys9QUFb/stbOWK965mTMusgbm5xl9
 QeIzgxmhoDStywlrGlJPhfmvcsG8w060cX+mRuD4VnD5AZ9iOnJuWY0CWqVqHwANjx
 1jpS9XNscsKPg==
Message-ID: <sashiko-outbox-219062@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PM: runtime: fix stub pm_runtime_get_if_active()
 for !CONFIG_PM
To: Frank.Li@oss.nxp.com
Cc: linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org,
 media-ci@linuxtv.org
In-Reply-To: <20261116152513.2676573-1-Frank.Li@oss.nxp.com>
References: <20261116152513.2676573-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 15:25:28 +0000
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
- [Low] PM: runtime: inaccurate Fixes trailers and caller analysis in
  commit message
--

commit ef3656b915b0fdf6f58ce6d87b9638c3f1514d1a
Author: Frank Li <Frank.Li@nxp.com>

> PM: runtime: fix stub pm_runtime_get_if_active() for !CONFIG_PM
>
> When CONFIG_PM is not enabled, should be treated as if runtime PM were
> enabled for the device and the runtime status is active.
>
> It's a subtle distinction but the previous behavior returned -EINVAL, whi=
ch
> means "runtime PM is disabled for the device"
>
> __pm_runtime_resume() returns 1 (called by pm_runtime_get()).
> pm_runtime_get_if_active() is the try-and-get version of pm_runtime_get().
> stub pm_runtime_active() also returns true. So pm_runtime_get_if_active()
> should return the same value as the stub pm_runtime_get(), which is 1.
>
> Analysis of all callers and their behavior with old (-EINVAL) vs new (1):
>
> Pattern A: if (!pm_runtime_get_if_active(dev)) -- no impact
>   Both -EINVAL and 1 are non-zero, so !ret is false in both cases.
>   Callers: drivers/accel/ethosu/ethosu_perfmon.c,
>            drivers/gpu/drm/msm/adreno/a6xx_gmu.c,
>            drivers/gpu/drm/msm/msm_perfcntr.c,
>            drivers/gpu/drm/v3d/v3d_mmu.c,
>            drivers/gpu/drm/v3d/v3d_perfmon.c (x4),
>            drivers/media/i2c/gc08a3.c gc05a2.c og0ve1b.c ov6211.c,
>            drivers/media/i2c/ccs/ccs-core.c s5kjn1.c lm3560.c (x2),
>            drivers/media/i2c/s5k3m5.c thp7312.c imx283.c ov64a40.c,
>            drivers/media/pci/intel/ipu6/ipu6-buttress.c,
>            sound/hda/core/device.c
>
> Pattern B: if (!ret) after get -- no impact
>   Both -EINVAL and 1 are non-zero, !ret is false in both cases.
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c (comment says "allow access"
>     in kernels without CONFIG_PM), drivers/pci/pci.c
>
> Pattern C: ret > 0 / ret <=3D 0 / ret !=3D 1 checks -- FIXED
>   drivers/usb/core/offload.c: checks (!=3D 1), old -EINVAL caused
>     -EBUSY even with !CONFIG_PM. Fixed: now returns 1, proceeds.
>   drivers/accel/ivpu/ivpu_job.c: drm_WARN_ON(<=3D 0), old -EINVAL
>     spuriously triggered WARN. Fixed: 1 > 0, no warn.
>   drivers/gpu/drm/i915/intel_runtime_pm.c: checks (<=3D 0), old
>     -EINVAL triggered error path. Fixed: 1 > 0, correct path.
>   drivers/accel/ivpu/ivpu_sysfs.c: (> 0), old skipped freq read.
>     Fixed: proceeds correctly without CONFIG_PM.
>   drivers/gpu/drm/xe/xe_pm.c: wraps (> 0), all xe callers
>     (xe_bo.c, xe_shrinker.c, xe_vsec.c, xe_ggtt.c, xe_guc_ct.c,
>     xe_pxp.c) now correctly treat !CONFIG_PM as active.
>   drivers/net/ipa/ipa_smp2p.c: power_on =3D (> 0), now correctly true.
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c: (> 0), now correctly
>     executes stall register update.
>   drivers/staging/media/ipu7/ipu7-buttress.c: active (<=3D 0) early
>     return now skipped, correctly proceeds.
>
> Pattern D: explicit -EINVAL check
>   drivers/hwmon/prom21-xhci.c: checks (> 0) then (=3D=3D -EINVAL).
>     Old: took -EINVAL fallback. New: takes (> 0) fast path.
>     Both succeed when CONFIG_PM is disabled; functionally equivalent.
>   drivers/hwmon/eic7700-pvt.c: call is guarded by IS_ENABLED(CONFIG_PM),
>     stub is never reached. No impact.
>
> Fixes: bd3d245b0fef5 ("usb: core: use dedicated spinlock for offload stat=
e")
> Fixes: 7806bad76ac39 ("accel/ivpu: Prevent runtime suspend during context=
 abort work")
> Fixes: 9d58aa46291d4 ("drm/i915: Fix the GT fence revocation runtime PM l=
ogic")
> Fixes: 1524c28b99527 ("accel/ivpu: Show NPU frequency in sysfs")
> Fixes: 30c399529f4c6 ("drm/xe: Document Xe PM component")
> Fixes: 0d08026ac6099 ("net: ipa: kill ipa_clock_get_additional()")
> Fixes: 70892277ca2db ("iommu/arm-smmu-qcom: Make set_stall work when the =
device is on")
> Fixes: 9ad65684b9285 ("media: staging/ipu7: Ignore interrupts when device=
 is suspended")
> Acked-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

[Severity: Low]
Are some of the Fixes: tags and caller notes in the commit message
pointing to the wrong commits or config guards?

The !CONFIG_PM stub for pm_runtime_get_if_active() was introduced
returning -EINVAL in c111566bea7c ("PM: runtime: Add
pm_runtime_get_if_active()") and updated in c0ef3df8dbae ("PM: runtime:
Simplify pm_runtime_get_if_active() usage"), neither of which is listed in
Fixes:.

For the caller-specific tags and descriptions:

- 30c399529f4c ("drm/xe: Document Xe PM component") only touched kernel-doc
  comments; the > 0 check in xe_pm_runtime_get_if_active() came from
  46edb0a3eb16 ("drm/xe: Fix xe_pm_runtime_get_if_active return").

- In __intel_runtime_pm_get_if_active() in
  drivers/gpu/drm/i915/intel_runtime_pm.c, the pm_runtime_get_if_active()
  call is guarded by if (IS_ENABLED(CONFIG_PM)), so the !CONFIG_PM stub is
  never reached there and 9d58aa46291d ("drm/i915: Fix the GT fence
  revocation runtime PM logic") was not affected.  Similarly,
  snd_hdac_keep_power_up() in sound/hda/core/device.c is inside #ifdef
  CONFIG_PM and also checks if (ret < 0).

- 0d08026ac609 ("net: ipa: kill ipa_clock_get_additional()") only inlined
  ipa_clock_get_additional() into ipa_smp2p_notify(); the
  pm_runtime_get_if_active() > 0 check was introduced in a71aeff3dd0a
  ("net: ipa: kill IPA clock reference count").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116152513.2676=
573-1-Frank.Li@oss.nxp.com?part=3D1
