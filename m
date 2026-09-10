Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62655C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 12:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88DB410F46D;
	Thu, 10 Sep 2026 12:00:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ZPq0Xlx/";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1E3B10F478
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 12:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789041624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2ALPxfFLzOB6fxKhlvV9SFvjlK6DXyJ4C78Re9ntQdk=;
 b=ZPq0Xlx/uk/Z+XgAk+xXbfgkX68QsagiOHskq0y/zCi0mLw4P7un2Am6HWajsyXHmIF/f4
 yPvVeoy+mlCOlLDTq5bNr3/5Dmz0i3UVaYeVcF4HziqUKw62W9xYrHS/pg7gO1qeT32onm
 SiFvNLfGR1opbqwjCaJXotxWlLx0lVU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-hcnfXXy-Mb2pqDl2c8YLGQ-1; Thu, 10 Sep 2026 08:00:23 -0400
X-MC-Unique: hcnfXXy-Mb2pqDl2c8YLGQ-1
X-Mimecast-MFC-AGG-ID: hcnfXXy-Mb2pqDl2c8YLGQ_1789041622
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-485866e0066so3858196f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 05:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789041622; x=1789646422;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2ALPxfFLzOB6fxKhlvV9SFvjlK6DXyJ4C78Re9ntQdk=;
 b=dYDaZ6ciZi3mLkhi3HvvQbtcKJc+E0/tHgkWsY5mO7FAEHurXim/tC9EYqTvdh9UiT
 Q8dF96tydV5oajhyJRAYjClsKuBtVyuspuEQ8AS7lW42Op2cMmGS3Qwk7Xmteg2TWd7d
 HPjD+QB+qP6C7se92wbiq8Zmr77LbHxkfEocFjWWfsh4DU+Xn+Gk2jYK7gYp7wN1rB9I
 48sPSPTCvt4PleRAsY8TiQxpxgNgsT1f9MIkrXRNeewOcHWcJY4aAekLpQ20cRzTmI+v
 kdoFIX29ctSdrV70jJ21swA6KgES4mmqWfR4Z17796A16F8DhQBO1zXK7rRD+2CFJTeZ
 tbmw==
X-Forwarded-Encrypted: i=1;
 AKwUvByxCht1hRRYNNT9wQmY/WFc7Ho5NjpzDVgGCv9plu4RxxPh6XZrnkkuPahqGYKZKK2GHMCpvldPX1s=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nAFoikmgYddwsLqGI6hcxX+zd0Wel/3ymGyUcQwAqneHWKiLfG
 ZsHkyBouKDImrNOYR8cxXf+oCzZ30i0qiRGzN459eTmG8TYbAUhmf8NSFbrBlwSnRGKz2sIyePE
 xKiNHHeFOZSJxSveQSMN6cJoFC5E137evnR0RBaNpMfNeHQD57ARzmLreAR5hQYt85bFc0A==
X-Gm-Gg: AYBFou3fsCGsexXVBB6x7EJN/DWyZ0P887N74pVVJh3uiV3k2f4jfIfRhmo48jDzgOM
 ZI8aLMVUAq1082MZb6KjKLg7XdqjCu8Xqqm6RPRsJc7Que8c5JPglANJb8sZfM2B51cwO9XN+uO
 1QFH+q3UIz9zsAuPwFoiH1AnQnyvLP9bfekWOh4FcUBKU41dw44oMs3SdQzYIWzZU2F/xPnZwvk
 3CPcFSfCnWNFXYyDSfBFk0ZdRQNljI6dR9XlnHgvnaqBDZZuyEd57tMvu9y0KxjRnDWbd25VHK5
 MX0AbbRLS0SLcrQ4WgmbXqkGskvTAaBADJcRP/dV0Rp2jAJaorlLvdj+Mk2jM5ik2XIexq4RA9Z
 W783P3vvSTPkCQet8RBYQy+susFQrVxLAem5WeEYgh5970i/X+zJpD5DsCQ==
X-Received: by 2002:a05:6000:608:b0:485:8e4b:3d34 with SMTP id
 ffacd0b85a97d-4858e4b3ed7mr39816590f8f.5.1789041621509; 
 Thu, 10 Sep 2026 05:00:21 -0700 (PDT)
X-Received: by 2002:a05:6000:608:b0:485:8e4b:3d34 with SMTP id
 ffacd0b85a97d-4858e4b3ed7mr39816517f8f.5.1789041620938; 
 Thu, 10 Sep 2026 05:00:20 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588392b3esm56930489f8f.12.2026.09.10.05.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 05:00:20 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>, airlied@gmail.com,
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: andriy.shevchenko@intel.com, holofermes@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: Re: [PATCH v5 6/6] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
In-Reply-To: <20260823111959.17029-7-amit.barzilai22@gmail.com>
References: <20260823111959.17029-1-amit.barzilai22@gmail.com>
 <20260823111959.17029-7-amit.barzilai22@gmail.com>
Date: Thu, 10 Sep 2026 14:00:19 +0200
Message-ID: <87tsnxl3jg.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8zElVgbwiclUfJPaqyQojPgqdMrd1ICc8jaBMtn8R7g_1789041622
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

> The Solomon SSD1351 is a 128x128 RGB color OLED controller. It shares the
> SSD133X pixel layout: one 65k color (RGB565) pixel per Segment, written as
> a bulk transfer once a column/row addressing window has been programmed.
> Add it as a new SSD135X_FAMILY rather than as a separate driver, so that
> the ssd130x plane, CRTC and encoder infrastructure is reused.
>
> Give the family its own primary plane update and disable, encoder enable
> and backlight callbacks instead of teaching the ssd133x ones about a second
> family. Only the callbacks that carry no family specific logic are reused
> as is: ssd133x_primary_plane_atomic_check(), ssd133x_crtc_atomic_check()
> and ssd130x_encoder_atomic_disable().
>
> The data path differs from the ssd133x family in one respect. The SSD1351
> only starts accepting pixel data after an explicit Write RAM command
> (0x5c), while the SSD133X enters data mode as soon as the address window
> has been programmed. Emit it from ssd135x_update_rect(), which both the
> damage update and the clear screen paths go through.
>
> SSD1351 differs from previous controllers in the command protocol. While
> the opcode is still sent on the command path, the parameters are sent on
> the data path. Introduce the cmd_params_are_data flag to struct
> ssd130x_deviceinfo and let ssd130x_write_cmds() split the buffer in
> accordance to the device specifications.
>
> The SSD1351 also needs its own init sequence (ssd135x_init). The remap
> byte is fixed at horizontal address increment, COM split, reversed COM
> scan direction, BGR sub-pixel order and 65k color depth; rotation is not
> supported.
>
> Contrast is calibrated per color channel as for the ssd133x family, but
> the three channels are parameters of a single command (0xc1) instead of
> one command per channel. Add ssd135x_set_contrast() for that and use it
> from both the init and the backlight update paths.
>
> The SSD1351 is SPI-only, so only the SPI transport match tables gain an
> entry; no new config symbol is needed.
>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
> ---

[...]

>  static int ssd130x_write_cmds(struct ssd130x_device *ssd130x, const u8 *cmd,
>  			      size_t len)
> @@ -271,6 +310,17 @@ static int ssd130x_write_cmds(struct ssd130x_device *ssd130x, const u8 *cmd,
>  	unsigned int i;
>  	int ret;
>  
> +	if (ssd130x->device_info->cmd_params_are_data) {
> +		if (!len)
> +			return 0;
> +


Can len even be 0? If that's the case then I guess that makes more sense
to check and bail out early regardless if cmd_params_are_data is true ?

For the !cmd_params_are_data case, the for loop will be a no-op anyways
but still I think is cleaner to check as the first thing in this function.

> +		ret = regmap_write(ssd130x->regmap, SSD13XX_COMMAND, cmd[0]);
> +		if (ret || len == 1)
> +			return ret;
> +

The len == 1 case is for commands that do not have parameters right? I
think that adding some comments explaining this to make it clear why
there is an early return.

I'm happy with the implementation now, thanks a lot for bearing with
me and your patience iterating over this series.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

