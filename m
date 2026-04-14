Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C878BF9D0E2
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 16:07:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1323810E625;
	Tue, 14 Apr 2026 16:07:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nP/YenIR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UW3mDBcs";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A63F10E622
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 16:07:17 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63EBo48D3157277
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 16:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=r8YC4bmsxOPBG90j4a6UAmrj
 B7uMPv7sbwMF4a52oOY=; b=nP/YenIR4jOGllbuRsZ7DYI9jfWjRh0N7xtCl0e3
 RC0QgsK3XDEMG8ONwPo1ACluyB9lk20sgbFUBUM8Y74Rt0tsdyuLuys602sduVwL
 asay3EuMq6W+aHUj+O7cMW3W72QnpRWBAo/EalZZL/sFQ1DeBxT04GFHFJ7W6TLW
 OO2NkjU6wKR28tC434Ln4bx1ZRMF6PWWbi6Keoha1UMQPq2/PNocM9zabNxlR4wR
 rrJRGnlPIaKEiChjgH6oE8XVf2A5KIJCSK25nZXLo9QAFBpGgEAPiJ7W5HZeukL/
 nelSBGLS81249AZF6vwVLIgfyddgiZdnjllWQrRok4HeOw==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86bbf4w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 16:07:16 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-46fab90a5e2so5456648b6e.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 09:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776182836; x=1776787636;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=r8YC4bmsxOPBG90j4a6UAmrjB7uMPv7sbwMF4a52oOY=;
 b=UW3mDBcsYYKEiDp/zQAnxwT5y541sBWcGJOxQWAXvzJC2cTbEC5RPujFbNGYULcovf
 wWQHK43W7y04xDuyVFKmj4XcSabRJJWel6l07aDBRGjUAxhU0ZVcAL57oFWbx+3kAUiB
 Zc1YDTOFuEQebuYn4mD6TYxQI2NHeyxeWGoTGx94lIq3dElApZCsvFbx6BGpcVkvuYVn
 NuCob6kST7Qbhrwqj/4WVakpjiKYsrBH3XqTOXytsnhbP4PJlj/zrH8R/FT8O9rA0D1T
 eh2vAqG5PLnQRAKLgmZB3lwRE4lw+d9VgSEsZ8x/0/9DbFYAXZoIL2RhjabUo2qD7JJl
 PWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776182836; x=1776787636;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r8YC4bmsxOPBG90j4a6UAmrjB7uMPv7sbwMF4a52oOY=;
 b=mou5VfCQIOGnfdL/1IVEg84YBH9KXcmTEtJ1l3C+Qp9ECoFJiJZrQLk3OStqp/jb/3
 30BPzTFZadT8h62vpB8VQD9CtKNSMv+wFRKuHlmP8mT0okJsQK/vpneGSq/Sek0xGzUK
 eZb/7rxPnUX0VnaJlJAdlWIwcaT9Kmwob1NXCz3r09NthozfsUSjJ8SlQGyoN0nc5yYx
 i/fxDxPNS7H/AJ0FF0lSkFzhQ6JZvUj0C6snZCf9tOCfjO3+Nc9tYhXQSLq2Bzcm1tVv
 BeaXK0NgIQZDbfRxyqQ83isVVhOEXgndclmYSxacj5AFRSIvhisM8dPys7vWRcS+GOJ0
 oPXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FV5gwtm2JiUpV3toEdKOWw+5jh5pIM7rHCk/lTcUGPWrzcq+c4ClK45HCDB+vOYo7o7+Q2WUZvVA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+Pi8mC3DGp0Wmlvm3enaJSivfEzMIGm50nuWGTX+DPWZjLcRT
 fbWjKLecrNqEq62udtuA16XCWy1386YP2wftOvr3M0l4n7rF49eyn2gKhlCKRuA6XDCFXiSaW6K
 iJA0AL4Mv2V4dXVaQoUvzZCfsYuTyjEgXLg8yxRXd9MouyKEK8Ue7c60yJS0M8pVetrMVnow=
X-Gm-Gg: AeBDieuLngEcMlHxsyPUokWEQIDsncMp9IsEjBKmbzluZ7RBDBn5ZfEnPm1p5GH0GM9
 GY77p1AUwBH+00tyz5vkQxiH5YA0Y/8SW5QB7RUsdCvC87fi9RULb64f5uT4nnNZfIIOo696abZ
 DlpBYS96sytsIIJpm1LneLbVkP/hIgUUW+1lRmezVgAoh4CN7HR2dwWZT4KW9cFstS83z/VO8HL
 j/aKi0C9ca/pmZ4XkrMY3CgkGuvzj7Z5mdk7fFGf6pJwmxLT5ofAmxV62LwmWahrzm34m6P5v79
 M7dU4EqQ7t/wviSaXipG+nTMk+vRjXxvE5J3EIWu6ohOBmpaUADZ3Tp37tJFKB8/lef4tH/5PTO
 9sHE1V5UAO0paW1DWSI5SspAKq/F9OnzfOyUh58vZk5Ye2CKm9D0qYREZb+eKxefYzns9mYOoPi
 5zwP6H9+1SiC9BJQ3/ZHBi7gx0xrIwk1tmHGS87OkFsfaRAw==
X-Received: by 2002:a05:6808:1391:b0:467:1ad3:7ee with SMTP id
 5614622812f47-4789f10b778mr8687040b6e.40.1776182835721; 
 Tue, 14 Apr 2026 09:07:15 -0700 (PDT)
X-Received: by 2002:a05:6808:1391:b0:467:1ad3:7ee with SMTP id
 5614622812f47-4789f10b778mr8687025b6e.40.1776182835264; 
 Tue, 14 Apr 2026 09:07:15 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3fe7db21esm1301462e87.51.2026.04.14.09.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 09:07:12 -0700 (PDT)
Date: Tue, 14 Apr 2026 19:07:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: fix UV scanlines calculation for YUV UBWC
 formats
Message-ID: <sgybjwtuj7ke4w2imsezuw62meitngg6hkz4eam5pmz72vv6e7@jqqc66bmz77s>
References: <20260414-topic-sm8x50-msm-dpu1-formats-qc10c-v1-1-0b62325b9030@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-topic-sm8x50-msm-dpu1-formats-qc10c-v1-1-0b62325b9030@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE1MSBTYWx0ZWRfX55XCipikJBE5
 Iyi1ikoeffzhFR5qF7xoLWFExSgN3J0njaIza6OACbK+nrtq4mSk8ejEKQq1R+PaeTO6PVC8Iz0
 Mw6q4RwSHjyJl9ovrVXZY0mWSfh+GywpPJm+YjRN1N7nrDZ79XQdvQw2UANsRyAKrjrVG+4LIYK
 aEqIcN1gmBBG4G9GUbJDrgl7ESQsJRI6IKt/eVJooaEIOG+sIj9oiyiwhlP8NS0rI74nO1KxMTr
 qnturWJHFHqcIJcV7usbHJPKO9db+1m9uxrq6+ql/cHW32r4TdcuDXkOMju5MeopiAUagbI12Ad
 9THikwKl9B3TG5Ne+DVzn0HalI1jc0J27t/dpgs/8+CACzUcJGudpkNWKSxyxiPvXFd4QaAmdaD
 m3U5ov7iDhg3qmWaILLuz1HG9zGwDSHpkpskNMN4JytCjYJaDzbQPK7xP9wHpxczQkvh0fV1CQm
 88ayATVWmhEh7AvS3hw==
X-Authority-Analysis: v=2.4 cv=MahcfZ/f c=1 sm=1 tr=0 ts=69de6634 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=fVZ1-b_OFI8MV6liJMAA:9 a=CjuIK1q_8ugA:10
 a=pF_qn-MSjDawc0seGVz6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 9owtmBJLOvh45xyQGsMlhPRRd1sy7nCV
X-Proofpoint-GUID: 9owtmBJLOvh45xyQGsMlhPRRd1sy7nCV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140151
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

On Tue, Apr 14, 2026 at 05:14:30PM +0200, Neil Armstrong wrote:
> The UV scanlines is calculated with (height + 1) / 2 unlike
> the Y scanlines, add back the correct scanlines calculation
> for UBWC YUV formats.
> 
> Fixes: 2f3ff6ab8f5c ("drm/msm/dpu: use standard functions in _dpu_format_populate_plane_sizes_ubwc()")
> Fixes: ada4a19ed21c ("drm/msm/dpu: rewrite _dpu_format_populate_plane_sizes_ubwc()")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
