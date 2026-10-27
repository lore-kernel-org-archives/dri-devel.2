Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D3F606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UYvHj3Dy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E896310E406;
	Tue, 27 Oct 2026 13:23:06 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A5D810E406
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:23:00 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48e47347279so1868066f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 06:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793107379; x=1793712179; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bt8+RMZDmd6s3sr6pjCs6SFKWlDJZBaHmutX4rG7P/I=;
 b=UYvHj3DyjMsuRpcMzXQbJM3QTJvb3hkBBLr7MAk7JQuKPFLtSShW5sbFLkdhlDepvr
 JPxdOZpN69e1z4OSiRDCJpKWa4zjHcPZlfmurJ37ZYbZRL1aF4iYIpr5gGDCcyy8huX2
 W1H0v6pcg72fzC1Rl+dgkLit1bWG8ha1ZK2i9cTLN7EcYAmkv1bnurvP4mLfy3UPe+BD
 v1zic9P7WA9ks3+/ibDoORAibTJaK9fKx5XCuDL1UFmU4lfsp5y/M5S5rg8PMcl7yr8F
 BMFp/VTAYXKBrW4rjLdwfqmr+12jZr9rmuAJ6MTv1qC/jtBtC1p2RNqcH/vxPwgvDKvZ
 elig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793107379; x=1793712179;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bt8+RMZDmd6s3sr6pjCs6SFKWlDJZBaHmutX4rG7P/I=;
 b=wzTtYw8vCC375X5UI4TRyLBdwtCG6YfrrKhJB1FrqynRHCvlZPV8+zUTFoRy9wKPqs
 xUgXq1h9G19pFVecKZ3exwMfs+YBZRq//AYtlPO1B1B44HI2XIuTjn2VrC5ATO/FRDrI
 dzC8cP9yWgtdlsTFivUJPWtY+gsJa+I3+kEbR8cKkBWN/R079jgCZTRxqNOl93MrfOEQ
 dg1um9UTcDL2PnKCOkeNjd36u2CvKxDdVy18/t3ZVPw+Y9TpwVSZ7cCZctNOhgXmUhLy
 6MtBVRzX010nbV+xI9rB7yziQ8UEnvmKcc+ypNqR7/zzvONC6UHg9hQWbmc4xUiDCCUX
 oixQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbzvumxxDXTvUdHF/jrSqh0YwRB2wDpwtV8v+zUn3gicqhgFPC9wLZSmE3gLn7+P1wto1hiua6Dl0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK6LHMaxh0L5y1N926CORoHSMoWlB8kz6FPo2eZ5A0vVWvcvqxH
 GHXzjfnYOCp+zzv1xxb1KkPRRMNEvDkjiWMNzI/dMeVvkfILLDCSZuEZ
X-Gm-Gg: AYBFou3DKIb5bXpe/6cXMuVlMPwVk8hnGC6+QKHTGoWCxPcqpcHA1PaWruElXpLLzU4
 QDzW7GZwGNAOCr+LF3/+L32lsW+oAQfpY38Xs+btI8kb/xvcfg+ssuCKsJh1KtmTcIU39Tsk7O1
 xMEC272bSILvOp8O5E8KC4vL/IGOrovUqhvX8Sq35eYzJ0iGZqtNlE+GGw+f+nXJKH8MzG7WFo1
 ZE2USLAPCTxquEntxcwziLCzReM5e+Td+akhAz6b39nXf1IsnmcAxuDnz1cbLGKqmysHPA9VMpK
 2oVy+knupTZZDIbuxpg0ldgYbHMB3tPmGCs6qH5CQwPCiKY9U0y4TiJ0P/CQAM6o/sR/W0OddJM
 9Jc4NdU4ofwxeXTgpfVzMC3pcHNSHHnoRZhNxiAQTc7hSK6USv0f0WGwfnUmvTA8uYlIwLkjZKM
 1i0D5SJ49pHvYk5mj/dzOtf+Di3FhfBAL2MkCDyPXpnOMxPdmk17WYEzVFa8URlOE/VeWXqtev2
 mCQ8WqHDo6p8NeEeRLXMBbn0MKD8tsRYCRjNC9hgWVT6HisNAxPXPqODbwBJS8JXe7ZUNPBSofy
 ZYAU9aqqmg7ze4g7O6Cjw/8K14R2q+iKnNcNHw==
X-Received: by 2002:a05:6000:2388:b0:48c:7386:af18 with SMTP id
 ffacd0b85a97d-48e3eb2cf0fmr19717600f8f.8.1793107378393; 
 Tue, 27 Oct 2026 06:22:58 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc39a8sm23819954f8f.11.2026.10.27.06.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:22:56 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:22:53 +0000
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
Message-ID: <20261027132253.5f3a461d@pumpkin>
In-Reply-To: <as4W9hToBqAvbzJ-@pathway.suse.cz>
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
 <20261012-dd-cmap-part2-clean-v12-33-3c8cc5725def@gmail.com>
 <as4W9hToBqAvbzJ-@pathway.suse.cz>
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

On Tue, 13 Oct 2026 13:33:10 +0200
Petr Mladek <pmladek@suse.com> wrote:

> On Mon 2026-10-12 20:37:04, Jim Cromie via B4 Relay wrote:
> > From: Philipp Hahn <phahn-oss@avm.de>
> >=20
> > pr_fmt can be used to add a common prefix to any output from a module:
> > 	#define pr_fmt(fmt) KBUILD_MODNAME ".%s " fmt, __func__
> >=20
> > But adding additional arguments breaks dynamic debug: =20
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
> > > |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ =20
>=20
> I wonder what this error about undeclared macro means.
>=20
> > > note: in expansion of macro =E2=80=98DEFINE_DYNAMIC_DEBUG_METADATA=E2=
=80=99
> > > |         DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));    =
     \
> > > |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > note: in expansion of macro =E2=80=98pr_debug_ratelimited=E2=80=99
> > > |         pr_debug_ratelimited("%s", "Hello world!");
> > > |         ^~~~~~~~~~~~~~~~~~~~ =20
> >=20
> > Add an additional ', ...' to DEFINE_DYNAMIC_DEBUG_METADATA_CLS to slurp
> > any additional argument, which `pr_fmt` might add.
> >=20
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> > @@ -351,7 +351,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
> >  		dump_stack();					\
> >  }
> > =20
> > -#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
> > +#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)	\
> >  	static struct _ddebug  __aligned(8)			\
> >  	__section("__dyndbg_descs") name =3D {			\
> >  		.modname =3D KBUILD_MODNAME,			\
> > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > index f594c1266bfd..5d701952e739 100644
> > --- a/include/linux/printk.h
> > +++ b/include/linux/printk.h
> > @@ -742,7 +742,7 @@ do {									\
> >  	static DEFINE_RATELIMIT_STATE(_rs,				\
> >  				      DEFAULT_RATELIMIT_INTERVAL,	\
> >  				      DEFAULT_RATELIMIT_BURST);		\
> > -	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));		\
> > +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);		\ =20
>=20
> IMHO, this changes the existing behavior. The prefix added by
> pr_fmt() will no longer be stored in DEFINE_DYNAMIC_DEBUG_METADATA().
> Is this intentional, please?
>=20
> Anyway, if we do not longer pass pr_fmt(fmt) then we should not
> need to add "..." into DEFINE_DYNAMIC_DEBUG_METADATA_CLS().
>=20
> By other words, we newly pass just the format "fmt" without the parametes.
> The 4th parameter was added by pr_fmt().
>=20
>=20
> IMHO, the right solution is to keep pr_fmt(fmt) here and extend both
> BEFINE_DYNAMIC_DEBUG_METADATA() and
> DEFINE_DYNAMIC_DEBUG_METADATA_CLS()
> to accept var args. I would expect something like:
>=20
> #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)	\
> ...
>=20
> #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt, ...)		\
> 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt, ##__VA=
_ARGS__)
>=20
>=20
> or maybe, we could "eat" the extra parameters in
> DEFINE_DYNAMIC_DEBUG_METADATA. It would mean to keep
> DEFINE_DYNAMIC_DEBUG_METADATA_CLS() as is and just add the "..." into
> DEFINE_DYNAMIC_DEBUG_METADATA(), aka
>=20
> #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt, ...)		\
> 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt)
>=20
>=20
> Or do I miss something, please?

Don't think that will work.
Won't you end up with ".%s" fmt as the string without the extra argument.
So you need to keep the expansion of pr_fmt() together until is is finally
substituted into a printf-like call.
It is possible to enclose it in () so it is passed as one parameter and
remove them on the final expansion.

David

>=20
> It is possible that the macros work another way. Or this depends
> on another change. I checked only this patch...
>=20
> Best Regards,
> Petr
>=20
> PS: I was curious what Sashiko says about this change and it seems
>     that it does not review this patchset from some reasons.
>=20
> >  	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&				\
> >  	    __ratelimit(&_rs))						\
> >  		__dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS__);	\ =20
>=20

