Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F43910A1E68
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 11:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 719D310E0BA;
	Thu, 26 Mar 2026 11:24:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gs84JcIK";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB05210E0BA
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:24:56 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-359fea895b5so664788a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 04:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774524296; x=1775129096; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=BX0MT01leMBG4BuGPpqJr+b5zRNKzVO7+wXXaiuziM4=;
 b=Gs84JcIKC9z/Wv+wiAiFP3CHa0MF/b0Qru+pD1eydcEPqMUMsJtr4VTIjsuFDNDNTP
 tH7uRJQy2XMQXBrvGRIR3Gb3SOqXQhsUa2w2rvj3+H4LqsEhw9WWbp8JSr6wD0IoVuxY
 f1OrH9rqwgsUeDgDpJB1Tn5RsFZKdZ/K3z4QK4/LeMcuWVKnxbgq+Rc5+/BzWpJCau9A
 xq/I0ihdY7Xfge28RvYMhsKYaqFmf0PIKmSPXxiGPF8RKtl15CM8hagJTS8tPVPDOV3V
 XeX4Y5cMkyEJUUm8IPG9pBykOlAVWUGZO64eeKco7MSx+PQTKwl5xsiZtYI6zqHd7CUj
 4YJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774524296; x=1775129096;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BX0MT01leMBG4BuGPpqJr+b5zRNKzVO7+wXXaiuziM4=;
 b=JzBhyDjhijDAZSUmPYlmpnTZGiiQ1TZ5ti+7B1YLN8XVeOaZ8z4zH57bIdgvEnUVKG
 QBkGtRK97m43WemH8UzhH2UgC1y83ca2HHvhkJxWlPQcvx0YbXUoLijdTpThAakyoLZC
 vzxo87SyFasi55fXvUYtfSWqOywm4TIvm+Rk1p39hYPoUSc37EgHW9+qitkvWC+x9tQy
 ez7Tqtzm//HzUFizIphipmmUIQU4grF57SWvxZZtCDZ59qtTUDqF4OEKepkZht0Qj2le
 +PiHzfSUshKHx8YgDyy/VTatrFdjg87KvIWNs7k2UUkoB9i0NKIO9n3Yazk0MuhYghzc
 wP3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbec5peXbtJO3Bu9wRuZHNNevLU3tVl9CLc6N13O2e7tHuv3DH9uj3vMRP6HDEmzB9n1JumT3G0K4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFQSLr+csZ/TLCfGO7fKkpsI3AXcw3MKQByOP1Z+RYRmYJ8r00
 WN+hWWDJNfGn/LEFeHhCBOwy5dgZYOPvn7V+I8TGRdtZTEhbbqln6LYmbBNjXQ==
X-Gm-Gg: ATEYQzzdRF64xaEFirmyBLH3zhIC2n6/Cbf/9qOQD6Kwbv4KF00XjFj7Sb0FYLX34aH
 9PPqc3bcJay6+9qVQDkYuP/Xm60cdJscrzDap6nDNEi5TIeKAteaPIW85ZCoJ6k9O2LtHTdjNoW
 jrBsfrZEfgLKjTtGTC0OopaDDoU6PQnYe4k35bASeoJU7cfjzwdP0BfVDg0p4hdUI6S7KR3Wxyf
 Y9UhZgHNGMK46Uwdth7g55ytrW/SraalNn4ae9WASxzoLnd0iK+lH7i194DB/aKnM/ndknoL80Q
 GAkS0TikyKggG+OFMGOteEP3YbSXmK27W1VWAmpDr7SERH8Uy5MB4KCsxbQh7ebMSfwOYUto1Nu
 R8z+AXB6FJRbKAnJLp81bz7BTk96qJBnkbQaF3sCSyygtkNjJnB2LUfBJa1rkIfSfVv9zwbfiLR
 yRc/J2UlogYDu57r1I1v+MhUlGNreEgHYFVDwj0E9jTpYeet6PMxnrAMlGaubArWMvsoQ+RJ4B
X-Received: by 2002:a17:90b:530d:b0:359:974a:3d65 with SMTP id
 98e67ed59e1d1-35c0ddadf71mr6902467a91.16.1774524296187; 
 Thu, 26 Mar 2026 04:24:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c22a54fd5sm1959276a91.2.2026.03.26.04.24.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 04:24:55 -0700 (PDT)
Message-ID: <18bd5247-a8d6-414f-9816-e131f471a7bf@roeck-us.net>
Date: Thu, 26 Mar 2026 04:24:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm: Fix use-after-free on framebuffers and
 property blobs when calling drm_dev_unplug"
To: Maarten Lankhorst <dev@lankhorst.se>, dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
References: <acRPgts0pCLw8yLq@phenom.ffwll.local>
 <20260326082217.39941-2-dev@lankhorst.se>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260326082217.39941-2-dev@lankhorst.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/26/26 01:22, Maarten Lankhorst wrote:
> This reverts commit 6bee098b91417654703e17eb5c1822c6dfd0c01d.
> 
[ ... ]
> Back to the drawing board, and fixing it in the intel display driver
> instead.
> 
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Simona Vetter <simona.vetter@ffwll.ch>
> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
> Fixes: 6bee098b9141 ("drm: Fix use-after-free on framebuffers and property blobs when calling drm_dev_unplug")

Tested-by: Guenter Roeck <linux@roeck-us.net>

