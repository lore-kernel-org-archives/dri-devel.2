Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F906C624C2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5342410E684;
	Mon, 31 Aug 2026 07:00:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="DMse7pzQ";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="UlG2hGF6";
	dkim-atps=neutral
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D630510E12C
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 20:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1788034695; bh=99oQqqsmDdYcuU1KZ1BBNtz
 eXvz/eiQA8iTcrFoXqIQ=; b=DMse7pzQkebE9ELqmn+vxiJj6jWBXBCV+5si2YDBWZEdK+dhgn
 m1OWgG1o8czZieM+5Qk6arZUiTbW+8+2j5LGv/+/I5yT1DEKrV/VH8HvzlV8QfNwGzg65t03+R9
 ubaDBpIccNehc9VUPSA5PHUr3APYa7xsbiPgVM+VErO+K8aGBsLfIHEe8jhBh44FwZQe8CVzYQK
 QJ0pp3Lb4U7PrOrkBq2ZcGg+SJXTDZ3QcEZKGg2RLiNpeUKAE/qSjFWNqCCqp5lc0uPgpGH1pSw
 biqduohF338vjs1uFJkKbAShvDvcnWGTrIKxyh3QqjNs+WMbGH3+SEPjg3I42yKMJxg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1788034695; bh=99oQqqsmDdYcuU1KZ1BBNtz
 eXvz/eiQA8iTcrFoXqIQ=; b=UlG2hGF6ZkfucljrhX0AKlQZZojfgmvDL/P0ciu+VPUv7kdO3l
 u+6HiXxMKHT5D9eq8oPbtI/CjMsi8An3PYDA==;
Message-ID: <6e0e03f6-8ce9-4c01-9f04-206b163d5664@mainlining.org>
Date: Sat, 29 Aug 2026 23:18:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] dt-bindings: display: panel: Add bindings for
 Novatek NT51021
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
References: <20260829-qcom-novatek-nt51021-panels-v1-0-cc1ca61bd261@mainlining.org>
 <20260829-qcom-novatek-nt51021-panels-v1-1-cc1ca61bd261@mainlining.org>
 <20260829201500.796D31F000E9@smtp.kernel.org>
Content-Language: ru-RU, en-US
From: Nickolay Goppen <setotau@mainlining.org>
In-Reply-To: <20260829201500.796D31F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:00:03 +0000
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


29.08.2026 23:14, sashiko-bot@kernel.org пишет:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Commit message and schema description contradict the schema's compatible list by claiming to only support 'boe,tv101wum-nx0' while silently including 'boe,tv080wum-nx2'.
> - [Medium] The description for `reset-gpios` incorrectly specifies the polarity as '(active high)', which contradicts the example and typical panel reset semantics.
> --
>
> commit 4949971c710c300054975d637c238b42bc5c2c75
> Author: Nickolay Goppen <setotau@mainlining.org>
>
> dt-bindings: display: panel: Add bindings for Novatek NT51021
>
> This commit introduces device tree bindings for the Novatek NT51021 display
> driver IC. It explicitly states support is added for the BOE TV101WUM-NX0
> WUXGA video mode panel.
>
>> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml
>> new file mode 100644
>> index 0000000000000..a3e4ed10e645d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml
>> @@ -0,0 +1,93 @@
> [ ... ]
>> +description: |
>> +  The NT51021 IC from Novatek is a generic DSI Panel IC used to drive dsi
>> +  panels.
>> +  Right now, support is added only for a BOE WUXGA LCD display panels with a
>> +  resolution of 1200x1920. They are video mode DSI panels.
>> +
>> +allOf:
>> +  - $ref: panel-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - boe,tv101wum-nx0
>> +          - boe,tv080wum-nx2
> [Severity: Medium]
> The commit message and the schema description state that support is added
> only for the BOE TV101WUM-NX0 panel, but this adds boe,tv080wum-nx2 to the
> compatible list.
>
> Is this regression intended, or should the description and commit message be
> updated to reflect support for both panels?
>
> [ ... ]
Will be addressed in v2
>> +  reg:
>> +    maxItems: 1
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +    description: phandle of gpio for reset line - This should be 8mA, gpio
>> +      can be configured using mux, pinctrl, pinctrl-names (active high)
> [Severity: Medium]
> Could this description cause regressions for users configuring the reset
> line?
>
> The text explicitly specifies (active high) for the reset-gpios polarity,
> but typical panel semantics and the example block further down use active
> low:
>
>              reset-gpios = <&tlmm 62 GPIO_ACTIVE_LOW>;
>
> If users follow this text description instead of the example, could they
> drive the physical line incorrectly and prevent the panel from initializing?
Will be addressed in v2

-- 
Best regards,
Nickolay
