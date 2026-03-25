Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C84F106B52A
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AED2810E872;
	Wed, 25 Mar 2026 12:51:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="VxqI3tMF";
	dkim-atps=neutral
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 741B910E8A2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:51:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3046D10D7D0; Wed, 25 Mar 2026 13:51:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1774443091;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=UU6Obqyjf0TTXWPo4v01hIfA04+zL1qD53sBGNeuK8c=;
 b=VxqI3tMFtrpMG5jkTRi/WUjSfF6HrBWxTPwBpkgujiMLF8Y4/CeMP1y5Errzfiw1T4souj
 uH9ZOxYlXXXOJciqqRSxvZ9Nqk9vAZql7soEOXqCFs1KayBZCJn0YVcs/qhEmD9i6DWT3P
 fyxVUOxhI7R5kBx+8wmuebIYf8EFwvpGK6FisKWj9G4tnUk1AYpaQ1XBRw+R/sQrbvBKFH
 p+rzVQLSaoohOKPb8Cxp1gSGFNt0aNEfy3JzFIcQlLAi57FUZN9dOcJuNRryCiDYdpAbtF
 id4WqScaGGWOOKJ7sOrzxTI4yFq9DmqaNryINH341RF8I4gOGwtXcLAfzCTtzA==
Message-ID: <5fdc83c2-28c7-4aec-9dee-dd8c9ab6548b@nabladev.com>
Date: Wed, 25 Mar 2026 13:51:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/9] dt-bindings: display: fsl,ldb: Add i.MX94 LDB
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Liu Ying <victor.liu@nxp.com>, Marco Felsch <m.felsch@pengutronix.de>
Cc: imx@lists.linux.dev, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, Frank Li <Frank.Li@nxp.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260304-dcif-upstreaming-v8-0-bec5c047edd4@oss.nxp.com>
 <20260304-dcif-upstreaming-v8-1-bec5c047edd4@oss.nxp.com>
 <b7968f1a-c4bc-4bad-bcf8-407ff2d8db27@nxp.com>
 <dmqbmmpyi3ssvq67iqwbt6ww7tsaik7ifi5dnupmuhep7u5saz@ads5g7ette3y>
 <mx6b5svmvlonil4efuiaxcmtygn7lld3nj7gcxnnauaryt2yed@gohjshakc2g6>
 <40b3d1c8-0cf2-470d-8223-751240061735@nabladev.com>
 <xqy67fmh42k26iagl7wqrh2dbsn7c5fytwbkcksfzagefp327j@s5hg4lpuvy3q>
 <4e75f1d3-29ff-46a2-adb5-78a08f781834@nabladev.com>
 <2fe36f04-97d3-4e99-97e9-7a3ac53cffdb@nxp.com>
 <p7glzm344tiu76zm5aa7qq4lswdcjuqlqel3hl3tr3s2cllltj@i2eyzuux4cj3>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <p7glzm344tiu76zm5aa7qq4lswdcjuqlqel3hl3tr3s2cllltj@i2eyzuux4cj3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 3/25/26 9:02 AM, Laurentiu Palcu wrote:
> On Mon, Mar 23, 2026 at 03:22:35PM +0800, Liu Ying wrote:
>> On Sat, Mar 21, 2026 at 03:37:47AM +0100, Marek Vasut wrote:
>>> On 3/20/26 9:23 AM, Marco Felsch wrote:
>>>
>>> Hello Marco,
>>>
>>>>> The LDB driver was always written with parsing 'reg' out of the DT, so
>>>>
>>>> Not sure what you mean by always.
>>>
>>> By always, I mean since the very beginning.
>>
>> Marek, your below patch is not accepted(at least for now).  In that patch,
>> register offset(s) are directly parsed by calling of_property_read_reg().
>> Without that patch, register offset(s) are determined via device data in
>> driver according to compatible string.
>>
>> [PATCH v3] drm/bridge: fsl-ldb: Parse register offsets from DT
>> https://lore.kernel.org/all/20260104213712.128982-1-marek.vasut@mailbox.org/
>>
>> [...]
>>
>>>
>>>>> encoding the register offsets into the driver was a mistake. The LDB
>>>>> controls two registers, which can be comfortably described in DT.
>>>>
>>>> Sorry but I have to disagree on this. It's no about if it's possible,
>>>> it's about if the abstraction is correct and IMHO the LDB is just one
>>>> subdevice of the syscon. For i.MX6SX the syscon is the iomuxc-gpr for
>>>> the i.MX8M and i.MX9 this is now a blkctrl.
>>>
>>> Right, and the "reg" DT property specifies at which offsets are the LDB
>>> control registers from the start of that blkctrl. What is the problem
>>> with that ?
>>
>> The problem is that ...
>>
>>>
>>> Look at e.g. imx8mp.dtsi as an example with blkctrl and LDB as a subnode
>>> with "reg" DT properties:
>>>
>>> 1938                         media_blk_ctrl: blk-ctrl@32ec0000 {
>>> 1939                                 compatible = "fsl,imx8mp-media-blk-ctrl",
>>> 1940                                              "syscon";
>>> ...
>>> 2003                                 lvds_bridge: bridge@5c {
>>> 2004                                         compatible = "fsl,imx8mp-ldb";
>>> 2005                                         reg = <0x5c 0x4>, <0x128 0x4>;
>>> 2006                                         reg-names = "ldb", "lvds";
>>
>> ... i.MX8MP LVDS bridge node is fine with the reg property, but the property
>> is not allowed for i.MX93 LVDS bridge node according to commit[1] while
>> commit[2] requires the property for all LVDS bridge nodes.  See the contradict
>> here?
>>
>> [1] 3feaa4342637 dt-bindings: soc: imx93-media-blk-ctrl: Add PDFC subnode to schema and example
>> [2] 8aa2f0ac08d3 dt-bindings: display: bridge: ldb: Add check for reg and reg-names
>>
>> To avoid the contradict, how about requiring the reg property only for i.MX6SX
>> and i.MX8MP LVDS bridge nodes and making it kind of optional for i.MX93 and
>> i.MX94 LVDS bridge nodes?  Overall, in terms of the reg property, I feel the
>> LVDS bridge nodes look similar to reg-mux/mmio-mux(See reg-mux.yaml) where
>> the property is optional.  BTW, there is a mux-controller node with 'mmio-mux'
>> compatible string in i.MX8mq syscon@30340000:
>>
>> iomuxc_gpr: syscon@30340000 {
>> 	compatible = "fsl,imx8mq-iomuxc-gpr", "syscon", "simple-mfd";
>> 	reg = <0x30340000 0x10000>;
>>
>> 	mux: mux-controller {
>> 		compatible = "mmio-mux";
>> 		#mux-control-cells = <1>;
>> 		mux-reg-masks = <0x34 0x00000004>; /* MIPI_MUX_SEL */
>> 	};
>> };
>>
>> We never know if HW designer would put a mux-controller next to a LVDS
>> bridge under a syscon device like gpr or blk-ctrl in future i.MX SoCs,
>> so the optional reg property would buy us some flexibility.
>>
>> The below patch is what I propose together with a Fixes tag for commit[2].
>> Since commit[2] is not in v6.19 and v7.0-rc5 was just released, it seems
>> that we have time to land the proposal fix if it makes sense.  WDYT?
> 
> Marek, Marco,
> 
> Does Ying's proposed solution sound reasonable? Having the 'reg'
> property optional for i.MX93 and i.MX94 platforms seems like  a good
> compromise. Can we move forward with this?
I only skimmed through it thus far, I need to read through it again when 
time permits, after which I will reply to it.
