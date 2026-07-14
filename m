Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC49DC44515
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:19:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A02410F1F6;
	Thu, 16 Jul 2026 08:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JmhMH5bR";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78B6010EE63
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 21:33:57 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2cacf197759so22305185ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 14:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784064837; x=1784669637; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zebbIro5mkXbuDBJ5TKnPBr9hFGew4CMfA/H27lS0KU=;
 b=JmhMH5bRnq/SXDzgstDegeBbdbJWwWFVQoQVG3EQVY/MKzmKZomRmZzBKRSZmcWZp7
 e0eU7wyhV1tHy+KNrSQE6+8oeZQu1mE4aiPXLIxIXcH0k78c1Qi6LUgsliGfyYZWS0TW
 3BHMp5Yo+Qj1iuV0fNyZpsd3k7cBHfVFdl+xvmma9r2su9I17IxkNTl73HBte5k7o2gX
 U/npZw5mr5OuA9orcIwltQbgJpTJH1nG2fz76K450qWRxkK8fDs0SZ2ECdj4hDNnJOc7
 G1rfgBJK7dcyuqWWl6r5tUSwBHrUwKi5iSgm8HKZ5EUpkBiw0hOL7NsGiU5E5iBKwa6L
 ziYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784064837; x=1784669637;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zebbIro5mkXbuDBJ5TKnPBr9hFGew4CMfA/H27lS0KU=;
 b=qKtsnU8IyKPNS8hS0zyzmQghJ5fV3dvWUC/6rlYTgouQXVLo6z6wa7OBDozZ0WLAs7
 QCiemnRBAJbAm8QP0NWJTMe55qfRekfNCnnGOza06sBriSLviuJl0kcpXWFFC2llYKch
 zQzCih614liT3Yzv29X3wOL7u/9X0b2wxIf2GTtoE4FWNNuJjq+lVPjay145b8tzibqP
 OGL4aJMVkDJ4u0ugmdiqxUdihgZndu2GKcvDw65hempc1vDngkj28BHRomO3fj3bc2p0
 tpQ+ahVsS4XmDJV5k54rhZD80P3Z2YXVeYkt8NWGNOuxt6ZybdGLKALL6Ri/iFPDUDX5
 5tCw==
X-Gm-Message-State: AOJu0YxW8Jt6+sZXv5KdhAPHV4M2/Fz3WimLf6maxOO2fIdJiZiHGNRT
 MNAFOfRmLd01ik7EtKvKuh1GxRGo3gMcO/Dxtsk2Xgz9UYuh8OK/8bgy
X-Gm-Gg: AfdE7cnGDMqPdzG/b3gIZG1xuzRtE62b8O+yMFdsoBpzlD28Ilfw7YsRLGFsyxvxUtM
 5Af1eTwKQ3w1HoVeULkgvvXq5x7HlGX8e+wTDlugB3UvSkxpRPOXXB3zTDGwFOLjEgmZJR4rXpM
 ja2lsPLHcnh5E4CiUJLVfnScg997vaLI1XPqE5E8IzL6R6/fyF5VKyizRGBO3KWPl5zyA+FtLAS
 QwfE/4MyBcg2CKOJitQh+j9oI+oWHrydD27fd6ACO6scJLBI75y5Mag1Zy8TFes7mIu4zNqJ4he
 lqJ9k/Cq47AmTbgOs4+ecDC91P+LbWRNY0z08AuSJPfcRV1xezsBHkh5AF+m56IHBoU6gI4FKek
 4bcAOErplN5wlxXKgaX9ZjsgeGCKX/dY78RPXLhrnhPw3XqMMOEU/x61YBKwlIEXOJHSh5YmFTh
 VRMLYDcZqUcc10JFwdg9N5ZAcG3FOR2HjgvU+J0Mlg/xLhI7Lu/xSl4ViIdV9gXq9Obg==
X-Received: by 2002:a17:903:240c:b0:2c8:1c05:16bb with SMTP id
 d9443c01a7336-2ce9ec0f108mr142192545ad.24.1784064836947; 
 Tue, 14 Jul 2026 14:33:56 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cea6507b5csm55058005ad.72.2026.07.14.14.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 14:33:56 -0700 (PDT)
Date: Tue, 14 Jul 2026 14:33:53 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
 corbet@lwn.net, dakr@kernel.org, david@kernel.org, jgg@ziepe.ca,
 kees@kernel.org, leon@kernel.org, liam@infradead.org,
 lizhi.hou@amd.com, ljs@kernel.org, lyude@redhat.com,
 maarten.lankhorst@linux.intel.com, mamin506@gmail.com,
 mhocko@suse.com, mripard@kernel.org, nouveau@lists.freedesktop.org,
 ogabbay@kernel.org, oleg@redhat.com, rppt@kernel.org,
 shuah@kernel.org, simona@ffwll.ch, skhan@linuxfoundation.org,
 surenb@google.com, tzimmermann@suse.de, vbabka@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/4] fixup! drm/nouveau: use
 hmm_range_fault_unlocked_timeout() for SVM faults
Message-ID: <alarQbmnjwtgdBUB@skinsburskii>
References: <178405975214.1082778.5193079941156341151.stgit@skinsburskii>
 <178406001808.1082778.17299764648397654220.stgit@skinsburskii>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178406001808.1082778.17299764648397654220.stgit@skinsburskii>
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:18:22 +0000
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

On Tue, Jul 14, 2026 at 01:13:38PM -0700, Stanislav Kinsburskii wrote:
> nouveau_range_fault() now uses hmm_range_fault_unlocked_timeout() for
> the HMM fault path. The timeout passed to that helper is meant to bound
> HMM's internal mmu-notifier retry loop, not the whole nouveau retry loop
> around mmu_interval_read_retry().
> 
> Pass the full relative HMM_RANGE_DEFAULT_TIMEOUT value to
> hmm_range_fault_unlocked_timeout() on each attempt, and retry from the
> nouveau-side mmu_interval_read_retry() check with a fresh HMM retry
> budget. This lets HMM continue when it has made progress, while still
> preserving a timeout for repeated notifier invalidation retries inside
> one HMM fault attempt.
> 
> This also removes the open-coded absolute deadline and remaining-time
> calculation from nouveau_range_fault().
> 

Sashiko is right. I'll need to do it differently.
There will be a v2 of this series.

Thanks,
Stanislav


> Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_svm.c |   30 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
> index 4cfb6eb7c771..b1415c2e49fc 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -655,8 +655,7 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
>  			       unsigned long hmm_flags,
>  			       struct svm_notifier *notifier)
>  {
> -	unsigned long timeout =
> -		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
> +	unsigned long timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
>  	/* Have HMM fault pages within the fault window to the GPU. */
>  	unsigned long hmm_pfns[1];
>  	struct hmm_range range = {
> @@ -677,25 +676,16 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
>  	range.start = notifier->notifier.interval_tree.start;
>  	range.end = notifier->notifier.interval_tree.last + 1;
>  
> -	while (true) {
> -		if (time_after(jiffies, timeout)) {
> -			ret = -EBUSY;
> -			goto out;
> -		}
> -
> -		ret = hmm_range_fault_unlocked_timeout(&range,
> -						       max(timeout - jiffies,
> -							   1L));
> -		if (ret)
> -			goto out;
> +again:
> +	ret = hmm_range_fault_unlocked_timeout(&range, timeout);
> +	if (ret)
> +		goto out;
>  
> -		mutex_lock(&svmm->mutex);
> -		if (mmu_interval_read_retry(range.notifier,
> -					    range.notifier_seq)) {
> -			mutex_unlock(&svmm->mutex);
> -			continue;
> -		}
> -		break;
> +	mutex_lock(&svmm->mutex);
> +	if (mmu_interval_read_retry(range.notifier,
> +				    range.notifier_seq)) {
> +		mutex_unlock(&svmm->mutex);
> +		goto again;
>  	}
>  
>  	nouveau_hmm_convert_pfn(drm, &range, args);
> 
> 
