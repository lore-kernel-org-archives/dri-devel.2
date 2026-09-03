Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39D3C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:38:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8138A10F5BA;
	Thu,  3 Sep 2026 13:38:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="PojtZPsV";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C190B10F5BA
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 13:38:07 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 301AF4E414DB;
 Thu,  3 Sep 2026 13:38:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EB358602B8;
 Thu,  3 Sep 2026 13:38:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5B77611C7A01D; 
 Thu,  3 Sep 2026 15:37:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788442684; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=9f0ZuBKqT92qJPNvM+giYXAm4zlV6Gw43u/bjYl1GBs=;
 b=PojtZPsV70ZDuv8d/ej0nZtaNT/cu5e72fOQRqjRjdbQ9xlz0ttKsbDXLvmcpVwOqtE+qY
 TsfuBdjmCvxy6gfcqQu+8vxzZsDqvaqNESJ8Mwt90+mdZInIojEC0f7xlYe1C6XXE6kyam
 Ezx2Xh6teTrJXaXjDAi0UIppX6Snwe49bYsNqp31elJSfLf/X670efvpckN2yf9yyjxmFt
 4OpPBwNnu2hcgpMKxSxooF5gqojPBZk2BY1FHGEaga7WO47rlMdMBuwKKz8KDIWeO+DmAx
 PT13m9PY2FFJ+p8eki2X6mIXMQifNWLpaGYNOWnqy5jEhQaWVe7v6XlOnVqU2A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 15:37:55 +0200
Message-Id: <DL5Q0MLS0KT9.24LJK2Q1L89KP@bootlin.com>
Subject: Re: [PATCH RFC v2 05/19] drm/panel: embed a drm_bridge into every
 drm_panel
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Linus Walleij" <linusw@kernel.org>, "Inki Dae"
 <inki.dae@samsung.com>, "Jagan Teki" <jagan@amarulasolutions.com>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, "Albert Esteve"
 <aesteve@redhat.com>, "Anusha Srivatsa" <asrivats@redhat.com>, "Dmitry
 Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Hui Pu"
 <Hui.Pu@gehealthcare.com>, "Ian Ray" <ian.ray@gehealthcare.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Maxime Ripard" <mripard@kernel.org>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com>
 <20260903-drm-bridge-every-panel-v2-5-2ab8ee24538e@bootlin.com>
 <aplG-skzq-TPfFZQ@houat>
In-Reply-To: <aplG-skzq-TPfFZQ@houat>
X-Last-TLS-Session-Version: TLSv1.3
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

Hi Maxime,

thanks for keeping the round-trip time short for this discussion!

On Thu Sep 3, 2026 at 12:22 PM CEST, Maxime Ripard wrote:
> On Thu, Sep 03, 2026 at 10:11:08AM +0200, Luca Ceresoli wrote:
>> Adding a drm_panel does currently not add a panel_bridge wrapping
>> it. Usually the panel_bridge creation happens later, when some other dri=
ver
>> (e.g. the previous bridge or the encoder) calls *_of_get_bridge() and th=
e
>> following element in the pipeline is a panel.
>>
>> This has some drawbacks:
>>
>>  * the bridge API is currently the best practice to access various
>>    components of the pipeline, especially with complex cards where bridg=
es
>>    can be combined in different ways on different hardware
>>  * the panel_bridge is not created in the context of the driver of the
>>    underlying physical device (the panel driver), but of some other driv=
er
>>  * that other driver is not aware of whether the returned drm_bridge
>>    pointer is a panel_bridge created on the fly, a pre-existing
>>    panel_bridge or a non-panel bridge
>>  * removal of a panel_bridge requires calling drm_panel_bridge_remove(),
>>    but that other driver doesn't know whether this is needed because it
>>    doesn't know whether it has created a panel_bridge or not
>>
>> Other drivers call [a variant of] drm_panel_bridge_add(), which also has
>> some of the above drawbacks.
>>
>> So far the current approach was working mostly because devm and drmm ens=
ure
>> the panel bridge would be dealloacted at some later point. However with =
the
>> upcoming implementation of bridge hotplug and dynamic bridge lifetime th=
is
>> will get more complicated.
>>
>> Switch to the new approach: embed a drm_bridge inside every drm_panel,
>> which behaves just like the current drm_panel_bridge.
>>
>> Do this by copying and adapting the code from bridge/panel.c, using
>> function names that are more suitable within drm_panel.c and doing the
>> minimal adaptation needed.
>>
>> Currently drm_bridge and drm_panel have independent refcounted
>> allocation. As they now become a single struct, just change
>> drm_panel_get/put() to get/put the bridge. As a result, the refcount for=
 a
>> drm_bridge embedded in a drm_panel is:
>>
>>   bridge.refcount =3D=3D number of drm_bridge_get() calls
>>                    + number of drm_panel_get() calls
>>                    - number of drm_bridge_put() calls
>>                    - number of drm_panel_put() calls
>>
>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>
> So there's a lot to unravel, and I wished you had split it, but I can't
> find a good way to split it either.

As I see it, this could be maybe split in 2:

 - copy all needed symbols from bridge/panel.c (or move or whatever, see
   discussion below) without using them
 - change _alloc, _get, _put etc to actually embed the bridge and start
   using the copied/moved symbols

Would you prefer that?

Note the second bullet, which is the core change, is pretty small, I think
a <100 lines diff, but I don't think it can be split further.

>> This patch is new in v2, and replaces "drm/bridge: panel: add a
>> panel_bridge to every panel" which was based on a different approach.
>> ---
>>  drivers/gpu/drm/drm_panel.c | 258 +++++++++++++++++++++++++++++++++++++=
++++---
>>  include/drm/drm_panel.h     |  33 ++++--
>>  2 files changed, 266 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
>> index f8f6082e637f..9b86195f9f66 100644
>> --- a/drivers/gpu/drm/drm_panel.c
>> +++ b/drivers/gpu/drm/drm_panel.c
>> @@ -22,15 +22,19 @@
>>   */
>>
>>  #include <linux/backlight.h>
>> +#include <linux/debugfs.h>
>>  #include <linux/err.h>
>>  #include <linux/export.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>>
>> +#include <drm/drm_atomic_helper.h>
>>  #include <drm/drm_crtc.h>
>> +#include <drm/drm_modeset_helper_vtables.h>
>>  #include <drm/drm_of.h>
>>  #include <drm/drm_panel.h>
>>  #include <drm/drm_print.h>
>> +#include <drm/drm_probe_helper.h>
>>
>>  static DEFINE_MUTEX(panel_lock);
>>  static LIST_HEAD(panel_list);
>> @@ -46,6 +50,18 @@ static LIST_HEAD(panel_list);
>>   * take look at drm_panel_bridge_add() and devm_drm_panel_bridge_add().
>>   */
>>
>> +static inline struct drm_panel *
>> +drm_bridge_to_panel(const struct drm_bridge *bridge)
>> +{
>> +	return container_of(bridge, struct drm_panel, bridge);
>> +}
>> +
>> +static inline struct drm_panel *
>> +drm_connector_to_panel(const struct drm_connector *connector)
>> +{
>> +	return container_of(connector, struct drm_panel, connector);
>> +}
>> +
>>  /**
>>   * drm_panel_init - initialize a panel
>>   * @panel: DRM panel
>> @@ -86,6 +102,7 @@ void drm_panel_add(struct drm_panel *panel)
>>  	mutex_lock(&panel_lock);
>>  	list_add_tail(&panel->list, &panel_list);
>>  	mutex_unlock(&panel_lock);
>> +	drm_bridge_add(&panel->bridge);
>>  }
>>  EXPORT_SYMBOL(drm_panel_add);
>>
>> @@ -97,6 +114,7 @@ EXPORT_SYMBOL(drm_panel_add);
>>   */
>>  void drm_panel_remove(struct drm_panel *panel)
>>  {
>> +	drm_bridge_remove(&panel->bridge);
>>  	mutex_lock(&panel_lock);
>>  	list_del_init(&panel->list);
>>  	mutex_unlock(&panel_lock);
>> @@ -370,13 +388,198 @@ int drm_panel_get_modes(struct drm_panel *panel,
>>  }
>>  EXPORT_SYMBOL(drm_panel_get_modes);
>>
>> -static void __drm_panel_free(struct kref *kref)
>> +static int drm_panel_bridge_connector_get_modes(struct drm_connector *c=
onnector)
>> +{
>> +	struct drm_panel *drm_panel =3D drm_connector_to_panel(connector);
>> +
>> +	return drm_panel_get_modes(drm_panel, connector);
>> +}
>> +
>> +/**
>> + * drm_bridge_set_connector_orientation - Set the connector panel
>> + * orientation from the bridge that can be transformed to drm_panel.
>> + *
>> + * @bridge: The drm_bridge for a drm_panel.
>> + * @connector: The connector to be set panel orientation.
>> + *
>> + * Returns 0 on success, negative errno on failure.
>> + */
>> +int drm_bridge_set_connector_orientation(const struct drm_bridge *bridg=
e,
>> +					 struct drm_connector *connector)
>> +{
>> +	struct drm_panel *panel =3D drm_bridge_to_panel(bridge);
>> +
>> +	return drm_connector_set_orientation_from_panel(connector, panel);
>> +}
>> +EXPORT_SYMBOL(drm_bridge_set_connector_orientation);
>
> I don't think we should create new ones. Just move the code from
> bridge/panel here and remove it there. The only thing left will be the
> panel_bridge_add() variants that become almost trivial now, and you can
> cleanup the drivers in later patches.

What do you mean by "move" exactly? Really move all relevant functions from
bridge/panel.c into drm_panel.c, so evey user driver will depend on the new
drm_panel module instead of the old one for these symbols?

> This also allows to get rid of all the symbol renaming, which isn't
> great in itself, but also the existing names were good so it's hard to
> come with better ones.

I think the names in bridge/panel.c make sense there, but not in
drm_panel.c. Here's my interpretation (using atomic_enable as an example):

 - panel_bridge_atomic_enable
   ^^^^^^^^^^^^ <- this is about the panel_bridge

 - drm_panel_bridge_atomic_enable
   ^^^^^^^^^        <- this is drm_panel stuff
             ^^^^^^ <- and specifically about the bridge embedded in drm_pa=
nel

Does it make sense to you too in this perspective?

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
