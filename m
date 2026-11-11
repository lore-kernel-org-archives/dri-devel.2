Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75339606F39E
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NuONsJl1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U6LXmJ3f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC15F10FC9A;
	Wed, 11 Nov 2026 18:14:39 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A26810FC9A
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:14:29 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABHtYH31014228
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=EVDD0ZIf0hmd9TQw5ueEix5r
 vkoEax8Jzcz8T9iUU8o=; b=NuONsJl14mEotLSRpoxfRhUuboX5vi8srBBzXDdz
 n26rpdrbVtVMOGXsT4z7KXPpMSu4bvOmar6YXOj/HAnpI9UumXpWDjlX9gy/CIGs
 qw0lgkC0KCTfsI4n1PsoxSEuPXjaZT01c4ecsmjM8kXPyEBR4t41ECPZ8rmlFNgN
 W4IRTefM3QCwYD3jzXhCanx14hrAePIZLqO1vBsz5kdsBex9bXEAtC7osJojjaLJ
 QUsX0PmNR9ashmm++NT7CSGGyFmOWGi4vssF/Nr7y5RgSOd+uRULSaWwQivpC8kn
 I573ti4CU+RX5egjnmUJEqvA6Wds/iJO2qfVzM2DdjIZeA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvpjjt1ha-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:14:27 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb98809caso577889085a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 10:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794420863; x=1795025663;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EVDD0ZIf0hmd9TQw5ueEix5rvkoEax8Jzcz8T9iUU8o=;
 b=U6LXmJ3f/FxIAhkGXkKdxuyZNqwWzZW++ZHUlSPp1o+Utkg9g3rzWzV+2tKg5wK26o
 aZ3kN+0cDJj9JoAD85fF+s2LUTBfYKcBsd8srt+7JIbBpVVHECGbgegar7DJop9guXaX
 Lc/Sk0cr3rzTSE+QVPh6x4qTk5ZJEFHdcfZo27BuE3yYu7jbSF/tIJc005s8e6S0uP8q
 4ih+VWtkkC4T09i5r5ekbDozCyizR0dCjU+olyqEwAViuiLPnnSRYvwikOc7Iu4JFnE4
 VXOKRww99fhH6k1cHvW9Zvr7zMXiMzhjPEkjS5IHGS0LQLjGu1s7DqebRa+Ps1N+jf2/
 HZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794420863; x=1795025663;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EVDD0ZIf0hmd9TQw5ueEix5rvkoEax8Jzcz8T9iUU8o=;
 b=oG6k6/i9wP11SL4gnrAO6+FmFTsawt/9M1gNwTuVB66GGMBFsSeLWL+HRb8uX9WiaH
 GjhnKWUMWawMWaJ225IMb3UmCbDWqi1zzMjsCPyS0oH3mEDm0wtewWE5dE/4QsxuSfD7
 +Q17JOD3ooZAM1ajNbXMioCjlebolewzkpCt1kPMKCBvMARW+wyFOrPRAo+15Dqs0qH8
 2TSTgdo6MpWXLfJ3oGRLLuSLAW/enQSD8lhVzpZp5m15ilxnUV8iqWoMJWgAQoB3ZP53
 cSiKI0Z1ImZvTPETc0XNlHLRVKmxHIYpRVLoruNDg3P5ruArwaTIVacna6AS2c/QXnYq
 a1ZA==
X-Forwarded-Encrypted: i=1;
 AL+hErG2WvLyoOCELYB4CRHbf7c3OYIRQbkj25aXWih4uDQCZ9znBO5hjkrAS7trmKAneKngAtkKO5GOjqU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9JGQVkZprJwuTbc2MM/FG7H2QZ76g/0c+VHG+RmVm+viqoB5Kl
 ojAQfEP4E3tDAvGM72vIYFZ1o2z6Nvv5AZgsWSOZCpSJve+rIDs8DktGWL6ptlKG4UDCFkIRPtc
 QfD3WKWjd0bpM3wiH5ZbxY80DZ+Xqeg2c9pm4dwH50qrvV1oTWzSuekQua5deeCgqFBv2JAA=
X-Gm-Gg: AYBFou2vLdFAu1Fyq4AMP7yJGH28kMGgraNoMxFNV5Ycbgm+LjXlrbOIgl6bv40mTz5
 IwQJSIgjncPuMLNzg70cb4WoQuLy9YbvKiq2fwJANtf8Q1jovo6Ri8bjtrc+9KINga2Mo0adaCz
 cclfX1epYhmsGidHHCsC9mru8rymop7pic1BAzweN0OX2yc4E9zpEXeq9vGmrr0wFOc3z9wpAK+
 cXk2qVEGA8bg94iMwvkhnMNxVwcHT+SwcFYFd4qW4vZYKfIxqYl3B2HgOHRi0q8LJypONNG9IE6
 i+84dl/tsKn15QCriZdwyctq7VxBYJ5zzBWTbG2/dCQHmcVKVheRADY7pmAOgmwSCfnw1AURWmc
 awKpObDfT83hcYYPGXzbUuFqhKrY+Wy2U66nHLM3fjqk4j5S02mLhYw+Z/nvF3i/YVoAwrM4ufn
 dkowhtAJHGDcXKeroNZl4WU6lH43s8xmxLu88Q6Z4gmwTiGdsfdxh02W+nt5ZjYQ==
X-Received: by 2002:a05:620a:6cc1:b0:93f:334e:df21 with SMTP id
 af79cd13be357-947b007b8c2mr552406685a.62.1794420863206; 
 Wed, 11 Nov 2026 10:14:23 -0800 (PST)
X-Received: by 2002:a05:620a:6cc1:b0:93f:334e:df21 with SMTP id
 af79cd13be357-947b007b8c2mr552371285a.62.1794420860004; 
 Wed, 11 Nov 2026 10:14:20 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae115a2e05sm6552871fa.19.2026.11.11.10.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 10:14:19 -0800 (PST)
Date: Wed, 11 Nov 2026 20:14:16 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Del Regno <angelogioacchino.delregno@somainline.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Mahadevan <quic_mahap@quicinc.com>,
 Richard Acayan <mailingradian@gmail.com>,
 Danila Tikhonov <danila@mainlining.org>, Robert Foss <rfoss@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: msm8996-oneplus: Disable
 disconnected DSI
Message-ID: <dkplnfllwn2zlx36yh43lynz6qwcnzp4af7l5d6yph32shcy7g@cup3aqkgevw4>
References: <20261111-display-msm-of-graph-v2-0-fdf8fd97f49d@oss.qualcomm.com>
 <20261111-display-msm-of-graph-v2-2-fdf8fd97f49d@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-display-msm-of-graph-v2-2-fdf8fd97f49d@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MiBTYWx0ZWRfX1yV9M9FccaIk
 IhIMkQcP/EhpUHaqMqooW6GQ/NyY/9fi9fQqFdlcBLwlAT0MZkzyL2iD2DcejafPhhDHqv46ln4
 Du+WP+qAGVb8CAk1w5/v0QYxvzjfJTDjdpJkaBjeyQ5EGCokljM/RiBUHYYzLlWP2Qmp8LSRjSs
 /5TB//IIgDhaN/QRX6XPgE8QPT0qph1taCu4IzyHbRkZO4ulb7mImIU1KPpmIu7qUApZnyNgB9S
 LTwyt4a08wBBiXmZtR7I2Kb5WvkJPBWb6TdHB0nbm5Nb/f2k7GDDhyefIpBZwNnUpbPXiGJLxb/
 kCo2O7RXSP6hIYYtn647zp6ehtEwjYRo6DJ4P6/gQF3Jfh9yXSSeSFPFAjzf3cDIWWUjFG0YJCX
 bQ4/Dx0SKTUygGWEitamEYEErDm441rcxjBZtkZf32V3NH62jY+k0iE/3dfLs8qNrqmIT5cSPgL
 1s0J+8mKklVWPm6EoBA==
X-Proofpoint-ORIG-GUID: L2xbL9ubz7KatrtMNpyWTS6XdZa736Bm
X-Authority-Analysis: v=2.4 cv=FeuiV5+6 c=1 sm=1 tr=0 ts=6af4b083 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=FelehbBqFq-cYOsUXMkA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: L2xbL9ubz7KatrtMNpyWTS6XdZa736Bm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MiBTYWx0ZWRfX5xDfeiBMp8DL
 lPaRj5yJ0WjlcTEDIkUYIgzxhZf5BLpaqgwqIO5PHy79HZECNBSp0Ot/WPLgg0pLrhEDQV83Doc
 CwYg1VfoUhEcHsRhYWe3EHkd44S+LTI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110072
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 06:45:01PM +0100, Krzysztof Kozlowski wrote:
> MDSS DSI and DSI PHY are useless, when nothing is attached (no panel
> description in DTS), thus should be disabled in DTS.  Linux MSM DRM
> drivers will also fail the probe.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
