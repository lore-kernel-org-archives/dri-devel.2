Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8284CD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 14:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51E9B10F2E8;
	Thu, 28 May 2026 14:59:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yxntkil3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VCRo4nYT";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 778E610F2E5
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 14:59:06 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8vb85566549
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 14:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=JF7FCNKgC+/N7fXpBOgq/DWr
 CNsYoGEOdFyMNVP5q9E=; b=Yxntkil3rlklLRhS5RH0zK0CJS6ASWkRlIkeCVQ2
 J5tJW96s1Eh4rd/jTTh5NDK6LJWqYkhoT1etdHo2ce5w+LriLhqWQzlO1Dh+Oieh
 XeGUGlVHjdyoV5E3WW7uJBB04A+GsQGuhXuKd0XvsLKeQ5kzNWg0oTXfQTXw5L5y
 Qq71zx8jCPZV9U5QSoepivwnS+tMfOpmAjS4NJREOrA7napAqpOfDtgy9JMVZIHc
 syHikQHC1mpEx4K2nCK7AJkcTw05Cmr29NwK6/LvHwYI227JuiFqgWHpJ53btSLC
 8eSSj8SkPB9YfOzoQoUOrtM8jz5I4Z2bKEnBAtMiAy+Wjw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ynk6x3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 14:59:05 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-95fc346e02dso18877259241.0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779980345; x=1780585145;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JF7FCNKgC+/N7fXpBOgq/DWrCNsYoGEOdFyMNVP5q9E=;
 b=VCRo4nYTXGNSOFgqUwt7CQTjLGBNaoqYmfE86+CuVP0h4VLWnGsS4lF9kpXb4nOm8q
 XWZScjhP6pyqmaGOvQZkX9oek8q7LHzM5hhWpeZoeUwaeIr2zFvHd4KgouIGQa6z7H79
 Pixdact5GMPIyJJb7fv5xwI79uyCnmMQHAM0/YBiScmJYkHF1u7jAnMWii0bT7BpXx86
 E7PSgl4UjckFUU881eT4nKJsii8WrqXHQNLwhoPLg+1gadSDlKDBddwo0CHDBq1TzVol
 iq5thOz+uDR/QGXpuWJcm18141nU227Z1+kBS/3GKn3X2umjeyBiXzD6xS8oF+OMi2du
 4dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779980345; x=1780585145;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JF7FCNKgC+/N7fXpBOgq/DWrCNsYoGEOdFyMNVP5q9E=;
 b=FO6Sk23Np6hEVaTkHuw8w7shhA1qzTFdqB0LmIKEGrcuE1RuRXAMq6kSNsL6ZrF2HD
 e7877rTHjoROsDpqAK8mSxhj6He1cviUgdsjtvoYpQH19Xr5CTHHcCThnQNQ6ZB7TOQn
 vIRD5FMzSWyVZ+W/7RXlyq/lYS006lyXeX9JIXMHjzFzNzT8d8et7II4M/JH47sL4/2N
 +Zg2fkJKXAytpnbLfptpQWm7GxxTaKl5766EmkhhZyk5QlOBBu6A7Eghn+r3xauABr0l
 uUxOvw+mKv5SjC+Sk/tiraeny4O+fXHwffrkcgxlmCD5Z5DfVu5YrkMAQFbLIKUr3ndo
 NvEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/CPMDbM1L7/XD4d+BHOP6U/c3Qb5FTyDzhnZB4Pg8W3NH1+2oIF1ntkWDR2sWc1NKCRQWsEXVYxXc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzHrEElvdUPXE1YC5RNl1l5e/37trJ5v+qJlpe5ixngFd2OqOnn
 aPmrauTFw50viNQ4OsENyAm4k7sTHmoRMVtP39hnRygiVs1CB2N+QLT3n0IIIgJveNMOTxo0eRU
 Gvkq01xD3OdKkgLB4mqU3PLzl95Q5LdHWpVW9OXURkMdlSgjLEue3ZQElDauexmuJ4APjfpY=
X-Gm-Gg: Acq92OGxdyW5dtPKff+OLEiyl/Rwe3W03t8m+R8XkzutTeQAaX253lEY26C4aZwIW4h
 eeuVQEFjdNRAf6F0fg5CEdPBsjnBuTJ8zkOC7jbRdz9dHBB1FoLn2cut/M8gOKSA83d+3ppyfYq
 10WbaPySlda3XyzMmYQnS9V7Ypbn2vmajDAYxT+sonKT127lROSJT6Olia/L5VfSXahicafyqva
 Hdlmf3YcZFK9+ajE7PEOMF5mrFIUFIGVtc/RRo6CH6XL7Hi2ltCS9qNIEbMxIzOti7WvzwMh0mu
 lGNVs9etKKd4O/40orByf2c+pcrpWy35J+8wufWOx9dvSjuKXfxm1i8fYV/Jlei7qotsLwoIbwu
 75GAlPf5vUMxbyFY2Wb1kYkTfUTEZrNqmJ1BWxbB7StDy4IHmGzcIqeRNNlFlVVPvtc+wftsoXc
 Qs30O3MYom++aWhLLSdfxLmQcpdNcMySPtwBN2HBONxVYN/A==
X-Received: by 2002:a05:6102:3f90:b0:610:1c78:9531 with SMTP id
 ada2fe7eead31-67c7f83cc72mr14626482137.24.1779980344993; 
 Thu, 28 May 2026 07:59:04 -0700 (PDT)
X-Received: by 2002:a05:6102:3f90:b0:610:1c78:9531 with SMTP id
 ada2fe7eead31-67c7f83cc72mr14626470137.24.1779980344596; 
 Thu, 28 May 2026 07:59:04 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa46322114sm1986254e87.44.2026.05.28.07.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 07:59:03 -0700 (PDT)
Date: Thu, 28 May 2026 17:59:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Val Packett <val@packett.cool>
Subject: Re: [PATCH v6 07/10] drm/msm/dp: rework HPD handling
Message-ID: <eijkwjp7taugpxsitpxu6oc7dxsvfenlsavzajoqrw6yaqysn2@lkjkrhfevtco>
References: <20260524-hpd-refactor-v6-0-cf3ab488dd7b@oss.qualcomm.com>
 <20260524-hpd-refactor-v6-7-cf3ab488dd7b@oss.qualcomm.com>
 <0c6ace6f-26e3-4a15-a467-1715480b1115@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c6ace6f-26e3-4a15-a467-1715480b1115@oss.qualcomm.com>
X-Proofpoint-GUID: iqYfmbu6tUypIwPUihMxwFgLydPhWcX5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE1MCBTYWx0ZWRfXx3M+c+lwlLaI
 jOKFgVctAkIXmrnX0pcRp5SpA1O3+83i53ERFkCrdU+H7+7SOcyeNSxQKeJ8EPCBkfrXnAvU7kd
 dbV5PTwxdLWf3FuHPOx73gNncgbvrwLMABWiHQQ0l4hQdmVgiHTcW6d4qgeYkyCmM7mQjd34fXX
 e3Uj/AzQ9YnsVI+51c/syTrs+u+oPp42pIAlZsq/+73cSPTpne0MEZ77kUEIS+tRFk8RFJvQeI0
 m0n629vC4f7QfoIme3odCV4/EZRXoAQsvzs+CynN7c3RJBE2ooErriTT/WEaK+PTfXw0py1doTz
 djS3XhUfruKhPjp2917SKpSLKqOx/d6Rf79JnZqRJjtIzwJmyBBZTzWDliSKgVDJQUzFQ6xquCQ
 ngNAG/6lILqBL5n9Xxd5adyRQouw0Ez08BTfWSXvf5PgcV7TRBIuq9jkj1iowk/c2NYIy6piOUc
 e+Pi5+XZ64gd3XpwCjw==
X-Proofpoint-ORIG-GUID: iqYfmbu6tUypIwPUihMxwFgLydPhWcX5
X-Authority-Analysis: v=2.4 cv=Eo7iaycA c=1 sm=1 tr=0 ts=6a185839 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=BT-0i3qiSzrRAeLSTCAA:9 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280150
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

On Mon, May 25, 2026 at 03:51:15PM +0200, Konrad Dybcio wrote:
> On 5/24/26 12:33 PM, Dmitry Baryshkov wrote:
> > From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> > 
> > Handling of the HPD events in the MSM DP driver is plagued with lots of
> > problems. It tries to work aside of the main DRM framework, handling the
> > HPD signals on its own. There are two separate paths, one for the HPD
> > signals coming from the DP HPD pin and another path for signals coming
> > from outside (e.g. from the Type-C AltMode). It lies about the connected
> > state, returning the link established state instead. It is not easy to
> > understand or modify it. Having a separate event machine doesn't add
> > extra clarity.
> > 
> > Drop the whole event machine. When the DP receives a HPD event, send it
> > to the DRM core. Then handle the events in the hpd_notify callback,
> > unifying paths for HPD signals.
> > 
> > Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> > Tested-by: Val Packett <val@packett.cool> # x1e80100-dell-latitude-7455
> > Tested-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com> # Hamoa IOT EVK, QCS8300 Ride
> > Co-developed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> 
> This is way too complex for me to grasp at once, so I have a couple nits
> 
> [...]
> 
> > +	drm_dbg_dp(dp->drm_dev, "After, type=%d\n",
> > +			dp->msm_dp_display.connector_type);
> 
> Most debug prints added in this patch have odd indent and some
> have vague messages

Correcting the identation. I'm not sure, which messages are vague.


-- 
With best wishes
Dmitry
