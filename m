Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40066CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 10:33:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A09D110F144;
	Mon,  8 Jun 2026 10:33:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="QspeUntV";
	dkim-atps=neutral
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com
 [209.85.214.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 664DB10F143
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 10:33:06 +0000 (UTC)
Received: by mail-pl1-f227.google.com with SMTP id
 d9443c01a7336-2c0a5354da1so32953895ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 03:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780914786; x=1781519586;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1BZvvtW/avjN7EApvuTMWlC47GrxgBPws0Db3euv+Hw=;
 b=dRN/6FO2o6im1/9irhAlmJKNAZaZG1ZFyshN+Fnd0klp0vdYdpvgLaq9UShNDKOhb7
 TDcgY1jRlEygj9lrHoDSC8qLD/ia+zzAyPxitQxdYUJ5f8IA2FPkJC3ZUynR96NN3EWf
 hdHIPXZs/KVpKOw9XOB3iGc7GVPIqGdkv/PnA6Zt8PPOWQ12YfsaCYOeGl65PzUhL2D0
 e4ZMQx6BAiAnZtpwoGo3DGMcXRr7owBBkRBwhwABPrdYGmy17fjTz77nqjjyqoVRHTos
 bjY1jqxsMQ7r/t5QvhqMJp93AnqgbMF/Y4JH3Pz7+omXXb01ooEBSFueBIV972qZNgGw
 HDwg==
X-Gm-Message-State: AOJu0Yx7G5II9VSRNdi9AWWfeVKzwOx0DcPA9UCcrkXCmMUOhxFqVBFh
 nTDgxoEKquPmXjbx/ReeCw20lPqAwkOUWiewkWSoJ8zRnzQLW8R2FA+vfWbQ2MSwgtEGtBi2+zA
 euX7+Y3OiGafGQS+XHTPJeC+qamY6yea4tFBQr1fHV5tCy+CCkrTCwKt8VC3RdW0UwLSOjInG7F
 Mh05rkstYLLHadeF+adJ8nlSvpt9ITi7Kbx+/Z6KpyNYtz7JGDh9l7TJrQCbGykh62srwlsKZti
 KzNr55MZWy56iKe23SVufBu54fjP2Y=
X-Gm-Gg: Acq92OET2BQ2551/ui8XdnAgJNoXo2mIU4qqHZcdGdzYx9FsJGQFivlFA823xHZLQm5
 QEwolMe4XkazEEltVc9Kp6y9VNBSFM79X1QSXdldqp3uQ2QkgpX4Qkd92A8eVN6JXIwzgP4h6aw
 pzgC2Hnkc3wr78QO4hnNwJ01YZTdZ8Ilhj33vyjtMHAtg5WeAT5ftPVw2ORnXj0730X6RxHy/Re
 TT3gD9X3hXEdfMTfGQe5H+jVLUfNTaGoMwpZiS0Nd3U1831mZZk/CrDUrT5XsvKfsIUcwOlCDfT
 EbAH3hbW8ly/IpNziNOXq4IqkBkhJmiES0iCJFrFNhRXeL1/bsDMgz87EMT6d/5kjjgZUKRdcFi
 VDc90jwHq2WGiRgdA170PQQfAjJy6qTTVAdW6J5PgoPp+oz8rMJfhh0QOGd14jV5M4nZyV9CKG0
 PDxU7y8j/WwHB17kDbjnuv9dWefSkvuhx3EoYLAghtdPNAvgir8/yCxBt2eZFibx5v6m+W0Nd5q
 N0=
X-Received: by 2002:a17:902:cf07:b0:2b9:cabe:ce37 with SMTP id
 d9443c01a7336-2c1ec3f5cb8mr119217935ad.1.1780914785749; 
 Mon, 08 Jun 2026 03:33:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2c164fa79a4sm16597535ad.22.2026.06.08.03.33.05
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Jun 2026 03:33:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45eecec7667so3028166f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 03:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780914783; x=1781519583;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=1BZvvtW/avjN7EApvuTMWlC47GrxgBPws0Db3euv+Hw=;
 b=QspeUntVsuXKB68DTJtZWl96HC8D/pT2DZqfZMgG+Dqa0NfL7bw8Jqkik1VbUs3Ulq
 V9MrpMrRjZzHhCY4HpRSGHCYSqwXII18Gg98Bi6HuHxE0aIA50Ry3/+YqPpTsGhCtTCk
 yz9Lgv0414X6YTkZ3DBJLi0Q8BNYIyduGsIN8=
X-Received: by 2002:a05:600c:83c3:b0:48f:d612:3c59 with SMTP id
 5b1f17b1804b1-490c25a21a9mr274587945e9.9.1780914783572; 
 Mon, 08 Jun 2026 03:33:03 -0700 (PDT)
X-Received: by 2002:a05:600c:83c3:b0:48f:d612:3c59 with SMTP id
 5b1f17b1804b1-490c25a21a9mr274587325e9.9.1780914783068; 
 Mon, 08 Jun 2026 03:33:03 -0700 (PDT)
Received: from [192.168.0.105] (88-187-52-200.subs.proxad.net. [88.187.52.200])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3c183asm387752935e9.6.2026.06.08.03.33.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 03:33:02 -0700 (PDT)
Message-ID: <2ca283ef-f333-4229-b36a-8fdd14ba83af@broadcom.com>
Date: Mon, 8 Jun 2026 03:33:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/v3d: Deprecate V3D 3.3 and 4.1 support
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Emma Anholt <anholt@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Stefan Wahren <wahrenst@gmx.net>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
References: <20260606185616.694188-2-mcanal@igalia.com>
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
In-Reply-To: <20260606185616.694188-2-mcanal@igalia.com>
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



On 6/6/2026 11:55 AM, Maíra Canal wrote:
> V3D 3.3 (Broadcom BCM7268) and V3D 4.1 (Broadcom BCM7278) has had no
> in-tree userspace since Mesa dropped support in 2024, on the grounds
> that those generations were no longer being tested. The situation in
> the kernel is similar: the maintainers don't have this hardware, the
> hardware is not available for purchase, and there is no known user of
> these GPUs.
> 
> With no userspace left to drive it and no known users, maintaining the
> ver <= 41 code paths is a cost without a benefit, considering that these
> paths are not being exercised on real hardware.
> 
> As a first step toward removal, emit a deprecation warning at probe for
> V3D versions earlier than or equal to 4.1. The hardware remains
> functional for now; this only warns. If any real user appears and
> explain its use-case, support can be retained.
> 
> Schedule the removal of V3D 3.3 and 4.1 support to the next kernel
> release.
> 
> Link: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/25851
> Signed-off-by: Maíra Canal <mcanal@igalia.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

