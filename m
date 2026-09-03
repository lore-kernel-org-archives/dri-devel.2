Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3EFCC624DA
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44EC210F73B;
	Thu,  3 Sep 2026 18:52:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CxZSKjR/";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 310D510F73B
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 18:52:13 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4956d1d9fb2so288445e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 11:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788461531; x=1789066331; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kWGcV+CZXP9CxFvzIcOWKnbKfmDZVF807ifeZedNWGw=;
 b=CxZSKjR/mh8NpZeShkMANsvawY8ro7DOFFfVC89NZh78JF8oWMk0aMVrjhJv/Y1B+T
 OxFBAfDQm2TjRvkQevSnD8sa7aJl7BoGiQI2O6FJ16znYlPkXbhLBS1nK0q/1kAWcQiX
 +IQBuBQ5OqIcS0ivxNNdmjsLjabPctjjJXPQTAVGLr1K1K6TEEh7RbUFDNi9JkIQATyO
 8NizlUQ3UJvqUf5cW+yZKAhRjSDl5xCitzpaXqJvtd+brVbEIFhDLXx+tywtmkvwWVwx
 mQjYukE4Np1JAGHv5BdN4U8xgU6O4isu5SlqUZqx99epVNe4ZS5NMVvEPGPL/STTIINS
 ZTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788461531; x=1789066331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kWGcV+CZXP9CxFvzIcOWKnbKfmDZVF807ifeZedNWGw=;
 b=A9kGl1GGvnmNSPCajfS2Rb+w7nUgjNXNQLgnYhL3NLJ1motEpUUjySgNbOEt+Yx/Yx
 44FJcHq46ErZsRrtdmBtAizzj01W+95jEk4YF8Qdz6aTaYdzJL/ke1fM9hpaAoeb2Wt9
 vK1P2jvai3FXJf2POEXabhYh4RiUMJ2fVHWcSNPkDIm03ubaaDEcdoU1WiuwzaYctXOb
 FIpdo8kcY2C6dth71YTeL+36B7wmEPL+lC/qUyU9gPp0fyH8t9Y4ho2O6gmNyD7ydh0B
 Z9m0FAkRfW5RjR28mn2/8h/ozEnWJeIfcHtVDQseZsHKOY/TqpBKzAk2N7JJunV0QS24
 QRAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4DHTUBAi7TA/+vG5jDFDyiImiElnXVs7IXX6LrDS3GLWurhfEBTwJ6AgPhElHdeEWbbr6c27uKF4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lK2F1SFsEWLepefkqsXIiINWzcqNmaWT5Dyv+EcvycICcs2nd6
 Ii04Cl8iOzn5va5dt77aaYpWoG4tXaPdMI3KH1v+TV50vB+OSddlOyLb
X-Gm-Gg: AYBFou1LEkO1vmdnReI95KWvvgiPerB2p+WtH+D4b1yLc95STa/T2ezmDKRd+R6890G
 Bxwx77lJbxCpFhmanSpYwk9sHEKe0OTy3Muc8kk6Kgt3Pajotzg3frcvaG4FAWCCJAOampYDq01
 yRtu3b8F8rQJU0B9MUhHYxdWfQ1ci2umZC2O6pf5vJMbMZlCwR/nQ9Xq6Yvot7gZf4EcbQNe+xn
 ixzzMDCudtUarwPP0OreKYFvHL1+HfvsYEJHzBe3n1wxoMvjT6Ios98r45udu51IvlfU+x/JCun
 L1xZhwntXA3KJqR7AuAlvsU5RVX7ZLPWIII4woGG+/xBbQoxYyhClN7HAiy0QMdyXEWkrCk74/5
 cdaQSlbRZ4MPPeKeUU8B2rLqe8Xzsxktj6OuIPfopLwPDX+sc3CYjKUiPmRc6jXwUy7hOkmG2r/
 JXiQ0NYU834OTqWAzpVdTUzqQ1MU4ug94N4yStq8dZTjnGgPmyPOvMgZWxGzbwNqbn++MaK+lZW
 DxJag4xdykO1+mGAKDQbyD+HsIH73LQkvyKXRezT37n56WUHJFBzsYzuer/92s0qRtk
X-Received: by 2002:a05:600c:138a:b0:49c:f45f:b09f with SMTP id
 5b1f17b1804b1-49cf45fb368mr43232445e9.2.1788461531325; 
 Thu, 03 Sep 2026 11:52:11 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8962003434AB95A407E573.dsl.pool.telekom.hu.
 [2001:4c4e:1b89:6200:3434:ab95:a407:e573])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf772692dsm6604945e9.10.2026.09.03.11.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:52:10 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Huseyin BIYIK <boogiepop@gmx.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Nicolas Dufresne <nicolas@ndufresne.ca>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Heiko Stuebner <heiko@sntech.de>,
 Jiaxing Hu <gahing@gahingwoo.com>, Oded Gabbay <ogabbay@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [RFC] accel/rocket: DVFS on RK3588 - a hardware constraint,
 and some numbers
Date: Thu,  3 Sep 2026 20:51:41 +0200
Message-ID: <20260903185147.49411-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2f88072c-6aa3-4294-a35d-722d1c7a405c@email.android.com>
References: <20260801131656.58450-1-royalnet026@gmail.com>
 <ad1e526e-a4cf-4c34-88ff-1884ef2f3dfe@kwiboo.se>
 <286e8418-fae6-4979-96d1-e13abb04b3a1@kwiboo.se>
 <3204a0d0-969d-4ac6-adfd-29c57f1c3e0a@kwiboo.se>
 <20260819125932.5853-1-royalnet026@gmail.com>
 <82c8b17e-7215-45ea-84d1-9991ba6fb541@kwiboo.se>
 <20260819184807.6665-1-royalnet026@gmail.com>
 <f5241666-9657-4f49-958f-476fd366e408@gmx.com>
 <20260902110432.22069-1-royalnet026@gmail.com>
 <20260903091646.7183-1-royalnet026@gmail.com>
 <2f88072c-6aa3-4294-a35d-722d1c7a405c@email.android.com>
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

Hi Huseyin,

> if the ccf is really giving locked 1ghz it is most likely reporting
> back what it is set, since scmi is probably returning 0, and ccf is
> ignoring that.

That was worth testing, so I did, this evening: 104 samples at 1 Hz
under sustained MobileNet load, reading in the same instant
CRU_CLKSEL_CON(74) from the kernel and scmi_clk_npu from clk_summary.

  CON74 = 0x00001011, bit0 = 1, in all 104 samples
  scmi_clk_npu = 1000000000, in all 104 samples

With bit0 set, clk_scmi_npu_get_rate() in your commit takes the
PVTPLL branch, which has no fallback: it returns whatever
NPUGRF+0x24 holds, so a zero there would have come back as 0 Hz, not
as 1 GHz. The "return the set rate" path is the GPLL branch, and it
was not taken. So the readback is the counter, not the request.

> If you read the clock in each 1 sec, you should almost always see a
> different value with several hertz of difference.

Agreed, and the register cannot show that: it reports whole MHz.
What I can say is that the NPU value was constant to the MHz over
104 samples, while the GPU on the same BL31 moved between 1047 and
1054. I withdraw the word "locks" from my last mail; "constant to
the MHz" is what was measured, and whether that is a tighter loop or
sub-MHz jitter is beyond this register.

> So it was a theory and probably a weak one.

Fair. What is measured is only this: the same register, read in the
same instant, gives a value from EL3 and zero from EL1. I will stop
calling the cause a firewall until someone knows what it is.

One more correction, to my mail of 18 Aug in this thread: "the 2.58x
I measured here with simple_ondemand against the 200 MHz pin" was a
projection from my harness, not a measurement. Measured today on one
boot, rail at 850 mV, bit-exact oracle in every run:

  userspace @ 200 MHz    89 inf/s   (NPU-side 9.65 ms)
  userspace @ 1000 MHz  222 inf/s   (NPU-side 3.02 ms)
  simple_ondemand       221 inf/s   -> 2.47x, 0.7 % below the pin

The magnitude held; the provenance was wrong, and I am sorry for it.

Enjoy the vacation, there is no hurry on any of this.

Igor
