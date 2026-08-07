Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47897C2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78CE210F4BC;
	Fri,  7 Aug 2026 13:08:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="svOgui+b";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DE2F10F4BC
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 13:08:32 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47fe89fb333so2074599f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 06:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786108110; x=1786712910; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XjfEMCqkZ88kBIhDMMBN1abXLKDzKlzUH+bF7MfZKwc=;
 b=svOgui+byGomaSPO13yDCMVLMdesAKhqJmqhTlbn761BQtN3yJxh/GqGy+Z30Gbvtc
 0Yu9Wb8g2bHBrN4oYpdH4X1eJTYmMqzQQYtX3SZqcM987wRxnBNOX2aNosrAxtbcUpcG
 Mk/iZbv0Y4WAi9wowALLQmKtV4DB9p2dpKlSnzJb0tPDHBua68owBAWeAzAoG1bfRjsV
 dARXOVS0Wt3pmGrwAOlq4032kTtUvOgv3QKsz8H/RvcUxhEAr07v2EqTwhoB/Roa2c2d
 XY7xkEstFlfg0istfhk56tAAnP7OcpvubIdOFPHG7CWT7VCUHoJTFUDT4X//Ye5WExKI
 LfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786108110; x=1786712910;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XjfEMCqkZ88kBIhDMMBN1abXLKDzKlzUH+bF7MfZKwc=;
 b=rx/OOSa3mmxcBmXeBZgZpdAtHDT5lZGPA6fx5BIh1Hl7B73B4kgK9HxDDBtrWe5TOp
 rye+bQsoF5NNrFo+ju0WmEf6+yA6qtPVeFWGc1vJY/pUO/EmaugbwryDi7GiEha/FEmk
 2BOE9ezeLELB2bcyNIz3w8PqCyzudYwSACRZVMD7w+wGD8QknU/75PFvOSRc3OsHkoNw
 zobyWe+ZwmjYWfAQhCYDNrYvHB0fHZVeCUB3YKVL/W8yB95LLmv2Ao2xy27fGVECcN/7
 Ohbe3ObBkqzaCJjY56ErkZXylv9Uuk8vhi/T2ha68sqnRBNylpIMR2ve5vPY5ofoUFJ+
 qkkw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCGjSVLG5/b/Zk5VM/R9J+NoWF1L13IHJLbLTVXSLflgOhGdsxiYPM/2SMAGBKt4ufll28PuDZj/s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwnNhZxdXVjLbPVOQw2v3WPrdn2/nBTFMryIVDlp4L8JNRJnaz3
 4tvrXLBBdFsOWawRzq0qQohSoIpTyTUEpR0trq348fq5zlxGzXBk5QFy
X-Gm-Gg: AR+sD11otwmUkHIB7gx8Ll2ruMPpoQ5MmGUDl+3E0D1QfnwiWTbXdu8SuyByEZZDeZQ
 tUJEMWpSPzRd57X3lmcqJGiunYorrgu0bvSttHbTAXuhmbzOTawEs968Mo8Q/NO2cLsmIUYD9YD
 23k4c8xCUDdK+JdPK1Ni45r05g1lgAjXKEdJ7z4WuPEFZnb+8PsKrsmeAx7Ul+jdxG1InyJS6HD
 lKIm3VE9e8w6PZag6WAu5BxecMEyIJTy1RgzOVx/GYEoZ9KVwg3/kP11jLHqU1OEIRH5r1hoRdz
 yuZo4W67ftgm86xXHa4vuiZA2MfnfXO9t7MMdks02T5qXctp+KfmfDEg7oER401/uVkn39odKlO
 MnQSt7JZouUsx9xiS8ytEnpfvCl5se8qrSZKNzoRKw7MYfWJnQ9ZM/Oa+uAt9scYBVSQqaBstPN
 zjpGA1inLnY4wvWahxmsD9nNm862ItwrbL8IFKdsysd6BLg17C1cY86kJM
X-Received: by 2002:a5d:50c2:0:b0:47f:8e50:9411 with SMTP id
 ffacd0b85a97d-47fec52acc2mr26764789f8f.20.1786108110319; 
 Fri, 07 Aug 2026 06:08:30 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021501bcsm5754365f8f.9.2026.08.07.06.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 06:08:29 -0700 (PDT)
Date: Fri, 7 Aug 2026 16:08:26 +0300
From: Dan Carpenter <error27@gmail.com>
To: Nam Cao <namcao@linutronix.de>
Cc: sh_def@163.com, andy@kernel.org, gregkh@linuxfoundation.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 thomas.petazzoni@free-electrons.com, notro@tronnes.org
Subject: Re: [PATCH] staging: fbtft: make dirty_lock IRQ-safe
Message-ID: <anXYynas7E3oarx2@stanley.mountain>
References: <20260804173712.176017-1-sh_def@163.com>
 <87pkzu852x.fsf@yellow.woof>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pkzu852x.fsf@yellow.woof>
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

On Fri, Aug 07, 2026 at 02:53:26PM +0200, Nam Cao wrote:
> sh_def@163.com writes:
> > diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
> > index ca0c38221c16..193643d0329d 100644
> > --- a/drivers/staging/fbtft/fbtft-core.c
> > +++ b/drivers/staging/fbtft/fbtft-core.c
> > @@ -298,14 +298,20 @@ static void fbtft_mkdirty(struct fb_info *info, int y, int height)
> >  {
> >  	struct fbtft_par *par = info->par;
> >  	struct fb_deferred_io *fbdefio = info->fbdefio;
> > +	unsigned long flags;
> >  
> >  	/* Mark display lines/area as dirty */
> > -	spin_lock(&par->dirty_lock);
> > +	/*
> > +	 * fbcon takes dirty_lock while holding console_owner. Disable local
> > +	 * interrupts here so a printk hardirq cannot acquire console_owner
> > +	 * while dirty_lock is held and create the inverse lock ordering.
> > +	 */
> 
> Beside that reason, we also need spin_lock_irqsave() because
> fbtft_mkdirty() can be called in both task context and hardirq
> context. And this reason alone suffices and usually is why
> spin_lock_irqsave() is used, so I think a comment is not necessary.
> 
> But I am fine with it either way.

AI always adds comments.  If we keep alowing obvious comments, the kernel
will turn into reading the Terms and Conditions which are impossible to
read in a single human life time.

regards,
dan carpenter

