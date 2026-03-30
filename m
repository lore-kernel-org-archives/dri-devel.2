Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D2B1061B1A
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F31710E6B8;
	Mon, 30 Mar 2026 18:50:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cBt+Qo/E";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YAuR1ZWz";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59FB410E696
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 18:50:41 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UHuNuT703531
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 18:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=DE8Sw5kR9lGM4C3h602YOoTU
 pOjpbxDUO0a5++U3Gu0=; b=cBt+Qo/ExYBETSAhLuOmZVN0aPscA8YEqFre4PXg
 /hkz1of2A/QmjdxQK3B+xCXZOpaS1quq79IWwI+vQjA/dEGlz/+LRIVG8uGbmsEq
 3f/eB67dUSGUvgt8WkDQTOnK3SSzrEPh1odpOaFOCTw3I+CQcsi1ASSnwL76GpKg
 3KQz5WYh8Bb93fyBEHWJAU1MLUxwK/0Ew6UFDyG3Vd/2xbRSdyisPTZ2RWRoBXiY
 GaOBKHMDk845WDvlgvYQyiJCz6MWXL2M8uYE3yO03lDoVNoFkMeonF1qFiBGsX3O
 j8NpQeB/2aoahZJUGAyI1RbYLLOYklb16Ud9jl6Z1XsnOQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7sansgnf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 18:50:40 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b4b81c632so156907351cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774896640; x=1775501440;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DE8Sw5kR9lGM4C3h602YOoTUpOjpbxDUO0a5++U3Gu0=;
 b=YAuR1ZWzG+z9Bag0S4UMmWRdQ6AHto9ZWbBTb19s0s/agzOPRBq4Gl8iWennAhJIcm
 NPXN6qHzLC8OCePdDMjF+cyIptaaYRMAZAN0PMIBQMOu9JI9fIotyhC6kx4GgpGdl7ir
 3pyMKp+GORvs0YnxrD6hyxi5BjvwhDQuQ0x0FxlFWA+PecSHyugZ7ngyHo749re787+8
 9V/kfG9cSJC45n1kdPn7qbjeMEORfmMnfcqLNk0Zy5TpbBktVGzlCBnla4AlJ3aZxQTO
 dVBHAC5T/Ei1YSlG7MKnjsb7rLeZvZV51+E2l+QY3gIpvCgSqQ5PhJm9oeD3XI3O/EBq
 0cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774896640; x=1775501440;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DE8Sw5kR9lGM4C3h602YOoTUpOjpbxDUO0a5++U3Gu0=;
 b=OMrzVRxHYYngcibIUXXjAWN6UO8KB/AAQ0D5Gp0CSD9te/P3QFqR2KEyLmlCJxsj4+
 lFgxNwUiRYCD3q95I3T5xgZi2nhgTO92J2r2X0jccYvLMYDF9LhlfgXxwlOfXhA3vbrH
 5Q7pxCvX5ETVnsSyDqdUpySxlvMyLX46HULU2xGKFZcc/mtKx+/w3DZx6C8QPPeXgYi/
 BpKLiGvINSJnj7Y63VymNBuwzEqRqMM7xHVCUaX9ztlBzyLY+0smdijB7Wq0UnMHh9i3
 Plf+NAwEKTjxL3d7ZUv9F4VP44uWImlPujoF3NsqPaK59qcURMm3cmveGSQWBzaqfk5c
 rImg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu1TrKt5tZQibhd/e5zESE2xoU/YyPeDPZAtvCLaFmcISXl1SZNXoqGBDKXIu3Gdnv0Xb+QeC8tj8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxkGXRnMl3WQy/FJy9O6qAYO1aXK/NqmtFJ+oqZ+hLQiwTd0wLF
 ff+WiQBLr3dkGSduR4QOq3BvAcc8BW4tlbvz+BoEb3tuNqqZCpGRy/HeTdbYcVJKMHtosYCuFxE
 jTvN/eSyKK5UbQkWDLuZLkbO0AAxVow6Hw8wFyZ4yvz9aIK8DYPHgkB6NIkIhhGLTbTS0qi0=
X-Gm-Gg: ATEYQzylXgivlyXDuXGrrTgIiepnkiG2DlUpsQfskRTDO0E1LaAfJCMFjbwz9cLtJAm
 E3tbvneX/bNm3hghPVnWUBRQiVPDpzr3GOrwI8UYJAWBq8xsqGTZDmv8unDhm048oSycOwmxMi9
 1J+na9x0nMSdZh+SmIHpD0uDatGhGkzCoo08ahJweKbqpUQ5w2tdkgE62jDjnsSZjkqurJfNv1P
 AVBO3DtXWXoUeqs44urLaxb6DvKumXInQg/LRw3PUWFO2R5ey2Nv3ry5r1jOx6V/LfkJ1SVuhBv
 J778VXYMx2Tw1U3AswSB2j259j+t01UKJjJT3Cnb8h4oN6/K3jJ4BiGnsg0O6soUjdLUtr3kc3Q
 LmTx1qs8bpfh50/3MKoa5Bfh62MnQl8X93Q8LBGMgg9bBlh83FqSpgJudPG3WnPcrN07tqHSL+S
 Arqxr0hrPey3TsWh3wD2zyeQchv958hwyNzxE=
X-Received: by 2002:ac8:5d05:0:b0:509:2053:ab5a with SMTP id
 d75a77b69052e-50ba39803eemr172246881cf.57.1774896639565; 
 Mon, 30 Mar 2026 11:50:39 -0700 (PDT)
X-Received: by 2002:ac8:5d05:0:b0:509:2053:ab5a with SMTP id
 d75a77b69052e-50ba39803eemr172246411cf.57.1774896638998; 
 Mon, 30 Mar 2026 11:50:38 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b13f4329sm1828151e87.3.2026.03.30.11.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 11:50:37 -0700 (PDT)
Date: Mon, 30 Mar 2026 21:50:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
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
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] dt-bindings: display/msm: qcm2290-mdss: Fix missing
 ranges in example
Message-ID: <wsf7oet6r7d55i7f6cdwgor4cqu3hzgqcv3r6lmyfsoivzgzls@v5z7bbea6fxe>
References: <20260325122209.147128-2-krzysztof.kozlowski@oss.qualcomm.com>
 <177488647743.633011.6769674149013868210.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177488647743.633011.6769674149013868210.b4-ty@kernel.org>
X-Proofpoint-GUID: IH-EJoF8t-_SRxcGOL6nuHvebj7NsHVw
X-Proofpoint-ORIG-GUID: IH-EJoF8t-_SRxcGOL6nuHvebj7NsHVw
X-Authority-Analysis: v=2.4 cv=NofcssdJ c=1 sm=1 tr=0 ts=69cac600 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=q8DrNbCZZteTo-H5dVoA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE1NyBTYWx0ZWRfX9AiTcJ/U0Qgw
 aHuof9lqOKyzbjLFqjTjVEz1sr8g7Re0te5Nj8AWJO2Mr6860epLXEvsYOauBIQZfCnjeAJDnss
 +aUJhsVZRBtDbNkWTQ6eKO9JWbhkoNx9DD4O8z+xq0IzNjWvd+jOCg1sWrp6rC38C5wNW34RR3x
 4F398xo8pRVMziwIqmtyaOiFtEC+5yJzx9L3KTTBzH5tN7LXfSyZxgft1SXjOQ10leqaQaVtY8O
 yPcCK1Qa8nLiwmyKvHx72cKCRS866ydeNZ+hEL0R71a5f7bm6W3LkCpev+6CpjnTvY3X2kzIFQG
 A/wfZPfR6lXVwt2mhIEBL5s2JORrQWEN0Dq/neOLnKJWmUcMS4R8Dmm5LYP1mzHHfTD1Bdxfevx
 xSD1Xmk7ywDflyrl/dRf9Atf2F96qtsZ4OZ5a8VucdGOxG0Rvd489+oqPjsrU5cyXMV3v6dCbXR
 uYklD+vXzfMn/i2+VCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300157
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

On Mon, Mar 30, 2026 at 11:01:21AM -0500, Bjorn Andersson wrote:
> 
> On Wed, 25 Mar 2026 13:22:10 +0100, Krzysztof Kozlowski wrote:
> > Device node has children with MMIO addressing, so must have ranges:
> > 
> >   msm/qcom,qcm2290-mdss.example.dtb: display-subsystem@5e00000 (qcom,qcm2290-mdss): 'ranges' is a required property
> > 
> > 
> 
> Applied, thanks!
> 
> [1/1] dt-bindings: display/msm: qcm2290-mdss: Fix missing ranges in example
>       commit: 88bdac5443e5269bb39c4968d5ee0becbffe3f82

Hmm? I don't really mind, but...

> 
> Best regards,
> -- 
> Bjorn Andersson <andersson@kernel.org>

-- 
With best wishes
Dmitry
