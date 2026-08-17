Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CF9C5DF70
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:01:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F87E10E3F2;
	Mon, 17 Aug 2026 10:01:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mAnmnk3T";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C93B10E3F2
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 10:01:00 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47f611b3af9so366162f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 03:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786960858; x=1787565658; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C5xJAp5EsJh4mtoVRdetKKnVuOabsV+/QbXlIN6U2H4=;
 b=mAnmnk3TO6XV+lHCSaMa6CtR5yk6ocaLTl7gwXeEKiFzlkVVgprbwHOWNynXrLHzNX
 Sn4faaLWCw9dcIXTeUQdo6ow+61gyTPR6JGtr95nhwhwUTI911qpC3u7jfFTKeVYvIrp
 eKoL40iz6Z0SraWLD83+V8jniWjy9Ntud6W8jXd2uc5ksydRl+hjn8prXZ30dahCaks9
 WGfLvkJQdj0TL7ey9Tl7gXs0fx67wbVmjnwJ8H4EFPN6cnpW4Vyv979EE2TbSOLqivIx
 FHZs1H1OjnvXIMpjQPfchMj2N3kwW6PRv2//gqbhSeqw7cuvqLm9+Ru4InyFltqsWsRO
 5wAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786960858; x=1787565658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C5xJAp5EsJh4mtoVRdetKKnVuOabsV+/QbXlIN6U2H4=;
 b=QZXMV3SX7keDIQyDo5xGChsOZ0x912ivqSOIq7V145gaDbzlpy3qVa2/dZm5cS9ymQ
 Im2aUkNsgX/DhAM4SVrWyE63YK4IRdTVTWKuPqzK9lsGFXhIL7oSzZ0oqnsag0POlgeI
 K0zfHiaas6HYfIgeJN8Wal13dLKyv2176ZRZZecvkBPTIX7/4mOGygMYPj9UXV0pCi0+
 JUikTvA5V6qm09xT1znlylmMEvRh7zKGpKaT5ud57bPRhFPWNRTUx8+8FDVeIl1wj/Tk
 92viUf2vLkOGQREmBvnY2d/9TBCMVNi5Y5+C5gQPhfHXLoTy1SNIM6EMlYEboSPBMXSj
 K5Xg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/AjHlc2f7kiAa3rNfI66oQSCSKw7mBfGo2NlQErX0ayjjSsBRwHiUHonTcoWlXdAP45tME7D0ndU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyU9YsWoulhHohhPZj3b/is9cArmmxTw1O5FgW4J560UKr7sdt7
 EMHPEJG8BFgk5UnW79ORteoiwo2P8ALFQOZfxVC/Hu92cka0p0TwJflu
X-Gm-Gg: AR+sD10fbBP9/DFRaqq+wny84oC/mm88jCE1VxHjI1IZmo70ERm41IoJp5bPjF6pLhq
 V3bGz5WTLHcxLsdFzOOAIKwsy4x8NOwL2z4JNiD3fDjoM66YuvNQFMIad2kyAe+piw0W3SCZgiC
 6qsicG5cUt5w9PY6mJeiOjeMYy3dCTSA+wJEZ5t8ewrsnOgeK+FPX2YUeOVqJvqs2vjwovPTiGs
 uRB8huxAE0aakniLUwhI4o2xO1rH4QVUFjtFpkkF7vksnDPvI0Rof7VTMCypC9O016JtcWWgj+A
 j94PeFEb7JRUF+vggyZRvj6jSbqoFV35MfjsRRtGBFuUqLi01phcRAnb1GE15s3Osz2sXMe8rCh
 Y65NfEd6ErS2dRohP9CsCX1Buq+pZReeRSJEHbsPtMzfP+TnALrijTeprJyi6Z/kmhRuJCauoRy
 vQ1O3u7rnfuKnhB8Q7BNApFK63clwy4aqknN3oHjvhF5bC2kQM9kZ3+mKoYFuu0HsFGVk3A3NX2
 mBPmEGyNFVMpO4KhZICzBZT+b0Y6lmvHsL8w/Sd2PPziw+Ad8staA83aY1Dbe5UYKjGVw==
X-Received: by 2002:a05:600c:a0d:b0:498:1371:660c with SMTP id
 5b1f17b1804b1-499878d5e0dmr175209465e9.0.1786960858323; 
 Mon, 17 Aug 2026 03:00:58 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8FC50027494B64639367E4.dsl.pool.telekom.hu.
 [2001:4c4e:1b8f:c500:2749:4b64:6393:67e4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996109652sm167889155e9.4.2026.08.17.03.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 03:00:57 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Heiko Stuebner <heiko@sntech.de>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/10] accel/rocket: add RK3576 NPU (RKNN) support
Date: Mon, 17 Aug 2026 12:00:43 +0200
Message-ID: <20260817100046.24872-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817094544.1159366-1-gahing@gahingwoo.com>
References: <CAEWPSH7ETfw2TDjUfOvcVtDm19FC43x2vP=Lh7m+XPOGptnPWA@mail.gmail.com>
 <20260817094544.1159366-1-gahing@gahingwoo.com>
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

Hi Jiaxing,

You asked for a count that is not 24 modulo 32, so here are five, on
RK3588 with upstream Mesa. Same generator and same scoring as the 56, 88
and 120 rows earlier in this thread: 1x1 conv, 64 input channels,
uint8, output zero point 0, scored against the raw CPU reference with a
channel counting as matching at maxdiff 1 or less.

  oc    oc mod 32   matching      bit exact
   33       1        33 of 33        31
   40       8        40 of 40        34
   48      16        48 of 48        40
   56      24        56 of 56        47     (16 Aug)
   72       8        72 of 72        62
   88      24        88 of 88        81     (16 Aug)
  100       4       100 of 100       86
  120      24       120 of 120      106     (16 Aug)

Eight counts across five distinct remainders. The upstream constant
computes the whole output at every one of them, and the global maxdiff
is 1 in all eight runs. So on this SoC BS_OW_CFG needs no term in the
output channel count at any remainder, not just at 24.

Controls, same as before. No channel of the reference is constant in any
of the eight models - the generator refuses to emit a model where one
is, since a constant reference makes a trivial match. No NPU channel is
pinned at the output zero point. The NPU interrupt counters went from
zero to five across the three cores over the five new models, one job per
model, so each of them reached the hardware. And the counts that are not
bit exact are off by exactly 1, which as you noted is not something a
delegate falling back to the CPU produces.

What this does not say: it measures the upstream form only. It is not a
statement about how the modulo form would behave on RK3588, and it does
not touch your timeout observation.

Which brings me to your last line. I cannot run
ROCKET_DPU4050_MOD32=1 against my build, because the knob is not there.
Upstream Mesa has no occurrence of it anywhere in the tree, and
src/gallium/drivers/rocket/rkt_regcmd.c emits BS_OW_CFG from the
depthwise flag alone:

	if (operation->depthwise) {
	   EMIT(REG_DPU_BS_OW_CFG, DPU_BS_OW_CFG_SIZE_E_2(3) |
	                              DPU_BS_OW_CFG_SIZE_E_1(3) |
	                              DPU_BS_OW_CFG_SIZE_E_0(3));
	} else {
	   EMIT(REG_DPU_BS_OW_CFG, DPU_BS_OW_CFG_SIZE_E_2(1) |
	                              DPU_BS_OW_CFG_SIZE_E_1(1) |
	                              DPU_BS_OW_CFG_SIZE_E_0(1));
	}

which is 0x36c and 0x124, with no output channel term in either. Setting
the variable on my build would be silently ignored, and I would have
reported a null result as if it meant something.

So: send me the value expression your knob selects at 0x4050 and I will
patch it into my tree locally and run the RK3588 side of the comparison.
I would want to run your oc=64 control at the same time, both ways, since
that is the one where the two forms emit the same value by construction
and it is the cleanest discriminator you have. You got one side of it and
the other hung. I can run both here, and I can also give you 40 and 72
under the modulo form, where the remainder is 8 rather than 24.

Two things I want to acknowledge rather than skip past. You flagged the
mod-32 confound yourself before anyone asked, and you were right to,
the twenty four lost channels at 56, 88 and 120 really are forced by the
arithmetic and are not three independent confirmations. And you disclosed
that the 120 modulo row is a different boot with an unrelated power
domain change and a different NPU rail state. Reading that row as two
points rather than one is the correct call, and saying so in the mail
rather than after being asked is worth more than the row.

If it is useful to anyone, I can send the generator and the scorer. The
generator builds the flatbuffer by hand and self-checks against the CPU
interpreter before emitting a model, and the scorer is your perch.py
logic reduced to this one case.

Regards,
Igor
