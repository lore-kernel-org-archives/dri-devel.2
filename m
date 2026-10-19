Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F073FCCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 692A610E544;
	Mon, 19 Oct 2026 11:46:36 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D545910EC7A
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:46:24 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Orw81348196
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:46:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=hG197sZx3XRJAemskE7V+hMh
 trqkgeOsYb24Xht8LNk=; b=TEaqUc/AW2zv0dvvnpDGjbJ34/KQDGa49xWXOlC6
 yz/a6Xp6aX5v3p3UgpV+s4NNziLQicA+imw6XHDL5sTpGfxlnvUIPDyXYxy7GADV
 G7JscBXn6Mg6NOG3jb/vIszrSa4jEGMWEgItHiJU/ZlgycX/KT6j7cPKNqLwFO6I
 mrMjWB4dAWZoYrpSRN7NSgZ7Kc6IL9SC3Gr6nyRCe2Xv9AQfof4YdWucsVpurvpi
 /QvDTfMq5abkWg1dR4XwYEkJf8D5/jjMoMkvbeQ4qHhUXD5Fxy+kev39xWw6OTPP
 8MAqZgjbQ1GcywD+xKQjFwCyK222Xlnw7uAsbnQgqF2TkQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf4rgvj6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:46:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f13c143c8so383756085a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 04:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792410383; x=1793015183;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hG197sZx3XRJAemskE7V+hMhtrqkgeOsYb24Xht8LNk=;
 b=ZOe1grphEZHjbh/2mZF0WNr9qPtcGco3X3QSPRGDfU3pKfu+PD2dZbioBDNoq+8sx4
 Xtq1mfew/TPI884kIVVhjW1uKG1+qleQsprH7q/MoCPlekk4yHtC836zeI00qX8tPu3N
 rCS45ABwJi/SIa5mwMUzt/PzxRTBfh3NYDeoYqkLXxch4tsT39wpDr/etq/v5BTKzUWQ
 XiLAyffJrnsL1ue9Yf1Pab87uFo1XC7BhLNHD0U/gBQXO/2VcF2u6bzUvnImMv/6M9e8
 NVMZC/LwKCraHi51fbeCWMnSYitgtpnnO1PwigSJzVD1UisbmzQJPy1eicFPIeRiPGbe
 qThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792410383; x=1793015183;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hG197sZx3XRJAemskE7V+hMhtrqkgeOsYb24Xht8LNk=;
 b=ALN9p84YvoXRl4WbluElMuOBiUOZL62hUWXr5MgKO7Qix8Ia1Zic470zdBMhG4dxuB
 XFnGdpJ6KS+McPfel4jTb71lOo4GhIGunAGYsGS39gl08jbgAf499JLdV8I9m/8H8rSM
 3bJ+AMbD1xRyKZN7d9npOqT2p1h1d+IxVipI8606JvGji7pb3wSYLBE4Y3+5ZCRLUgLR
 4ZYbr/cY7dts2Gi9464cyBH0zCh5rfBOOA+LqDykM5LrBjVGSfmLHKW/EMUA0uMqAmkF
 FuR/s5u5sxBu8+gjnJzoGZ8sYwfRKO8nbLlT4Ab+gFb4yUoqIXxLGZjpQYuOXLjTaF9/
 KDPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzAbI4KQ/89y4lnqemp7OGNZV0Lqsgz1dTSC8LJ3/b5weKF7dB6nG1zRPmShs+YCsJvv7lvD9FAKw4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJFUomQbar8HFUYUzkH+N1Lt7dDS4xSZew6soXqYoPWJEdIr62a
 tmGOAyTW/JnMj4IcHgKFQ/8Yrcuw/WxC0xioChm3HTPJ+A65cJ/vdU1jtb5qWCzqrqy6TCn3f3d
 w5zA2dWiOxrcgNsURiPVB9aKz6PWCOWStuztijYmalwevlDMeRzWMsu7yZFrjlwDrDg9xRUo=
X-Gm-Gg: AYBFou1aJuMDbfQiIMcxw7T63PuKcgV09qVHR4VrqoVmlSWAOmstWaLAUdUSik1pAod
 NbwmE/lqLPlppksb8ZYFYyP2nFivKn3a/kChVFUW2XYUY3dBgKDWjxnHZvut7oxyJ1lCPANar0J
 oPGBOT+nfQt6LaybG1AJtr5RPwdWRARWStgMr3wJoBXI5N99wUcDccEDu/0WVQQcFy1F8Dc3R6O
 fqwj4ngFhiCUX5I2efoygltRwG+6kuiU/Q5YgyyzNtufb7Fhasspj81DZ2ugfR0VeYS1Ra+39Pl
 K+MYeugxl03YH4WzwwPrcK7vigXg+9XYlsXqDfbfKmV6i2NBAglJ4KryPMJkbhzbYlrokIc+V01
 ckIIERDLjiK4piACu
X-Received: by 2002:a05:620a:2601:b0:93f:115:7338 with SMTP id
 af79cd13be357-93f29d66830mr1237946385a.54.1792410383088; 
 Mon, 19 Oct 2026 04:46:23 -0700 (PDT)
X-Received: by 2002:a05:620a:2601:b0:93f:115:7338 with SMTP id
 af79cd13be357-93f29d66830mr1237940185a.54.1792410382478; 
 Mon, 19 Oct 2026 04:46:22 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.187])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1e19ad17esm60581775e9.3.2026.10.19.04.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 04:46:21 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:46:18 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 7/8] arm64: dts: qcom: sm8150-hdk: fix FSA4480 address
Message-ID: <rpsezddufer654mndwogaguvriun4i2lhu4nnosedz2h34qnfk@s44v3tjrrnnv>
References: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
 <20261019-sm8150-display-card-v2-7-86c05068efc5@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019-sm8150-display-card-v2-7-86c05068efc5@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: rGPM2OTU-qD3jn8xCF5OYTtK-tKxbAEn
X-Proofpoint-GUID: rGPM2OTU-qD3jn8xCF5OYTtK-tKxbAEn
X-Authority-Analysis: v=2.4 cv=H7NOUOYi c=1 sm=1 tr=0 ts=6ad60310 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Qvngrl3H0rQgGg+94q4QgA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=No1CG8Rj059PRq910ZoA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NiBTYWx0ZWRfX8GJKs87i9YaX
 H48qe/Y48BpsVOvyV74r/RU2kHhjlRY/ZwiQklRBTg1O735M5N1NlpKNlRR9kssI3rjAEwUAUqB
 Mi+ZIkj9Ke6he/K5P2aN8CBCyM3ubQatdZZJW0Z5jxNKQ0G+b4kca7+sF3IFng55G15BV832/2E
 c4jnT5QSbB6V3jt6jf5O/Y+Kzdt+fD0wvW3L148xAx+mm7tN/z50YbnKgRtIsgvbTpYM9Hd4bs/
 p+E5TJ0HR/40u6S7x0Rr7jZiiVTEXBQnMBp22VsAi93b4/a+4RFVjAVItPIV8dTtJSA4Mx7WLbK
 1JPRyOXVRrZFdVI9kJajK4xeqNfE464dSUQHi60CLIZNk++T+F4bYs+75ixN52eIVwBezXiK7Fe
 snx6jJqip7iA/OFNIny7KUy/agqb7o85xZK2lm5m+jygK6+kFRqmmNyOjpfAgRbA0bvJmFgqC0S
 z60VsPz/fZVlbAAH3qg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NiBTYWx0ZWRfX4VsLJfeldgmk
 0Z21CXqnDqQ+MeKFtBCcBWLYbe7x+iJdEIYgX4uamYrkx4YBFXoKbMk7F6JhRQCp1i12rHnzBnx
 0ejTfNtStT7JryGamH+rSvdzgr7BTts=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190046
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

On 26-10-19 14:25:43, Dmitry Baryshkov wrote:
> The FSA4480 on the SM8150 HDK responds at 0x43 rather than 0x42. With
> the wrong address the mux driver fails to probe, the Type-C controller
> and the DisplayPort controller keep waiting for it and the display
> subsystem never binds.
> 
> Fixes: ba712fd55c7b ("arm64: dts: qcom: sm8150-hdk: enable DisplayPort and USB-C altmode")
> Assisted-by: LLM
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
