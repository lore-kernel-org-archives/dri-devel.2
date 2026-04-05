Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB628E63FF9
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 02:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB44210E03B;
	Sun,  5 Apr 2026 02:08:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nHS5l1IT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R+a+4EnE";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB45110E00F
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 02:08:35 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 634JF7J63591533
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Apr 2026 02:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=FQ+C8B2+GVFz9XgKRp+WYhAw
 NEfDJtAsm9FbCzmQGDQ=; b=nHS5l1ITFHZKIKuI0GmPZcrEMbMnkXpdrj9oMD2G
 kIXbsvtUqT82Qs5C/TymXJ1Fyie1F33ms1HB5FNJYBj4gvEXAzvBYB5+pJeaR2Ce
 xgfbLVd3owA5Gt3rjQAOYa+eWVrdAkpQrgqEnrI2jovouKz05dFSWINLJiWVrTcK
 ZHwrpdEk+fkVswwhH0g7YsOrZBLgnkfOYhXmHjDMAw3F+Ok9xZ9LS6jVzkVwMnYY
 zrFA6hVFoLlcfjfhyH04jAQ32r6gZcM2XOTQKvshB/6qyLgMdmHsOtX/rzpKxtYq
 jNeD20cpe46TShbSCrMsQvHV+O2e4wrAU0QuoGKuzc1yZg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dar0mj168-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 02:08:34 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50d84b5f73bso12268221cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 19:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775354914; x=1775959714;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FQ+C8B2+GVFz9XgKRp+WYhAwNEfDJtAsm9FbCzmQGDQ=;
 b=R+a+4EnEUOzjf5nVUzjrd6yPn+2MxybF15Qf3YBzxOzwtH742uAIKBBx1u0BvDryMe
 JZilVYPl+qVDYoRvyHjatToBAAyH9O/EqxdN0EAG7jzOjVnHpud0e39KPHlW3llLjvZV
 NwjJiu6gxxEaGQ3uEHk8M8cHGwBuaMYy1VPRS2GztBM+8qX3w2u/CHcCWa3IO1VyXB60
 t4qgbZm4Z7SJlNy4iGGcvS1wrZ5DwTOuE/R5SMpMBKz+up5e0c39Ic3Mr+iRzDbDcYC1
 wuI3AkaFU10x2XEc4O1QJPpMKHiZJyjI24n3h8y2zD22sLWIvHxBeF9G+6dF2RRhIrGA
 YTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775354914; x=1775959714;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FQ+C8B2+GVFz9XgKRp+WYhAwNEfDJtAsm9FbCzmQGDQ=;
 b=HcyEkpbONdAl/8XsefizrTB6fWBpIk71DbmXnz71kQ8eZtpqMddN1x+J47mlF8gTTU
 xBQG4+RnM3XckdAtgo/k8MMjp02guFNjYpwHMERKYpidWrxd82bu4d7jTKpdW8RT9Jdm
 HnOzO+U1kEiyPTu2m4Hhvuax3es7q12vddhjSElK1JPhW7eYRgc82lZwcsXYW0vwPd6D
 DhuzQay69geLPhXcvCNKy3MnlDy1Jk4WKKNvUNM1DI5Zj3uujKW97g5lQsDyUIQqFX9A
 nK5xeNhM4JZEb6habhqDWvYWk4Qh0Y6t4iVPVb8s2T+s61gEgszDq0Ts/X1M8aym52nL
 uNUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN5UTnAZ+/53Tg7KKgfGjGiaVwBIbP+472USkunH2tnuXrHd3cAfBg085I3bSQ6gAd9sascNhdyC8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDkPINTi4BtUmA+3vAO9SNf7WjgNmRo/nsIHDPERKzadIAthhr
 jyNTy7JajWYcctuyqbYBxtD9eCrl9YRqe19aqwdKB6QznjFM7sYWx2viZxMm3AajzIMGsrw3+ii
 r1WFIspW/A+jQDgYIDhYtDtRi66Q50KpispFeFb0YU7fkzp1E5CExWwXTDjp3+jipK+fvDWc=
X-Gm-Gg: AeBDievxA5uXd2rjgf2StwNCbTAA9kBpfMqCqFjeYKLz6C+02cbdKzx/y2F91h6EO0l
 tkTFb+QuZEDBnd9uEOgzGB06Kcryq0+HFNsm4LapRUkFEJoQZYRISE2PMNvsluoMTzGeVm8Hysr
 TsIMIWxQ/zrHRNhqCIuHhyTUjGw95j5MvipgNrDPLr0l1kf49FHbKbTlNOFWBHPuP4ODl9u/o23
 aJUxY83FLaIL5aaPn9DqGmTQZbZ7yEKt6A782XQobA9RB4NCiLDZZORix9YmDmrYpcEsdLih/6f
 7NFK0qz/PIpEvtVRqHFNa/MfFr5zkZmFq6Vk0Az/TCOJMhcA/f08ADgmjTIip6ttLoUY1BW9mlm
 dcUmJq8cg5iFfCCpXIrCriYsCdOeS3rWwM9i2UgG3XW3a+T6CWOyVxPRW41OrYc38GfZpNVutE/
 x1I+fjNWV/FAjVFCoFa7hd8u6bpSTE6FNnkRE=
X-Received: by 2002:a05:622a:1f97:b0:509:2b5a:7ff with SMTP id
 d75a77b69052e-50d625009c0mr131779361cf.10.1775354913896; 
 Sat, 04 Apr 2026 19:08:33 -0700 (PDT)
X-Received: by 2002:a05:622a:1f97:b0:509:2b5a:7ff with SMTP id
 d75a77b69052e-50d625009c0mr131779061cf.10.1775354913454; 
 Sat, 04 Apr 2026 19:08:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2c6ccca2dsm2426269e87.60.2026.04.04.19.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 19:08:30 -0700 (PDT)
Date: Sun, 5 Apr 2026 05:08:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 6/7] arm64: dts: qcom: sm8750: Correct and complete DP
 address spaces
Message-ID: <wg45gdnnkqulbmo7ip4drddksmd27ronqen4mftspbs7tjjuwt@2ymjmymxnfrn>
References: <20260402-dts-qcom-display-regs-v1-0-daa54ab448a3@oss.qualcomm.com>
 <20260402-dts-qcom-display-regs-v1-6-daa54ab448a3@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-dts-qcom-display-regs-v1-6-daa54ab448a3@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: SImg9DwFAVTXijftRG0Bargo283PwGWE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDAxOSBTYWx0ZWRfX5/Me+hKr1aCA
 Ouaf33odtyCrsW4xRP3dGKRqPtJ7Pc61vYWpQz2sCvDoGEBMR3966VfO4F+wtfdCgcKUzgQsuNd
 a/+0+7zVNfzJ+w9RIuRFI8R3QOd8ctEukrmMh6p0qryjgVZTiRZP7SYpywppDgTiS/BSAUNylOq
 1z48uCR6M6Fttdc/yABbUAKWsSpJYx0auKfJ68xdySnzkedClhI4pxtfe5PqMOiJiROCkwsZVY/
 qakVBRE1d006ffM6WORijAeuHmzO33FqZyDNef0z2HmmaofhTO4Dsryjn5qSAAEx+dAtMNCD0Rs
 DcH4tIPRw6Ic03fMY37o5RIPi8lWvhgj58gQW8tnQs0YjawaKehCy+yErHZEMU06ty+TBa75dBi
 CPshXO5Ndqf+ZtKF72mlVyU0rC2qLKhhJdmBdHZjdPXXjH1TnuiOpLbZqQIlF2UCruOU6IlLVXU
 xc/h0gzgq+T4/lHvQ1g==
X-Authority-Analysis: v=2.4 cv=PpaergM3 c=1 sm=1 tr=0 ts=69d1c422 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=EqZgH2Tm9vfPv3d_J88A:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: SImg9DwFAVTXijftRG0Bargo283PwGWE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604050019
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

On Thu, Apr 02, 2026 at 01:45:17PM +0200, Krzysztof Kozlowski wrote:
> DisplayPort block on Qualcomm SM8750 has few too short address space
> ranges and misses four more spaces.  Complete the hardware description,
> which in the future might be important for full feature support.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---
> 
> dtbs_check success depends on the binding change (first commit).
> ---
>  arch/arm64/boot/dts/qcom/sm8750.dtsi | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
