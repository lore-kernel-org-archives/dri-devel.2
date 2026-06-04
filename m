Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23641CD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:27:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8598F11A2F9;
	Thu,  4 Jun 2026 20:27:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZH1c7Hd3";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CEC011A2F9
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:27:12 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4906869f0cbso14122305e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 13:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1780604831; x=1781209631; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VeXxm1DQAZQwoMjTwYC+F1mwDMpIzyGSUpqxCZ4AH3E=;
 b=ZH1c7Hd3Zc9XSd1OrfhWUeDMfI4hHvDOwPXg2Bltjb28FZSdqmgc/bZM24boGCEflr
 z6B5N/CagkUgtckTeJ8xnu7ujB4rL3vlE+6ZjLXYjVDEq4W7VyLxPunib1uAAI1CtO3H
 sl4gLSuiJ815L1M041unEQSPFEWM5/CCIgtlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780604831; x=1781209631;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VeXxm1DQAZQwoMjTwYC+F1mwDMpIzyGSUpqxCZ4AH3E=;
 b=rohkzPKvE8Luv0md8zWbna1Ra/xVvek/dnVqN5/S2vftwFDAt7e0juJW201g4wsh7M
 TmS4zZgSbVutQNBj85Acyzt7tnKwXdsFbGHePy9u2OsdxJWlg7n04trKpxGQotKzoWeH
 +q+jnsISy4J2G0Tmct/zuPg47qyc4adgWLliQtiU9PvAx6OOBFm3BQcOR+wcMAZkJ8KZ
 BF2LXSX86IifwwStjpeJUjZL8r9z2sRJzjihILpVkfW96tWqivu8F8NxGj+tGbtOKkCj
 1UswpB0XxHQOJJmAGhy+8XvJJglaNiHvZqHB4i6D1qd8STslERJ8vdoAo/+H7GD8ACBB
 2TDg==
X-Forwarded-Encrypted: i=1;
 AFNElJ88FzHcIKGXrgiFmwGEe3ilXAnqZo4gMGEzveHQj58rdWu1aZzyXGkqx0vQZQVPhDavUTlD5T3xGs4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgCt397CAycoNt2oHA1Cu02Dsk2pBv5lux3WG7N7mHlxlKJTzS
 /52l0RfVBO123acvb9fpq4JqtUdw4gNgSE6GZDA2WDyM9Z6ZJ48XwJdj+/kPv1hNzKTZgKq5Yod
 oMNtNo/g=
X-Gm-Gg: Acq92OENk/qvJhiR2VEpeJmIEbPwsYDNYwflmrKIrrU1SXljSSwWKjbVfuyCR6btWNN
 3fPE6TrrxzbHk2R+ELVd24uctHymcmOf283Cx/a6qGJcaTmTs+UXIXsTlWyQUa3jH2gvWiQt6xM
 foQ8A0O1k6K5Djye4TAgOTssOFja0CLWoinMUoSA3iAQN4AOdNyiWqH047PkGiMg4iFdb00l5X6
 xmikn9tQlHjZ7pBryt+Pg4Ru+ea19ue8fdH+DTw2HEh5ZFBRFmQQ/w6+0lqSbY0qY/N6sfNrfnX
 Icr7qvba/Uh2eD1c7M61Gnr5zr4l/zwE1gqEpl3CkLrVGF0tkG9Sg0W0yXgmlbdvV6wQmW1K1GV
 /qY+230sylb7VjKnrU74q/sEHBBcmjFvI0hVA+/2SahfdmGkQHVAqATHUZ2EnRgesd/4leW2WCd
 OBUEAmSpQzWhhOstAcXltO/zAn/I+JCc/bO/rmRvPc52sSKA==
X-Received: by 2002:a05:600c:1554:b0:490:7dfd:f7c2 with SMTP id
 5b1f17b1804b1-490c25eaca1mr2350615e9.11.1780604830695; 
 Thu, 04 Jun 2026 13:27:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3fcf5bsm109657775e9.9.2026.06.04.13.27.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 13:27:10 -0700 (PDT)
Date: Thu, 4 Jun 2026 22:27:08 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: sashiko-reviews@lists.linux.dev
Cc: Simona Vetter <simona.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/gem: Try to fix change_handle ioctl, attempt 4
Message-ID: <aiHfnHlUboW8upkf@phenom.ffwll.local>
References: <20260604194437.1725314-1-simona.vetter@ffwll.ch>
 <20260604195848.546B31F00893@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604195848.546B31F00893@smtp.kernel.org>
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

On Thu, Jun 04, 2026 at 07:58:47PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The ioctl returns 0 on `args->handle == args->new_handle` without validating if the handle actually exists in the IDR.
> --
> 
> commit c59eb6aaceabfd08a4835d7c2c0133017afcb072
> Author: Simona Vetter <simona.vetter@ffwll.ch>
> 
> drm/gem: Try to fix change_handle ioctl, attempt 4
> 
> This commit attempts to fix a race condition in the change_handle ioctl by
> reworking the two-stage idr replacement logic and renaming variables for
> clarity. It also unifies the object lookup and idr_replace steps and disables
> the ioctl pending testing.
> 
> > diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> > index ac751a42db281..55caad80a3503 100644
> > --- a/drivers/gpu/drm/drm_gem.c
> > +++ b/drivers/gpu/drm/drm_gem.c
> [ ... ]
> > @@ -1028,52 +1028,36 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
> >  	/* idr_alloc() limitation. */
> >  	if (args->new_handle > INT_MAX)
> >  		return -EINVAL;
> > -	handle = args->new_handle;
> > -
> > -	obj = drm_gem_object_lookup(file_priv, args->handle);
> > -	if (!obj)
> > -		return -ENOENT;
> > +	new_handle = args->new_handle;
> >  
> > -	if (args->handle == handle) {
> > -		ret = 0;
> > -		goto out;
> > -	}
> > +	if (args->handle == new_handle)
> > +		return 0;
> 
> [Severity: High]
> Does this new early return skip handle validation?
> 
> Previously, drm_gem_object_lookup() was called before this check, returning
> -ENOENT if the given handle was invalid. In the new code, if a user passes
> a non-existent handle but sets new_handle to the exact same value, the ioctl
> will return 0 (success) instead of -ENOENT. 
> 
> Should the handle existence still be verified before returning success here?

Since the igt for this ioctl still hasn't landed I don't know, either
kinda makes some or little sense really since why exactly is userspace
asking for this. We could also reject this case as a userspace bug with
-EALREADY or something like that.

Either way this needs to be nailed down with an igt, which really, really,
really needs to land this time before we re-enable this all me thinks.
-Sima
-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch
