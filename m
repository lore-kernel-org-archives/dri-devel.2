Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D02560A262D
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 02:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=Ns/2mPV9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DBA210E8B9;
	Tue, 10 Nov 2026 02:52:45 +0000 (UTC)
Received: from mail-m822136202.xmail.ntesmail.com
 (mail-m822136202.xmail.ntesmail.com [8.221.36.202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0619410E8FD
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 02:52:37 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 541744873;
 Tue, 10 Nov 2026 10:52:32 +0800 (GMT+08:00)
Message-ID: <ab5694a1-2f10-4888-ad27-20715d3f98a6@rock-chips.com>
Date: Tue, 10 Nov 2026 10:52:31 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] dt-bindings: phy: Add rockchip,rk3568-edp-phy
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dave Jones <s.dave.jones@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
References: <20261030064905.2248999-1-damon.ding@rock-chips.com>
 <20261030064905.2248999-3-damon.ding@rock-chips.com>
 <20261103-lemon-guillemot-of-economy-eefbbd@quoll>
 <fd180b9c-de60-4718-b17f-319bf4339e13@rock-chips.com>
 <20261106152915.GA3406543-robh@kernel.org>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20261106152915.GA3406543-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa1c35f1cad03a8kunm4f8fb2772be325
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHh1CVh1NGh1CTUxNTh4ZQ1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
 5KVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
 b=Ns/2mPV9pH9bVvzBBCDzik0xz9kGzB25NEhWCgaJIvkA3av+MymfxdL510FRETs5vrsiCdISksI3CW1wh0tet9VEr08fX0Gv7MFLrFvI8AT3q6u9sMAphY8Oao2Ra1viV41VNtT+Z+VO25d7jt6OQBQja6J3O3lp6ZQ84Bc7Lus=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=1pznVwkEZpAe1hyxNb7ShpTi+47BEMmqvSU22FSDZfs=;
 h=date:mime-version:subject:message-id:from;
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Rob,

On 11/6/2026 11:29 PM, Rob Herring wrote:
> On Wed, Nov 04, 2026 at 04:59:58PM +0800, Damon Ding wrote:
>> Hi Krzysztof,
>>
>> On 11/3/2026 7:20 PM, Krzysztof Kozlowski wrote:
>>> On Fri, Oct 30, 2026 at 02:49:01PM +0800, Damon Ding wrote:
>>>> Document the eDP transmitter PHY with NaNeng IP block found on the
>>>> RK3568 SoC.  The PHY has its own register window inside the eDP PHY
>>>> GRF, so its node is modeled as a child of the eDP PHY GRF syscon with
>>>> a reg property describing that window.  Also add the
>>>> "rockchip,rk3568-edp-phy-grf" compatible and the phy node reference to
>>>> the Rockchip GRF schema.
>>>>
>>>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>>>>
>>>> ---
>>>>
>>>> Changes in v4:
>>>> - Add the reg entry for the PHY node and the ranges/#address-cells/
>>>>     #size-cells for the parent syscon node.
>>>> ---
>>>>    .../bindings/phy/rockchip,rk3568-edp-phy.yaml | 68 +++++++++++++++++++
>>>>    .../devicetree/bindings/soc/rockchip/grf.yaml | 20 ++++++
>>>>    2 files changed, 88 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3568-edp-phy.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3568-edp-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3568-edp-phy.yaml
>>>> new file mode 100644
>>>> index 000000000000..b78da00ffefd
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/phy/rockchip,rk3568-edp-phy.yaml
>>>> @@ -0,0 +1,68 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/phy/rockchip,rk3568-edp-phy.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Rockchip eDP Transmitter PHY with NaNeng IP block
>>>> +
>>>> +maintainers:
>>>> +  - Damon Ding <damon.ding@rock-chips.com>
>>>> +  - Heiko Stuebner <heiko@sntech.de>
>>>> +
>>>> +description:
>>>> +  On the RK3568 SoC the eDP PHY is controlled through the eDP PHY GRF
>>>> +  registers, therefore the PHY node is expected to be a child of the
>>>> +  eDP PHY GRF syscon node.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: rockchip,rk3568-edp-phy
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +    description: PHY registers within the eDP PHY GRF.
>>>> +
>>>> +  clocks:
>>>> +    maxItems: 1
>>>> +
>>>> +  clock-names:
>>>> +    const: refclk
>>>
>>> Just "ref"
>>
>> Will fix in v5.
>>
>>>
>>>> +
>>>> +  "#phy-cells":
>>>> +    const: 0
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - clocks
>>>> +  - clock-names
>>>> +  - "#phy-cells"
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    #include <dt-bindings/clock/rk3568-cru.h>
>>>> +
>>>> +    soc {
>>>> +      #address-cells = <2>;
>>>> +      #size-cells = <2>;
>>>> +
>>>> +      edp_phy_grf: syscon@fdcb0000 {
>>>> +        compatible = "rockchip,rk3568-edp-phy-grf", "syscon", "simple-mfd";
>>>
>>> This is beyond the scope of this binding. Drop entire node.
>>
>> Will Drop in v5. The example should only show the PHY node itself.
> 
> Actually, drop the whole thing and put in GRF binding if you want an
> example. MFD examples should be complete, not piecemeal with each
> sub-device.
> 
> 

Understood. For incoming v5, the example will be dropped from the PHY 
binding schema entirely, and the complete MFD example will live only in 
the GRF binding schema.

Best regards,
Damon

