Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D55606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Xg9e+AqB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97C2A10E324;
	Mon, 16 Nov 2026 10:50:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 423DD10E324
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794826254; x=1826362254;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=wpXd1p0hteXZVmr0NA5K9bSo20DaHXFaojY1b1jiCxs=;
 b=Xg9e+AqBUFmmJXashBBXe76m+iHACPkZS7tthADPGNzGzl4F5yvsTnkn
 E9Kvtkqzg0Sf6AIjsAyO4gjTmoCB3D0UaFtRl0hgJEGdmRUSSiauuvkc1
 JSHcG60iGa8iTp6jdC8zJCi3I3pdWI/G3Vp4PAVukLbtUuzR1YZyxpX7N
 EusL2Ds8DRxR1D+uJOY5bQalWod3i7bXHCDU0Xu898UiW16NDj8oxpZG+
 gQUIBCE+t75eDlOFHUUDnSQWbtQ0Kt9hvnwDsXPvF5z8mEsIuuCqIGGgG
 wS6QWnWm7jBTP+4hL9iA5eTnvfWxWTVO3Mwu/DOlexA5Uxf1627eTJvIi w==;
X-CSE-ConnectionGUID: 6+nRCvJBTIeLIKgqZ8aeIQ==
X-CSE-MsgGUID: 3iMdLJBaSVCyc9Mt/aO3YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3661069"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3661069"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 02:50:53 -0800
X-CSE-ConnectionGUID: kN3mEAjrScmTeueMq8BcHQ==
X-CSE-MsgGUID: uGhBcIjbSaG0KcBw4bw2Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9866611"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.245.117])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 02:50:51 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Arun
 Iyengar <aiyengar1990@gmail.com>
Subject: Re: [PATCH v2] drm/debugfs: Accept "reset" with a trailing newline
 in edid_override
In-Reply-To: <20261113-drm-debugfs-edid-reset-v2-1-07939ebe7a8b@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261113-drm-debugfs-edid-reset-v2-1-07939ebe7a8b@gmail.com>
Date: Mon, 16 Nov 2026 12:50:48 +0200
Message-ID: <79235528599da1ab5445fd8fcdc529c182eacf33@intel.com>
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

On Fri, 13 Nov 2026, Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org> wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
>
> Writing "reset" to edid_override only removes the override when exactly
> those five bytes are written, so "echo reset > edid_override" fails with
> -EINVAL and leaves the override in place.
>
> Compare with sysfs_streq() on a NUL-terminated copy, and reject writes
> larger than the largest possible EDID (256 blocks) before copying,
> so that the size of the copy is bounded.
>
> Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
> Tested on an Orange Pi 5 (RK3588S) with this patch on a 7.3 based
> kernel: "echo reset" and "printf reset" both remove an override, an EDID
> override round trip still works, and garbage or oversized writes fail
> with -EINVAL.
>
> Developed with Claude (Anthropic), which wrote the code and the commit
> message. I reviewed and tested it.
> ---
> Changes in v2:
> - Use memdup_user_nul() and sysfs_streq() (Jani Nikula)
> - Reject writes larger than 256 EDID blocks before copying
> - Shorter commit message
> - Link to v1: https://patch.msgid.link/20261112-drm-debugfs-edid-reset-v1-1-4cd19d83cd22@gmail.com
> ---
>  drivers/gpu/drm/drm_debugfs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
> index a72f9723d3a9..7c39c8ed3984 100644
> --- a/drivers/gpu/drm/drm_debugfs.c
> +++ b/drivers/gpu/drm/drm_debugfs.c
> @@ -565,11 +565,15 @@ static ssize_t edid_write(struct file *file, const char __user *ubuf,
>  	char *buf;
>  	int ret;
>  
> -	buf = memdup_user(ubuf, len);
> +	/* An EDID has at most 256 blocks */
> +	if (len > 256 * EDID_LENGTH)
> +		return -EINVAL;

This is an unrelated change nobody asked for, and it diverges from a
review I tried to converge by presenting a clean hand-written solution
that the LLM didn't come up with on its own.


BR,
Jani.

> +
> +	buf = memdup_user_nul(ubuf, len);
>  	if (IS_ERR(buf))
>  		return PTR_ERR(buf);
>  
> -	if (len == 5 && !strncmp(buf, "reset", 5))
> +	if (sysfs_streq(buf, "reset"))
>  		ret = drm_edid_override_reset(connector);
>  	else
>  		ret = drm_edid_override_set(connector, buf, len);
>
> ---
> base-commit: cb0a63f0c96e8ecb90199eeb99cc2a7fcfa703d4
> change-id: 20261110-drm-debugfs-edid-reset-0504a20c67d1
>
> Best regards,
> --  
> Arun Iyengar <aiyengar1990@gmail.com>
>
>

-- 
Jani Nikula, Intel
