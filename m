Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB728CA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 06:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1FF610EB7F;
	Mon,  5 Oct 2026 06:55:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TGpQxz0r";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UzQ9qoY5";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 227A110EB7F
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 06:55:39 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69510AUj787337
 for <dri-devel@lists.freedesktop.org>; Mon, 5 Oct 2026 06:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=6A1bPSiOGgsHAdpCNaSmQ9ZG
 Nam6PZMqoQGyG8bRKdU=; b=TGpQxz0rp6HR3enX/zk6Qzg7H3YJcUVk7yONfn5i
 9VpXQNRsSLY6ois4sKf3qiTyJgArTDt1bN0c+UXh3bdNjN0sgaW79pSmF0Rh0InY
 okQukS8x6fwOM2PrPkGV83yQJ+jpo0IbAzNiYBWSjnuelP1eHlzzvZq5BlZFz5Sx
 k0Av9lzRIMuV3sUJzZOxhxWOcPYlTIS88n/FGK9lyFJi0SgcVW+XqSsug2Anuvlj
 I5+5UEBf/M8pn5L4NK6NfM9jh5tNgbQMwL+ZNZdESbI9cK1UIut3kmDs2rZeeZ4l
 2um8w60T3SpV+vbFZDXbOu69WnQJOWmEgGiaj4uMPwQ7Qw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2spa4u2g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 06:55:37 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7bf3a0a498fso1291598137.0
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 23:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791183337; x=1791788137;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6A1bPSiOGgsHAdpCNaSmQ9ZGNam6PZMqoQGyG8bRKdU=;
 b=UzQ9qoY5VMjx+HHNsffQ8Mw0xqbh0iG7TtXl2WrV3yzd/50N2GtOVQKQEbfKWuYTf9
 IPUBWkkrrFWa+EsQkY79JoPXMgcnYNoWCP7lOxIt5ki6Nrcl97q1WGB6Z/dpHY3k41dy
 DiK7ldWkwVefHFQI1rfnKqv0S2mKkDW3U+jRLLYrdhhRhdEcreaofu5S41b0CrzaaB7p
 s1wdSmzSugkuvJqBkMWkkntPuZ6EgaTKr0UKrNoyOVdDsb+hkeMSlhNUEgiZsXq25gl6
 0VgvYpQlI0fCqyiNNNo5Gjy+6+G2lo++qwqF0DGydYJGQJ5QL8RN2v0BPHoIvSLKX1Gv
 VZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791183337; x=1791788137;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6A1bPSiOGgsHAdpCNaSmQ9ZGNam6PZMqoQGyG8bRKdU=;
 b=0s++N6QY2SeNI/An3iwltPDONM3Qu8J7INhszEf/UzJtCYX2Di3rLhAFHNjVWl3lRt
 CO3HGmO17za8rElpbfCX7QCBm4aORODCEUppbQIXLCP5WKE5hxQrrJxbaLmDBYgzAMRq
 3Pk2wkuSn1vbrYV+fJ7qk36qHdLaqZ2oWtvhx7N1qsucE6oc39JM8gW0ALYOy/5kZ4Ja
 mitQmAI68SxDaWCZN0wAEBJFGzdFyt+4Q3ui+7GwH0D2UrYs8c0hCp+sOTsdnCFGaIMc
 sJPedSEPNjOFBzLk/hiCzVGNn3ROLAui8gXStR1CT76z87g0FA5PICpo31fESqWGSizC
 jyEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2X/FrJaFDZmCOd8jY+tWq3Ta3v4cCx+dOuHJnt+sXe5byJGEefzNDGvWG8q0RVlCyTK9qZVKIIBQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLcgtGrfdBrRHV3FVfBd9SjQ8eo7waHXX0JOomU/NZ7jo+BRZOp
 mp1n2HjtY9jh400NsFbXyxXMv4A8JMcmmFn6Z6//nkbRYO2BryEyBF90aa6a8AJ5nwGd21BdtRu
 t65oIb3mkNeAM4DIVyeEbU2xTzLMplqXaY0L4x25TorEY9UHc4XiDliCrIGh0HXTEbfhOjC0=
X-Gm-Gg: AYBFou07ojGY4cRfbzwlRNeacwoUw+F5g8BEzXuIdym9XMq1vHhYs3IB8otB5X8dO59
 Ii1Yesx67KP6ZywQlIZ0OrdGHb7oxCEM17DayYG5xiL9IO/+ThUY1UAW4SMZeFSaessBAtlYiPr
 6M3GKjJW9Itn9izucvx8+UZwhKrqV68xqz/U+7YwUxmRQGI67QTyZguJXC+XGk1AIXrhXnUr6wo
 xsat1YnxGE/5VwGwMmQI/2MtfLGqjU8j2md++Fc/lRmjUzjJ7jbxSRQUSwEfs/BLzWHTXeEVOLU
 px9OxtvgvOPoCEI8gXbqDW3PZIMH4HVQsYnjsdePjr9jUhyenRu8ZD4wzazqt332bCxoBsm1bj/
 wTG5+/s+g9MHQKdMJafWgpdklgE1nQYytQaCJ6rLLHfugrhYUOZ1sgm1UTEri88Ixp3mFP3PnrH
 ZsGok3DO6WisgA
X-Received: by 2002:a05:6102:5120:b0:79d:a035:b6e6 with SMTP id
 ada2fe7eead31-7c0f4689e8dmr1883076137.3.1791183337111; 
 Sun, 04 Oct 2026 23:55:37 -0700 (PDT)
X-Received: by 2002:a05:6102:5120:b0:79d:a035:b6e6 with SMTP id
 ada2fe7eead31-7c0f4689e8dmr1883066137.3.1791183336654; 
 Sun, 04 Oct 2026 23:55:36 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a87e33530bsm38036081fa.42.2026.10.04.23.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 23:55:35 -0700 (PDT)
Date: Mon, 5 Oct 2026 09:55:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/4] drm/panel: Add driver for Novatek NT37705 panel
Message-ID: <xuiobdqd236poxv2lieckjg7da3cpmczdf5owwxx2fl3hynhf5@rl5mmcyzzqk6>
References: <20260918-fp6-panel-v2-0-6695c4008920@fairphone.com>
 <20260918-fp6-panel-v2-2-6695c4008920@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-fp6-panel-v2-2-6695c4008920@fairphone.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX/1KqGQBRphml
 zxiYsmjRUXELiiXvg/oJR2ZVmUgREGR1N8haU7VFKlKYHoEfPxd5c3A0VR30YcI2YMGqrM4x85Y
 8tT6Ob1GJXSyPoDu+8VBaOsfh1OiBZmCPAJneSF9q+1aCUFWtBnsW14nqTwV0Yw0zGuW/7t2HCJ
 GTC74toilqV49yU/ae9xPCtEp/U7FPTofhpEL3DlNNbt73M7fd0gjIj+OQZAv8TkJnRoJF5ozE+
 ZUGux+Pk6o+Td93wUv5wUVe/NdP2hu9Vf01s2ajzI3sqgtaBVI5bx4i0av/iA4hhItV42bumO4a
 yAY5q+lBbTXSsRmPQbckLL+hYnerSwf15ex/yGN8VRNnQ+hI6k705DbBE4TlQG4ylHsYfpFARV3
 0mmgt51eUaV2ijvLLeW+e3dmg8p4dqKamoXVhIFppb6f2i9n24SgsvRBbzDjWks0B1OSWrsJ0yI
 ukHleE0tarOQpcy18Mg==
X-Authority-Analysis: v=2.4 cv=b7MncdGx c=1 sm=1 tr=0 ts=6ac349e9 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=6H0WHjuAAAAA:8
 a=o-EclO7zvcZZgozh8CsA:9 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: s_6b2VYNHV8XfGm1AiUZB_I6eBcjTAF6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX4EAdNoVqu/QU
 m6Ah8Tp1eMy1RPkInH3J0hPkMdEHkCnBWT5o1WWxODGlZHO5EnSIIqMKW+IAEZa2JmHLk9B8UQY
 FUGOIfjPBoRDyM0BCei/fds9xU7AuJo=
X-Proofpoint-GUID: s_6b2VYNHV8XfGm1AiUZB_I6eBcjTAF6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050027
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Fri, Sep 18, 2026 at 04:40:05PM +0200, Luca Weiss wrote:
> Add support for the 2484x1116 AMOLED panel from BOE (BJ631JHM-T71-D900)
> bundled with a NT37705 driver IC, as found on the Fairphone (Gen. 6)
> smartphone.
> 
> The panel can also be configured in 10-bit (RGB101010) mode, however
> currently it's configured in 8-bit (RGB888) since there's some issues in
> the Qualcomm DPU driver when driving this panel in 10-bit.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |  12 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  drivers/gpu/drm/panel/panel-novatek-nt37705.c | 413 ++++++++++++++++++++++++++
>  3 files changed, 426 insertions(+)
> 
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x02);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x01);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x30);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x00);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x11, 0x00);

MIPI_DCS_EXIT_SLEEP_MODE

> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x00);

MIPI_DCS_SET_DISPLAY_ON

> +	mipi_dsi_msleep(&dsi_ctx, 22);
> +
> +	return dsi_ctx.accum_err;
> +}
> +
> +static int nt37705_off(struct nt37705_panel *ctx)
> +{
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> +
> +	ctx->dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
> +
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x00);

MIPI_DCS_SET_DISPLAY_OFF

> +	mipi_dsi_msleep(&dsi_ctx, 20);
> +	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x00);

MIPI_DCS_ENTER_SLEEP_MODE

> +	mipi_dsi_msleep(&dsi_ctx, 120);
> +
> +	return dsi_ctx.accum_err;
> +}
> +

-- 
With best wishes
Dmitry
