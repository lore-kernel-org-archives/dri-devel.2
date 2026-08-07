Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE4AC5AC7C
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9519410E3F1;
	Fri,  7 Aug 2026 10:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="m6x1H5TP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kDOtSHD2";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5793010E3F1
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 10:04:24 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6778CImR3564374
 for <dri-devel@lists.freedesktop.org>; Fri, 7 Aug 2026 10:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=2YxO6sel+FdiQvLcLCoi7QI7
 s/XcbqboOjuQsSWxzbo=; b=m6x1H5TPbr5tbPWMCuCM1oJgJLOm3X0XyoGXZKRt
 PvjhnccAt8+O3pnzRaIWa646yN8Nlo+bYb1LcEiC6GTY5NEilaACuTSfRT1l45Xj
 pFG34VRTNcrr5Sj/eWojsfNf1nUgWEUFk2pSKKyNIpDZB8gXAexS7RFo9Mq4HeYb
 GF+vZa7mZJze+TaXJaSZ+Z9RhTrCJyFYSAZFfLFweNx8B2LVQuDa7NAO1ehpwN8A
 6utXbRZHwB/dld6nuybPZMV/El7Q6LKHis6SBqiWySjQUKMItgLKIG5dbIE7ag5z
 ULLG/5Cd4wxapnNosFpmziBTboZQW8U8U+cojzSo7RzQRA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6ju97n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 10:04:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so52243111cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 03:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786097063; x=1786701863;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2YxO6sel+FdiQvLcLCoi7QI7s/XcbqboOjuQsSWxzbo=;
 b=kDOtSHD2x9wa128bFJolJkGh5MZRAmOc8sn6LClmE2IKvEQUognBUXEEeMYI7bg0OZ
 M6fEmaK9QcqCaVB2paigVojSQJI14FGGqUwEIXiiTjRDEs7kQRwQk94EzOIXbU59OJfX
 tyh+e5m4WQSvH8YwmOGRQuqXe5RbP30cshQ5qkaHSuVFNxf8ggc1LR0eS9BfTfDJKAC1
 3MQw7QMcZvxUW1o4nWdnSNwAWrWnftW0g7L+Tg3Y0tJAQsW+o7QeSz2JwU6Lw1n3lX1X
 u15k9o2eXJiSNm5B2m5eVqSxujJoMkGQ91Yj7pjx1MA9Jt5KbNO5/DTpTAoM88aUDFDf
 0sAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786097063; x=1786701863;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2YxO6sel+FdiQvLcLCoi7QI7s/XcbqboOjuQsSWxzbo=;
 b=m3inAKSOQO6s54vScxycObxJ3WvgQL3IiebvQcyP3VLZcqrwNwOodbaT8qF9Sk8QND
 epXRYszLhy2FMjtjVzZzZZ5FUD4sZ9kTy/FT6ZojvNZagb9XjSHdqtp8GvaTs+P0oeSD
 4+QB8BW+js+1cX2oPgYdRYqezS3ewxr2svcuG5UQG44lEXbSp2h3Tt3XdUySE3EM67tF
 9sTlDrfhh9V0upA3yz8V0TcGxh5RZOSqfjXn9o9Bf9rN1UbOE56xWsfsxgttEY/p9z0q
 v22b9QZfiP7h7sQlg3QhASRWEE/XFWnC68b0PdxRc2lQqPChNwiQWZ4wzmy3AODR5y28
 +p4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8y5/jTGgs9hspEWS9iKpt+MiB1mGqXdHriiV91FU1zb7Z8ERfgqv8Ei+eRjbqHrha/fz+B9/4zbI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDpVWJ9NV/A4/wHDvXisgPu7YWjaSDvptaDYA0CccoJAyUo2Lt
 7JbZdxJ/ahc5pa+HG0qnaISj5jUVouqvOG3/Tf4KI0ml+ZEcF85FAfEQl4w56dTp3mJ0UtKt3wS
 wgd+pJzzKEopWsourASOi5koNj0jHb2W7yBB/gediIko4bjBQHpYA1m42VjSp84wFDEFns8E=
X-Gm-Gg: AR+sD13wg+0uPfhuVsXA4JADJvIBNpN0V40LX9rCQvyBOFRZD8bOiZ5uBSvGccb+654
 BKMu3+OXzrKwCw1/6DXgpJrB/HvH9nmbYST0ia3uCw+694y/ZNaUZoS42DQ0qaNaxMbizFQ7z1u
 tn4z73+qKUzWfnNZzUqKsMtA1SgILkX0DZwftRSblqZH+DP3VbzrvHGBPEjs1ufcCtwfM4rYRmK
 XRSeINL7MLKNgGiEndl5bGFMH5rwNcDP2ttAJaWeVlcQvuM83XueN8ej3pUYkWIPpF08Vd/0U9F
 oDjM4pAF+jH8u+vDZf9SDJN4PiAXVWge/SEH0QDkinzC9QPhh0yeNHZjgSvlyksPa9H+RxOcVBO
 wY1NE0ShJhMTSB6cemNX3tYlgc58IOeHYos6tvlxgpGhiEVqnYl2iGooMN7fufrrFPVhpAgPJLq
 n4SherFbJHSYpttw==
X-Received: by 2002:a05:622a:2448:b0:51c:1117:c79 with SMTP id
 d75a77b69052e-52d0b193284mr99587181cf.24.1786097062689; 
 Fri, 07 Aug 2026 03:04:22 -0700 (PDT)
X-Received: by 2002:a05:622a:2448:b0:51c:1117:c79 with SMTP id
 d75a77b69052e-52d0b193284mr99586611cf.24.1786097062306; 
 Fri, 07 Aug 2026 03:04:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39fdda977d7sm2327021fa.10.2026.08.07.03.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 03:04:21 -0700 (PDT)
Date: Fri, 7 Aug 2026 13:04:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yifei Gao <gyf161023@gmail.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abelvesa@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] misc: fastrpc: fix use-after-free in
 fastrpc_map_attach() error path
Message-ID: <sy7253wbth3wlaqibiu62oddtc2o2vg33ybqjfrkqef33jydrb@os6cwxvhrqdt>
References: <20260806235056.456341-1-gyf161023@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806235056.456341-1-gyf161023@gmail.com>
X-Authority-Analysis: v=2.4 cv=Rt/16imK c=1 sm=1 tr=0 ts=6a75ada7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=CgArLu3JlFgy8oRInKUA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA3NiBTYWx0ZWRfX+CeW6bd3ZUH/
 j3hIc7He4HpexJ92rAj1UXv2tAw/Gdfx9ZB5bGgvdH+QKevTtmVvWdbKXUjNksjJDqGNU0d4wVZ
 qp3GNvI6jJKu29q7MQI/njlY8P6bSNVnXmJB+W5fFeP7uJvq36n3SC8lt5W2GKIMruvd58mlep0
 xl47O3ZrGqfSx+lsELrB9mBiWJk0VENP4hKqhWcgavj/YCvBXtuwqxtuRlr0g/QssLyje4lK2oz
 7igZ4LH39m7s49R16N0nrElbFFvPDqbtCIQTSHRJBnIBTmgrr8fET2J0AKH0387MoQBzrdRbYL7
 xgEN4B7kMlNjJtFIjYlOdgP29QMivThEFk28m4syMlqC78MhMD+F0vHTlddx1RPsNay6cb0wft/
 b3rue74C/3/nbPvK0mYiPkQjvTpvuVoQ94Kz4rvB5VwnZ7aE6cEtzDD/BJTx1HZaxjxCQ00cXu1
 kU4U4u9eBv/3HPkrITA==
X-Proofpoint-GUID: jznpU7vWs5m7-fGQiviCkou4_WZg8AYA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA3NiBTYWx0ZWRfXxZApXKv7wsR+
 gO+T1pc3Gp14m34NZMmBYH1OI0y+uGLMZLEzCTzgtaOic5Q9WZKZ5ST/wdk8ChdOfhieVmP6T0p
 JcqKcukeIeCOPcmHKGFwtRO7IgbhVMI=
X-Proofpoint-ORIG-GUID: jznpU7vWs5m7-fGQiviCkou4_WZg8AYA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070076
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

On Thu, Aug 06, 2026 at 11:50:54PM +0000, Yifei Gao wrote:
> map->table is set right after the attachment is mapped, before the
> len > map->size check. When that check fails and jumps to map_err, the
> error path manually calls dma_buf_detach() and dma_buf_put(), then falls
> through to fastrpc_map_put() -> fastrpc_free_map().
> 
> Since map->table is still non-NULL, fastrpc_free_map() repeats the
> cleanup: dma_buf_unmap_attachment_unlocked() dereferences the map->attach
> already freed by dma_buf_detach() (use-after-free read), and a second
> dma_buf_put() drops an extra reference on map->buf. As the exporting fd is
> typically still held by userspace, this imbalance can later lead to
> premature destruction of the dma_buf and a use-after-free.
> 
> The branch is reachable by an unprivileged process via
> FASTRPC_IOCTL_MEM_MAP with an fd whose dma-buf is smaller than the
> requested length, before any DSP invocation.
> 
> Clear map->table in the map_err path so the fastrpc_map_put() fallthrough
> does not operate on the already released attachment and buffer.
> 
> Fixes: 334f1a1cbe03 ("misc: fastrpc: Use fastrpc_map_put in fastrpc_map_create on fail")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Yifei Gao <gyf161023@gmail.com>
> ---
>  drivers/misc/fastrpc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f3a49384586d..d6be951d5538 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -915,6 +915,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
>  
>  map_err:
>  	dma_buf_detach(map->buf, map->attach);
> +	map->table = NULL;

This way it will skip dma_buf_unmap_attachment_unlocked() in
fastrpc_map_free(), which is not nice.

>  attach_err:
>  	dma_buf_put(map->buf);
>  get_err:
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
