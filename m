Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E063FF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0503710EF47;
	Wed, 29 Apr 2026 11:09:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XRRzmLqN";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A006410EF47
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 11:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777460956; x=1808996956;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=x91/QzqaBoZCDJqKLWSL/fQwvthYz6O7kRRLn42AZLI=;
 b=XRRzmLqNOoQ3l5B7ATkQfA6KLOmdCczQi3c2si5h4kWEYbAzrdhurAaP
 qQxhlD08QILoEAi9wkIjgOTvsR6e+rryjwDn4A3CO8nPN5A5BIDDVzUEN
 yNv8cHNL/VQUklqM5kEkh2mXmsAubuA75Vjg3dCeQGG40PDQu+6zEikqQ
 M31cKvOfQoG6J43G+cH+7xjdzzW12S+OGPR+ind7iC0jvJxMes7Az4hNQ
 TvdamnBIt8QygKIu2BkOuk19QzudS8lxWuvxFbuCxI8mrTRu+guR3S+e9
 wG33f4hDWK/58Uf2OntfUd5IfJtMncqKdoofdhs06bkskMx74ALaPATa3 g==;
X-CSE-ConnectionGUID: 4MSyl7pyTc2CHyj2taK3bg==
X-CSE-MsgGUID: l5zzznqHS06jnTEX2BVOcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78304089"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="78304089"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 04:09:15 -0700
X-CSE-ConnectionGUID: mjl/vudbQYC3v603zySjoA==
X-CSE-MsgGUID: 7qHgbGA+RUmN5AFqQBrXTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; d="scan'208";a="257793365"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.245.218])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2026 04:09:13 -0700
Date: Wed, 29 Apr 2026 14:09:10 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: george.d.sworo@intel.com
Cc: maarten.lankhorst@linux.intel.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/modeset_lock: add NULL check for ctx before
 WARN_ON
Message-ID: <afHm1k0K0mDRPmJM@intel.com>
References: <20260429025952.1202080-1-george.d.sworo@intel.com>
 <20260429060431.1462589-1-george.d.sworo@intel.com>
 <20260429060431.1462589-2-george.d.sworo@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260429060431.1462589-2-george.d.sworo@intel.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

On Tue, Apr 28, 2026 at 11:04:30PM -0700, george.d.sworo@intel.com wrote:
> From: George D Sworo <george.d.sworo@intel.com>
> 
> modeset_lock() and drm_modeset_drop_locks() do not validate
> the ctx pointer before dereferencing it in WARN_ON(ctx->contended),
> which can lead to a NULL pointer dereference if ctx is NULL.
> 
> Add a NULL check to prevent this.

Why are you trying to pass garbage into the function?

> 
> Signed-off-by: George D Sworo <george.d.sworo@intel.com>
> ---
>  drivers/gpu/drm/drm_modeset_lock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_modeset_lock.c b/drivers/gpu/drm/drm_modeset_lock.c
> index beb91a13a312..2052bb9bb9e5 100644
> --- a/drivers/gpu/drm/drm_modeset_lock.c
> +++ b/drivers/gpu/drm/drm_modeset_lock.c
> @@ -295,7 +295,7 @@ static inline int modeset_lock(struct drm_modeset_lock *lock,
>  {
>  	int ret;
>  
> -	if (WARN_ON(ctx->contended))
> +	if (ctx && WARN_ON(ctx->contended))
>  		__drm_stack_depot_print(ctx->stack_depot);
>  
>  	if (ctx->trylock_only) {
> -- 
> 2.34.1

-- 
Ville Syrjälä
Intel
