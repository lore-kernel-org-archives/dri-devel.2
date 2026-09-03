Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1992CC624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BD0D10F746;
	Thu,  3 Sep 2026 19:38:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="ASU4Rzbl";
	dkim-atps=neutral
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com
 [209.85.214.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3774110F746
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 19:38:47 +0000 (UTC)
Received: by mail-pl1-f227.google.com with SMTP id
 d9443c01a7336-2cc891373e0so2118305ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 12:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464327; x=1789069127;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=brNSF6ql5aevmqbGax3CboePf220/VniLivOauNNsPk=;
 b=WgG7VhR/4oRFWFuwK5vH03oFAs2gYdV8k/bHQQgoWhQ1xsCqV5uH+W9cbv1c2DSuBT
 2bpxR2ezavOcaB5qi06itmYpaFdmSB8qvjRA4RoGGFv8JAWkx7znl5Pnw27JIFW9G3B4
 UuOmQUjxbk+Puyn1N3Vv29xKzSsOu6YQBX7JonwXtweRSELWt1bF8m56a+2jNxaJ3woN
 Q2BpqWhz55Mh2mt8FFnd2KnGK86JZNdE8uLIOWs9Vjrww8OJcMGYg5hbUrx5hArgHGmT
 ZCzXVV1K3IYN+SP3P75HkS7pgMMeVXi7wR1ln7v5N1kMR6ITAEEOAjKRNb/Vefa/WdOd
 MwWA==
X-Forwarded-Encrypted: i=1;
 AKwUvByVPg3ijIkJwxFYIdbAKpQuc1aaa3t8m+FIPcNSEUX+XSK2v5XUp62EtYokuQlI8yQw4RCXeIctIEM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lD1PcfxlsTflmcWNUHnUSNCIao4ni4QcZZQq4jF1A5l3JWWlOL
 W0qXzUegkhJldjM1sIt5cD+JKbAuMd4pcsMqw1th+SaFoW10P78wXkIRpDNO5THHUhg/ONyPMNC
 Opzyr1OYrAEFugdMm/3nVaw22Oz6Yo4UYieScvpCWq4aiKWjddtg+ATGveTYxuE2ci7HsAhgh+O
 K0QbtE58aPOWRJ6910C/YM5IOpMR7bA99D6z9RbArklCxxpICeRUaKlt5FCyRsgfC+V9/mscXAH
 nZpI4YwigFrTAO7jcSwK6hSt9+Z
X-Gm-Gg: AYBFou2YrIJm+0N/qgRvm6el7Q2o9/zy0ZN/L+LtsgZcxfJODaxTz4c02x9bZARxz6u
 UrUBuWXiOdshXmhucjPDeftTdLIWedWB04zSmO5xGGvEqu0RHUcRao0Jk3p9Hc+KuiFvoEXCak0
 3OPTNJfYX2BvmZT0YCf0HGaEQVohhGdlXEfGox1M52VUAtseXmLIvIS6mAu88jSQNyRhG7gO6U3
 gvn0TBdWs/FLaPs6qH2jIlIzYhIOGCOPDI8X7fFImnsgznXaAF1xS0l701nwk8Q2sVmaV0k5ppT
 P3jnWsEJUWAS+y2+IaA0KTyYwbyT4qVXaZJY1/xag5AOQJC4bKm3XhH8y7fs/oyM6iwQD43ie86
 2Qv7FtTGpWy+NCbbtIMxKxXrIzRlMfXHtlLvIjJumjtmlPKcCMouy9muOWVeOceNEkCYMwutLuA
 SCX/8NXe2fZSYF4xNW16EIyCkbW5cF9aI0qrhfhl/R
X-Received: by 2002:a17:903:13c8:b0:2ca:e62c:9e96 with SMTP id
 d9443c01a7336-2db1232e220mr21110455ad.5.1788464326612; 
 Thu, 03 Sep 2026 12:38:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2db1489931csm64675ad.7.2026.09.03.12.38.46
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Sep 2026 12:38:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52faa0dd18bso9590081cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 12:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1788464325; x=1789069125;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=brNSF6ql5aevmqbGax3CboePf220/VniLivOauNNsPk=;
 b=ASU4RzblPiAvXAaqhr5t4Zo+sJDhBHFsIblH/12z/jRQ9QacJY8R00fBny2VR/6TDo
 AunYG/UKvFVWl4Sg8t9qbtfKDhWizLTXATXOVmUWGnj0K8A0SX8EbKpyGFa7CHIYhC/1
 lNIM3yhbLGbFUiQ+ImE3viuvm/Q+M+gHLnXfU=
X-Forwarded-Encrypted: i=1;
 AKwUvBysv5fRsjkbc8ISvulhX6+YkjTWb8WANMspB0y58Lrfa8e14t5zNcfCbbKfEA5nNCtDsh4E7VTqJxA=@lists.freedesktop.org
X-Received: by 2002:a05:622a:2505:b0:519:f884:b587 with SMTP id
 d75a77b69052e-53054961822mr14588901cf.27.1788464325207; 
 Thu, 03 Sep 2026 12:38:45 -0700 (PDT)
X-Received: by 2002:a05:622a:2505:b0:519:f884:b587 with SMTP id
 d75a77b69052e-53054961822mr14588241cf.27.1788464324657; 
 Thu, 03 Sep 2026 12:38:44 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-530541eab6csm5221631cf.26.2026.09.03.12.38.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 12:38:44 -0700 (PDT)
Message-ID: <1f4a0df1-97e0-48e7-bd08-6b31c8dcd0e9@broadcom.com>
Date: Thu, 3 Sep 2026 12:38:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: display: bcm2835-v3d: Add an optional
 reset line
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Stefan Wahren <wahrenst@gmx.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, kernel-dev@igalia.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20260816-vc4-reset-control-v1-0-896444373716@igalia.com>
 <20260816-vc4-reset-control-v1-2-896444373716@igalia.com>
 <20260818-idealistic-chivalrous-sawfish-08ddae@quoll>
 <3ab273be-e811-45e4-adf1-75532c840bc8@igalia.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <3ab273be-e811-45e4-adf1-75532c840bc8@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

On 8/18/26 03:35, Maíra Canal wrote:
> Hi Krzysztof,
> 
> On 18/08/26 06:05, Krzysztof Kozlowski wrote:
>> On Sun, Aug 16, 2026 at 11:05:41AM -0300, Maíra Canal wrote:
>>> The BCM2835 PM block has exposed a reset line for the V3D block since
>>> commit 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power 
>>> domains
>>
>> This is a reset provider driver, so not really relevant here. Driver
>> commit would be relevant if it was about consumer who implemented
>> undocumented ABI. I suggest to drop reference to driver and instead
>> describe the hardware.
> 
> Ack.
> 
>>
>>> under a new binding."), which allows the GPU to be reset without
>>> power-cycling its domain. Document it so that the vc4 driver can use 
>>> it to
>>> recover from a GPU hang.
>>
>> Does every device have it? Cygnus as well?
> 
> I'm not familiar to the Cygnus hardware, only Raspberry Pi, so I'd
> appreciate if one of the folks from Broadcom could help us with this
> information.
> 
> However, just like the power domain, I added this property as optional
> to accommodate the fact that the current Cygnus DT doesn't expose any
> power domain or reset controller.

I really don't know and have no visibility into these older chips, let's 
assume they don't.
-- 
Florian
