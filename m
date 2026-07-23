Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9E7C531CD
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 09:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5F9610F035;
	Thu, 23 Jul 2026 09:40:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NIX0XwHp";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6947F10F035
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 09:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784799641; x=1816335641;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=iOl6735PcBjPnKDUGIaM3g3PnqUPfPoSAMuvVsuFYJE=;
 b=NIX0XwHpRspiQc7BojGXKnOj9nVX6ikNEEemMJqmL5nrfCRWJLSCSyEd
 MG1WK42IJylksu9XwilMLTHMFAIVNG0ijtePgggQv4WcksCKOEYtuhq3J
 XRTQT/Y7NPJli9anw/rA/pbbEvcbF23TWFrJbx/rdyXQ3ATbQRiQRRbuZ
 KAeCf3QWweZCuW5I066NL68X7a0gNEaQ/a2EpF2I2a6YztPvjAJ8GFjI0
 /p75uOofa9pH2xSaXONZqEbVqiLIRkYL95G8/YweHJUhlMHRkJe3uMnF5
 ewfBVtx6ey4U6m6ZNwsSewybt2G7F/f1dSaXlc7qZ5vyLk7c7i6vZ+5kn A==;
X-CSE-ConnectionGUID: ephPNhfJTU6EuuHskK0hqw==
X-CSE-MsgGUID: ymubbzclQi6xrpsFPcRDsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96965935"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="96965935"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 02:40:40 -0700
X-CSE-ConnectionGUID: R4oBbySfQKmuYaViTzZ5rQ==
X-CSE-MsgGUID: nnFbEhOURRC3GIe/lzIS/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="261917678"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 02:40:37 -0700
Date: Thu, 23 Jul 2026 11:40:33 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com,
 andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com,
 riana.tauro@intel.com, karthik.poosa@intel.com, sk.anirban@intel.com
Subject: Re: [PATCH] drm/drv: Add buffer bounds check in drm_dev_wedged_event()
Message-ID: <amHhkWhU7bMUyL3S@black.igk.intel.com>
References: <20260721105041.642598-2-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721105041.642598-2-mallesh.koujalagi@intel.com>
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

On Tue, Jul 21, 2026 at 04:20:42PM +0530, Mallesh Koujalagi wrote:
> event_string[] has a fixed size of WEDGE_STR_LEN (32) bytes. Since
> scnprintf() reserves space for the terminating null byte, it can write
> at most 31 characters.
> 
> When len reaches WEDGE_STR_LEN - 1, only the null terminator fits in the
> remaining space. Any further scnprintf() calls return 0 and additional
> recovery method names are silently dropped, making the truncation hard
> to detect.
> 
> Add a drm_WARN_ON() check for len >= WEDGE_STR_LEN - 1 before attempting
> another write. If the buffer is already full, emit a warning and stop
> processing further entries. This makes buffer truncation visible and
> allows the loop to exit cleanly instead of silently ignoring recovery
> methods.
> 
> Fixes: b7cf9f4ac1b8 ("drm: Introduce device wedged event")
> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> ---
>  drivers/gpu/drm/drm_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 1ff0bf7cba6a..63eef0a19e99 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -578,6 +578,9 @@ int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
>  		if (drm_WARN_ONCE(dev, !recovery, "invalid recovery method %u\n", opt))
>  			break;
>  
> +		if (drm_WARN_ON(dev, len >= WEDGE_STR_LEN - 1))

len is the starting offset for current method, so the string can still
be truncated. And we also have to account for the trailing comma which
we later drop, so I think the correct logic would be something like

		if (drm_WARN_ON(dev, len + strlen(recovery) + 1 >= WEDGE_STR_LEN - 1))

which looks worth an explanation here.

Raag

> +			break;
> +
>  		len += scnprintf(event_string + len, sizeof(event_string) - len, "%s,", recovery);
>  	}
>  
> -- 
> 2.48.1
> 
