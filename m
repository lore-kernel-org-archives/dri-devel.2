Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE80606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kyUFBL7W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F00A610EE6E;
	Mon,  2 Nov 2026 13:50:44 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CB8D10EE6E
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:50:39 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so32507855e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793627438; x=1794232238; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wefc2gukvW46R1Cw0qQcSR93VGaxqDP3JbJQQHsIV+s=;
 b=kyUFBL7WHENsHl0N8lVVcMq/5M9+0hOYWfVzcBNQxKPch6Sho0JzOElt2s+mXu85II
 PwTsH1qZ1GaNjEG7sKiCfVoNlURQrCSMDgNYj6p5fqc3/Co6r8JBfCeCvSnu6+y2dLu8
 jMnWWLPyHdgF8RGW/HIupuKNNKPkFR53Hg/qipD3TTm60X0IAxatjiIN4Rl3DKAE48Fn
 BZhc+3mvUwVzFkozrjtISRFb6CT2rGXFsIV02oYvkuAkwO5mlLjhNt1DHklYTLMpYQ+s
 aooQHKZGVl6WUk6pW0qdK6mWc5Fb5hNeVV4MgdhGw4/YZVYIHi+X1ZMCZQhpqQiSF/Qj
 HNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793627438; x=1794232238;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wefc2gukvW46R1Cw0qQcSR93VGaxqDP3JbJQQHsIV+s=;
 b=RxvlPy1DmxXsPyH/kqoR2XS30Wq+nkVXm3dz4S6iFV9BJ0nwzXKUNlnI6jc/tWC3fZ
 kCVny5Rx1i/BgEkeYrqDFp+ANgvnISC0d6PEgIIxSo84fxJeXqX38O86OJSFDjKWNDaJ
 ojrPyTNe15ysfZ/8/k+W5nqFXK7mGXPFpUMic8Wa9KYy4bpkQWuAQxGQaeSDGQHgU0H/
 c83znI7X0hZ3ezcFNEAlsugiqGQJ/nY6WoYag74Ulg0H3CAtDmspWVUqv4s+kluM370+
 Z1ir5EKhD2RWPPZu0ZmDrf/tomj4YY/cnIlmihXW0NhZ/X0pwTd1nvui0GaomfysYJlJ
 QzLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxwm9H23R4Cw5iEOF5royu3EG94mnZRkVo6U23xH56aPusqYE2UZlKcWs2nUUepS6ohRPTXt4EnHA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKXU3A/O97xKx6ni4+Tqdw1xelTXv7G3Hsxo6HLhP49rY0+vMhl
 bkRWjVPQafu3zOR9poyf+YfhWkdYSsYse8DXNilOoVccGkWPdqc/ekJC20B3MZ826WM=
X-Gm-Gg: AYBFou02/sY8LMK3Lop2oFSP3ahpnhOlAWnjG7QghfHjOMinFE25RDbWrWIV1fKowOn
 Rdzn/ED57vhHtjik0r1CNujmMTqOZdsYFQt1cV+zzO9WBvOO2RCq+LT0xDHhq62SG5SX78uQmry
 RqYK697KEwXAFcXYK+Hrc/w4vPdZf2wZJkZxnckkZ8cS+yViT2Jb6GUpSCdkHpGSijBN/tA5R65
 AxONkGG/WpA1a6mWC4hOYSuyPye6tJsuO3T86aYB0ttN4TEscyXk2LYCTa4w9Lj/NC22Hl0+/vt
 x6J3w9vjMRp/6hWMqWIu0gjY6dQ5wPVwAAjk+e5iJCU3ppI6Qf5nsjKKlolRAPobbS+zvHjRI4U
 ea3CYNXHqHYfDRy0MbaB9pcgGPaHXtA+qz+gEmtnnNX1oDI7mAbd+0YVtkbpMTyM27AaRXDPvjj
 xGVmxQ3Pl++sFEB6jH8oxcyc9Hh3PkOOz5ghPvl7ESvS1opH6hyOVMNFErc7x3CxOqw0SN9en0B
 2+g8SwzVrGww98ymGAtCYnzq5omdtIX99yDqFbwLw45FlWIclO4do3NjcdBrE4qnmEbhv6ZAbb0
 jgCj6y6IuHW+6CiSeYBwUoUkVSeanoKtrTglGky/cqwtH+79igc4p5/4zIS2SQmeO+tUzfV8rZg
 Tyg+juw==
X-Received: by 2002:a05:600c:1990:b0:4a7:462c:6b9e with SMTP id
 5b1f17b1804b1-4ac1923581cmr221506345e9.32.1793627437466; 
 Mon, 02 Nov 2026 05:50:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9476:5165:3a16:262?
 ([2a01:e0a:106d:1080:9476:5165:3a16:262])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8a5a7sm21252789f8f.37.2026.11.02.05.50.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 05:50:28 -0800 (PST)
Message-ID: <422e70b0-7113-449f-a5b0-1dfe4d7c41c1@linaro.org>
Date: Mon, 2 Nov 2026 14:50:27 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: ltk050h3146w: convert mipi_dsi_attach error
 message to dev_err_probe
To: Heiko Stuebner <heiko@sntech.de>
Cc: jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 quentin.schulz@cherry.de, Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20261030115844.3661099-1-heiko@sntech.de>
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
In-Reply-To: <20261030115844.3661099-1-heiko@sntech.de>
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 10/30/26 12:58, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> The panel will happily report every defer during probe with an error
> message.
> 
> Silence that to actual errors.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>   drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
> index 0856df5a6ee2..459d8a1ceab4 100644
> --- a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
> +++ b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
> @@ -587,7 +587,7 @@ static int ltk050h3146w_probe(struct mipi_dsi_device *dsi)
>   
>   	ret = mipi_dsi_attach(dsi);
>   	if (ret < 0) {
> -		dev_err(dev, "mipi_dsi_attach failed: %d\n", ret);
> +		dev_err_probe(dev, ret, "mipi_dsi_attach failed\n");
>   		drm_panel_remove(&ctx->panel);
>   		return ret;
>   	}

Could you rebase on the lastest drm-misc-next ?

Thanks,
Neil
