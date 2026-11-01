Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D598C606A325
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bk++1HiO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A5CD10E40D;
	Sun,  1 Nov 2026 14:32:09 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 346CE10E40D
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 14:32:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2C62660052;
 Sun,  1 Nov 2026 14:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D3C1F000C1;
 Sun,  1 Nov 2026 14:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793543521;
 bh=vMspBcuyqpwO+B/elY0GVC6yL3BryKaCZThjohGQxhE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Bk++1HiOH07DKsUZllesmDaQ4r5HlsZd8QTuDT6Nr8BHVMGa2TKwG2E//5jkBJIy2
 kWjOMTF9FGdZbyVepJv5O/zu3qv47cXilRUVryZmsWRM7UI5AYV3QW6mIPXIKjq+OW
 2HPU0Odr+FOKP02OUlj07a49U/AWCeye0F9grl6AMjUUajBF+lS6QWiE4k5iEd5w/x
 tAUJeo+480U8qGCzCPNEWA8eHktruzDMq5EADO728neNXlD7rR/7EgsVYJ2cB/Dz/S
 JSDyIlY0Am5gOEZAXkVzsdrnrhvJ/VdG3ooZu/T7LzeZN0VxoDRcqPNg5ezsFeoiSj
 tg/tOp0yzfYGw==
Message-ID: <sashiko-outbox-192448@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] video: leds: backlight: lm3533: Support getting LED
 sources from DT
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org, lee@kernel.org
In-Reply-To: <20261101142435.130520-1-clamor95@gmail.com>
References: <20261101142435.130520-1-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 14:32:01 +0000
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
- [Medium] leds: lm3533: unmasked upper bits in lm3533_led_setup() regmap u=
pdate
--

commit 65c330f7377fc6ec85de7b076ec8dcd4d456b54b
Author: Svyatoslav Ryhel <clamor95@gmail.com>

video: leds: backlight: lm3533: Support getting LED sources from DT

This commit adds Control Bank to HVLED and LVLED muxing support to the
lm3533 LED and backlight drivers based on the led-sources device tree
property.

> diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
> index 7259097bd6a71..a1aeff70a90fc 100644
> --- a/drivers/leds/leds-lm3533.c
> +++ b/drivers/leds/leds-lm3533.c
> @@ -26,6 +26,11 @@
>  #define LM3533_ALS_CHANNEL_LV_MIN	1
>  #define LM3533_ALS_CHANNEL_LV_MAX	2
> =20
> +#define LM3533_REG_OUTPUT_CONF1			0x10
> +#define   OUTPUT_CONF1_SHIFT			2
> +#define   OUTPUT_LVLED_MASK			0x3
> +#define LM3533_REG_OUTPUT_CONF2			0x11
> +#define   OUTPUT_CONF2_SHIFT			6
>  #define LM3533_REG_CTRLBANK_BCONF_BASE		0x1b
>  #define LM3533_REG_PATTERN_ENABLE		0x28
>  #define LM3533_REG_PATTERN_LOW_TIME_BASE	0x71
> @@ -54,6 +59,9 @@ struct lm3533_led {
>  	u32 max_current;
>  	u32 pwm;
> =20
> +	int num_leds;
> +	u32 leds[LM3533_LVCTRLBANK_MAX];
> +
>  	bool have_als;
>  };
> =20
> @@ -622,8 +630,36 @@ static const struct attribute_group *lm3533_led_attr=
ibute_groups[] =3D {
> =20
>  static int lm3533_led_setup(struct lm3533_led *led)
>  {
> +	u32 output_cfg_shift =3D 0;
> +	u32 output_cfg_val =3D 0;
> +	u32 output_cfg_mask =3D 0;
>  	int ret;
> =20
> +	if (led->num_leds) {
> +		for (int i =3D 0; i < led->num_leds; i++) {
> +			if (led->leds[i] >=3D LM3533_LVCTRLBANK_MAX)
> +				continue;
> +
> +			output_cfg_shift =3D led->leds[i] * 2;
> +			output_cfg_val |=3D led->id << output_cfg_shift;
> +			output_cfg_mask |=3D OUTPUT_LVLED_MASK << output_cfg_shift;
> +		}
> +
> +		/* LVLED1, LVLED2 and LVLED3 */
> +		ret =3D regmap_update_bits(led->regmap, LM3533_REG_OUTPUT_CONF1,
> +					 output_cfg_mask << OUTPUT_CONF1_SHIFT,
> +					 output_cfg_val << OUTPUT_CONF1_SHIFT);

[Severity: Medium]
In drivers/leds/leds-lm3533.c, when lm3533_led_setup() configures LVLED4
(3) or LVLED5 (4) on control bank D, E, or F (led->id > 0), output_cfg_mask
and output_cfg_val have bits [9:6] set. Left-shifting them by
OUTPUT_CONF1_SHIFT (2) without masking to 8 bits leaves bits [11:8] set
when updating the 8-bit register LM3533_REG_OUTPUT_CONF1.

In drivers/base/regmap/regmap.c:_regmap_update_bits():

	ret =3D _regmap_read(map, reg, &orig);
	if (ret !=3D 0)
		return ret;

	tmp =3D orig & ~mask;
	tmp |=3D val & mask;

	if (force_write || (tmp !=3D orig) || map->force_write_field) {
		ret =3D _regmap_write(map, reg, tmp);

Because orig is an 8-bit value (<=3D 0xff) and val & mask has bits [11:8]
set, tmp exceeds 0xff and tmp !=3D orig is always true. This forces a
register write with tmp > 0xff, which causes regmap_smbus_byte_reg_write()
in drivers/base/regmap/regmap-i2c.c:

	if (val > 0xff || reg > 0xff)
		return -EINVAL;

to reject the write with -EINVAL and fail lm3533_led_probe() on SMBus
byte-data I2C controllers, or issue an unnecessary write on raw I2C
controllers.

Should the mask and value passed to regmap_update_bits() for
LM3533_REG_OUTPUT_CONF1 be masked to 8 bits (e.g. & 0xff or u8)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101142435.1305=
20-1-clamor95@gmail.com?part=3D1
