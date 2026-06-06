Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4500ECD6E75
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 04:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E84B10E567;
	Sat,  6 Jun 2026 04:18:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YFjU40dw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 115EA10E567
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 04:18:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 47953601DE;
 Sat,  6 Jun 2026 04:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4961F00893;
 Sat,  6 Jun 2026 04:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780719534;
 bh=Pgup0MEuURsh5FlkXz5/7VTHh8B7vxpw6Qxh+IBuPsg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YFjU40dwaSGN/Av4Aj/qTidsVLdoXuvRA5tQMI6rzHLdUM7ZHrt8ZbARUqqUaCjf+
 uU0luMdkebr/On6S+L4sJfZxAkiB9TzrDjhNggBwHtWEfA/mGCawpSijMsyMUJZDXf
 tpZpYNCWuJ+T1sDuZSvwFQy8ztsNuIZd6kmQTNeGIJCki1yvcvv7jIeHSVcUSXjRaf
 jXP2g757K9674ijMtg+Xrd3gwVeMeLluBptBdQTip3OGkweu2QSBqh7ZkS0gkLqs/+
 uiUWh8csY8N2fsVCeHe3stiumioSedVhGhyNgazoRI/vlANYVkDbhYso2tzDrpZrsl
 /QisDfrxmS63Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/omap: check IRQ wait allocation
To: "Ruoyu Wang" <ruoyuw560@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260606040620.13-1-ruoyuw560@gmail.com>
References: <20260606040620.13-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 04:18:53 +0000
Message-Id: <20260606041853.CF4961F00893@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] omap_irq_wait_init and omap_irq_wait call sleeping functions (GFP_=
KERNEL allocation and wait_event_timeout) from encoder atomic enable/disabl=
e callbacks.
--

commit ae2889fe92d3ac71e93d1e5708680bea50475102
Author: Ruoyu Wang <ruoyuw560@gmail.com>

drm/omap: check IRQ wait allocation

This commit adds NULL pointer checks to handle memory allocation failures
in omap_irq_wait_init() and omap_irq_wait(), preventing potential NULL
pointer dereferences.

> diff --git a/drivers/gpu/drm/omapdrm/omap_irq.c b/drivers/gpu/drm/omapdrm=
/omap_irq.c
> index d0f895c43ee41..e0fa9617a3d30 100644
> --- a/drivers/gpu/drm/omapdrm/omap_irq.c
> +++ b/drivers/gpu/drm/omapdrm/omap_irq.c
> @@ -46,6 +46,9 @@ struct omap_irq_wait * omap_irq_wait_init(struct drm_de=
vice *dev,
>  	struct omap_irq_wait *wait =3D kzalloc_obj(*wait);

[Severity: High]
This is a pre-existing issue, but does this allocation sleep in an atomic
context?=20

kzalloc_obj() defaults to a GFP_KERNEL allocation, which can sleep. If
omap_irq_wait_init() is called from encoder atomic enable/disable callbacks
(for example, via omap_crtc_set_enabled() during the DSS encoder enable
sequence), calling sleeping functions in an atomic context is forbidden and
can cause system instability or kernel warnings.

>  	unsigned long flags;
> =20
> +	if (!wait)
> +		return NULL;
> +
>  	init_waitqueue_head(&wait->wq);

[ ... ]

> @@ -65,6 +68,9 @@ int omap_irq_wait(struct drm_device *dev, struct omap_i=
rq_wait *wait,
>  	unsigned long flags;
>  	int ret;
> =20
> +	if (!wait)
> +		return -ENOMEM;
> +
>  	ret =3D wait_event_timeout(wait->wq, (wait->count <=3D 0), timeout);

[Severity: High]
This isn't a bug introduced by this patch, but does wait_event_timeout()
sleep here while in an atomic context?

Since wait_event_timeout() is a sleeping function, calling it from encoder
atomic enable/disable callbacks violates DRM atomic context rules. Should
these operations be deferred to a non-atomic context, or should they be
converted to use non-sleeping hardware polling mechanisms instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606040620.13-1=
-ruoyuw560@gmail.com?part=3D1
