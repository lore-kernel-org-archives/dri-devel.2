Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7AFCD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CFA610E0F5;
	Mon, 25 May 2026 13:51:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KXKkg+Z8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jvr1bDlm";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F16C410E0F5
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:51:21 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64P7HxhH671784
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TBi8TFsiSGuDtHvREBnTkWTPDNdkV9Tw5zfg0QAYJ4k=; b=KXKkg+Z8vBcXBtsX
 KHmRyL7KyAWVnoCkVIiaxygnDIS93yFjFtE40PlQ+2Rq0g5uhDGkICqiRmV6iqCy
 jjuZHOdcm73BRHvw47aYpFvAI+x5bp9eqmPGqzUFLQUPXtt++yFlUH9dtadOhORl
 CZxU13Vy8fhIlNCDEzKH18UL1g+rVO1I21XXLIK3gizce2f65pr5CWotJWKJVE3C
 AcBtMjQqWniX5FCWD9oCnovX8fSRlvhOdkMlHr1odPzM0QijIUEPUHJLppdZFYPq
 x91Z7MQBj6qAO3jcKubJPyLJlkh2++/yT9P/GXubr0BUg/lusw9kjH72v4++E7nH
 ZA14gA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4f3euv7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:51:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-90fe39eab32so151694885a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 06:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779717080; x=1780321880;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TBi8TFsiSGuDtHvREBnTkWTPDNdkV9Tw5zfg0QAYJ4k=;
 b=Jvr1bDlmPXkrp+wJZDVtiy5WwoxfMInWaVS+JkgpIzEECb5T89X94xJD/CinIzuDNq
 +jWJCn6FXIWTS1fFYMg+iqJkWyZDJiftiw9txq0QRQWx2fn9pXpHSMVXxQ1wcwufhzpY
 1un5PLLuWaXYetkFkoT/XI14CcLHw9h4RA6a4KukTAuELDsRRa9yWT24IEdaO2l0NR6k
 OIFdisl1v7dJN3mhzEfjqlZRdPc54sgIUBudpifWZpFatKJJAmPOjFmLBSE9+T/TF8l3
 9WHVFPoTDTkxZ2jto5BeioM2vdngEUzOd9SjLT3MoZJ2xzsxi+N2VgugsYrRQZquRaO+
 VJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779717080; x=1780321880;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TBi8TFsiSGuDtHvREBnTkWTPDNdkV9Tw5zfg0QAYJ4k=;
 b=Nrsj/9PdMFQdez4s997/erNxK90wEYgz/L6E6krujiOwMkVlQhh0A8uUO6jpk9O1Sl
 pOsycmtwnEumsGHgARgxT5KzC9gwMFFo1zGfGBndRayk3usfI0hUw/a/e0qPNglM4rAh
 U9s+NwLz2dvN0XDByxTbqL6J8DoShN6SarcHXOaORV/zsT2o1BrDGCc7mSWorT5PmI4T
 zywKUF37OzY5rrquEd71nnJ9Lb2o2B3PuMedAoTk/LjK8/4RbyxbxsTvln1YAHQWuAN3
 VpUnG7a9yDvf8Q5FEI9Nhg7v9i8GvWIi8BAqEZYY1B8nhoSHBljOguz2z+RvmGRmxZml
 Oy3Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8RHz2lGSaeK2wJoH7V9ywtVmCeRhK5k/+e1JHLxCci6Wk31BGwhM1VyQiEhZdsAnJFOieIDo2D9Js=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywfx99bE/2Hp+T2rK1kbW+isHuwY7jtK6KI2cnf0lHTpcxP14hK
 skjNJ53b9nGGJgPCL1aORvROT14beqFqCQrVwNtm7NuE+/kutx4xLAp7kvxIlihnqA/r4o/V7oL
 pf67OdPSxaey4c2n345VVpdKLW7+1DJd6oPawd0E+rbiCQxkiA9LF2K1DdVlfcTSXHZVxdoU=
X-Gm-Gg: Acq92OFd/pvSaXwWtJSwIKw8ZsfrR3unvA7Pt4A0rP+Fcj8InnNaR4qv7L3x/C1FgkX
 5l67pYanlJ+2JetF5a423AvYD4puCg8cUyDpYGDITzS/7beM9d6K1o8CrxjANcLpXz6JIAwZ9uq
 QNyOrs4EgNkU5DSB+DD54RzvLWRs9jsJwoYVCJjxqXDYt2I7tO9JHLqg8dTLpXS87htc0tOKEUx
 l+zy4xF1yKGRvZvTDoA3HIiRvAj/iQ2lsVu6OleHOVHrlclYg9tobxf6UQlPCifXptkSDFV8jLH
 dEIbN9S5DYElmFBegT5h+/9NxNAaqRjnvbjehMCOnT9pMHlE45r+K7GlgxGMAUwmSuklCti2pCH
 rpItqc+9+KBhMNYp3x42r2pGRB944hgH4525bCUJfwtKlkQ==
X-Received: by 2002:a05:620a:462a:b0:910:79db:c946 with SMTP id
 af79cd13be357-914b49a1bf3mr1379218585a.5.1779717080482; 
 Mon, 25 May 2026 06:51:20 -0700 (PDT)
X-Received: by 2002:a05:620a:462a:b0:910:79db:c946 with SMTP id
 af79cd13be357-914b49a1bf3mr1379215985a.5.1779717080090; 
 Mon, 25 May 2026 06:51:20 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-688baf2ec1dsm3984677a12.21.2026.05.25.06.51.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 06:51:19 -0700 (PDT)
Message-ID: <0c6ace6f-26e3-4a15-a467-1715480b1115@oss.qualcomm.com>
Date: Mon, 25 May 2026 15:51:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/10] drm/msm/dp: rework HPD handling
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Val Packett <val@packett.cool>
References: <20260524-hpd-refactor-v6-0-cf3ab488dd7b@oss.qualcomm.com>
 <20260524-hpd-refactor-v6-7-cf3ab488dd7b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260524-hpd-refactor-v6-7-cf3ab488dd7b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zAZEVpH6azaqhoLUVM5irCMPDaegz2Jx
X-Authority-Analysis: v=2.4 cv=WvYb99fv c=1 sm=1 tr=0 ts=6a1453d9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=V3MyGVYEbErwUeSx0MIA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE0MiBTYWx0ZWRfXxGlhhLx0QAzk
 cJhJwqbwsKfdqrsq2Ute7viSEl04jV6Fvi7F/zu3egGKgqTMI2VqJPEunoXRVNcNae3HxvsnnGs
 I7pFCaZ+B8uYH/o4ida4LttQaNWtlRCVQT25dKGnmwHDRBKaunFbMmMWsJZmZg6UdPDXf3SgC/G
 akzGIonblswijUBs4HIUgCF0YCoupqEJDua8dXMsEeS2RwphtvnNXGEiBcW2KmprbNsyN+YldKB
 jEhScVM/oQF5J8u7rSq0rDEzuIC4TRuMDj92sW5M8KgerN34Ufc4brCxu1i0m2YECcp1urONVkn
 NuC0mbOU2LuwfGlAdzEYUvlqHQVg94aXYwqwRWGa7YF5ob89G6nsHraoszE62vBDzjzL8ZR1kSw
 aHXJnQKKwuAcdoG3+BouuIOz9gtxTjESNHPXqYxzrIY2wAE0Uko3ryeD2JWe1/MwAsWpUiRNIZ2
 acBloy5CVD54xcc40CA==
X-Proofpoint-GUID: zAZEVpH6azaqhoLUVM5irCMPDaegz2Jx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250142
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

On 5/24/26 12:33 PM, Dmitry Baryshkov wrote:
> From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> 
> Handling of the HPD events in the MSM DP driver is plagued with lots of
> problems. It tries to work aside of the main DRM framework, handling the
> HPD signals on its own. There are two separate paths, one for the HPD
> signals coming from the DP HPD pin and another path for signals coming
> from outside (e.g. from the Type-C AltMode). It lies about the connected
> state, returning the link established state instead. It is not easy to
> understand or modify it. Having a separate event machine doesn't add
> extra clarity.
> 
> Drop the whole event machine. When the DP receives a HPD event, send it
> to the DRM core. Then handle the events in the hpd_notify callback,
> unifying paths for HPD signals.
> 
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> Tested-by: Val Packett <val@packett.cool> # x1e80100-dell-latitude-7455
> Tested-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com> # Hamoa IOT EVK, QCS8300 Ride
> Co-developed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

This is way too complex for me to grasp at once, so I have a couple nits

[...]

> +	drm_dbg_dp(dp->drm_dev, "After, type=%d\n",
> +			dp->msm_dp_display.connector_type);

Most debug prints added in this patch have odd indent and some
have vague messages

[...]

> +	/* Send HPD as connected and distinguish it in the notifier */
> +	if (hpd_isr_status & DP_DP_IRQ_HPD_INT_MASK)
> +		drm_bridge_hpd_notify(dp->msm_dp_display.bridge,
> +				      connector_status_connected);
> +
> +	ret = IRQ_HANDLED;
> +
> +	return ret;

Return directly

[...]


> +}
> +
>  static int msm_dp_display_request_irq(struct msm_dp_display_private *dp)
>  {
>  	int rc = 0;
> @@ -1247,9 +933,13 @@ static int msm_dp_display_request_irq(struct msm_dp_display_private *dp)
>  		return dp->irq;
>  	}
>  
> -	rc = devm_request_irq(&pdev->dev, dp->irq, msm_dp_display_irq_handler,
> -			      IRQF_TRIGGER_HIGH|IRQF_NO_AUTOEN,
> -			      "dp_display_isr", dp);
> +	spin_lock_init(&dp->irq_thread_lock);
> +	irq_set_status_flags(dp->irq, IRQ_NOAUTOEN);
> +	rc = devm_request_threaded_irq(&pdev->dev, dp->irq,
> +				       msm_dp_display_irq_handler,
> +				       msm_dp_display_irq_thread,
> +				       IRQ_TYPE_LEVEL_HIGH,

I think this field expects IRQF_-prefixed flags too

Konrad
