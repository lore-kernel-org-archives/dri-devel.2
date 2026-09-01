Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2091AC624CF
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 11:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CBE010E3D0;
	Tue,  1 Sep 2026 11:01:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CW83/wQb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X1duk9Br";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C1EE10E3DF
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 11:01:30 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681AJjov2752225
 for <dri-devel@lists.freedesktop.org>; Tue, 1 Sep 2026 11:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZF/DA0i/vJB8ETVhi537WGfCwLGoiddks1hUp3ZHR0s=; b=CW83/wQb1Y2K6z+G
 0dyFxJoDvzG7dR2702RceUiMPF8VFNuTNnJ6J2A28NyzdnTMriZNJnfYIwzvcraY
 VSfzLNiBLOn0MTSucE7A6S0FPP2m9hmQUXmAP7XD6hZMlL1kBS2g1pUS4xfL02NU
 sSowKQX9+f/ZWkf7JHo26vnDLo0sc03R42ERljW6qoVRho3NI37/DEbThiLYCwQZ
 25yzSE1uJylfQJj8TWRbLsWcnCYIKJwBW2CC9LYUOhvii0W4SNq6IRZBU1wCK0Rs
 zISEzek6R9Hmyf/0LK7ugjLWZxSiISeP73/ct1g/wTdzf4tdP4OXhcJIcmHWf4YF
 sKPXlA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdfchbjx5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 11:01:29 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d959904658so12552145ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 04:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788260488; x=1788865288;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZF/DA0i/vJB8ETVhi537WGfCwLGoiddks1hUp3ZHR0s=;
 b=X1duk9BrwqLLI8F9RJ3vhLswULImPcXkkg4cxc/aCKiOCoPanSK4xe/90fmst+B0CF
 yVUwSKN2yy/ute9UBba9em6I8gZ5lBDdt5caOBgFG3g3sXp9+bWhV93LFMFF5OKYUfak
 MhhK4W/6Uhmnax01eoVqhqvLbYXXdAXu260ba6JBOux4TupljUqP3FW1HkTj8CAfLHMR
 g2KpoQUBHDbtJsR+HHdh7rEn745YRkKvZ4TIIOdlS/I3Wryrhbme1ZT5sNqJEQ+luMoS
 9PY5na3ynb056Hyj5dwddBmLr3Ixh33BPYrfEaEynYD0aDH+a42zC4wHEJa36vFJliki
 V4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788260488; x=1788865288;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZF/DA0i/vJB8ETVhi537WGfCwLGoiddks1hUp3ZHR0s=;
 b=gNi6+k9rLA8pRSm1b+kKVqc2teGZdvAXOZTnixjnRq17UYgfmzgiHXzXgv0+KWFEWO
 OR3OCOz+K6BxTmDg8e/PhDqwfaFZrbmBUU7ZCYgGXrfOwsDwneEmZYhlyg5DyxFrMe1f
 tptWmLVh+tLqH53F0kjc3/1zLkAp2R/0YKIxtERPzzwW6NX8c2AEvDlqgM6kL6iRT6WH
 /8qsUuMDy6Cnhy8I1wu1BAAg1mYRpJDFKaSMTB5N3iQR8DwCMjOb6XSVSgX6CkXAnzp+
 1UEJYAj9F497rfa+PM753OlSCCK+DNNGrQBwsYi8WFbZYGkMpSAHaLTI5UqQNChFXUV7
 tDQA==
X-Forwarded-Encrypted: i=1;
 AKwUvByFhWacDCrO6ZTCqsYDtP6p9zO4+NL+DgbbVXz2CmEQrVbGaAVq3BJOjwew7eE3rDgMHDyAVlEYaoc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++no4/JPdA6HdTiOaINXgVKY90FKJBWH/8bj4Ns9q9vf/6cB/oKJ
 tMJu46hvjVFx6G8T2TUu4HWzOCaXW41a2nranqaUhduDcn9DN7oY0r3SUKx7LUOUkLXYvCXTw+r
 rTAuAQejp7X0uZnkaisOC0Q6ufNOvhDk0xoDxhEhEM9BVzdQb+X6dOkDjD6dvCvP0bWkl0wQ=
X-Gm-Gg: AYBFou2YGe7aHpwCGB8Fec0I3QN3QWBoh8y8dQ/AXfcFBBSU97hNZpRZKNLfdk2CYA1
 h0vnHjAtg9wSXHaQevIXt8ga9+MIWkUOcWAYAs3DWqqUxcFGPHr3KHRKnCZ0pbN77vyTYyd/fDp
 7D//GXEqP/J/+k1vrM8kq33/d6NPvvZzD2m7UPHyAWrDpj+Rv0f77IVxev5Xb/ZVT7wgMzxliUR
 jjzTjyZGVIieXTD1f8BIAqJZLq0YSg+lX2DBW4s4cwVJOjJOW6N8rbGrOvXZGKU9oRO83YGNpUf
 PZ3OqqSIUPK3yFp+ZN/7Kgjt+Nc7Ng5rmvZfE3kbC/ImHtal5F1g2h156fErcRZ6vIS+8hHvbLT
 cSOlTaMaFYbwaKn52U/yy0bgjn3xW3A==
X-Received: by 2002:a17:903:1a2d:b0:2d8:d4cc:be64 with SMTP id
 d9443c01a7336-2d94a904ffcmr110370465ad.17.1788260485733; 
 Tue, 01 Sep 2026 04:01:25 -0700 (PDT)
X-Received: by 2002:a17:903:1a2d:b0:2d8:d4cc:be64 with SMTP id
 d9443c01a7336-2d94a904ffcmr110365825ad.17.1788260484072; 
 Tue, 01 Sep 2026 04:01:24 -0700 (PDT)
Received: from [10.219.57.226] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d7596412c2sm49707335ad.37.2026.09.01.04.01.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 04:01:23 -0700 (PDT)
Message-ID: <5c91768f-b8b0-48f8-aac3-b08b76605e1d@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 16:31:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
To: Jianping Li <jianping.li@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, stable@kernel.org
References: <20260826033803.475-1-jianping.li@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260826033803.475-1-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: CmXIM9tNNZnxTpNZYDdYOJyoqDCViiPI
X-Authority-Analysis: v=2.4 cv=G9Ms1dk5 c=1 sm=1 tr=0 ts=6a96b089 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=MOthyIZreOk6ictk8Y8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: CmXIM9tNNZnxTpNZYDdYOJyoqDCViiPI
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA5NyBTYWx0ZWRfXwwtN16LERWpC
 hnjsIh8bccRdtSL6JQ68b+cb7jC8pP5RDTX8QIc6lpL9eFW+hLkBOvVHWxfbZKzuHRE5fOFQ/yb
 UpYdgkmUaE7zqTINnpyQbVeDmrTJg/g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA5NyBTYWx0ZWRfXzbujh5Rcvv99
 KZO7f1aVO4f8rUauKCChdrYTOdlezIwAZtFmlQJLszqW2GzrlW1rLiJ5wjVjU6dIlWCOP/mNXf8
 nRqqLWBLo88w5HgBmcIA1nJGBuEA5BYHUNuRZi00XcoY5JkgSxoyawjg8PcVPKv4lJOvTrL+pDG
 K3snqD2yRjf7fFjxVdHw4dCkiFHx4/p1ng5amCn9F2k0M0Ne66wokTCIPwHzA74JvN/3zgYiBmv
 4mrR3CFvYfP2/59OGVSj2y0/1YRfbT2c7WHt3y+F9dEL1voxsbGxeQiqtzLGSCwz2Qq61ZzrZXT
 iGCfxW2Gx2HKGFm7dovHyhZ+rQehLs1uAUucsLwiRhNUsWn0PFwWBmFFtL2y02PXou4ZhV8Fuim
 NQN4/BHcmCOwU0s1xmCnG8JW+zB4R4iVJlZA15ZYz15/CdcSc8mBeEjmEz45SCckcg1lmAr59Za
 Kk7aN1b8DvbBeiAoGzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010097
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

On 26-08-2026 09:08, Jianping Li wrote:
> Allocating and freeing Audio PD memory from userspace is unsafe because
> the kernel cannot reliably determine when the DSP has finished using the
> memory. Userspace may free buffers while they are still in use by the DSP,
> and remote free requests cannot be safely trusted.
> 
> Additionally, the current implementation allows userspace to repeatedly
> grow the Audio PD heap, but does not support shrinking it. This can lead
> to unbounded memory usage over time, effectively causing a memory leak.
> 
> Fix this by allocating the entire Audio PD reserved-memory region during
> rpmsg probe and tying its lifetime to the rpmsg channel. This removes
> userspace-controlled alloc/free and ensures that memory is reclaimed only
> when the DSP process is torn down.
> 
> The reserved-memory region is now mandatory for the Audio PD domain.
> Rather than failing rpmsg probe when it is missing, validate it in
> fastrpc_init_create_static_process() and reject only the static-process
> creation. This keeps the fastrpc device probing for all other domains
> even on a misconfigured device tree.
> 
> Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
> Cc: stable@kernel.org
> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
