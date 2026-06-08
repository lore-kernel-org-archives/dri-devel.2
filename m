Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3471CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:24:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C37010F5C2;
	Mon,  8 Jun 2026 15:24:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gShwN8n3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE62410F5C2
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 15:24:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A76E543D82
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 15:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0B01F00898;
 Mon,  8 Jun 2026 15:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780932268;
 bh=ULO1+hx9jNGp/tWKflWbTyAGEPDZRa90GT/gQF+dc3Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gShwN8n3Ooi4xnAgnhTr9xyOZNiJj8Px7Hj/N9VzBnGOnoCmHUzzY8oOgXoRLg9hn
 8d75mbmY9B1bKJSMXux7pDyBQ4TLxr5Fz6MCEPAHpLF42zPWtx5+X/cRd49hM/Fb/x
 XvZhdf5w831tcQE1YWLyGR+YZtorb0oymnbSLcYoJbWItC+pK0+6udDRyeT9Lzg/L4
 JoSw0059ABo46r1EeDWLUkpCiTK7sTFEqDBqd0SSC3pWuBniEt8cK1JIKFmpAtkWqt
 GyYJK1c0BjliYY2bhbpy0f6mEk4AcCPLsFjwq9SwP+uIHnRaNT/5uXLsu3NkMnS93d
 YKMDC4dje8XXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/78] drm/bridge: adv7511: Switch to
 atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-8-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-8-0a91018bf886@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:24:27 +0000
Message-Id: <20260608152428.6C0B01F00898@smtp.kernel.org>
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
- [High] The HPD workqueue (adv7511->hpd_work) is not cancelled when the dr=
iver is unbound or fails to probe after the IRQ is registered, leading to a=
 Use-After-Free.
--

commit 27fb30e849a482fc0f7d55469140b878f0a937a9
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: adv7511: Switch to atomic_create_state

This commit deprecates the drm_bridge_funcs.atomic_reset callback and its
helpers. It switches the adv7511 bridge driver to use atomic_create_state
and drm_atomic_helper_bridge_create_state instead.

> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/d=
rm/bridge/adv7511/adv7511_drv.c
> index 02f8f7e78a163..db99e252aeebc 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -1004,7 +1004,7 @@ static const struct drm_bridge_funcs adv7511_bridge=
_funcs =3D {
>  	.atomic_disable =3D adv7511_bridge_atomic_disable,
>  	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> -	.atomic_reset =3D drm_atomic_helper_bridge_reset,
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
> =20
>  	.hdmi_tmds_char_rate_valid =3D adv7511_bridge_hdmi_tmds_char_rate_valid,

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a pre-existing
issue in this driver's error handling and removal paths regarding the HPD
workqueue.

In adv7511_probe(), an IRQ handler is registered via
devm_request_threaded_irq() which can schedule adv7511->hpd_work. If the
probe fails after this point, the error path does not cancel the work
before returning:

drivers/gpu/drm/bridge/adv7511/adv7511_drv.c:adv7511_probe() {
...
err_unregister_audio:
	drm_bridge_remove(&adv7511->bridge);
	i2c_unregister_device(adv7511->i2c_cec);
...
}

Similarly, adv7511_remove() does not cancel the work either:

drivers/gpu/drm/bridge/adv7511/adv7511_drv.c:adv7511_remove() {
	struct adv7511 *adv7511 =3D i2c_get_clientdata(i2c);

	of_node_put(adv7511->host_node);

	adv7511_uninit_regulators(adv7511);

	drm_bridge_remove(&adv7511->bridge);
...
}

Because devres eventually frees the IRQ but free_irq() does not cancel
already scheduled work, could this lead to a use-after-free?

If the work remains pending after the final reference to the adv7511
structure is dropped, any executing adv7511_hpd_work() would dereference
the freed memory.

Should cancel_work_sync(&adv7511->hpd_work) be called in these paths to
prevent the work from executing after the structure is freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-drm-no-mor=
e-bridge-reset-v2-0-0a91018bf886@kernel.org?part=3D8
