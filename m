Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F06C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFAD210E841;
	Mon,  6 Jul 2026 09:38:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SMME+Egv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dgwO6BEy";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F7D210E32B
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 09:38:03 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66693m6H4172027
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 09:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UmvEo3pA7Pq8NfvYG3chpyYLUANHLsFRyacd45P4BwM=; b=SMME+EgvC39EFdP2
 bvUtHETUasD8CkHlv0Jqwax6ufpmJ3R8p0IP4CWInLPYJ34pAOcmIvOsqLmVwotX
 pDkGVN2Dm4+0DvNhYD3iKDhIqCUfjY1FGr9V0XS6f15/qd/UpX+oU2RQxski7/gi
 yaX+W1CVH8XapWfVCbo4KQvNCmRy+eSpzktuQkCP9fBXs5D/WjsZMuVuQtxZ4ZGl
 6nwhnUVzC8LJuuXXgonFiJ4BhpYIdyhUX3IQHsgZR0HZDbEXp3MUnKo0b4Ozoe3x
 lQygoy2uVQAZaMSxFhkXWYUzKqbY6+pgOuVT7GeVXH3QSen4oDiKvkZlJrcL2/Yn
 CP911w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t889se-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 09:38:02 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e6cb57d25so88667585a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 02:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783330682; x=1783935482;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UmvEo3pA7Pq8NfvYG3chpyYLUANHLsFRyacd45P4BwM=;
 b=dgwO6BEy0ZQ9t8NYjK1G4h/L49m5HstX2NinAiIeAe7W1VXBdQBJhIUd5ts9+ZeXve
 /Z1rXhj/uWJblB7WMNKa/7+AnJrW3WCF6iU9FHpqoryPSHtjHA2m2dWuc+Rgd1PAiynn
 IFX9YQTnO2qd8u+T90VcmhbhxYIfzhC0G6bPRUMiv5yTTwuNr7X7bfYuUMX8uc7lapzl
 7LBwjZuapfRJ4tWg5gWWB0V5xDbyzhfTMa/hpCe0+ZGj0hhQ2hXEYAtwnRYrNSQVkXaM
 x5MWCnfwrFh92U2sG7zK9dQFwwcTWRYub5fLWbAT27gUYPB23aKszh6g1w35knpxJDtN
 m13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783330682; x=1783935482;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UmvEo3pA7Pq8NfvYG3chpyYLUANHLsFRyacd45P4BwM=;
 b=B3gKiLBWGHMoy5qdkknWXFBxAbYDAOwB13meVnUZjoYuNGyNkTTn1lJEY/y/52XGJm
 oSHkoZn9VI1eEe0w64za94AzNJmFqTCu5MejJ+C3xQ3q8bex7GfRBcnC4FMGeozrIrOc
 xH2L0TRAT8G9GtjCxkCckgsjhopcS9lfpeigd1NBQzhfiUdaCS+HgOHBg/bT+0hZXrMu
 mug+BvHFN+iHrJxDKTrdCV2yNLmUOK9TXF0t5m7Uz2BSfDqxPNKE7OCzW+pic3sEPbAB
 WaVcOhPMb+DFEopKU7mofMsieOaFfQTPZjtoLwAKSa3whhjWfJBMB6UUno8saZADqEG2
 D12g==
X-Forwarded-Encrypted: i=1;
 AHgh+RppXBc9Wk7f8TrF8DlPxXEQ803tsUzHPYliJM8rt8ofYrHfWaicDvd0yS1D5hI1dekaZi9zn2/9l6o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwvG1sFw4SEhmMTcavahTgo50VeDqgz3aO3qpVSAosJRLcUgCPW
 eL1rOjlICgEqfh33yXVfSOKVN0HxmLET3+LgcKTc0w44+JX9kHMbpLkczXdu7sBFCQxb/g6Jpwz
 br9hhuSM5etwZd6+3ieq+UnjrR6mFebDl4BTaDbpaWcqU/m2rWx1qyQzo9HD0RtfXcxoGPB4=
X-Gm-Gg: AfdE7cmQBrfoB0/y6e4TVK0Er3m5NhCdG7LcKqRC3A/O2Lq04QZkP/Eu+GXkR2y/JuA
 QQ88FNfaUbXM+KY2RqnWsWLIsonkUw8t+1IPoz3JyUL2Kbwb/F3yi08WWhuJx4078wBDtMSh4kI
 eERc+Oe6oxfcIL3ELSsepHM4sD91Qq2OD6BkNMR0L57TP6ycpLnCGnJXb6JrqdHT/KEx2+wdQzE
 vdvKqy86u/U0O0O32+KUdPrMQXNKuiPOao9dBYm1h4X3GpbKCmZg27dcFuUZ4+TKWlnjwVEQyj9
 kU/BWd87ClKtntVrxSM7NrVpRcAZ56wepQO51uljE0R53stOQxsySvaKkTrsq4a+z/uX/g6LO1C
 gK2fxdpYolvNPVphW8ev/SsE6WaO4MQaTm18=
X-Received: by 2002:a05:622a:13cd:b0:51c:f3e:781e with SMTP id
 d75a77b69052e-51c4be97d68mr86773231cf.6.1783330680882; 
 Mon, 06 Jul 2026 02:38:00 -0700 (PDT)
X-Received: by 2002:a05:622a:13cd:b0:51c:f3e:781e with SMTP id
 d75a77b69052e-51c4be97d68mr86772871cf.6.1783330680497; 
 Mon, 06 Jul 2026 02:38:00 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12b60575c4sm709337566b.9.2026.07.06.02.37.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 02:37:59 -0700 (PDT)
Message-ID: <e2b7e03f-911b-41cd-8ac4-044492e2bdbc@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 11:37:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] arm64: dts: qcom: Add GPU support for Kaanapali
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
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
 <20260705-kaana-gpu-dt-v2-5-6ac53de56314@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260705-kaana-gpu-dt-v2-5-6ac53de56314@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NiBTYWx0ZWRfX6NcRwMJSlLfP
 apDeRKqq00itsEJu5kG9z7Api08LIMpW0DREOXFIGTmtrfByNxJOOYTwPvb+aGVz5GtLnytu6tn
 LmbGVNoA1qX/7Rt3Vc/SopnlpPWqwTA=
X-Proofpoint-GUID: cEfteY3_drhH5xYX_PTQez3JaBxjUB7s
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4b777a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=z65YV3W3F_EkYOo9s_QA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: cEfteY3_drhH5xYX_PTQez3JaBxjUB7s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NiBTYWx0ZWRfXwKvUwjOTqy3d
 9umYv0iJbljhislNNMtLgCqyfvt0k0gPEMZdoysJ6ZkfaJLd6oqK7G7Z5zFE0D+fwhGv4eikx3l
 8t3ivhYFeS2lVEQlq4M86D4LZg/TP0n6l+tlzNooK/dGY+ZnKfsXDXBhRUOXK2AtICSjjfpH73M
 UAaqeTPg4c741u6E3Y10AkvMu2RPjPUXTZ3wkTLuozrNoAXPKnr5HoCh79A2Wm1EPEbROq9S/0n
 dU9yrLAK9QXoW4BFz8LPeEgEpFDt9CXlqRi2Nc8WO7ff4lVyEkII4uR2cNTF2MsrBfkxZtbuOQ+
 X1pyIl76VL4qZUODJwgGcMVuJUSo8LctSZ3vTOEZDKbOFvC3jcJDsV/oNGPk86uP5aV1j7/um+m
 OxRJWPI44QxA5y97JbIGkgWCuHOfu/e8Rg6Fc+5RpihZPkpL2eim7TrTIFOSQciQCcpPiHMiJ7P
 Z+hN3uMAJiFdB14ZWJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
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
> Adreno 840 present in Kaanapali SoC is the second generation GPU in
> A8x family. It is based on the new slice architecture with 3 slices,
> higher GMEM/caches etc.
> 
> There is some re-arrangement in the reglist to properly cover maximum
> register region. Other than this, the DT description is mostly similar
> to the existing chipsets except the OPP tables.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

> +			qcom,gmu = <&gmu>;
> +			#cooling-cells = <2>;
> +
> +			nvmem-cells = <&gpu_speed_bin>;
> +			nvmem-cell-names = "speed_bin";

This looks good to me, but I thought that on a8x, we're supposed to use
the freq limiting register in CX_MISC - is either of them preferred?
Or are they just hardwired to the same thing by chance

Konrad
