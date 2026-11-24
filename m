Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530EB606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JkAwh1uS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A814410F51B;
	Tue, 24 Nov 2026 11:56:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 644D610F50E;
 Tue, 24 Nov 2026 11:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795521352; x=1827057352;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=X2F0f2zB9SigSFSuYhjW3PvNKcmd8BncxRYDOtyPW54=;
 b=JkAwh1uS1yuOBY1Zy6mrHROd6ltl7yV0DaY5ji+wDM4clzbnA0Sb+E2P
 yghbvuCcJ3tWprLEJwTu++8dL91uToyvFlGD5EoH0LyhYSMQ2NlmLciIG
 s/hdDsznzvQRGRVCyC4utRBdFbevscsIg8J0iVtp1HusChTubQic/lZis
 D3HDEc4z/0H5QJH5AFBsILxIOfgC60U6bI7y5HCVSCEXrMTy0O1L8YXou
 pMky72A239kfWLzCmqdjF9meBYQC1H7jukGpI9JrTBHpMsFvwqFKlZiZ3
 OEDVFQ3fwO2x4H0nk1t0BHVoCzi+G35k2uldpfVp75tHISPOk7G4TS/yu w==;
X-CSE-ConnectionGUID: kO8I6CmzQr+v8SWWU7a6Sg==
X-CSE-MsgGUID: cW3yVxL/SoyVWdbcik30oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4366240"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4366240"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 03:55:52 -0800
X-CSE-ConnectionGUID: 0Rzl09vjTJKEN+a/UVpB1A==
X-CSE-MsgGUID: u4rsUnD9R6yhMas/aDAcFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11895830"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.138])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 03:55:50 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v1 1/1] drm/i915/hotplug: Use
 DEFINE_SHOW_STORE_ATTRIBUTE() helper for debugfs
In-Reply-To: <20261124105805.617827-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261124105805.617827-1-andriy.shevchenko@linux.intel.com>
Date: Tue, 24 Nov 2026 13:55:46 +0200
Message-ID: <d464e5f329632fad52ab7ffb315a991e5fc03ec5@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> Use DEFINE_SHOW_STORE_ATTRIBUTE() helper for read-write file to reduce some
> duplicated code.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/i915/display/intel_hotplug.c | 32 ++------------------
>  1 file changed, 2 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_hotplug.c b/drivers/gpu/drm/i915/display/intel_hotplug.c
> index d095eb13dc06..c47a7c9044e7 100644
> --- a/drivers/gpu/drm/i915/display/intel_hotplug.c
> +++ b/drivers/gpu/drm/i915/display/intel_hotplug.c
> @@ -1246,20 +1246,7 @@ static ssize_t i915_hpd_storm_ctl_write(struct file *file,
>  
>  	return len;
>  }
> -
> -static int i915_hpd_storm_ctl_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, i915_hpd_storm_ctl_show, inode->i_private);
> -}
> -
> -static const struct file_operations i915_hpd_storm_ctl_fops = {
> -	.owner = THIS_MODULE,
> -	.open = i915_hpd_storm_ctl_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.write = i915_hpd_storm_ctl_write
> -};
> +DEFINE_SHOW_STORE_ATTRIBUTE(i915_hpd_storm_ctl);
>  
>  static int i915_hpd_short_storm_ctl_show(struct seq_file *m, void *data)
>  {
> @@ -1271,13 +1258,6 @@ static int i915_hpd_short_storm_ctl_show(struct seq_file *m, void *data)
>  	return 0;
>  }
>  
> -static int
> -i915_hpd_short_storm_ctl_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, i915_hpd_short_storm_ctl_show,
> -			   inode->i_private);
> -}
> -
>  static ssize_t i915_hpd_short_storm_ctl_write(struct file *file,
>  					      const char __user *ubuf,
>  					      size_t len, loff_t *offp)
> @@ -1324,15 +1304,7 @@ static ssize_t i915_hpd_short_storm_ctl_write(struct file *file,
>  
>  	return len;
>  }
> -
> -static const struct file_operations i915_hpd_short_storm_ctl_fops = {
> -	.owner = THIS_MODULE,
> -	.open = i915_hpd_short_storm_ctl_open,
> -	.read = seq_read,
> -	.llseek = seq_lseek,
> -	.release = single_release,
> -	.write = i915_hpd_short_storm_ctl_write,
> -};
> +DEFINE_SHOW_STORE_ATTRIBUTE(i915_hpd_short_storm_ctl);
>  
>  void intel_hpd_debugfs_register(struct intel_display *display)
>  {

-- 
Jani Nikula, Intel
