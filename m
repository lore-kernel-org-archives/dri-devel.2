Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848101099B32
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 18:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF7E110EAC1;
	Fri, 20 Mar 2026 18:09:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q5cWqo8N";
	dkim-atps=neutral
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 658FE10EB83
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 18:09:15 +0000 (UTC)
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-64ad9fabd08so2158633d50.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 11:09:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774030154; cv=none;
 d=google.com; s=arc-20240605;
 b=ZXCw4NF/LEV/WnkPxhhM0FzkObMLveFXbhH7D8pM8iqHDSshvwe6XzDwWxNXZxvmZD
 47+j//gIQ898NA2HtTOPOTkOsVYVSwLnKKXaxL7fZkuYda9qEFw1LzT8RkEo7nMSLPN0
 2yWvEV+RrAlzP6bu12+BQbN3xG7Pv314w7vBcVCgthCGbd2bqrhwtnJ2N2RsAkRgGNNL
 mknWNmnX5+AKvEgiv1JTaiKuiDZHtB/6x5EsZqaTO5WMA6ACMTJodVjPO47zfR7VQcz1
 HolWX2yAHuw0Z9JwrYeFiPUSCh0SE3PK+xxrFZlM/Q+aECem0b5U9p0BeX6lkoQrCAPc
 /IwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AWhS4iaGoaPOka2Ug+rWFyTKYlbaHwFlyjwq3H7YvsM=;
 fh=maEgNoA+kjflBZXhiWXnD6SyrcztAB55dPhHGEcbXXc=;
 b=VwV7h6i6fTr/h9ok6qZpykaZt4SWgdIegm0SrSKmXbfjPmi7ZUy8Ndbhl1/dRz6BuM
 BPxxlJs1tQAgLL4Gnmjp3aghYCHgeLY45r2we01NOrZLe9ysSHi4NQ3vbHGZ0s38UkHo
 WrUTtdJ8+40ud4yB6ahzsrXY+vDTyGVne7i1mz/YWqY7n8Kq1i9qj7e4FFHF4LtyoQZU
 rot/xQ/dGffMRJuyM/YXtqa1B1XlFONZRco/YM2KZ7hb2thGap68r0+8XbLS7H0CroP+
 44Fx6Lbpato6ZMVwprNzOq1JOvNnsWxacSmBYuyRdguAL1Ku24LCFiEfJLMzS9xhOnb9
 gbAg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774030154; x=1774634954; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWhS4iaGoaPOka2Ug+rWFyTKYlbaHwFlyjwq3H7YvsM=;
 b=Q5cWqo8NPQoOiU7mAU8XFfDwxfZn0n1os4c8lo4CjVg6z3QGqjnuewocQrW7pva4AU
 3N0/1040N9/YRnzd5M/x0CqKEEYoY9aKkk+k5+5cjGFjxgxVLpLwX3HqWa/XO7aC0dF9
 V8e7eOGIxFiOnTQKWN7yVnKT6KWfiweBRbAgcqhiwM5wDsySlyNRxumJ8vdmYPY1ef5G
 Ksf9TzAEmV/v2CyQiyBJsfw+DexSg1VBJ9mGNwum+qZQVMvBOKqA9bpwPLbo+Tja4FlG
 6y6B6VxvTAWVCuvqjcLVXVPhXeNv+KLMyDvDjKbCDBDJCXcPTVz1v49+iP98Os+BdfBw
 j5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774030154; x=1774634954;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AWhS4iaGoaPOka2Ug+rWFyTKYlbaHwFlyjwq3H7YvsM=;
 b=AyMRU8Z8MLDyNanEQb5RNvuoZwiBukb9/GCLbNPkGO0JWYDz0/4JWHNNSHctxrRUqF
 ElKrcA4CLFI2TUCJ+j0AgZMEaL+V+CAi8g8TQPSKUyf+peK3nH1aStNXgA2fEKQstkMa
 R5CNJYh0iIoqspemGDXEK/0KevUZMOXx8ugEYAVlGzW75JUmr3Ol0i0IM0o6rb0u17iG
 KwxYVgQ8LexEGJJFd+gsRU+FiCWDwze86U6O1fJm+Qhb24d8NFjYBApdC6NHG41y5xvn
 QfJqDpFpbTHJ7sKWZy+9XUAAFPQ8HBSgjO0sIH3zf/aQFUABc5Q8XkpR0lt2w7TVUdW8
 IFRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/+QIoPcZ1u4rTwBV1WYzUnFsAmXsrn13q55bNoTwPw/ysXbQCW4oeFZQKWzNEo3/c+DkxK9wQqcY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMyqv0ly07bdGzlYhYoZmQdMHcccAHWvVrQYZk9EWUh4iMV80Y
 AsT7dBlgf+D4J93OFZJ8wCCcFtyTJHpeaCGcu8elJIq4dCfj8palO/pvXlNiTn7FQoqSInoNQAW
 mj0YS8IIniV1Bt2eSiJzdsJ8MTMUilFY=
X-Gm-Gg: ATEYQzxoNqEl1XOy7mimRvG2ZdtP6ljGHA00imbn/3EXSaYFIkvLD/wracBhjeuBXaL
 xpyljL2Wc4oy1xdMFX6WUorqLp+nGePz5lqIEMalNYCbl2af/ZpjKWhN06J9LJ3TvjeZW4zV+5r
 zoINF+oOaAsQeCJ0MBOdNv4qVfwhieOnRyqVbZoY8+Uyne1eiwSi1yePYxpTLWaXIrcOrWqW+HC
 puIfZpx9zgYXorikf1uU4HMMbIpNlpRYeooK8sNtQtN9bLJ1esshGSonCVKuOgMjfjt3COcrEKT
 2SbU
X-Received: by 2002:a53:d7c8:0:b0:64c:f90c:743b with SMTP id
 956f58d0204a3-64eaa764fe2mr3121177d50.41.1774030154371; Fri, 20 Mar 2026
 11:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-33-jim.cromie@gmail.com>
 <177402491454.6181.12972283720507136037.b4-review@b4>
In-Reply-To: <177402491454.6181.12972283720507136037.b4-review@b4>
From: jim.cromie@gmail.com
Date: Fri, 20 Mar 2026 12:08:48 -0600
X-Gm-Features: AaiRm52OI33ofFnw-Ol-4xRbb4iS7hd6Ofimy35v4GvSaV31JzwNtCu7GJCPT2U
Message-ID: <CAJfuBxwnKXG4d92WOOpiXRDXjFrYFnvfbKXaG5nn4nm4pVyqdQ@mail.gmail.com>
Subject: Re: [PATCH v11 32/65] dyndbg: Harden classmap and callsite validation
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
> On Fri, 13 Mar 2026 07:19:57 -0600, Jim Cromie <jim.cromie@gmail.com> wro=
te:
> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debu=
g.h
> > index 0d1245aefc69..28684cfc0937 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> > @@ -262,6 +262,8 @@ struct _ddebug_class_param {
> >
> >  #define __DYNAMIC_DEBUG_CLASSMAP_USE(_var, _offset, _uname)          \
> >       extern struct _ddebug_class_map _var;                           \
> > +     static_assert((_offset) >=3D 0 && (_offset) < _DPRINTK_CLASS_DFLT=
, \
> > +                   "classmap use offset must be in 0..62");          \
>
> Can't you also check the offset+base?

If I dont already check, I can. theyre all constants.

>
> >
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index 2083a8546460..635df6edb4cf 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> > @@ -1404,9 +1404,8 @@ static void ddebug_apply_class_users(const struct=
 _ddebug_info *di)
> >       (__dst)->info._vec.len =3D __nc;                                 =
 \
> >  })
> >
> > -static int __maybe_unused
> > -ddebug_class_range_overlap(struct _ddebug_class_map *cm,
> > -                        u64 *reserved_ids)
> > +static int ddebug_class_range_overlap(struct _ddebug_class_map *cm,
> > +                                   u64 *reserved_ids)
>
> I think you can remove the __maybe_unused earlier in the series (23/65
> seems to use it).

yeah that sounds correct.

>
> > @@ -1454,10 +1471,33 @@ static int ddebug_add_module(struct _ddebug_inf=
o *di)
> > [ ... skip 5 lines ... ]
> > +     /* validate class map types and the per-module 0..62 class_id spa=
ce */
> > +     for_subvec(i, cm, &dt->info, maps) {
> > +             if (cm->map_type > DD_CLASS_TYPE_LEVEL_NUM) {
> > +                     pr_err("module %s has unknown classmap type %d\n"=
, dt->info.mod_name, cm->map_type);
> > +                     goto cleanup;
> > +             }
>
> I think this check could be inserted earlier.

ya this could be compile-time too.

>
> --
> Louis Chauvet <louis.chauvet@bootlin.com>
