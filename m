Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CED4FF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:43:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0B0410E5DC;
	Mon, 27 Apr 2026 07:43:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UdWYMB7I";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B3110E5DC
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:43:08 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso99629575e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 00:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777275787; x=1777880587; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=oRsAzItervdKnHbuWBjQcpBneMcumUm5p4D7xOs/de4=;
 b=UdWYMB7IfiTqa35LiL2n4s5aiYI2kiU5QoDEPDDDA837Hav/8dQgFKn8GVGPo3cHl4
 h9yGkSzRsHPrKCyk0wA546FbKuoDQyT/ovXgh3MbUx146UsE8OudmDx/CfWmvG7WnT77
 ackccalE4nujI3zSJcddqK0Q7vpQCdEK/iiZNUO2xvywMBpia8zulrgKrPGM432Zz5jG
 ntUa3Ohs7V9COjuuTXk+LCThZyQGTZL42ChT+BDxdydoIN8ODotpjVbDZCLPEQMw1ToQ
 6tqRdD+UFhVt14KmDWVDK48y/GFYbHk4qew/Fjw4Lwgj+6vQ2gpX+ECCMHeK7WYOcvi5
 MZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777275787; x=1777880587;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oRsAzItervdKnHbuWBjQcpBneMcumUm5p4D7xOs/de4=;
 b=jbO4zD5Vb1uz2DPEoUlyCgXgJ9wEl/LP5ATq7Mpooc2nJdLqtoBIlg3X2F3FlKahv+
 6AOcDZmb3dtj/Pq3uZwq0g14C0FTrZtqnkx1kTLsNDlhCzEys4aj0l/LGzk/zobMjjBn
 JJCTLjmfgCkd/BsXXoAMS83ah/76RVzXd74B9mPVTsdBlfU5Fint75RZsASJIKQoJtVT
 IGmyZ86GwJMAgoXDYtjl1MdGMakh/rf8xgPtqObi6JZo9/QJrzYZ+h/lVI9i1mllBUz+
 V2BISj81OK+veYMB1oiBazBZN5Fd7WGWKB5Hgccqc3xfNo8B7PnTlAtmhpRX+IJimm5U
 itSg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+3b4PNf87VK9DH0WgKpTI2SLS7f3ArIIzqWxL8IB26u6v0YeySRdlJ7L/561dGOM2QQO7hNPQfrc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6iXkI/tC0evJ8xyEMqyjbBVhok6PXL46KkhphYA2W7Ij3W/ZD
 pdZFJ6ZAL67gsy0va1P6/ipeT3mblNHfnyokIOL7ZZCHuqWwgWQw8ULasqO/wZ47XYg=
X-Gm-Gg: AeBDietgTVOUe72NoUt4UZ5BYDrjTMAccBOU/fgyFfDFgCGtpuakkvoiNmkdBH9DLxn
 EWCsa0iq9qBtp3gtZDJDdOvZR/GDtYS7CScIiIMIABuGoNUzYAYaqoW6tyqy9cZBbrHo6GZojh/
 lWgVK9YvSEfJ6Zxs6bjUdSpFIZ8hyqy1DEB+sFwyPtqAyBMv2mknL0eEFnxxb/9OTeaaLYMEWCi
 dsZaayP3WSk98HsfW4UtFbtk/QpmCj+5LwNFNan9Rs9UicXvZJzuphNKiQwxKHLkyA0S1A98zg0
 eC7dorbWEtoPqGKAJuWD83Zo24BFJYhk6CseLt1ZKf2L+0+KK9N31siQPyuXOQammDdVaAAdUWw
 vuTDwtnrk7zTJp75PrkAvbMeFhYUGRyaVSD0KJeYiCckmzSjGJ897//hURIPH+aQV2bZ9x6rbDQ
 CyKL1nBOLDrZk+2Jx4DZIXIkVm6j7ZO5Maqpm13Wl8KmhKQzKcT60qcddi9XzRWHMd7QcqtlbzZ
 rdeAX+hgssnvtrHDg==
X-Received: by 2002:a05:600c:1d05:b0:489:1baf:8c03 with SMTP id
 5b1f17b1804b1-4891baf8d2cmr428569415e9.11.1777275786796; 
 Mon, 27 Apr 2026 00:43:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:ad59:75f7:6c30:2440?
 ([2a01:e0a:106d:1080:ad59:75f7:6c30:2440])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a6124d7e7sm462203655e9.5.2026.04.27.00.43.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 00:43:06 -0700 (PDT)
Message-ID: <503bdbd2-8a88-4224-8059-23e9e5c599f7@linaro.org>
Date: Mon, 27 Apr 2026 09:43:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/panel: feiyang-fy07024di26a30d: return display-on
 error
To: Christian Van <cvan20191@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260425053948.117714-1-cvan20191@gmail.com>
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
In-Reply-To: <20260425053948.117714-1-cvan20191@gmail.com>
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

On 4/25/26 07:39, Christian Van wrote:
> mipi_dsi_dcs_set_display_on() returns an error code, but feiyang_enable()
> currently ignores it and always reports success.
> 
> Return the DCS command result so callers can observe enable failures.
> 
> Signed-off-by: Christian Van <cvan20191@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> index 4f8d6d8c0..dbdb7e3cb 100644
> --- a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> +++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> @@ -98,9 +98,7 @@ static int feiyang_enable(struct drm_panel *panel)
>   	/* T12 (video & logic signal rise + backlight rise) T12 >= 200ms */
>   	msleep(200);
>   
> -	mipi_dsi_dcs_set_display_on(ctx->dsi);
> -
> -	return 0;
> +	return mipi_dsi_dcs_set_display_on(ctx->dsi);
>   }
>   
>   static int feiyang_disable(struct drm_panel *panel)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
