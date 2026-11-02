Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C97606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=C2RSun9v
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB36510EDFC;
	Mon,  2 Nov 2026 13:01:07 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDE3210EDFC
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:01:00 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so3135622f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793624459; x=1794229259; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j29pNpi9lCEApLMieivEV71xbUHKc75TmajW4Oe43v4=;
 b=C2RSun9vzgV8Klio1ooDzfMrPcI9XrBGH4ll5yQA54erE5LJRFYQKhUKtIACsEcFeV
 r3fYQboVAIg9+TCq4BW9F8jAD1HZHPBwLisN43GPmPOs79uqaZVkYElF3bxRt74KL3Xl
 QAZzvoucKHemNaORGTg9z6rI0vc3/t0MCElJzB5zsmCXtKdv7heqc75WHIf9KUzQG2+u
 sHfnk9pWHsj97M2v4jRP4TQZwpQ1B2N2/e6Ndxpq0zxdDmk5lqXMT/E2IEECJslBbZca
 7euI30PKJic9upeF/aKwHybu1WW6YGdcvj/KWHRQeBm2VMkYB33GcYDwCtOeO7CSUS4O
 iMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793624459; x=1794229259;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j29pNpi9lCEApLMieivEV71xbUHKc75TmajW4Oe43v4=;
 b=duWIdJLNps8in7wpfBWFZw2g+EnOThwb6ERbot9oBMR1h0dKfqkaVHiaIzL2H0bFSy
 8mqio2KCqNLg/qgvC4cfk5LL4AN86RV2N2SkyywHX0fIsehBiuwiQBY3gw6LUFD4FSeU
 lgMKwU/kGIT52JXTcUeKlahiBgTPL/nDhn3BMKHwJU3g5z4nA1lL3GVVSNJ5m/0iZN2s
 tEKRwWi7mqEpts0XXGmwn+vDuUu+KZPH/PRvyJjmp8WvMWKftmq+cTFYNVLgC70Z4AUR
 1V172PYalqhvluROCpgENH7XFnm2HVxcGD0WqBd/7zMqJTxKwe2LHItIuZ8en0YWr9qA
 358w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJqiZ+JmwCHPs8A/v0bNkCIM0mEOeFTvgEcefftlbEtKP4g3LNcv5lZAfObPApCPDxseMR2IS/bE4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8EXPw6FdqzWaOEuxqn3dBghNLixvSQDhnM6BPqBK79gxckGSVd
 Q2mcXC0cjzcQ6OvXv7mouTsroxlodMDtAjwoz71ck25G5Rs2/ffW4skgczHDaTBFxEg=
X-Gm-Gg: AYBFou3XA6l4CwdB/2udqLRuodF3GXULNV80o4v1dNYgwH8agsEcShFvUGMzAvKdIfS
 YB0awncngfri+ESAdF23NS31H83ljL+RZwaknprQpjtSMiOC+R40LAKJqc3HHC0g/yynhc7faNm
 P+hDSlLZ3gctlnDhfeR9vHHy+IzyujPj/pKyDcMAyIdz0w1fQ+P82SKr9mTyMMFyY2lWg+oimJW
 xiYQwmern6V0RQ8DXpFvU49LSPosBYFt9tD9ofby6pXFq1bvr8ZgJCYBkZ/zk5PO+1cZbMQOMa3
 I1Rds0QGw2NO4brWSzSRx5yN7YvZjnmhSgI1X+GykbYcnpmAx6O2++3pPMGxYhCIQaN20kmvgVN
 3JkSeRImUcVuXX2x5MktPATz1VJAwEQ3Lc/hy9Ymu10FnvQ9FUUpAyrKZEwMsuSLiA1pk18gaAH
 +2q2645oMSOG9idSPjQRJ/zzklnSZUsBlbQKCUfDOekiPqZvCogIC0szaTnLaS5+4kdpIb+/YTT
 Vq9qZ5G8ZbxvYk5Lm5TDda7a0yH5Ega+ojsvlHrGDJKgkTuPQhlAgYYV2yPXwjbe1D2tAuJqrPF
 cvtgU+ThnIV1tER9CEmIcKDVTyjIhWdWAICkvndDL+DwcOHpYFSI3kmovHQ3Ia7OLvxjUGBoXmM
 n6bSDYyXQ2Qo/i1E1AyXDJzgmkMM=
X-Received: by 2002:a05:6000:2610:b0:48e:4561:8a17 with SMTP id
 ffacd0b85a97d-48e6e303ea6mr20567690f8f.16.1793624458807; 
 Mon, 02 Nov 2026 05:00:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9476:5165:3a16:262?
 ([2a01:e0a:106d:1080:9476:5165:3a16:262])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b789ecsm19170893f8f.29.2026.11.02.05.00.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 05:00:58 -0800 (PST)
Message-ID: <e0599f9d-c282-4b63-9e17-3a00564766dd@linaro.org>
Date: Mon, 2 Nov 2026 14:00:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/5] drm/panel: feiyang-fy07024di26a30d: Fix prepare
 error cleanup
To: Hsieh Hung-En <hungen3108@gmail.com>, dianders@chromium.org,
 jesszhan0024@gmail.com
Cc: jagan@amarulasolutions.com, osama.abdelkader@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
References: <20261102043215.990351-1-hungen3108@gmail.com>
 <20261102043215.990351-2-hungen3108@gmail.com>
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
In-Reply-To: <20261102043215.990351-2-hungen3108@gmail.com>
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

On 11/2/26 05:32, Hsieh Hung-En wrote:
> feiyang_prepare() returns without disabling previously enabled
> regulators if enabling AVDD or writing DCS commands fails. Since
> drm_panel_prepare() does not mark the panel as prepared on failure,
> drm_panel_unprepare() does not call the driver's unprepare() callback,
> leaving regulator enable counts elevated even after subsequent
> successful prepare/unprepare cycles.
> 
> Disable DVDD if enabling AVDD fails. On a DCS write failure, restore
> the reset GPIO to its unprepared state and disable both regulators,
> preserving the existing 10 ms power-off interval between AVDD and DVDD.
> 
> Fixes: 69dc678abc2b ("drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI LCD panel")
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Closes: https://lore.kernel.org/r/CAD=FV=Xm48DUT==8HuuGCSFZtLTEk-W2Q6UTfqt-MnM4nULzTw@mail.gmail.com
> Signed-off-by: Hsieh Hung-En <hungen3108@gmail.com>
> ---
> 
> Notes:
>      Power sequencing note:
>      
>      The error path retains the 10 ms AVDD-to-DVDD shutdown interval
>      used by unprepare().
>      
>      The FY07024DI26A30-D datasheet, Section 7.3 (Power, Signal sequence),
>      specifies T10 > 0 between AVDD/VGL reaching GND and DVDD starting
>      to fall. The delay allows time for AVDD to discharge before disabling
>      DVDD, but compliance with T10 has not been verified on hardware.
>      
>      The existing unprepare() comment associates the delay with T11,
>      which actually specifies the DVDD fall time (0 < T11 <= 10 ms).
>      That comment can be corrected separately.
>      
>      The msleep(10) checkpatch warning is expected. T10 has no specified
>      upper bound, so a longer sleep does not violate that timing constraint.
>      msleep() is retained to match the existing unprepare() sequence.
>      
>      Datasheet:
>      https://files.pine64.org/doc/datasheet/pine64/FY07024DI26A30-D_feiyang_LCD_panel.pdf
> 
>   .../gpu/drm/panel/panel-feiyang-fy07024di26a30d.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> index c1d8ca5ca6e1..bb4cc1ea2ece 100644
> --- a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> +++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> @@ -59,7 +59,7 @@ static int feiyang_prepare(struct drm_panel *panel)
>   
>   	ret = regulator_enable(ctx->avdd);
>   	if (ret)
> -		return ret;
> +		goto disable_dvdd;
>   
>   	/* T3 (dvdd rise + avdd start + avdd rise) T3 >= 20ms */
>   	msleep(20);
> @@ -84,10 +84,21 @@ static int feiyang_prepare(struct drm_panel *panel)
>   		ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data,
>   						FEIYANG_INIT_CMD_LEN);
>   		if (ret < 0)
> -			return ret;
> +			goto assert_reset;
>   	}
>   
>   	return 0;
> +
> +assert_reset:
> +	gpiod_set_value(ctx->reset, 0);
> +	regulator_disable(ctx->avdd);
> +
> +	/* Preserve the AVDD-to-DVDD shutdown delay from unprepare(). */
> +	msleep(10);
> +
> +disable_dvdd:
> +	regulator_disable(ctx->dvdd);
> +	return ret;
>   }
>   
>   static int feiyang_enable(struct drm_panel *panel)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
