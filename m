Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CCCC44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 10:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B769310F27C;
	Thu, 16 Jul 2026 10:23:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="b0gPzyXz";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B64D10F27C
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 10:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784197424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q8zisv8v+OCz5mSkB0tHa1MIv/FMnNErmwivzO7LfPs=;
 b=b0gPzyXz/pQ++Y9ChK3wo4/EwPkjnHz3p19Vp922Kpu834YCCedh2gqR57OjYGwAvH+VMu
 P2YQaiNXciearS2qEDosORUtJYXiuz5wO6axYwkQNjQ3vpY5PnIFSIG90xLgasPLLKCHon
 Jx+XA6eT3/IXzvLc2EQf/yaMbZpocxU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-aRX1ecKePA-HDsjjfn_V3Q-1; Thu, 16 Jul 2026 06:23:43 -0400
X-MC-Unique: aRX1ecKePA-HDsjjfn_V3Q-1
X-Mimecast-MFC-AGG-ID: aRX1ecKePA-HDsjjfn_V3Q_1784197422
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493f75ebec5so43447205e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 03:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784197422; x=1784802222;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q8zisv8v+OCz5mSkB0tHa1MIv/FMnNErmwivzO7LfPs=;
 b=X0ug3Hr92mGeDyNjsDM/NYTQ7MIxNWz9YJpIhyu9D7EnUszhZ5u1RL3aKINqc50yi2
 NOWUdlCHjwYxxVvKvxVgiSItgjuTT+knYmAb3bRYiuKOZM5ODWcI7u+WYolyjKLwrzj+
 /W3vg07ODMr4Q/0qhTX9+OAEpxM83S3o9IDtgQYKK2DOlkXNsW50TWHiaW0ObUUub9MD
 mm1Sgd3JwSLusSnPDYjCwm1W5debLQBKLy7SCAUIZ/feUxgTwkbELqST/4v9IqHrms3H
 ODnLkrU9WZo5QX7W5I9fWemgS51jTHGFiOqJqPxuyXZbO6BomRtS3Y+fmQnMUm2Ol1nv
 SL8Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqP2oNsaDNZkQrvY/KyBHPpwPQwJ4QqHIQUKmNS+X+VjDnCNuxamH8yntH64sKXL8IJj54IhIMxBlo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzzxZe0PH+HDttnbnIbpwrbMTErow1F547kc6AziAYqwIVPlyEA
 pkwKL8360kvBmpnmZ0BQ20g4x84TDX3dAlwqPHIsoAJk0z8dm+AEAUrAsjAQuaGPQvU+d7AeTuJ
 bubjJ88H7ZXOdjCtL9dcFOmHztXcqpgOpEGAVaHlSzJCmDhF4eXwdxC8yDSzKkp4PMm7GPg==
X-Gm-Gg: AfdE7clXYewMbFr6tIw9x5fMucSeuRB86AbyqIjCGq1CZjAxo0LxzHmOTviRgQqPoG2
 HBR65Nkl5/qunZKKy2TrqxmbMXbwsWFXfQQmglRrreWiT7PdokdAAvGMr+7pxvPul6+je3i3pD2
 Of6jFt5E/N+iwtSZ1fywspMiV03AhZCpFz/hH/F64yq+0GsX9kqZyoE22TF7mMeY/5a1lvYOqQe
 cYIS1ZnFnkcgF9jJLGGXkheX8hGVzGB6Db2G4u/sZK7DSBDrRxf3wi0T5yRrnAM9m0MNcNWMI4m
 Vdu/fWeWNsTJQWOqVF71t023f429RijYqJuRFWhlGvFccz13w3gLKYt04s6jFpa93RS0CTrvzLQ
 PgQ5KGsA2dq0IXvfcNSKzTmR5DNXNWTXR1YbKUnlcZPDmmo1vNpAaBs3Gz+A=
X-Received: by 2002:a05:600c:4ed2:b0:495:3fe8:880f with SMTP id
 5b1f17b1804b1-4953fe88815mr42927275e9.4.1784197421784; 
 Thu, 16 Jul 2026 03:23:41 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed2:b0:495:3fe8:880f with SMTP id
 5b1f17b1804b1-4953fe88815mr42926685e9.4.1784197421061; 
 Thu, 16 Jul 2026 03:23:41 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49541e51f47sm44889525e9.0.2026.07.16.03.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 03:23:40 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: Re: [PATCH v3 3/3] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
In-Reply-To: <20260704080925.75113-4-amit.barzilai22@gmail.com>
References: <20260704080925.75113-1-amit.barzilai22@gmail.com>
 <20260704080925.75113-4-amit.barzilai22@gmail.com>
Date: Thu, 16 Jul 2026 12:23:39 +0200
Message-ID: <87y0fbs05w.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wWK3xz1h6UVRyNMyb2rkCVmN7KXnWzCQT_RIhzqwG-8_1784197422
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Amit Barzilai <amit.barzilai22@gmail.com> writes:

Hello Amit,

Thanks for the patch. Unfortunately I think that there is still some work
to be done for this patch to land. Inline comments below.

> The Solomon SSD1351 is a 128x128 RGB color OLED controller. It shares
> the SSD133X data path: a column/row addressing window followed by a bulk
> RGB565 pixel write. Add it as a new SSD135X_FAMILY rather than a separate
> driver, reusing the SSD133X plane, CRTC and blit/clear helpers.
>

[...]

>   */
> -static int ssd130x_write_data(struct ssd130x_device *ssd130x, u8 *values, int count)
> +static int ssd130x_write_data(struct ssd130x_device *ssd130x, const u8 *values, int count)
>  {
>  	return regmap_bulk_write(ssd130x->regmap, SSD13XX_DATA, values, count);
>  }

>

This change is correct but need to be split in a separate preparatory
patch. When you do that, feel free to add my Reviewed-by tag.

> -/*
> - * Helper to write command (SSD13XX_COMMAND). The fist variadic argument
> - * is the command to write and the following are the command options.
> - *
> - * Note that the ssd13xx protocol requires each command and option to be
> - * written as a SSD13XX_COMMAND device register value. That is why a call
> - * to regmap_write(..., SSD13XX_COMMAND, ...) is done for each argument.
> - */
> -static int ssd130x_write_cmd(struct ssd130x_device *ssd130x, int count,
> -			     /* u8 cmd, u8 option, ... */...)
> -{
> -	va_list ap;
> -	u8 value;
> -	int ret;
> -
> -	va_start(ap, count);
> -
> -	do {
> -		value = va_arg(ap, int);
> -		ret = regmap_write(ssd130x->regmap, SSD13XX_COMMAND, value);
> -		if (ret)
> -			goto out_end;
> -	} while (--count);
> -
> -out_end:
> -	va_end(ap);
> -
> -	return ret;
> -}
> -

Please split these ssd130x_write_cmds() and ssd1330x_write_cmd() refactoring
as separate preparatory patches. This patch is changing too many things at
once, it is better to have each logical changes as a separate patch. This
makes reviewer much easier.

>  /*
>   * Write a command byte sequence from a buffer.
>   *
> - * Like ssd130x_write_cmd() but takes a pre-built byte array instead of
> - * variadic arguments, handy when the command is already in an array or
> - * when the caller wants to use sizeof() for the length.
> + * The first byte is the command opcode and the following bytes are its
> + * options/parameters.
>   */
>  static int ssd130x_write_cmds(struct ssd130x_device *ssd130x, const u8 *cmd,
>  			      size_t len)
> @@ -294,6 +296,22 @@ static int ssd130x_write_cmds(struct ssd130x_device *ssd130x, const u8 *cmd,
>  	unsigned int i;
>  	int ret;
>  
> +	/*
> +	 * The SSD135X family latches command parameters with D/C# HIGH (i.e.
> +	 * clocked in as data), unlike the other families where the opcode and
> +	 * all of its parameters are sent as commands (D/C# LOW). Send the
> +	 * opcode as a command and any following parameter bytes as data.
> +	 */
> +	if (ssd130x->device_info->family_id == SSD135X_FAMILY) {
> +		if (len == 0)
> +			return 0;
> +		ret = regmap_write(ssd130x->regmap, SSD13XX_COMMAND, cmd[0]);
> +		if (ret || len == 1)
> +			return ret;
> +
> +		return ssd130x_write_data(ssd130x, cmd + 1, len - 1);
> +	}
> +

I don't like that this logic is in the ssd130x core part of the driver. This
is supposed to be transport agonistic and should not be aware of the D/C#
behaviour that is specific to the SPI transport.

Can we move this to the ssd130x-spi driver? For example, something like the
following might work:

1. Make ssd130x_write_cmds() to just be a static inline wrapper that calls
   to regmap_raw_write(ssd130x->regmap, SSD13XX_COMMAND, cmd, len).

2. Make ssd130x_write_cmd() be a variadic wrapper around ssd130x_write_cmds().

3. Add your logic to ssd130x_spi_write() instead of ssd130x_write_cmds(), that
   way it stays in the correct layer rather than having a leaking abstraction.

Also, instead of checking for info->family_id == SSD135X_FAMILY, we could add
a dc_high_params member (or whatever name is more suitable) to the struct
ssd130x_spi_transport Then other families that might use the same can just
reuse this option instead of checking for specific families.

[...]

>  /*
>   * Run a packed command sequence.  The format is a flat byte array where each
>   * entry starts with a length byte followed by that many command bytes.  A
> @@ -415,6 +454,12 @@ static void ssd130x_reset(struct ssd130x_device *ssd130x)
>  	udelay(4);
>  	gpiod_set_value_cansleep(ssd130x->reset, 0);
>  	udelay(4);
> +	/*
> +	 * No long post-reset delay: the controller datasheets only specify
> +	 * microsecond-scale reset timing. The lengthy delay seen in some other
> +	 * drivers comes from fbtft's generic reset helper and targets slow
> +	 * parallel-bus GPIOs, which do not apply here.
> +	 */
>  }
>

I don't understand the point of this comment. You are not changing the logic
of this function nor I see how this comment is useful.

[...]
  
> +/*
> + * Write a run of pixel data to the controller's display RAM. The SSD135X
> + * family requires an explicit Write RAM command once the address window has
> + * been set, before any pixel data is accepted; the SSD133X family enters data
> + * mode implicitly after the column/row range is programmed.
> + */
> +static int ssd133x_write_pixels(struct ssd130x_device *ssd130x,
> +				u8 *data_array, unsigned int count)
> +{
> +	if (ssd130x->device_info->family_id == SSD135X_FAMILY) {
> +		int ret;
> +
> +		ret = ssd130x_write_cmd(ssd130x, 1, SSD135X_WRITE_RAM);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return ssd130x_write_data(ssd130x, data_array, count);
> +}
> +
>  static int ssd133x_update_rect(struct ssd130x_device *ssd130x,
>  			       struct drm_rect *rect, u8 *data_array,
>  			       unsigned int pitch)
> @@ -826,7 +927,7 @@ static int ssd133x_update_rect(struct ssd130x_device *ssd130x,
>  		return ret;
>  
>  	/* Write out update in one go since horizontal addressing mode is used */
> -	ret = ssd130x_write_data(ssd130x, data_array, pitch * rows);
> +	ret = ssd133x_write_pixels(ssd130x, data_array, pitch * rows);
>  
>  	return ret;
>  }
> @@ -896,7 +997,7 @@ static void ssd133x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
>  	memset(data_array, 0, pitch * ssd130x->height);
>  
>  	/* Write out update in one go since horizontal addressing mode is used */
> -	ssd130x_write_data(ssd130x, data_array, pitch * ssd130x->height);
> +	ssd133x_write_pixels(ssd130x, data_array, pitch * ssd130x->height);
>  }
>  

Instead of ssd133x_write_pixels() and having per family logic in the primary
place update path, I prefer to have a little bit more of code duplication
and add an .atomic_update, .atomic_disable, etc for the SSD1351.

Yes, I know that your current approach reduces code duplication but also
makes it harder to change the primary plane update path for a family without
affecting another one. This is particularly important in my opinion, given
that contributors usually just test on their display family when posting
the patches. So I prefer to have per family callbacks if possible.

[...]

>  static const struct drm_encoder_funcs ssd130x_encoder_funcs = {
> @@ -1897,15 +2037,25 @@ struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap)
>  	if (ret)
>  		return ERR_PTR(ret);
>  
> -	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ssd130x,
> -					    &ssd130xfb_bl_ops, NULL);
> -	if (IS_ERR(bl))
> -		return ERR_PTR(dev_err_probe(dev, PTR_ERR(bl),
> -					     "Unable to register backlight device\n"));
> +	/*
> +	 * The backlight update path drives contrast through the
> +	 * SSD13XX_CONTRAST command (0x81), which the SSD135X family does not
> +	 * implement; the brightness byte would be interpreted as a command
> +	 * opcode instead. Do not register a backlight device for this family
> +	 * until the backlight path is family-aware.
> +	 */
> +	if (ssd130x->device_info->family_id != SSD135X_FAMILY) {
> +		bl = devm_backlight_device_register(dev, dev_name(dev), dev,
> +						    ssd130x, &ssd130xfb_bl_ops,
> +						    NULL);
> +		if (IS_ERR(bl))
> +			return ERR_PTR(dev_err_probe(dev, PTR_ERR(bl),
> +						     "Unable to register backlight device\n"));
>
> -	bl->props.brightness = ssd130x->contrast;
> -	bl->props.max_brightness = MAX_CONTRAST;
> -	ssd130x->bl_dev = bl;
> +		bl->props.brightness = ssd130x->contrast;
> +		bl->props.max_brightness = MAX_CONTRAST;
> +		ssd130x->bl_dev = bl;
> +	}

Again I wonder if is better to have a device_info member to decide whether to
register the backlight, instead of harcoding the check for a specific family.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

