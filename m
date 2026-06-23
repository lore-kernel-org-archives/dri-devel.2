Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F97CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43A7C10EA17;
	Tue, 23 Jun 2026 08:50:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="YVS+Hz7U";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F321E10EA17
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 08:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782204625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BuoRitIZndRdwR/IA+zUZeOYUkqVtr5e2wU2WIH4U+g=;
 b=YVS+Hz7U8F9d9rj7BnA4z+BzVB+g0apBKbVVieZPywox+7O0SzCfGPZ9jfCxdTAVUZ5HL6
 nctU/nkmmPLS801t1bdx43e0OZxAtS1QDxPCU7c+XZ/pCOb6I8Y7L2W4n4SfKP6yUr/tTo
 N+D/Hny29EaK/IUq049Xflifyk0UJ2k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-qdy13TreM9CCo-N5NjAy3w-1; Tue, 23 Jun 2026 04:50:24 -0400
X-MC-Unique: qdy13TreM9CCo-N5NjAy3w-1
X-Mimecast-MFC-AGG-ID: qdy13TreM9CCo-N5NjAy3w_1782204623
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490b0682d2fso39935375e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 01:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782204623; x=1782809423;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BuoRitIZndRdwR/IA+zUZeOYUkqVtr5e2wU2WIH4U+g=;
 b=JuI7VtpClBxek+sv7hJF7+ySbZOwup+ijG6MDLP+rdPorw5flHggKT1WrKt8rjFX2R
 9eBSU52NtrPw0dn8Cu6uXS0q4+QF7y5tnnDRnDqq9s5ZQJZLfWZEdEl/Sj45eGOutx3a
 F+T+u8RfsxEBwRmFcimgBeSe4V/g9vT76OIjWPJ9MoG/9/fsvVD6jCveaIxkFT/Ez27d
 cOFwR8BO9Kli7b8bJdbCS/BU0+H325k4TQekxHmrQoMZ6AqhqlDBRT3ByuN4ugxns/GS
 6Bj+mvoXiLVBk4yBXF7hp05oNwWL6wCx4UeF3NDgVM+V3SnAQNs1uJKs88NP4jXOyBBx
 qdgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/aGinW8leq3j51DSaGkGkqFqkrKLM7ZmMcLwTtp/z+/IOx4C/iDeY9XekhEvFkO/iWxgjUNpCTLuM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzG4T5K1e+9aFzwYbX81vKPz5+VhGVc87bkWj+mwqdt3FAh+r0y
 /i9idKVBQo18OZx0+7kRv/RzigpOtT/Adozxdz5w8tbuIEtS5Pa09Seqv/kcdaqUaoi2814/2TH
 n1gwf9WSVnhnC6ATLkgke3Wz3/NcIDyhA23e9bgD1oE003U0DUv1UkVju3GKgLNfJAQ3jtw==
X-Gm-Gg: AfdE7cmEbHzbcyWoXNZj48hy3D+L4bW4kPzuNuLYu+Kxybw2zqda+wCaiBa7yMDlfGS
 CppUUkOzk0n5pQZmUsddQK14cnhFOf9OTy/nDSlf+H0cgQMyxMp6TkvPbzQ2H5UB+yJYnQpNA06
 dv+ygpdvTeTJkxA32LN1Rmy5z1upaxqLiNerrOdu9+9Ny61be0CLw1ypC3Bs0ySyfRJ75Ddcc6T
 U2tgl/reSbz1sIH17ZE8Y9nFXWdarNm14gP/0kYBXsAD3r2wlbVcyUP1hy967LgTb3vY6K5ofAZ
 YbHrqjXwNPlY9rd+UDacPDZgIPF7S3/7wFXSU6Aa/ulqAne4yGaXtJY2kNlx2Hkuu1re8TqvMIm
 PyyqNTWVkatVVMwjHmeBRuFiEpFJWAcNIixQpzPr8exvfAscnAxx1VJjoycDMb8RuLK+XoQ==
X-Received: by 2002:a05:600c:4503:b0:490:50c5:8153 with SMTP id
 5b1f17b1804b1-4925b3896ffmr24629445e9.2.1782204623023; 
 Tue, 23 Jun 2026 01:50:23 -0700 (PDT)
X-Received: by 2002:a05:600c:4503:b0:490:50c5:8153 with SMTP id
 5b1f17b1804b1-4925b3896ffmr24628745e9.2.1782204622485; 
 Tue, 23 Jun 2026 01:50:22 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923ff8a9e3sm389322615e9.14.2026.06.23.01.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 01:50:21 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Amit Barzilai
 <amit.barzilai22@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 gregkh@linuxfoundation.org, deller@gmx.de, azuddinadam@gmail.com,
 chintanlike@gmail.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 4/4] staging: fbtft: remove fb_ssd1351 driver
In-Reply-To: <ajpGy7K4eM8oJIfD@ashevche-desk.local>
References: <20260622152506.78627-1-amit.barzilai22@gmail.com>
 <20260622152506.78627-5-amit.barzilai22@gmail.com>
 <ajpGy7K4eM8oJIfD@ashevche-desk.local>
Date: Tue, 23 Jun 2026 10:50:20 +0200
Message-ID: <87ik79iqsz.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ypYoJoydHJj-OYuadi2L__nl2Q1oFUL4TmUIhsePH_s_1782204623
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

Andy Shevchenko <andriy.shevchenko@intel.com> writes:

> On Mon, Jun 22, 2026 at 06:25:06PM +0300, Amit Barzilai wrote:
>> The SSD1351 support was added to the ssd130x DRM driver. To avoid
>> confusion and irrelevant updates, the staging fb_ssd1351 driver is
>> removed.
>
> NAK, the fbtft has two drivers in one (SPI + parallel), plus as Maxime said,
> it has its own binding.
>

Yes, I agree that we don't want to delete the fbtft driver.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

