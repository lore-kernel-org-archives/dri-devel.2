Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BE4CDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CDA510F2DC;
	Thu, 25 Jun 2026 14:20:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="k2P5v4WE";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB2D310F2DC
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 14:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782397238;
 bh=VMFPhL9qWWY3o87HlGHRQAIC0bU8r7sxyyc2r8OQoEI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=k2P5v4WEpgP1QbQKqad1URswH/dxla8HE4Ry69llrZsBSCIegasJ4WZANnIHEXsMY
 bvI7SFeNudB85wcT7C/VNA4bfrHlKN2+KqRqQ6R1NAEiS6TJ0U36iCi2cFMZL2SOyi
 A7dXqd+xBgL9gjN4RULHt0tJbUSSQCKXn3/AoUZYMDeg2WBje/ZG98svnqD/B9c0zQ
 UDAiDPPF+Inf5jNDeVseZd1/u79I9r9kGETgc2Aq4NSehnml5NIVNfqCBAZobA/EZR
 C7Cem2XPzIxBcIh2FevlcFG+3ig/ORszHlf+0yCulKFereAgkrTkgNM2B2xDfgF1Sr
 EtkoiJFpukqdA==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E016A17E0114;
 Thu, 25 Jun 2026 16:20:37 +0200 (CEST)
Date: Thu, 25 Jun 2026 16:20:31 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Nicolas Frattaroli
 <nicolas.frattaroli@collabora.com>, Chia-I Wu <olvaffe@gmail.com>, Karunika
 Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH 03/11] drm/panthor: Fix UAF on works queued to
 panthor_cleanup_wq
Message-ID: <20260625162031.31aa32c6@fedora-2.home>
In-Reply-To: <20260625-panthor-misc-fixes-v1-3-b67ed973fea6@collabora.com>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
 <20260625-panthor-misc-fixes-v1-3-b67ed973fea6@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 25 Jun 2026 14:40:29 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

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

As shashiko pointed out[1], this doesn't work. __flush_workqueue()
could work, but I'm actually considering moving those work to the
panthor_mmu/panthor_scheduler, so we can easily call
disable_work_sync() when the MMU/scheduler components are torn down.

> +
>  	pm_runtime_dont_use_autosuspend(ptdev->base.dev);
>  	pm_runtime_put_sync_suspend(ptdev->base.dev);
>  
> 

[1]https://sashiko.dev/#/patchset/20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com?part=3
