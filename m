Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D81D10775E1
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 16:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7CD110E175;
	Wed, 18 Mar 2026 16:44:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="LbzlFJ8X";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50D7010E175
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 16:44:01 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id C9BA4C5506C;
 Wed, 18 Mar 2026 16:44:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0E5DF60050;
 Wed, 18 Mar 2026 16:43:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7B44910450554; Wed, 18 Mar 2026 17:43:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773852237; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=kFyWujQcWcLidxUL7ayZ4mliS2DvOdnHo4P290V1PlY=;
 b=LbzlFJ8Xhnh2KuQsoQmi3aaoY9HXy6iACQFSPY0M7LdYUGJdmCQCLv10Eoi200HO7NDuEY
 xzvatxldLpDNQqXbNB9BlLecEr07ff3KgqTauporTxAamodTt3BOqIliu6vjlhjIVrn7Mc
 bhUcQkUPHW+6e/DjVuzEMZo6NvOpF7d1C9AsSEHOzQPH0GhQuf6S89s4cGqlup+xawyfyP
 bE4EmbOUnKq94MeWYtcRYCSEADmF+SVbCqGw4kJkacRo+C2a2gP/Xv/Vum3su4qr0haFVU
 wBdp8yIzVMTfDs46XCAmFLqirw7dSyn+tdvYX9z+wpcSwYZKvN6yrOf/s3IkQg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 17:43:50 +0100
Message-Id: <DH624WYWKT14.5TSCJXZPVN0T@bootlin.com>
Cc: "Biju Das" <biju.das.jz@bp.renesas.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Anitha
 Chrisanthus" <anitha.chrisanthus@intel.com>, "Linus Walleij"
 <linusw@kernel.org>, "Tomi Valkeinen"
 <tomi.valkeinen+renesas@ideasonboard.com>, "Kieran Bingham"
 <kieran.bingham+renesas@ideasonboard.com>, "Geert Uytterhoeven"
 <geert+renesas@glider.be>, "Magnus Damm" <magnus.damm@gmail.com>, "Tomi
 Valkeinen" <tomi.valkeinen@ideasonboard.com>, "Hui Pu"
 <Hui.Pu@gehealthcare.com>, "Ian Ray" <ian.ray@gehealthcare.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>,
 <dri-devel@lists.freedesktop.org>, <linux-renesas-soc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 3/4] drm: rcar-du: encoder: convert to
 of_drm_find_and_get_bridge()
X-Mailer: aerc 0.20.1
References: <20260318-drm-bridge-alloc-getput-drm_of_find_bridge-4-v3-0-10f502520357@bootlin.com>
 <20260318-drm-bridge-alloc-getput-drm_of_find_bridge-4-v3-3-10f502520357@bootlin.com>
 <20260318152533.GA633439@killaraus.ideasonboard.com>
In-Reply-To: <20260318152533.GA633439@killaraus.ideasonboard.com>
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

Hi Laurent,

On Wed Mar 18, 2026 at 4:25 PM CET, Laurent Pinchart wrote:
> Hi Luca,
>
> Thank you for the patch.
>
> On Wed, Mar 18, 2026 at 10:39:37AM +0100, Luca Ceresoli wrote:
>> of_drm_find_bridge() is deprecated. Move to its replacement
>> of_drm_find_and_get_bridge() which gets a bridge reference, and ensure i=
t
>> is put when done.
>>
>> We need to handle the two cases: when a panel_bridge is added and when i=
t
>> isn't. So:
>>
>>  * in the 'else' case a panel_bridge is not added and bridge is found: u=
se
>>    of_drm_find_and_get_bridge() to get a reference to the found bridge
>>  * in the 'then' case a panel_bridge is found using a devm function whic=
h
>>    already takes a refcount and will put it on removal, but we need to t=
ake
>>    another so the following code in this function always get exactly one
>>    reference that it needs to put
>>
>> In order to put the reference, add the needed drm_bridge_put() calls in =
the
>> existing cleanup function.
>>
>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>> ---
>>  drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c | 28 ++++++++++++++++=
++-----
>>  drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.h |  1 +
>>  drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c     |  2 ++
>>  3 files changed, 25 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c b/drivers=
/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
>> index 7ecec7b04a8d..5789fc75092f 100644
>> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
>> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
>> @@ -51,7 +51,7 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
>>  {
>>  	struct rcar_du_encoder *renc;
>>  	struct drm_connector *connector;
>> -	struct drm_bridge *bridge;
>> +	struct drm_bridge *bridge __free(drm_bridge_put) =3D NULL;
>>  	int ret;
>>
>>  	/*
>> @@ -69,20 +69,26 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu=
,
>>
>>  		bridge =3D devm_drm_panel_bridge_add_typed(rcdu->dev, panel,
>>  							 DRM_MODE_CONNECTOR_DPI);
>> -		if (IS_ERR(bridge))
>> -			return PTR_ERR(bridge);
>> +		if (IS_ERR(bridge)) {
>> +			// Inhibit the cleanup action on an ERR_PTR
>
> C-style comments.

OK

> Shouldn't drm_bridge_put() be extended to be a no-op when called on an
> ERR_PTR ?

Uhm, maybe, even though I think I haven't encountered many cases like this
where this was troublesome, and all those I can remember are related to
panel_bridge functions that are meant to be reworked.

Also, drm_bridge_put() deliberately mimicks of_node_put() which also checks
for NULL but not for IS_ERR.

Maxime, your opinion about Laurent's suggestion?

>> +			ret =3D PTR_ERR(bridge);
>> +			bridge =3D NULL;
>> +			return ret;
>> +		}
>> +
>
> A comment here would be good.
>
> 		/*
> 		 * The reference taken by devm_drm_panel_bridge_add_typed() is
> 		 * released automatically. Take a second one for the __free()
> 		 * when this function will return.
> 		 */

Sure, makes sense. I'll add one to other patches of this series where
relevant.

>
>> +		drm_bridge_get(bridge);
>>  	} else {
>> -		bridge =3D of_drm_find_bridge(enc_node);
>> +		bridge =3D of_drm_find_and_get_bridge(enc_node);
>>  		if (!bridge)
>>  			return -EPROBE_DEFER;
>>
>>  		if (output =3D=3D RCAR_DU_OUTPUT_LVDS0 ||
>>  		    output =3D=3D RCAR_DU_OUTPUT_LVDS1)
>> -			rcdu->lvds[output - RCAR_DU_OUTPUT_LVDS0] =3D bridge;
>> +			rcdu->lvds[output - RCAR_DU_OUTPUT_LVDS0] =3D drm_bridge_get(bridge)=
;
>
> Line wrap.

I wish the 80-VS-100 policy were clear and valid for all the kernel. But no
big deal here, and you maintain this driver, so I'll split.

> I have tested the patch and it seems to behave fine.

thanks for reviewing and testing!

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
