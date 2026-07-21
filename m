Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDA6C44532
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BED4910E351;
	Tue, 21 Jul 2026 15:26:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JSvhOC94";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9C8010E351
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 15:26:46 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49548aebcd8so28988545e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 08:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784647605; x=1785252405; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uod+u13E2CSgW1Iws1ifKq+dmZzv5+nPVOhwR0/qtSo=;
 b=JSvhOC94ys4e4UpCoi6rZiR/XQ6wFdLGh27eGZC54lWPELJydtwskxPaNQCk7H3+Wj
 wvkHFtwdFDL2HQDxGhRI1rxD5AR7NJhHyX1HEPHxrubbfvIK2ffM+Kze1EMeWoxOrkxI
 yTyONExx32R4qiRwLRJ7wUwrnq14GTNzPDfW090eYw+zppPrrFGpPEzwi2t/CUg4i9c4
 ThuXC1Cb/Ymvv09vg9+lO4b6RPWyvYE2HqyxghEELToPlObpWtRC6G5muySdoNz8tv5D
 2TRCvNHrHfINTbtVe7JCQNekwwY4tRwmfy0QTlSInzjLBwGpgk6Kl9Zc1jQAFO3hC+/j
 PauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784647605; x=1785252405;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uod+u13E2CSgW1Iws1ifKq+dmZzv5+nPVOhwR0/qtSo=;
 b=lW0mbHo2Dgx1pLtfP+GCW2TEs30rpX2N6AUgEUumJQyF9dH51r1p2w/wprLNojMR4o
 DM3PHE8bV9X9QqgQUgGIM6Zy7+CvEUVhi3p8QMMkSQkKenS/IXtVTr0ng7OqQLNkmk8E
 xEUxUXSZHPut+xs3ifcxcRbu5n23IlHQa7fqpMwW9s6s84WVsj+36S2GDAzoPZWDDrC1
 Mt9vN1bRM0n2w7hUFTwYDVi6/Wc8lL8DZACy1in2pF81+S/eC2210Ftu8I7Cfs3dc6Gy
 bzuoqLwjnU27ojjvLJ8mWIEYo8y6SkQr5N72xRRRef23WhGbmAdjMM72NlJ+XvDNZWDQ
 ApxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRQZno407vB97zA+7EVCL3pnzDbHhmmpG9dPPXO4T0p8kfVdg6a9dEYTF9ei95STGQYswmJSAEMks=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzrNcsowSd4d3UwQIvYEBBhv1U0OqfvCfjmx96OlcNyVyMbfa5l
 ng8lJCfz1UwnEW8zhOa5dWWU7sE9AUfyFrL8u0SlY9PqmusPwX0DluoaBS0dKuDVTVE=
X-Gm-Gg: AfdE7cmye7C40V9kcpVBYAzEE0LC67MnSLr8P31XPbVz0n72Fo4vQOjHrWeqNn6kfvi
 LieTX92TUV/PJzMuKWBW7aeLAr66GP8v0sLYht2jeVi+3zACqZVoZDFplpf78zS+2Cr8d/geDh5
 e2oDfIVt4Nq2Qbt1yVl3e+wKon9CBbpFAZ/bJPsjpNWDfiVxiK0wSAXHNn6GRTOfE8eVyK+z2Lt
 a3v/RRizDKT0bM0qkQFWc68huYOq2hNSlIf3Fge3LhDx0Lv0Z9wLTgnPbZkbXY9qyo6G1GUiY6S
 x3fQ0QkW8ULkjU6ZUh2VZceI0B5Z24NedagllMwVdNXtLtj5N9ECv6ciPKiK1kXgyqBs7tSUeiR
 qcIZfpHGCtft1wIKIW4K3/BTMHKl4TQtb7/CnQg8Snq2AkSBnDB/8TMt8XO2qOgpqyE3GKqFtYp
 Xs0yBowGTzMegjgBdFMCJSX+8UnxKphoyfT2cQwzXuW3TJfGyapjsT8YQ=
X-Received: by 2002:a05:600c:4fc3:b0:495:4a22:d684 with SMTP id
 5b1f17b1804b1-4954a3db781mr202649435e9.10.1784647605152; 
 Tue, 21 Jul 2026 08:26:45 -0700 (PDT)
Received: from ?IPV6:2001:861:c12:13d0:dcef:c045:96d5:c1b3?
 ([2001:861:c12:13d0:dcef:c045:96d5:c1b3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49563969482sm191060655e9.3.2026.07.21.08.26.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 08:26:44 -0700 (PDT)
Message-ID: <bb1c5003-3a19-40ae-8d71-1c28c1223e2e@linaro.org>
Date: Tue, 21 Jul 2026 17:26:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1] drm/panel: simple: Add Kyocera tcg070wvlq panel
To: Heiko Schocher <hs@nabladev.com>, linux-kernel@vger.kernel.org
Cc: David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
References: <20260721041935.757240-1-hs@nabladev.com>
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
In-Reply-To: <20260721041935.757240-1-hs@nabladev.com>
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

On 7/21/26 06:19, Heiko Schocher wrote:
> Commit 922fb2db0287 ("dt-bindings: display: simple: Add Kyocera
> tcg070wvlq panel") added the compatible string for the Kyocera
> tcg070wvlq panel to the devicetree bindings documentation
> (panel-simple.yaml), but the corresponding entry was not added
> to the panel-simple driver.
> 
> Add the missing compatible entry to the driver.
> 
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
> ---
> 
>   drivers/gpu/drm/panel/panel-simple.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index c09bf3db5e78..caef94e5f384 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -5909,6 +5909,9 @@ static const struct of_device_id platform_of_match[] = {
>   	}, {
>   		.compatible = "koe,tx31d200vm0baa",
>   		.data = &koe_tx31d200vm0baa,
> +	}, {
> +		.compatible = "kyo,tcg070wvlq",
> +		.data = &lg_lb070wv8,
>   	}, {
>   		.compatible = "kyo,tcg121xglp",
>   		.data = &kyo_tcg121xglp,
> ---
> base-commit: b95f03f04d475aa6719d15a636ddf32222d55657
> branch: abb-display-v1
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
