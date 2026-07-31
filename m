Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7551EC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:17:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C258710E1DF;
	Fri, 31 Jul 2026 06:17:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fN8+Ynir";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bj3YQJBq";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A98410E1DF
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:17:14 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V60MdC3131200
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4l7IylTrV7+WbYAv8Zw4WOy+wYaL2MEqhPzc8HHXHYo=; b=fN8+YnirddVyk8ia
 LNPVlcHbu0O+QKDLTJfH27a02oyP3nNCB93T78kdkWmTTY7C2Pbz5T7rcUPRz0NV
 gewceT3tsodaGxuWCbnzd1eBUZi718ip9jFPDt/ObNTRZHW2qbylN0IUl9BX89ZL
 J3X4+wMvH8a9ozFAGVbfl/H4JuogdzT02IaFOr6JJa2YpgKWO6eamHTdDmH/Synx
 GYVj7lvyMJWkToW3wtvvos92Vg6NZQN3zG8z+cVANAUsmhW4xznMJRpDYv3kVkEK
 gDlzApDxnaUuBviq6Gu0YqsB64bveF0iIBs8ziplS83LNcGWpb5cadiIOV8Rkc9a
 SAE72Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frp2ar21u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:17:12 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d001671a54so12901205ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 23:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785478632; x=1786083432;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4l7IylTrV7+WbYAv8Zw4WOy+wYaL2MEqhPzc8HHXHYo=;
 b=Bj3YQJBqoCmVyPAmoDZpsV6ZuI/C8iiA3jhKlLK8hBUxVHRWVVg8znjPeGU8YpHO5p
 3hVswOlVExVTny7DtIYQ6yDK6TXDm2lAKeJ+8ncDG8DJ6fTJyUiEN9Q2BQ+Cxzl2x52t
 uW5+rsxO2cgxJFSalXZv/AgNfBuvuG6U8gCBam0DdaljqPK9Vfzc1mo0o9jjUHsEu/wh
 ReVKgXRnBBwhHAfNZE4vQtRHDUEU5wQGTMiBUuafUcJiAmcAJ82uSsoH6a5A4+WXFVH7
 tMSqBszWJIymXAEQstQ/7ulWqGKduL2b1drXwNpZ08E0D/VdSavZDK6wH9pyZpRICJAc
 nbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785478632; x=1786083432;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4l7IylTrV7+WbYAv8Zw4WOy+wYaL2MEqhPzc8HHXHYo=;
 b=VpWhAR2HLIqA8AnUYHTAHEd7HlGCbvxjxkFveuDSiLU6BIAATancp9l7mr48hllq4I
 LHvQeIPEgyurgxz9z6JKJd55VSRcAd8/I91uuBA5ooYqNhZ+9lc3hVeBy3PzmeC9cu2c
 TMGMmd6vYA+tZrourMzhOqaKONlFnfF7zh07o5pF+aNrh5p/wES3UC75BSIgAJJJaAwa
 Zn0PZBRJLGJmXQfhbA4k/Ue/ztGhIUAJDubnAlNjda5Mo6Lfg6VhxoGxYp6uwmBxSQnP
 4axfl2KVvUeXBeM7uWN+0t82AS3sSYljm7pF7N1i7sSULCEjNwpfITPX9wqewvUk3O2d
 cWzg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoQqg0zPqq1shlikia+X5cVB+dO6e23zoKGggmm6PZQeSUabfz8/Ttn1CMsJF2GGQxPzB0FRunKBmA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7UsxVl7FcpxCpkwSdSyn5Cv0JZEbIOBLUyTXjnkgONICyI52L
 pjt907paT1tjGrgYNO+USkz0MHhsm+bM5AdeM+v17j577/8PxU6RdmGGLnVLdbzvFr2/fY2W5li
 iUyApO/L0iasWXvgu/PxdhwvUhvp4jH8q5Wv+UcerxqTxida7UI3GHIilSr/HOTnxadPFvwY=
X-Gm-Gg: AR+sD11FqGcQpfVDA/zmcOY/UcVgAN2Ni9MQz4pG3Y5rKXI3OSgz1Y3qp96SOmZzjyN
 e0aOac9IQAybGrx+qmsyAUkkIWE7Iy5dCDAwLOuFfEWxUXTYIeQhFydlLvgXU+2pPXUp2g8p+4R
 szmz7UBEmi1N4T94aNdJus7MrQ2WgG6ExMQ2AHMETpZH6Cg1JTN+bIDvV8iI7nLhnsTkT3TZKYb
 4L5jmnYTbvRRYABQB7OfblxN9lX6H27WLJoqbrLWct1X7ThKJcCNAMC1c9j9abEKKSSr7BWEGyc
 xSr31KNk4nPFK8UE5X+d54rtirUTxmkxrMBxepMWxz/5jwtAO7ZRk2oBLym4XFtMu6JT65iwWHu
 5Ovouu/NKJcfYaguLBYdj2k96FXo9ag==
X-Received: by 2002:a17:903:4b50:b0:2c8:2808:3ec4 with SMTP id
 d9443c01a7336-2d046e7c719mr8401425ad.24.1785478631579; 
 Thu, 30 Jul 2026 23:17:11 -0700 (PDT)
X-Received: by 2002:a17:903:4b50:b0:2c8:2808:3ec4 with SMTP id
 d9443c01a7336-2d046e7c719mr8401225ad.24.1785478631128; 
 Thu, 30 Jul 2026 23:17:11 -0700 (PDT)
Received: from [10.204.78.242] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04b0eb486sm799165ad.53.2026.07.30.23.17.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 23:17:10 -0700 (PDT)
Message-ID: <d6bce7e5-5077-40a2-89fa-d1add3144d84@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 11:47:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: fastrpc: remove mmap entry before remote unmap
To: Yousef Alhouseen <alhouseenyousef@gmail.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260624174652.6792-1-alhouseenyousef@gmail.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260624174652.6792-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA0MiBTYWx0ZWRfX4nSlD9IVMKEH
 fmP+oH30o5afCH1vXroQpxAb8ozWPHleUTOcDo3/cDTnuIAsCbmSgJu0SPW0uFbqu7Otn527TAc
 zLzDSPZb2Wk/FJaCkzHmAPLU3NgsWBgTjq3niMcTQ3pSOQuD2ZClzgFKkScsJqauTllc2Nxa8+7
 Ccn7QYdEtDkY3fVuio/Y7qHgykXxw05SIcj50cMjpVR/fp4I3crIn64wAmeT7zdqZilUJjV05zq
 sriGvkJFCOGgkXNdaTAY7ZKfz+w0dzxlSGOoBd4xw627XBxc1W0Q1tSQgqkjs36u7jvKlSlosiL
 lcJzu7sUVgqmKxlw6MXKpLBibPlSb0Z9peJMgVZXawNrrF3f9gNZztOA0TAPYL+fRp0tcegcy/q
 HIZaW+aeIoaj52SM5bowOA6+6VwlpB4m7LumDY06UXWVq2dD/I5WgPz0bYyQijz708XhA9B+CWk
 MH4Qqg8or2BXu8U1dHw==
X-Authority-Analysis: v=2.4 cv=RYOgzVtv c=1 sm=1 tr=0 ts=6a6c3de8 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=kqHp1m7fC-4U1ryjZVsA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: ZnCZuijDi7xwhZt10sF8Q08t4ibtYmnw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA0MiBTYWx0ZWRfX+frU0eQyrRYG
 uKU0xzQQknzhckz2D7sC3an7wrmrsAJ07lGyuBYX/dQl32SkKTUyDmIUSNhfah8hWtZh/fvuRhK
 GJA0fJpiu0MpShY48rffMK3k+FXZ7pw=
X-Proofpoint-GUID: ZnCZuijDi7xwhZt10sF8Q08t4ibtYmnw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310042
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

On 24-06-2026 23:16, Yousef Alhouseen wrote:
> FASTRPC_IOCTL_MUNMAP looked up a buffer and dropped fl->lock.
> 
> It only deleted the list entry after the remote unmap succeeded.
> 
> Two threads can therefore find the same entry and unmap it twice.
> 
> That can lead to a double list deletion and double free.
> 
> Detach the entry before invoking the DSP.
> 
> Put it back if the remote unmap fails.
> 
There was a fix that got recently merged to fix the same problem[1].

Please check it and let me know if your change still holds.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/misc/fastrpc.c?id=902b8ec9dd1098cc133cffa8be0b6378544f27ba

//ekansh> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>  drivers/misc/fastrpc.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index ba4ade874..6a5239b1c 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1902,7 +1902,8 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
>  	if (!err) {
>  		dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
>  		spin_lock(&fl->lock);
> -		list_del(&buf->node);
> +		if (!list_empty(&buf->node))
> +			list_del_init(&buf->node);
>  		spin_unlock(&fl->lock);
>  		fastrpc_buf_free(buf);
>  	} else {
> @@ -1917,6 +1918,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
>  	struct fastrpc_buf *buf = NULL, *iter, *b;
>  	struct fastrpc_req_munmap req;
>  	struct device *dev = fl->sctx->dev;
> +	int err;
>  
>  	if (copy_from_user(&req, argp, sizeof(req)))
>  		return -EFAULT;
> @@ -1925,6 +1927,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
>  	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
>  		if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
>  			buf = iter;
> +			list_del_init(&buf->node);
>  			break;
>  		}
>  	}
> @@ -1936,7 +1939,14 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
>  		return -EINVAL;
>  	}
>  
> -	return fastrpc_req_munmap_impl(fl, buf);
> +	err = fastrpc_req_munmap_impl(fl, buf);
> +	if (err) {
> +		spin_lock(&fl->lock);
> +		list_add_tail(&buf->node, &fl->mmaps);
> +		spin_unlock(&fl->lock);
> +	}
> +
> +	return err;
>  }
>  
>  static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)

