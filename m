Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98AA4C5DF74
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 02:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D455A10E9B0;
	Tue, 18 Aug 2026 02:13:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h0CJXt0e";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BA1F10E496
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 02:13:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AA4A04002F;
 Tue, 18 Aug 2026 02:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612481F000E9;
 Tue, 18 Aug 2026 02:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787019221;
 bh=RpDn1uZU+xSRAG9bjWHO1zGkiecu11k38OwMgZoig6s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h0CJXt0edV3g0ilJGk+5gYs7ZHB/Wrpfjfq/qR2noFSfo0a8SKo6mdmwuVAb5ovNz
 zuE5UQVPrFVPps9QqGqE2RQG3rGvrHajNxNnrsUlDr4nfZnDpiQ0PL6tg0N3IjkAq6
 DJfj071NwWkgz5Vde1Hk4LLbOMZnAG5jFx8EymLgvhig6dcPMj86oZpere9DVhbhTC
 8dM0k5eRJFslS8cIuPqFg1yFCXXQE0klWvB2yymDssW/mLQn0BWJ7HkJLa8FMVsl3K
 6oPSJ00X6upBAuxHQKBxbPdYVz+2vEQHsOpQd7yJbrF3xNXcdTSCjvoUeATTeAuMh5
 9/YU3wQxuqmsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm: anx7625: add I2S input stream right justified
 control
To: "Xin Ji" <xji@analogixsemi.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260818020559.961335-2-xji@analogixsemi.com>
References: <20260818020559.961335-1-xji@analogixsemi.com>
 <20260818020559.961335-2-xji@analogixsemi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 02:13:40 +0000
Message-Id: <20260818021341.612481F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Bypassing standard ALSA HDMI codec DAI format negotiation.
- [Medium] RIGHT_JUSTIFY_CTRL bit is conditionally set but never cleared.

Pre-existing issues:
- [High] Use-After-Free due to interrupt firing after workqueue destruction.
--

--- Patch [2]: [PATCH 2/2] drm: anx7625: add I2S input stream right justifi=
ed control ---
commit e78186b015f668998903e293729ea71c5bebfbd8
Author: Xin Ji <xji@analogixsemi.com>

drm: anx7625: add I2S input stream right justified control

The default audio data stream is left justify. When the
property "analogix,audio-right-justify-enable" is detected,
the code enables right justify.

> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/=
bridge/analogix/anx7625.c
> index fffcd6154c710..d00aa6ea7273d 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c

[ ... ]

> @@ -2083,6 +2086,12 @@ static int anx7625_audio_hw_params(struct device *=
dev, void *data,
>  		ret |=3D anx7625_write_and(ctx, ctx->i2c.tx_p2_client,
>  				AUDIO_CHANNEL_STATUS_6, ~AUDIO_LAYOUT);
> =20
> +	/* Right justified */
> +	if (ctx->pdata.audio_right_justify)

[Severity: Medium]
Instead of bypassing standard ALSA HDMI codec DAI format negotiation,
should this code check the standard fmt->fmt parameter for HDMI_RIGHT_J?

When the driver receives HDMI_RIGHT_J via hdmi_codec_daifmt->fmt at the
start of anx7625_audio_hw_params(), it rejects it with -EINVAL. Relying
on a custom static DT property breaks compatibility with generic ALSA
sound cards that dynamically negotiate the DAI format.

[Severity: Medium]
Is there a missing clear operation for this bit?

If a bootloader or previous kernel execution left the RIGHT_JUSTIFY_CTRL
bit set, and ctx->pdata.audio_right_justify is false, the hardware will
remain in right-justified mode even when standard I2S is expected. Should
there be an anx7625_write_and() to clear the bit on the false path?

> +		ret |=3D anx7625_write_or(ctx, ctx->i2c.tx_p2_client,
> +					AUDIO_CONTROL_REGISTER,
> +					RIGHT_JUSTIFY_CTRL);
> +
>  	/* FS */
>  	switch (params->sample_rate) {
>  	case 32000:

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but does the driver have a
use-after-free vulnerability during unbind?

In anx7625_i2c_remove(), the workqueue is destroyed before the interrupt is
disabled:

	if (platform->pdata.intp_irq)
		destroy_workqueue(platform->workqueue);

Because the driver uses devm_request_threaded_irq(), the interrupt is
only freed after remove() returns. If an interrupt (like Hot Plug Detect)
fires after destroy_workqueue(), the ISR anx7625_intr_hpd_isr() will
attempt to use it:

	queue_work(ctx->workqueue, &ctx->work);

Should disable_irq() be called before destroying the workqueue to prevent
the ISR from dereferencing the freed workqueue pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818020559.9613=
35-1-xji@analogixsemi.com?part=3D2
