Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5023C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 16:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22DA610E5BC;
	Mon,  3 Aug 2026 16:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nVvtRmN3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BAEE10E5BC
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:33:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2177960A60;
 Mon,  3 Aug 2026 16:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAC41F000E9;
 Mon,  3 Aug 2026 16:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785774821;
 bh=S4XWqEvwIJW8yYn3VBhpGSI/Zryxk7Egi2STk3Nq/n0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nVvtRmN3yjLgDSVmyikiSAxxOVMjBIXsLjmi7XvE8XrrjH06/AIFsjM/OJJMT14e6
 kag7+zXnbDFBF4qcKQ41/Pd1sCZS7pp8hJRZxPBnTjTZAj3FMYKTAO5RRjlPGXljXo
 WXlxho3flSxTsnJIeVCbAKbpONB9f0Qn202FrfCxLU3lkQULgYeho1c9gIXcM1GRln
 GflqcHIGK8FOSZLjWf9vjnyDbq6aRTTE7Ha+eGcbBFEN8b4+KWZpFlA7daBC7pN/Y1
 Vb/g54qTFSuQ7umrPB5NX1jQScaOmpeSb/443jgBUwVWPA4HKblklMs8q0aKdIgR8/
 NyQdEPymQQB6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/13] drm/sun4i: hdmi: Don't leak sync polarity bits
 into packet control
To: "Jernej Skrabec" <jernej.skrabec@gmail.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <51ba0918ce016a4b45313d5df1b6ce31b8c8731e.1785772659.git.jernej.skrabec@gmail.com>
References: <cover.1785772659.git.jernej.skrabec@gmail.com>
 <51ba0918ce016a4b45313d5df1b6ce31b8c8731e.1785772659.git.jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 16:33:41 +0000
Message-Id: <20260803163341.AEAC41F000E9@smtp.kernel.org>
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
- [High] Encoder atomic enable callback calls functions that can sleep.
--

--- Patch [7]: [PATCH 07/13] drm/sun4i: hdmi: Don't leak sync polarity bits=
 into packet control ---
commit 65d502c65ade8ff425b6b395888cc0a59bbbb7c3
Author: Jernej Skrabec <jernej.skrabec@gmail.com>

drm/sun4i: hdmi: Don't leak sync polarity bits into packet control

This commit fixes an issue where stale sync polarity bits were ORed into the
packet control register. It replaces the OR assignment with a direct
assignment to prevent selecting incorrect packet types.

> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun=
4i/sun4i_hdmi_enc.c
> index e99f52ebb26f0..97253d631b2bd 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> @@ -160,7 +160,7 @@ static void sun4i_hdmi_enable(struct drm_encoder *enc=
oder,
> =20
>  	drm_atomic_helper_connector_hdmi_update_infoframes(connector, state);

[Severity: High]
This isn't a bug introduced by this patch, but does this code sleep in an
atomic context?

The sun4i_hdmi_enable() function is registered as an encoder atomic enable
callback, which executes in an atomic context during non-blocking commits.
However, it calls drm_atomic_helper_connector_hdmi_update_infoframes() here,
which explicitly acquires a mutex. It also calls clk_prepare_enable() just
above this snippet, which can sleep.

Could calling these sleeping functions during atomic commit paths cause
kernel warnings or potential deadlocks?

> -	val |=3D SUN4I_HDMI_PKT_CTRL_TYPE(0, SUN4I_HDMI_PKT_AVI);
> +	val =3D SUN4I_HDMI_PKT_CTRL_TYPE(0, SUN4I_HDMI_PKT_AVI);
>  	val |=3D SUN4I_HDMI_PKT_CTRL_TYPE(1, SUN4I_HDMI_PKT_END);
>  	writel(val, hdmi->base + SUN4I_HDMI_PKT_CTRL_REG(0));
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785772659.gi=
t.jernej.skrabec@gmail.com?part=3D7
