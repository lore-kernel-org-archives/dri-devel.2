Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE88606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 00:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h3uzm3Z9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54C1110EDAC;
	Tue, 27 Oct 2026 00:15:55 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9081F10F1DE
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 00:15:49 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-8b0dba37a7fso29963917b3.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 17:15:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793060148; cv=none;
 d=google.com; s=arc-20260327;
 b=WtcEZ0ZCgt3z47FAgNtBYGlBAZDliwe2C9h0voNG8QUvOiaUDkJJmbPqsLsjS1WD9r
 Hwh2vjGvEfyXt/qvaiulCzeOWTfFsYkHifZaFY/Wtt5klQJNSh+/pa/KSoIzdNyvAgtO
 10vDUs31PwXy1Y3Rr+PRjR5LoDIhDPLZoTRODhdIaa0/dRgBhCej9z2O0HwV93D1Gy+m
 b7B0QuMbPYszj3tSW5VgVYHUnLv060ST7d6bLs8GhZIxIRciBmw3c7laYONAXqeVlItc
 t80zqIDVVSJCx8klIWg8IHL5KA4BwK4xrMC91tFUIeXcSEJEo/r+xvuRaZfIw4GQUpZw
 IgvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qKeQmKdHS147YBCUhe6/TQHxqYO/kgxJinnL8fZRSJA=;
 fh=h9tpSRPjWnGwVMrKsGZeOJaxHZ1sfEXZeW8uVOI0Mho=;
 b=GrYUaac76JkB99rlEoFSndzd4G8aBRtx6Bcaj90XUK1ecySwuagJv2KCyv1E++KPYn
 LKNzLZbtcXHEGM1DtW//T3pB4O5YJNE+SDnJ+aCPMT6YpaXarzxJy97lvcaxU3l6iCLQ
 LcU2lfz2V0RUNpEDYaWt12kLwW2RVfh6JCcWSkSnfibF5U9dMzCAp0QG02NHnKGvnOH/
 odrqZ1zaiE7M5G6j5Zca6nF3r8Z7uLM56zTqIgpOLvLtPo1QvLqRf6+mmbz9KqFbgB9N
 qyB31pDBR2d2ljbWbtL+DcoPkq+uF8gJ8s/DB54IMr1kUSiM+eY/OKfwRCFkgMZCnuco
 MmOA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793060148; x=1793664948; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qKeQmKdHS147YBCUhe6/TQHxqYO/kgxJinnL8fZRSJA=;
 b=h3uzm3Z9LPvmyPmgKXSlsEQd3ItgJ1e+p2vPnwDa8l2vkhpNE1FPAA5tHJ9WRzu0JX
 5Gj8LQt1bkh9b0H3RzrCvSeHcPPHb1hBQE0wTiMvZfVX37/MdxffEjDoJJDGKO+SD0Yt
 oEATAsAcWYAjrn/9tBHgN+Gho8wjoZeO3ARzIKKqndgWF0RFwAA/vvI1ZCm3RBQD/atT
 HLH82zzaW0rFw4An8elvvO8734mLrnhh8cpSKY1L/mnNJ/BRWOZZNVlXOZHbtN0ULKZ+
 OFuZW92QQXpqM+AoBrqYbCBnKUK6LtxrabHnbs//T/UEpZPHNIyRJ85c77O9v7qlwzVy
 y/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793060148; x=1793664948;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qKeQmKdHS147YBCUhe6/TQHxqYO/kgxJinnL8fZRSJA=;
 b=Vo1rSLwzvy54aX5D8FhGsUA/gb+2EU98nIE4+/zELefytnwyt3WXjZsdTcpRwqAXSZ
 TmGl5pG2Cr4PteFnEsu+hrifejVg2WVFCgipv3Jr5BTTdWcvshaFesdbfotDDZfYvUZ2
 mvnzLoItBaQyFBqoxtAjfnFL0C+SLt2HxIBzNNE62Yan4HbokG1FHlniYG/QSAVnIk1v
 A3JSXUrdnlOA7xjDQMi7WPau4GyukW55RKteHzyaHPsigynvbPNzlno/J7X6crVoqM6C
 xn0xqm5+Gspyh5HkVsqC/4POTYN/c7j1XJyAVrvBzGIMAlwXubtNRWpNNT6wVWKO9ZKl
 dbow==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJgjJKiYGoTPZSJNWEkYG6j6db5Zd82tLl1EDzEuVo49zyBwpULOPuP62XuMYGFhbHBUh8kPphL3g=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIjrE9sVCLnqo3HjFA+huG6FxvEW/RCNB9tj9x1RwYDp92FSx2O
 uVTA5kJnhF0I7YJIaPjP1BKZ2o9t9OtvBDh+I3B15AnQfzLCN6kcqdUUwsC8rmYp2yb9XYpahDw
 WM4ef8dWNh+XX7aCkhXogAYiaLeyP5Mk=
X-Gm-Gg: AYBFou3NeqzogUv4so+kHTlBB4dFVqis6XYXxu1S+bOaINqh2CqApLknnVWvd2LNiIM
 rih24+ywuzZAjLan+PzqcsxQ/+kkSga5GhB0464+Is8BTyN53lC1w+/ESzSAOicWMIpWLnzYO/m
 otRlfCZzPkSo546ZoX4vau6qgHlTikX0GWjaAZUbZ4Q0za7WY0xu05TjISVv3I3rbvgmcsWzsFD
 Xc7T1syh+WRuQ8Ue9klqmGsTiXflgM0RMLgICvWo5/bUx+vypbvH/MuzehKIPEsaaF4NWzGIh4e
 fI+DcgmBJbyCPi7kxpCZ4L+LT1KCmdoziwaRl7EZUXUtWgtevBSFcFTlyJBxmogGIdsuzqgPOb6
 2dqju9mWvMKiMe5YZIK7mTR6rNMPKUhRGOx2aaPppTqx6czfkurDelkpPsJkMCvFBVE/SW2rj9R
 6IZSDjztVRgGCUpjM=
X-Received: by 2002:a05:690e:150f:b0:679:c803:98d1 with SMTP id
 956f58d0204a3-67a45496c6cmr4080476d50.152.1793060148265; Mon, 26 Oct 2026
 17:15:48 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
 <20261012-dd-cmap-part2-clean-v12-33-3c8cc5725def@gmail.com>
 <as4W9hToBqAvbzJ-@pathway.suse.cz>
In-Reply-To: <as4W9hToBqAvbzJ-@pathway.suse.cz>
From: jim.cromie@gmail.com
Date: Mon, 26 Oct 2026 18:15:21 -0600
X-Gm-Features: AclHuK9LH_u23sCYiYKMz0I-9md-phfbwb6JA9KZbhXjHlVRGYmTapsg8H2JBYc
Message-ID: <CAJfuBxw-cq3AYXKZ07Y3732tDM-NYxt+rs8Fz6S=P7+1TF5WNA@mail.gmail.com>
Subject: Re: [PATCH v12 33/40] dyndbg: Ignore additional arguments from pr_fmt
To: Petr Mladek <pmladek@suse.com>
Cc: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@net.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nsc@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, 
 Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Philipp Hahn <phahn-oss@avm.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 13, 2026 at 5:33=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Mon 2026-10-12 20:37:04, Jim Cromie via B4 Relay wrote:
> > From: Philipp Hahn <phahn-oss@avm.de>
> >
> > pr_fmt can be used to add a common prefix to any output from a module:
> >       #define pr_fmt(fmt) KBUILD_MODNAME ".%s " fmt, __func__
> >
> > But adding additional arguments breaks dynamic debug:
> > > error: macro "DEFINE_DYNAMIC_DEBUG_METADATA_CLS" passed 4 arguments, =
but takes just 3
> > > |         pr_debug_ratelimited("%s", "Hello world!");
> > > |                                                  ^
> > > note: macro "DEFINE_DYNAMIC_DEBUG_METADATA_CLS" defined here
> > > | #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)       \
> > > |
> > > error: =E2=80=98DEFINE_DYNAMIC_DEBUG_METADATA_CLS=E2=80=99 undeclared=
 (first use in this function)
> > > |         DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT=
, fmt)
> > > |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> I wonder what this error about undeclared macro means.
>
> > > note: in expansion of macro =E2=80=98DEFINE_DYNAMIC_DEBUG_METADATA=E2=
=80=99
> > > |         DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));    =
     \
> > > |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > note: in expansion of macro =E2=80=98pr_debug_ratelimited=E2=80=99
> > > |         pr_debug_ratelimited("%s", "Hello world!");
> > > |         ^~~~~~~~~~~~~~~~~~~~
> >
> > Add an additional ', ...' to DEFINE_DYNAMIC_DEBUG_METADATA_CLS to slurp
> > any additional argument, which `pr_fmt` might add.
> >
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> > @@ -351,7 +351,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor=
,
> >               dump_stack();                                   \
> >  }
> >
> > -#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)    \
> > +#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)       \
> >       static struct _ddebug  __aligned(8)                     \
> >       __section("__dyndbg_descs") name =3D {                    \
> >               .modname =3D KBUILD_MODNAME,                      \
> > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > index f594c1266bfd..5d701952e739 100644
> > --- a/include/linux/printk.h
> > +++ b/include/linux/printk.h
> > @@ -742,7 +742,7 @@ do {                                               =
                       \
> >       static DEFINE_RATELIMIT_STATE(_rs,                              \
> >                                     DEFAULT_RATELIMIT_INTERVAL,       \
> >                                     DEFAULT_RATELIMIT_BURST);         \
> > -     DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));         \
> > +     DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);         \
>
> IMHO, this changes the existing behavior. The prefix added by
> pr_fmt() will no longer be stored in DEFINE_DYNAMIC_DEBUG_METADATA().
> Is this intentional, please?
>

yes, its intentional.

515a9adce0f0 ("include/linux/printk.h: include pr_fmt in pr_debug_ratelimit=
ed")
added pr-fmt to both the METADATA macro call, and to the printk() just belo=
w it.
The commit-msg was clearly about adding it to the __dynamic_pr_debug() itse=
lf,
the METADATA addition was overzealous.

Removing it brings pr_debug_ratelimited() into conformance with the other
*_pr_debug_* calls:
    dynamic_pr_debug, dev_dbg_ratelimited, net_dbg_ratelimited.

and as you noted, this makes the ... variadic unnecessary.

Ive added the Fixes: tag accordingly.

thanks for the review & pushback.
and apologies for the delay, I picked up a FLU shortly after sending v12.




> Anyway, if we do not longer pass pr_fmt(fmt) then we should not
> need to add "..." into DEFINE_DYNAMIC_DEBUG_METADATA_CLS().
>
> By other words, we newly pass just the format "fmt" without the parametes=
.
> The 4th parameter was added by pr_fmt().
>
>
> IMHO, the right solution is to keep pr_fmt(fmt) here and extend both
> BEFINE_DYNAMIC_DEBUG_METADATA() and
> DEFINE_DYNAMIC_DEBUG_METADATA_CLS()
> to accept var args. I would expect something like:
>
> #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)  \
> ...
>
> #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt, ...)           \
>         DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt,=
 ##__VA_ARGS__)
>
>
> or maybe, we could "eat" the extra parameters in
> DEFINE_DYNAMIC_DEBUG_METADATA. It would mean to keep
> DEFINE_DYNAMIC_DEBUG_METADATA_CLS() as is and just add the "..." into
> DEFINE_DYNAMIC_DEBUG_METADATA(), aka
>
> #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt, ...)           \
>         DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt)
>
>
> Or do I miss something, please?
>
> It is possible that the macros work another way. Or this depends
> on another change. I checked only this patch...
>
> Best Regards,
> Petr
>
> PS: I was curious what Sashiko says about this change and it seems
>     that it does not review this patchset from some reasons.

I checked shortly after sending, it was "embargoed" for 24 hrs,
perhaps cuz it was so soon after rc7

>
> >       if (DYNAMIC_DEBUG_BRANCH(descriptor) &&                         \
> >           __ratelimit(&_rs))                                          \
> >               __dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS_=
_);    \
