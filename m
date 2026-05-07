Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B2DCD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 09:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 049D910E26F;
	Thu,  7 May 2026 09:33:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HAG8ZEd2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V3/UGogl";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A213F10E26F
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 09:33:21 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6473eVs0026493
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 09:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=/aIs5kSqJiZG1VuM0sf5euCM
 DtZBXw0HExmkArpjzSE=; b=HAG8ZEd2DEOYCb/MlkiEyMrQaVDzY2ACfX0olC4x
 xvViQruc08iaoNqQ6fY2dDWey3rW787EvuYK6e+8AcWE5kf9HvPexj7cOjjSLL2u
 daVLO4aDkp5geKBCQJDFchkKCXk0VwG7VLX5QmM8C4essaGgcGkwDVis6l1z/jdp
 V2xM+r838O35Iuq4WGCNU4j/ffJcaL/xAiJonAqreUkUsw4tr4TC7qEvTZui1dhl
 Leysu0fLRPLuFufkn+PmOSbXVTXColefjlcId8G/a8tCD0PNpBnGFpMmS0t+hExN
 Ur35MYf9uueWlEUY0EcUXNhMkei4REJg0mmpy1ceLLK+rg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0k1t1817-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 09:33:20 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d9a6a853bso14093071cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 02:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778146400; x=1778751200;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/aIs5kSqJiZG1VuM0sf5euCMDtZBXw0HExmkArpjzSE=;
 b=V3/UGoglwpX/MMdFqRU33lgK3tVARwVbPXjOJJltC6hKEMkqMxEJD3OFVFww8bhyTS
 fQDKGkt5x+yvONUXLE21seLAhpdPCt+0TtbeHO3/AS6z6z6jGnd2kdsk4BymyjonetgN
 rdxVEHeJogYF258pgBzkQY4tS2TaA6uSAMgE9ykiU387d9TZDyywNNmh69aOfvCxwI0e
 Q3rX8/WNOlYptmcK6VwfKHYIofsbm6sp8HcWQs4yl8ddBSvHQ80E71VMLAZ335FV3sdf
 Zpx/yOLd3jGsB0eSyO1EH8QAGBuTqopcfIItJVQ821H4/UAuirqBaNwDQu6G5i7FpGpF
 eInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146400; x=1778751200;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/aIs5kSqJiZG1VuM0sf5euCMDtZBXw0HExmkArpjzSE=;
 b=DBjsC+SkL2HYl5yLXtPkELavziInpZAaMmgGpiJM323mN942s32Ktvhmu0u4ElgDMe
 6us37M+OUR3VItrSux7eJWuW5ONe/FqtxsVVYQyuoOuDfdxgYVdBXobedYrsZlIrgJIe
 UgKFsl1K77rI9UEktEAYukpzDR01uUJxIFIfXfbqIT6jniIXMtu7155vTms77fdO/7dY
 2hwrM7PzWS/EyHaGXosolHx4wv22ePIg2FnG2HcYSOMP5fcmAlxhnrO88bZs1gyOmjgD
 UQU2Om3pMO9imz2IK8muNssLmalPpeWsX0tCJdVqdm8ThOYxG1WAzNqz2n8PGuscoldA
 h0lg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+mvhu76NmSTtwLfCnFeZ8ZG19CGoaJk+gpCSP0BD0DlWNqaCheQUFKYWgoReJ2p1BsysKHoo6+cJ4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzTzKJE0llFwGiDE6kmYrhRtBpp2Kg2+CO49ucq4f6pnH4tZKwS
 fA7GzL+mE7oGJIhUnPCZLCtNncIgSXY5siOiQKZEquAV10WdkN9TxdO26ah/GitDyJsbfq3jUK2
 RcAz67ekm+6uwTr+ASYOeZnLO8uEntRH7DJCSsDJ4uMTlaUxHtIVw13ytl2AkKB2se03hK1o=
X-Gm-Gg: AeBDiesogi6yFDwW44/Xrxn3/1L+UtOLv0UQAvNVHWmSn0zYUFz5h3oD3VAl8K6jRMY
 8ZTPGnAuY1Qazf5NOcf32xjKpFH/LkxmEchiwaapbYbIpCAyOdtGj7z/Pz+erL9R17mgyvSGIuC
 XTlUSlHMC5nm5nyD/4pFvGFguT5oA/6KLdSa39/97TXT2E0k1h6jlp56M4aGMdiccbuPn7jHM4k
 BxFkvunwEn3mz0WLF+ncBcyapAh4fGzsTKV8rD0U4Lbz+rG/PH87ijZaAOmiPJCn5EnYnNG7Gk/
 BM5UOCyUeaUK25o+/804+S8dP+qHFk+3cJHXLGdE/EHPPjCwL5iFOSofP6XybI6cFwBunQS6s6E
 Xumfx+hdRyx//KEXqB9/IXORQkzjGTPuV+CX/EcirmTyuTfKzDK3aYLhGsLYbHHhAvM/lVgLM+S
 yzm/PmOtlbk4nqea0VEhiMYmh/QnGNkERx3QCA3S3ZNKNLmw==
X-Received: by 2002:a05:622a:6096:b0:50b:4a84:aa94 with SMTP id
 d75a77b69052e-51461be0138mr96892051cf.7.1778146400145; 
 Thu, 07 May 2026 02:33:20 -0700 (PDT)
X-Received: by 2002:a05:622a:6096:b0:50b:4a84:aa94 with SMTP id
 d75a77b69052e-51461be0138mr96891721cf.7.1778146399641; 
 Thu, 07 May 2026 02:33:19 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a870f9c282sm3504593e87.81.2026.05.07.02.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:33:18 -0700 (PDT)
Date: Thu, 7 May 2026 12:33:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [PATCH v3 1/2] drm: verisilicon: add max cursor size to HWDB
Message-ID: <b56ynhweipg64p7a4hwbnvtbrt7lynk73wgulhdnpmqhkuwk2n@uli7afikgol5>
References: <20260506175610.2542888-1-zhengxingda@iscas.ac.cn>
 <20260506175610.2542888-2-zhengxingda@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506175610.2542888-2-zhengxingda@iscas.ac.cn>
X-Authority-Analysis: v=2.4 cv=EoPiaycA c=1 sm=1 tr=0 ts=69fc5c60 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=NqnNFXwKi19eTjbDJboA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 64YIjsLUU4Ye4M-324JF5_6sbNVaSqRY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA5NCBTYWx0ZWRfX76UMBNmCmY6c
 nABeovpGYunrUF0AldXyO9kIapBEqP5UBKD/Zl9quJwb6CiV9N2pKK5unTZTEhGEGxliInOXgTD
 JMQGfptDpXrLhWgAFgkOaxnqqVJdJZfd5Gr6xpyRPpdzHb+C8PRWRmtwmXZ2BOVEsTre4jxn2Am
 F+5bTOKRYCTmq5o/DRDmPjzXO8ykY9exXguG65Ao6IbFE6IpvELRvvSfz8eVOc7TmFBYHfy96Yf
 GMIVXbT3pEWS8IMo+vnwFfbg3THHW9IYmq9T7R7wbtUU9ke6mW/N4tQ5q/5zchQCGCqmz9BT3KH
 qO/Ckgf3lgOdZu0E25dEsjPj7y4xdhmkL7KswvbPgHt2W1zNSEFPsqyeFzU8IL+QlyA89ISYTkU
 PtUi88bTBUNSBA6aT/z3yClkZSRIIDKyz32L9ZJGflWezIs9T/cnIlIIvLY+sHS7tZGFt0ypTqJ
 9ktQsC98bEhpV1Fqupg==
X-Proofpoint-GUID: 64YIjsLUU4Ye4M-324JF5_6sbNVaSqRY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070094
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

On Thu, May 07, 2026 at 01:56:09AM +0800, Icenowy Zheng wrote:
> Different display controller variants support different maximum cursor
> size. All known DC8200 variants support both 32x32 and 64x64, but some
> DC8000 variants support either only 32x32 or up to 256x256.
> 
> The minimum size is fixed at 32 and only PoT square sizes are supported.
> 
> Add the max cursor size field to HWDB and fill all entries with 64.
> 
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
> Changes in v3:
> - Add R-b from Thomas.
> Changes in v2:
> - Added a comment about the cursor being square.
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
