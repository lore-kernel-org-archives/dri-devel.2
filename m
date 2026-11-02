Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F885606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nP9UwEEm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A94610F13A;
	Mon,  2 Nov 2026 18:25:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96F7A10F131;
 Mon,  2 Nov 2026 18:24:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 50C8D4392C;
 Mon,  2 Nov 2026 18:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC29A1F00A16;
 Mon,  2 Nov 2026 18:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793643896;
 bh=D9T5jJuN48XjdnDFeq15ajMmBUA9HDTixTlnifoT0qg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nP9UwEEmlncJWnArkadAKWfEoPxxpWFj2jJ26Vr0QylqZ+SHX2yjPfLGLSNnT8suU
 d4ii6BWREznfnlYMjnfkLtTCfEMLpNGug2cBvRY1v9rLxJHxFMby+l5tWxgH697/wU
 To5xkmA/lbMqMP8xohLM4N0ox24mEaEF3Rgqyjlp2ySxeM6JgAoI/+1vOK3XllYcii
 x8SPCrk1Zwxf4qbmPEBCUPK95cVLIxGIFCgWQgWdi+FP83fbMhWIOMtyVtjvS58DXQ
 COjnZjJR+6E+WbcJdWphkAYCZVgZDloie8sG6um2WCc4YY+P7MEmOnfiqDmmOD9h5L
 77F6am3vTnmgg==
Message-ID: <sashiko-outbox-193932@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 07/15] drm/bridge: add connector luminance operations
To: =?utf-8?b?TWFyaW8gTGltb25jaWVsbG8gKEFNRCk=?= <superm1@kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261102-superm1-backlight-property-v10-7-b2a6f24131f5@kernel.org>
References: <20261102-superm1-backlight-property-v10-0-b2a6f24131f5@kernel.org>
 <20261102-superm1-backlight-property-v10-7-b2a6f24131f5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:24:55 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drm/bridge: rebase artifact in drm_bridge.h causes redefinition bui=
ld failure
--

commit 13f21a6ed9ffad8454f947df0968b7d42361d36f
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/bridge: add connector luminance operations

This commit adds a set_luminance callback, DRM_BRIDGE_OP_LUMINANCE flag, and
relative luminance fields to struct drm_bridge so bridges that control panel
brightness can advertise luminance operations.

> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 1981d24a700d2..95f5c2b8656cd 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h

[ ... ]

> @@ -1522,6 +1542,60 @@ void drm_bridge_hpd_disable(struct drm_bridge *bri=
dge);
>  void drm_bridge_hpd_notify(struct drm_bridge *bridge,
>  			   enum drm_connector_status status);
> =20
> +#ifdef CONFIG_DRM_PANEL_BRIDGE
> +bool drm_bridge_is_panel(const struct drm_bridge *bridge);
> +struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel);
> +struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
> +					      u32 connector_type);
> +void drm_panel_bridge_remove(struct drm_bridge *bridge);
> +int drm_panel_bridge_set_orientation(struct drm_connector *connector,
> +				     struct drm_bridge *bridge);
> +struct drm_bridge *devm_drm_panel_bridge_add(struct device *dev,
> +					     struct drm_panel *panel);
> +struct drm_bridge *devm_drm_panel_bridge_add_typed(struct device *dev,
> +						   struct drm_panel *panel,
> +						   u32 connector_type);
> +struct drm_bridge *drmm_panel_bridge_add(struct drm_device *drm,
> +					     struct drm_panel *panel);
> +struct drm_connector *drm_panel_bridge_connector(struct drm_bridge *brid=
ge);
> +#else
> +static inline bool drm_bridge_is_panel(const struct drm_bridge *bridge)
> +{
> +	return false;
> +}
> +
> +static inline int drm_panel_bridge_set_orientation(struct drm_connector =
*connector,
> +						   struct drm_bridge *bridge)
> +{
> +	return -EINVAL;
> +}
> +
> +#endif
> +
> +#if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL_BRIDGE)
> +struct drm_bridge *devm_drm_of_get_bridge(struct device *dev, struct dev=
ice_node *node,
> +					  u32 port, u32 endpoint);
> +struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm, struct dev=
ice_node *node,
> +					  u32 port, u32 endpoint);
> +#else
> +static inline struct drm_bridge *devm_drm_of_get_bridge(struct device *d=
ev,
> +							struct device_node *node,
> +							u32 port,
> +							u32 endpoint)
> +{
> +	return ERR_PTR(-ENODEV);\n> +}
> +
> +static inline struct drm_bridge *drmm_of_get_bridge(struct drm_device *d=
rm,
> +						     struct device_node *node,
> +						     u32 port,
> +						     u32 endpoint)
> +{
> +	return ERR_PTR(-ENODEV);\n> +}
> +#endif
> +
> +void devm_drm_put_bridge(struct device *dev, struct drm_bridge *bridge);

[Severity: Low]
Was this hunk included by mistake during a rebase or patch split?

Prior to this series, commit aa8a8c7e4641 ("drm/bridge: panel: move all code
to drm_panel.c") moved the CONFIG_DRM_PANEL_BRIDGE and CONFIG_OF panel-brid=
ge
declarations and their #else static inline fallback definitions from
include/drm/drm_bridge.h into include/drm/drm_panel.h, and commit 51afe16e3=
3a0
("drm/bridge: remove devm_drm_put_bridge()") removed devm_drm_put_bridge().

Because include/drm/drm_panel.h includes drm/drm_bridge.h and already defin=
es
those same static inline functions in its #else branches:

include/drm/drm_panel.h:
    #ifdef CONFIG_DRM_PANEL_BRIDGE
    bool drm_bridge_is_panel(const struct drm_bridge *bridge);
    ...
    #else
    static inline bool drm_bridge_is_panel(const struct drm_bridge *bridge)
    {
        return false;
    }

    static inline int drm_panel_bridge_set_orientation(struct drm_connector=
 *connector,
                                                       struct drm_bridge *b=
ridge)
    {
        return -EINVAL;
    }
    #endif

    #if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL_BRIDGE)
    ...
    #else
    static inline struct drm_bridge *devm_drm_of_get_bridge(...)
    ...
    static inline struct drm_bridge *drmm_of_get_bridge(...)
    ...
    #endif

does re-adding this block in include/drm/drm_bridge.h cause redefinition bu=
ild
failures in translation units that include drm/drm_panel.h (such as
drivers/gpu/drm/display/drm_bridge_connector.c, drivers/gpu/drm/drm_panel.c,
and drivers/gpu/drm/drm_of.c) when CONFIG_OF or CONFIG_DRM_PANEL_BRIDGE is
disabled?

Although a subsequent patch in the series, commit 3eac0878c8a6 ("drm/panel:
add connector luminance forwarding"), removes the #else static inline stubs
and the CONFIG_OF block from include/drm/drm_panel.h, this breaks bisection=
 at
this commit and leaves the misplaced panel-bridge and OF bridge declarations
along with the deleted devm_drm_put_bridge() prototype in
include/drm/drm_bridge.h.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-superm1-ba=
cklight-property-v10-0-b2a6f24131f5@kernel.org?part=3D7
