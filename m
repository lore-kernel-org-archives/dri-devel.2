Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A89C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25E6210E1D2;
	Wed, 14 Oct 2026 19:57:43 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8573410E1D2
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 19:57:32 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EFMh8U1682633
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 19:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +8RR8qDMjT7yxubGtgQELppj2hvS1akqQSaC9T3HkI8=; b=A5zCCt/Vd1znMdtp
 Lv/o0GI1QEv+p1GNEvYjf3h+gK9Yix5e5WVsgHiseYb5jCp5kw0mfaQdadSW5DJB
 TSM82xWR74q4pTbuBwdN99sBbyTy5xabEsYMKYmeODPPscpQo7jPl3PLmyx25W73
 quk2QNUytUqZIv/F1RnZ7a8VPbZOq2S0imiMrocRnNYTEZszjIJz/1JSrG/10leS
 EDMgRR5ZBWqfwjWBZfBCI1d3eFuZe7SGcmhftvaLimNjVZfcIve3UClMtZp/kXs0
 SKbstiCAXsmmsVYnKnrDjWrMtYA0w5+f8kNb9ERFqHyjmESv8tQ51gWmR+avLCRQ
 3f0Ryw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hacb011pe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 19:57:31 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so12570844eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 12:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792007851; x=1792612651;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+8RR8qDMjT7yxubGtgQELppj2hvS1akqQSaC9T3HkI8=;
 b=ZAqW3gO574uMf8/GfGd/L/7+NiCLRHYsh1Jdwi0a1pb4iRaThwJx44eBqhQFE47ZDR
 74iRS18O7vKilS9g5qmLjaQpxzOn/0T9rvmT5VKotRbW4PT2wEJm15QKjE4NnLayNph3
 tpZyIiE84grKm1UtQCsohGLLmcDyNaQyk/Hy8FIxJj+EaU/xlfNRQ1QUVncQ539tdKwu
 NNh7hXmh7WeSXqzKiC+QkFIA5ALm/Uy07w2TClXJtDO85cGpwsF5EkBU2+mZ8aqwj+ax
 T1cEnl+/FdeN/orVPeNK4S7Ausfref8jyAZ5jQkX9Stx52CSK8lyFNHQ+5wYOgJTFq2W
 ztHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792007851; x=1792612651;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+8RR8qDMjT7yxubGtgQELppj2hvS1akqQSaC9T3HkI8=;
 b=jgVKlpl3Vl0ej8CParAm987CY14fHl5XLyY7Qpw6K8Hp3YqTBw6M7L3O2C4eJXdtje
 MKVm+VeHpmZtw/0M+4tLMHgk8Vcp97swc8PH7g28Tg7uokWjMbcz2Jb75n8xO40oI2Z8
 EOy+ytVaTbxv5Gg7mYig7xpWc8b5xsKARDK8I0TN7VuLj/GHy4PV/aja4cEQPfHTf7Ci
 VJJk5KRUxmY0AL4QLsiqUedE5SG+Xgx7rMxPUbHr3fszHxYxCxb+9/Tct1tQMdv0BOy0
 sP7bZC0JOsaoHbjZyPC8Uqxg4M4M91YyWnNdFBjLelqbNHv2Q08BqEZt7Md4p19DsjU7
 gI3g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNbDDOQYpCKWPmT7RUhGLZBxllNcsODa2psFivQ+2etJVowbuDh0WBh+B5IAbbdKYboLNWUVEITUw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLcg5rFpdlNa5f76kpRE9Z0W1i52SAWZCXpm1BQIlUPK0EyIHN0
 utJFbTcJizHuSSaeoNfExWts3GSuieq6+eU3Pnvy7yYt4XULVj8KJ9lcRcs3EafsAwP4tPctUV6
 Y/o2H1b67xm5h/LV1E8i9sm4g0/n6rbjb4DDdCoTK8I3UU9ae10Y5IKcdjU6qgXh1qZquDCc=
X-Gm-Gg: AYBFou37FRnGa0Qt6SuM/+H4eavUuRxD4NF4aaNjXlLfB1QfiojZk+OObbTsY7an0oK
 IQ97NVEWOTYEhgQb4vA6tN3hD7BV0Kz/cKmir/Sry5+TuDpBim2OeMb/Ji9mB/HYuurpKooNcLF
 +B5vDm1J0uoK4eg8G4MYaMKZUoFVAFS+AycaqTPgtX7O7Fh7LuUtZ4oTfIdymJJxfLALnKUi18h
 mmS0OfDLXjllzqciGaZSPZVAm59AC4GyKp7bskaiLABrynGIsQEXEgtLQP05F56Ct3ZN0EPti9N
 4pzcQaOfjBMhm9ZMZlTOWRV+RPSBiioIejvYdYMzV7/qBchpFWnyIsGr19ld8je16TeJavMz0eM
 lUXid6k0qaag83KLGBqxmzipXWrpJA1jmLn1FuFjFOQrbwDNVTA==
X-Received: by 2002:a05:701b:2803:b0:16a:b995:dc7c with SMTP id
 a92af1059eb24-16ab995dd20mr23120464c88.21.1792007851067; 
 Wed, 14 Oct 2026 12:57:31 -0700 (PDT)
X-Received: by 2002:a05:701b:2803:b0:16a:b995:dc7c with SMTP id
 a92af1059eb24-16ab995dd20mr23120423c88.21.1792007850297; 
 Wed, 14 Oct 2026 12:57:30 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a4429603sm46818445c88.17.2026.10.14.12.57.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 12:57:29 -0700 (PDT)
Message-ID: <1f38b5e2-e7c9-42bf-b4f1-c8721947010a@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 13:57:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Load firmware on cold boot
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, karol.wachowski@linux.intel.com, lizhi.hou@amd.com, 
 dawid.osuchowski@linux.intel.com
References: <20261014101545.3298558-1-andrzej.kacprowski@linux.intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261014101545.3298558-1-andrzej.kacprowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VKpIDNPX c=1 sm=1 tr=0 ts=6acfdeab cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=wQ7E4ILsKqv4331j-4EA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OSBTYWx0ZWRfX+E0/pSKwUgb5
 y6IGH/mg2/9FW2KNzOQLerfy99SqkJWwW9dZvwFRYrvPp8xKG7FZ491HYdo2/iLVB9PX/lXXIZB
 btEOMA/imrJcjevUdW5RPMbOR4U79J8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OSBTYWx0ZWRfX+tgnkfNwB6yM
 BrZ9x9+R5JJPkeghswAvriOHsqjfM6jWmFd9+O+vGGW2xjwt6uR6sIvBnN8vpIStHGSpd8HVFI+
 5dxtVPg1PgpMeAZq3aV1hrG8IXwbao9R70DhoJMUWDN630V7SWYUhNOekDiaOsczBDLK1UPVBzJ
 mRMmtgytBXOgLNWtYyHiiNw5ImYTB1MvuyQZMNoldssxHf3BSQLe+CPNgSddiw92/PoJoLqpjnn
 MFNLRXjBxis+nNk1zm8OG/lM2VIqqrq5uhKCMAr/pq+H3GLBGgQjskKeNRqgSKuYmr+FHniER/f
 Zaf04ge5doPzKdwNmvnYH1xSx2sWEqUqlE0ob8iF2YlYjaRI3P1pNeuMMYDWnV7wF/vKebPZxfl
 VnZ+Sbi3iX/jiD/ovVevYDyLQ9cEPEYvEDWQI19YCdbiAujQJsUk7GtZt7Hprc7YJpvVAXifmfe
 fOzVT4bnfwfYW6nQUow==
X-Proofpoint-ORIG-GUID: 1h5WhYaU6piQ15EijHCdPDSLjx-WFv6I
X-Proofpoint-GUID: 1h5WhYaU6piQ15EijHCdPDSLjx-WFv6I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140079
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

On 10/14/2026 4:15 AM, Andrzej Kacprowski wrote:
> Load the firmware image immediately before each cold boot
> instead of during probe or cold-boot preparation.
> This moves image loading to a single call site
> and aligns code for future driver changes.
> 
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
