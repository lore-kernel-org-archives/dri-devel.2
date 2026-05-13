Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6E3CD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 16:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27AA710EF74;
	Wed, 13 May 2026 16:52:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ub9SG6+J";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i/tzS7ft";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D43FD10EF5F
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 16:52:22 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DGAv6L2524359
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 16:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=PQDKVHkpUsfpWP0216KpWZo/
 ckkZQvWAnsqZGCHLh74=; b=Ub9SG6+JgDbR98bvDLUhCV9iBCiaZ2TMHpDiSraS
 Kxee6/wCy2LOyFoS5fSuP/f6AN4+VlmVakSq+jruUriTHDoh8SSpyCvy+CwFiXpx
 kPO1H5Nl1vrZ22MN5zAsz3+ke1ipSWJSxSxmEzxK3didYf/fpqFQmF5Af5Vl/z2k
 i23RfLj2pmfIJnh9C8TS70J/VzJsi6ncVhIKLPjfyjVDmhe3okXnA5EEv3DXAHfZ
 i1J3q8RIFywnRTVNiLLvs108RhgG8wuOJ2IzBrhA26nc29JtS4G6OfteEprEiUz8
 hYGXeEKA7Rgqm7bkFCuiuZi8I8dieqvYDx/HrzTFRimuOg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4vkjg5g4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 16:52:21 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-634ce585b41so2069098137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 09:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778691141; x=1779295941;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PQDKVHkpUsfpWP0216KpWZo/ckkZQvWAnsqZGCHLh74=;
 b=i/tzS7ftfr4ephO8cnEF4eaTm6V1JZ/wNOPNDgmBTTHZvSTqspwDcFw8wYwnbZ1ICS
 +2WA3jOladZRVxBOaajRbNr7+cJGqIVCv1TDG8++Sr4ETEVPYE6dCtuKDpJ4Q1cN+Yiz
 sHwLacCLVGoLltmgpvHNcgDpmZUUr5TfL8BmduAL3ZF3Ke4jyUL/MW+R6iVKfiaRvCct
 aIQZmNxHaSyAeAG/mWXV5r/O85vovelh4wsoqOzd9y7F3vLjJQCZriaHguwky7+ebqIQ
 AfTdXEpdQ50lO3fppczZIDXZPvJOVAWOB+F/xRU10efen6SKBbADHEfqTevlfem06nIE
 G3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778691141; x=1779295941;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PQDKVHkpUsfpWP0216KpWZo/ckkZQvWAnsqZGCHLh74=;
 b=mkghxQhx3r+P5OaVfad0iVFfRdTB5nA8h1aQfHwPRIF6fZpTJPq4XFSHm52oB1yZWk
 YojWnYd3vQOTlDGVoBPJx8MKmYecEGSYHbEYtGk+IFRmMqcDvr4l2DBv0G99MsO4+Rnu
 FRVK07HzAFT5mjk4Fkm4o4fL5aHFGRh1YDdeBD4BnX/5oSozsE2vmzBoEKVBd5JNrmRG
 frK3S6utiUhVFraxqICJLayNhbDNWRMYU1wkr54YX/uodY+d5C97ukMu/LrKjvSxj4II
 yyZmq2mwBinRHizUMA/bbG3AFlsE/5I51fyKJZCn/uuqEPw+h/JVydlWLJsyyvgxFgyu
 MzIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8N9NktIWkhOJzo+OhV7i4NE63Zurje0gxNH20f2zyfNZ/oQaW658CL0/aocdnktrmbJG8u8Oigtws=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YypnnbmGVIUoZA9kIwR7xDlJ6SPfLktdrPWpxK6sBlFmme5WR47
 l78NWQleATEZlA5JFQMZd/vCp6krmoyv7On+6hrjILrPF2x35GaslPFoQBSWFLj5g4jhV6XDmzo
 n7HtuptlERjDUZZXIkd9/rsuhdl9Vjg36fQM2dG0gk5kqIDKnSUPypAMl5zBWF3Y8cdPuPOs=
X-Gm-Gg: Acq92OEb90uRGNBfNkCrRtouN/RrbwKoNtYjmTM3j5Hqd1k5ma+oBZnSa0TYzLNwmar
 IrFWryRYId2R44nC8FBzadrf8oEpOuy9WmfoJgjwL6O6jWYS3zYvg7yx1Mvm1/cK7ws5J6JPxFa
 1vZ5HZZxOIr3RvzqQeexfyue5E7uzZPHegfjk9eNQVBeuiMEv1P0AVv1wKbIZF6hGkYHhblMb0z
 +5nZN5jsSE3Zt5UzKxQY+NuWj5PsOM4z1+oFLEIUJ5y477013XUptM6DSg/qf4AjdisqeNUlDSK
 CQZHozWyPRitL0KB3WM6I4IZQnW45ZYdiwjtBAqCpzVOlTNb6cOypp8qumv+t825ZdRWD/tCDxn
 Fy1peA0QIj8PozpPFlLdli93IuwG3rlw7ptZn0bFNdPlw+Xm2woEAc7qSQWMaKkcMobd/nGvjfP
 XfAK++7o3t9nPEpm02GovQffd+KYaJkNynikE=
X-Received: by 2002:a05:6102:a51:b0:632:29a5:2b27 with SMTP id
 ada2fe7eead31-6377239d243mr2364700137.3.1778691141083; 
 Wed, 13 May 2026 09:52:21 -0700 (PDT)
X-Received: by 2002:a05:6102:a51:b0:632:29a5:2b27 with SMTP id
 ada2fe7eead31-6377239d243mr2364665137.3.1778691140453; 
 Wed, 13 May 2026 09:52:20 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a956b3d0sm4096876e87.80.2026.05.13.09.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 09:52:19 -0700 (PDT)
Date: Wed, 13 May 2026 19:52:17 +0300
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
 Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: Re: [PATCH 4/8] arm64: dts: qcom: kaanapali: Add qfprom node
Message-ID: <smuahoo5kk23pmy6hl3ydnha4aak3xyalrkg4vydixoq4zrro4@rpb2c2oy7lko>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-4-13e1c07c2050@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-kaana-gpu-dt-v1-4-13e1c07c2050@oss.qualcomm.com>
X-Proofpoint-GUID: KfsOf-7Q9DiW0s-6dTdL39b_7ddLp3Eo
X-Proofpoint-ORIG-GUID: KfsOf-7Q9DiW0s-6dTdL39b_7ddLp3Eo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3MCBTYWx0ZWRfX0ZNHNvG5e74l
 Y32vPxCmSzmwof3qruUcrhEnPau70/lU4jZ0ZoWIUPHBO0u3TwY7AxGxxwkWSJC7MhDGhue7+JB
 hVOjauHISc/YXUTa1p0Sq6LpnVv2FUOF4U7ZRNgU9PZ1yircTPL7pofDZK8pkH1a8j6/p0NjYMo
 +F+s1N3DU1M6bt9IxjStWWNhHIWSFlhYMZpS4BMk/NpYoJ0nCOHo5P3u+nd0aTwS9eFjciZ26kA
 rNCuslcJTqbi0Bm15Oufk6X/zjLlBI1jt2wsDQE73UaJGNaY953MGAE4kZYOcde0p83nj1ctxd4
 08aNRAuwbkXSVy9OiEQ0Pr5ouv7kQvfYsiYhavqltS0ewF0gcJCZurifJvx2SE7uoy0mnrAH6bz
 XOL/p7slfcFNAF1DAgDln2sKsjkW3J6pfxh7oFYce93MGSlUE8zD1bx3KVaWK4p0HfkuqFbJpWM
 SZEt6+uf35JAPAFJiIA==
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a04ac45 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=UQAiW8fk4jwks4S4FoYA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130170
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

On Tue, May 12, 2026 at 03:53:18AM +0530, Akhil P Oommen wrote:
> From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> 
> Add the qfprom node and gpu related subnodes on Kaanapali SoC.

QFPROM, GPU

With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

-- 
With best wishes
Dmitry
