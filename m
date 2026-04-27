Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44D8FF8870
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 21:39:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AF1710E2C9;
	Mon, 27 Apr 2026 21:39:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gRNHOpuW";
	dkim-atps=neutral
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8736110E027
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 21:39:40 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-bb3c4d8cc29so236177766b.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 14:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1777325979; x=1777930779;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
 b=gRNHOpuWNx4Z6aAgLy1EtqgF5FFLY8DiAG+eyOdKw5ktPAp0fvMS5PTA3EY1j5BoW+
 Z6udRB3ytTirO8arZUv9DcUDKnv9usJgP4cQaEx9pbVJG5Uuf9S7Zgmojigy8UtItlTp
 CtOwBxHY6EfogmWEADk1TARlhZ3OX8J66wTlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777325979; x=1777930779;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
 b=eJgpK9B2oS9yShk7fFge5syqJRnkdlZslLbMiMn7fOmKG2xIBbzMau8LPOYpvquSBL
 t92Bqx0Vt9qBhuZIaG00Tmau6N2T6V9rdAgSV/HpHq7n+82dtTacl1/nDFzAqvFY8Nli
 gdPBxh2FeaI+sSb8EJ8ov5skCVMlk9bDDd0FC0S6qBvKo7j5i1ZYRRlZRK67lg3PkNNF
 c+h7xtolnZvQGfZ+GbPRkGa7LXsoDzlVWtBAvYmLKeJNvcLH1mpEsm95+2kzANSaB+Ba
 XVNYr16AZb74SWwrFeYsPNlhACT9Ir75mR89peJ5ilyHmzCVRopQ7mrvp8u7bGn0Z9GS
 kvIQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/CvUVldF1TPmiLB8jfOoiicXzMIeeGkyt1iuTekoRS8G7pKgHOs8sUUbQa5gJ0kKoXOmhoMIFdUcU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZpkA4zKZ74dzvS+8SugMlzmboTRjO0fPAEa1HkHq50QM+6S4s
 eBzIRyA55xLvRvMh2rNxAEth92gEPQg7laK5qh35dOSSFTcK8FuZvE4KJFQ4vb4juBE2wVYNhd8
 F2+j83JMzjQ==
X-Gm-Gg: AeBDiet+2ts5Dkq50UZaQCKQiHodgn3vKAxXCc5HlVo3cp4aEMAQTFboTuKDglKz3zR
 z+Z2DouK+RGT48U+OBm2OkVaBsNuOXTxWKeuEhV7NeYEJvupblLqp55R0rYsvZpDo/DNqgh4SU6
 R8uMN8O2t3RLj66WAeplDtojzuctGI7Z9YZL8A6pbrQ/W1UYNGuh0uyChGQfdwnLVC4IQ51vz75
 oOCzZubqrQnA3Dl/b9mX4mlx2z4jgD8+l54C/jCiOPSUWBMowpv6IepPLbC+BbS/vTEi+/3wOU8
 +smvlKFBovrwxtIWKTaAfXoPnDpu5x9WRxygVA7HmLTkGDNPtts6xrOpoSt2ZxlA3d832bZq5ir
 4r4JJArKU3eY339lUs/nmRDuPYn5CaX8rgPKGcMiu7WsIDmjxRkU4C18WCv4YZ922mp2wlbNXaB
 gVqATbF3yRxSh3t0xTaEdAsQ8/y9bMyenrBUrbnK4+6kiiPGyssp6MyeS/gH3PtYQVOtIV/ftGl
 ZJJ3JX/DNs=
X-Received: by 2002:a17:907:cb06:b0:ba3:6377:860 with SMTP id
 a640c23a62f3a-bb8020ca239mr22020766b.3.1777325978722; 
 Mon, 27 Apr 2026 14:39:38 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com.
 [209.85.208.44]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bb80853b64csm9895866b.12.2026.04.27.14.39.37
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 14:39:37 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-65c4152313fso14716972a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 14:39:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9IfhJ7SysWMTDGYyktSu2utj1p8azgDppjwt4eOVH0c2gOYT8k3dRl0zw4XKF8xKAIGZTaTtL+w28=@lists.freedesktop.org
X-Received: by 2002:a05:6402:5216:b0:679:1f4f:9d30 with SMTP id
 4fb4d7f45d1cf-679bb04c1a2mr179970a12.4.1777325976937; Mon, 27 Apr 2026
 14:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org>
 <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
 <CAHk-=whC1DZojwdMB1=sJWG2=dsCdfyU8N6tDE1qx50HRZ-WJQ@mail.gmail.com>
 <20260427222914.1cb2dd3b@pumpkin>
In-Reply-To: <20260427222914.1cb2dd3b@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:39:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
X-Gm-Features: AVHnY4I-AxqvQRk42MegvhKMp_z4sSEpEzhzpgw2GyV2bV8dezSPoI0JTlwB18Y
Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to
 copy_{to/from}_user_partial() when relevant
To: David Laight <david.laight.linux@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Yury Norov <ynorov@nvidia.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, dmaengine@vger.kernel.org, 
 linux-efi@vger.kernel.org, linux-fsi@lists.ozlabs.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, linux-wpan@vger.kernel.org, 
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-serial@vger.kernel.org, 
 linux-usb@vger.kernel.org, xen-devel@lists.xenproject.org, 
 linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
 bpf@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
 linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 27 Apr 2026 at 14:29, David Laight <david.laight.linux@gmail.com> wrote:
>
> I think there is a slight difference in that the normal copy_to_user()
> will determine the exact offset of the error by retrying with byte copies.

I have this dim memory that we decided that you can't reply on byte
exactness anyway, because not all architectures gave that guarantee
for the user copies.

But that thing came up many years ago, I might mis-remember.

            Linus
