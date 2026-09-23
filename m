Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E455C982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C243510EFB3;
	Wed, 23 Sep 2026 10:29:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HbDeETvQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7340A10EFB3;
 Wed, 23 Sep 2026 10:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790159381; x=1821695381;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jQQPVVYT59xKcv8aBpDOQ7PqlE3upfL5ySw41K5CN/o=;
 b=HbDeETvQinL9/oEUxsGUiI0exvZV2fi/OKrqmFDt8sIfOi6dcvuEIozn
 GBYaXlIvpXDa1RIXHA+GexQDr+rAwa66SNRKjXcn8Aw3/Q3uGZDv6vurR
 +DNLKsMmHd8scdwfmfRnejKIP/BinDa05a/c45qy/O0WMNUGIUkWD1ajd
 FlU/xUJnsSbO6wEKTKu3dpSSLKoe7jAp9bHLEpKfBwwUybTl/37o6NmCq
 62RxAnU0fDXYcprVKjHyW6HOexpEE6heP2Dnv60rRwgYiDup59HyPIb9L
 a5c1CPJ3ojpFAQQInHPmjIMP2iTS7xeN6oVg/Vmok08or+PY+8sut432L g==;
X-CSE-ConnectionGUID: Ps/4AHenThG4EtRNF2sasA==
X-CSE-MsgGUID: n/AdW4WCSU2zV0KZI3FPEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90952301"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="90952301"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 03:29:40 -0700
X-CSE-ConnectionGUID: 5HfouIXbR6qvdOZWp/Qr5A==
X-CSE-MsgGUID: /vU+ntXsSxSQCUJJil5B3A==
X-ExtLoop1: 1
Received: from kamilkon-desk.igk.intel.com (HELO localhost) ([10.211.136.201])
 by fmviesa003-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 03:29:39 -0700
Date: Wed, 23 Sep 2026 12:29:21 +0200
From: Kamil Konieczny <kamil.konieczny@linux.intel.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH i-g-t] lib/igt_profiling: configure Panthor enable state
Message-ID: <20260923102921.hrn45pkboeo3risn@kamilkon-DESK.igk.intel.com>
Mail-Followup-To: Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 Deborah Brouwer <deborah.brouwer@collabora.com>,
 igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260922-b4-gputop_panthor-v1-1-e908705bd062@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260922-b4-gputop_panthor-v1-1-e908705bd062@collabora.com>
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

Hi Deborah,
On 2026-09-22 at 20:01:20 -0700, Deborah Brouwer wrote:
> Currently profiling is enabled for every device by writing '1' into the
> appropriate sysfs node. But Panthor uses a bit mask where cycle and
> timestamp sampling are enabled by the first and second bits respectively.
> 
> By default assume that writing '1' will enable profiling, but then adjust
> the value to '3' for the Panthor driver.
> 
> Closes: https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/work_items/209
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

Thank you for solving this, LGTM
Acked-by: Kamil Konieczny <kamil.konieczny@linux.intel.com>

Can you ask some Panthor developer for review and/or Tested-by?

Regards,
Kamil

> ---
>  lib/igt_profiling.c | 23 +++++++++++++++++++++--
>  lib/igt_profiling.h |  1 +
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/igt_profiling.c b/lib/igt_profiling.c
> index e1526ad98..5c62a3fb1 100644
> --- a/lib/igt_profiling.c
> +++ b/lib/igt_profiling.c
> @@ -50,7 +50,10 @@ struct igt_profiled_device *igt_devices_profiled(void)
>  
>  	while ((entry = readdir(dev_dir)) != NULL) {
>  		char path[PATH_MAX];
> +		char driver_path[PATH_MAX];
> +		char driver_link[PATH_MAX];
>  		char orig_state;
> +		ssize_t len;
>  		int sysfs_fd;
>  
>  		/* All DRM device entries are symlinks to other paths within sysfs */
> @@ -87,7 +90,23 @@ struct igt_profiled_device *igt_devices_profiled(void)
>  		}
>  
>  		profiled_devices[i].syspath = strdup(path);
> -		profiled_devices[i++].original_state = orig_state;
> +		profiled_devices[i].original_state = orig_state;
> +		profiled_devices[i].enable_state = '1';
> +
> +		snprintf(driver_path, sizeof(driver_path), "%s/%s/device/driver",
> +			 SYSFS_DRM, entry->d_name);
> +
> +		len = readlink(driver_path, driver_link, sizeof(driver_link) - 1);
> +		if (len >= 0) {
> +			driver_link[len] = '\0';
> +
> +			if (strstr(driver_link, "/panthor")) {
> +				/* Enable both cycle and timestamp sampling. */
> +				profiled_devices[i].enable_state = '3';
> +			}
> +		}
> +
> +		i++;
>  
>  		close(sysfs_fd);
>  	}
> @@ -124,7 +143,7 @@ void igt_devices_configure_profiling(struct igt_profiled_device *devices, bool e
>  		if (sysfs_fd < 0)
>  			continue;
>  
> -		write(sysfs_fd, enable ? "1" : &devices[i].original_state, 1);
> +		write(sysfs_fd, enable ? &devices[i].enable_state : &devices[i].original_state, 1);
>  		close(sysfs_fd);
>  	}
>  }
> diff --git a/lib/igt_profiling.h b/lib/igt_profiling.h
> index b063d54e1..d38cc2bb6 100644
> --- a/lib/igt_profiling.h
> +++ b/lib/igt_profiling.h
> @@ -12,6 +12,7 @@
>  struct igt_profiled_device {
>  	char *syspath;
>  	char original_state;
> +	char enable_state;
>  };
>  
>  void igt_devices_configure_profiling(struct igt_profiled_device *devices, bool enable);
> 
> ---
> base-commit: 65f84b280be2caf8ce376295d97987a808affdee
> change-id: 20260922-b4-gputop_panthor-cbb78c0ffbf8
> 
> Best regards,
> -- 
> Deborah Brouwer <deborah.brouwer@collabora.com>
> 
