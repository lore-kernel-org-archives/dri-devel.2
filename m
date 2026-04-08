Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D25CFD5F98
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 09:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB47810E5BB;
	Wed,  8 Apr 2026 09:08:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="WWt25n1Y";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7751E10E5BB
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 09:08:11 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-43cf8fe9c2aso3474367f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 02:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1775639289; x=1776244089; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dKTBatq0cvZCVrBhAkZ8dIwEDJYjd8kVDmfDtYpfCw0=;
 b=WWt25n1Yiv9bQEs68tvMmntlKPtAJiS1WUDOUfLfuyODtE4wKnGFQ1PCJX/kpIMCkB
 PHF1u+W0BBGZiIDExNjIW4hbzPpMdAqLJAv35ttVFcqRDUbr/2Xl09MYdGd4uDqxuVWX
 v27c7HnjLA2TTpDiONYkoJ5M/boT7mwB4vnOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775639289; x=1776244089;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dKTBatq0cvZCVrBhAkZ8dIwEDJYjd8kVDmfDtYpfCw0=;
 b=fg//WMpVyMMHsBUsMvRN/sF0sqLh2a5kk/aQITEVCjb7b7yQ7j8sAQtSVZ0SFwc0al
 2alM2lcx93v50Lzq3Uw7BkQJB2JW0gbzJOc6fnfxYXTXRywKwjZ2PQ39oTWwBWy96Ojc
 Wv7diD8tlBF5DoIaoOfpDwZ3CXoSExI+N8ZrLGKxkoeTDBAAiTiPOx/rw353czpJ1gwg
 RQneXUe8Mda7Dm4iv7h/Lnr5XgHAT4AZNve45Fu+w26UUqM99odxCLFJwHmAyNQJVlAV
 cBjk3WnpFNtZ0nzsJ3cO7wLbmANvIh6LbT3CzPaTGDuQxjmhapo25OT4GlppVBl4/BG8
 JLZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmb8ND5kbSMqVBRqWojO9hp6WV/Q4Al/SW6PKRvJYtqHrF7yZTRi76diIW2ZhaqVargvVrJfMN4UI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWuDl9uSKM0/ZejfOWlusfufk2hJNbWyulcCGjUERRhSrSQ+uQ
 ZGaz7Ye6R7LeBC+mnU5AFMLJF64GPmgfEt8tWk5IgqI5l/3G3EaF5PN0phVy9zrGUiw=
X-Gm-Gg: AeBDieuluaSXAJ6xMKBy+qtFotRCzCtOlfQjqGA1eGLlExZz11v6M61wAuDu0FHXA+M
 IYhQCWrqtrp7h3xgdLxm477vwxGgOx4v50RbOsK+4d2KRTmhXSJarPkiGV2wzTpi65qIw8N6dnq
 FntNWUajBcMcpLgRM+EEIJBnEIH8HuY7fZV8ehtoMAcJgZZg/xZAXDQrWGFFK7DzoiZmIRNiNwh
 AEDnKUXyXMok8TikpP4qKL7ZLvPee+3AGaE6nM9MIPSYUlsWfB96w/gvp7KH2ftdn24N3YLJaXs
 GzrMiIA/5cg9CIam/OHQ3dX2XAdlNDwm627JI3xuLgC3WObWhmDWegJJyG0HOBo98bFESx0NsNY
 twBhLytVN2ud1YzMvONCfo2bRfEvsOnF6GM8BXT36J7211MdGbStZa/nmUAbYI5tDII3tui6V8n
 N0VIUEs8qczuBhvZKMsHUZoJLWp2u8CvEQyok=
X-Received: by 2002:a05:6000:208a:b0:43c:fe0e:5bbc with SMTP id
 ffacd0b85a97d-43d292a0309mr28660057f8f.19.1775639289373; 
 Wed, 08 Apr 2026 02:08:09 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f7d4esm49900832f8f.34.2026.04.08.02.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 02:08:08 -0700 (PDT)
Date: Wed, 8 Apr 2026 11:08:06 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Intel graphics driver community testing & development
 <intel-gfx@lists.freedesktop.org>, 
 Direct Rendering Infrastructure - Development
 <dri-devel@lists.freedesktop.org>, 
 Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH] drm/i915/gem: Don't use VMA from wrong VM in EXECBUF
Message-ID: <adYa9rf5fgL8-DVq@phenom.ffwll.local>
References: <20260408082859.69823-1-joonas.lahtinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408082859.69823-1-joonas.lahtinen@linux.intel.com>
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

On Wed, Apr 08, 2026 at 11:28:59AM +0300, Joonas Lahtinen wrote:
> Do not pick VMA with non-matching VM (ppGTT) on quick path
> of BO handle lookup for a given EXECBUF call. VMA from wrong VM
> could be picked if same BO is repeatedly used in EXECBUF
> calls on same context with alternating VMs (ppGTTs).
> 
> Also avoids returning a VMA without increasing the refcount,
> which may potentially lead to UAF.
> 
> References: https://lore.kernel.org/all/20260324151741.29338-1-sosohero200@gmail.com/
> Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Linus Torvalds <torvalds@linuxfoundation.org>
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> index bd608cea396f..7463c3262651 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> @@ -897,6 +897,8 @@ static struct i915_vma *eb_lookup_vma(struct i915_execbuffer *eb, u32 handle)
>  		vma = radix_tree_lookup(&eb->gem_context->handles_vma, handle);
>  		if (likely(vma && vma->vm == vm))

This check was added in f7ce8639f6ff ("drm/i915/gem: Split the context's
obj:vma lut into its own mutex") but without any hint in the commit
message as to why. In another hunk of that commit there's a hint though in
__eb_add_lut:

	/* user racing with ctx set-vm */

This would mean that this bug was introduced in e0695db7298e ("drm/i915:
Create/destroy VM (ppGTT) for use with contexts"), which allowed to change
the gem_ctx->vm at runtime, opening up the race that was partially fixed
in the earlier referenced commit about a year later.

But it cannot be exploited anymore in anything remotely recent because
with the introduction of proto-contexts we've made gem_ctx->vm invariant
again, exactly to preemptively close all these potential issues.
Specifically d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle
create parameters (v5)") is the vm specific part of the proto-context
work.

Despite that this is impossible to exploit I think it's still good to fix,
but I think for paranoia's sake we should put a WARN_ON_ONCE(vma->vm !=
vm) in there, since this really should be impossible.

I don't think there's a  harm in backporting this though, since there's a
2 year window between the introduction of the ctx->vm change and it's
complete fix with the proto-ctx work between 2019 and 2021. It's not
realistic to backport the latter and this here is trivial in case anyone
is foolish enough to run such an old kernel.

With the WARN_ON_ONCE added and the above analysis included this is

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>

Cheers, Sima

PS: Caught a cold, brain's not entirely working, this might be all very
wrong so please check my history digging.

>  			vma = i915_vma_tryget(vma);
> +		else
> +			vma = NULL;
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
