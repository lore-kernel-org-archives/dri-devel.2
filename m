Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5C0C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F060D10EE76;
	Mon, 14 Sep 2026 13:24:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QWbNb02Q";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AIjc5qMP";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6B4810EE6F
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 13:24:48 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED0hTM1200872
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 13:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TJEsqlbhkeYlvOTZeQMhupa6Ph/sDiB31OAPFik2LLM=; b=QWbNb02QNVXvEYSI
 LSHs0mIIGJEbh/T60hOsLDfGeW2+GMdGZgtgPBLfnuRpRvHzI9whPWMqZB86tGU4
 F9Go+RUrpDjru1FiBA3stdJJu47PqKS9Z5kGo27IFKcinkoCSQTC198YnBCTizSS
 ttcOlgH7DjXqVvTOOKEM8duu2LlXmt6ByPebsT4qK8MFH2VOQceaHToc8TlTntSS
 Jn7hcGDiwvYgr3Fb+R6PtOmtQl1oAp8Lo9ckpm5fsVNJS0O+rlcpLsjr6E/Xe+FD
 OtEhHqF5jl8gITZcdzYhNROZS9Stzi7zQy10Mx/ibD95d4dH+3yam4vpdPeXUsiA
 44yPZw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpdevs1fy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 13:24:47 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-78fb9f59781so2871465137.1
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 06:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789392287; x=1789997087;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TJEsqlbhkeYlvOTZeQMhupa6Ph/sDiB31OAPFik2LLM=;
 b=AIjc5qMPjcXES8LvV1FPdPrPW31q/sr6wXmnmOQAjoS1ntmOQXhN5nAa3g1+7iZ7K0
 DL+86zW+J/x14nZh8iJRpbIy0oE0xH6qGFaHpoN84TfHwor3ihWx3YP16evoRrPvjpLz
 SaITGB2DOrAqGi6wdD2p9O4lU6A6qOOQkzKWxBKu4h196gjxcA1S4PNm9i7kDk5MyKmA
 Q1i9xUgrN1b4O9EFa5g01+TppHFODFmL3BmVp3EJWv+j+y6zV/qNQt3FyC7TE3bdZlKk
 1Fh9rOXVTa4FSk8wpXE+oJt/8+YrvWVeyhoNzdTd+3j84hYR5EsIfz65ETicrizRzMsj
 0Z1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789392287; x=1789997087;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TJEsqlbhkeYlvOTZeQMhupa6Ph/sDiB31OAPFik2LLM=;
 b=QxBzjVDI/NKd2VgUHrlZc2fs3KqxZOU2gzbgzPdug2wlbHFk/WN0sggmPEtPmWv3e7
 1S9OF01KzMryBjn1NfMVOHD4LgLF0cmfJjFYTXqhNDMYQp98QKIDMnLrPS4+L3kcz3Bq
 AoxMZRGSWYilnqipL49ITsTA0Qs4h00S6v+KwYVTIbIsKgu2HuOHn6PDyiQG9cK7hqsj
 cpf8b033G5jpP+f6KZLqqFCdgbTz928KwAQX4AfKauldzoak2rSiRZ2y15ELPQIz6YpB
 WONU4wCrGr/WDaZqqlbauQhTySqZBNE4PbNciMBvPr0ar2UKLSGgzHMzH0HbxiXJr8G1
 Xo8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByhsgvHQxYMb9ePbTbweFoi0eUKhoppF2W2lLc7vZolzq4bRyyVdKd22BrqOfrtqTdIF05tz2UJvOw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m7a7ez3JRqUunewJtGC0Qjyz3C8fMnxddB7QC+KlkWesS5vZna
 /j7YipfCB4c19P7asFqTcQ41QRvnjDSOlhiZuR7EOET5csSgWnVGH/b3/KQ+EagaRG0Zieq+Vu+
 N0HU2qCgsGymnZKWsinkSVDcbpEYM2+MoFMf5NIemtVTKyzs8FYCtVTDqnT7fWa9OV+n3+8I=
X-Gm-Gg: AYBFou1wPFXzVM7CUKmXFZ4S6OWcD6FI36H7+CxCyyHIRpapf7o/6yxpMhOjPwORJVm
 M+nFxlRH84FkP1wHRI4mvroAPTvnyVwVx1y+LXGEseYowiK2jviglHK/XeHPM6WWGl/t0Z0CWJc
 6tOaF14lzTWkHs6A98zbhl9mdO2dcx9ZJRdMg1TpYK8CIefAlk8vihQq/6NrZ3cssZI0hjxRYaK
 KrMHjX6Dnv5b4MRWFoOoyHFZif2sA1HdMXl8yb3ufhvNnoBlmBtLE8greOELN5QEe4iH4WswCz4
 PsJFZ4nuzjm1Ml/3xnSP+xkjx2lpbZX1nkK4QUrMA7Vl2RbYZFyjvP1p15jgCxFroX5CqdicHSV
 c67YyfqOzya1/fMNlOCHRCZm+xH/6Hb4oUKWHmEyT3ryTDR/TO0rKSPB2QbQf+OdxE8ABnMBBlK
 d4kR0wrbZiSHsd
X-Received: by 2002:a05:6102:6a90:b0:795:1be9:661e with SMTP id
 ada2fe7eead31-79b570f4ba8mr1227990137.1.1789392286908; 
 Mon, 14 Sep 2026 06:24:46 -0700 (PDT)
X-Received: by 2002:a05:6102:6a90:b0:795:1be9:661e with SMTP id
 ada2fe7eead31-79b570f4ba8mr1227965137.1.1789392286464; 
 Mon, 14 Sep 2026 06:24:46 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a0472bdasm2443458e87.63.2026.09.14.06.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 06:24:45 -0700 (PDT)
Date: Mon, 14 Sep 2026 16:24:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: kavakliyigitcan@gmail.com
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Henrik Rydberg <rydberg@bitmath.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-input@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH RFC 08/10] drm/msm/dsi: make command and video mode
 configuration mutually exclusive
Message-ID: <pnlrq23steuyvrqm4e6krzdlaa7pqozxqcaaakzsmqajuo7n54@hhhu6chgeei5>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-8-0e68e63a18d4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911-ginkgo-submission-final-v1-8-0e68e63a18d4@gmail.com>
X-Proofpoint-ORIG-GUID: dC7CFk39L-L5wicmkHa3aMwl_B6Aeyy7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE5MiBTYWx0ZWRfX503HM8qbAUTx
 BSxMADgM0wOf+wY0pPH5gmON21IwJRtfCQHIGdEf2b34+o9DlgWt4rYGT7fStcshaJyqaa0rBhc
 olAB2jYRauKQkO4c2WGNE9AQqNfE6x0=
X-Proofpoint-GUID: dC7CFk39L-L5wicmkHa3aMwl_B6Aeyy7
X-Authority-Analysis: v=2.4 cv=ftpJ914f c=1 sm=1 tr=0 ts=6aa7f59f cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8
 a=irAkg3Ti1NS2jvoIXoMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE5MiBTYWx0ZWRfXxbvCr20BCCWl
 eFy4BcWP0rpY6+qX6EDv/XKF43ruZDKAV/EBdAnNoMSXaFTigGMl8w/nw4h/OpQn5QEU6M0/6HG
 4Pgpj8n0Lh+5ct1ro9IKd6bkynclah62dNN2gaVzKz+PJ0S1miV25U51I8mCPJWRJ6OUuvCkNiJ
 8oOCdbZceCHSCK6jwXSn91vuTcpbwN7sZHpW2Iv4j717wS3gVmGJjNl+YPXnXwp46qCK9PBa6SN
 XZSYTQGtHmq2pww/YXxcw945Cnx8aoW5aOUj/uoWzQgfbbgzC3sGlST/jlcX8Ips07fHKF6OHgP
 5hojBrf1fXu5CdSdYL/iZjEsKsKf8ZV583A0VQ8SyvJuUD6ZgWLnNU/SVsd/f+Zeum0E2KMJHtJ
 i55XbMOJJ1PUocAZDoOO69iJ91NvEub2RZm+xqPxAJV4zfA5TLHD9Q73Jqhgi4k37wlqoY+KKBG
 mDo4fBO3tb0ccDopRHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140192
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

On Fri, Sep 11, 2026 at 11:51:05AM +0300, YİĞİTCAN KAVAKLI via B4 Relay wrote:
> From: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
> 
> In dsi_op_mode_config(), entering video mode sets DSI_CTRL_VID_MODE_EN
> without clearing DSI_CTRL_CMD_MODE_EN, and entering command mode sets
> DSI_CTRL_CMD_MODE_EN without clearing DSI_CTRL_VID_MODE_EN.
> 
> Ensure explicit mutual exclusion by clearing the opposing enable bit
> when switching operational modes to prevent hardware bus collisions.
> 
> Signed-off-by: YİĞİTCAN KAVAKLI <kavakliyigitcan@gmail.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 7e4e3718b536c92dc555de213042857379499447..b9e2867d435a3ad8b6db6b57c440bbd827180b6e 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1094,7 +1094,9 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  		dsi_write(msm_host, REG_DSI_ACTIVE_HSYNC,
>  			DSI_ACTIVE_HSYNC_START(hs_start) |
>  			DSI_ACTIVE_HSYNC_END(hs_end));
> -		dsi_write(msm_host, REG_DSI_ACTIVE_VSYNC_HPOS, 0);
> +		dsi_write(msm_host, REG_DSI_ACTIVE_VSYNC_HPOS,
> +			DSI_ACTIVE_VSYNC_HPOS_START(hs_start) |
> +			DSI_ACTIVE_VSYNC_HPOS_END(vs_end));

This fixup is unrelated, please split it to a separate commit. Also, I
don't see corresponding code in the downstream driver. Do you have a
reference?

>  		dsi_write(msm_host, REG_DSI_ACTIVE_VSYNC_VPOS,
>  			DSI_ACTIVE_VSYNC_VPOS_START(vs_start) |
>  			DSI_ACTIVE_VSYNC_VPOS_END(vs_end));
> @@ -1168,8 +1170,10 @@ static void dsi_op_mode_config(struct msm_dsi_host *msm_host,
>  					DSI_IRQ_MASK_VIDEO_DONE, 0);
>  	} else {
>  		if (video_mode) {
> +			dsi_ctrl &= ~DSI_CTRL_CMD_MODE_EN;
>  			dsi_ctrl |= DSI_CTRL_VID_MODE_EN;
>  		} else {		/* command mode */
> +			dsi_ctrl &= ~DSI_CTRL_VID_MODE_EN;
>  			dsi_ctrl |= DSI_CTRL_CMD_MODE_EN;
>  			dsi_intr_ctrl(msm_host, DSI_IRQ_MASK_CMD_MDP_DONE, 1);

For this one:


Fixes: a689554ba6ed ("drm/msm: Initial add DSI connector support")


>  		}
> 
> -- 
> 2.47.3
> 
> 

-- 
With best wishes
Dmitry
