Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE5A606A339
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=MHZnCuK3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A1EF10F145;
	Wed,  4 Nov 2026 09:00:10 +0000 (UTC)
Received: from mail-m8191.xmail.ntesmail.com (mail-m8191.xmail.ntesmail.com
 [156.224.81.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFCDE10E307
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 09:00:03 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 5376b923e;
 Wed, 4 Nov 2026 16:59:59 +0800 (GMT+08:00)
Message-ID: <fd180b9c-de60-4718-b17f-319bf4339e13@rock-chips.com>
Date: Wed, 4 Nov 2026 16:59:58 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] dt-bindings: phy: Add rockchip,rk3568-edp-phy
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
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
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20261103-lemon-guillemot-of-economy-eefbbd@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa1a5c95c3e03a8kunm4bbaef2a348d4c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTklPVksZGRpLSxlPSBgYH1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
 5KVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
 b=MHZnCuK3X0/bHPD1qBFBpPTg5quAPx84ehdDHx+2O7e+ZW0NvxFEq3Qa7uJmJjE/dpQuLUHBLvCCA7Erx3R7UwcpFYvbZelF7bJukJ0Kp7fqAV1l7q9ezBQqrl4ZAThxvSRXaHEinP0DVtJ8ttPK0TCapb15cyIRtY1FZvkdsBk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=eAdT+8rLd44bxIIAm/zwqM4YbafLLwH/m+nhuD3g5QU=;
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

Hi Krzysztof,

On 11/3/2026 7:20 PM, Krzysztof Kozlowski wrote:
> On Fri, Oct 30, 2026 at 02:49:01PM +0800, Damon Ding wrote:
>> Document the eDP transmitter PHY with NaNeng IP block found on the
>> RK3568 SoC.  The PHY has its own register window inside the eDP PHY
>> GRF, so its node is modeled as a child of the eDP PHY GRF syscon with
>> a reg property describing that window.  Also add the
>> "rockchip,rk3568-edp-phy-grf" compatible and the phy node reference to
>> the Rockchip GRF schema.
>>
>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>>
>> ---
>>
>> Changes in v4:
>> - Add the reg entry for the PHY node and the ranges/#address-cells/
>>    #size-cells for the parent syscon node.
>> ---
>>   .../bindings/phy/rockchip,rk3568-edp-phy.yaml | 68 +++++++++++++++++++
>>   .../devicetree/bindings/soc/rockchip/grf.yaml | 20 ++++++
>>   2 files changed, 88 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3568-edp-phy.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3568-edp-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3568-edp-phy.yaml
>> new file mode 100644
>> index 000000000000..b78da00ffefd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/rockchip,rk3568-edp-phy.yaml
>> @@ -0,0 +1,68 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/rockchip,rk3568-edp-phy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Rockchip eDP Transmitter PHY with NaNeng IP block
>> +
>> +maintainers:
>> +  - Damon Ding <damon.ding@rock-chips.com>
>> +  - Heiko Stuebner <heiko@sntech.de>
>> +
>> +description:
>> +  On the RK3568 SoC the eDP PHY is controlled through the eDP PHY GRF
>> +  registers, therefore the PHY node is expected to be a child of the
>> +  eDP PHY GRF syscon node.
>> +
>> +properties:
>> +  compatible:
>> +    const: rockchip,rk3568-edp-phy
>> +
>> +  reg:
>> +    maxItems: 1
>> +    description: PHY registers within the eDP PHY GRF.
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: refclk
> 
> Just "ref"

Will fix in v5.

> 
>> +
>> +  "#phy-cells":
>> +    const: 0
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - "#phy-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/rk3568-cru.h>
>> +
>> +    soc {
>> +      #address-cells = <2>;
>> +      #size-cells = <2>;
>> +
>> +      edp_phy_grf: syscon@fdcb0000 {
>> +        compatible = "rockchip,rk3568-edp-phy-grf", "syscon", "simple-mfd";
> 
> This is beyond the scope of this binding. Drop entire node.

Will Drop in v5. The example should only show the PHY node itself.

> 
>> +        reg = <0x0 0xfdcb0000 0x0 0x8000>;
>> +        clocks = <&cru PCLK_EDPPHY_GRF>;
>> +        ranges = <0x0 0x0 0xfdcb0000 0x100>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +
>> +        edp_phy: phy@0 {
>> +          compatible = "rockchip,rk3568-edp-phy";
>> +          reg = <0x0 0x100>;
>> +          clocks = <&pmucru XIN_OSC0_EDPPHY_G>;
>> +          clock-names = "refclk";
>> +          #phy-cells = <0>;
>> +        };
>> +      };
>> +    };
>> diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>> index 7bcb4e2f47ec..c089bd014003 100644
>> --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>> +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>> @@ -93,6 +93,7 @@ properties:
>>                 - rockchip,rk3399-grf
>>                 - rockchip,rk3399-pmugrf
>>                 - rockchip,rk3562-pmu-grf
>> +              - rockchip,rk3568-edp-phy-grf
>>                 - rockchip,rk3568-grf
>>                 - rockchip,rk3568-pmugrf
>>                 - rockchip,rk3576-ioc-grf
>> @@ -119,6 +120,8 @@ properties:
>>     "#size-cells":
>>       const: 1
>>   
>> +  ranges: true
>> +
>>   required:
>>     - compatible
>>     - reg
>> @@ -156,6 +159,22 @@ allOf:
>>             $ref: /schemas/phy/rockchip,rk3288-dp-phy.yaml#
>>             unevaluatedProperties: false
>>   
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: rockchip,rk3568-edp-phy-grf
>> +
>> +    then:
>> +      required:
>> +        - "#address-cells"
>> +        - "#size-cells"
>> +      patternProperties:
>> +        "^phy@[0-9a-f]+$":
>> +          type: object
>> +          $ref: /schemas/phy/rockchip,rk3568-edp-phy.yaml#
>> +          unevaluatedProperties: false
> 
> Properties should be defined in top level. Here you only narrow them.
> 
> This binding is getting close to unreadable/unmaintainable. Split new
> devices with children to their own binding.

Agreed. The "rockchip,rk3568-edp-phy-grf" syscon will be documented by
its own binding schema in v5.

Best regards,
Damon

