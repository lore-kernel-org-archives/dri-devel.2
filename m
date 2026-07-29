Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D1DC53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1352810EB5F;
	Wed, 29 Jul 2026 09:48:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eHy6722s";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3859310EB5F
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 09:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785318533; x=1816854533;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=y29Bx/MHebd8jws4ZYOHkDcArLrG/zbSpIS25YdoY2o=;
 b=eHy6722scp08RFCjm/CtMVOBVzQpl98ZA7GcNjmcDm20mj3ZNyak+QzJ
 m0hG/xc07PkaGxKeT+3xeT3n8vUnrBjUgj+W3xQ6cPpeSCfKXigRM4zmD
 yH2vma2WNAPHNNSrRWbtt8J1YihVLmWj+F9bIQZAhPVD3ekocQNM+sZiM
 HHhMp4VDwHQjUTEbmK5jB6Biwq27QMx7lRPp1cgmWKA5XzcxA/CxcMRjk
 nOovUPBvjMjqsdVJADzMGBlMN4+MJZOafqtpSQWznvD69SJ2VtBPQR+RP
 vF8U1u8WrDtSKR3xhrfJLNm9DZv4WJsZn7ZryTHmglTzi6SJCSTg2BfhK A==;
X-CSE-ConnectionGUID: E+AstCcpQVuTppU7voRhrQ==
X-CSE-MsgGUID: 90pUqshnQmmXDKqlpcSjiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="96579493"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="96579493"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 02:48:53 -0700
X-CSE-ConnectionGUID: 0tBppqU6TMyFA/pBLjMZew==
X-CSE-MsgGUID: N2AxdOvDTuaeD54bz8ki3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; d="scan'208";a="256629828"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.244.212])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2026 02:48:50 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: oushixiong1025@163.com, Jocelyn Falempe <jfalempe@redhat.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: Re: [PATCH 2/4] drm/log: Fix division by zero when scale module
 parameter is 0
In-Reply-To: <20260729084520.688087-2-oushixiong1025@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260729084520.688087-1-oushixiong1025@163.com>
 <20260729084520.688087-2-oushixiong1025@163.com>
Date: Wed, 29 Jul 2026 12:48:47 +0300
Message-ID: <d4c83a8cdd4612525dd32c3036a2789ab8387d99@intel.com>
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

On Wed, 29 Jul 2026, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
>
> The scale module parameter can be set to 0 via kernel command line or
> sysfs. When scale is 0, scaled_font_h and scaled_font_w become 0,
> causing a division by zero in the rows/columns calculation.
>
> Add a custom param_ops setter to clamp scale to a minimum of 1 at the
> source, ensuring scale is always valid for all users.
>
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
>  drivers/gpu/drm/clients/drm_log.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
> index 294b3be1a6b3..a04f651e8265 100644
> --- a/drivers/gpu/drm/clients/drm_log.c
> +++ b/drivers/gpu/drm/clients/drm_log.c
> @@ -26,7 +26,27 @@ MODULE_DESCRIPTION("DRM boot logger");
>  MODULE_LICENSE("GPL");
>  
>  static unsigned int scale = 1;
> -module_param(scale, uint, 0444);
> +
> +static int drm_log_scale_set(const char *val, const struct kernel_param *kp)
> +{
> +	int ret;
> +
> +	ret = param_set_uint(val, kp);
> +	if (ret)
> +		return ret;

Pedantically, scale may be 0 between param_set_uint() and the check
below, i.e. the fix is racy.

An alternative is to use a function to get the scaling factor, and
having it return scale ?: 1.

BR,
Jani.


> +
> +	if (scale < 1)
> +		scale = 1;
> +
> +	return 0;
> +}
> +
> +static const struct kernel_param_ops drm_log_scale_ops = {
> +	.set	= drm_log_scale_set,
> +	.get	= param_get_uint,
> +};
> +
> +module_param_cb(scale, &drm_log_scale_ops, &scale, 0444);
>  MODULE_PARM_DESC(scale, "Integer scaling factor for drm_log, default is 1");
>  
>  /**

-- 
Jani Nikula, Intel
