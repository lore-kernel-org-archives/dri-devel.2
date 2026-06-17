Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6E0CD98ED
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 07:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9203410EE5C;
	Wed, 17 Jun 2026 07:35:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KN9nua4u";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C196310EE5C
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 07:35:54 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-491609cdd8fso28653575e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 00:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781681753; x=1782286553; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=kiyyh81BRUnw3RVblLaAaVPI8hb9C+UfMQnBnCoh3L4=;
 b=KN9nua4uqEHAnTdnPR3AI+BUgVLxLheMxy936CmnVT4D6NsveJNgPKPyyTSQlwrGqQ
 /DcNJr6nZg3VMAfh3pKt8P+n87iRxogOjCgeetO7LRxuQbu2lUskO449fsN8LnVw+BlR
 1+EUsBQmPcKdH/Bn68OdpTG+7tvAUnHDWWFeBvmAA4qppUYIwQWF+llM/+rhQz5ow5la
 xn1wCfb5c+YnRW4i/vtAmQqAuRd2Sov+A9mRgvERJd5tlvhpberk8wEz7yjQ8hPWCtvN
 NMK/auVd2RecRGYGQOK0SpqRgef1Gpj/NCJCb8JnmR3HBdGDJn3Nm1O7CoDil4DIdBaS
 cT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781681753; x=1782286553;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kiyyh81BRUnw3RVblLaAaVPI8hb9C+UfMQnBnCoh3L4=;
 b=oGHQuQm3tA6ZhtMrHZWodySErgx0LElWs2ZjxweukVJ8XRIqDqoOoJz+lIvhEedPcc
 0ade2ty2Ek4eoFsLK7PEl5XAghrEsf9CvXv78/DpDEUYbSHIO/VNIiy5EnyBs30/FNfz
 lAg7lEMXRBDMytKREYqkD3Og8YV6Y42tdIde3+2gFEo0B7rjYIoXCTiQ209czGOvq2yo
 ckuf3qB4/NkoOlVFX61RnQ7WzubNT/sc88Vqrqr4d8HZsrT9ll/uyrcKRBcnS3uAdAnN
 DW95R7dSTsts/RI3buEikvYwtD9O6fAxtDveUZdhfTgfNlhYEYVxH/tpxqenpCJ/YMg4
 9THw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xhaBWFsxLB4fRegiNZ2tVk4cXJ/jPoMYxPkjer7oc4c2ywPx/+pDFkmsClDe4PQwXssMfieeIpi4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywo74wKZfpDXzO1tV6VW+fkQR/lZuDzMvNed7okFgvtAH6yGKnv
 E5W8+Qbtyybh3ZnBIraNoUXVxGEw8Cep3+5tkmmwW6sao+SVf425md6zgKpiOJojrIM=
X-Gm-Gg: Acq92OFNcs8BpOff1K/67M6vezRuN93L2caDzxZNABD5Zvk1yH7rUmY9dIbEeN/7rfQ
 SNDkxC49fv/kEAa23gQWHdrtUjLa2bsz/TEhKzHPKhUJyuvsdXf4/8inou5ZwQbJjJwEh/+vChq
 PmDBuM42P0w+7tH0EmLVWUmXin5pLNUyLtMZ/IwmWM62DooDyhmUDdXbgp0GJZ/WtfqUAKQodAo
 awSm2HpFvZNdkPIrP4ebY4Gu3kOIYGb9UwF0GJ0ZzIGoo7q+pS9UjRmTXbG7knM7vx9AGi+x90N
 k2aIzazhn39cVdg6Sh9eWh0iouy2NJTf+7HSjFenwC441IGmNLf0rD5wN63Vnw6GDZPiPvhaEq1
 XRsu7M+8VstgCTePndVX6EeAmwPg0NIaSDXvxDkHOKv/ng2rYgBEZRF3CXRU1MWikTpusUc9LFW
 d9aDJprSt7xweSRaAV28uLyQ==
X-Received: by 2002:a05:600c:a104:b0:490:958f:2a5e with SMTP id
 5b1f17b1804b1-492333ab197mr38532605e9.13.1781681753234; 
 Wed, 17 Jun 2026 00:35:53 -0700 (PDT)
Received: from [10.12.4.106] ([212.133.41.97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-462a9784497sm3087858f8f.34.2026.06.17.00.35.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 00:35:52 -0700 (PDT)
Message-ID: <69550878-fd99-4da2-88ad-8d537d9e305a@linaro.org>
Date: Wed, 17 Jun 2026 09:35:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 0/4] Add DRM driver for LG LH609QH1 Panel with
 SiliconWorks SW49410 DDIC
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
 <20260615-celadon-pug-of-teaching-f1eb0a@houat>
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
In-Reply-To: <20260615-celadon-pug-of-teaching-f1eb0a@houat>
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

On 6/15/26 11:19, Maxime Ripard wrote:
> Hi,
> 
> On Sun, Jun 14, 2026 at 05:07:57PM -0700, Paul Sajna wrote:
>> This patch series adds a drm panel driver for the LG SW49410 panel found
>> in the LG G7 ThinQ (codename judyln).
>>
>> The basic driver skeleton was generated by
>> https://github.com/msm8916-mainline/linux-mdss-dsi-panel-driver-generator from the vendor
>> device-tree.
>>
>> There seems to still be some power supply issues, the bottom-left
>> corner of the screen is dark, and the rest of the screen develops
>> shadow-y burn-in-like patterns when resumed after being left off for a
>> while. https://i.imgur.com/oJZSHzE.jpeg
> 
> If it's not reliable, why should we merge it, especially if it can lead
> to ABI-breaking changes like it happened already.

If the patchset is not ready to be merged but you need comments to go forward, please append RFC to your patches.

Neil

> 
> Maxime

