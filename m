Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B91606A321
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DLLvVPar;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ac3fbZYq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 461A510E1B9;
	Mon, 26 Oct 2026 11:59:19 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5DA910E1B9
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:59:07 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAsvK83561850
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IsV99hi88PjkYSWI90A+gZYiPZ8DnKRkCVaWs6NIztY=; b=DLLvVParQf6/HTmo
 xMkJAaRYx/CNErg3qP5d373mfmkRMlG66TUm7dlT8HzFBnWBcTukab/whPunc1lA
 K0rVIjvllc85JiD1ZVo+TuCsCBUTtwtEdBM9GggqIJq0ujL2InfRQzN7LFO0qEa9
 8Ezy6s6QNxkgyn+hrW/ZH/jry7Qb/4fqMICpV8/EbF7XtpDMbbeEayFc6N3a6/PW
 e2A2nqFoTBOHdTW2cLXfE80Q8+SKh5pRhBkViLKswYyMKihZUhtwyqRirCnfIl7s
 voy8liL+X5m7hHXxY9k6lYNGdMGklZqe+9F+xpUL9B40C3+Ttwc1Vk3bebjBfuQe
 t5E1iw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4s90e3k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:59:06 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cac495d99so31814985a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 04:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793015946; x=1793620746;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IsV99hi88PjkYSWI90A+gZYiPZ8DnKRkCVaWs6NIztY=;
 b=Ac3fbZYq36+OsoLkcaaZAY/5gOIXKjj/DxyuEBjtRM9tRVJq7PKEnIi1Flzlyq7LgE
 6WOriJiWfxers5kYnSynABxIVhODR/tX338jnWlyHHGHlGM/PW9WzSNRykclorZrhqtF
 I8jTgE3B+6iPIPZxWWQL1tKwUhZCH7L6WVi1wgNyt4JpxqiyJyz7UeZ/DwuQwgz5cdlA
 Kv+cKAyVFmdxO87oZvGmm+SX+5EiN63ML1GRT2KO7X+qh0YSB7pdW9a23DY/uz1AYoFj
 0p1SLRYZb+8LO5eISmbtgbT0sMsAT4OKY6XqyIrwnFJ7SM4z50Lgl9VEYrVeSAuKfgz2
 eNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793015946; x=1793620746;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IsV99hi88PjkYSWI90A+gZYiPZ8DnKRkCVaWs6NIztY=;
 b=ewei3ZOJqmi3llzrvAodzAZIEqPV4cGt6O6GlVL20rIXvKwcoaovlihVaHHdOjREZj
 1jpv5M4tal9E9TkuCuzloR0gErWCYAjIaSDUzjhD62smJy4tb8Vy0XHprJryZJaHPUyl
 saXOe4pmtWtY9/0nNciE1IaN+wOXCd/WZvH1d/CBaRO5s9Jdv0nREjqgXLY5SDKB8eTE
 vFoSqerzIV3QrVx0sXqnhmX6+fRoqnZGKI6Q6F2EVruu9Rgkr2jzQOgKoyn2q1Ev23/D
 lNel6vd+djBMuChvP+NnwUhvzbmSzSzWQ70qqif/dhJGW7gxLBZdZZx14lpaZRD1RVfK
 JsxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6glYwmvF51WobBNaDIxEpUN1CtEGUS+yb5IQc7NHCfWUnB81kSeDUrak3cLb4B44s7Q7g1yFW6yU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIJSAggXdFGFytOIAmKZ7/W+f0VdpRT58WVclw4Vrb1Cjr/zlVr
 SY8xVMCUfub7GOQPMJpcvj/vm+LvAPl5g2tR6Vi0XNprp61N9NW3aN/WrdB/hU0BIDRo+XpeF8b
 BMtrJgl4DT+StuhMhl46VvBtH+OI2vcm/RFiA3DHqqOgLwJX5G2APqAIs6G8Ttzp5pnsX62w=
X-Gm-Gg: AYBFou0S7I4zvgJu5zM3J/y0wK1kQ0WVZ4Dme6Hq7+2tpoc9fqltW/WcHUS8NvW460N
 ZkjLeeTYPDjAkTb5ZoZ+BHM//KavizkcgUhzLeisLuYF9Mog7ercY2txybWQi8E8JXBmi/jJURW
 Wtyx9dDPdsDNSETVLj1PEQCUmZ3igQwho38yLJgZSpg5M9RFox+mrQT7gEC+O6Omm94vrD+3BTM
 62FIrxfZaR0OxDcoSEijLnlREmYquMYz5HspCa5PoB7xaz8c+fddQ2BOPOeG2cPWQbDMDfRJYxN
 TxrcmYTLC7hMISZWEVEvYf0BiYtYHWb5BAxDAwJnZ/bc+iFf6gEGfhLcMN/tuRvF6E7LDfTvE2r
 005UkGVbUGYUhJ9oIUiiXIg==
X-Received: by 2002:a05:620a:a29b:10b0:93f:1a1a:2974 with SMTP id
 af79cd13be357-940ef951f4dmr1003734885a.6.1793015946242; 
 Mon, 26 Oct 2026 04:59:06 -0700 (PDT)
X-Received: by 2002:a05:620a:a29b:10b0:93f:1a1a:2974 with SMTP id
 af79cd13be357-940ef951f4dmr1003732885a.6.1793015945868; 
 Mon, 26 Oct 2026 04:59:05 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd529b47sm310666466b.40.2026.10.26.04.59.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 04:59:04 -0700 (PDT)
Message-ID: <f0bd8179-f211-4d2e-bb0f-a419744de2ea@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 12:59:03 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: sc8280xp: Remove FastRPC compute
 CB9 entry
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
 arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-4-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261023090308.2898683-4-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NyBTYWx0ZWRfX/poqFLy6+mIc
 kFVLJlTFVHSwRLDxDkK0+vFfqaV6nV+dD8y3tmvobEt+fmZGf8LfbK3xRZb541UbZZ4afi+0Kry
 F5M1kWEubg/jVI4cc8XRHOOlpE95Udbn5HQQHSZHHdhqP6X1jkQ93b2o1Kpaa1RGYCgRnxwN1QU
 4f4xcP8fvtWjCT7D5yNtzfWj2WXpuWQqvrJ60jKcVeIjlPXZ02RZBvpiJ0VQPLqTNHnCdtqoWE+
 rMwGG7ESVeJykJLB5O4Q5dA/sRKDinLKqHUyx5EQemG7CAtgNNFK1ilEFj8/E8KjShNeMY50pC5
 JSk8huzVHEDNPUzeDNl2zm7lH/C6ZtVzRbiz9OsiU7PSIRnYGWe8bby+DBoZ1cZbCOb2u9fkPZg
 adXsFJoPVikvujWbirPIhqgCXbDt7dqTcUYMKGDu9cCDeQYSVm23D9gB6rvVXWGP2cYM8xj9fJM
 NJAEMD25mfWSooXP7AQ==
X-Proofpoint-ORIG-GUID: MHOetfL8yJ6HLG2rVuWTM3q4vhXNYmHi
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NyBTYWx0ZWRfX/hvs4UgY8emW
 nJEzhpwpKt5y4fnx7eFt+si2UVith3tv/or/S/PdzL1HPkHpcsFRbs422uaeNmyagyM6ezrkxTG
 rerhC+TA7RI/RKdTTmm8kV6hkN/aZN8=
X-Proofpoint-GUID: MHOetfL8yJ6HLG2rVuWTM3q4vhXNYmHi
X-Authority-Analysis: v=2.4 cv=HKhWhYtv c=1 sm=1 tr=0 ts=6adf408a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=khcIRSTurGpjo1Y0ADwA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260047
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

On 10/23/26 11:03 AM, Abhinav Parihar wrote:
> Remove the compute-cb@9 nodes from sc8280xp device tree to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.
> 
> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
