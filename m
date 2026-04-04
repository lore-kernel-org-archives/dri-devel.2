Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A960DE63FFD
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 21:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C019C10E04E;
	Sat,  4 Apr 2026 21:44:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="J6MeK2c6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bXpLnz+u";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB39010E04E
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 21:44:14 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6343ZkYb1873021
 for <dri-devel@lists.freedesktop.org>; Sat, 4 Apr 2026 21:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=M1lqoTHHtvZmQw4ap8o2vp4C
 /j3uIcLBtxHCYWfV8yo=; b=J6MeK2c6jho5YyWLXnStUGAJCHSAIxta/xj1C1K8
 t8gyifGHUO4sj3l8R+9ExHrIrzRowGUgtstKJMdbGw0Bv7v3KW0dxTv/89NBSDc1
 eFsImhTW/Ckuj1b64mSD5p1vgZjtA7J3OArELnTsL1hERrkTG3jXmq83h37RaLH4
 T2ksbub0Q+8Yle/ReJ29xJtOtZHrOJJFXGsvr0+tIoBTCZaz//+jSZB6XfXUJugK
 RV1RXdY4iy16u2EsrXUqUFaROkIU3IiKBnel7xouy61gOf9HCh8A+w7GhepMZuXD
 IkcMz+TyEMsU5jC4OJbjBf2xolr/cVGuJ+890uE40e1NfQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4datv19h91-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 21:44:14 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50937cf66b5so134907851cf.3
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 14:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775339053; x=1775943853;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=M1lqoTHHtvZmQw4ap8o2vp4C/j3uIcLBtxHCYWfV8yo=;
 b=bXpLnz+uDAaKQIr5rXsD9HxKmEGrBiatxV1RD2kXuPCP+eqXWT/aOgZOy1/R8lLiqi
 lnFsb8VgFJmihI2fRA0FgFFQntHFjaKwYIOc2b7DtZYRdJxQNwfkZoC4rRbAH+5mqf50
 RJtf/xmfc7LqvmXWqsTB379OSAxejNRMajtLzNEEaipD3UQamyomrZ6nSllNTctzBvZ9
 1tVBstHksezG8DwmS5z5v9+om+pI6YorSD79XkYZpSWuR2nX0SXbg1D75RhIPY1nZkSp
 XxOHimOi+TqXV7haeLHFvuxuNuZVCQ+fSqef6LYKMtgs+M6irkDO7YMhE8kQDOzp8y4d
 F6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775339053; x=1775943853;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M1lqoTHHtvZmQw4ap8o2vp4C/j3uIcLBtxHCYWfV8yo=;
 b=ZO13spJnhD78tI4sUxjjq5hro1Ji81iYcfIFP2UE1hadDgtkkAOkTDmiBEs0HKR/lQ
 E+emHGOElINmHJKp58xe/py3lQSKAmzy3KzMlg2M+7NXsbxbJC+dwzHCQBoAiHUr3pwW
 bTe70IwZUzqzipJQsvypbvQi0Cz3kz/IA1VG880SpiSwSp7PA0hYu9OjL8Ad6wg4FRIY
 kKcWZ3vLBoMdCe9TYcEWTF108DIuujd4X8FdbsPAnoRRPz7HcD4p57zhFL35Y2onaxf9
 5K/AQU4nF16YYDWD70YCnbg7aK7gJnpz63cKpiLKO9wRoqRUnIjheKMukMw+YF3dhNYm
 hvGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM50kpNrmr9zB6N4gsv3aVK0gba5gfnaKi3LjQ4p9yJpqTBPviO4Y4d5TqzPDJnUKPCwieV+LTces=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRlkMtNk5s9dx/h/tb/5jUnws338QpSom922oV/bl6M7WYiS8x
 J5vIRi4Ru6sHCAj1IaxiJBjioc1pzRsSF9wrGcapqXTUYCdGB5D9flqj00GR7k4PTW8KPaiQvzH
 +k6vgnizbAV62GPb8WXbUhH3vl6QQf55vt+ruAauUrxf5hKGWY/6dQgsghfUe2ia/EffDDiY=
X-Gm-Gg: AeBDieunJ6+buI26pkdI9Rl4cJDmQRyo9SMqBUDpHGc2QMZftTLqZxl7SRzQO4+GMRr
 c6yXwMpML35cUwpNJZhn0mUaiaDjzZhJci4N+3LPLJbkH/SLoDrI8VNEY0t7IyPBcr6NY6lhM3N
 i/+uQqlbAwGrB3C4aepTQpoo5OvgAbfDgz4+rSoQC4WYq0EGv57uGOmU5GZ6RdQb73uZ8MI4plx
 V3GAboSjqJQVKRz/1kKPvwO6LB3rbdNcIxKKEOcBmNeLRwrrsiyPV7mt31azgFgu2EYkNlB+zkd
 rZKpQZ2kd8Y35zhxt7SDpy8FUl0miSceeyVw4/3idmwaDR414e2+EvGzCI6AoBPi3+7hVJo8IhV
 I3OcMIG2fj6zhE//vNKuBCDUjSnRIS3LvNUhv/YWlEnQ4FX+7cm4r2/3imqLUPWofcsud4xlUfO
 cuqbxPzp5Spa6jGsmLy/D/Qt2Hjm81iKyHy7o=
X-Received: by 2002:a05:622a:59cd:b0:50b:4dc9:3488 with SMTP id
 d75a77b69052e-50d62a80f05mr118604221cf.45.1775339053268; 
 Sat, 04 Apr 2026 14:44:13 -0700 (PDT)
X-Received: by 2002:a05:622a:59cd:b0:50b:4dc9:3488 with SMTP id
 d75a77b69052e-50d62a80f05mr118604001cf.45.1775339052836; 
 Sat, 04 Apr 2026 14:44:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cd217d85asm20165011fa.41.2026.04.04.14.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 14:44:11 -0700 (PDT)
Date: Sun, 5 Apr 2026 00:44:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH RFC 4/4] arm64: dts: qcom: Enable GPU & GMU on Glymur CRD
Message-ID: <ui4r3krzvd3i6kjdozhmmueejdqpbnbo5wfa6pwzjolcse3eeg@3u7bdphqv4iz>
References: <20260405-glymur-gpu-dt-v1-0-2135eb11c562@oss.qualcomm.com>
 <20260405-glymur-gpu-dt-v1-4-2135eb11c562@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405-glymur-gpu-dt-v1-4-2135eb11c562@oss.qualcomm.com>
X-Proofpoint-GUID: -lbsK7lcGD2SYL2R2rRQWNOzGDfSwFAO
X-Authority-Analysis: v=2.4 cv=GLEF0+NK c=1 sm=1 tr=0 ts=69d1862e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=HqnkvqIaPZsfh6_35gUA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: -lbsK7lcGD2SYL2R2rRQWNOzGDfSwFAO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDIwNyBTYWx0ZWRfX6nPghovqFEus
 C0D0gykFCQkSHXAfTX6juM5ej0GOHdzLpWbMaAGASTBcAHcVjqFSvc0PH65O4GWqMz6yxUGOwd/
 UOvlAJOkZ9IjQnC5VCJva9YuP+3fsf34oGbs6KSENLwproiAyDN5WOntDCc1ErWI0dLVvRI2zzV
 FUJ8QqXy77hiaAhTPDZLswfgNBGuR8S1xDsw5cvezbu0MsrxCoqoC/oxAGutafaH++E28BY9xex
 D/Qj+ZiIGXGONNMPuPA2zJ5TixrNUCuCFWhZoawC/DF8D79Xwsn2XU75XxyNyQ1DseXFc+i/Gvb
 Lv2unE1kWqo9g0qKvUbADrtvUgMnVHZsGU3V2E6lI0AzWIr1RaoxhPCanOgO52rl4avAMCRjiSi
 M46uAzSWFs2Q/ocAhJute1AEvFu7VJrIaosHWFJPjvLNuW/4O7Rchj84TMYuXvlMQqDkF19j4j6
 i3IXGTpFKqp+Kp9ywHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604040207
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

On Sun, Apr 05, 2026 at 02:33:17AM +0530, Akhil P Oommen wrote:
> Enable the necessary DT nodes to add support for GPU on the Glymur CRD.
> The Glymur CRD boots Linux at EL2, which means it doesn't require the
> secure GPU firmware (zap fw).

Is this going to be a default mode for other laptops too? Otherwise it
might be better to keep ZAP node enabled by default and disable it here.

> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur-crd.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> index 51ea23a49b9e..a579df902323 100644
> --- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
> @@ -110,6 +110,14 @@ vreg_misc_3p3: regulator-misc-3p3 {
>  	};
>  };
>  
> +&gpu {
> +	status = "okay";
> +};
> +
> +&gmu {
> +	status = "okay";
> +};
> +
>  &i2c0 {
>  	clock-frequency = <400000>;
>  
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry
