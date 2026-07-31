Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B6FC5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 12:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E254E10F23D;
	Fri, 31 Jul 2026 12:19:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="Y1Hb05Cl";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78AB210F23D
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 12:19:24 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so657981a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 05:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1785500364; x=1786105164; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hRCEkgyL5maguOe88SdUQWVzbN/lQncmrY8r9dbt88k=;
 b=Y1Hb05ClQShQq/y/U7EcvQTl0rR2VMwAwf+fhjlPJefWaqMGTftscEEBLV6KULsZFx
 sIVgAYSUcIBpGfIc/M1lskQDeOizTFwYtOcEysUlaRMMzm21Xo3axTv5bnSteKl5braN
 OWUqd08oJYvrpkd8HqBTEUD+rgmFp/2hoo6fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785500364; x=1786105164;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hRCEkgyL5maguOe88SdUQWVzbN/lQncmrY8r9dbt88k=;
 b=ZvIEZ285ImDjwxqiUlZ1qtmu4jjHC4Es+uMS74Tb4h0KKMfjjM+Q/0ppdl70nxEiex
 ty8LlG5aJFU35TcPw8pUOcTf/+dBsDFg97KDuVzaFQnowlLRdkyznNi0OY0SH4bwR6gz
 530MTda6/qNTjgXMWnZfTJAQ0ZmrDLjGfr5Aenr2TEEVzda2C/Nd5jz7/7BEc8KvHruY
 FjEe/u9+7WiX6WkHgyI32++XDbA4EPlo9oTR4Bt1dJOMKci8cPYKYfpfbofFHXM0iAzZ
 UYjgOGLFKXqgIpKK291uCdyprQP+bznZR4WW3DfjiTDAvf2z+osKMHdr4nDeA4zRwnai
 t9tg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2ADKiRF31AFMhTugc0/rAnR+lrgFa30KCeEVSE8ZzbN5xvOj59lmbb1O+52JrlFPW7FkOMkH6IVs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLMSF61J8O3NrHfpddi0vHtwTU8f84FyOioNQ5WM1NCCQ4YWYw
 Tsf8NjdPkZv3ysCJe78J60eDz7pkqltj4MC1qIi6JOypjDUCu3bLqsxP69DFNP6GoHE=
X-Gm-Gg: AR+sD13ucLPvzw43bqeeKAzdzeEpk48LvU6Jk0+MBduEEsIYyTw0s/u9gpovTGi0ta/
 qBsDQERavrrTRY9ekbTYkwcL33yTWWU2ZZ4Yh4GuLyH7fcs50CDX8410Hp3pUvVPk3VGAf2vo+F
 R/HcD+udRRaOaL7IMjiS9eAWhk/pnN/5uDCRP09rglDTivER598garuCxZwhh1ezMMgm13UbgX6
 ZJOKnWY0ADBKBAq+jsdTE3+ecJXNe+7ywF6IOhXdRMw0EoTUVZbYWu2ZOx0/JKNwXNe9NhkEDIC
 SfTpih14R91ucAvYi2oLAshpfzQux2LWXJA9hXqv7tqVmm3pMy+KrxnR9M98ewikMytJemSUYd3
 lIVSnvotS3GVwrNqXIZ3OSizcDwQ08Y9yX01LjFL7G5kAyprlje281AbR5ropC1lPxxHcsRo3pn
 VO39MQ1w+ih3pJWwqDAUbESzt4sZTW5tNM9/y0HfaxKB5dKAKVRKA=
X-Received: by 2002:a17:90b:5290:b0:38d:c0f9:30be with SMTP id
 98e67ed59e1d1-38fb1429190mr1671305a91.38.1785500363814; 
 Fri, 31 Jul 2026 05:19:23 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:77cc:841c:1fc1:22d4])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-38fb2b8c5c5sm321981a91.4.2026.07.31.05.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:19:23 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 0/5] fbdev: tdfxfb: Make "unbooted" cards work
Date: Fri, 31 Jul 2026 21:19:09 +0900
Message-ID: <20260731121915.3362232-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Currently voodoo cards that weren't booted by the video BIOS aren't
usable because the hardware is never brought up.

This means if you happen to have a proper - non-x86 - computer,
another card is the primary or you have a new BIOS that cannot
run the video BIOS tdfxfb would probe but you will be staring at
"no signal detected".

This series implements manually booting cards using the
values from the video BIOS' own table. Currently this only works
for the voodoo 3.

Debugging was partially assisted by Claude Fable 5. I could not
work out why this would not work for months so I told it to
create a voodoo 3 emulation for QEMU to compare the BIOS against
my code. That made it obvious my init sequence matched the BIOS
but the VGA core wasn't running.

This has been tested on a real voodoo 3 in an x86-64 board and
an Amiga 4000 with a mediator PCI bridge.

I have some patches to add an interface for doing 3D rendering
that are not included in this series and 3D rendering is also
working so as far as I can tell everything is good.

v2:
  - Fix up some poor 3am English mistakes in the cover letter.
  - Limit this to the voodoo 3. The BIOS layout is different
    for the 4/5 apparently.
  - Fixed the valid sashiko complaints - mainly clearing the
    framebuffer memory before fbcon might have bound, retaining
    the current behaviour if we can't get the video BIOS to get
    the config parameters.
  - Tweaked the wording of some of the commit messages.

Daniel Palmer (5):
  fbdev: tdfxfb: Add helper to read config table from BIOS
  fbdev: tdfxfb: Attempt to detect if the card wasn't booted
  fbdev: tdfxfb: Manually boot unbooted cards
  fbdev: tdfxfb: Wake the VGA core before programming the CRTC
  fbdev: tdfxfb: Program the initial video mode

 drivers/video/fbdev/tdfxfb.c | 155 +++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

-- 
2.53.0

