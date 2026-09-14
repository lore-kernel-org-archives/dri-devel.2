Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04BCC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:05:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A99410EDF0;
	Mon, 14 Sep 2026 12:05:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=minlexx.ru header.i=@minlexx.ru header.b="a959j0Tq";
	dkim-atps=neutral
Received: from sm24.hosting.reg.ru (sm24.hosting.reg.ru [31.31.198.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D07810EDF0
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 12:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=minlexx.ru; 
 s=dkim;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=j2v9bbLb7RJD05oFKbLtgt12x6whs/0vHXG4WLk2P0o=; b=a959j0Tq2VZmYWtkXDbNMHGztp
 ONfjEal4d1WhuWz0yPmwmB8bZFs6LzWc3UJnhn3e6olEzn6b8OYKZYD3EuFyTE4M8tH8oYIsdeARF
 DisUGM/JTlamyl5PngLf6RNtU+vuyYNRYYcgQIbTBvRkGLwRPVjcYgRy7Dx7LWtRlsKs=;
Received: by sm24.hosting.reg.ru with esmtpsa (TLS1.3) tls
 TLS_AES_128_GCM_SHA256 (envelope-from <alexeymin@minlexx.ru>)
 id 1x65R1-0000000A0jp-115B; Mon, 14 Sep 2026 15:05:20 +0300
Message-ID: <c2162090-c88d-4c2c-a5e8-8b45aa63451c@minlexx.ru>
Date: Mon, 14 Sep 2026 15:05:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] dt-bindings: vendor-prefixes: Add Shenzhen Zhuohong
 Electronic
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260913-nt36672a-panels-v1-0-ce097402c6ea@minlexx.ru>
 <20260913-nt36672a-panels-v1-2-ce097402c6ea@minlexx.ru>
 <20260913063107.D83681F00893@smtp.kernel.org>
Content-Language: en-US
From: Alexey Minnekhanov <alexeymin@minlexx.ru>
In-Reply-To: <20260913063107.D83681F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 13.09.2026 09:31, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Vendor prefix mismatch: 'shenchao' mapped to 'Shenzhen Zhuohong Electronic Technology Co., Ltd.'
> --
> 
> commit 73f96d396aaa9d9d8dc1a660e32b98910c8690b8
> Author: Alexey Minnekhanov <alexeymin@minlexx.ru>
> 
> dt-bindings: vendor-prefixes: Add Shenzhen Zhuohong Electronic
> 
> This commit adds a new vendor prefix to the device tree bindings. It aims
> to register Shenzhen Zhuohong Electronic Technology Co., Ltd., a
> manufacturer of LCD/IPS displays.
> 
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> @@ -1507,6 +1507,8 @@ patternProperties:
>>       description: SGX Sensortech
>>     "^sharp,.*":
>>       description: Sharp Corporation
>> +  "^shenchao,.*":
>> +    description: Shenzhen Zhuohong Electronic Technology Co., Ltd.
> 
> [Severity: Low]
> Is this vendor prefix mapped to the correct company description?
> 
> The patch introduces the 'shenchao' prefix, but maps it to Shenzhen Zhuohong
> Electronic Technology Co., Ltd. Since 'shenchao' typically refers to a
> Shenchao panel (as seen in a subsequent commit introducing the
> 'shenchao,fhdplus-video' panel), mapping it to Zhuohong, a different panel
> manufacturer, could cause confusion for device tree authors.
> 
> Should this prefix be named something like '^zhuohong,.*' instead to match
> the manufacturer, or should the description be updated to reflect the actual
> Shenchao company name?
> 

It is very hard to find anything about this manufacturer. All we know:
in vendor kernel they use shenchao prefix and they produce LCDs.
But I think I've found some information, so this will be fixed in v2.

--
Regards,
Alexey Minnekhanov
