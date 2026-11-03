Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBAF60850AF
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hA+4GUOl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3989210E534;
	Tue,  3 Nov 2026 13:27:15 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2812F10F594
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 13:27:09 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a2084d62cdso37188635e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 05:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793712427; x=1794317227; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ta7vqfu43+eJdwILEtJUiCIzSZFnqUgMnY49Wv68/Ms=;
 b=hA+4GUOlCoGQeRJfPEIo0DzFl68hzsXlTdlBQQsz0DagsPVrRLGlQ/HugbX0At2IP1
 p2zhM6I3yS/OI97UAJeK/nVla9ASqJxBaTGSg1G74Z105inB/HKZuZHCLptFFF6QYfGR
 0RYcD4W9IZ1gK+nrXz1oMOMZyKdbC/eFc+59XdgFmBuHFXkD6TIv7Fq+8vxocI6iSWil
 xQ+bA7ceY2EglzSaZ9Xjef4Lar0hJPA0aB7JkzTYeN4yyJ4u2dF53guLH1zTFx9H/CJ3
 /boGoE9JqPZqK3LCGWtOueXQW2fNv0PO5rsHXToEbRWaUzsqNrl6N8l/DCNnpzXVIENw
 5cSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793712427; x=1794317227;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ta7vqfu43+eJdwILEtJUiCIzSZFnqUgMnY49Wv68/Ms=;
 b=dMUygFeXrZ6b63iyZ7wiubLJuYxSzaSklSYvqftnFtthRlLLBafvGl2cjw/7CMCgkT
 Pv+xYSA6J56H8uTVYhVmi57DZhrQfwWPd5hY8CBMhznq4ckRkvbYa06m5WMo2wGOEL0f
 Rak9jDj8RxKYOpWnR9ZcPNcTKymoKoIDxuEj3xqCtJ7Pr6J4PLomUYQqHv92MxfLNIf9
 OHbAKlx677pBZTteaQ8O4cLoLJr5l0XWHEIr++JfnZl/B/zbk9lR59AKD8hgftomevaQ
 xZDuckPGikUvBvesk3U0Y/QhEhoI9c7g0ClvE4szg10senWaUe6TgW0oDN2GkQChqht7
 XBmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4RduPV/ErHrEAnB8a4TJvuU7MmjKCFBuUr+nGY6J1NVUJBLGYNkq88EWM7ZUlwGQWSUoTxMUPnYw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8UmM1wOnvrLZ3rPPzcjmNY2Of4Z57F9LYCw78J2WvZD53FbQMS
 7HHUthT5F4PwSS1LbV1+HryP7mHcZ1Zax96WvE1ErWuE9FybWghyQdA=
X-Gm-Gg: AYBFou2sfByMjZqa/2QrLmg6mAWQjyM0kT01Y7KtMBjjT7jZab4LtsZv1Ur3jQ0Mj8Z
 DRiV2YBO6o78Tuhk4TN6wkF9f0EoN9iBRC/xafWj+ktc/JYikQLHif5DbBtu8lEKdxkjwH9+OIh
 P9+5LHMzc18LEbyNG9XBN1YZqv84ML0GpeCIXjIbszkiygLNZRWObaK3jrXQp5rjo2WK3chx2Us
 nGinlcvwQJwrZHnuTAqr/SagE2twWwWtU1OHdAONcYocDn/yielUf6zZbQgmnXZaQHnJXkAlpsO
 hXdww/Pk3B8Ri+HLDak4SM5zmPtRd5xEumOIYA9KvlTBOS9WJ+ebsGTukLDVWBrJ9w8dZeGvomU
 sSLKtJC9R8RA1IJNrDPFg01LvqQsnMIvDbJl+N9h7+k3DRZbLiLL65e8B7fRQslED25LeMZ1jcg
 8hlJCm5bhW0mL4EqauqgDI8kq8aM3irDPsmqcNLl4SifVg+eo4Wy+n2JcSF1Qlt1QZYPYKCH+cv
 FWnPpK6UCn0d/K08q8cwxVNCb1gUQkmaSZ2XxqNG9t2xwMPWUeeTXJApr36X1iWf8jknup0o3b/
 Gsw+ZWttrRl5LsFdp/TZtPV0Afo+nfdJufsWI7VRXoqfmyzJjH7afjLRLTprec7a7Q6GMGOnkAb
 PgqIYoqUO
X-Received: by 2002:a05:600c:8b54:b0:4a1:fa21:fd90 with SMTP id
 5b1f17b1804b1-4ac16bc547dmr316952755e9.9.1793712427364; 
 Tue, 03 Nov 2026 05:27:07 -0800 (PST)
Received: from ?IPV6:2001:b07:2ec:601d:4b26:1672:75c7:805a?
 ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aa38bb4asm57032565e9.6.2026.11.03.05.27.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 05:27:04 -0800 (PST)
Message-ID: <a3da6619-b40e-4118-ad52-bcbe319cd601@gmail.com>
Date: Tue, 3 Nov 2026 14:27:03 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] drm/msm: Add cleanup help for disabling IFPC
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261102190010.720443-1-robin.clark@oss.qualcomm.com>
 <20261102190010.720443-3-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <20261102190010.720443-3-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 8:00 PM, Rob Clark wrote:
> Simplify error path cleanup for IFPC-disable critical sections.
>
> Note that this moves where we re-enable IFPC until after the
> wake_up_all(), but that is harmless.
>
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>   drivers/gpu/drm/msm/msm_gpu.h      | 4 ++++
>   drivers/gpu/drm/msm/msm_perfcntr.c | 5 +----
>   2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index 0334a0f604ac..e7912d2180a5 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -399,6 +399,10 @@ msm_gpu_disable_ifpc_put(struct msm_gpu *gpu)
>   		gpu->funcs->ifpc_update(gpu);
>   }
>   
> +DEFINE_GUARD(ifpc_disable, struct msm_gpu *,
> +	     msm_gpu_disable_ifpc_get(_T),
> +	     msm_gpu_disable_ifpc_put(_T))
> +
>   /*
>    * The number of priority levels provided by drm gpu scheduler.  The
>    * DRM_SCHED_PRIORITY_KERNEL priority level is treated specially in some
> diff --git a/drivers/gpu/drm/msm/msm_perfcntr.c b/drivers/gpu/drm/msm/msm_perfcntr.c
> index 867dd476ed88..995857273aca 100644
> --- a/drivers/gpu/drm/msm/msm_perfcntr.c
> +++ b/drivers/gpu/drm/msm/msm_perfcntr.c
> @@ -259,7 +259,7 @@ sample_worker(struct kthread_work *work)
>   	}
>   
>   	/* Inhibit IFPC while accessing registers: */
> -	msm_gpu_disable_ifpc_get(gpu);
> +	guard(ifpc_disable)(gpu);
>   
>   	if (gpu->funcs->perfcntr_flush)
>   		gpu->funcs->perfcntr_flush(gpu);
> @@ -295,9 +295,6 @@ sample_worker(struct kthread_work *work)
>   		}
>   	}
>   
> -	/* Re-enable IFPC: */
> -	msm_gpu_disable_ifpc_put(gpu);
> -
>   	smp_store_release(&stream->fifo.head, head);
>   	wake_up_all(&stream->poll_wq);
>   }

Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>

Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>

