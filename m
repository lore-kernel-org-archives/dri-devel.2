Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5270AC43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B41E310E782;
	Mon, 29 Jun 2026 08:53:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="T1XGg8hW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V5fia2MD";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 565C410E782
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:53:13 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T6rGAM2115242
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MxKbFO3jZdx0YMVM28FnI1izFIXZoinjwwywDy6J9aA=; b=T1XGg8hWV+HFSMfv
 ZayRu3sTjrhGUa6K+hGv3D8cpX854IbY+g+3K1kEJjx9PhYbM/nKcJXTSEWQTBdF
 KtpLoCpzE4TT4oRoQZuB8FOlEtbzTe7bQzLxawr7FK92zZzcvXx0+6QqixNhgvD3
 n3Evhjco5KhEgQYeM9crVLtLFWnTAZEVG8xlnNF/cICa8358tFuA/q/IEPKHFkWw
 zqtwANNOGtfe3yHk4XjGK2y+jtw2WhR/z6d4qAC1EHj/7Hexil8tvf8KGtxl211i
 WsY8rbmK3yhARXp7f3J9iXpHRKdGsabAUrkNjtcZ7ECLuXKdbOiM0puNFGkwKHsJ
 N+0PGA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f2734dn5d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:53:12 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a8ee253caso1339441cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 01:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782723191; x=1783327991;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MxKbFO3jZdx0YMVM28FnI1izFIXZoinjwwywDy6J9aA=;
 b=V5fia2MDCNnyXlmU8AOkjVbPZdrkxXVfJ1HhjrQrwkROI4ZVaFxAmRkXgMO+KG8jrM
 xCpfd9FLC6x0hDGQwfJAAGtUKykRI4xC5pCEh3I9u2eHGmAr4NBDb/AAWRrLpUHN//Pe
 SNvY+meFVB6bV33FV7edXUnf6W+H6WCdrajQaN0L/07q9XdxBx+hQ11D1kTefDMbeJzm
 qO+URthAeHqg4dSGDiDg1uSlsPWUhOZ50YUf6IqlJvXSt/Zu1cYbpqgY+fx1FZ1AOBpe
 NPMKja63t4RhAkGnWts+2ypdUvLsPXJmgyQFxukvfBhrJRX1l7G9PQXtVtesuZXiXRWg
 UxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782723191; x=1783327991;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MxKbFO3jZdx0YMVM28FnI1izFIXZoinjwwywDy6J9aA=;
 b=bg7Y9t0/sgNurB1nbjZhDmF0pSqj22Jb93W937YfCARMHSepINGndwcTGoG5ac49zi
 pIF6lGLVdpXaM/NM9xafQ1jjqWwJ6MAp8bpJzpq4guZ3y3lVD5Nbl/R/Z4imY8pz33S0
 6Yg7oivW0s5JRAIxogXOvnmHfvQq3q3epYtAmbP3Vy1JJz3E0FoswqNcuIr3+QaPZ/Vr
 5aawasfW36V1RbLvk5UO6Uh3iHcqkT/2Mz4vhCA705jYXmT2NBq5l8fgqQNNv7BiWHHz
 5OBkqE7XjfxQpCreVNEHT5aDaALif+AslNzE4Nni7InWRRYW2eRJqSFDpr8EGUFnQVYz
 W77g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+TTThxFliIbkie4lmxDmFWc9wc0/DmO6XexJ1BwBrOyOXO4JEam3UL7A1lyjXf0Us3Cfp9IxfBrk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDK1Ii5UT12l7NO9OzgNHooQ+KCqMCwm8eJOnqJbE3mOgBFELG
 TJO9+yNMwYDVJ1W17uvpnfr/LMOBQeIWVeV06lyVSTiIZ0yiGMM+7jUD05ermwGSTjN2Prb4lLs
 78HLa/4SR2awLI81A3hBmvqOH9rEyuBAr0C4PF1K/mga0SZlAr5aQ937VNyJKKMvD2wUTTsc=
X-Gm-Gg: AfdE7clrSWCqkjp2r8hSKvnEoQBMmtgqscwpvUB3m3OKTKRxWmb2j6ppSLgQ00wKuAU
 /bEQdC99FjPaI68LhtEIbGeWsdmu5YDz4pk34BAZyXpc2aO4+55tD0Mj6MAkW4LRWGUbsUoV8eg
 jS2qk2PVU1e2RaY3YfiKR+PPTQlJR4iKu9Wkpyi4w8QW0PcPT6AFqmc6vFRhSR4JYz+MtY5EceL
 b/yRzwxEplAfktE1SgG9xkTXtqhITSKg7VI9vuvGDXUvlyJthGDcm+1OR7xSB3pna64BgnppfBj
 WmHyUrquPFdqqXa9oY3uWtWheYd5r2SY90sjT67ZTuEVWMiyXGYX4eGQ5pPS4UkI2s7qdxZPl7v
 OTyU8/wDc+AI6vbx5mc3CTjppPgCIYMw4Ec8=
X-Received: by 2002:ac8:5dd1:0:b0:51b:e991:92bd with SMTP id
 d75a77b69052e-51be9919641mr61100191cf.7.1782723191382; 
 Mon, 29 Jun 2026 01:53:11 -0700 (PDT)
X-Received: by 2002:ac8:5dd1:0:b0:51b:e991:92bd with SMTP id
 d75a77b69052e-51be9919641mr61099921cf.7.1782723190905; 
 Mon, 29 Jun 2026 01:53:10 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c11fbe05cbfsm739181166b.36.2026.06.29.01.53.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 01:53:09 -0700 (PDT)
Message-ID: <a509092a-1c65-493b-9df7-c8a89564bd7a@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 10:53:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] arm64: dts: qcom: shikra: Add A704 GPU support
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
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
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Aditya Sherawat <asherawa@qti.qualcomm.com>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
 <20260628-shikra-gpu-v3-5-9b28a3b167e1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260628-shikra-gpu-v3-5-9b28a3b167e1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: uN4u8fGNt6QhLcRcrNbJlqcScT1E7jZv
X-Proofpoint-ORIG-GUID: uN4u8fGNt6QhLcRcrNbJlqcScT1E7jZv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfXxE5qkzoQHJCz
 8iZBck2HDIBrqE7Rb71k6DkAGTGB0yo42U85LW2Ka0YTcM6uhsSFeE9xVU4RL4BA2hobLwxAytS
 zl/9ZyN6zoOFWzrHkNk0b3VgTJB9uDU=
X-Authority-Analysis: v=2.4 cv=HYokiCE8 c=1 sm=1 tr=0 ts=6a423278 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=QDjCMyA0A8yHJihhU1wA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3MSBTYWx0ZWRfX65d8uGkWn4+d
 CT8ntBjNBkjQxppSbdByJRhEg4OePW4lCvLgfA/pmPzXBS+KKZz88IRCmektH9kGoGP8d2cDL+4
 FuXm/NgSDN0CLB38zb0FmntoC0yLx6xXWK9qpNYT7iFVSOgKEC4w06Aev9Qgmi72apXK+tRufI4
 /rKcHZXr9CYZfctRWbjYV+Uvz9MlxmAOLcJoctfAhKdq2eU9KzAJnJmg+0Z6UGSi1npwIxlb1Qm
 7Aso03lpVqAueVkdx3OpOPgFtS49wFt9NbTIFcE6arQXtHB2dzjL8x0qnhtHt9Nx98Zsiy/5W3P
 pIzQ05YGikJy2vxxyloIoz53YZqnExo5iqRisFIyH6LsMQexlCJpUdJzbc9ZQHu6M26FIS27S/0
 7JxeGFaUop/LpEO7PZoQ9QIFLKXcwkVQdpzUCFPmo09WOe7JwXyYzatXq2Pn/VaQgw34pNcr20T
 y1XvjymhL3MzM8AHrvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290071
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

On 6/28/26 8:23 PM, Akhil P Oommen wrote:
> From: Aditya Sherawat <asherawa@qti.qualcomm.com>
> 
> Add the A704 GPU and GMU wrapper nodes with register maps, clocks,
> interconnects, IOMMU, OPP table and the zap-shader region.
> 
> Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
