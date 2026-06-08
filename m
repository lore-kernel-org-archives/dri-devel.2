Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E93CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AF3510F735;
	Mon,  8 Jun 2026 16:43:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MBOdKXl7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 951CE10F735
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:43:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 73C10417AF
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389731F00898;
 Mon,  8 Jun 2026 16:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780937006;
 bh=hJigngcjt0m+NLB4wdE5s4PMQ8UQFTaw3J5QDxGptwM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MBOdKXl7gpgTDRjIbPUaog33JQImFjLsmBUryUrGIt191fNSwUTYBcTHFT6jBpJoV
 WzqRXw1DjwdmG/IGNAXgt4FDpWhLPZ7Ob90eOkxiYLo7BPjBP31gxJEem9DzfLXfZu
 SlzJZ27yAzLOPZd9YM08hs4nD0WYVqduBNO9nNBDpWtWIxylal9tkrqfk+t6MuZerL
 hySmA8DIU4BEvWv5IvRAN9Dvhzk5XBlaQH7kkBjXxCYH0XU2wB7fh0Qvx9sTbPgaUL
 vX2OQrS7Kv5L/q4LhQuV0uC/xKxnEYus3AUd3N9NiY4TXtOduOVtMP3Ln0jZkOdePY
 4NhpJOfTAlqJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 34/78] drm/bridge: dw-hdmi-qp: Switch to
 atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-34-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-34-0a91018bf886@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:43:25 +0000
Message-Id: <20260608164326.389731F00898@smtp.kernel.org>
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
- [High] Misuse of `devm_*` allocators in component bind and initialization=
 paths leads to resource leaks and Use-After-Free on unbind/rebind cycles.
--

commit 17f25cb35afad5d43662041d4b770c5036dbd7aa
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: dw-hdmi-qp: Switch to atomic_create_state

The drm_bridge_funcs.atomic_reset callback and its
drm_atomic_helper_bridge_reset() helper are deprecated.

Switch to the atomic_create_state callback and its
drm_atomic_helper_bridge_create_state() counterpart.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/d=
rm/bridge/synopsys/dw-hdmi-qp.c
> index 1c214a8e6dc2d..a5217574c77e7 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> @@ -1192,7 +1192,7 @@ static int dw_hdmi_qp_cec_transmit(struct drm_bridg=
e *bridge, u8 attempts,
>  static const struct drm_bridge_funcs dw_hdmi_qp_bridge_funcs =3D {
>  	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> -	.atomic_reset =3D drm_atomic_helper_bridge_reset,
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
>  	.atomic_enable =3D dw_hdmi_qp_bridge_atomic_enable,
>  	.atomic_disable =3D dw_hdmi_qp_bridge_atomic_disable,
>  	.detect =3D dw_hdmi_qp_bridge_detect,

[Severity: High]
This isn't a bug introduced by this patch, but does the component bind logic
leak resources on unbind/rebind cycles?

In dw_hdmi_qp_bind(), devm_drm_bridge_alloc() is tied to the platform devic=
e,
which means resources are not released during unbind:

	hdmi =3D devm_drm_bridge_alloc(dev, struct dw_hdmi_qp, bridge,
				     &dw_hdmi_qp_bridge_funcs);

If the DRM master is unbound and re-bound, could this reallocate memory and=
 lead
to leaks?

Additionally, in dw_hdmi_qp_cec_init(), devm_request_threaded_irq() registe=
rs the
CEC interrupt handler tied to the platform device instead of the connector:

	return devm_request_threaded_irq(hdmi->dev, cec->irq,
					 dw_hdmi_qp_cec_hardirq,
					 dw_hdmi_qp_cec_thread, IRQF_SHARED,
					 dev_name(hdmi->dev), hdmi);

When the DRM master is unbound, the DRM connector is freed, but the interru=
pt
handler remains active. If a CEC interrupt fires after unbind, will it
dereference the freed connector and cause a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-drm-no-mor=
e-bridge-reset-v2-0-0a91018bf886@kernel.org?part=3D34
