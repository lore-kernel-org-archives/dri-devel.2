Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F17606A32D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IDSvKgtL;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=a1t2AFAl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 119DA10EE96;
	Mon, 26 Oct 2026 12:02:03 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6CB410EE96
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:01:51 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAtEBP3563059
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VzJXKHWJowrI6hOoUXLp6aJOFbu2bd1z6Aka5OEKUo4=; b=IDSvKgtLSU4Bw1d1
 G8fUyADyvE5gRtxX05159uGej0m6GRxBzbF/sehcA4Q8ObR2HYxpIcJkv/+AJuyn
 LxfV2ZLcXGqpPxEhV93FhgC6SQu8aEOjJg/MtxSc76iGf9/wT4BJPLGUfZfoTtmR
 1xZ5rgMa3MG3vNjWBpZBuvzuCnfUYKMiAkuKaZifA99SSeH8BqdnxNQCmWehsbYV
 6cllylrwNOPt+BXTZDBudlOPfxKk6fIwyMMv2eYk++qM06YqST4R36UEpJ0ZcSKI
 V4kgDlFLmU/ayCf9qP0F0OVYfvEgA1JcbuP+re4466dis4XsTk2d1EGXmql38Nrt
 2f7LMQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4s90ecy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:01:50 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-8241d159f80so772578a34.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793016110; x=1793620910;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VzJXKHWJowrI6hOoUXLp6aJOFbu2bd1z6Aka5OEKUo4=;
 b=a1t2AFAlf+hv+ciImva88mI+wDApWkkJPXGxwA5Nj3N3NQb+dUe0NirJ3kzjezISYD
 8fStfS51dROwst11PKHuqQfxUb4MCLI9OftUShk0kvgw/9hA85lib4lP/NSNNkCh+lao
 o9Sw9pHIDFvm5ya8kfOzK9RQd0e+pqK0pPI67E14YFoWB8y6cAn9/7XQd0n0D/OKjzqr
 LPvUZ/bsUUHGBIUk+0DAP7ySL3CphtmS4wp1XQaCGsi7KEGUIwcf1DxuPdJos+o9JHgg
 0yE+Ty3vMX72Fih2tXMbYjUg4lppDEBaYqMYp60cnqAaok9BY6c3Nj4IFghf+F5ROLLp
 vigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793016110; x=1793620910;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VzJXKHWJowrI6hOoUXLp6aJOFbu2bd1z6Aka5OEKUo4=;
 b=jUJStL7V95wnFBtevA5JivZY07nAZTw7cvR4Zp24qgy1Gqdmss//sR0GsVg/LjMdD5
 HlN8v6UWKRp4+hZZznzlw4ymnU1HxcjQsF39J+MRp9/VwQsWOGQn7/L0mD3AhfZ4pILB
 G//z1Qowo1YNg5oM0nCdn2c4HedNZlZjLSfsMpICwMxD0iAkq3A0Ipvy73a9TqqRQqsl
 P8i2WWFpI5dzRHCnUxMdrkWurPWhMTqJIEIal+VeJaNYEnzDCRMofVjdOwgnWbmgSUF5
 jSJdr87f673r7z1K9BVC7ZWSKsm6Zc/ik5BZRI9g6rdSMw2flCPnW6UJmwf/i2gDd/1q
 0J/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBw9P0BV5Oo/tp6w9I9sWKpI16Jx+GRfwTZnR3H+kguTpf0SNKM/hjxdpZySJ0BekR/vaOWjwxnBUm8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJv2hTt/+mPMzBYMvWEwNbfsWOwCOe3Ancc1N7eOi6BpNpgt2nV
 xPfAqoaWmXPVl+LiXFaNUFj12pGULYxPnmyHQ1efXw3zNXaQS4Udvdu/Cu9SiCwfSeQkFaNdgf8
 R0iHykfeKXO6phQSzOpizgTNiAKp3abAXiJCYSMUj0uMMcoLq/2sMklUkAMZ4lj90V+CldAc=
X-Gm-Gg: AYBFou1xM16aMIv5V5oXePltM6M3yGZDWGwj5z47f5DtTY+/kuwdVT1hF3GhkrHxaUA
 K+UK94BA2RA+J4/GEI3gMKs9BJyNHs2uqGoqepGRpzQv+oTNIufEyMJok9QZOBWR7L9UC3ew2CL
 Dj2Ov2yljFcSqyJ6SyAwbvOs0/pSsnVIZur1HSPTK/0XXaE75ut312Z1aplz/P97LKtTVxOY0ga
 +aoFm1ukr33gTMfbptpIlQHRLef49l+Kd8exnh9SjY7hau1eX9szcHyMg2t+5Z8j7ydOSN/sZNP
 wz1tuHCAjm+dZx3KJw2mIhY2KAFPrStusNTiSXorlLfdng0EEpxgBMKi7bBJsp5GOlLkuQrLeNH
 ec25MC+v7zp2tyepfJ4tgJQ==
X-Received: by 2002:a05:6820:c0cf:10b0:6de:87d1:a1e6 with SMTP id
 006d021491bc7-70ba0d3ee53mr4140756eaf.2.1793016110007; 
 Mon, 26 Oct 2026 05:01:50 -0700 (PDT)
X-Received: by 2002:a05:6820:c0cf:10b0:6de:87d1:a1e6 with SMTP id
 006d021491bc7-70ba0d3ee53mr4140696eaf.2.1793016109423; 
 Mon, 26 Oct 2026 05:01:49 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46c59c063csm265518866b.34.2026.10.26.05.01.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 05:01:48 -0700 (PDT)
Message-ID: <0facde6d-85e6-4394-9de8-8290c4d69582@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 13:01:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] arm64: dts: qcom: monaco: Remove FastRPC compute
 CB9 entry
To: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org,
 arnd@arndb.de, stable@vger.kernel.org
References: <20261023090308.2898683-1-abhinav.parihar@oss.qualcomm.com>
 <20261023090308.2898683-3-abhinav.parihar@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261023090308.2898683-3-abhinav.parihar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NyBTYWx0ZWRfX4ypsZvzB/Vaa
 A3uoMReiQ5ev0T3mw5Rjx6S2iY/liW/x5CBePrYldG2rKM+O7iPC5Sr7H68ZR5vFkrG4jSPO/gb
 DC/uHFyMaCoxsgMSbFZ68+pP0CeqGIlp0MwBPLzsF7kr6hFSS5AGDNeAyHGYG6bpyfivV2hxeoE
 QISYO5K8LaYQl1zhVk8Khc8ytLrFYJVxdHs2/L3qnBFmEGVKnlJOMPWdkRmsyeM/IhLPASEmpLC
 zk7JZS/OAkhXdzYa84PapZrvVdVCxagpTSpYWPSuezKmpnP8vn/CHX5PzD3bR6qrLK+QktlVMw3
 awBEPjbc62oZTqyQShGkE+od/4DzmI/8TfunOG1SFtlq3PW2++TQl9vMvRLfG5bjeHb8MBJw2tH
 /HuyF10LEBUDA6kz2NCdMBm+B94uasECF20evASjuSMruGXlxWdl9qZ5eqLQhTdNi3RkaYpzT2O
 im3WGrr0c6IDc/umv/Q==
X-Proofpoint-ORIG-GUID: iq_-pdExY2eOiDELslQ8kHlj4On4b4X7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NyBTYWx0ZWRfXxy4VNPwm6CXK
 6RG7yd44ekTS2Hx+MjXN6hwPBXRG8GVuZSvcvZk3LxfKpeiAa4Z7dPSwPSipZb3OL2Trd7nL0Lc
 hi2HHLDveWsNC4kjezuYRcdnjDdbcJo=
X-Proofpoint-GUID: iq_-pdExY2eOiDELslQ8kHlj4On4b4X7
X-Authority-Analysis: v=2.4 cv=HKhWhYtv c=1 sm=1 tr=0 ts=6adf412e cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rdexUmAEWTTLP2vLS_oA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
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
> Remove the compute-cb@9 nodes from Monaco device tree to
> prevent clients from selecting a secure context bank for normal FastRPC
> workloads.
> 
> Secure use case support is not currently implemented upstream.
> 
> Fixes: af0d19ea5a31 ("arm64: dts: monaco: extend fastrpc compute cb")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
> ---

The documentation doesn't concur this for this platform

Konrad
