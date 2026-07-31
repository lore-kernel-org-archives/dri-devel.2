Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E08EC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB14410F169;
	Fri, 31 Jul 2026 06:44:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="U4n2VqiQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fd5oqkdf";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87F7310F167
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:44:47 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V665m82636701
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sKWmxBXJBHdVo9za8nnXMGzPjkbzHCu2a0+Of4kjIIw=; b=U4n2VqiQuX8wABmv
 f1gA+D4klb+g8U2EZnjMK1ZGevTrLmSNprtb0zqwh1/e8l+fXteGj89kT9jB75nk
 fQwva0twAeUQ5fd8drmijk2kiyOI2bo4sOuTMXJ9iLrr3NsbWJRoiXQpxz6mAXP7
 5cod/r6X6xnj6RK0Xi5QTDoXIn6dHuQ2FOfitUgabjlcvWUYoZ9N5atU0hwlRJXp
 iMY5ibCyRRjL8xsJgGT+UOlM+szY9c1tdFmPx4fmMc4dijfyee0mEEJbQ9F9IKKw
 jD2R/7rBnFjQEBIZvSRv4DlJOjPmbqScPloMObIqJm8gIpOJHEiK1yRQ6zCrhrrZ
 lkou7A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frp4y04et-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 06:44:46 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-848568a6f62so1502711b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 23:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785480286; x=1786085086;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sKWmxBXJBHdVo9za8nnXMGzPjkbzHCu2a0+Of4kjIIw=;
 b=fd5oqkdfjHdYyzl6725j7J2vAo+i6Bqcwbuv0JuW9HCUXGlC/pCgSg7+H9kFse+9A7
 7sclNwjD//Bs+wWAEJDwn7Hic/xL/d8FpZht5s/lLVC+nSnV/kQDu3U7oWnd9WCxJbL+
 xJY5JoKoSceYjN2uFnTtNGGfeqR2fP64lUjAHBjaorqSk/fZT8oRtjhODrGA6/Y0/fub
 28/YAnjB+18+XJnwGFUh3R58n9meMHSMvc6el5C00sZglwXp517pZ5V9mgNKzt6jm0XP
 Ee1Z/cUu6SeReL3CmGRMOSgFTHw2mM3bz4Imzq7nQVn7w20Zxco/VIz+OE0g35cwn2uo
 Iung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785480286; x=1786085086;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sKWmxBXJBHdVo9za8nnXMGzPjkbzHCu2a0+Of4kjIIw=;
 b=IhGCZCE1CXjdaMUqFBXPrGtSrwh9TULbk+b7uoDSyLGg5lIuyEuFaIMtZzqUeWv79m
 L5gPcSnj2tIj7n4/MYFZhnrFFKCd/pbPPaAr97+YT5XujmAtTQBDRTsGylYntwS1aQ4a
 yK72reZqeRgFGQ4mKOoEZ3vZULt21adeMXOFMVOwdoyBDnK+VcSYXhMZasn3H7AG1kdr
 FdD7XcoL8yBKZVoBv5r6XUnWQ9CtKn36y9XHIth3n0WRC09dtRGq72knF5MsoTszEVYy
 OZbODCLsEqLwLdGTMJQNQ0ruNtVNIyqQeQRT9WneS/iXI8zwWs7xyVHqqbn/X5MsXWk8
 nEOw==
X-Forwarded-Encrypted: i=1;
 AHgh+RocOIF1ygvjVvUKZu84e03QOXf344GT+tXx4IJxFZUSiWPP5DbBkH4svpUb3Mn8TICpVkdumJXeLto=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJsFs/T05wIAPdLCDxs1XNVyW0ObZYxgvffH9QalB7TVz/Qzpe
 pApwWQNxiTNgY5Z3lfSRqv2sZsynZrXHYCrglE+4aI1iykKm87mRANuYtppWScZIcmZVVcpg6xU
 FSc6LDn87ktG/wMMeXJtpO53dpjeN2d/+cDwpjswUvz5VfgI1pNlfHPCryyxDs+8qKE3rajIb54
 U1/cA=
X-Gm-Gg: AR+sD10a9lNZwcDEOrV4TQXEFviTQS95uBgdw/y2kS0eXFu/RnXZfW5lH0Xok+fSCmJ
 F7TUU0a9XdjsUkealyjChqv3tSXS670N+RD0Y6cU+5n7o+oxQ4aXbYC2F3rTjyn72zvKKCbIBbq
 bngfo3v8UbSKFt860hWR0s198MubYkBYOuy3FqEjX2C8Bv6qRqLL3eqvFmSwLU+qjBaq0GMnb56
 1psoEbk8qd7vMAulCMc3YnNZAhCqMC5v1Rp79JOPM6eCs8j+DOsDriMUnIiz9LF33+OhhYebi2g
 jq1hh8q4ojqQlaCGo2nwgbuFp0YXyUZygbDNBLgK5XZ7FACp7hkLrRjE0Tsm6JR9PzN1oOMHhs1
 FV5KCSKNpk6BqzDf1ETBejS7aEcSVDg==
X-Received: by 2002:a05:6a00:2991:b0:847:9151:3409 with SMTP id
 d2e1a72fcca58-84ed6f4d301mr799857b3a.55.1785480286294; 
 Thu, 30 Jul 2026 23:44:46 -0700 (PDT)
X-Received: by 2002:a05:6a00:2991:b0:847:9151:3409 with SMTP id
 d2e1a72fcca58-84ed6f4d301mr799838b3a.55.1785480285854; 
 Thu, 30 Jul 2026 23:44:45 -0700 (PDT)
Received: from [10.204.78.242] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84edbd31590sm29318b3a.8.2026.07.30.23.44.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 23:44:45 -0700 (PDT)
Message-ID: <9a5808d9-9d95-4491-8d44-647b08a6d058@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 12:14:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: fastrpc: remove map before remote unmap
To: Yousef Alhouseen <alhouseenyousef@gmail.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260624174932.7419-1-alhouseenyousef@gmail.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260624174932.7419-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=K44S2SWI c=1 sm=1 tr=0 ts=6a6c445e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=s0Wo0hrht0JdwzRqEpUA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: Uv-cPUPJuhOty8ZV-4BDknddITs-Lltu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA0NSBTYWx0ZWRfXxeNJMv3LZtpe
 KV9yxtCSG53pyuGnX36KPT0G/vN5DL3ylQAdU1GABKjY5D+UU82k4lWbW4AfdbdSlSN9QVCfGke
 Ugff9R4YyJVkJ3oiNOKterk+Hken5PI=
X-Proofpoint-GUID: Uv-cPUPJuhOty8ZV-4BDknddITs-Lltu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA0NSBTYWx0ZWRfX3nXv8FeHDHb1
 9arNrevTYTGXiwbU/MPAxRHHeIlszoC9kYi7msSaR2x5qX3Mona2mrPHubTR6sTPQyMTEd/kosw
 PHkumkLf1MAUhrwyYTSMS4aZmM9wv3CoUVyH7+e/9QtlbmbEqVOr1ueBFshzFh1LqO9WBifS2ye
 OMGq06Gxf1M+3OewmLx5Q6JSX6IMO0lb387VaORGKyI7yyvygM0jq4DpNJsIGV5/goT2SkQoEAJ
 eb+x7VxP4MkMwqsxG7S+GmpzOpQgPrqA5d3z2P3pVzSFzHAzadsUYSMzz1hA2FS3Tu/HOymwT56
 WD10gZ9xQ05rJidGHWdPS5V8R12JQI4S2v0OsBX35l24aiu3L1mS24LVWM+OB4krICtV3n0AcWI
 RUiQU5+Tww8RCQyv4PM/Q64WeAUTkt5/tbzle5rY1ksVGDIB8yKitNvvPi/+JdyJVfSRXp+yXXZ
 T3pkwqESvMZAqzdRZFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310045
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

On 24-06-2026 23:19, Yousef Alhouseen wrote:
> FASTRPC_IOCTL_MEM_UNMAP found a map under fl->lock, then dropped the lock.
> 
> It used that map until the DSP completed the unmap.
> 
> A second unmap can find the same map and race to fastrpc_map_put().
> 
> That can cause a use-after-free or double list deletion.
> 
> Remove the map from the lookup list before the remote unmap.
> 
> Reinsert it if the remote side reports an error.
> 
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>  drivers/misc/fastrpc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 6a5239b1c..6ced210ca 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -365,7 +365,8 @@ static void fastrpc_free_map(struct kref *ref)
>  
>  	if (map->fl) {
>  		spin_lock(&map->fl->lock);
> -		list_del(&map->node);
> +		if (!list_empty(&map->node))
> +			list_del_init(&map->node);
>  		spin_unlock(&map->fl->lock);
>  		map->fl = NULL;
>  	}
> @@ -2064,6 +2065,7 @@ static int fastrpc_req_mem_unmap_impl(struct fastrpc_user *fl, struct fastrpc_me
>  	list_for_each_entry_safe(iter, m, &fl->maps, node) {
>  		if ((req->fd < 0 || iter->fd == req->fd) && (iter->raddr == req->vaddr)) {
>  			map = iter;
> +			list_del_init(&map->node);
The map is not available after this point in the fl->maps list and there
can be another thread making a MEM_MAP request for the same fd/dmabuf at
the same time. Now as the entry is removed from the list,
fastrpc_map_lookup() won't find the entry in the list, the MEM_MAP call
will go ahead and create DSP mapping for the same fd again. This can
leave the same buffer mapped twice on the DSP with two different raddrs,
which might cause problems.
>  			break;
>  		}
>  	}
> @@ -2088,6 +2090,9 @@ static int fastrpc_req_mem_unmap_impl(struct fastrpc_user *fl, struct fastrpc_me
>  				      &args[0]);
>  	if (err) {
>  		dev_err(dev, "unmmap\tpt fd = %d, 0x%09llx error\n",  map->fd, map->raddr);
> +		spin_lock(&fl->lock);
> +		list_add_tail(&map->node, &fl->maps);
> +		spin_unlock(&fl->lock);
>  		return err;
>  	}
>  	fastrpc_map_put(map);

