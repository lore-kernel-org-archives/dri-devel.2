Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EDBCC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ECDF112332;
	Thu, 15 Oct 2026 11:41:13 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64641112332
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 11:41:07 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 1EB15C63455;
 Thu, 15 Oct 2026 11:42:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B149660360;
 Thu, 15 Oct 2026 11:41:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EDDC810328B20; 
 Thu, 15 Oct 2026 13:40:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1792064464; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=2CwmQ38XBCXNxkYV8PsEb5OrSl1y/IZojDr7oXcVPP4=;
 b=2K17D360fRTzckjSdYiEX7unfIIKcGugNpe3tQ/utyUPrsi28ZEdyCk1xUWn3VZsPxT1M0
 l7qnjqlTFIgPlvGtCr++eUpOfLgGICViGjKerFzhCBbvp6tN/V+y0z0Dluw3zX1uyCKgkS
 vwWxmTVKg17VnlaHaFM5E8o9hoao/aGd+RIbKKwcDcyLbI3l9lsrc4lfb39eVqaj7SQEIE
 FGf/d0v46xRSIMMpD6N7ZJxvTh8hebJWC5z/h7XQ6Mu2QcXyN3LnNpmEOv1xuB0TcyScvV
 kcsafHNEVVK5zFMmhTic1BLjDf80EGujhR8abDbN8F9+kYbprcCFLDZlNOttGw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 13:40:51 +0200
Message-Id: <DM5DTVXB3ONJ.1HC2E6FMC5TX5@bootlin.com>
Cc: "Paul Cercueil" <paul.cercueil@bootlin.com>, "Nishanth Menon"
 <nm@ti.com>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Javier Martinez Canillas" <javierm@redhat.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Phong LE" <ple@baylibre.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Julien
 Chauveau" <chauveau.julien@gmail.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 1/3] drm/bridge: ite-it66121: improve reading IDs and
 log on errors
X-Mailer: aerc 0.22.0
References: <20261015-drm-ite-it66121-log-probe-errors-v1-0-7fd6994e0be0@bootlin.com>
 <20261015-drm-ite-it66121-log-probe-errors-v1-1-7fd6994e0be0@bootlin.com>
 <xlv1y0bzfdf3.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
In-Reply-To: <xlv1y0bzfdf3.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
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

Hello Javier,

On Thu Oct 15, 2026 at 12:47 PM CEST, Javier Martinez Canillas wrote:
> Luca Ceresoli <luca.ceresoli@bootlin.com> writes:
>
> Hello Luca,
>
>> it66121_probe() calls regmap_read() four times to read the vendor and
>> device ID registers, without error checking. This leads to silently
>> continuing using invalid ID values when any of the reads fail (which has
>> happened and is being fixed [0]).
>>
>> Adding error checking on all 4 regmap_read()s would be annoying, so swit=
ch
>> to regmap_bulk_read().
>>
>> In turn a bulk read requires a differen data structure, so take that as =
an
>> opportunity to make the vendor/device ID computation more explicit.
>>
>> [0] https://lore.kernel.org/r/20261015-drm-ite-it66121-fix-reset-v1-1-47=
3038e06abc@bootlin.com
>>
>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>> ---
>>  drivers/gpu/drm/bridge/ite-it66121.c | 30 +++++++++++++++++++++--------=
-
>>  1 file changed, 21 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/brid=
ge/ite-it66121.c
>> index 692a85e1e2e8..9b43456c67a1 100644
>> --- a/drivers/gpu/drm/bridge/ite-it66121.c
>> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
>> @@ -1580,7 +1580,16 @@ static const struct it66121_chip_info it66xx_chip=
_info[] =3D {
>>
>>  static int it66121_probe(struct i2c_client *client)
>>  {
>> -	u32 revision_id, vendor_ids[2] =3D { 0 }, device_ids[2] =3D { 0 };
>> +	union {
>> +		__u8 byte[4];
>> +		struct {
>> +			__u16 vendor;
>> +			__u16 device;
>> +		};
>> +	} chip_id_regs;
>> +	BUILD_BUG_ON(sizeof(chip_id_regs) !=3D 4);
>
> I think that would be simpler and easier to read if you just use a
> u8 chip_id_regs[4] variable, instead of the union.

OK, will do, together with the change to get_unaligned_le16() suggested
below.

>> +	u16 vendor_id, device_id;
>> +	u32 revision_id;
>>  	struct device_node *ep;
>>  	int ret, i;
>>  	struct it66121_ctx *ctx;
>> @@ -1644,19 +1653,22 @@ static int it66121_probe(struct i2c_client *clie=
nt)
>>  	if (IS_ERR(ctx->regmap))
>>  		return PTR_ERR(ctx->regmap);
>>
>> -	regmap_read(ctx->regmap, IT66121_VENDOR_ID0_REG, &vendor_ids[0]);
>> -	regmap_read(ctx->regmap, IT66121_VENDOR_ID1_REG, &vendor_ids[1]);
>> -	regmap_read(ctx->regmap, IT66121_DEVICE_ID0_REG, &device_ids[0]);
>> -	regmap_read(ctx->regmap, IT66121_DEVICE_ID1_REG, &device_ids[1]);
>
> You should probably drop these defines if will no longer be used. Instead=
,
> maybe you could define a IT66121_CHIP_ID_REGS_START or something like tha=
t?
>
> Although maybe is good to keep them as documentation? Not sure about this=
.

I'd rather keep them for documentation if you don't mind.

>> +	ret =3D regmap_bulk_read(ctx->regmap, IT66121_VENDOR_ID0_REG,
>> +			       &chip_id_regs, sizeof(chip_id_regs));
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Error reading device IDs\n");
>>
>>  	/* Revision is shared with DEVICE_ID1 */
>> -	revision_id =3D FIELD_GET(IT66121_REVISION_MASK, device_ids[1]);
>> -	device_ids[1] &=3D IT66121_DEVICE_ID1_MASK;
>> +	revision_id =3D FIELD_GET(IT66121_REVISION_MASK, chip_id_regs.byte[3])=
;
>> +	chip_id_regs.byte[3] &=3D IT66121_DEVICE_ID1_MASK;
>> +
>> +	vendor_id =3D le16_to_cpu(chip_id_regs.vendor);
>> +	device_id =3D le16_to_cpu(chip_id_regs.device);
>>
>
> And here you could use get_unaligned_le16() instead, to not have to cast
> when using just a u8 array.
>
>>  	for (i =3D 0; i < ARRAY_SIZE(it66xx_chip_info); i++) {
>>  		chip_info =3D &it66xx_chip_info[i];
>> -		if ((vendor_ids[1] << 8 | vendor_ids[0]) =3D=3D chip_info->vid &&
>> -		    (device_ids[1] << 8 | device_ids[0]) =3D=3D chip_info->pid) {
>> +		if (vendor_id =3D=3D chip_info->vid &&
>> +		    device_id =3D=3D chip_info->pid) {
>
> I wonder if this could be done in a separate patch.
>
> That is, keep the << 8 | for this patch and just do the regmap_read() to
> regmap_bulk_read() conversion. Then as a separate patch you could replace
> it by converting with le16_to_cpu() or get_unaligned_le16().

Sure, will do. I felt like this patch shoudl probably have been split, but
was unsure how.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
