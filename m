Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41CBC5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 18:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45B6210E593;
	Wed, 19 Aug 2026 18:48:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pE7i/9WG";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EB7810E58A
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 18:48:48 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47f611b3af9so143138f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 11:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787165327; x=1787770127; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Bjn5VJLDS1yXucT12O23qgB/U5aanozAOffCoTMJ1Jg=;
 b=pE7i/9WGj3V0MHUlSwPIM8Si2Dblc3oYzm6o2qFWYha6DvZOTshMyMYPLcZIewX2QX
 8mi0zFDJd1nbACKifEhHR+ATM2X3OItjdotIKDQ9M3Iy4etCpepqHWgnf5DinNH6hiDd
 hdDsu7ZjkrYjP8jFraq9IEPzA0GdF3qJYNNZzRQ7zFm1wZT3+YhIlhnWiR5qBFgCYyQc
 TCGH0sYXMHnKRvUeHYEyRIq8FY1Vm7duWc9HpKA3EMwFIRzRta49/CoYYFF+ZjBwyW8a
 rYeX0ABIGOysuKcPLMvE1RB7JNyi2cHFdXVqQ9j6IKSQ3+MB8NJQiFw+b32jXgg4HxWD
 ODgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787165327; x=1787770127;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bjn5VJLDS1yXucT12O23qgB/U5aanozAOffCoTMJ1Jg=;
 b=povu1tKBmjAMvMrq7pYVwYBdug5tIe6mBB4z+wpdvMS3ybNuOK1c8LfBAAYVDHTPxs
 xmzwxdA+/HN13ym94kSOtNZ59xXvc0i5nUZllsgR09U+pChfVUReUcnOQA2VcFAs1iJM
 ThJKcCIjyADwkNkRuE0OoTMWbxcGlT2KtQJCBCwvsVjJpPNjLg7lfUx3hiEXMxXUmbc9
 FMXIr2OP92s5VneutLf6Siv2iwcw8VwyTH4DiCsf1jPiXR7vimIiFEMi1sdMosEoIpZu
 wU153jSAUArTSwYpQo7qvgfbhXdbEWXOmy9d7BTugfNZWDoKN4TmQrEK/a8c1iinqKZ3
 tOHw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrcyNLU05iNqOYNLbQUUTt3Nmv9ij2yATDgt7nQG/Ycx2EXiuN/SL8VbW01OX0nce9yyKUV5j3Kyw8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwsethVUeO1zQm6TtRWD5uEryuz6xiAaSLwMd9HY5qSqSVH1i/5
 X9TamdOcVBUgUh9fD35ZoKrwbQd5DzBn7wSLKcC7p7nMq0BJkctI9P3o
X-Gm-Gg: AR+sD10cUyB/KI+JtYmORF3LyRaYlnq//Ebi31TPbJtbsY2P03GKV8Aprn5mt7o9hRp
 IiGCxKHnKQwGZAtZCuGaDEx444yotmkjm4onLuHsnQeX/c83piRFxUjtobZXaIChyfjUMoV6ucG
 1zH8ecDSSImb1kONNQZbVMy0eAGWnwjlayHnXHlN8LjzlNRF+vlB4YnksG/5wrCxGsowgXmwj3U
 9l4ih90CTLY7xDVveNqMN/c+dKDmMrAJhvU6jcGXSNaLnl7aTE43cBeqCNrZ1fnZIroJDa2PxZb
 XGHJJfCO/B9TJtDNwRNsOxEInOeRPxmPFK097yU/72yeTL4LUolDKXVkX6GT4rr0GMnE0/XaiWh
 HBb8CRqpJYzUBe1Hqi7G85Gske2JyoWmg4fmEVihIbYWjy1Bn10sOeXYiSQAZ8n6+5Qh1DNEuSS
 VAFzR7yTzNxV2bF0R3rB5vzr77guvuXM5q6hG5jYkJD4Cj7pEsaklrlQaP/HVIYMo76S3NMBPF9
 wNBvVCHtcH+GdF8l2WT0aknfzG6d166C5ZcttexYauyv3x0cD2Pd5tWSJD2gQ+iSq9u
X-Received: by 2002:a05:600c:3b84:b0:492:4a7a:e415 with SMTP id
 5b1f17b1804b1-499aa1a8c0dmr80658135e9.2.1787165326812; 
 Wed, 19 Aug 2026 11:48:46 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B9296006957154F80580DB7.dsl.pool.telekom.hu.
 [2001:4c4e:1b92:9600:6957:154f:8058:db7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa1755b2sm78585025e9.11.2026.08.19.11.48.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 11:48:46 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Heiko Stuebner <heiko@sntech.de>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/10] accel/rocket: add RK3576 NPU (RKNN) support
Date: Wed, 19 Aug 2026 20:48:33 +0200
Message-ID: <20260819184838.6723-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819154634.7584-1-royalnet026@gmail.com>
References: <CAEWPSH7ETfw2TDjUfOvcVtDm19FC43x2vP=Lh7m+XPOGptnPWA@mail.gmail.com>
 <20260819105723.632029-1-gahing@gahingwoo.com>
 <20260819154634.7584-1-royalnet026@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

"Coming days" turned into "same evening" - the harness already existed,
it only needed your question. Both halves below; raw npz kept for all.

1) Forcing outputs below the zero point on RK3588.

Model built to your exact case: 1x1 conv, out_zp=128, no fused
activation, bias centered around zero so the outputs fall on both
sides of the zero point (59% of the raw reference material sits below
it at oc=56, 46% at oc=128). Open stack, mesa main (bf70ab68a21),
which ships no lift - the pre-fix state, so nothing in software can
be compensating.

  vs raw CPU reference : 56/56 and 128/128 channels within +/-1
                         (47 and 113 exact), global maxdiff 1
  vs max(cpu, zp)      : collapses (0/56 channels, maxdiff 128)
  NPU values where the raw reference is below zp: min 0 - they pass
  through freely, nothing pins at 128 (0.6-0.8% of values happen to
  equal zp, consistent with the reference)

So on RK3588 the output stage does not floor at the zero point with
L=0. The floor you demonstrated on RK3576 is real there - your
three-run experiment stands - but it is not an unconditional trait of
the family silicon. Which of your two explanations that favors for
the vendor's per-model 0x40ac values on RK3576 is yours to judge; what
it removes from the table is "unconditional in the family, so the
compensation must be hiding somewhere on every SoC". Here there is
nothing to compensate.

Reading what the vendor stack programs into A on RK3588 needs the
vendor runtime, which this bench machine does not carry - if the
below-zp result does not already settle it, I can set that up after
Aug 30 (travelling from tomorrow).

2) The remaining discriminating counts.

oc=50, 60, 90 and 114, same protocol as the 17th (raw CPU reference,
no clamped comparison, zero constant reference channels in all four):

  oc=50 : 50/50 within +/-1 (43 exact), maxdiff 1
  oc=60 : 60/60 within +/-1 (53 exact), maxdiff 1
  oc=90 : 90/90 within +/-1 (78 exact), maxdiff 1
  oc=114: 114/114 within +/-1 (98 exact), maxdiff 1

No channel pinned at the output zero point in any of them. Together
with 56/88/120 from the 17th and the earlier 20/33/40/48/72/100, the
RK3588 side of the discriminating list is now complete.

Regards,
Igor
