Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935F9606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 04:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W6dQD+NG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CaPdfe1U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C004B10E13B;
	Fri, 13 Nov 2026 04:53:11 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2469A10E13B
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 04:53:00 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD2KAr11187082
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 04:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SQOyNq4wTmVvG1qOL+i4cjxIp55ug7AVmwSdeBhMIlU=; b=W6dQD+NGeIfbalbg
 fBXP1uYaB4rbxVX4V2s/40APqNdHqEZ55y2yBpgduq8h12Ecie9AUadWDYVgM4Ud
 h8nZNeDdPZI6R6uTnuUL7wzY5biXCfn/qtXLaKx0U9MuaotZUi0rmtYpyti9Ag8Z
 M3NwLxYgVNZarjrp8Xt4ML9bbSLBc6HllPp65eLVxZTKWGxdzS1XHOUgWAkRrZ+b
 tE0tCDU/bVCrsnpjai62L9R+ytvnZ1vfwn9Htl0uUctgxNYZzYfzwmzx3/8sbU3S
 pD5PmLq1qmU+2/h3TAXdBdvWNwyjNVaO3ta4LUErbYkRVnTCYe6BYrdQi3P7Alcx
 jVMMbg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw9e1c3mu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 04:52:58 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3b0c7ab2427so425434a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 20:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794545578; x=1795150378;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SQOyNq4wTmVvG1qOL+i4cjxIp55ug7AVmwSdeBhMIlU=;
 b=CaPdfe1Ur2pj62s3yL/KdqOtia/bgLHRWJu+tz3RTaZ/jkPQAUsuXaMqyCPnDlA2U8
 cdDwIvkwZkGYZlD92IH+ZsOJ6FDpiVLRVS+VZlVLlVfVh8/4CX8K0W/29xWoHfgUhhkw
 32SwrAkPUgMRbQwl4Y7HM8JE8MMrwW+028tBhH3ZZxKW/Yra5EKeF9NTsrEzEfwAxM70
 Ajpm0jhE9HtzlGNCy68VQisgREzDpDYltLt2WQ8kDcBoT/vEaCcnONi9biYsP00jLH2U
 Dcjcq4bmqn9+NnAvzSCIP3HY0aJbE0fEqDWcGQqS36oGEF+Lh1PgDKtSMACAcQiH6n7K
 2aHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794545578; x=1795150378;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SQOyNq4wTmVvG1qOL+i4cjxIp55ug7AVmwSdeBhMIlU=;
 b=J7u3UFL2e0C3a9+jallRSHbu76ZtqFGlRmjNag1d+KdiGhzTxqE0vszsy93Aw4vpdW
 BhodWfOV+IJG1/M4W7tTW5kA7r5A5l1HOYpIjIcCoPltoSZPtW3/8e/pQSqNvt418rv2
 NTK4S3o4W+T2rd3C9XDl+f3JDkW0JKmbFztVVFpvs8k7gRpgr2nAqPCKTyLqOS+mt927
 ZFkO0/293d2rY4YV4+QeVHJ+fIExaVc8Jn6IrbcoRwyHonNH+NzGfEQG8mE1eoEt4xBu
 p62X+60AnMb8CB39OsBKR/KaLOXylxVS8jlgEhbk4NNK6rkaYvHD5RAMq7tjx7lYTHyH
 ntfg==
X-Forwarded-Encrypted: i=1;
 AL+hErF0eUpavWfDrTX+n8sqqnZJzGRslYRXArUn0FqceGzfultCpjdpFQrVVWCqFvOfVybt4zEWwtjgcgU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9gTRPLDzRFu6xL5WbhXbHsy+7ZWjmgQ28h7pKxmq7jqXL/rDWB
 z7LbZWu1HDOKX9t4+bk79DEsUrHIQ64NEeJPF2IKYyOd+eifUsRRtTUgFoQuwBoSdZ/3CLrl8qZ
 kmuGajo4fxghZZJlb3/nBvaAGP7znj3MMNQ+Yrg2h4wr3pSFb5dqYGmkzPypUSG8N1pUZbrc=
X-Gm-Gg: AYBFou2X7n/L/fUkojzTBEz44yaxFqNU8yKkAHrO5nNR8uNfSCaG5fDY0geBirRIZG3
 uUjKAlB1MAg37H8s+XTYeqv84wzgyFjwV7cEb+/8yMxZuDueD2Ku1vEf3ENJBr4vgaHbodneSef
 KzK4bUlAqzJa1lZ/cNubKDrzKJr69RwMlfJger+U3SH0hly/JUYaY4zU56V0rrTB7UZTWwNO7k8
 NfiFSrFJUfyDXOLdWt2VYD1F1zvpHl+luUZfqb4WmRKk+QGddqcQ3YhdZ+UNWH7u638XrwwU4V8
 Imdbu2a22V/IFvEwlae+DhFgFwWy6krCzcxtWxyafXzQLr8tsm3F3gHKbcdUCNVTzqZ0DWS0pyZ
 O7v2jxRDS7RIswADRSz6XE/8CRGibrdNRQ16oR02tl5ddWyehxUCZ9UIUaomg3w==
X-Received: by 2002:a17:90b:4e8f:b0:3ac:9c37:942e with SMTP id
 98e67ed59e1d1-3b1b0b53e79mr1213791a91.49.1794545577727; 
 Thu, 12 Nov 2026 20:52:57 -0800 (PST)
X-Received: by 2002:a17:90b:4e8f:b0:3ac:9c37:942e with SMTP id
 98e67ed59e1d1-3b1b0b53e79mr1213777a91.49.1794545577299; 
 Thu, 12 Nov 2026 20:52:57 -0800 (PST)
Received: from [10.204.79.100] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1aec43699sm2343811a91.10.2026.11.12.20.52.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 20:52:56 -0800 (PST)
Message-ID: <84eed340-905b-43fa-9c63-135401920e5f@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 10:22:49 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/msm/dp: Remove redundant force_link_train flag
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, mani@kernel.org,
 robin.clark@oss.qualcomm.com, lumag@kernel.org,
 abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, irlied@gmail.com, simona@ffwll.ch,
 Saurabh Anand <saurabh.anand@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 quic_riteshk@quicinc.com, quic_vproddut@quicinc.com,
 quic_mkuntuma@quicinc.com, mahadevan.p@oss.qualcomm.com
References: <20261111104434.2222182-1-naidu.nama@oss.qualcomm.com>
 <20261111104434.2222182-3-naidu.nama@oss.qualcomm.com>
 <gfzdwaeouexratptiktpzodi44x6ztsfttqajzr5wxtrluyqjx@axwlv5jlakcc>
Content-Language: en-US
From: Naidu Nama <naidu.nama@oss.qualcomm.com>
In-Reply-To: <gfzdwaeouexratptiktpzodi44x6ztsfttqajzr5wxtrluyqjx@axwlv5jlakcc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAxOSBTYWx0ZWRfXyTZVMbTIhWjK
 Ie9ezF6ZFYKR9XZP8Y5jxfg3QHzcZs1etzR3/QrLT6nVF6ae06ppXXKVtgJrikHif6XfSgQ0dWX
 pZsedI9WVQbxOakW054quYqv/ysHbGHJBXGu8gLVFli3iOu3jQkMrUZfLDvJf0EwVQQwI9rnUKG
 I4TIMIoX2I4W/zrNHD1qnIwcTfYklI+MR4QS2wKCMpgZDVZGzA/eQ3JQ2xJhedEsSLEJSUX/mOf
 pishzf/rlYXCRoBHmZJ6Vdtn7LslOFJFDlMKuvh9uwh8uH7knHsc+pTJUyWVBf3mwBrsjtOi27K
 jj0Kl5c0VGYUD5DYye0ZHr3nWyY9/sTWYYFSZK7iZBE6XK8Wu0NkNOElIg0ul+jeHrGYszmQie9
 FZv/4A+5KPbI59q0zdDnybKIFaMi1APUoZ2oDv/Y1JkTfePcKxzUkZ7iFGcX93H9m77tAnwJzyd
 mWmPyVitiOWEe0vnEfg==
X-Proofpoint-GUID: k1v6YLmkwegTMPhnGvxRL45QRwW-uL4Z
X-Proofpoint-ORIG-GUID: k1v6YLmkwegTMPhnGvxRL45QRwW-uL4Z
X-Authority-Analysis: v=2.4 cv=F6fC5ahN c=1 sm=1 tr=0 ts=6af697aa cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=QtFsyhEtc1s9TALtjxMA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAxOSBTYWx0ZWRfX4KBnQwZcPVCM
 Qs4ToEm0QT6YVWBS6YrOwhksj1N/sxjpy6uQDVPoo0E3Ri0T2u1kWJm916A0a0yv0TazP8D6+s5
 onN4UyroR9JLwAafLyIIh5pjYKAa56M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130019
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11-11-2026 19:36, Dmitry Baryshkov wrote:
> On Wed, Nov 11, 2026 at 04:13:54PM +0530, naidu nama wrote:
>> From: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
>>
>> force_link_train is always false when passed to
>> msm_dp_ctrl_prepare_stream_on(): the initial link is trained by
>> msm_dp_ctrl_on_link(), and the flag is cleared before stream preparation.
>> For active streams, it is never set.
>>
>> Remove the dead flag and parameter. Stream preparation still retrains
>> when channel equalization is incomplete.
>>
>> Signed-off-by: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 5 ++---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.h    | 3 +--
>>   drivers/gpu/drm/msm/dp/dp_display.c | 4 +---
>>   3 files changed, 4 insertions(+), 8 deletions(-)
> The same SoB comment.


Sure, I will update in v3.
>
