Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB349CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:12:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1353F10E913;
	Wed, 10 Jun 2026 12:12:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="M7t6/i91";
	dkim-atps=neutral
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EB7B10E913
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 12:12:26 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-692491fec0bso3219872a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 05:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1781093545; x=1781698345; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YJe1xz1ZMNVnBlNAhTok//gR+6F59R46BnGd4lcF8bY=;
 b=M7t6/i91iRfqU1TN97bLsiq9zQUABlMEGWfsK8kEQ7naQBP1YUAyNqY7dULffieTa5
 5zKwGStwmg5P0WRARB3pDkfMW1UGx6x0Ftl8CIgYKJPj6b8gFr+ukPibw6lWc4UMwCRJ
 V9zZXagJ+jI3XU6UwGzrhztR1GGWtkXpPO2Wa3iTSCYpd3n7x+VhgNhE1fyiUO4oG0E9
 PKkWqYarxc/rz6mn9mL9ASMo66TlwGrXYMotaGnvrGSEiuawYq7zCqWSxUL5I0HmCYtt
 bpZmhsDmkcUiiVgQOKsGs4Mdhs6awrOXMpNrU4nLzqYztmExUSlm8CmUCKlybil1LaJ4
 gFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781093545; x=1781698345;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YJe1xz1ZMNVnBlNAhTok//gR+6F59R46BnGd4lcF8bY=;
 b=IUyG3i6vlki/CYzBCMJ7GnRAhgLjEQjofTKLgvPlzE0lgBFciWgIQBmAqOAZmSL0Bz
 HRiEoFkeueDocLu6mV1HO2ptkyM25UTuOeVTwSxJTSE7Ge2hjoL1Y1ick09Wvv0fOvTj
 w23OaZqCbn3zuRrzR/wA32OcAvSUYAVPQ232DflYM5Sdjae/GzmuJlaHW45bQGajFcpP
 +vPlNZs5AlItMHzZHl35FCtmYvtO7g+pCyKLJZOdvC6Q02GHQA0nAzqQirHY+xtQWCkB
 W7NvEtkbwjOcH8JC/iBeizuWRhLWs44lq4tXXWZA+rZPq+wBVubOpl8cFHlEluT6WGkJ
 6AXg==
X-Gm-Message-State: AOJu0YzgXJRDiQrSL6V+akq1h/qiw7S0VXYf2WDRhdR9lsExqfPCgXzZ
 OCjprLwHwb8wzz/jVYRmgq1tZglV50zQdq/d3rFCdChc03bA36zmdxnC6UoQ8kjXX/M=
X-Gm-Gg: Acq92OF1pwK924Muhcbb68WUHpcEcozLpyVF6fbMfOcaO5PmVa37biYTUhadgP5zokM
 o4mfd2qUYAcvVE68u3DqZ9aXONLnnKLAzumTlzHnhnq/kdlfE7pmxdWEoLk7LKaTa28Z5iiV3I8
 IUtmFQvCA9XNk4Whu8zZyzd60ch7uAwgruYQJ6XA6QqLSCXMTz4FjMgvYs5SXBqWviv4Gj8c9Ri
 rJ71+wLdZuELpEFzJtY/pZ2byeHYHLkSaQ1zavJTN2tQBWpM/fFtP2IT4jc/IUsoZTPtWl9A9l6
 7SiAyJhg7w2kHvePFfO7fc09STEUhWCoiMohN+i6KJKENjOKujyV0Kapw+r9K8M6wEt8Lf4wbFq
 vWwH3xZexu5VwZSq4mgjCr3uv4lNCdFOILlPK2eYQjDbOKzzH1/xdZ++rcgsOm1Y/L+kwg3LmeH
 S1y5zJ+fCC9GbbIS4zEQIfcPFFXj7AKiNdl78SwCUs0XyiMO2tB6H0b6HeB590B6S0Iw==
X-Received: by 2002:a05:6402:5193:b0:66e:abe5:ab22 with SMTP id
 4fb4d7f45d1cf-68fa4c0039fmr11944776a12.5.1781093544179; 
 Wed, 10 Jun 2026 05:12:24 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e64e2c810sm9966710a12.9.2026.06.10.05.12.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 05:12:22 -0700 (PDT)
Message-ID: <b5f634e3-ca52-4674-82a7-fabce99ec364@ursulin.net>
Date: Wed, 10 Jun 2026 13:12:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau: Document weird looking bugfix
To: Philipp Stanner <phasta@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20260610082602.1292853-2-phasta@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260610082602.1292853-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 10/06/2026 09:26, Philipp Stanner wrote:
> commit c8a5d5ea3ba6 ("nouveau: fix client work fence deletion race")
> fixed a race. To do so, it replaced the automatically locking
> dma_fence_is_signaled() with manual locks plus
> dma_fence_is_signaled_locked().
> 
> For someone browsing through the code, this reads very much like a
> cleanup or rework leftover. Future contributors and / or new maintainers
> not familiar with the history might be tempted to remove that bugfix.
> 
> Document the bugfix.
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> (I did not test this)
> ---
>   drivers/gpu/drm/nouveau/nouveau_drm.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
> index 42a81166f3a9..519a0c164a72 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -159,6 +159,13 @@ nouveau_cli_work_ready(struct dma_fence *fence)
>   	unsigned long flags;
>   	bool ret = true;
>   
> +	/*
> +	 * This is not a cleanup / rework leftover, but a bugfix to prevent a
> +	 * race with someone signalling the fence. The locked
> +	 * dma_fence_is_signaled() cannot be used. The dma_fence implementation
> +	 * is not fully synchronized with locks, but also uses atomic bits,
> +	 * which can cause the dma_fence_put() below to be executed too soon.
> +	 */

IMHO it would also be interesting to document why this happens from the 
nouveau point of view.

For example I see the two references held on this fences in the call 
chain, but apparently neither are enough to close the race. Which 
suggests a third party has a pointer to this fence but with no reference.

I talk about this:

nouveau_gem_object_unmap -> nouveau_cli_work_queue

There it grabs a reference before queing the worker. In the worker it 
drops it before calling the callback nouveau_gem_object_unmap installed:

static void
nouveau_cli_work(struct work_struct *w)
{
	struct nouveau_cli *cli = container_of(w, typeof(*cli), work);
	struct nouveau_cli_work *work, *wtmp;
	mutex_lock(&cli->lock);
	list_for_each_entry_safe(work, wtmp, &cli->worker, head) {
		if (!work->fence || nouveau_cli_work_ready(work->fence)) {

... nouveau_cli_work_ready can drop one reference

			list_del(&work->head);
			work->func(work);

... then work->func was set to nouveau_gem_object_delete_work by 
nouveau_gem_object_unmap, which will end up calling:

nouveau_gem_object_delete -> nouveau_fence_unref

On possibly the same fence.

So if there a path inside nouveau itself which signals the fence without 
holding a reference then could be it that the problem is self-inflicted 
and not due a dma-fence quirks?

I am not entirely sure since it is not very clear. It needs someone with 
nouveau expertise to clarify.

Regards,

Tvrtko

>   	dma_fence_lock_irqsave(fence, flags);
>   	if (!dma_fence_is_signaled_locked(fence))
>   		ret = false;

