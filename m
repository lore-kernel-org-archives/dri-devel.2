Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C083CCD4F25
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 13:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 117A210F525;
	Fri, 15 May 2026 13:36:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EuGssWlt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g5pmmSLv";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0924310F525
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 13:36:28 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FBkKer3197820
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 13:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=3fH5rkxqtvlr/lqpie/zaJri
 oVqs4D/a1AVNK2Q6F5A=; b=EuGssWltAk5i4GWjLs3rVa16048UzGQQdYCW4caj
 JCHHwse4RVcLyLnyAk4rpWkFbyDupQwzP6Yi6DpWbvAPm6uuOyn4MCo4P83rRtw8
 UY81Y04Yc3lke3XgGUB/AQKUp0ofTa5dXHLEnm6da9nNflMb3iJQiOusL19rFaqE
 45nyWtEIQuZLSF3iKSqjQu3cO0XODR72/vt7Yp/eo28qD9iSgAOmAQrzhfli6YzD
 dzVMOOF82yk5+iiMlw0I2KhFMg5l0hS1tj5Qr3ETxk3ISoQ7Y3pE9ddYMWFajxyI
 nm/AumoiiHO7jyjLxalNDEGGOpzDjjxzqgDHcwb+2aDdlw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1qbew4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 13:36:28 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6312aa1d7adso323692137.0
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 06:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778852187; x=1779456987;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3fH5rkxqtvlr/lqpie/zaJrioVqs4D/a1AVNK2Q6F5A=;
 b=g5pmmSLvwd4ZcrySRuAod1QTcQ1bbbCQXO722T2jqoAnhKOFGRp7aZuc9h0aq8ZpsD
 TnXgjz7i4KO9uKgy88NW/8B4q6RdQHNAmc6qgBjrD0l/PuM0YVl5Ld4bLqp/LT8cemtK
 XchBy4N9DTz0jHeHReEB8kt7qhKu/vFCruLg58XQZoCcso+UPOPNKxk2bwSM0singwo6
 yOmMIsA2PXZYbi7hXFZMmObaXrKcYQkf69La1JlQOpgzn0LmnXK8eF3uzoyP6+CNzZnQ
 29/QyXlfWT8EP26ur3Yd4YwfAicmaKBfAAE1Ykr6Z3XClbQCn54duXkOvlSIfAp7rN1n
 jsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778852187; x=1779456987;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3fH5rkxqtvlr/lqpie/zaJrioVqs4D/a1AVNK2Q6F5A=;
 b=UpqBpEVPVTnPe3U/l5M/G45r2dAiBuuuw6Zr4n6iR/dzQaWYWItpGHR/AsW362yilt
 3La7u4OYDHQsjeXkZdXEGe/EbYZv4tdMZRBB8ME/pyV9v8rR7Rdm4D4hzaHTaRUeId2a
 3X9UoMyvuWeZEc0v8gya2iwHhdP6iFzJwsmLN5NjR0Cb5slVnDaMx046y55LmHH0gGZM
 h8iTAenVaVK9/o+9ux7Ks4zjVC/c7CA9DMvW4+MOobUECTTykk3SeboANc+Eh3J2Qu3N
 Wi07SPjbTa/GdankUkQqNMNreUmEOpJc1rPCZRtzy3hB90vk5GROespKeeezQbY9MevP
 RWzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ92nCJ3gvuLUdfpHamcJH33u08BsrIVYf6cYg3DlHTtRGcOJW+DO1J5yA5ExDnYYVY6qMnH+JvwHYg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyD6ENOtLmiclZA7odh4Drclz/gMikXUtIkuhrcyHkWduoAB9GR
 ViM+kyHKi6AzmUc4B7xiD6QaL9ZJavAbfhNxZ21R2gA4hrIM4G7wUH/qIq+LNx1ysW1HoSOQTaV
 Ny43ol3t1jJE0oBTr1fkHTboClsN9GgOkCAY7MlaG/iGbAVQvn1IepCBAdD1uur+aSEHZ9s4=
X-Gm-Gg: Acq92OETFhQBvE9ACHfMez/c3oC8OLjd2Xo7aCLihH61e4LzpFJUijk3NuReA4Yzbcm
 VHQ/urnYilgr3FQ5mT4krbcGEiXK5RzUnJ8v3YM2A9b1MayRdmsD7N2iuoSHPf0iBIeYZxglxxn
 SVkc5R6CKDhqgB06dUdxciOk5YbA0/3WBHKa+GwD3v8XUHvxHylg+rAeDll2LSAAiplUmojP6kG
 aSDG0rFqJ1/3EiDNWKxFy7iQqaNzHyoFr4xcoucp2U+d1lLpeQ/Hcvqhj4pYaVxMOcsq6dSJeDb
 LZRQxQNXSgMlC52kADTxoINdYfE5tuwqS9gPddUFizAQmOwJyoBD6PPKB1J8iDfIqioZVASAEF6
 jyx5F73o9GUl82BQCivbKYZ2VSdxQu2+xV9+PsDPb9VgC/ORSRmOjFoXN9oHT+fIFQ4MEQB/o7f
 DZmrhgdhuFV/6VVKmTHK940Ik9ZXHHLD6iCu3Boej1HwfQ+g==
X-Received: by 2002:a05:6102:f0f:b0:631:4580:6a42 with SMTP id
 ada2fe7eead31-63a3fe9beb9mr1789893137.22.1778852187392; 
 Fri, 15 May 2026 06:36:27 -0700 (PDT)
X-Received: by 2002:a05:6102:f0f:b0:631:4580:6a42 with SMTP id
 ada2fe7eead31-63a3fe9beb9mr1789820137.22.1778852186745; 
 Fri, 15 May 2026 06:36:26 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c5e5sm1330255e87.3.2026.05.15.06.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 06:36:25 -0700 (PDT)
Date: Fri, 15 May 2026 16:36:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
Subject: Re: [PATCH v5 2/5] misc: fastrpc: Remove buffer from list prior to
 unmap operation
Message-ID: <xnkycubizpoe4rmhc3jt36ulx2fb3tubjybu3djovafkqqttmc@o6vw2so5ctxr>
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
 <20260515124217.20723-3-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515124217.20723-3-jianping.li@oss.qualcomm.com>
X-Proofpoint-GUID: KqWwFI3oA37WswArnAghelHYMrZwbuzj
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a07215c cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=UJ1zFB7r74I_tpvr3eIA:9 a=CjuIK1q_8ugA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEzNyBTYWx0ZWRfXxRyy0bS2uo7q
 l78gKWDEo4Cp4Jp0ByLoS4H3l7p1ujKNZsi/nDXy6GwYV1vBWpDxxbhPZAqWBnJIBg2y+lzTp5N
 kqSLcBQrFVcGQHsF6s7MhLSpBdf4G1navxnDzK/gEHDQs+RQP5MmJu9clxtNxwiFfTmgz3i8fcx
 SvTLG9O0ZS8q8ukuODtiLJzVSyu0nSA7Xim/eAIy4/YQko0kK22sJeoBY7yMdLJc6UdogcvAPNE
 1ARbQ9mKfvWwmfclnJ/7+Spkd3NPA9qFJEMTgebFET72nXXkBtY5P55ZAVSLBShEebgtOhW0gwD
 BAHVpoABcROzhjWjL2o544bzEixAhaScmqiSegtxEtClMVLbPtwgYxE570H2v+EoKZAmaQXQnc5
 gUOpqMBmBlUQpj6Y+FhbFnnCoPZnEXRV5tRNLe4jhrTO0OPltmyYBBzYcUMnhK/ryR7/XRKfFWr
 nTy+5Q/JdfQmz+hStJw==
X-Proofpoint-ORIG-GUID: KqWwFI3oA37WswArnAghelHYMrZwbuzj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150137
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

On Fri, May 15, 2026 at 08:42:14PM +0800, Jianping Li wrote:
> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> fastrpc_req_munmap_impl() is called to unmap any buffer. The buffer is
> getting removed from the list after it is unmapped from DSP. This can
> create potential race conditions if any other thread removes the entry
> from list while unmap operation is ongoing. Remove the entry before

How can it remove the entry from the list?

> calling unmap operation.
> 
> Fixes: 2419e55e532de ("misc: fastrpc: add mmap/unmap support")
> Cc: stable@kernel.org
> Co-developed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 8b21f85cd9f4..3c7c3b410d7d 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1863,9 +1863,6 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
>  				      &args[0]);
>  	if (!err) {
>  		dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
> -		spin_lock(&fl->lock);
> -		list_del(&buf->node);
> -		spin_unlock(&fl->lock);
>  		fastrpc_buf_free(buf);
>  	} else {
>  		dev_err(dev, "unmmap\tpt 0x%09lx ERROR\n", buf->raddr);
> @@ -1879,6 +1876,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
>  	struct fastrpc_buf *buf = NULL, *iter, *b;
>  	struct fastrpc_req_munmap req;
>  	struct device *dev = fl->sctx->dev;
> +	int err;
>  
>  	if (copy_from_user(&req, argp, sizeof(req)))
>  		return -EFAULT;
> @@ -1886,6 +1884,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
>  	spin_lock(&fl->lock);
>  	list_for_each_entry_safe(iter, b, &fl->mmaps, node) {
>  		if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
> +			list_del(&iter->node);
>  			buf = iter;
>  			break;
>  		}
> @@ -1898,7 +1897,14 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
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

Is it expected that userspace tries to unmap it again? Or why is it
being added to the list?

> +
> +	return err;
>  }
>  
>  static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
> @@ -1989,14 +1995,17 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
>  
>  	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
>  		err = -EFAULT;
> -		goto err_assign;
> +		goto err_copy;
>  	}
>  
>  	dev_dbg(dev, "mmap\t\tpt 0x%09lx OK [len 0x%08llx]\n",
>  		buf->raddr, buf->size);
>  
>  	return 0;
> -
> +err_copy:
> +	spin_lock(&fl->lock);
> +	list_del(&buf->node);
> +	spin_unlock(&fl->lock);

This is a separate fix.

>  err_assign:
>  	fastrpc_req_munmap_impl(fl, buf);
>  
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
