Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34C7C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 19:13:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EBEE10E07A;
	Thu,  9 Jul 2026 19:13:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YVmUgrwN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KdF8/5m4";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDC7B10E07A
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 19:13:29 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HYbjF2475979
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Jul 2026 19:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 93SaqZgRCSZmk9+Ho1xlDlbMr7fxHHhWTs2lCLEiG/0=; b=YVmUgrwNnfs5PiOP
 xVFJ+HLcHPcQzDiBLtL5JLLhOBBI3ef8L/ZUJhvcvpxV1hYIta22f8DSSRBncqzu
 JvAOXIp31N47AmnsygndA5oWLS+WI8EQv8osBcvo6NTlk7E5fqXkWAWyAdbadji0
 ONX/xMAk0wHhMinxZuhejIbE9J4BFODILamS/mwvJjeb+UjwlxIj+EnWOvBMXCjD
 RA/0w2NQ5ZU4At/d724ZsyQZ5RIPlRUpSwuJjMeCtymfqsTf9+IyTTwJwQQ6w6pB
 OmrOHktk4Qgo8jid+3Kifc9wozrVwNBoKdwG9aErCkbrNUcNTBMRfNkEyMm3Vwz2
 yeHwMA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4facqphmej-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 19:13:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c27616421so408341cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 12:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783624408; x=1784229208;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=93SaqZgRCSZmk9+Ho1xlDlbMr7fxHHhWTs2lCLEiG/0=;
 b=KdF8/5m4pG8TulUkJ26yfo1R21+EPsS0H9/NQTRIJmV6hJyzIobBpU0t0kWG7YU9FB
 t7RgBtbZJ0ZVMl3wrnEqJ6+4OCUHiH3DFAdD7OKtOZCKHw+p7dTnyF4u5PrcZPtbMXM6
 V03p+FkjmVq/InZrOv9biAfUJaf4vMHHUiUVexD+BvCvYHraeDrc+GaPLpv8/SMWNO4T
 71ERxcxjE64Ol350hJF7UkVM+6VQDeiKQj02mDHCe/d+R+8zHG/Mx5ADjoc7LV0jgr5r
 nJPFHrSnXHLY5fIxJkpvBtSAgCs0XG95qtU1J/8WZ1FHH7y0gJPbgqtEtFjJIndsXSvA
 YmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783624408; x=1784229208;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=93SaqZgRCSZmk9+Ho1xlDlbMr7fxHHhWTs2lCLEiG/0=;
 b=kmRfbwDuaHq5aOssIxTlYZoH8nWOhbGwQNMDc5IGyo/uvli0McbFvK1bZVaHE9asLx
 cZvrygRWzLzrlwYbcUA5iHQVeTyWANISgcIQ28Q4UYRD9GaY+64Zsr0vhK4VoMp+XwVe
 FIRMjpXowTyrqyzGA8340g4m+Hp2XaFAlauCOc4Z/VZmEQXr/6gkDMfoCZiGNdEYa+Xr
 aSGS9DkoH8i0BdOPFmMwatxXedYBcIEZsf60Xg8aZIcuBWJ7sgGpTc3NKrjM9uS2T73A
 tilKYTOdRSeyT0kGzNhNvZF9ky5YPIAh1JBCVfZd3cSdGlDLUAH9iPTBMxWTR9G2EAoI
 OB5Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq8fToCb/jyBHwETF4LDiDvJFyiKt6sH5pPvuzZBeHtDyGTSRDT7rynVnwD34hUNIIZWRGau9azw9s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwBQ5s3sOIGCYwjxEMGVrJEraS62gLsgXO80K3RSyQU8MT6Y7fG
 e1kxzRheq/8MS5uN2Rs3JXnGbbC+26EoJEIRrqxbFiMvIE/k8kZPmvCpOaqeDXOmKJRrMPJX6VD
 XDozBCEW5088OixoYEBkBy9VaugG04/NIRMauJRutHkvbPIEp2DsGVprnFrZhgueMf05rNu0=
X-Gm-Gg: AfdE7clPhi4vT3NZMFVoObqI8psod+Hy4D14zm1w5f2ZXKeSNScM5P0Mad0SFEhNCPZ
 L2ryDm0+QW2yjqdxKT68DUOFo/7r2QC0gvG4GxXP34qu1DmSOZ+W63m34EtLtJIGBoypR1UEOL+
 Ff8Dn6HVZoKMMg/BAStIxiUqJvfvfowVDlnVY1i6Cb679cBYFpJ7E6twSbzXpu9vzTwjxNx0wln
 UNHvPvXScOOqV48LGXzPSEbkFicgLhLVx4p2WcWjZXN/0diebi6fJXS2L74qvxmiR8Piz51qtoc
 GDEpiCjizMvZXJGpepjX3QT/5rxUwQCOlzVmGhGOELQsH7wtOx0ABi2UwyawdxCnu68W1P7TxTp
 tOXouBy6pwS2dzsEQ2z83mVYveWpnOoKoeyA=
X-Received: by 2002:ac8:5d41:0:b0:51a:8945:312d with SMTP id
 d75a77b69052e-51c963e7d09mr47417331cf.0.1783624408392; 
 Thu, 09 Jul 2026 12:13:28 -0700 (PDT)
X-Received: by 2002:ac8:5d41:0:b0:51a:8945:312d with SMTP id
 d75a77b69052e-51c963e7d09mr47416731cf.0.1783624407847; 
 Thu, 09 Jul 2026 12:13:27 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15d5de95e6sm277444666b.39.2026.07.09.12.13.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 12:13:26 -0700 (PDT)
Message-ID: <b9c41d2c-b036-4d58-8cd2-da94ab6b9ca0@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 21:13:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] arm64: dts: qcom: shikra-evk: Enable A704 GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Aditya Sherawat <asherawa@qti.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
 <20260710-shikra-gpu-v6-7-b388ec5dce77@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260710-shikra-gpu-v6-7-b388ec5dce77@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4OSBTYWx0ZWRfX2JW2QTDorWsr
 h9Wu6w22WKLXhiVN16qxAcb94oBknGl/p32PjQM6RUUeY/wkwR6SWe+fBLOR1SYMIIdwOIPdbwt
 5gRr8z2EyWiydHTf8RwyVHPmBYh5t4t/kEuNKzNcDfeJkcRWZLuCRZjLncKvHBvH27Q6OyFMAFV
 /iddKX9I9ykcpFut/T8jN6YYDfUaxVVY/aChPgXL7yjiuq5f7QQ/redvVTfjfyb13Awf+akhVCq
 gr7CcLZnO2GsmaGZ8b7Y7C2wOSkUP7htpniiGn4K1Z/f7uI5dwarBbynyvM9DE5wADDZPmzRMS0
 OUZza7opbTj+dmOKrkD7C37Bm2jP2JdnJNCT/4kciK2eCFT00PuzCRdnpS5cMXiguuQ9eKoA39+
 mQB2MoCEiZo9UDW+w+rK10ijk06T3LCrYBMtVuUZ0D0ocs6oLtCIBmoOHCOYPIVct6tux8t6dQ4
 mS8bSvUQV3RAtahI1KA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4OSBTYWx0ZWRfX+7ODu7qIfP5m
 QyJTgdpGHdBti79nEGMVu+/28FXwTZeRSDuAvnipi0FrDPdyZ/P+gp+iHkP3EZZE3KPSt/vFmrA
 upusdQLrKpW/v+YSvH3xfXaLiJHARsw=
X-Proofpoint-GUID: Km64hNEHn42hVI3TdPBfApAmeBrY8vrl
X-Proofpoint-ORIG-GUID: Km64hNEHn42hVI3TdPBfApAmeBrY8vrl
X-Authority-Analysis: v=2.4 cv=GJ441ONK c=1 sm=1 tr=0 ts=6a4ff2d9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=QDjCMyA0A8yHJihhU1wA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090189
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

On 7/9/26 8:42 PM, Akhil P Oommen wrote:
> From: Aditya Sherawat <asherawa@qti.qualcomm.com>
> 
> Enable the A704 GPU and configure its zap-shader firmware on the
> Shikra EVK boards.
> 
> Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

