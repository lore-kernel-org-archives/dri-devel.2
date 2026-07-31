Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED15EC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:57:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45E4810F187;
	Fri, 31 Jul 2026 06:57:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ks8/RlLZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MmN8KOwn";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BBC010F187
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:57:39 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V668HG2636759
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yeoMnG3I9e/DLxw1trT1m1DMzEITRAh6vsr1I63XEME=; b=Ks8/RlLZStJh8O9T
 tSegNnRWHOzwPt/+CXHVQsf8PTbIJ99+WEqirjvxRAytKTf+hUEjrzAnG8jrVbzO
 ynnEu3jEijDFiqOFmDM+BdtVCYujicwyCoSC6clITur2RzgIW+lR4cSakGUYpBtN
 uFHbv37Q1OJtwkDusN5LvGNKzpuooEkW+a7ULGDPITKlsQ8PD6VYMw6BXIqihlIn
 pTiBQn0p2WWzkPN4OpCO1zaJVi4EJcPYBipI1z5+sCglrA4pvf8ldERqsAX62jrD
 036LrJ3whTyrhEuofOWOhwctfCVGJ1UfkE+Tc3LICsmMlDcxxB6mwAwxcdIk5Yxz
 fWanPw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frp4y05vw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:57:39 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cab048cdb3eso861918a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 23:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785481058; x=1786085858;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yeoMnG3I9e/DLxw1trT1m1DMzEITRAh6vsr1I63XEME=;
 b=MmN8KOwnraHYNuVvgHPCAztooJykdBbKAb7mAN2zY3+ozPGjiuTnC8cBBuxznlGlGY
 A0AxD67vKYlNkNQXf5DCIC9LaqEUh/JxkLGgJUgZKWDrlMlmDfHTa8uhdwA+0bVvN9lL
 Sfc6+oKmjKnDj6U97Gh5N6Knd7KNA4LvKiLUL3lF1solXyomWsy+vdOn86HLn3EyBDql
 U11qQTw+OgaYvvlrAaI6mYmz7w1YXqpi2FvWtI3Eij8JiZVO5w1QJ0CtWegAJ7IVgJP1
 d/iBeJBsr9cBBujimN5kTVAX6/Za5twaUuuuiDrzSPIFNZwofKBHQMbY+tEa0TRxClt8
 wpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785481058; x=1786085858;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yeoMnG3I9e/DLxw1trT1m1DMzEITRAh6vsr1I63XEME=;
 b=basynOlNFcQNXbrrA64P4nNRCt3SPdeArpZml9dCXPLIqEoZF5REVuXeeypvs2VK7z
 sFyeW++CnLLmS0zj6R24NJtL33azKwDlppJVS1LH70BXgllSt/wyPGYZkaqiE4GGEE0Y
 hs4doC+zqVlr6H1jHa2tLpC95BX3UKz5kuUO7DFG+YIpGelshGC+R2gLDh0jCRS6AZBD
 s4Ylt00VqyrwQiwunOtoek3jeLWD0K1KYjiwqz8AxyMPzzYKdynqK9UjZdU1LldIxpqV
 /PDA3d6NTClN4ruMvqJVSaL5jbsUTiDhGznM6ZajarAjqdpzDIeDJG4P0qTJhPXQfAN3
 y6HQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpompch6TIkeF90K5aWYn1WLTfDIee6GdTQ25YlfOOuBMhxCoR/eXLVAWtK9jZsQXlIfugLgsGl+xM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgH2Nl7DBEi3jH82N1RoSS4ZOzz9UPIuB4VmKpoBQiwZNh9V/g
 ClPSZeLMkqYK0mWzIweYWb4patvMOh/u0Vf2RZduWnEsm3sIuqrf5KMyJ03CayhoBnPkanlvIdp
 4CnDzGzvyYzhoxS7ggt6njM5Wfv1pvbGqawT45xzQswlmjx77Cq4z0AruLFrJypVdQo05GZU=
X-Gm-Gg: AR+sD139GJO6UlkCS+RXksvqoFGI6nGe79h7ftycwpSvEY++YQVQ3/95ulgzbb+6SY5
 +X43iiKpjYx5X3T0de2Vok2f9uCQ0sj2Hl7feBn2IkN+eUi2fg5fpPRto2t4gxGiK0lVC3NGElR
 FOKsQrIho+8ZwyeK4dp1HlplkIBR3Sh/fq9T7ll8ijwBo0+H3BrmVpYECQBRDWVqYgvDMlst51w
 lG3hB5jh+8GVBNpJntqaNfimB2ZD1fswEiik0zswNuejMVtYqjaolA8ncqJDPZI4OYU4rO4+gnD
 FfFF1QDNegpB6KV3oI40x83WAOqDEnOH4IMQ7SN270PYIgREPmGk34PXTKpqqPxeO1xFHrJch1l
 hqjzGQNBjqyRkTI7P8gte/uTrj59qSA==
X-Received: by 2002:a05:6a00:b8b:b0:848:57f3:8f8f with SMTP id
 d2e1a72fcca58-84ed71df47cmr706020b3a.51.1785481058359; 
 Thu, 30 Jul 2026 23:57:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:b8b:b0:848:57f3:8f8f with SMTP id
 d2e1a72fcca58-84ed71df47cmr706014b3a.51.1785481057758; 
 Thu, 30 Jul 2026 23:57:37 -0700 (PDT)
Received: from [10.204.78.242] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84edbd35a76sm43031b3a.6.2026.07.30.23.57.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 23:57:37 -0700 (PDT)
Message-ID: <7150bcc5-c378-4b18-85df-cf9ae705f7e7@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 12:27:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: fastrpc: initialize invoke refcount before publish
To: Yousef Alhouseen <alhouseenyousef@gmail.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260624185427.1451-1-alhouseenyousef@gmail.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260624185427.1451-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=K44S2SWI c=1 sm=1 tr=0 ts=6a6c4763 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=WQc7OmQVWAu9uTwc-zgA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: GQLGbvTashtanlPiQFXtJ1562KWJgpWt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA0NyBTYWx0ZWRfX5cw6LKyJMlTl
 gRY0r7l/hDxatJv1qJDiYzsjBLCueZ4uIVuYNZHV0jovX8kj0yLk2p/mCVg/U/Ya54VyPN2fEVW
 UUMg8SIRDeRkMVdfoDwHP1Fi2hkF0+Y=
X-Proofpoint-GUID: GQLGbvTashtanlPiQFXtJ1562KWJgpWt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA0NyBTYWx0ZWRfX8kTa3bRkoDxD
 sjz5aWEMTKeXwFKxOG9Z3ElumYLbwjNaq1Jbo0Ju+qdUNV2fC4Kkk35l1/Q6w3k86g2rzkJuCDX
 fW3Dy9Ma8Iaq3VD75rK5RrKL8rpuJPUrDz1xUEqend6O3YbdYtx9AZjj+C7nNtReAHkgaH7qltT
 ZSCU++Pk6RriBPMA+PFgxpZHZF5helRo5EDgTKuBejlk/R9DyN1IaDoGoE8nDVNnCLH02NXMnbR
 XMveVZICz6oIN0pCYgFXb3+RMlxLGABmOVL9DFbN4HJY1ZFTtS7WeUMKHI2RvNJ4sY0j948GL3w
 OGbxjjWSAPfKyK9ErEy7wydEQzh9D/pNfE+oUSvkOj4siBE4cgU1/e3OGCxf98tW1uqi5P57OyB
 1F/A5c7+gbaHI3oCn7BwDLWFzQQRTTcBl2kfoQH4UOAyMlbxpgce6Yq/yTbB6+AHr75Q6JeoSc7
 a/obiHvGbghfSXuioOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310047
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

On 25-06-2026 00:24, Yousef Alhouseen wrote:
> fastrpc_context_alloc() adds a new invoke context to the pending list
> and the channel IDR before initializing its refcount.
> 
> A racing DSP response can find that context by ID and drop a reference
> before kref_init() has run. Initialize the refcount before publishing the
> context.
> 
Please add Fixes: tag to this.

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>  drivers/misc/fastrpc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 6ced210ca..42fc128e1 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -703,6 +703,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
>  	ctx->cctx = cctx;
>  	init_completion(&ctx->work);
>  	INIT_WORK(&ctx->put_work, fastrpc_context_put_wq);
> +	kref_init(&ctx->refcount);
>  
>  	spin_lock(&user->lock);
>  	list_add_tail(&ctx->node, &user->pending);
> @@ -718,8 +719,6 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
>  	ctx->ctxid = ret << 4;
>  	spin_unlock_irqrestore(&cctx->lock, flags);
>  
> -	kref_init(&ctx->refcount);
> -
>  	return ctx;
>  err_idr:
>  	spin_lock(&user->lock);

