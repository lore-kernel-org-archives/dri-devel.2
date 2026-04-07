Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7611FF5104
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 15:09:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51ED510E029;
	Tue,  7 Apr 2026 15:09:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="gfQT8L/e";
	dkim-atps=neutral
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B08A10E029
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 15:09:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B98CF10E33C; Tue,  7 Apr 2026 17:09:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1775574576;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=fUKRr3PIBlTzdV7W5Whjo5YyCw0hsjFvMeaap8RDMWk=;
 b=gfQT8L/ePFsPjNOlKK7k4A8ISlVQUwClinREShy/diZqB70BOY43EQwB6JhIiJJHrtQWet
 xaxDxyWLPzX1j2RvMm8/jtZinzR9neA6m/dPmrHL2ZTh0TivcHbMT8SXrRIXyZmAc2eQmC
 uWb3saPAGAaNFP5DG1xfevjSqP+YDyCQL3itj/wcesOIM26SANxL4snTrnLa8CbIMkOjG/
 uv6ELiglcBwNlO992owG7IPXHLH6FufdjnKXibgtwZvknkRkApNMm0ql+ASjKi9r+CwxTJ
 f2aqkyl7QcFb8opXCWp0DlBHIqEN0r0td1ZbL6mU+F7VbO+LynOsSEPK5ztzeQ==
Message-ID: <c3a9c4eb-92ce-48c2-83ff-18c7ce03acd9@nabladev.com>
Date: Tue, 7 Apr 2026 16:51:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: display: bridge: lt9211: Require data-lanes
 on DSI input ports
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260404034123.340818-1-marex@nabladev.com>
 <20260407-invaluable-pretty-leopard-1e8dfc@quoll>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260407-invaluable-pretty-leopard-1e8dfc@quoll>
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

On 4/7/26 10:00 AM, Krzysztof Kozlowski wrote:

>> NOTE: For example Linux kernel driver does already use that information
>>        and fails to probe if it is missing. There are currently no intree
> 
> The first sentence must be part of the commit msg. That is important
> reason why you are doing this... but I don't see how you achieve any of
> this. Look:
> 
> 
>>        users for this binding, so no new warnings will be generated once
>>        this is applied, but a new user is about to be added.
> 
> What warnings? How?

There are no in-tree users of this binding, so no DT checker warnings 
will be produced on existing in-tree DTs. I am in the process of adding 
a DTO which uses this binding now in arm64: dts: imx8mm: imx8mp: Add 
DTOs for Data Modul i.MX8M Mini and Plus eDM SBC

>> ---
>>   .../display/bridge/lontium,lt9211.yaml        | 37 ++++++++++++++++++-
>>   1 file changed, 35 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml
>> index 9a6e9b25d14a9..5264fb2b68b78 100644
>> --- a/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml
>> +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml
>> @@ -36,18 +36,50 @@ properties:
>>   
>>       properties:
>>         port@0:
>> -        $ref: /schemas/graph.yaml#/properties/port
>> +        $ref: /schemas/graph.yaml#/$defs/port-base
> 
> OK, that's correct.
> 
>> +        unevaluatedProperties: false
>>           description:
>>             Primary MIPI DSI port-1 for MIPI input or
>>             LVDS port-1 for LVDS input or DPI input.
>>   
>> +        properties:
>> +          endpoint:
>> +            $ref: /schemas/media/video-interfaces.yaml#
>> +            unevaluatedProperties: false
> 
> That's correct.
> 
>> +
>> +            properties:
>> +              data-lanes:
>> +                description: array of physical DSI data lane indexes.
>> +                minItems: 1
>> +                items:
>> +                  - const: 1
>> +                  - const: 2
>> +                  - const: 3
>> +                  - const: 4
> 
> That's almost redundant in this context - it was already there - and the
> point is that it solves noting in the problem you had. Binding still
> does not validate the ABI and does not match it, still.
> 
> Since commit foo bar, driver needs data-lanes, so what you need to do is
> allow them and to require them. You can also specify their constraints
> if device can be configured multiple ways, up to 4 lanes.
Please pardon my ignorance, what exactly do you propose I change in this 
patch ?
