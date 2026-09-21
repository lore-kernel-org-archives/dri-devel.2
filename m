Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE925C982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 077EE10E10E;
	Mon, 21 Sep 2026 10:43:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SkFc3WrE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CD4310E10E
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 10:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789987395; x=1821523395;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=HrgUTYm+rQYlaefjTDnzVgQ/IOugymTnai8JLExScwo=;
 b=SkFc3WrECGyXN1/mrImH/OT/YZtYU+cc/uyRJIN2Lk6DuMJWlIBtCQ9i
 CYPGR+5jxdO61Xocd8vR/LnsLiZ8elGYWogMYA0xdMU4Cs1OAvKKo9z7T
 WYXHpL10wvNKItkYXdNoFgUw5H8vTffi2ReX3RqdMcG0tOgNAGhls5P8V
 MBlj9qLTffjEyU+QsyBQc/uuqYrCyu0pmxpJG33vV6STcQvcgFl2HJ/7P
 epbs4GyKhrDxBJrsDP8fQcdE7UeIFWsj+almLMPNaqNuedc3v39pkAbYq
 CiJP5Q0TSaxi8YIgFyrB8knuudC9sUPsbBopc4/uOnQ4ipZY57J4VAzBr Q==;
X-CSE-ConnectionGUID: FJt9jjR+RRuEwrX8P92S2Q==
X-CSE-MsgGUID: gb3fjfUxRyaYJoE9R4tmFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="995471"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="995471"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 03:43:14 -0700
X-CSE-ConnectionGUID: znoIhxjORJWJFEc2a2LaUQ==
X-CSE-MsgGUID: 8ojwJ6voTL2BfIN5PbF4qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="272759840"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.180])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 03:43:12 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Hui Peng <benquike@gmail.com>, airlied@redhat.com, sean@poorly.run,
 tzimmermann@suse.de, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/udl: reject short USB EDID control transfers and
 fix URB init cleanup
In-Reply-To: <20260919223511.3889061-1-benquike@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260919223511.3889061-1-benquike@gmail.com>
Date: Mon, 21 Sep 2026 13:43:09 +0300
Message-ID: <e53ce901a913d9b660d682d8206a2167770c02b4@intel.com>
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

On Sat, 19 Sep 2026, Hui Peng <benquike@gmail.com> wrote:
> In drivers/gpu/drm/udl/ (udl_drv.c, udl_edid.c), check that
> usb_control_msg() returns the full 2-byte response in
> udl_read_edid_block() before copying read_buff[1], and clean up
> allocated URBs if udl_Driver initialization fails.

One change per patch please.

>
> Fixes: 5320918b9a87 ("drm/udl: initial UDL driver (v4)")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> diff --git a/drivers/gpu/drm/udl/udl_drv.c b/drivers/gpu/drm/udl/udl_drv.c
> index 1922988625eb..239a6983f49f 100644
> --- a/drivers/gpu/drm/udl/udl_drv.c
> +++ b/drivers/gpu/drm/udl/udl_drv.c
> @@ -97,8 +97,10 @@ static int udl_usb_probe(struct usb_interface *interface,
>  		return PTR_ERR(udl);
>  
>  	r = drm_dev_register(&udl->drm, 0);
> -	if (r)
> +	if (r) {
> +		udl_drop_usb(udl);
>  		return r;
> +	}
>  
>  	DRM_INFO("Initialized udl on minor %d\n", udl->drm.primary->index);
>  
> diff --git a/drivers/gpu/drm/udl/udl_edid.c b/drivers/gpu/drm/udl/udl_edid.c
> index af4cff2a7c51..b7c462436573 100644
> --- a/drivers/gpu/drm/udl/udl_edid.c
> +++ b/drivers/gpu/drm/udl/udl_edid.c
> @@ -36,7 +36,7 @@ static int udl_read_edid_block(void *data, u8 *buf, unsigned int block, size_t l
>  		if (ret < 0) {
>  			drm_err(dev, "Read EDID byte %zu failed err %x\n", i, ret);
>  			goto err_drm_dev_exit;
> -		} else if (ret < 1) {
> +		} else if (ret != 2) {
>  			ret = -EIO;
>  			drm_err(dev, "Read EDID byte %zu failed\n", i);
>  			goto err_drm_dev_exit;

-- 
Jani Nikula, Intel
