Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0E9C55172
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 22:44:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3750510E042;
	Fri, 31 Jul 2026 22:44:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wk5DSJDj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E15D210E042
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 22:44:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 82F724073C;
 Fri, 31 Jul 2026 22:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F99F1F00AC4;
 Fri, 31 Jul 2026 22:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785537845;
 bh=PYj5RSrA82FadPcJOA5SkkisXBt5WHsg/tOlTodLmQk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Wk5DSJDjBwxk4jUGRarcGWU0/kf3KwP/fljij2cV5r80r0bi0eS+jKQ3aXb6tBxzv
 R8h1foxn/O23XqHC3B3JMb9FShM2SdB/Rg/glL8m0zXplURXf9oRsp5JJDXLUSC8a7
 dYidqCya/sfgOt2z6na4oQpHDJUZqmlpkVDrqMwVjTU+doTU3S0NoL9Fj4sXSfXtyZ
 PE92HBmX0Hphur9TU/O+HvVM2aTgkoLiLyDhQsiaQisP7s5Uf8t95xtXCBT7v5OYPR
 xvWlaf6C/UnKoImHkaquuS9w5z8/CojFxn0AQFVUAqEC4t8kpACu7gg2TNe8kd8kik
 jb6B0IbuUthqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 45/69] drm/vc4: hdmi: Convert to common HDMI 2.0
 scrambling infrastructure
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-45-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-45-294364b2cf15@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 22:44:04 +0000
Message-Id: <20260731224405.3F99F1F00AC4@smtp.kernel.org>
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

New issues:
- [Medium] Spurious CRTC reset at boot breaking fastboot / seamless display=
 takeover.

Pre-existing issues:
- [High] Atomic Context Violation due to sleeping functions in encoder call=
backs.
--

--- Patch [45]: [PATCH v10 45/69] drm/vc4: hdmi: Convert to common HDMI 2.0=
 scrambling infrastructure ---
commit 1688ee272699db4262a5b9b8449734034531bbd5
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/vc4: hdmi: Convert to common HDMI 2.0 scrambling infrastructure

Replace driver local scrambling logic with the newly introduced common
HDMI 2.0 scrambling support.

> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdm=
i.c
> index d599957fee3ac..ec0c1f4224d75 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c

[ ... ]

> @@ -534,6 +409,14 @@ static int vc4_hdmi_connector_init(struct drm_device=
 *dev,
> =20
>  	drm_connector_helper_add(connector, &vc4_hdmi_connector_helper_funcs);
> =20
> +	/*
> +	 * Since we don't know the state of the controller and its
> +	 * display (if any), let's assume it's always enabled.
> +	 * drm_connector_hdmi_disable_scrambling() will thus run at boot,
> +	 * make sure it's disabled, and avoid any inconsistency.
> +	 */
> +	connector->hdmi.scrambler_enabled =3D drm_connector_hdmi_scrambler_supp=
orted(connector);

[Severity: Medium]
Will this cause an unnecessary full modeset and visual flicker at boot,
breaking fastboot seamless display takeover?

By unconditionally forcing the scrambler_enabled state to true here, when
vc4_hdmi_connector_detect_ctx() handles the initial detection, it calls
drm_atomic_helper_connector_hdmi_hotplug() which in turn invokes
drm_connector_hdmi_sync_scdc().

If the sink does not have scrambling currently active (for example, because
the bootloader set a 1080p mode that does not require it), the sync_scdc
helper will detect a mismatch between this spoofed driver state and the
actual sink state, forcing a CRTC reset.

[ ... ]

> @@ -890,7 +724,7 @@ static void vc4_hdmi_encoder_post_crtc_disable(struct=
 drm_encoder *encoder,
>  		spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
>  	}
> =20
> -	vc4_hdmi_disable_scrambling(encoder);
> +	drm_connector_hdmi_disable_scrambling(&vc4_hdmi->connector);

[Severity: High]
This isn't a bug introduced by this patch, but can this cause scheduling
while atomic warnings and potential deadlocks?

The encoder post_crtc_disable callback executes in atomic context during
display commits where sleeping is forbidden. However, this calls
drm_connector_hdmi_disable_scrambling(), which performs blocking operations
such as cancel_delayed_work_sync() and I2C transfers.

[ ... ]

> @@ -1666,7 +1501,9 @@ static void vc4_hdmi_encoder_post_crtc_enable(struc=
t drm_encoder *encoder,
>  	}
> =20
>  	vc4_hdmi_recenter_fifo(vc4_hdmi);
> -	vc4_hdmi_enable_scrambling(encoder);
> +
> +	conn_state =3D drm_atomic_get_new_connector_state(state, connector);
> +	drm_connector_hdmi_enable_scrambling(connector, conn_state);

[Severity: High]
This is a pre-existing issue, but similar to the disable path above, does
calling drm_connector_hdmi_enable_scrambling() here violate the atomic
context of the post_crtc_enable callback?

The generic scrambler setup performs blocking I2C operations, which can lead
to system instability or scheduling while atomic warnings when called from
this context.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-dw-hdmi-qp=
-scramb-v10-0-294364b2cf15@collabora.com?part=3D45
