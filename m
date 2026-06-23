Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7EECDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 16:32:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 889B510EC0D;
	Tue, 23 Jun 2026 16:31:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ESUWwHoB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IDjLlNpP";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CBFA10E187
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 16:31:58 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBZeWd4052488
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 16:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=bpZit0nzAD1TX3LmUuhtrO8w
 q8/DhirAmsH9yXDIezk=; b=ESUWwHoB/PYrdnzgspHK50aVHFG9HG0SsYqEfjcK
 zy3aoaNgH/czKeAZ0dhYEzvc8zj5J+CgxxbnedXTsuYRgPWHLPc2PFl5NVhl71B5
 RzAZ1QTHSeWoAg0DmOfZuqmnTFoJ98qSXI13pKXGoBq6v22b7zOvt8Tp8WiqEJju
 p9oePXq6Oj8Um594mC8b1BhgZVi78fg1jRXMfsxb3w1ShooV4RrqzM57YviXD7BM
 J8FvAdOBL4AMuiWP0Dh9PCHX85HUP9B4Te7sj9/puAK1R6J42yxzqKsFGGXnfzfV
 5f8fJ05IbJCt/q4yfE+sukmirsLHgEPcUWhEzCioqzK8Zw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyr9yshgk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 16:31:57 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c894c1c4aa9so10066a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 09:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782232316; x=1782837116;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bpZit0nzAD1TX3LmUuhtrO8wq8/DhirAmsH9yXDIezk=;
 b=IDjLlNpPadZcjipNPgVLUp9bERGgbfP7/UYHeqAxfZCuf/CcaaV67NIhw587GzsP1A
 /vMHtR4WUkQI+q3WtkEv2AIgXvNvWSi47jQAjcG2Rl9CMyoRQam4Um64soMjuJXGVZO7
 92TK1oTRyJYqfk9acJJuX7uYAUZrnUeFYbp4YIIRjgfjQK60A/Gfn628YAdVj1OIIU3V
 n5mnDYFTjwqEBwBYF1Hze9SsBL2WjvIPGw43GGw/vK5wXeYnau6EICU9I8hVDf5EqOSC
 Wz0Z8CYBzxuo+zgc4lFDdtHVAMqfyr5yWDWvKyg/Sx2iXl8b7k/eBsQz8myViEtxIk6/
 Q8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782232316; x=1782837116;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bpZit0nzAD1TX3LmUuhtrO8wq8/DhirAmsH9yXDIezk=;
 b=Ug9zkM9YgLAvGaziCeO+B7T+Q88yRJQ8cM5GveZXMoqaJLXuuuwOaI8hL4YhsIobxK
 lXIBjYRmm1b8d7ugiTiCIzxJFjyiKRc3an9jwUF/lHG0pNwzULUTVgFpDHEbWmJ8sIuy
 gb46tFFOCp8DPUNDd82sO7BDfyB1rxSFJI59R/kvpq3paTdDQrb/Zx5GFHXC2cqXoyQI
 +D+Gg/sudt/DqZ+ikgdHW3Wq92qAz9W5TvKAuAIifADmlIZ5/yrDlY+nx3MarT7q+SWC
 QTYv7nbatKbovruYbAliTr+m6Y5HQfwbq5yqb0hq+fEAXBXrHjy8g4AEJmBMyx11JzSd
 p0vQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+i07O5lRUslBQc7eoljYN9i9prXNtdmlX1GGa8YC5wZnByZqzu3pvH9WfzwNXjRkN9ievzQGj8C/A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKbdXhuZsm9O+QjwFQ3XqNSPbbmB4Uixoz/CeknPiHUfcIPP2g
 7CErkhNLY3wJWe2LdvIvGYtxpzLr6EGByWbVrSdF5v+UbXsQuNGJhnYmoDm3fcBDrurwsB/ACVR
 DAxuC+2QzGQ3PrCl3wgSozDHS0Auc0vYDVhqNGvTVQIQHMAE8UtQOM1hpPBraOC5Y0WoN5lo=
X-Gm-Gg: AfdE7ck1jfFQTS9VH8USVNpg/dNCBIKcpMGRzTSnOzOymzyvbRuzrbZqZGPvOvhlY2V
 sLxX0mBXoGWYQh9CnkNs5opHuWrXa6OWtBHB15Ypx5tK/yDYrahBg59UkLsJ0Ifsy09Uauz9+GF
 +3HTB9K6/7Vddz7bu/JclbZEN++uYsJ3Ln2m0mp0CEbi2RESTPKl476oplVNLaMOd/ps2SagF+L
 hq8Yxs03gtw4+sUIWlZW6tqcLMWJ+2sAqT9em8+t5gJzX/OGMHH70FslTBGwZVK6H48vBrsMPI6
 aSV3palc+JDUHXctZX4COvOtVxKhQnZ5Ztx+3KtMubsBVnX8na6lZZuWsMyUn/gsqjLIGX6yhzT
 B0jHF3RRNtW2ZKLm103kiQShT3si63Cq80SZqWg==
X-Received: by 2002:a05:6300:68c8:10b0:3b4:870e:6f44 with SMTP id
 adf61e73a8af0-3bd151fd460mr2827967637.35.1782232316104; 
 Tue, 23 Jun 2026 09:31:56 -0700 (PDT)
X-Received: by 2002:a05:6300:68c8:10b0:3b4:870e:6f44 with SMTP id
 adf61e73a8af0-3bd151fd460mr2827936637.35.1782232315599; 
 Tue, 23 Jun 2026 09:31:55 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc5a1dd9csm9850337a12.22.2026.06.23.09.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 09:31:55 -0700 (PDT)
Date: Tue, 23 Jun 2026 22:01:40 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: andersson@kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
 akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
 dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
 elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jjohnson@kernel.org, mathieu.poirier@linaro.org,
 trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
 jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com,
 amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
 op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
 skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v7 01/15] arm64: dts: qcom: kodiak: Add EL2 overlay
Message-ID: <20260623163140.l7dvkqa5szqkej36@hu-mojha-hyd.qualcomm.com>
References: <20260522115936.201208-1-sumit.garg@kernel.org>
 <20260522115936.201208-2-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522115936.201208-2-sumit.garg@kernel.org>
X-Authority-Analysis: v=2.4 cv=JYSMa0KV c=1 sm=1 tr=0 ts=6a3ab4fd cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=scVuWRnFyv5x-Sid9UUA:9 a=CjuIK1q_8ugA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: Bq3ZVzjgjEi2_rj26isMpoCP_PMECmTN
X-Proofpoint-ORIG-GUID: Bq3ZVzjgjEi2_rj26isMpoCP_PMECmTN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEzNSBTYWx0ZWRfX08MIWx+1wVya
 lSaJkF8RCO46AkZxUjemGoRsE/YEU317En4hckSNCjHhhaRnWoFIUIC2b/bd7XH5jSJuoJQIZMJ
 uox5OhnV15aNe8hhD8BIifwW3df5zVSF3M+DhEtkNtlm+2hAz41MJbdYp0BSZMe1CBbARoJX06c
 LoJTN6X/ZpreR5/SrP6l4qqBFwt4u/x6fO5YoWrJyyHAzqTksDtJJtScFhMGubMSkq2Liah8hO/
 g4K+nEusasebuxJuu7ZBPBzE5F2bMYAEiktsInfcAtwrGJOf+YDAZBwZPzrQXeReHNw3kfTmuhC
 ju8fUFTBlKZ8vCcYINY9RbT2T3SYmAPP4mLsV3WyrwI744jzVNydIsNwo9PuGzzsdtWR6VxICof
 mluiH/nGFUUtxaK7MjjGn4cqRFQ2gTgV9PRicgl2OV85UYxSCtK+yaXa3RbHc9ItL2QySAXMp0b
 bcmGEyAvqaj1YegKhQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEzNSBTYWx0ZWRfX29F3Do8j4zE7
 nzf5lVMZfN/V3MxmCAS14sT4LV+n25a8wXc850D02pEB8cL1krzKW23eWg/ZTSkF+7OrHUDsbGz
 NpgI0tVsjNygbWeIcwIq4i6gBblhGmo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230135
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

On Fri, May 22, 2026 at 05:29:22PM +0530, Sumit Garg wrote:
> From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> All the existing variants Kodiak boards are using Gunyah hypervisor
> which means that, so far, Linux-based OS could only boot in EL1 on those
> devices.  However, it is possible for us to boot Linux at EL2 on these
> devices [1].
> 
> When running under Gunyah, the remote processor firmware IOMMU
> streams are controlled by Gunyah. However, without Gunyah, the IOMMU is
> managed by the consumer of this DeviceTree. Therefore, describe the
> firmware streams for each remote processor.
> 
> Add a EL2-specific DT overlay and apply it to Kodiak IOT variant
> devices to create -el2.dtb for each of them alongside "normal" dtb.
> 
> Note that modem and media subsystems haven't been supported yet due
> to missing dependencies. For GPU to work, zap shader is disabled and
> in EL2 mode the kernel owns hardware watchdog which is enabled here.
> 
> [1]
> https://docs.qualcomm.com/bundle/publicresource/topics/80-70020-4/boot-developer-touchpoints.html#uefi
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> [SG: watchdog and modem fixup]
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

As discussed internally, I will be taking this patch separately and you
can drop this from series.

-- 
-Mukesh Ojha
