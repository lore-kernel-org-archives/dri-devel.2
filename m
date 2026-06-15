Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE37CD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 09:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B7BC10E31F;
	Mon, 15 Jun 2026 09:32:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="by2nHFup";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9257D10E313;
 Mon, 15 Jun 2026 09:32:07 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gf4dY5yZhz9trN;
 Mon, 15 Jun 2026 11:32:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1781515921; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IHQDosOm22jDMT0kcqkkbFG5+g4HnZQEipe6cGcRh7c=;
 b=by2nHFupUSW24AiyvLIU0HFpiEkiM4M5QjbephY0Ueq4ZPEfSrMJBeRPMlKG/98iYYyMhT
 suKSPvpkRRr5zHaspoDD0FOMxhsdtUjonlJlTFJmOBvLSwPy+p6A5CB9rzj3PFvtQpoGBv
 dGhNiEqe157ic1sk3dZW3ffhacALkVyZzKDO6hC1ziuBwnpYnP4i9IMusUw8KRO1r4AZ95
 HEqf7fap6fhq0cdJ9DqyhcuL3UwI7wArYp66A8/ciUmNSpNlZzrNvPh5GrTYy2BfLvKkFl
 jCGD3aKlHKMd/wV1ppc9KTPaYvl3A0GHrLW6vEgYBRgsv7Em9M3Us/eAf5PItQ==
Message-ID: <36bd84b9c2d504efbb2484c13455f1aa5ade06ff.camel@mailbox.org>
Subject: Re: [PATCH v3] drm/nouveau: Simplify nouveau_cli_work
From: Philipp Stanner <phasta@mailbox.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Philipp Stanner <phasta@kernel.org>, Lyude Paul
 <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 nouveau@lists.freedesktop.org
Date: Mon, 15 Jun 2026 11:31:57 +0200
In-Reply-To: <20260615092607.80917-1-tvrtko.ursulin@igalia.com>
References: <20260612165409.54447-1-tvrtko.ursulin@igalia.com>
 <20260615092607.80917-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: t1jwn3aphp9ngd7tjsygxqfm4wk69uas
X-MBO-RS-ID: 12c9ef0ea4e8ee90adf
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, 2026-06-15 at 10:26 +0100, Tvrtko Ursulin wrote:
> Lets simplify and make clearer the fence lock cycling workaround in
> nouveau_cli_work().
>=20
> The reason for the workaround is that the worker processes the list of
> pending work items (and so fence callbacks) opportunisticaly, while
> dma_fence_is_signaled() returns true as soon as a the fence is signaled.
> It is therefore not allowed for the opportunistic processing to free the
> work item, since the fence callback processing can still be in the proces=
s
> of dereferencing work->cb.
>=20
> This wasn't very clear in the code so clarify it with a nice comment.
>=20
> In the process we replace the somewhat interleaved and not very readable
> nouveau_cli_work_ready() helper with a direct dma_fence_is_signaled, whic=
h
> is even faster since it removes the lock cycling from the unsignaled fenc=
e
> path.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: nouveau@lists.freedesktop.org
> ---
> v2:
> =C2=A0* Don't dereference work after work->func(work) frees it.
>=20
> v3:
> =C2=A0* Put back and explain lock cycling.
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_drm.c | 34 +++++++++++++-----------=
---
> =C2=A01 file changed, 17 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouv=
eau/nouveau_drm.c
> index 42a81166f3a9..7ea95ab960a0 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -153,22 +153,6 @@ nouveau_name(struct drm_device *dev)
> =C2=A0		return nouveau_platform_name(to_platform_device(dev->dev));
> =C2=A0}
> =C2=A0
> -static inline bool
> -nouveau_cli_work_ready(struct dma_fence *fence)
> -{
> -	unsigned long flags;
> -	bool ret =3D true;
> -
> -	dma_fence_lock_irqsave(fence, flags);
> -	if (!dma_fence_is_signaled_locked(fence))
> -		ret =3D false;
> -	dma_fence_unlock_irqrestore(fence, flags);
> -
> -	if (ret =3D=3D true)
> -		dma_fence_put(fence);
> -	return ret;
> -}
> -
> =C2=A0static void
> =C2=A0nouveau_cli_work(struct work_struct *w)
> =C2=A0{
> @@ -176,9 +160,25 @@ nouveau_cli_work(struct work_struct *w)
> =C2=A0	struct nouveau_cli_work *work, *wtmp;
> =C2=A0	mutex_lock(&cli->lock);
> =C2=A0	list_for_each_entry_safe(work, wtmp, &cli->worker, head) {
> -		if (!work->fence || nouveau_cli_work_ready(work->fence)) {
> +		struct dma_fence *fence =3D work->fence;
> +
> +		if (!fence || dma_fence_is_signaled(fence)) {
> +			if (fence) {
> +				unsigned long flags;
> +
> +				/*
> +				 * Because fence can still be in the process of
> +				 * processing the callback list, and the
> +				 * callback references the work we are about to
> +				 * free, we need to sync with the callback
> +				 * processing before freeing the work.
> +				 */
> +				dma_fence_lock_irqsave(fence, flags);
> +				dma_fence_unlock_irqrestore(fence, flags);
> +			}
> =C2=A0			list_del(&work->head);
> =C2=A0			work->func(work);
> +			dma_fence_put(fence);

This is semantically exactly the same fix that was introduced by Dave
in c8a5d5ea3ba6a and which you are reverting here again, basically.

It's no improvement IMO, just a differently looking work around the
fact that the dma_fence framework is not properly synchronized.

I suggest you participate here [1] and here [2] and share your opinion.
At least *this* problem would disappear of only dma_fence_is_signaled()
were locking properly.


P.


[1] https://lore.kernel.org/dri-devel/fa0dc9757bf8343516c4b156a2b70ec91b64e=
f8f.camel@mailbox.org/
[2] https://lore.kernel.org/dri-devel/20260612104251.2264707-2-phasta@kerne=
l.org/

> =C2=A0		}
> =C2=A0	}
> =C2=A0	mutex_unlock(&cli->lock);
