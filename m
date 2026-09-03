Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C6EC79F80
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:40:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3582210F75D;
	Thu,  3 Sep 2026 19:40:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="c9WU/usv";
	dkim-atps=neutral
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com
 [209.85.215.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4133410F75D
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 19:40:17 +0000 (UTC)
Received: by mail-pg1-f227.google.com with SMTP id
 41be03b00d2f7-cc1c7364550so406086a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 12:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464417; x=1789069217;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=p8+z4kiOtdTmn8miWX+XqbRCAv1t3K0Ial/sw+P7zoA=;
 b=qk/LG/J2kR5IbKp4uZ0MaJ7GUZXyLtXvdKL5rVz024KbKrRgXrYaua8r0SdR46Zte+
 K/u12ENR+GBoJdrsoM+44nBla8GB03pIIU7OBGeESPv2tO892eh2+B5dcoc50PATJXS3
 uAyM8OTFuu6eU/KWfU1TASlptvkUAZUHIprRKod0crPtxt2qtkGEhI1/t00xWrTflxVk
 R3CHURfG0u0M38Ljtf2RqwuvLdxKs7IsHX8xld94VYh5p/t4pG1/jUpgz+Ib1KDunYHh
 9CfD7HbpRCjNdL2gWpcqEtibOv5p3saNpzUAYDn5hZqSddMaBo/CzQ1OgmxFJ8Kb2Siw
 6kEg==
X-Forwarded-Encrypted: i=1;
 AKwUvByIr1Xd0dO5O6ecY0nVdKiJCMUYeiySmBMDJrXnmERNTzBMyYo2i6gJix2d4ipxINevLYFveFONsmc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ni0XIerY7llANo40L6QLpwk5GoLOg3GMJKqU5N2hbS/MTXpavK
 p2CDjeUMeLxSCmIdlZ1jT/O0NIRl6k7m3oUW6+Px71gvklrdvnJPeQ5iGpq2MoGdqNgjsQHSuND
 4yadN0wb/KHmRi0i/Y3AL0tcN81uEdoEfGxyZRx3sZwI7GPj4G/JgKiYlrzpq95PSodvUn3x2Sk
 N9t9KJ+MUwwWZU/WMJeVj2nWLJF5ivJ7XnnorV1rN/k2JQPZcPxb/OLFYIh7gdOAXdQGMFu14Or
 aOuDL/3cOwI662XMIo0liNxMBvD
X-Gm-Gg: AYBFou3vuQLS+/eVXxQLyYPL9rK7SLfNOaHghw98aTZfGousR9+0ARFqOIcSCTwZ7d+
 Eo1APO0UoFwp3qlqav1GnOFyZeED83UcSDaCVHNTiB/cCicYX4B2QxSxfSZJL4ufKv9LAnTMBWj
 1m5hln6B7N9zoqWnqu8A/sbLGPVjOqykmykE5ln/W3VaNLExQgOFVticsTirqCdFo9QOOncNhek
 Ql6/q3YxV9xctH4SfzEoOWwkiMkf5uPeR23zQ1ZLApIgPYHJYXFA6FyzNguNYmrv/QWbUBb7SBb
 OlmJNoT2HZ3XCWNlL3jxU+G6Xouci0+P3lSuBKQZyEYw6X3zJnfpuOFiQYONUmhrKWqcEQiwTin
 QvOAEu8AfEAACTJgfvJn4lH04DnlAgqVlacpzicA4PsOLsRnl3WPJJBjE/xecjSuIKCSqLKC+bc
 gGBQIUa2mEh/xZu5RtfAGYxJ0EB9KhwRdGLSeDqLai
X-Received: by 2002:a17:90b:1a8f:b0:398:d2a0:87ff with SMTP id
 98e67ed59e1d1-39b26101029mr1343189a91.1.1788464416578; 
 Thu, 03 Sep 2026 12:40:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-39b160990basm1441039a91.8.2026.09.03.12.40.16
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Sep 2026 12:40:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c89704da8c7so357440a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 12:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1788464415; x=1789069215;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=p8+z4kiOtdTmn8miWX+XqbRCAv1t3K0Ial/sw+P7zoA=;
 b=c9WU/usvdM0SSkvpMbGFIkhMHUWOYjekqt5QFrOXMRJu7+m1LfLA8xwf+T5kXLKjdd
 AfSoAEKE3BzkIkLerNRQDUHezCAwnZePc44jae3jZfZeTJ7e/qoyv1s8dwhbKufYkU3r
 JjCefwmIaUyBhOn4gucQOVesZaT3HbYiqvZKA=
X-Forwarded-Encrypted: i=1;
 AKwUvBxgI6jceaVyyVtfxtxdgGtRXKptlJuPLYii/WdcirlGskS7FERldjTwjbkIFPiQ5P2iOKrXmk8oI6M=@lists.freedesktop.org
X-Received: by 2002:a17:90a:e703:b0:398:e969:87ef with SMTP id
 98e67ed59e1d1-39b2629926dmr1274556a91.24.1788464414680; 
 Thu, 03 Sep 2026 12:40:14 -0700 (PDT)
X-Received: by 2002:a17:90a:e703:b0:398:e969:87ef with SMTP id
 98e67ed59e1d1-39b2629926dmr1274468a91.24.1788464414183; 
 Thu, 03 Sep 2026 12:40:14 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339b6036fcsm1124198eec.20.2026.09.03.12.40.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 12:40:13 -0700 (PDT)
Message-ID: <ba2ef3fe-5be0-4e1b-a2bb-f0832fc4dd95@broadcom.com>
Date: Thu, 3 Sep 2026 12:40:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/vc4: Use the reset controller to recover from a
 GPU hang
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
 <20260816-vc4-reset-control-v1-3-896444373716@igalia.com>
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
In-Reply-To: <20260816-vc4-reset-control-v1-3-896444373716@igalia.com>
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
> vc4_reset() recovers a hung GPU by dropping the runtime PM usage count to
> zero so that the power domain goes down, and then taking it again. Such an
> unconventional approach only works if the driver knows exactly how many
> references it holds, which is why vc4 wrapped every pm_runtime_get_sync()
> call in a private refcount and mutex.
> 
> Commit 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power domains
> under a new binding.") exposed a V3D reset line for exactly this reason,
> so that the block can be reset without power-cycling its domain, but the
> vc4 driver never picked it up. Use it now, which removes the need for the
> private refcount and leaves vc4_v3d_pm_get/put() as plain runtime PM
> wrappers.
> 
> The reset line is optional, to accommodate older device trees. Device
> trees that do not describe one still get the driver-side recovery in
> vc4_irq_reset(), but the hardware is left untouched. Two in-tree platforms
> use the VC4 V3D block: BCM2835 gains the resets property in the next
> commit, and Cygnus is no worse off than it was, as its V3D node has no
> power domain and the power-cycle only ever gated its clock.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
