Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B667FC61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 11:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2660610E49F;
	Wed,  2 Sep 2026 11:04:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YbOR2SL7";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4AF910E49F
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 11:04:52 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-499c0879d51so746135e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 04:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788347091; x=1788951891; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GTGAL2LK49DXmb4kTFlr75XQjH/03+yuaF3FJpUhzoQ=;
 b=YbOR2SL7Vgmm49/vXwgi3keEHZfXQmT4CwDnVdqk9VQ7B7u7w+/r5+0fER/0rWtX2p
 klwHvHG5FPqLDHR7JduFDopniJ9Zg/W5gWLLZAiJlLiUwv7XLOk026UTuwrH5U9zaM5c
 zclUMuTJORuff4yu331dyplGMWXxB0ytS5OUC+QQLt+PlSlKRkHafhIjTwlupITTyouG
 w895xIFaDDZ+Dx6kre1zMPkyYMcQPiLwgXO2Y9U1fac/pY35kBQBzWAXxLgXD+uoN8Bl
 7tRx23aPKPUfXloxKbrI9YxuwY9qnv0wL1cNlJxondYvU0sqQJl4Lpj7pPSgw1MSPXAD
 FXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788347091; x=1788951891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GTGAL2LK49DXmb4kTFlr75XQjH/03+yuaF3FJpUhzoQ=;
 b=NFfChFoQjuk0o1s8W5bMZo1Ko6zlFZ9MEu/NkrJvuKRFev6W17tB9tK5w4ThULM9kb
 ST2rjZxFN+uVq7Ra+tiPD7d7Okv64Hgf1lZKhgdUNY1wNUtCNCUXV+y2sgTx2lXWYNG7
 sAwaI9IrqwpnChoz7sjd5AtVOIWjCFSuiP2qf3VDyEqNry2wqrdkJp22NArePg+f/8Y8
 nUgqMoVLMI4/9p7mefIqMWlp/ZLIT7C7Uu0CsU1L4W2IxUZnDTrkhryMwma4u6nE+EEi
 XELHaB665xmSOPiX8nEPNRxrN53n14n5mY9GSiDvr1KYjKRLDwU39x6sTRjK35CBSBZ2
 KjKQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqv7NMda5HvtKETYPcvVpxO5z8Rzp6BrcgMcqwYAT9j0Y8bXwTPQNitUWGwxzlmR6Ve+JvZUqYy0OQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++np3yMsTFpQiDcyv1c8BVyDe5u1sDsqBRIdCVoYGoRuxDa4RAL2
 yjOKyXlAbGdWIdCEc5wvud2kw595g4qGRa+78l/yVfNPTUhCMxLO891P
X-Gm-Gg: AR+sD111EmkfgbUMBYZTVflfTnX7GYCvKehmEdnBN2U5QF2CofNxPaK4yOiwV+CWEvt
 txHIFMLF6DNk8FMLCm3qtGYbB2VUBere9K+42ArwwwHhR98Ct3Za0uJQ/N6av6+oYOHlWlmkLAo
 GcXou3v721OpfeF5yBUkinxWh6AKa7LhS52dlIE7SC8hNp+HWy98EYNvG0CzNxsg2BP/XZ7QS42
 zbzXK/wg+LEQ8S87VHWCOwqyyQRGvUdE0rknmw2+LeWszLBS0LDJUkq91OLImj9Jpt4RfHe8rPw
 ssSxN5xrO5ES9YSn2vOeKoHVuKkGnSevvzTd4C1/MnSqsQNCHbmtDLfDoiGptRPAiJ3JVwJqdvJ
 HOYRbGQuCJ4ABeAQrCaP5iX+Fa8uvHy5aBvFG6XNg/FzLo3ZFIEjzgDQyCFwHm2uY2798XFiuLZ
 H9idMftq6IBv6Gasb71EQ4T/mt0VvA9kNKcLXu1QdiIjWYeapz2uddvb5op+oCzYlNHUA2Pwm7f
 PtHRn0juvJomaAzW/7dIAF0qTLH5Yr88eF4SizyTgwABL1gNJ2if3mXBj+7uPQft2EOquqlBqfi
 EI0=
X-Received: by 2002:a05:600c:3b03:b0:49b:910c:76fb with SMTP id
 5b1f17b1804b1-49ce58252e3mr32581935e9.2.1788347090765; 
 Wed, 02 Sep 2026 04:04:50 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B831700C106E30F6C827C62.dsl.pool.telekom.hu.
 [2001:4c4e:1b83:1700:c106:e30f:6c82:7c62])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce309e418sm83442895e9.13.2026.09.02.04.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 04:04:50 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Huseyin BIYIK <boogiepop@gmx.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Nicolas Dufresne <nicolas@ndufresne.ca>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Heiko Stuebner <heiko@sntech.de>,
 Jiaxing Hu <gahing@gahingwoo.com>, Oded Gabbay <ogabbay@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [RFC] accel/rocket: DVFS on RK3588 - a hardware constraint,
 and some numbers
Date: Wed,  2 Sep 2026 13:04:27 +0200
Message-ID: <20260902110432.22069-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <f5241666-9657-4f49-958f-476fd366e408@gmx.com>
References: <20260801131656.58450-1-royalnet026@gmail.com>
 <ad1e526e-a4cf-4c34-88ff-1884ef2f3dfe@kwiboo.se>
 <286e8418-fae6-4979-96d1-e13abb04b3a1@kwiboo.se>
 <3204a0d0-969d-4ac6-adfd-29c57f1c3e0a@kwiboo.se>
 <20260819125932.5853-1-royalnet026@gmail.com>
 <82c8b17e-7215-45ea-84d1-9991ba6fb541@kwiboo.se>
 <20260819184807.6665-1-royalnet026@gmail.com>
 <f5241666-9657-4f49-958f-476fd366e408@gmx.com>
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

Hi Huseyin,

> No you can even read them from userspace with mmap. i think there
> is also a firewall configuration where you can restrict the access
> per ip core, but default configuration should not require any EL
> escalation.

You were right, and here is the number that proves it. On my daily
kernel, from plain userspace mmap, the GPU PVTPLL counter reads:

    GPU_GRF+0x18 (STATUS1) = 0x412 -> 1042 MHz measured,
    at the stock 1000 MHz PVTPLL operating point

so the written rate really is just nominal calibration, and the
actual ring runs 4.2% above it on this sample. One detail against
your note: on my board the live value shows up in STATUS1
(OSC_CNT_AVG), while STATUS0.OSC_CNT stays zero. Thank you for mmm
and for the TF-A pointer - both did exactly what you said.

The NPU counter is another story, and I can now bound it tightly.
With the ring alive and clocking the NPU at 1 GHz (CON74[0]=1,
CON0_L=0x103, length 12, CAL_CNT=24), NPU_GRF+0x24 stays zero from
both kernel ioremap and userspace mmap, after eliminating every
lever reachable from the non-secure side:

  - counter input select already xin_osc0_func (CON74[4]=1)
  - REF_CNT (+0x1c) tried both as found (0) and set to 0x18
  - every gate bit in CLKGATE_CON(27/28/29) opened, one register
    at a time and all together (27/28 were already fully ungated)
  - CON registers read and write fine throughout - only STATUS0/1
    stay zero

The GPU counter counts out of the box with its pvtm gates closed,
so none of the pvtm clocks are the reference. SkatterBencher's
rk3588-tools hit the same wall ("NPU PVTPLL is not working", with
the sel flip left unimplemented), so this seems to be a wall and
not my setup.

That leaves two candidates, and one of them is the firewall you
mentioned: either the NPU status words are restricted for
non-secure masters (per-ip-core firewall), or the counter is
simply not wired on the NPU instance. Have you ever seen a nonzero
NPU read on silicon, for example through your d2d6928641ba
get_rate path from EL3? My next step is to cherry-pick that commit
into my BL31: if EL3 also reads zero, the silicon answer wins.

Jonas: the GPU result above also answers the OSC counter offset
question from the pclk thread - GPU STATUS1 sits at GRF_GPU+0x18
and counts without any setup.

I added a GRF_NPU catalog entry to mmm while testing (start
0xFD5A200C, per the TF-A offsets). Happy to send it as a PR if
you want it despite the dead counter.

Igor
