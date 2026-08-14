Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BABC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 08:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA9B10EC68;
	Fri, 14 Aug 2026 08:27:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="FyCEQVXC";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="d0q3UoAl";
	dkim-atps=neutral
Received: from flow-a6-smtp.messagingengine.com
 (flow-a6-smtp.messagingengine.com [103.168.172.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A871510F062
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 08:26:59 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailflow.phl.internal (Postfix) with ESMTP id DD626138029B;
 Fri, 14 Aug 2026 04:26:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Fri, 14 Aug 2026 04:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1786696018; x=
 1786699618; bh=0nRj2hLp7dpKjdKjqfKtiu3Ukh6tmnaMstGpJ7o7t3s=; b=F
 yCEQVXCESdDx5Nxk5sAt/aZuRJiSD2hRodCVS09tBhoAIyE9GQ7HleJtLhgt+4nO
 aKBuhvLM5KCPbIUsIUjUInnYkcXzul71lYXG5NhQS8vdDtIotuthwgghjczeFStx
 9N5G5seVM3/subPtPNpO4eGgeLF2Q1BF6+6MgbgdIqOx5SfElhQlcurVNikotk67
 Iosy5WozfyScNfewneDgZoBuJI22BsuHNDOCqqhWykGoyJ0+Z/jKdUfqFYAx7qxx
 U7hn40fzdY/HkpgNzU9TLh+TOozWY8oRjJrxId0ovkERIUuF3UNYiuT/UpQKGAkI
 4qRNmuVb51vLpqSMcLleQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1786696018; x=1786699618; bh=0
 nRj2hLp7dpKjdKjqfKtiu3Ukh6tmnaMstGpJ7o7t3s=; b=d0q3UoAlPjDQiQFn6
 d6hB92BxbsdFo1IhQIpht0GsQjENyCaY83qDUYYBAw/QvoLUprnrMA2D34VkrjUv
 DcEmZHk4FjfXm6n3rznZT5j+btTjjBzC/n1wh9L8PRF5AXH549OUsIWC1ImHK1PJ
 uFYThG/U2rxShsZga3c88VAPFzwjYdAXtNaRaT3eK6tcmPPqGXEkDsfwSG6/Lkml
 PjLEF1K/i4OyAskH1w9CwVDWfAA/cTgynd+nGj6JJnNQhqLh5okLu260LlacPKQA
 9P+0WxM1lWDkqaAAUHyf8PjDOFI3NgS89QW2c0WdIsd2XsoaCn3+BpRMym13ND6V
 4JfoA==
X-ME-Sender: <xms:UtF-atIVS1RA6vd00Rdi6fCo7C_lrjH5eJfDvta5_juhrcKORfi_iQ>
 <xme:UtF-ahUHnVUJ2mDpBzEQRjlQm3kQPu4Q_lxzX5Rod3IhBNFYPPLwwsRunzsh0lawb
 J8PgRP2lue7jvCAWsLjOwIUKAj7etD9Cq7ahVnmVDSnf0lXirf-Pp7J>
X-ME-Received: <xmr:UtF-ahSkD89nmNhftsFY-4T-IvZN81xYVhUpl9k5P2K5857po6pFnWbxjTvnb7AvyT-8xIauig>
X-ME-Proxy-Cause: dmFkZTF1vbujDXZ4zL/lNYTa4cf3hxExvwiiGIWei4lqgO8vpso+bbW5yM/DRSWM/0cJeH
 El2HgEn1e0YXpWnvHQ/mtXOgjKLkJDApplpOWs73nIOCR1wYMIy6IEPGKbn5dcUxeiyBOi
 HCGUyKXclYDa7k9zzY4zpzgQxlvoJueA3q51wME8c5WSRv5U4Ud+RMcZXxcVQRa3XcEila
 p7KrfQxJZxdR+bfs0hB9Ch6VrPhqO/msBa8dfgmimhJYWr12AUU1tiipAAa5sUtBFEam5b
 xC+dm0LPLR6E+Ymv6XYwiyQcrrXwehicFzdcJe9S/M1z7/rruCtoqgSlheSwn/WuKM1HGw
 ZjyvcCPYvSVD0Ya7Hpios/BzuRRpSArIGtURCjsalLtW+VnPzlCNLPyK9Ovlt5wu9YZOlu
 Z3jVhjDPSuziLi6daNpNx82tJZR6loHgoEhFMgYJ2xKNp8Xn2PLSxnni8PL3lhLthSQy8v
 dB8wqlTmQwtYHiB6j1KCyYXyYZbl6dSz60R+tC1x8Zcb0WwnHjzCds0F4RG1r9pXoS1FT/
 di00JnAOw8Ca1RAuJtkm389AQIAq1zAIg+7SabTuPa9eLyQXLiW3CmABq8FynWTFUV9PTh
 NK59+MLOo6WX1rGd/vo8vWXl2IwEdNBJhXP25mUYgUVFaNPyQTe6Np4YGDIw
X-ME-Proxy: <xmx:UtF-apBa-zMssP7px7-Jq_N4qGjQOEh8C96KDJpo7GsfufLbjFsz8g>
 <xmx:UtF-agIzcUkhO2S0-BRxY2qVv8UIjEjWykyHi68gQQQElLtG6pk2SA>
 <xmx:UtF-asBWw7FU5UmCzbGBzfUfPH3QqFdNywpfquua_V0VEIeAhnJ0DA>
 <xmx:UtF-atuK53hVOPl3iVXy8-WhTI8xluY3tSZgxqKOkkH4J3fB2JJ93A>
 <xmx:UtF-ajrQeps5mdPrUrCc-ofDB92oCiJBHrcZpBDym-exDLcExiPSG573>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 04:26:54 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: royalnet026@gmail.com
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, chaoyi.chen@rock-chips.com,
 alchark@flipper.net, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>
Subject: Re: [PATCH v7 08/10] accel/rocket: add RK3576 NPU (RKNN) support
Date: Fri, 14 Aug 2026 20:26:52 +1200
Message-ID: <20260814082652.3852617-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813095718.9747-1-royalnet026@gmail.com>
References: <20260812094106.1391698-1-gahing@gahingwoo.com>
 <20260812094106.1391698-9-gahing@gahingwoo.com>
 <20260813095718.9747-1-royalnet026@gmail.com>
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

> I had the window right and the location wrong.

That is the useful half. v8 carries synchronize_irq(core->irq) before the
guard in rocket_reset(), with the comment above it saying what is
actually guaranteed rather than "Remaining interrupts have been handled".
Driving the reset path deliberately rather than waiting for a timeout is
worth more than the rest of the run put together, since that is the only
path either change is for.

> Say the word and I will point it at the CPU reference the way you did.

Please do, and thank you. It is the one comparison I cannot produce, and
it separates two things that look identical from here: a defect specific
to this SoC, and the reference's own rounding compounding through a
chain.

Two things before you spend time on it.

The number moved. When I wrote 995 of 1001 there was still one fault
left in Mesa, an output channel count that is not a multiple of two,
which the CNA reads in pairs. With that fixed it is 1000 of 1001, so it
is one output rather than six, and whether one output is even worth
chasing is a fair question. The comparison is still worth having for the
LAYERS rather than the final vector.

And the oracle matters more than the run. A per output comparison
against the CPU is not enough on its own past the first layer or two,
because tflite's requant and the hardware's disagree by design and that
disagreement compounds: at operator 6 a flawless accelerator scores 4 of
128 channels against the CPU. vendor-capture/chainmodel.py in

  https://github.com/gahingwoo/linux-rk3576-npu

runs the graph twice from the model file, once with tflite's
SaturatingRoundingDoublingHighMul and RoundingDivideByPOT and once with
the hardware's single half up shift, and prints what a perfect
accelerator would score at every operator. Read your numbers against
that column rather than against 128 of 128, or every deep layer will
look broken on both SoCs.

If it is easier, mn_L00 through mn_L26 in that repository are MobileNet
with its graph output moved to each operator's output, which is a four
byte patch of the flatbuffer and needs no converter. Those are what the
per layer table came from.

Jiaxing
