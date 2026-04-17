Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6B3F43698
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 12:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8A2810E2AA;
	Fri, 17 Apr 2026 12:04:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jeZxORJt";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C150610E2AA
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 12:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776427440; x=1807963440;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=XRnNIrcsMnEVq95YKOZf7K6BMN+ywiHLZr9nGpX1sd0=;
 b=jeZxORJt98j7m6syeMOwW37lSXylSF9lzi0MXz9zDS2CBLbx4dmKwiMg
 V/cd0bd30cg0rlsISzjvKJnJg67YhjNukChM2ny3Na8Rj7i5BVzGxv2dB
 WpzY4Z+rQosOwzvWYrw+4ZdUzIvCKY9+V1tJkrrzqKhoncXJfxtVwpyAN
 kvI/xTEZkQKVhQMwNiC3CrRHRNBMRQxO/fWz3lv7ZVZQb8HJTAidc85ld
 1PJ9Yo7x2n6xcLUcpJweElzrNbA/t5rYBv+HoRE+hWwX/9d8qs7RdpdZ9
 wXiNFFaBZVKK+lVdHGr0LhdsZV73+BDM+1y1n9nEH8I09tCQNbJoGHoRf g==;
X-CSE-ConnectionGUID: iTCuO2PzRyi8rKRDgDCcvw==
X-CSE-MsgGUID: XAGI4m2DRRK9X/68+HEXSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="80029830"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="80029830"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 05:04:00 -0700
X-CSE-ConnectionGUID: 02vpZtdORFu3FDE4eA8c8g==
X-CSE-MsgGUID: X6eHqJniQ0qtpFQZ8odHfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="235399324"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.127])
 by orviesa004-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 05:03:57 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: sai madhu <suryasaimadhu369@gmail.com>, Chun-Kuang Hu
 <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, sai madhu
 <suryasaimadhu369@gmail.com>
Subject: Re: [PATCH] drm/mediatek: hdmi: Convert DRM_ERROR() to drm_err()
In-Reply-To: <20260417113310.2903091-1-suryasaimadhu369@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260417113310.2903091-1-suryasaimadhu369@gmail.com>
Date: Fri, 17 Apr 2026 15:03:54 +0300
Message-ID: <6fd252e6c41a1a6a0b57fb381d33f2e0813b5b14@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, 17 Apr 2026, sai madhu <suryasaimadhu369@gmail.com> wrote:
> The DRM_ERROR() macro is deprecated in favor of drm_err() which
> provides device-specific logging.
>
> Replace DRM_ERROR() with drm_err() in the Mediatek HDMI bridge
> driver and pass the drm_device pointer via bridge->dev.
>
> No functional change intended.
>
> Signed-off-by: sai madhu <suryasaimadhu369@gmail.com>
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> index 1ea259854780..f431fc9adca5 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -981,8 +981,9 @@ static int mtk_hdmi_bridge_attach(struct drm_bridge *bridge,
>  	int ret;
>  
>  	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
> -		DRM_ERROR("%s: The flag DRM_BRIDGE_ATTACH_NO_CONNECTOR must be supplied\n",
> -			  __func__);
> +		drm_err(bridge->dev,
> +			"%s: The flag DRM_BRIDGE_ATTACH_NO_CONNECTOR must be supplied\n",
> +			__func__);

We really shouldn't be logging __func__ either. Errors should be
unambigious anyway, and drm_dbg* logging uses
__builtin_return_address(0) to achieve the same with a much smaller
footprint.

BR,
Jani.

>  		return -EINVAL;
>  	}

-- 
Jani Nikula, Intel
