Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B98ECA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 901D210E62A;
	Fri,  2 Oct 2026 15:21:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fjsPPAEM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZP6ZHsPY";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F2CE10E62A
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 15:21:21 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692FHOsT435907
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 15:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oxRZnvCw3lGSk2CcsaHNTnh9hw9jr+t9sP+rr+e+2/o=; b=fjsPPAEMCh3Cjd8s
 UloZWsNWQUBwpVBClPqkvepcOvfO4k0Lu/kXbgy2Ub+p132e5X6VqvLxkDpFLkAq
 tt06f8VX1AXO003VqvxmsPu/hP8aNklqytYOr6sjpNIY3eyfDQIMOA1AwXvt3j46
 fNJzH2aZSv+MESge9vHpNu+ZUcUktWxK9wILyzyFkIm4ZXFEcm+/k7WVWPcddjgd
 twfZ4qV+3a70lIYdrIvw6yus6bMOrQh7UNQNj+PGG06juUSlSN8pmq/V0xWA+0O3
 QHzHEoBZXObuIv2MCp91vV69DqIzdvWXL0jEUe5FmEgJo5QPEaly5sE0OQNZg3/t
 X3tuvQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1vxebr0k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 15:21:20 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3a70af6c365so149873a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 08:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790954480; x=1791559280;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oxRZnvCw3lGSk2CcsaHNTnh9hw9jr+t9sP+rr+e+2/o=;
 b=ZP6ZHsPY87c1KfIZcNU4SvxzP5mMeDphGgpZia7xP0D0YCJBb48m2D9ACioPdaqgwf
 FudVrE0eI4DfyL/IL4H1t8Gvj2+fmsiUgT3eRj1VKXLuCgWvMV+Km6nioPMEJxUYFjSq
 pu6fYWbr00PS/VIUpm2v9S6zTZcmtmjpqx0CEiDmfXCUFmA7ZWmdgrG9Nb/lcE0q6igU
 HOKJsVdVyEGBTuBV70xdEncKFm20II3c0Qzh0vbopYBN+QHcX5MHzOgOraM4Ga5v3zdV
 nMV96sNn11gaPfNrnFvAc1VyhM7kKjOSFQiJ8oAnYoaQWCApLHdEIfC9eS+2gDbAWifE
 poAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790954480; x=1791559280;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oxRZnvCw3lGSk2CcsaHNTnh9hw9jr+t9sP+rr+e+2/o=;
 b=2U/B/4p8l8Hg8dqem8VwhXsfjTXPBBCvVahc/0ZUGKjtcRVcDxphWyb30MGLMYDm31
 mWWcJeF6XZAvkMACLRJbSP7xDSX3FDqkWfrMkfDl/vY612DwF1ATNfmQ84z0oAmqaf5H
 4zlWJezXirIPis24Cyg5ePr1TWNp4m/k7I9K4LvSHUpEqmuxj+okAc45d7eJNBNKdUEp
 lr7ZPNf/nBA/HnLEYQDJ3cvtkbq8KvdzebGQLgDw/gytIv75WvySVnTAQB9o0fQNcDsb
 uerrWEpmv6CDzYJAs0rmPGsjFOdeSFhaeN4vzwFaBygXmctXN3i0qRIeoMQliE/baPme
 8WbQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByQGhyu0Ue9kzh6be2yvJHnJYaKLj2U/nvv4b/3FcfaWRDt194LTb5McwqvskZkCjSVvqbdiwhghQ0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJLbeWtVqkUpX8NV8GfU1mK3MPquj8pvT3yQ1P1cBc0aKiaVA/K
 fsyJe43zbteDVnEIBl0k1VJ2M/cMfNFV+QF1ojM41wn7Fq3zQnWrNm3FpcrZrnmS4t2qveILTT3
 ts9CZAMvg8YszrakMhvxsO0GucuiK5Ax4hYkZAlyi6tgFN/SIPzR0g8ZzIa4VlmXsijqi8pc=
X-Gm-Gg: AYBFou2FcXV9cr23j29tmYF4Oi9JnEyL3H+4CeXRkmsHYE0kj1YbmMldpdrSydM3wzm
 Hm4djMrzNiOu8cfsvn6gi2aoW3u1zUF4Jdxof2IbEXFjmV2oXOPXBUdDO3pt89gwgBp6zr4tDk2
 V/uOhzOBytFU+LjSDxLsL5a1DxkwyuPPgOI+Hr3161EDudksvQSinHgKL9EAEpmKENyD9UD96uN
 X50ZPM6tJI2URslu3FgLtoEQuwB35ZTV1bS5DTwnIMMUa/6pSKnijKFVyQu+OEUyu7mn+uAhRRg
 gm90nlgCNg0pHLeVA1QUfPgCPULSxC17Nytbka3bBEEkM+3jWz2qrhUf6g6c4ZyePXe9+EGYQP4
 lHJODeEPaVX2fQ2me+zI5KPnO26FMQPIlbNQX6pb1HkMw7rgfZg==
X-Received: by 2002:a17:90b:224a:b0:3a0:cb48:df6b with SMTP id
 98e67ed59e1d1-3a6ce98d0b6mr2918883a91.34.1790954479963; 
 Fri, 02 Oct 2026 08:21:19 -0700 (PDT)
X-Received: by 2002:a17:90b:224a:b0:3a0:cb48:df6b with SMTP id
 98e67ed59e1d1-3a6ce98d0b6mr2918849a91.34.1790954479297; 
 Fri, 02 Oct 2026 08:21:19 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f74d093sm9385225ad.83.2026.10.02.08.21.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 08:21:18 -0700 (PDT)
Message-ID: <726b64ed-3913-4e4f-bf35-74ab43c744f4@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 09:21:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] accel/ivpu: Split HW IP generation dispatch into
 helpers
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, karol.wachowski@linux.intel.com, lizhi.hou@amd.com, 
 andrzej.kacprowski@linux.intel.com
References: <20261001110401.2866557-1-dawid.osuchowski@linux.intel.com>
 <20261001110401.2866557-4-dawid.osuchowski@linux.intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261001110401.2866557-4-dawid.osuchowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fdc4WEQF c=1 sm=1 tr=0 ts=6abfcbf0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=m4OkbcnvSYaI_tkVD_0A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 0xqMiPFqWKVpDZ0qgan5M8Q0jlwJS0ns
X-Proofpoint-ORIG-GUID: 0xqMiPFqWKVpDZ0qgan5M8Q0jlwJS0ns
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2MSBTYWx0ZWRfX2+bDusMmJa/C
 LKjb8KMwNB5QwB/aWaJsCBKM/VTQQz2wAyPcLI8WoDH67DZwcgVt7AjzBdp5fjvFLSWSsHU+Gah
 9GyWGAW5X/CDNaNVpWNL5SYkSvlf+1zUrNuXNwCGZr5Kc4xF6tPQV8dKGc0D7wMHtLz66UlbprQ
 irCztJOg3DdER1mNJF6OVx3nA92XVuU3fC6V5b+by2hZhDp/wOevrv8gNdJjIyWm+Kr4pk+9q2a
 XnbcygIEKz1+3M+Gn15SjofTD2teDGC5OOMQx8xC5qYfTg44Mtd9FHCpBcA4p9LeQzt+vhlLGvu
 NbYDGDvtF0vrHILfJfCu/NzxU2XjeKbhz4XSxpzewcxSTtq8wZQkWWpe9WIEUuQ1RZ/4FAkvTAf
 b2jQHhy5ZIk4kIyWWyQi+9sBYfBoWgHnrTfLxGRWWPFcHp/lzeMhmCodVvCkjiU8L+sw9ARaZ7c
 C7+EjAXUYw0xm23IVYw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2MSBTYWx0ZWRfX5g5xXCuqVmC5
 Z3rWpmugHh1p+3vmTRORwbHiKOf1K0huGSUASCAvsMLQCFZS8KSymySNuWTcz9Xtyc9HYZCOa3j
 W58P/KVVerI5hX/WMuxd8xUJHsZJc3w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020061
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

On 10/1/2026 5:04 AM, Dawid Osuchowski wrote:
> From: Karol Wachowski <karol.wachowski@linux.intel.com>
> 
> ivpu_hw_ip_soc_cpu_boot() and pwr_island_delay_set() keep the result of
> their per-generation switch in locals that are left uninitialized on the
> path past the last case. Building with -Wmaybe-uninitialized reports ret,
> post, post2 and status; Kbuild disables that warning for GCC, so it does
> not show up in a normal build.
> 
> Let every case return directly instead, so no local is needed.
> ivpu_hw_ip_soc_cpu_boot() now dispatches on its own, with the debug
> message moved ahead of the switch so that the boot mode is logged before
> the boot registers are written, and the power island delay values move
> into per-generation helpers. Neither switch has a default: label, so
> -Wswitch reports any enum vpu_hw_ip value added later that is not
> handled, and the path past the switch returns -EINVAL.
> 
> Build the power island delay values from zero instead of reading the
> registers first. POST_DLY, POST1_DLY and POST2_DLY together span every
> writable bit of PWR_ISLAND_EN_POST_DLY, and STATUS_DLY spans every
> writable bit of PWR_ISLAND_STATUS_DLY, so the read-modify-write only
> fetched bits that are immediately overwritten.
> 
> The boot mode is now logged even when the boot fails; no other functional
> changes.
> 
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
