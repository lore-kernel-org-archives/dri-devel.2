Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4EE606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AYNPE4VD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAE4011203D;
	Thu, 12 Nov 2026 11:48:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F5A511203D
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 11:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794484113; x=1826020113;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=vo27qnizSaWoeng/wgI+cUcoe+VkKt4vRpNAtaN69Pw=;
 b=AYNPE4VDSA5x1RNq5ne9No37aMF0ASG3Jai7NNLlIRRNAY8cuprLLFHL
 3+j/4Jn6Ix35qy6VglHqspkD7JW0qYz9+qKu8BPxxfUBRkasZy+0tMTLP
 YUMr8deFsSG2piUxK22xVrQ3JjV0xqpGG1D0AsLzcuUrzy5C7uPojupw5
 YhQqc/tUDcXFXjMT+2fB2ShSboAzOBjPHKI9qupqfyWgjARMFg0KTYOAw
 KDa6J1YwKkq4mvXHxsUA4+oxCEcvdPSzB+Y2CM0iaiT5T95AFQ8CqtM08
 j+ARmDLpZ0fB1EBpb5364LUd+7EZR3qOwxMu1RgV1/7REGhdD6PnO2cvK A==;
X-CSE-ConnectionGUID: 6Mwo1zzzSF+2kktU+s5lzg==
X-CSE-MsgGUID: iCs29ou9SXmatRQyU7Q/6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3185863"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3185863"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 03:48:32 -0800
X-CSE-ConnectionGUID: +UP8GAYDQJynOakSbn4Hew==
X-CSE-MsgGUID: xSrzvlxZQFKkvS49/NzKTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8526038"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.61])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 03:48:29 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Arun
 Iyengar <aiyengar1990@gmail.com>
Subject: Re: [PATCH] drm/debugfs: Accept "reset" with a trailing newline in
 edid_override
In-Reply-To: <20261112-drm-debugfs-edid-reset-v1-1-4cd19d83cd22@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261112-drm-debugfs-edid-reset-v1-1-4cd19d83cd22@gmail.com>
Date: Thu, 12 Nov 2026 13:48:26 +0200
Message-ID: <eead642a87b1916414972dd346a4be9195020541@intel.com>
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

On Thu, 12 Nov 2026, Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org> wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
>
> Writing "reset" to a connector's edid_override debugfs file removes the
> override, but only when exactly those five bytes are written. The
> obvious
>
>   echo reset > /sys/kernel/debug/dri/0/HDMI-A-1/edid_override
>
> writes "reset\n", which is handed to drm_edid_override_set() as an EDID
> and rejected with -EINVAL, leaving the override in place. A test
> harness that cleared its override this way kept running on the
> overridden EDID until the next reboot.
>
> Accept a single trailing newline as well. An EDID is at least 128
> bytes, so a six-byte "reset\n" can't be a valid override.
>
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
> Found and tested on an Orange Pi 5 (RK3588S), with this change on a 7.3
> based kernel: with the HDMI connector's own EDID written to
> edid_override, "echo reset > edid_override" succeeds and edid_override
> reads back empty, and "printf reset" (no newline) still succeeds. On
> drm-misc-next the patch is build-tested only (arm64 and x86_64, W=1).
>
> This patch was developed with Claude (Anthropic) as a coding assistant:
> it wrote the code and the commit message, and I reviewed and tested it
> as described above.
> ---
>  drivers/gpu/drm/drm_debugfs.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
> index a72f9723d3a9..3c6290457fa3 100644
> --- a/drivers/gpu/drm/drm_debugfs.c
> +++ b/drivers/gpu/drm/drm_debugfs.c
> @@ -569,7 +569,12 @@ static ssize_t edid_write(struct file *file, const char __user *ubuf,
>  	if (IS_ERR(buf))
>  		return PTR_ERR(buf);
>  
> -	if (len == 5 && !strncmp(buf, "reset", 5))
> +	/*
> +	 * An EDID is at least 128 bytes, so "reset" with the trailing newline
> +	 * that "echo reset" adds can't be mistaken for one.
> +	 */
> +	if ((len == 5 || (len == 6 && buf[5] == '\n')) &&
> +	    !strncmp(buf, "reset", 5))

Feels like a more robust option would be to allocate buf with
memdup_user_nul() and do a simple sysfs_streq() that handles newlines in
a generic fashion.

The corner case downside is that it'll also match "reset\0" followed by
a bunch of arbitrary data, but then an EDID like that wouldn't pass
anyway.

BR,
Jani.


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
