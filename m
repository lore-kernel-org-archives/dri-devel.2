Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5E6C44525
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 266C110E14A;
	Mon, 20 Jul 2026 09:48:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="lLRgpw36";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D844610E14A
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 09:48:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784540886; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZsocTz/8b0nVZF8qsJxiZUPQfX01++RPg63N2+4t22GehJNJ+sUMUIvbpb1uwD8x2dsOedaSQKv/fur6EnbEAHgIyV8smAX7rM+VnlEu8Gi76HjeCxv6CQcgC1t4XG5/uY1ux1hEOsGHqvmVnYNz9Yrswa4rEDj71ajTGV/vWg4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784540886;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=f06YDyvcwlZTxvovNFtb1iwHk4VC7nx7/aML7uTwEsI=; 
 b=OlDK8pvYXTNtmhp44Z7q2JJRAUBn4iQvkA+d06kGtSVvWLSUVqe6YLbFyO23zfOBhLfnltm9/X2sluzyRR2koju87jgNCR7LRroYXW04+39BzM00QVEWOg/2zTtaewImCGA9TQ1qJBrSOedxxisDwbNp5UrWk7YzwAp5Ozy0bE0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784540886; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=f06YDyvcwlZTxvovNFtb1iwHk4VC7nx7/aML7uTwEsI=;
 b=lLRgpw36yyE6HgjGZukGkOLNRqT8NVVhLC9KUPirfPangFD/IHHhYhldLeVabHX5
 2iMz9g60zzKaJCbvLEuesmIGgfaSoMBk74UkeyPabyBXZ4GjroWiHZmNptE7m2q4WCW
 M4dRfRMnyfkEQHXovmhrimTavzwcdh/Bn3Oa+YBM=
Received: by mx.zohomail.com with SMTPS id 1784540885604554.0929587352072;
 Mon, 20 Jul 2026 02:48:05 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chia-I Wu <olvaffe@gmail.com>, Karunika Choo <karunika.choo@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Boris Brezillon <boris.brezillon@collabora.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH 03/11] drm/panthor: Fix UAF on works queued to
 panthor_cleanup_wq
Date: Mon, 20 Jul 2026 11:47:59 +0200
Message-ID: <bw7DeMSTSiqMFTSPLhpuNA@collabora.com>
In-Reply-To: <20260625-panthor-misc-fixes-v1-3-b67ed973fea6@collabora.com>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
 <20260625-panthor-misc-fixes-v1-3-b67ed973fea6@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

On Thursday, 25 June 2026 14:40:29 Central European Summer Time Boris Brezillon wrote:
> If we don't drain the panthor_cleanup_wq before
> unregistering/destroying the panthor_device, we might end up with
> cleanup works that are executed after the device is gone.
> 
> Add a drain_workqueue() call in panthor_device_unplug() to prevent
> that.
> 
> Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
> Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com?part=2
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index 0b25abebb803..a0774e28aa94 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -101,6 +101,11 @@ void panthor_device_unplug(struct panthor_device *ptdev)
>  	panthor_gpu_unplug(ptdev);
>  	panthor_pwr_unplug(ptdev);
>  
> +	/* Make sure works queued to panthor_cleanup_wq are executed
> +	 * before the device is destroyed.
> +	 */
> +	drain_workqueue(panthor_cleanup_wq);
> +
>  	pm_runtime_dont_use_autosuspend(ptdev->base.dev);
>  	pm_runtime_put_sync_suspend(ptdev->base.dev);
>  
> 
> 

I feel like nothing in the driver instance should be allowed to queue new
work to that workqueue while the unplug mutex is being held, and
panthor_sched_unplug should just disable_work_sync all the associated group
release_work items as well. If there's not a strong enough relationship
between a scheduler and the groups to ensure we get all the groups in a
non-racey manner that might not work out cleanly though.

Having a scheduler unplug be completely disconnected from the associated
groups being gone seems counter-intuitive to me.

Kind regards,
Nicolas Frattaroli


