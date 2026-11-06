Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8168B606A330
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fnP8tIDY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 802C110EB20;
	Sat,  7 Nov 2026 14:28:20 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E416F112F2B
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 17:10:22 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so6265765e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 09:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793985021; x=1794589821; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=V9n1CV17mWoyinWHCGFvDxtvvBlrLNzZtRYoJJeVLOM=;
 b=fnP8tIDY9QQHCk7G2+1R+SHU6YMinNc/9z135NwrZO7PTkMfWKwEiwTOgWBJSDvGm7
 T5Hrvhb9UtA8UuQGeBnxC1PbLj5+meo7ayWdjHgno4yGNatbbsWjdVhrx2ayKxjsBG1R
 o2w5MRdxLwnJM8jWwHWrIuRroJ6ioxePoWDdC++R4pXg0Nbw65r4MLdDOv7iD/d5sHCb
 DXTIfMREuLbCEKktAdEcSfkqclak7nywcVDPJx7UAtLmLmAF016zwmGI3s99/2GCKh8h
 roX+8QQo7jTxnqX91GOYu9d/lyLBrz2EbA1goSfED/mqyfKPM1BiKiS2wRz/HuK01WZ6
 Z+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793985021; x=1794589821;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V9n1CV17mWoyinWHCGFvDxtvvBlrLNzZtRYoJJeVLOM=;
 b=HeH2DXQUXSeJPbcBE3t2cBZoxllI8bIXrDBZFYEzJPOT9o5ZmKT4rUHRchfWZrvCer
 /fg00nbPB9S07MBUl2HcPUA8Vl0p2OaTw5qarczK6a1hoZYE09bHk+096E1eTffFTzzq
 BdxyBZBATuKO4ltuz+KmSzwIXAKP7pucVAaMvI7RU8imUCoT/fxAwFNLzX4LB/MP1WAr
 +/I54CIsOw4iSt79oi8FPa/dGo9hZTAWcfvaBeCW9P6iqDBRrgq224R8y7NrKNQvRR2g
 W6Q9PmiGocAIG89PVhk5T5R6Oy8S1CAFsOt/lQhcNp4X2UEtfcYArLOU+hoonDL8t3ra
 Kt3w==
X-Gm-Message-State: APuU4Z88lZmz99g7ptDlbwh85AYrMll6Fmv7c/2HHpYftWyjdlW/mfnq
 NOiZ4d7r2UFmbKvNzmlnnnwHVTV11wMz7VIz/cnWRZOH8nOP+QsVxDt4
X-Gm-Gg: AYBFou2FnOt028irS7wwo3Ks7RXu3361OnEF8DSC8yuG15Mz8ecbMQ25XciXwreT2sa
 cD6CboAGyfYGWHt3ppTNq0oJ5GjrNzhSRfT5k6LU5r/2K7MMi6dxlH6b2iJCkXLUedIgu5OHSTn
 0DdIhg/9gqzayiyNlG1G4RB66M/8dGbp3N0eEZK6YsnZGYu6fFAot3c8vMTWHZwoADsIkIbxGaK
 mNsr+ghVtrxm93phZO+bvjBMkXA9W2JKtAdTx/v+SJA7hTZ2ZiAD5IkDJ0QKXti5dPJQVH54QvB
 g3tZSRbXT8RLr2/rcbkdjBFjHEX6lNzJ6/Ol1bMhtT+UqIhE7LRmsV3RBXJNocqvVHmv4yxYBzJ
 QL2ke3dO9yEtkRUUIAb1f7rE3Mr4yKcXKYJVhLKPZirRpTGsbOW4klokTllFbWWzb94GLopWyBs
 2u+A0N2ucwyN84i7XR866cwUxv+/wQBWkYpKm0Y+N8VU5XJZap9tk3k2c26bcW82BRKSU+eKW6x
 eyYevBnXL/glh8QOilGTVtxi2Wau1/IhdC2RxVI/w2cVT+QrWgGswOSqT7EOyBwb7twWfGY1KLZ
 EnwkfyyE4GAx2XVrzimxTZZy3Q7H6Sbk
X-Received: by 2002:a05:600c:64c5:b0:4b0:a7aa:843 with SMTP id
 5b1f17b1804b1-4b6df4f1dfdmr55413875e9.25.1793985021160; 
 Fri, 06 Nov 2026 09:10:21 -0800 (PST)
Received: from localhost ([82.77.126.113]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b57317cae5sm238886225e9.12.2026.11.06.09.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 09:10:20 -0800 (PST)
Date: Fri, 6 Nov 2026 19:10:19 +0200
From: Daniel Matyas <matyasdaniel006@gmail.com>
To: Nam Cao <namcao@linutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
 Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Lanzano <lanzano.alex@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [RFC] staging: fbtft: Moving fb_ili9341 (and others) to DRM
Message-ID: <au4J-0GOUuueHLZe@rabbit>
References: <20261105201154.37294-2-matyasdaniel006@gmail.com>
 <874idv2bol.fsf@yellow.woof>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874idv2bol.fsf@yellow.woof>
X-Mailer: mutt
X-Mailman-Approved-At: Sat, 07 Nov 2026 14:27:39 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 10:47:06PM +0100, Nam Cao wrote:
> Daniel Matyas <matyasdaniel006@gmail.com> writes:
> > Questions:
> >  a) Is removing fb_ili9341 acceptable, pointing users of other ILI9341
> >     modules to panel-mipi-dbi? The KD233 node would then have no driver.
> >  b) Or should KD233 panel support go into a DRM driver first? I don't have
> >     its init sequence or physical size, or the board...
> >  c) Is removal of all of fbtft already planned?
> >  d) Several other fbtft drivers have drm counterparts. Should I inspect those
> >  to see if removal is needed?
> 
> IIRC the main reason fbtft needs to stay is because it supports parallel
> interface which is missing in the DRM drivers.
> 
> Nam

Thank you for clarifying. However, the fb_ili9341 driver uses only the
SPI interface. Is it alright then to move (or remove) those drivers that only use
SPI interface and have DRM counterparts?

Furthermore, would there be a need to enable parallel interface support
in the DRM subsystem?

Daniel M
