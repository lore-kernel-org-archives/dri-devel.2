Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0957ACA5FCE
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 20:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5624910E1EB;
	Sun,  4 Oct 2026 20:29:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qPnQW8l7";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C239E10E0EB
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 20:29:15 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso11353125e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 13:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791145754; x=1791750554; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iIFKjp1lGfDiZDolW1BimcdoYD6V0XYUoyt5Xe2j2X0=;
 b=qPnQW8l7xuhyAQ+qU6auwQbxuJoKcteucUmnYt2uqQazDOY/48blg5bSxTb499h5A3
 dhivNEfJYoNGzJrFs5A0AH0AGhHKCSUk+M5r7U3ioB1LEsRF2k91fDVucZbx0vaDKtNH
 dBuGXYbodT6qVw+GbwK09p369P9Egv7JGRhCGx0M8HDDCY8Seb9TfHhAHfSnRrfJQleX
 +TMfxmjBv+UkuPFh73M+u+TCcqjrbeHwJWdNofn/L+DoyBAlSXj4Qzj3fpYN4nE0iCDG
 53a1zY7zOX7E+yjztwKvL5iaw5F9AKIjxA4yk8uHicFeUOk7f77QU9PyCzIDwYTYLFFT
 auZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791145754; x=1791750554;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iIFKjp1lGfDiZDolW1BimcdoYD6V0XYUoyt5Xe2j2X0=;
 b=yXEtYD9P947xgQcrzbPDbFj8Huh4fx/7d4UzGke4tWiZbEaa8lo0B1sGYhNfZr8qQy
 xZt3Xj0EiuzIkpGzVctRFe6Vm7GybWPbL8xojoFIWLIEKi/Z1kAYnbSc/mQfAEUBOdDc
 xgwOeH5L15FuMnhpb80frKcyK/WiG3zHy98QGztQRzUO61whmLb0FsWotPr9UnJKPRQ8
 Km1k0hCSsfDa5hn4oGQx22mQvl9pCHCstgYnTotPtIyk3aNk2KbTNwV/kL9LVrNNU+3B
 jTuSL+x9LD3u4gop6uu/3JLj81Z7FrTw4ozHfpjPnhblS4QkIuZu+hElgSe8XeHLvuqn
 WcuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBydCGX0M+7AzbvU4Z+PC65778B9Zu3K3hPORDGwMoxcrGSVHBB3ZlF3VR62CG4JR3ZMxDTtIdC/dfQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lpOnFn+sQZkzzBZTg6hOzPfs8owMHqc6X9G03KMrErpmDtWm88
 BcAOJ9jCs8DpUiTvSLilpOO596a8jpdVtS1lae32YfbNLr+R7wARPzA=
X-Gm-Gg: AYBFou2yqdsseAk2hkKdhjhFB4x4jXEWCqAfyCSHm6qPRM7DhyKT2ErmaoXCj+doQZW
 RsK+ddw20y+z8xilzieT7r+x8+Pp3JiyD5+N2TneVN06Motl9QvVsd2F8T3SiITCAFdBYlYHlNe
 Pg9E2ugHyfecrJqEnH+8g5tRkx8ud9hnF0zRMdN8Tk237q7zwwGK8u/IwhZx6WMTE97tgrmi9Df
 HWXv8qXNZCVytZFfQMUNECxKoPVMmAY2nlBL/gv4fO+VhcSY5Dh7cJUwY2mTUwcHbn4Rm+94x0z
 VzFyCIRcpyhGUvUzCPoNlaIhDWhHXG4ZtnAF8uN9OOGDYjTmB/gls8QvhzQaR+SyE7t4a/dSqH6
 PjzfKdMBI5VW/6s1hk4cM+4KZ6lZcEzhohhapc8whqtvALtL+YhufrL6slXaPxtN9CxPB5lzo5e
 mpfaHFxiF/HP0FitjvnSDUI5zOvkTDbUWRQlQO8OLlD3p5nQ1mu6LAmM1rG+KozOcQ2MJ9mr1zP
 a+COStKjEoyYnJc9fRVz2kNc8iZVJbu+B8xKHUhNMoP1vliwtqmC+7pY9CIPRgV5A==
X-Received: by 2002:a05:600c:6096:b0:49f:ce73:7a9 with SMTP id
 5b1f17b1804b1-4a1681073e2mr86527135e9.34.1791145753848; 
 Sun, 04 Oct 2026 13:29:13 -0700 (PDT)
Received: from ?IPV6:2001:b07:2ec:601d:4b26:1672:75c7:805a?
 ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a030326132sm232315185e9.0.2026.10.04.13.29.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Oct 2026 13:29:13 -0700 (PDT)
Message-ID: <b46b2f7e-f5fa-4556-9da3-aa4e4ab0e7a0@gmail.com>
Date: Sun, 4 Oct 2026 22:29:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] drm/msm: lock the resident BOs of a VM_BIND submit
 last
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Alice Ryhl <aliceryhl@google.com>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Liviu Dudau <liviu.dudau@arm.com>,
 Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maxime Ripard <mripard@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Sean Paul <sean@poorly.run>,
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>,
 Steven Price <steven.price@arm.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
References: <20261001220632.3190896-1-matthew.brost@intel.com>
 <20261001220632.3190896-7-matthew.brost@intel.com>
Content-Language: en-US
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
In-Reply-To: <20261001220632.3190896-7-matthew.brost@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/2/26 12:06 AM, Matthew Brost wrote:
> A VM_BIND submit locks the resv of every BO mapped in the VM, then
> validates the evicted ones, which means getting their pages and mapping
> them again. That is slow, and external objects can be shared with other
> processes, so all of it happens while holding resv locks other processes
> may be waiting on, for BOs which needed no work at all.
>
> Use the two pass locking gpuvm now provides. The early pass locks only
> the evicted external objects and validates them, along with the evicted
> private ones, which the VM resv held from the start covers. The late
> pass locks the external objects which were resident, and still validates
> in case one of them was evicted meanwhile. When nothing is evicted,
> drm_gpuvm_exec_pass_needs_split() says so and the submit keeps using a
> single pass.
>
> Both passes run in the same drm_exec transaction, nothing is unlocked in
> between, and they take disjoint sets of objects, so reserving one fence
> slot in each still reserves it exactly once per object.
>
> This moves validation from after drm_sched_job_arm() and fence
> attachment into the locking loop, ahead of everything else, which is
> also where a failure is easiest to unwind. The order does not matter to
> the shrinker: it skips any BO mapped in a VM whose resv it cannot
> trylock, and the submit holds the VM resv throughout, so a BO mapped in
> this VM cannot be evicted while it is locked, whether or not a fence is
> attached to it yet. The same means the early pass can never evict a BO
> the late pass is about to lock, the property Xe gets from
> xe_vm_set_validating().
>
> Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> Cc: Antonino Maniscalco <antomani103@gmail.com>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Dmitry Baryshkov <lumag@kernel.org>
> Cc: Jessica Zhang <jesszhan0024@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Marijn Suijten <marijn.suijten@somainline.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Rob Clark <robin.clark@oss.qualcomm.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> Assisted-by: LLM
> ---
> v3:
>   - Follow the drm_gpuvm_exec_pass_ function renames (Danilo)
> ---
>   drivers/gpu/drm/msm/msm_gem_submit.c | 84 ++++++++++++++++++++++------
>   1 file changed, 66 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
> index 1215b388cb40..4e454345567a 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -266,6 +266,71 @@ static int submit_lookup_cmds(struct msm_gem_submit *submit,
>   	return ret;
>   }
>   
> +/*
> + * Lock and validate every BO mapped in a VM_BIND VM.  Unlike the legacy path,
> + * where submit_pin_objects() only validates the BOs userspace attached to the
> + * submit, userspace does not tell us which BOs a VM_BIND submit uses, so the
> + * entire VM has to be validated.
> + *
> + * When something is evicted, the locks are taken in two passes.  The early
> + * pass locks only the external objects which need validating, i.e. the
> + * evicted ones, and validates them along with the evicted private objects,
> + * which the VM resv held from the start already covers.  The late pass then
> + * locks the external objects which were resident.  Validation means getting
> + * pages and mapping them, which is slow, and an external object can be shared
> + * with another process, so there is no point in stalling that process on the
> + * resv of a resident BO for the duration of it.  The late pass still
> + * validates, in case one of those BOs got evicted meanwhile.
> + *
> + * Both passes run in the same drm_exec transaction, nothing is unlocked in
> + * between, and they take disjoint sets of objects, so reserving one fence
> + * slot in each reserves it exactly once per object.
> + *
> + * The shrinker cannot evict a BO the early pass is about to validate, nor one
> + * it has validated already: it only evicts a BO after trylocking the resv of
> + * every VM the BO is mapped in, and the VM resv is held throughout.
> + */
> +static int submit_prepare_vm_objects(struct msm_gem_submit *submit)
> +{
> +	struct drm_gpuvm *vm = submit->vm;
> +	struct drm_exec *exec = &submit->exec;
> +	int ret;
> +
> +	ret = drm_gpuvm_prepare_vm(vm, exec, 1);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * With nothing evicted there is no validation to keep the resident
> +	 * objects unlocked for, so do not pay for the second walk.
> +	 */
> +	if (!drm_gpuvm_exec_pass_needs_split(vm)) {
> +		ret = drm_gpuvm_prepare_objects(vm, exec, 1);
> +		if (ret)
> +			return ret;
> +
> +		return drm_gpuvm_validate(vm, exec);
> +	}
> +
> +	ret = drm_gpuvm_exec_pass_prepare_objects(vm, exec, 1,
> +						  DRM_GPUVM_EXEC_PASS_EARLY);
> +	if (ret)
> +		return ret;
> +
> +	ret = drm_gpuvm_exec_pass_validate(vm, exec,
> +					   DRM_GPUVM_EXEC_PASS_EARLY);
> +	if (ret)
> +		return ret;
> +
> +	ret = drm_gpuvm_exec_pass_prepare_objects(vm, exec, 1,
> +						  DRM_GPUVM_EXEC_PASS_LATE);
> +	if (ret)
> +		return ret;
> +
> +	return drm_gpuvm_exec_pass_validate(vm, exec,
> +					    DRM_GPUVM_EXEC_PASS_LATE);
> +}
> +
>   static int submit_lock_objects_vmbind(struct msm_gem_submit *submit)
>   {
>   	unsigned flags = DRM_EXEC_INTERRUPTIBLE_WAIT | DRM_EXEC_IGNORE_DUPLICATES;
> @@ -276,12 +341,7 @@ static int submit_lock_objects_vmbind(struct msm_gem_submit *submit)
>   	submit->has_exec = true;
>   
>   	drm_exec_until_all_locked (&submit->exec) {
> -		ret = drm_gpuvm_prepare_vm(submit->vm, exec, 1);
> -		drm_exec_retry_on_contention(exec);
> -		if (ret)
> -			break;
> -
> -		ret = drm_gpuvm_prepare_objects(submit->vm, exec, 1);
> +		ret = submit_prepare_vm_objects(submit);
>   		drm_exec_retry_on_contention(exec);
>   		if (ret)
>   			break;
> @@ -790,18 +850,6 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
>   
>   	submit_attach_object_fences(submit);
>   
> -	if (msm_context_is_vmbind(ctx)) {
> -		/*
> -		 * If we are not using VM_BIND, submit_pin_vmas() will validate
> -		 * just the BOs attached to the submit.  In that case we don't
> -		 * need to validate the _entire_ vm, because userspace tracked
> -		 * what BOs are associated with the submit.
> -		 */
> -		ret = drm_gpuvm_validate(submit->vm, &submit->exec);
> -		if (ret)
> -			goto out;
> -	}
> -
>   	/* The scheduler owns a ref now: */
>   	msm_gem_submit_get(submit);
>   

This and the two other msm patches are:

Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>

Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>

