Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D87C44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD86E10E28C;
	Wed, 22 Jul 2026 11:46:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VeXebwCz";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A965210E28C
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 11:46:03 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso31725745e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 04:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784720762; x=1785325562; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:from:subject:reply-to
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kN32egMVj+BuZnJfxjCB7GoVmbNikRELJH1GSBpm2RA=;
 b=VeXebwCzMtBPv6887ur5vN66EDQ8XqyDRz84K94I7xHGbX2KL+h4fMm4cDmh1pO1j7
 5weIpiOV11QwLWVD4tCWxuisftSFSvaFKkQlvXwC2OL6AKCm1WD5Jg7dPYCWcLKt/Xjh
 I4+xej61zPfBlD4qUCl70v/266mCJUl7jlQEk+ll5ONfAqf4gzDpSZp4KeqVu6sZhwm5
 u0e3kL8EXtX2slKA8VFIBYpCRWH2W/lYXj+6zZm7Up4yGridjGV4f2jcxWMVfJtJbZzb
 vcIT1cCXh5Wef/RJzKGvDE3urAPrBcaUgzFyzq22eX8Y2zVL96cs6OYuA8118KBS3r+A
 LxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784720762; x=1785325562;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:from:subject:reply-to
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kN32egMVj+BuZnJfxjCB7GoVmbNikRELJH1GSBpm2RA=;
 b=r6KM+FasPcJcgx/g3ZZc2sfPEQU/zXukPUFJxRMxPnfyi1S99fgKYSGuP7G8ZxJYUp
 iHsJVBGoxzm4NnNvDEuhuYWP3fOdISbFZlRwHz8+qNtak491LAoEOIID5fZn+bajWKsD
 RQoIEp9/TDIJ91MrAnE7vBe7Hjky9GkEh5506Qm97Lb/tGUob5Ma8sWymA96bVvBZtKS
 1r0nVyapeMstjc0C7VPbE0RVuzRZAvIudJjd6uDg0kDHD79amt5pVlR1fz20Y+6JJE5p
 KMG70MS+oCXehIQi8HkLgaH2zYnB6qWH8kb5JcGP+foElPINk/j9PVEMiC3QnDPebXQz
 c0+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCyp1OUejbnSfisCp8Jckn3abQCsMtZTKMEQbP/5s1/Cxs6r/c22xa1lrJmzjiCcHv4jjE9Q9g3kc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXF33xUmD26d3sXUyTfuN0YOaq1qHZPNt8uafmG3pSFv7/Gnz9
 82PkS8+2xjI7b6xiV8o2cfKT6Q8QA2PSzTEm3tyMgdWoTVcN6fhuSBmqaw9TFcEtICQ=
X-Gm-Gg: AR+sD125lLJPizFTR/kDLjuzNYXEGZvteOXm4vypoG0NBHaMx2ZQ4/IAXGmuLsRW1jW
 K7YIN4ZX3KBqqBTg1Uk6iQ30VYHgY+MlG4YrQLQxxB1qWSM9fwdDc+XA78S0SGe5I6DHEGx1s0N
 p92iG+scXRUo2SswXGlQVwCMi/REymbYgqoGkUZY/vP0WQk3a3JSt6NrSWFH4HTgJfIq9JdSVUJ
 8tW+1DxRjPoqhi8KkZ6XU/HFBRi/lHyQ7+FutaAREP9TbdOKPSxVBZPIUAE2NYLQoZqdpPLMmn0
 KYnH4utM/3+YF6HkUQwcj58z+gv2IcZYbq2OGxr4DAAA7rhxbo2iAOjZYAsadyOgLLdlVsW7vzw
 oodX85Rwu2ik+7RTaV6JbFwHmZhOkqoQl1n+ET5xuF2ZuUEx9MpoJPTNQv9cFu7pgvoTazvcJAV
 EHil3UzhUjARWVsmf1TKwnAnlphhzI+VgIpqPCcU0ZYqNQ/dBukaA/AuwHxDEXTinKSdE7
X-Received: by 2002:a05:600c:6289:b0:495:636b:e4e9 with SMTP id
 5b1f17b1804b1-495636be6c7mr109500005e9.22.1784720761757; 
 Wed, 22 Jul 2026 04:46:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:3307:4f92:b0bb:e8cd?
 ([2a01:e0a:106d:1080:3307:4f92:b0bb:e8cd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b5e04e9sm32723985e9.2.2026.07.22.04.46.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 04:46:01 -0700 (PDT)
Message-ID: <37613fc6-6c1a-4539-93a4-21130801d2df@linaro.org>
Date: Wed, 22 Jul 2026 13:46:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm: panel: jd9365da: Enable LPM mode
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>,
 Jagan Teki <jagan@edgeble.ai>, Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jerome Oufella <jerome.oufella@savoirfairelinux.com>,
 Felix Boucher <felix.boucher@savoirfairelinux.com>,
 Quentin Lehoux <quentin.lehoux@savoirfairelinux.com>
References: <20260708213500.1867092-1-marc-olivier.champagne@savoirfairelinux.com>
 <20260708213500.1867092-2-marc-olivier.champagne@savoirfairelinux.com>
 <39c805d0-0435-4c27-980b-97a7c2850b87@linaro.org>
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
In-Reply-To: <39c805d0-0435-4c27-980b-97a7c2850b87@linaro.org>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 7/20/26 14:40, Neil Armstrong wrote:
> On 7/8/26 23:34, Marc-Olivier Champagne wrote:
>> The JD9365DA-H3 uses DSI LPM for command transmissions, make sure
>> this is configured correctly in the DSI mode flags.
>>
>> Suggested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>> Signed-off-by: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
>> ---
>>   drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
>> index f6b04de1182e..1ef0c937863a 100644
>> --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
>> +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
>> @@ -2950,7 +2950,8 @@ static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
>>       else
>>           dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
>>                     MIPI_DSI_MODE_VIDEO_BURST |
>> -                  MIPI_DSI_MODE_NO_EOT_PACKET;
>> +                  MIPI_DSI_MODE_NO_EOT_PACKET |
>> +                  MIPI_DSI_MODE_LPM;
>>       dsi->format = desc->format;
>>       dsi->lanes = desc->lanes;
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Thanks,
> Neil

This patch doesn't apply cleanly on drm-misc-next, could you rebase and post a v2 ?

Thanks,
Neil
