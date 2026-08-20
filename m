Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C0FC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 17:42:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1250210E5F6;
	Thu, 20 Aug 2026 17:42:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vi+xYTZe";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DE1C10E5F6
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 17:42:53 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hQrPP6QnwzMlGJ;
 Thu, 20 Aug 2026 19:42:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787247769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PL0+TkBEAw/ljLIv0zv8/yDD3v/lKZn/hBCUcu+4UtU=;
 b=vi+xYTZegipotKL2tNDLtKIfr4Q7NZSS5N0m7PDg/g8LrdQpp4i6KQfVK3X65QtNmBHIu7
 P/UGH7eS0JL4OYHymF9Lhp7YSbmWFcxzK/wfGtjMZ23pB6mka6/s8UeWaBkxFsgqBhkNdW
 shMZ5LHf2hOb8GoIJJ99oaQnNGYwd1cUwU9tI2GZyrFxuN3+MKwriStrZb+5IdPvZLfGnk
 N8FuBrs9NJqcHRld0M2/TbwNZk6+IKqjDjoqjjmWJsGNM1eOWlgDEKJSA/lswdK3t5F+DI
 mJDo/ZppsrTd+hWac4XKyeuydmpW00w22a+JK/Xdw07brYPWNDKTUAAsJxOEAA==
Message-ID: <ca696ae8-4d26-416a-aaae-1e54cacf9fb8@mailbox.org>
Date: Thu, 20 Aug 2026 19:42:45 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] dt-bindings: display: panel: Document 10" Raspberry
 Pi Touch Display 2
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org
References: <20260809200107.842945-1-marek.vasut+renesas@mailbox.org>
 <20260817-whimsical-fictional-dove-89b3d6@quoll>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260817-whimsical-fictional-dove-89b3d6@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ayciih47b1nm1gj34y6j84hzzwq7ik4p
X-MBO-RS-ID: 5080b6edc4b6540025f
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

On 8/17/26 9:42 AM, Krzysztof Kozlowski wrote:

>> +++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili79600a.yaml
>> @@ -0,0 +1,65 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/panel/ilitek,ili79600a.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Ilitek ILI79600A based MIPI-DSI panels
>> +
>> +maintainers:
>> +  - Dave Stevenson <dave.stevenson@raspberrypi.com>
>> +  - Marek Vasut <marek.vasut+renesas@mailbox.org>
>> +
>> +allOf:
>> +  - $ref: panel-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - raspberrypi,dsi-10inch
>> +      - const: ilitek,ili79600a
> 
> Binding looks exactly like boe,tv101wum-nl6, so either properties are
> copy-pasted without checking in datasheet

There is no publicly available datasheet, but ...

>  or this does not need new
> binding file.

... Documentation/devicetree/bindings/display/panel/ilitek,il79900a.yaml 
could be extended instead, so that is what I will do now. The devices 
are compatible.
