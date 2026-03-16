Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16195F30295
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 03:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6665710E253;
	Mon, 16 Mar 2026 03:18:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UgZY4e3T";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z2vrJ/+e";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21ED310E253
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 03:18:01 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62F9trBm2994269
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 03:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rCtDtvcMPIIzhmO3lBZlD8BEAmaAtTPECV5u+wA+9e4=; b=UgZY4e3TeFQKHPMO
 r6LQfQJeV3Qn53k6CAeodM36D4WHGJUBdYzlZIXc/BaPfW8a4pgN7bjOfVsynI2N
 4Gv5Li7Rnv2mB0OkuRDUdqsLM0oG2nJSwc3vrGaGbaMWsDCt4ZUb2H8htU2KrH25
 iHaWq9Tayse/EPVAwFxjFj1ZN+amDyJfKe62a/OSx7yB3Tj2Wq0+djVKl02iBTLu
 +V+RoXafAEIan1xvli4t6tVnn3g/ZT48KW2+uGJh1t1MN87tuxjK2pg2nHZF29pM
 sAuB6k7L09ullyq6vsD9bM2Pqk6cWtoTq1R8YcJsI03pxTjWg9taQOUuAwY29Mwr
 JbGu1Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvyyc3u9p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 03:18:00 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cb0595def4so3589600785a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 20:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773631079; x=1774235879;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rCtDtvcMPIIzhmO3lBZlD8BEAmaAtTPECV5u+wA+9e4=;
 b=Z2vrJ/+et79SxDUlLP+qpM07wo4CPf53GyUywzzM2ladnCxnoAHkJsY9FLbhVRHfnd
 gA2hcoVuSa71Rdg8qbbCrNucAGAvIq7Tu0Dbz5a7kv2IlX729615uiO4m9k8+ZLPhTb8
 icRVvXq9V628qJ7SLKx21ttRC2MCcFyzzVvCRexD5hpClWe4cV7IHdZnGwVvdwvslpHS
 PTp0SKZx0Ppo8HZ7BnOKV3KC2GHiS+0U04Wmh0KuCUq47poItYRVvlmMN2jh0aR12Hql
 xeGzkrfAhW1RV1G5d5686ABigO7i28thCS3Tpc+V+JyJ1urtlxJ4rc01F3H3LestDyGu
 Knbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773631079; x=1774235879;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rCtDtvcMPIIzhmO3lBZlD8BEAmaAtTPECV5u+wA+9e4=;
 b=EB1Q6aP/lHQeLX10421IETWj88Fstopeb5R5YCzrbYRNg+Rnxs1e69QdcyfYI9Ennl
 5khWCw5JCYf4vNHuQnFBiiEGc+TLG+zCI/VCLd6xeNH7X9Bn0rr5nxvdqjN7Y/jb0dCd
 te0y2YSruT9o5t+rNmkCJGb35gK1oRg/6kA5mmq7/mtfMwPab5AAdVjtWVvS2Z2mZrjM
 n0bzF7y6fEmidUoWGgbAyW56QtsDk5ASTQtLhTUhlnKbfa6MxAODTxhcnfvs7N8DO9DR
 Bz1MbZgl0B+oNBmeJHUvC5emcVAWSfBDohdOsILBGmF0aKvyR2SRCPVQx0EUZrPdHrL5
 dasA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9+SfRQx3DEDjL73xjB6m+eSETRWQsVPE1hRnGA+Ct2NeTAatbdVrhp4F42eCCFO71dqjfqSqhUHE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx57qAVcMeq2r9rFCeTma3ISNmobWI/1IESXk6YqEEIbuAJ6vYp
 LbqBXPHD6YOJm9tuf8WesUH9gjtbdw+yo/6x3xA2ZiM42b0rSCAIcEXc90McJtG3ZdbyZ6Cb96R
 nsZpIp7iUae+RoNxWb0r9Da9jwCURUDRPOR674+9s6IxwuC+u5rVTJyVpdbGTTkOZrRfprzQ=
X-Gm-Gg: ATEYQzz1B3pAqKQ72AWV7HEXJOOYTAI1hm9L/BMR/RSho8DBI29BLchBnV3fmBhfG1I
 iDw3PycMUIaO0kYYOEbAfT6AgYaxCg3YOsvRhZnE7d19KeRiKALDyNrITJTlBqIbrdKC3J4cnBl
 j2oqs5zYotp/6TDX0YW5g0JKn4MyHcBiv0BDzT2jRJFAc2MGqpdnnpOIlROi2yn0kRdwf/zWDmD
 yT0xDGxn/wgEje7WN8kAGiTQIhEgOavKlSCdImH9rs5C8D30jihLbGWKV+IZPr6JwzgsxSVyDfg
 2bsR7wU0NHCum/FqXjRC8qXMrUAbErt5kpIVP+R3uUOIVK9McHYCl8b43x4QB+HxKODaRRpIFN9
 a299+rIfvRPTwISXq+WrorLvzhUb3GWChmjDV/NOsjU9DD1V+yhu49bymMxEkMT09mL1LZH+jh6
 szR6fh9FwAEraD7johIadcYWoQZoAfoZzrP9Q=
X-Received: by 2002:a05:620a:29ca:b0:8cd:85a1:d136 with SMTP id
 af79cd13be357-8cdaa7793a3mr1718925385a.4.1773631079322; 
 Sun, 15 Mar 2026 20:17:59 -0700 (PDT)
X-Received: by 2002:a05:620a:29ca:b0:8cd:85a1:d136 with SMTP id
 af79cd13be357-8cdaa7793a3mr1718923685a.4.1773631078859; 
 Sun, 15 Mar 2026 20:17:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a15602e47csm3234895e87.28.2026.03.15.20.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 20:17:56 -0700 (PDT)
Date: Mon, 16 Mar 2026 05:17:55 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yedaya Katsman <yedaya.ka@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Kamil =?utf-8?B?R2/FgmRh?= <kamil.golda@protonmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 2/3] drm: panel: Add Samsung S6E8FCO DSI controller
 for M1906F9 panel
Message-ID: <36cglvsoch5vvlyyanyh4zuqbpb3mxlb463dh4zddr2ceu6kwt@mbmcwckg4meo>
References: <20260314-panel-patches-v4-0-1ecbb2c0c3c8@gmail.com>
 <20260314-panel-patches-v4-2-1ecbb2c0c3c8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260314-panel-patches-v4-2-1ecbb2c0c3c8@gmail.com>
X-Authority-Analysis: v=2.4 cv=euXSD4pX c=1 sm=1 tr=0 ts=69b77668 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=sfOm8-O8AAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=8s1cotv8QL1OgUCTKcIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=TvTJqdcANYtsRzA46cdi:22
X-Proofpoint-GUID: gTd10kxmoT-oqR_QgH523Mej0RsqmnH7
X-Proofpoint-ORIG-GUID: gTd10kxmoT-oqR_QgH523Mej0RsqmnH7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAyMyBTYWx0ZWRfX0eLZgxL90n96
 kBgWnG/fBMUSIC8uhk3F8rgph0aeCt94fkDAKHPiCa1Zmvl/2Wgx32belECKHEvhsTpTRWmFLoS
 LGamHsz6P5+oGmtMC/baRrbocqPaBh6fbbB8Ix20c6EeEbLKbjMcXEY8+pXYQUV9UvJEVmKXEFP
 2OP1Ez6tJCQ8Ly3fPXSsbgDdoSdhQBxhga9dh3knCZYWKDXBjI78kOUzte1K0mvtVeX278AH3rV
 9hCPUACz5z45XaTeQHOXB+5ggulcM9yKDq9R4fsukQJlTll9G21XpYdXO4AnbyJ2h6bWp7SwhQ6
 DKdvee16T/W6nNGfiAnX6S6yolxvgdSc1htgBIbTGiAzFKLB0Mr6kDavwSOXSMxTzrUL8l1AKZM
 HjsIGzxG2J9O/T8BcvX0GVV/maBdmLT9hVy/KklI0clOuOC43JsNB8aDlE1NGBIbXef/0Kd37hw
 j3/89Lj3BEwj+xmDiIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_01,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160023
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

On Sat, Mar 14, 2026 at 11:46:22PM +0200, Yedaya Katsman wrote:
> Add driver for Samsung S6E8FCO DSI controller for M1906F9 video mode panel,
> found in Xiaomi Mi A3 mobile phone.
> 
> Co-developed-by: Kamil Gołda <kamil.golda@protonmail.com>
> Signed-off-by: Kamil Gołda <kamil.golda@protonmail.com>
> Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
> 
> ---
> 
> The downstream dts claims a max brightness of 2047, but seems to ignore the
> MSB.
> ---
>  MAINTAINERS                                        |   5 +
>  drivers/gpu/drm/panel/Kconfig                      |  13 +
>  drivers/gpu/drm/panel/Makefile                     |   1 +
>  .../gpu/drm/panel/panel-samsung-s6e8fco-m1906f9.c  | 301 +++++++++++++++++++++
>  4 files changed, 320 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
