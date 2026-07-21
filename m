Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695B1C4452D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF80910EB8D;
	Tue, 21 Jul 2026 22:11:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bT4kgFOd";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 761A910E3CA
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:39:47 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47f703a9d05so1950026f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784666386; x=1785271186; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1eC0x+8qZxdiA6PkBx6wdsYN4w8frL4bj2W3YRL/T0g=;
 b=bT4kgFOdiyU+I65V82fyN11diMEJF4rciaS9jm7qjrC9xb/PmofLyd/2+hPFXt4O7S
 dFf/+Id/ReTCWsxEx2zSBcvIbOGUQCIXbZ5vAoaK0xPczJ3qmkVgMpz1gPMRHIaj7ijf
 3qW9bJMGXELqz6h9heDGQ8RAGFYT0B6Rxx0nWJlFjmAqL3j7IITCnFyfvvETOU031jw5
 IksAqVqLWzcqyKDbnt3ibkOq+KYP25/gLpaH0qhTzJhGbSq+3tkhoPSBaXOKJQne7onF
 /4yFaLfeJveVYloikI2APTMy5gHpi+qUcw7/hGz/OgoSP5xQ2F670QMuZMfDYYXZkcrd
 anVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784666386; x=1785271186;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1eC0x+8qZxdiA6PkBx6wdsYN4w8frL4bj2W3YRL/T0g=;
 b=FLumlBH/fyzwDTDZH5MGKboqra5BSP/IQ/50/noMyn3qtR1Zkgl8S6zpwOlLgDyUse
 5g0MAr4jKzc7aTDMfYPZUuveDW+G+wGMa3H7n+z+z6aCECx2m0c9FfZ41tTrcckCgQ15
 OxGNpxoeC478pKEmnA6HM3LWsrUbPcbV8vmYGPHG6D0CKoa1Ha2MLRpcax826df6ojf3
 i5pLqLU4l9l7XtMo1h2+WMBCEVSXuuxbUdXtwQ+AGp+9GMeAoHDbj1VWHSXcGS0XepQy
 d966KSSSHNFYawWidh3vrssHbuJaLfJrI7ObgkhExRIzTWsxXOZ5rnD2l5o9405MzhJG
 ejpQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpBHAojf+BeFp76wX7gG2TpF6usJkNw4jYDi4a4KlxkkNDxOUqX7XQvjSzMbe5knOtCyv6ke04QVNA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywu+8p6WQzG9LIPPyUSyPQ8wuEWcEr2pxK/lkYBFdpHHD5McsDd
 RAPI6CN2DZ+RBBjE3Nd9EkgnvWPnh58G4pIOaftYYbylWYuDv2ithL0l
X-Gm-Gg: AfdE7cmPTK5AgyvR2fPHkOQ2EqnWCo/mKJNXjs5MtWwickYgwx9V/2siNdMTcyrjL/F
 vEBTVBIAH3Yteltpe1/ILlqM6pOEHCnrKG6aUNvfvxhx76wQRRJKZBtrTan01yeu3EnxtghQ0kS
 m7etBjpep9qatZ4qGpM+5+/LiIUTs+bWfdpPICyVXB+lG1FGTrfgHQ3wXjAcktLlIJ8u99mPNqn
 4DLZDi7ficO29IjrAlLRpDdMfqvAWgam8JikNit65MF34n5ZLaSw8ClMLW23KKD+IRwa3TMslyk
 XYOy+fBdVgalCpSxyJN6hSqsfoFl0ZmrIX9gHnAEtDB2+BiYhj8h8bzhlXTz1AUwoltQxD8OMjg
 yg76JONIgjcvF/EX8gNt1xbjIjY5RVPGD7dG1RHf5vuC4bpV7LEwO7xkWbbstI5qDA3OUZbSkkk
 iMQ8FGokAUuylLi6e4QltpdU16ZxFtft9pIvTpVQ==
X-Received: by 2002:a05:600c:524a:b0:495:5a0e:6d8c with SMTP id
 5b1f17b1804b1-4955a0e6fa1mr148432705e9.27.1784666385617; 
 Tue, 21 Jul 2026 13:39:45 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b030a64sm5090805e9.3.2026.07.21.13.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 13:39:45 -0700 (PDT)
Date: Tue, 21 Jul 2026 23:39:44 +0300
From: Michail Tatas <michail.tatas@gmail.com>
To: Doug Anderson <dianders@chromium.org>
Cc: michael@amarulasolutions.com, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] drm/panel: ilitek-ili9805: Use dsi_multi in init
Message-ID: <al_ZEMZ-KEX-MJvy@michalis-linux>
References: <20260721172715.602196-1-michail.tatas@gmail.com>
 <20260721172715.602196-3-michail.tatas@gmail.com>
 <CAD=FV=XoyaqCwXCQagxmeSQKZi8nW2R-g8f8UpFFk-BHXq0OcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=XoyaqCwXCQagxmeSQKZi8nW2R-g8f8UpFFk-BHXq0OcA@mail.gmail.com>
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

Hello Doug,

> > +       mipi_dsi_dcs_write_seq_multi(ctx, 0xbb, 0x14, 0x55);
> > +       mipi_dsi_dcs_write_seq_multi(ctx, MIPI_DCS_SET_ADDRESS_MODE, 0x08);
> > +       mipi_dsi_dcs_write_seq_multi(ctx, MIPI_DCS_SET_PIXEL_FORMAT, 0x77);
> 
> You've already got my Reviewed-by tag, and I'm planning to merge this
> patch as-is. ...but my AI happened to notice that the above line could
> be:
> 
> mipi_dsi_dcs_set_pixel_format_multi(ctx, 0x77)
> 
> ...so I figured I'd at least mention it. ;-)
> 
> My AI also noticed (yet another) pre-existing issue that the "name"
> field of "struct ili9805_desc" isn't used in this driver...

Hahaha AI's like finding stuff like that, good catch.
I will include these changes in this patch and send a v4.

Regards,
Michail
