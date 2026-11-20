Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DB5606A330
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BjP37kBy;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gisCzT5e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FF3A1127E0;
	Fri, 20 Nov 2026 09:50:47 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F295D1127E0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 09:50:36 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK7f14p3575871
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 09:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=zB5SsH8VsIf4nEkhNxqYqoKo
 wJRLv4fFPfgAoBW0n/k=; b=BjP37kByTAgTjiRHlga37NpG013SpZl6UoEWvm+p
 0c4jvbTuj6WUhgfQLXs2osAictIUffdVBS8R4s+FN9m5WswyTXcU1tSfiTksZVqs
 wFRqvOrp9aJ5GWKkWIc9N1sGv2sMOdNPy73cigCk/KXROlEAJiOF1iyfKUUd+O6X
 52uXpYWNSI9v9kX8fTRYZUhUt2a5FdHFhFmsKSMk8pN4hcWFlL0QObmVqFNpzK0b
 7WFLOslTFiUuDFU/8jbSaPF8rCFSpnADDvorZyhMKzdm6VBuca7VV+uJb1TaAT8+
 V9C3OwIiYwyE5eC0N84taumnN1VAawPIclzBrqocdtUUqQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2gu80tud-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 09:50:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f5844cb60so137415285a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 01:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795168235; x=1795773035;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zB5SsH8VsIf4nEkhNxqYqoKowJRLv4fFPfgAoBW0n/k=;
 b=gisCzT5ejDo9j1qRNGDJyoSpbD8B/M8uN/qyZeshbLeKwAQuUHFGfMfOjx2J7i+wxj
 DntLro6OEjA+boCkwTZgBnMZCIiX06o/YduFv7hofZq/LnAKBcDJhD29rTlSN1/6IoEw
 vIo7t9eYe+NXyJyafsZImj0L08P0kA2c2nOputZ2mxh4RMbQXyeFJT5E5RnwT7xHz/do
 Ih6NsFYZcu3Xazz2Xv2QKMIU7zmGDNzdrWI3ocg14XAqxbWqWMvNskBcTS1ixsvPdATJ
 PKjU4/HKAYWBhTqGLIzbIpd0Bpm/VgSe7nmWUrvP5l0GG0tqSLJHzZL6lQSyTz4FuYGS
 2LHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795168235; x=1795773035;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zB5SsH8VsIf4nEkhNxqYqoKowJRLv4fFPfgAoBW0n/k=;
 b=iX2dxcfnb9zru9WyoHXlt0dI7HkCAqkazcVuY9SPejcPBJ/Fyz7ewtB1g0QG3aNO0Z
 MZFM+zHV5a5YN+3HLkTj64E+FmS7Bn9X9Sh6Cjy3oqes2fBZvRxujwDuYhFhVCDS2kTE
 9PjQlL+2TTP6oV+ZYAHBVAaD+XBepztspyudUGy5IEr3op4sxV1ozdhBsNehAnTyQ00D
 H2K/cqGKCucv0pwMLF4V2a3q3nrFStie34dA9ehAUBcVh3abpdQGQVC96fz47PeOJKXm
 /7kCo4TRJUILGXUK5N5tCf+F2TbIzuvj+dRnNSydo6Co1uDy17uBbb7yRJwcpUpQKOvF
 uxcg==
X-Forwarded-Encrypted: i=1;
 AL+hErHOp7rAoFZC4TTA2J4foN2VyLD2KuW7Fs6vGuiYZvZH/beitLBcPXVwl8qsovEQ8wIx7L0gV8AfPck=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+4NAHTfzcA9ZSCwG11lWzCbbdPZmWXuDHIPwBx8QhioDSzy0Vv
 XniEC5osGHJrrN/Yc4p/0PX4U1v5wbtIeDMXvRNxmUTbex9Y86F3n9t1+hVL2wM6i4FDkTacJxS
 HzgXEEKgKO4QSfRtdO/Zrsk8SNrnkAUGeMLWGkHCISbtluplRIxt11+il85xPd8O0uYxupIo=
X-Gm-Gg: AYBFou1v34Sje97If80SDgU46xL7vL84BZ96N0T4NyXHz46JmPAOHpLZ10hTsgETCFu
 3gXjtsqwER5/YPsWVv1HpVW2CRiQkeuBrKtIA/w4lRysKKprKdeWFKF5+FGhdHSL4InCi2WUzDr
 ZT5tAPWSXogTSbOP/u2w642fbTjnFJ8HQ89GSJrrVV869XtvCBpPiHa/c8XXXtNOcxJk6Q9i0vC
 bEu8zt7xxzkGI/dMorkYzL9DimaVQYM3f0u87UdQdq6hFpKe2Rreu2KQ6mRDADq+inG7oyQYwjX
 ThDUe6QYN7mQYZ09yspsn5bV52Mk4QnU8iEh04veP3K+/w4bP9x1FCBAZcyh/pnQYxmivpXQuDF
 7Qb8uMMr8oJNI9V5/MLd7No+T0cVZ3Gp82QLaoeESWZZJM5aCJkDNjHnnxTIE/0mQ
X-Received: by 2002:a05:620a:6401:b0:949:589e:4bd5 with SMTP id
 af79cd13be357-949b35ce47fmr569788485a.23.1795168235192; 
 Fri, 20 Nov 2026 01:50:35 -0800 (PST)
X-Received: by 2002:a05:620a:6401:b0:949:589e:4bd5 with SMTP id
 af79cd13be357-949b35ce47fmr569787385a.23.1795168234664; 
 Fri, 20 Nov 2026 01:50:34 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b2050f1sm4302232f8f.38.2026.11.20.01.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 01:50:34 -0800 (PST)
Date: Fri, 20 Nov 2026 11:50:32 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
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
 Shivam Rawat <shivrawa@qti.qualcomm.com>
Subject: Re: [PATCH v2 3/5] arm64: dts: qcom: nord: Add GPU and GMU nodes
Message-ID: <l5jxkp2xknjjk72mpf22blpxnou6ufkaswhehddtpgyowly5qv@6ngdwriwkeny>
References: <20261118-nord-gpu1-v2-0-8d6d9908b7c5@oss.qualcomm.com>
 <20261118-nord-gpu1-v2-3-8d6d9908b7c5@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118-nord-gpu1-v2-3-8d6d9908b7c5@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzOCBTYWx0ZWRfX+Esp2KBOLnyf
 3fn+1GiMnIuedT5jYMPCTALQ4/++vlhOHQ//p++op8WB4ES4SqMOXIHQdmQo5ErziuxxaSlGu6U
 91NKRipQAJ4qYAuwcLMpaXz3pRVEBnUSoiaT3XqaGv/tp1BVEVLLE/BCAuOi7lJmh3FUSneHGJ8
 GKIaZrmXdMyLIE802dERcj4xubBJapScPCHFfmIQ2u0gt8vGuX3ljvF1LC2m17DGA6WbeHf6oXs
 OVudqrTQn78ycLc1xINPAaLcqoPSXDGpuv3JTqeGFOjwgodLmre6MOjE3DYL3gCS8K20knWqilv
 tpWxZyvQqllfMsNx0KwuSuw/ZUw/LBjuNm60fviR9jmjnPrWhGkVEQ1LYWxTYQrr4Clk6AC1ZFN
 XjQsIqlrB99WVodFcR+4FpmwlbKVlVsmxTHF4Buh/TsywtekcH1lRIaaiMsTxXwk/rpZzhI64ph
 kqazdj63Cslwv9Us6pQ==
X-Authority-Analysis: v=2.4 cv=bLeDs/+Z c=1 sm=1 tr=0 ts=6b0017ec cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=O8GIW4uRg8gWTlYuajoA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: J326lTB_u-AVwTbEyRL72N-m7t0PiMFv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzOCBTYWx0ZWRfX293tWthrUfd5
 TxMXju516+D3pKjbP2FG83o4YZysrTPD2n6UvGukbd93aWowmBv5PCujFzPFVuYcj9xoI8nsAVL
 ZAouqwkP94A8fRBKw3duD4h1MX3oBn0=
X-Proofpoint-GUID: J326lTB_u-AVwTbEyRL72N-m7t0PiMFv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200038
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26-11-18 04:30:06, Akhil P Oommen wrote:
> From: Shivam Rawat <shivrawa@qti.qualcomm.com>
> 
> Nord SoC integrates an Adreno 753 GPU as its primary GPU, belonging to
> the A7xx Gen3 family, along with its Graphics Management Unit (GMU).
> 
> Add the GPU and GMU nodes together with their OPP tables. The GPU sits
> behind adreno_smmu_0 and uses the gen71300 zap shader, while the GMU is
> clocked and powered from GPUCC.
> 
> Following the existing Nord split, the SoC-invariant properties (reg,
> interrupts, iommus, zap-shader) live in nord.dtsi with both nodes
> disabled, while nord-embedded.dtsi adds the clocks, power domains,
> interconnects and OPP tables that are only managed by the OS on the
> Embedded (non-GearVM) variant.
> 
> Signed-off-by: Shivam Rawat <shivrawa@qti.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
