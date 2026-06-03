Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929D9CD6E60
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 23:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08EAA11248C;
	Wed,  3 Jun 2026 23:09:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ItHNQFCV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TdihjMq3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E2D8112489
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 23:09:53 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653KC94H1740590
 for <dri-devel@lists.freedesktop.org>; Wed, 3 Jun 2026 23:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=VM7re91kygzVwItS+ciTwBT7
 UhZcfvCtwxBR7/9Rl6k=; b=ItHNQFCVXlcr3sWHBPrR/Jiyl4WNsdz75NYJwNVA
 u9QYRBhxqmnTBQ6F+9QHJfy37sA8aw1eh+flWW0DcMAOSAncb0ALAbwf2oEwVI1P
 QA6KKlRW2F7birwA6SoFimt7A3uGH4cy3TNDkc2u6n8pcpl0nE5G4aFicrt82W53
 xwnuayjo+lnqnsFItT+VXwZplDO+BbvxbXdnVLYbEXLtVZxdSA4mVkzaCLFzh2Wr
 0yed7dV3ssEW8dSjmHN5h8X+Y6Hvh5/HOMMoOOt0nM+u1LXpkSwQUJOO8aqtxcTa
 3G44XaKRDxj2JxBKRuPcYPc4UVmMz6FyfZltEbPOipE0fw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejdq7vd3a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 23:09:53 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-963b099b539so1466943241.0
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 16:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780528192; x=1781132992;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VM7re91kygzVwItS+ciTwBT7UhZcfvCtwxBR7/9Rl6k=;
 b=TdihjMq3KzZTu6ZMPmpVKqW0VKKWrEmenggtJOWqOIYW9RomjGanQnyHOt3tt9lUhj
 4LfET6RI6atjrf5PofkJxr51bFlJuSKqOPI+n7VOWRVNvrl7l1wyKBowIMyoXANWjy4O
 Hq1DkHjZiLDJPqVaTSX380zCsLpzvHXLeh8p9hPOO+pKhsEajJCbceHx6QoFixhRZm7q
 z/lY0PKZqHDZeZ/A1A3i4/c5TMDUNAzuNsRRFMXXNYfOuR1ILwfnDCDDZp43myr96NYi
 f6XJ/MHCbzPP3LDQJXnNx0YkwQ18S9mxLrUzknWL2MmYnYC0rVEu0uC8Cadw54rF96LF
 SPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780528192; x=1781132992;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VM7re91kygzVwItS+ciTwBT7UhZcfvCtwxBR7/9Rl6k=;
 b=SZs0TkzElV2TkXaggAFMuG44nygaUQYqoKE6CBbxgWtVYObrFOHhReJrR7shkxDJSK
 3fDnHoSFbqL3swjZjhCECqbeIpMdWIkQpjZNsShcB1cWgDiv2+60PMFNoVN53KaHzAuK
 l55aVNBvMh7IJ3GYJK/cm87b65dQITHj3oi6/LGqSoun521MHR4bYXwkN9+bzoD9G/d5
 8h4XCmO5V+RMUcxOcYjLtW4WNGxoxpbAMPsq0tAK/RUq3hGOgzF00IvllPrAFgoS0NQd
 yiXEokfXZPJ6pp9jRoqVapGr8cvln6J1lmKG/vwZgsxC1TlRqUfV+oDQjIfebWPSiafy
 uVpg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8YuyCW4K2I6DefLrLh56par2U02wIk8pEuvA0OxhyB3eldO3KDHRWOMEFHbNKnIUbkuWZi33lOOgA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwXyFFVEJOY5Ct0nTHmXEg/j71tVxAjFzaevVuqgXSEPaIJbwnb
 QcSIVenUbc+xn6qX05EI3cstEsIKojpDjdOg23Y2ZWO12kHTGpU86aWhpQWVyS4YpkCd4fXLcKf
 x64UnV/JMdKFqfJ2pz4eOH1IYyXksyyub/ztwR4va01F7AjN5qhsoRvs8D7aCI4yyjB/5ibY=
X-Gm-Gg: Acq92OEcz59Sy0g+xlIZ9CqeLEPTZ+8VxexqYTAZzHZG2Qz5Yw0xQOPOL6cx4Cl6XRM
 czE5NgWj1ewmSnHSDxbf2fZrgvRqLKbY4AsBusQVoqKkL1bs4YSHbI8EvHbDz6eGhtXxoihon9R
 WvYmKTNqBszSaZxIoBdHeK/lCp2hCoZI5tFqBQ5GB4W8/F+oK9vIrTmOp1delPEavU5nj4MCqAG
 NuTlN7iWEghQCbDBtQMW65B5/FwpYlEBGeOxIwtfqIbQK5deoqQKJ7cqxVZU1X2DepxPVYSnFg7
 vg8uR9aefouWLB5edjKUhb0CW7xaKcJXEfWP9I9etUnijhZiwkwbIeq0eYTtAJPdrPrhVOSsNgw
 VVWWNpl8PL0GBjKB9GFSmFgKaTFidm7P6N/g1dKh/Z3sj+cnrxUDDTylDQ/+3ho/O8+FiJNKtn5
 5mEkzogBs5FukY3hKA+ldLAhEoIYcEiZ85AchaStwxT3l0GA==
X-Received: by 2002:a05:6102:7:b0:6d2:1633:1803 with SMTP id
 ada2fe7eead31-6f5512f0f18mr606510137.19.1780528192019; 
 Wed, 03 Jun 2026 16:09:52 -0700 (PDT)
X-Received: by 2002:a05:6102:7:b0:6d2:1633:1803 with SMTP id
 ada2fe7eead31-6f5512f0f18mr606503137.19.1780528191675; 
 Wed, 03 Jun 2026 16:09:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b9082b7sm883863e87.36.2026.06.03.16.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 16:09:50 -0700 (PDT)
Date: Thu, 4 Jun 2026 02:09:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
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
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] arm64: defconfig: Enable ILI7807S DSI panel driver
Message-ID: <bhq7pallav6wfni7l3xtalv3ophpoa7offdzdhfoqk3a6lj46e@ke34hu2ukig7>
References: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
 <20260603-shikra-display-v1-3-aeac1b94faa7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-shikra-display-v1-3-aeac1b94faa7@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIyNiBTYWx0ZWRfX4n5KwcZ1IIrj
 o2KS277Omr3FtS4ASv7NFpzAJFZc0uu7sm8avsaS37HyU3p/M/fKTDE/WMCtvU1nVDyO/Uz3+H0
 J5jINV8IEXe3JzoeO51cYYCY+wA60MWFLfq6WNI0Sr8QQHkTvZANTKIl0FshC39x889eaab4Ii0
 zufshUIz64cGARhN1kppfLDrpZz+vrGH2NY9vx+qSBTjpbL2ht+qo+CMImBHn2ye3AxDWDh0cGj
 vXVv5gISm0hFM1iEMEpOyOV+j64Mw915Og9wTcUSusx7sLQO7vsYfhLoO1xIvba6R1fs/8SWp2R
 v+sq43dHtTel33KYvllg8OM/ZK5Qhi4GJG5MWDfB7C1VSvRGMgJUNvfyCLEGdhZBmR7toUw5UpE
 /yEGEiaCWzqRN/Lf9+EzKn54pNpWPDCPZiCDUJYX1aEW+21mRNaipeeR/45zPe0rmFugW1+NbPk
 j4z1uXJhGtS1mDGqhsw==
X-Proofpoint-ORIG-GUID: qjcXMVGtnDLR8KwcqX_YqlinniTIFUbA
X-Proofpoint-GUID: qjcXMVGtnDLR8KwcqX_YqlinniTIFUbA
X-Authority-Analysis: v=2.4 cv=ccniaHDM c=1 sm=1 tr=0 ts=6a20b441 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=oNl6jLlcSFQHEdJXP8oA:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030226
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

On Wed, Jun 03, 2026 at 08:29:28PM +0530, Nabige Aala wrote:
> Enable the ILI7807S 1080x1920 video-mode DSI panel driver as a module,
> used on the Shikra CQM EVK board.
> 
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
