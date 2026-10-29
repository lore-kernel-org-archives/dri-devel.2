Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F27A606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=BceE0c4E
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4338A10E838;
	Thu, 29 Oct 2026 18:11:40 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com
 [209.85.161.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5519210E826
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 18:11:33 +0000 (UTC)
Received: by mail-oo1-f51.google.com with SMTP id
 006d021491bc7-706113e92f9so1473509eaf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 11:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ieee.org; s=google; t=1793297492; x=1793902292; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gLjComLCp2esLTingR9be9ipRIp36YyskRA+PmDaCHo=;
 b=BceE0c4E467mjLtd4irK2w3nJ67W+76K/z7dEyGv/Et4kDkQ7BwYQrUpf8fvRBN3fT
 BnMgcjcdMeW5N07W0LPiqYMUvfMDwtYnE0/Xs7szh88pGJW7PfCvE//ZHc0ESw14f6Pv
 arN78dxTkPoq2w5EtsljNDaW0Le7zeaaD9/UA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793297492; x=1793902292;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gLjComLCp2esLTingR9be9ipRIp36YyskRA+PmDaCHo=;
 b=GdMZeQlHywl7zvv8RrL59AQonbk2BBfAM+RzxMvaapAOnBjMW18ARyJ2aa7I+Ur13P
 jOt2/Bvckqbx5lJbFrP6a3r9WEDC+CyFiH+P/hhI9M8f6MLuwXjrv96hCy2VQqMHXFz6
 EYZlpjGjjfogIMitG4rUOMStlSQ+T/ki4gF0U36U+55ANAurjq0+zr5rJa/iOD4Bwqkg
 /BSD2DJHFYVzWG5T9N2YDmwtbixwTYFYV/2X4KoyABMaJ+dFKg62egQiYOaEpopu0bO6
 ELmWBf6QY++JqNqVWf9FxgJNMHJWqSemAHHbDQpdTVLmEyPWbOpNL/TzHMqZuzWJ/yqP
 7t5g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxl2MaLUBtA8Juqb6aksBQWSUSF1tEAWUybFlbU1qc4bEvUPdM61ejRmI1lIqhk1Z/dLu7Es6rQcxE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKLeMR0ET6YXRFtFnvDhKtTZ3dA7dt7whgPQgJkmUzb2Z0fZ7Pu
 oUwQebaspTH+sZNpaCvvjF0Q6dityyjJKL8NVy8AZxmkAa9hUnJzHaA/wn/1bBSrCA==
X-Gm-Gg: AYBFou3hXpAU8Br5FhniXeqZZ+l0U9p/WqqkvEO8P1L02b9Ukk+dlwCS/X4d5wqq6an
 wxWF+dXLCGLZFY2NgRgPfFbzZIN8T0KkU00GcbHFDlNkIpnVC/qyRzMvkXCxGuxUZRdv7thY+mE
 SoTUlbYXC6m1QBu20diSEELZmsXPUUeLmF55MrX8xss7D3ZcK/rIhB8YdkIDk+9s0oOZv+w0BjQ
 NCD9X650kbLFZY23GLWa6A9jv12A1W/PFQJOd8H2JxNWci14zF6VOSL4zBa1ek00aNTdPR9SLi1
 /Aap3PXtaGdTTq6lGjrbNIHca85dvifRCtBVsclvXNiJMCus8O6NKyqu+o652n5i/+xrpX4uzFh
 UjK5ORBcyitojrGlq2ZbvHzgIKlWyg/LbuZYhwddqXyTRRU8hC+I6P6tjd01nTln7l67Fu8HnsO
 q/puO2voJrojDGmgyxjxy5CbSaIB/1Ozx5OcBl2nhcFgUV2pA7n8J7Q8RVaXZSgBgdX/Mr6yHI9
 IDKoLQXX0RZ2cVLFV/PX+/JN72M/Jdrn0SHyXfP3/IgwcDL35nysYloGy+0perEch6Tm5h/TEXr
 bvXQ9v5QbfO37fAe8qwyfux8r2CfTZYPQeL5Fb/zhmeWSw==
X-Received: by 2002:a05:6820:5710:10b0:6de:aeea:5c89 with SMTP id
 006d021491bc7-714f288a10fmr36729eaf.23.1793297492247; 
 Thu, 29 Oct 2026 11:11:32 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-4a904856f09sm130363fac.3.2026.10.29.11.11.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 11:11:31 -0700 (PDT)
Message-ID: <4c7a6635-7382-4e57-ae16-6bc2ee694f46@ieee.org>
Date: Thu, 29 Oct 2026 13:11:29 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] PM: runtime: change stub pm_runtime_get_if_active()
 return 1 when !CONFIG_PM
To: Frank.Li@oss.nxp.com
Cc: Frank Li <Frank.Li@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Karol Wachowski <karol.wachowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Matthew Brost <matthew.brost@intel.com>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Elder <elder@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, Guan-Yu Lin <guanyulin@google.com>,
 Mathias Nyman <mathias.nyman@linux.intel.com>, linux-pm@vger.kernel.org,
 linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 netdev@vger.kernel.org, imx@lists.linux.dev, Rob Herring <robh@kernel.org>
References: <20261029163044.3062958-1-Frank.Li@oss.nxp.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20261029163044.3062958-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 11:30 AM, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> When CONFIG_PM is not enabled, all devices runtime PM state should be
> treated as active.

Should be treated as if runtime PM were enabled for the device,
and the runtime status is active.

It's a subtle distinction but the previous behavior returned
EINVAL, which means "runtime PM is disabled for the device".

Anyway, for the IPA use of this function, this looks correct.

Acked-by: Alex Elder <elder@riscstar.com>

> 
> __pm_runtime_resume() returns 1 (called by pm_runtime_get()).
> pm_runtime_get_if_active() is the try-and-get version of pm_runtime_get().
> stub pm_runtime_active() also returns true. So pm_runtime_get_if_active()
> should return the same value as the stub pm_runtime_get(), which is 1.
> 
> Analysis of all callers and their behavior with old (-EINVAL) vs new (1):
> 
> Pattern A: if (!pm_runtime_get_if_active(dev)) -- no impact
>    Both -EINVAL and 1 are non-zero, so !ret is false in both cases.
>    Callers: drivers/accel/ethosu/ethosu_perfmon.c,
>             drivers/gpu/drm/msm/adreno/a6xx_gmu.c,
>             drivers/gpu/drm/msm/msm_perfcntr.c,
>             drivers/gpu/drm/v3d/v3d_mmu.c,
>             drivers/gpu/drm/v3d/v3d_perfmon.c (x4),
>             drivers/media/i2c/gc08a3.c gc05a2.c og0ve1b.c ov6211.c,
>             drivers/media/i2c/ccs/ccs-core.c s5kjn1.c lm3560.c (x2),
>             drivers/media/i2c/s5k3m5.c thp7312.c imx283.c ov64a40.c,
>             drivers/media/pci/intel/ipu6/ipu6-buttress.c,
>             sound/hda/core/device.c
> 
> Pattern B: if (!ret) after get -- no impact
>    Both -EINVAL and 1 are non-zero, !ret is false in both cases.
>    drivers/gpu/drm/amd/pm/amdgpu_pm.c (comment says "allow access"
>      in kernels without CONFIG_PM), drivers/pci/pci.c
> 
> Pattern C: ret > 0 / ret <= 0 / ret != 1 checks -- FIXED
>    drivers/usb/core/offload.c: checks (!= 1), old -EINVAL caused
>      -EBUSY even with !CONFIG_PM. Fixed: now returns 1, proceeds.
>    drivers/accel/ivpu/ivpu_job.c: drm_WARN_ON(<= 0), old -EINVAL
>      spuriously triggered WARN. Fixed: 1 > 0, no warn.
>    drivers/gpu/drm/i915/intel_runtime_pm.c: checks (<= 0), old
>      -EINVAL triggered error path. Fixed: 1 > 0, correct path.
>    drivers/accel/ivpu/ivpu_sysfs.c: (> 0), old skipped freq read.
>      Fixed: proceeds correctly without CONFIG_PM.
>    drivers/gpu/drm/xe/xe_pm.c: wraps (> 0), all xe callers
>      (xe_bo.c, xe_shrinker.c, xe_vsec.c, xe_ggtt.c, xe_guc_ct.c,
>      xe_pxp.c) now correctly treat !CONFIG_PM as active.
>    drivers/net/ipa/ipa_smp2p.c: power_on = (> 0), now correctly true.
>    drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c: (> 0), now correctly
>      executes stall register update.
>    drivers/staging/media/ipu7/ipu7-buttress.c: active (<= 0) early
>      return now skipped, correctly proceeds.
> 
> Pattern D: explicit -EINVAL check
>    drivers/hwmon/prom21-xhci.c: checks (> 0) then (== -EINVAL).
>      Old: took -EINVAL fallback. New: takes (> 0) fast path.
>      Both succeed when CONFIG_PM is disabled; functionally equivalent.
>    drivers/hwmon/eic7700-pvt.c: call is guarded by IS_ENABLED(CONFIG_PM),
>      stub is never reached. No impact.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> Cc: Karol Wachowski <karol.wachowski@linux.intel.com>
> Cc: Oded Gabbay <ogabbay@kernel.org>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: "Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Alex Elder <elder@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: "Joerg Roedel" <joro@8bytes.org>
> Cc: Rob Clark <robin.clark@oss.qualcomm.com>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Guan-Yu Lin <guanyulin@google.com>
> Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: intel-xe@lists.freedesktop.org
> Cc: linux-hwmon@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: iommu@lists.linux.dev
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: linux-staging@lists.linux.dev
> Cc: netdev@vger.kernel.org
> Cc: imx@lists.linux.dev
> Cc: Rob Herring (Arm) <robh@kernel.org>
> ---
>   include/linux/pm_runtime.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 64921b10ac74f..de9e7518ecef2 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -280,7 +280,7 @@ static inline int pm_runtime_get_if_in_use(struct device *dev)
>   }
>   static inline int pm_runtime_get_if_active(struct device *dev)
>   {
> -	return -EINVAL;
> +	return 1;
>   }
>   static inline int __pm_runtime_set_status(struct device *dev,
>   					    unsigned int status) { return 0; }

