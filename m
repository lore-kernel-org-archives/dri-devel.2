Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49191606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pKS44ki5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QLSXhwDM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DEB811227A;
	Thu, 19 Nov 2026 10:41:03 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 236C1112278
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 10:40:52 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJAFa3O2018599
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 10:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=uWn3Y+Jdz87hhj+gJPn7knzb
 Pk6e9lytITsJOXk9EDQ=; b=pKS44ki5JI8wObyvuYSumrjV1F5uMVnuWt59cV09
 bRFFE7A7VpaPuOM7Dbqd6ZZh6PASdsXRtcxjAaRTRTv4Rg/yL8IY9394U7Tp+qTe
 P/EAgkr5hs5MOLN0HRRZByTTjRCVXnfFE13AaCeV8l8svPyZOoxn9CCPUzmy+j3t
 X6WVigE6NAG+ZUoI/oRP9nz+eNVNwVLxIpYQmpFVgM/VfU7QWQ1wo1zod+v2I5Qb
 9wy6GIZMmBu6DArSWgh/sKYGOewFyTsUZY96ohYerxdWgsXiFyEksFx32tDmoltW
 UnQzyK5RQ0esjcC9cDasrNWusVJFhsD1Rc60qM41NObSYQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1uux946p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 10:40:50 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9495c71055bso443364685a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 02:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795084850; x=1795689650;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uWn3Y+Jdz87hhj+gJPn7knzbPk6e9lytITsJOXk9EDQ=;
 b=QLSXhwDMuWR/HzEGdP+RGifGBgo3cq79IM1cHUSsK+baRfM2hLZBRBQcNKm/FNxN3g
 TtMmVUGpwB9z43bwX9lirb/wCm58YY+zSH9K0w6x6uAG6mx7hF769eF5ItFkriefxCTs
 1zIBRsNEROTWxNVziXB/aJdQGantiMkL2R32eC39lCrT+FlSRxg+AqamtC50GoWzV9RU
 te9cqvKEfRXR8GScr88Nt8M7oplnZgXqH2IZgzCMsjrq9DMdbBZ8GXFfoZeF2FWU0mZc
 BNT6MwXRFGaPZ9xOYBnfU4ThFfRtyPotJqkcEDb7ZfuikOQNBXtk9CNbDuxI6ZzXTrC2
 FCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795084850; x=1795689650;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uWn3Y+Jdz87hhj+gJPn7knzbPk6e9lytITsJOXk9EDQ=;
 b=eM3LJPwjMrzknfF2S9eTR38BLIKWOCZ06DYfimoU6+LSn6Wqglg7bAN9xqFOSlHfkQ
 PPeIVvXpxM0GUMCZ0th2ob9fqAw7iEUSq8lxGAWi4OL7fz6wQp5XFYPAgY9M62k7j7V9
 lNyyZXuJk9X6FsbaX6vYhf3eJKeIyU0+oUbvlf5A9+fWcwA1o52ECGBv98lp4NKC97w5
 55GUMmsF1WEuuMXzaZTed6iqbX250tuByQbDoyxa8mcH+mi2+A7LpYjRJD5gKQ4ao/Ar
 agOellpzU4FPS6I7u7mSefSexV3VQJvECPOn0oIUkvCT2XpWFk1IJSCMrKuXAyu5YGmn
 XcPw==
X-Forwarded-Encrypted: i=1;
 AL+hErE/+nzloA0oQ3oHdpJL9nYA8KvFKLHelxDrL2oSsN80QwtYSzzq57G/noOOaWCPU9IchZHRKqNeBgg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+Xg7mODfV12vtEKVt/tNnLngmexnO69SOYIlKsnOQKFMUT17T1
 liCsR8iiek4GX78wkddAYr3uRoneqyY6BNZk0C/4bF0t/AQIRRlADzoANG6OtilvODvyNUH7lW2
 gp+qk6vjoL9Z5CT8D61RopGUZTwrU50cFt9fYKMfF2/BxxGhL/UE3H/TnPRjq41UuGvG/plc=
X-Gm-Gg: AYBFou0Bt6F5bSlVkmLyMGt6kYq/u5sx3P2mMqhSg5N6kfsRZPjHfrOrS5yf97faq2p
 sA8kHC8Q4ChdArQzcyDXGHNeIDU0yvuWYyTg48E6o63VSeWQ+o0UPfG623i4oamPsTbfbv4hExd
 Pa1I8GLzREsE7byp1D/l/0nxqvaMojZ4lKYZtnXNXzJDVELk016jGmeJRBJdkh+WkY2TU5m+w3c
 zJTQIWl92Lu4SXkxG1DSSpD8XjB7JXJKax5SED6dufU2qnE6RU/hbYNHsbhd8DQiIGApOKWvKp2
 LGeQnvfo22dXpCozOslm3/zDmMd9oQQ5To5Do0cg5GICJy0JjArx8bQcYV5pmZNxtZfDxE8aRVB
 cZ2Tu6WdYduZVu938AHcqsLNWvxG4gufCVI9wgIJafQOWJfrH2JUwKKLxKkOgWd44+8eySTEGh2
 0/jmxOdIKbiAI=
X-Received: by 2002:a05:620a:461e:b0:93f:dea:3b7e with SMTP id
 af79cd13be357-94999721e29mr990591885a.24.1795084850134; 
 Thu, 19 Nov 2026 02:40:50 -0800 (PST)
X-Received: by 2002:a05:620a:461e:b0:93f:dea:3b7e with SMTP id
 af79cd13be357-94999721e29mr990589785a.24.1795084849693; 
 Thu, 19 Nov 2026 02:40:49 -0800 (PST)
Received: from QCOM-aGQu4IUr3Y.na.qualcomm.com ([195.50.164.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb85343607sm31483185e9.6.2026.11.19.02.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 02:40:48 -0800 (PST)
Date: Thu, 19 Nov 2026 11:40:46 +0100
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
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
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Shivam Rawat <shivrawa@qti.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/5] drm/msm: Support for GPU in Nord
Message-ID: <av7SLvRI48ZfOqU7@QCOM-aGQu4IUr3Y.na.qualcomm.com>
References: <20261118-nord-gpu1-v2-0-8d6d9908b7c5@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118-nord-gpu1-v2-0-8d6d9908b7c5@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: R_doOQPluB0HMG4P5FkpUf4MOCeLmj0l
X-Proofpoint-GUID: R_doOQPluB0HMG4P5FkpUf4MOCeLmj0l
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0MiBTYWx0ZWRfX4LriD3K5BCsL
 IrgtGzrzLVEWzcj8YUZG9Iv3rVZNJoGyHHkVh65viuBLZ69lEOF7gDwTt0d/RpHHsmeolVGTvJS
 M4eTj1NHynYjsVdlsptKQOlvqNVXRhc=
X-Authority-Analysis: v=2.4 cv=Q89HcI2a c=1 sm=1 tr=0 ts=6afed232 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-_VEVeJjoQ_3OyoAHY0A:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0MiBTYWx0ZWRfX72zU2nXZoPOM
 KniyU5ljQJTwr2rNYjtS3IDs/wdvT1nxUxkWV9/fE7UnrvwEesBwIxGjNBkS4XeHK5nl2+lbnl1
 AYz5LmLkZFMtoYYAyDE6sOoIQ00r6bxarU5Mkdt7oO/sY0OExE27O4MBn1TYeQhMJaRKLQy1osM
 nyfKI5vIGTPHqcLzUZfu329kMj9eKNf48px9DMkItd6QgDNY0pq5fgFRV0MX9Gxy2yUWJUnXMH5
 +SZJIkQbX6WaQI1TY7h+NJA3kJtJMHgga4Xa7Ike6tbKihCIZ0KAYbsTGL5tLkIoH+mtx/W4HxR
 rIx6cTM5xnQzH8IBAmpVMhoQ+c5VeuaNofOdr4ssswyKG3gnX324gX+D+NCQKB/ZUdBY5aHVN7z
 H8uqLFNl8z6P6GHrxNwSykU/DWZFQQdCuYaGRiQm6kacsoQ9PEexG7zQK09eJatNV35UFk2JBSt
 UtixtmfMpktbsNiL7Lw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190042
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 04:30:03AM +0530, Akhil P Oommen wrote:
> Nord is the first Snapdragon chipset with 2 integrated GPUs. It has
> an Adreno 753 GPU which is very similar to the existing A750 (SM8650
> chipset) and an Adreno A735 which is similar to the Adreno X1-45 GPU.
> This series adds support for the A753 GPU. A735 support will come later
> in a separate series.
> 
> The driver and dt-bindings patches are for Rob Clark and the devicetree
> bits are for Bjorn to pick up.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
> Changes in v2:
> - Rebased on next-20261116
> - Collect trailers
> - Split the GPU and GMU nodes between nord.dtsi and nord-embedded.dtsi to
>   match the existing Nord layout (Shawn)
> - Moved the GPU cooling maps into nord.dtsi alongside the thermal zones (Shawn)
> - Fixed the GMU OPP table to match the clock plan (Konrad)
> - Link to v1: https://lore.kernel.org/r/20261009-nord-gpu1-v1-0-a06a6c57bde7@oss.qualcomm.com
> 
> ---
> Aastha Pandey (1):
>       arm64: dts: qcom: nord: Add GPU cooling
> 
> Shivam Rawat (4):
>       drm/msm/a6xx: Add Adreno 753 support
>       dt-bindings: display/msm: Document Adreno 753 GPU/GMU
>       arm64: dts: qcom: nord: Add GPU and GMU nodes
>       arm64: dts: qcom: nord-rrd: Enable Adreno 753 GPU

Akhil,

For the future posting, can we split driver and DTS changes?

Shawn

> 
>  .../devicetree/bindings/display/msm/gmu.yaml       |  33 ++++
>  .../devicetree/bindings/display/msm/gpu.yaml       |   1 +
>  arch/arm64/boot/dts/qcom/nord-embedded.dtsi        |  79 ++++++++
>  arch/arm64/boot/dts/qcom/nord-rrd.dts              |  12 ++
>  arch/arm64/boot/dts/qcom/nord.dtsi                 | 220 ++++++++++++++++++---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |   6 +-
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |   5 +-
>  drivers/gpu/drm/msm/adreno/a7xx_catalog.c          |  35 ++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   5 +
>  9 files changed, 361 insertions(+), 35 deletions(-)
> ---
> base-commit: 38c8be16846f10f3a710351357e4f4ace7254c8e
> change-id: 20261008-nord-gpu1-7e71a91ae653
> 
> Best regards,
> -- 
> Akhil P Oommen <akhilpo@oss.qualcomm.com>
> 
> 
