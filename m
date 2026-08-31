Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09D1C624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 23:24:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C21C510E361;
	Mon, 31 Aug 2026 23:24:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cZON4xMp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1270310E353;
 Mon, 31 Aug 2026 23:24:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A690440446;
 Mon, 31 Aug 2026 23:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CC91F000E9;
 Mon, 31 Aug 2026 23:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788218661;
 bh=Un61TF2wU7icO/ENvcHa2TKcqzKeJeRU1OFUqRlE/m8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cZON4xMpLnvqIoJ9rwQIehRWs+ZScnmDhsafhrJ/crLw794a/a/7WeR9Hg0IFg1GJ
 yfEB8zwwBCBTvphdu/oCZKRdZBc4/3Ig9+nhlSMROPAfaFwE5+B8rtIs6yOG4TewJu
 GTapLWWy2lDt+nFVrnHycMc9Y9/3LA5WhQxXNYdTYaGjTaxdJYFgyRPU3fmlCHG4yR
 46AzxqV2rJpQQoyejnfRfuGklmu7QjMYlHeiaABrJKk/5TDVtb8D9CWw1eWB19CHSQ
 IjsrmBsjaO9gVDVRqffKJgfRqeSSuTUHuJzQuz0CnNyCuIttImgg5pEMHxTsNkXbIl
 3bMDDc1+gbs1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/12] drm/bridge: auto-link panel backlight in
 bridge connector
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260831210531.2334221-10-mario.limonciello@amd.com>
References: <20260831210531.2334221-1-mario.limonciello@amd.com>
 <20260831210531.2334221-10-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 23:24:20 +0000
Message-Id: <20260831232421.42CC91F000E9@smtp.kernel.org>
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
- [High] Missing cleanup of `drm_backlight_link()` on probe error paths cau=
ses a Use-After-Free on a global list and a reference leak.
--

commit a0dd986fcfc01d36a6bb91afe25a294e80d0f4e6
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/bridge: auto-link panel backlight in bridge connector

This commit links a panel's backlight_device to the bridge connector so
luminance-aware clients can drive it through the LUMINANCE property.

> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu=
/drm/display/drm_bridge_connector.c
> index 8b54069fa53a4..d4b4e59cea51c 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
[ ... ]
> @@ -1082,9 +1084,16 @@ struct drm_connector *drm_bridge_connector_init(st=
ruct drm_device *drm,
>  		connector->polled =3D DRM_CONNECTOR_POLL_CONNECT
>  				  | DRM_CONNECTOR_POLL_DISCONNECT;
> =20
> -	if (panel_bridge)
> +	if (panel_bridge) {
> +		struct drm_panel *panel;
> +
>  		drm_panel_bridge_set_orientation(connector, panel_bridge);
> =20
> +		panel =3D drm_panel_bridge_to_panel(panel_bridge);
> +		if (panel && panel->backlight)
> +			drm_backlight_link(connector, panel->backlight);

[Severity: High]
Does this cause a use-after-free and a reference leak on probe error paths?

During early initialization here, drm_backlight_link() links the connector's
backlight to the global list. If the driver's probe function subsequently
fails before calling drm_dev_register() (e.g., due to EPROBE_DEFER or
hardware errors), the device is never registered.

Because drm_connector_unregister() is never called in this error path, the
backlight is not unlinked. Later, when drmm managed cleanup runs
drm_connector_cleanup(), it calls drm_backlight_connector_cleanup().

Looking at drm_backlight_connector_cleanup():

void drm_backlight_connector_cleanup(struct drm_connector *connector)
{
	struct drm_backlight *b =3D &connector->backlight;

	WARN_ON(__drm_backlight_is_linked(b));
	WARN_ON(b->funcs);
	WARN_ON(b->luminance_clients);
}

This function only warns and does not actually unlink the backlight. The
connector is then freed, leaving a dangling pointer in the global
drm_backlight_list. Iterating this global list later (e.g., during backlight
brightness changes) could dereference the freed connector memory.

> +	}
> +
>  	if (support_hdcp && IS_REACHABLE(CONFIG_DRM_DISPLAY_HELPER) &&
>  	    IS_ENABLED(CONFIG_DRM_DISPLAY_HDCP_HELPER))
>  		drm_connector_attach_content_protection_property(connector, true);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831210531.2334=
221-1-mario.limonciello@amd.com?part=3D9
