Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78FF606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 02:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=hLPmJ282
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DA1A10E504;
	Fri, 23 Oct 2026 02:35:08 +0000 (UTC)
Received: from mail-m20521016437.xmail.ntesmail.com
 (mail-m20521016437.xmail.ntesmail.com [205.210.164.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEA4210E504
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 02:35:00 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 52123f987;
 Fri, 23 Oct 2026 10:34:55 +0800 (GMT+08:00)
Message-ID: <45615806-fa9a-4823-8f96-9a906e4433aa@rock-chips.com>
Date: Fri, 23 Oct 2026 10:34:54 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] dt-bindings: display: rockchip: analogix-dp: Add
 support for RK3568
To: Rob Herring <robh@kernel.org>
Cc: Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
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
References: <20261020030916.3223833-1-damon.ding@rock-chips.com>
 <20261020030916.3223833-2-damon.ding@rock-chips.com>
 <20261021133002.GA3886567-robh@kernel.org>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20261021133002.GA3886567-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa1669c826703a8kunm895555f01716b0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSR5JVk4YS0IeTk5MH0NOS1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
 5KVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
 b=hLPmJ282eTgyBRhFIComvj78l4vIa84ErkQymRNMxoY0RgAFUIbIegUnHzdyzCaPeZHu7N1zuHwFlctmx/1NHXSnzItVBvPAC4TxtK4oXwyaJSvDTKLEXeXCs4dnSLQk3TYEixGBh/Q9B2dONuKZXAzcdCq5DXv/MAMPyt8eao0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=g7p57vMomCUBZccjEesEUi9+rounalBz2hqbDLPfdqw=;
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Rob,

On 10/21/2026 9:30 PM, Rob Herring wrote:
> On Tue, Oct 20, 2026 at 11:09:11AM +0800, Damon Ding wrote:
>> Document the "rockchip,rk3568-edp" compatible.  Like RK3576/RK3588,
>> the RK3568 eDP controller has the dp/pclk/hclk clocks and dp/apb
>> resets, but unlike them it does not use GRF registers, so make the
>> "rockchip,grf" property conditional on the SoC.
>>
>> Also document the optional avdd-0v9 and avdd-1v8 supplies, which are
>> needed by the RK3568 eDP controller.
>>
>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>> ---
>>   .../rockchip/rockchip,analogix-dp.yaml        | 25 ++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
>> index 39dafe75a680..f8670a4e0430 100644
>> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
>> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
>> @@ -15,6 +15,7 @@ properties:
>>       enum:
>>         - rockchip,rk3288-dp
>>         - rockchip,rk3399-edp
>> +      - rockchip,rk3568-edp
>>         - rockchip,rk3576-edp
>>         - rockchip,rk3588-edp
>>   
>> @@ -47,6 +48,16 @@ properties:
>>         - const: dp
>>         - const: apb
>>   
>> +  avdd-0v9-supply:
>> +    description:
>> +      A 0.9V supply that powers up the SoC internal circuitry. The actual
>> +      supply source varies between different boards.
>> +
>> +  avdd-1v8-supply:
>> +    description:
>> +      A 1.8V supply that powers up the SoC internal circuitry. The actual
>> +      supply source varies between different boards.
>> +
> 
> Are these valid for other compatibles?
> 

Got it. These properties are not required for other compatibles.
I will restrict them to the RK3568 compatible in v4.

Best regards,
Damon

