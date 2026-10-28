Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8BE606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nfDkUCUv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 384C710E69A;
	Wed, 28 Oct 2026 20:25:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA66A10E134
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 20:25:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A086340DCF;
 Wed, 28 Oct 2026 20:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8451F01828;
 Wed, 28 Oct 2026 20:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793219113;
 bh=O6yGKa93TxFyAJGzdOzoN/pRr+EPCAQmQhZOkVtjIVM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nfDkUCUvqI7Yw25/PD3RQNGFPhmATnA/ZvO1xoO0niGX++NvRSLVpoAJ3oBXZtwP5
 KH5m2amr93fzCBLRLwfla+ykkWuPf4Jv4sLgQ0Gh9gMSz9LNatbcvizeFyZe3nW3oH
 wleFiWW7f3mdcNncAhrRsuc9CH//0qvsYmypDkD7LsMeLGQe8ZlnytCfy71UT5a0xF
 G8JMdBgr7wJdBLmSsvblhhx6BKOVD4MsdjZGOEngNzC+eRht1AkbYZGzTazMhMqQE5
 Hjm9WGZi14Oj5gNfiecbEFYNMWo8jYn71ovQUpfMaokvgfwvJbDNKTnTEoISY4A287
 pRLQvUOYatNCg==
Message-ID: <sashiko-outbox-188395@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 19/39] dyndbg,module: make proper substructs in
 _ddebug_info
To: "Jim Cromie" <jim.cromie@gmail.com>, "Jason Baron" <jbaron@akamai.com>,
 "Shuah
 Khan" <shuah@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Arnd Bergmann" <arnd@arndb.de>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Petr Pavlu" <petr.pavlu@suse.com>, "Daniel
 Gomez" <da.gomez@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Aaron
 Tomlin" <atomlin@atomlin.com>, "Jonathan Corbet" <corbet@net.net>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Pavel Machek" <pavel@kernel.org>, "Len Brown" <lenb@kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Petr
 Mladek" <pmladek@suse.com>, "Steven Rostedt" <rostedt@goodmis.org>, "John
 Ogness" <john.ogness@linutronix.de>,
 "Sergey Senozhatsky" <senozhatsky@chromium.org>, 
 =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
 linux-kbuild@vger.kernel.org, "Jason
 Baron" <jbaron@redhat.com>, "Louis Chauvet" <louis.chauvet@bootlin.com>
In-Reply-To: <20261027-dd-cmap-part2-clean-v13-19-9267923be612@gmail.com>
References: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
 <20261027-dd-cmap-part2-clean-v13-19-9267923be612@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 20:25:11 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dyndbg: __UNIQUE_ID(_ddebug) prefix change breaks objtool klp di=
ff
--

commit 317df06d413f02902ba4470f9dd1320a81d15cee
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg,module: make proper substructs in _ddebug_info

This commit refactors struct _ddebug_info to group descriptor and class map
vectors into struct _ddebug_descs and struct _ddebug_class_maps substructs,
embeds struct _ddebug_info into struct ddebug_table, and renames the linker
sections accordingly.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index 36b7d341076db..b05dc843a1d8e 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h

[ ... ]

> @@ -245,7 +257,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
>   * macro.
>   */
>  #define _dynamic_func_call_cls(cls, fmt, func, ...)			\
> -	__dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARG=
S__)
> +	__dynamic_func_call_cls(__UNIQUE_ID(_ddebug), cls, fmt, func, ##__VA_AR=
GS__)
>  #define _dynamic_func_call(fmt, func, ...)				\
>  	_dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
> =20
> @@ -255,7 +267,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
>   * with precisely the macro's varargs.
>   */
>  #define _dynamic_func_call_cls_no_desc(cls, fmt, func, ...)		\
> -	__dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,	\
> +	__dynamic_func_call_cls_no_desc(__UNIQUE_ID(_ddebug), cls, fmt,	\
>  					func, ##__VA_ARGS__)

[Severity: Medium]
Does changing __UNIQUE_ID(ddebug) to __UNIQUE_ID(_ddebug) in
_dynamic_func_call_cls() and _dynamic_func_call_cls_no_desc() break livepat=
ch
builds with objtool klp diff?

In include/linux/compiler.h, __UNIQUE_ID() already appends an underscore
after __UNIQUE_ID_:

    /* Format: __UNIQUE_ID_<name>_<__COUNTER__> */
    #define __UNIQUE_ID(name)					\
	    __PASTE(__UNIQUE_ID_,				\
	    __PASTE(name,					\
	    __PASTE(_, __COUNTER__)))

Passing _ddebug changes the generated static struct _ddebug descriptor symb=
ol
names from __UNIQUE_ID_ddebug_<N> to __UNIQUE_ID__ddebug_<N> (with a double
underscore).

When CONFIG_JUMP_LABEL is enabled and a livepatched module function contain=
s a
dynamic debug callsite, tools/objtool/klp-diff.c checks for the single
underscore prefix in validate_special_section_klp_reloc():

    if (strstr(reloc->sym->name, "__UNIQUE_ID_ddebug_")) {
	    WARN("%s: disabling unsupported pr_debug()",
		 code_sym);
	    ret =3D 1;
	    continue;
    }

    ERROR("%s+0x%lx: unsupported static branch key %s.  Use static_key_enab=
led() instead",
	  code_sym, code_offset, reloc->sym->name);
    return -1;

With the extra underscore in __UNIQUE_ID__ddebug_<N>, strstr() will no long=
er
match and validate_special_section_klp_reloc() will fail with an unsupported
static branch key error. Should this remain __UNIQUE_ID(ddebug), or should
validate_special_section_klp_reloc() in tools/objtool/klp-diff.c be updated=
 to
match?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-dd-cmap-pa=
rt2-clean-v13-0-9267923be612@gmail.com?part=3D19
