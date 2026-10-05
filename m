Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A1ACA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3297F10E91E;
	Mon,  5 Oct 2026 09:27:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jEPXtRqO";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24DE010E91E
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 09:27:56 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e79a408deso8636985e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 02:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791192474; x=1791797274; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8rLD6lFejoN0T8xG1+fKNKHQcEvhqJXDjenF0dJEnUA=;
 b=jEPXtRqOH4MhLSlea8uhaaL+7i1UIn56svDZ2DicpOFDk7/9kG0Jb/l8XCg5jYQr9s
 b7VeTR5S3tS2qmRqMBEgb/P+DSwpqbyqrCIzntlfS4q2KyPJCJUGQBLdzyk72JWvnk9m
 MQLIQqDeHfIAZUDO+OovGfUWjFA3rQrUlzhk2mPS2gqCKDjdpYkgSFA/x0FLIxDHqBkq
 7M4lkoXlzbp8q5sYOuJ87LrlG9VVDxJKgq2/X+sVPYJdSOl5eqOJEfUrIe6h9qQFuXmv
 x7ABPifA69uHB/2OdarRN34wgqsF8b6ucY3qQrlYfvydJZjgirq6+b0/u/9emyaUp7yZ
 dylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791192474; x=1791797274;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8rLD6lFejoN0T8xG1+fKNKHQcEvhqJXDjenF0dJEnUA=;
 b=KY1iNY9ibDqBjvBkY/b/ouXiqRVrOrA7kSGQZBSL8C5E7Vbq/OzcT8mRTUPGuBfkZ6
 BtPl9ac8kHzZSCCzU7b6eTPqmz8/X0mLvvRqoio3f1rWi8dvUWhHPJzUcdq53g+vemSA
 5Ha5jvQ7twv5tVtSwjyNOnvLO8u8/gEqsfwIowPJUoeVCWTqzCEekX8FDK8yRGPp2gsG
 Q8ZchTjK+Pf1e7vUwPYFZjkxNApbuWTvVrD48DrBlyUvv7oVPqTAdrwLaHql2kaabARR
 +z5pRRDT8SP2NQ+yChsliFWXgnlMVSEb6PA6vXWp79Vkxz+PZVMg16OEwVkPnX2PdxXU
 I9ZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBygF6naUsMhA+9UeFKRnimP9UzTdCDgStwUWN3BJ2CZHLqdIAL/S2+D6eGMZL42ypl53xiTEUdXjzg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k57ZCX1riolVm6iSPnzUY5vIaVH1Iw7HTgSrjOYDPBsOPUN7Jc
 nHSPDqMFSnPWlJGSpJBskpvfuXSBtlvluWg2dAokjLvMqhakH1zJuU36VN7qi5U4YnU=
X-Gm-Gg: AYBFou18udND2Kxm2Ja/TZeoVkWZyeVjGEAZK9VfWC3WqCJ1c0QBmgIrN11ZeApjhsx
 fxGZss+uU41X7qEnk3DJMuxO0ChqJWiSwatrN6kUL1tV4s0LBN2aaz76dsZ8zJB3K1DT8JyF5pO
 fARhjdbquvra00GecbWc+mQWa1uSRl3fvyH7hLsIw9lzNpWdEV3QxvESWM6a6uFSaSr1b7yhp9n
 /4Rkw9GAQIbJF3GYxplO1PlUIVAZceeLzZpl2dHgzXqaOzxzsHg+LPBkkchdNknTdP4K5UpBb56
 WRw1ktaNdGUDP082Z1TAluz2/9wB95OppvY2cvypN3aX1r1th707t4tNj9ZY3inVmbj92fMEJOp
 FRMfH9ERjgoRwNruxvBAmPZlky9D0mplIv2A8HXPwhBut9+OKiQ6Seg9VLoVvy+mskFa2ap0bXm
 puXjE6Z3y35pO/9hBxnOVZ/WfJJS22Cqry3Agu4y9Rm9Lq7U8ZqVDtm6ISRDwhDZ5+V20iIK0GL
 TgRvSGc40yI7h8MCprnnBkskNrBAzI=
X-Received: by 2002:a05:600c:468d:b0:4a1:7093:409a with SMTP id
 5b1f17b1804b1-4a1709341bbmr63938175e9.27.1791192474107; 
 Mon, 05 Oct 2026 02:27:54 -0700 (PDT)
Received: from [192.168.151.46] (90-182-211-1.rcp.o2.cz. [90.182.211.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a16620dbdfsm221932725e9.0.2026.10.05.02.27.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 02:27:53 -0700 (PDT)
Message-ID: <9be89803-974c-4746-8af0-a13e5a19fb33@linaro.org>
Date: Mon, 5 Oct 2026 11:27:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: himax, hx83112a: Tighten
 compatible matching
To: Luca Weiss <luca.weiss@fairphone.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca@lucaweiss.eu>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261002-hx83112-compatible-contains-v1-0-d558635ab7fc@fairphone.com>
 <20261002-hx83112-compatible-contains-v1-1-d558635ab7fc@fairphone.com>
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
In-Reply-To: <20261002-hx83112-compatible-contains-v1-1-d558635ab7fc@fairphone.com>
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

Hi,

On 10/2/26 16:49, Luca Weiss wrote:
> The compatible was defined too wide, we just want "djn,9a-3r063-1102b"
> and nothing else.

Can you add Fixes tags ?

Thanks,
Neil

> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   Documentation/devicetree/bindings/display/panel/himax,hx83112a.yaml | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83112a.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83112a.yaml
> index 2c60d0cd704e..3dd9b25ff13f 100644
> --- a/Documentation/devicetree/bindings/display/panel/himax,hx83112a.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/himax,hx83112a.yaml
> @@ -18,8 +18,7 @@ allOf:
>   
>   properties:
>     compatible:
> -    contains:
> -      const: djn,9a-3r063-1102b
> +    const: djn,9a-3r063-1102b
>   
>     reg:
>       maxItems: 1
> 

