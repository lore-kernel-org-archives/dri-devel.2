Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC4ECA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:03:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EDEB10E2E0;
	Thu,  8 Oct 2026 10:03:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LSR+N6YB";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBAB310E2E0
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 10:03:32 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a061a13884so24176595e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 03:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791453811; x=1792058611; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/z+e+2G8R9kjk4W08xr2uI7ifrsGMZWDh/5vOBTpZuM=;
 b=LSR+N6YBxDRj2vTybD5cM3a7uzv/1Tt4o/NrV2WmlK6fS+3wfLbOSowL7O/hLbUdO6
 ckOb62y+zzwwAafUbWaxdaybnPJZB4GyZ3wWEAjJEFXPI7nuUtnfuuCaTxTz4y7j6Q5d
 1g++uObwg48Ud1Huvq3vEfpvCB+Eiv4acYrNaa1kviYDN7haTMU8YG26898nGMvzdvgo
 OUtvWpMbQjFx4bzQTm1jWqdMZ4ALn9Yw3RzGdgink3MQ7s0GczP6fybIej1S4xyPXhCy
 wPVxuNwcZFSAW68jnbl2fiixOdlzZYIIbiQq+Y98RR0TI0C2rz3LKrP901BgMBKP4Cmu
 dLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791453811; x=1792058611;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/z+e+2G8R9kjk4W08xr2uI7ifrsGMZWDh/5vOBTpZuM=;
 b=s0Ci09CejKHhPi5UZt4oKCl4yNsU3pKq9yjHPf4T+i0L5zFWdUmqfrJB/RFdcAvOFG
 riigqeKz6OalgLQd4VtpFNrINOqf4CE2FagROPKi14e7981fLCQfuoL8fmXHl+GMC7Cq
 6BPKRot0eVMJnUvqtE5a3IleXjI3ZcYknM0h30bCn6RgiUk4KR3Uov4+uK3HA79Afqvi
 r/QIP/arZmLvx+NWehwyRgDffoDIIbbot9s7WhIL3p66JRnffK28K/Az2o12QNE5UaNg
 kgIHzhWDqcrZLdwqQZisRkO2eV/U98doY/zdpfC5SuJZnIR6ObaxKAtHdm1hd9m4dBOm
 poeg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2pzElnrs9yfF3DdW1On7F+x+KD5OBnj+6ymi/H1R5DQo1nYkw6rnNbGzvHD8c+qtGWE3VAVG+2r8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m5+nHNrm81IfT0yfs5Ms25X/mBo8wrK2tjpQ902eg7b40ifEra
 qIJeJs9+Btj2XWYwpMlEnDaK6CDiDlyx907taGYaQEL3kEAdQmu6C57T
X-Gm-Gg: AYBFou1B8DuiN5HEK0wau1WNfcMOz0uw2gwPCXJqzR8qtLHfUVziyseYyM3M1W6pE3p
 J3IDwAZHfnHcqxDbkBvLn1DJZLTVDGOVZnbDxqSXQhdcEgJjBgts4OEIOnFPjfWCP1ZlwDJlYMD
 REEewnJVI/Ucr1XSO62nrYEaG3neH8cGsoV9tkRVCcyyK3FunNGtzN8ZoHPlBWgzMnAKR45vZK4
 5Bw6SEoyn6vijM6y9Pzbjgn4G/TXP2G7UoG84y+EQn3YaJIMYfjg9ef4XiHvzYdDyuhdHXn0iu9
 S6W2ubbZdH/QbeusEjlzM+HZ9mXZtNnzLs00QyRVZF8uFm0WkLL8SBzjjO1WIg6zmRKW9B5UuoP
 r0VEt2OAY5dvVVP6ZQdzUyr34e94FUevtAQm9J5J3DZdUqqyMuRQpCLw9gf1O264xiguYA9xHEF
 lmmgkoP3Y2tO64MQNcNIe5jf/CNLg5hqKa5RwKCsDB7UTJsIlK/m98YCGy5pBjWSV8spATv3+PQ
 UEbKbbHEWeCMvMiBqHe+n2wY4oMXg8J
X-Received: by 2002:a05:600c:19d0:b0:4a0:1f51:ba2d with SMTP id
 5b1f17b1804b1-4a18045373dmr81270255e9.22.1791453810672; 
 Thu, 08 Oct 2026 03:03:30 -0700 (PDT)
Received: from osama ([2a02:908:182:d1a0:b456:28a3:bd59:abb6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d04c0fsm10290146f8f.10.2026.10.08.03.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 03:03:30 -0700 (PDT)
Date: Thu, 8 Oct 2026 12:03:28 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Akash Goel <akash.goel@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Fix TOCTOU race between GROUP_REGISTERED
 check and erase
Message-ID: <asdqcHJDL6PzQ7gk@osama>
References: <20261007181220.2418060-1-osama.abdelkader@gmail.com>
 <asdaHi1t7i721Xfn@e142607>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asdaHi1t7i721Xfn@e142607>
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

On Thu, Oct 08, 2026 at 09:53:50AM +0100, Liviu Dudau wrote:
> On Wed, Oct 07, 2026 at 08:12:19PM +0200, Osama Abdelkader wrote:
> > panthor_group_destroy() checks the GROUP_REGISTERED mark and then calls
> > xa_erase() without holding the xarray lock across both. If the handle is
> > destroyed by another thread in between, and a concurrent GROUP_CREATE
> > reuses the freed ID, the first destroy erases and releases the new,
> > still-initializing group, leading to a use-after-free in
> > panthor_group_create().
> > 
> > Do the mark check and erase atomically under xa_lock().
> > 
> > Fixes: eec7e23d848d ("drm/panthor: Prevent potential UAF in group creation")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> 
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> As Boris mentioned, please let us know if LLM has assisted in finding the bug or in
> the creation of the patch before we can merge the fix.
> 

Hi Liviu and Boris,

Thanks for the review, an LLM has assisted to find the bug but I created the fix patch myself.
I think I have to add the tag nevertheless.

Thanks,
Osama

> Best regards,
> Liviu
> 
> > ---
> >  drivers/gpu/drm/panthor/panthor_sched.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> > index 0493858e55d7..a343c5180e01 100644
> > --- a/drivers/gpu/drm/panthor/panthor_sched.c
> > +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> > @@ -3770,12 +3770,18 @@ int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle)
> >  	struct panthor_group_pool *gpool = pfile->groups;
> >  	struct panthor_device *ptdev = pfile->ptdev;
> >  	struct panthor_scheduler *sched = ptdev->scheduler;
> > -	struct panthor_group *group;
> > +	struct panthor_group *group = NULL;
> >  
> > -	if (!xa_get_mark(&gpool->xa, group_handle, GROUP_REGISTERED))
> > -		return -EINVAL;
> > +	/*
> > +	 * Check the mark and erase the entry atomically, so a concurrent
> > +	 * destroy + create can't make us erase a group that's still being
> > +	 * initialized and happens to reuse the same handle.
> > +	 */
> > +	xa_lock(&gpool->xa);
> > +	if (xa_get_mark(&gpool->xa, group_handle, GROUP_REGISTERED))
> > +		group = __xa_erase(&gpool->xa, group_handle);
> > +	xa_unlock(&gpool->xa);
> >  
> > -	group = xa_erase(&gpool->xa, group_handle);
> >  	if (!group)
> >  		return -EINVAL;
> >  
> > -- 
> > 2.53.0
> > 
> 
> -- 
> ====================
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     ¯\_(ツ)_/¯
