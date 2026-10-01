Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23644CA5FC4
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 01:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ED5D10E0BF;
	Thu,  1 Oct 2026 01:58:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Av6XhOcW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eH3blsvq";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3BF310E02A
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 01:58:19 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6910k2LH2012667
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 01:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ZdeAUChydPqhPIvtw0cY1t+X
 ErxSg9azs+6bi/qs5xI=; b=Av6XhOcW37SpihgwTkGfs4qIDt0nNlPqo7uM+tTP
 csNja1zSArvVgJBXalT9UdhucfFxx30xWP3vbe9cMp/ntSP2ByZNm90EG5v4c7VJ
 oJRM6K0oQAo2/W6sdLegXqhDjNH6g0ZWQl4iej31n1Jnf43bB7ZmmgH7nRQ78Uvt
 CyODMykncY4RRlobcyM8BvdeEg6lyJpGykgjRJg5dDYHUGmGCcvmRu1UVvwOuJpW
 mb8tx/7QI09N3Q+Js/9N6NCgSGYOWJQ/8t1vMMmS3EsV9vI+8nS8lm3nZpdqimoq
 BDGxotkozDyWaDVXRZGMY7T2nOabY3jC70ckSGuF9uyvGQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0yh83xjc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 01:58:19 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5338c59f90dso2165491cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790819898; x=1791424698;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZdeAUChydPqhPIvtw0cY1t+XErxSg9azs+6bi/qs5xI=;
 b=eH3blsvqEpIYyOqxRTQG7+YFdWhZShIPEJd9JF/+RSVV1EDjm0cZfqL5KmbsG4R6lT
 GdiS29GlaeL9tnhXASbaZXgCehE5VL3yvZFYbDZ+B9KvHWSELfVvgG4n5chNOr0G2wV7
 EFT5CnBH22pfWnjOCO7dWwc7lmSaSU0hm1iHcjLBgzoT4Uq7Bmsf6qrg7Vm1FAhbl7HS
 lyaIu0yrsujYsnGwHwnTHKgjjqc/2t/N3GHoSTHXQ6xe1GeuDADTlY4YAFwAbeDv+g69
 A6xoj5wkqDtUDoGkwsjkUh1TiFEvUIiqWYckx3dw0fN+RoH5BdW32c3o3rNoAIq2U+4B
 Qx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790819898; x=1791424698;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZdeAUChydPqhPIvtw0cY1t+XErxSg9azs+6bi/qs5xI=;
 b=ZpghESinyfcfBi2pIz6AcNtrgBxD84mcPkbKP1E0tC1mrSlVp1z9giNYDLd4UXwd3X
 +TZXKJ59/GC1YDnjxrh4LuZSGIAIxekeyT0zZ4Y/fHZVPtYj0Jilx+w+0yygCMAxY2G7
 LUncEMJDjeEGysu1gsfD9y6P9D2lZz7XSInthmg1FKAoYwcZD+jd7sfwGc7aQpyOWGpp
 KN72QNr/KVSyfPxD2l0LmKMhmCjV+Tr++zVAPx+lsLMvqHXMV3L/vrIeYbwl3DnCRthw
 Adp9K8CxubZZIlYL5MVKCSdvkel4FSKF8Axb3my8NY0iWatws3WvA7V2QZL4o9gjlRXy
 eaSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8fo57h7eLGXRaw3+LLTE09xHSFkmPDrmEeyaSMaPT6+cooBhPMchu8F20kqsGbpop6S5lhWqImpU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k6idaH58Ulc8TQIa/yH0OgfiW5CGLesddizj6QXBx/NhNoJW3l
 z7Jdn2bUSobwypW3JCqiwj6+P3O6vrCZFop9sZRERgYJE5MGN1gdZATH0scyLtsMIkfuvCG2EfY
 QCZOyxpI57a7tLCgedMeKe8q/xkZUkZ+AwYo7/vxwuqt8VECYy+YuokTTtw8hdbvyrJZKCe4=
X-Gm-Gg: AYBFou1NQLs7VmNqXuieNQF2mXT7alMHaX1ekOaw1BwGfSCb/vdJ6OLZfUyieq5kiID
 FVK4UXYfeD/ZQVG4Q7tOx0EPU9i4u6SliZoGExCzRuI8vyGyUz1Z3JgNohz1rn6oj7pHgJhSdVW
 c9RIm/pfK6eub3Y+Z58B+IrXG18yDU4XeqAOcoJPnTmE0/CLFYrIojhXYxlzKT00KE/C89EFtZ+
 IlR0+sjHZtbDLTtYoOIw2croXY5OK9t6+u6dJHxRRtCrnPI9VYXc6NfUiZLCk3/qiBsHDLRtYfg
 AJESTmqmrNmgUH7UVtucddHpwxY+u2OcOrUDLM+sYUlTlfaxy9HiT1X3Q7xtCEcb09ixcanlDOT
 sfz4TV2hnWzcb+MdO7KM4y6L5ib1Nh4XWovLuDNI8X8tZDWSx+YsGSwMJOje4V21qLdp7kznPP6
 qjo2EYhpzGE2Er
X-Received: by 2002:a05:620a:2991:b0:93c:aa6b:93a9 with SMTP id
 af79cd13be357-93cb5c10d42mr278085485a.32.1790819897797; 
 Wed, 30 Sep 2026 18:58:17 -0700 (PDT)
X-Received: by 2002:a05:620a:2991:b0:93c:aa6b:93a9 with SMTP id
 af79cd13be357-93cb5c10d42mr278079485a.32.1790819897286; 
 Wed, 30 Sep 2026 18:58:17 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba440595e3sm175732e87.8.2026.09.30.18.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 18:58:15 -0700 (PDT)
Date: Thu, 1 Oct 2026 04:58:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: muzafferkadir@mainlining.org
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>,
 Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, iommu@lists.linux.dev, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
 linux-input@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: Re: [PATCH v3 14/19] soc: qcom: ubwc: Add UBWC config for MSM8952
Message-ID: <lxil5g2zx3gr2li5ola6xyj7khwfltzbyqfuflqygrcetztryu@mr65up77ioec>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-14-b96fd3fe298b@mainlining.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-msm8952-initial-support-v3-14-b96fd3fe298b@mainlining.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAwNyBTYWx0ZWRfX9jO9S7icuJ7c
 2B/uZomOFOdO6Vnw4Ok8lLJBY1lNgdy6LQ+wcQOaOpP9AkAcQXqOfFMuBMnFF9p/C4gf9Xd1ucF
 Xr4JcKfjTp5EgUYo+l5k+IUGbpbqNqnwER0b1+c84DmMvEfsQdvcwLbpZ2t+lnzbeDZT/OUhXQn
 J6+SHzIQUNi+TiVVSugREQHf9gprS4KAMLqoh13xsQ/hx6cpQoJMx346nNfa17wPdK8NkdS4I1Q
 DBTAzJf1NGltiuONsWSYHQ2gSJy8HS+VxrJdLAcC+X4HyWwTMqsy/44tgcn4EyU23FZAsDEw+vC
 flFRPWxyWtuLDlZSmLuBstQW0ctc8QuR5Z9i1tvMr1jf/n2PjnKWVYKnbzbbwln99XreeKqbgst
 3Rw1ScXLWYWtEhBB7Dud8mlysbe9YklhXLNFNGOjN9hEAp6hLVeuOfBxWs1PpmSWzQt5IOF9qFN
 +/P1BxkN6PKMwhySE2g==
X-Proofpoint-ORIG-GUID: prEyHPaTBGYcmlIHSDBspbwKjNQEnfzk
X-Authority-Analysis: v=2.4 cv=NedzRGD4 c=1 sm=1 tr=0 ts=6abdbe3b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=OuZLqq7tAAAA:8
 a=EUspDBNiAAAA:8 a=bqz1LMNPX605IxUfdh4A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-GUID: prEyHPaTBGYcmlIHSDBspbwKjNQEnfzk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAwNyBTYWx0ZWRfX5CDYGT6RPNTA
 qBA6VM/qiYBlJsKnR6RaVlc2yOlewUtY25ydAb5tjv7DRzYtng0R2mXRxBS3l1dq9tQOfzCZxdr
 bw2SENWyk+jWlKmCPGWAsiZ8hq1aHO8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010007
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

On Mon, Sep 21, 2026 at 09:19:05PM +0300, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> MSM8952 uses Adreno 405 and predates ubwc just like MSM8939.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  drivers/soc/qcom/ubwc_config.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
