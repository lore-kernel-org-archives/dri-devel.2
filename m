Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886A0C5AD5A
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 03:12:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4927A10E5D6;
	Sat, 15 Aug 2026 03:12:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="my+xzyu4";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="TLr3AkZP";
	dkim-atps=neutral
Received: from flow-a1-smtp.messagingengine.com
 (flow-a1-smtp.messagingengine.com [103.168.172.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B1DD10E5D2
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 03:12:29 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailflow.phl.internal (Postfix) with ESMTP id 15BC31380143;
 Fri, 14 Aug 2026 23:12:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Fri, 14 Aug 2026 23:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1786763549; x=
 1786767149; bh=kA/r/VQ4oatiVrzWTgockk3L+gnj8KfRxkcgdbcdrgY=; b=m
 y+xzyu4XGxX89R9BPPH2r4HycR70j72NO71yUVejjsHNMmKT5UL+vXJBvPPABrFI
 DZ1eZw+/hbZVPNYnLWrzAsnEM2/tA9cnNCjVB34vi7aGqniZJP8DkwTnopj31VBj
 Jm5iskOZEEPZOaG5yjMYIt1t+mIhH7jD9Y8lzwOAYjws0xErS+8Dp5WO4W7perv/
 ZJj6WkUWlKYMMkfzhQoeTeoTRtNwFb3E4H8FuduD8sqviA+RHZ0pSpHzBfa3jR25
 lxWdwD+va6lXl/5D3ogHwG8/oHEuBr7mUyXaBpSt6nawDOImb4+sx4fX/RbavKIP
 aqu5Rj/XI827ApovwrNgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1786763549; x=1786767149; bh=k
 A/r/VQ4oatiVrzWTgockk3L+gnj8KfRxkcgdbcdrgY=; b=TLr3AkZPdY1OSoYux
 mu86NASV1gS2/ZY4RmxJGG1Bf3X/63sJN7tuNPiac5PtSUyuDEXgDni4VZEGDd1H
 Yb3Lr3tNa0umwZDk2De1bZ38EjatGPw3P1u3JDvFz0LfdASrTO3BIXUfKQQuAB/l
 wT1tyqQEwtzBguK46ho2JOVJixtPzWOesGbXApnstbue/dvCFdQBtvQP7e6UcVsJ
 b/ub7FEs94cNDBWunsQqR7HHGxkRUPLanPWEcN/T/bTUm/Y2dmOEArG+DBJKu+Np
 uikDoGNwJvXvn+PclRm05aRIGno08p7vud9EcuW0iW19bortLKKEYvgO9QFkDNVS
 GOzbg==
X-ME-Sender: <xms:G9l_atKqXN089uuc6PNCPQY4pqgYsjI9YAnsvbC_gq73ROTqDomP5w>
 <xme:G9l_ahV499lvGE4mbeyLIEDOAUBWI0ERKewzCHtk-PHAKu3OtvZtnNWL84eMafRDG
 j5Z8OE7is4g_msWNziX-B10efBMMrH4hRKjoK1v7SzM163CRjPjsA>
X-ME-Received: <xmr:G9l_ahTBF5ecTZlYho-xfQHpaYU9hvezcQ3c5Nld3aNnaaAhaGYRQsjry4p6FP4F453DnqHVeg>
X-ME-Proxy-Cause: dmFkZTFZ5VqGgVICYTHgTtgPrQBIUDcIY34EnsjaahPws85NFbLnwUfD1zbYJtwkWFhAbF
 HcEX6DZFoTadXmZS8lVH1Tr+kZuEtjBy9n9AjLXYP6roYnZ4WYXyKIp7H3Iw8JSmbqjdeu
 0BhtvY0WwoH7RH0iz5lKnB/p+pS7FrKo/2mGKz2Q9uTQ1xWFxFgunu51D0VyP/UgSD+YD2
 eoAndAFcFCAyWlmHfbbBbXgoRQjaUWm5pKlLeXk18SfETRE7XCZl09NNoPcpGTzV5gSOjk
 7mS93aRmO0qga0dLfv1I1FU9xNoxqWv5uKsjO7BqSmgv1j5yzTEF7qxKvzWNC+X9+ciIiF
 4DUQfYxRUwooKhtfQB5lGeFzULhZAOx0V14mWgYRkQu3Rpuk/U58PMru+A/6p4epiyOayi
 UQkykI/88SZIMap43nC97DadGZbFdKNZ5HPknw0+2u3/WQ7GENBzOvR8xKyRLMTu7uBl/w
 I5aChnxRLrdAW4kCkYgT+MlAU1pDOzjOzHeVweFnroj7GljzoYNrxQ2nfDPKkh4LBYjuIS
 7PAAQCu7fyCs6SIn73iKCN5j4pjX8CBqt2LuZoQjGjm4yO7PlDgxuhEYTDH0gshXWoRy6l
 XHA5f2cY7xKXYkRy8k6ZyomlUnnKgr/DQ1Me7m02dLLDHKcNCqZWiujqjBpQ
X-ME-Proxy: <xmx:G9l_apCzfWUYyiIGRuUth_2Nwj8yinkNMeWTNTGe9WreFd1_Iphgkg>
 <xmx:G9l_agIY54UB27FMmg6hlqIUcW2cF6QGLKEgyUkntKqyePcleommWQ>
 <xmx:G9l_asDXs3eVJ_ewV-xQnBk3wgOQ7-B4XZqr0mz5x8zMeU7WixsjSw>
 <xmx:G9l_att3NMC9WKzrQkuO5SeUU_nEa-BY7qARs0Ty1sPZm9bP3YEjJw>
 <xmx:HNl_ajoJMhXzR-fmcQXQ87wbYsdYgSOQUWjf-adPSS_AxjgAY2Sho3t5>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 23:12:23 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: royalnet026@gmail.com
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, chaoyi.chen@rock-chips.com,
 alchark@flipper.net, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>
Subject: Re: [PATCH v7 08/10] accel/rocket: add RK3576 NPU (RKNN) support
Date: Sat, 15 Aug 2026 15:12:19 +1200
Message-ID: <20260815031219.3860651-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814110841.11238-1-royalnet026@gmail.com>
References: <20260812094106.1391698-1-gahing@gahingwoo.com>
 <20260812094106.1391698-9-gahing@gahingwoo.com>
 <20260814110841.11238-1-royalnet026@gmail.com>
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

Thank you. This is the column I cannot produce, and it settles the
question it was aimed at.

First, what you were comparing against has moved. The RK3576 collapse
from operator 4 with maxdiff 255 is gone; four Mesa faults came out
between that mail and yours. Against the same simulation RK3576 now
reads 21/64 md 13, 18/128 md 14, 9/128 md 13, 4/128 md 23 and 7/128
md 10 at operators 3 to 7, which is the simulation exactly, and
MobileNet end to end is 1000 of 1001 outputs within one count of the
CPU. So the thing your run was built to characterise no longer exists,
and your table is measuring something else.

That something is worth a note, and I do not have an explanation for it.
From operator 4 on RK3588 sits below the simulation where RK3576 now
sits on it, 8 of 128 against 18 at operator 4 and 20 of 256 against 36
at operator 8, with a few hundred elements per surface already off by 1
to 4 at operators 0 to 3.

My first thought was that this is my Mesa tree rather than your silicon,
since you ran upstream and four fixes are not posted yet. Checking it
before writing it: three of those four are not gated on the SoC, but
none of them bite at MobileNet's channel counts.

  the CBUF row cost fires when ceil(ic/16) is 3 modulo 4, which is 33 to
  48 or 97 to 112 input channels. MobileNet has 3, 32, 64, 128, 256,
  512 and 1024, so 1, 2, 4, 8, 16, 32 and 64 atoms. Never 3.

  the output channel pair rounding fires on an odd count, and the
  coefficient operand alignment on a count that is not a multiple of 8.
  In this model that is only operator 28, the 1001 channel classifier,
  which is past the end of your table.

  the fourth, the tiled 1x1 weight layout, is inside the RK3576 path.

So my hypothesis does not survive its own arithmetic and I am not going
to send it as one. Operators 4 to 26 on your board are unexplained by
anything I have, which means either RK3588's own path carries a rounding
difference RK3576 does not, or my simulation is closer to RK3576 than to
the hardware in general because that is the chip I tuned it against. The
second is the more likely and the less flattering.

If you ever want to close it, the cheapest probe is operator 28 rather
than any of the ones you ran: 1001 output channels is odd AND not a
multiple of 8, so it is the one operator in this model where two of my
unposted fixes would change anything on RK3588. On RK3576 without them
it came back an empty convolution.

One more thing, since it cuts against my own earlier note: operator 3
scoring identically on both chips retires the suspicion in my round 104
write-up that its asymmetric stride 2 padding was the first RK3576
divergence. It was not, on either SoC.

Jiaxing
