Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A94606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T/zu0/Tc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AjfXcX5U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6454D10F426;
	Wed, 11 Nov 2026 15:39:30 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6032910F3B5
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:39:18 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABF0UMH2594027
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Cttqldc4K8HVD1wbRQk87+5y
 4p5x85/EZZq9nMZ5e98=; b=T/zu0/TcsbdQZMVbAApJmyZ17eSXG9ZjSSnv66lO
 mSNFQh9T5HlenITk1F64T8nKjKCK80zlnXjyaj4lXXEuBxTQg9SM/ZE777hno8z4
 7Zvkq2y/oo8VxQLk8WiT5OmZE4XYjWtK0Q6MAZ0GNIRQusfEWIBQDFhCfIK7lXWh
 9hRUYYa8gALDaXY+5+RSCxbx9+OxhI4Bl4qiKf/WgHY6kwQdnN3L6GhPR1l0cvWm
 zJuDM42zdnQwM2nFvz5/QpauMPAEq8INQb0hJQPs17nMe7Ll1EjNEhxNwGc72svT
 ExEY9dUYV7mSr8DU7ua9Q/glhmgIPxpWAza+w5a21XSxqg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvksm9whk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:39:17 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91ebc622dc8so87670076d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 07:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794411557; x=1795016357;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Cttqldc4K8HVD1wbRQk87+5y4p5x85/EZZq9nMZ5e98=;
 b=AjfXcX5ULTtZypk3eBZXYz0KAXaMqZk1Hbn4M58j1/P7f9yPFPxPfN5fmbmkQBFjyi
 pEG2EAMB4mBZklEt6tq8teO3jL1HaREw6skob3pagwsyfu/nzL7jb2EDjVHIFErKiw1c
 8X0WgITb+6VTRvBQGaO/p6pqbtKeKug9AIaVe2oQTSuvTsiEFYUxej+Qdlef7Ohx5dyJ
 YF2vObn1hrHv9AWaxrF9QQ7Sbr1AxQ2nLxb8HtTLsb0yEaOJmcg6/u3tBz14qrVMAcyY
 R1gIv6CdhUQLu4RYj/wmlefF7l2rn788OAizRRz6BsQ9DrLNmHO+XCthWnP7itkFnYlE
 0ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794411557; x=1795016357;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Cttqldc4K8HVD1wbRQk87+5y4p5x85/EZZq9nMZ5e98=;
 b=abtragjSYUwceiCAzlWSjvt36wCi4SpOw78VwG2vXtSkzkaFWT6lVlHR+LpNgBRnTj
 gQCDIaAwm+nkxKmDfx7qtK7EaWdpjTkLRKNzyZnXw5HLq4M3fMc3XDzMVP26tS/QyflF
 BF9jQ/KymlGwVCiAfqhfhlgHD8ypx8PbFbPil55if5hlr5Opsr+oAWjialSSpxye1ONM
 GyAU4XLNMhhWUxNSsAGdo++UVDLlrb0OOKgWhAzUK/Hf0THazTS+4+TyQZgzqPQ9yKuZ
 VzMyClWdaENRJn5Ni8zgwCpRVNjTpyr78qwjApQGNrzEjKw1Bl6T6Cccz0PgjcltlQb9
 1JSQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEY+uP7Z51TKQ+jIsOuriZlIzt2sOAnoGaVjtlV8kWr97rwOUUlJ4JNwrt2xLSbnsWvpor1xj8AWRY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9s4qRXb+J8QC207/wcrO5ZId1zKXdRtLNzmMtZw2v1cBi/wUPu
 makjvxCuE7aZk1ivUgpx1cgiB1DvyGde7gFkt2iimUmQTTR6lc1vEhyFmApycL51bWGBLlbk1Xy
 BCfmqm6103+Kcg1zeOCzwJK2VfrsUYT0vbrTlGwxuFmh/tmqtv17X4fsIzLDRQQkVjNo0gao=
X-Gm-Gg: AYBFou3/QJTyFmy4bZN7oa5XJ2NySY59VMwcbgxgPC+pd/B5CceLNl4E0uCOk0dQt6N
 XK7aciO+m5lTjKIS02b7mkLxfFuRDpBahXEEkI2ib1OCTwIqzv8HjFxJIocCSQsqwpVf7ygSAQg
 +UfGnJveX57PoftXgVttIa0s2IeqK1mIUydlSqRNeCsFz+OI9bQgEYGjCf2P6Ku5eF+uwK6KmN5
 QJj3ERDah5Yri+0YdjH7M2PDKwqZY1o4JtZ1wSXKmAy1J77wy7uFXFMSFH8DRW8r68j/nfpVxuq
 /5L5AAaJ3MPQsFnfD+hWTkcR4bj6XG/kqrIH/SqNee7+1kymMSwhwc1H5BFiEZhNrlFLfmdvgnI
 3MaaTEOGvXH7JqdRdGheaCQhjCOYnaxS/eGCvKHI1T45qzFbvRzuZAf7cWud0MIn7YtO+v2fs77
 i6bRE0K4eodLVUgjD39t3oKFJxJ6exWvogIHgBIViM9MgPAhjsQJXyyh/YHuX9XQ==
X-Received: by 2002:a05:620a:2852:b0:93e:d1d0:67f with SMTP id
 af79cd13be357-947b0075f66mr381265385a.51.1794411556802; 
 Wed, 11 Nov 2026 07:39:16 -0800 (PST)
X-Received: by 2002:a05:620a:2852:b0:93e:d1d0:67f with SMTP id
 af79cd13be357-947b0075f66mr381261685a.51.1794411556305; 
 Wed, 11 Nov 2026 07:39:16 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae091739edsm11782131fa.1.2026.11.11.07.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 07:39:15 -0800 (PST)
Date: Wed, 11 Nov 2026 17:39:13 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Michael McAllister <me@michaelmcallister.org>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm: avoid an unmatched fbdev IOVA pin
Message-ID: <isnqaepemtnbo7lejjsuk46wkfentboedqk5tb6lhe6ju5anrx@2qrdrgd5tb7b>
References: <179424371125.96483.2462884435294600442.msm-fbdev-pin-leak@michaelmcallister.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179424371125.96483.2462884435294600442.msm-fbdev-pin-leak@michaelmcallister.org>
X-Proofpoint-GUID: gatRxnt7onVCtUHgnybVhc1dq_ebFR5R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2MiBTYWx0ZWRfX4eVBqsPJheXy
 KGcmfxli3vQZ0otUhIKkr5JWUmPZFtDBHI12VDoY+u4M1XVORgd/GUtHIYr/ovedRD6dTQr8TJV
 y8QzDCe8XMboo1Kqh6XADpqWW77sf+r6Q8Wxqh25EFjrsk1pGdKhVo9fNC50jDqnJNwUiepIO7S
 p7zoKQ7ZmexuHYuQAmjA/QrV79XN8pKFghBh5wE4PTuAo0YrEbhNBkW5MzPi/7lAE06O2uiksS7
 q1eFDZHPwxcscDDOAnQHlZkiBHCkyHqIyaBA1g8E/8F8tPQq+i7NGe715ack1FLtG7TDUOw118N
 ojXWGK74uS5sdepGhGGkb1CLNwyQ8JZjHAkmA52VZfP6Z1tM8LYcFNPtodio5yduthgWBQvIpYN
 1EE45SMtfzMRcCDzlrWwOjNU6a5tO9WfigyAIqjLJqaY8TTCoMIEIAwplOjSNQ37/YmJs86Io6a
 /VAL1At/KdE94cVxONg==
X-Proofpoint-ORIG-GUID: gatRxnt7onVCtUHgnybVhc1dq_ebFR5R
X-Authority-Analysis: v=2.4 cv=O9isLx9W c=1 sm=1 tr=0 ts=6af48c25 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=JwJ85b4fAAAA:8
 a=9Vp39pDZEKLU9gGmolAA:9 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=qg2vb7sgHZQYDKbllo_a:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2MiBTYWx0ZWRfX8kiYlwpAsFgL
 Hz8engg/BoTqmddIztMiamsuuaByjtUzsukgUV6IcdOdkdM4SLGgpBgvm9hQp1GmodSQDazI5Ne
 cVwDLTXWCqRNtqE9eQYiAROoNstNVDM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110062
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 05:01:51PM +0000, Michael McAllister wrote:
> Unbinding the display on the Moto G10 produces a pin-count warning when
> the console framebuffer is freed. The fbdev probe takes an IOVA pin,
> but normal teardown never drops it.
> 

I'd say, it suggests that the teardown path must be fixed instead.

> Use msm_gem_get_iova() to reserve the address without taking that extra
> pin. Scanout already pins the buffer while it is in use, and the CPU
> mapping holds its own pin. Drop the matching unpin from the error path.
> 
> Fixes: 7ad0e8cf6317 ("drm/msm: Count how many times iova memory is pinned")
> Signed-off-by: Michael McAllister <me@michaelmcallister.org>
> ---
> Hi,
> 
> I found another pin-count warning while testing display teardown on the
> Moto G10. This one is in fbdev: it takes a pin when creating the console
> framebuffer, but doesn't drop it when the framebuffer is freed.
> 
> I tested this alongside the other display fixes on 7.2.9, including
> unbind/rebind with the compositor stopped. It is independent of the DSI
> command-buffer fix I sent earlier.
> 
> Thanks,
> Michael
> 
>  drivers/gpu/drm/msm/msm_fbdev.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fbdev.c
> index dd6d6c507d..c3bec6719c 100644
> --- a/drivers/gpu/drm/msm/msm_fbdev.c
> +++ b/drivers/gpu/drm/msm/msm_fbdev.c
> @@ -137,12 +137,8 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
>  		goto err_drm_gem_handle_delete;
>  	}
>  
> -	/*
> -	 * NOTE: if we can be guaranteed to be able to map buffer
> -	 * in panic (ie. lock-safe, etc) we could avoid pinning the
> -	 * buffer now:
> -	 */
> -	ret = msm_gem_get_and_pin_iova(bo, priv->kms->vm, &paddr);
> +	/* Scanout pins the buffer; only reserve its address here. */
> +	ret = msm_gem_get_iova(bo, priv->kms->vm, &paddr);
>  	if (ret) {
>  		drm_err(dev, "failed to get buffer obj iova: %d\n", ret);
>  		goto err_drm_client_buffer_delete;
> @@ -162,7 +158,7 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
>  	fbi->screen_buffer = msm_gem_get_vaddr(bo);
>  	if (IS_ERR(fbi->screen_buffer)) {
>  		ret = PTR_ERR(fbi->screen_buffer);
> -		goto err_msm_gem_unpin;
> +		goto err_msm_gem_vma_put;
>  	}
>  	fbi->screen_size = bo->size;
>  	fbi->fix.smem_start = paddr;
> @@ -179,8 +175,7 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
>  
>  	return 0;
>  
> -err_msm_gem_unpin:
> -	msm_gem_unpin_iova(bo, priv->kms->vm);
> +err_msm_gem_vma_put:
>  	msm_gem_vma_put(bo);
>  err_drm_client_buffer_delete:
>  	drm_client_buffer_delete(buffer);
> 
> base-commit: 1e59855738454b14021b64115f0090eafc7526ae
> -- 
> 2.39.5
> 

-- 
With best wishes
Dmitry
