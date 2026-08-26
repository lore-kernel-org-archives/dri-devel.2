Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA62C61DC4
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 867BC10EB88;
	Wed, 26 Aug 2026 18:38:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VnjgcFO1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0165810EB88
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 18:38:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 29B446001D;
 Wed, 26 Aug 2026 18:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D0F1F00ADF;
 Wed, 26 Aug 2026 18:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787769508;
 bh=kRkpPIIJDseCUMtgO14yei1ZO4aE4GBXMb9b8Bse7z8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VnjgcFO18UXQBAMEIACh+VpTrxs6MEK30eCuIpk6Mb926WCLGaPyma0L0xQPERY+v
 aTiHChUQ7VM7oG6z1bY30uXKIhLut/B8t5dte2/+RiD7OpnBxdKGASso7nPi35WzxB
 sXbxtGDtIeB/xvpQIYb8527+ahPSmzDFOSSHJkHotAVH6R6tHsgYi5w1OVTw+bjLhA
 E8Fig/VV0JIVWmkOb6bSWguSW8Q8VfCrw5I6zaMIHdgB/j8kzrmOoa8BmTMcrde4zq
 oyuE+JG/Owd38so2N10iTaxHuzlnylpwgR22rGuU7Jx8OF0/V8UzNr2ELwN45gE4Z4
 FjJMaj/NnpdHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/dpu: clear pending flush state before physical
 cleanup
To: "Saim Shujah" <saimzst@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826182459.1506522-1-saimzst@gmail.com>
References: <20260826182459.1506522-1-saimzst@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 18:38:28 +0000
Message-Id: <20260826183828.A8D0F1F00ADF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] dpu_hw_ctl_clear_pending_flush() fails to clear pending_periph_flu=
sh_mask, leaving stale peripheral flush state across encoder teardowns.
- [High] Sleeping function usleep_range() is called from display driver ato=
mic contexts during encoder cleanup.
--

commit 8f92b7c700308d037e1db8696d21fde498d38560
Author: Saim Shujah <saimzst@gmail.com>

drm/msm/dpu: clear pending flush state before physical cleanup

Hardware can consume an active-frame CTL flush while the cached software
pending-flush mask retains the submitted bits. The patch clears the cached
pending-flush bookkeeping before constructing the teardown state.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/dr=
m/msm/disp/dpu1/dpu_encoder.c
> index 1f20695f81e35..45189b6076bc4 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -2263,6 +2263,7 @@ void dpu_encoder_helper_phys_cleanup(struct dpu_enc=
oder_phys *phys_enc)
> =20
>  	dpu_enc =3D to_dpu_encoder_virt(phys_enc->parent);
> =20
> +	ctl->ops.clear_pending_flush(ctl);

[Severity: High]
This isn't a bug introduced by this patch, but does dpu_hw_ctl_clear_pendin=
g_flush()
leave stale peripheral flush state across encoder teardowns?

In drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c:dpu_hw_ctl_clear_pending_flus=
h():

	ctx->pending_flush_mask =3D 0x0;
	ctx->pending_intf_flush_mask =3D 0;
	ctx->pending_wb_flush_mask =3D 0;
	ctx->pending_cwb_flush_mask =3D 0;
	ctx->pending_merge_3d_flush_mask =3D 0;
	ctx->pending_dsc_flush_mask =3D 0;
	ctx->pending_cdm_flush_mask =3D 0;

	memset(ctx->pending_dspp_flush_mask, 0,
		sizeof(ctx->pending_dspp_flush_mask));

The function clears most software state caches, but ctx->pending_periph_flu=
sh_mask
is missed.

Because pending_periph_flush_mask is omitted from the clear operation, any
peripheral flush bits set from the previous active frame remain in the soft=
ware
cache. When the encoder is later re-enabled or flushed, this stale mask cou=
ld
be inadvertently flushed to the CTL_PERIPH_FLUSH hardware register, potenti=
ally
causing unexpected hardware states or hangs.

>  	ctl->ops.reset(ctl);

[Severity: High]
This is a pre-existing issue, but does this hardware cleanup execute a slee=
ping
polling path while in an atomic context?

dpu_encoder_helper_phys_cleanup() is called from the encoder atomic disable
callback. ctl->ops.reset(ctl) resolves to dpu_hw_ctl_reset_control(), which
polls the hardware and calls usleep_range():

drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c:dpu_hw_ctl_poll_reset_status():

		if (status)
			usleep_range(20, 50);

Calling sleeping functions like usleep_range() from atomic context paths in
display drivers can cause kernel warnings, system instability, and potential
deadlocks.

> =20
>  	dpu_encoder_helper_reset_mixers(phys_enc);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826182459.1506=
522-1-saimzst@gmail.com?part=3D1
