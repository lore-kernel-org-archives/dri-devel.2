Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0360C606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WUcjISH/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 353BF112899;
	Fri, 30 Oct 2026 15:07:29 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A075910E2B8
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:07:22 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso5249075e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793372841; x=1793977641; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YNL5gTzoS0SNcKXI362OG6Cyagd0/f8y/Be+hIpJbPg=;
 b=WUcjISH/c3DiH0Mmsh8+jQ6aCcm53/HFfWnugMul1JZM/A+0osKetD5wlKvdzccH+x
 yxtWIndYdQ0k6DPna7UPbOpPoeeDuy2QqOmMPnziKGi/qnP+ZEJQBpoO+2l+AmbEexzx
 j2SlxsWgsOixL2csB2CVaM28zVY9KaUXDZVgsRTNI/8o76O68sArGyKQWIG0R0et0muY
 0vufLkExXgq2vWIpcBFtw27Z6Xyonoq29xZ9MJlDzbOuoT2Mo57lDU6jHUPKrLqqr9WQ
 qQmGTNg7gZnhEww6OKE6BA90a24HTotDU6FYyt7lKf3VAaLEmLJRFGjSOLnorWKF9f+x
 QkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793372841; x=1793977641;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YNL5gTzoS0SNcKXI362OG6Cyagd0/f8y/Be+hIpJbPg=;
 b=UdDCUrQnbvzRypvWlbFE9l20HY7gn27/TJeg68Utjw4GID/zbsX+xsMDVQp/evJvR0
 P6NuLB/MiQaMTjJ+OshAj6PSB75ZsGw8diM/En3Vn8OFy2ULeNyjMVqMFpI5s/CKMQTC
 c+pe+K9vPZoXj3uqCLRPUVb4HWBPoFyUwjvJMMraQzVcqowgx1hbFCla+IvpKXKsk0eY
 Kl7HeBDVLqTA9iqfUlu+BviNqJM9QLn9rDD0LYP23rRXV7tDY/863Q6SZs0lHIsGO7F0
 dZyGzPjog5FoEYpubViUUcaZzdVNopzwNu7a6O+MqcGL9/JJvBTzn5B+MLjj6PJhGPb7
 Fkkg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4g0BGwZCpKR5pMxivUHGtMTHZS3ZDCxd6Mm1iYXYyYEUuOaANKV+fOa7SpnxZF1IFtE1ZSTt0FFM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJZA4/ddVRKgc2gtz8ZfINGs4HsNASfU3b14Aa4/z9T5/MiE4r8
 N51D8hcXCHrken/UZY7z1Rt/2uYkRqi7EJA9yOUK15ufwneYlxm3aCLT
X-Gm-Gg: AYBFou3PF/zJUXxOq7CuRhlfI9rSswCBsoGYIMt2m7LKPgZD2h1CALHkPC1qvqH1Wxu
 NsZrszs2oCUQ7eDTma3hQDBkQqcsGaFBywHyIuZA616VLabo2WoXZzzTY0yVW51/mwrSJWpiD33
 QQBomIjNm+U5y2CniLYpSYXAaRBj0aZK+/XVxn7Zf11Ozs0ucXdF4vwrbngJAsz12VKazrUJ4XV
 q9/9hnV6+CSqa/Ok2L7RlE+Sf5yyQmBWElz8qILbfjPCFBg+h6ds+Rs9S/ytKOhetAL8XEglRGD
 QLgZ9fqcO5HLtbAifXC60h0wKz025/MxdwwXueRnVTtB5Izt497vVmY42vJKplEHnVc+TUWtDEx
 ubokf/ZnR+8q2B2xZaTEaOR6tXFjhzoctH0/RRASMLYAsXasSsDhq/HYaS2ZseRHLoMDWswmCBO
 BG9reKqX9dUX4mJopxDaWdFiN/138Kb3D6L7I9CzBWu/GMXZJoIwjawQg0JJnq+UL/2aWdh6ClH
 f2rZgDGhMnnkp9wa+OV2kukfp+/ffP153xcJaa5tIfpzK/nj+uuZFyb0Vd9sUAHSCEBaIFTdPzC
 JkK/za87J5YAocLtv/1B3EwPss/CRdi/hLz+UlUuB4JM0Oa+mYsfIxyr8ApBEPP2xQ==
X-Received: by 2002:a05:600c:4e8c:b0:4a1:dade:f049 with SMTP id
 5b1f17b1804b1-4ac1793ff26mr57275105e9.15.1793372840727; 
 Fri, 30 Oct 2026 08:07:20 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf67aab10sm64599465e9.9.2026.10.30.08.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 08:07:18 -0700 (PDT)
Date: Fri, 30 Oct 2026 15:07:17 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: jim.cromie@gmail.com, Jason Baron <jbaron@akamai.com>, Shuah Khan
 <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Arnd Bergmann
 <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu
 <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Jonathan
 Corbet <corbet@net.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel
 Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Steven Rostedt <rostedt@goodmis.org>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, Philipp Hahn
 <phahn-oss@avm.de>
Subject: Re: [PATCH v12 33/40] dyndbg: Ignore additional arguments from pr_fmt
Message-ID: <20261030150717.094d8a35@pumpkin>
In-Reply-To: <auNes2b11NqUey3C@pathway>
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
 <20261012-dd-cmap-part2-clean-v12-33-3c8cc5725def@gmail.com>
 <as4W9hToBqAvbzJ-@pathway.suse.cz>
 <20261027132253.5f3a461d@pumpkin> <auNes2b11NqUey3C@pathway>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 15:56:51 +0100
Petr Mladek <pmladek@suse.com> wrote:

> On Tue 2026-10-27 13:22:53, David Laight wrote:
> > On Tue, 13 Oct 2026 13:33:10 +0200
> > Petr Mladek <pmladek@suse.com> wrote:
> >  =20
> > > On Mon 2026-10-12 20:37:04, Jim Cromie via B4 Relay wrote: =20
> > > > From: Philipp Hahn <phahn-oss@avm.de>
> > > >=20
> > > > pr_fmt can be used to add a common prefix to any output from a modu=
le:
> > > > 	#define pr_fmt(fmt) KBUILD_MODNAME ".%s " fmt, __func__
> > > >=20
> > > > But adding additional arguments breaks dynamic debug:   =20
> > > > > error: macro "DEFINE_DYNAMIC_DEBUG_METADATA_CLS" passed 4 argumen=
ts, but takes just 3
> > > > > |         pr_debug_ratelimited("%s", "Hello world!");
> > > > > |                                                  ^
> > > > > note: macro "DEFINE_DYNAMIC_DEBUG_METADATA_CLS" defined here
> > > > > | #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)      =
 \
> > > > > |
> > > > > error: =E2=80=98DEFINE_DYNAMIC_DEBUG_METADATA_CLS=E2=80=99 undecl=
ared (first use in this function)
> > > > > |         DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_=
DFLT, fmt)
> > > > > |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   =20
> > >=20
> > > I wonder what this error about undeclared macro means.
> > >  =20
> > > > > note: in expansion of macro =E2=80=98DEFINE_DYNAMIC_DEBUG_METADAT=
A=E2=80=99
> > > > > |         DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));=
         \
> > > > > |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > note: in expansion of macro =E2=80=98pr_debug_ratelimited=E2=80=99
> > > > > |         pr_debug_ratelimited("%s", "Hello world!");
> > > > > |         ^~~~~~~~~~~~~~~~~~~~   =20
> > > >=20
> > > > Add an additional ', ...' to DEFINE_DYNAMIC_DEBUG_METADATA_CLS to s=
lurp
> > > > any additional argument, which `pr_fmt` might add.
> > > >=20
> > > > --- a/include/linux/dynamic_debug.h
> > > > +++ b/include/linux/dynamic_debug.h
> > > > @@ -351,7 +351,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descri=
ptor,
> > > >  		dump_stack();					\
> > > >  }
> > > > =20
> > > > -#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
> > > > +#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)	\
> > > >  	static struct _ddebug  __aligned(8)			\
> > > >  	__section("__dyndbg_descs") name =3D {			\
> > > >  		.modname =3D KBUILD_MODNAME,			\
> > > > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > > > index f594c1266bfd..5d701952e739 100644
> > > > --- a/include/linux/printk.h
> > > > +++ b/include/linux/printk.h
> > > > @@ -742,7 +742,7 @@ do {									\
> > > >  	static DEFINE_RATELIMIT_STATE(_rs,				\
> > > >  				      DEFAULT_RATELIMIT_INTERVAL,	\
> > > >  				      DEFAULT_RATELIMIT_BURST);		\
> > > > -	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));		\
> > > > +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);		\   =20
> > >=20
> > > IMHO, this changes the existing behavior. The prefix added by
> > > pr_fmt() will no longer be stored in DEFINE_DYNAMIC_DEBUG_METADATA().
> > > Is this intentional, please?
> > >=20
> > > Anyway, if we do not longer pass pr_fmt(fmt) then we should not
> > > need to add "..." into DEFINE_DYNAMIC_DEBUG_METADATA_CLS().
> > >=20
> > > By other words, we newly pass just the format "fmt" without the param=
etes.
> > > The 4th parameter was added by pr_fmt().
> > >=20
> > >=20
> > > IMHO, the right solution is to keep pr_fmt(fmt) here and extend both
> > > BEFINE_DYNAMIC_DEBUG_METADATA() and
> > > DEFINE_DYNAMIC_DEBUG_METADATA_CLS()
> > > to accept var args. I would expect something like:
> > >=20
> > > #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)	\
> > > ...
> > >=20
> > > #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt, ...)		\
> > > 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt, ##=
__VA_ARGS__)
> > >=20
> > >=20
> > > or maybe, we could "eat" the extra parameters in
> > > DEFINE_DYNAMIC_DEBUG_METADATA. It would mean to keep
> > > DEFINE_DYNAMIC_DEBUG_METADATA_CLS() as is and just add the "..." into
> > > DEFINE_DYNAMIC_DEBUG_METADATA(), aka
> > >=20
> > > #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt, ...)		\
> > > 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt)
> > >=20
> > >=20
> > > Or do I miss something, please? =20
> >=20
> > Don't think that will work.
> > Won't you end up with ".%s" fmt as the string without the extra argumen=
t.
> > So you need to keep the expansion of pr_fmt() together until is is fina=
lly
> > substituted into a printf-like call.
> > It is possible to enclose it in () so it is passed as one parameter and
> > remove them on the final expansion. =20
>=20
> My understanding was that the format is stored in the metadata as is.
> I mean that the string is not formatted in this code path. So that
> the parameter values are or can be ignored. We just need to make
> the compiler happy.
>=20
> But I might miss something.

If it is formatted in any code path you need any argument added by pr_fmt()
otherwise the values printed wont match the format.
Indeed, in some cases, the format has to be formatted in the same code path
(or at least scanned for anything passed by reference) to avoid accessing
stale data.

I've definitely used:
#define pt_fmt(fmt) "driver serial %s:" fmt, foo->serial
which relies on all call sites having a local variable foo of the correct
type. There may be some in the main kernel tree.

Maybe I'm missing something.

David

>=20
> Best Regards,
> Petr
>=20

