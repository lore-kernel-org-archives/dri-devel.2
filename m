Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B2FC5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:28:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D1EB10E21E;
	Mon, 10 Aug 2026 13:28:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="N5F3Am2/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4695D10E21E
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 13:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786368519; x=1817904519;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ntPJ4gcCMLG9u+cIFBkdYoh4PQ9h8qsoXk2IA1+kdew=;
 b=N5F3Am2/yQbCsWdClLukO8F5RtAvYv6CiTV9ySyDhJYVX3nfIWEokp1z
 578uzQ7dsziJoyrpVIoPsuBgSDkMbl9GS9BX9LA7GyGaQ3xcjEhk6Z/v/
 ShD2XnEFwoSdPs78KngCq27ft2VxKTO57gN1ifvuaAyKBSxEqtDfeqw4v
 1eB8KU6hhmxwjVqrFHexmiNp0vItYYrWsEInzeYRLdrBXeR4PmWyhIMNt
 X++7Z10cPwo2MN3SB8GVE60psM6SSn2lxGLM+Rc0fCMkZFwhXjKFEtnnG
 JQp2/UEcxVwhcSEMH/2gs338qEPG0NPvrncSgcPD7Z01k2yZ8JDuzSHyM g==;
X-CSE-ConnectionGUID: xwDrlYL8RFy+U/iZ9X6Xug==
X-CSE-MsgGUID: f4ug8OdyQlaSKcNpfZWt4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="98240758"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; d="scan'208";a="98240758"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2026 06:28:39 -0700
X-CSE-ConnectionGUID: tXZACEjASp6j2mNHFQHGMQ==
X-CSE-MsgGUID: msBY4wM+T56E/ay7EEBA5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; d="scan'208";a="286457504"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2026 06:28:36 -0700
Date: Mon, 10 Aug 2026 15:28:33 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com,
 andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com,
 riana.tauro@intel.com, karthik.poosa@intel.com, sk.anirban@intel.com
Subject: Re: [PATCH v4] drm/drv: Convert wedged event string building to
 seq_buf
Message-ID: <annSAeKcg4ixXenc@black.igk.intel.com>
References: <20260730101922.917870-2-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730101922.917870-2-mallesh.koujalagi@intel.com>
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

On Thu, Jul 30, 2026 at 03:49:23PM +0530, Mallesh Koujalagi wrote:
> event_string[] has a fixed size of WEDGE_STR_LEN (32) bytes.
> The original scnprintf()-based loop required a manual pre-flight
> bounds check.
> 
> Replace the manual bookkeeping with seq_buf, which tracks overflow
> internally. seq_buf_printf() writes each "method," token into the
> buffer.
> 
> On overflow, len retains the position of the last
> successful write, so the trailing comma is stripped cleanly without
> including any partial method name in the uevent payload.
> 
> Fixes: b7cf9f4ac1b8 ("drm: Introduce device wedged event")
> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> ---
> v2:
> - Add proper logic to handle recovery string. (Raag)
> 
> v3:
> - Convert manual bounds check to seq_buf. (Jani Nikula)
> - Use drm_WARN_ONCE() instead of drm_WARN_ON() for overflow. (Raag)
> 
> v4:
> - Use DECLARE_SEQ_BUF. (Jani)

Make sure to cc the reviewers so that they are in the loop.

> - Warn overflow at end of loop.
> ---
>  drivers/gpu/drm/drm_drv.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index e51ed959da89..e429f52ba230 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -36,6 +36,7 @@
>  #include <linux/mount.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/sched.h>
> +#include <linux/seq_buf.h>
>  #include <linux/slab.h>
>  #include <linux/sprintf.h>
>  #include <linux/srcu.h>
> @@ -574,27 +575,32 @@ static const char *drm_get_wedge_recovery(unsigned int opt)
>  int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
>  			 struct drm_wedge_task_info *info)
>  {
> -	char event_string[WEDGE_STR_LEN], pid_string[PID_STR_LEN], comm_string[COMM_STR_LEN];
> -	char *envp[] = { event_string, NULL, NULL, NULL };
> -	const char *recovery = NULL;
> -	unsigned int len, opt;
> +	DECLARE_SEQ_BUF(event_string, WEDGE_STR_LEN);
> +	char pid_string[PID_STR_LEN], comm_string[COMM_STR_LEN];
> +	char *envp[4] = { };
> +	unsigned int len = 0, opt;
>  
> -	len = scnprintf(event_string, sizeof(event_string), "%s", "WEDGED=");
> +	seq_buf_puts(&event_string, "WEDGED=");
> +	envp[0] = event_string.buffer;
>  
>  	for_each_set_bit(opt, &method, BITS_PER_TYPE(method)) {
> -		recovery = drm_get_wedge_recovery(opt);
> +		const char *recovery = drm_get_wedge_recovery(opt);
>  		if (drm_WARN_ONCE(dev, !recovery, "invalid recovery method %u\n", opt))
>  			break;
>  
> -		len += scnprintf(event_string + len, sizeof(event_string) - len, "%s,", recovery);
> +		if (!seq_buf_printf(&event_string, "%s,", recovery))
> +			len = seq_buf_used(&event_string);

Should we continue iterating if seq_buf_printf() fails?
Also, why not just

		if (drm_WARN_ON_ONCE(dev, !seq_buf_printf(&event_string, "%s,", recovery)))
			break;

and drop seq_buf_has_overflowed() below?

Raag

>  	}
>  
> -	if (recovery)
> -		/* Get rid of trailing comma */
> -		event_string[len - 1] = '\0';
> +	drm_WARN_ONCE(dev, seq_buf_has_overflowed(&event_string),
> +		      "WEDGED event string truncated\n");
> +
> +	if (len)
> +		/* Strip trailing comma; also discards any partial overflow entry */
> +		event_string.buffer[len - 1] = '\0';
>  	else
> -		/* Caller is unsure about recovery, do the best we can at this point. */
> -		snprintf(event_string, sizeof(event_string), "%s", "WEDGED=unknown");
> +		/* No complete entry written, do the best we can at this point. */
> +		snprintf(event_string.buffer, event_string.size, "%s", "WEDGED=unknown");
>  
>  	drm_info(dev, "device wedged, %s\n", method == DRM_WEDGE_RECOVERY_NONE ?
>  		 "but no recovery needed" : "needs recovery");
> -- 
> 2.48.1
> 
