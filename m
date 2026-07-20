Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF80C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3047710E927;
	Mon, 20 Jul 2026 13:11:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jdBuKsly";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2113A10E927
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 13:11:16 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso20280405e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784553074; x=1785157874; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rV+LNIyGmfFfld3C1G4vTQmnT9Gt4YURlSasWtdKilk=;
 b=jdBuKslyEUDfTv+GMZzAzg9bhSOPwMlWHowXwKgzp4/PLa1TS0YcBrSh5o5YwUpRzV
 E62rafyqxobZUX1+0wWF4D78QGeYM2xCXt/d7CIKN8jA1NoTuHYkGUA1ifSipomEhYh0
 EUqJvLUVEP44AZ0fJjUDFmSOqDhf1VXn8bwZxmVWN49l7ERV1tj5pqlxwzpqPnPSLBC+
 H/O/Qt2vImauYf5XzlGOQ/nHK9NnqVVjLlZtt0l7rwNacaMEHhtBRQBVpn4qVmr200VS
 pL+Tp4mHLdDyvYVKvsSrBB0LiUC4myXBz7xdlh9M/auO7yC73QJIAQH3W4ym0zUV8JMx
 WvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784553074; x=1785157874;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rV+LNIyGmfFfld3C1G4vTQmnT9Gt4YURlSasWtdKilk=;
 b=j/UiWWvMj4+kVSvxWdo32EeU8gMYGYSoaWG6eimVguNXETgLzLfTWgF7G3SbLWOp3V
 nwKuiCHvP2AsKyh4UnOMwOZ0fMUp5Ap02jHpHElwHIT2zLaXdwFzq0plKChkJJrBatQ+
 G7Suam+Gr4f0e4czpAExZRiagWxFXVOoVaVRjEm128eX40PL7G4K7OGPeww9x0IJrOMy
 RU5eI3ZWU+Fm8J0yn3s2gaVUCViA155jNh5fYa/vFttdggc6z12EIteglQtBBidxb1lh
 gq1CltFjHVPIXZaBfNP+1AUg5GyD7qUUrSPjl3TpMsd1ZbsKH+hIN686m6cnu5DAFKb/
 JtvA==
X-Forwarded-Encrypted: i=1;
 AHgh+RofSh79OL4BeFl0VKHUDOir1vHX//tkNjF6fRZcCwb+tPeUB04cGcQfrlvxCw35wgPHsVoybtShVhc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YybTcc6DqO6WCyF9V9A/ks0DhNIeICyfv0ZdKPt3MnZJ1SfcVEU
 6zlBaQnvagfXAkdR7MypfX5/kRwRYcPfM9u7VdEj5ubUZcyDJHFUZ9tuZdhSI4u2BRE=
X-Gm-Gg: AfdE7ckT+vk95QzsKOJVuy4pp2nw09xZtL1uBdP61g5DZya8rdKBrBMVfTWMIhI3yGO
 5j0NWOPmDws7hdg35D1GQCC/RXNzyakcNJdn0ErjvG/TqBTE6iW5bmPWbTYkOLqI+OJKddFmY06
 hwdzBwb/Lyxnc0cy2oxN8dhxP29BmnzjAEAVgE2ZuJ1aVjDMQeZeHR8WD5DpgZB2aEDPBpNeGWP
 KKIYd1zF4uPWAfWsGYHyUmn7cZ1PKt8i+S18VK6iRTmxneXHIAkUkbNKLMMIrSt9fUrxmJiH49k
 KA7HUw7W6rc6958RuUWQe5f/88H00sr6ucQDpPt/LHAyn+wIVZO3QuUjw4J2N/8wiVOgpjrC3MV
 JwJIZdcvCt2R2e9p7JqFLDVg5Z2mcl3DQc5yCEmMqZtM1s7FJBGmK1puqlXMmjijwOcTJto3d/Q
 iVbBrmf+kFeqiQt1S80cICkyWkidXKS8pywfGKSQgi9Jix6HW7DPaREM3//8cXUEGaPrLt
X-Received: by 2002:a05:600c:a0a:b0:493:ee2b:c876 with SMTP id
 5b1f17b1804b1-4954a41302fmr152466995e9.35.1784553074304; 
 Mon, 20 Jul 2026 06:11:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:544a:2852:f257:ebc5?
 ([2a01:e0a:106d:1080:544a:2852:f257:ebc5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549a3e2a9sm278436215e9.4.2026.07.20.06.11.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 06:11:13 -0700 (PDT)
Message-ID: <27e0e8d1-2e53-4378-877f-4172e131f7fd@linaro.org>
Date: Mon, 20 Jul 2026 15:11:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 5/5] drm: panel: jd9365da: Add DCLTek 300250 9.35in display
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
 <20260708213500.1867092-6-marc-olivier.champagne@savoirfairelinux.com>
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
In-Reply-To: <20260708213500.1867092-6-marc-olivier.champagne@savoirfairelinux.com>
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

On 7/8/26 23:35, Marc-Olivier Champagne wrote:
> The DCLTek dt300250 is a LCD panel using the jd9365da controller.
> Add the panel to the driver.
> 
> Suggested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Signed-off-by: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
> ---
>   .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 246 ++++++++++++++++++
>   1 file changed, 246 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> index a79dc8f8d5af..970c64d6054d 100644
> --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> @@ -2931,6 +2931,248 @@ static const struct jadard_panel_desc waveshare_10_1_inch_b_desc = {
>   		MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
>   };
>   
> +static int dcltek_dt300250_init_cmds(struct jadard *jadard)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x00);
> +	jadard_enable_standard_cmds(&dsi_ctx);
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x2B);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x2B);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0C, 0x74);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xCF);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1A, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1B, 0xCF);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1C, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0xFE);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x09);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3A, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3C, 0x5C);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3D, 0xFF);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3E, 0xFF);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3F, 0x7F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0xC8);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x66);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x0F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x28);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x8D);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x0A);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5A, 0x29);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5B, 0x1A);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5D, 0x7F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5E, 0x65);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5F, 0x53);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x45);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x3E);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x30);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x33);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x3B);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x3C);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x3F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x5D);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6A, 0x4D);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6B, 0x3D);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6C, 0x37);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6D, 0x28);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6E, 0x15);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6F, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x7F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x65);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x53);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x45);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x3E);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x30);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x33);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x3B);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x3C);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7A, 0x3F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7B, 0x5D);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7C, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7D, 0x4D);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7E, 0x3D);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7F, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x28);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x15);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x00);
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x41);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x4B);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x5C);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x5A);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0A, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0B, 0x47);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0C, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0D, 0x4F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0E, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0F, 0x45);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x11, 0x4D);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x12, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x13, 0x5E);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x14, 0x51);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x4A);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1A, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1B, 0x5B);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1C, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1D, 0x48);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1E, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1F, 0x59);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x46);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x23, 0x4E);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x25, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x26, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x27, 0x4C);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x5E);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2A, 0x50);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2B, 0x5F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2C, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2D, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2E, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2F, 0x0C);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x30, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x31, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x32, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x33, 0x0E);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x34, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x19);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3A, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3B, 0x1B);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3C, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3D, 0x0A);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3E, 0x1E);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3F, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x11);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x0D);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x46, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x47, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x48, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x49, 0x0F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4A, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4B, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4C, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4D, 0x1A);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4E, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4F, 0x09);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x50, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x51, 0x1C);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x52, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x53, 0x0B);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x54, 0x1E);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x1F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5B, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5C, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5D, 0x70);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5E, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5F, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x70);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x4A);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x56);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x4F);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0xF7);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6A, 0x4A);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6B, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6C, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6D, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6E, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6F, 0x88);
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x0E);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0xB3);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x60);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x4A);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x58);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x0F);
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x34);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x76);
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x00);
> +
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +
> +	mipi_dsi_msleep(&dsi_ctx, 20);
> +
> +	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static const struct jadard_panel_desc dcltek_dt300250_desc = {
> +	.mode_4ln = &(const struct drm_display_mode) {
> +		.clock		= (600 + 48 + 32 + 80) * (1600 + 18 + 6 + 23) * 60 / 1000,
> +
> +		.hdisplay	= 600,
> +		.hsync_start	= 600 + 48,
> +		.hsync_end	= 600 + 48 + 32,
> +		.htotal		= 600 + 48 + 32 + 80,
> +
> +		.vdisplay	= 1600,
> +		.vsync_start	= 1600 + 18,
> +		.vsync_end	= 1600 + 18 + 6,
> +		.vtotal		= 1600 + 18 + 6 + 23,
> +
> +		.width_mm	= 83,
> +		.height_mm	= 221,
> +		.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +	},
> +	.lanes = 4,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.init = dcltek_dt300250_init_cmds,
> +};
> +
>   static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
>   {
>   	struct device *dev = &dsi->dev;
> @@ -3039,6 +3281,10 @@ static const struct of_device_id jadard_of_match[] = {
>   		.compatible = "chongzhou,cz101b4001",
>   		.data = &cz101b4001_desc
>   	},
> +	{
> +		.compatible = "dcltek,dt300250",
> +		.data = &dcltek_dt300250_desc
> +	},
>   	{
>   		.compatible = "kingdisplay,kd101ne3-40ti",
>   		.data = &kingdisplay_kd101ne3_40ti_desc

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
