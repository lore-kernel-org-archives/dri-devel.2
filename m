Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06169C5DF8A
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 10:57:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A51510EC1A;
	Wed, 19 Aug 2026 10:57:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="p6+NYb8+";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="T3qimOPr";
	dkim-atps=neutral
Received: from flow-a8-smtp.messagingengine.com
 (flow-a8-smtp.messagingengine.com [103.168.172.143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5ED210E54E
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 10:57:31 +0000 (UTC)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailflow.phl.internal (Postfix) with ESMTP id 0C83C1380202;
 Wed, 19 Aug 2026 06:57:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Wed, 19 Aug 2026 06:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1787137051; x=
 1787140651; bh=4ZWUv0XJBJ4DWMN3R0oWm84PCPuREepeCO7+TGqNras=; b=p
 6+NYb8+P+XDdInqzyPfsouqDCthXlpYMmEVVfuqJkHd0cAbNOUz9zFjk78+tiWuL
 gtCYZXD3NqmsiA8Ztx34tV368/eX2DJQtNDTjGQJDVmb/XcOO2OTX28SAfqYSLSa
 FXWZx0xT9KThETkFx+A9J2SF8rJAe4+6WTxnAVfwvNHqnfZp2thA+KbM/7oS7Lry
 XyOtdEynR+sV3lKE8zeYNefCuCQzWjCfiHLAT9a+yhzATx8FZEu6TVzsH7ijImDb
 /qd9BIxlZtXGvHRanaDAL3Censb6UeVcdfFc+A9igG5Brm2TOFnivjqsYNpJWNSB
 /nE4hbSdd+boR4iXXczpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1787137051; x=1787140651; bh=4
 ZWUv0XJBJ4DWMN3R0oWm84PCPuREepeCO7+TGqNras=; b=T3qimOPrG9Ob9da/e
 7mr8XtYYsxXkg0AnHhTd/WIAqWA/s+Ogf7hLQ2piwJG7reOSsc64XbMSbqDaGYAC
 yusM8VQaOkVYZn4P+Wfkc6Di6xS2pKo8H0hqSRCl+/FtXHxHfaixB7kWFfCL3RNY
 pn20VVHSNyoB7FOObiwcjXplYfT1KsEb48gK+jqZKAGXsTYXaQ/9NSajBKKohK+q
 uWgFAjfVJnOttULaqiYfVMGXMaOrvJ1b7VILYx/XffgHymFQOQGHBnF1DfKsOviT
 B3MTU8LnuASESbSbj8ROUT5cBUXm2XvtvgQR/1ItMqp0vYKPIBn9lSv9VEISwq0h
 y6gLw==
X-ME-Sender: <xms:GoyFapo1qGQWzd5OYK7CCNGirlzCC6O1Rns3_TLTglwPHvEfln295Q>
 <xme:GoyFaj0_MbTwRyLxQuPz3eit5g6IJv81rx0EpHla97QeSOY07TRXWVRxD01r10QXT
 6sZwnxfb-ZgitL0vBS52jFSg68ydadAfMW6DwOEz0sgvA0EozxM5Gc>
X-ME-Received: <xmr:GoyFahx9f7MbRPLnnV9ffh-L5aDyhm4cLCaUqCk3gI8G0CJP0ybauZZrfYu-uOUonr9hkY6aLg>
X-ME-Proxy-Cause: dmFkZTEG+L+KrrKuCpQ8O/E2FuOjLE8Rj74+FZgVz4tR1VVH3Ox+RhCBaXOP2m3llBN6G2
 vc/El87pQJ+KQqXesucf+bxtBpRsHti91F73e0ERYuNjuW6x1qovLXaWK1tBuTRx7A+iKf
 yHgv72a5l0jMWBzzMapHratPD+BjSi75dXMZgeCDmrAWnGzBXc+9c0Gcz1+xZGy20fFYbd
 Rr51V7uf6YLv8xMAGwfBbyHg+buCU+daNK30nOohfpyICLHRqjbQ9nuJMBZXMaNRsXeZRS
 wqOzfLeCmOtBZf6hZLJGpIDsAdFxBpyEFeou3naIwW7L05rr6siVn5/7bHOx0dNnXiLTd/
 qmUyRv4W4Pnz10WOQ96FI2HSLzTCZthYs3QK3Et04ri+cyb0+ej8W99aEc+HvVraBF8LIZ
 b1Ly/w7143PEypNDIFSEN8SM/zwnNAXb9FfRZo51edj1mhMK2fVw1QPrDlQPGmXh0LZaS2
 QR1hTCymtnncWjeGcJYfMmB3VjIQs1eBlDn27+RNFZjrq5o1fOBkcur+mPp4j10AUDNb6h
 1ddbJ6NsIbhDabP20s1hlYm0W/IiqcXVC92RNX5Ps8f7XY1rEPzJHhMCaO/ix1iUPP+Tdb
 r5EhUcjrAolMdhFCf840ouGAgRvZnWu7sy+b8K4nCpyLmWCSOABzaol9dikw
X-ME-Proxy: <xmx:GoyFavjy9_dNLn_RRBywzz8EANgH5Dq1dp8vRP7mZ-A7nw8PIXDBpQ>
 <xmx:GoyFakqHy1zqWDaOzdgvPX-uVBptClt-VWkYcQ7Ojo7n-r0PkwlUCg>
 <xmx:GoyFamjpUTk_9_CZQuecX4qYNsTn5iAdbGqTfqlhJ7MnlImpTrRrCQ>
 <xmx:GoyFamPsPitNMW1b8N0wNPJahHob7-zVab8om6thOZVnuhbBiPMJvw>
 <xmx:GoyFaqJb-N08trkI9dcyejKTwIwFR3UTJGXxfV33I15rATP6kSO9Ae-7>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 06:57:26 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: royalnet026@gmail.com
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, chaoyi.chen@rock-chips.com,
 alchark@flipper.net, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/10] accel/rocket: add RK3576 NPU (RKNN) support
Date: Wed, 19 Aug 2026 22:57:23 +1200
Message-ID: <20260819105723.632029-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAEWPSH7ETfw2TDjUfOvcVtDm19FC43x2vP=Lh7m+XPOGptnPWA@mail.gmail.com>
References: <CAEWPSH7ETfw2TDjUfOvcVtDm19FC43x2vP=Lh7m+XPOGptnPWA@mail.gmail.com>
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

Hi Igor,

I owe you a correction, and it is on the clamp.

I wrote that since the vendor userspace on the same silicon does not clamp, the
clamp had to be mine and there was no hardware behaviour left to appeal to. The
first half holds and the conclusion does not. The output stage is

    byte = clamp(max(requant + L, 0) + offset, -128, 127) + 128

with the floor applied before the offset, so a negative requant is gone before
the offset can do anything about it. That is the silicon, and this driver was
shipping L of 0.

L is the output zero point, which is the smallest lift that clears the floor,
and with it the expression collapses to clamp(requant + out_zp, 0, 255) with the
offset a constant -128. On hardware conv2d-cal went from 0 of 128 channels
against the unclamped output to 128 of 128, and every model whose zero point is
zero came back byte identical to emitting no lift at all, which is the control I
would want to see if someone told me this.

The reason I am not claiming to understand it, and it is a real tension rather
than a detail. If the vendor compensated the way I now do, its output offset
would be a constant -128. It is not. Across six compiled .rknn, DPU 0x40ac
reads -2, +9, +17, 0, -128 and +10, which is out_zp - 0x80 exactly, the same
expression this driver used before the fix. A floor that is unconditional in the
silicon should therefore pin the vendor's output too, and measured on the same
board it does not. So either the compensation is somewhere I cannot see, which
would be A, since librknnrt builds the coefficient buffer at load time and it is
not in the .rknn, or the floor has an enable I have not found. My model fits
everything I can measure on my own stack and does not explain that row.

If you can read A on RK3588, or force an output below its zero point there, that
would separate the two.

Two things I should not repeat at you. The 88 and 120 sweep went out on the
17th, and the reference argument is older than that. I lost track of both and
nearly sent you a mail announcing them as news.

One thing that column earned. Scoring each MobileNet operator on the board
against exact arithmetic rather than against tflite puts every one of them
between 99.93 and 99.99 percent of pixels identical, and the per operator
figures chainmodel.py predicts, 4 of 128 at operator 6 and 34 of 256 at
operator 8, came back exactly on hardware. Your reading rule was right.

What is still genuinely open on my side and unchanged. RGP_CNTER 8, OW_SRC 1 and
the two in the reserved range have never been varied one at a time. I said that
would happen before the Mesa series went out and then opened it anyway, which
was the wrong way round. And of the discriminating counts, 20, 50, 60, 90 and
114 remain unrun on either SoC.

v9 is ready. I am holding it to let v8 collect more review rather than resetting
the thread, and I will say so here when it goes.

Regards,
Jiaxing
