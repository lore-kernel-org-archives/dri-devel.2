Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8FCC5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FD4E10E53B;
	Wed, 19 Aug 2026 12:59:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jEQ0f9E2";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D70A010E53B
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 12:59:53 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-481595afa73so125346f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 05:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787144392; x=1787749192; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dA5rU+vuRqS0Z+LPWRZHCw6d9diJLksBuXxk6FmF4tw=;
 b=jEQ0f9E2fg8Zk34r9tH7Vwc4xYfepj5NnrlI6LHV92PuyoqC0JMzPJcczxRIgySsxA
 9ILtTIUlYaNmIpjOXRylFAEb6Lwy430KqmeeHaTyEkWS6MMSSllJ32wb7xeRwvXrpQTw
 58/m1XxkcM8kzFrY/+duUqeu0MDYY803238pp4Yr4QSM0QG9bFK5fUmTWGnou8QzcM3A
 9P+Ple7hHoQknaWo2SrvkDVlP1Vs51kZWs5vQsGNIfKVaTdV18JCH3xmDgeobKVDsMhP
 lqaQZQnrX7vhYMY/VgrfULMR+fb8srJ0hcSDilBVAnBXJP04DKK8zjxBqtf1BtpD1cwR
 21Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787144392; x=1787749192;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dA5rU+vuRqS0Z+LPWRZHCw6d9diJLksBuXxk6FmF4tw=;
 b=EtpPCjLgYABQ6YLMETn/9+SVTKbX4+Vo/QV4wB5T/vCfRkG9pqkndi0bH/6l0zezVl
 doUB5HC+uX6ZCc0dnh9ex51uR+S2T2720BCO01FxJ2KJY+97g9cQMl5FqsySxqGnc8P4
 PFB3THrR2oSQMI+5DW0DXRC73gjfnFCAtug/ld6kQoyJU3y2wkcTZe7kRLBEjqcKfG8W
 YilQvbz9/gSKUeZ97VSYCc3SJ4YLzq43+vyKwv4LzpaL0yNS4Zjtg1eMMK/0GJQlcp8X
 nc/P4pPLoriHaUJTo0lpTGqmQvC/oq83rH77lncsIzhGFMvtjQSwU0ruu489Tr9bPZvY
 9gTA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUQ7n9mSdjlRqQbzGd095impj91xeyQilPtIXMhKilnxm8JqSFPrTMYdWNwPhdxo6A/tIAs+tkXOE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k4X5I5lLXodPhf2QNDggLz2AiDITc91X2GzENxUTihZJsiGPUb
 tj4Ax5+LKke7f7y6fv1ygSBVgSWQXG00eCpl7a7JzTUr3gx8Iaf4mTW4
X-Gm-Gg: AR+sD10Jacten5p/W9BMM+3v04LwSXAWwlVxoR+a3k3ah/X4lipGicMqbjLykoIMK3b
 kcQbHN8BF0+370Pn3iaQcokudDVHuZqE/umkj91uYjiV54Yz9lMzp9RKXSjDS7zaOBxoXyk14t4
 gtDGaLulQHnO5OWHjenSIp8IfiSbTw4WaZZjGvatWWZoSGohYDeVOiPQuGmsaoUaLD1lJtVBylK
 dwxXsvdGKYtLPrniDjk3YZwAWn8ClQj7SQMvrXHI83bPGRPImVRazBcMDL/kbogMMi6wHQBX8ny
 k+moAOmJ+fVRPTfNduFuKrRpZw65n3Ic3QRY4OJUmiyVtZVnYbeLXFtrR3hfDc3sof6QeuC/w/e
 aV9IC11I2fMaUPM5anNcBBa4r3JCRxK20EYuLZdg+d1HCwNox1sDWsGRAyheTSToDzWwhvrc2sy
 WtMt6hgnMas9MvPSvnbV0abBDJPw6rc9K6f6rFG1A1eLTWwE0CecLcEnqCtvZ3K5DMKNWpiAZco
 0HwDybjjQbxK+JXRPGWt3Yl4j7xJuuinj0tKR/7T01gqCn7S+7yid+wKyZxo/Kr9OZT8Q==
X-Received: by 2002:a05:6000:701:b0:47f:dfc1:6907 with SMTP id
 ffacd0b85a97d-482b1fc4e0dmr4045866f8f.3.1787144392065; 
 Wed, 19 Aug 2026 05:59:52 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B929600FBC58E6E51BF6D72.dsl.pool.telekom.hu.
 [2001:4c4e:1b92:9600:fbc5:8e6e:51bf:6d72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14d059bsm5128441f8f.36.2026.08.19.05.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 05:59:50 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Nicolas Dufresne <nicolas@ndufresne.ca>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Heiko Stuebner <heiko@sntech.de>,
 Jiaxing Hu <gahing@gahingwoo.com>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: Re: [RFC] accel/rocket: DVFS on RK3588 - a hardware constraint,
 and some numbers
Date: Wed, 19 Aug 2026 14:59:30 +0200
Message-ID: <20260819125932.5853-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <3204a0d0-969d-4ac6-adfd-29c57f1c3e0a@kwiboo.se>
References: <20260801131656.58450-1-royalnet026@gmail.com>
 <c495dae1976dab842d77f4a4a142217eb77b6fb7.camel@ndufresne.ca>
 <20260818072936.41844-1-royalnet026@gmail.com>
 <ad1e526e-a4cf-4c34-88ff-1884ef2f3dfe@kwiboo.se>
 <286e8418-fae6-4979-96d1-e13abb04b3a1@kwiboo.se>
 <3204a0d0-969d-4ac6-adfd-29c57f1c3e0a@kwiboo.se>
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

Hi Jonas,

I promised to determine empirically which clock the NPU PVTPLL needs.
I ran that today. The answer is not what either of us expected, and it
comes with two corrections to my previous mail, so those first.

Correction 1: I wrote that only core 0 requests PCLK_NPU_ROOT in the
mainline DT. That is wrong - all three rknn-core nodes request it as
their "pclk" (my grep had truncated the clocks list; verified since in
the tree and in the live FDT). The hazard window is unchanged in
practice - the gate still closes whenever all three cores are
runtime-suspended, which is the normal idle state - but the sentence
as I wrote it was false.

Correction 2: my inferred failure mechanism ("the GRF write cannot
land, the mux still switches, the ring is left unconfigured and the
failure appears later as a power-on ack timeout") understated reality
considerably. Measured today:

Test module, on the same v2.12 firmware discussed earlier: acquire the
clocks via the core DT node, verify all three cores runtime-suspended,
then issue one clk_set_rate(scmi npu clk, 600 MHz - a PVTPLL-path
rate). Serial console at loglevel 8, captured by a recorder on a
second machine, so the last lines survive whatever happens. Three
arms, one variable:

  held during set_rate          outcome
  pclk_npu_root                 SoC resets, U-Boot 0.58 s after the call
  pclk + hclk (the PD pair)     identical, 0.58 s
  nothing (control)             identical, 0.58 s

No oops, no SError trace, nothing on the console after the set_rate
marker in any arm - the SoC dies at firmware level and the reset
latency is constant to the millisecond across all three. Bus clocks
are simply irrelevant to this failure: my open question ("does the
ring also need hclk_npu_root?") turns out to be the wrong question.
No root clock makes a domain-off set_rate safe.

The explanation most consistent with the data is that the NPU GRF (or
the PVTPLL block behind it) sits inside the NPU power island, so the
EL3 write to 0xfd5a2000 with the island off is fatal regardless of any
bus clock state. I cannot rule out that the firmware dies elsewhere in
that path, but the clock-independence is measured, not inferred.

The counterpart run closes the loop: same module, same set_rate to a
PVTPLL rate (1 GHz), with the cores resumed first - completes cleanly,
and the GRF readback then matches the firmware table exactly (ring
length 12 for 1 GHz in CON0_H, cal_cnt 0x18 in CON1, 0x40000 gating
interval in CON2). So the sequence we discussed is confirmed live in
the registers, and the domain state is the single discriminating
variable.

For the series the consequence is now sharp: every path that can issue
an SCMI set_rate - governor, sysfs, cooling, OPP init - must guarantee
the domain is powered first. The hold-all guard stays ordered before
the devfreq patch, and your pm_runtime_suspended() check in
config_clks() guards the OPP-initiated paths for exactly the same
reason. On mainline as-is the NPU exposure is theoretical only because
nothing scales the clock yet.

One small ask: we tried to read a ring frequency counter in the NPU
GRF (candidate offset +0x24) to publish measured ring frequency vs
voltage; it reads zero with the ring demonstrably running, so the
candidate is wrong. If you happen to know the OSC counter offset in
the GPU GRF from your experiments, the pointer would save a TRM dig -
if not, no matter.

Regards,
Igor
