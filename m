Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7C31073CA3
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 12:04:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD1D010E620;
	Wed,  8 Apr 2026 12:04:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="TwbVrcDC";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B186A10E620
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 12:04:06 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-488c2690057so14947695e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 05:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1775649845; x=1776254645; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=67FUvuUYw3FdlK6qJZvlH40hk371TsgTNRnsmwrbeHA=;
 b=TwbVrcDCohhfSbcghHn/c/Uo+AaKaGfMIDBzV0D8nCUH8Sw02WFJVQk3TDUIQY8jsU
 cvXeIU2sSPWLNLG4ZTLqJ8lzPqqi1sT3z88R7eHim7JfNP0UO6j0dEPkzV65T9x6ggHy
 0qyt6EgHRN9M6cLG1z898XhBUGXJV8PwbD6Ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775649845; x=1776254645;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=67FUvuUYw3FdlK6qJZvlH40hk371TsgTNRnsmwrbeHA=;
 b=dloygVFHfiM5GAfeFX0CTmoNcUde4sdSkRCWRYqT38x8247SlrrB9BO1w6rphFrb2J
 KfDA//qtpBf3TlQF/vMCLvlAabB4vUZOCnFh7akOH25128fLLAzJJHTAeBmL/618DVSa
 I5b/f4y3au2gw4d07SAhgBr3XbWiZh5AYbPeHuOe3p+gAA3RTJKCLqHqhJypVUCyzmOw
 QHl85KcA/KLErQPz5ggxvOgDy3kYkGpEj8vxbsAaxDv6rxdi7N/a2JN1nZ49HX21R73g
 zR5LgvLizPGcldWWqbbkmLJLv8OG1PNuh9RgqAAg7QT6pcB7OwPUTE3O/OOAjVzm4hWG
 7zHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXzlu7EM6J+Dv1dMKj5a2V2wzJZsdY4r+Y4gnPl1GpU+gw03Tp4f6sqCtn1TVsAR8lkWbYahVjYSc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUq3GmEnwRB90Zo4bxn2rfz79s14Eti41uJ5a5J4xG8Do1hmNN
 hbCAyy6EVarI4igmX7Q047KTyrJCqZ08/iyLXDuyhEt6q0F5cMrXswpKyYYtSNQVloM=
X-Gm-Gg: AeBDietjzK2f65XQbgYue6wFFFUwSCriUXH/etjTzd39MytZCs4Ag95pzG5jInrqCvL
 iZ2tWJIlkpn0eCEHRO0LU7j/VS4CPFWf9q3llUeoPn8qqAnzaKAksN3MWStiB3Kwf7cFDXne3Iq
 9ipsWlJNv5fSjkMJUvetzUyA/Ox3qQJIAunIlEK48hBX6DdDE2Cb2NJ168b0sLxXT1AwaQJtZDs
 6mC+rs7tFnAk3q3NxkYPrImu0r4ukCtdhNubdrN676HkyEIP+ZFWYr51fbVOGPuTFKI0op7EcCP
 4CIwY1svdnrBjM3LSsHXtCeYMy3rNzCDgux8VW97ckqUlp8AMM8XAnafk6nmXylWbb0wSr6E35q
 nd7eDzABpZ8KEdwhjPh8DJlkpxBMQrAUD95jo/wY+Q37p5ijoGf0V2+n1M4uor+PmbIFsHpRf64
 zFgBsqlp2MAcyP/E/kjYSyhf3MFrYA1yJrhtS+J603c4H3Qg==
X-Received: by 2002:a05:600c:1d1d:b0:488:7ebd:78 with SMTP id
 5b1f17b1804b1-4889977cbb7mr287621565e9.14.1775649844715; 
 Wed, 08 Apr 2026 05:04:04 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48893f39027sm439570295e9.2.2026.04.08.05.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 05:04:04 -0700 (PDT)
Date: Wed, 8 Apr 2026 14:04:02 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Intel graphics driver community testing & development
 <intel-gfx@lists.freedesktop.org>, 
 Direct Rendering Infrastructure - Development
 <dri-devel@lists.freedesktop.org>, 
 Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Andi Shyti <andi.shyti@kernel.org>,
 Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH v3] drm/i915/gem: Don't use VMA from wrong VM in EXECBUF
Message-ID: <adZEMi0ps3vK9-xt@phenom.ffwll.local>
References: <20260408110551.84120-1-joonas.lahtinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408110551.84120-1-joonas.lahtinen@linux.intel.com>
X-Operating-System: Linux phenom 6.19.10+deb14-amd64 
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

On Wed, Apr 08, 2026 at 02:05:51PM +0300, Joonas Lahtinen wrote:
> Do not pick a VMA with non-matching VM (ppGTT) on quick path
> of BO handle lookup for a given EXECBUF call. VMA from wrong VM
> could be picked if same BO is repeatedly used in EXECBUF
> calls on same context with alternating VMs (ppGTTs). However due
> to the introduction of proto-ctx that should not be possible since
> d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle
>  create parameters (v5)").
> 
> Also avoids returning a VMA without increasing the refcount,
> which may potentially lead to UAF since f7ce8639f6ff ("drm/i915/gem:
> Split the context's obj:vma lut into its own mutex") and until
> d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle
>  create parameters (v5)").

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>

Also, much more succinct summary above than my babbling below :-)

Cheers, Sima

> 
> Sima's analysis:
> 
>   This check was added in f7ce8639f6ff ("drm/i915/gem: Split the context's
>   obj:vma lut into its own mutex") but without any hint in the commit
>   message as to why. In another hunk of that commit there's a hint though in
>   __eb_add_lut:
> 
>           /* user racing with ctx set-vm */
> 
>   This would mean that this bug was introduced in e0695db7298e ("drm/i915:
>   Create/destroy VM (ppGTT) for use with contexts"), which allowed to change
>   the gem_ctx->vm at runtime, opening up the race that was partially fixed
>   in the earlier referenced commit about a year later.
> 
>   But it cannot be exploited anymore in anything remotely recent because
>   with the introduction of proto-contexts we've made gem_ctx->vm invariant
>   again, exactly to preemptively close all these potential issues.
>   Specifically d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle
>   create parameters (v5)") is the vm specific part of the proto-context
>   work.
> 
>   Despite that this is impossible to exploit I think it's still good to fix,
>   but I think for paranoia's sake we should put a WARN_ON_ONCE(vma->vm !=
>   vm) in there, since this really should be impossible.
> 
>   I don't think there's a  harm in backporting this though, since there's a
>   2 year window between the introduction of the ctx->vm change and it's
>   complete fix with the proto-ctx work between 2019 and 2021. It's not
>   realistic to backport the latter and this here is trivial in case anyone
>   is foolish enough to run such an old kernel.
> 
> v3:
> - Include Sima's analysis and WARN_ON_ONCE
> 
> Fixes: f7ce8639f6ff ("drm/i915/gem: Split the context's obj:vma lut into its own mutex")
> References: https://lore.kernel.org/all/20260324151741.29338-1-sosohero200@gmail.com/
> Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Linus Torvalds <torvalds@linuxfoundation.org>
> Cc: Simona Vetter <simona.vetter@ffwll.ch>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: Andi Shyti <andi.shyti@kernel.org>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> index bd608cea396f..16f7c2fac143 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> @@ -895,8 +895,12 @@ static struct i915_vma *eb_lookup_vma(struct i915_execbuffer *eb, u32 handle)
>  
>  		rcu_read_lock();
>  		vma = radix_tree_lookup(&eb->gem_context->handles_vma, handle);
> -		if (likely(vma && vma->vm == vm))
> +		if (likely(vma && vma->vm == vm)) {
>  			vma = i915_vma_tryget(vma);
> +		} else {
> +			WARN_ON_ONCE(vma && vma->vm != vm);
> +			vma = NULL;
> +		}
>  		rcu_read_unlock();
>  		if (likely(vma))
>  			return vma;
> -- 
> 2.53.0
> 

-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch
