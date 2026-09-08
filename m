Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F93C79FA1
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 12:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72B9810EB92;
	Tue,  8 Sep 2026 12:11:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wZUnzVNO";
	dkim-atps=neutral
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9934410EB92
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 12:11:28 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-6a668cacdadso6466534a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 05:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788869487; x=1789474287; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b2P1SkFoYcs0vGhaQZ4l8dD/Ypai6Sg+yoqkptSpF1w=;
 b=wZUnzVNOqF1FZUl7/5wKk6KKBGeryTeU5Vu39DLF3FyJsY8XOftZUNSMhAngpGNsmu
 bxRgPoJw96hAVxsYqFeHrbUqNckY71FiuqxgFZLftzL+dTNK80kMC1H6kddPo7HJ+3YG
 f4xpf0n5UHZyiZlx/gatd13DWeY7WHMd5Kp+quYfWpwg4MTEJgjwIlR/+JvVoWgQJzea
 m6Kp4EOY/1VbDjh2AuLMU9nSKHDRnswzGyTb2WzKgv4eJcrkVn7A9+qf/sX4GkSvUd0/
 b+s0TRhVFnNmOu2omz7Ly+pNf94XcHwhjZty0Vf3diQuP2R5NBP8os14zgrlf7igcx0E
 1btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788869487; x=1789474287;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=b2P1SkFoYcs0vGhaQZ4l8dD/Ypai6Sg+yoqkptSpF1w=;
 b=RmvsWelzb19u7+dq3vA5GrMCr4hZXpKi1sw7CMJjfDBo3jb9t4eTCoyGsMuYBmVA6o
 1S0N/Anr3+luxBOjQ7UfLZvimUeoJhU+SIJAp+PXQvHoQg/olgUW0jf3u+Skz7H8h5hM
 QrUOYfAHbjM4lcCQWA9bBJA0FDjwFaOcz1c4pPFf1TQacWF5USh2+JDk3BO0Ywb3vAeQ
 yCoMJa71aQHhgxaCULpDlRIcorV/K2E43p6L81CcmyJtX5YIH8fAs8NhQsS5ZDwd1edW
 IPwaTRuaTf83rnUb6M1aLBhJx8tb5JLWyz4GN4/Vgp/Jbbj63zVGnfNGIk+/zYiaZoef
 Kajg==
X-Gm-Message-State: AFuF++lbAr6bLR1fVwsgQgUaTUWOeCINDjlsCRvkPqdiwzFjsuXAIy/I
 3FI9iJBFJYaQoaqD5OyVvRaaeAkHxKdVCFEMr7fGUMPUyV6tLTOnwwKNWe63n9T8LaQ=
X-Gm-Gg: AYBFou0inrazz3He+tGVeZ6SLc+R03mzgcpBQBmETBCIekGkepGQRjtLDi5I9PuBKJI
 dwuXsRADqSu/vN8j/0YFWpXS/J/Jz442ygoZmWUXGznoz3K4L7i+nVbotlSX2AH1dRDNdsJmkdW
 9lzIZFgaIhYGqbNXKg4yBZnXbwrXjcBTaF7gFV2/kOEUnCFO1D2Ce2DK/kGZcbLLaoVNJeCtFGR
 GbMQSHgy7owUYN9VInPXxGjRTGRd4HiqQvK8xfdqbogsPErn80zaSTFuXbNV17JC0gLqMwI5J1z
 fxti9UmZJrDeojGbFIpuuP4r0tpnloYdkzvRvds72uVE/dh8eIyHPToSLWS+3qtmFP0XTcce58u
 +aPaUOGzi1JFDByHwQUXutjpVzpI3NComh+THUAE9AG1g6phfOv/ddXpj+q1v7AWKlsvXsjCkoQ
 a5OZl7RxqRkP2EbtCKVLL6iC33X3gPJ27SiIdVfi9B8yunXdUkIQSTDdRuSihLVi1zN2uf8lIXr
 rdQr2DyVSYh0PsUtUfm/KhqKToLH88LOY/DovKyK3g=
X-Received: by 2002:a17:907:7243:b0:c26:1649:47b4 with SMTP id
 a640c23a62f3a-c2616495644mr949929266b.42.1788869486673; 
 Tue, 08 Sep 2026 05:11:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:ea45:883b:8b89:b4e5?
 ([2a01:e0a:106d:1080:ea45:883b:8b89:b4e5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d5cdf7asm631013466b.58.2026.09.08.05.11.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 05:11:26 -0700 (PDT)
Message-ID: <61a734b9-6cd3-44e5-a8d4-76e139d0b768@linaro.org>
Date: Tue, 8 Sep 2026 14:11:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/3] drm/panel: ebbg-ft8719: Fix the MODULE_LICENSE()
 string
To: david@ixit.cz, Joel Selvaraj <jo@jsfamily.in>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>, Marco Mattiolo <marco.mattiolo@hotmail.it>,
 Linus Walleij <linusw@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20260906-ebbg-ft8719-fixups-v1-0-4e846510cad1@ixit.cz>
 <20260906-ebbg-ft8719-fixups-v1-2-4e846510cad1@ixit.cz>
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
In-Reply-To: <20260906-ebbg-ft8719-fixups-v1-2-4e846510cad1@ixit.cz>
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

On 9/6/26 15:19, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Replace the bogus "GPL v2" with "GPL" as MODULE_LICNSE() string. The
> value does not declare the module's exact license, but only lets the
> module loader test whether the module is Free Software or not.
> 
> See commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL" vs.
> "GPL v2" bogosity") in the details of the issue. The fix is to use
> "GPL" for all modules under any variant of the GPL.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/gpu/drm/panel/panel-ebbg-ft8719.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
> index 1ab09c50a6306..14982263a94f1 100644
> --- a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
> +++ b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
> @@ -241,9 +241,9 @@ static struct mipi_dsi_driver ebbg_ft8719_driver = {
>   		.name = "panel-ebbg-ft8719",
>   		.of_match_table = ebbg_ft8719_of_match,
>   	},
>   };
>   module_mipi_dsi_driver(ebbg_ft8719_driver);
>   
>   MODULE_AUTHOR("Joel Selvaraj <jo@jsfamily.in>");
>   MODULE_DESCRIPTION("DRM driver for EBBG FT8719 video dsi panel");
> -MODULE_LICENSE("GPL v2");
> +MODULE_LICENSE("GPL");
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
