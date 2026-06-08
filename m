Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615B5CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7B0610F440;
	Mon,  8 Jun 2026 14:08:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="OCDkAtSp";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47F8310F440
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780927709;
 bh=wMdzVbo7fQ6ACjCX+/zM5k9XCFQ4DSfvxjQMK9PPkH0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=OCDkAtSptNj+BgBgVIlD4NreMxNMC5NBAfJE5V/yzZVbiEEXFzcWNfp00YAhQD0ag
 HXltUqlrtQv+WS4PRJcbiSeT2cgeCaY70Waxra+Umm4YmeuZ/EvMt09zsRXKcQKpSV
 vnwC8c25AKk1zB62v6nrcPdcfdYgvoKFYvCpI+BZ3JNtWLHJSkRQKdTjzYloWu3qgL
 L97BBJMw8mQs6abYicXKZfW+BSUCWEueYlB8nPTF5pPSSWNiF+haQOhSD4dTrW2+eC
 nrYetYOmZsahlziEDnTgtdabzx/87W06+i9dWlXX/C7mZMiweT7BXOy3zDU9ss9F3a
 6gpuFxmzy+XtQ==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 79EDE17E0CA9;
 Mon,  8 Jun 2026 16:08:29 +0200 (CEST)
Date: Mon, 8 Jun 2026 16:08:22 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 08/18] drm/panthor: Skip devfreq when no OPP table
 is present
Message-ID: <20260608160822.1038d08e@fedora-2.home>
In-Reply-To: <20260528150546.3168527-9-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
 <20260528150546.3168527-9-karunika.choo@arm.com>
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

On Thu, 28 May 2026 16:05:36 +0100
Karunika Choo <karunika.choo@arm.com> wrote:

> On Mali v15 AM systems, frequency scaling is handled outside panthor by
> the AM_GOVERNOR block, so the GPU DT node may not provide an OPP table.

OOC, is this still handled as clock frequency changes? I'm asking
because the recent perfcnt work requires registering clk notifiers to
get an approximation of the number of shader/top-level/coregroup clock
cycles on a given period of time so we an calculate relative GPU
utilization, and so far we've only considered clk notifiers as a way to
get informed of these frequency changes.

BTW, this is already problematic for the mediatek GPUEB design, where
devfreq stuff is delegated to an MCU, and we don't currently have a way
to get notified when this MCU changes the frequencies.

> 
> Make panthor_devfreq_init() return early when operating-points-v2 is
> absent, and guard the devfreq helper paths against a missing devfreq
> instance.
> 
> This keeps devfreq enabled for existing platforms while allowing v15 AM
> systems to probe without a local devfreq setup.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_devfreq.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
> index 2249b41ca4af..c3252ce54437 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.c
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
> @@ -148,6 +148,9 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
>  	unsigned long freq = ULONG_MAX;
>  	int ret;
>  
> +	if (!device_property_read_bool(ptdev->base.dev, "operating-points-v2"))
> +		return 0;
> +
>  	pdevfreq = drmm_kzalloc(&ptdev->base, sizeof(*ptdev->devfreq), GFP_KERNEL);
>  	if (!pdevfreq)
>  		return -ENOMEM;
> @@ -267,7 +270,7 @@ void panthor_devfreq_resume(struct panthor_device *ptdev)
>  {
>  	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
>  
> -	if (!pdevfreq->devfreq)
> +	if (!pdevfreq || !pdevfreq->devfreq)
>  		return;
>  
>  	panthor_devfreq_reset(pdevfreq);
> @@ -279,7 +282,7 @@ void panthor_devfreq_suspend(struct panthor_device *ptdev)
>  {
>  	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
>  
> -	if (!pdevfreq->devfreq)
> +	if (!pdevfreq || !pdevfreq->devfreq)
>  		return;
>  
>  	drm_WARN_ON(&ptdev->base, devfreq_suspend_device(pdevfreq->devfreq));
> @@ -290,7 +293,7 @@ void panthor_devfreq_record_busy(struct panthor_device *ptdev)
>  	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
>  	unsigned long irqflags;
>  
> -	if (!pdevfreq->devfreq)
> +	if (!pdevfreq || !pdevfreq->devfreq)
>  		return;
>  
>  	spin_lock_irqsave(&pdevfreq->lock, irqflags);
> @@ -306,7 +309,7 @@ void panthor_devfreq_record_idle(struct panthor_device *ptdev)
>  	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
>  	unsigned long irqflags;
>  
> -	if (!pdevfreq->devfreq)
> +	if (!pdevfreq || !pdevfreq->devfreq)
>  		return;
>  
>  	spin_lock_irqsave(&pdevfreq->lock, irqflags);
> @@ -323,7 +326,7 @@ unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev)
>  	unsigned long freq = 0;
>  	int ret;
>  
> -	if (!pdevfreq->devfreq)
> +	if (!pdevfreq || !pdevfreq->devfreq)
>  		return 0;
>  
>  	ret = pdevfreq->devfreq->profile->get_cur_freq(ptdev->base.dev, &freq);

