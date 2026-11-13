Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052E4606A6E2
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TzC7cE78
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63776112737;
	Fri, 13 Nov 2026 18:19:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4A7D112737
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:19:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CDCCA63554
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885FF1F000CB
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 18:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794593950;
 bh=/VIh85zZMfzSY6G83+v5V/TjnRLbNiLly0GYfH3nJNs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=TzC7cE78kKFl2rFE1ESKez8K3/v6Pqk/6PLrXGyiq2H8nW8RaKll1mNR/hvrBhoAX
 9WUKboDxL2p3Jax+koelb066IybY3DAyK95vGOnYrQLEWCd8zr9JB2nkLXwMD48oro
 eBlcvuFHizULDj5hONrf7IDExHONWpvIf77MgXaUD3OXBqfZQ67bfgb2xPq1SoAoJK
 T3NkAz2AcSCaHe3eo20kPD9U/cE84jkgmN3fcFTb3UIgs2jbLigXSsu2MG4WlwRKQd
 lN4tR2+CCuZNMvYNucVewMR1jQy7sxt8uriatRDaKQNHlu1Xb8w/7Uzi3R4wDwiNfg
 QeLT7VoO7hmng==
Received: by mail-lf1-f47.google.com with SMTP id
 2adb3069b0e04-5bcdae234ecso2100663e87.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 10:19:10 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErGLH6OH4P9zAiRyH0MkeHl8VD8CYciedRCoydMwxSp0pf0hMy0baRxMmGNztU8XzS374fcQFQTONfg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/p1sHFd3wgHLid8NKMF3nvm77A/6s9+JVhB6Lu1403oCAL+IE0
 U2yhk2ewSEsDmMaclWOEQ/kODlLf6ZJta1W8Y+fQV0CzNRAvbBkputTzi0hC52qfzUH1AblNyKE
 2of0l4RPtpHOxN2A6lksZU5VBpqdGeok=
X-Received: by 2002:a05:6512:1310:b0:5bf:cf80:dfd8 with SMTP id
 2adb3069b0e04-5c170a0bb47mr1769832e87.23.1794593948320; Fri, 13 Nov 2026
 10:19:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029163044.3062958-1-Frank.Li@oss.nxp.com>
In-Reply-To: <20261029163044.3062958-1-Frank.Li@oss.nxp.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 13 Nov 2026 19:18:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jyuMjh4En_r2TYui+sNbGveJ0Rz1Da39LEK9e-HxHgGA@mail.gmail.com>
X-Gm-Features: AclHuK9_YtJ6aWlSAf9yM8R-lWnFcHYi_anHWoQsLhZYkqzdVHJqxA51shEqA-Y
Message-ID: <CAJZ5v0jyuMjh4En_r2TYui+sNbGveJ0Rz1Da39LEK9e-HxHgGA@mail.gmail.com>
Subject: Re: [PATCH 1/1] PM: runtime: change stub pm_runtime_get_if_active()
 return 1 when !CONFIG_PM
To: Frank.Li@oss.nxp.com
Cc: Frank Li <Frank.Li@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>, 
 Karol Wachowski <karol.wachowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Matthew Brost <matthew.brost@intel.com>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Alex Elder <elder@kernel.org>,
 Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 Guan-Yu Lin <guanyulin@google.com>,
 Mathias Nyman <mathias.nyman@linux.intel.com>, 
 linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-hwmon@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-staging@lists.linux.dev, netdev@vger.kernel.org, imx@lists.linux.dev, 
 Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 5:31=E2=80=AFPM <Frank.Li@oss.nxp.com> wrote:
>
> From: Frank Li <Frank.Li@nxp.com>
>
> When CONFIG_PM is not enabled, all devices runtime PM state should be
> treated as active.
>
> __pm_runtime_resume() returns 1 (called by pm_runtime_get()).
> pm_runtime_get_if_active() is the try-and-get version of pm_runtime_get()=
.
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
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

People sent feedback, so I'm wondering if there's going to be a v2 or
does someone else need to take care of this going forward?
