Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CF6C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:41:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1075810E8DA;
	Mon,  6 Jul 2026 11:41:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XsySMgQX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XUXOF+/p";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D79610E8DA
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 11:41:11 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxEE0366750
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 11:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JyWL2bmNSCp8kUWSmxLKw8OK4EFDlj3sVJl+0VzDp88=; b=XsySMgQXvfPgt0+a
 HXtcu1zM2rla/ZW5eTCxaMB6FICW13P1fwym0A/MsfBjDjqUGgXD1EHFUEySuOk2
 2z6rHOSeFOjg0Nyyc6VHixBwF+xqtTVaCt3ADnTB1IzhmU/aQqOPwenB2//RiLUm
 B+kOKlkYz6F03GNs7m211bs4Pr22Yuq9DZfFgJDYUjFMnF4mWSST9/zOrRBcEb9q
 n6vKECdJiMTwf5jgm2LcODgoUDnUe4767AbVeb1xNK1d92+uBCFBvMe85oFat7y7
 xZR2l3W1G+EwqCXOK7NjSKq0MIxTJb8OcGXxyUAjh0LR+gEqcXBvSvMPiveVOXbl
 yRJtqA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f891urp7e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 11:41:10 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c298a1b20so6242701cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 04:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783338070; x=1783942870;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JyWL2bmNSCp8kUWSmxLKw8OK4EFDlj3sVJl+0VzDp88=;
 b=XUXOF+/pEoANjFLhHd0wW3dUHw3jrlRNzuMP7PTFpT2OIH5C7EF6TTw+YuC16IA4vh
 Q8uNZYJ+Fppgi7SuoqY+JzaH/X2oIOcNAK2I3c2tnNlKF3qrFH2EQuD4vtMV7Rbh4JBU
 ToK60aQdO2qAtV5WsO0UoWCxbYNuAb6pmyLTmLp5pwSEb2AcnK58tOHjOI/vj3sewS5n
 oya0UYBgBWJ2A3Iz5WETONYVhjMu1zUHXoIwxXiM62kiUQ2iaQFzdyCkoJnNCgx7f0wN
 1ZOTBdqUqrfNTI0pQcSi6eOhlmISr5xxwduU3RZvEj+veFsyQSbsp3hOkgURLx1PNaMo
 FPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783338070; x=1783942870;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JyWL2bmNSCp8kUWSmxLKw8OK4EFDlj3sVJl+0VzDp88=;
 b=k2uekBIlsMiC7HHFnWHemZ3SlSBuLrDa6bxi+pMvNxwiwiHS53Sx2ic0Rp2ARFEhWj
 dc1jgu/uM0LQYhw7dNXcgYclSD2cnQp5V7k5qajJNsW7T7hV1T82X/kqVP4nRjIcTLYD
 /5FDnYZRE3bhNjMIYQTBcrUM2pIE9081uuDl6fBBtd2nlz1ZPLs0hB8CSvErPamKpX8f
 Ct3EFmSSVxszFs39MF8gx142VUHGnqn8bFjK/TpUqmnq9xzS/jVNiMOOs3/wUcK77/WY
 Cvf6WoZIbrJEMTZXJhbCGIirJ2pBfJmjzy7lzfvdF+7u6ZcRlxGWZA/HB6nw9cNfeWW6
 eE+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqP3VVvAzQh/V7wkSXO14IDTk5jy9fQ8fhWtQNRVHmEKP/EebFXsHDpIZfdvBecZSFmNteJ++IXgyE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyOZ/c6TB4CXDnsvRh7UMFfzD/vRQm02mvsYSMDkSdGomY0kde1
 BW9Ca7INyiPItDOe8LWQLhLwRUmHkJDsO5P7rVdgrBF3ct7+SfJvbGfwKNdOvDxf9ka0rB7FsQj
 5ERKSLSboi7ZFQjR/voDkL13ZGcvA/IniCihE/T+AmGus9l/V+nOy/GRnsHWIHaYeEbhNEXU=
X-Gm-Gg: AfdE7cnXEVCtl+yYZcvdVRHc7GvMQ0feHlt433j42fPkYbnk5VEYFEEqZ+fp7DYtaxX
 VdK0sTP1+rA33KBHbXC1LPIdhMzizh/Te3Cb7dUJlauxOtx9PGDUWx628Opcz+YrqmLrZIEHwke
 zEadhFxbUHUSlrnii/DXUA9/HqZBab21VZkWPd3X60aMBvNO7c6n/LxcrQDm5E+CBT9mAhXjm80
 nguzHTOs0epHfiYiewqgmYDqd5WI7R4+3lPiNmQWVYqRUe6YAsr2Sc+dZmUAZ0X7nFBqcA4q2L7
 a0i1w52fKYpjmqSpffQSqQiLr4sbYCIWWVCaJ/NRyOk/20CPzTEZVBEGcMMlWamt1biC2S+hcAj
 Pao7UP8OLSzPT0+WnbgEUyM1zYSUKnD+wZrk=
X-Received: by 2002:a05:622a:208:b0:50e:6311:7380 with SMTP id
 d75a77b69052e-51c4be99299mr82578451cf.6.1783338069825; 
 Mon, 06 Jul 2026 04:41:09 -0700 (PDT)
X-Received: by 2002:a05:622a:208:b0:50e:6311:7380 with SMTP id
 d75a77b69052e-51c4be99299mr82578061cf.6.1783338069294; 
 Mon, 06 Jul 2026 04:41:09 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19cf68f5sm4059006a12.13.2026.07.06.04.41.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 04:41:08 -0700 (PDT)
Message-ID: <4f865aaf-a400-4dc6-acaa-80dc22a36af7@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 13:41:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: qcom-geni: Add dynamic transfer timeout based on
 transfer length and frequency
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
 mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
 andi.shyti@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 naresh.maramaina@oss.qualcomm.com
References: <20260705135739.4038826-1-aniket.randive@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260705135739.4038826-1-aniket.randive@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: oDeaZbwr9OVA1F9b0l4yg-HLI1YPNWVe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDExOCBTYWx0ZWRfX2xc3wfFUO4G9
 bZh1zY6QIQUZHTykq2rZ8VZhi/vmAnMsqWGzRwzZDdR1aYGQ/CCcZCfQLoijUQ7z4gcxklxAk2a
 oPoM4B1CuW2HXW4zkfjGA5O7HwNsH7g=
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a4b9456 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=QdFQMySKPoxOC9Zsaq0A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDExOCBTYWx0ZWRfX8y1VLJorIfc5
 r9QvMltZ4ur1fw89aAdPHr6mu2Be/IGbcU5TWeRobcFu8uBQLUaCrLoRTxfv2f2m9rL3G/vSI8c
 uHtDJ6e0Xm6qBg4ZPqua0GJrMUxcNdjN8ofswrEBqYl+0oP4rC7HCNKrMQ+CkHHOtG0b/YmTofC
 3Ok2ehQ8HjNxfPXI/Bv/jryteIpIhrxwDg3CWDgKMMM2mvcXBoDI38GE5BUHitUcv7KD9NdhBvP
 Am/moQqjIXtWmFuTWZ5sIG2CWnKTe8nmakWVYvjMYFV5UMpZrMMKR3LQXNzGAHAOQCfpNxB6Fu+
 AH6DUE452kFmrhkh+F3gJhcCk0OX4u1asFfMudgLbRF8/ohon3usVCISKbP+1ERikFTv5X1o/eX
 4lhva55aQMCHhrp6SNOxg4IkLs1LqNce8yMTRyIPlt21pNl58K2+YeOsIoUgirF9VIKxq3LpERA
 FSAk8u2yyyVQTLKUUVw==
X-Proofpoint-ORIG-GUID: oDeaZbwr9OVA1F9b0l4yg-HLI1YPNWVe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060118
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

On 7/5/26 3:57 PM, Aniket Randive wrote:
> The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
> regardless of message length or bus frequency, causing unnecessary
> delays on error paths.
> 
> Compute the timeout dynamically from message length and bus frequency
> with a 10x safety margin over the theoretical wire time and a 300ms
> floor. For GPI multi-descriptor transfers, use the maximum message
> length across all queued messages as the per-completion timeout.

What's the reason for a 0.3 s floor?

Why a 10x safety margin specifically?

[...]

> +static unsigned long geni_i2c_xfer_timeout(struct geni_i2c_dev *gi2c, size_t len)
> +{
> +	size_t bit_cnt = len * 9;
> +	size_t bit_usec = (bit_cnt * USEC_PER_SEC) / gi2c->clk_freq_out;

mult_frac()

Konrad
