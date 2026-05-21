Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB9ECD343F
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 07:45:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11F5110E484;
	Thu, 21 May 2026 07:45:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XlwwHhEy";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B791C10E1F8
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 07:45:01 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso76159455e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 00:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779349500; x=1779954300; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=hHRSZ1dQ/OppMz1XaPvdHkTsf0qKVIFDibvJklHxKOo=;
 b=XlwwHhEyygxpPu0+Bo5vKTl4jjP4dLaIYWeBV9Uq6dbFWvPDNueKzsse5hlc2Sq6Xb
 i881idCRwc6wqqgLymYhaeK4d5sezjUOSLxuSH9KAS4Mb6T8BAvDHM6FdvaSfg+lCB9r
 iDWhSUYd3UxXliEQNQfKukoDxm8AEHsKKPhjl+dOu4CroEZoO/ZgWkGCS7ib8Yha1f+A
 Wqxp0id0iiAQJ8rz7bufIzu6mhyhxwSmVDbAX/hfPMwcYFBpwnayojZv3dFYKw6FBjU6
 j604T+6S3fhmoCEUGADr4Dw1hm1VfJeD+cp7UVavIkQT0lTFzuZaKyGjvPehnMyd2aKn
 FbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779349500; x=1779954300;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hHRSZ1dQ/OppMz1XaPvdHkTsf0qKVIFDibvJklHxKOo=;
 b=ZcbRBQOAMqZizGz+uzY6gLrjU0Rx/3TMpDOGNQpxACtGSIGxOQIBunjmzMfpQbvL4o
 Na5OZLUT1lDF4qZ7q2PmT+XwdvOMKfbbe5IMR8djJGn0OAtYIyB3IxcUo+YRS7Y6Ja1x
 xz3ggKchgj385ADZvnBJMRA6F3pjWSqYF/wFHnfktAcjbpq0cortRx5Fq+W4d5qTAFtH
 NBu8Sg6UXgJ8d/X+DVBKJDSnDyckonLFWMKNEWUbSnA41qTvwJOv4pHWHX54/3MDQy9Q
 Wp7ZX34DSebCrdeosd83BHcxC22XVbKdVPkSsA/OEMmvPEpKSdHt/+yEU7h1zm6oQh9K
 uefA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GcLL1kcDdrI9v4QhpRzWiLkMzjElSVPgO6L9F48l04Li5TABOtOoJ3jkjH3/2nThTHSFhvO9wcI0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvEHehKoyM0gkKBmuJTFOVU/1nNhKMxGltzKMqAISTeEGuSF/m
 GRZN9UHY3HSlexz6N9XEWpWt9+jrCdq76CNU0HNRYebZWOfkzZMd2kdt1sA5Uebszc0=
X-Gm-Gg: Acq92OEh/G+ZoWptcrF9jrmh7hEusWFX7r78CnMJCSVa+mwHxAJTdRUKsui4c/joDfM
 4NihcOVt9aXJeFVeVJHK6o4yAlrKxZUPXmppSBP34ZW9k7j2FyEgHjzhGyMUldnmDvxdwVV/Enp
 25uNT0tYUrjU7k+ZzUbg01jSFtjO8onADqoeF3BC36ZI+2o/4dEhhpUF7aQgoccM8AiXAiXJrZP
 RQsHQse9eN/wvXVG89fiBbZuEuU+L2XullW4/YuSRyDAPtQBdbFXNaz9s+tW4RHh1vtOC98rr/s
 ZAVeFaBRo4JJk37QClxx51i5ybg2Qv6kCw3JXm68DfNj0BNGxMqSO3vWLP7ROwKPOeZ//vYbEID
 P3XkG7DHz1TXevqh/96r6K14EpoGx+LLi0Nb+4U7COctl1qwahQa+9OaUMq3iucXwCJXs2XVp48
 ozEcb6kY8mTDIdZJ1vF6Pr7/hDwAESfPyx2h3beEa9Ik1K1AqYsi6krT0iMre0zcyzQ0+pY7oY6
 UqoSh0=
X-Received: by 2002:a05:6000:2883:b0:45e:742c:f195 with SMTP id
 ffacd0b85a97d-45ea38c0decmr2776799f8f.12.1779349499721; 
 Thu, 21 May 2026 00:44:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:e038:7e8a:7467:8c6c?
 ([2a01:e0a:106d:1080:e038:7e8a:7467:8c6c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa92de72sm670351f8f.21.2026.05.21.00.44.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 00:44:59 -0700 (PDT)
Message-ID: <efede04f-b2e2-4fba-8247-f92eafa2b381@linaro.org>
Date: Thu, 21 May 2026 09:44:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/msm/dsi: support DSC configurations with
 slice_per_pkt > 1
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Alexander Koskovich <akoskovich@pm.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20260318-dsi-dsc-slice-per-pkt-v1-0-1bd66b7f9e0c@pm.me>
 <20260318-dsi-dsc-slice-per-pkt-v1-2-1bd66b7f9e0c@pm.me>
 <w74ctaczp3ty7wil2sfkztc6wvuppgpyff4tw4dze34irvfmlx@e5f36rzqmp6i>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <w74ctaczp3ty7wil2sfkztc6wvuppgpyff4tw4dze34irvfmlx@e5f36rzqmp6i>
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

On 3/18/26 10:39, Dmitry Baryshkov wrote:
> On Wed, Mar 18, 2026 at 07:33:03AM +0000, Alexander Koskovich wrote:
>> Some panels support multiple slice to be sent in a single DSC packet and
>> this feature is a must for specific panels, such as the JDI LPM026M648C.
>>
>> Use the MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT flag to derive slice_per_pkt
>> from slice_count, note that most panels are expected to just work with
>> just one slice per packet.
>>
>> This change was originally authored by Jonathan Marek:
>> https://lore.kernel.org/all/20231114174218.19765-3-jonathan@marek.ca
> 
> This is a wrong way to give attribution. Either please retain the author
> and Jonathan's SoB or use Co-developed-by and still Jonathan's SoB.

Please retain `Signed-off-by: Jonathan Marek <jonathan@marek.ca>` since the only
major difference with the original patch is moving the drm_mipi_dsi.h change to
another patch.

> 
> The patch looks good to me.
> 
>>
>> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
>> ---
>>   drivers/gpu/drm/msm/dsi/dsi_host.c | 25 ++++++++++---------------
>>   1 file changed, 10 insertions(+), 15 deletions(-)
>>
> 

