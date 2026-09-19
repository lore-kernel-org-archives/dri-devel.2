Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CA7C982CC
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 09:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53DE110E038;
	Sat, 19 Sep 2026 09:17:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="l8c1G/gl";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="gVlgQCYA";
	dkim-atps=neutral
Received: from flow-b7-smtp.messagingengine.com
 (flow-b7-smtp.messagingengine.com [202.12.124.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FCC010E038
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 09:17:22 +0000 (UTC)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailflow.stl.internal (Postfix) with ESMTP id E8AB913000F1;
 Sat, 19 Sep 2026 05:17:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Sat, 19 Sep 2026 05:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1789809441; x=1789816641; bh=aLilx+Y+5Rd4TJOso07SZXSV7ysiX5Nj
 vH1w9ELaVHs=; b=l8c1G/glBvhdQrD+MwiJbSXZze7hrXrpKIZFOr1Milmd++GG
 yV8hD+Mwo1+eUQiYoQxF8BWZ+WU3eF0Re2fsFK06rZQhcUnR/rVmT3r5I52Ba7H3
 J6rjyIzpCwqHlMXJ/8jUWjK00/qWgW77xaGfOdHY0E8K/lM5p67zkXhZSE2mSg9I
 ppcIhGGoInybx73k/mPZUh6nAoRVGlIfQfHlhwFoiCLb0NkTOowRWhpVrlKKHddV
 jOX18elzZoKJEyqkcd3HC33YB4PaiucYtfWIEqb9mRKrbW0U+bzD+EPg5OcIZACz
 iGuHMDE0er+iZi6GamlzW0j+Ctdip0gs6WEuGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789809441; x=
 1789816641; bh=aLilx+Y+5Rd4TJOso07SZXSV7ysiX5NjvH1w9ELaVHs=; b=g
 VlgQCYA/hlnRKUNR7656JJVxQaoF2rWHx/7ahmBVxw9uGaJbxeR+IC2VzNBG9mbK
 1pE0FxVvsKZKxXs6dkUw52jnVzEuHq1+9ieN78v9aoZH3KAIbkyANvjJ14+XG9kg
 CMj6ar3OiCyaOOPGFyuFPIonPwsjNl9/8GqjHME0Xj40+EwZY2la+pKPkxm8Kv6f
 6Xa10oXK+5QXWkpx9PKewmu3Zcz/hXZ6LxVokyRgWUhV6cgTWKRN5jMu4VVpniP/
 NbnCFY2poVL5BWKiCriUFeqpF6cxjg/5PU6VaXDXlXLcg+x+0NMIS0CrLFM5BT7K
 86yT0aOGboj6A+ueuN5Bw==
X-ME-Sender: <xms:IVOuanRvubhnRI0dGlQSAQSc9QkG-d3-AgaH_wxvoKJQEtYtsMTzOw>
 <xme:IVOuaqTWpx3zgrjQGGDfwJlboteScZ2WUHrnrTVx473rwTDbOJkJ98xAjjwH3sPG9
 Todg7M5R9hFazW2uV5i8Jph6eFWwH-SD055Yc8UtmkQlIwmgd-W8_xU>
X-ME-Received: <xmr:IVOuas54k7foM9PKvm4cS8zi1ZY3OXDL3awgAv0HsXbpd5mhgE9NDgKtNvoRoTUcovmVeOZAkA>
X-ME-Proxy-Cause: dmFkZTFQP+qejIQprqt8h9363tqg90+edW0FX+PTKqTzUtU/iBB4pYRUfWmSM9LFptzZNl
 XWhNTMvIFffh1P9nio1ewd4IzoEU/OawTO9oBLgNE+CZ7kADavEBeecX1ZY75ks1+am05p
 Wxl8VO1FQ9TrcxPCQEMQsLmmP6nIpk7/Rtoj4iwEKp7nj7G5jrrzi/8yycNWY2eefBBQPU
 IbkpBHC29wBkbLuNwCMgQec9zQniZZtdr5dtYaAzDBQvooKQwQ5PVJ+GQTPmNezKAg/2OA
 oMGkkE/jvoOdZq36sNQOdv07gnVyjaEWq2lrQnwTWFSCnlv5HNtX7RY3BXUXP3m0hmQXoq
 /C4M+4fTKIUbeF42t0nZ6IaiLbNipI/2BsiA9m2kYFt1xgQi8VvtWi17FWIZUGredp/PGb
 YaTA3nD+yBAuO3YTpr8A4ELYzgiGWJo/PCpEP6aqciPdZUEnA5NDlIGZy9LmLyvXT9mEhk
 S67bBRUlWSZmv7Y3yxSyYB8LvX21Bxqf5/oDJggTXyM1VHEyuFiG/dO1JzAcLbTbrIhNYk
 zdodeY6l9x8RqQCVgbT2m3bud8Z+D/x46tDJqDb++DlqG/pzqVKEuCWbGhY/TFYb2gvg9U
 mAhyhxACG2C8K3zUAOBLF73d1TXuPhHHltN58Y68FWSTe2k94aUsZi3M9fTQ
X-ME-Proxy: <xmx:IVOuam3dN6637-m96OyUZCVbQHbsNHyQQ5lSwchBu9YKStWeAvKVlQ>
 <xmx:IVOuanB9blsIA3eY5Hy_0rX0oNgSTAZryD-P1ULvOOCpsLjpp9YTKg>
 <xmx:IVOuahNKb-097alUinLtT8iX_ctLfDZSp8ZkEJMPm8FG8DynvGrX_Q>
 <xmx:IVOuasb2NiGpDq15omhF9P-Kg8czxPAS9vDJiEhXhr8aGzMxkI3Kqg>
 <xmx:IVOuamzDDhHJqsuWenwMjUzW5TmQVz8VD6kjTMlNVevt2IV-Vx0oS_ko>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Sep 2026 05:17:19 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: sidong.yang@furiosa.ai
Cc: tomeu@tomeuvizoso.net, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v13 00/14] accel/rocket: RK3576 NPU (RKNN) enablement
Date: Sat, 19 Sep 2026 21:17:15 +1200
Message-ID: <20260919091715.8933-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aq41BAp-6P0HMFBB@rock-5b-plus>
References: <20260915104328.45901-1-gahing@gahingwoo.com>
 <aq41BAp-6P0HMFBB@rock-5b-plus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi Sidong,

It is not private: https://github.com/gahingwoo/charsiu,
GPL-2.0-or-later. It reads a GGUF, quantises the weights to the NPU's
int4 or int8 itself, and submits the matmuls through this driver's uAPI,
with no Mesa and no Rockchip userspace in the path. On a ROCK 4D with
this series applied, Llama-3.2-1B at four bits decodes 17.85 tok/s at
594 MHz, against librkllmrt's 12.85 on the same board and clock. Both
were run here.

It is not the first, though, and the one before it is on your SoC.
gregordinary's rocket-userspace and ggml-rocket drive an RK3588 through
mainline rocket, and rockchip-npu-notes collects the measurements. Worth
reading before anything of mine. Their finding is that the NPU is a
prefill engine and decode belongs on the CPU: "Decode (M=1 GEMV) is
forced to the CPU, ~82x slower on the NPU".

charsiu is not a port of that work, and it runs decode on the NPU, which
is the thing that finding says not to do. On RK3576 the vendor does it
too: 3752 of the convolution dispatches in its own Llama-3.2-1B file are
M=1, and they are the model's projections.

Which is the caveat for you. Your From: says rock-5b-plus, and charsiu
has never run on RK3588. CBUF is 1 MiB there against 384 KiB here, three
cores rather than two, twelve task-number bits rather than sixteen, and
a different weight tile stride. The register encoding and the weight
layout would have to be rewritten. The quantiser and the model frontend
would not.

Regards,
Jiaxing
