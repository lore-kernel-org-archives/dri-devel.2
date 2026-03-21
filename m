Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FCF1094489
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 17:16:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ACDB10E277;
	Sat, 21 Mar 2026 17:16:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JvEB4tIy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CJBjAL/I";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30A5710E277
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 17:16:47 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62LB04po1966970
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 17:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=5/WEKlSuRIQ3y6kLJmolINvh
 UCSFxM2orcg3n1rvkHk=; b=JvEB4tIyiA+gzVx5h+ULOk/e+RLbmaLaiqi/cU4z
 QFmV9OhEurr9W98gb8dSyeg6YZRZX6FIeTKc11d7Ty0qfTnO8L9DA5ac9Bry0Nry
 MQP+qc/58iV3XEj+W/omxMkehv2ybPkxNeHHEDiPIb20TiRxtv2Fy2AFP3lWl0s3
 s++FheJb1Dj5E/J8acvRYETrxcWpAhrvQs4+hrkYkKDkJi5/imE2I4ji0gbQKBOw
 oFumuQmE6OM44y/qc+NeNGxUPovtSuWoensY3S0WghtWtMpBQCeupaSb2Uwf7/zc
 O4q0AmZYh7OMlIxAvIT2QRi9WhV02yh56h060dKzSu2rOg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1kdu92dg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 17:16:46 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b34223670so207274961cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 10:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774113405; x=1774718205;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5/WEKlSuRIQ3y6kLJmolINvhUCSFxM2orcg3n1rvkHk=;
 b=CJBjAL/INnAupBGxjY95ePPew5CmzFNTlc30Lj4g9g7agoV/2j+e3w7Sx8tCbwG30y
 WwYwaXwlXdEqUrnSlaFVUK3bFWz9UKHanvGrbhAPgKbkJP9f3lqU9HGVZjrdVczHTcLd
 dn9W2vfNkbcDqUiKSnlBguGPH+lk6zTG37Y03CIe9ebRD1Sbv6M16GTRt89b3MQw/3ut
 xkRscJn8zhPmpzYMwu3WC6xSuHDZxQjUFOt3fhLJmDyUTKg8RwLMW4G2SkOdFybQ9ADa
 5DJuliqheqbdRDglXYgggeAhiNgHlw3HCp+kJ8eIQzZWuzUm/dEoi26IVamgReGLwFOc
 CM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774113405; x=1774718205;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5/WEKlSuRIQ3y6kLJmolINvhUCSFxM2orcg3n1rvkHk=;
 b=TFL6bQ/rFlEPMj1tOSjX7C2Dzn77caIPjtowndrf/IV8gEOhn1lN4f/6MQaYs+8UkK
 WlCA/jOr56Bg/7DQxIqfzWWXaIm813w7+eYe8zNWh5SKpnAfNR2xE3ygcMUWzVKF0n/w
 sAw6MZ1U7iEVtNoUwe5ZeUrgG6M2SaglZ0rV9QTv2+LLYfE0zKsU9WIX6peCYardOlyZ
 xr8kfLFjJGVa0V5fRxZLO3M0TzxSz52p49gtPkRmy90NaB2ErPHm9yJ1Y5+XBMMLAiHv
 EUeEd+H3HSFbpX0m8JqTiCD/lsFLze+2BigwJtk33NR5IgHyY3ln3BHwKWvU+Z7Z9g3/
 1/SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeJRJx+hnWLXviiKlAmZoVGobvnL8cR6P+RvwY5jqsBj3nAG1VNT76oEQIETJYVe+T/k4wwzN+yto=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwwjHeqeM5aIl23JxgHTGpC5dDFsIEidrUVJHLiXWrQsLNReCOo
 nRXEHrWdPuEO2Ksv69V9mjeF/p0WDafDE4z6QrNwY3qac+oftEOqGsc1h9KsQlc2q1Wu0DilGh5
 VduDBNfTXHnPl63ID06hRwtWfndAOuYyMQBDPLo+H8Zw8IljSLM6QGPjz/4ZBJ7En0ZCoHJ4=
X-Gm-Gg: ATEYQzyir1xVirSmNJXBA+w5MMtOFDIKL+Cdm6g2xGP3QJ7j0NX9K6NSHEU3dy34glT
 QKflsHFVml9t5iYGo1lVrjROyY63TOLhXHy3bsO9oKClCb7mdYEi3VlOGVkTM5SRXZMR042XTqb
 GLQswxWr0NrkMtYkzjNRB+H06qoaWTu95Cp5PVVHzgkOO6Y3kSvmgSi4ci/GyOKzdn/1qItTqzC
 6/ciw19/GRPj3kEPSRhihXP3nxNCXItxdaBxaPmpU2AW37bRr0vtcEEF70stlkc++EqPTit5YhI
 JJ4hTPYDwekE2uiXstsqhPk8cXA4KTxgyEGYYadmxD86d5PuJd/8RUQtyzQNi1YQunHiCO21NbB
 VqByC5zezHM4ZTEwI98GOymgfoga+JnZ7d6iVc0+NPB1c6NSTLhSxLy9NyjU8MuGufHgCLRPmmG
 78XjFf8Pcc7XRL6EW/PpspLIPxvA10SzrqT/w=
X-Received: by 2002:a05:622a:588b:b0:4ee:1e82:e3f4 with SMTP id
 d75a77b69052e-50b375d0dc7mr119534411cf.64.1774113405548; 
 Sat, 21 Mar 2026 10:16:45 -0700 (PDT)
X-Received: by 2002:a05:622a:588b:b0:4ee:1e82:e3f4 with SMTP id
 d75a77b69052e-50b375d0dc7mr119534101cf.64.1774113405142; 
 Sat, 21 Mar 2026 10:16:45 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285206f73sm1223501e87.54.2026.03.21.10.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 10:16:42 -0700 (PDT)
Date: Sat, 21 Mar 2026 19:16:40 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/5] drm/meson: handle RGB101010 in format switches
Message-ID: <lu6cjjfcrmhebizkuf3hcghgktlyvw7f7docmoo5v47r2uidvu@c3rqozgop4i2>
References: <20260321-dsi-rgb101010-support-v4-0-eb28ecebbfe8@pm.me>
 <20260321-dsi-rgb101010-support-v4-2-eb28ecebbfe8@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321-dsi-rgb101010-support-v4-2-eb28ecebbfe8@pm.me>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDE0NiBTYWx0ZWRfX0dHkh1KMefm9
 +J7KlPrdowMU3u80/PCDJ71IvcTaqtw1fnCGyHOhwKlBS0n9tsz1rWRQ4tkz0U0bwb9+XLXJy/z
 CHy/kAF8NP9EcfJFzDxVawp8XKDVTyUpYLc3W0pQqL6SQNGy0m62+dgXF/m4CoKyh/ARisFxmtN
 VvWs6ho852DJdyxSODpf5lHm3iV7ioYZ1JUQt4louWh2HYdKmwcJHNyfSCC/HOoWc73VQvzeekY
 YAfNCAhTUT4UNMH4KmKEFTuIZOrBR9GgoTGdiW5aOwplgm9VkA+BsVAblHMK01Tfr0plHhSzgEz
 JLRz3ca2BSpMmyAji16bUnFNtpT3+BgjWN6kIVWsIXbHHm4Pg+y7wwNXnjRxz3fmuVTA1pB5edQ
 OL//de//d78BLLHPIUVyuKfO6CsQd0Zdg/yk5ZVlTWUoBCcklO4dvEgDezdtWMjK/LSWKeWaEC8
 vYQ3q4gMPVSJI/6lbSg==
X-Proofpoint-ORIG-GUID: vdwNO3fMiBfg3sN4tMPw0PEjcqtDVhly
X-Authority-Analysis: v=2.4 cv=Q4DfIo2a c=1 sm=1 tr=0 ts=69bed27e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=4dpF3GFcmnioVf4f6KwA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: vdwNO3fMiBfg3sN4tMPw0PEjcqtDVhly
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_05,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210146
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

On Sat, Mar 21, 2026 at 07:52:30AM +0000, Alexander Koskovich wrote:
> Add RGB101010 to the unsupported format cases to fix -Wswitch warnings
> introduced by the addition of the new pixel format.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  drivers/gpu/drm/meson/meson_dw_mipi_dsi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c b/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
> index 66c73c512b0e..59fc0083d318 100644
> --- a/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
> @@ -119,6 +119,7 @@ static int dw_mipi_dsi_phy_init(void *priv_data)
>  		dpi_data_format = DPI_COLOR_18BIT_CFG_2;
>  		venc_data_width = VENC_IN_COLOR_18B;
>  		break;
> +	case MIPI_DSI_FMT_RGB101010:
>  	case MIPI_DSI_FMT_RGB666_PACKED:
>  	case MIPI_DSI_FMT_RGB565:

This would need to be changed again and again as we add more pixel
formats supported by the MIPI DSI panels. I think it would make more
sense to use 'default:' here instead of listing all of them here.

>  		return -EINVAL;
> @@ -232,6 +233,7 @@ static int meson_dw_mipi_dsi_host_attach(void *priv_data,
>  		break;
>  	case MIPI_DSI_FMT_RGB666:
>  		break;
> +	case MIPI_DSI_FMT_RGB101010:
>  	case MIPI_DSI_FMT_RGB666_PACKED:
>  	case MIPI_DSI_FMT_RGB565:

And here

>  		dev_err(mipi_dsi->dev, "invalid pixel format %d\n", device->format);
> 
> -- 
> 2.53.0
> 
> 

-- 
With best wishes
Dmitry
