Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F042AC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 21:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4152B10E5A2;
	Wed, 19 Aug 2026 21:50:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="jEGdPcNo";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="JOteyyf4";
	dkim-atps=neutral
Received: from flow-b7-smtp.messagingengine.com
 (flow-b7-smtp.messagingengine.com [202.12.124.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 194CC10E3A8
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 21:50:21 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailflow.stl.internal (Postfix) with ESMTP id 1A1F213001A6;
 Wed, 19 Aug 2026 17:50:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 19 Aug 2026 17:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1787176219; x=
 1787179819; bh=2t8vq/d3i5IvAM6dRBW4KGvislz8A8nGvUYB0iRZEio=; b=j
 EGdPcNoC8MpMuL36NOGZOHMt7CDyBNBY5RZ975svZrGqypdhP6KFAQNitWeCp4DM
 K+Ye9KzzOfnTXXvqF5akPWXMltLnC6ISqwXr8QleI0Ng9kSVvOZX1QHyzxeq/Vku
 nywOtPpdGJYD0iI0X0YakQTFeOhGFBpfdgO9449G8kUa9bCbzjn5KFFU94s4iEb4
 UJksE3mRsdlrYMXlit3MhwSqLuajnTu293XJsUk2sb3+ti/0EYkt2LKBMh/aFNCw
 cRsp08kboWMprTvC1iMkiDerp/BdWYFleTJBzq6sJ+eBh63nAAOtwSl+C+YZUy4e
 90lvarC2y2N4wDM1s1xuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1787176219; x=1787179819; bh=2
 t8vq/d3i5IvAM6dRBW4KGvislz8A8nGvUYB0iRZEio=; b=JOteyyf4YTaYi/2WB
 NtSRjQXUgmsLVJXMOjUK1XSj1CA/VbbJkDgbrsg2GP8sQOqBrpb+qV9O5JzgUR4n
 jnIaC/BrzoHt153ecWXMLfv6AXEek47hOe88gwIaTnGrbUON6srL3G5lg3YuhVWH
 38Md/jVWRT6E4v6oC2SRLrxbFuUxVaAX5I5TJcWh3dcVYMjG1Q4C80hmwWttvean
 IBqXGIsNvFJ43F0qNHoR45FMRS4Co8KsPr/Dq+H/bfyVLmur3L8dHYn8ThfmoD1j
 OST13HYbCfR6yY9LlNuXaL46blnRsxSgp6X2PFYZvnP8r3VzT5+Z9nxDQzOrFq0S
 /c3nA==
X-ME-Sender: <xms:GiWGahy99rJJw6YL8fMsnHH01ohqEMg2MKMdva3YefiLQN-ve9EfGg>
 <xme:GiWGape9N0H6okQIMmjSPE_qDuwTOrilDL-YVi-pHSt4vKXEsra6eVlxtE17yZCHE
 wjoJLn39YBEFf53SUUM1Cm8L0ajEGcj5q2iwJxhPFs16Ym8KyBmHBCi>
X-ME-Received: <xmr:GiWGam4lwBvNUcaB6GUipUZ6f0F1aL6pk-pA105hvF1UMcr4Cd3jx5ULBVnNbg-es42N1kXndZD7>
X-ME-Proxy-Cause: dmFkZTFBtBmt2YPmQEyaS+GdXpilS0viv1+2FE3F1SETvdJkYNaADr6lYxbjKSS9kPWPCv
 HFpCJuzPOUHDE7Ks3btVoCAvnKi431EodZGstEh7V+I07+XNZhgxY/8Bux5R846+BH3+zX
 Qfan6M+g2J8lF/XShsLSRzP5U1kIyDBS//sa331xTrhvZ/mAithr5f/GaXfzZprX+4M5UN
 BOeoKi4/5c/Xio3d/pxnxnTL5abtADPZ95dsZCq8KFQpAAnFwk5Ix1MrwgFuko/PjYcWYQ
 3rRW1fnuYrG0RHW97CQwPEaMvsxY5Qart3bzWIVI490i+rx7Rc1TauklhDJ+DPWY4OuYmw
 svkvbV4l4AIt9ze6nfODZyKio1JNxtGnFCDjorzhL82DwagADiWZUbKZT42pzZub8Z2JNk
 MuYxgYkC/I7vYmOW7nQkt0P/huUpgJ5bTK74Xxa93dX7VxbngNQeB6lg2oXTahVxPGD+3I
 GTn+a8IlDoReh/Ee6n8zRpFW/IdNFJFr3E5iO/bFG9jG1j1d1LW0s0SaxG8Jg60SNW6FLt
 Z0nNuw5r6onB177PON22gzHRvbRilUTIwMEYjikJnHkgsWL839wVX8apeWxMR2MP1fJTLc
 OsB1uMETiCxJFoPKbEUXY+r8GJkeNm+ekK8XlOoX89ZomjrwK8n6F3ximPyw
X-ME-Proxy: <xmx:GiWGauJJUbqnjyXpkPrATamjTAusYy98AmKeadcWK6gFmX4_skUAwQ>
 <xmx:GiWGauzEo2wGvweN02BGR8WRK_Cq4fS9YzslBrXpwdOnGs9_TvjMiA>
 <xmx:GiWGamKzG402w6SRn8lAxAduCdRFF2medf7PKMGp77RSAysgTRT4nA>
 <xmx:GiWGatWHGCIWCslzr9Do6dxpUQ5qz6CFyvTi14LAIrvvYYHmLzsMew>
 <xmx:GyWGakzV0xAhKs2rneFqiMqv1vhus_jrjskHHczkh5r8VN8zgWPSwdof>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 17:50:15 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: royalnet026@gmail.com
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, chaoyi.chen@rock-chips.com,
 alchark@flipper.net, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/10] accel/rocket: add RK3576 NPU (RKNN) support
Date: Thu, 20 Aug 2026 09:50:13 +1200
Message-ID: <20260819215013.728951-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819184838.6723-1-royalnet026@gmail.com>
References: <20260819184838.6723-1-royalnet026@gmail.com>
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

Nothing gates v9 on your side, so please do not reorder anything. It is held so
v8 can collect more review, not to wait on a measurement, and ten days of travel
beats my patch queue.

You offered to set up the vendor runtime once you are back, to read what it
programs into A. Please skip it entirely. Reading that on RK3588 cannot separate
my two explanations, because your run has just shown there is no floor on RK3588
with L of 0. There is nothing for that A to be compensating, so whatever it holds
says nothing about which of the two is true on my SoC. Saving you that setup is
the most use I can make of your result.

The measurement that does separate them is on RK3576 and it is mine. The
vendor's coefficient buffer is built at load time and is not in the .rknn, but
it can be dumped from a live run and I have done that. Doing it for a model
whose output actually falls below its zero point, and asking whether the
vendor's A carries a lift, answers it. If it does, the compensation was hiding
in A. If it does not, there is an enable I have not found. Either way it is a
board round here.

Your result changed the shape of the question. I had two explanations and no
reason to prefer either. You have removed the one that was doing the most work,
that the floor is a family trait and the compensation therefore has to be hiding
on every SoC. It is not a family trait. So on RK3576 the difference between the
vendor stack and mine is something in my configuration, on silicon where the
same 0x40ac expression demonstrably does not floor the vendor. That is a much
smaller place to look and all of it is on my side.

Thank you for building the model to the case and not to the shape. Bias centered
so the outputs straddle the zero point, 59 percent of the raw reference below
it, and mesa main so nothing in software could be compensating. It answers the
question I asked. And the collapse to 0 of 56 against max(cpu, zp) is the
control that says the comparison was live.

One precision on the counts. Of the thirteen you have covered, eight
discriminate, and those eight land on five distinct remainders modulo 32, which
are 18, 20, 24, 26 and 28. Ten remainders in the range still have no data on
either SoC. That is far past where 56, 88 and 120 left it, when the three were
one data point repeated, and it is short of the whole space. What it establishes
is that the upstream constant computes whole on RK3588 at every count anybody
has proposed, with no channel pinned at the zero point in any of them.

Regards,
Jiaxing
