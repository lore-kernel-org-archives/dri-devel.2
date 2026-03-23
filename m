Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4F1D58CBF
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 21:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 703CE10E4CC;
	Mon, 23 Mar 2026 21:29:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NljK6uLZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JF8wylt1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31C4510E4C8
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 21:29:33 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqcX93170733
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 21:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8fGTPmBY5vWGW1J+pc1gcodKZaPogmrWSzX6ByBHUis=; b=NljK6uLZLsqjqNDi
 HSKXMJHMaqn70Cpo5M/tuIydVWwUVYyMudjlxONN5pb9JohScyiKfpqOHsa115MX
 8mU0C11E/17YZ0/yUcDLpWRDpZVgfC5fn/hDjvd2VFvQYF2ZcujrXWQ26Xwyd65m
 PsVFaPAdvu2dtMnFQ0yvj1F2y1y2sokEZDE4KBjXyYt+nF4ybuDYLrFoQ5EQfIM2
 RSWoCxqybORFXWCl4klq/eaOHEbNHHgRog4ZSSshpOMxga5uE4QX0kMkZNZxH2lC
 lJfrUZQanROGV6qpO+0PQf08Kz7gBIUtwG2Ob1CydzH1Xb6/2DPa/d+k/A/2kbLr
 dxGCSw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d35r21s5p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 21:29:32 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b4b81c632so86028111cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 14:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774301371; x=1774906171;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8fGTPmBY5vWGW1J+pc1gcodKZaPogmrWSzX6ByBHUis=;
 b=JF8wylt1Fjtjz+DoIxcYSsiDCATmTwrYv4rGMv+H2b3ImHHRyk0hkLr5XYf3ec2FrM
 7X6dMwWFsIxCUwziAuONVFeVBwmh7yOrBteMyO9+guzN8ZrhWnzm4ZU3/6/vCnndfcav
 CSR5bIao9KH3xojfml0LN4UUP8gyNZuGeu1TccdExs02wEu05hMUs5k9jW/R3wU7lyPA
 wlZCJ2FXaznDcW7upgRFzSduTZsGcdRBVAXvOKwyNG9js/MycLrF+ozsgDvs4xKvnWY5
 9qHCs+qTXNXWHlBDvDJzVj9oyGgmW0qOwo8yB2ypfJIWemqA8Q/2kXEnWrVeJJhSgjDZ
 9i0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774301371; x=1774906171;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8fGTPmBY5vWGW1J+pc1gcodKZaPogmrWSzX6ByBHUis=;
 b=NU17yZILv3l7qxR2fLYkiIieptfm4s5BpztsT6bn6htfXsv5rlcZs0+KZD+CVyK8DY
 vwvSV4WTxHFF+wTPZyJfYLMAn6JaQJDe6tuL6n3coQ7NSW//1CMQiSsTYULEn4ldbM3k
 JGPN19uRHl7UrrlFeFrt5IsbjX/aQTXRy39Y1NBSRZMQYnmybwm8zt6SYO8PZpAv3vba
 n08iplgyL1fn2ZZDNE22OQh2Rezy4peTIuHJYEd20qprn+Kr+tmA3ia2jlS581A0QNx2
 JaMBhX7QpMctWoxDLJwlsB19r8ZAbZWtX3Lwfxf4noTEkwWCVCDlUCentvikVP6DDy6z
 CSwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1zxHTc4GXrNVI0k4UgRSnrzdRn3l0NQEBxN5BRr0C29yn4Fs4AunYQQPFI1jtPEO5GcZN4wGlOxg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUNZg0etwL3HpZK08GH4Yd1u3tqzsGmBHEpvMdHt+i7MMV95FR
 ao7taahA3XRFoHAGrjeY5N1J+qVyt/ac2M3xBHAQRAn1nWI+mRLaBs5Lr9sMhX7EnfJLSXokYmb
 si4upUzOuUkSytKqPpcAAv25q3jAHsqIMxL3aqa8xnGYW6TgM61c2V992wkbET73bHtMfa3c=
X-Gm-Gg: ATEYQzxczZgyqGjjILMb51alEOLd7f22+CMR5zzcbsMpmW3AVGwvFgxnLXbkZXYWPtY
 patEmpkbDcLsfs/TyyoDLZlpN6dPefDIYpQvBwu+8+YNNmSU6HG5bDzpYBc7ky9UTOalsPJSEbA
 Hl7xFKLrU0NPYgiqC0R0NLYoXPMIhDgvM/iLHoxdtEAEoKaINUkA7yoWE5SElYKBvoAM8F+JWsk
 1NdOahfYnZ8ZuSwpTuekAeJfb7PkK/Kd1z4kvLNs1kuaNnww2yfuWRFNlSNmjA7bq7ohe9+j2RV
 zdXnAUi/n3W37Kkmlb3D+KAINPw1uJJX3azhUerNXc/FJga50AdefgQhMwt6EVUAN7TEiMG52xl
 r/LubxnsXTZq88lnctnugfyRTVLvBqQk0kJ7CizP+lr5ctIFy/mbqXaWpQFDIHTYJroFCszltNi
 kJXiCzp3ptfI0NucqKwRD3lqqlo+KwywFHLrI=
X-Received: by 2002:a05:622a:2c9:b0:509:172f:bd5 with SMTP id
 d75a77b69052e-50b3739f59fmr222809191cf.4.1774301371495; 
 Mon, 23 Mar 2026 14:29:31 -0700 (PDT)
X-Received: by 2002:a05:622a:2c9:b0:509:172f:bd5 with SMTP id
 d75a77b69052e-50b3739f59fmr222808921cf.4.1774301370999; 
 Mon, 23 Mar 2026 14:29:30 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285305fa1sm2662589e87.67.2026.03.23.14.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 14:29:29 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:29:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <rob.clark@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/16] drm/msm/a6xx: Use barriers while updating HFI Q
 headers
Message-ID: <s4jt64qc7rsbngkt3magrphvluclodlc6yopm4pnmmgjbno6l6@kfqcbsilsit6>
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
 <20260324-a8xx-gpu-batch2-v1-6-fc95b8d9c017@oss.qualcomm.com>
 <CACSVV02XkyT-om4LQJA_Xa-4Z+B5aKOPU_3uxtwHCa1nMXVUKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSVV02XkyT-om4LQJA_Xa-4Z+B5aKOPU_3uxtwHCa1nMXVUKg@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=VvUuwu2n c=1 sm=1 tr=0 ts=69c1b0bc cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=DHZr7MJB055T0w-EqowA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: m0PSIMr6-6986DcOQUoUMFSzBL-wQv0N
X-Proofpoint-ORIG-GUID: m0PSIMr6-6986DcOQUoUMFSzBL-wQv0N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE1OSBTYWx0ZWRfX7gfJidn7Wrpv
 sgVc2czqidDpclms8EmNiQHMmT7uarekK79j1+NvRGIVO2m9AhQv3Rc5I8ikZiDaPKFR+N7EAmN
 5My5DRHRSkZ1aytDTPHVKN5YGLpkd8FtVkD6wtt1FEvMOkDx9GbL716d1FVGsnmxzZNuKWQQNf5
 9AqMM/6oDJ0A1XpCoOrP7rq5f9YCz061Y9kfTIIMb/C7tFoPCrbMvHT6a/RxXMPmFTVUJ3Z4Nlo
 4bfrlF0V+e1IOCDT0jqzzMogPsCRX7asr4Awv6GAgGVvkM/N3CBnbmM2RZ9HEulsJUvzkmOWh4E
 YpIX/GQxcUbzXLSho8TAYyTGutAa8kAQsh6O9YK7hRmyOFS0zZmnZmG8IVZF+2KGI5Di1vOaHaw
 YwZctgDQ0Sqa2rsp50r2PO6b6Lf6DBFfw6ZhFYMFB0n/HxQn5MUX0BAy8TyYngPdDpDQCqDTYAC
 01YrVU5y/tmhvZjJ7dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230159
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

On Mon, Mar 23, 2026 at 01:45:16PM -0700, Rob Clark wrote:
> On Mon, Mar 23, 2026 at 1:13 PM Akhil P Oommen <akhilpo@oss.qualcomm.com> wrote:
> >
> > To avoid harmful compiler optimizations and IO reordering in the HW, use
> > barriers and READ/WRITE_ONCE helpers as necessary while accessing the HFI
> > queue index variables.
> 
> This feels a bit like it should have Fixes: ?

And as a friendly reminder, if it is a Fix, please move it towards the
start of the series.

-- 
With best wishes
Dmitry
