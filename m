Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F58AD58CC9
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 22:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF96C10E192;
	Tue, 24 Mar 2026 22:41:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QO70mq4u";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U5U8pgfU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA1CA10E126
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 22:41:08 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJDjV03984405
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 22:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=RzG1x5GNPRTNAhxIAESsHFun
 AJA/m9ukZDrYjDKozTI=; b=QO70mq4uBsb62rJM5WrLRBSkKeKDz2nN/8AzSKdW
 Ad8ZpweBd4Ltb4MrJKZ+HEc31kBNJ3oDKX4WsSJ5DPy2N+iqjzzUEvjB67QEMZ9m
 7dyP65lKX5owc9Wv5Z3k9mav29F19GpGYv0QizcYcxgxzd/DKEwudo57OAMBwDRY
 nIlINHr7o3MZypu5TC/4Ih3yWk7Cw47AZM3KA/lZiMBHrT9areUOa6s4xp2TNV7X
 ZkF0MBdhIuu3xIr9m2WvSvJbeJZPYZdy0x0Im6pUWIeIjeDVFoEzvyhT4dQ8qoy/
 LgdlnDCf8GGfLUNKAw4OeZQ/I+oOVZoKXoVdtzPVo29lsA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3p833a9d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 22:41:08 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b4fe4ff7bso17232581cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 15:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774392067; x=1774996867;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RzG1x5GNPRTNAhxIAESsHFunAJA/m9ukZDrYjDKozTI=;
 b=U5U8pgfUZite2C0ZAEzrb8F/2Qnl0dfBgMh7PrNej9bGkGItE4Mr0vubNyQJAStYHQ
 OJ3GQ7EwY9+1vGBX/TYtyEkT6OAyv27YT2cy5yYKkPd/3vNkBnJHWo7G3kGZKLMyHN7i
 DSEKJdDRSxt3lPAhNqI0qStKxKyd/HA/1KRLKfwfPK2/c7EqUSXEmQnWL+D1NoeDbc+X
 o5d12EnPj47VE8u+cY0w0jfMHMHxWuta8W6S2/2zQiHqiWN4RchrIJq1bGThycj2b8Yk
 bqqUYE6NtLtkFmoOu4LnOeB2qshL+xMgpmXW6pEKOf4pSHPAbN9R8NCRc+/X3UV1OSgu
 vmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774392067; x=1774996867;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RzG1x5GNPRTNAhxIAESsHFunAJA/m9ukZDrYjDKozTI=;
 b=W9X0AbrzqnvNmTjA9StcV7NhOiiK21iWFmRqgIkAZmdNlRbPkzI2b/9I+wCCIe5tmU
 1sjrjEJ8we7+8RHVcQVIvTkSrJybmzowTP95io9eNi4FVsWiyi+9Duua705Fg5DTyFb3
 biK3Nd2298kB8TXCSllTcGts4QHCHAi4LKKQ8UD0lcw7lpwImtE+EO3Qj3ogi8BepykC
 lmeUbHzLfDRTd4bpuJI9Q/tZXbh1mqhiazjG/GiwFxCU4U7YW3FFr6NRafyDzqOepIU/
 eN3bP5Zl/TTU6etma2E8mceQiPkyDsTLt7ntNc58m4r4+inK4ZkrZeTia8jrMTNWIRzN
 cdgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/GkbIUoUJe/LQUsfqWy7jgfyMxvcMU0DDe0rFGXxa1HGAB01MpqDCi/3OTpm6sgTFb1jCVB3H2XM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwyMdiAio4tPilDSZ/58/PQUyhMdFpLAHVCcO9wL4LbpxJXKKwt
 Acrx9lmPEGWAo4KwayB6sDurGWQ8rKyI0Ab2VRhfhp5H7P9Omwhiu0vhuYp7CZtZI1YIdlxmA4R
 Wow5ja9/aQhQckFSsFOG4WCkqxpxWrTnHZDfk3dXqOXnuN9zFhSDqRnfpHwRXfhtV324f04E=
X-Gm-Gg: ATEYQzyZ/GW06dHZ2q12MIZMsz3Upx8H4O3zx27TssgjclRLb8c0pTN+tbZHF7KOkkv
 5gVjLtVeB3VN/iFlM3mPN0eCNLMmzV9JNmmIsie2sRIbVg7XY3k4OJni/p3IPlE11Ccf9kzYfK6
 ekFeg76v7mDUe91ewTW3R1eFwOStRuCbIVFhiHwPLRc3AQ1BhEKiEkZ8c3XgvZzJhW8uysEuey6
 3Ox/pPgMXQUHA48Tly8lAFYfMSjytcDO29wFoNPnj9j+UimK67rv6sJkktXsAlNjEnW8Cc5xyFF
 jW3PLtDGIv7bq4pqxVBj+VXVqyk0uL1JJc7YFr3P2hVUoXgQY+mz3vUVKQWpS6NScJMMipIvgk/
 krAMvKWO7lQcPzuZbUDXEuJ8uzCqK+SC3FoitFDFIwCmxqvggpMps4znNzfcdMvuY7gJuKTMqTZ
 UHwhrLPLil3X9uv1ByA4pBs+c059gI7+v0SU0=
X-Received: by 2002:a05:622a:1791:b0:509:56e:1b5f with SMTP id
 d75a77b69052e-50b6ef16524mr72810411cf.40.1774392066961; 
 Tue, 24 Mar 2026 15:41:06 -0700 (PDT)
X-Received: by 2002:a05:622a:1791:b0:509:56e:1b5f with SMTP id
 d75a77b69052e-50b6ef16524mr72810041cf.40.1774392066419; 
 Tue, 24 Mar 2026 15:41:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2851add10sm3433452e87.33.2026.03.24.15.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 15:41:05 -0700 (PDT)
Date: Wed, 25 Mar 2026 00:41:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, konradybcio@kernel.org,
 thierry.escande@linaro.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] misc: fastrpc: validate overlap-derived invoke buffer
 ranges
Message-ID: <74oe23odro7ykszj2ocfgetfr5f244ep6x2mcwcad3326phvlc@5g4tpqqhnlxy>
References: <20260324014459.93364-1-pengpeng@iscas.ac.cn>
 <20260324114514.79392-1-pengpeng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324114514.79392-1-pengpeng@iscas.ac.cn>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE3NCBTYWx0ZWRfX5QVT2TlTc8Ud
 6OZWUvOVtUVQ54cjpI8XGpZQcmtz0AYHoz2GzRDjuCOMnFyb/MoGswoBOMtooMhasUbjddAYcjT
 9X1GgQ3flPXYibd++kBOM4xv8Ky5driCZDs35ROwn7jfTJ1KEfhL8Y8t3cjIdlhmQ5vMOJcaK1y
 dp18XZ1yT88J6g9z6a1gig6l/wC2MdnKAg9YvxWMvMWKA6O2wmRAqK7iUjNOhDWP9VKHvQ5Le7P
 vfVA7nJVOEuYvgDvHctepFZmuFOegcJGJxaFTYm2bmnhJ/lm9VnQUeNk7BzPA1DQpT1fYTVo7R5
 09biQ7dFCEpWkJWVsQDXko3O0x6PynGFBRcWZAO/ordmPbGvFuC5o7Ob9xepJzQyK+IkZH1TaLR
 gofDL6bxGPIBpELy0k9zOSoylkhhvUHzKvF0HNFV77k04wfeYGxh47RBW05jASXLa4nOKUW47cH
 kAN8wQvMJTtD3oYnmRA==
X-Proofpoint-ORIG-GUID: r4pHRo98ueiOSN1SDkRk3d6EawhdrZ6A
X-Authority-Analysis: v=2.4 cv=F6hat6hN c=1 sm=1 tr=0 ts=69c31304 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pMEd-TaGR0FbweYsBQUA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: r4pHRo98ueiOSN1SDkRk3d6EawhdrZ6A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240174
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

On Tue, Mar 24, 2026 at 07:45:14PM +0800, Pengpeng Hou wrote:
> fastrpc_get_args() derives rpra[i].buf.pv from the overlap offset that
> was computed from user-controlled argument pointers and lengths. The
> resulting destination pointer is later passed to copy_from_user() or
> memcpy() without checking that the overlap-adjusted range still stays
> inside the allocated invoke buffer.
> 
> Reject overlap-derived destinations that would point before the start of
> the invoke buffer or that would extend past the end of the allocated
> packet before storing rpra[i].buf.pv and before copying inline
> arguments into the buffer.
> 
> Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
> Found by static code analysis.

Please don't mix tags with the free flow text. Also please don't send
next iterations as a response to your previous email. Always start a new
thread for the new revision.

> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
> v2:
> - add the missing Signed-off-by line
> - add a Fixes tag and note that the issue was found by static code analysis
> - run checkpatch and keep the patch checkpatch-clean
> 
>  drivers/misc/fastrpc.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 47356a5d5804..7dfb5eb6dc92 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -993,6 +993,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
>  	u64 len, rlen, pkt_size;
>  	u64 pg_start, pg_end;
>  	uintptr_t args;
> +	uintptr_t buf_start, buf_end;
>  	int metalen;
>  
>  	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
> @@ -1016,6 +1017,8 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
>  	rpra = ctx->buf->virt;
>  	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
>  	pages = fastrpc_phy_page_start(list, ctx->nscalars);
> +	buf_start = (uintptr_t)ctx->buf->virt;
> +	buf_end = buf_start + pkt_size;
>  	args = (uintptr_t)ctx->buf->virt + metalen;
>  	rlen = pkt_size - metalen;
>  	ctx->rpra = rpra;
> @@ -1053,6 +1056,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
>  			pages[i].size = (pg_end - pg_start + 1) * PAGE_SIZE;
>  
>  		} else {
> +			uintptr_t dst;
>  
>  			if (ctx->olaps[oix].offset == 0) {
>  				rlen -= ALIGN(args, FASTRPC_ALIGN) - args;
> @@ -1064,7 +1068,18 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
>  			if (rlen < mlen)
>  				goto bail;
>  
> -			rpra[i].buf.pv = args - ctx->olaps[oix].offset;
> +			if (ctx->olaps[oix].offset > args - buf_start) {
> +				err = -EINVAL;
> +				goto bail;
> +			}

if (buf_start + ctx->olaps[oix].offset > args)?

This needs some more explanation anyway...

> +
> +			dst = args - ctx->olaps[oix].offset;
> +			if (len > buf_end - dst) {

Can this overflow?

> +				err = -EINVAL;
> +				goto bail;
> +			}
> +
> +			rpra[i].buf.pv = dst;
>  			pages[i].addr = ctx->buf->dma_addr -
>  					ctx->olaps[oix].offset +
>  					(pkt_size - rlen);
> -- 
> 2.50.1 (Apple Git-155)
> 

-- 
With best wishes
Dmitry
