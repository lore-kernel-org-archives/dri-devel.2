Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3B9CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26DFF10E101;
	Tue, 13 Oct 2026 11:33:22 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD88E10E101
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 11:33:15 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48afe75f055so2621341f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 04:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791891194; x=1792495994; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=anitmvt5QBwY9lobKzDJl69qsHc8ScLJ3DQrPkwQ6aE=;
 b=g8UrwRCr0cUbBlUG9KMvOrXni3CVrXxJ4pBj0PwyJj5Wa0GuDw9AbpAsEK8VeieS9o
 htndnZpy0kuVSd/vxhGpMJAghnNsPG7RILhWNlOqYrVH0PofUo0agQN7q4itoei/DTvs
 Ezh1TSUN3ct6uOjYF+5ZDBFof6Ng7Q+L6PLiY2jEGp2FxBPydwtwW/f8/4qkEVyYy9oJ
 qdV6RglFatBP4FuPvqNPruk6J5sr+GhLLU1xblxcN6HRqgTrbK6cIq+j6WUUDRBR/pS2
 J7WfhMK+T5Q22jiYv5IM1R/a9rnO0zy5k58fGPcp072vQ24Fm6lzk4sbbY2KHo9Ss1Km
 qT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791891194; x=1792495994;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=anitmvt5QBwY9lobKzDJl69qsHc8ScLJ3DQrPkwQ6aE=;
 b=s+02bpXCAOS65SBBtVrCr764q+4/1Jl4c9RenvFuZEXnQOvU+Og+26IZXtQUGBGpKm
 5woub5HoxeZItU5Qi6IUKL2NfagUduX2/oGtYtVLUKf2jYmircEprBkSUx/EuE7emU2A
 72HQpOMXESPTOHVHMDmhmzG7VbT8mZD+8o+AFWT4bV05yd2MblYWeUDm7VKycGMs5tCN
 0ypIlzTBIBKhUJvo99+iBx503Ux6u0fe68nkR1a/Mhv+aMxa6PmXhVLxJhfB4Zvvg9bF
 HpuDNEWUOd+XDmS83n5jWiqoVfOFT5XtnCbzBbtgnQN2VgeZrD+Hj5BCxzC4+I1mwlWp
 GDkw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmcslNVGXLYgJ8EVYyf1AsB03JfnuulXan6ny1OpMsX005VbePyGS2hEcOa9AqTxem8M+gFYeeOV4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJi8WgLs4+ODQruQqi/ntRmLW3Vn2AeOTPOzP6KuNKDjxiOztRb
 EvnndIUCIbHnn9c3r0Lb4IJ3NdC2JX+7y692PwYyLPfEFhjHnqH2BxxZ3Ql3h37Qrdw=
X-Gm-Gg: AYBFou39r/x/RXlBJQLJlF3hk5MnJykFZ5nAnkuqUtYVQZ89r47IZwowa7Aqpe3E5Mc
 tl2vVnT0N2cCKMuLKeiOLOw8nFC7O8BpJw3O7Zan+eM6GDsaImLLSfDXTEcboIkoLBskVBbgH51
 8v5e3b4BFh1S9spRs35fj+h5EShvNCRLGFvpD5LSPIyLJtujRLq0YfwjS3I/AVRffHLLf/G8G93
 OF1fDRwAWHVNWk2P+JLHXRjCRnq6DqxgDwHGxgT3wc6XrUmAwIvqXpGfODY4cAYlyIHUNDVrNP4
 QkDHfSr7lXBqBFlNizx3ddHKilMaKEBOPuSOZMQli+btED3zSaqHO1ER9xKxlkWtBhNt7l8L6rK
 OjkXO1cDEubyQabA06LredZIOLDFj/ceAVgHvP5TClUUFgbJnq98uDjTYgPgfSojWZFC7Jf2rgp
 w7Iw29WcCu+TkYwXEpbtI/ZsodWO2Oky6SSua7yG3UPJcaR+zgGhD6G+7cIifvwiXtBL0MQpTQ
X-Received: by 2002:a05:600c:46c5:b0:4a0:eae0:769a with SMTP id
 5b1f17b1804b1-4a18e4cd224mr244258165e9.28.1791891193452; 
 Tue, 13 Oct 2026 04:33:13 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc50e0sm5960955f8f.49.2026.10.13.04.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 04:33:13 -0700 (PDT)
Date: Tue, 13 Oct 2026 13:33:10 +0200
From: Petr Mladek <pmladek@suse.com>
To: jim.cromie@gmail.com
Cc: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <as4W9hToBqAvbzJ-@pathway.suse.cz>
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
 <20261012-dd-cmap-part2-clean-v12-33-3c8cc5725def@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261012-dd-cmap-part2-clean-v12-33-3c8cc5725def@gmail.com>
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

On Mon 2026-10-12 20:37:04, Jim Cromie via B4 Relay wrote:
> From: Philipp Hahn <phahn-oss@avm.de>
> 
> pr_fmt can be used to add a common prefix to any output from a module:
> 	#define pr_fmt(fmt) KBUILD_MODNAME ".%s " fmt, __func__
> 
> But adding additional arguments breaks dynamic debug:
> > error: macro "DEFINE_DYNAMIC_DEBUG_METADATA_CLS" passed 4 arguments, but takes just 3
> > |         pr_debug_ratelimited("%s", "Hello world!");
> > |                                                  ^
> > note: macro "DEFINE_DYNAMIC_DEBUG_METADATA_CLS" defined here
> > | #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)       \
> > |
> > error: ‘DEFINE_DYNAMIC_DEBUG_METADATA_CLS’ undeclared (first use in this function)
> > |         DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt)
> > |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I wonder what this error about undeclared macro means.

> > note: in expansion of macro ‘DEFINE_DYNAMIC_DEBUG_METADATA’
> > |         DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));         \
> > |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > note: in expansion of macro ‘pr_debug_ratelimited’
> > |         pr_debug_ratelimited("%s", "Hello world!");
> > |         ^~~~~~~~~~~~~~~~~~~~
> 
> Add an additional ', ...' to DEFINE_DYNAMIC_DEBUG_METADATA_CLS to slurp
> any additional argument, which `pr_fmt` might add.
> 
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -351,7 +351,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
>  		dump_stack();					\
>  }
>  
> -#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
> +#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)	\
>  	static struct _ddebug  __aligned(8)			\
>  	__section("__dyndbg_descs") name = {			\
>  		.modname = KBUILD_MODNAME,			\
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index f594c1266bfd..5d701952e739 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -742,7 +742,7 @@ do {									\
>  	static DEFINE_RATELIMIT_STATE(_rs,				\
>  				      DEFAULT_RATELIMIT_INTERVAL,	\
>  				      DEFAULT_RATELIMIT_BURST);		\
> -	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));		\
> +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);		\

IMHO, this changes the existing behavior. The prefix added by
pr_fmt() will no longer be stored in DEFINE_DYNAMIC_DEBUG_METADATA().
Is this intentional, please?

Anyway, if we do not longer pass pr_fmt(fmt) then we should not
need to add "..." into DEFINE_DYNAMIC_DEBUG_METADATA_CLS().

By other words, we newly pass just the format "fmt" without the parametes.
The 4th parameter was added by pr_fmt().


IMHO, the right solution is to keep pr_fmt(fmt) here and extend both
BEFINE_DYNAMIC_DEBUG_METADATA() and
DEFINE_DYNAMIC_DEBUG_METADATA_CLS()
to accept var args. I would expect something like:

#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)	\
...

#define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt, ...)		\
	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt, ##__VA_ARGS__)


or maybe, we could "eat" the extra parameters in
DEFINE_DYNAMIC_DEBUG_METADATA. It would mean to keep
DEFINE_DYNAMIC_DEBUG_METADATA_CLS() as is and just add the "..." into
DEFINE_DYNAMIC_DEBUG_METADATA(), aka

#define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt, ...)		\
	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt)


Or do I miss something, please?

It is possible that the macros work another way. Or this depends
on another change. I checked only this patch...

Best Regards,
Petr

PS: I was curious what Sashiko says about this change and it seems
    that it does not review this patchset from some reasons.

>  	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&				\
>  	    __ratelimit(&_rs))						\
>  		__dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS__);	\
