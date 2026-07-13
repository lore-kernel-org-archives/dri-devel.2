Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACE4C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BBFE10E570;
	Mon, 13 Jul 2026 07:02:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="oavYqWF4";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7164D10E570
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 07:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783926139;
 bh=JmL2Xl89K/g0SDzatddF+hPgFCB5s4RU+PbV4too2i0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=oavYqWF4S16Y9fz/VE4AkuAoOnchjHpkJc5P35aHNkeNmXEsOwOso8AxiFJ9LoHtb
 VdiLEWhB28TKU5AbyxfyC4C6nb50PSbQyrhMjbp7f0Nfm7e92v2eRyNzIgfhyazUNb
 c9wb4gjrfOcRNHrzrmzD3VdnL/gT/ycHTlihGXCjAgEQ1u+Lue9iIKrWFe9MM5DfRH
 G68RAfwiGtm4NfuIK9FkmOkUJlyGCMrOvo3z2a+LPZ5TpcEUyYCyzuXDYpUyIANPlc
 19LyBGtTyylYkufc6UqCDr8dUrHfkaVNEQ0TkI+9ewxoV/tV2EV3eZI9alnphlyOaG
 o/oAKmu2Ix2iA==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 8D5F817E0802;
 Mon, 13 Jul 2026 09:02:18 +0200 (CEST)
Date: Mon, 13 Jul 2026 09:02:10 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ketil Johnsen <ketil.johnsen@arm.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] drm/panthor: Don't allocate protm_suspend_buf
Message-ID: <20260713090210.40677ad4@fedora-2.home>
In-Reply-To: <20260712135439.1546950-6-ketil.johnsen@arm.com>
References: <20260712135439.1546950-1-ketil.johnsen@arm.com>
 <20260712135439.1546950-6-ketil.johnsen@arm.com>
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

On Sun, 12 Jul 2026 15:54:37 +0200
Ketil Johnsen <ketil.johnsen@arm.com> wrote:

> The PROTM suspend buffer is only needed if the group is going to
> use PROTM in the first place, so let's not assume we need one until
> we're being asked to.
> 
> Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index dc77a174a3368..86c0f12b09e11 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -3642,9 +3642,11 @@ static void add_group_kbo_sizes(struct panthor_device *ptdev,
>  	if (drm_WARN_ON(&ptdev->base, ptdev != group->ptdev))
>  		return;
>  
> -	group->fdinfo.kbo_sizes += group->suspend_buf->obj->size;
> -	group->fdinfo.kbo_sizes += group->protm_suspend_buf->obj->size;
>  	group->fdinfo.kbo_sizes += group->syncobjs->obj->size;
> +	group->fdinfo.kbo_sizes += group->suspend_buf->obj->size;
> +
> +	if (group->protm_suspend_buf)
> +		group->fdinfo.kbo_sizes += group->protm_suspend_buf->obj->size;
>  
>  	for (i = 0; i < group->queue_count; i++) {
>  		queue =	group->queues[i];
> @@ -3724,14 +3726,6 @@ int panthor_group_create(struct drm_file *file,
>  		goto err_put_group;
>  	}
>  
> -	suspend_size = csg_iface->control->protm_suspend_size;
> -	group->protm_suspend_buf = panthor_fw_alloc_suspend_buf_mem(ptdev, suspend_size);
> -	if (IS_ERR(group->protm_suspend_buf)) {
> -		ret = PTR_ERR(group->protm_suspend_buf);
> -		group->protm_suspend_buf = NULL;
> -		goto err_put_group;
> -	}
> -
>  	group->syncobjs = panthor_kernel_bo_create(ptdev, group->vm,
>  						   group_args->queues.count *
>  						   sizeof(struct panthor_syncobj_64b),

