Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D11606A32D
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Fm8pWGqN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06D8E10EE1B;
	Mon,  2 Nov 2026 13:21:39 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8130E10EE35
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:21:32 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so24083535e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793625691; x=1794230491; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yzb4FLFHNkxHewORAzgIXxT9puE5wh1HG/JpGad3oS4=;
 b=Fm8pWGqN2YAfGmmIiKtGtTR3v6IIqTAR1G2MAg0z8rBCNHV9GqNt/CAw+YKMFS5mMX
 DRAz0KjqSn1XBctFTsmfQGtJDyY9eyCvlURyfV06N6w7/c4Xqg0cAql2O00awlXQtQiW
 DDHNkQRRuzqcQX59sWdTVQ7KcQRkYLe5ve3zPfkdfXcsdlH9BtIb1adDttp0ht27ahCX
 cy2Hhvk/Hn5zYUDwm8P1FtijL1WUkYGT9ARiUNanfvw8KUwPkeLAbrSmcIjca4PVOivm
 fvcgO8Hg8COZuO/shYP/PK51qpjwd6Gx0D8sv12fhw43E4RUmWKRyrcYjl8GY1we+3cB
 wvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793625691; x=1794230491;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yzb4FLFHNkxHewORAzgIXxT9puE5wh1HG/JpGad3oS4=;
 b=HRCcbzZ5z8qgxQOgg1CfyfPkd2CsFZYwAbtr0WtulMyXvAn1I+egTsZ4XML3xnLLFp
 grxZwgDv0QsiNXcdHp/5lFY4HxWmudL27E0P9yGaBIcWr5ETb4PDz3uKkscOeXLr84kN
 1thNSbk5LbbkYXyQSI7TRYOzcg2UmRJ6XhHKQbzLgA3ODYnX5cESi2Zv0fOvo8cnXBIF
 aGZaB7GUIAO+ZxrON8EXS2OQuhnnfC5JFDVKh0hk7y/1KrGBQJHkdA4EmBb0mKSCtkZ8
 tQnXuiZfjCmEQzGL7owN1543rSpEB1+nObsQTkN8UvYeVEQ2Sb6MEdBmfT5670Xqye8D
 JdVA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgz9ygG2CMpSCkS7Zet+TWNw+op+cpHswnjIm5zhtC+2Kj3UZTdsEiOBew5A6gpFIPmSV0YlAV+90=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKORK6VSE3h1AJrVixPSMli9LO3hh7dG1tOfF/GKUZSJYtrzaBg
 oqMVB1eAqdogbWvn8kTlxdbSbxjXeCSAhBvG59uXRwRnwqiPCbeour3+8Id75u6F7bk6vZlo5bH
 MqzMe
X-Gm-Gg: AYBFou2GvchCVipKoKW3MqN7PbNmXTaWPj1XfjffhkZt/dKfNQ9gbgM0Vqh15kIPb4G
 FYLr5HNgAB2Bt+6y8A5GbfA9DsK3puTY3ifEBT9qjEHe2toStc2RPKFDVgk/k5uVJ4OtD21jyRs
 NCJ7DVGqm0RAv4yboFLFBSmoEzQ4GV5zBS0oYj8+aoqw/Z1LCtBXg+IJlz+Kk28f8Dsz655Np2x
 3nhxNZi4wE9uySGVj2wSQ20LywWeKysCUpSXzHTmezf9zgoTqyjXlK5WvjR/GdchAxqPFJt0Xed
 bV7jON7mj9Qweudiosf9opZR7qePDgSTlouWuiyhDKY1hpffojtrmxqDwUMFag53DLJu+ceqdHL
 AZ6H2PMMjV6d2/16Zk3xLAQkJwlMqK057lqaPk28keuZI8qUi1nq/Woexck8413p+IfNWtTcb6u
 BrLMk6TYq+Q69Z/ZqaPJwiqiGCrfRBpOePuw3MtwyRgzuM9JJvx5fSTCselcg1CrJVHxRUZFZEb
 B8Vl5id9l81EnEXJ20BpSHKVUskgzLF4bMrMr2bGM4FMvB8QnIb0BRijsi1z5pOEKU2V2SaqED4
 TVnZzCqjAtbjOQWazuz7UA30VBcgsfJF5WhswfRSDEBqFxeiadphkC5uziQIKQ6xLzLZ5mbeKmp
 IeXJ3
X-Received: by 2002:a05:600c:a00b:b0:4a2:180b:3153 with SMTP id
 5b1f17b1804b1-4ac185bcc7dmr242358135e9.14.1793625690760; 
 Mon, 02 Nov 2026 05:21:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9476:5165:3a16:262?
 ([2a01:e0a:106d:1080:9476:5165:3a16:262])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf5b286a0sm228432265e9.4.2026.11.02.05.21.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 05:21:30 -0800 (PST)
Message-ID: <484889a9-97a4-48d8-b630-27141077d0b0@linaro.org>
Date: Mon, 2 Nov 2026 14:21:29 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] drm/panel: simple: Add AUO B101UAN01 panel
To: Asif Ikbal <asif.ikbal@amd.com>
Cc: jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 thierry.reding@gmail.com, sam@ravnborg.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, git@amd.com,
 michal.simek@amd.com, naveen.gaddipati@amd.com
References: <20261016094638.2958431-1-asif.ikbal@amd.com>
 <20261016094638.2958431-3-asif.ikbal@amd.com>
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
In-Reply-To: <20261016094638.2958431-3-asif.ikbal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/16/26 11:46, Asif Ikbal wrote:
> Add support for the AU Optronics B101UAN01 1920x1200 10.1" WUXGA
> MIPI-DSI TFT LCD panel.
> 
> The mode is taken from the MIPI interface timing section of the
> B101UAN01.7 (H/W 1A) datasheet and gives a 60 Hz refresh rate.
> 
> Signed-off-by: Asif Ikbal <asif.ikbal@amd.com>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 32 ++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index a944c34642dc..46ec17b6c365 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -6389,6 +6389,35 @@ static const struct panel_desc_dsi auo_b080uan01 = {
>   	.lanes = 4,
>   };
>   
> +static const struct drm_display_mode auo_b101uan01_mode = {
> +	.clock = 148350,
> +	.hdisplay = 1920,
> +	.hsync_start = 1920 + 40,
> +	.hsync_end = 1920 + 40 + 40,
> +	.htotal = 1920 + 40 + 40 + 40,
> +	.vdisplay = 1200,
> +	.vsync_start = 1200 + 4,
> +	.vsync_end = 1200 + 4 + 4,
> +	.vtotal = 1200 + 4 + 4 + 4,
> +	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
> +};
> +
> +static const struct panel_desc_dsi auo_b101uan01 = {
> +	.desc = {
> +		.modes = &auo_b101uan01_mode,
> +		.num_modes = 1,
> +		.bpc = 8,
> +		.size = {
> +			.width = 217,
> +			.height = 136,
> +		},
> +		.connector_type = DRM_MODE_CONNECTOR_DSI,
> +	},
> +	.flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.lanes = 4,
> +};
> +
>   static const struct drm_display_mode boe_tv080wum_nl0_mode = {
>   	.clock = 160000,
>   	.hdisplay = 1200,
> @@ -6572,6 +6601,9 @@ static const struct of_device_id dsi_of_match[] = {
>   	{
>   		.compatible = "auo,b080uan01",
>   		.data = &auo_b080uan01
> +	}, {
> +		.compatible = "auo,b101uan01",
> +		.data = &auo_b101uan01
>   	}, {
>   		.compatible = "boe,tv080wum-nl0",
>   		.data = &boe_tv080wum_nl0

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
