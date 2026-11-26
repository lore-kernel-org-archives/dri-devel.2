Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363EB606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fm2kgiL2;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M4esX5u8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F2F6112461;
	Thu, 26 Nov 2026 14:28:14 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 055E1112461
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:28:04 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQEOWTV2634933
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7Hz+V0KZEUKwYNABkLWPKOt8inKUR57WAc+UGW03IoM=; b=fm2kgiL2cWg5RwJ8
 HFdDWNUoA/yk0YZOV+8RUXoFikuYrhEynGi325nG2OdMCTsaD6075+EiYmzqgWzS
 NUMdf1qaw8OCS7RiLSRlXCYOim/qKu7wHtkPI028cqfcV5j45FiJLtIDoI5kM2lc
 3aZ3HgH8aiYp8EQ8q5SC5Oxat6cXZk2s6osE6GDLIDfw09v7D1VA+puPzUNv984p
 1HnqGwy7GfE7806+8ASg8vmx5EAu9UETLMRu5tprgpIc7ZaHRBK+sL+5mBF6uGf4
 LqcBLfWteZI2vXIwm8/y5iiq6UkNYEGoMnhmbgIe+Qkt1Dwlj+yyAGZrnwyBtAkQ
 n4G+gA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6pgqg0b9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:28:03 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-92108bbec59so8752096d6.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795703282; x=1796308082;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7Hz+V0KZEUKwYNABkLWPKOt8inKUR57WAc+UGW03IoM=;
 b=M4esX5u8UGZQw+tMM8J0BzJjtV8g3QpbqCATsSoBLywYPM2pVYpERBdIHVdPC1I81v
 aGe4SNOtABjFaBwWhwXziaVUURqxVHczXjV/2JXNrRMELt8n64v+wsb6GTLDDJIiF0Fj
 M+jImJ/02bo0Of0ZAcWIiuSpg/4evK8DNUYEdMbrZ4oBgw9H4D2ASkqYfLSjtmsHOE9w
 oMuFhJk+QHUA2TYG4aHDvcrE5yuJnz6cCOtvBVUi/NLKpY6f6sxlVU0cEpvpAUA7vWQz
 0bZupX6J0nr+aCRfmKqZ2Pr6Xz6fWg963P/MBHocm0XQ7NVjZZJbCT8VPREWh/NApvku
 0a5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795703282; x=1796308082;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7Hz+V0KZEUKwYNABkLWPKOt8inKUR57WAc+UGW03IoM=;
 b=MAasUeLMUSB7kuYKgbc3kgWtr8POerZka7w2pEExtpf+N5GzIGTjtFWDrxQhw08pd7
 zphGU1tjAXO8karCFmWyhd8lD1uSWgA3i3Dw5gzWHoN6idTFLZuULlgHskCVnQ9cS8Du
 OaRffIK53OJOEniM1m9+sz+nGSvvE9V2kEPHR3JN+Qo2nIomzoQsFWqWKwjvT+KauyCJ
 HADv2gGVH4rz845pOrE8P4l92X1cXtgjBTLVEPbZgEr2VVnJRRXYGdgdbaotnDNZBvHr
 5FL1iNMUpA0/6XcoWpZT1q3xsBQDOvRkwwmWK6w/1szlF6JCkT8Au6tarSPLTRZmMnKk
 r19Q==
X-Forwarded-Encrypted: i=1;
 AL+hErExfexLs+YoK5EIo2PXbAJzu9JsEBxORoxNYALVZgdpJQrwLNCiw7e9KVYKr4eo+3/l0cFCOf5xvyc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+C73qUclMH79EYmiffjJtP84aO83IO+suZckOyFWwETTkmuTAi
 G5kx+8l7g+njdQ0FD8/1py3p7FqfL5ZyvOYNBr4INHStXE9v+53kFXwDLsLqYkSvcO8Q9CQFqnp
 PY+ICmpqBcO9SAiETMppOIKs9Nw51crAuvE1WqKLsufvkbE3nuXEJ0r0rslGYavyjRXxskiw=
X-Gm-Gg: AZFdTZex9RdXzfD/qhkUD/1KL+Dh3EA4OXBCTxQLBMxSI9P+ObiHlW+CzUWnk/JWI46
 HN+nL3LhmX1oDY9ne5Cp8XCHM6Q7g+1sm6GqseFRWZTM+mfg03dNvJpfQmr0zoy9mpaU57P0zqt
 FoprLxggIEl1sP/gJikWbWKCkj4gAvWId4oT2aQR4aXNlZ4kpRBrsMczSOZMPmekUXLHN45wedD
 MWn+hoRgg3wZKSCR1k++1SWqZkyLCrbs0tCIG48FJkgsDouMnsEt6hbuMheCHp5BqfCJtyGDLav
 P2MnahqgW96HMSGERcpd4xopF3AG0pRARNLNvEVKm9WDqlcaShIsgFqarsRvd1/8OwpYdrd0Uba
 O0H5+vJRHBeIqqsL84PI5TQvd9h1Dp4rcDc9o/pjHqfcQ/nG/cwi14bkAmizUSAwZAsB/K9Q=
X-Received: by 2002:a05:620a:a914:b0:949:afe9:5539 with SMTP id
 af79cd13be357-949ba8e9975mr3995707885a.2.1795703281592; 
 Thu, 26 Nov 2026 06:28:01 -0800 (PST)
X-Received: by 2002:a05:620a:a914:b0:949:afe9:5539 with SMTP id
 af79cd13be357-949ba8e9975mr3995701185a.2.1795703280974; 
 Thu, 26 Nov 2026 06:28:00 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afc73d3sm756279266b.64.2026.11.26.06.27.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 06:28:00 -0800 (PST)
Message-ID: <d7901f88-af08-4a62-bf0e-cd7d858ec405@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 15:27:56 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] arm64: dts: qcom: sm8350: Vote the GPU memory
 bandwidth
To: me@fromdisposition.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20261105-b4-sm8350-gpu-v1-0-a7175cdd6512@fromdisposition.org>
 <20261105-b4-sm8350-gpu-v1-1-a7175cdd6512@fromdisposition.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261105-b4-sm8350-gpu-v1-1-a7175cdd6512@fromdisposition.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XvbY8TM0pncMum0vgyK92F3ATL0f6XKo
X-Proofpoint-ORIG-GUID: XvbY8TM0pncMum0vgyK92F3ATL0f6XKo
X-Authority-Analysis: v=2.4 cv=A7H5rKWG c=1 sm=1 tr=0 ts=6b0841f3 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=Tt5JBQAfAAAA:8 a=EUspDBNiAAAA:8 a=L780p2Jx1yd6vCQwJl0A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=kpHMOrJS8sLNr5ru0mYA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1NiBTYWx0ZWRfXyLBfjX3ODf5Z
 YX2k2ht8aqbVMv6r39EXBVcx0l3gt/I60mPSfwkkxGF7q4DuFRLxhNHUcyhI5/oPezU1S4whNfc
 o4A3yJUBQHiO6FZNXeagsTvGGmpkLr4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1NiBTYWx0ZWRfXyDwPfm+Czwzr
 pQSNHEPCCblJWMMOmsWUCkVpP6NeiDI1mFkVg9mVWXresUKr8PzIEvTUWRxJF5wTnMFwI51B31Z
 6t8fT0CcfheKE38r0fCqi//2cJM+vravvJohUdVsoBdFgJLPwENHk/p1BFdqxIalJ3W+QHFR2Qp
 89NGAK0hjvIoxqSK7S86avg3JSATPnyjPvuFEjcaY8NH1Zs6OSnwu0lrYVg2/mPMmtOJHvEyNVg
 E8ncY28VKLMsJoUcWvuseJg87CpiWbc/rsOmF3B8PWpra/SNekQcgAdHqS5TUQRqovDDVRHqo6j
 DrC2twnp9gk9Ul1y+vNGVzGTdtL9IxGWcXioA0N9f41upFllkcgP8sE4GJbYAXyeNeVtV2qXwvc
 91bnollFHjlbt8mvikN/DqjF7gOB/xKwF+uPB4794auSp48ZKuu/OMnx4d+BkwLdbTFv83FI7gi
 tOXgIyF2wo37APztmDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260056
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

On 11/5/26 2:30 PM, Demeter Barna via B4 Relay wrote:
> From: Demeter Barna <me@fromdisposition.org>
> 
> The SM8350 GPU never asks for DDR bandwidth. On A660 the GMU gets a DDR
> table with only an "off" entry, so the driver leaves the vote to the OPP
> core, and the OPP core votes only when the GPU has an interconnect path
> and its OPPs carry a bandwidth. sm8350.dtsi has neither.
> 
> Add the GPU's path to DDR and give each OPP the peak bandwidth that
> Qualcomm's GPU tables for this SoC vote at that frequency on LPDDR5, as
> kodiak.dtsi does for its A635.
> 
> Signed-off-by: Demeter Barna <me@fromdisposition.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
