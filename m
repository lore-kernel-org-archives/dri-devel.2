Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80747CCF2DE
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E957910E2C5;
	Mon, 19 Oct 2026 13:38:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A75D010E542
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792417087; x=1823953087;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=H72UuwdPD6tynQBkJ++nrNG6UGsqGHoCTtCOjoUOuvA=;
 b=b7vVP6bAKT2lnrksjxrKNRp6Fcq/zGuBfEHaylFkmoO/hFlzrAXYV6gb
 HNL3nnY3mLLYkM99/zaKZEek6LuMxDiVwprezypk6UCgsM7yGwzMu7oMn
 1p6pggYDXHWzSI2zpCzecSIfPk42YTw+V/b2/ewhxp3mauayXoCLnllif
 Q5/2FoiTzdAuCjj2ZTNTl2GdGJCEezeFt1RvN8X3eaEpCwwzydyNhUk7S
 tEhAqablwBYWYZitplilD5RRq/7K6cR2fu4+ObVPysMo87B6s+Gbin+lO
 KppuGO2T3HbMdNKdzvlSqWhfdVBo/OShZtcMbNotfj4s0DWMXDwPD+cNS Q==;
X-CSE-ConnectionGUID: 5dJXBJStS9eaQytPAQbU2Q==
X-CSE-MsgGUID: C+NR8+bvTJ61Nyi8LcESVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="994029"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="994029"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 06:34:26 -0700
X-CSE-ConnectionGUID: D4bkrAy7Tr6bze2QW4b/Cw==
X-CSE-MsgGUID: xwg9x5xdT4KFrH58dQ8G/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4295026"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.21])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 06:32:17 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Avi Weiss <thnkslprpt@gmail.com>, Inki Dae <inki.dae@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park
 <kyungmin.park@samsung.com>, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Avi Weiss
 <thnkslprpt@gmail.com>
Subject: Re: [PATCH] drm/exynos: hdmi: free EDID on connector update failure
In-Reply-To: <20261012064334.3193085-1-thnkslprpt@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261012064334.3193085-1-thnkslprpt@gmail.com>
Date: Mon, 19 Oct 2026 16:32:14 +0300
Message-ID: <e22eadd0ada0c8243cfdf7829580984fdf897498@intel.com>
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

On Mon, 12 Oct 2026, Avi Weiss <thnkslprpt@gmail.com> wrote:
> If drm_edid_connector_update() fails, hdmi_get_modes() returns
> without freeing the EDID allocated by drm_edid_read_ddc(). It's
> an unlikely error path but nevertheless possible and should be
> cleaned up fully.
>
> Free the EDID before returning, while keeping the existing return
> value of 0.
>
> Fixes: f6e4f57fd90dc ("drm/exynos: hdmi: convert to struct drm_edid")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
> ---
>  drivers/gpu/drm/exynos/exynos_hdmi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
> index d4fce39c2b61..386557a7f5e8 100644
> --- a/drivers/gpu/drm/exynos/exynos_hdmi.c
> +++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
> @@ -893,8 +893,10 @@ static int hdmi_get_modes(struct drm_connector *connector)
>  	drm_edid = drm_edid_read_ddc(connector, hdata->ddc_adpt);
>  
>  	ret = drm_edid_connector_update(connector, drm_edid);

You could just move the drm_edid_free() call here to avoid duplicating
it.

> -	if (ret)
> +	if (ret) {
> +		drm_edid_free(drm_edid);
>  		return 0;
> +	}
>  
>  	cec_notifier_set_phys_addr(hdata->notifier, info->source_physical_address);
>  
>
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907

-- 
Jani Nikula, Intel
