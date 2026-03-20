Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6562C1099B2D
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 18:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEEA710EADF;
	Fri, 20 Mar 2026 18:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h+5GLWM7";
	dkim-atps=neutral
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B83DB10EADF
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 18:04:02 +0000 (UTC)
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-64ad79dfb7cso2931161d50.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 11:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774029842; cv=none;
 d=google.com; s=arc-20240605;
 b=OwkHcPNSqZouadPhP1zkus4A9+RqYfEDU+2wmx9jiYjRaNt+AhouX9UX1dgt9ql2LN
 x65p2rWk1+QfSMmsa+RfWSBTBEkltW2yYX+AN7hNtiRL4UxobuATMlwsCql+uZ4H2sUe
 /g5ijvAQ36ctUXgWxfrO4C1yTTCLdsWfuEtEpd2B6vqvRHPfm2FDMfxxhQSGq04K+JP2
 KDGCHLI6sgxe/KKgGUEwFp15GBdTXq8PV5gEJhlBMdUUa8Wr2lPULlmPSTAkKjxWcf5Q
 cwUL2F2284yHntPZNilAsTqFRdRW2TX2NaPo7DDD2ui0ePyHFbTKhkh+7Ri8mzXxpYWr
 fReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=n0ReudbBcJ1VWJQ8xSvYlWUHawfsvlE3jFdIh1UvDJg=;
 fh=3JAq+KsIFogkMQaVHqCVxqq0qwsA1FfjLvuAC8aZNOU=;
 b=NjBK2O24yLHZk3Ol8ZTnhwZaBJc7+2qcGbFByzUQh2cD1lY2mjBUR7/gZdY38IsHVT
 MXFb5iKoZpdmFi1zl4Of1sKNpFMi7UQt/uqp7yJEbX6gmTv7JuRixPtjGCai6gd0pBuh
 in/rUNA8kiFPOZrrNlySTqO3g1GoxHUimdh2d77CQyehLsFmXDTMOpb37NA0KnD1vcLB
 4R0Lcj+657eu329lykW3zJaDkHSXa0oY56HUK4OPlJMEBPpqO1KBDyqcRy2nWuJzSG6c
 Fk6VD74qf+isM6SrdHKHhgZEVPbAP+nf4LS3Ss/7e8mPdAyUkw1vdm4nuMtvudgVQ7uf
 fqsA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774029842; x=1774634642; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n0ReudbBcJ1VWJQ8xSvYlWUHawfsvlE3jFdIh1UvDJg=;
 b=h+5GLWM7gOz6wIV5N+PjMYBSto7oRLGWGaLrjUv4foO+8Eg7YmRwD3oc+T/saNv8OK
 2X/jZgLY+jrbBh61GzsZn2pUN3FwI7xDhcvjUkRHqX6ZEVqI6DbOh+JUpZ0U74L8Blky
 lgiY6xHshv3fhU5Jca0ADOaRaZqzNWyUT3UgHEQmCh6CFoA9Js5NSFujBfhmXzZc+uum
 67oA2f/mVvBHcpHBaWU9Zk+kkXBdQQh4/IIcagPgez6e4CdnR7GwCBmBUqA6MT/MLHM+
 H+xshFNwQWXhaZmOnfGJp6oTrkmMKmhdh0dZOWj0K2ocAwTma3mpOFBXbQPuXC4+pT1u
 ImjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774029842; x=1774634642;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n0ReudbBcJ1VWJQ8xSvYlWUHawfsvlE3jFdIh1UvDJg=;
 b=CxiqHxp4Cdi07BVbDo0CuLpLwnkq9sDXKg5BJffqdnM6k/URXXN+uIKfUEi22pMdvm
 koAf5E07oB8TfJqaNFDo5rSiAWXbXufs9Sbjvwflm1GO1dPxiX2VIThYMtRQ98Q7BsRT
 p0bh93Xp342GBSw5mAX1zc/jZSejoSJIVAvxhUNdMGw6mZq6HWxVri4prp1fCJuKKVh3
 Im6vA0bgPy9dD47afMzjbK/Zz7j1AWGlaPhm/9zOXP4Svmo4kNbFkomt0aTiNpC1oJX4
 KbZAawWAbQjJIioPOdWJW3xKwXGZPghpSsaBY6sNuMCKrGLgDDMUet6hNPgnuaX8t5a3
 jreA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoOTBMCcO4eGojaCYwYEFdLEKhrJFTCcIYXNDvj4cAeOSjwrvtb2APddYcXMWtQMQ7F/yJAX/XqXA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyxrGADZqQbK46FKM+S05NB5TsTr3bYm/xsOGJp4lhsJAzvimIK
 D/k4VfoKlSeUMg4I2cyk7gqAte3sUco22W5k4NYtj7jd7nOHd1dZYRs2bVyb9bLpglGavX+ejKr
 8oKHhDrb8VGE5J8QXycesQKkmkjpOVA4=
X-Gm-Gg: ATEYQzxGkW8W9A6enuSO+vYP5Gedr8ozEMf3bzx1PT5HJExqE0VL8OAnp7WZXubik65
 u/2Kmc7RJsmjI3XsunS/uvB0ERpYe/1hUiHnOdLKQQJkPxTQJf0kSbrPulmEGM0KT7mFTVwgzjG
 9QOCevE3JulBZ/GsYvOZ/t5wlqqkI83M4POfwbB8MEcs//RKji30KXzrlh9VspMc5VCDc6BRlhX
 glIYfXzmuVv/bU15Obw+7m/bQnDbRlWGBBHvuKRrGCMFqiDCH6LKgc7yK/CBuXfqRBE4zPMe2ab
 VESL
X-Received: by 2002:a05:690e:74e:b0:64a:ce9a:ace2 with SMTP id
 956f58d0204a3-64eaa7f7bc9mr3212110d50.56.1774029841504; Fri, 20 Mar 2026
 11:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-32-jim.cromie@gmail.com>
 <177402491451.6181.5247342952148189934.b4-review@b4>
In-Reply-To: <177402491451.6181.5247342952148189934.b4-review@b4>
From: jim.cromie@gmail.com
Date: Fri, 20 Mar 2026 12:03:35 -0600
X-Gm-Features: AaiRm53l_YjOB-S5RZgL9xPfAK8bYaoK2HLT6VSg9ZSzbMdUrD-RUBzNTMJmVgQ
Message-ID: <CAJfuBxx748fTNk51joPgCUTqd8PmTG-mwp0YL3gTSzcnu5w8KA@mail.gmail.com>
Subject: Re: [PATCH v11 31/65] dyndbg: add
 DYNAMIC_DEBUG_CLASSMAP_USE_(dd_class_name, offset)
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com, 
 gregkh@linuxfoundation.org, mripard@kernel.org, tzimmermann@suse.de, 
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com, 
 ville.syrjala@linux.intel.com, christian.koenig@amd.com, 
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com, 
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Mar 20, 2026 at 10:42=E2=80=AFAM Louis Chauvet
<louis.chauvet@bootlin.com> wrote:
>
> On Fri, 13 Mar 2026 07:19:56 -0600, Jim Cromie <jim.cromie@gmail.com> wro=
te:
> > [...]
> > cases; perhaps a 3-X-3 of classmap-defns X classmap-users would get
> > too awkward and fiddly.
> >
> > This is an untested interface extension, so drop this patch if it
> > feels too speculative, knowing theres at least a notional solution
> > should the situation arise.
>
> I agree on the patch principle, the implementation seems good.
>
> Can you move this patch after the BROKEN removal? I think you should
> "stabilize" core features first so we can merge part of the series (and
> reduce patch count).
>

I'll do this.

> >
> >
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index e9fa0c8868db..2083a8546460 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> > @@ -206,12 +206,17 @@ ddebug_find_valid_class(struct _ddebug_info const=
 *di, const char *query_class,
> >       return NULL;
> >  }
> >
> > -static bool ddebug_class_in_range(const int class_id, const struct _dd=
ebug_class_map *map)
> > +static bool ddebug_class_map_in_range(const int class_id, const struct=
 _ddebug_class_map *map)
>
> (that the rename I mentionned earlier)

I dont know what you mean here.

>
> --
> Louis Chauvet <louis.chauvet@bootlin.com>
