Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E8BE63FFD
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 21:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F2CA10E154;
	Sat,  4 Apr 2026 21:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iKEirlY4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HVeXaFOb";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B950010E154
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 21:57:49 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 634Li2762962991
 for <dri-devel@lists.freedesktop.org>; Sat, 4 Apr 2026 21:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ElmZ7iJb0cInL3gMdYY09UVw
 xjBUS65tHjlxby6xRGQ=; b=iKEirlY47e/C7JboreWhr/r/twR6Jqyrb8pQurQE
 NIwd/T3s/U01EcSNN4LFKK4QS/c9oyQ9b7Ezs2qhdi1lkAkIjIivHQUiHMOqTGm3
 LzySn5sQOLNqXjr+xJAEzvMPGxJLWOEGKaiU23U77e+FZ4hKubGfC1b4yifYQkkJ
 nq3/sq5R/AmGV/RCP18k55DpnWp5BiVmYxp3o1JfSuMW1GNgiUEyJOxkFAf5h+hz
 FJrwWBvTcbmc/RoyxYYqRDQkDtGC9zbNzHDvSxRq14mDCLov86SDhdJynjiLR9OC
 +Pms20qCqVgrk9Eo3Tqe/0EyNc6jeR6lgishx5pWn43ZXw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4daux89esn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 21:57:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5090e08dcfcso9157561cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 14:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775339868; x=1775944668;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ElmZ7iJb0cInL3gMdYY09UVwxjBUS65tHjlxby6xRGQ=;
 b=HVeXaFObbd6jPo0/SCJy63JqPHvXz6C5lUDhG3tpVAMYj2Rwp1UNUH8oiWr1CRjFGy
 Zfc7vrvjiWaC7VkL2gqcKeuJB9fDKWTaf3pu+LqHZWbLVOqqryvn3AyeTBYL6en8sfNj
 CUGeg8IN+zGjcErim907dHbUnaHOQaxHDUz/Ujn2eH/Mxr4amNh+CcU9ThrUBjV4Frqi
 +Mt/ztMjIyRULaAV67hXyMlFt+m2aLi8GhagF+8+Qrh8c7DXkhHPm9vk6HtzRPpeMpNG
 vAlRxjRpGkIQscF+MKM7+NpKlmmz2DcCeRkSUGRNec+6+wssjcOZc4N8ktChtz68NO5F
 ttjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775339868; x=1775944668;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ElmZ7iJb0cInL3gMdYY09UVwxjBUS65tHjlxby6xRGQ=;
 b=VmpL31oDNtINPujUtoFY4jEKf8hKl/p4Q097cU9hF0bqEna1s2FFcqQX51XzvqDbxr
 sbs5hsAZIowq1T7YD2ds7PwpcvaKQxVa1HS4tLZsW+P7GtMmSMW2rlagm1/RmZNFbs1Y
 i2DOqOBbYfjXt9V1Xu60B6+qaulRCn1ouHukwC9NEiHerJvAdmMe5hjTUrNK+PRo64MB
 lGxrDwBhhNw1X5jH0XCJhIQ0VeUNL/61HmhNX0JnBw05B0XfaQzYSm+rlm0NQHCJWLBo
 NUYkGobfB0dB+Oj9u/RFIf206uF7U7vW/9R7lbGk7L//5IyIQsnQwvth6cndBlWKQV6S
 eMlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcnigOgj8udxd+UyvJNXnKgQMHRcdofEXrmkmKOFXPI51op2aAReI1TtFDvDnBmWLmd3f8kZr2+sk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyTLrbaGAwMNAHFzdR0fxTRL4fSY7SshM1tZRjYFPSUtLO0sERq
 2Y40sblaCOoMFto5XTkMJc2J8P6nM6bOP+PlssENxxapAu0ph7WdMiPlKXfwBibB6H9U2HELbVf
 pXffOiHc+DtgM4iTZzmXW+e9IisGLgeOLAi2S80bN0kJ3l58ms3JXymcvNX0Ax4Pda0M8R/U=
X-Gm-Gg: AeBDieuS/sLZITIDGTscI1VLtWdu0ITx4GcOqj8qYxu/jHdnWHj/gUEoVriDoivkQxa
 36eGepn2HnmKHLg9f7/aoxwO8RT8FByFhdxLmZaB9G3D1ku2nr5N2036yqkKRyBLDYuPsa18SIG
 yw1gM6bAp01Uen4nqJrZwprp9UmOWajtN6LkDavyXZ67Kf5RChI2P+URh4Qlj4J4seO0pg9aj63
 tXLe6IlvpWwJcCaooUCzrpzWigcRpAEHf4sxpreePv7hOvPFiflAwypq/U0yy2q2Fp/Mi0c3MV6
 iUbX8g4wC5JM6mAi5X5IcoCjNFSy92UdrwkkmSo34KYPpNs1gcXyfuL2/BBsjdCcze8/V2yGOyM
 8U4gy14Tf27JByPrU+5fO4bBp85h1WMF5j4jSX80ZJC/f9niK2IKqxd89ci1tOlgvq3mZ4Q7lcf
 ABp4/CKGLfStUDg4xtyLPVYfRpwVAKJ+gzMSg=
X-Received: by 2002:ac8:7f07:0:b0:50b:526c:541c with SMTP id
 d75a77b69052e-50d62d0f97dmr120363201cf.50.1775339868189; 
 Sat, 04 Apr 2026 14:57:48 -0700 (PDT)
X-Received: by 2002:ac8:7f07:0:b0:50b:526c:541c with SMTP id
 d75a77b69052e-50d62d0f97dmr120362871cf.50.1775339867784; 
 Sat, 04 Apr 2026 14:57:47 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cd1fffb53sm20787601fa.16.2026.04.04.14.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 14:57:45 -0700 (PDT)
Date: Sun, 5 Apr 2026 00:57:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH RFC v2 6/6] arm64: dts: qcom: milos: Add Adreno 810 GPU
 and GMU nodes
Message-ID: <ahv2d5zmbh7s5t7uu3s3kepkv3ecpxukfqy7hqnzjd3qhuaw4n@bpprcym53jce>
References: <20260402-adreno-810-v2-0-ce337ca87a9e@pm.me>
 <20260402-adreno-810-v2-6-ce337ca87a9e@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-adreno-810-v2-6-ce337ca87a9e@pm.me>
X-Proofpoint-ORIG-GUID: Ib-RlDqCUgNrevU19g56YHxKfEVahkpX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDIxMCBTYWx0ZWRfX/oiD4tETDu/m
 lu/bYevUYQbdMFm/YdchXPTEKv2pioZDEy64bqzjysvoW29Cvc3GyjMea7AROxfIRUclW5elzxL
 nGA8Oz1G+t+c8caeY1gujM5tTACP4Jata6s+Uw2OQX0vYshOpEx4QfCT1Usa/5/Zjgz83D4jFyO
 GS3dOYZFmhC6Cb8hnV4cZ80h6DwQ+DpzGBT5yomAA8NEXWRWlQy/L5cfOQZUYw8yvQJiGwJF8gV
 ohlf2xPrqZBIJCskcmEXBVNtrhMAEO4HwV4hDmPRin4GeqfRwlepYpTQzAdc3w4ivebjHPA6o6w
 Jd8+uK5Gbg0fYpyDqec2sNW3yU8ANrBjVVc2msxZ7FJ5tlwhiXXyJ+Waw4uNoCMK4wOaPZOb7JP
 ZpLcWdTRI7pz/8Wc8wIJ3+Vt8abwe03cjMwCZ42vxf3XDv5qFLlYdpz+1cXHnKPeXN22T3LfzN6
 7PKOjbxvoX9ngOPGrMg==
X-Proofpoint-GUID: Ib-RlDqCUgNrevU19g56YHxKfEVahkpX
X-Authority-Analysis: v=2.4 cv=AuzjHe9P c=1 sm=1 tr=0 ts=69d1895d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=REw7ijk5hhyOG_fLH2gA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604040210
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

On Thu, Apr 02, 2026 at 11:09:52PM +0000, Alexander Koskovich wrote:
> Add GPU and GMU devicetree nodes for the Adreno 810 GPU found on
> Qualcomm SM7635 (Milos) based devices.
> 
> The qcom,kaanapali-gxclkctl.h header can be reused here because
> Milos uses the same driver and the GX_CLKCTL_GX_GDSC definition
> is identical.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  arch/arm64/boot/dts/qcom/milos.dtsi | 148 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 148 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
