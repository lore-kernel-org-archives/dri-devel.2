Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB8E1061B1C
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F15810E627;
	Mon, 30 Mar 2026 18:46:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="gAxEx7hg";
	dkim-atps=neutral
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com
 [209.85.216.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 981D310E627
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 18:46:50 +0000 (UTC)
Received: by mail-pj1-f99.google.com with SMTP id
 98e67ed59e1d1-35d99031e4eso1333746a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774896410; x=1775501210;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M1E+3WVXMJwlqaN80KkJm7QShEoP0ecOMzlPB5qaAL4=;
 b=iRtfuz5BWi7Ff0rSQ/S3qgkEVx3ALsiMEQc+QO5PC7f8tmCXYctH2ysF0ETE1hPpoo
 7tfzadWDCkIZs7IgweA+F4+pDesB0aGtQPxu9Yy5RNh4S1Ft6TxoiAidM6fsJKEZIy+c
 eL7dFaTnhsYv0Sa1R3z1II2241aPJRRFmE/FAD69uy5iVRQlQtPE0vFhOzzFAD7aqzHG
 AxMI5hTvqP4xMGA4d4e+++6kywdrElD/IBW5zL2UGJWlVGXYUuQcY7juKJM6DFwPkFFd
 /t6QyhcG5PzJ2t/CKT2r1nIJgaMNMeLAUm04n29r9w8aRaHZbhOzuuVN/OlhnR/9Qb8L
 ZiwA==
X-Gm-Message-State: AOJu0YykoPALqE6jyZ07aSxpEZYhX3flWHmB2vWW5V1GNpqtdk+Tpa+J
 Pln4UrDvdJ8CkBeR/r8r/n/+Z6RNGBo2ywCZ0ufi9pTY+O5aEy4ufEpEYIsttD9Ak7TS1FPDU+b
 ti8jUH7pVrT1Hd/XZXjkGWzSNnAM7as08rWu/nGHTyUtN0+6P73DI9zHup5lvjn4J2Eq5eroxY6
 O1NbwXzs5/LxtwoQgw5HzPL2102Yf7vJKO1Uhba6dgAI0+Sev0Ldphh8h675QKDJDB2PqRnRcXK
 7HFHZqnqIOjJVe14xkWV/iyWzrY
X-Gm-Gg: ATEYQzz+eaJvKac8oYbBZQMoLRzEcSn7Mp+a848eBlJg1IhqgdMGcHXSfg0vvF0zvIL
 i1KzroMcNUuKI/0WPHY+MQ4SqK9f5iTseXUvFVhrD15k/xkKKwQE3TxSl/Du7C7YvML+9AT4OWy
 xcgEl7wRoDNlIb+TZJTJuHd+OwiWJq6pgjBN7F0AE61WY7IhahZwv/NHpBXBOR3ujv/lRkmjW37
 99rrv3ycADu8kv7lfALwlC5sQ0ZxwPpsSHeY14ltTjA2ubVxNlD/GbmUYrNwpbOPyHAm+qcoWVh
 HzMK0JNYKlrmETHPOA/rgVjCraQoA7dIs3lCYK3FMbxlJzdQJ0+oprfjiJINevLRcPHZld12h3z
 OM3+E8B29QSKVIpEYeGRTDtOoPliLK8OVSmxwmpKLlJCoxRnFwzsWHu1KiHjPS19NNyzHKgOEcn
 3jsc9eLhCiICVx6naca+XytJwnalVhyDtH9DvbMB1CNAxsBWjWYYnXxRMVSMeTGQ==
X-Received: by 2002:a17:902:da4d:b0:2ae:5eee:7a5 with SMTP id
 d9443c01a7336-2b0cdc280d6mr119202345ad.12.1774896409968; 
 Mon, 30 Mar 2026 11:46:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2b242742a17sm9591165ad.37.2026.03.30.11.46.49
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 30 Mar 2026 11:46:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5091782ab06so248443851cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1774896408; x=1775501208;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=M1E+3WVXMJwlqaN80KkJm7QShEoP0ecOMzlPB5qaAL4=;
 b=gAxEx7hgxHDNeue/hanKlX/Rh9P9S1dL5N5VmFBcBX9JmBOqQg/xIVldzmLeh5KvLC
 x7P/VA7xYhVNuj6PmPlv4MsZGU9iJijSYYUVB5fRAk8mWFNXXFjBdAjsZeyjBRmtlCcO
 Ks7bq7KXZbtBxHM6NbVmn5rolOxDgouw2o2bs=
X-Received: by 2002:a05:622a:5591:b0:509:2618:cef1 with SMTP id
 d75a77b69052e-50ba38c8f89mr180654061cf.47.1774896408056; 
 Mon, 30 Mar 2026 11:46:48 -0700 (PDT)
X-Received: by 2002:a05:622a:5591:b0:509:2618:cef1 with SMTP id
 d75a77b69052e-50ba38c8f89mr180653611cf.47.1774896407577; 
 Mon, 30 Mar 2026 11:46:47 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50bb2cccbc4sm75020471cf.13.2026.03.30.11.46.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 11:46:47 -0700 (PDT)
Message-ID: <189a2bcf-88f6-4038-99f9-af11a4e27990@broadcom.com>
Date: Mon, 30 Mar 2026 11:46:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/3] drm/v3d: Introduce Runtime Power Management
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Stefan Wahren <wahrenst@gmx.net>, Maxime Ripard <mripard@kernel.org>,
 Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, kernel-dev@igalia.com
References: <20260328-v3d-power-management-v8-0-94336830df5f@igalia.com>
 <20260328-v3d-power-management-v8-3-94336830df5f@igalia.com>
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
In-Reply-To: <20260328-v3d-power-management-v8-3-94336830df5f@igalia.com>
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
> ---
[snip]

> +static void
> +v3d_suspend_sms(struct v3d_dev *v3d)
> +{
> +	if (v3d->ver < V3D_GEN_71)
> +		return;
> +
> +	V3D_SMS_WRITE(V3D_SMS_TEE_CS, V3D_SMS_POWER_OFF);
> +
> +	if (wait_for((V3D_GET_FIELD(V3D_SMS_READ(V3D_SMS_TEE_CS),
> +				    V3D_SMS_STATE) == V3D_SMS_POWER_OFF_STATE), 100)) {
> +		drm_err(&v3d->drm, "Failed to power off SMS\n");
> +	}

We would certainly want to propagate any errors from wait_for() here to 
ensure that we built appropriately timeout and get a chance at debugging.

Same for v3d_resume_sms().
-- 
Florian
