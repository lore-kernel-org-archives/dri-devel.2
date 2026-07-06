Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E6CC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADC7710E838;
	Mon,  6 Jul 2026 09:33:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oV4pdxOF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XTyQGuAE";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E418F10E32B
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 09:33:20 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66693xKE103102
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 09:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CqI3glLxpjkIaZ4hS8KAt+z85sv8/xneAfqqjsT0BtM=; b=oV4pdxOFkkgiwhy3
 KqQkRC/eNXZnrAUtWwLiMjuiM9z75nTKAlsexWfvJ06t8B6RMx1uhJ3n+CvmsGvq
 ijj3ukeTsKiOA9rME3WLIRqParkCUvFsqEPrM7NAllVPF69cpNKHrm7/RWwAT6kM
 vMg+2abWKTLmYA+EcGRmtq16AxOY8VT0/lyNrcjvYE8Iu/KXBPmqxB0UsElSBR3Z
 /QKljMdrTPLdXnr2gHXPBVEsuD31Zvk0qxhQQ62aXHKcLHuRx5e3q4ykx1HopZd1
 leEUczyCwW6zfkO30AlDmc8rEN5RBb+JoFUOWU3w7EBRRWhjz0nS5NRLA6eAMcwo
 cVsUTg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h50bdc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 09:33:19 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ef4a54f86fso7563746d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 02:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783330399; x=1783935199;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CqI3glLxpjkIaZ4hS8KAt+z85sv8/xneAfqqjsT0BtM=;
 b=XTyQGuAE/pvHH1Bwj+xR/dpl6TVH/TqR9W1xJ0weVOdDvYFUcme2EwuGgT6NHkxrAg
 NSksl8c3RB4RpmBuJFHpHK6iSECCYeRgWVyfL6jtjSblnJeDdU6Kc3MRj+X31D8ti+Qw
 IxRetdvzMGnWCFEPh+SbLc0LFlkOG2F1hk1Y8VmJztNIE5obPmypfpGWCpF1ssjimZop
 aVqpwYaId18TMKVDcml+3bZAHcA/Od6umU/o4UGJsc6EQq6hK6xBNaTpCVY3N9qWEJEy
 TTiNuXN5nkLfBuKn1m7j9oLxUwYVl4+yiR+2AuTFzSEoiirvKE2d5+qUYJBrXV1j79gv
 EEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783330399; x=1783935199;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CqI3glLxpjkIaZ4hS8KAt+z85sv8/xneAfqqjsT0BtM=;
 b=gK+Jelo8Jy+WGtI2GdYpbkjofAEklUK2ZjTKUn/NnwDG2r2zRjnUsFUvByfJTQSJoa
 fHvT6+bAhSbmLhs2p0jNiHJe2wiaclt7xpaiE2hk8lMdQZLj7ByEkxF6sS+wi3kaMQ2A
 i52efEYlkBb9NENQpcyrQxbiz/MHhxrGNVRxZhkEr72ySwfG6KO9YCA0iva9L9EnpIre
 BsrUYAvxNGnRwOkmfU/Z/INhS0bQmlhHPx6eLmEGrwAdKVyk2gTWyLf/vkJ65emBlXQu
 R66isF3UEL+Ww3f/ScCj1SEDFS2BF9y7+bPQTtpGdu6L20s29qG0wKZgCAJuWCAh5Y9j
 7A/g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+y5LtQcMbdU3q0qVlkugQQ/pFIxMSlug7W5SPz2EqNBMKS6UvI9rbapdQzERjtYY13VSDi1rxOxU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzpLbxSxZHmD/5lDyRUxTWstlaD9OEc/0A0ZsGPSM22/hQWClUJ
 CcI7sCS/q+/6wBUkYiUaOBdXbmClryfhmDD9CJBJKMWPVSS09Nyd60N5o243e0hfgtwU2+Ou2R0
 tI2oMZ9CntHfIPDOuDCGLfr0nptv3nN4qAAXGiGFN2xfykSJSTkMMI1vEKuOMHT0LWlSJYIg=
X-Gm-Gg: AfdE7ckmcTcDvIFgGGDPNpIYt4Q3ub+1tIJXrtqaVmCTF7yDCioTbMd1U60ygOoBdX0
 8rm5G5ODT1+kYDRXqX6U7+u1dz3TM9V7K1QqbxFM+kFEi75YVpud+lIsEw852WoJqoNM4uf5j6/
 pU4PhKHvquKy6LXSf+XT2lBapF8H0UlqfJ+H28zildkn/BKKfxVnmVmFZ/UpxVi2Mg7XEQ8l9IT
 rJYd01Istnf+JzQbyyyXI7ciqI12AMAf+Hkx+xcMDrF1oNXcIdsAVDfUu6OW1diyKZoRVtSLWpo
 wY0Z9fzv4tb4xRB57QbmlgXh7uFNIU3+JDocBAyr1YZTJfRMPGZR1PZylr07pWZOKEiHzCEJRom
 sNP88tSk38dZB6zDPDSDWffYBm2bVTAST+R8=
X-Received: by 2002:a05:6214:2503:b0:8e9:f5de:d5fd with SMTP id
 6a1803df08f44-8f74caaf417mr106701626d6.10.1783330399108; 
 Mon, 06 Jul 2026 02:33:19 -0700 (PDT)
X-Received: by 2002:a05:6214:2503:b0:8e9:f5de:d5fd with SMTP id
 6a1803df08f44-8f74caaf417mr106701416d6.10.1783330398707; 
 Mon, 06 Jul 2026 02:33:18 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19d9e701sm3807545a12.21.2026.07.06.02.33.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 02:33:17 -0700 (PDT)
Message-ID: <14c366e5-f030-401e-b51b-62d833f9dde9@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 11:33:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] arm64: dts: qcom: kaanapali: add the GPU SMMU node
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Qingqing Zhou <quic_qqzhou@quicinc.com>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
 <20260705-kaana-gpu-dt-v2-3-6ac53de56314@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260705-kaana-gpu-dt-v2-3-6ac53de56314@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: r0b240wXg5D-d-31f_pYOv7voPGLKemj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NiBTYWx0ZWRfX0hWX4EengCXz
 zZ9UHogzEPK2+rZxvxnJlJzlxE0H20Ew3MgKl5zmJLFiMSbtRg4eL/GNOvhTlPxUKF0pihUr/82
 AaftYYZmBynlrM1g83iu4edVUbsizEQ=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4b765f cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=54KNg95dvv-uSQ5X8vIA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NiBTYWx0ZWRfX0iypJ6Hq4KKJ
 XeYArQXKppQogccg+4r7ABti+vtXMKMWywKNfYn6BnMSAe+81xzNNI5j16VcojWn0UzL3RbbmvI
 MW7j5OmH7+MZiN1XDwFNcUyiRNMLwj6IbVaH2SMVfrIK0FFWxk4LwlQUQxdqh8Gc0OfALthYBJu
 QEqHqgX+mbQA4S16dBrq5qtvqy8G52dFZ7RMdvUWAtiewEfTffsECDk+tQ8EnKui0BzfXqb/Klu
 GKR1dO/0l83JN/p5lwJ08Dr9715pRJCIOKPIKhmyqGShmiqRvqQ7PYfooqyTY7Pxu8olHnF/psw
 wDQ/AsuER8D0fiugGvrp2+ftEJqPZR+ofuvbevPtk8y3B0O+pBI+G9WS30sOvgqk3gxfXazopfM
 EvhN08fRXxfvfBYTI9C4RR6E+nL84A3XDKBQ1k0Z+aKNGqFxQKcyqfmX2SDy7gGJdu4ud+yy6QV
 r2ZRv57+wwGhPDl3oHQ==
X-Proofpoint-ORIG-GUID: r0b240wXg5D-d-31f_pYOv7voPGLKemj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060096
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

On 7/5/26 10:00 AM, Akhil P Oommen wrote:
> From: Qingqing Zhou <quic_qqzhou@quicinc.com>
> 
> Add the Adreno GPU SMMU node for kaanapali platform.
> 
> Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 43 +++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> index 7aa9653bd456..19eceecc2a19 100644
> --- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> @@ -2601,6 +2601,49 @@ gpucc: clock-controller@3d90000 {
>  			#power-domain-cells = <1>;
>  		};
>  
> +		adreno_smmu: iommu@3da0000 {
> +			compatible = "qcom,kaanapali-smmu-500",
> +				     "qcom,adreno-smmu",
> +				     "qcom,smmu-500",
> +				     "arm,mmu-500";
> +			reg = <0x0 0x03da0000 0x0 0x40000>;
> +			#iommu-cells = <2>;
> +			#global-interrupts = <1>;
> +			dma-coherent;
> +
> +			power-domains = <&gpucc GPU_CC_CX_GDSC>;
> +
> +			clocks = <&gpucc GPU_CC_GPU_SMMU_VOTE_CLK>;
> +			clock-names = "hlos";

Let's match the property order of glymur.dtsi

for the contents

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
