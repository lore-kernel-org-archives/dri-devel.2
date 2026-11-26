Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9FA606A32C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lWclrFBy;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QbZkl3ig
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1DEE1124BB;
	Thu, 26 Nov 2026 15:01:57 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68FE91124BB
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 15:01:46 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQEV5xV3664859
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 15:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BCBvJWUUzh4EABV/c2ZfxvfD28hjPtQ33YkZR/isC78=; b=lWclrFBylEkYJmnz
 uQqsbH3qxDtNpVUljF7B2i5IowP3/Oz5hHlLqH2U8Iyjwo1ACDZJplStp2qvZkyY
 zBA9II2Mz9JjOZQGYlv+5Z6DuuuBpaanwklVZ6x7e/++ESCfR1/Laypp6cMYICX3
 ajwQ4hQXebB8lLxGlADQnuWmKjmzAsREYHp7ecQW79cKIGkSlndiYEFMaDmRicVL
 TcqeI8UcjjWNIoTakZqg3iJTrQlVoIjWRbaXZ1A0PAZhogBCX9AOnz902WUl8VWR
 Lk46w7/BeCv5eKvATozGYNgNfetjve280PVTyMjT7zXWV1v2iZX+NFXNEPOAy4cn
 VJvQ2g==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6h7g9dhd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 15:01:45 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5ec78f43e7fso318815e0c.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 07:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795705305; x=1796310105;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BCBvJWUUzh4EABV/c2ZfxvfD28hjPtQ33YkZR/isC78=;
 b=QbZkl3igEr6+1CYOtx4XwhtT0jk6/JGy37oXcyuIqvS858SlR5oJTpwB74+RLrIIIH
 EjaTxg0GOfeFqR4Iyl7ijE+/C2wr8xufOV9YzhOMbI4hyepwO9aniqFPC5kHPjDMFGuT
 Nzu38Ly4se6zSXyAGHwZtwzPgKQ64SJTZM/wom0yhVJsDXsY9hrfBSVGmH5RCXGXehfs
 nSiEH0eg6T3R9lc8Xk3nKz3alIZwAyXT6IWaW5eesVWcPzQ9Nuo7xH9F2RsChjpdivkR
 yLP2A8hJxN/nYdZmguI8UGmJ7TDORLXdxaUkIA4BB6W/+RM3iZe89x66Uz25FArapvgb
 DfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795705305; x=1796310105;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BCBvJWUUzh4EABV/c2ZfxvfD28hjPtQ33YkZR/isC78=;
 b=T3oCxYOhhjn2JH59tTExmzmzmON9WutMYNyflI98zObE/CVILuCw+qVAPy+4ripvmX
 faYp60qKSlfb5t7IK1uWFCMDgKk6N1+pzfKOVJ6eykgANy4Ll06ugsXgeY1wVJ1yIY13
 P0NJvi38GMwfDY91LXJFH4Zx1PaeVX4MXxSB5CPjeT4aNxRRD06othPQm37CzhcB6blb
 od5SN0qrXR9BLCCI45R96JQIGzOwDBHqZa6Ll37RKnr2Sd5R0wwOEOssIC/6EDzEaoez
 sxK1TOorCKtLmkOBeuY0Xr9Fq2XDCQSX61B0y3eQAYkTMiyuJsqaiMvVBCpcSSZhq7Ra
 ohcA==
X-Forwarded-Encrypted: i=1;
 AL+hErFZFgitYcfLX7Azn7DEAwNh3jE8w5xEw9oyjRGuJKRqEZS9e3IH5Bv4SWx1SpUj86yBI6MDPB/RPY4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/I6pwYSoFf1IPvhGoHXyptnM4D8kh32jtvCFn1Ec/qUU6CA3fl
 Bs8WSfiWjaC5amdSxqs9yiMmHHxjmWWn+3MB1K0BEfaPnVQIbT+oHvg8OiA6a42R4K7VoddvbpO
 pM655GIIVOpZo19dEy3DWmJ/HkdKOtk5YeOHCmnEOURXUulfO7V/1XnBmSr9aSGQ09nEvGkc=
X-Gm-Gg: AZFdTZfy3vjCU7S0L95tk/ASnBoFLkobK60Jf6MyLexIJbCWZV2yZ7elG0M0d3RRYX2
 nKIh9A5kCR3fxQ1V96NhcAQnnEy3+nezsR1AgM7VCqg4SBJ5KbyQyGCfkPAD14ihOm/L6+NUoRC
 t9MenDqHr1aRinTT5Jy+JQWSeZsngz0QdqJRxzQYUf1kHVuPZmYseULxCGUhrIRT71siBCwRovM
 bPH2nIxO9tg1Q1GrpLWxGdp85qmGbIQu6AAmN65dVGF6ltJTC9hLwG49FFRobRskQNgkCAczZ3B
 aSOBcrFIM04GjlhS3SZ7EYlQgFffS5PMaBIVZ6M0ORyz/gKAPQUtASR3ad/gPf3G4v7fFVDaV2N
 VF00n0NXSS4uvc3bKjKEWuZ4SG9EM+DaxJtyZ5Q20ICZkz+ZqeU8sS/ce21sCxBv+skkeul0=
X-Received: by 2002:a05:6122:264d:b0:5e6:589b:eeec with SMTP id
 71dfb90a1353d-5ee8af4a6c4mr13275376e0c.5.1795705304728; 
 Thu, 26 Nov 2026 07:01:44 -0800 (PST)
X-Received: by 2002:a05:6122:264d:b0:5e6:589b:eeec with SMTP id
 71dfb90a1353d-5ee8af4a6c4mr13275286e0c.5.1795705304183; 
 Thu, 26 Nov 2026 07:01:44 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513acff65bsm790932366b.4.2026.11.26.07.01.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 07:01:43 -0800 (PST)
Message-ID: <00422583-53fb-47a7-bcfc-f517b84283c2@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 16:01:39 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/11] drm/msm/dpu: Fix DSI tear interrupts broken by
 adding INTF_9 and INTF_10
To: Nabige Aala <nabige.aala@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
References: <20261116-nord-drv-dt-v3-0-e3d3bf0e2c49@oss.qualcomm.com>
 <20261116-nord-drv-dt-v3-6-e3d3bf0e2c49@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261116-nord-drv-dt-v3-6-e3d3bf0e2c49@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ATt9r-L1JFEehToTxv3P63c5fwLXeTfB
X-Proofpoint-GUID: ATt9r-L1JFEehToTxv3P63c5fwLXeTfB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1OCBTYWx0ZWRfXyFFd3Tc6Y7qy
 YzbgWzyuayukh2ortQ13YcqUWouvo6U7SgHXfmMw2egEZgs17JFxyBLvuXG/GHCIJDY3y7Vlnnf
 Icvu8nDxFdB1G2bu+GwAD8Yby1F3O8NBsRChslq6erf+CgDPcxi+RJBesCB3TSyJEOy4q+wMSYR
 p3bLCfJNByx2gw6O/KjzaruRrDIHrf5U1BKs+BXY5c1cJsRfHHyGh7I9nBa6eQyfKwU9fSD35bm
 VvhNE3prRo9v7RMDpxHwXBG7bmF+d6ONhYZS9yESvFVlENPhbDJzuxaxBXCzb7mSU10athwKs24
 YsNAQuuRmUi4faca0MJOqJBJ1ipRRScNdOWzQQcF1NitG6Bw5bvAd9GvAN95RO+pNIOoleUNiO1
 +PBGandwC3spAxbsJACLJkj74/rtmAnmueEK8NKg8U5g2I8lo94v0sNRCiX92Yux8JlgreHn/74
 vgyVNpIYvg+Nd9DsfSA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1OCBTYWx0ZWRfX3VMX3fS68WDz
 aE63z/Vf23/vL87Bl5ABmxs0kQD8znSoFWiO7IIgleoR1wHKr+/jBa09R2HwFFVebxvUgxN4uNs
 qRmcYr+w9RR1TyPIYTeI3wgmRsreOsc=
X-Authority-Analysis: v=2.4 cv=L4GI0OT8 c=1 sm=1 tr=0 ts=6b0849d9 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=-NiRQLekuLvWmI5UBGoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260058
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 2:16 PM, Nabige Aala wrote:
> Nord requires INTF_9 and INTF_10. However, enum dpu_hw_intr_reg relies
> on all MDP_INTFn_INTR entries being sequential — MDP_INTFn_INTR() macro
> computes the interrupt index as MDP_INTF0_INTR + (intf - INTF_0).
> Appending INTF_9 and INTF_10 after the tear entries would break this
> assumption, causing DSI tear interrupts on existing platforms to map to
> wrong interrupt registers.
> 
> Fix this by inserting MDP_INTF9_INTR and MDP_INTF10_INTR before
> MDP_INTF1_TEAR_INTR and MDP_INTF2_TEAR_INTR, keeping the sequential
> block intact. Add the corresponding register entries to
> dpu_intr_set_7xxx and dpu_intr_set_13xx.
> 
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---

The subject should be more along the lines of "add missing INTF9/10
interrupts". Then, the commit message should explain the reasoning
and effect.

Konrad
