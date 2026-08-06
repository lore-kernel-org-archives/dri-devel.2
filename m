Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CDCC56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 09:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B9310E2EF;
	Thu,  6 Aug 2026 09:56:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="YsXLvlWh";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="fgRxnaWn";
	dkim-atps=neutral
Received: from flow-b7-smtp.messagingengine.com
 (flow-b7-smtp.messagingengine.com [202.12.124.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E56110E2EF
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 09:56:04 +0000 (UTC)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailflow.stl.internal (Postfix) with ESMTP id 5F3391300290;
 Thu,  6 Aug 2026 05:56:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 06 Aug 2026 05:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1786010163; x=
 1786013763; bh=Hk5pDzV8LlRqCkk9aD2kVsGM1I+df21fePiYEfh2vC0=; b=Y
 sXLvlWh2ZAKEZQbW5GYzkbQz38Y77eMpXhBpHzKoFP6Lo5dKRHyrlXr+ojb6wXST
 n0gnEVpLXww8wUnFq8PAwbnOkHMip+Ly486OzFf85X0LULur1iLcjiT6Bh+3j/xR
 R1SEcygIWtJcO5eArp9I/4AY5XMs/KtuVZ9uiGDvbOHzVSy/TdAR/45Mi9IPDxls
 hGGTuUSmpsjs+68bHd8zbOEwdtw0YlPhGW3u2mAvAN1vqTw+KAMv1jGFXBnqv6P4
 pjNHA+Y7/A7qEt+MTWcnFE0Y2bMmcGt+EGjFA+vLykiwThS5IITEjYKRbAdFx8I/
 2RoOmghx1r/FnaLhFUcTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1786010163; x=1786013763; bh=H
 k5pDzV8LlRqCkk9aD2kVsGM1I+df21fePiYEfh2vC0=; b=fgRxnaWnMyveS1aXO
 LjyxkQvlwukS0nrsYJrW86z0bKTxvrlI3X3na6OvG1caBb0sw5qKuVMTs0M+BGmc
 2e5iAUasBvybW4Q3qlP3+mXgkpPRboLfwugPWTGNiQcC6qGjcJM3nksZDUVxrB2v
 DEDT41AQlrOwc1O6Hys6SnHM4lmSTDX/8GS1o0Q9gaPfXY17GOyIG9SsihHjK2z2
 i66wvziKLpOYffjwFS+l2Jz12LfIuXhqiFGuhXHObw3unoz4oXhKJ6eYknNAhKgh
 HppF4WRDpS5+ufKw6KiOoKeqlYuK2Vel0/fYW2ECZiwWQpMzXyNTtCEiMK+ri2CI
 keRng==
X-ME-Sender: <xms:Mlp0ahS0yFPqV1DSkJ01rc_N8Nlb8Mh4K6XLjD4Vwm6bwjVzCK5Aqg>
 <xme:Mlp0avp7gNVjSKDp4RJAF7xJDKQ0kXIyXdu-o3JGr2CEe5Wz7AXLjoNjU8v361IQQ
 VMIsbdqVV_Pc8YyK2lUAw1EydPAfpsDa8btk-oveNlXdk6mLMfJ>
X-ME-Received: <xmr:Mlp0avat26AMe5XEEB0D4mW8NMHpnj9Wu67efEZXmZx4J2HKR1WrG16OfZz3_-BTq5FnTNMIEQ>
X-ME-Proxy-Cause: dmFkZTEwXjC8I/Apl6hZLAV8DofRZjARxHMzyBPZWfubTPbduEkENL3KBYf+BUJyXx3o1H
 pohUIUznaqX7Fjr2lTk141FubMEVNnW5UMIuAi4J+njPSv/GG64EL2ET2Hgv347vEiQ3jc
 KA0wugH9OtAy5ThKMtJS4rzVpp7fazWBBvvGSAaUJ/31Su1HTwA6ygKr329Xzd68/cfp/r
 kUtih/tfoUuoXMiAlMz4P8El5uMHxKkC1uSTp9CIRwChyeiZFIqFoe0r9cbHs0y91twdaj
 Ye8UZk8LuQZRgkNIKQp73lZNC19WmkBF37P4XI+j4jl1i7G99ToDHprnGUuph2QJtzRqhk
 Y/xPeL3aF8NCvUAvbvOzrzZeJFY1DHMXKBPl5POz6R00Vq+rFf8y2F1dCrc9xkjPe7YfPZ
 MjOxbmc0B5RRhOVoDZJsojJH79Y8knd2ukTaprVv1CJdGpf9/6JpqCv6nvRMe9n9QODaHA
 Q+1gcsIdDf99agQbM218bGomKOlbXyVQJD/sUEyfT7eypXbzLpHMsTL8FMqfBeRJeU/vgl
 SXyboeM44NX5RtS1p7+f+mwt7m/oVdEecoNVB4zu/bNgjjZwh24UsPNqSCE0LkkkpjyoXi
 I52UEBI8XitE2CGOb0uoTffZzjGEuXBj+CKbrmmBfT6/QNoAja0KieikT1Lg
X-ME-Proxy: <xmx:Mlp0aqRkn2pPE_-1_Gk6aKPEOvIxpvqZV_DT80w1B6u9jjBpMCp1pA>
 <xmx:Mlp0atcYjaJmkcAgm5FI8QtorqjulkfFcdmBT0IbeJ7Rhg-RFIQJWA>
 <xmx:Mlp0apmnC6Y0QLAUtxDLe_jhr_w0OD87HpgqAcktESrYlnLSGPL-0Q>
 <xmx:Mlp0aiiLAdb0nEdrZ2TqARrl0VQSgN4lZ0BhgFK5YJ7skMXdwp4vbw>
 <xmx:M1p0asBF4N3AsCWRS2JEJAFlWx9N7kdh1VpOIOmmYA_aW2bjq4YRkhS5>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 05:55:54 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: diederik@cknow-tech.com, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, tomeu@tomeuvizoso.net
Cc: royalnet026@gmail.com, alchark@flipper.net, chaoyi.chen@rock-chips.com,
 iommu@lists.linux.dev, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jiaxing Hu <gahing@gahingwoo.com>
Subject: Re: [RFC PATCH v6 3/9] dt-bindings: iommu: rockchip: allow the RK3576
 NPU MMU clock set
Date: Thu,  6 Aug 2026 21:55:51 +1200
Message-ID: <20260806095551.368456-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DKHR2P0XJF0B.OY937NT39DR7@cknow-tech.com>
References: <20260806063413.350184-1-gahing@gahingwoo.com>
 <20260806063413.350184-4-gahing@gahingwoo.com>
 <DKHR2P0XJF0B.OY937NT39DR7@cknow-tech.com>
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

Hi Diederik,

> Now every MMU with "rockchip,rk3568-iommu", "rockchip,rk3588-iommu" or
> "rockchip,rk3576-iommu" is allowed to have a minimum of 2 clocks, instead
> of having exactly 2 clocks. That does not sound desirable.

You are right, and it is worse than sounding undesirable, it actually
happens. I gave an RK3588 NPU MMU a bogus third clock and v6's schema
accepted it without a word. That is a real loss of coverage for every
existing Rockchip IOMMU and I should not have sent it that way.

Fixed for v7 the way you and the bot suggest, with a compatible of its
own:

  compatible = "rockchip,rk3576-npu-iommu", "rockchip,rk3568-iommu";

and an allOf that pins each side:

  if compatible contains rockchip,rk3576-npu-iommu
    then clocks/clock-names minItems: 5
    else clocks/clock-names maxItems: 2

so the NPU MMUs are required to carry all five and everything else is
back to exactly two. Checked in both directions: the three clock RK3588
node is rejected again, an NPU MMU with only aclk and iface is rejected,
and every rockchip dtb in the tree validates clean.

No driver change goes with it. rk_iommu matches only "rockchip,iommu"
and "rockchip,rk3568-iommu", and the fallback stays, so the new string
is documentation only.

The name is the part I am least sure of. Everything else in that binding
ends in -iommu, which is why I did not use -mmu to pair with the
rknn-core node it belongs to. Happy to change it if Heiko or Krzysztof
prefer something else.

Thanks for catching it.

Cheers,
Jiaxing
