Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84D9C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DE8810EBEC;
	Wed, 29 Jul 2026 12:15:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ntcstcyb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N4YFZw7M";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4397910EBDA
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 12:15:38 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TBh1Gg1724466
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 12:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZElkTGKf83zLq2SbG+PkttDl3n41jxZHeLynZGXTAho=; b=NtcstcyblUs8obhs
 ysvKMRRidoHCETaaiqeNG1BgfTAhsrZ7tn6uONKNJ2R5iOTNYTgKyATa4JiuzdvS
 25JBLvKw21O3BtL//eNybZzx4/q50Bw5zvanJ6/qxe8ojF04mTT/V8R4iQ0IfGY/
 sw7K7ob3WaSYIZEInzq5qhpIgYcJzl0GQAn21rXnGEO0GlQ1Bijcnqu9065Z9qxW
 EZr8Hy9HHJtDjamdro3PTTyG/ZorrLNnSv45UU1gj85PXfuzEmACEv67nsYMun76
 2k6+xJmzM38uktQDtjGCqlHRPgssO3LCQliLQClRB50coXs4bMD7zMfnqYWVT8Ln
 5MSOKQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqgw0g420-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 12:15:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5276a49e761so1334571cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 05:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785327336; x=1785932136;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZElkTGKf83zLq2SbG+PkttDl3n41jxZHeLynZGXTAho=;
 b=N4YFZw7MJaUP2NhnK+Ud97HCypq11lwHszE5liPV+eJh7np9M0fhPcK7wy8JwUsJPO
 YUUH58hnV0R+BSzNfE7oyJ/+mgsL6KVICY3egbkJR4NOI1BsmKWIptqH7LLvzI7o+b0J
 6zXmFfYBkg7Zfc3/R3eig68jUDwTJmw9VrNzeA3tdTSQTs35MsXIOrw3Jl2m8LfMKWq8
 WtoYzKA+G4UhK+dP6HY90pr9cbVPpJnjg/K9bpZLjU/6ICnoCSR6wp35trNeMZQOnegq
 0CG1tL095mvMpfpkHxWHC7z/zv7yzGQKI/DemBqn+SDzXdx5n9zzCCa1ccbDGHr3Y+ex
 9Juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785327336; x=1785932136;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZElkTGKf83zLq2SbG+PkttDl3n41jxZHeLynZGXTAho=;
 b=ap/tXgy180H1IRE95Vgr5X2tcNPu0+O4fr5OOwUzWKMNmNJGa4gac/RrlNnVxH90cw
 dvN4D0AtHXqx8werg42zfDy0eTHR8kD7zR3wrrsaLC5i9Yp+W6QQFI5uV0Dxvr6jBJ+n
 mR/ZN0PsmaSKA1nHnakqPtPAN2Tx1/aWyBOxuT5lyDFYoUxzcbj2Z4aeg6v2ygbIJxIw
 kH8GYmpSMxe1fO2uLsNyKm1lJ3cS7PJ/ZsvRWwd/JCOMPqyRUZHX6qXpCZHXsJkKR3Bw
 iSd6Tk8L+A7DhWm50lm97X9jQJ8jTJlDBgOSMTcj4ummE6CZKt5CXa8LWHgffF0iVVlh
 SIOw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr0jufu1IYxTGU2BGD2mfUibD6ivrGo63IECTC272mkdq0rmrhaqkZMluCulckPl5JLecMBx7+KmjY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQ7QbhwREEBKME4jE5hAHxGCMTj5X+bYj7WzhauZGfk5R24qYf
 hr2eAz2VHt7iKQd4hpUsQ7GfEbbEmtVMtXGaBB420ifUTrzKRGShfvnrkcOPbBShJnv7QzAFjX+
 Lsxm8qSYdJL/5O8a3J2mcofwUBCy5/xYyPoC5PxTYdvLWnf2m1aixWP0G4F2GfRWZC3iCWko=
X-Gm-Gg: AR+sD12IzxhjhjvyyYw5mTYWCOhjZqozDoM+MeYyh+SWlxTuLGVL0nWwYgYjnE11jbv
 2HsKFBqnZINRXIRuU9+o93he+t6nVcdWovSSHtAu+90ICgG96Qjam6UidOqX25tiD8K5Wt6DcZw
 24b2G04eTjAZ5N/18RaBcVVFOYm4tudbqJoYCKAk8uIiU5SLuwKX5liDjKxeHWEz9RN58VpKkr1
 VFO2GWerhDoZCE22uegE7n5CQlArp+vhgoEJTOs5SmwRoSJiEGyaRc6M9SMI6o0Q+pNhmtzVGtX
 RppXqhN0OnvZAVGcSM3F8vBTkAcDTJrX9MClZwLycb0Mk54Ny3RowAZTvMBUh0kRytsENqDM+rt
 YG+0yHr5D7nsxdGzaOMe9LwLk
X-Received: by 2002:a05:622a:82:b0:51a:8079:795e with SMTP id
 d75a77b69052e-529d70f64dbmr56395771cf.4.1785327332131; 
 Wed, 29 Jul 2026 05:15:32 -0700 (PDT)
X-Received: by 2002:a05:622a:82:b0:51a:8079:795e with SMTP id
 d75a77b69052e-529d70f64dbmr56389371cf.4.1785327328171; 
 Wed, 29 Jul 2026 05:15:28 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1f83f4e079sm104234966b.30.2026.07.29.05.15.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 05:15:27 -0700 (PDT)
Message-ID: <207866a8-bb1d-412f-9cef-3a597762a949@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 14:15:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] arm64: dts: qcom: eliza: Add GPU SMMU node
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
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
 <20260718-eliza-gpu-v2-6-64379dbebd7a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260718-eliza-gpu-v2-6-64379dbebd7a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JhBRPEqOnGvnAnhTlvUeQl2xOxZMBAsg
X-Proofpoint-ORIG-GUID: JhBRPEqOnGvnAnhTlvUeQl2xOxZMBAsg
X-Authority-Analysis: v=2.4 cv=AOkSgtoa c=1 sm=1 tr=0 ts=6a69eee9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=QDjCMyA0A8yHJihhU1wA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwMSBTYWx0ZWRfXxH4vQrRKaJvJ
 bc3w5oG9LjXQKq0sVRWDinRfuMqUGReIzm9Lz89yioJGsPJjjRzOM29+yFUt0T8ZI6cCrWpqzPk
 zliR1YqIFFkFVgOTAasQAacauGVbRbo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwMSBTYWx0ZWRfXzt7YyNqU7nsx
 NjnU8G6OrymMtJSlQCClqcFt8w/xDcWLJDChLuvH332srLNyLe+pAvXaX8ee6poxJeAptoqro4g
 Yx5zx7HINY8E0NzGbRI4BqLG6UqjYluxcn9/AIIIAXTT8DlpcRSq/k+KffyG/HLGBAzowoZoIoC
 t/5kxHD5MfKuDIvbIOTP9FsXUo95ZZxxx3rK01G2aGbEe+/QG1JJTCWVHM2jELp7R3qYuCIAJpT
 RS/YotE5Nprj9rW/LxvU6TPfDqchtx/8qskA5MyLzHP4u/AKbGzGV+XRmfCGzZcGH9tV7zcKyHB
 m3EpUU56D3ByFP9FdK6E32JFEzGN5KMinj+3K3dCrXvHgqyw3w60lmTMntDz4fcNKsZ5/j/Aicl
 nbM8Bvs7P7QjObSfBfi9YQodhfjzTRRHT7s1FSDYJAaa9JZ/5teiGSJkXeAcVzcUdFNGHKcXcXU
 iu48dA+RrWPDf0pOgmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290101
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

On 7/17/26 10:41 PM, Akhil P Oommen wrote:
> From: Abel Vesa <abel.vesa@oss.qualcomm.com>
> 
> Add the nodes to describe the GPU SMMU.
> 
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
