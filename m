Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12203606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=c/pyyskz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D2D710FBBD;
	Wed, 18 Nov 2026 12:29:24 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E14D10FBC6
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:28:32 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4a68190a2a7so688911f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795004911; x=1795609711;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fApH6YF8/olwr8rszx1618Se8LLbeSsWPgcCTgBcSzQ=;
 b=c/pyyskz9HALVWSlz4gCpFXYx3/+B2vB2MWrqxcLzDNmbvSpQu02BVcMWU1RwoSffu
 UOOYz7nKMIPEj0QknKjwZouCMzWuLDnrfleT4p+S/XmLQDW4IwhEnGpNEsXoWOLDCWJa
 Dx7SFk2kchaqOmkE8i/Hsc2mDl87l240OypB9CyI2G877QgOGL/pPfZNHpCulo1udOxK
 tstZBWg5JuBp13/EF7SP9rjEz/zrMSFrZtnOOLZBrvbAliAioqIAKz27ikzxa7Fwxuf+
 YZODccHItQcD0o6uDb3GYW7mGAnW7EU7Xta99T/CTL53TXmztzqH/nbt2FJOwffk3qXZ
 Lc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795004911; x=1795609711;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fApH6YF8/olwr8rszx1618Se8LLbeSsWPgcCTgBcSzQ=;
 b=r27cleLXpvS/z2qFsbWlehBxPS/lSQfbHxv0+zGEwN16XsXTnZwWYuP8pdeYKthrem
 ErhH5gyNAhhEZ1RDxAxAl+a0HkB8xzJrs7qQO6eVspu4Jn9ya2w76BN11DPrjLCRmkLb
 eU4wzcxPk0lCb2XKrQpi374RdtQt1DbiPJpb79zCa01rzI58oWjogyTHQpYbruF+Po+a
 94EjPzLz9+oWDgWe+O1o51HhwF8bu5JoUGw/uLbACI37EvLOE37ASrFqUn7ZZDksEicM
 1uWpddS/3i2b3/Eh1TCZmMzjhxMdfh6+CZceCO7uIisSLXap3JnlO5wuZVKG005nLWbP
 0s+w==
X-Forwarded-Encrypted: i=1;
 AL+hErHWVQmf31CZSy7GuvslQ5wNC0s7b9efJM4/q6JllgMSG+FVUKZ3Wjngw1ePzoI5D6MKRcUUn2zpB6Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+DKEEK9b2pUM7/iNyD82X2Usn8OYzf96R7JFNhEbKCI/7cVoQn
 GggomSNMpgMt11U93JXDMot9knA+caKizvTqdIwvuNwtfx+JkV9UfHkg/sVgSsGZrZw=
X-Gm-Gg: AZFdTZdnBnDFGR1l4jeXzrOFJg/3uR1WJ8C9T3/HhLP1XlJzqGldhWbfTh5cXqkAhOT
 ZabfPKk4sLY3BasRxqqoHcMLZMdYsPPR/DjhytO1wYr0Av0DgwUy6VmG8bXDQkQmOm4WrEwHWhC
 Y97V/ESPtm+q8C7WEr8dMR1bfTRkwUqjoGPXSQ2uiWqqUoZnDHjJGs2lGaa1rb+bTKWpmfi39nH
 hYfjZt+r+J0rOz099U9Q8Mkn1/x8M9Z2RqTKMz2+GYzGI1SIJw2TEK0w/EcwgPEuKMBsPVcK3l6
 8tm8lg1nuwKdE6IwDfdMsbSQqBPNxJ/a8e/DankMSmBrvl6kSHvguOMogQUdiclhrMqJi/B0fQw
 wslaGnPee9/Vp4bq/L/UFaW6eDQrmTTMO/rDvx97gIMkf/SD+FYBisDpSpVNoMBeT3c7vyCyQSH
 uxeV0Qt+S49NnuqlKeImKymogRqU94GC0DAN5vZZ44Bx/UD8MeRL1omz+yDy6Mzi9TnA3H9vQIW
 zj/y22T9o5uHRlMGKJtOnn4G2MFbuPJwC+0GXyJDyvQGUf4iz2mI8p7MTivIBWF/irGxL70QBSU
 zGrqWnsmJ+WAUJYGvkwyOiUxsWMsh6+Fvu/l2sKlzzQo/OlpLxfeeELJzlt5ixtzEHsTyRAislS
 6mA==
X-Received: by 2002:a05:6000:2f86:b0:4a6:63cf:99a6 with SMTP id
 ffacd0b85a97d-4a663cf9ae8mr4421294f8f.23.1795004910709; 
 Wed, 18 Nov 2026 04:28:30 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183?
 ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c406sm4567452f8f.14.2026.11.18.04.28.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 04:28:30 -0800 (PST)
Message-ID: <15dbc800-ab4a-4b98-8f6a-95d2ae80819b@baylibre.com>
Date: Wed, 18 Nov 2026 12:28:28 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Daniel Drake <ddrake@baylibre.com>
Subject: Re: [PATCH v17 12/12] arm64: dts: rockchip: enable the NPU on
 rk3576-rock-4d
To: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net,
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, ulf.hansson@oss.qualcomm.com,
 abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
 sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, shawn.lin@rock-chips.com,
 finley.xiao@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 leonard@lausen.nl, vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 rfoss@kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <cover.1794615324.git.gahing@gahingwoo.com>
 <c0d64d55586774802bdd70defa016be6912ab83e.1794615323.git.gahing@gahingwoo.com>
Content-Language: en-US
In-Reply-To: <c0d64d55586774802bdd70defa016be6912ab83e.1794615323.git.gahing@gahingwoo.com>
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 14/11/2026 03:05, Jiaxing Hu wrote:
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> index f068794e48d4..72b251d396fe 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> @@ -779,6 +783,24 @@ wifi_en_h: wifi-en-h {
>  	};
>  };
>  
> +&rknn_core_0 {
> +	npu-supply = <&vdd_npu_s0>;
> +	status = "okay";
> +};

I can't figure out which code actually acts on this npu-supply
regulator, even after considering the patches in the "pmdomain:
rockchip: RK3576 NPU domain supply and settle delay" series. What am I
missing?


