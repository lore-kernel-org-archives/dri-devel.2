Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78737C624DA
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F6A110E1BA;
	Thu,  3 Sep 2026 19:37:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="HTsopGB7";
	dkim-atps=neutral
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67C2810E1BA
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 19:37:00 +0000 (UTC)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so177738a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 12:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464220; x=1789069020;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wbmjJn4KRbF8oVMPpkd76I/qR3hSpCdh5Z2V63vUrww=;
 b=OxCE2R8y6x+Z16PjzDfxtD8QEyqLAhuNThntOqlGxyQ/uU5F1dtrc07ahIjgrlI72k
 IUWiry2XmjU+zB4P23NQtTmf8/SahKgcXi3xFW/LcgR9vi8L6AgOHuFaWxtPJdiPXLu/
 4fO/K84vwbmah4oDxlMUyWu5SVY58KyvAyQ5lycac2PwDLclXp57dXH9fzjyneqJweML
 gAHPo5uQX8JD+m06z5OrVXYCj75JGrxeRTNsITSTwFelQz1lwVkphtVz4MYDtj8/BN/x
 qou5YLh0XDuEN/l43kLwh3Q+VYJJHTzGIoQqE9tR2e7QZsGNvL5hDAWMwnzjPomr8TQ7
 oxew==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1vbNcV3nD2GCww+PldnNEEE82nci7f9VLGpQCYtz7BGl6SYxfWXt3UQTmYrycAQCyPROGnd8P3Aw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mJKp/2q84KRXlqrVw2SJakd57f5cOggPCRRQNj4JCjpZf5OVDY
 7XdwtiXVclx2iTBrSDD9MjxJoyJVOAxXaY+XJWDpXw8AR8XnnUpHq1s5xehgPO8Yo+Kv80FQZNk
 zXYAEBf5mbBjtQT1a/0o9VSSBJ3ojRYsGXMqZKC0DAB/ueE9rHluNt/CAGn3Q19VRbBTvHen4ps
 oAcHSLZQD5H4VDiRcTnv2KXA9FlRKYZagdrA/K2Kr9n6WmDHpZJ2c7m/vpRNVVNBuTLC14hwLG2
 79qCpClk7v7J3txpou4xG5enu1W
X-Gm-Gg: AYBFou2LWi93SVJm8cpwBACzaNzFt2RDJWUcVsVD2IqFvW6TuM5HsqEB/kK+8lUQYrT
 k1SZQs3jumcDiWRlO5XwKrGiTm8FxhPiX3jAbz1GLS0uTxbGo4TxweoGMKSHimwcYS9R+kieTFO
 /v1ms70bqQGyFKGT8MQTMrRMiOeQf4aKPb/aQ70KGmQY+b028t2vfnncN48NgmlDftKPPqjd6C1
 YgtRTBayZeYvQHq7HDGm4InebuHxr/Lm9EG/8dkB9IcGcgV0ZwK0YJXqMqjQbP3yR8tl5ZX+EJw
 h2KBZ7QVxWlC5SpD/3fwj88f03n79aiwcfJ1Kag1ucV4RM04E2/1NSyodapKfAZQGM6xw9iJlR+
 mnC9XBsMT7Ob4dD36OTY3oC6NuaBt8VcaKnNM3UaSvuCovkYjp3CjhUssGDqSIWzQAJJVYoEuu2
 VkfbrnJMGLMDpKh2Cj8plBYJCCcWStueH1KAD94uhF
X-Received: by 2002:a17:90b:4cce:b0:38f:240d:b857 with SMTP id
 98e67ed59e1d1-39b260dd4e9mr1346923a91.2.1788464219751; 
 Thu, 03 Sep 2026 12:36:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-39b1600a8fbsm1439361a91.3.2026.09.03.12.36.59
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Sep 2026 12:36:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5302b692c8cso6495941cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 12:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1788464218; x=1789069018;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wbmjJn4KRbF8oVMPpkd76I/qR3hSpCdh5Z2V63vUrww=;
 b=HTsopGB7zCZGfOWeftUFsseGoPVb5nzaNMZS9d7NCkScSc4yWE188UXGeea8eE8Bjd
 ZRtA0hwHKZlbRujqttjnbe5L9zC0s9LA7fLejQL3n82VUwTtaB1om2aEQO7CrgJvcDHy
 sME00O6x8pdFEogRmSpGa0cFrglh2RMoOZ6jw=
X-Forwarded-Encrypted: i=1;
 AKwUvBxD0lKgGKPRfiGitWZzUCmF25ff7Dbs5uUp/VqbyVAdH2WysQji9PVuc43Lye94amZvR4orbU8Z+YE=@lists.freedesktop.org
X-Received: by 2002:a05:622a:4d8f:b0:527:7027:cc1b with SMTP id
 d75a77b69052e-5305499cdddmr13859141cf.32.1788464218351; 
 Thu, 03 Sep 2026 12:36:58 -0700 (PDT)
X-Received: by 2002:a05:622a:4d8f:b0:527:7027:cc1b with SMTP id
 d75a77b69052e-5305499cdddmr13858541cf.32.1788464217801; 
 Thu, 03 Sep 2026 12:36:57 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-910406af144sm1966286d6.40.2026.09.03.12.36.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 12:36:57 -0700 (PDT)
Message-ID: <fa26224e-9f93-4a65-a265-2427bef7094c@broadcom.com>
Date: Thu, 3 Sep 2026 12:36:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/vc4: Drop the undocumented brcm,vc4-v3d compatible
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
 <20260816-vc4-reset-control-v1-1-896444373716@igalia.com>
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
In-Reply-To: <20260816-vc4-reset-control-v1-1-896444373716@igalia.com>
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
> "brcm,vc4-v3d" is the compatible string V3D support originally shipped
> with in commit d3f5168a0810 ("drm/vc4: Bind and initialize the V3D
> engine."). Commit 90d7116061f8 ("drm/vc4: Recognize a more specific
> compatible string for V3D.") added "brcm,bcm2835-v3d" in v4.6 and kept
> the original one around, because the Raspberry Pi firmware was shipping
> device trees that used it.
> 
> That string was never part of the binding: the documentation added in
> commit 4653f22e9ab0 ("dt-bindings: Add binding docs for V3D.") describes
> only "brcm,bcm2835-v3d", and no upstream device tree has ever used
> "brcm,vc4-v3d": the first in-tree V3D node, from commit 49ac67e0c39c
> ("ARM: bcm2835: Add VC4 to the device tree."), already carried the
> specific name. The firmware device trees the compatible was kept for
> predate v4.6, released in 2016.
> 
> Drop it from both match tables.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
