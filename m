Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061AAC5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:30:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3348110E793;
	Mon, 17 Aug 2026 12:30:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="vhvi33Wo";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A931E10E793
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:30:41 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 3306C4E41290;
 Mon, 17 Aug 2026 12:30:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E9B5560352;
 Mon, 17 Aug 2026 12:30:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 48B6611C72406; 
 Mon, 17 Aug 2026 14:30:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786969834; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=DWZF8jen0UUXQ6+yWtlvwKximKo59aFsN1UORVkYEk8=;
 b=vhvi33WoAoHwH4bEdSWgfdX4+RVX3NMiqS3tCtsiYK0uOcu3znVRD+1c2Qp6L2iTDUljGN
 BfdTOky7r3lnLR/c1pZZlSt/ZHXroECvDdQQ7/+tH1qxP+pqivqiGSVXsSmQdXL3jKP1ft
 pAcmccFZMdQlQ9PYvWOROLeytuXij5Npe1rVh9mRLWDTpBIM2NmAnM2kV49M1yM1X88Wpo
 OaVRIwaFvmm7JggplOU1XQKyjfi0oH8xXNNhc6FEwxMWT1FtGvM3yWhzVWo3u6rW5tkx3p
 sQoxHxgsaUjFGwPI2l8Ji1pLvCX49Q2TrJKHx+C6eVOZ6Ltw2JUE1h9568ecYw==
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 14:30:27 +0200
Message-Id: <DKR7XPSEOSUB.2E7CFACFXZ2WE@bootlin.com>
Subject: Re: [PATCH 05/11] drm/bridge: panel: add a panel_bridge to every panel
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Linus Walleij" <linusw@kernel.org>, "Inki Dae"
 <inki.dae@samsung.com>, "Jagan Teki" <jagan@amarulasolutions.com>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, "Hui Pu" <Hui.Pu@gehealthcare.com>,
 "Ian Ray" <ian.ray@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
To: "Maxime Ripard" <mripard@kernel.org>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.22.0
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
 <20260814-drm-bridge-every-panel-v1-5-19cd5277cc8d@bootlin.com>
 <20260817-cuddly-loyal-swan-075985@houat>
In-Reply-To: <20260817-cuddly-loyal-swan-075985@houat>
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

On Mon Aug 17, 2026 at 10:42 AM CEST, Maxime Ripard wrote:
> On Fri, Aug 14, 2026 at 04:05:53PM +0200, Luca Ceresoli wrote:
>> Adding a panel does currently not add a panel_bridge wrapping it. Usuall=
y
>> the panel_bridge creation happens later, when some other driver (e.g. th=
e
>> previous bridge or the encoder) calls *_of_get_bridge() and the followin=
g
>> element in the pipeline is a panel.
>>
>> This has some drawbacks:
>>
>>  * hte bridge API is currently the best practice to access various
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
>>    but the other driver doesn't know whether this is needed because it
>>    doesn't know whether it has created a panel_bridge or not
>>
>> So far the current approach has been working because devm and drmm ensur=
e
>> the panel bridge would be dealloacted at some later point. However with =
the
>> upcoming implementation of dynamic bridge lifetime this will get more
>> complicated.
>>
>> Switch to the new approach: always create a panel_bridge with a drm_pane=
l,
>> thus matching the lifetime of the drm_panel and the panel_bridge wrappin=
g
>> it. This makes lifetime much more straightforward to understand and to
>> further develop on.
>>
>> As a consequence devm_drm_of_get_bridge() and drmm_of_get_bridge() don't
>> need to look for a panel anymore and become simple wrappers to
>> of_drm_get_bridge_by_endpoint(). Also deprecate them as they can be
>> replaced by of_drm_get_bridge_by_endpoint() which also handles refcount.
>>
>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>> ---
>>  drivers/gpu/drm/bridge/panel.c | 47 +++++++++++++++++++++--------------=
-------
>>  drivers/gpu/drm/drm_panel.c    |  3 +++
>>  include/drm/drm_panel.h        |  8 +++++++
>>  3 files changed, 34 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/pan=
el.c
>> index 02388a3de626..d86555254aa9 100644
>> --- a/drivers/gpu/drm/bridge/panel.c
>> +++ b/drivers/gpu/drm/bridge/panel.c
>> @@ -412,6 +412,11 @@ struct drm_bridge *devm_drm_panel_bridge_add_typed(=
struct device *dev,
>>  {
>>  	struct drm_bridge **ptr, *bridge;
>>
>> +	if (panel->bridge) {
>> +		dev_dbg(dev, "returning existing bridge=3D%p\n", panel->bridge);
>> +		return panel->bridge;
>> +	}
>> +
>>  	ptr =3D devres_alloc(devm_drm_panel_bridge_release, sizeof(*ptr),
>>  			   GFP_KERNEL);
>>  	if (!ptr)
>> @@ -495,9 +500,12 @@ EXPORT_SYMBOL(drm_panel_bridge_connector);
>>   * @port: port in the device tree node
>>   * @endpoint: endpoint in the device tree node
>>   *
>> + * This function is deprecated and should not be used in new drivers. T=
he
>> + * returned bridge refcount is not incremented! Replace by
>> + * of_drm_get_bridge_by_endpoint() and handle bridge refcount.
>> + *
>>   * Given a DT node's port and endpoint number, finds the connected node
>> - * and returns the associated bridge if any, or creates and returns a
>> - * drm panel bridge instance if a panel is connected.
>> + * and returns the associated bridge if any.
>>   *
>>   * Returns a pointer to the bridge if successful, or an error pointer
>>   * otherwise.
>> @@ -507,18 +515,12 @@ struct drm_bridge *devm_drm_of_get_bridge(struct d=
evice *dev,
>>  					  u32 port, u32 endpoint)
>>  {
>>  	struct drm_bridge *bridge;
>> -	struct drm_panel *panel;
>> -	int ret;
>>
>> -	ret =3D drm_of_find_panel_or_bridge(np, port, endpoint,
>> -					  &panel, &bridge);
>> -	if (ret)
>> -		return ERR_PTR(ret);
>> +	bridge =3D of_drm_get_bridge_by_endpoint(np, port, endpoint);
>> +	if (IS_ERR(bridge))
>> +		return bridge;
>>
>> -	if (panel) {
>> -		bridge =3D devm_drm_panel_bridge_add(dev, panel);
>> -		drm_panel_put(panel);
>> -	}
>> +	drm_bridge_put(bridge);
>>
>>  	return bridge;
>>  }
>> @@ -531,9 +533,12 @@ EXPORT_SYMBOL(devm_drm_of_get_bridge);
>>   * @port: port in the device tree node
>>   * @endpoint: endpoint in the device tree node
>>   *
>> + * This function is deprecated and should not be used in new drivers. T=
he
>> + * returned bridge refcount is not incremented! Replace by
>> + * of_drm_get_bridge_by_endpoint() and handle bridge refcount.
>> + *
>>   * Given a DT node's port and endpoint number, finds the connected node
>> - * and returns the associated bridge if any, or creates and returns a
>> - * drm panel bridge instance if a panel is connected.
>> + * and returns the associated bridge if any.
>>   *
>>   * Returns a drmm managed pointer to the bridge if successful, or an er=
ror
>>   * pointer otherwise.
>> @@ -543,18 +548,12 @@ struct drm_bridge *drmm_of_get_bridge(struct drm_d=
evice *drm,
>>  				      u32 port, u32 endpoint)
>>  {
>>  	struct drm_bridge *bridge;
>> -	struct drm_panel *panel;
>> -	int ret;
>>
>> -	ret =3D drm_of_find_panel_or_bridge(np, port, endpoint,
>> -					  &panel, &bridge);
>> -	if (ret)
>> -		return ERR_PTR(ret);
>> +	bridge =3D of_drm_get_bridge_by_endpoint(np, port, endpoint);
>> +	if (IS_ERR(bridge))
>> +		return bridge;
>>
>> -	if (panel) {
>> -		bridge =3D drmm_panel_bridge_add(drm, panel);
>> -		drm_panel_put(panel);
>> -	}
>> +	drm_bridge_put(bridge);
>>
>>  	return bridge;
>>  }
>> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
>> index f8f6082e637f..95fc95d1b4b7 100644
>> --- a/drivers/gpu/drm/drm_panel.c
>> +++ b/drivers/gpu/drm/drm_panel.c
>> @@ -453,6 +453,9 @@ void *__devm_drm_panel_alloc(struct device *dev, siz=
e_t size, size_t offset,
>>
>>  	drm_panel_init(panel, dev, funcs, connector_type);
>>
>> +	panel->bridge =3D devm_drm_panel_bridge_add(dev, panel);
>> +	WARN_ON(!panel->bridge);
>> +
>
> Having two refcounted dynamic allocations yet with the exact same
> lifetime makes me a bit uneasy: we'll introduce lifetime / reference
> count issue because we would then have to keep the same reference count
> everywhere.

It may look twisty but I don't see why it should not work.

> I wonder if we shouldn't embed the drm_bridge struct into drm_panel, and
> provide a way for the drm_panel and drm_bridge to share the same
> refcount, maybe by making drm_panel_get take drm_bridge.refcount instead
> of duplicating the refcount in both drm_panel and drm_bridge?

That is the other option I evaluated, and I must agree it makes
sense. Basically the resulting bridge refcount would be:

  bridge.refcount =3D=3D number of drm_bridge_get() calls
                   + number of drm_panel_get() calls
		   - number of drm_bridge_put() calls
                   - number of drm_panel_put() calls

I think that's an implementation detail, even though an important one. The
API for both panel and bridge users would be the same, and with the same
guarantee: memory won't be freed before (get - put) reaches zero, but with
the second idea it could be freed even later.

I'll try implementing this, and see what happens when going into the
details.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
