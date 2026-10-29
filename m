Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76477606A320
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=YdoWYHPw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E454C10E56D;
	Thu, 29 Oct 2026 17:53:37 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D28010E56D
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 17:53:30 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261029175328euoutp0160d85dd29c36cd0c8e7d870a148e9be2~jEZUo7_mo2181221812euoutp01L;
 Thu, 29 Oct 2026 17:53:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261029175328euoutp0160d85dd29c36cd0c8e7d870a148e9be2~jEZUo7_mo2181221812euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793296409;
 bh=EVH99uGrBjV1LXCPbiOuybiSxiADyCk5jOCu0FgStEE=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=YdoWYHPwmJN/KFk1TlDkNYhFdqmZj/+KS3IoG8aUG8OuAgV1ZKqmChA8RwrBrtk63
 2EJ8N/oXBcYm8Rwj8dyL2ZcdLI4kx5PA50P7t8b4ByliK/9E9X0wVJGo4OfCo34HTT
 H6cNO/1oBoDGGt1dGhGX7IqLdqiGAWce09a+/23o=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261029175328eucas1p2ceead9bf1d2040fb65ca9ac941f6b6fa~jEZUAr23j0643406434eucas1p2V;
 Thu, 29 Oct 2026 17:53:28 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261029175326eusmtip1da81d3d531e57fbb55db47bb699094a6~jEZR9_Q1X3030430304eusmtip1N;
 Thu, 29 Oct 2026 17:53:26 +0000 (GMT)
Message-ID: <777c7a8c-de7c-4f0c-9c9c-d5b78a5595d8@samsung.com>
Date: Thu, 29 Oct 2026 18:53:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/18] dt-bindings: soc: starfive: Add
 starfive,jh7110-hdmi-subsystem
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-rockchip@lists.infradead.org, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, William Qiu
 <william.qiu@starfivetech.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 devicetree@vger.kernel.org, Andy Yan <andyshrk@163.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Dominique Belhachemi <db@domibel.de>, Maud
 Spierings <maud_spierings@murena.io>, Joshua Peisach <jpeisach@ubuntu.com>,
 David Airlie <airlied@gmail.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robert Foss <rfoss@kernel.org>, Sandy Huang
 <hjc@rock-chips.com>, Paul Walmsley <pjw@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Heiko
 Stuebner <heiko@sntech.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Conor Dooley <conor@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Yakir Yang <kuankuan.y@gmail.com>, Emil
 Renner Berthing <kernel@esmil.dk>, Manivannan Sadhasivam <mani@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, Hal Feng <hal.feng@starfivetech.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 dri-devel@lists.freedesktop.org, Xingyu Wu <xingyu.wu@starfivetech.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Jonas Karlman <jonas@kwiboo.se>, Graham
 Markall <hello@big-grey.co.uk>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, linux-riscv@lists.infradead.org,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <179329528881.3539981.14637229355908751610.robh@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261029175328eucas1p2ceead9bf1d2040fb65ca9ac941f6b6fa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261029075358eucas1p111293c602fc3aac9c6a044fc41488919
X-EPHeader: CA
X-CMS-RootMailID: 20261029075358eucas1p111293c602fc3aac9c6a044fc41488919
References: <20261029-jh7110-clean-send-v6-0-759594e43acf@samsung.com>
 <CGME20261029075358eucas1p111293c602fc3aac9c6a044fc41488919@eucas1p1.samsung.com>
 <20261029-jh7110-clean-send-v6-4-759594e43acf@samsung.com>
 <179329528881.3539981.14637229355908751610.robh@kernel.org>
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/29/26 18:38, Rob Herring (Arm) wrote:
> 
> On Thu, 29 Oct 2026 08:53:38 +0100, Michal Wilczynski wrote:
>> Add the dt-binding for the StarFive JH7110 HDMI subsystem.
>>
>> The JH7110 HDMI IP is a monolithic block containing both the digital
>> controller and analog PHY in a single register space. This binding
>> defines the parent device, which holds the shared register map, and its
>> two children: the PHY and the controller.
>>
>> The two have separate resources. The PHY takes the 24 MHz reference
>> clock and provides both the pixel clock, which the VOUT clock generator
>> routes on to the display controller, and the phy the controller uses.
>> The controller takes its clocks from the VOUT clock generator. What
>> they share is the register space, which the parent maps.
>>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  .../starfive/starfive,jh7110-hdmi-subsystem.yaml   | 95 ++++++++++++++++++++++
>>  1 file changed, 95 insertions(+)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-hdmi-subsystem.yaml: Unresolvable reference: /schemas/phy/starfive,jh7110-inno-hdmi-phy.yaml#
> Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-hdmi-subsystem.example.dtb: hdmi@29590000 (starfive,jh7110-hdmi-subsystem): phy: False schema does not allow {'compatible': ['starfive,jh7110-inno-hdmi-phy'], '#clock-cells': 0, 'clocks': [[4294967295]], '#phy-cells': 0, 'phandle': 2}
> 	from schema $id: https://protect2.fireeye.com/v1/url?k=e93a78e1-88b16dd1-e93bf3ae-000babffaa23-e7f80dd3ed8ff65f&q=1&e=27d4095f-5012-49f1-94e3-a63fd9693348&u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fsoc%2Fstarfive%2Fstarfive%2Cjh7110-hdmi-subsystem.yaml
> Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-hdmi-subsystem.example.dtb: /example-0/soc/hdmi@29590000/phy: failed to match any schema with compatible: ['starfive,jh7110-inno-hdmi-phy']
> 

This patch depends on the JH7110 HDMI PHY series which adds
starfive,jh7110-inno-hdmi-phy.yaml [1].

With that series applied dt_binding_check is clean.

[1] - https://lore.kernel.org/all/20261028-jh7110-inno-hdmi-phy-v6-0-f3379684d97e@samsung.com/

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>
