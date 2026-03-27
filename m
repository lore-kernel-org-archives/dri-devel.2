Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE99310F2867
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6C7810EEBB;
	Fri, 27 Mar 2026 19:48:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="g+6qcBiE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C7WKgzMW";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5092410EEB6
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:34 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RI2QkA2217686
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DTcml2DXC/4wK1DbbRxZTt2MfDBgAA+ck/H1+9Sm9R0=; b=g+6qcBiEQOMOtMCv
 7B58zVp1yBRYPPxi3g2wPPoVEEbnjb00A4+y8mRBjD0kTm6hHcm1/oR2l/JdI70D
 TuZqDcF8my/zLKgETCdnxG5iGCbE0Ob9EwJwbwE+YTzrL0Z8hFO0iMks/3hHMuz0
 BKMjtsSj6Xn+QWHs14ukBfjuN3DFEI20KePAPAS1HNcCg99kkU7HG6nUo2tYPhja
 wAmlxh+Iv0OfLcSs/TL4KE46DI6WWOqcGMthftBI2RlLHNZsCBFhoCuewmmMX0go
 rH1+QB0N1YYtAR9vH8w4enFp4Q8eH2pZrVqfBBJh0isivd7NJc76/iA20/VorIp/
 I0n7sA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5w30rqxh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:33 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b317c40acso17357611cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774640913; x=1775245713;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DTcml2DXC/4wK1DbbRxZTt2MfDBgAA+ck/H1+9Sm9R0=;
 b=C7WKgzMWajUbmokXbBlrxkxQXCgHcYmAyek4suMGQsy9RW1uEC6MLPVfdkArEkc83h
 +GY/b1B+NnwWe9tBn7mRRezH09A5w6t9U1b04+0HH1Ky6x2c09rAbDSNH6T7eWw7kQ37
 WP5cSrbTl2llFTqwecdlepqjc7EMp9OeA/tHVp9ynaIrJNsZvaGzkg/zqGyAP5G+fmdC
 rMs0/L1zMMw4dVgXUIuMqW1/qKgmUEfitFO9I651DsP9yAmSO+vmSc0+oE+152z1u06H
 yxZMod35EOQrk02XGyey+975XNL2RvvlFkjmwAekcIx/M017+xPWB09Ghj2SZxlG9+Qo
 cMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774640913; x=1775245713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DTcml2DXC/4wK1DbbRxZTt2MfDBgAA+ck/H1+9Sm9R0=;
 b=qJUiKHeESvJfV//qfbym7BGIDs9oqvs7pvcKGNDSQv5RBW4V+DzE7xSR5AF3Q2qWXx
 4z5q980UEStkZrU9QDz5hdg147x4eGhgtdpYso/JiVb4YUn+KoHXMg+Qx+HPZc3vlUh2
 ObZlTQMLrEzMGLrlquhAAwkKajCma1PldQKf7c4lDTocRvOTwZk+5s7+wv3mgY6PT46x
 E7HnFKGcslUp2oRxfycocDVDdtUlb3RUVmEon4OSU9vUEaek71KYV9hPW2R8xkf9Pqis
 TJjBmF3tMNO+DBHfqGc/4njhIbR4opvprmls/2yDUDck07XVMw/rB/Qhbijf/GHDX48R
 cO+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXId/hzkVUfwMdkXZdm8rGm4M2DTrKPCnFtH9qHrUHCpCWokEZjQZlwPSgQQ3vIk0qTYnTfA2Gb3i4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQOCzDUciBiOys4lh5FqrshM4Fwey79m8iX4macUIstxOVRzil
 z7LFb9LkvOCtWxZm4LLfMbVJnrhKwvInoL5EGGCMcgkcRwW2DCZaIef0nToelx621trWT3b57N3
 qjn/pRag4iegI4/MGDKR4GtnnlcmrKzH5oX08ih8wh634KAzSnht6DhAEMgVX/oNUdBKTSJI=
X-Gm-Gg: ATEYQzzHc/yOCukeg7t5HxarhrVn+UHNU1PqW1HDXqOQR6Axgidi+52uGjGsEZb6RbK
 4+IHOSjnRxUA88BTn2IV8hjyViVFh8vTAdGq/tegXFIbm2lCPJyQF5N311oxf0VyRRZy4GLMn1n
 qCEOCIGZ78eOPLyUTMisD5Jr/x/ctMshUW73OGRkGL+sOsOcT/rS12FabaUxUF0UJe3VNBXbk7q
 QHkl44IfJ2LnLUU6SfJq2xwI2Sll+HRYSY92f9631QBdf/iOiy1DWJcoL5uDN5Hd41SxXpsPhSB
 ZBPHW1041ft1WmZhsgiJc/MoKxwHeAL3GUPq+Qgwu2WI6nEB9yofaEkAVS+uY4j6w/I7W9QF9iL
 HvyLDJj7m4WQUu5l4K03MFJKPVbMacXqFKEfQyIbx51Z7Z4CiI4bakHVZaTQQcnxYZ8NNgiIFoA
 3mZElAmrbIsXuojG/TYJxcmWMIlrph+a7s
X-Received: by 2002:a05:622a:1ba6:b0:50b:408f:f54 with SMTP id
 d75a77b69052e-50ba39130efmr51506071cf.53.1774640912726; 
 Fri, 27 Mar 2026 12:48:32 -0700 (PDT)
X-Received: by 2002:a05:622a:1ba6:b0:50b:408f:f54 with SMTP id
 d75a77b69052e-50ba39130efmr51505671cf.53.1774640912293; 
 Fri, 27 Mar 2026 12:48:32 -0700 (PDT)
Received: from umbar..
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c837130basm275211fa.12.2026.03.27.12.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:48:29 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, neil.armstrong@linaro.org,
 krzk@kernel.org, abelvesa@kernel.org, konrad.dybcio@oss.qualcomm.com,
 yuanjie yang <yuanjie.yang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
 aiqun.yu@oss.qualcomm.com
Subject: Re: [PATCH v2] drm/msm/dpu: fix mismatch between power and frequency
Date: Fri, 27 Mar 2026 21:47:56 +0200
Message-ID: <177463970824.3488980.601109933319325787.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260309063720.13572-1-yuanjie.yang@oss.qualcomm.com>
References: <20260309063720.13572-1-yuanjie.yang@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Ise0G0KV1C5Az43cQ93ZycIS0pAzNGmy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzOCBTYWx0ZWRfX6l+IDIPMHnLU
 OsdEX3goMDRxldnlNtNy5am0GuC0q3ZIDaxuS0a/Lz/W6gi6GiccnGcVLaY7hFmVghkmbN9UVBJ
 CXzqiu7CON3wsB1MTBVg45Wd5p8NicPpTduDJAeYZ3H+USp7IykMyG7WikUBA1yHHHG8vJ2xNmU
 qpaBxZ6pvvbvgtUiGZO803WBiGHYbW+kS5Sg+0b1IyKBpLwH82wIyo2Wn9CmRDj0SK7ar0MTABg
 Zu4BMdPXwu88LaGO4DDB7YWQUEUaX/fFwgONJw2kb/u6n/mpR3uq+ldbJyee8N7exQjL+0dex0I
 sR54f8YjFOrYGF8AEvv04UXrmFxPNx+veshiGFQCuGiamybGnLd3idTPAUIGMkDV7p7Qiyhht+3
 yqy5mZvnLyfzkndk3nw8c3wzFYIUFXUMYQBPBOH2lqz6hvGUVMqm+SAt3mOLaKvHvMse4hMI5o6
 buhgf6QFGhV2aYU7iTw==
X-Proofpoint-GUID: Ise0G0KV1C5Az43cQ93ZycIS0pAzNGmy
X-Authority-Analysis: v=2.4 cv=F9dat6hN c=1 sm=1 tr=0 ts=69c6df11 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=e5mUnYsNAAAA:8
 a=5-8HcrL-3tWewVUv8uQA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270138
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

On Mon, 09 Mar 2026 14:37:20 +0800, yuanjie yang wrote:
> During DPU runtime suspend, calling dev_pm_opp_set_rate(dev, 0) drops
> the MMCX rail to MIN_SVS while the core clock frequency remains at its
> original (highest) rate. When runtime resume re-enables the clock, this
> may result in a mismatch between the rail voltage and the clock rate.
> 
> For example, in the DPU bind path, the sequence could be:
>   cpu0: dev_sync_state -> rpmhpd_sync_state
>   cpu1:                                     dpu_kms_hw_init
> timeline 0 ------------------------------------------------> t
> 
> [...]

Applied to msm-next, thanks!

[1/1] drm/msm/dpu: fix mismatch between power and frequency
      https://gitlab.freedesktop.org/lumag/msm/-/commit/bc1dccc518cc

Best regards,
-- 
With best wishes
Dmitry


