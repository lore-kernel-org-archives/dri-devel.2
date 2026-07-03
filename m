Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F292C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 05:16:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDFD610E565;
	Fri,  3 Jul 2026 05:16:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JTDdPWCd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A9t38s2M";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BF6310E565
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 05:16:15 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66342bBT2654815
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 05:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7je18tu2quK+pqEUyIaDqokYfNsUVcOnejDyULff2vw=; b=JTDdPWCdAlBz8IDX
 6m3WlsRH+k11kXRRGIpBZtFmZAg54oxhxU65SplmVRd+9Ghbhx/9yaffw4DHTi5q
 pP1IKBlJ4oRdJ4l6AjkE7NtvdO04YsqwGcKTFA+YTMCBr6cORDZSa+VD6BhPe1Pv
 nz8qohOa+tmnJ8oupVyudx988edq/bprvsZK+qe/BiNKrEZYHBzmOyxbEvL2yyGO
 hQzpWm7NGk/LlvXWKrT3ldr16mX6xpgxZHEwDiSmVQNgqu8jLuEq2ZpUFgr+NRXA
 /g1ow6OqsnEWH6YqoaA5iautPNJYnfMCseibZVCR9fSNZ3kjY34eESPYAEKZ/vWf
 sG2B/A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5nprc8pa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 05:16:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c9d8549d55so1696255ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 22:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783055774; x=1783660574;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7je18tu2quK+pqEUyIaDqokYfNsUVcOnejDyULff2vw=;
 b=A9t38s2MtlGjpvYE/SSXzPXI8gbTtzwZzRaKPtSHfKWKvoVhik3sTgk6GptCXc+rVg
 HKVNeAVjxKOUxxX8ZwfDHQ9SnrdWW/53Wnee3OEnPkDp75N67psSh+WQnNUBqB8Bwif1
 a2b4kwlw4wsPV9W7yo3DBH8sEgqyitk/KYOPZPbJuEHouxz/uzZ1AyaeNVpfvxAt4JiP
 hIcchiAsOwEOk1yRyueEvbzERCbw1ohB+x0Fr4t/YZA4FosG/JSuPe3PD2wgSoXZIN02
 OmZFfoKKiLVVWRBXcTaU0W8wpVQjQvdDmk1P8KnXbZBUAMfXPPJJPLDRbdAzTp4v5eKV
 /wtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783055774; x=1783660574;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7je18tu2quK+pqEUyIaDqokYfNsUVcOnejDyULff2vw=;
 b=ORGLcLGk5iVLjMDuiRMR1uRTiKU1yxxj6NehVO/n4hlJcZRmJplYcVv//b5Z74APC6
 Rl1j5AP9najAvkfvmGZASIh5wAb08/Gvvbo73gLOSocvF9Zidath9APZYxBRg0DYK+XE
 D/NPXj5dEl165V+x4fT6HGfEv11RM4e0WdMVoqUPUd7wn+/e+6ptWrK65BqNoaaNWNIN
 aeGSPNUJ4pQHgn8ktTiRkG/Aul9Yi5MGrKB2VqM+Bj6SH9pZmEco0/sqk8fnb2oAurL+
 Y8y2tNYOaWFFhF0oTrqMxI1S9edSuM+gY0C9DYXVRPypNsf8c7q+ZYWTDOVo8+FUy9cA
 ruCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GhDAOUqYL9DsOwaCJi54D21aPwv6ZlIAuzyN6F2mbaexmgYi2wk0EfV7+vH9snTtFehmoc2v/rBM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwJ1CJRVEH+xt133L88V0fGFijfD3WK/Hj5Uuh9WZ4dz10YjKe4
 kDgNMeyHywYWSbkG+3jPA//Apmts0yZx33q4uwTwemKCc036wQhX9rMGu2pHVDH8NZur8zFFBqg
 QFVEzsF5GNvBEoq1QTR1tQfKXo0sZhia3gH7oLx8sVkK3D30FoZcEIrP6QBjmXGnSns6MUzU=
X-Gm-Gg: AfdE7clgJAvT/xntK7GYIfMXeAsdeDpaOQLxMJJEiAyHc1bv4uGHjZNHJ8yEYmIqUSZ
 qCzclVYMWo24U99dlNdOwFprnN1yLD2NPgSxK6397yzSiykqDtw5PmlICANP3qEIERKopR2xlSt
 NKQJUg8nnpAr7OQBrs5vdu314y0tPSTu9WVpXNYVCFOxCeev2wEx2oZE6yfJtVmDJFXU/ckRZVu
 9yK9j+axQpEyBduXZl1STJ6yuFnHauYBz8S9mAn6jBZQyWooItvVzUEsoIDVIwNtoYTzfIJBOXq
 0YrW3csOnrsgnNLFnIJGomnZ1u0nojCoNNns9JEV1TWjGRXG/1vcCeuvRBzBmZHPzgulTkrCmhw
 iAfbbB/cTcy2c2CzwzmdUo8Ej2Unpl+hldRMoMm4r
X-Received: by 2002:a05:6a21:7314:b0:3b3:fc6:6226 with SMTP id
 adf61e73a8af0-3bfed237936mr11551296637.24.1783055773721; 
 Thu, 02 Jul 2026 22:16:13 -0700 (PDT)
X-Received: by 2002:a05:6a21:7314:b0:3b3:fc6:6226 with SMTP id
 adf61e73a8af0-3bfed237936mr11551263637.24.1783055773170; 
 Thu, 02 Jul 2026 22:16:13 -0700 (PDT)
Received: from [10.204.78.220] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0b813d37sm16467977eec.10.2026.07.02.22.16.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 22:16:12 -0700 (PDT)
Message-ID: <b907b6bd-ea6e-46fa-9546-b8b62e12bded@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 10:46:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] misc: fastrpc: avoid duplicate DMA mappings in
 fastrpc_create_maps()
To: Jianping Li <jianping.li@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Ling Xu <quic_lxu5@quicinc.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, stable@kernel.org
References: <20260625080832.17477-1-jianping.li@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260625080832.17477-1-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XmDqN4MpsRdzSeapEytLMHlMEFTFAE6l
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA0NiBTYWx0ZWRfX+ih72QyxQjya
 /ts1wwps/Z+ItECLUrpmot3acabieCpcDqqM2UbrF8ckzRdi5Oadz3fe8kLtwkkOamC33Kdz9xA
 yWTx5gZ4ITSuCwWH3fW1u8kj9Ai3/4s=
X-Authority-Analysis: v=2.4 cv=NsvhtcdJ c=1 sm=1 tr=0 ts=6a47459e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ywQd6nkPfMLC1FByFVQA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: XmDqN4MpsRdzSeapEytLMHlMEFTFAE6l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA0NiBTYWx0ZWRfX5RIaje+dRvkd
 zC9Usk/ryGH09LWp0K7d72k+i2ktFvdn93tmLmDJRRoWk2PqCclGtcpLME7INOezv6ET32e6VR2
 h91TsJqebUCoYoUvyzILHwE/hAF5DZNYq5vtZ7G1pSyjZUp37on8TmejSXQHQ6XhZ8NbO/dMUHD
 g3XTZtVe+4pMk/szdCtZrNvP9zyYvKViomqodPDC9C+wSei78/VtO2O7MrGNOeYjvMO2/K/2etr
 lAPEGIN3m5pvM+EbYgdQVmp/uPrPUwv0c4AAKKi/15f67dMNRDBZI7m4KLWNAWocv62FmW0uI/T
 ud8frSJeWelPCyMm0Y1OwyrNFYNLAIvXU8m1PlC+rrkFQK4dCPwVaSPnonXETjDukv0b7CZ9u27
 FkbFxcCOKMTLVj2KDFZoY1WD2BgoEg9y6JSVB+cpn8Q5M8ow/QOUG/SORxowoC8xcpg+/+DJuRm
 BX+zp0lIzFNnzN5GJLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030046
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

On 25-06-2026 13:38, Jianping Li wrote:
> fastrpc_create_maps() performs map lookup only for buffer
> arguments (i < ctx->nbufs) via fastrpc_map_create(). For
> arguments beyond this range, no lookup is performed, which
> can result in duplicate DMA mappings for the same file
> descriptor.
> 
> Additionally, if the same file descriptor is passed multiple
> times within a single invocation, performing lookups with
> reference counting would increment the reference multiple
> times, while fastrpc_put_args() would release it only once,
> leading to an imbalanced reference count.
> 
> Fix this by allowing fastrpc_map_create() to control whether
> the lookup should take a reference. For arguments beyond
> ctx->nbufs, the lookup is performed without taking a
> reference, ensuring that existing mappings are reused
> without introducing duplicate DMA mappings or reference
> count imbalance.
> 
> Fixes: 10df039834f84 ("misc: fastrpc: Skip reference for DMA handles")
> Cc: stable@kernel.org
> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index a9b2ae44c06f..2622a1360a65 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -924,9 +924,9 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
>  }
>  
>  static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
> -			      u64 len, u32 attr, struct fastrpc_map **ppmap)
> +			      u64 len, u32 attr, struct fastrpc_map **ppmap, bool take_ref)
>  {
> -	if (!fastrpc_map_lookup(fl, fd, ppmap, true))
> +	if (!fastrpc_map_lookup(fl, fd, ppmap, take_ref))
>  		return 0;
>  
>  	return fastrpc_map_attach(fl, fd, len, attr, ppmap);
> @@ -999,23 +999,23 @@ static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)
>  	int i, err;
>  
>  	for (i = 0; i < ctx->nscalars; ++i) {
> +		bool take_ref = true;
bool take_ref = i < ctx->nbufs, also add a comment stating why reference
should be skipped for DMA handles.>
>  		if (ctx->args[i].fd == 0 || ctx->args[i].fd == -1 ||
>  		    ctx->args[i].length == 0)
>  			continue;
>  
> -		if (i < ctx->nbufs)
> -			err = fastrpc_map_create(ctx->fl, ctx->args[i].fd,
> -				 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
> -		else
> -			err = fastrpc_map_attach(ctx->fl, ctx->args[i].fd,
> -				 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
> +		if (i >= ctx->nbufs)
> +			take_ref = false;
> +
> +		err = fastrpc_map_create(ctx->fl, ctx->args[i].fd, ctx->args[i].length,
> +			 ctx->args[i].attr, &ctx->maps[i], take_ref);
>  		if (err) {
>  			dev_err(dev, "Error Creating map %d\n", err);
>  			return -EINVAL;
>  		}
> -
>  	}
> +
>  	return 0;
>  }
>  
> @@ -1508,7 +1508,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
>  	fl->pd = USER_PD;
>  
>  	if (init.filelen && init.filefd) {
> -		err = fastrpc_map_create(fl, init.filefd, init.filelen, 0, &map);
> +		err = fastrpc_map_create(fl, init.filefd, init.filelen, 0, &map, true);
>  		if (err)
>  			goto err;
>  	}
> @@ -2100,7 +2100,7 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
>  		return -EFAULT;
>  
>  	/* create SMMU mapping */
> -	err = fastrpc_map_create(fl, req.fd, req.length, 0, &map);
> +	err = fastrpc_map_create(fl, req.fd, req.length, 0, &map, true);
>  	if (err) {
>  		dev_err(dev, "failed to map buffer, fd = %d\n", req.fd);
>  		return err;

