Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF93C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 06:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C07710E522;
	Tue, 28 Jul 2026 06:14:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DicGHKcn";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DF4510E522
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 06:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785219278; x=1816755278;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=LgxQoaA8wZsakqGzrrzEyAt9dzeS5EzjV30sAFRNFeY=;
 b=DicGHKcna+CeMTP/5lH5uks8RO8/gvwmtF0wGmc+/bxUrx/BD4vMxdL2
 muAHBzd56dbGvL1K7s2D/OKEfwC5z5ECgqOUhJ/+v0747r0v4NNPX6W9U
 ZLXAEFLHzgXPqzYhlSEWmg6sjics6ZMxalODvGoRh0oLYRTiw7oao1sbV
 HpEQH0/l2wt78FKij/a2i6NXOmDU/yrtattovdggWrkZlmEBp1xw/nw0b
 foN1nAaYfuHwJN7Vodv3VeGDU7bnDE+RFasatBpL8yuwvIy7LNj8mDvOv
 qzvi5VJODnOKMxD/u//hzww64V8Atadx8sQLTez3k/xnzMbNwAGmovPod A==;
X-CSE-ConnectionGUID: rwURGIANSYiCFx9FX8IDIw==
X-CSE-MsgGUID: SgcLr2jsQ16Z92zva6xA2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="111340586"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; d="scan'208";a="111340586"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 23:14:37 -0700
X-CSE-ConnectionGUID: 82M+Om9pTS6vpqyd9mYSTg==
X-CSE-MsgGUID: 9Dc7g9DlRtuCXXjniNt1xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; d="scan'208";a="259052556"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2026 23:14:34 -0700
Date: Tue, 28 Jul 2026 08:14:31 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com,
 andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com,
 riana.tauro@intel.com, karthik.poosa@intel.com, sk.anirban@intel.com
Subject: Re: [PATCH v2] drm/drv: Add buffer bounds check in
 drm_dev_wedged_event()
Message-ID: <amhIx1KpRV1bn3Xd@black.igk.intel.com>
References: <20260724063005.703631-2-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260724063005.703631-2-mallesh.koujalagi@intel.com>
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

On Fri, Jul 24, 2026 at 12:00:06PM +0530, Mallesh Koujalagi wrote:
> event_string[] has a fixed size of WEDGE_STR_LEN (32) bytes.
> scnprintf(buf, size, "%s,", recovery) writes strlen(recovery)+1
> content bytes (token + comma) and requires one additional byte
> for the NUL terminator within 'size'.
> 
> Without a bounds check, if the remaining space is insufficient,
> scnprintf() silently truncates the recovery token mid-name,
> producing a malformed uevent payload (e.g. "WEDGED=bus-reset,vendor-spe").
> 
> Add a pre-flight drm_WARN_ON() guard:
> 
>   len + strlen(recovery) + 1 >= WEDGE_STR_LEN
> 
> Fixes: b7cf9f4ac1b8 ("drm: Introduce device wedged event")
> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> ---
> v2:
> - Add proper logic to handle recovery string. (Raag)
> ---
>  drivers/gpu/drm/drm_drv.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index e51ed959da89..e48b22ca38bd 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -586,6 +586,20 @@ int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
>  		if (drm_WARN_ONCE(dev, !recovery, "invalid recovery method %u\n", opt))
>  			break;
>  
> +		/*
> +		 * scnprintf(buf, size, "%s,", recovery) writes strlen(recovery)+1
> +		 * content bytes (token + comma) and reserves 1 byte for NUL within
> +		 * 'size'.  It fits without truncation when:
> +		 *   len + strlen(recovery) + 1 <= WEDGE_STR_LEN - 1  (safe)
> +		 * so warn and bail when:
> +		 *   len + strlen(recovery) + 1 >= WEDGE_STR_LEN       (would truncate)
> +		 * Note: ">= WEDGE_STR_LEN - 1" would be off-by-one — it would
> +		 * incorrectly reject the exact-fit case where NUL lands on the last
> +		 * valid byte (index WEDGE_STR_LEN - 1).

This looks a bit verbose, can we shorten it up a bit?

> +		 */
> +		if (drm_WARN_ON(dev, len + strlen(recovery) + 1 >= WEDGE_STR_LEN))

I'd use drm_WARN_ON_ONCE() and avoid spamming logs.

Raag

> +			break;
> +
>  		len += scnprintf(event_string + len, sizeof(event_string) - len, "%s,", recovery);
>  	}
>  
> -- 
> 2.48.1
> 
