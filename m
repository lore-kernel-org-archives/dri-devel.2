Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9731BCA600A
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 08:24:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E795D10E04C;
	Thu,  8 Oct 2026 08:24:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OEWWJu/4";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9A3910E04C
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 08:24:11 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a02718da81so20992505e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 01:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791447850; x=1792052650; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mBycP8p7SGKiJlPKrsQosdM3WVmZLo/n5T15mL/kfEI=;
 b=OEWWJu/43y4rflL8BV5ZVOHwgpceAA5xxkF+dLLP/ljJOeGGTJTpi0UbcSXzY7KtDw
 pryoSdRwRAvs4OH6q8iga+gtK3MvkG5ukapVQ/HMTEc+usn4dkZLSQHJpirK1CtXUoFr
 dNdzv3SMTnF2kULzACZnRFuSzn+goZ6JjWiQa5cgmyjYEmdRg00XXoZfMrqNxP5iLftM
 OGZXxt1wKgra996IwPiaBbi+kVPaLxRRdIb92oYhS75sej6+gV1UzLazhyNrwfQ3GfvG
 M3Gat7Ba5+tgMpGFEaRBu+7BTmfgmDAAAbp3kH6BdmR0F4RRiROsYNtnOMyR1wFr4VIC
 4mDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791447850; x=1792052650;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mBycP8p7SGKiJlPKrsQosdM3WVmZLo/n5T15mL/kfEI=;
 b=bWHjbhT0E/MCyTCYsmlORJEfxtcJEpbZNJnfjwjYFPhmve730KoX0NGhxntMYAaLFs
 enIipxH1wZweaNG+1U7gOnSvlyCVVfc5WOMVuiL6Gd6sBKM7fynM7FMJoXBQlW8ATof8
 buolKvL8bLp4zSjAKYcA5EvYEeKZZQdAK7PAYvescRh/dI9+L6x8M+wyZgaog0L0Ldys
 HLwQtPoywB3CdakBcqIU5Q6CsAjj9/iwwA36Yxp7l0g5074a5uiOghv/rqg9U2AZuwB8
 hK4dTk93l0JS+yfcddMokZKvjXI0PAfIyuCRL8A3qPO1z3gn4PWW2MX5dbbXPUg4XvIP
 /PHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzd1UH7xK0OMJonuiDEWMbC7bLML8A3aJ+E1w7IczJYAkUkI7ISt/J56CkQ1S/WlOPcdd2xHqZZyWc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kN9/NhY2AbwiZz961HoJGzsTK/qaFyGdaHq3HFioh72Zmj9b+g
 uTKa4VdehqppNkBhDxJZCB1XlHPy8rcY5qv7B8wjVV0J1UsxYPfM5+MrSVMT6HmHowc=
X-Gm-Gg: AYBFou22pFtwT9I6/jaxKoTADGROoRFpXy7Zb2OUa46cY1KIi8rULxCxrOWAO44D7uL
 Z7TkIiDGUYbuj6a70POaI6lVVMBdaSb89K+dA/bhpOwPesZXKOjnb/MousGyGJyeBJymuuV8WUp
 oTxrdyPVv5GQCPtO6BoiUyKNRrIscZnqGAEhkIelUCl5fZayVkKlCXhCsWlJZNxBG8qRX2kFuFC
 MjZnRYRXcQAgxIkRgeohh+TdRxv/lbvnpg2SKuseqDYA11xfKx0neSVmVU6WAuPHTr6HLsr2wlZ
 RXBjgAHRzEJUKT6YBvRCAyPeQcjVc36fkiOFqCxuGI2WT7lSCJMKeg3tXSI+vrbxpec+Zrifco4
 AMIfyWWbpvdIbmDXzwpAW3di0Mv3yhjnFX49tw8hPSl0MoOLLb76vfeOvBBvJE+ZLTBu7+0mKED
 jhkgOgm2nnr1InRWJFyp6igVlZEBFPL2siClVMmH9mPwbwnPnKz586Fi27vwTdwVQwrfTgrQSCL
 6Smg8WFSOnjNOnRf0NsLGlDxfQTpGg=
X-Received: by 2002:a05:600c:8b18:b0:49c:fa21:e749 with SMTP id
 5b1f17b1804b1-4a180455775mr77142395e9.31.1791447850014; 
 Thu, 08 Oct 2026 01:24:10 -0700 (PDT)
Received: from [192.168.151.76] (90-182-211-1.rcp.o2.cz. [90.182.211.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71b786d8sm9975943f8f.0.2026.10.08.01.24.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 01:24:09 -0700 (PDT)
Message-ID: <51fec579-a74a-4bfd-8b5d-2e7308405211@linaro.org>
Date: Thu, 8 Oct 2026 10:24:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/4] drm/panel: st7703: set prepare_prev_first
To: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, =?UTF-8?Q?Guido_G=C3=BCnther?=
 <agx@sigxcpu.org>
Cc: Ondrej Jirman <megi@xff.cz>, Purism Kernel Team <kernel@puri.sm>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jerome Oufella <jerome.oufella@savoirfairelinux.com>,
 Felix Boucher <felix.boucher@savoirfairelinux.com>,
 Quentin Lehoux <quentin.lehoux@savoirfairelinux.com>
References: <20261007201859.3709656-1-marc-olivier.champagne@savoirfairelinux.com>
 <20261007201859.3709656-2-marc-olivier.champagne@savoirfairelinux.com>
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
In-Reply-To: <20261007201859.3709656-2-marc-olivier.champagne@savoirfairelinux.com>
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

On 10/7/26 22:18, Marc-Olivier Champagne wrote:
> The DSI host must be enabled for the panel to be initialized in
> prepare(). Set the prepare_prev_first flag to guarantee this.
> 
> Suggested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Signed-off-by: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
> ---
>   drivers/gpu/drm/panel/panel-sitronix-st7703.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> index 70f7282471e6..368c57591817 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> @@ -973,6 +973,8 @@ static int st7703_probe(struct mipi_dsi_device *dsi)
>   	if (ret < 0)
>   		return dev_err_probe(&dsi->dev, ret, "Failed to get orientation\n");
>   
> +	ctx->panel.prepare_prev_first = true;
> +
>   	ret = drm_panel_of_backlight(&ctx->panel);
>   	if (ret)
>   		return ret;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
