Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9451C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 17:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE19D10E143;
	Thu,  3 Sep 2026 17:27:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="HZG2zrne";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D57B10E143
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 17:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=omSdGrzgptFKkaEboQmH9m/MCMMwI+CK/RTEyIElEGw=; b=HZG2zrneaLyVIxkBm0ceTXM/+k
 J5bCUkcq+0XdaiZxfkEGS5UXwWA4M0R9P5AZFqI7yNmhFHZHNUoxwLaZspcwUZcMUVncXnswPJc4O
 d+0dH/bsJ+/RgoxcUYCIWIF4xm3/Joz57c0xVBSo7rS8Fg/ro4RErusQZJxHkyb7wyCvCt3Z9sZ56
 /3EUXJAUmWgWERcKguFLfps0PTYGPv769cY5XN3RUWMFnfIUqoil3LiM3CiA/Xv9dWYaEzXJW8UJ1
 LnBVHWNtmdF+YVrLH8JRKEevDCH8UhyQ0tRO1mO0gn0HTOEdEuDDwNazFTLvomAG10yqg8iHxrHDy
 BcyC+0ig==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1x2BE5-00000000H3T-3emx; Thu, 03 Sep 2026 17:27:49 +0000
Message-ID: <9e53e154-1b4e-49f4-a028-a50af0fbadf3@infradead.org>
Date: Thu, 3 Sep 2026 10:27:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/gpu: Fix spelling mistakes in todo gpu doc
To: Hardik Kumar <hardikxk@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260903-docs-gpu-todo-v1-1-be712c8f67a0@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260903-docs-gpu-todo-v1-1-be712c8f67a0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 9/3/26 10:04 AM, Hardik Kumar wrote:
> Fix some obvious typos in the todo.rst doc.
> 
> Correct spellings of incorrect words.
> Fix an article usage.
> 
> Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
> ---
>  Documentation/gpu/todo.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
> index 14cf37590..187932554 100644
> --- a/Documentation/gpu/todo.rst
> +++ b/Documentation/gpu/todo.rst
> @@ -277,8 +277,8 @@ Various hold-ups:
>  - Need to switch to drm_gem_fb_create(), as now drm_gem_fb_create() checks for
>    valid formats for atomic drivers.
>  
> -- Many drivers subclass drm_framebuffer, we'd need a embedding compatible
> -  version of the varios drm_gem_fb_create functions. Maybe called
> +- Many drivers subclass drm_framebuffer, we'd need an embedding compatible
> +  version of the various drm_gem_fb_create functions. Maybe called

LGTM except for the comma splice above, which you weren't
attempting to repair. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

>    drm_gem_fb_create/_with_dirty/_with_funcs as needed.
>  
>  Contact: Simona Vetter
> @@ -303,7 +303,7 @@ everything after it has done the write-protect/mkwrite trickery:
>  
>        vma->vm_page_prot = pgprot_wrprotect(vma->vm_page_prot);
>  
> -- Set the mkwrite and fsync callbacks with similar implementions to the core
> +- Set the mkwrite and fsync callbacks with similar implementations to the core
>    fbdev defio stuff. These should all work on plain ptes, they don't actually
>    require a struct page.  uff. These should all work on plain ptes, they don't
>    actually require a struct page.
> @@ -465,7 +465,7 @@ be turned into a WARN_ON() or somehow made louder.
>  At the moment, we expect that we may still encounter the warnings in the
>  drm_panel core when using panel-simple and panel-edp. Since those panel
>  drivers are used with a lot of different DRM modeset drivers they still
> -make an extra effort to disable/unprepare the panel themsevles at shutdown
> +make an extra effort to disable/unprepare the panel themselves at shutdown
>  time. Specifically we could still encounter those warnings if the panel
>  driver gets shutdown() _before_ the DRM modeset driver and the DRM modeset
>  driver properly calls drm_atomic_helper_shutdown() in its own shutdown()
> @@ -891,7 +891,7 @@ Querying errors from drm_syncobj
>  ================================
>  
>  The drm_syncobj container can be used by driver independent code to signal
> -complection of submission.
> +completion of submission.
>  
>  One minor feature still missing is a generic DRM IOCTL to query the error
>  status of binary and timeline drm_syncobj.
> 
> ---
> base-commit: 66498c75b4f8017f62d720d9b59675bdf3abce91
> change-id: 20260903-docs-gpu-todo-31116c645874
> 
> Best regards,

-- 
~Randy
