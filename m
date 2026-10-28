Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C9E606A32D
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VSsaVvOf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48F7510E134;
	Wed, 28 Oct 2026 20:25:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73BF210E134
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 20:25:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E9F3C602C3;
 Wed, 28 Oct 2026 20:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F951F01828;
 Wed, 28 Oct 2026 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793219126;
 bh=pXQKU9DZv7QOB+vexCN36JMnrBHhqRzYrbNC+ZXybeQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VSsaVvOfx9F+5nysS7kneG1JMC6kElFiBuVviixJCMb/Zf/w3tkXtmKVp5mlLdbJI
 vJ6VtpmORONZi4LmobxpsuxGLAG7xHOao1OSGfIZmXU6yWuHZbYyyrMXivWzbGBpXD
 azMqtBZlESDb5aK70klWrd/S594IbdX3jvmYm9V8KDi+vB8k0gw2f6WHc1zSeX96R0
 Qqmfkb0mfkCAoqDM6Dub4Fig09VVo2xzM8Vlo4DHI82ZJMJopIiDuf5tuo/zPt8wvv
 rzKMM/v65QGv0IQKQ39HGGUxZ67ES6e1RdHnSH2HHZ28hT0e9O4CXmp3tkAJu39P+s
 tjtYW3YWNMHnw==
Message-ID: <sashiko-outbox-188412@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 36/39] dyndbg: add DEBUG-biased fallback stubs for
 _dynamic_func_call_cls
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
 Baron" <jbaron@redhat.com>, "kernel test robot" <lkp@intel.com>
In-Reply-To: <20261027-dd-cmap-part2-clean-v13-36-9267923be612@gmail.com>
References: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
 <20261027-dd-cmap-part2-clean-v13-36-9267923be612@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 20:25:24 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] dyndbg: unrelated runtime classmap validation squashed into head=
er stub patch
- [Medium] dyndbg: empty DECLARE_DYNDBG_CLASSMAP() stub breaks drm_print.c =
build
--

commit 919e16985df0bc0e411e71184e2e97b087e1097c
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: add DEBUG-biased fallback stubs for _dynamic_func_call_cls

This commit adds DEBUG-biased fallback stub definitions for the
_dynamic_func_call_cls macro family when dynamic debug is disabled for a
translation unit. It also modifies runtime classmap validation, descriptor
checks, and warning output in lib/dynamic_debug.c.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index fb182c9030889..6a6cd45e5571c 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -536,6 +536,23 @@ void ddebug_increment_call_count(void);
>  #define DYNAMIC_DEBUG_BRANCH(descriptor) false
>  #define DECLARE_DYNDBG_CLASSMAP(...)
> =20
> +#if defined(DEBUG)
> +#define _dynamic_func_call_cls(cls, fmt, func, ...)		\
> +	do { func(NULL, ##__VA_ARGS__); } while (0)
> +#define _dynamic_func_call_cls_no_desc(cls, fmt, func, ...)	\
> +	do { func(__VA_ARGS__); } while (0)
> +#else
> +#define _dynamic_func_call_cls(cls, fmt, func, ...)		\
> +	do { if (0) func(NULL, ##__VA_ARGS__); } while (0)
> +#define _dynamic_func_call_cls_no_desc(cls, fmt, func, ...)	\
> +	do { if (0) func(__VA_ARGS__); } while (0)
> +#endif

[Severity: Medium]
Does the DRM core build still fail under the configuration described in the
commit message (CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy, CONFIG_DYNAMIC_DEBUG_CORE=
=3Dy,
and CONFIG_DYNAMIC_DEBUG=3Dn)?

Because drivers/gpu/drm/Makefile uses:

    CFLAGS-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+=3D -DDYNAMIC_DEBUG_MODULE

and Kbuild ignores CFLAGS-y in favor of ccflags-y, drivers/gpu/drm/drm_prin=
t.c
is compiled without DYNAMIC_DEBUG_MODULE defined and falls into this #else
block in include/linux/dynamic_debug.h.

In this block, DECLARE_DYNDBG_CLASSMAP(...) expands to nothing, while
drivers/gpu/drm/drm_print.c references the declared symbol under
CONFIG_DRM_USE_DYNAMIC_DEBUG:

    DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS,=
 0,
                            "DRM_UT_CORE",
                            ...);

    static struct ddebug_class_param drm_debug_bitmap =3D {
            .bits =3D &__drm_debug,
            .flags =3D "p",
            .map =3D &drm_debug_classes,
    };

With DECLARE_DYNDBG_CLASSMAP expanding to empty, won't compiling
drivers/gpu/drm/drm_print.c fail with an undeclared identifier error for
drm_debug_classes?

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 027f7c31fe226..8c0a67ad9c922 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -329,7 +329,8 @@ static bool ddebug_match_desc(const struct ddebug_que=
ry *query,
>  	/* site is class'd */
>  	site_map =3D ddebug_find_map_by_class_id(di, dp->class_id);
>  	if (!site_map) {
> -		WARN_ONCE(1, "unknown class_id %d, check %s's CLASSMAP definitions", d=
p->class_id, di->mod_name);
> +		pr_warn_ratelimited("unknown class_id %d, check %s's CLASSMAP definiti=
ons\n",
> +				    dp->class_id, di->mod_name);
>  		return false;
>  	}
>  	/* module(-param) decides protection */
> @@ -1583,18 +1584,80 @@ static void ddebug_apply_class_users(const struct=
 _ddebug_info *di)
>  		__di->_vec.start =3D __start;				\
>  })
> =20
> -static int ddebug_class_range_overlap(struct ddebug_class_map *cm, u64 *=
reserved_ids)
> +static bool ddebug_validate_class_range(const char *modname,
> +					const char *name,
> +					int base, int length,
> +					u64 *reserved_ids)
>  {
> -	u64 range =3D (((1ULL << cm->length) - 1) << cm->base);
> +	u64 range;
> =20
> +	if (base < 0 || length <=3D 0 ||
> +	    base + length > _DPRINTK_CLASS_DFLT) {
> +		pr_err("module %s: base:%d len:%d (from %s) exceeds class_id limit %d\=
n",
> +		       modname, base, length, name, _DPRINTK_CLASS_DFLT);
> +		return false;
> +	}
> +	range =3D (((1ULL << length) - 1) << base);
>  	if (range & *reserved_ids) {
> -		pr_err("[%d..%d] on %s conflicts with %llx\n", cm->base,
> -		       cm->base + cm->length - 1, cm->class_names[0],
> -		       *reserved_ids);
> -		return -EINVAL;
> +		pr_err("module %s: [%d..%d] (from %s) conflicts with 0x%llx\n",
> +		       modname, base, base + length - 1, name, *reserved_ids);
> +		return false;
>  	}
>  	*reserved_ids |=3D range;
> -	return 0;
> +	return true;
> +}
> +
> +static bool ddebug_validate_classmaps(struct _ddebug_info *di)
> +{
> +	struct ddebug_class_map *cm;
> +	struct ddebug_class_user *cli;
> +	u64 reserved_ids =3D 0;
> +	bool valid =3D true;
> +	int i;
> +
> +	for_subvec(i, cm, di, maps)
> +		if (!ddebug_validate_class_range(di->mod_name,
> +						 cm->class_names[0],
> +						 cm->base, cm->length,
> +						 &reserved_ids))
> +			valid =3D false;
> +
> +	for_subvec(i, cli, di, users) {
> +		if (!cli->map) {
> +			pr_err("module %s: classmap not found for user\n",
> +			       di->mod_name);
> +			valid =3D false;
> +			continue;
> +		}
> +		if (!ddebug_validate_class_range(di->mod_name,
> +						 cli->map->class_names[0],
> +						 cli->map->base + cli->offset,
> +						 cli->map->length,
> +						 &reserved_ids))
> +			valid =3D false;
> +	}
> +	return valid;
> +}
> +
> +static void ddebug_validate_descs(struct _ddebug_info *di)
> +{
> +	struct _ddebug *dp;
> +	u64 bad_ids =3D 0;
> +	int i;
> +
> +	for (i =3D 0; i < di->descs.len; i++) {
> +		dp =3D &di->descs.start[i];
> +
> +		if (dp->class_id =3D=3D _DPRINTK_CLASS_DFLT)
> +			continue;
> +		if (bad_ids & (1ULL << dp->class_id))
> +			continue;
> +		if (!ddebug_find_map_by_class_id(di, dp->class_id)) {
> +			pr_warn("module %s uses unknown class_id %d\n",
> +				di->mod_name, dp->class_id);
> +			bad_ids |=3D (1ULL << dp->class_id);
> +		}
> +	}
>  }
[ ... ]
> @@ -1638,10 +1700,10 @@ static int ddebug_add_module(struct _ddebug_info =
*di)
>  	dd_set_module_subrange(i, cm, &dt->info, maps);
>  	dd_set_module_subrange(i, cli, &dt->info, users);
> =20
> -	/* insure 2+ classmaps share the per-module 0..62 class_id space */
> -	for_subvec(i, cm, &dt->info, maps)
> -		if (ddebug_class_range_overlap(cm, &reserved_ids))
> -			goto cleanup;
> +	if (!ddebug_validate_classmaps(&dt->info))
> +		goto cleanup;
> +
> +	ddebug_validate_descs(&dt->info);

[Severity: Medium]
Were the changes in lib/dynamic_debug.c, lib/test_dynamic_debug.c, and
tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh accidentally squas=
hed
into this patch?

The commit description only discusses adding DEBUG-biased fallback stubs for
_dynamic_func_call_cls in include/linux/dynamic_debug.h (and notes that the
!DEBUG case uses an if (0) statement-expression returning 0, whereas the ma=
cro
uses do { if (0) ... } while (0)).

However, the patch also includes runtime changes in lib/dynamic_debug.c:
- Replacing ddebug_class_range_overlap() with ddebug_validate_class_range()
  and ddebug_validate_classmaps() to check class_id bounds and validate
  di->users during ddebug_add_module().
- Adding ddebug_validate_descs() to warn on unknown descriptor class_id val=
ues
  in ddebug_add_module().
- Replacing WARN_ONCE() and WARN() with pr_warn_ratelimited() and pr_err() =
in
  ddebug_match_desc(), ddebug_add_module(), and ddebug_module_notify().
- Adding the DD_RUNTIME_CLASS_CHECK test block in lib/test_dynamic_debug.c =
and
  updating FT_test_classes.3 in dyndbg_selftest.sh.

Should these runtime validation and selftest changes be folded into the
earlier classmap validation patches in the series or split into a separate
commit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-dd-cmap-pa=
rt2-clean-v13-0-9267923be612@gmail.com?part=3D36
