Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5826FB5EA9
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 03:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5824B10E885;
	Fri, 20 Mar 2026 03:59:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="LUam4bT9";
	dkim-atps=neutral
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71D5110E885
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 03:59:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2BC70110E34; Fri, 20 Mar 2026 04:58:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1773979140;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=AWHHdDNqh9ZvQHUva5HwCaoi+Z9+EM+dvDGmkXuDbcA=;
 b=LUam4bT9N39dUOjkSfM0tn5oFZ5aiQ2mhPAM2uOUWYPu/xIVUGDe91ds7BEtiZLZbk6gso
 8+AY7JYZ3W/8efj1E9nKSEA6Mgj0d8JNAO9wQWczaVWscGHVpzEwktVGP0oKNLPbUBI4GZ
 q40E0XvRSYCl+wyPg7qnwx84GfGBtbMZAdElMSk26120WNBMLsT3ZLDZwF95j4Kau2V4+L
 pa7hEBDamt+m2mxLKQQ/djwMcyI6/Vpfj2L8qJythU0gavHe2i74gp6xrTsxuMUg65pkj4
 o38n69GjSMQNbOMzNw5qxXRRmKMhVgnEIR4hwyPF56oArqBk4O0UpLlnuh8j0g==
Message-ID: <40b3d1c8-0cf2-470d-8223-751240061735@nabladev.com>
Date: Thu, 19 Mar 2026 15:38:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/9] dt-bindings: display: fsl,ldb: Add i.MX94 LDB
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Marco Felsch <m.felsch@pengutronix.de>
Cc: Liu Ying <victor.liu@nxp.com>, imx@lists.linux.dev,
 Andrzej Hajda <andrzej.hajda@intel.com>,
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
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <mx6b5svmvlonil4efuiaxcmtygn7lld3nj7gcxnnauaryt2yed@gohjshakc2g6>
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

On 3/19/26 9:57 AM, Laurentiu Palcu wrote:
> On Fri, Mar 06, 2026 at 09:46:57AM +0100, Marco Felsch wrote:
>> On 26-03-06, Liu Ying wrote:
>>> On Wed, Mar 04, 2026 at 11:34:10AM +0000, Laurentiu Palcu wrote:
>>>> i.MX94 has a single LVDS port and share similar LDB and LVDS control
>>>> registers as i.MX8MP and i.MX93.
>>>>
>>>> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
>>>> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>   Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
>>>> index 7f380879fffdf..fb70409161fc0 100644
>>>> --- a/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
>>>> +++ b/Documentation/devicetree/bindings/display/bridge/fsl,ldb.yaml
>>>> @@ -20,6 +20,7 @@ properties:
>>>>         - fsl,imx6sx-ldb
>>>>         - fsl,imx8mp-ldb
>>>>         - fsl,imx93-ldb
>>>> +      - fsl,imx94-ldb
>>>
>>> Cc'ing Marco.
>>>
>>> Recently, Marco said that LDB node should not have a reg property...
>>>
>>> https://lore.kernel.org/all/4sofljffovrorpxe2os3jl745qfjoglvl54oqf3v7r5bk5f6aq@6y3jwn4abiqy/
>>
>> Yes, this has to be dropped. All variants of this specific "IP" use the
>> same approach. This "IP" is part of a general purpose register layout
>> with very loose reg-field definitions: e.g. resets and clk-gatting share
>> the same register. Or a mux reg-field shares the same register as a
>> MIPI-{C,D}SI configuration reg-field. Therefore this "IP" is part of a
>> syscon and should be abstracted as such within the DT.
> 
> Even though I understand the logic behind why 'reg' should be dropped,
> I'm not exactly sure how to proceed with this. It appears Marek made the
> 'reg' required in this commit (merely 2 months ago):
> 
> 8aa2f0ac08d3b - dt-bindings: display: bridge: ldb: Add check for reg and reg-names
> 
> Should the above patch simply be reverted and have 'reg' as optional again?
> Or should the 'reg' and 'reg-names' be removed completely from the
> binding.
> 
> @Marek, any comments?
The LDB driver was always written with parsing 'reg' out of the DT, so 
encoding the register offsets into the driver was a mistake. The LDB 
controls two registers, which can be comfortably described in DT.
