Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293C1CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 11:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B96D10E305;
	Fri,  8 May 2026 11:58:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jsTVcJa0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M5dgRzeN";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0C3A10E305
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 11:58:38 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6489qfgU2770996
 for <dri-devel@lists.freedesktop.org>; Fri, 8 May 2026 11:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=nfuqOW3nIEbZgS9+VlU86ZLX
 h5hfjbWg92U7xxM35eU=; b=jsTVcJa09XtZvUZDUelCg6p+uGbNYl3iqT6cm4wd
 b0JAdqcjt3Dax0+RC0Q3bPqJpMQF/81ROaa1x1Prpcd+MprV2UjZjzl6NenRWd6f
 T4IQ/7ZvEqGwg0Qh5HdYUcUGklPyhne64f5fKGcvVTw7Lq7YfOen8HFLRpjbC/+4
 a27HklNB+bzunS1RpFtygMqHnceBw+xH/fBuK8TBPXlO2FngA2K54waT4ZfX44Kg
 AQ9SYi9rztv1CAyKAPI6XF2rW4Fyty4SppmANM3hfwoDOTYlKlzQo7UEXgTgZwSH
 g6bDQJq8iM22p19sg9PafgZFHE78w6hCSutaQdDqodKULg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0yt5kjvk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 11:58:37 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51306c1076dso40441921cf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 04:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778241517; x=1778846317;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nfuqOW3nIEbZgS9+VlU86ZLXh5hfjbWg92U7xxM35eU=;
 b=M5dgRzeNXQLWySJXsWL7+eqJuW4XhBxnhgm/DHg+fVa+Rp9ZKX/34ytSGYNRTFCq5/
 qAYn3PbgdEvz+cQ+S6/K7icW02y8AfBUnuKdy/0nW01LWZjhLPuLh+pIFqySGacITyMZ
 BhQrBEHt8Q0idn0Z7SUYxVzDTKxa007WDiN/1o0s/H+S7N0GmkZ1OuBas//JYCmWw3FG
 XcbMlDcUZHmVUJf6nLOSksDLygGQRdGqj62i39FrR6M/AUGhHyApZKti3htlLhYl5JK9
 Ggp69VVK03yoRwRnPwm6oiKhmH8/4wGidu5ab4cFpWesvF18tgjJdnj/oswqwDWT3N4d
 k+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778241517; x=1778846317;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nfuqOW3nIEbZgS9+VlU86ZLXh5hfjbWg92U7xxM35eU=;
 b=WyoxjTdw2wp8olFw3q+bw2Uwq785iAeUmpJbNCtAId5eVRTpvBEY4VoGxlcBIkHAk7
 7Zlp9OC5ZcK+e9MqtEe/yoz9jB+asnYQGJyuzbiQz+C03oVUn/IwisKtJbjz9/l5KuTx
 S3ferzBgYumKuiUYs4rLWmbj7QhoX3J+1jcnUxBgCaJQHnpQSqTTKfL86dR0Uky8hgom
 rASLCE4ekzbM0gB0tiUp40wcjVkiE+EtP0mfcA9jYrC5CTviXvU44v+rb1mdxjicwFSY
 cHbWk7fsMbVMLMgOwcxHnnOF8RIFQeUYERjTtZdO/wRm4EDdpvdK3ekdaRzpL50Nx7kq
 rmfA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8XlG64OLCqOrpDQpAspX9q9JDS+sD5yMCWnDWYQE2AShU/+Q69fvyPHRezrnjbepsDbuMzj4KEyGI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzlTQBOd7NbpyxZdkZdyrAXAt+uV5/ZRwx8NdKzzPWeYNFmmhfi
 ORZlcop4X4s/J3utZnYPIzWYb+lU0GIEfs+4c/MDn9xtgLOaxu5APQ5I3tLDR5Jwi8PEKaKY9Uc
 AWZgBdObJN53I87emlxeYOLUsnLl9iPH+AhN6dX1bMBi/0hc/7yzE65zcupTamFWtvTixFYA=
X-Gm-Gg: AeBDieuJ5TZeqU3CulJqFYkp2F8CEUyLIBu7nrDa3OWeSlTre9CjpjoyJKnYauMOirP
 unrC7gYxTfajOF7yoIGi1HXcdt4Q+sx94TQjSrrmNa2jHrAhVxYmm7212mCknR5TdQD/QUxTVfJ
 PzUg4SG2zeMtsGaTM4FYMwqaR8WcIhF9ONP3zfQpsfO+fKj6l9KRk+xFYNTQybjYj2f906EXtUZ
 Xb5Qs6qmTC2HqChvLDNrI6rMFthes8p5vlJWP14KfJAcauGt5xJaHFWhWRgKxPhO6T7eXG0X5UA
 bS1XZPoPUEoZkwZSHPkdtY9BkdihWtQsRpU2mNrH8tzQDVeQyrtN9CA4ZJIvGBV9via6HFyLRKR
 BCMZvPXV/21k0ML04FVFrGdM+BUidNXeBagFJAwNqzzuChyzteMmDVgbY2ojSI2S4NF3DRKBXVk
 QqntrkE9KhAbuFwnOpjh7sS8kcHAgniTr1HIM=
X-Received: by 2002:a05:622a:580e:b0:50e:60b8:347e with SMTP id
 d75a77b69052e-514621e5a59mr181828791cf.59.1778241516628; 
 Fri, 08 May 2026 04:58:36 -0700 (PDT)
X-Received: by 2002:a05:622a:580e:b0:50e:60b8:347e with SMTP id
 d75a77b69052e-514621e5a59mr181828431cf.59.1778241516218; 
 Fri, 08 May 2026 04:58:36 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a951d16bsm467738e87.22.2026.05.08.04.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 04:58:35 -0700 (PDT)
Date: Fri, 8 May 2026 14:58:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sen Wang <sen@ti.com>
Cc: ple@baylibre.com, neil.armstrong@linaro.org, andrzej.hajda@intel.com,
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, devarsht@ti.com, s-jain1@ti.com,
 j-sahu@ti.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: ite-it66121: Convert to DRM HDMI Audio
 Helper
Message-ID: <kbv3s76q3i4aal7jp5cbjlgned34lztxo3irqxf65mw5pwm2jy@kc362d22y5pu>
References: <20260318154636.3230454-1-sen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318154636.3230454-1-sen@ti.com>
X-Authority-Analysis: v=2.4 cv=Dc0nbPtW c=1 sm=1 tr=0 ts=69fdcfed cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=sozttTNsAAAA:8 a=7dJF91htWd4eWW5YXtwA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: NbVFKut30_t_DWZHblaiCvyS8n1ochmd
X-Proofpoint-ORIG-GUID: NbVFKut30_t_DWZHblaiCvyS8n1ochmd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEyNCBTYWx0ZWRfX3WWzxwVbxoa6
 fWbxAOwoxeeCeYDzUKQLQa3nm15TFEC03vucXuojzYaQ5Vvov7kew/x3MvzRdtk96NTUvgM9NwO
 d0vxy0r29lfkvKhIZtY8LgiJawz4ceNMGYDkPVq2NnvQse9VisT1vZSaYCF/7TT8gSgWlUfBt2o
 N6tjCtGMDe4YbmP6W7M6IbJ1D0PR+Y0NnBltz+ESvV7311JKX2OiqLHq4rVXIZva161O6E3ovNS
 XiOrLKAGv0y6S2CiNqipDltFlFUce5AwhoHzjHAErnqClydW2R0NispCNu9yXksHlM5u5c3Ng7L
 6mK16TZBUl9Ja+y9QJeO7NFexgw1PHdXEjefa7dWf0k7f12o9fQu/PKbyNalZdJd9A9ZqmURV1A
 YIjgXCKsR1VzyjIUqfOiWGspk4OoHHTBIrmhNEYN+dx2Z8CA4eJRCIjrZWkEGIHjLfcKXgzYEH/
 d3aqjVjgwKvbc8D3oMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080124
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

On Wed, Mar 18, 2026 at 10:46:36AM -0500, Sen Wang wrote:
> Convert the IT66121 HDMI bridge driver from manually registering an
> hdmi-codec platform device to using the DRM HDMI Audio Helper framework
> via DRM_BRIDGE_OP_HDMI_AUDIO instead.
> 
> The previous implementation manually allocated hdmi_codec_pdata,
> registered the platform device, and implemented hdmi_codec_ops callbacks
> including get_eld. The new approach sets DRM_BRIDGE_OP_HDMI_AUDIO on the
> bridge, letting the framework handle the codec registration. This also
> resolves some non-compliance issues with the current audio implementation,
> such as HDMI audio advertising a non-functional capture stream to userspace.
> 
> The audio callbacks are converted from hdmi_codec_ops signatures to
> drm_bridge_funcs hdmi_audio callbacks:
>   - it66121_audio_hw_params   -> it66121_hdmi_audio_prepare
>   - it66121_audio_startup     -> it66121_hdmi_audio_startup
>   - it66121_audio_shutdown    -> it66121_hdmi_audio_shutdown
>   - it66121_audio_mute        -> it66121_hdmi_audio_mute_stream
> 
> The it66121_audio_get_eld, it66121_audio_codec_ops, and
> it66121_audio_codec_init functions are removed as the framework handles
> these responsibilities.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Sen Wang <sen@ti.com>
> ---
> Tested in beagleplay ensuring HDMI/ HDMI audio works correctly with
> the new implementation, including proper ELD data and audio.
> 
> Changelog:
> 
>  v1 -> v2: Retained no audio registered dev_info warning.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Also, if you have HW documentation for the bridge, would you consider
implementing infoframes support? As another followup, would you consider
switching the driver to drm_hdmi_acr_get_n_cts()?

>  drivers/gpu/drm/bridge/ite-it66121.c | 135 ++++++++++-----------------
>  1 file changed, 48 insertions(+), 90 deletions(-)
> 
-- 
With best wishes
Dmitry
