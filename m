Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996A7606A321
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=JuIdgIsa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAEDA112373;
	Thu, 29 Oct 2026 14:57:01 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23E6C10E2C5
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:56:56 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48c4d99c32bso1796037f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1793285814; x=1793890614; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PiLUJIzj7M85elEEaNM0ojSu5Qbzbb6E3aVU0YwZNoU=;
 b=JuIdgIsa/bEQwjCAoBgz2oMFRA1weTlDTa20tzRCnoc60aGLB2E8ScvTdAm02xkKBa
 BwFh/yz30m5ucNc1+4wZX1uOmCQLLBxuzj7Lb0b3r/Pas+2ebmXl+MUhmQk0Us8A5GrF
 SQEoVZmlhGRTL1zoHW0zSSDC2uZ1pFBU3ahqZa91+Iqp21bcsVBrIWzMQaiPw3vUC2Jl
 Uju6HgvSbWuSByR2yIP/eniPBJmIfRryaKIUGJUOt4Oi4/AOmbmS/8G5P0abfIXTaB0f
 Ql8a2K9+xniEfblbFPR6fQBDTZUfSkRoSlr69GtP7nidGa7h9EloNTJ/vpE29Cq6aPpZ
 gYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793285814; x=1793890614;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PiLUJIzj7M85elEEaNM0ojSu5Qbzbb6E3aVU0YwZNoU=;
 b=qY1WpMFL7vCMQb11O8vO/I8Qtxh0Kkc3qpw0sFDOZyee2Wil88eglpuip4pblWm0Vl
 ppWv7tIg79vGUDI/b7qLt6r46iN6RVqnM5P2wAjUACz1FeS+Hu5Zz/hyq2W2+ZVGJ5Cu
 3xFUWnvVklxZqa5Kas3PBI5sdZN4K4ag2oCzLPAAmEVb74dEX/o7NIXM7IiP3FE6Kr6F
 MERtooB9vOy6w4B7IE1byigd3EBiQbXLtlsrQfq7jBDxmYJj3fLbQ7INdCPqtrYsEzcM
 yYYGjwCWQTzuby8HW4aI50GO4Kq3QFS/BJVvGMFAqCEPGEFFTcHJ2FIVWXz85Ra2foyH
 H9wg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFqqU1z2WYJqcnrZkPgmzu912fwTxO+b7ZmPlsIsWOJj5eIoAOGnacmgYeZC1TTVvBNeaj/nvUgOw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKYicAH+Rzpm9SX8bG3jkd8C7xc2u4zaRUmI3zQzGFMmcTf1bLB
 44q3lsYGKdMjMh7we/8XA7d1673RI+wOWxiSi5r66esYIOfbxTkEv9uie+jUmPWhTUU=
X-Gm-Gg: AYBFou1EFdS7pTkfpFluIYfbaQlTjJ5Vo4LEEJVJ48QqHZ5QYohcXT/2RUYE8bMpXAx
 N7VSheGebZcS0UxWUZRKBpqkCxfrayEJRIsWaPjZ8S2tIiWXgWooqlIHK8lhBZVLtnDXz5MOlq4
 Nsbt7hor32LuFDCldj9YIwBCGpCmuzooyGqwduRWb917hHCrewo6bnfdlICBfcmo/XHNlozRJYo
 NWeX1t10809Mpk5KQsHQGK4p89AvllipnVjYRU7gOJospl6JFtV3eMSJGtXGpI6LOjwq+N2MA6/
 6F9UbkFkjd9YJtdJe6hi39ojG8HKokxFrn+KfuM8Nfy6aKYbEzTl4ivAQm4R3muyjGYeKLsejKN
 bdaKx1XT69PnCd9fFL4HeeL1fcEb+n/r57v97M3In9a3C4YHsqTbisa4MK0yzp0ENb8m9O/Uks5
 oFtizZNTovEp3yMvIacWNE3ELqgoLCc8QtF9ezOgWggm6PCu0Q7H7nWd32LSXWuOVgjHogHsB6P
 e/S6Hiyi/qXUcvnCQ6lpb/SUmQevJIu4FXpBL9GCaZ2Jebjs9Sfy2wZaGimM01RnBSdgf98dzZo
 YB7YhmNkw02xewbtjT0xfA/xS7qFaen49Mg=
X-Received: by 2002:a05:6000:290d:b0:48e:6a23:4a09 with SMTP id
 ffacd0b85a97d-48e6a234a62mr3002384f8f.54.1793285814407; 
 Thu, 29 Oct 2026 07:56:54 -0700 (PDT)
Received: from pathway (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc39b3sm35816798f8f.10.2026.10.29.07.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 07:56:53 -0700 (PDT)
Date: Thu, 29 Oct 2026 15:56:51 +0100
From: Petr Mladek <pmladek@suse.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: jim.cromie@gmail.com, Jason Baron <jbaron@akamai.com>,
 Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@net.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org,
 Philipp Hahn <phahn-oss@avm.de>
Subject: Re: [PATCH v12 33/40] dyndbg: Ignore additional arguments from pr_fmt
Message-ID: <auNes2b11NqUey3C@pathway>
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
 <20261012-dd-cmap-part2-clean-v12-33-3c8cc5725def@gmail.com>
 <as4W9hToBqAvbzJ-@pathway.suse.cz>
 <20261027132253.5f3a461d@pumpkin>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261027132253.5f3a461d@pumpkin>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue 2026-10-27 13:22:53, David Laight wrote:
> On Tue, 13 Oct 2026 13:33:10 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > On Mon 2026-10-12 20:37:04, Jim Cromie via B4 Relay wrote:
> > > From: Philipp Hahn <phahn-oss@avm.de>
> > > 
> > > pr_fmt can be used to add a common prefix to any output from a module:
> > > 	#define pr_fmt(fmt) KBUILD_MODNAME ".%s " fmt, __func__
> > > 
> > > But adding additional arguments breaks dynamic debug:  
> > > > error: macro "DEFINE_DYNAMIC_DEBUG_METADATA_CLS" passed 4 arguments, but takes just 3
> > > > |         pr_debug_ratelimited("%s", "Hello world!");
> > > > |                                                  ^
> > > > note: macro "DEFINE_DYNAMIC_DEBUG_METADATA_CLS" defined here
> > > > | #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)       \
> > > > |
> > > > error: ‘DEFINE_DYNAMIC_DEBUG_METADATA_CLS’ undeclared (first use in this function)
> > > > |         DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt)
> > > > |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
> > 
> > I wonder what this error about undeclared macro means.
> > 
> > > > note: in expansion of macro ‘DEFINE_DYNAMIC_DEBUG_METADATA’
> > > > |         DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));         \
> > > > |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > note: in expansion of macro ‘pr_debug_ratelimited’
> > > > |         pr_debug_ratelimited("%s", "Hello world!");
> > > > |         ^~~~~~~~~~~~~~~~~~~~  
> > > 
> > > Add an additional ', ...' to DEFINE_DYNAMIC_DEBUG_METADATA_CLS to slurp
> > > any additional argument, which `pr_fmt` might add.
> > > 
> > > --- a/include/linux/dynamic_debug.h
> > > +++ b/include/linux/dynamic_debug.h
> > > @@ -351,7 +351,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
> > >  		dump_stack();					\
> > >  }
> > >  
> > > -#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
> > > +#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)	\
> > >  	static struct _ddebug  __aligned(8)			\
> > >  	__section("__dyndbg_descs") name = {			\
> > >  		.modname = KBUILD_MODNAME,			\
> > > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > > index f594c1266bfd..5d701952e739 100644
> > > --- a/include/linux/printk.h
> > > +++ b/include/linux/printk.h
> > > @@ -742,7 +742,7 @@ do {									\
> > >  	static DEFINE_RATELIMIT_STATE(_rs,				\
> > >  				      DEFAULT_RATELIMIT_INTERVAL,	\
> > >  				      DEFAULT_RATELIMIT_BURST);		\
> > > -	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));		\
> > > +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);		\  
> > 
> > IMHO, this changes the existing behavior. The prefix added by
> > pr_fmt() will no longer be stored in DEFINE_DYNAMIC_DEBUG_METADATA().
> > Is this intentional, please?
> > 
> > Anyway, if we do not longer pass pr_fmt(fmt) then we should not
> > need to add "..." into DEFINE_DYNAMIC_DEBUG_METADATA_CLS().
> > 
> > By other words, we newly pass just the format "fmt" without the parametes.
> > The 4th parameter was added by pr_fmt().
> > 
> > 
> > IMHO, the right solution is to keep pr_fmt(fmt) here and extend both
> > BEFINE_DYNAMIC_DEBUG_METADATA() and
> > DEFINE_DYNAMIC_DEBUG_METADATA_CLS()
> > to accept var args. I would expect something like:
> > 
> > #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)	\
> > ...
> > 
> > #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt, ...)		\
> > 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt, ##__VA_ARGS__)
> > 
> > 
> > or maybe, we could "eat" the extra parameters in
> > DEFINE_DYNAMIC_DEBUG_METADATA. It would mean to keep
> > DEFINE_DYNAMIC_DEBUG_METADATA_CLS() as is and just add the "..." into
> > DEFINE_DYNAMIC_DEBUG_METADATA(), aka
> > 
> > #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt, ...)		\
> > 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt)
> > 
> > 
> > Or do I miss something, please?
> 
> Don't think that will work.
> Won't you end up with ".%s" fmt as the string without the extra argument.
> So you need to keep the expansion of pr_fmt() together until is is finally
> substituted into a printf-like call.
> It is possible to enclose it in () so it is passed as one parameter and
> remove them on the final expansion.

My understanding was that the format is stored in the metadata as is.
I mean that the string is not formatted in this code path. So that
the parameter values are or can be ignored. We just need to make
the compiler happy.

But I might miss something.

Best Regards,
Petr
