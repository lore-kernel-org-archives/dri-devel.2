Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA11606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h8x8FN7h;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U+jujiUT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5199C10E646;
	Thu, 12 Nov 2026 17:36:13 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B28F111227F
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 17:36:01 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACFZNNX2293193
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 17:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6ARaiH+yGSXvs7RhHMO/6X6meS5Td6KQMs8Pk2FRdGA=; b=h8x8FN7hs1uMIwVF
 +4AkQgWyIJ2znC9hkPebS6CeL84FHDaNTvqZL/eQDWOYki7lVSOKMQ2/N7W0B4Zf
 Pc8nzwI3n5PEKjCvc/azXf6GpW9VdJJJbQzQDKs0Qt1iB0EsPw3UjdXMsMtxMiks
 BU3/9BFcGNqhPx0MkRVpj6N81ShoHMOYodq9pWhykGCTnZ+f0nqNmQBsoc+jP7Lz
 obe2qlBuWNpP+Zu8mdFd+f4CuuWjP674XWh+WQG4JdBM8nJ577D7mSOcYBKYj9fd
 5LXH5g9O6Zymk+onVOseAyr/+P3seu7hWEALu+b89zTxbCPmyhHQgz0FzpoOoGmR
 8APpNg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbs01kt3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 17:36:00 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36de26cb4b3so102388eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 09:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794504960; x=1795109760;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6ARaiH+yGSXvs7RhHMO/6X6meS5Td6KQMs8Pk2FRdGA=;
 b=U+jujiUT6c/fOkmIpb3eU4BMtSTaf0Wk7WR1tivTYhLe3PmG+DaGMLi0/NsfsM6wIs
 Zo5wuM7PfzJyIUtiy8NHmK1zv/AwBHZLCtcIG0p8TvRRKy6N0uGWCMTt5A2nGA2vbqSR
 BdEtCSAg7auU+ucIvj5Ey6AneSOb6Z7G5lNreMN/w/2br7670JTmZ9jiU10sD2a7Aqow
 e1cIsad2QvKyzx9pHc5JciD2eKcJSq+0vk+f3khP5X9XTNTL9rp1r71DA1gPrNJDmK6r
 s3OUyvsxeauBdPhTMGNnxCUEIdj2DdBnww5Z6lEfHDJyCqSX7PFv1LBnpGbhat0Fkpz2
 gBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794504960; x=1795109760;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6ARaiH+yGSXvs7RhHMO/6X6meS5Td6KQMs8Pk2FRdGA=;
 b=KIo/NUwEk6GQJH5PMM7AnaecunuvysbUqkNtT1DQCsF88CUhx5rJnnYWiJ5DjUkjGw
 JiYZs7hdsfyy1iRPrzoqmYKG2KReB6Kss375niT50tY7E1mUv3Pl4Ll1wSPdupbxnvdj
 0JK8+HvV2yecsOH7ppQRut3ubavvbDYMXxoUwpp0xXy3mi8HhkjbhcS18TnIYjyBD7ZN
 aG42s3ysS6o+UOzg3NpSVk6XfbfNZPU/kpsaDtEVoqwcAcZSlmRvH8HoXM/hIFWanZVu
 B6GL+P23xgSy04Oj6OFSF/h6Fdedz0j1Aty2EPaAOALiT4rIXf1DjjrvEK/vB+lshjaS
 Vd2A==
X-Forwarded-Encrypted: i=1;
 AL+hErEmfJnA5RwJCVRKwMrWheE/HgbEjRPda5XLx/7s1CakAMEAZaoDqmB6DyHgdZGLs7EY1zLp6HiEG2w=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Z6IQWrMiuGlXYb3JWTkXGhy+Ut8lrLqCWLvcb19NO21HS2yXp
 e5tlEFrc02OeqJwakysCROans2fjM4E9SJvtsOL+pRn/sKvLmglqQ5Ty/+Xl2ejZQy2R30tbmBY
 Uzogp2AOXjn4PZUJkKBeqO5fvQpH/w0Ugkj8qBs/GpDAu3/JuE365zztJUDHmu58g5QsslSs=
X-Gm-Gg: AYBFou3Vv3RlLoodwc/1WKBf7GEeTZYtgQXTjvsfWYHmTWVgNC6U1J4xvNPKnskWEtq
 5TpOnMvErUQCKpuNkZO9CQ3L37NwZMaxi2mKvy19NeKMaf5QqF9XWgUxFp9y0wz2Gv/+PmbgAnl
 b1ro+bWAAj95ylwvGxl5V5BtiU/007T8ZlJGqVmy39WiXaSmKjtosbc+UiEenE4CFwRWcg4pnNY
 YFaX9Gtzt9bgNAkAsahgyNYGA8CCsgmvBv+kofYk4KqWSgDwXzawQUSv6S0sHcBDDMmZm8j658Y
 HJBaFOfY5hOj1H0JoRcp4cSexSBjTev0QsheLACo07ARMSItv3YLkFy5elyPJzS33OuEgq+ukG2
 AjCOix8UEAcYKx96WDOFLDTeHfvzuVkczrXGMO8uRVQnLtQ+LjQsqReu/Bwf2kZzhqpCsn4cSbt
 yNzcWEZpFns1j/Q46AioC2/9c=
X-Received: by 2002:a05:693c:4007:b0:369:f420:8679 with SMTP id
 5a478bee46e88-37687211c14mr6500561eec.38.1794504958618; 
 Thu, 12 Nov 2026 09:35:58 -0800 (PST)
X-Received: by 2002:a05:693c:4007:b0:369:f420:8679 with SMTP id
 5a478bee46e88-37687211c14mr6500537eec.38.1794504957717; 
 Thu, 12 Nov 2026 09:35:57 -0800 (PST)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955e0d966sm44496eec.15.2026.11.12.09.35.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 09:35:56 -0800 (PST)
Message-ID: <410eef90-a692-46a1-869a-cbd121c3981f@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 10:35:54 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] accel/ivpu: Defer recovery until probe completes
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 Daksh Sahni <swizzguy76@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, dawid.osuchowski@linux.intel.com,
 stable@vger.kernel.org
References: <20261110121534.3566028-1-karol.wachowski@linux.intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261110121534.3566028-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA3MCBTYWx0ZWRfXy8mkcLtn8qti
 8GPK6ACXh0IxMvWhNPp/aHmlGD+/KEI6ClvY7fZ9qgsZnWf4uIWnDlzqkDo1Jr/V3hNFvLAmpJj
 /EpsDeoyPQS3jKaV4ZMIgSlS11SXEN6gAR0BseGKytR9uPnpgJUA0HqWene4M5bnEiUEvxiLLy4
 sF7UbU5dwtBmRe5W1DxBGCRnl+9jT3EFvueF3BZUMlXnhbkgnDJJyk8QE6ganbCNbD8gRbVkcHN
 FdnAMlblLozzlIjyIcYhvOqUNxx/K+RM9CyLf9ijkcfA9QqrGx2ZDVygqtijRgbl2fWHEaWljI5
 B7UeSIN9TPM/gFl4xV0G8Q4TaEpkYqcnz7lm2i0dccOyHtOzu+YZHjx3fov9XNbvziynI8s6mTL
 22clA+ldwOGIBvEsqoA6WoIzHBNvYFs5k/j9qfE1fICgvskljfxuiPfpMvc7wnDE3U7nMqxBZWw
 cWYssH3ipDFsOgvQ2xA==
X-Authority-Analysis: v=2.4 cv=AsF7T+9P c=1 sm=1 tr=0 ts=6af5f900 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=Z2QDNxsNg4WANq0UR4wA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA3MCBTYWx0ZWRfX34TzNBetVWAN
 XgyZjP0XWE2m9Zi4M9TQERL7eB0oJTq5PsGfVkHWYcfZNtZo89syfIxv9Z2VUCPVnunTk7dumaX
 VGk3o0XmJKqYlIfLdLNvJgJIyRCQMME=
X-Proofpoint-GUID: n61UiRoRwSpr23HlZe7sixZFWQHQe3Yj
X-Proofpoint-ORIG-GUID: n61UiRoRwSpr23HlZe7sixZFWQHQe3Yj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120070
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

On 11/10/2026 5:15 AM, Karol Wachowski wrote:
> An error IRQ that fires after ivpu_boot() enables interrupts queues
> recovery_work during probe. If probe then fails, the device is torn
> down while the work runs, and the work faults on the unmapped BARs:
> 
>    BUG: unable to handle page fault for address: ffffcfc6680200f4
>    Workqueue: events_unbound ivpu_pm_recovery_work [intel_vpu]
>    RIP: 0010:ivpu_hw_ip_ipc_rx_addr_get+0xc/0xb0 [intel_vpu]
>    Call Trace:
>     ivpu_wait_for_ready+0x155/0x220 [intel_vpu]
>     ivpu_boot+0x9e/0x270 [intel_vpu]
>     ivpu_resume+0xa4/0xd0 [intel_vpu]
>     ivpu_pm_reset_complete+0x2c/0x90 [intel_vpu]
>     ivpu_pm_recovery_work+0xf6/0x140 [intel_vpu]
> 
> If probe succeeds, the recovery runs concurrently with the rest of
> probe, and its pm_runtime_disable() discards the initial autosuspend
> request, leaving the NPU active until first use. Any recovery that
> starts while the NPU is idle loses the pending autosuspend the same way.
> 
> Keep recovery_work disabled from ivpu_pm_init() until ivpu_pm_enable().
> A trigger during probe still runs diagnostics and masks interrupts, and
> ivpu_pm_enable() runs the deferred recovery before the initial
> autosuspend request. A trigger racing with ivpu_pm_enable() can cause
> a second, harmless recovery. Request autosuspend at the end of
> ivpu_pm_reset_complete() so the NPU suspends again after every reset.
> 
> Fixes: 852be13f3bd3 ("accel/ivpu: Add PM support")
> Cc: stable@vger.kernel.org
> Reported-by: Daksh Sahni <swizzguy76@gmail.com>
> Closes: https://lore.kernel.org/r/20261107174215.15818-1-swizzguy76@gmail.com
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
