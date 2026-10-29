Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D3A606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iDLLrMwh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F4D510E82A;
	Thu, 29 Oct 2026 18:59:17 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D2CA1124F1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 18:59:11 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so25127435e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793300349; x=1793905149; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K0Ytmrnk1GXIgM1fqIrHZ5HsCVM2IH42icX0Nl0p4uM=;
 b=iDLLrMwhESqkTZ7HmkWs3YmOMgMO2C+W3wgNBfIeHBYqV3+ceyIObRhqks0qcVjwc7
 A1IfNUFlM+jVR9B/LXbVrncGVbL17EY0kxQ2jFmH2RqQznxWNASdea+lkf5GLcJjQD3r
 F7Pn6zKPES4M8bXaRLulH2zftAmKvi2qNE198kH9zS9VgIJe36iD3U1+yeMkGa9JVwHP
 ST27E5j2pfq8V+kuLqeQ0R3IO4GEPfFrx1bAYl1WbmVqHjg7J7K3VByyNtwpCkyW8qln
 amAtnt5Mk/qVNAqnzzZ/5dLsztza6yQZpKqIGRd2ax/jls8oR3OmQWc1DkQ5yhpXc1I6
 DLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793300349; x=1793905149;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K0Ytmrnk1GXIgM1fqIrHZ5HsCVM2IH42icX0Nl0p4uM=;
 b=x02ng4nz0vQIwF7mQfCAa/JsFdzlAn8ftdT8Wxjgl2ev42enTi6yC6wRFJyUNv3Mzk
 e7dnB+eRVuXme1qCt1tjDVFXlPykHK7UYXtOExq1IbATM323UsdMNC2c+NCFBvmS5m3p
 W10RCRjag1V5/8wRRO3pQCOPkrXqzlnfjpV7B+O4OKBYbrDcH+1nOt65teKxVsFHDt9B
 yfB0pYkzt732bK2rxcGSup8x5zDrbR+U+VkSqPmX4IVCQlx3ESPvT7T3JOd2kvES58v3
 sWrOMxGP/73uU+GaeRyxJ/ODZ1XziTHWf099pjl0NeitEEtiA3X2o1/sDK1tCvwKP1qe
 57yg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/4WZ4kowly2Z3+vixmzsMnn65bY40vvgsRBgo0Q+HEjZN/dWTdzKPduWbFLdoL350JsBR7SHeS18=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ4rCkr/6rlBCS4dLCxy1+ps7jV92VI/cFlLSpmJM5qa0xFi28j
 x+EnHvMd6Qk8/LxLlCpbukfD1Urxi9FmG2BihTfy4vRfZinulHkfkSdq
X-Gm-Gg: AYBFou35MQ4UkF6aT6ovmL7vVEZZq8Mh2aRCLs2bsCdDcms+ZMITsGcPnnhWPsY+bxq
 3ULReqs2jQItA7w29Yb5Ur43Qwns2qaoXOMWubWyJsgC+XCqt+W2TpYowY/EHsHl5pdWyIbUYcJ
 Sf4zv4lU/Wp94kx6VVYXkv58ITU8lXRStDR6eEYgWI+gW+Nb37ahPPz9dahkGocorAPOpurmIhl
 8tKwMt835EKDykRyGz99LbNKy181gKbapsmtCbY2lhgisKXclqYfJhazp6W4AFZgvf2+16L5bp6
 8sqaFrrzfkVqlVty3RdyYe/yX/I9FcC9RcK/DWr3ueL7MZCXbETS9HvpLHSLRJLAVG+kWH+mE1H
 TE5nc36KMStWP5ZyAz+EYWKDLt91BTF8RBg902eloB1ZvRtW+Th0n/JA7lpDduoRYPZt20txv48
 prV303OEjLsBEbCX+MObomXc3HXMtG01/Amzrb8p0D6DNgfY1d45UCn1TKGiNYeoaFAFV8KHAr4
 0A5pM9XMsy/zDLRT7y30aykpqrPY2TawvVFI3ekQkmpnyeNCY9v9qGz33nTxKm2equQANYWd3MJ
 ZKBByqWY0yRYtiqhC6obuVpFzfG/hSscXZINYSOaG5ZQAxITAt8sz0czpbVPDLxWBZGfgaci/nA
 68DLFwAh2FrizlO96jkqrnjRLQCM5txif+itCq8vGbIJpu8Fc0Mmx/O/KkYZ2kBBBDT8X/ej5BT
 WXq36Rxchgucp+
X-Received: by 2002:a05:600d:4121:b0:4a3:59c9:a758 with SMTP id
 5b1f17b1804b1-4a96836988amr152798385e9.32.1793300349381; 
 Thu, 29 Oct 2026 11:59:09 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf6c76507sm4933955e9.10.2026.10.29.11.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 11:59:08 -0700 (PDT)
Date: Thu, 29 Oct 2026 21:59:04 +0300
From: Dan Carpenter <error27@gmail.com>
To: Frank.Li@oss.nxp.com
Cc: Frank Li <Frank.Li@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Karol Wachowski <karol.wachowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Elder <elder@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, Guan-Yu Lin <guanyulin@google.com>,
 Mathias Nyman <mathias.nyman@linux.intel.com>,
 linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 linux-staging@lists.linux.dev, netdev@vger.kernel.org,
 imx@lists.linux.dev, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/1] PM: runtime: change stub pm_runtime_get_if_active()
 return 1 when !CONFIG_PM
Message-ID: <auOXeGVQG0UHeoQb@stanley.mountain>
References: <20261029163044.3062958-1-Frank.Li@oss.nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029163044.3062958-1-Frank.Li@oss.nxp.com>
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 12:30:37PM -0400, Frank.Li@oss.nxp.com wrote:

> Pattern C: ret > 0 / ret <= 0 / ret != 1 checks -- FIXED
>   drivers/usb/core/offload.c: checks (!= 1), old -EINVAL caused
>     -EBUSY even with !CONFIG_PM. Fixed: now returns 1, proceeds.
>   drivers/accel/ivpu/ivpu_job.c: drm_WARN_ON(<= 0), old -EINVAL
>     spuriously triggered WARN. Fixed: 1 > 0, no warn.
>   drivers/gpu/drm/i915/intel_runtime_pm.c: checks (<= 0), old
>     -EINVAL triggered error path. Fixed: 1 > 0, correct path.
>   drivers/accel/ivpu/ivpu_sysfs.c: (> 0), old skipped freq read.
>     Fixed: proceeds correctly without CONFIG_PM.
>   drivers/gpu/drm/xe/xe_pm.c: wraps (> 0), all xe callers
>     (xe_bo.c, xe_shrinker.c, xe_vsec.c, xe_ggtt.c, xe_guc_ct.c,
>     xe_pxp.c) now correctly treat !CONFIG_PM as active.
>   drivers/net/ipa/ipa_smp2p.c: power_on = (> 0), now correctly true.
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c: (> 0), now correctly
>     executes stall register update.
>   drivers/staging/media/ipu7/ipu7-buttress.c: active (<= 0) early
>     return now skipped, correctly proceeds.

Pattern C is mostly bugs so this patch should have a Fixes tag since
it fixes bugs.

regards,
dan carpenter


