Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66FEC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:12:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C50C310F15C;
	Fri, 31 Jul 2026 06:12:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WX7ZdSDB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PzDJlmNb";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 372A510F159
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:12:11 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V69KoF3161857
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K8UxirRvbXdY+b+94Ymr+F20Oxc3hLoj+iEzXbmXsno=; b=WX7ZdSDBJ2AUzeZH
 xcW0IR1ZmEPsOlWLyRv+UyhYy+MtN4uidZ1yps+8O7vx44GauanFrBOejenSvt17
 Hq1ALDdhVOP0BTFfR3YJQ5mx0hUWhNuigbXJE8WgjT3P3EuvJE+i0bFh8eU2XLBF
 lEn6WoxGggDeDaQEvCeag2UkzQIowJbWpP4DuFe9nM6G7CTQ5Q/HOx2Yqt8TNXBP
 OPs99O/5jk4FfYCoVvpDZsuLsgZ7k4fYkSi3GGujQyQXB7WSajXnl1Yv6VMRWvIR
 2oZBOPLZYB0mEo1Sv125HuhGsLwX3ZQnsM6upjqDD63kaWrUaXaagfs1FNCaFqeB
 2q6Xxg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frp6k809m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:12:09 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-847a00bcbd0so992416b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 23:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785478329; x=1786083129;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=K8UxirRvbXdY+b+94Ymr+F20Oxc3hLoj+iEzXbmXsno=;
 b=PzDJlmNbyC0jQfrPHUbWvD9b4ZAhIFswR+eUhcYU+bf7WPDNts087L/7jJ4ElvQlgM
 lQdKlDgrD1aZqUbUD3rOSe2SdALFzFuN14bA+T/RV+JnRnA6ykotz9lwr1qJF0xV/BrB
 cG6ToC4qu0BKAAoupVHvuU28grZVSIrhZfc1WhNnsqT5mmUkQi9Hqq45M8O/xelXlI39
 bcK8h1d3/jEnHbB3sQ7ygafgmIFC1sHA/LuksUb7S2zEF4oSdEEiSb+xok5p0RmkNJ3U
 S45tHEdLrIeH0wNjG8jIR+l3tnLJeHORzYVl2Lw47Eo+um5790iMKbtX6kNCrYfh5S6B
 VsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785478329; x=1786083129;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K8UxirRvbXdY+b+94Ymr+F20Oxc3hLoj+iEzXbmXsno=;
 b=iycCEhtJcI2w9qzutJahlfj2kNeNHaT9w0ugJYuk3C40To7xAD6KCLdgNcpR6tQd0y
 msJk6vGZXvJaPMZXzISFfn+kx1fW6DPHQ94hIiMGAGilEZ7s2jh73Uvyj4wq75a+ryPu
 kTnP7VYdcAuBui3lbhytyrCQ6dsPzjnu3J6oS9bBc438/NZUzsTOFZ5oIjJzq0sSZr/b
 hnIGY7G+97lAGb91n/sFBHOdDDRLx1wkSztjfUct746VhpbVb/0xOUm3nfz6TEzJN4VG
 y13GEtukHh4N/eTyDgzuowGPjHVAw667OB47/mdfxSwJrecT4hTbi7P9DziUysfhyUQy
 +I3A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqNYuKlcNVnkFfRZ2jJgyGyXpegojIpNf6u6A/KkmGDnSvWg7Htu6L50WBPKlhu/O8+FeiXcKxHkVg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwvrD9P6P5Us54j/YH1rz8scTclp1HtR6jpk+5hww31L4eMlaao
 DxLzFOLektbClj1LxFdNPEGMhycj+MjWKO9vOrvYoH3sR/GjtVLIhDWJorPN3FBU49uJBgAAyn9
 jAG/ariQrBbx6SpeOWf+TpapifPENAs8HaK+DEr4RzPnACfTx7xnAFMYyouySyavip96Orbo=
X-Gm-Gg: AR+sD132ml9/Zg/5oIsPcu3cpO0anavp4pn7Nr/XnRZEtjIwDEE7WUEvgZCAKHYIolj
 GOxC9DO0+ubpwenY2qd3OnBsSKmjlMJadGQ9TqWSZuikfzsXLcuEXH5vdigV611v4ve5pKkyBXx
 03jXqM7RKNOEiVllYv0KBrL7lHFrZWvMlklZBh84Lx+ejjhUywqIKZga9qaErX767DoHq08I7YB
 hSOuNOxXN8sahQsfiJM4vy08VEQqtihEksVujEDeRQbEFaiyHT1JAwsO/Nla1F8hYrNR1ctyWb+
 Oqg22g3uRBIOXs6vHFaF5mZ+iTv9A1VfVqka7XIr34JP1yLp2Bh/Uh7IcFcTF4eqvj2ZiYrvKQ6
 NIJFGEtWni1WqHRpkkxCASvxAL1ixwg==
X-Received: by 2002:a05:6a00:3d09:b0:848:2f84:f429 with SMTP id
 d2e1a72fcca58-84ed718e6cdmr641353b3a.66.1785478328668; 
 Thu, 30 Jul 2026 23:12:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d09:b0:848:2f84:f429 with SMTP id
 d2e1a72fcca58-84ed718e6cdmr641320b3a.66.1785478328169; 
 Thu, 30 Jul 2026 23:12:08 -0700 (PDT)
Received: from [10.204.78.242] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ed57d96b8sm339361b3a.21.2026.07.30.23.12.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 23:12:07 -0700 (PDT)
Message-ID: <46caf817-5327-420d-945d-283ae65a511a@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 11:42:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: fastrpc: reject overflowing invoke buffer ranges
To: Yousef Alhouseen <alhouseenyousef@gmail.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260624174410.6074-1-alhouseenyousef@gmail.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260624174410.6074-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H/nrBeYi c=1 sm=1 tr=0 ts=6a6c3cb9 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=tvG3XtUmWFG8HhscTzAA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: Z8txLeLSwF_GwqSgSNr0z-3-Zgl7gkIq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA0MCBTYWx0ZWRfXyDSCc8D2B/DB
 SYVRc1ZLEywC7Dj2d5S3zPxRuudFf25zMdgUu3iysBZqZOXWr8cxnIkMQ8BN9MZg3ThdJUIhZVh
 UCbVo+k0OW46FzwWH6g6qrwa6ywRkdkqXnF2Se21nWixLxGUQc1ge+INoJoypmdHDSFDv8BLu+Q
 XqlUCRXDY9XobJZnV3D6AANv/GS0+YwoJ0F4QURqDYPO2I0vgf8upktV/G0HYdMM/9iuB/5YI9E
 ZPbGUsjugAcUyaqVI2RfLYh74+5oMNqu6+zMT/HjAVttxJ8XqVxMYSiOMUfzuvWYGbp2cx5SISi
 4B5IrrtJYMxII8SjOLTSPN19T2VoEod27EtXfCPQVeR+SfG3EwGsOHiOv4lBXDfNszaI7MHr6lq
 b21XWxYexP+vAL9/lIp2SM6vicJAs/yDuao36kxngBZs4AjEu1oIYRRyt7sLeRCUCQL/051fTVv
 9/jybjcuqXCIeBJbIAQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA0MCBTYWx0ZWRfX1K76eHK8v0vr
 vEIia33++LvPuqovfa/sn4W87nlDutqLWcrbuZit7DTJDy94l2520EWpkSWE4uAgec76rYELflN
 +g7FwGw7eY/1Kfe+fc16Lk1E23dfdsQ=
X-Proofpoint-ORIG-GUID: Z8txLeLSwF_GwqSgSNr0z-3-Zgl7gkIq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310040
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

On 24-06-2026 23:14, Yousef Alhouseen wrote:
> fastrpc_get_buff_overlaps() builds end addresses from user ranges.
> 
> A wrapped end can understate the payload size.
> 
> It can also feed bad ranges into the invoke metadata.
> 
> Reject invoke buffers whose pointer plus length overflows.
> 
Can you fix the commit message? Use flowing-paragraph instead of single
sentence paragraphs.

Also use Fixes: tag for bug fixes.
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>  drivers/misc/fastrpc.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f3a493845..ba4ade874 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of.h>
> +#include <linux/overflow.h>
>  #include <linux/platform_device.h>
>  #include <linux/sort.h>
>  #include <linux/of_platform.h>
> @@ -607,14 +608,17 @@ static int olaps_cmp(const void *a, const void *b)
>  	return st == 0 ? ed : st;
>  }
>  
> -static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
> +static int fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
>  {
>  	u64 max_end = 0;
>  	int i;
>  
>  	for (i = 0; i < ctx->nbufs; ++i) {
>  		ctx->olaps[i].start = ctx->args[i].ptr;
> -		ctx->olaps[i].end = ctx->olaps[i].start + ctx->args[i].length;
> +		if (check_add_overflow(ctx->olaps[i].start,
> +				       ctx->args[i].length,
> +				       &ctx->olaps[i].end))
> +			return -EOVERFLOW;
>  		ctx->olaps[i].raix = i;
>  	}
>  
> @@ -641,6 +645,8 @@ static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
>  			max_end = ctx->olaps[i].end;
>  		}
>  	}
> +
> +	return 0;
>  }
>  
>  static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
> @@ -675,7 +681,13 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
>  			return ERR_PTR(-ENOMEM);
>  		}
>  		ctx->args = args;
> -		fastrpc_get_buff_overlaps(ctx);
> +		ret = fastrpc_get_buff_overlaps(ctx);
> +		if (ret) {
> +			kfree(ctx->olaps);
> +			kfree(ctx->maps);
> +			kfree(ctx);
> +			return ERR_PTR(ret);
> +		}
>  	}
>  
>  	/* Released in fastrpc_context_put() */

