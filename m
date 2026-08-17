Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFFCC5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E89610E3F4;
	Mon, 17 Aug 2026 11:06:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a72IcK/h";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2E6C10E3F4
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 11:06:24 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47c2ae992beso208604f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 04:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786964783; x=1787569583; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6OwP5HDWaliFgti3Iscv9ilvEY9jqmGVYGbAyk7tFDg=;
 b=a72IcK/hSw7gOOCDhvuReCj4/NQ+I5lUFvblJa6VBE0nzW8y6q4O9RtS+YVB1izkkJ
 fEAlWcnIqgw37+Waa7QxzZqVTchGN/cTUlJt4XX4QnL+YXFzbnJw6V4AanHRl5p1mIwN
 QlRYUxxq+HrD92p3HuTkjLXTiLnpqxHJNnYmzqHfn7SSR9bTshJgEWwVdbVKBIQWEeZi
 8XuTrBqgfp4MwyqcMeoeMgN8kjTvhi+13ARAgDgZfDw+moW5OMyC6XoRmAFF9Q8XcvTV
 E9191noRvyQPIuvem0d98pCrXr579q37aBrCL2KVD3ceNxSl27r4+tSutVnBo3E5hjRM
 de+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786964783; x=1787569583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6OwP5HDWaliFgti3Iscv9ilvEY9jqmGVYGbAyk7tFDg=;
 b=djnf+t8UbcNjZWeDipOHx5zDKCIGhK82ue0nedE15EuYXv6s3zpCQUA1Cds867UvVY
 4YJ6qMvI1V6o/J3ILdhqWVWsAu7e6VpDiSVaAz9184lPDvpZrE2Ofea7TN34+zUnABOv
 DZwykEvlxbzNPSjpcHIrmug0pNtnbr580BetC4xLUJlqzT0uL76as3W9ldBWoQykOCpV
 biLgKuygM1Yg8Ok4UrNf6IRBXJ33/j5vMwOmFi2k41LPbj45wzHHLI+E1rYs7vAPWEB3
 pINO9bYi7jrdGOZr7c210DlN/EWHLSOYKNfYs8/ZARt/X5E/f27ekm8KY5/Swt9qM7Ut
 ARJg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpfXN1+MduwYtWBJ0lu9vOFF4Mz3z5yvogv3nLGfXA2WLRZt3yuWRrib6A+BfnN/7dHtfxOCEet43w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxEYphbS7rAs3DKYruGE+hJzLgnMxdfzIJPciauzw/0zf5Bhrdu
 ncY4NOTK9fqI6FpwNYRjdV3Iz6Kb6hisNuFrQJ3kUIpamLV1otVUBF8K
X-Gm-Gg: AR+sD13unkGcljciTBcqbZZNipjeotBkXd8XodFW3d0dzmaAI8zFxdHAen1Oi5BCob4
 3m0zzJGWof85unVRODwnZ3QCZNw7uMEuBE44gIdX2KgYhCo/T7FVXL9rlkMk3Sk1WOefWXArUyC
 fflz9+OoOpHpSdjuUXvj5Zh0+nUse9t8IYzuxeinMvidvuRy1Q4KW9B7XE0fjzUmwJnhmJ37Ai5
 yH0vVdEIQZNwlfNzIwitCK/zx9+viy/VtaeB45WD+3cDBYErnDaCI1+NzyM2s4OQObOE/UkRTsv
 Nam2LUM0c1O5MbZArZkxtK2WNm2JifjUoAedbRrO/QsxFO6EZYKa8NzXJGNYeilQMmbw19+unHa
 V0lNoVlvNYy3yUNYGm1dfWcHcMRnjvg+/YI2wB1+WSJrM2uCPFxbsqp1h8RtUU2CTaxj/Cqg6Fo
 pH9vU2E/+YWoZFosPvCS3VyWE8Bet6DfprF/BQskNMdxOH/AIJ8+QmpVlXiLC8oR+58vNYFJiqt
 LUmg8YkaB8h9e4IhzapXT0AkUCbBWnql1xlpGqIbwweC9/pDfqr41lfWfjqnpf/svb0HQ==
X-Received: by 2002:a05:6000:2585:b0:46f:7d90:8124 with SMTP id
 ffacd0b85a97d-481607738d1mr17922081f8f.2.1786964783101; 
 Mon, 17 Aug 2026 04:06:23 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8FC50027494B64639367E4.dsl.pool.telekom.hu.
 [2001:4c4e:1b8f:c500:2749:4b64:6393:67e4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b43dsm2982833f8f.12.2026.08.17.04.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 04:06:22 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Heiko Stuebner <heiko@sntech.de>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/10] accel/rocket: add RK3576 NPU (RKNN) support
Date: Mon, 17 Aug 2026 13:05:53 +0200
Message-ID: <20260817110556.31613-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817102021.1226525-1-gahing@gahingwoo.com>
References: <CAEWPSH7ETfw2TDjUfOvcVtDm19FC43x2vP=Lh7m+XPOGptnPWA@mail.gmail.com>
 <20260817094544.1159366-1-gahing@gahingwoo.com>
 <20260817100046.24872-1-royalnet026@gmail.com>
 <20260817102021.1226525-1-gahing@gahingwoo.com>
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

Thank you for withdrawing 40 and 72 before I built anything on them, and for
the field table. I checked the table against registers.xml and it is right in
all eighteen cells, including RESERVED_0 = 34, which is bits 12 and 16 and is
not obvious. I also confirmed the part of your reasoning that matters most:
your two words XOR to 0x100, and 0x124 against 0x80011111 and 0x024 against
0x80011011 both XOR to 0x80011035. The five-field offset really is common mode
across the two arms and cancels in an A against B.

One thing I cannot resolve on my own before I write code.

You wrote: "Use your own constant with bit 8 cleared instead, 0x124 where the
predicate is true and 0x024 where it is false." The merge request line you told
me to take instead of your branch reads

  R_DPU(0x4050, (DIV_ROUND_UP(output_channels, FEATURE_ATOMIC_SIZE) & 1)
                   ? 0x80011011 : 0x80011111);

which puts the SIZE_E_2 = 0 word on the true arm. Read with that predicate your
sentence gives me 0x024 at oc = 64, where your merge request emits 0x80011111
and current upstream emits 0x124, both SIZE_E_2 = 1. Read with "the predicate"
meaning output_channels % 32 == 0, your sentence is exactly your modulo form at
every count. Both readings agree at every count with oc mod 32 in 17..31, so
your five discriminating counts are unaffected either way. They disagree only at
oc mod 32 == 0 and 1..16 - and oc = 64 is the count you said you most want.

So, concretely, so that I do not guess: at oc = 64, do you want SIZE_E_2 = 1 or
SIZE_E_2 = 0? And if you meant your own form rather than the merge request's,
send me the expression.

I would rather we name the arms by value and by count than by the word
predicate, since it now refers to two different things in this thread.

Now the part I think is worth more than the A against B.

I went looking for what SIZE_E means rather than which value works, and I think
it falls out of the padding. In upstream rkt_task.c the output channel count is
padded to a multiple of 32 for the normal case (line 87,
align(MAX2(oc, 32), 32)) and to 64 for depthwise (lines 88-91), and
FEATURE_ATOMIC_SIZE is 16 (rkt_ml.h:18). So the padded bank is 2 atoms of 16 in
the normal case and 4 in the depthwise case. Upstream writes SIZE_E = 1 and
SIZE_E = 3 respectively. That is 2 - 1 and 4 - 1.

  SIZE_E_n + 1 = the number of 16-channel atoms in the final output channel bank

If that reading is right, your parity predicate is not a fit at all, it is this
same statement: I checked over oc = 1..512 with no exceptions that
DIV_ROUND_UP(oc, 16) being odd is exactly the condition that the final
32-channel bank holds one atom rather than two. Odd atom count means a
half-populated last bank means SIZE_E_2 should be 0. That is the reason you said
on 16 August you wanted for the field, and it is arithmetically identical to
what you already wrote.

It also explains why my eight counts said nothing, which had been bothering me.
Upstream hands the padded count to the write path, not the real one -
rkt_regcmd.c lines 201, 226 and 247 all take task->output_channels, and only
ORIG_CHANNEL at line 225 takes output_channels_real. So on RK3588 the final bank
is always declared full, the atom count is always 2, and SIZE_E_2 = 1 is simply
correct at every remainder. My five new counts could not have discriminated
anything; they were confirming that upstream never under-declares the last bank.

And it predicts your losses arithmetically rather than describing them. An
under-declared last bank keeps floor(oc/32) * 32 channels, which is 32, 64 and
96 at oc = 56, 88 and 120 - your three numbers, including the lost ranges 32-55,
64-87 and 96-119.

Please treat that as a hypothesis. I derived it from the encoder's arithmetic,
not from a TRM or a vendor document, and it assumes the three SIZE_E fields are
independent, which is the same assumption you flagged. It also does not touch
the timeout, and I agree with you that the timeout is unexplained.

What I will run, once the polarity above is settled:

  - oc = 64 both ways with the constant forced, no predicate in the build at
    all, so the ambiguity cannot reach it. I will patch only the non-depthwise
    branch at rkt_regcmd.c:239-241; clearing bit 8 in the depthwise arm would be
    0x36c -> 0x26c, SIZE_E 3 -> 2, a different move. I will verify the emitted
    word from the submitted register stream rather than the source, because at
    oc = 64 real and padded are equal and a build that read the wrong one would
    be invisible.
  - oc = 20 and oc = 60 on stock upstream as the reference arm. Those need no
    patch and no answer from you, so I can send them whenever. They also add
    residues 20 and 28 to the table, which so far only has 1, 4, 8, 16 and 24.

Generator and scorer are on the way in a separate mail.

Two small things. Your sentence "modulo true implies parity true and never the
reverse" is the wrong way round - parity true is residues 1..16, which is a
subset of not-a-multiple-of-32, so the implication runs the other way. Nothing
downstream of it changes. And your five are a sample rather than the set: below
128 there are sixty counts with oc mod 32 in 17..31, and odd ones are fine since
33 already ran, so 17, 25, 51, 83 and 117 would do just as well as 20 and 50.

Regards,
Igor
