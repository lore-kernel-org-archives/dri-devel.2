Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC437C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:11:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A1CC10EB9E;
	Tue, 21 Jul 2026 22:11:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OWtyEaxK";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7B7110E39A
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:32:29 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so89230435e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 10:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784655148; x=1785259948; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oarivZVG6jdDaREUGN57J4bwMGePVEaf7kTu1kPSfvQ=;
 b=OWtyEaxKGiPVQ5n/8ynIi1/yjIBJGXzffKD6upXTJAQHqQwB3Ziymze+g4zX1em5l8
 nVS5cpVCd8zbb1j/rLchW70dKq63BZFGxGh0y+zpZ7RojZUxCA9UYlltMhlk+KB9Mm/E
 Ze3bOdOzx/9COdvEaycaDdYXnH9WW3Lu9zZBYENWryER5KjSnD0E89Clz3FdnQ0F+DO5
 xe5+IZ5GnRspvkEDsY3kuqVvfLOH+QTATDjEIoVllMJM4CE2TMm7FE+9Q6l252X8AwJr
 eqTigCks701F0HxIDeE6VaRAwzqA2TNngdwFQKC6qNpoXNMGfDY97U+32J2iF0cRTHc8
 3ajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784655148; x=1785259948;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oarivZVG6jdDaREUGN57J4bwMGePVEaf7kTu1kPSfvQ=;
 b=ZE0PROjmE5FY4Cmzw/2yDsH5U2U6sYqsAoCjkEKywpsUz55MH2KWZvfUrrxfQfEMTj
 6qMpQ7C822Qg2vtyZTLUpjOOXKg/4VK0yuy7prEB8IxMihfz0c/IBayXIGAVSEjWJl32
 GO/cmexMxY8BfefwhHRpBalYx447aM9NfSO2gPO/zaq2+Dh4ptstOrf+6QWOIU/DI/DX
 HLEbQyM65oM4xw99dJwwDebcRFRdoJxn4v/ZxFRBBdjC4ASeXU38S/M0xKTorermlSuw
 rocP2ONuUPUqt0v6+ipn/BFoyWwnSlzGox8OuL4/Yyi9lSQddMTO1zYqkMykDCy7evfC
 zYiQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpsRNmJ2SMXkjSlJcsdPSf9T06x5wJGBPzXPYdYO93ijaEJOGUIQv73QzdKsNH/y3PFeo2ADX/3PKo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YykxRVjs9hyk8nWUCS2IO0tdtOHyyIKmI5Z56WzkyhI761wydlD
 BgKcYA40V4WDtkZzcx4E+BX42zfrbWK1GCeBpY75mfcKka5jBUTbTF/3
X-Gm-Gg: AfdE7cleCgsXgVtOKRgZI/yra4f1Pm45UuQi5NBfHIioKS3cmLK3SSLPQFhBNpoKaqy
 mVRVXkr8N0PQSkV4tSMwCIDyJ/znHZGMc2nhWkxEIxqLpsIR4rS2HvXNhnSL6Ek9Ow8045TQsGZ
 HjKg9snT8EsIuetV7cvEU0j6L8gaTacuVTEVPs9M2hXDWCwA2x0a7EOf3G3R+SPDlosRlRr3T6Y
 z4EaInM+SXHJLVoaE+CO+2L9gq6oWsjQ3lDH20oIJoCiXOQjXhkAqffR7KgjnQkOMtxAwXMcpYn
 R1zu1NNG0L1eg09RrqoeVcoS7hgRp6CcgL7egZjpd+8WpqkQ96cTWQ6tFrZYDlTJFw+J3FnXMxF
 ZyXiYx/wJkaUbw86r8L6T6E/DOFSXa6i8qrxDF4JwOPSce4R9x1PMTfVzGNCPauRh4WdcqOKPhW
 NsHnN80eaSVFxNANmgTxb7eb7losuMgiuhBIzLCw==
X-Received: by 2002:a05:600c:49aa:b0:495:5943:b76c with SMTP id
 5b1f17b1804b1-4955943b9dfmr94309475e9.34.1784655148196; 
 Tue, 21 Jul 2026 10:32:28 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956ab41a15sm2475905e9.3.2026.07.21.10.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 10:32:27 -0700 (PDT)
Date: Tue, 21 Jul 2026 20:32:26 +0300
From: Michail Tatas <michail.tatas@gmail.com>
To: Doug Anderson <dianders@chromium.org>
Cc: michael@amarulasolutions.com, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] drm/panel: ilitek-ili9805: Use dsi_multi in init
Message-ID: <al-tKjc-wAzmEOUx@michalis-linux>
References: <20260719190358.438699-1-michail.tatas@gmail.com>
 <20260719190358.438699-3-michail.tatas@gmail.com>
 <CAD=FV=Wqo8Y=NCH0HVn8diQ2q1qxh0tcYLTKNKxGL2e-He_mNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Wqo8Y=NCH0HVn8diQ2q1qxh0tcYLTKNKxGL2e-He_mNg@mail.gmail.com>
X-Mailman-Approved-At: Tue, 21 Jul 2026 22:11:24 +0000
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

Hello,

Thanks a lot for the review Neil and Doug, I appreciate the feedback

> > +static void gpm1780a0_init(struct mipi_dsi_multi_context *ctx)
> > +{
> > +       mipi_dsi_dcs_write_seq_multi(ctx, ILI9805_EXTCMD_CMD_SET_ENABLE_REG, ILI9805_SETEXTC_PARAMETER1,
> > +                                                       ILI9805_SETEXTC_PARAMETER2, ILI9805_SETEXTC_PARAMETER3);
> 
> nit: the indentation of the 2nd line of your two-line
> mipi_dsi_dcs_write_seq_multi() seems off. checkpatch.sh --strict
> yells:
> 
> CHECK: Alignment should match open parenthesis
> 
> Strict mode also yells about a few lines that are over 100 characters.
> I'm not quite as picky about that, but it would be nic eto fix too...
> 
> > +       mipi_dsi_msleep(ctx, 100);
> > +       mipi_dsi_dcs_write_seq_multi(ctx, 0xFD, 0x0F, 0x10, 0x44, 0x00);
> > +       mipi_dsi_msleep(ctx, 100);
> > +       mipi_dsi_dcs_write_seq_multi(ctx, 0xf8, 0x18, 0x02, 0x02, 0x18, 0x02, 0x02, 0x30, 0x00,
> > +                                                       0x00, 0x30, 0x00, 0x00, 0x30, 0x00, 0x00);
> 
> Since you're touching these lines anyway, can you also fix these
> functions to consistently use lower case hex instead of (mostly)
> uppercase hex? AKA 0xfd rather than 0xFD.
> 
> 
> Other than above nits, this looks great to me.

I have sent a new version with these changes

Regards,
Michail
