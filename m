Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BF3CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:15:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45FB810E2BE;
	Fri,  2 Oct 2026 17:15:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dXMuxogA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hh+jIOJR";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A31410E2BE
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 17:15:40 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692H6O501278553
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 17:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zbsnwXTq0OoV45hgow4KHvYsJLjC6m32dKDmrYd1IQA=; b=dXMuxogAwmwYkXVx
 0cXUL2XR4xHSJFDVHtA+Gv3KoP15+/A41yQpq9hkQUyOR9XI98y3WJ1sgCSYmMEr
 aycvq9l4Lv2q2x8aaP29bcR23JkY4u5bLQOqQi/uOZp1rDpcXHPqH5PfrjRyJvED
 W8dt3VWpa03SE4y29Tn48zxZa9uh8z7irBFVLnAUvMT6/jY6sYLB1BI9/AceZPRS
 fW7LY0zFLRxQFLubRmiXeK/vmS8D5f/K70n6H0PkBr1zsBY3IMrb15w3gb9V4DUC
 MiOejtOhwj6XbLTfwojQYn72O4BH9DzsmVs4evwMDSLWi5Suwq9W+i3Y2IXnN/xE
 sNDoVA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2dxdgvxs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:15:39 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39e3c10ac70so11026630a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 10:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790961339; x=1791566139;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zbsnwXTq0OoV45hgow4KHvYsJLjC6m32dKDmrYd1IQA=;
 b=hh+jIOJRrZhi+kmefMmuT4MOEt/vc2+ttwhIlDWFMHCsAJqzAx8pnhITNZ01ehFQ27
 vYA6qmDYC1nube18RiKC1oE0pJYkOnC5bMEq0JxM/JN6+8fiezu6shl+QLn3QjNDq+hK
 2qLIK6/Izi6FHEU1IHmGWnaeh/IsO+ArmXHCVCViwiMBFul4aq+moVF6q+/PIvpzPAOS
 ZO9IDAQO684YNi45TSOHTbjjT3bV1QCbWkK5IKEijQ4337vcN6SStwANrq33FEwYN95H
 OuTT08oNuFNuLjdkjo8i5p30135/Asnh2/p74p0ZALZB+PjEh+gGuCjkQxJTmyaE5rtM
 ePeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790961339; x=1791566139;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zbsnwXTq0OoV45hgow4KHvYsJLjC6m32dKDmrYd1IQA=;
 b=rmEA4LIAAGWBySgRbSxmaawIZqGdGYSLq5XhUSVii0+fRFXva+iHFWQb26OESuIkMn
 3kcKDgpt9k4Ck9XEylYUotE7MSkg1t2k0iz7If06vO30Q1qln2ZQfDiX60Nn/gOATBGN
 QygK8H4UT8j9EzfE2czG0inLjoWVufXx58rcG3vZQGnww+9v+FFZVqCOMftZh+qdtibp
 wlKEpVfWoz7YTy29YkG0fDg1+E86evzcyfFa2DYQulioWlpbUrm4mXIh2mCZhzZ7MmNJ
 wBiZ3DbOwJ28/Y8nBrPbkeq9k+zSPLbIeUBRCOvXY0iLhK+9vt+2PAubCyN5B6WrrpHh
 uemw==
X-Forwarded-Encrypted: i=1;
 AKwUvByTsmGWdLk8bm3L/BYqIBByIz2+S9rxIbIeJLp0I7TL+umrFNzr8TVPnbrHffEHYGjzo0VxUhvVWnM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJzykIci/0XOohG68dikGuy2MqW5rhgw7iIkgc1Nw+Q3K3OZLpM
 e4zvinR9LmT90i6BojRBvqzdbsHHJS2Wraw5jf/ksEBLaqwLYmfrV9CcgzLdFuNXDF+KBnfwq97
 D85IaNWyX+pfgTdDE9RdeqedkQj6PULVL+9eBOKlsk41t2GThyzVE1gaRL5Jdm8SrKms4vsk=
X-Gm-Gg: AYBFou3Gn4LtIwgqrn4+ZT3AeE+dB182puLhoLskkNyqK4zQPkq5/v2khApK80FNduD
 ZTyHBvtzVJwM6DDSy4g155LxgJi+3RWlOzc71hy0Z/gq4fMqI6aed+epU7BCu3S0znxokUssTKY
 OMms2ouFQSoFLp6In2j8AbEi7EiXM50ou/492+WDmAvA3qrSdZsxXYMTDyguFJxd7a0tcGDMdEk
 hFMw4quD9UiLKbPCaH82pYqPyjnTKUIxSDeyJROvQeSJGfwomC+OQuPc3cTYEX0iAZb/tw1oMjI
 RJNzUyUn2RK69/vqLaLm/Yj7esn6nyVfy+A0n+d+Ujl2FtnJSMxwx4DCVOVTAsDyBhlsqu0mJGX
 xAptb7nzW9yvQNCKM+4et+pbK0OL8U2nqf7T7i33R+dTSES8JQw==
X-Received: by 2002:a17:90a:d2cf:b0:3a4:e635:a8b8 with SMTP id
 98e67ed59e1d1-3a6cecf86aemr3187606a91.60.1790961338758; 
 Fri, 02 Oct 2026 10:15:38 -0700 (PDT)
X-Received: by 2002:a17:90a:d2cf:b0:3a4:e635:a8b8 with SMTP id
 98e67ed59e1d1-3a6cecf86aemr3187588a91.60.1790961338379; 
 Fri, 02 Oct 2026 10:15:38 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6dd1c308csm1772910a91.2.2026.10.02.10.15.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 10:15:38 -0700 (PDT)
Message-ID: <656b3e9e-4668-4369-8bde-d17bda52bd2f@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 11:15:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qaic: tolerate absent crashdump state during cleanup
To: Slavin Liu <bolin.liu@seu.edu.cn>, ogabbay@kernel.org
Cc: carl.vanderlip@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260913125201.109964-1-bolin.liu@seu.edu.cn>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260913125201.109964-1-bolin.liu@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2OCBTYWx0ZWRfX4HM28Ahutx9K
 3aN8q52QH4v+yEAGk2ujP3wHMTd3Yib5Ryq3s0QlNE7vi5XfZBpXnRdBFH7QWZGhNeuLK2Qyrjp
 Fw2hYgdu/XgKATsNm63zsr4pApGbYqw=
X-Authority-Analysis: v=2.4 cv=Ko/YSmWN c=1 sm=1 tr=0 ts=6abfe6bb cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=GiR1NQjo400kaVoCfNoA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: LiytTVODIbCTfxgTk4wi5uCdB71rNexg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2OCBTYWx0ZWRfX97FpLmWeO/NH
 75QNrV7GotkEmkVnbCMaFd6a/MbeYk3YdxUsvw9IbpXBOIUyKFta+rvK1H/RbNd3BGfsmglmsZt
 uSMdh+CFtGzipCahrwBtbqmb7/sULQSHi2+7JIbf6gZsMuewWuZ/wHtokniR73+axvSPbwYPTZW
 FtHLemBSNcjQdOPJBfyqoJ9U/ZQLOISqD6dYDAC5WUVb/B6zR/3iOU/mMqkXxoiKwvvob2kXnd+
 pXX7Ok0BoDHCFU18rH+F99/8WKS7k3RutWoTnuJ0jMp9UvImcODnymUAgS1pKnSDZI+fmfaqO7Z
 T4ur47Zo7GsNY4JBliaRJDMbwon8fYyhZBpIQcocZHarOrbpPdcbaoP/yWqWRUv0UIsMF9KwId1
 EBFsgyqT8uccwTabe9v3loCNRmlipE+EvTQWDtTBpVf1jQ/2TvXXtW6tN0U0IX2ST7ebjySxwrT
 qdij+lvnUA37+R4s2dQ==
X-Proofpoint-GUID: LiytTVODIbCTfxgTk4wi5uCdB71rNexg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020068
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

On 9/13/2026 6:52 AM, Slavin Liu wrote:
> A negative response can be sent before crashdump state is assigned.
> If queuing that response fails, cleanup receives NULL. Treat that as
> no owned crashdump resources instead of dereferencing it.

Please describe the exact sequence of functions which triggers this 
scenario.  I don't see it.

The change clearly protects against the ssr_crash parameter being NULL, 
but that doesn't occur in relation to queuing responses.

> Detected by static analysis and reviewed with AI-assisted source auditing.
> 
> Fixes: 6bc1fe6c748c ("accel/qaic: Collect crashdump from SSR channel")
> Assisted-by: LLM
> Signed-off-by: Slavin Liu <bolin.liu@seu.edu.cn>
> ---
>   drivers/accel/qaic/qaic_ssr.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/qaic/qaic_ssr.c b/drivers/accel/qaic/qaic_ssr.c
> index a98928654959..d9ba1d333cdb 100644
> --- a/drivers/accel/qaic/qaic_ssr.c
> +++ b/drivers/accel/qaic/qaic_ssr.c
> @@ -194,7 +194,11 @@ struct dump_file_meta {
>   
>   static void free_ssr_dump_info(struct ssr_crashdump *ssr_crash)
>   {
> -	struct ssr_dump_info *dump_info = ssr_crash->dump_info;
> +	struct ssr_dump_info *dump_info;
> +
> +	if (!ssr_crash)
> +		return;
> +	dump_info = ssr_crash->dump_info;
>   
>   	ssr_crash->dump_info = NULL;
>   	if (!dump_info)

