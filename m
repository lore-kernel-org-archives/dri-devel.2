Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA2D109B491
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 15:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1C8210E8FA;
	Tue, 31 Mar 2026 15:33:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="H+uMMKCy";
	dkim-atps=neutral
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com
 [209.85.215.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C983210E8FA
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:33:31 +0000 (UTC)
Received: by mail-pg1-f226.google.com with SMTP id
 41be03b00d2f7-c76af7b0f94so727988a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 08:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774971211; x=1775576011;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aM0vCzSlnL1yo748oI60JSGgC3GnaxtG3fVPhDjexBg=;
 b=VJkgJMKLEoU0NmrQgqTrcEe6A25m76KjU8eKkzmTav3EdalLkgNJgDOdGT9JVV1kF7
 gf3RP2MhUMp6eADFLpDFovhiCu/2gbCmkoHOI6quJ7BaAVFVZc3jS3xmSyprFHx5UvHk
 qpJyvh+YEk8wrrJu6ogBPn9RW9ukVKxvcJ86XQafbxEuV8bM2QlChiDASIk98sbP+LuJ
 uquw907jLspKnzdOfpWbDB68wzp+p6moTmH95Jm1d6kjuvsksG1p48Jq/xujodoC/9ET
 Z8m7pWmXTbF3FEMiRLqZsilsoBkisg8ReE77ovjANzvalqPxPQkC4keOpxTmkmZvFhdH
 IkjQ==
X-Gm-Message-State: AOJu0YxxWcHmkSq8sHwx/EveT3QKFWTXes4zgZ7TODsY51Ff3CSiP5d5
 g4X2eiGv/OnNRUdZpx+0s13Ks5QJRq1u9oseP6F7bDYhbT3hoEHgAM0lGMpFTsqH23dABK5smwU
 TSMzm4F/u/cWE9dVBWMx9A1xRQave5R0AZDvvQs8xiB9KBV+m278d1u0Ie2kFk0Xt++R9CsqmF/
 qcM8oCCxkwJBar9qzVEdKZUBeb7nzA/vuu0R3d5RQ6ldry7pgCK+/Edsdpv2RCaC1AxTtUJXRkr
 CgvNhOL9Rfydyhk9CmkBGqkzfnv
X-Gm-Gg: ATEYQzxtZNLMKOr2FjL6WHD2DORJhc0nh7B/oWo/CVTJQXfTcdUHv7E5vbKtsyUqPjJ
 unWFcjquEilRJ3ZDUyJT6OyW+y0JQb8mJul8eJzKk8NLkFpx1nfw6mqZB+mZZEmC9SQW0RsUzM+
 Zw6j/HS/AckNKxotllsjpH5c9GuN8CUwQQlKcyZswlR6G86OBbuoWhFqz0M1CDVZ95wOrHf3G3Q
 pJs6OwVls2aP9ugO3rKY0FY2I5oUk+7e0ngZK9YD3i+kEai/Yl58O7jz8aPn/APAegNpOoWaMPY
 cqTHC4Flwjgw37lnuAHoWELi/KqIhheiyZwolKVnp2DQujq1M2AbxX62Hy4ZNtM5aA5Hm5VSGRx
 HpCrkmC3ipYo8mrYoXnmmoAHRieLK1296SkrhiBWTX0onEm46zy/DGWbaxK/ceGPmn0JIzYGo/x
 b7jMsHDKQSUvrxaBTHeSSq4w/yhsGUlt1K2HTfa7zy+92cJNlctm72tqsoFKOCLg==
X-Received: by 2002:a05:6300:218c:b0:39c:787:f188 with SMTP id
 adf61e73a8af0-39c87ae0d7amr17989989637.39.1774971211078; 
 Tue, 31 Mar 2026 08:33:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-c76916e0329sm911520a12.4.2026.03.31.08.33.30
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2026 08:33:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8a0d03df951so77457466d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 08:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1774971209; x=1775576009;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=aM0vCzSlnL1yo748oI60JSGgC3GnaxtG3fVPhDjexBg=;
 b=H+uMMKCyhBlDDDn59fu97U43Tv4vwu6cSmjxhwRkMzPQRaAKhLZPP0CS6k/HR/3e2m
 iuItppPd0Il8rbMGSWEfi6XAbsyrNC1IF4cKxN7LOD1Vb22p7PjPC7ko7w97a0y1+Kh8
 YkK10R0dSP+CuDawncOAqFPypliJNqz5lPmNc=
X-Received: by 2002:a05:6214:4012:b0:89f:2ae0:39f7 with SMTP id
 6a1803df08f44-89f2ae03c33mr180966886d6.22.1774971209605; 
 Tue, 31 Mar 2026 08:33:29 -0700 (PDT)
X-Received: by 2002:a05:6214:4012:b0:89f:2ae0:39f7 with SMTP id
 6a1803df08f44-89f2ae03c33mr180966396d6.22.1774971209093; 
 Tue, 31 Mar 2026 08:33:29 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89ecf281b2asm93232106d6.23.2026.03.31.08.33.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 08:33:28 -0700 (PDT)
Message-ID: <08a2bcec-aa0e-425f-b6eb-66eeaf0ef362@broadcom.com>
Date: Tue, 31 Mar 2026 08:33:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/3] drm/v3d: Introduce Runtime Power Management
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Stefan Wahren <wahrenst@gmx.net>, Maxime Ripard <mripard@kernel.org>,
 Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, kernel-dev@igalia.com
References: <20260331-v3d-power-management-v9-0-f52ff87bfd36@igalia.com>
 <20260331-v3d-power-management-v9-3-f52ff87bfd36@igalia.com>
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
In-Reply-To: <20260331-v3d-power-management-v9-3-f52ff87bfd36@igalia.com>
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

On 3/31/26 05:35, Maíra Canal wrote:
> Commit 90a64adb0876 ("drm/v3d: Get rid of pm code") removed the last
> bits of power management code that V3D had, which were actually never
> hooked. Therefore, currently, the GPU clock is enabled during probe
> and only disabled when removing the driver.
> 
> Implement proper power management using the kernel's Runtime PM
> framework.
> 
> Reviewed-by: Melissa Wen <mwen@igalia.com>
> Signed-off-by: Maíra Canal <mcanal@igalia.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
