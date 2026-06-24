Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6FFCDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C50110E0F0;
	Wed, 24 Jun 2026 17:13:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WSmpmumi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD86510E0F0
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 17:13:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A36FB4081A;
 Wed, 24 Jun 2026 17:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7289C1F000E9;
 Wed, 24 Jun 2026 17:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782321186;
 bh=MAxsmdYZhVHMt8eN2QP3gJZQNrMcWOOtrDYe6vZNtdg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WSmpmumiJg0YAkZsX48wfacrlyLDqH+g4lzty3C5k7f2qZ51f1J/2NrRbced2fux+
 emYb11XQWV0CqL3u11dUTshjYk4/3b9uL5qnyBirEBXSkjk+kd1YT+3DoXUNMqXZ/O
 e6blJElSUNItEUE6MI52FKv9X2x170VgW2NZZ0OspI8xpIdRCAwVx18bCAsXT8jhJJ
 eDFdONKBtw9pNMU7+ms/xa2lbxWHLeQbf12C8qwIWQlLfeZYC2yEiADcnaBLk9kV/t
 4Qp1pGHGotXUmb4Pjpw7l9ZVso84kIk6yyMnqrG7xWL/Z+ZcTbvTM1Y1B8d84SRmTe
 jCpDUpwAFLy7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/10] drm/bridge: auto-link panel backlight in
 bridge connector
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624165751.2014759-10-mario.limonciello@amd.com>
References: <20260624165751.2014759-1-mario.limonciello@amd.com>
 <20260624165751.2014759-10-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 17:13:06 +0000
Message-Id: <20260624171306.7289C1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] NULL pointer dereference when calling drm_backlight_link() on an u=
nregistered connector
- [Medium] Unconditional overwrite of return value 'ret' ignores drm_backli=
ght_alloc() failures
- [Medium] Reference leak and WARN_ON if drm_connector_attach_encoder() fai=
ls
- [Low] Build failure due to missing static inline fallback for drm_panel_b=
ridge_to_panel()

Pre-existing issues:
- [High] Sleeping in atomic context when drm_backlight_link() sends a ueven=
t while holding a spinlock
--

commit 97d3e5fef0b8faac0a3e7bb0d3351e3d883fc3e8
Author: Mario Limonciello (AMD) <superm1@kernel.org>

drm/bridge: auto-link panel backlight in bridge connector

The link should allow clients to change luminance property.

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> # SM8150-HDK
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Tested-by: Simon Ser <contact@emersion.fr>

> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu=
/drm/display/drm_bridge_connector.c
> index 649969fca1413..23a3802294625 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
[ ... ]
> @@ -1051,9 +1053,20 @@ struct drm_connector *drm_bridge_connector_init(st=
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
> +		if (panel && panel->backlight) {
> +			ret =3D drm_backlight_alloc(connector);
> +			if (!ret)
> +				drm_backlight_link(connector->backlight,
> +						   panel->backlight);

[Severity: Medium]
If drm_backlight_alloc() returns an error code like -ENOMEM, is it safe to
ignore it?

The error code stored in 'ret' appears to be unconditionally overwritten by=
 the
subsequent call to drm_connector_attach_encoder(), silently ignoring the
allocation failure.

[Severity: High]
Can calling drm_backlight_link() here cause a kernel panic?

This links the backlight during connector initialization, before the connec=
tor
is registered to sysfs.

In drivers/gpu/drm/drm_backlight.c:drm_backlight_link():

	if (send_uevent)
		kobject_uevent_env(&b->connector->kdev->kobj, KOBJ_CHANGE,
				   (char **)ep);

If connector->kdev is NULL at this point, sending a uevent could dereference
an invalid pointer.

[Severity: High]
This is a pre-existing issue, but does drm_backlight_link() sleep while
holding a spinlock?

In drivers/gpu/drm/drm_backlight.c:drm_backlight_link():

	guard(spinlock)(&drm_backlight_lock);
	send_uevent =3D __drm_backlight_link(b, bd);

	if (send_uevent)
		kobject_uevent_env(&b->connector->kdev->kobj, KOBJ_CHANGE,
				   (char **)ep);

The lock is held across the entire function scope, including the
kobject_uevent_env() call, which can allocate memory with GFP_KERNEL and
sleep. Could this trigger a 'scheduling while atomic' BUG?

> +		}
> +	}
> +
>  	if (support_hdcp && IS_REACHABLE(CONFIG_DRM_DISPLAY_HELPER) &&
>  	    IS_ENABLED(CONFIG_DRM_DISPLAY_HDCP_HELPER))
>  		drm_connector_attach_content_protection_property(connector, true);

[Severity: Medium]
If drm_connector_attach_encoder() fails just after this block, does this le=
ak
a reference to the backlight_device and trigger a WARN_ON?

This error path bails out without unlinking the backlight that was successf=
ully
linked above:

	ret =3D drm_connector_attach_encoder(connector, encoder);
	if (ret)
		return ERR_PTR(ret);

Because the connector was never registered, the link is never released. When
drm_connector_cleanup() runs, it might hit WARN_ON(b->link) and free the
structure without dropping the reference.

> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 4ba3a5deef9a6..6311ca726b45f 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
[ ... ]
> @@ -1586,6 +1586,7 @@ void drm_bridge_hpd_notify(struct drm_bridge *bridg=
e,
> =20
>  #ifdef CONFIG_DRM_PANEL_BRIDGE
>  bool drm_bridge_is_panel(const struct drm_bridge *bridge);
> +struct drm_panel *drm_panel_bridge_to_panel(struct drm_bridge *bridge);

[Severity: Low]
Will this cause a build failure when CONFIG_DRM_PANEL_BRIDGE is disabled?

The function declaration lacks a static inline fallback when the config is
disabled, which might cause an implicit function declaration error when cal=
led
unconditionally in drm_bridge_connector_init().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624165751.2014=
759-1-mario.limonciello@amd.com?part=3D9
