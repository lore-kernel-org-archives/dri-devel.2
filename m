Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547D7C5AD5A
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 13:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 679ED10E116;
	Sat, 15 Aug 2026 13:06:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mJIISvJn";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52D1F10E116
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 13:06:05 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47df6a5655aso204933f8f.1
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 06:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786799163; x=1787403963; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6TunZ6T1253lLJ2+HTnnlCLT2K1O14zopzv5ooYmm6w=;
 b=mJIISvJnAabgwkPtTWbGxKqlXQrsQvOPeVCNhUgWfyWpy4rD5QrZC7QVjIcSzx8v4s
 5x8lVF3NAnW/sEVAUIU1Gk6kmdLobzbxdebSvIlX6IM6sQR/Fd0bPek6nmSU++dQTBBA
 8o791Aq7jkWIMBqCR7aG9t6/M15fpV4GLNBwx4i18yw3VsejD2zfiSw3gzjEdxMBY6jJ
 LiJ3gtPUeuUQ40bPJ3n0aom90SZ760XFEk2zUr6++IZDd7/cDGHh/ksriEY2rrEGSdtW
 YDHIr8tQuM3oDK1/RNi3ox/eo5e0CYabFUrHDmwyEmtvxRueSwy7+o3J+91o1i91Is1o
 +tSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786799163; x=1787403963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6TunZ6T1253lLJ2+HTnnlCLT2K1O14zopzv5ooYmm6w=;
 b=Yv9KjC3mDh4Fu1rfi8KeaT86m9fHp17O4ywtbXMWjF0WzO8ava41PdsVZeuuErCLoi
 eGwqZ1DMmc/8ECZIbzacK19Hli6DexUKejyH9dmV/unT/4bE85bdhoPOpw4MCe64A5NE
 PwVk7oJOQ+1MBhTBujkhgVLMz538LjIGHe4MbzJyHeSNy+Iss3r+s12OxMSfSkIDviF+
 z129x5/SqPcI3WTDi1nCPvHcpGpHZzgESAxpBsmzEV7Wyp4i1Wn8i8VpbmpHC+mmXwgv
 8RGGW78CUirmSIR8P/6i7Js5nsrEaiIjAT78ODN8C9RyCbyNFkK4apIMIKRz//e8iYDm
 Bf0g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoqROlyOcTzsCUy/hcIO88LiY1lzu9JcUzmhiPZ5iZ7SIrA8an2w6XhfZ6BgzT6u6mMsWWdAXZlawo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxVY5d7UbKmG+SJJPPDeC2dJ+SrqbHumVhjtaDs5rgD6fbIyAre
 nH3N3dfRmEuK5C/xW0jit73YSY4+G21D1AnrvN1KooXxexoXbmDa08Wz
X-Gm-Gg: AR+sD12Mo8/dIRbzh4x9GwQSeBGqk0FZ5nj1BknIbXJJmmHK9eUbsGWQK2WDPZrqlS7
 SmPOSB/Nxu0lzb2kUj80IBOjpmASj/9wYpFYleYd/TD+QQsFLaBU3gRWjpIWM5Nr80Ls/WLswry
 dfkRK1Q+y7WAIzXGVD3zCCxCNF73cYlcSuRnwjICdyrF3mvnq0xawCTsRaRxKxSJ7OGURJNAn0K
 kybeG4EFBTD02y8fUm0II033aFGEOD95mO4BlUhbHSpC8P80d10RmLdY2N8tZPm7XuNu1Byp7dN
 KJvCuAAmss74tw484DeJsx+wzpd/a3n80ke/GuF3VwvkMvmdlo7PPPsk4IyHBnP93eErC3SiZ+C
 0nhqgRd+GiLRzuIWhQO5qNBRb3GZxaoHGs8sltsJf8UWtKC+LAefZSRZAXHtKjw02EgxblBQevM
 IU9DrP/TO+Ei29cRsPPNyNmS1wJcVLMvNVVnyeLz4nyGET1PfZXDlbk2NHkUbLSBOWEDhgjMLL8
 2vmb8yLIiYqsa3m2AL5QPwxkuL2aOyXaL6dYkV23v2RIvs4LeKoHUC48UtTKHPqduyd4xmupXBi
 5lo=
X-Received: by 2002:a05:600c:354f:b0:495:650b:4c61 with SMTP id
 5b1f17b1804b1-499879690acmr87570305e9.3.1786799163529; 
 Sat, 15 Aug 2026 06:06:03 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B932600BF05B505F15B0ECC.dsl.pool.telekom.hu.
 [2001:4c4e:1b93:2600:bf05:b505:f15b:ecc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999130d9a4sm59398995e9.15.2026.08.15.06.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 06:06:03 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/10] accel/rocket: add RK3576 NPU (RKNN) support
Date: Sat, 15 Aug 2026 15:05:53 +0200
Message-ID: <20260815130556.68876-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260815031219.3860651-1-gahing@gahingwoo.com>
References: <20260812094106.1391698-1-gahing@gahingwoo.com>
 <20260812094106.1391698-9-gahing@gahingwoo.com>
 <20260814110825.14893-1-royalnet026@gmail.com>
 <20260815031219.3860651-1-gahing@gahingwoo.com>
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

Here is operator 28 on RK3588, and it changes the picture: it is not an
empty convolution here, and once the reference is right it is the
cleanest operator in the whole model.

Setup as before - same board, same upstream Mesa at bf70ab68a21, none of
your four unposted fixes, ROCKET_SEED=7, model truncated the same way as
the table (subgraph output repointed to the operator's output tensor,
here the 1x1x1001 BiasAdd). One change to disclose: the kernel moved
from 7.2.0-rc6 to 7.2.0-rc7 as my daily since the table. The rc6 run also
had my devfreq patches in the rocket driver; this rc7 rocket has no
devfreq node registered, so it runs like yours does. Before running
operator 28 I re-ran operators 0-4 as a control and all five reproduce
the published column exactly (32/32 md 1, 28/32 md 3, 22/64 md 6, 21/64
md 13, 8/128 md 15), so neither the kernel change nor the devfreq
difference moves these numbers.

Scored exactly the way perch.py scores, operator 28 reads:

  674/1001 channels match, maxdiff 29
  NOT empty: only 36 of 1001 channels sit at the output zero point,
  71 distinct output values, min 37, max 117 (zp = 66)

But that maxdiff 29 is the reference, not the hardware. perch.py scores
against max(cpu, zp), which is right for operators 0-26 with their fused
ReLU6 - the hardware really does floor those at the zero point. Operator
28 has no fused activation (it is the logits BiasAdd), and RK3588 does
not floor it: the raw CPU output has 362 channels below the zero point
(down to 37) and the NPU follows them down instead of clamping.

Against the raw, unclamped CPU output:

  seed 7: 1001/1001 channels within 1, maxdiff 1 (708 exact, 293 off
          by one)
  seed 8: 1001/1001 within 1, maxdiff 1
  three seed-7 runs byte-identical

So on RK3588 with upstream Mesa, 1001 output channels - odd AND not a
multiple of 8 - come out clean without either of your unposted fixes.
Whatever those two fixes change, this SoC's path does not need it for
correctness at this operator. It may be worth re-scoring your RK3576
operator 28 against the unclamped CPU as well before reading its "empty
convolution" - if RK3576 also skips the floor on a no-activation conv,
the max(cpu, zp) reference alone moves several hundred channels.

Two small notes for reproduction: perch.py prints the headline and then
crashes on this operator at its spatial-profile section (got[1:-1,1:-1]
on a 1x1 surface is empty) - the numbers above it are unaffected. And I
find it a nice detail that my board reads md 23 at operator 26, yet
after the CPU average-pool the classifier lands within 1 of the CPU -
the pooling averages the deep-layer noise away, which fits your 1000 of
1001 end-to-end result.

This reply was prepared with the help of Claude (Anthropic). The board,
the runs and the numbers are mine, and each number above comes from a
run on this machine today.

Best regards,
Igor
