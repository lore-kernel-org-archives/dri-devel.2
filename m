Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D131061B1A
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:44:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC72F10E670;
	Mon, 30 Mar 2026 18:44:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="UAsHhJUk";
	dkim-atps=neutral
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1CB510E64B
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 18:44:43 +0000 (UTC)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-2b258576d8cso6892855ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774896283; x=1775501083;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a7bh5ixiifKbiWJ6yXLI+KwYDZ4p+qUAcuT1NVFVQLQ=;
 b=MSYVEMeUFcb393vW/D9ULEp/HMWn/Jn9xPoLoRzxgsLzsMlSV/KSvv+c3m14lvAfqS
 tlUWJxOvSa4+Gfcddb1v94WBcWOqiU4j3JgCcWQYbGWXkZEDMYxknX03u8riLz8R+z1G
 rzto2hm5LLcCXke8odjGCYSdQOhc2vfNZbX1wKhf9DAOzmkMXNUerEYAzebON2NLDVWp
 AIqc7B4zyH3j0aPGXEunN+XkiaCYCzXDCRa/7nYIB5mXgqs05Q7acAAuIMilHY4AEZSr
 68oIblSEKOjne4EloCqMO3JnuihHAmLhhy9WO4nLNRCMRBba59OSOmiH0f+NkVoaQxDO
 At/A==
X-Gm-Message-State: AOJu0YxHxEbVyjkdd0rhKWSY5xdufwib3v3HTQcwMByb85B9Nl8vxs/I
 MVHKovH9+TQHLykAZspUQFN9VEh6l2F5KBwSgFaKEuvuWME8gI5QBG6hmSTX6jy2tx3IlddiUFM
 TeDHav7lru16IiV9tSI2O1+K8q7bBBXJre2G53pbKLVWczGffLhX3/yXyXUnmi85COsdbaBi3Hr
 YK1BCb3+B/XmOJGBoZlwn48GxqZEIZUvQGg6QBJYIbK80pKip1rTLLUZl8xnnRz70noLLgjCf/M
 1nQyRuJzEOPfTP1Lq811SwhYSxr
X-Gm-Gg: ATEYQzxF6yGKgnO7vy5juvH8ZPC2UxZeZV/6ZKwcxzOfw1knPontcNC1j0q7FvYDUWN
 fLESumlXeag4t4a0uFvpBNt4Kq9Zfyz1BBERAPlUGVslBQ5gTyAsEVsZI2onwGaNOGvqiXHsAxd
 F9Gy4SBwP2biKEquqhENRc3V32KmnlXgct+SeqFNp5rQz5jJAk6fqoURQwbylr+OSgdz5lT0Mxz
 YWwE7acIDg0Q84x1h8FR+8WSaB5jhywe9yOtDK0owvDdMNUL/KGkL9uMxFK9IqrBSF325eRWMpI
 cQ0QorKSc4kp3qezbUrgoqdgoGMn6/iTSFtDvhKHD9u2l9xAkWyWqeUSyw3h11SWjiCZoxbopzW
 SrqIZ44YPV0KU2XjGNSMMAW0a5m2N9vGPpRO6GDoBvevIrUISVG/g/9Rij1Xbcj+NxK1/6M3bp7
 MwemMGnkP5GK9LvmNYkIMlHyTr2nt+VN2Yabu6ch6iOs9151dZ5QLZ1KOqqLP+HA==
X-Received: by 2002:a17:902:f542:b0:2aa:d5e5:b136 with SMTP id
 d9443c01a7336-2b0cdd7bb09mr141221995ad.38.1774896283190; 
 Mon, 30 Mar 2026 11:44:43 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2b2425f5979sm9260865ad.5.2026.03.30.11.44.42
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 30 Mar 2026 11:44:43 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b4ca7e7c2so123404121cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1774896282; x=1775501082;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=a7bh5ixiifKbiWJ6yXLI+KwYDZ4p+qUAcuT1NVFVQLQ=;
 b=UAsHhJUkN7wQ7AwX9dp927LDRAg0c7J9GIuuXjxz3c2osN8qMzJeqt8dxPhVJS9zQp
 ceBnPhwCAXc46tCNm27USmca10oyqNygwA2gHJ4xWxIt4cXJEJKSK+YikpmLjKRXLHj6
 T1r3z7T5vmdoICyw3GgHCh5CuH04PhESjPTqU=
X-Received: by 2002:a05:622a:510:b0:50b:3a6d:db5d with SMTP id
 d75a77b69052e-50ba39ad465mr187299531cf.65.1774896281966; 
 Mon, 30 Mar 2026 11:44:41 -0700 (PDT)
X-Received: by 2002:a05:622a:510:b0:50b:3a6d:db5d with SMTP id
 d75a77b69052e-50ba39ad465mr187298991cf.65.1774896281285; 
 Mon, 30 Mar 2026 11:44:41 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50bb2c96a5asm68164441cf.10.2026.03.30.11.44.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 11:44:39 -0700 (PDT)
Message-ID: <f39c38bd-edde-46f2-9b2f-2dbf22e80487@broadcom.com>
Date: Mon, 30 Mar 2026 11:44:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] drm/v3d: Allocate all resources before enabling
 the clock
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Stefan Wahren <wahrenst@gmx.net>, Maxime Ripard <mripard@kernel.org>,
 Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, kernel-dev@igalia.com
References: <20260328-v3d-power-management-v8-0-94336830df5f@igalia.com>
 <20260328-v3d-power-management-v8-2-94336830df5f@igalia.com>
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
In-Reply-To: <20260328-v3d-power-management-v8-2-94336830df5f@igalia.com>
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
> Move all resource allocation operations before actually enabling the
> clock, as those operations don't require the GPU to be powered on.
> 
> This is a preparation for runtime PM support. The next commit will
> move all code related to powering on and initiating the GPU into the
> runtime PM resume callback and all resource allocation will happen
> before resume().
> 
> Reviewed-by: Melissa Wen <mwen@igalia.com>
> Signed-off-by: Maíra Canal <mcanal@igalia.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
