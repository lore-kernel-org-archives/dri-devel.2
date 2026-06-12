Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B63CD98C7
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 00:44:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52AA110E8DC;
	Fri, 12 Jun 2026 00:44:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="j2I0MUH6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MoEeRW/L";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83C9A10E8DC
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 00:44:49 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BMT1J61912595
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 00:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=R0LBBiuMgyGLR9JG6+0kFaVb
 NWMsmymTjQMdc9kPM6M=; b=j2I0MUH6sVMR8aZ6CWRRzTbdYXCS9Tu6wX4fZzOK
 LyDuPjJpcjKZFXyzgsbUDCtBtBQ5zOzN0qr+foZJU+7d9vpCt1NWL9ndS6LdIUPN
 CSg39rqU+eEzUn0t5UM7sNd4JCXkz8BvuwBWHxvpxaA5+imISLB7SLxUNi8dfV++
 aRQrSt6Q75pkLpHkrIpPqXOlpbYl8m9bLjLt/37DOGC10CwQOcGvhtuw3Jkh3LTm
 jpNAABL3W3pzhbeg8KOJf2C7KtjQOv33wJ9QdSG9gdtSErzFY+t4gRDq0zQPcYmh
 sFShYybSsitpJB9cs95k/dgiko3Ta/aCffCqAypKQ4c24A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er0x7hpa2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 00:44:48 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5177bddf6e0so10021821cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 17:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781225088; x=1781829888;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R0LBBiuMgyGLR9JG6+0kFaVbNWMsmymTjQMdc9kPM6M=;
 b=MoEeRW/Lthck/iyPuj5FYbqLFo2ltWNpvnjc154suEypN8z8LrEzzfv+c+Yifo7Vp/
 SwbawD/90wPVdeLWLLXar9rQ/RTofS5WATMXTAl/NGFJJak9YwZqcIYJIZ9/V5T/TB4g
 NxPBkQkfYuiPdwXL+tbKk8pMvjNeKtSNBqmwAlHVxfXNcB5qZeRsJ5Vv16v0/ijKQomz
 HdGeeGNRNhADuTYK4SASloXnxH64F2N9yWMMuNjvZEi8cTxHl3ff5pj+FbfJ5P7JDHcJ
 zBlyl8MAFVWu7+Ii7V7fqKALzpYH8X+Mi+2ZS8wMzfem8mzcyzrsD2wXAqk7ybLMDoAD
 V/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781225088; x=1781829888;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R0LBBiuMgyGLR9JG6+0kFaVbNWMsmymTjQMdc9kPM6M=;
 b=rSpQ+kW8/XlXkncY9P+CfhLs/vILqnLBsxP9Mvqe87bTYjJrPyawQqSLpCwV9rCmBz
 cXx+5aOkOKWA1hI8o/6UzhVH0XKxlgOHh1ogTxWtRQwWTna6bHg2rqlWrhdpQGzmowgi
 wvQjHmcff2d7SoDaDmbOpXUN4K92Sj4hnE5PolAO09PLb10JfrDVPt5X1YIfsPAE3T36
 TrDuvJZGA/79x9qwQBXsi3Dp4sbTOUX+CC16F21D1axSOdjXDLruxRFm6OQFBJcVS+Fr
 MG2nMS1FmW9jvhDnpWSr/4KCFUmYCg5HTO+WgyhoYtSLRv+TeDjdLgwI0rtJrb0oSHkw
 jNAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9DCDrGIlWpMT9Vi7DZNf37JBQYH2oPHSMbTxynYhb6p3lZVKnza1i0PHuDk5DxJsRN/Yt/IxQ0GGI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy/VgNeedWrFtXo4Zn2DNmjBUeOce0H2zNQg7K2GUM9TY0AG5B5
 PidT58JNvC5BWmvhfum2vMC8SvZsTaXtjYEEz8hvHMhghh9Fsjq+XznNmWUozS52jBVBiYCReup
 Q48l2teIU/NOIxNz9RZ3EfveuSRdRXGyyWQmBzAuhPXocFP7bNCizbPN7dM9S24J1UCfBcwk=
X-Gm-Gg: Acq92OHx+G/lDNVuPBqWpMrlCZukdB6MRIkvUsMWe0nagku1rGSFExMGkv59dM2pGY7
 I8fLHmzd9Y2bWKhVzK/X/1XRr1R59VIyA5jJWbY1G6p9sDCQN2TGxDiwUhvUjkoJnBG9D7SiaH3
 fu8KZtaufzicqP9yvykZIG6M/XAT8TveO3Q8lnqTSY5rc2Ry+lGZXzDnw6vMbn/M9Pb714LsEFu
 P8Lxj9f9Qx/kD7ozEC3JPOkFF6NXlDTtEKOrwK3zSqjPZr7WDDHAKaUeuWn7/hzlZQ6L7qoqCZm
 72gqdUy8y1jG7GeBEErIn1XhiQMcVf6G1SVtWCBnwcC7+gbQqx+Qfoiwn7U+Sx0ov84cMblRGRz
 +/IYLWh+2/87xSE/U7jCICz23CZArIm4af22mLAfs3ydzzYq+KM6IHZWdEQoLxUfwt9CZxGzCce
 6defi9sZ7t2ZFG4UXUS7cQZHo9pTHQ2nQOKe0=
X-Received: by 2002:a05:622a:14c8:b0:517:63df:91a5 with SMTP id
 d75a77b69052e-517fbe61a18mr15595841cf.19.1781225087951; 
 Thu, 11 Jun 2026 17:44:47 -0700 (PDT)
X-Received: by 2002:a05:622a:14c8:b0:517:63df:91a5 with SMTP id
 d75a77b69052e-517fbe61a18mr15595611cf.19.1781225087547; 
 Thu, 11 Jun 2026 17:44:47 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e1a729fsm60822e87.54.2026.06.11.17.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 17:44:45 -0700 (PDT)
Date: Fri, 12 Jun 2026 03:44:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Eddie Lin <eddie.lin@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: fastrpc: fix memory leak in fastrpc_channel_ctx_free
Message-ID: <tiug7vw6ozzel3oed62qzogcjxo36h5vfy2d7xwlfqjecqptuv@m35i37kapu7s>
References: <20260611-fastrpc-cctx-cleanup-v1-1-28097444116c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-fastrpc-cctx-cleanup-v1-1-28097444116c@oss.qualcomm.com>
X-Proofpoint-GUID: 41bDzXCa84qReuc1pgeYdOchRYCHmSWU
X-Authority-Analysis: v=2.4 cv=c4abhx9l c=1 sm=1 tr=0 ts=6a2b5680 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=QzKQqk6toh7SdGiYyI4A:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDAwNCBTYWx0ZWRfX6OTgU70/mHGh
 u1tC9JcS7zHRyQND9stG+NiHbba02TyUnlM0H9XxIvkLVwtHAE/7E5mgoFrj6fY8sZuqu4YABPJ
 1Y1PbiZIm98k7Uam+joGsmkeDpbDE6YggHmRyl7LLMSINbLnXZXmNwXu+H2sfy6j1z7wn6Rh2bZ
 +sapm8OZ9DjQ14zBnX8+5GGGSyYsmJgt6KVVFEJ25YI+yNoOOVM9LHFrbmC+7H3G8NNKnFxcg8z
 NHjaIrofMkld7VITFXFxeBjL/HTb9isNG8yzOOa+BeSaAlBRWG41nlbpFs81rZXJCfhu3PlxGef
 JMjhL16CkZqXdLlLVS0eQdt9+VCWdBrsoDqNMrUYBJfGeGnVc4pnK45Z7wTfbIJslxML25rBkoC
 Qk85kbfybwpTcEE59CrG/8iAqDgUywreEkjfV+SnkrIvuCnzSok93WrfCcWijWIgctFSdjCziDz
 pdsr/lOr4bbiOwVf/VQ==
X-Proofpoint-ORIG-GUID: 41bDzXCa84qReuc1pgeYdOchRYCHmSWU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDAwNCBTYWx0ZWRfXwhUtx8uwJZKj
 lgPuCGgYEVvDOJoLeUHeMzXibUHJC8kVGFM+kv5qJFxzhSG2WGhvOdgITrgWBUxqe3y6mMTRWjd
 Pu4u3LqFjfS4d2txbrjqRfqnFaFAIjY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120004
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

On Thu, Jun 11, 2026 at 02:21:44AM -0700, Eddie Lin wrote:
> The 'ctx_idr' is initialized but never destroyed when
> the channel context is freed, leading to a memory leak.
> Add idr_destroy() to properly clean up the IDR resources.
> 
> Signed-off-by: Eddie Lin <eddie.lin@oss.qualcomm.com>

Missing Fixes and cc:stable.

> ---
> This patch series fixes a memory leak in the FastRPC driver.

It's a single patch, there is no series.

> The channel context's IDR was not being destroyed during cleanup.

Duplicate info.

> ---
>  drivers/misc/fastrpc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index a9b2ae44c06f..7727850e9240 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -492,6 +492,7 @@ static void fastrpc_channel_ctx_free(struct kref *ref)
>  
>  	cctx = container_of(ref, struct fastrpc_channel_ctx, refcount);
>  
> +	idr_destroy(&cctx->ctx_idr);
>  	kfree(cctx);
>  }
>  
> 
> ---
> base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
> change-id: 20260611-fastrpc-cctx-cleanup-bfd20aa7b8a0
> 
> Best regards,
> --  
> Eddie Lin <eddie.lin@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry
