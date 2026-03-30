Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34891061B1B
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1886710E23B;
	Mon, 30 Mar 2026 18:44:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="Q2MdB0SI";
	dkim-atps=neutral
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com
 [209.85.214.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2DFE10E23B
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 18:44:02 +0000 (UTC)
Received: by mail-pl1-f226.google.com with SMTP id
 d9443c01a7336-2aaf43014d0so32273565ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774896242; x=1775501042;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9EGyhPkMbZlKeaHk45N37Ig1oxoER5V4siPo1Ha7gTE=;
 b=LmC6ZucIXepISDwwfg0fNlcEkhIhkiDW8WLAFUQcIAkskNEYsfOXJKNHJWUgtId565
 fzjxLfHUGu8X4AY5nwdqB34PyxnDNilD+hu0bv3MpX5kpdeuXZJfLMk1T9aE8Ivu79r7
 JLE2723JrwZuOgrRjn0LAZ7QAoqU1wbgXPbuU6Tscpou5ZKjZggUEu0dANvxQZV2Ts7x
 +oZG3xcZV7gmMOn7QbP5DOUU9EOala/1ehlODi6WeKHPrURofPa6hTJF168FA5PCM2oD
 vTNrCH40zG1X0LC98zqTF8amlEQ4vTUbCy6DmZf6AaUkQ1jhztG2fd48QrW0qyMxj8ft
 a3/w==
X-Gm-Message-State: AOJu0YzbsTj/4eLNiuQ3fMKHqqQH9rKXDkNQMN5T0dC1RLx4LCkJ96dW
 DqJtdNykC2LOHVyvkJodj8PLyr1nlkRBBN//kO48WyYGYipzVQ5XGpjKrHqUa2MU0Nd5UOqlO50
 xXIFY6xDS7KIWghus68zKoZ0fWlLHTSVq3Vcz9iXILE30FW9gz3rouHxTIaEfTIoykLsE7fW7fX
 fZQ0wycE/gtDcsBzFcvJHYtdPWLY532wuwxAqqImQi61IqhDhYvoQuCJZiJcWJGd3UZ9CIq5k4X
 mOCBgPFcQTW0JHun/eaL8G0PVTw
X-Gm-Gg: ATEYQzypwwF2MraOsDUzGpZ2oLrEy9Q/TyK7uiEn2FJIeM/smMn9dl+PejkVer5PBks
 86OV4Mux3oE5TUsCYmjVyxIa6ozT16knt3b8vOAuyoidRiUzKG+11qVZcxrOHLoqj69Ks4lqALK
 ERj13P6K/UsRS5bWbLnTEd3QEc3aGpOZAVMMiCCWH/jjuY9djg3YDBpEuU5gb08nkDqcLf2ToHb
 Zu5dwY5YSlVXs0STxcazDXZAtpCU1akaOUThExVo3+eCZTzQrbYXXFEghZoyzBwN9WaQlL5SZ1i
 lHvvKJf73h+sAO75h7qwpcpssmSvGVKwAFZczpsyp/JUw/YlQtRuFeVFcx6P9zu+bvQFpMXHfTt
 NBBEnZ+jMlTpr88XbepeiEboW7sRvR4G6aiTi258AZ0hJTbeaQ8tg1cKZRapcFyml8mSPQOLlRf
 5R45JN1w6E+A3Bh2sIFaQK/OqX1l/krexhHl2V0Dtl8t3yE/haKfZ+TKgIa3Wvbg==
X-Received: by 2002:a17:903:40cc:b0:2b0:59fd:bbe5 with SMTP id
 d9443c01a7336-2b0cdc041f0mr145615255ad.4.1774896242214; 
 Mon, 30 Mar 2026 11:44:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2b2425f5dffsm9942345ad.9.2026.03.30.11.44.01
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 30 Mar 2026 11:44:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cfcebeb1f3so987932685a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1774896241; x=1775501041;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=9EGyhPkMbZlKeaHk45N37Ig1oxoER5V4siPo1Ha7gTE=;
 b=Q2MdB0SIBnatD0HM5pM242AWolN+HH1tF0maB3ubTWCLJT2z2IuuMBLje8TsMqi/qd
 UXbMmpmAmBgaATI+np9Vyh9Kcn93gDpGr1Fu8XoaGFOdnIkkCrHtzSXb7K2nOANDeSuA
 P5bYpmeJsr9C1xJ41yU90SOApU1yi1MvqYsPU=
X-Received: by 2002:a05:620a:2953:b0:8cd:8d4c:aa0c with SMTP id
 af79cd13be357-8d01c333e13mr1875222885a.0.1774896240882; 
 Mon, 30 Mar 2026 11:44:00 -0700 (PDT)
X-Received: by 2002:a05:620a:2953:b0:8cd:8d4c:aa0c with SMTP id
 af79cd13be357-8d01c333e13mr1875218085a.0.1774896240260; 
 Mon, 30 Mar 2026 11:44:00 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d027f29135sm665778785a.20.2026.03.30.11.43.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 11:43:59 -0700 (PDT)
Message-ID: <0d494a0b-51f7-4832-9102-e45953e294d5@broadcom.com>
Date: Mon, 30 Mar 2026 11:43:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/3] drm/v3d: Use
 devm_reset_control_get_optional_exclusive()
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Stefan Wahren <wahrenst@gmx.net>, Maxime Ripard <mripard@kernel.org>,
 Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, kernel-dev@igalia.com,
 Philipp Zabel <p.zabel@pengutronix.de>
References: <20260328-v3d-power-management-v8-0-94336830df5f@igalia.com>
 <20260328-v3d-power-management-v8-1-94336830df5f@igalia.com>
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
In-Reply-To: <20260328-v3d-power-management-v8-1-94336830df5f@igalia.com>
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

On 3/28/26 11:52, Maíra Canal wrote:
> Simplify optional reset handling by using the function
> devm_reset_control_get_optional_exclusive().
> 
> Reviewed-by: Melissa Wen <mwen@igalia.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Maíra Canal <mcanal@igalia.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
