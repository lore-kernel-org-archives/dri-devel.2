Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2883606A322
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=D4hurscT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0954410F47C;
	Tue, 24 Nov 2026 11:49:26 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA29B10F47C
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 11:49:19 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso48120875e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 03:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795520958; x=1796125758;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=J1NeJEfZebfbcpy8hj3dQLRnIcpIwRmtjjuLE6tESEc=;
 b=D4hurscThJ1lAAVRKlzvRQ+PgLqscL3eX0foCGxmpnclCF4FptME8bxEEESPYCgtrR
 T+FsDlhefRKmmMHhc4N9UVySHh0lS5UmB/mV8dIbIYFTAu9dz8nO20iZj7DYwjDyI0YT
 Ozw8MbtuMA5Fj0qpMLcTf4OI/u4aGQVNzAvcqtd3Il5F4tuVui3235JlQq/jqIDXa+DF
 2wOf3a2ytZVqek2ier0MqSX6u6r3Onk2WpsF26S62CuvdPgs7JNAtjlc0QCCtbXWCyZx
 3JSO/N5iscI7hQ3Gz1kTdSl6NH/ZWRSPeoV1672rjs1wPv8DC0PefPo2d3k7NEDSoWkf
 Qr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795520958; x=1796125758;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J1NeJEfZebfbcpy8hj3dQLRnIcpIwRmtjjuLE6tESEc=;
 b=lVibWqpVUCHHtG0if5ulkUoWW9SmPt9Z8q+EKlhvqGcqSuW0JtClCKgQHOSX3OVi1f
 EGBFJRidPe0z7eSdtvr7fD0eBRF/bZ0iDaCy22eh4aJL6zif3+22VRDRub1vh+YhTsUo
 wPFzh+5Ts/hU2lvluotAam6qxuurtT7jKtcoo6snO8y/16czWC19NqEslaYBlTLgpDIh
 10xD/PV1Jx+HRqZKc6ELjSP4p/yJUVZKXwJptKsdaMtrmaF/hE7ggzaDKu0h9VqLBQLG
 EUXN3U0E+zBt36KX56uh3ifljwi/gfvyndcX2ZOkRW/0Mem2c5rTB32E51iG5V6WowW7
 iEyw==
X-Forwarded-Encrypted: i=1;
 AL+hErHj085Zu6pzDzwNLHhkVbxZ9YUqJ10OkyuoMwEQkxVvQWHJM0Xi9Hk1Hz+7rQy+ufkZTsvF08rqGKU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9WGSdhNybuHTjThLvvhg1a26803TuFjF0JkPa6tOaMv6yVF8xw
 db88uRsbnYcdz1Xf0YH13riuz2DGF+9KL2mBzjUZ419MEiWklpc9YoS4/AuSA4XzxS4=
X-Gm-Gg: AZFdTZd/8SSP/vfknVcejhdI1dsXI/cuFTcGrviS3K2e8Y8JDNoqbajwK4dYETJErJ4
 d8AypG+BZpeHJoID/FhQYh14PrN7KabUlB9HfqQm0HmBF4Syq/wIwVg4CnUq1fktMYHCx+PnRmc
 Hrvr/heKGSbMfN3d8mXg0OaE3Ir3URJjQTvOA5rkRwLh3jNf/7APWGK2p3HT+OrF4xFaolUYNvF
 JfiiMxsjtIXAA3Df296mfJpfBAIrKJBnsQFBLRSdYKPS/2ynBMi+WsAof1jjuxvn63HImPrFs7p
 8L2FiKOw2isJ1sk3Dymm+XQbaa2bQpeZdqRdeKObNzUXQHQ/gRgHMkNFLwEDXDhX6XRGLN7t6nj
 2KZ6PoWFA6orWSPnM8pfSXi+f4uQVJ5grlmPFSuGkOIAnDSVbMqpQsIelngVxWBczJpzSGSBG0E
 +Vvqv4rBosZsTj9e6UpGoekX/obO7SWGb/wiEXPF9g1kM2t3WnQ9A1ERVqMP1S96BQf8nRe+qS7
 +TbDF6KKwBLKNVrRKpnLCdYxOzcWWYjLNWDq64PNdN1wW4PSumhrqW5TgJkwsE4Hl982fpw8x6W
 abfQoaGwgYgtCjyML/ha1CLb41XqgfD+Qa/VnUO5rZJjmjDJv89pnANQHoutrJllH1IWxDkiR1J
 tsdLCPVy/TkIF2TsA8iYuptI=
X-Received: by 2002:a05:600c:b8a:b0:4a0:20b4:ba93 with SMTP id
 5b1f17b1804b1-4bb88818156mr290637705e9.16.1795520957605; 
 Tue, 24 Nov 2026 03:49:17 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183?
 ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a3a3dsm416542295e9.10.2026.11.24.03.49.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 03:49:17 -0800 (PST)
Message-ID: <99f6fa65-33f1-4865-9745-c092fff2e032@baylibre.com>
Date: Tue, 24 Nov 2026 11:49:14 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 7/8] arm64: dts: rockchip: add NPU (RKNN) nodes to
 rk3576
To: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net,
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, sidong.yang@furiosa.ai,
 ulf.hansson@oss.qualcomm.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, chaoyi.chen@rock-chips.com,
 shawn.lin@rock-chips.com, finley.xiao@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1795478392.git.gahing@gahingwoo.com>
 <f1d20ec832e10a80dc813aa10697632e8024a685.1795478392.git.gahing@gahingwoo.com>
Content-Language: en-US
From: Daniel Drake <ddrake@baylibre.com>
In-Reply-To: <f1d20ec832e10a80dc813aa10697632e8024a685.1795478392.git.gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/11/2026 00:01, Jiaxing Hu wrote:
> Add the two NPU cores and their IOMMUs, disabled by default. Core 0 is
> in PD_NPU0, core 1 in PD_NPU1. Label PD_NPU so that boards can give it
> the NPU supply.
> 
> Set CLK_RKNN_DSU0 to 594 MHz. Nothing scales the NPU clock or voltage in
> mainline, and the boot rate of 786 MHz at the boot voltage of 750 mV is
> outside the vendor OPP table and gives wrong results; that table runs
> up to 600 MHz at 725 mV.

I still struggled to understand this (particularly the choice of 594
MHz) even with your notes, but I think I got it now. Suggested rewrite
that will hopefully make it easier for others:

---
Set the DSU0 clock to 594 MHz for now. Radxa ROCK 4D boots with the DSU0
clock at 786 MHz with a voltage of 750 mV, however this gives wrong
results and the vendor OPP table suggests this voltage is only workable
up to 700 MHz. The rocket driver does not control the voltage yet, so
594 MHz (GPLL/2) is selected as the highest rate that we can select for
this operating point. Voltage and frequency scaling could be implemented
in future to more closely match the vendor driver behaviour.
---

Please tweak something along those lines, you can add my reviewed-by.

