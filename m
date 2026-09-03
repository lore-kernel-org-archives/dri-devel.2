Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49193C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FDA810F750;
	Thu,  3 Sep 2026 19:39:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="adhrSRFi";
	dkim-atps=neutral
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com
 [209.85.214.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17C6410F750
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 19:39:19 +0000 (UTC)
Received: by mail-pl1-f227.google.com with SMTP id
 d9443c01a7336-2d9201076b3so2894245ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 12:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464358; x=1789069158;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4Usv5SNynw+4aZQ9DPp9M1Ly8wN0kqlGi58tc/lH1VY=;
 b=V+83zgCHqC3hjgiSZytR5hlm2QmZFxvhdnspyhAnbM03/zzBioHQd7yvZo1VwTYquQ
 Q1WJJjIsB+jSeK5RlbZdnXcu2sbQPENtidY2XJgQOWaIwzkiLC+Xo4rL2fqq5Is0BcrU
 QNSWmtd5lHpspemUpjZdPRuceqEprjQcSlTaoxrR8zuOsnLTWkAWMO++63dz6VjzY6Ka
 f3g82CMogH5A6O8BlvyK8floxMEfDD9BIQUy6IxYdLSVNUjegkvd/z9751s4wl1qNMqq
 L2VgP0Pw7WEanFqwgyhW8CeTZ38Ce0l+ny5CBSwznNzMass/YFvEBee5YgMxtM+O9erY
 UIUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzw6AWSfvBq1Oagp7qSDsobHLSomuqIpcg7nDgjcabJ8xbA3Xc8VvtN7fCiLoIm6vSIsccVe6SAMv8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++modlyMSCwHyy7A2860TuyKZRAghkiFrv2g7gLfhtB9ufYdkar1
 IEK+DHgMbFHJMXPdtSidkr9AaCTDNDS7in+vJaPiD53Fnk9g7F8WiL3vuNjSzGryn4PdsBgkz84
 cFY2yCxZh/+wIYuxew6IYEJnXRA1p71rNST+kxlXqm8pg+aZDLk8lpTTcYHUgtlDUXpv1BsM7g2
 7tK8P0Rg3Tjcm4FWJMogIGuOK4DBb//2ej2JBc5CY35SED3q7YGfF0Ka6ohHgEpgLWfW7Z03zEA
 I9112SRScA9rBHpQCN81EP5+R4i
X-Gm-Gg: AYBFou2TC5YmAKaE+6RPuENfKsoFBgHhy+hH4tJPlfojXpvd7HOe5o2u5yG2eWZEjWC
 s2yZn9C4+dILpQWLvoqdCnwzmA8sZykxUMxfz1U8nSsqLrvobmePhM7rGRIR6dsHJ/4Tu7LVSJw
 46Ergg47M1+REQpQPSWZe8V6wZcffD8YTSFRWaLg83uA3J1QGDsWaOgPFq1TE5JPvRo+C3aHzpe
 RQ8fkcuduUj4NADFXfvjfpCe7ImGC2G8tMWUQg0au9CFEMdMRmwSJH+FQKBIqvhAq7ZkqqijTxU
 0sSYthIz4LU8zwcKNchD8HDTpA9G2b9EhzeMfmrpqXtRslHzpFtw3R9jIBhFIjS34Mg38RllJo9
 22kjNh+HU80w43SLS7YqlJXhXAAxawVtX8EpeSRWiJoGpgUDSMzYGGigINkOaJi5cT3RFz452D0
 C8a+M6pym1ZY1hkIXd8xVecq/gmvnYUTTNAKYR3nD3
X-Received: by 2002:a17:902:e948:b0:2d9:51b7:c0bc with SMTP id
 d9443c01a7336-2db125a3452mr20332615ad.12.1788464358507; 
 Thu, 03 Sep 2026 12:39:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2db14899311sm58585ad.3.2026.09.03.12.39.18
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Sep 2026 12:39:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ce8a76df2dso3251135ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 12:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1788464356; x=1789069156;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4Usv5SNynw+4aZQ9DPp9M1Ly8wN0kqlGi58tc/lH1VY=;
 b=adhrSRFiBjO73nLC9IatSXEzKm3EmOLQIskJA32SVag29FkipyY0hSjwtgE19F7L6S
 aFaz5f5htUKjr/w/dgiG/2eS17exgK4WXjgD5HK7V4Odik5ksUlCzufsIB3jp4fN8/7/
 fB8Xvp7JTHq8hjVD8ndE7gpSlcS0qYk7Qxdpc=
X-Forwarded-Encrypted: i=1;
 AKwUvBxk2Zi+mBzMbYq/YOXZmk+juHztmitQfa6HhoWHwwvAlIpZNKSoFP9BC9GFdKD5E/sh6b+9nsu9EI8=@lists.freedesktop.org
X-Received: by 2002:a17:90b:1a8f:b0:398:d2a0:87ff with SMTP id
 98e67ed59e1d1-39b26101029mr1333659a91.1.1788464356512; 
 Thu, 03 Sep 2026 12:39:16 -0700 (PDT)
X-Received: by 2002:a17:90b:1a8f:b0:398:d2a0:87ff with SMTP id
 98e67ed59e1d1-39b26101029mr1333593a91.1.1788464356086; 
 Thu, 03 Sep 2026 12:39:16 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14324410092sm1349016c88.14.2026.09.03.12.39.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 12:39:15 -0700 (PDT)
Message-ID: <31166950-1099-41c5-bcf4-13e4641dbfea@broadcom.com>
Date: Thu, 3 Sep 2026 12:39:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ARM: dts: bcm2835: Add the V3D reset line
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Stefan Wahren <wahrenst@gmx.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20260816-vc4-reset-control-v1-0-896444373716@igalia.com>
 <20260816-vc4-reset-control-v1-4-896444373716@igalia.com>
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
In-Reply-To: <20260816-vc4-reset-control-v1-4-896444373716@igalia.com>
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

On 8/16/26 07:05, Maíra Canal wrote:
> The PM block exposes a reset line for the V3D block, which the vc4 driver
> uses to reset the GPU when recovering from a hang instead of forcing its
> power domain down. Wire it up in the shared V3D node, covering BCM2835,
> BCM2836 and BCM2837.
> 
> BCM2711 already describes the same reset line for its V3D node.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
