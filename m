Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260EBC55174
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57DBF10F3B9;
	Fri, 31 Jul 2026 18:31:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S669h1iW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B614310F3B3
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 18:31:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D9C6B600C3;
 Fri, 31 Jul 2026 18:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695A81F00AC4;
 Fri, 31 Jul 2026 18:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785522701;
 bh=vkl4mNUOmfBTL0RLtoKzHBw73Pl5gzZLcFculT6MCkc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S669h1iWmnBBTVF1vRff3jzyATBudFbYvFSdjS8b6kbqWFo1JQfI+PHj47VoZOQiT
 vrfXjNYMA/uwBPiPb8mRd9irPW6byTZZrD4BxMaKWVdikEeo0NLFc/f2CE4987Q/EF
 Jinugi2M/5x5PkVQhY7rOpPJc5Mxur4F/W3TpLtJXYSdrOTtmuwv++DEhY3OSDL9AN
 lXFi1MJmU3KwsZ4YBjoOOY2CQCNyJ4raPtXohWcfGR1jbbj3ByaoqWtTymKsZHrAu8
 vHtPj/bQ0K6rnvqY3JLkv/vVuPH+5dBgfz/mBMWMrtU2/+VvUa1baSs1SCMF0C5m2o
 PA8yYAV7yot3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 18/69] drm/display: bridge_connector: Switch to
 .force_ctx() connector helper
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-18-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-18-294364b2cf15@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 18:31:41 +0000
Message-Id: <20260731183141.695A81F00AC4@smtp.kernel.org>
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
- [Low] The patch replaces `drm_bridge_connector_force()` with `drm_bridge_=
connector_force_ctx()` and calls `drm_atomic_helper_connector_hdmi_force_ct=
x()`. However, `drm_atomic_helper_connector_hdmi_force_ctx()` is neither de=
fined nor declared anywhere in the kernel tree. This results in an implicit=
 function declaration error and undefined reference during linking.
--

--- Patch [18]: [PATCH v10 18/69] drm/display: bridge_connector: Switch to =
.force_ctx() connector helper ---
commit 01a7e2cca1b495d499fd78712842111769ad4146
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
drm/display: bridge_connector: Switch to .force_ctx() connector helper

This commit replaces the drm_bridge_connector_force() function with a
.force_ctx() implementation. It hands the acquire context over to
drm_atomic_helper_connector_hdmi_force_ctx() for HDMI connectors.

> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu=
/drm/display/drm_bridge_connector.c
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c

[ ... ]

> @@ -322,6 +311,19 @@ static int drm_bridge_connector_detect_ctx(struct dr=
m_connector *connector,
>  	return status;
>  }
> =20
> +static int drm_bridge_connector_force_ctx(struct drm_connector *connecto=
r,
> +					  struct drm_modeset_acquire_ctx *ctx)
> +{
> +	struct drm_bridge_connector *bridge_connector =3D
> +		to_drm_bridge_connector(connector);
> +	struct drm_bridge *hdmi =3D bridge_connector->bridge_hdmi;
> +
> +	if (hdmi)
> +		return drm_atomic_helper_connector_hdmi_force_ctx(connector, ctx);

[Severity: Low]
It appears drm_atomic_helper_connector_hdmi_force_ctx() is not declared=20
anywhere in the kernel tree prior to being used here.

Could this result in an implicit function declaration error and an undefined
reference during linking when building with DRM display bridge connector=20
support enabled? Is it possible a prerequisite patch introducing this=20
helper was omitted from the series?

> +
> +	return 0;
> +}
> +

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-dw-hdmi-qp=
-scramb-v10-0-294364b2cf15@collabora.com?part=3D18
