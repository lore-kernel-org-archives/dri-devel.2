Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C91CA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 01:05:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 376CE10E8D8;
	Mon,  5 Oct 2026 01:05:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CHIl7WMc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FFsK28NR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0F2E10E8D8
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 01:05:10 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695102aD291392
 for <dri-devel@lists.freedesktop.org>; Mon, 5 Oct 2026 01:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=+4pnXRuP5CcnmgcmUqfYx2/q
 Ua4INOWTnjZBnXUGk14=; b=CHIl7WMcpYP1PU+FDQHLoT6+mprWCeWMYCUVHH/c
 BUNZOoUx6dIMOqmiBd9BBo5FN6c2ZYYy0B8zQkDLtSGKiJpaO7w6yz84LqpbBeGw
 47fnTybdS4ldS+E+a11p0GovalhEcTHVJ4m9xT14gMFAD/DArUqVc6qnNUfT2Isp
 c5mn6s+IIjDXLrZQ7Sc+XredfzjTPdI6joZMM8vhmLNgXoQap4gN/kuaIPpBQoFL
 oMo4jHHXvP9fNk20VcsrXJyW43frcOECg/6MRSJ+33JTSYu/wfKGwczrLg0fQSde
 Zisk8lJgVi5pBT2lOKwz8VvsLUpE0kV5dPVmA1Ea+OqsiA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3xhs0a8m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 01:05:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cc5f70c8dso124231985a.3
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 18:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791162309; x=1791767109;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+4pnXRuP5CcnmgcmUqfYx2/qUa4INOWTnjZBnXUGk14=;
 b=FFsK28NR6hyZIFPTG6VuHOGGSr4O1g/u8CMdhCsXAXQMXEd96y+oWpzvzkizYhsYuD
 dQQDPERjremRHafgdsMiMHDgdzAOHgEKdROVCu0nBctWdd/Z4g3YeBI3khxI2CjEXbRx
 ZDNP03maZL9aMra9RVuseSrpLtXg2rnC+DWEYKU2xomU1lmQYuFsoSY03bAlTzu1WkJQ
 hdDko+4tbp9e7L137zsI0F1lqSKsL+W0V/ECZtQOp0Idz+6Cs18fL9TVnW/U+kaSV5MI
 FaxypMjD/sHCNaOn48FIBJsJ8P2gHzyu+DikYtWIhBKnRYHVCeOcukxHoQGUT89S/fl4
 VnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791162309; x=1791767109;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+4pnXRuP5CcnmgcmUqfYx2/qUa4INOWTnjZBnXUGk14=;
 b=BugrjJpE9ze2PCw/UulddQC7udEgyRsQGmikR9rABRVXrTplwp52tR1WZ/q4FOri9k
 f4RM9wlXkQ4eW+eGnNWA+N1HYh8ewPKmQ5WY1HOC+hVIdkOIMhpGiw5F8CxOY9TolK8z
 qbOQFEQXNZXsk704iG0ypt/egVbnwzpUY9ML9z7sGOgeGfEf3o7Mt3iehEueJrhdZeQ5
 bEaDU6wyBfKtMClmsyRFtiTi6DJZBVLf2HvJ0IG8PO/yQKpGsppb+o/nXQMtTd4ctTDr
 rFZws1wOb2RVVXc+m+31dBzvK3WdcKPhnmcCOfUNewxqul7B9M+YyPr8ZHE8OZn5JkZ/
 QqZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDwobb2be7Y1VpdHXZZ9CvClSq2saydOuGW87Mm8f8/uv+oOhGcbyNPoNXxo2lspJqJ317VuZIhlY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mE6fYHgttQsmnzz3rfvrNFL5bvcf1qvwsr1fM4eGacCxevtnz5
 oIGP284P83WBK7+7UtHY+9zR89OD+9IZm57MmOfsn8ft8fmyxjcLJfHHBEn0Orwn6aBI6uOqSvp
 6eAD9lrT6PRSPrlFZGnF/bjkM8eX6A7/OzqZShtVMorB49P71BqzJAlbfJS4kvZvbICaaPtk=
X-Gm-Gg: AYBFou0tcsFyjeSytWJDo13dfFZqnqyMIYihvXypv2VY/hTLSse42J3xBYcpAb1s/Ps
 zVkwqjoNypr8RLUVzXxejKk54PLH9W8gUECdhPI8kB8+oAR6GMc6cMF8u/TUjET7uAJsKaM6OPY
 Y6AJypwVoRAr1CFvTzxarYeYCYbk64ydOdihR/9COOMmBQaA0+rh8+h+jqmgFn5Un5qm/mHkH0H
 4MO7RJ8LmmjsDPLaFZIBYI9lQxV1coCMWSHNajrSpwBOZA+B0zprr3+AQJ2ijZcdWFdJIqZfkJL
 12SAlkaW2HRkVobsUtEKP5u7b7KxOPRhZri0cd1ou4Dfr0PvJrQyE5aKiAUJ7GaCYlcW/aI5tVF
 VWQbfugpYA80p0VE5HPckQ/7G6+z+WNJyZAq+IKalpqPfCr2AEzkBG6ONMiY0ip+L6qlYwSaSQW
 HdxFpgzEuK55QQ
X-Received: by 2002:a05:620a:684a:b0:93c:70f9:8961 with SMTP id
 af79cd13be357-93e51122d54mr1195941085a.61.1791162309039; 
 Sun, 04 Oct 2026 18:05:09 -0700 (PDT)
X-Received: by 2002:a05:620a:684a:b0:93c:70f9:8961 with SMTP id
 af79cd13be357-93e51122d54mr1195935985a.61.1791162308512; 
 Sun, 04 Oct 2026 18:05:08 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7c78bd83sm2760522e87.14.2026.10.04.18.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 18:05:07 -0700 (PDT)
Date: Mon, 5 Oct 2026 04:05:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] drm/msm/dpu: Attach INT2 power domain alongside
 MMCX on Kaanapali
Message-ID: <4nmgi3mec35nnvxuruonq5zx3npr5psjicdn6kgxy26t3alwa6@oz2csuuzwpbf>
References: <20260915-msm_gdsc2-v2-0-9157237b8382@oss.qualcomm.com>
 <20260915-msm_gdsc2-v2-2-9157237b8382@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915-msm_gdsc2-v2-2-9157237b8382@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: jroaY5U6AL3CF2DaROLqG2CvsIW29-y7
X-Proofpoint-GUID: jroaY5U6AL3CF2DaROLqG2CvsIW29-y7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAwNCBTYWx0ZWRfX8PR45fxslKdm
 L8J8N8lN13ETxyV6cOJRjkz8oWtAUHLAlwwD/EdLS0uPxr2m2xvVeQ7BARE0ydVCzvBvOsWKPjT
 ExyIiY2NDPJKEGwbU2McWnsFez1wS+0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAwNCBTYWx0ZWRfX/xbV4Dehznpw
 yrVjWKqRB/tOw32g/vUU4AnbYiD62HnB/jR7aXrlKymvJrjdaV1sSkWiRxULSn2Qoe4w4HFpaGr
 0quVa9+FTUBNDG5yIsOprnBPJK4PTzAgnq7uoO3HnsGQl59uYhHcULf3BO1Y7vujSXIPRW4JlML
 R7b+kBK6zteCC/LLh8bC/fUv9fKEZVBSLfxaknyjXgoFEYgiDZNwCyaChoXjNlUBCkv1DiNq8cN
 t7fdHHvq7zEatGixO4CancIjTIjI6g0ylOV93TUpcHPzf+FeIYtBCZTVa9yF7eWntzGEXCnD52m
 UsRly5+uAs5/UdE1KOZ46/mnlj9jIKo55FpnFCqXBfWPRcKlCxRp9RUK8lh0QyRA8IyQmbqQTa1
 KIO9uxHBX0k/sJX92dnawmjQ2Q4M0yad/Hz+g4lYo1Gf22lR9csa/FVoVelVkBQs642++ZPI2Vy
 xY6jLZdYQPxI+IOgwcw==
X-Authority-Analysis: v=2.4 cv=Q6tHcI2a c=1 sm=1 tr=0 ts=6ac2f7c5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=8KN31ognrfrXisba-IgA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050004
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

On Tue, Sep 15, 2026 at 05:27:49PM +0800, Yongxing Mou wrote:
> Kaanapali's DPU node lists two power domains when its DT provides
> both MMCX and INT2 GDSC. The power-domain core only auto-attaches a
> single power domain; with two phandles it leaves the device
> unattached to either, so attach both explicitly.
> 
> MMCX keeps PD_FLAG_REQUIRED_OPP, preserving its existing OPP-based
> performance-state voting. INT2 has no OPP of its own and is attached
> as a plain runtime-PM supplier, via the device link the attach API
> creates automatically, so it needs no manual pm_runtime get/put in
> the enable/disable paths.
> 
> Platforms with a single power domain are unaffected and continue to
> rely on the core's existing single-domain auto-attach.
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
