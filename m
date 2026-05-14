Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA20CCD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 12:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C72210F19A;
	Thu, 14 May 2026 12:36:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YdZfUXij";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kbhnLWHw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FA3510F19A
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 12:36:19 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBecNn2241828
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 12:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L3E4RMWJDlN4oTIAm3vwmxetHRc24rPFl0tCcoD9zto=; b=YdZfUXijc1B63K4O
 JdArn+cNh/r/AmZB/J0SRCcZ28FQsxxgqDgzALCmvHrC6TZ4czcJ5FSfjCVxIdLo
 m5wiUrTeTxnJ/Geh+XNmLOqRuJJHLJ+E7RGvS2ygDQ7P67Gp/VE6+L2Ue5sBctVH
 BcvvCPsVXEJYwbtK1F6ULFfEP4vh+3tMCFzVpzQz6u6wbT0/KOEcco6smNCe2tx+
 2WikL6CpTdyaCDtwnYRf16RPCqNwjI9OCSoJm6P77yHVgLxbj4DTGXUUg7br8UT2
 RUMKUMe3kAUtmfFg5059U3y59k9H17t2qLjKS7i9zCV7MU/ScqOv4z/mAbF4AjxN
 AXdELQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e513gameh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 12:36:19 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5752affb36bso719549e0c.1
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 05:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778762178; x=1779366978;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L3E4RMWJDlN4oTIAm3vwmxetHRc24rPFl0tCcoD9zto=;
 b=kbhnLWHwN302Hq447fyrIjSSP2x35FlWe4Y6lnR5h4NeT/cBaoMSbQhMtyuaMpGHxt
 +PC3NK4kOqHB80zdQNGizFdaBhyb30CHzY+aVWqo+Qc5ORTbWWMxzgGK/unPpG9kSl0V
 d4FnIF8NESMKy1arkJ/Rt3X9h+a3uDQj9R8FX9Xw8pPYcIT0DewrBeFvBNYbtVVfNtVZ
 w+dPIT023KYdi9ii7N6AXukWs1DQuN18QXeF8A22ns3Be8NOlA1vcJHk007ukj58Awy9
 kg+VS+DA6LvN9oTgaRVOwUbhNx5d08dIT78ccWYrm6b05DsjIV+TcuCFAyRaXa5x+kAD
 1BFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778762178; x=1779366978;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L3E4RMWJDlN4oTIAm3vwmxetHRc24rPFl0tCcoD9zto=;
 b=kRkeYJ5duleydZxXULRiozuP7LdAZWOIBERjZOqu4i44O3TRn1wX6b1e5YDAy3ARb0
 AxsKpmQeDaevW/owUxJxoyVKY0Iv16WR5x9IYCOIcVQb4lyx2RECpGLpscJqQSUWX7P8
 +UW148+eFsVzQCfQ+lB+e2Qd4edcdvIYTaewv6XJiZ0Eqbvx+75Jj995hxYZKShMRTxa
 c/RBSjIVH6VDDO12Blf3sjE/Fn9taWzxk5RUb5AXpxm6c/WF7zEYD09gtiOXgxVPUcD0
 sB84TF6ROSjda14XQbi5Ze2fw++th9+fxn6Evm87yzjp+/qqE49FsakXgLfJHjstwClI
 KqfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8m3xQNXts1oGVpgq1yhhj2SgNuRjvMEVoEXKhGOmM0FdMejxvkKB7ea9RdelsVAhDjgMoiiscyNj4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMGM/QcceTPN8z0BFdI6do1GHMBltMRIYZQzoE5DhwOYcATthz
 kMmc+CR6x+K5JTNHaa7cMQu6QIuqQ16bfwM22fTIMhNKEF2rR6ROhAFC/xwWFs5S+lXiuuDjH7M
 Vxhf7H16ykIqAGvTAyLF7sREa59RW4oIYjQNUo0C+dy3HxTa7gOYuVLLz6Msdgc5/2Pf8sFU=
X-Gm-Gg: Acq92OH1WZxupVJT/Yj9BDsQHHeRu+o3deGCxn3a7AjKW4um9/Xr2k0kKq6k4NIz6yK
 fGBGrknPXOZYgGPfKhAtfc+lAUGuiXjMVL2hOm3Xk6JbrFTxtbf98rD4AhKuhdXmWAOgHpi0eMn
 a27KAXZb8niGZSEozbLLcLtUDVDpNya3A0tRcSoaYWo7vTgf7q3P3QQmn4CQdIIAP64EOEa3Txv
 Y4NuraAojkdfZ12ZQW0NzxtZTracqiQzz2QIBYKuigGNOzuPRQcyTivceD6dw2EJMx6nKTH3fHH
 n2upFUR73l4qucZzxFtrV0Trd38l0BqIxxyZpdSVd1m9Z2NEaGf9PNmj8xD1weNvFDdFZX6GtX9
 tBsF9+059dVbG34Ihw4BKB/hMrgvm+dlWg6rbxgFBWsRmlYmiN6TpiNCzFLCJFSdUQwV0Y2vGuD
 GJiEDhBQjJLnoZJw==
X-Received: by 2002:ac5:c7d4:0:b0:575:2300:9f54 with SMTP id
 71dfb90a1353d-575e6f5a3b9mr1298025e0c.1.1778762177948; 
 Thu, 14 May 2026 05:36:17 -0700 (PDT)
X-Received: by 2002:ac5:c7d4:0:b0:575:2300:9f54 with SMTP id
 71dfb90a1353d-575e6f5a3b9mr1298009e0c.1.1778762177520; 
 Thu, 14 May 2026 05:36:17 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bd4f4bcf7f3sm85198466b.2.2026.05.14.05.36.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 05:36:16 -0700 (PDT)
Message-ID: <83958f30-59c5-4b15-a62a-92da02187c08@oss.qualcomm.com>
Date: Thu, 14 May 2026 14:36:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] arm64: dts: qcom: kaanapali: add the GPU SMMU node
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
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
 <20260512-kaana-gpu-dt-v1-3-13e1c07c2050@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260512-kaana-gpu-dt-v1-3-13e1c07c2050@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDEyNiBTYWx0ZWRfX4QklLE/hn9kG
 KRERA82UE7i6kZkI98g2T1R8hmOgtufhbwiTQEdCnzFgWpUNUkivNzwiIQqX/J2lVZv7XNgu8we
 IFjw0nOm6YFBc+SbiqYQ8F21W03W7R9w0pO984OBd4C0dJ6SWT5AXEkxU2MBAKTGiBBmLxcAwFW
 aHDNd7msxjSQSxJ7VV1qhJ9MyKcajLBPt1wiVsHIvOt/v+xAex+h/t0ozkrd/0RB5XVNw+U7J+U
 pRBjf9SEycSruqX1YVY9qr6sB5M+Kie6pM7+F6Czvgd794YPCH2fsJeVAiyVjzpOUPJ6Xg0wWKl
 A+Mwfk/F+wqCKwf5visCrxrudPUbw8UDNkyyG5xzVTNErKX2ozO26EKIbM0O8VKWA1QIk3qaLwM
 8S76eY3HDMIrMj7oB02/V04gaCaYA3yV1fT2faroOUo0YQ9H195X47Ek1iPZLdYtYDWg1uy+JZ7
 11TW/DyixMtuYS0I1xg==
X-Proofpoint-ORIG-GUID: _isvlxwudgoe128es06HCaQWcgj7h_VB
X-Authority-Analysis: v=2.4 cv=Iba3n2qa c=1 sm=1 tr=0 ts=6a05c1c3 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=54KNg95dvv-uSQ5X8vIA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: _isvlxwudgoe128es06HCaQWcgj7h_VB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140126
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

On 5/12/26 12:23 AM, Akhil P Oommen wrote:
> From: Qingqing Zhou <quic_qqzhou@quicinc.com>
> 
> Add the Adreno GPU SMMU node for kaanapali platform.
> 
> Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 41 +++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> index bab654bbd6d0..26a4de9c8d45 100644
> --- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
> @@ -2597,6 +2597,47 @@ gpucc: clock-controller@3d90000 {
>  			#power-domain-cells = <1>;
>  		};
>  
> +		adreno_smmu: iommu@3da0000 {
> +			compatible = "qcom,kaanapali-smmu-500", "qcom,adreno-smmu",
> +					"qcom,smmu-500", "arm,mmu-500";

The lines are misaligned, but please reshuffle this to be 1 a line

> +			reg = <0x0 0x3da0000 0x0 0x40000>;

Please keep the 8-hex-digit padding for addr


> +			#iommu-cells = <2>;
> +			#global-interrupts = <1>;
> +			dma-coherent;
> +
> +			power-domains = <&gpucc GPU_CC_CX_GDSC>;
> +
> +			clocks = <&gpucc GPU_CC_GPU_SMMU_VOTE_CLK>;
> +			clock-names = "hlos";
> +
> +			interrupts = <GIC_SPI 674 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 678 IRQ_TYPE_LEVEL_HIGH>,

likewise, please align the '<'s and align the property order in this node
with Glymur

Konrad
