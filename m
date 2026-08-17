Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9993C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:20:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36E8A10E3FF;
	Mon, 17 Aug 2026 10:20:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="kDorzMwY";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="e3tfk1Rb";
	dkim-atps=neutral
Received: from flow-a4-smtp.messagingengine.com
 (flow-a4-smtp.messagingengine.com [103.168.172.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 811B310E3FF
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 10:20:28 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailflow.phl.internal (Postfix) with ESMTP id E5BB21380339;
 Mon, 17 Aug 2026 06:20:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Mon, 17 Aug 2026 06:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1786962027; x=
 1786965627; bh=toFR7CttO5z3jj5XX70w7xnXop6+YeM2N8EtwJ/xROQ=; b=k
 DorzMwYWQ8UBd9lF3s3l7x240IkaADZR/qmhJImi43reP/RpGw0Lbu8OAq9xnPQJ
 N7d55p43sb5FzAvi4RbwoUsUNTSgUU/Co47Q72YK1hOBet7Q4mU1gNCLLTihyNCJ
 P/y6bv2M9o2Z+Pozqojf5zHKPrVMjkhaKa79Jwqr6CZdSQyQp74B5iAIIL7Y7F7k
 nFTRYUICHD4j4s9McTdyx1bxK7EoxBAMw76vZKD8aJaQylZ/C4xEASxTZx8fR2ym
 In+qbVeW4qi1/4zE/NhXoiYGdoBkZrt+X8sr6DJfueX0YIVbd2/YQ2oE1CdVupoz
 17VxenK02M5e5aV243Eww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1786962027; x=1786965627; bh=t
 oFR7CttO5z3jj5XX70w7xnXop6+YeM2N8EtwJ/xROQ=; b=e3tfk1RbNVgZiG35n
 O1IDh52BayR9W1ZybJoiZ3gIRPMmNN/ayQ4CH8+Bgk/mAcwTTsZYRR/aF1hKXz88
 i1xq12MI/QccS5FyR/Y+gJE3Q5tDzBRRVE6rH0XXTfSOEQHmIIUnWRxv/hIkkKDG
 94GGZgjwvtXFpRGBsOvYRARUeLjlKySU51SOrST8BiKe/U+SnhjlPeua07PMrfaJ
 VgorMmfxPCdh6SRisZbcKw3JBLrY0Srmz510jZhGNap5koExL/prWg5yGTLuMIyj
 ZaEGXuHmk3IF/SZsnO/saOKeTlfuxwB+uaWjvB7xfjfEQ3N3hKx2Qv+HRmL55Vuq
 ESMrQ==
X-ME-Sender: <xms:a-CCapERq42D396F-WvEVMS96cfIQpAnBdoH8ZhjiBu5uHf62e_z9g>
 <xme:a-CCamjRvLUwTyKji24L2J8LzcTsf-CZVVrGuhEjG_dLcr-tstYU1q4IasUzwN8WU
 AuyXDCOX2OinHA8mSW6x4yQMNlkhECJQtanYzgOSUq6NW38-9-cYcYi>
X-ME-Received: <xmr:a-CCamtb48pTVq1-_GmEXWLUeeCExlicdF9y_ppU39qcTLHc6Gse3F2uDARsa2zbRn7uJMx3Mg>
X-ME-Proxy-Cause: dmFkZTEav12/xox9dW6FBrGBtqGDntmQw+BK8FNwTWmRZjxu8LmOPvxJLoqU5ERQ2bc4Sh
 EZTMtc+O1uYQzV11Wxoj4DcdyOim58v1EwZW/KjHoqAFyJ007NUBR20UItdIgPWS9PsXBq
 pe89jlsR9mJe7k2fRZhSktW/8sOxkpzOe09fjNRCMBiwIlBCHVI5VwWaxGXFrYZdVsWD8T
 52vMwRkhQIUUgsZdZbEZDtRTbJeWJLpufjCQGCpqCBp5wclqROY2LMMw7OpGz3JD5/Nek5
 dQqSB/RHcDywRRL7dKDqNv+L32U/Ay+fbsSTUemig8p/3vpdA1ucfND8A/hlnoTuRgaYAs
 ia75Cchp0mALQLn46Kyahjr00cWOSvN4PUWbMS4ZUD0d7q5xX22cQBTydSFgzjQBnfYhyD
 TC7Aww6EcaQA9DmAwX1AdDmnHdKv65rcIFjiBijOgxck90DvV3KSAI4UAT6df3la9rS8A+
 38cOjyG52g/faS8m/k0/X/BQ72gfpc41DePsIED6qD2DLDN7TNZagYSGiPJckbjOjaAJNm
 gD1p8MNV+iDXIA5UzTTqc1/6bOxxDJomY031pSrkDl61UP/LFvMxFCrRzQdBowoWwZ+hyv
 EL04bPEmGMesAMuTStxaJrd3yF6LEpoubwOo7Ijdzk3uG2W63mNtaea9UcKg
X-ME-Proxy: <xmx:a-CCapuUDBoxg3wQqwBDLCTLeE6ojJfspPFPx9t6i-6bXRe3xrrRzQ>
 <xmx:a-CCarHLEMWt-uZZGYsjvuc3CuDxAgGxZdkCkXbTL-Ar8xC-c5HtBQ>
 <xmx:a-CCakOTODvED21m5GbAqXQWdXOXa685f0DJXuNxvjFE4f3EBgR2yw>
 <xmx:a-CCaqIA9LYla2ZnkHi8uK840Ywz6pofG89dde6PybG2zRZz9-jkpg>
 <xmx:a-CCauVITsaLWtdqyqOfeHeI_8QESZofbuGcX4DUxRTD7NpkHa1RrfwD>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 06:20:23 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: royalnet026@gmail.com
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, chaoyi.chen@rock-chips.com,
 alchark@flipper.net, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/10] accel/rocket: add RK3576 NPU (RKNN) support
Date: Mon, 17 Aug 2026 22:20:21 +1200
Message-ID: <20260817102021.1226525-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817100046.24872-1-royalnet026@gmail.com>
References: <CAEWPSH7ETfw2TDjUfOvcVtDm19FC43x2vP=Lh7m+XPOGptnPWA@mail.gmail.com>
 <20260817094544.1159366-1-gahing@gahingwoo.com>
 <20260817100046.24872-1-royalnet026@gmail.com>
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

First, I sent you to the wrong counts. The two predicates disagree only
where oc mod 32 falls between 17 and 31, since modulo true implies parity
true and never the reverse. At 40 and 72 both forms emit the same word, so
I withdraw them. By the same arithmetic only 56, 88 and 120 of your eight
carry any parity versus modulo content. The rest still establish something
better, that the upstream constant computes whole at five remainders on
RK3588. Discriminating counts nobody has run are 20, 50, 60, 90 and 114.

Take the code from the merge request rather than my working branch, it has
no knobs in it.

  https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/43804

  R_DPU(0x4050, (DIV_ROUND_UP(output_channels, FEATURE_ATOMIC_SIZE) & 1)
                   ? 0x80011011 : 0x80011111);

output_channels is task->output_channels_real, the unpadded count, and
FEATURE_ATOMIC_SIZE is 16.

Do not put my two words in an RK3588 build. Against registers.xml

  field         upstream 0x124   mine 0x80011111   mine 0x80011011
  RGP_CNTER            0                8                 8
  RESERVED_0           0               34                34
  SIZE_E_2             1                1                 0
  SIZE_E_1             1                0                 0
  SIZE_E_0             1                4                 4
  OW_SRC               0                1                 1

Mine differ from each other in SIZE_E_2 alone and from yours in five
further fields. Those five are common to both of my words so they do not
confound an A against B, but none of them has ever run on an RK3588, and
if both arms fail for that reason the oc 64 control goes down with them.

Use your own constant with bit 8 cleared instead, 0x124 where the
predicate is true and 0x024 where it is false. That takes SIZE_E_2 from 1
to 0, the same move my words make. It assumes the three SIZE_E fields move
independently, which neither of us has shown.

Bit 8 does something on RK3576. The table I sent on the 16th forced
SIZE_E_2 to 1 with every other field identical, and 16 output channels
went from 16 of 16 to a job timeout, 41 from 41 of 41 to 0 of 41. Whether
it is the only field that matters is open, and the sweep I promised before
the series went out covers RGP_CNTER, OW_SRC and two reserved bits but not
SIZE_E_1 or SIZE_E_0, which are just as fitted.

Of your three offers the oc 64 control is the one I want, both ways, since
that is the side I lost. A count at 20 or 60 would be the first
discriminating point outside 24 modulo 32. And yes to the generator and
the scorer, the refusal to emit a constant reference channel is a better
guard than mine.

You are right that none of this touches the timeout. Every modulo run that
lost channels also raised one, at three counts, and I cannot yet tell
whether the register causes it or both follow from something else.

Jiaxing
