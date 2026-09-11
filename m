Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA42C88E53
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 19:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11C0910E401;
	Fri, 11 Sep 2026 19:19:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Xot4l4hF";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6274E10E401
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 19:19:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789154327; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KgIoiEMoXqYTZzILMJrJ9WBHq6wBgAy5WFfsPa11sj1o78pz5DjCIJMT3f+k6X/sThl2sEj3LQfhQP8cM9fkogn/qqm/aHJu3mlSm+ukwq0iI/YRQDINvZqD5oN7OD3YyiT86bUnyYR5XUe0t3JhOFFuVV00KAEaW2gjyM7L8IY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789154327;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=lK+pZwRlb5fLtEfqpk+prHr+qVuv4jWiesa+VEIUtzo=; 
 b=NN7IclaDCTXPueBGCor1LH4yxU6LqugHikOJyeaMNDQc4ZKyeB1+PO3ysjYL+6MkFqSPRZ0KW6pifvxtHYeISLqoU1zDUlV10YMqyNkVzB1tqgzz9lMn481cyoXdC2TkLDy+N8z+9B9MAJcCijat/4/gx44Q4XE4qARMZ1bQTVA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789154327; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=lK+pZwRlb5fLtEfqpk+prHr+qVuv4jWiesa+VEIUtzo=;
 b=Xot4l4hFxuOXrJJ0QG3Cy6+/aaVEHuelXVwBAJCmUVYr3IQQn9mNkOH3DQczqhCV
 yrZ8kKX0u+H6FR0oZpq+ThKSsyRDMaxBCsUzMnRQU5x/2H8hdwjsofxlRAEMiWZECj8
 3t/MtmI4bOzVBC9yxQ0xrGcq54UPpMZ9K07jaJUs=
Received: by mx.zohomail.com with SMTPS id 1789154325501804.3814371256973;
 Fri, 11 Sep 2026 12:18:45 -0700 (PDT)
Date: Fri, 11 Sep 2026 20:18:41 +0100
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
Message-ID: <aqQs54XbOvmxOyzz@sobremesa>
References: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
 <20260826-panthor-unplug-fixes-v4-18-982cc8f4234b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260826-panthor-unplug-fixes-v4-18-982cc8f4234b@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/289.144.59
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

Reviewed-by: Adrián Larumbe <adrian.larumbe@collabora.com>

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
