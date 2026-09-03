Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD48C624D6
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 590D510F62D;
	Thu,  3 Sep 2026 13:59:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="eJsIL05e";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FAFD10E36F
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 13:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788443992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vm+o51d5AAhWwdhCJ9D5D6GwJZ5w7R0MImR238UNQLM=;
 b=eJsIL05ei5qJxWshUcF319FKvJEVDge230gswskCHezcp+D+Udj2LQEx6ur69LxuKBjIjr
 giwSpsqE6fl7P/7QIaQbo12RJFqVDc1hJfjry+HjaF+/y6mLgJ40I29a3mRb6Y0KaMeTTD
 uJ1vGr+wBS62pIfkLgNeDW8UVkV/7rM=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-1D7TWPPxMY2qUS5h0qYWfQ-1; Thu, 03 Sep 2026 09:59:51 -0400
X-MC-Unique: 1D7TWPPxMY2qUS5h0qYWfQ-1
X-Mimecast-MFC-AGG-ID: 1D7TWPPxMY2qUS5h0qYWfQ_1788443991
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-81e735bcceaso35212547b3.3
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 06:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788443991; x=1789048791;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vm+o51d5AAhWwdhCJ9D5D6GwJZ5w7R0MImR238UNQLM=;
 b=g7DewHlOrS6DQUCZq25qmPn+X2l9kFyEsv5ht1mWNEcVXEV3VfaHNyEXQSvAxkd00G
 A8DqIQqDCJpKU8WztFHAxScsOc8UkJgIsZoJ8bsRDyFHXkDIVBnvFSau2Rqd4lhPMRup
 oxO3yIiENDOUiEfaAlJHN39cADpPYx6tMnqWHe6AoChWGb+D4sA8k/Ja7WtsxI7vbbTE
 st9hvxp0FjBEybVEEIHCazfzw3l/mQU6TiJmFS8Ay4cWifciQeVWFRw5fcc1eA7ORL+1
 tLEyWLrBKpjbvhdpFn5im+WkBtEakg2Le7xkY0zAiXGY2Iyz4eumDDHWUdWxiMISXO0T
 X08A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiNy7uqneAC509ZQG4YTYA3UnzB5F23sKiLblT9U43JwzVk5tC5W4flA+cytY1N2wClcKewP+r03E=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nQnKvDuydOGWBRK8Frsd2C3ACJP6v4aRoqOp/POhsZk6QvKSOf
 q0xpqeR73PqU/Yuf3sFTXbUTHLtWqH2HpRz19po/eIx+NXmtbhFVv/XJGJAdS6vydazBT2UMMRP
 w+fpIYTlzTob1pvSpFD1Xegk6FkeNG7NS9cD3o2n56UHzWBRuVWHwAhhKtWg+STxsWzrqtACeOn
 UDa38FwS786mvr+7jpfj9m8jTdJ6RkCz/V5/VnBpjqIaSa
X-Gm-Gg: AYBFou1ho8WYeSjEkk10q+No5qiGn5DHCjreTuaHmVnjlmqXmzrU2SPDispw4IwCRXj
 o5huWIpwK76Sj3n4iE99yQCtrc4TLtOp+15pSDmRW1Yiyj2TeJp1LCytawTjME07a9jwSX6ab42
 spg2/2GKptmTP7Qjv6B5IyYAMGJ3Rx6qBx9NNKUEJRuDii8u0Xc7kyDy0=
X-Received: by 2002:a05:690c:ed6:b0:870:c600:686c with SMTP id
 00721157ae682-870c60071f3mr2545437b3.18.1788443990622; 
 Thu, 03 Sep 2026 06:59:50 -0700 (PDT)
X-Received: by 2002:a05:690c:ed6:b0:870:c600:686c with SMTP id
 00721157ae682-870c60071f3mr2545057b3.18.1788443990118; Thu, 03 Sep 2026
 06:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com>
 <20260903-drm-bridge-every-panel-v2-4-2ab8ee24538e@bootlin.com>
In-Reply-To: <20260903-drm-bridge-every-panel-v2-4-2ab8ee24538e@bootlin.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 3 Sep 2026 15:59:38 +0200
X-Gm-Features: AcwNN1XDl-Ni_DEe3erHCFfPAz2cykoqMGRy_g6UAaZH6jri9FS6U46r-qkzR3A
Message-ID: <CADSE00+n4XQ+Xj-TG4KtbPq4asR6GH9=+fC0MdQUycM2_DXiNg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 04/19] drm/bridge: panel: rename
 drm_bridge_is_panel() -> drm_bridge_is_panel_bridge()
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Anusha Srivatsa <asrivats@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JVof-WZXhn-NPQ7A2PkEyDMZtPRxUUe_9kq36Rw9N6U_1788443991
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, Sep 3, 2026 at 10:12=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
>
> Work is in progress for every drm_panel to embed a drm_bridge, and for th=
at
> a function will be needed in the drm_panel API to tell whether a bridge
> represents a panel or something else. The ideal name for that will be
> drm_bridge_is_panel(), which however is already in use by the panel_bridg=
e.
>
> Rename the current function in the panel_bridge API to
> drm_bridge_is_panel_bridge(), which is more precise and frees up the
> drm_bridge_is_panel() for future use in the drm_panel API.
>
> No functional changes, just renaming a function treewide.
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/bridge/panel.c                 | 8 ++++----
>  drivers/gpu/drm/display/drm_bridge_connector.c | 2 +-
>  include/drm/drm_bridge.h                       | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Albert Esteve <aesteve@redhat.com>

Thanks for cc'ing me :)
Very curious to see how this series will unravel.

Albert

>
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/pane=
l.c
> index 40e3970e8b76..0582c708957c 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -221,17 +221,17 @@ static const struct drm_bridge_funcs panel_bridge_b=
ridge_funcs =3D {
>  };
>
>  /**
> - * drm_bridge_is_panel - Checks if a drm_bridge is a panel_bridge.
> + * drm_bridge_is_panel_bridge - Checks if a drm_bridge is a panel_bridge=
.
>   *
>   * @bridge: The drm_bridge to be checked.
>   *
>   * Returns true if the bridge is a panel bridge, or false otherwise.
>   */
> -bool drm_bridge_is_panel(const struct drm_bridge *bridge)
> +bool drm_bridge_is_panel_bridge(const struct drm_bridge *bridge)
>  {
>         return bridge->funcs =3D=3D &panel_bridge_bridge_funcs;
>  }
> -EXPORT_SYMBOL(drm_bridge_is_panel);
> +EXPORT_SYMBOL(drm_bridge_is_panel_bridge);
>
>  /**
>   * drm_panel_bridge_add - Creates a &drm_bridge and &drm_connector that
> @@ -321,7 +321,7 @@ void drm_panel_bridge_remove(struct drm_bridge *bridg=
e)
>         if (!bridge)
>                 return;
>
> -       if (!drm_bridge_is_panel(bridge)) {
> +       if (!drm_bridge_is_panel_bridge(bridge)) {
>                 drm_warn(bridge->dev, "%s: called on non-panel bridge!\n"=
, __func__);
>                 return;
>         }
> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu=
/drm/display/drm_bridge_connector.c
> index 00feb73e63d7..5de9b76f345b 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -983,7 +983,7 @@ struct drm_connector *drm_bridge_connector_init(struc=
t drm_device *drm,
>                 if (bridge->ddc)
>                         ddc =3D bridge->ddc;
>
> -               if (drm_bridge_is_panel(bridge)) {
> +               if (drm_bridge_is_panel_bridge(bridge)) {
>                         drm_bridge_put(panel_bridge);
>                         panel_bridge =3D drm_bridge_get(bridge);
>                 }
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 9f2294957669..b29096d624d5 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -1474,7 +1474,7 @@ void drm_bridge_hpd_notify(struct drm_bridge *bridg=
e,
>                            enum drm_connector_status status);
>
>  #if IS_ENABLED(CONFIG_DRM_PANEL_BRIDGE)
> -bool drm_bridge_is_panel(const struct drm_bridge *bridge);
> +bool drm_bridge_is_panel_bridge(const struct drm_bridge *bridge);
>  struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel);
>  struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
>                                               u32 connector_type);
> @@ -1490,7 +1490,7 @@ struct drm_bridge *drmm_panel_bridge_add(struct drm=
_device *drm,
>                                              struct drm_panel *panel);
>  struct drm_connector *drm_panel_bridge_connector(struct drm_bridge *brid=
ge);
>  #else
> -static inline bool drm_bridge_is_panel(const struct drm_bridge *bridge)
> +static inline bool drm_bridge_is_panel_bridge(const struct drm_bridge *b=
ridge)
>  {
>         return false;
>  }
>
> --
> 2.55.0
>

