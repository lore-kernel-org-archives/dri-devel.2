Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06089C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39EFB10E87D;
	Mon, 29 Jun 2026 12:43:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NMdpH6YD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VfCnQ4MS";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A99B10E88E
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 12:43:40 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT3ro2646942
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 12:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CpHcwEms8mZxbI2w+Md5BrpKxIEKLFyT45Gg2vM0YiY=; b=NMdpH6YDeqCM6Ng2
 6l+u1JT4xPqzvjoTIliP40I8uS1vyj+L87A0s/qye2JFugwtFubIXUyRV7TGDunu
 R6AT7ytIJgsoT9qLUDl4wVFliJkW4IuqsH8CbCK3KeaS2RCkVYPYUJb3E2XmVf/n
 n3hDCcBxNJlzKeVUAMJaWhtjvocMm4xmBllzsNmFZBHpLfh9MoNKpAQANg8pAcNm
 TXF0zOy0GX+9LwYTaSDruBciQSlEcjcnL39ePRYOwyzIFsHATrj9EfyXaS+7TQfj
 LXtLZZhSE0HawuL0/q6HT7LO9lTXKMaK7kYXAJnJbjWc2xRjybwKZ0RF9NkF8Rk6
 8fCEwA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3m4ts9tp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 12:43:39 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-37e4045395cso3804907a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 05:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782737019; x=1783341819;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CpHcwEms8mZxbI2w+Md5BrpKxIEKLFyT45Gg2vM0YiY=;
 b=VfCnQ4MS3iadVqGY9nA1cWmzklCtlgVaPvgjreTjlgaAaeINOtSuToVW79FJJjaGZZ
 C1Ah9ls9KQhA+CfemS6ilgmoSwQF1/i39EqeoB3Cwt4elQLqrLRSXFSyZDj5RHDXzl7D
 GnaGR1z5ShKwZ3Fg89Gk2wMRrFJ8GeI847KlXgSgRxPW+PLucMtRtSI/vj7/hxzasaqw
 NZrKQKki8cpVVIbqlGDaS9fY8ZjhYH5hbDpW3hZBJQQslDIBQ8CzDcO7si/cqFg3y1nv
 xqq/yAGATm5wtCUuSZRWWuwif2ow+nrEfmrk02oJO9gm0nBREsIoI/OKnl0qFMr+FKWb
 fgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782737019; x=1783341819;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CpHcwEms8mZxbI2w+Md5BrpKxIEKLFyT45Gg2vM0YiY=;
 b=aJIriP3jpjZITblPpzcgMRw3LuBx+ndJwO9pzJ4+FS6cOePErQ89Dpt1HPTrZs4ycL
 urJQXOH9LcYNNQ48sHcCvEVNbtVVieDriqejLhJB0oZTn5BquGfQXSuhvjsqAgEh7vIq
 9cVB3roPYWqIIxBl1x1Egr2WebqzwrnBxItjlekt+7Fy/IxYwCxXIJvGjNnT1Q4xvCtl
 pYCdckYaJEFV8lZ/IIGBND04Ciywb9DLZRLGqR22BYR9G7oCY+1NyL7OrMOtOoDVrzWl
 vjBL1jE51kq6iL+Fs+wfDhPRk4eThbIYE/OpLfqwEnYzRXCDnU5B18YkgZjm5R8kwgjP
 KwDw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rppc5XfbI5f4eUbvFSxZp3HiPp+vnpESlbcW7Csjx2oH5ZNfFtHAQCeAqQykyqrL7EbJAtwl4Spjt0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyfY16FO9DpfJ+xmKGkkS1K0x/cGUdRhpOm0wcTC4lMpUABhmo2
 FOjBOv+UbAfgPjphMXHhLksi+5lHn7hE52uxRHCgAIYNNEnD64hulQG94vZKybppxEnIwUWcN9k
 GADRdrHNPtf16a+1pJHHHqLx910JJ4Ez0U3vWbaCVqOyDlrRJMTzfBdgmBJ1umkIN8wgbQpE=
X-Gm-Gg: AfdE7cmgioQPXhIMy3r81OFPe5c4LNOviWBztoIfRtvmqDnHK4lsEAMKWPROnwLIFob
 unxfPBxfxMQmyXYd7HJVAsKLtF47isK6dA6XlOtxHA5Y+ZyelCWdSe9yCh8/9nR3KxRQeIlxvoM
 bVFWikCDa+wsXxVLVN9XpYdsyA0GyscLf+1uifxyJ8qvfpq+I6EmR/iS+7g1nHPHetT8/cQ9F8I
 MGJAsH50+s4EUogek64hYwf18oqrFpL2uqasmqxFrSYTI8EDnedBDjO8lk4+9BXWwmYWjzzT7J8
 noT7hMMMzFvw6WXjusbKDcNixyYiyWjPCt4m08Fgy+rbBQjMgJY7vN2XwFhXUjTLbRrhpl4UxJc
 nUL43jHjrXoAVcrwluKQyQ9FVjQ1alnoKANRbn/wf45y+PkrdHE1pSTG5u7+p3ymv2wdGbiWw25
 7Xp53xvA==
X-Received: by 2002:a17:90b:4ecd:b0:37f:9ce1:cdb0 with SMTP id
 98e67ed59e1d1-37f9ce2229dmr7491063a91.30.1782737019094; 
 Mon, 29 Jun 2026 05:43:39 -0700 (PDT)
X-Received: by 2002:a17:90b:4ecd:b0:37f:9ce1:cdb0 with SMTP id
 98e67ed59e1d1-37f9ce2229dmr7491002a91.30.1782737018606; 
 Mon, 29 Jun 2026 05:43:38 -0700 (PDT)
Received: from [10.133.33.246] (tpe-colo-wan-fw-bordernet.qualcomm.com.
 [103.229.16.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37eaff87f61sm5602580a91.17.2026.06.29.05.43.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 05:43:38 -0700 (PDT)
Message-ID: <f0ed588a-6cfb-4079-a2fe-7c14f1b42727@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 20:43:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] cpufreq: rcpufreq_dt: use vertical import style
To: Guru Das Srinagesh <linux@gurudas.dev>, Miguel Ojeda <ojeda@kernel.org>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Andreas Hindborg
 <a.hindborg@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>, Michal Wilczynski <m.wilczynski@samsung.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Jens Axboe <axboe@kernel.dk>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, driver-core@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-block@vger.kernel.org,
 netdev@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, zhongqiu.han@oss.qualcomm.com
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
 <20260628-b4-rust-vertical-imports-v1-3-98bc71d4810b@gurudas.dev>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260628-b4-rust-vertical-imports-v1-3-98bc71d4810b@gurudas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwNSBTYWx0ZWRfXyfnCndHmmnA+
 LoNQzicIos1LNQgdRllk+fzCTg43xlOeG8+BioDG3uyfCjcoSNyu7szjo82uu/OOmVxxZRN0oxr
 89QU31ZVdIfd7h52FYiIlc3gT3gCvq97hWgPidGZWm6sMR9Mdm263cFVxEA4XILENo9aYkAuxXn
 XxeALoohWvmSMWr7tu5cf/1vqHpV26lwath7zCOfWv3FRaTq2A3xXI+RY8wX/5Ol3d02nf/HcBS
 2qaZiE1/x6iNbh8e2vocetp6TGt1NV0JSkd89zfwk8JITEuYCJNYdHjgo6UdxkaAusJGPCWjcIX
 wzXFhY37tR4WaBenlnKZM3QVpZR0hG8sEhPn+fUjp12m2iq4B38CDWZxkyjNp+mqfHVZuyPE9o4
 JtggV3fnt2VP85bpHSQESdjLsWb9yqRG9YRm/V2BsLgS8/xjOpibB92L34dAabuMFXlNaQI4mod
 csqjHT+3DvBXtSPBdQA==
X-Authority-Analysis: v=2.4 cv=R58z39RX c=1 sm=1 tr=0 ts=6a42687b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=ecjbvcZnrCEMvoAzKiMA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwNSBTYWx0ZWRfX31W9//hq5foq
 dlvV6icV9EsMVTggWCguhveGAuEzwV/MHeKWiYrpP0L0fj1cyGVAPvgk6eFMenR0XSNkkhBdS19
 HAyIy7PxavhJDMhTLuLwQIeX2LPqUrc=
X-Proofpoint-ORIG-GUID: HqmklXuBvct0MKBZsQRLUIRDEtn7YSO4
X-Proofpoint-GUID: HqmklXuBvct0MKBZsQRLUIRDEtn7YSO4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1011
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290105
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

On 6/29/2026 11:38 AM, Guru Das Srinagesh wrote:
> Convert `use` imports to vertical layout for better readability and
> maintainability.
> 
> Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
> ---
>   drivers/cpufreq/rcpufreq_dt.rs | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 

Hi Guru Das,

> diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
> index 10106fa13095..6f83cf8955a6 100644
> --- a/drivers/cpufreq/rcpufreq_dt.rs
> +++ b/drivers/cpufreq/rcpufreq_dt.rs
> @@ -6,7 +6,10 @@
>       clk::Clk,
>       cpu, cpufreq,

The change seems reasonable according to the Rust coding guidelines:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/tree/Documentation/rust/coding-guidelines.rst#n44

     "each item goes into its own line, and braces are used as soon as
      there is more than one item in a list."

If the preferred style is to place each imported item on its own line,
shouldn't imports such as

     cpu, cpufreq,

be formatted similarly as well? Have you run: "make LLVM=1 rustfmtcheck" 
on this change?

>       cpumask::CpumaskVar,
> -    device::{Core, Device},
> +    device::{
> +        Core,
> +        Device, //
> +    },
>       error::code::*,
>       macros::vtable,
>       module_platform_driver, of, opp, platform,

Likewise?

> 


-- 
Thx and BRs,
Zhongqiu Han
