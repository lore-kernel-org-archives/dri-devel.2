Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831FB606A328
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 09:15:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF7A310F42B;
	Tue, 20 Oct 2026 09:15:16 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1F6610F41E
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 09:15:14 +0000 (UTC)
X-QQ-mid: zesmtpip4t1792487651td50b66ae
X-QQ-Originating-IP: PBOfxz++v/LvFipXH7mVzfeUBqvezzb47+j5WyN5cAw=
Received: from [127.0.0.1] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 20 Oct 2026 17:14:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13061347834158941364
EX-QQ-RecipientCnt: 31
Message-ID: <3935A48BAE8900B9+821b9e6f-e494-4af5-a79c-f418cfe2157e@radxa.com>
Date: Tue, 20 Oct 2026 17:14:05 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sc8280xp: add Radxa Dragon Q8B
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski
 <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>,
 dragon@radxa.com, Daniele Briguglio <hello@superkali.me>
References: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
 <20261009-q8b-dts-v2-4-eda11e5dea8b@radxa.com>
 <ec5ae206-beda-42d5-b152-91c457218374@oss.qualcomm.com>
From: Xilin Wu <sophon@radxa.com>
Organization: Radxa Computer (Shenzhen) Co., Ltd
In-Reply-To: <ec5ae206-beda-42d5-b152-91c457218374@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N80S9118e2YFBN69V7WMnABHdv69jDs1t1hmtB2E69T2YGGv2BpsmWya
 R1N/Pyp7/IvlHyxt7HrvVQNgsgtDeim5iP6weNna7OWQw7Qrukqr561LpvG7rpd3qvnMP6B
 nGKEoKiAFlfscPxDZs+4Dt1WoMiY31gAXQCNpJiMtQw9LRCdpN9wtuotNCb/qLC1kmKPdd0
 l7+Dg8/LyVLP8tlWQMC4GcFYH/QyvcsWkXidfKlo7RBtpORTdaf/FfejnUrc+6Jz93dr3yy
 bflB7O3h9oJ+z0Zg7HLmLC2U/TBbtefWZYy8f1XdOX9x7wXlpYLYOX0d3woiGZ1ZlFFJmod
 73c+pUNsglnit1sRH+zrH7c3mLI2hcLWJSiqu8Uy4jBEuUMGDLtJcRAsYzTHnIaoaQ1XZCY
 wFhWcggIzsLouddkrM2uu+pMlR0+5j2a+cbebqbKljNcBUWw2rW/TmCiBdeddZM+HLVydYf
 Z1FH06Fetu1HxFOPLWdgMMcNX2VBtqqVG9hhzVN8x97gci8K++PAkxwGsokTHV7i7+WCafc
 11KhJ2Fl+P729Kii+BtCOjLiJ87PLEDZU9iZxPG6POx4ORQP7Rif7w9tuP4fYvHwl/fPxkG
 3SFKi0z8Zxpgbfs7VuCr440KuLFITI2T6jYkzNG2XvAdn/+HoLQ2nWzQA6OG2keByMCGOYM
 9KzoHmErXNwn+Sjniiqb2uDZ4Cw1ObsB+7+PqII1JualaKbym5FFcwNifDmEnfYZSd8JNZG
 Q85zqE9LBoCYLnb14RtLKYsjAiLppN1/exi9DRWUh93Tda3jgJNjfnIAuW3Flh+icP3lGee
 YaCF2rKvJ+MVRpHbbnsudKZaag9cVCb9+Q7HmoNW3zO7TetiwCHC2davyO5xlHZ6zwZoTAt
 bvtxXMdLSLuOyVaBdKO0TsgF1IiWSeNrFv9Kp7Otp4USwq7q6Yd4B5ohW4q0vbSMBfQsPSb
 2mNbeoXo5uLpU/7ip6PxZulk+/IWLJNiUpEERAgaqqMgNKg7HXlV37DyYulq0SmzlNOVTck
 s3BNZf5Nkl5/TKgGUH9mL/S7lgv/XWtHmEm7//a+y0Tu01NpCdPfLQ5tOzudAlt1CUMxX9N
 atsvESTO2MEN8DNBdmc7BUDFI7Ymmkyp0uOz02WOmRr3WIjgeE3fCAXBKmGHtsRAqC6d/MT
 O0QcUuKRiPJByVM=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
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
Reply-To: sophon@radxa.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/2026 4:28 PM, Konrad Dybcio wrote:
> On 10/9/26 9:55 AM, Xilin Wu wrote:
>> Add initial device tree support for the Radxa Dragon Q8B,
>> a single-board computer based on the Qualcomm Snapdragon 8cx Gen 3
>> SC8280XP platform.
> 
> [...]
> 
>> +	hdmi-connector {
>> +		compatible = "hdmi-connector";
>> +		type = "a";
> 
> No i2c bus and hpd?
> 
> Konrad

The i2c bus is directly connected to the CH7218A bridge. HPD is 
configured using the TLMM edp_hot function on GPIO_2.

-- 
Best regards,
Xilin Wu <sophon@radxa.com>
