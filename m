Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9255AC61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC43710E2E8;
	Mon, 31 Aug 2026 16:28:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cQ84dMke";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="En2h+I2/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8276710E2E8
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:28:03 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VFpfpn3395816
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LkJ9lxCTtDvdCe5fxVE9tsx5zXvwZAtV4NrQpN1u2Ac=; b=cQ84dMkegfNwZO1A
 ISmP5JBgwUNkXh0ttbyAra6M+RF9f0Uc90yO/hDqUO0c2UxfiuH5ypUOa87owTbv
 rfydUmufXVZHNTrHbGRBfRekOFe8SOKaEK+ZaD/lS2NRiTJciBAljC0qY7MWmv+U
 oioopqJICC7HZH4iBagwsw15YSppKiBxC4lKKxGE/ZKYOIUvuMrr+V9jqiev5h+p
 fzLKiKurVDfia9bRG60GS6bzwcl+q7ec9Oc0L9ipn/ZgL9UNLrKydHkfLnZrSrNC
 0krTSmUEiBuQssOB0oEg4M0oWDCk1JYcCvcLV515n3Cg5Sy2n5VeW+5NdDY41mwf
 kgR6Pg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6vcsvhf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:28:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9349ba88188so97957285a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788193682; x=1788798482;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LkJ9lxCTtDvdCe5fxVE9tsx5zXvwZAtV4NrQpN1u2Ac=;
 b=En2h+I2/nTPW+pqPapL7HicCjOwsFVvinu1ASkaOe1Ygnyd5jOKdDfC7+2QfT4X86y
 TAk+ME0S1nIe3f1RenBwlDAfADLGSFasMB+PPugbjVCSTUqxzZvTz9IgGdFVUD+61a8Z
 /ICzx6VsDMAb6lg3rdOzXhpe7rx4BozApt5Sfbdq4KL9A+aTtg6n4whqwSfcTWdHP4B3
 yhpsZxlQtdyQLoCxk9Yn93hD+XXz6zSomjpdN6/ZQdc1zBvv2dw4nrVKx8tCsZegmQ8T
 UhCt1uImuhtEv+lDZj4d72aRzPUc5jWI25WpYeqmY1V9wcPgCQfWWpy9dGlc1yv0ZjY4
 vfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788193682; x=1788798482;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LkJ9lxCTtDvdCe5fxVE9tsx5zXvwZAtV4NrQpN1u2Ac=;
 b=TGVvMaoDitxfIDaF30mpEliDXAIf9UcbPpMzigk3cev4mhqckOJB7tLDXToBYA3vjs
 pwHYMJHXAotL4ywyZhW6ML9Wp7jG55iKBj+FYFfJZVg5H1JBixIU4wnaK+hzA3Im60rf
 g8fagA95OwVvejjnL6WiZYScBFgepazA78xhfzVfAeaTbhXTnQlvT8zDjxPswidgMzS6
 L520gFsrCsiS7+vZiDPE30ornQ6F+g8Y7TdZxYr+wx2ArPHUWCHlAoVCLNOTP1U3LQ5T
 94T+tVCaizEvLbVkqDdeqI0R1JppGc7H6NU0mT2pcUL2vm4QSE3vo/1BF0NEZxeHPtyQ
 FW6w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrxSc5jdrPbMf5wm3VrCaMEIJwwmDj3BbOq8VeOclK/F00+pvHDdkTG3T6t2LsQFDWf/BGY3oUSzPU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l+fwUcHet4ozhGGQm+pkX4xN68FV3F4KMSnPwt0A6SoJpHBc+r
 STvcI4ZpUqXURjbYpbldC/DTyDuDUPCg+oYzdZQ7YZf5IN52sT6v/KlIrVkomUstOgJhfdhrTlC
 lor9i3NSvR6YR/OfuTP4AixVxQjW7hB0SR0kO6nINlhUh7IJ1r8gyFLFOSChSTvatW1VKxkA=
X-Gm-Gg: AR+sD13Zz8Co6TbyC8B4ZziGgG/f0+G5CTDzDF+UGPswig+ZbAcMyL1XZC0pi8Idl+f
 UIKWwuBR1omIdhqI6CaQBhm6F8ibDiUYmhjrJHZZJ86XVIzBMxHpW+bQ80sG7VaK54Ixca+JrEn
 HSQ1w/5n+1miJ+Cj5eXaGqrxM2vLjxZEjkVU7g8VBD8vSTqaiTlP9aH/MA3f3F8Z4ZYfvY6u8uW
 /NlXFwpmMsgcY0EWfIzWZOnn3jCqApuZ1V+nGkcovWAib0hT8Ies0kHgSOETUiBR8u5xdTdblvV
 LVqyz3YN5RwPd88TtNggc6f2aI/ROuyQqwsWtPQ5kFtui3Z36lND4m8CkwGhTF/RWZZtaJ63oah
 urCCxS2e2Ap8IMREqU8HmLA==
X-Received: by 2002:a05:620a:224a:10b0:939:3fce:1a60 with SMTP id
 af79cd13be357-9393fce1addmr278260185a.0.1788193682019; 
 Mon, 31 Aug 2026 09:28:02 -0700 (PDT)
X-Received: by 2002:a05:620a:224a:10b0:939:3fce:1a60 with SMTP id
 af79cd13be357-9393fce1addmr278256585a.0.1788193681450; 
 Mon, 31 Aug 2026 09:28:01 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255f1b5a4esm464039466b.32.2026.08.31.09.27.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 09:28:00 -0700 (PDT)
Message-ID: <3e7c4364-db4c-4db8-b37a-c9ed78bbca3b@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 18:27:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/DO NOT MERGE 02/12] drm/msm: Properly handle
 msm_ioremap() without name
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-phy@lists.infradead.org
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
 <20260828-drm-msm-hdmi-eliza-v1-2-67843277de17@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260828-drm-msm-hdmi-eliza-v1-2-67843277de17@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE0MiBTYWx0ZWRfX0wtUgsIQ9EAx
 paB2QnmKyAfrtKMSNhcWw8i3IhjeFD49OpKGxtmECIh/T5EA6GLoMOs5IfKCX205PUkF514IPla
 DxtZDuWdKDq7nKlKW18A4kUIYZ0m51UpRaSl0FH9Y9SBDoZLlXf+1FzCv9QSmFOB7FY4t5sFDuA
 vQKqTAVU6URn82IdH5XyOFiv+6jNAkIbQiGvBKHrJJa9BIXAFsDMMsEn0JIvRh3f9IjqZIubI9U
 MUcPFOGBv6NfeGfjYkURFMD+mHhFlvdoKhBaTFJwevA5T2o2iR+t1GbfSG2CEP0Y+94scfHbjro
 6T9xWpLYfSjDdLV7wFuiI6F9PkPe8Ho8v2G0MecPE4Mm3wh/4C8l94qkr8TrFJbft1mLu2m5Wgt
 +Te65SQP6p48aO5F5QIJkV2jbhBPo4vNgYqI8uLBdvUzOZ8q79985ERexvJN9uC40zLWh63CZnP
 1BHUBF+2QijuRrhL53w==
X-Proofpoint-GUID: qpspFTeYnGtsR6t5X10Um8pK8ahphuLL
X-Proofpoint-ORIG-GUID: qpspFTeYnGtsR6t5X10Um8pK8ahphuLL
X-Authority-Analysis: v=2.4 cv=Eo7iaycA c=1 sm=1 tr=0 ts=6a95ab93 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=20nyjBPLO04NUT9Gj6kA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE0MiBTYWx0ZWRfXxl17NYtDkFwy
 bklRDzuEWt+vz/fjr0he/fIf6IBrrCEelHyR00vPc1AKaDSPcB3woBJb7ArsWiMI2o3M3HwZC+E
 149x5Iq1JvpNXsPMWz1W9pRKGuyX+60=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310142
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

On 8/28/26 4:05 PM, Krzysztof Kozlowski wrote:
> msm_ioremap() accepts being called without name of the region to map and
> in such case maps by index 0.  However error paths still use the name in
> error message.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_io_utils.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_io_utils.c b/drivers/gpu/drm/msm/msm_io_utils.c
> index a6efe1eac271..93b94e330cb8 100644
> --- a/drivers/gpu/drm/msm/msm_io_utils.c
> +++ b/drivers/gpu/drm/msm/msm_io_utils.c
> @@ -77,7 +77,8 @@ static void __iomem *_msm_ioremap(struct platform_device *pdev, const char *name
>  
>  	if (!res) {
>  		if (!quiet)
> -			DRM_DEV_ERROR(&pdev->dev, "failed to get memory resource: %s\n", name);
> +			DRM_DEV_ERROR(&pdev->dev, "failed to get memory resource: %s\n",
> +				      (name ? name : "#0"));

nit: name ?: "#0"

Konrad
