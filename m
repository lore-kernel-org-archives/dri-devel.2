Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEF7C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 11:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10D4410E0F4;
	Fri, 14 Aug 2026 11:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d1rLy+rW";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05F1410E0F4
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 11:08:38 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49987367394so241945e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 04:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786705717; x=1787310517; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7S7sFuRCjatzs09JKRbH4HGwrINbYlULF/Unkzu0baA=;
 b=d1rLy+rW7FPupv0ISEYu/TyL/NCMmOEWM+7hGM43wrWuXui4ACNKf6XSoiwMzL0XQp
 x3/Os1cv+CTH1hBM/ZmQBstd/GXLq4UaT0br8sWP0etaCXcZ+ZN6eDwOrYdF8cLWVDtw
 aR/gfawlasmCKNTNtnrGCg9BQzEfNpa664/iopq4fc5rcNWqczJpeU9wb0gDI0ogBCl8
 rekLLsq9fmn6OrmcCvuTYKyoWoL8A2DToILL0mYPSPeOpBNohZgjn+Ye3AZ/6KW5+jNL
 nlh67FHzkXRoGYzSPJWH3MoXFBDaQDT9n4nxFTNUKIpKcCJHs6EnpA+f3NdnfpxmTMcl
 kqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786705717; x=1787310517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7S7sFuRCjatzs09JKRbH4HGwrINbYlULF/Unkzu0baA=;
 b=DV35Ay0577UbWiuj352BeYxRm+U36vWPAFcFM/R2nUqChTuoMJLbYc5XL6fV5d1lkp
 KO84RPv1rBruaoZIgtzPMZOQARWNjMyxTqbp3qDE9qWZSGZyt3TrIwB9/XwXQWKmx7F6
 QfEMyc8U1TNwg64dyChMKfOz9ty74R70RGz9jLZ2SobnbgsUSGDD+yoq96AUfIaEBpRj
 hJ5oAOLfYHZlx1l9PG7TFPiFVslh9qPfBbWYVb4X7i2opz7xRAdijbM8J+yaF5qr+nfz
 cyqTxu4yKDyQk9aYYb66e26DTVlu2ibNfLAt6XrpfRZrei66wKgpr9wiUufi4wDJPuVc
 gSPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RosMk1qnwPYhxcv+mK/g+WMHpyUmWOvdXIprMNhBwKIPpwOO2LKu6qc2SSJRKAStwY9OQ2lvxBJgW0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMjndpUPYigmUNUmmjRf1V/TYx/Fm+C9iNLkCSxYmo/L+jX7DR
 iX2JTX18hA0RL4rGF3F0SLFrxSF8Q/Z6L7hcE71sEFq9GXS4nfp32WED
X-Gm-Gg: AR+sD13w3ZCajCRIAif4bZqSuzV158FB8rB8rWJoNP+0jTlwdcyTw4SbuavawPqfn/y
 1L3E7++BpFvLpqeCRXwd5mn9mbfOJOj7TEHTCSvZK0jvhwGxouWBpEFDb07BovWt9p/FD8Sx9eQ
 c/eVTNolDZoG34oyc2C+iGOhn4GhbYZhn0weIxXdeSotbhzAmNqm4GtnDPwbvcB5CgRpL0eJkj3
 SBzcNfLTFq+1RTTUUttiP3Dzqpi3TMW3Dla+m4WYbL79NL/XJqlavu4Ou+vZsDXIxCa+lfQLn5G
 yOZR1nbvIbzlgfP2C7hV9uG3rjHt+Xj0DB380N5utzlvlFll4GBqw2fnXYVcL/S6E3zJ3WbThTX
 aZUBlEm4lzNfpm8rOEjWGjx5OOY/sz/Pi4bN//2EsJ6gwXg3eJMBN4snbdQWI83lCz4/oCVpK7b
 jO38tCWGZm+uEQBiYN8dUDniN6BAzEF6zc0DlPyM9QBe9XZEGulcnwJ1saI9/SdLiFLAKaJBkCD
 CMvzYPsv00aG/RCJHScL9wYKUOhqzYjKPd6dOpdYB3pkL1BfdfZl3skUgAkQRwM/C7/9Q==
X-Received: by 2002:a05:600c:1395:b0:499:77de:78ba with SMTP id
 5b1f17b1804b1-499879826b2mr34045235e9.2.1786705717053; 
 Fri, 14 Aug 2026 04:08:37 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8D33002713106A8ABE6E8B.dsl.pool.telekom.hu.
 [2001:4c4e:1b8d:3300:2713:106a:8abe:6e8b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499877d7974sm37724265e9.1.2026.08.14.04.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 04:08:35 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, alchark@flipper.net,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/10] accel/rocket: add RK3576 NPU (RKNN) support
Date: Fri, 14 Aug 2026 13:08:21 +0200
Message-ID: <20260814110825.14893-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814082652.3852617-1-gahing@gahingwoo.com>
References: <20260812094106.1391698-1-gahing@gahingwoo.com>
 <20260812094106.1391698-9-gahing@gahingwoo.com>
 <20260813095718.9747-1-royalnet026@gmail.com>
 <20260814082652.3852617-1-gahing@gahingwoo.com>
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

Here is the RK3588 column, all 27 operators, ROCKET_SEED=7, scored the
way perch.py scores: a channel is good when its maxdiff (md below)
against max(cpu, output zero point) is at most 1.

Setup: Orange Pi 5 Plus (RK3588), kernel 7.2.0-rc6, the rocket driver
from this kernel's tree rebuilt with my clocks-by-name and devfreq
patches on top, Mesa at bf70ab68a21, teflon delegate, model
mobilenet_v1_1_224_quant.tflite from the Mesa test suite
(md5 4f348b87dca3315d2b3646cf5a3b31cf), per-operator models generated
with the four byte output patch you described. The "correct hw" column
is your chainmodel.py against the same model file. One difference to
flag up front: against this model file chainmodel prints 36/256 for
operator 8 where your table has 34/256, so our model files are not
byte-identical, and the columns below should be read against each
other rather than against your FINDINGS numbers.

  op  kind        correct hw       RK3588
  0   conv         32/32   md 1     32/32   md 1
  1   depthwise    28/32   md 3     28/32   md 3
  2   1x1          22/64   md 6     22/64   md 6
  3   depthwise    21/64   md 13    21/64   md 13
  4   1x1          18/128  md 14     8/128  md 15
  5   depthwise     9/128  md 13     3/128  md 15
  6   1x1           4/128  md 23     1/128  md 24
  7   depthwise     7/128  md 10     3/128  md 12
  8   1x1          36/256  md 7     20/256  md 17
  9   depthwise    32/256  md 11    22/256  md 13
  10  1x1          29/256  md 9     28/256  md 10
  11  depthwise    53/256  md 8     48/256  md 11
  12  1x1         166/512  md 11   121/512  md 13
  13  depthwise   142/512  md 9    137/512  md 12
  14  1x1          82/512  md 7     72/512  md 10
  15  depthwise   154/512  md 10   115/512  md 15
  16  1x1          82/512  md 7     71/512  md 10
  17  depthwise   156/512  md 14   141/512  md 21
  18  1x1          92/512  md 7     77/512  md 10
  19  depthwise   170/512  md 7    152/512  md 12
  20  1x1         102/512  md 8     84/512  md 10
  21  depthwise   166/512  md 13   150/512  md 12
  22  1x1         174/512  md 6    161/512  md 7
  23  depthwise   293/512  md 5    261/512  md 7
  24  1x1         671/1024 md 6    636/1024 md 5
  25  depthwise   718/1024 md 9    684/1024 md 8
  26  1x1         572/1024 md 25   574/1024 md 23

Three things stand out from here.

Operators 0 through 3 score identically to your chain simulation --
same good-channel counts, same maxdiff -- including operator 3, the
stride 2 depthwise with the asymmetric padding you suspect for the
first RK3576 divergence. They are not byte-identical to the simulated
hardware: diffing the raw tensors against the requant_hw chain shows a
few hundred elements per surface already off by 1-4 at operators 0-3.
That looks like the same small extra rounding difference that pushes
the scores below your column from operator 4 on; through operator 3 it
just stays under the maxdiff <= 1 scoring threshold.

There is no md 255 anywhere. From operator 4 on, RK3588 sits somewhat
below the simulation (8 vs 18 at op 4, 1 vs 4 at op 6), but the
maxdiff never exceeds 24 across all 27 operators and the deep layers
track the simulation closely (574 vs 572 at op 26).

A control run with ROCKET_SEED=11 keeps the same character: operator 0
still 32/32, no saturated maxdiff anywhere, worst case md 35 at
operator 6.

So from the RK3588 side your read looks right: the deep-layer
compounding is the reference artifact, and the RK3576 collapse from
operator 4 with maxdiff 255 has no counterpart here.

Igor
