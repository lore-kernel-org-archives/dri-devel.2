Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633BACD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 17:53:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B047810EFAA;
	Wed, 13 May 2026 17:53:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IBlM2wlM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GlNeeQAT";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A320B10EFAE
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 17:53:52 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DFdeQL1242787
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 17:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 amWzFW2AhltZZiBpdafVGSL8sTRgUnuUyXbxrb/TJ1c=; b=IBlM2wlMmqeFHzE2
 wOWomBDbwP7QrhCvlVkGxcI9aMBJLS5dDoXUAUC00axbhIBBeU6oOEyHJWA/kVY0
 FrZHO2ySgFs6qJBcYOLLd/+oKkcBb6oiMEAa7MsmhE7tE5XsFsg0rvujVPuK4zmB
 riOzJp+hD4PbmO4Kx4+wl00kLYv4tsdzH8VGmTzGWE/fgRrmvunji+kr6o7uc9d4
 K72iuduBvH+MCTPK5MeQhitzF42fS3xuqLWIwt8OFzt2S4kKpwYM7IJ3dd5pNljR
 rWJmEll7upmriXcTaPhJymm0GzIEi6yrNGXEY9nCiM4MX79mf4Uta1hTzFOkfbma
 xtKEJA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4v4trh6q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 17:53:52 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-514ae0e3ad6so107430961cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 10:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778694831; x=1779299631;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=amWzFW2AhltZZiBpdafVGSL8sTRgUnuUyXbxrb/TJ1c=;
 b=GlNeeQAT7rlt3wmIQfdGCXhsNgHmxNvYb7Gnd++yNequj3trgKZKs6Lz4rK7iQRDKa
 x2qpcMDAWCRNon5cbYvwX1RMFhAhWEYQf6OED3WkqIOFq57tBzBsIStwij5HtOD41R9c
 H3y5A+RcQ/6h7tOaxezfUX2CFNBhGoCMx14taPZGMVwfmmUif7D7b8PVnV7bQVJQ6euq
 Wu2JtRo0aL51OAHkEXykMoR4C+Il8laq15kdZ1IkgWroXCLB63S3+l4/Rri3oo2pQvgO
 yONKB3id2F4Tbehf52DbD9wWC9L2e7uMpqQ6cDkYUAWyYnIaqjqW5n3mgmrsrgRB28xN
 HaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778694831; x=1779299631;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=amWzFW2AhltZZiBpdafVGSL8sTRgUnuUyXbxrb/TJ1c=;
 b=FoxlypWGGXAXssRP2GTTGe0HOnZx4zAv7RJQVY/Ro6lbzAQWv0n5vz3DdRnrOkdXcr
 7ED3lfI67CHjqWdxqE7uiiwvaNHdscja8Nz4o2QcxFuT7lfczfGOk1F6OvEp47rCUGMB
 qM7M6IkJ2w1n4xuexOx5S9LmF3iz3A9VdX7UsNqMd+ewj1xk9h4MvrfS6YENlAPZBXIF
 LQzVuLJzhTO6WPF+5J0GgOKVVo9ISSJTTQLwcUV6G7JYeorv9b5X4x4iH/TPnsYbOSO7
 XLiWnWiOIwjIWBbool7SdzQ0LFRLcmN5SDHEA/ewBzadgx+c/TW2NoUaPtuqcCD5xDd6
 +xXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ928qPWpJh+Olo4cIfGfcU8OBe84P4g/fl2Wt7edGrIDH/VZ7lQ7BWlO8E4+TMV+amOo7Y5LU6uwiE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx73oz0iDba2/okbozNwTaOp71afIIrqGesXUtYWB8OjoOqzJiM
 BYn23iAu+z9ezwQ0z036GtFzutYVOABjvNJZ3zK5zMvcoAXofT8hCX2BD49Y7xGEMUqz9E5Upic
 V3h0VnfJ7pKCSIUFYNUEhC2qvP4NhdPASPfZ0tpN2+ajOR/ERllHObrRktbnd68AKLpXRjC4=
X-Gm-Gg: Acq92OHbUB3MPXnF1MmXQnCHlS0kfaRu0q2nEYTADNT22qI9ebdR67QE3dVGKE9guuM
 uz7eCCLi1XNblDrrvCgIYC73zVx8LIWI3NJ0am4TaGTq3tVUrldrJzkBjxSGYBdqn8BY2hIoafe
 yD4JcfdxngCQcFKEgtu+sw6wy6Oz1wtDLS2d+c56aPN1f/t7TCQwqNjOOkjhgDUrQktDXg6G6Di
 AhAvAU6weLl3yoectIC3APZoCMKSJxM3kezlyEoZFFgQfX8tc41lzCS9m1RaPKkqFaf8/ufYDUF
 s4Dz0pO1byplBU8ksevVDUFF+/TBn47TnHfHTglSNy03x3pVmB4StmxODFryHt7zR79hV6pU7/5
 y+Y/MvkIN0LZ3xNUfEWLR2XUWOy3NB42WPcNEceIVLLra2h9JnoOr4Krx9MMwZx9T2/t/oFd3bR
 Fh7MKnvXjgucb+6B5zIgtBmaCUG1FsL8VVhQ11qaQ5RphzUQ==
X-Received: by 2002:a05:622a:215:b0:516:35fe:5524 with SMTP id
 d75a77b69052e-5164155bc78mr7504651cf.5.1778694830831; 
 Wed, 13 May 2026 10:53:50 -0700 (PDT)
X-Received: by 2002:a05:622a:215:b0:516:35fe:5524 with SMTP id
 d75a77b69052e-5164155bc78mr7504061cf.5.1778694830374; 
 Wed, 13 May 2026 10:53:50 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3945cae06b4sm109561fa.28.2026.05.13.10.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 10:53:49 -0700 (PDT)
Date: Wed, 13 May 2026 20:53:47 +0300
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
 Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Subject: Re: [PATCH 6/8] arm64: dts: qcom: kaanapali: Add GPU cooling
Message-ID: <iun4ziuei3tzvr75qbbqgxytto6vptvtd7j5mr5ol5aqviaafz@5m4yxgnqjavc>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-6-13e1c07c2050@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512-kaana-gpu-dt-v1-6-13e1c07c2050@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=XIIAjwhE c=1 sm=1 tr=0 ts=6a04bab0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=U2egry7Pn7Pb3urGTtEA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3OSBTYWx0ZWRfX0Kf5SWF3zu0x
 mbDxlIJFOMRlsfvzNZ/iX5wNcIAPgVhLtkttvxp4VXve65CLbkpXZMJeQZo3WFZlK6y3cP+JuLx
 XCUUVdyq+v2tSnQuIwD9zIaBmUmd4GJKAGrNigp4YT0Tk5OJngI6tsHe7p9lKOTyn5w3SPUOt9/
 7w8vtflocf9AexcBD6gQn7SK7kLCPmg8uye4+w3QOYv49mfUishYJ5gbgh9HipSFkIg2EPl8M9F
 QrnAXyLVL0dwUKgaZGwHrkFy1rd8tzGC0mUat99JifZsgdoo9oU9PmMYoimKrP5JtvQmSEhtWQD
 u1gNXL1lx+Hv+UU+hC1IBUX3v0VceSZvxbgGP0Ofu0M36ZvEWJEfCR/ERBZiTP3n9ee+o3L+kfJ
 S33whtmA3enWIoIbCLpRyRbSGSyWXZWcw/eVmLgAGTm9pYxJQwCnDd5WTX/QsswV6k0+9BU3rUY
 GRRwlgr8xPiW2IgF4rg==
X-Proofpoint-ORIG-GUID: IWb-Nx4GPUOWEsAL52lUyZfBpMmQzBbZ
X-Proofpoint-GUID: IWb-Nx4GPUOWEsAL52lUyZfBpMmQzBbZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130179
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

On Tue, May 12, 2026 at 03:53:20AM +0530, Akhil P Oommen wrote:
> From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> 
> Unlike the CPU, the GPU does not throttle its speed automatically when it
> reaches high temperatures.
> 
> Set up GPU cooling by throttling the GPU speed
> when reaching 105°C.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 165 ++++++++++++++++++++++++++------
>  1 file changed, 135 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> index c57aea44218e..5089416ec32c 100644
> --- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> @@ -26,6 +26,7 @@
>  #include <dt-bindings/soc/qcom,gpr.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  #include "kaanapali-ipcc.h"
>  
> @@ -7045,13 +7046,15 @@ nsphmx-3-critical {
>  		};
>  
>  		gpuss-0-thermal {
> +			polling-delay-passive = <200>;

Other DT files use 10 for GPU thermal zones polling interval.

> +
>  			thermal-sensors = <&tsens5 0>;
>  
>  			trips {
> -				gpuss-0-hot {
> -					temperature = <120000>;
> +				gpuss_0_alert0: gpuss-0-alert0 {
> +					temperature = <105000>;
>  					hysteresis = <5000>;
> -					type = "hot";
> +					type = "passive";
>  				};

Why don't we keep both passive and hot trip points?

>  
>  				gpuss-0-critical {
> 

-- 
With best wishes
Dmitry
