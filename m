Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73865C44524
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 04:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C94B10E52F;
	Thu, 23 Jul 2026 04:43:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SKU3guVS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9731210E52F
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 04:43:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3B46543ADD;
 Thu, 23 Jul 2026 04:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9261F000E9;
 Thu, 23 Jul 2026 04:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784781827;
 bh=R2Kg/bahb4FaoIQlPlU0rs34yL1mo86P6LmhhWEB5Uc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SKU3guVSW9lGjovHKopWz+Whm6Mgjz93trkOkAEUQA+LjhFslnUQjYBJ88rLFh/c4
 vEdvM5U8ZCQVas1khPvfUAvLXIV78TvDYBYVzZM21sGGbKM9mGWfdTcubPrAGkj7eO
 K0OAFQpd3uq+2/agN4vJtK5KbV0ahSwTZeccjoui7vPH9xWrkr90dcMTi0Yf7Bp0XT
 3YrHqPdyk7z+nCA6wO0XnyYyMLGVNUJ3yORkWIPlImBbiyCQBsDqgN/lSVBe0uLXjC
 UbUaFtnFMRIWD+wWVfvf0u87iWdTzhQSPWIsFrwm925ebO1tW85SE0loHPoJm9eKwK
 +BRo1QpFHbf0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/vmwgfx: Remove unused vmw_goal_waiter_add/remove
To: "Saswat Jung Khadka" <saswatjungkhadka@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723043605.2195-1-saswatjungkhadka@gmail.com>
References: <20260721080028.4464-1-saswatjungkhadka@gmail.com>
 <20260723043605.2195-1-saswatjungkhadka@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 04:43:46 +0000
Message-Id: <20260723044346.DD9261F000E9@smtp.kernel.org>
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
- [Low] Incomplete cleanup of unused fence goal wait functionality
--

--- Patch [1]: [PATCH v2] drm/vmwgfx: Remove unused vmw_goal_waiter_add/rem=
ove ---
commit b2ac90a8c2d493310136bd03db77570d84be4d81
Author: Saswat Jung Khadka <saswatjungkhadka@gmail.com>

drm/vmwgfx: Remove unused vmw_goal_waiter_add/remove

This commit removes the vmw_goal_waiter_add() and vmw_goal_waiter_remove()
functions as they have no callers left after a previous dma_fence_ops
update.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx=
/vmwgfx_drv.h
> index 38bea8abab84c..d84e077ed2a4e 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> @@ -1026,8 +1026,6 @@ extern int vmw_fallback_wait(struct vmw_private *de=
v_priv,
>  			     unsigned long timeout);
>  bool vmw_seqno_waiter_add(struct vmw_private *dev_priv);
>  bool vmw_seqno_waiter_remove(struct vmw_private *dev_priv);
> -bool vmw_goal_waiter_add(struct vmw_private *dev_priv);
> -bool vmw_goal_waiter_remove(struct vmw_private *dev_priv);

[Severity: Low]
Since these functions are being removed, should goal_queue_waiters also be
removed from struct vmw_private? It appears to be completely unused now:

struct vmw_private {
        ...
        int fence_queue_waiters;
        int goal_queue_waiters;
        int cmdbuf_waiters;
        ...
}

>  bool vmw_generic_waiter_add(struct vmw_private *dev_priv, u32 flag,
>  			    int *waiter_count);
>  bool vmw_generic_waiter_remove(struct vmw_private *dev_priv,

[ ... ]

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_irq.c
> index 05773eb394d3a..88c77226c793f 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c
> @@ -273,18 +273,6 @@ bool vmw_seqno_waiter_remove(struct vmw_private *dev=
_priv)
>  					&dev_priv->fence_queue_waiters);
>  }
> =20
> -bool vmw_goal_waiter_add(struct vmw_private *dev_priv)
> -{
> -	return vmw_generic_waiter_add(dev_priv, vmw_irqflag_fence_goal(dev_priv=
),
> -					&dev_priv->goal_queue_waiters);
> -}
> -
> -bool vmw_goal_waiter_remove(struct vmw_private *dev_priv)
> -{
> -	return vmw_generic_waiter_remove(dev_priv, vmw_irqflag_fence_goal(dev_p=
riv),
> -					&dev_priv->goal_queue_waiters);
> -}

[Severity: Low]
With the removal of these waiter functions, is it also safe to remove the
fence goal interrupt check in vmw_irq_handler()? Since the corresponding IRQ
flags are never enabled in the IRQ mask anymore, this appears to be dead co=
de:

vmw_irq_handler() {
        ...
        if ((masked_status & (SVGA_IRQFLAG_ANY_FENCE |
                              vmw_irqflag_fence_goal(dev_priv))) &&
        ...
}

Would this also make the static helper function vmw_irqflag_fence_goal()
redundant?

> -
>  static void vmw_irq_preinstall(struct drm_device *dev)
>  {
>  	struct vmw_private *dev_priv =3D vmw_priv(dev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723043605.2195=
-1-saswatjungkhadka@gmail.com?part=3D1
