Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EE7CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 357B810F5D5;
	Wed,  7 Oct 2026 13:23:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jyN6id0g";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z3/DVfXu";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E7B010F5D5
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 13:23:28 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697BVMIo641552
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 13:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=od/ltRzE348gH+PAnRq5JK25
 RMcjNc/ilrPe7ahtxwU=; b=jyN6id0gSsAnxV6VXP5219pJfa0SnX9aV4tRRPrS
 wLSN9cfqHQS+uSh6c1HCJYp7Swy6KjdA7sFRQVDHnuL48ZS/5q/jeLk3G17mYJqt
 VEJTwcUQLYDrj36WugDVjVkE6hDTq04bBsU0jlzAoko9Fhv4PLWolNo92ljYjVoe
 HWX+ngyykneVl52olGUhIf8AjicMlqHwRERG+c6r2aNKkrjabMu84yizbMLurIIB
 1wSwLFydOCEYyfpgvU0+k4JyMBz03KhSsSHGnjyIsi1Mn3Ba3KfCwmVcYa9L3gF9
 U48zluwhnddUC4j/S5WEcfwHWXoWJ+4eR/E66a3LS7OZ6w==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c71abry-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 13:23:27 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-98929c3b03bso3688010241.2
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 06:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791379407; x=1791984207;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=od/ltRzE348gH+PAnRq5JK25RMcjNc/ilrPe7ahtxwU=;
 b=Z3/DVfXu4pJfDoUJJczV/wQEs9ndZJmQVMjzbYq91B7RqS/ipLpjoWscw/Wjq7wNtD
 6kUUVeMV8EkfuWp0QzqDACeKJ1LJd6gSju0e39aRg41TUO6DIoOGh8gSApaAU8uuxUhW
 qyslUDH6JVfTMnDzN1j5aKmhV7UkPEwpkazHAAk78Bgltm8S3umvNbnOXrNFgGWCv2US
 JV232e3TKnoF6qm1xXbbJkmbDMNl/4tuF+BsoirK20vlvhwcmHHmjm1ir3lwbQdnn5iO
 TBvAwUV+IioZsf1p/K3DbdDwk70W409QS+cNYP9NzfX6v1D0Nvgw138psFbJPz99fMeg
 YaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791379407; x=1791984207;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=od/ltRzE348gH+PAnRq5JK25RMcjNc/ilrPe7ahtxwU=;
 b=YO0AuU1uOrN2XXwOGAzFAKosi/Kf19hV7HpgeQvIp0Ma8HANlnhEZTOg/TYYGwQ2BC
 zHf4cOQtbrlpjDJ8MhgxREyKX6h9elI5NKjActAKQMYNqq5Hps/+pXo5VoROGdrkkU0O
 xmmZCeGGQq7Kh1YVM+SAwZkA9RCO2aqZ9DsiBGD3u4lqVP/298njWSDvtJvwC/MJVUwb
 T6222L9cDjs/rfrTQVzlzM3CQShHNNDqjjZXp4w4q+NtD7HIN1waMvWTDSSOuM8oC9Zk
 dAt3Tv2d7A9g5x9iFAwemgcfXyebXC+yenGRAWP17OvoXG3M9UBkX2vS5ps1UeG3UX2K
 Yuxw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2ZcA6ulUN7BR1j6+ADOnXW8L139mhB005J4x/6LTfLzHt4rbbBJf2N4MH9htSPzARdmZ39peTqtk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLMZnCkp9ZsIOYeT3RB7Jg9eTER4V3CurEvARAHaPVRZHIoeDge
 OuK+GoJbXVY2ElGSrNUHxpakDI6UDYKmx8dZS8YQkfa7R/xoyUJKFnp44YfdSeKd0CfhZxNjKHj
 nyhj20cx1k7OeQ/3/5ATTEQ46IuNOw3XJoU2bnCQJUrln45julQdu68HWimva2tNIJzYmKU8=
X-Gm-Gg: AYBFou3DMi4ynBpdQtDO4oP1ptCviYcQpMtq3ZHu/oOvxmbMwl2o+AKqo96fRiaiAeu
 9ZAFzAdWAVrTMtU6EhKe8cCneJBl1cINIsDicc91bYSML6MGajnQarUN5a2uQuTpf4A38xCJSX9
 1PUS0puA8cGZfPMQEpuu7E0XsIpqo0KAXHQZ4vlw4vIXG+M3SitkoqrbQ7Ll04onej2pxMqRwnq
 fynZ0rAywt1rd9JzTHgShcXkV/kEM/yIJ7+PpsTVnI3I5FbRVZEX+9evD7FPLkrgrxO0olXOiF8
 16CxmTeoOTs+GLC2pvkYwbrJMDyZ4+AURS2m3/Vbvi52PeOPQD+hbAi9w/kp2U2GEe0iwszwbpp
 hu035RNT6H2OQAa9ARLYBQsGydwC+8MIcjnOsx136DnJaFMty+r6oN8mn4xf1fBS2mSRRyXmGgT
 fi6TTAKeuhmCK1
X-Received: by 2002:a05:6102:5088:b0:7c3:1898:e8e2 with SMTP id
 ada2fe7eead31-7ca3890b52cmr688231137.13.1791379406732; 
 Wed, 07 Oct 2026 06:23:26 -0700 (PDT)
X-Received: by 2002:a05:6102:5088:b0:7c3:1898:e8e2 with SMTP id
 ada2fe7eead31-7ca3890b52cmr688194137.13.1791379406242; 
 Wed, 07 Oct 2026 06:23:26 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcd308255dsm29300e87.35.2026.10.07.06.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 06:23:24 -0700 (PDT)
Date: Wed, 7 Oct 2026 16:23:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
 Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/5] platform/surface: aggregator_registry: Add Surface
 Laptop 8th Edition
Message-ID: <zgg4st367m4s7gfttvmt7hi4khx5haw4436hmde72mu56xyft3@t4fxnw6c7jlm>
References: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
 <20261006-mahua-surface-laptop-v1-3-406fc042162a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-mahua-surface-laptop-v1-3-406fc042162a@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1MyBTYWx0ZWRfX30LUVPWgGxMz
 9X9Z+w5Qq27/UGC/iGwN30+8vRD7/VkBPDi9PHwYyYKl8Q7kdridDmrqHDIWC7WdfEYR3zPPgx3
 CppwMP2jum2l8QgVl7Q4MPRfJMltzcg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1MyBTYWx0ZWRfX7VFQrKKg3cKH
 Cmcx/WRngmnoKJfCo3LHkeDeHwJQpgYgeka5f/kk8w+gAEHDj0qfHeGaZzTKCHiVzSwrT/awIkM
 h7sBmhEzyMO3Xs2CUYwy2taNooG1Md9+KBKN0vadF8vMFwtxUv5SR7mo4wBSzIwx4DuQE9Qmita
 INY04072pPiLCtLtvsJDRA18GoENlVGMb95LoEy2XIJGCxUltEfGFBk4U0HjsMG7iQgVdAtDqvM
 EcqEhdPv8IBvmf71rxqN/kk8nDrbhp6xU15jIiEfeL4GW90BRKh0/AFsxDam5pCuhvUZo0473sU
 xa4QOwJXbwzXY37iqUVHgOsCbHyIFuDdm/oN3j+OYuOcdCFfmgBwk0VAgujU4CAbjIshcg8Wvyc
 b1jhXTn9r4QeNwQLi+Nz8kNV41U/wS7CSXkoSYPIQsSgI/Zc5sqmEMijh21VhM4bdXFEkDM9e2A
 uZ+sfNTUFhw9XH32JFA==
X-Proofpoint-GUID: 8e6nUpiqb5E_7g0L8gYaac4yGy6g-23t
X-Proofpoint-ORIG-GUID: 8e6nUpiqb5E_7g0L8gYaac4yGy6g-23t
X-Authority-Analysis: v=2.4 cv=LvYHWXdc c=1 sm=1 tr=0 ts=6ac647cf cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=lafGyRzbQaP5-a-rDggA:9 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070053
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

On Tue, Oct 06, 2026 at 02:50:29AM -0700, Gopikrishna Garmidi wrote:
> The Mahua-based Surface Laptop 13.8" 8th Edition exposes the same SAM
> client devices as the Surface Laptop 7: keyboard, fan and platform
> profile. Battery and AC status come from pmic-glink here as well, so
> the Surface Laptop 7 node group can be reused as is.
> 
> Signed-off-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
> ---
>  drivers/platform/surface/surface_aggregator_registry.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
