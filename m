Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22CDC43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:31:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1973410E3E7;
	Mon,  6 Jul 2026 21:31:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EM4BFVw1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JEnCQNGO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78BFD10E3E7
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 21:31:17 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEPqJ1613995
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 21:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=fzc0UyfTLrZB1zWo/aKngVCr
 9fX2cKPgrJwdh7m6pAE=; b=EM4BFVw1U6C44bzQw34O8jRKusvwreqOly1nZt1U
 oUhDEvwvB84iMe50TpYtYotIRmv6LnsjGV0QrJlnDBBMdEGm8fJuwvUR2G7hXQDw
 sh5GgBKavN6YTF4EHHthKno/Sbckz2rDTTyEtWtmYfUfuudttKmfTfXp4H2BeP+3
 QlFwddHyHWpvXpQr6bE8Jp57G4SbtS40GCN3Qy5/04f1pSHm+4PkBsUmQAjwpwW5
 j/FTha4md5OulfNuShjkXnVoz+PBxXkxtV8Fy89xQAUilimimyGvgJp1W21383Cb
 q39IfzkWdNNWJRfy8bbOZqXLtMps+PbzZhm8Q0IYgKzADQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h53c5x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 21:31:16 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5174a236220so32498451cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 14:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783373476; x=1783978276;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fzc0UyfTLrZB1zWo/aKngVCr9fX2cKPgrJwdh7m6pAE=;
 b=JEnCQNGO0CAjcu1cTW7EGOh316yJc0ymMReOuz1iu9VaHjmJLv3140471bPSzrFHj1
 xBFBh8wsbJRcI60HfsEYnDSzzionwzYM+T3yLHW2Sno9DhcM+3FhJUyXb/QFLX+M+Z0M
 SfWHXhRK6EHVgH3mVtgcRp9ZU4j+ushtAkL5B1k+7B5890UiyZYRHrk+DNIQWAXNjR3V
 t1Sj40CSbk9Psx8NW6jNmlj+hBSm93wpkKFW96tCiPbv0gEdIYPFkdV2z0WUFdun68qR
 T04H/EPjqiy/qeYtGvQrTPRt0SY7Adzs8LtIQocELjePKa+MmkdBdzB2ZL6dpmAJw1rW
 qxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783373476; x=1783978276;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fzc0UyfTLrZB1zWo/aKngVCr9fX2cKPgrJwdh7m6pAE=;
 b=CNYNsda/yAoiFqe/0iWysyBpHFj2//CUfAYla9DQXDIeJTNs6mF+LwXHffxGe1+eCs
 OYpgjsLDktrYq4fdxwlpkzBt/yrdu+NKk2E3BmT47nmQrsvh8cUqiD5fL6k6/JKDsuyH
 5slPGyNz5pysEvnPk7AfGpfKhqPfdbGa+zbNG6LLTB0+gktqGAA48NZ9RgOKufSaC8Tg
 zdpwfmu9lpFeur4EmZUECIdB8/fw4No8FWdcXDn1X5t42HRmOiz+NX2dx/mGCMbpvw8S
 s5ogU8B8hZcKBcTXECZwFqbQPKl6N3X/3/FB3DF1NlgzwPIjHMYpsrf0Bcqq3BDoWee7
 AaEA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoS78Wbe86W24g4qAhnvfh1FiDYPvdvZcgyy86MMUIX+EQ+//ii1NrYY8AUJ9iu0IqLZQ7MxhZGXBU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyeTWES7w68fyRrJ/H7tsIh+cpNIJ352HmN6v8DHjtJYyNzln9o
 Zrl7lGOUrkjth2Zj/fcAdinOvyRn9/58kB0N1iH8ADCZxmGDLgcZs3RyyOsbK62JLVuVE39fkbO
 NmRBhn9ybEObGfLF5YZey5opbgmG785R1Q2AZjmqlA8N3pcky9+ZdthAYlhACILUZHxGbz1w=
X-Gm-Gg: AfdE7cm1OVziOtFHjkB/ujI2LKyAIpzfKkrPTJnuL8X0pnd4CMe85MCWSwThWZJsPrf
 eJi8MZOGKQhRBCPLACJKsVu0uDg7geo2HbEsCtDTwpzYUnrog+PqVtedsPEde/e0UBCEFFTOLAd
 Dk0ydrfbAltTga3a27vyoi+lNZFUdntqEKAcWyvyEI5WDfrCV88BB+1vWMbdnxSWXDUWUsiuoVj
 NjjiJmqD/2f3DmOQM8Ga3FrYZqh/MYdmJsheb+R1n6vCqk4r7YSRKFrVEs2yhEK/sLoiz6ktD9b
 f8w3INTXzqGEv7Zp2NbPsnq14MkUlqHwVHaEPMRZQA++vTdfe7i81J8y9pGJTy0AFKQCV7shh20
 aGmUjZ5z9AMcoZ8zDnPf6vDWsM/xo8gUDdOljKUoAubaYFQRw0q+TCUK+nxcevYHC/ZtxjnLD2N
 13FyAOZX2s11MFcDWg2XbO2Jg1
X-Received: by 2002:a05:622a:248:b0:517:8011:3a4b with SMTP id
 d75a77b69052e-51c747be066mr29060271cf.21.1783373475650; 
 Mon, 06 Jul 2026 14:31:15 -0700 (PDT)
X-Received: by 2002:a05:622a:248:b0:517:8011:3a4b with SMTP id
 d75a77b69052e-51c747be066mr29059761cf.21.1783373475081; 
 Mon, 06 Jul 2026 14:31:15 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aed13bb417sm3124713e87.50.2026.07.06.14.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 14:31:13 -0700 (PDT)
Date: Tue, 7 Jul 2026 00:31:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Qingqing Zhou <quic_qqzhou@quicinc.com>
Subject: Re: [PATCH v2 3/8] arm64: dts: qcom: kaanapali: add the GPU SMMU node
Message-ID: <u5jvkfixrm23gugwlnpwq3ov26gf2yqf3pjntcl3k5t5wormet@powdt4jkmqmo>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
 <20260705-kaana-gpu-dt-v2-3-6ac53de56314@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-kaana-gpu-dt-v2-3-6ac53de56314@oss.qualcomm.com>
X-Proofpoint-GUID: YY1dFKGURP_AZxelHwNwP9CaeWChMwne
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxNyBTYWx0ZWRfX1jgAvVxjO58k
 EpW1Vr7qVtuzrFRcDYFocshNueNBOhdn/rBVAr5GZt5Ivd7KA8bczB05PXf8Q5nCciI1mmLD4/Q
 hoS83qUg2LBGrLxIC605JH1QvasxVsk=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4c1ea4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=8h3n1EBGBd86Ebf8828A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxNyBTYWx0ZWRfX9z+9hPcksenB
 /h61mkBd4zI4GABnRNObUL5YAVIHnAGCP28ayERBZU+owbvYQiQ5Vj932tdzTndDDzpkk0WaeCE
 vthsIGbew+RHq+ryqf7sxqwlOggIBjHpzPlIzvCVgHHU3CCHYNMyHujuwNJWiI1V4KzHBO1JO/0
 dBiiJMjXjAO9llDLb81y1LpX+tU0meYSZGDx1Uc0EtdvRVFBe+lsxALntuXdVJ16t6CkilQYvRg
 ZExOUegtMYY6KqwxG23mReVWxiK+QLtpnkjOkhNOUjENtm3a3+11iRgDXrVGrA6qs9AdNou0+Us
 8trZxaS91Er28o37CV/rERw/5e/0HielQ/YyAurv2roUfmAGv6hS0U4ft6LB5xDKmI3UuUgGFXu
 iLD41VMPyOnvzg3XETLL5OuEOtAXuyTAsBhSGnabYqHGO/KR0x3cAYP666vFjGBU5ShIxXG8l4s
 4PZC+O9BGRilUqZIk6Q==
X-Proofpoint-ORIG-GUID: YY1dFKGURP_AZxelHwNwP9CaeWChMwne
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060217
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

On Sun, Jul 05, 2026 at 01:30:07PM +0530, Akhil P Oommen wrote:
> From: Qingqing Zhou <quic_qqzhou@quicinc.com>
> 
> Add the Adreno GPU SMMU node for kaanapali platform.
> 
> Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 43 +++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
