Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01D5E9DE6F
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:11:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFC0610E778;
	Thu,  9 Apr 2026 09:11:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="YkWeiO21";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A4D810E779
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 09:11:44 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-43b8e8e7432so550751f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 02:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1775725903; x=1776330703; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+5wz/BvjEDMd/4gYUrDrwtdKo1HH0lx8NLd29v9vbXc=;
 b=YkWeiO21oFLzHXFrg+mZMErPee5T/rVPJljtVLpAsfiQi3bNSL9uJkKNKHHVkF6YEY
 D8tsjqEsWahon3aG0pdPT/7FouARpzt2i2hEkGyThWYvPX4FaxOPbYVKMqhvu7X19NU6
 R34A1GWAXMi9i7wmSW14dezrYjsnrSHN1+QqSEcOSRRaTOaJ7e7IQMQ4e4mf7IAgTgtD
 O8aI9syJbDhrZDKSkVGgXdb0jHwhBkCK4xeYbARi0CAIAgULJQyul8Xr/au1r088flAZ
 cNW+btCLjm6Z/E9fHVWTTez0b1xFU+oeaory7ySFjKA4Yl/DbPmdAhfDwmDASWveK43X
 AMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775725903; x=1776330703;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+5wz/BvjEDMd/4gYUrDrwtdKo1HH0lx8NLd29v9vbXc=;
 b=dtYXUFc2Zs5r7T/0fFYXV/QsG1KQd4U9bkW5qDSI/A3xTSyED7HoHw4wU9Xhohqs3y
 MAE+v6JxmksGTGMOCCTmyeUDGTyAcn27/RBShsRsxJ1iF6vR95EG6xI5OYz/UzYRAg3U
 hroLaG6PwUTVJOI+KygPYcQz+9DqPuYqhkm/hkYcgsCLwav07WRlAxGg/Q2Vio1ATYlU
 AtLlE4NnXYmLaCQgeWzurYsau9PIyTQDrifYK/Cj1sn0yYEPtSE0B//x6nkvPA7TKDZ+
 2QWXDHK4+WUKomrqDXkxxwUyFhbGtr61MmOyf81g9RO4lJ7iFiMyTNRxS6dnaJ2mnSmr
 ZY1Q==
X-Gm-Message-State: AOJu0Ywf7BtrQZLq1lO67PexY81YJ8nzlGpWxjk1tfcXFOCabrCyTnlr
 aHlY4IyWOs3YUPparv4dYdHx+79uu52yrW2Cmvac2ku7NS+jpSf7QQCGvkE3B1zVKSUyXt57VpW
 YEcKcaLI=
X-Gm-Gg: AeBDiesW1Dp3VK5uSLMtrQ0IOn/HB5tLgoc25pWtniK2+nG8+2bLfcaK9UV/Uemy2Py
 83nZ4vvTlyjcC/rSfPgcXYlQ26blm9kvmVITkrNcIJ6y7sdYEb/27HND7BhXKirTMHAgPUBB2Eb
 o6N6GhM/piH0dRTuoTZvDqvII3TAr+8kmW57cB1zttmhD06Vc5TSQqFkR3aGdamf3/KCWjilh2a
 JB3PX3GiYwdJN8xLsG/8xplFzic053t3tKtz4clYHZ46oW8e41T12R00qyCJIPJLTRR+6vWwIqI
 Hwuauz0siseSmbtImnOQTM8tlaZ3OaIsgcavyjZgFDpJi0kTc10sleHiwml/DTtaqwnZoDzun/O
 Orzo3bDEFz+NBiGX37Hl9QV8fZ7uJ4sxH5IRrjXePz95GDIcR62yGnl3MB2e2bRO00jWxpRROyY
 ygmDejxzokO5+sznNGPSwBveiAP0fv/GnJs98AQKNraTbO
X-Received: by 2002:a5d:5d08:0:b0:439:b8b2:fabc with SMTP id
 ffacd0b85a97d-43d292a9581mr35950478f8f.21.1775725902114; 
 Thu, 09 Apr 2026 02:11:42 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4e6224sm66188510f8f.25.2026.04.09.02.11.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 02:11:41 -0700 (PDT)
Message-ID: <b8d02a4c-e20d-4814-8ba3-eaba6b701b6f@ursulin.net>
Date: Thu, 9 Apr 2026 10:11:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/i915/gem: Drop check for changed VM in EXECBUF
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Intel graphics driver community testing & development
 <intel-gfx@lists.freedesktop.org>
Cc: Direct Rendering Infrastructure - Development
 <dri-devel@lists.freedesktop.org>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Simona Vetter <simona.vetter@ffwll.ch>, Andi Shyti <andi.shyti@kernel.org>
References: <20260409053111.8914-1-joonas.lahtinen@linux.intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260409053111.8914-1-joonas.lahtinen@linux.intel.com>
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


On 09/04/2026 06:31, Joonas Lahtinen wrote:
> Since the introduction of d4433c7600f7 ("drm/i915/gem: Use the proto-context
> to handle create parameters (v5)") it has not been possible for VM to change
> after context creation so the check will never fail.
> 
> Sima's analysis:
> 
>    This check was added in f7ce8639f6ff ("drm/i915/gem: Split the context's
>    obj:vma lut into its own mutex") but without any hint in the commit
>    message as to why. In another hunk of that commit there's a hint though in
>    __eb_add_lut:
> 
>            /* user racing with ctx set-vm */
> 
>    This would mean that this bug was introduced in e0695db7298e ("drm/i915:
>    Create/destroy VM (ppGTT) for use with contexts"), which allowed to change
>    the gem_ctx->vm at runtime, opening up the race that was partially fixed
>    in the earlier referenced commit about a year later.
> 
>    But it cannot be exploited anymore in anything remotely recent because
>    with the introduction of proto-contexts we've made gem_ctx->vm invariant
>    again, exactly to preemptively close all these potential issues.
>    Specifically d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle
>    create parameters (v5)") is the vm specific part of the proto-context
>    work.
> 
> v3:
> - Include Sima's analysis and WARN_ON_ONCE
> 
> v4:
> - Focus only on latest mainline codebase
> 
> References: https://lore.kernel.org/all/20260324151741.29338-1-sosohero200@gmail.com/
> Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Linus Torvalds <torvalds@linuxfoundation.org>
> Cc: Simona Vetter <simona.vetter@ffwll.ch>
> Cc: Tvrtko Ursulin <tursulin@ursulin.net>
> Cc: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> index bd608cea396f..621f07a55c38 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> @@ -895,7 +895,7 @@ static struct i915_vma *eb_lookup_vma(struct i915_execbuffer *eb, u32 handle)
>   
>   		rcu_read_lock();
>   		vma = radix_tree_lookup(&eb->gem_context->handles_vma, handle);
> -		if (likely(vma && vma->vm == vm))
> +		if (likely(vma))
>   			vma = i915_vma_tryget(vma);
>   		rcu_read_unlock();
>   		if (likely(vma))

Analysis reads correct to me.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

