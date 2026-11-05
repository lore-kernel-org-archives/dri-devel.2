Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEB6606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=csMgt1AR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F28F10E958;
	Thu,  5 Nov 2026 19:12:42 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D06EC10E958
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 19:12:36 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-8b331cad3cfso6768487b3.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 11:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793905956; x=1794510756; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=y8P+WoCobFB7rgWkL/XYrODvnkiB2lim4Wv3M4Ag2eA=;
 b=csMgt1AR17P2peQqni0WXla4swlVtriG9m5pudRLh+BoWMpEak5jjkaaIqBsuwQum+
 oBgrpDT16oW24AL6ujZNm6llhtFnngBHqZf8+7k2zhogQpjhomxYgPKdFjysLnJ+GTW5
 7VCR+3Drq8r67zfQwqBflfYrcM+rPg1TwpFv2eZDbeWDpHp/JmayRc45Z6tcwp/wLkJm
 +v09fGb0Jit4gNZzHdAEMObzIpnJLH3Hz/uFzm14f1DIuP8nKuxrGgbaZ2qfzSOkd9io
 +2/zkA0thx2vrlicKy6DUdehsj5Bh2OLYAVAaojuJrD02hi/egadpYgj1QB5F/9sBYzC
 WTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793905956; x=1794510756;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y8P+WoCobFB7rgWkL/XYrODvnkiB2lim4Wv3M4Ag2eA=;
 b=DPzdR0jry2S0eR2FXuIt9rzCVFq5Htw7yZ2HcApcksgCBKV+spJVwFGHS68F2ao2Vc
 ONn/jmEUjHhUX30C5ynLcN2WWrlIyenvUSbtu7/GsE51eXJwxbZashBX/Bz9gnorxCda
 FUWUoY40Hk2rB9Lc6CMVh58fZguGBEus4we3nXPaK7suegtB6tY1DCGZ21HeVyC+I8Xi
 N0FU8FrSGgo1vWSWK5LYN1jnAas6/Q3hB0mIG3ryT6YzJAkRVVqULNY5vs/93NDXSdTd
 vikVBqA16NOMXBjER1jb6i8Fa1VyxxfZl9AaBdcey5cVhO8sKL9G8RwJvPSZPKpMNE0T
 7zGg==
X-Forwarded-Encrypted: i=1;
 AL+hErEH8ZMmc5NReiJCyPiCQ4VCJA5EmtHW7QsvUK6vuwBjsCx/79yfdGtox0sPN0JrQDZ8Tg7jfaV7oWk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8EJqOCgkhRQjNpUAlGSl8B0S5QbxGlA63FSQhPtTW3EpjO9bsk
 uawaRuKW9cVOJdCa0Gs4zTJHkYfxZKoHiRJ1Pe6p5dV/IZWCLVsY6rs=
X-Gm-Gg: AYBFou3AFYBa+7W5sasGDOvZirczlgXlgieiU1ByFqykBOO7WqKp0D5KYNBWezH7IMu
 ViVXwO8s/wDIucPFd/axhWX5NgvdqnGHYeYnIL1S6gZb6ccGW+ZJPwu5UYD3uELVCq0ndYpTtXB
 wjpgxEAaf0GFH5zuS24oR/Pcd21RQQqEl9/L9Jzr4tmHhJ68hJ2dNnSU3jQDFgn0aGZC0HFqXo3
 z0owybAFIrUDW8ed2jMLZSqXIFNhgx4T2TqtUcRLZcynjyKP8/30B60mAKojXOxlUCz/TaSlur4
 0UltgTdBXghZohK3fJtDn3LpMb/u29SuA2gx0Gk0uzc0mmT5xNAF+aPnFjG0TvgxKKed6rXKpur
 rXOYpsc5PeTi3e2M0B7qw4CjqC61FVkwYss30EaliTRo/XaL0sccPvJnKK69rjLJaeG7fDlnEyl
 Od7h1WZh6d1crdyXikD0/qI4c9PN3U3FEVURE7DbbP710ZcyW0p4faMvwsXf33TMsM4/jF0KzlJ
 Sin67CLLHV/eQSc3rBgGoynfii7eGZPdKMk8xkvkdVQ8GeCKZDVu07NKEhpIE66mREfnvuW0EaJ
 5vw/SIxqn9Yji6YMLrb8S29FadLoYKp5JKZ1Yz9OZ9osMHCbvwFTELCmnaJgbC6U
X-Received: by 2002:a05:690c:c510:b0:8b3:2a99:55d5 with SMTP id
 00721157ae682-8b32a995d6bmr19870087b3.10.1793905955435; 
 Thu, 05 Nov 2026 11:12:35 -0800 (PST)
Received: from localhost ([186.158.238.108]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b33f773239sm2235287b3.15.2026.11.05.11.12.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 11:12:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Nov 2026 16:12:31 -0300
Message-Id: <DMNIL4ZYZWLZ.3K6BK08P4SUD5@gmail.com>
Cc: <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <robh@kernel.org>, <conor+dt@kernel.org>
Subject: Re: [PATCH v6 2/3] drm/ch1115: add support for Chipwealth CH1115
 OLED controller
From: =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.20.0
References: <cover.1793735996.git.nico.antinori.7@gmail.com>
 <01cee5640e8637cbe0cd49e920f3aeed2c60640a.1793735996.git.nico.antinori.7@gmail.com>
 <sashiko-outbox-196034@kernel.org>
In-Reply-To: <sashiko-outbox-196034@kernel.org>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

On Tue Nov 3, 2026 at 6:05 PM -03, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] drm/ch1115: out-of-range display offset 64 sent in ch1115_oled=
_init()
> - [Medium] drm/ch1115: missing DC-DC disable in ch1115_encoder_atomic_dis=
able()
> --
>
> commit e5268b4f2a7c534421925bdee0145caf63c50632
> Author: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>
>
> drm/ch1115: add support for Chipwealth CH1115 OLED controller
>
> This commit adds a DRM driver for Chipwealth CH1115 monochrome dot matrix
> OLED panels connected over I2C.
>
>> diff --git a/drivers/gpu/drm/tiny/ch1115-i2c.c b/drivers/gpu/drm/tiny/ch=
1115-i2c.c
>> new file mode 100644
>> index 0000000000000..08fee5a09f4f9
>> --- /dev/null
>> +++ b/drivers/gpu/drm/tiny/ch1115-i2c.c
>> @@ -0,0 +1,859 @@
>
> [ ... ]
>
>> +static int ch1115_oled_init(struct ch1115_device *ch1115)
>> +{
>> +	u8 commands[] =3D {
>> +		CH1115_CMD_OFF,
>> +
>> +		CH1115_CMD_CLOCK_DIVIDE_RATIO,
>> +		CH1115_VAL_CLOCK_DIVIDE_RATIO(CH1115_VAL_CLOCK_OSC_FREQ,
>> +					      CH1115_VAL_CLOCK_DIV_RATIO),
>> +
>> +		CH1115_CMD_MUX_RATIO,
>> +		ch1115->height - 1,
>> +
>> +		CH1115_CMD_OFFSET,
>> +		ch1115->flip_vertical
>> +			? ch1115->y_start_offset
>> +			: CH1115_MAX_HEIGHT - ch1115->y_start_offset,
>
> [Severity: Medium]
> Does ch1115_oled_init() send an out-of-range value for CH1115_CMD_OFFSET =
when
> flip_vertical is false and y_start_offset is 0?
>
> In ch1115_parse_dt(), y_start_offset defaults to 0 when the chipwealth,of=
fset
> property is omitted, and is otherwise restricted to [0, CH1115_MAX_HEIGHT=
 - 1]
> (0 to 63):
>
> 	ret =3D of_property_read_u32(np, "chipwealth,offset", &val);
> 	if (ret) {
> 		ch1115->y_start_offset =3D 0;
> 	} else {
> 		if (val > CH1115_MAX_HEIGHT - 1) {
> 			dev_err(dev, "chipwealth,offset=3D%d must be [0-%d]\n",
> 				val, CH1115_MAX_HEIGHT - 1);
> 			return -EINVAL;
> 		}
> 		ch1115->y_start_offset =3D (u8)val;
> 	}
>
> When ch1115_encoder_atomic_enable() calls ch1115_oled_init() with
> flip_vertical set to false and y_start_offset set to 0, the expression
> CH1115_MAX_HEIGHT - ch1115->y_start_offset evaluates to 64 (0x40), which
> overflows the 6-bit [0, 63] vertical offset field instead of wrapping mod=
ulo
> CH1115_MAX_HEIGHT to 0.

This is a false positive, the datasheet [1] states that the formula for
this command (D3) is 64 - n, where n is a 6 bit number in the range [0,
63]. I did not use a mask for this because the unused bits get ignored.

>
> [ ... ]
>
>> +static void ch1115_encoder_atomic_enable(struct drm_encoder *encoder,
>> +					 struct drm_atomic_commit *state)
>> +{
>> +	struct drm_device *drm =3D encoder->dev;
>> +	struct ch1115_device *ch1115 =3D drm_to_ch1115(drm);
>> +	int ret;
>> +
>> +	ret =3D ch1115_oled_init(ch1115);
>> +	if (ret < 0)
>> +		return;
>> +
>> +	u8 command =3D CH1115_CMD_ON;
>> +
>> +	ret =3D ch1115_send_command_list(ch1115, &command, 1);
>> +	if (ret < 0)
>> +		return;
>> +
>> +	backlight_enable(ch1115->bl_dev);
>> +}
>> +
>> +static void ch1115_encoder_atomic_disable(struct drm_encoder *encoder,
>> +					  struct drm_atomic_commit *state)
>> +{
>> +	struct drm_device *drm =3D encoder->dev;
>> +	struct ch1115_device *ch1115 =3D drm_to_ch1115(drm);
>> +
>> +	backlight_disable(ch1115->bl_dev);
>> +
>> +	u8 command =3D CH1115_CMD_OFF;
>> +
>> +	ch1115_send_command_list(ch1115, &command, 1);
>> +}
>
> [Severity: Medium]
> Should ch1115_encoder_atomic_disable() also disable the internal DC-DC
> converter?
>
> When the encoder is enabled, ch1115_encoder_atomic_enable() calls
> ch1115_oled_init(), which turns on the DC-DC converter with CH1115_CMD_DC=
_DC
> and CH1115_VAL_DC_DC_ON. However, when the display is disabled via KMS or
> during system shutdown via ch1115_shutdown() -> drm_atomic_helper_shutdow=
n(),
> ch1115_encoder_atomic_disable() only sends CH1115_CMD_OFF, leaving the DC=
-DC
> converter enabled.
>
> By contrast, ch1115_remove() explicitly sends CH1115_CMD_OFF,
> CH1115_CMD_DC_DC, and CH1115_VAL_DC_DC_OFF after calling
> drm_atomic_helper_shutdown():
>
> 	u8 cmd_list[] =3D {
> 		CH1115_CMD_OFF,
> 		CH1115_CMD_DC_DC,
> 		CH1115_VAL_DC_DC_OFF,
> 	};
>
> 	drm_dev_unplug(&ch1115->dev);
> 	drm_atomic_helper_shutdown(&ch1115->dev);
>
> 	ch1115_send_command_list(ch1115, cmd_list, ARRAY_SIZE(cmd_list));
>
> If ch1115_encoder_atomic_disable() sent CH1115_CMD_OFF, CH1115_CMD_DC_DC,=
 and
> CH1115_VAL_DC_DC_OFF, wouldn't that properly power down the DC-DC convert=
er on
> both KMS disable and ch1115_shutdown(), while avoiding the duplicate comm=
and
> sequence in ch1115_remove()?

I believe this is accurate, apologies for this oversight. I have a local
version of this fixed, tested with modetest, unloading the module,
rebooting and power off the system entirely. I'll send a v7 in a few
days in case there is a review.

Best regards,
Nicol=C3=A1s

[1] https://datasheet4u.com/download/1576606/CH1115.html
