Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A26CD98ED
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 07:34:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8D8710E96D;
	Wed, 17 Jun 2026 07:34:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mGbI5TPV";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C7A510E96D
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 07:34:27 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-490b613a17bso49350265e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 00:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781681666; x=1782286466; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=3Uim5pbWVyeQp4JbMjOlnv43bbNh3AaD6WsvZpd9kZ8=;
 b=mGbI5TPVVjAawbYzRq+tT1Y0lgWK3lSyksMverkDSRRPr7ou/Ic0LjTJ8RMx+/sCd3
 VR2Zv06ReFQZVFN6+zqyK03iBycOfK2TTclqwxY8WhUmrCnOcDHhn4s96P5OlvjENfsi
 Ma8VkzK5GuIucnRQOzYiOdYtDFjYT/CdVNHvIPeibc3aP5E1m4xZn+PXRSPPc70EQzNQ
 ODz8USO5tT/QJLD+gBX66fXu5KmnMQXO2BlJ9VE/fFWTwdFfSGNgOdQeI9jlRadOtR1r
 noFAR4uGyg6h2ItIMpoHGpgw/7UqbIbfnDrOUuBXdToxsuhHYOkZcRoAfV74eEjHYV4h
 hwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781681666; x=1782286466;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Uim5pbWVyeQp4JbMjOlnv43bbNh3AaD6WsvZpd9kZ8=;
 b=NAeS9+ypu5GVFXHbwvFVeutBMXbCsRUOfJfvt9Kqjwhx4aS5q9MCa+sSF3Gp+stJbd
 EhtRZbFkkEbcsyZWxMYJi6FFdSIjF6icweVlGLU++9qW/N3tFFFMe2Jk3oX4EcqM3L2B
 VpVFWMa1sNDgOTen7+25HkVOpFmrRb2YOgkLTj8JeE2RrJ4n0UZacbRINaD++g67r3It
 moCizuIw8zOf75oUKYWsEQAqY6/p7R3n+2Vk2iEaHKySmGYYeG0Lz9uF0UHPKkCKYN7w
 qc7lMj6IqhHL4MYKUB62AwQK/bttJd8JTKUZt3+dNa4r0ps/HS9sP+hHN4HtHmTIgAsh
 XuWA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hYW2bNsnLz6O9S0TXr+yOsP9I/NHDH6ftvr8pPx8K54gACn+fB4JB35tqcqZMbZtrXx0Se//E0nE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzX+RxFAKPiXz6YCEcVwZrRciTXyqJ2V/N92CGsaD6AqcfyLKXI
 0S8JXOntg4761xurwQNM3lcmyX3Hd6NBr9AjeKv9yDTUItnggptSc3tUYniS4Jj/XP8=
X-Gm-Gg: Acq92OFMmmEh6AJp5mDZ0vDkvACKdXs17/CXEk23Z6DR7vs6zh2Dm4FOskdRXMKhxvA
 dx7+Em8axkW0jz0oFuLFQ1Pi/tTV3lAoBhluQKr6JNrYbzrKWXilhEKaKouI4gzQ7UK8Sx9Njqg
 q4oqZ9qE42dWN1J/3j5SzUAuT6jMW3xoIKVE+ZlfcqF75mfoPsTRl+PUOS/3oWUOQqrzSl5blfZ
 1Rx2Sp05ETot6ueAS1oJrAK1uVh2PQBz4QanpNaUif4jXJ+3gtmU3dSU6OXu65AikmuktbbhvZ5
 Cnm/t4uMSo6UBdihM/M6ATPpuow9Fgk4hy+46FRRi8ANnxkRpCyLZTn7YMDA/AsqgMBsF1hjsZ3
 bn6P4PmXeAs0DOx0wEn0Dy5IxRYCbNheXcRWZhYlzEqsliINjWYwJSb9Ownvl9oFEmchUwl1nM2
 sWei+BFANkUkSLRi6NT6PJ9w==
X-Received: by 2002:a05:600c:a305:b0:492:2c87:3d4b with SMTP id
 5b1f17b1804b1-492333af19dmr33307215e9.12.1781681665133; 
 Wed, 17 Jun 2026 00:34:25 -0700 (PDT)
Received: from [10.12.4.106] ([212.133.41.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa97a07sm242913335e9.14.2026.06.17.00.34.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 00:34:24 -0700 (PDT)
Message-ID: <6726e289-02c8-4267-b8cb-3b4ba2ebae1a@linaro.org>
Date: Wed, 17 Jun 2026 09:34:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 4/4] Revert "dt-bindings: display: panel: panel-simple:
 Add lg,sw49410 compatible"
To: Maxime Ripard <mripard@kernel.org>, Paul Sajna <sajattack@postmarketos.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, David Heidelberg <david@ixit.cz>,
 phone-devel@vger.kernel.org, Amir Dahan <system64fumo@tuta.io>
References: <20260614-judyln-panel-v3-0-07f4134441bd@postmarketos.org>
 <20260614-judyln-panel-v3-4-07f4134441bd@postmarketos.org>
 <20260615-amigurumi-kagu-of-prestige-ecae6c@houat>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260615-amigurumi-kagu-of-prestige-ecae6c@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 6/15/26 11:17, Maxime Ripard wrote:
> On Sun, Jun 14, 2026 at 05:08:01PM -0700, Paul Sajna wrote:
>> This reverts commit a74c2e55ab66519ffa2069ac9ae83cd937bff4c4.
>>
>> It isn't actually panel-simple-compatible, and we knew as much by the
>> time this merged, but I guess maintainers needed something to prevent
>> the dt-bindings error going off while I was working on these patches.
> 
> I had a look at the patch and discussion that commit was from, and I
> didn't see anyone bringing up that it wasn't actually panel-simple
> compatible.

I wonder why rob applied this one, I clearly requested a v3...

Neil

> 
> If you knew as much back then, why wasn't this brought up?
> 
> Maxime

