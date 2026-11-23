Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1687A606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=XuKLtJtZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57C7C10EF6B;
	Mon, 23 Nov 2026 16:09:40 +0000 (UTC)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2BE410EF6D
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:09:33 +0000 (UTC)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-3b4021b572dso2204020a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 08:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795450173; x=1796054973;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BbQLzcz5N1dlPbUl6OzlxxVqvyHG+NqgOT2/CZytGRw=;
 b=KFASao/B3ZgRmQndAkHLtAGB7uL+qU72dKAz8fkvtCuZoMfAshyQQYDEPURlmUjA1/
 Bekj6cDWm8MLH1ab0LGzKJ9nwKGx1R7AqK8CmcRMrX9HnnrdFjeusmqwFDB7Qpqc00M+
 Yg7Vu/c6Fa7nWUsdWI8aBkrLItnKtuGxj2xj8QPNFglhl9xui7j/d/JHhPKxxFS5N3y8
 UFdJwCaH3we/zKhXByVZcvNqzuaxmRgqfWFa/0raQ6RkYyZoMkzAUK/U4iHX9KU/HOkN
 2i+yDYQCdKR4VoH0HvwGZibmIln8j3TEjIyKBfF1DDEy6WPN+1NwfcQB7iT7fUL71Clu
 WccQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH5gMzlN1j6/W/LrfJiu3ExlCKt7AVas8xwK/uoYVH90fYVbOdg+3v/r7mggtwGsbzzxw2DDqtIkwI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9VwMpZ3Ezw4oiYoOrji+xzY+VpdeeQCBLx9TpGjNhniWny2C0/
 yDz+NB3gRGFB4/f8FP6R+3tibwJWZuhKswt1rNxWurPKKTfSHYRvBs+cyqvNMBCpGkmeudjB7RB
 KeNw4C6wlVp+xoSSdBJK3rWMjDgt8OEgHYwUb93SmdzGexRQ9XPNob7JHF1DGJHrYRVQOHyfdqE
 w0oqkkZ5aiNvgmj6NemdUJGqTgGzM3vYJMhQaTucgOK5UvW6wjIRH3XZ/AXmk/QGlXi6HQRkiP+
 AIbkvBNg3/AqC4NVQfAXhaBm87q
X-Gm-Gg: AZFdTZcEFhE1waD8bIjY2b8+EIJ0NdR9QECTlzNxS8rXQQyAxJiisun0bF2HO2EYdCP
 I+PC5W0y9y1ocK0GnmMzuKzTh+q4fE3KlAC21aP/vZy/R2kIJfSVX0Tp3G5c6ERlMvWs5QBDXJ2
 vhPYAEc7jjZeMr+gqSPVXegi2Z3+hNhrQ9XHZmFRc+ZlxpvpCFnskpcYhYJWVKkGVZFGfWytmRm
 0/cU2EQSpzeEf+P0m8uL7wLVtDaIDMb1GY2EB3LwTo7iScm9i9T9SSfURizUky4a6gmH2S2gAcU
 BnGjOlQwKOA5OQgvuI3oHkY2BhLzreQgzgU8yzWIoapdS0os0iGQi1c6FBCnAixC1bClz/Rig/R
 C5rGrgloitjM0e/gL9jcynW2LKKUUSTp2Id1vI4M7Rx/Yj9fuOxei9HKJwvjjZTrzpPgc578AUm
 /I2miJh3SBHW9AzJ4IINN1uPSVTicB2KSrOgTVHTOphzw=
X-Received: by 2002:a17:90b:1dcd:b0:3a6:e901:e79b with SMTP id
 98e67ed59e1d1-3b41c8d9bdfmr10741566a91.15.1795450173242; 
 Mon, 23 Nov 2026 08:09:33 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b41ab582a3sm8627987a91.0.2026.11.23.08.09.32
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Nov 2026 08:09:33 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso4810742eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 08:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1795450171; x=1796054971;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BbQLzcz5N1dlPbUl6OzlxxVqvyHG+NqgOT2/CZytGRw=;
 b=XuKLtJtZNcKNwf5LSnoRROeU7U0UXiDFvQ4yw3TuM/v9i77hEprESQDg6EgEFeAAmq
 IOtxO7OOo1DTn6hxg0Dg40jS7p0SAibCDRZFzQAdCrSb2XjQfnMYjAZqyCbiZAJxlbOy
 R/bldn7Vk4j08F1bmcT9DvjFiOPBY+c6a6DeU=
X-Forwarded-Encrypted: i=1;
 AL+hErE0MUWU+nCoMOSx3MKDRtvyOHoa514p8ua7KcDs3mV9zOrWu+cJGG0elveadvo67FVDJ+czIMejVjc=@lists.freedesktop.org
X-Received: by 2002:a05:693c:8850:b0:386:b351:d5eb with SMTP id
 5a478bee46e88-386b351dcddmr2691981eec.7.1795450171223; 
 Mon, 23 Nov 2026 08:09:31 -0800 (PST)
X-Received: by 2002:a05:693c:8850:b0:386:b351:d5eb with SMTP id
 5a478bee46e88-386b351dcddmr2691953eec.7.1795450170519; 
 Mon, 23 Nov 2026 08:09:30 -0800 (PST)
Received: from [192.168.10.3] (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385677c0c1dsm40727775eec.21.2026.11.23.08.09.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 08:09:29 -0800 (PST)
Message-ID: <e9c24ccd-427f-4ea7-be14-9d05da6eec71@broadcom.com>
Date: Mon, 23 Nov 2026 08:09:29 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/v3d: Remove V3D 3.3 and 4.1 support
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Iago Toral <itoral@igalia.com>, Melissa Wen <mwen@igalia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
References: <20261122-v3d-remove-33-41-v1-0-52152b454ad8@igalia.com>
 <20261122-v3d-remove-33-41-v1-2-52152b454ad8@igalia.com>
Content-Language: en-US
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
In-Reply-To: <20261122-v3d-remove-33-41-v1-2-52152b454ad8@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/22/2026 7:47 AM, Maíra Canal wrote:
> Support for V3D 3.3 (BCM7268) and V3D 4.1 (BCM7278) was deprecated in
> commit 7ffcc4fffb45 ("drm/v3d: Deprecate V3D 3.3 and 4.1 support") and
> scheduled for removal. No user has come forward ever since.
> 
> Therefore, drop their compatibles and the code only they used, such as
> the GCA registers, the bridge reset path, and the V3D 3.x performance
> counters.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

