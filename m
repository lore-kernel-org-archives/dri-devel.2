Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50CBC88E56
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 19:27:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D16D510E785;
	Sat, 12 Sep 2026 19:27:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Bi4Yfa/m";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE97C10E785
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 19:27:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789241254; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=B4CaJ7dUQuCJbR23Nt2XbHCuwV4RDnfdco77oGVLs/g74AbpHNYMpelvmk1fIFdM0irHbcKRSn12BQKzPFTNZf+vy+oV/iNkhZPEXI/54Q1BRurJ+6IEqQGhWtd0gIOF5WkEE8mGL5Vb+IKrOqhZXuekhywdHO4JyGVor7+ci8g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789241254;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=bEBDSJzrRr1SVORYP1XOYyIEe3AEhIJwVdb2STNG+Kg=; 
 b=EGE7glYAzZ+2MZRLJSTFEkizho3ToCevnoRIJOtM/7fTnQhPJfXEJjRTpf64MxQBcjHPKNp5TspmArzQrlNpb7Clgv0CoV9yZl0a7NU9UgkQSQiZ75Wqm9jTMava5yDdQ18ql55nr8q72Au6JR3iKM/lESFqvQ03sEBECIfEeqw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789241254; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=bEBDSJzrRr1SVORYP1XOYyIEe3AEhIJwVdb2STNG+Kg=;
 b=Bi4Yfa/mYcMDQSKonuCfQSDP349qF7UpJTlWTqSIVtbL1vuMBFhNCS+S3/hnoF6u
 HPHAd3OqqRrad6kTGCGEvVcvoVLh29K7E8xFLrjaRM1zAC8dNT/W2pIc49yPRnP8Rvz
 R3XroajRSHxIfMnbKC7qcvgc5lSOOVoaGa8w+MXg=
Received: by mx.zohomail.com with SMTPS id 1789241252677947.9407094368581;
 Sat, 12 Sep 2026 12:27:32 -0700 (PDT)
Date: Sat, 12 Sep 2026 20:27:28 +0100
From: Adrian Larumbe <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chris Diamand <chris.diamand@arm.com>, Akash Goel <akash.goel@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 18/18] drm/panthor: Add debugfs knobs to simulate
 reset failures
Message-ID: <aqWmIbT_46Enz8VH@sobremesa>
References: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
 <20260826-panthor-unplug-fixes-v4-18-982cc8f4234b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260826-panthor-unplug-fixes-v4-18-982cc8f4234b@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/289.238.31
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

I've tried poking the knob that fakes an error in the reset path and got two different kinds of oputput:

Either
```
[ 1950.080236] panthor fb000000.gpu: [drm] *ERROR* Failed to boot MCU after reset, making device unusable.
[ 1951.167384] panthor fb000000.gpu: [drm] Timed out waiting for MCU to halt
[ 1951.167543] panthor fb000000.gpu: [drm] Failed to cleanly suspend MCU
```
or just

```
[ 2022.804466] panthor fb000000.gpu: [drm] *ERROR* Failed to boot MCU after reset, making device unusable.
```

I guess the former happens when after device unplug, there are still inflight jobs that keep a PM reference.

On 26.08.2026 16:56, Boris Brezillon wrote:
> It's almost impossible to trigger a situation where the reset
> doesn't work now that the driver is more mature, so let's add two
> knobs to exercise this error path:
> 
> - a knob to trigger a reset
> - a knob to fake an error in the reset path
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.c | 48 +++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/panthor/panthor_device.h |  8 ++++++
>  2 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index 328e601d80e8..8bdc511310c0 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -5,6 +5,7 @@
>  /* Copyright 2025 ARM Limited. All rights reserved. */
>  
>  #include <linux/clk.h>
> +#include <linux/debugfs.h>
>  #include <linux/mm.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> @@ -182,7 +183,10 @@ static void panthor_device_reset_work(struct work_struct *work)
>  	panthor_hw_soft_reset(ptdev);
>  	panthor_hw_l2_power_on(ptdev);
>  	panthor_mmu_post_reset(ptdev);
> -	ret = panthor_fw_post_reset(ptdev);
> +	if (ptdev->reset.fake_failure)
> +		ret = -EIO;
> +	else
> +		ret = panthor_fw_post_reset(ptdev);
>  	atomic_set(&ptdev->reset.pending, 0);
>  	panthor_sched_post_reset(ptdev, ret != 0);
>  	drm_dev_exit(cookie);
> @@ -690,8 +694,50 @@ int panthor_device_suspend(struct device *dev)
>  }
>  
>  #ifdef CONFIG_DEBUG_FS
> +static int panthor_device_fake_fw_reset_failure_get(void *data, u64 *val)
> +{
> +	struct panthor_device *ptdev = data;
> +
> +	*val = ptdev->reset.fake_failure ? 1 : 0;
> +	return 0;
> +}
> +
> +static int panthor_device_fake_fw_reset_failure_set(void *data, u64 val)
> +{
> +	struct panthor_device *ptdev = data;
> +
> +	ptdev->reset.fake_failure = val ? true : false;
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(panthor_device_fake_fw_reset_failure_fops,
> +			 panthor_device_fake_fw_reset_failure_get,
> +			 panthor_device_fake_fw_reset_failure_set, "%llu\n");
> +
> +static ssize_t panthor_device_reset_file_write(struct file *file,
> +					       const char __user *, size_t size,
> +					       loff_t *)
> +{
> +	struct panthor_device *ptdev = file_inode(file)->i_private;
> +
> +	panthor_device_schedule_reset(ptdev);
> +	return size;
> +}
> +
> +static const struct debugfs_short_fops panthor_device_reset_fops = {
> +	.write = panthor_device_reset_file_write,
> +};
> +
>  void panthor_device_debugfs_init(struct drm_minor *minor)
>  {
> +	struct panthor_device *ptdev = container_of(minor->dev, struct panthor_device, base);
> +
> +	debugfs_create_file("fake_fw_reset_failure", 0644,
> +			    minor->debugfs_root, ptdev,
> +			    &panthor_device_fake_fw_reset_failure_fops);
> +	debugfs_create_file("reset", 0200,
> +			    minor->debugfs_root, ptdev,
> +			    &panthor_device_reset_fops);
>  	panthor_mmu_debugfs_init(minor);
>  	panthor_gem_debugfs_init(minor);
>  }
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index e12049961912..82ec34347eba 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -294,6 +294,14 @@ struct panthor_device {
>  		 * all FW sections to make sure we start from a fresh state.
>  		 */
>  		bool fast;
> +
> +		/**
> +		 * @fake_failure: When true, pretend the FW boot in the reset path failed.
> +		 *
> +		 * This is important to check that we're doing the right thing in this very
> +		 * unlikely case.
> +		 */
> +		bool fake_failure;
>  	} reset;
>  
>  	/** @pm: Power management related data. */
> 
> -- 
> 2.55.0

Adrian Larumbe
