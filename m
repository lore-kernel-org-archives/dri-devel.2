Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90C7606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=J9IZupV7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50E2310E287;
	Tue,  3 Nov 2026 08:53:48 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29C4410E287
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 08:53:42 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so5370745e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 00:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793696020; x=1794300820; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cYVEhmFXBYWgKUnLGpmzVsxJ6ulxA2Owk59YswCIlXg=;
 b=J9IZupV7a9pL/2C+6KiJzLTQMx5QToR136vhoexmaXIu5WKT1KXASdD5DrmFHGdnvU
 tSkx6NijpqAv+InyelllKjXZ/T+6szSqOUFx0+kEaWc/yOIGfRotKC56iz1yVO6YeKmE
 44nuqI6aFw+rmYkW7Mce4ZvZO2rUmGOdzWAZJ2s/dHgLzYjCYyyiME2ySUjy154z3mIb
 ypVN7XwpHMtvBdv/N4rL7P2qzZyfsq9bY0gCLrvBBrmnF/pVjnNCue0WX+cUObDmP1h3
 M7wgRhlrXLsJdnPEKvNW0Zd6EAg6rP5/CKEAB+W+26wk2Qarnixq4WJzM4qB20ka7G1J
 9BQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793696020; x=1794300820;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cYVEhmFXBYWgKUnLGpmzVsxJ6ulxA2Owk59YswCIlXg=;
 b=gcjYuuxiIvnmvYmVOYlcLZawjA6SbI9RKM582cBtfQlAS1z62VNnBmfpPKcmsG5bjS
 7W1Tq+J6xjkqwfPPxrYNRL8UfhILsSqkeTEB2yUX6yVYrgX4v5P0pdu8FTFmqczPcEFv
 0M5B56YU9vs72vV8xRzfU6yVSgzPic8qc7E9TUeUCIKAamyfc/2xn4PDskb9oocplGvX
 ZruqvpCbwD442/p4MZVt4UQkcdua64HPMjBMpZstKznhxKyTcCAj/IsqVWVfWdqCr4o5
 bMkI31kSrB3JGacv4dz455/x6WkCvCpT2q4gNyq1Gb1xDz5i1dj7YmioJu2jL/qxsM/8
 Z5Ew==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5RrVh+Ta/n3CGUoERF0UB5YcE97lZ9EPkiijZTp7WNAz5vGow0Um7CBQhD9Fst9Ok0OM6NZZWCRw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/nXaE5kN2aby9ZMABP3LmpioDgSVDJ4gEO97Otv9Tpj9JpZGTM
 1G0rkpzC9vb2T+W+sNTEi3CHm+2B5HTmQGM2coPj7cDdHPWGX++ne/wTo6vrhQytraM=
X-Gm-Gg: AYBFou0F0oXWbAPPgAD40GZCUVB44BHsRPd53k3gPQlBMYE8X00aK6XUGxncOH0ETe4
 l/A+GPZbo+Qvp66yq3zJJZPVUnC9O/oBjQHftqtoYMOt2SFRlKVQEXTPUJ3xreQVUYDUC+eZbLk
 IId1cM3hF7K5alh9r1D/dICFxbVdDDCzyArmo3cETIijsUeMwarh5fuSXiBQUVjOWHn8T4snGfN
 cqEIJkdkUuynHrfcA9CA1+G5n6HQamxtLlQCSq5wcLNLfwbrFNVnXEgnATvx2f4neGZbn+im9a8
 aSBxil8qVo5L7+YqUsNUc0uiW/BQ6EfJDpBzf1jx6KcnT981DM04yosnuQVsrxAZQZW22sXgitT
 o4u3wDJPGDLaNkKlUfnRRVnO0CTc9siqzEhBFY2OL+/9cP7rMaLrgrzTYnBTQPGc/iSUdY3rIah
 s3s8tq7s5tqWgrsi103mzq/eKVtrhhTyWSBrxHtIhb2jxHzDE/2rvabxS568X1QB4m3cuUbmR0U
 IfeOb9LPLnlJW3ZhRagzdVBbA1ry4b7oTiDNH2WvqzCshySiOlQr58sa0SGCf6NADlFM5lKzfgN
 OBPByr8UwaLaAbZqJYBg5FNNDf7GwVazifvRL5y287reAw+ID7FEA1cnXQfODjnRYWFO8B5VWj9
 1NWU1K0iugOI+eC1h5V0mnkZeYMnw
X-Received: by 2002:a05:600c:2541:b0:4a5:9224:fa10 with SMTP id
 5b1f17b1804b1-4aa8b060adcmr301144395e9.18.1793696020400; 
 Tue, 03 Nov 2026 00:53:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:95a2:4869:9f46:45f0?
 ([2a01:e0a:106d:1080:95a2:4869:9f46:45f0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b728ddsm23606102f8f.9.2026.11.03.00.53.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 00:53:40 -0800 (PST)
Message-ID: <2fdcea84-8b95-4ec1-af62-07e1803cb418@linaro.org>
Date: Tue, 3 Nov 2026 09:53:39 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH re-send] drm/meson: add support for higher bandwidth HDMI
 DTDs
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de
References: <20261102212843.1213021-1-martin.blumenstingl@googlemail.com>
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
In-Reply-To: <20261102212843.1213021-1-martin.blumenstingl@googlemail.com>
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 22:28, Martin Blumenstingl wrote:
> There's a report from a user with a DELL U3415W monitor and a Khadas
> VIM3 stating that 3440x1440@50Hz works but 3440x1440@60Hz doesn't.
> edid-decode Detailed Timing Descriptor (DTD) extract of that mode:
>    DTD 1:  3440x1440   59.972616 Hz  43:18    88.819 kHz    319.750000 MHz
>                 Hfront   80 Hsync  32 Hback   48 Hpol P
>                 Vfront   28 Vsync  10 Vback    3 Vpol N
> 
> Those high clock rates are currently not supported by the meson_vclk
> code as it limits the PLL OD (output divider) to a minimum of 2. The
> formula to calculate the clock internally is (ignoring fractional
> dividers):
>    319.750MHz * 10 * od = 24MHz * m
> 
> With od = 2 this results in m = 266, which is outside the supported
> range of the PLL on G12A SoCs (the driver limits m to 106..247).
> Using od = 2 results in m = 133, which is supported.
> 
> Allow the driver to pick OD = 1 to gain support for modes such as
> 3440x1440@60Hz.
> 
> Link: https://forum.khadas.com/t/can-not-set-display-resolution-to-3440x1440-for-dell-monitor/26271/12
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> Re-send of [0] which seems to have slipped through.
> 
> 
> [0] https://lore.kernel.org/linux-amlogic/20260109204836.790096-1-martin.blumenstingl@googlemail.com/
> 
> 
>   drivers/gpu/drm/meson/meson_vclk.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
> index dfe0c28a0f05..c0be0b7655bf 100644
> --- a/drivers/gpu/drm/meson/meson_vclk.c
> +++ b/drivers/gpu/drm/meson/meson_vclk.c
> @@ -700,8 +700,8 @@ static bool meson_hdmi_pll_find_params(struct meson_drm *priv,
>   				       unsigned int *frac,
>   				       unsigned int *od)
>   {
> -	/* Cycle from /16 to /2 */
> -	for (*od = 16 ; *od > 1 ; *od >>= 1) {
> +	/* Cycle from /16 to /1 */
> +	for (*od = 16 ; *od > 0 ; *od >>= 1) {
>   		*m = meson_hdmi_pll_get_m(priv, freq * *od);
>   		if (!*m)
>   			continue;
> @@ -750,7 +750,7 @@ static void meson_hdmi_pll_generic_set(struct meson_drm *priv,
>   		/* OD2 goes to the PHY, and needs to be *10, so keep OD3=1 */
>   		od3 = 1;
>   		if (od < 4) {
> -			od1 = 2;
> +			od1 = od;
>   			od2 = 1;
>   		} else {
>   			od2 = od / 4;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
