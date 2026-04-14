Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF47F9D0CA
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 12:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 435E610E5F0;
	Tue, 14 Apr 2026 12:59:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kDELr+7A";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C4E410E5E8
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 12:59:00 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso67810445e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 05:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776171539; x=1776776339; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=3tcc5/KRd6tdNgGgUfi11zlIghGQ8xzQPBYAELyGHWs=;
 b=kDELr+7AnFNmJMwUQuu5RLaOMGhFzg/Ni/EgGOTjKnAptbFFxdOje3+Fv9QHA9FaoW
 NlDiMWqfibUXl/eYr6rKZtl20oyWF4LdYvtDlUtytnodu4CZ782qq9x5ViHpI2DhmHDS
 bXpX+ixiWM6wQ92gcP0MfQM3ZRLjggUA8CLBJLSCrPHssN5MZfW1a/2IBtXWyh1Nauwx
 NWF0IiXrmDZcTd7SvJ2Rnfdi+WoQiCiVDe+sjhPVMcLJ26LARpctwp49znkVcvJsZjxg
 jspJmik5QN204MNyYfDhMYLMw0KqqxKodxnwA+4r/85qExmCSGGFDEdGziZu0JRQAxvv
 NoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776171539; x=1776776339;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3tcc5/KRd6tdNgGgUfi11zlIghGQ8xzQPBYAELyGHWs=;
 b=GlOMdgZ5wX6ShPfEjz2HdQmKtPCCueATxnJAlt0kUqitSbr7wA+40waNT2Em+kyGCe
 nGoyTuT04XARlLHOseHwGOggO1vabEefy9e62ZRM9+AUnh3Fw4Owqd81DtmoLUs7ODwr
 LAWfq41bxSLuyEA2IzdSyoHnmQ352tUXdk0SNt5+KS8Q7Gfben7XnpzY1bXo0X5A9Blo
 VDndSy01NC98MKCW6Ky1IRPNEawWYpkdzkk9FTGFzYXcph44oDEEfxJJPWFdIt68Jh0S
 vwXjrxrNdWqiQT8iA+CTVR85qB7PMhs9bW1tiPUIDtQ+/wLW7MsFHiwdtuPudSW2fUN8
 kb5A==
X-Gm-Message-State: AOJu0YwgAauMaJj/+kwb0M8uO2bap3D6/2MKwdcZY5/VR13H7oAjKCXa
 fWpdAIEBKWkpYbMEFVoLLRIlgmg2kEZXYepQYJorX971QRDIuxWFmkkHl2RJiy6Nn6g=
X-Gm-Gg: AeBDies7BjaA3UJUSy0hsoOcBmSMHetAwnw/t9c5H/debW/QuiHwmfQsdCfoqDzUwc/
 LtT6+s2/xQaBicc8MKFsThzjGc9gq1sEuH/59MEzv5pGDquMmuuysMARjFs0K704olJjDqb59dq
 TFSCsA9+tjt08Mod4OHhdhxc7sQQq9xyWYCUni1aJUaxOPJc8uoSbQEBB+ZujOW50+Nhy72G+2b
 VKl0W7y7mL8Vk1cXs3Or9pOrYr/JMulxMRUaNhpvnBaHS6fcBoMhv1JosibiBDGR56RaegaGojR
 lpNB4dJtofja0/Mpqtf3f5J/laW+jlOMBD1BE+7JnaPKMMffeKYcHKllOBLV8fvA85/Hd11+MIp
 ZOmWSeL/sK7dka5BjOyOEujD/1Ue6p4rNi+xB9Xm5DyvER2EMgl6HnkhUELLSF8V5nRZPUvqtoM
 Gl/DjrC9UVuBHKaYMBQ2nNo6/25ns4Q19hdL+KSxHf7mnvsx8My5v5rpH8Irv82dx6eVWutVgf3
 h++WvRlm/DtXfA=
X-Received: by 2002:a05:600c:8907:b0:488:c744:49b with SMTP id
 5b1f17b1804b1-488d67d2cfcmr168168345e9.7.1776171538721; 
 Tue, 14 Apr 2026 05:58:58 -0700 (PDT)
Received: from ?IPV6:2001:861:c12:13d0:5627:3bd0:f3ee:8a22?
 ([2001:861:c12:13d0:5627:3bd0:f3ee:8a22])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488e10d69b2sm88855305e9.8.2026.04.14.05.58.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 05:58:58 -0700 (PDT)
Message-ID: <908b1360-e53d-4f33-82ce-4e2b67ddcfb7@linaro.org>
Date: Tue, 14 Apr 2026 14:58:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 15/21] drm/panel: jadard-jd9365da-h3: support Waveshare
 WXGA DSI panels
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Jie Gan <jie.gan@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Riccardo Mereu <r.mereu@arduino.cc>
References: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
 <20260413-waveshare-dsi-touch-v3-15-3aeb53022c32@oss.qualcomm.com>
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
In-Reply-To: <20260413-waveshare-dsi-touch-v3-15-3aeb53022c32@oss.qualcomm.com>
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

On 4/13/26 16:05, Dmitry Baryshkov wrote:
> Add configuration for several Waveshare 8.0" and 10.1" WXGA DSI panels
> using JD9365 controller
> 
> Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 568 +++++++++++++++++++++++
>   1 file changed, 568 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> index 61d67efed379..7744c66514c9 100644
> --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> @@ -2067,6 +2067,566 @@ static const struct jadard_panel_desc waveshare_4_0_inch_c_desc = {
>   		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
>   };
>   
> +static int waveshare_8_0_a_init(struct jadard *jadard)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x00);
> +	jadard_enable_standard_cmds(&dsi_ctx);
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x00);
> +	if (jadard->dsi->lanes == 4)
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x7e);
> +	else
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x4e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x65);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x74);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xb7);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0xb7);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0xfe);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x19);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3b, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x70);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0xff);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0xff);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0xff);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0xa0);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x1e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x0f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x28);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4b, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0xa9);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x37);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x19);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x78);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x63);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x54);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x45);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x38);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x3d);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x28);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x41);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x62);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x50);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x57);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x37);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x23);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x78);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x63);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x54);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x45);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x38);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x3d);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x28);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x41);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x43);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x62);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7c, 0x50);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x57);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7f, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x37);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x23);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x10);
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x47);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x47);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x45);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x45);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x4b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x4b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x41);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0a, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0b, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0d, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0f, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x11, 0x57);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x12, 0x77);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x13, 0x35);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x14, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x46);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x46);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x4a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0x4a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x48);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1d, 0x48);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1e, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1f, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x23, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x25, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x26, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x27, 0x57);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x77);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x35);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2a, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x10);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x30);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x6b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x0c);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x73);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x09);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x56);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x88);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x7b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0xf8);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0xd5);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x2e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x12);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7c, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x03);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x7b);
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x0e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0xb3);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x60);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x2a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x59);
> +	if (jadard->dsi->lanes != 4) {
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x58);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x0f);
> +	}
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x00);
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +	msleep(120);
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +	msleep(60);
> +
> +	return 0;
> +}
> +
> +static const struct drm_display_mode waveshare_8_0_a_mode = {
> +	.clock		= (800 + 40 + 20 + 20) * (1280 + 30 + 12 + 4) * 60 / 1000,
> +
> +	.hdisplay	= 800,
> +	.hsync_start	= 800 + 40,
> +	.hsync_end	= 800 + 40 + 20,
> +	.htotal		= 800 + 40 + 20 + 20,
> +
> +	.vdisplay	= 1280,
> +	.vsync_start	= 1280 + 30,
> +	.vsync_end	= 1280 + 30 + 12,
> +	.vtotal		= 1280 + 30 + 12 + 4,
> +
> +	.width_mm	= 107,
> +	.height_mm	= 172,
> +	.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +};
> +
> +static const struct jadard_panel_desc waveshare_8_0_inch_a_desc = {
> +	.mode_4ln = &waveshare_8_0_a_mode,
> +	.mode_2ln = &waveshare_8_0_a_mode,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.init = waveshare_8_0_a_init,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
> +		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +};
> +
> +static const struct drm_display_mode waveshare_10_1_a_mode = {
> +	.clock		= (800 + 40 + 20 + 20) * (1280 + 20 + 20 + 4) * 60 / 1000,
> +
> +	.hdisplay	= 800,
> +	.hsync_start	= 800 + 40,
> +	.hsync_end	= 800 + 40 + 20,
> +	.htotal		= 800 + 40 + 20 + 20,
> +
> +	.vdisplay	= 1280,
> +	.vsync_start	= 1280 + 20,
> +	.vsync_end	= 1280 + 20 + 20,
> +	.vtotal		= 1280 + 20 + 20 + 4,
> +
> +	.width_mm	= 135,
> +	.height_mm	= 216,
> +	.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> +};
> +
> +static int waveshare_10_1_a_init(struct jadard *jadard)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x00);
> +	jadard_enable_standard_cmds(&dsi_ctx);
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x00);
> +	if (jadard->dsi->lanes == 4)
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x3b);
> +	else {
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x38);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x10);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x38);
> +	}
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x74);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xaf);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0xaf);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x26);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x09);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x78);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0xff);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0xff);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x7f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0xa0);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x81);
> +	if (jadard->dsi->lanes == 4) {
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x14);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x23);
> +	} else {
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x1e);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x0d);
> +	}
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x28);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x69);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x2a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x7f);
> +	if (jadard->dsi->lanes == 4) {
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x6b);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x5c);
> +	} else  {
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x6a);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x5b);
> +	}
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x4f);
> +	if (jadard->dsi->lanes == 4) {
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x4d);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x3f);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x42);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x2b);
> +	} else {
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x4a);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x3d);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x41);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x2a);
> +	}
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x43);
> +	if (jadard->dsi->lanes == 4) {
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x43);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x63);
> +	} else {
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x44);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x62);
> +	}
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x52);
> +	if (jadard->dsi->lanes == 4) {
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x5a);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x4f);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x4e);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x20);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x0f);
> +	} else {
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x59);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x4c);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x48);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x3a);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x26);
> +	}
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x7f);
> +	if (jadard->dsi->lanes == 4) {
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x6b);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x5c);
> +	} else {
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x6a);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x5b);
> +	}
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x4f);
> +	if (jadard->dsi->lanes == 4) {
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x4d);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x3f);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x42);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x2b);
> +	} else {
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x4a);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x3d);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x41);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x2a);
> +	}
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x43);
> +	if (jadard->dsi->lanes == 4) {
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x43);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x63);
> +	} else {
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x44);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x62);
> +	}
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7c, 0x52);
> +	if (jadard->dsi->lanes == 4) {
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x5a);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x4f);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7f, 0x4e);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x20);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x0f);
> +	} else {
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x59);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x4c);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7f, 0x48);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x3a);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x26);
> +	}
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x00);
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x02);
> +	if (jadard->dsi->lanes == 4) {
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x02);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x02);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x00);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x00);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x1e);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x1e);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0x1f);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0x1f);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x1f);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x17);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0a, 0x17);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0b, 0x37);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x37);
> +	} else {
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x42);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x42);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x40);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x40);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x5e);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x5e);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0x5f);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0x5f);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x5f);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x57);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0a, 0x57);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0b, 0x77);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x77);
> +	}
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0d, 0x47);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x47);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0f, 0x45);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x45);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x11, 0x4b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x12, 0x4b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x13, 0x49);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x14, 0x49);
> +	if (jadard->dsi->lanes == 4) {
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x1f);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x01);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x01);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0x00);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x00);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x1e);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0x1e);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x1f);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1d, 0x1f);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1e, 0x1f);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1f, 0x17);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x17);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x37);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x37);
> +	} else {
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x5f);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x41);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x41);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0x40);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x40);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x5e);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0x5e);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x5f);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1d, 0x5f);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1e, 0x5f);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1f, 0x57);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x57);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x77);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x77);
> +	}
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x23, 0x46);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0x46);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x25, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x26, 0x44);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x27, 0x4a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x4a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x48);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2a, 0x48);
> +	if (jadard->dsi->lanes == 4)
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x1f);
> +	else
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x5f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2c, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2d, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2e, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x30, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x31, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x32, 0x1e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x33, 0x1e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x34, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x37);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x37);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3b, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x0a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x06);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x46, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x47, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x48, 0x1e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x49, 0x1e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4a, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4b, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4c, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4d, 0x37);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4e, 0x37);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4f, 0x09);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x50, 0x09);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x51, 0x0b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x52, 0x0b);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x53, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x54, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x1f);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x40);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x30);
> +	if (jadard->dsi->lanes == 4)
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0x16);
> +	else
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x34);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x05);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x6a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x73);
> +	if (jadard->dsi->lanes == 4)
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x1d);
> +	else
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x07);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x6a);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x08);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x88);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0xff);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0xdd);
> +	if (jadard->dsi->lanes == 4)
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x3f);
> +	else
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x2c);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x15);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x17);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x14);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x82);
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x04);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x0e);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0xb3);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x61);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x48);
> +	if (jadard->dsi->lanes != 4) {
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x58);
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x0f);
> +	}
> +
> +	jd9365da_switch_page(&dsi_ctx, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe6, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe7, 0x0c);
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +	msleep(120);
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +	msleep(60);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static const struct jadard_panel_desc waveshare_10_1_inch_a_desc = {
> +	.mode_4ln = &waveshare_10_1_a_mode,
> +	.mode_2ln = &waveshare_10_1_a_mode,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.init = waveshare_10_1_a_init,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
> +		MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
> +};
> +
>   static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
>   {
>   	struct device *dev = &dsi->dev;
> @@ -2198,6 +2758,14 @@ static const struct of_device_id jadard_of_match[] = {
>   		.compatible = "waveshare,4.0-dsi-touch-c",
>   		.data = &waveshare_4_0_inch_c_desc
>   	},
> +	{
> +		.compatible = "waveshare,8.0-dsi-touch-a",
> +		.data = &waveshare_8_0_inch_a_desc
> +	},
> +	{
> +		.compatible = "waveshare,10.1-dsi-touch-a",
> +		.data = &waveshare_10_1_inch_a_desc
> +	},
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, jadard_of_match);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
