Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146FACC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 05:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5482E10E0F5;
	Wed, 14 Oct 2026 05:33:26 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6309510E0F5
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 05:33:14 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E4h0Q8442764
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 05:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NwYCzFamUz6JWqnCtRiF1HGf20u7HKf9g47iiBgNPPc=; b=fqTvsewPyKUL9RNx
 sXl65tB155PmCVjk+dg9zD1nKu8rocpANJYQZHV3/I+R/+vJBc/u0wsjT68w0+Ck
 eSiaOWPPKoFuarTM7gIk9VDv8JwSwhKaETF1Mdd96QEVNGVv0ZU1zntZpWfhlbM8
 vb+LWRBSBWWBJ0cR7hqYEfL2sd8bjZtWvkzVZ7HAgYp0YP1QetXfpTSdomLyEg65
 LQObG9ZHef6uznNVO8kDavxD6K8OLnZQWQ2FZhCTmszKtUjFQAU7ogHai2bWjVOr
 OLxKEeTdgmAVRuBh/vqs0a3H0YxheXgHO6YjQY2wUoJa7PbJB/L+uUhivS1sSgYt
 NmFNBA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9n71kr7b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 05:33:13 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ac575a9198so1337858a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 22:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791955992; x=1792560792;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NwYCzFamUz6JWqnCtRiF1HGf20u7HKf9g47iiBgNPPc=;
 b=JMCDa63JXg+Y5s87BizBRDKl4tMF7mbWm7e6kl8k3MSD1ynTFawfNQ8jXljf3AY1+B
 C+LToL7fo8cSIQ+3RfCPSXfUQbNIDKHgo+NOH4bAw2+vb2EiAW0PuBJZ6yZW+MQh8f+U
 NF0bjWVOHRl7YK6hWbWoY75fTFQbgdyk5mRmsDUaKU/IR/FnHzHPjvI6OCz0VUpLFHt6
 I7C1CdTEjtuUQdTWdxd6ak+kjIbQzfA9iFYwC/P/B/Wqwa67RBsoTpmh5djfCy/F/w+0
 xGg7JNQ2A0kLSAgWojmRRBXQk0BxmxoUhjmXJ22AnZEDnm3hW3rfS9Bgz38lK7TnbtcX
 9cpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791955992; x=1792560792;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NwYCzFamUz6JWqnCtRiF1HGf20u7HKf9g47iiBgNPPc=;
 b=sxT0DmFB+LWO3mVzXWiinTOZXQEblQgZGNlX9JkMYc7jmUsTAplt6Klt4mjH2ST9sE
 i2C0Lpx3dWqKkmRlkwbJegC7xtw2NUYB+i+mbOVrhG3voIHR69Sc/ZArCm7y8PfimWkS
 vzCrv7uFW4jtxhbCELUvURIn4UuYskAPq3MMhhTLkrDAVK8zRoK1LZjadezWZZ1hu5+Z
 mZv5X1LirRcCa5KuaSwOzhhFxcKD2gCsnWjoxU6qRgLulsRs16KxH5yLk1ZcVNcuPY8D
 i0kPIdAH8xRndof5dgbHe0MxVeLN7tzYUev4XLXZfmpA28lTbBY/pRmAEsri+xrBBgSk
 b2nA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFLqGDHQE2b1a0jIL8/B9WjpAkeqOjRXPUCxLOBApFRHQgv5nkV5GIj9wDMpsWzPN6P9noPnyrBvw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI5WbMG/ZUEf4gELFLVjanKN26wSso2vHmuUHNm9sFGCe6XnDDn
 5XBptaR6hULhNQmP5ghO4TVMNi1+stjZaN0POopwQKR522WkWmH2oudXvT2n59chzx6rHJXhuZF
 TaqaM0fNd4Q7AOhaAhkVySqu38TQRJT27SkyoM6wffsJxqmPuOD6cEaByIn0PzJRWjHrtemM=
X-Gm-Gg: AYBFou1UYvXg7YERXQt7r7UggGpcyT9DbHkZCfAJwFcN/2d9dDwNwCbDCJzUcVYJ28N
 fy1iWj/WMa+yozU8ssNrIcfxoDNvkvhHeonnRjsjRI4ZEuprNtRtFsAIr5Z2kFcWPRFd8rTsiqA
 +rCALh11XxtmrPeOkcuFkUTZFv4ccd2MDbZ49XvMROItJxXos7ZRyo/Hr9icKtmBjjR6un5nJEx
 Va+4e2cwWRigW2a7+krfni2i8Pe3K8iExwL8fCnE6nXNdvos8KuzUYUhI2Y5PZ2o7ldisgnnT19
 IuEWmaOh1tAWswT96eolOI8ZIJq+wiUHnrTZvLQblnQq22wBo4jipdgMup5TZ9maSkHX5Vmk07j
 Myt7ioIJBDV9ZCi9c+LfWWjzxQKgR
X-Received: by 2002:a17:90b:35c2:b0:3ac:7c52:fae5 with SMTP id
 98e67ed59e1d1-3ac7c52fe5amr69188a91.50.1791955992208; 
 Tue, 13 Oct 2026 22:33:12 -0700 (PDT)
X-Received: by 2002:a17:90b:35c2:b0:3ac:7c52:fae5 with SMTP id
 98e67ed59e1d1-3ac7c52fe5amr69168a91.50.1791955991609; 
 Tue, 13 Oct 2026 22:33:11 -0700 (PDT)
Received: from [10.219.56.188] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac6019ca59sm2972612a91.9.2026.10.13.22.33.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 22:33:11 -0700 (PDT)
Message-ID: <293dc185-5714-4a12-a0ab-a767e81a88a2@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 11:03:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] misc: fastrpc: Fix double free and races in
 fastrpc_req_mmap() error path
To: Yao Yiqi <yaoyiqi3@huawei.com>, Srinivas Kandagatla <srini@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260930071340.2969948-1-yaoyiqi3@huawei.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260930071340.2969948-1-yaoyiqi3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FuqQbGrq c=1 sm=1 tr=0 ts=6acf1419 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=EUspDBNiAAAA:8 a=lqT82U607IzybvAi_igA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: UCtZjThVP38ssepFPNSlYiY3UlywLRjZ
X-Proofpoint-ORIG-GUID: UCtZjThVP38ssepFPNSlYiY3UlywLRjZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAyMSBTYWx0ZWRfX+R5ADu3IfwsY
 ap4ynrdZgcWwNcdiI9WYfR845hJSmf5oUZzkBxwdVBNMi05wFaBvfXeJ0fmg0KZcOKw2TGxyRQg
 EpqE+XZS/3nWnqQOmNP4v+TsCJQue2qPJhkWbfW15QcHe891OIHgjndMJyU2nvE2+4HTNI/F0ko
 FwD8gzSvAUQovXTfJwhOppF+3ajYrpWg5gB+qBuuO8Z2kmKjkY3lYur2vNe+5EG8IDQNczgagu4
 1eCgCtsLLxCyqKt/KGZsVdvKy+geA20J+gtghNculESGoC71eQwalnEjvcHaByy+2QKmgZMwouw
 u64meO263vhfBmILIkvfrevbqdzovkqL+JiO9IGUtZfHZQdX9qS23nBjbQaMQEwSEsrTiS3aydN
 DQwA145zWcKGDbGD3kTUkAqDl1dnSB/yHHzYlrt7vJ7n6P/jzp6RtTptsGkhE3OADPI9kx9V2dk
 2t2BU/hGdMFP4hNjKOw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAyMSBTYWx0ZWRfX/o8etVrixlL6
 PUa40A8tPjA3vZLxuYqw50aYCB0s6YmQ+l0vtgCR4+j30vXhbiquhRS9sZHaDuaF5qTiGsIzxt3
 4pFMsVCpaGtLe33ym3DD5W8T+niHYQg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140021
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

On 30-09-2026 12:43, Yao Yiqi wrote:
> fastrpc_req_mmap() links the newly allocated buffer into fl->mmaps before
> copying the response back to userspace. If copy_to_user() fails, the
> err_assign path calls fastrpc_req_munmap_impl() to unmap the buffer from
> the DSP and, on success, to free it.
> 
> Since commit 6102ceb4eab8 ("misc: fastrpc: Remove buffer from list prior
> to unmap operation"), fastrpc_req_munmap_impl() no longer removes the
> buffer from fl->mmaps, as that is now the responsibility of the caller.
> fastrpc_req_mmap() was not updated accordingly, so the buffer is freed
> while still linked in the list. The fl->mmaps cleanup in
> fastrpc_user_free() then calls list_del() and fastrpc_buf_free() on the
> already freed buffer, resulting in a use-after-free and a double free.
> 
> Publishing the buffer before copy_to_user() returns is also racy:
> another thread of the same process can read the DSP address from the
> partially written user buffer (or via userfaultfd) and issue
> FASTRPC_IOCTL_MUNMAP, which unlinks and frees the buffer while
> fastrpc_req_mmap() is still using it.
> 
> Fix this by adding the buffer to fl->mmaps only after copy_to_user() has
> succeeded, so the buffer is not visible to a concurrent unmap while the
> response is still being copied. If unmapping the buffer fails on the
> error path, fastrpc_buf_free() is not called, so re-add the buffer to
> fl->mmaps to keep it tracked and let fastrpc_user_free() reclaim it on
> release instead of leaking the DMA allocation.
> 
> Fixes: 6102ceb4eab8 ("misc: fastrpc: Remove buffer from list prior to unmap operation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>

Reviewed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

> ---
> Changes in v3:
>  - Re-add the buffer to fl->mmaps if unmapping it on the error path
>    fails, since fastrpc_buf_free() is not called in that case and the
>    DMA allocation would otherwise be leaked.
> 
> Changes in v2:
>  - Link the buffer into fl->mmaps only after copy_to_user() succeeds.
>    Besides fixing the double free, this also closes the concurrent
>    FASTRPC_IOCTL_MUNMAP race, where a partially written user buffer let
>    another thread unmap and free the buffer while fastrpc_req_mmap() was
>    still using it.
> 
>  drivers/misc/fastrpc.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index d4fac2caca86..917a5dfe3774 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2153,22 +2153,26 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
>  		}
>  	}
>  
> -	spin_lock(&fl->lock);
> -	list_add_tail(&buf->node, &fl->mmaps);
> -	spin_unlock(&fl->lock);
> -
>  	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
>  		err = -EFAULT;
>  		goto err_assign;
>  	}
>  
> +	spin_lock(&fl->lock);
> +	list_add_tail(&buf->node, &fl->mmaps);
> +	spin_unlock(&fl->lock);
> +
>  	dev_dbg(dev, "mmap\t\tpt 0x%09lx OK [len 0x%08llx]\n",
>  		buf->raddr, buf->size);
>  
>  	return 0;
>  
>  err_assign:
> -	fastrpc_req_munmap_impl(fl, buf);
> +	if (fastrpc_req_munmap_impl(fl, buf)) {
> +		spin_lock(&fl->lock);
> +		list_add_tail(&buf->node, &fl->mmaps);
> +		spin_unlock(&fl->lock);
> +	}
>  
>  	return err;
>  }

