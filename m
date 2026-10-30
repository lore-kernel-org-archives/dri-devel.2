Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43EA606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fSWT9XH7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dvchWMpj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AC3D10E854;
	Fri, 30 Oct 2026 08:32:25 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF55C10E854
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:32:13 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U8F0mD2682274
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y2nNmMULCkjiBMguFlrU+V/6B0EjOBHt0prOTM93F9M=; b=fSWT9XH7JUOojZrZ
 xNPFNDbX8/e8FIJ50SSI2/g6RslCmTRSQ/GxaPSbzPMUPunCvmahWT2t9536u8oK
 PwJnp2qSHBuwigf7/0fq4tEOxiE9bVvAFAPP/aq9d2yrXd0A2SWylArNQdm1Q/5p
 jIMWi4xTuV3vICZA9ZgrRSklsXGJd2L/YFIXH5w7Ab5cXbcUlZACYmVz10G1NtDZ
 e4rnqncrfY1IOp6Hl5Jef/B2HtZKjxTatIlDEDkvhxIjzmLiuwOP5uJ9N+BZpuRM
 1z+GbuQp7HZmCC5LhHtNeRTBemDug82fT/iKjkxMnZIVBXbRzL3B0xhdYFRy0Zes
 U0aB2A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qj0r2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:32:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f1440e081so10599185a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 01:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793349132; x=1793953932;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Y2nNmMULCkjiBMguFlrU+V/6B0EjOBHt0prOTM93F9M=;
 b=dvchWMpjI08LylXFtomfNzHNfDM6mmyvdO21yvN/oDR92Nnew9+QCxTMJtHFHTlXRy
 GFAm8G5XWH8ab4qg6qfUn76CjJ00szTxglyhFv1MA+KT0JfYPrA1YPHEwrDFo/9IfILK
 3hzLW786lMx9GzWFmodW6NggGUxnxD4HAdnFewKT6NBCm4QDSiNfHSVPtKP4xiIFgEGr
 3W9mernwmr3Fl9+W9bM3uOF8wH93TqWbJLZN32ExdSosVl/iRrvcboembHFbu0u5KNOG
 UflzVSe/4bdon2wEtAcL5349vMRsxJoEMU1CzSPJoY5gwGWY+ZoKZwaSFOcM/td/fBPI
 wlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793349132; x=1793953932;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y2nNmMULCkjiBMguFlrU+V/6B0EjOBHt0prOTM93F9M=;
 b=I8tJEpL/NVdMHx01gFwibEPBTkMZ6IGluTFUc+zTBw4vFQrqpm7KMZRWZ2Yur334Ge
 RV7PcEA/nPFtj67baJRMFGksV5IJHxAJLNAalbjRDCvlC7b3ovIv9F4hn3yrMa33zP1A
 ndfz1L9gGiK0NkmdSlsXn5z4eOVxFRedHwDgPMITHtjgggp1J6Mtzc+b3c5xtz5ryQCW
 vHUK94mXnK/kbGnK64/E4ABfXXx5xgFc+SUbMsOleRvs0sSfRiqA8AGOoJpWLcs884n8
 +8xMGTHw3svTzoBIiILYLoGkqzMHUhu2JMEkbb5uBi8lwSBPmWwo+3C4+rnlZ3mmwF7w
 +0FA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJg2WLKUip6b0id+O7KfOTfMGLm+L5N/2bsJ+/EOBqEz20MisQVogUq6MggctIQF4zi6IG1qBW7Xg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLPhNUPFLAntMzioXVVIZGH0TEZgsDZHfFFr4gISyHyMzg82sFK
 c6UPlAiQSl3vjYjTYWlL4g+5rRfwcw7vDsPUQ/4sO128vUQrmTKxdn/gvEeF28NRtrHqc/md479
 9zXUh19x7xBQZae6rYOJ4wdkK1CZmwwHQZh/CZpAT93UTpa1qjVkCjpJy1mtbFdA9+0jQcKA=
X-Gm-Gg: AYBFou3dFqF2xRp8bgC27ytxNvoyX9qVBx1rWGF/0m+o6tkGK+oDf7royYuce0EiWN2
 om/T8ZfQak8/NUwrNBhPMNaCllyEAhugG+r+K28qqejU7XVCm/bio4cOhEHdIRGHk6QY9aNMFKX
 1/tz8fm3rPtl0cxFrqZfN+FYFO1G3x2mePRZiu9lf7iXP0ozxhafiNL8FnVNDHSfepLfoDrohBX
 uyBSGl4TBTMHn5mhLthrq1kYoJ8gr035T9/D7svpd/Jxm4qVtJmeS3UWckVsLdtD46vElzdziqi
 I4i+zYfVvgj99x179Wl9KpLPyz/LjYYtTM//HQO9yr13MUfpnT3HtAi45q7gcDPcl+XRFP+LCaB
 /oEVSx5e46bPc9uOMSpvbaE0t7BxVVOgVUyf7+8nkhe4F4fa3JUSSYaeVundK7aRj0UQASgc=
X-Received: by 2002:a05:620a:870a:20b0:944:127d:f192 with SMTP id
 af79cd13be357-9442179be1fmr260516485a.5.1793349132156; 
 Fri, 30 Oct 2026 01:32:12 -0700 (PDT)
X-Received: by 2002:a05:620a:870a:20b0:944:127d:f192 with SMTP id
 af79cd13be357-9442179be1fmr260512885a.5.1793349131606; 
 Fri, 30 Oct 2026 01:32:11 -0700 (PDT)
Received: from [192.168.226.64] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabcfd22bsm39044966b.28.2026.10.30.01.32.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 01:32:10 -0700 (PDT)
Message-ID: <a2854c0f-d900-4f40-a28d-fb55aad17aee@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 09:32:07 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/16] drm/msm/a8xx: Add missing a850 ifpc reglist
 entries
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
 <20261029201730.151754-6-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261029201730.151754-6-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: E4dhHkTfD3qMvnUTym1OKWjMagCm0-De
X-Authority-Analysis: v=2.4 cv=KLzPn1Fo c=1 sm=1 tr=0 ts=6ae4560d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=QS795xsoLWCajuJlIHEA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzMyBTYWx0ZWRfXztFqDqo0aNte
 pY6JBeVrzn9e+LkR6UmL2/MdMaKzB06b9oNgnLCAYjrhwk0pUUTl/CV4lQR6zsf+xizA4yLK0+5
 Bgyv9XsGA/9CaGIfVVEzwCP0POI3EytJAoqWk6l+0fyC3A0GyDKKjb3TxbKvlRq+qRKLp+4K5Ff
 zQPX65fptD3MWD9HAwM/CNqiSOmpy91q2LtG2SKZLYhqZwvi4yu2pMwOb+5CEup/EJQG72Iri5n
 ZMxUPWppbsj6YmzvsQglyMWBdFfv8u9J6qfH8vU7st1wSnCAKMIf7QxczoBN7JHc/xHOvWkDawH
 9ACvVl11saTmEkhiXVsqZSyv2iIXyvaOSqTeS1ZeD0VO704XN/3z9IfRRNzW1wrfxQ2HzcoWzQf
 nyKJUBfsicfq6Iq04paOQUG+j3GGcqJJUS82lHPmUDPLz9nPjkzPSLfkPFOCnUPkxskj/7Fxkz9
 NtZB6L33FTjW9bOalDg==
X-Proofpoint-ORIG-GUID: E4dhHkTfD3qMvnUTym1OKWjMagCm0-De
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzMyBTYWx0ZWRfXyWkeoWhLEbBm
 Ui9UmDsgaEJav2J3ZlNlFvXzIeeEwsRnOw2z9C4KGSk/hLgdvyetrqz28QWB/0dLHKKM0Ku+nP/
 nPHj7BEkoE/ryDvVJ9+88GLXm+Jpn7U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300033
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 9:16 PM, Rob Clark wrote:
> We want to save/restore all of the CP_PROTECT regs across IFPC.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
