Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10AD606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=T+hdywZX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4512B112AD8;
	Fri, 23 Oct 2026 13:17:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id A193A112B06
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 13:17:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B12931DB
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:17:18 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 081E13F673
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792761441; bh=mXG0XX15yKYdw+EhkLniRyMbPXcVVDIBIbKHabfygrs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T+hdywZX7/tXhye8aLxX2Apj5HX4GaRUe9iDagSwIeRr/xgye/dBXvQCN04ifmdGU
 XMR/I2H06tRcoW/nZykB00EXBfXS2ji5gDzaELISBMzcIkjrl6cFW8PJidjX+THUen
 x/pBr1b6s1Qk2pP1IvwGFTJdsSfL3PWerhXzGEPw=
Date: Fri, 23 Oct 2026 14:17:17 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Bradley Morgan <include@grrlz.net>, Chia-I Wu <olv@google.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v7 2/4] workqueue: Separate sysfs mutable vs immutable wq
 attribute sanitizing
Message-ID: <atteXW1M-ZnWt6r3@e142607>
References: <20261022093848.5727-1-tvrtko.ursulin@igalia.com>
 <20261022093848.5727-3-tvrtko.ursulin@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261022093848.5727-3-tvrtko.ursulin@igalia.com>
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 10:38:46AM +0100, Tvrtko Ursulin wrote:
> In preparation for adding more sanitization steps split the current ones
> into ones which are immutable and the ones which can be modified from
> sysfs.
> 
> Point being that the mutable steps must only run on the initial workqueue
> creation, while the immutable properties need to be sanitized every time
> attributes are applied.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Bradley Morgan <include@grrlz.net>
> Cc: Chia-I Wu <olv@google.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Tejun Heo <tj@kernel.org>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  kernel/workqueue.c | 49 ++++++++++++++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index d8cf546d853f..c634b20f1874 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -5706,6 +5706,32 @@ static void apply_wqattrs_cleanup(struct apply_wqattrs_ctx *ctx)
>  	}
>  }
>  
> +/* Sanitize attributes not modifiable via sysfs. */
> +static void
> +sanitize_immutable_workqueue_attrs(struct workqueue_struct *wq,
> +				   struct workqueue_attrs *attrs)
> +{
> +	if (wq->flags & __WQ_ORDERED)
> +		attrs->ordered = true;
> +}
> +
> +/* Sanitize attributes modifiable via sysfs. */
> +static void
> +sanitize_mutable_workqueue_attrs(struct workqueue_struct *wq,
> +				 struct workqueue_attrs *attrs)
> +{
> +	if (wq->flags & WQ_HIGHPRI)
> +		attrs->nice = HIGHPRI_NICE_LEVEL;
> +}
> +
> +static void
> +sanitize_workqueue_attrs(struct workqueue_struct *wq,
> +				 struct workqueue_attrs *attrs)
> +{
> +	sanitize_immutable_workqueue_attrs(wq, attrs);
> +	sanitize_mutable_workqueue_attrs(wq, attrs);
> +}
> +
>  /* allocate the attrs and pwqs for later installation */
>  static struct apply_wqattrs_ctx *
>  apply_wqattrs_prepare(struct workqueue_struct *wq,
> @@ -5735,6 +5761,7 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
>  	 * every possible CPU and never falls back, so it has no default.
>  	 */
>  	copy_workqueue_attrs(new_attrs, attrs);
> +	sanitize_immutable_workqueue_attrs(wq, new_attrs);
>  	wqattrs_actualize_cpumask(new_attrs, unbound_cpumask);
>  	cpumask_copy(new_attrs->__pod_cpumask, new_attrs->cpumask);
>  	if (!(wq->flags & WQ_PERCPU)) {
> @@ -5757,6 +5784,7 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
>  
>  	/* save the user configured attrs and sanitize it. */
>  	copy_workqueue_attrs(new_attrs, attrs);
> +	sanitize_immutable_workqueue_attrs(wq, new_attrs);
>  	cpumask_and(new_attrs->cpumask, new_attrs->cpumask, cpu_possible_mask);
>  	cpumask_copy(new_attrs->__pod_cpumask, new_attrs->cpumask);
>  	ctx->attrs = new_attrs;
> @@ -5919,24 +5947,6 @@ static void unbound_wq_update_pwq(struct workqueue_struct *wq, int cpu)
>  	put_pwq_unlocked(old_pwq);
>  }
>  
> -/* the attrs @wq asked for, as spelled by its flags */
> -static struct workqueue_attrs *alloc_wq_std_attrs(struct workqueue_struct *wq)
> -{
> -	struct workqueue_attrs *attrs;
> -
> -	attrs = alloc_workqueue_attrs();
> -	if (!attrs)
> -		return NULL;
> -
> -	if (wq->flags & WQ_HIGHPRI)
> -		attrs->nice = HIGHPRI_NICE_LEVEL;
> -
> -	if (wq->flags & __WQ_ORDERED)
> -		attrs->ordered = true;
> -
> -	return attrs;
> -}
> -
>  static int alloc_and_link_pwqs(struct workqueue_struct *wq)
>  {
>  	struct workqueue_attrs *attrs;
> @@ -5948,10 +5958,11 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
>  	if (!wq->cpu_pwq)
>  		goto enomem;
>  
> -	attrs = alloc_wq_std_attrs(wq);
> +	attrs = alloc_workqueue_attrs();
>  	if (!attrs)
>  		goto enomem;
>  
> +	sanitize_workqueue_attrs(wq, attrs);
>  	ret = apply_workqueue_attrs_locked(wq, attrs);
>  	free_workqueue_attrs(attrs);
>  	if (ret)
> -- 
> 2.56.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
