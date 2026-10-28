Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BFF606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HsjjoPQX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4359F10E6D7;
	Wed, 28 Oct 2026 20:25:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E40F110E210
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 20:25:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C01EA4044B;
 Wed, 28 Oct 2026 20:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089691F01825;
 Wed, 28 Oct 2026 20:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793219115;
 bh=2k29I4YIPJKvXD8D5WaACCIQj3alsOfSXoDVRD69hJA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HsjjoPQXvvp10U7GSXIqo2E5g0/J62pvY/a2+Hy2HGBIL2vgggF1gO6UqvgqekJxL
 by113CvFNRK8PF9u3IzrkCeMgOrjj3y5h2NCth0s9+RRDYsB2qjoCo0nhBvLrJzMWU
 ir9TQwiuprA400e7yqFCEhNqxdq5qK4gdivVm8k9u8QI2Zu5IcbdA4JC5aeq6zHeY/
 diSM8esKSkSF+l+1ARsBpxXnk10r6ljFvLzdCRn3g0xwfBRvLugbbnWaLvw6yoJYoC
 gUfWf9GvIxJQQJGXnQagghpZ8WP/5TSdqsaEelC5thd5la0FlkIwhmlk0OhrRPnnkK
 iyiwynxEOHFog==
Message-ID: <sashiko-outbox-188398@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 22/39] dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
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
In-Reply-To: <20261027-dd-cmap-part2-clean-v13-22-9267923be612@gmail.com>
References: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
 <20261027-dd-cmap-part2-clean-v13-22-9267923be612@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 20:25:13 +0000
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
- [Low] dyndbg: unused ddebug_class_param_to_bits() and unclamped init in d=
debug_sync_classbits()
--

commit 061cb31380a7641ad87f8c44222d55e83ea7da16
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP

This commit replaces DECLARE_DYNDBG_CLASSMAP with
DYNAMIC_DEBUG_CLASSMAP_DEFINE and DYNAMIC_DEBUG_CLASSMAP_USE to support
exporting a classmap from a core module and referencing it from user module=
s.
At module load time, dynamic debug scans both classmap sections and syncs t=
he
initial class bitmap from the controlling kernel parameter.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 18289ca7170b7..ad86365f2474f 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c

[ ... ]

> @@ -1174,6 +1213,163 @@ static const struct proc_ops proc_fops =3D {
>  	.proc_write =3D ddebug_proc_write
>  };
> =20
> +#define vpr_cm_info(cm_p, msg_fmt, ...) ({				\
> +	struct ddebug_class_map const *_cm =3D cm_p;			\
> +	v2pr_info(msg_fmt "%s [%d..%d] %s..%s\n", ##__VA_ARGS__,	\
> +		  _cm->mod_name, _cm->base, _cm->base + _cm->length,	\
> +		  _cm->class_names[0], _cm->class_names[_cm->length - 1]); \
> +	})
> +
> +/*
> + * Modules which define classmaps get them initialized by
> + * param-callback via module.c:parse_one.  Modules which use other's
> + * classmaps must be initialized explicitly.
> + */
> +static inline u32 ddebug_class_param_to_bits(const struct ddebug_class_p=
aram *dcp)
> +{
> +	const struct ddebug_class_map *map =3D dcp->map;
> +
> +	switch (map->map_type) {
> +	case DD_CLASS_TYPE_DISJOINT_BITS:
> +		return *dcp->bits & CLASSMAP_BITMASK(map->length);
> +	case DD_CLASS_TYPE_LEVEL_NUM:
> +		return CLASSMAP_BITMASK(min_t(u32, *dcp->lvl, map->length));
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static void __maybe_unused ddebug_class_param_clamp_input(u32 *inrep, co=
nst struct kernel_param *kp)
> +{
> +	const struct ddebug_class_param *dcp =3D kp->arg;
> +	const struct ddebug_class_map *map =3D dcp->map;
> +
> +	switch (map->map_type) {
> +	case DD_CLASS_TYPE_DISJOINT_BITS:
> +		/* expect bits. mask and warn if too many */
> +		if (*inrep & ~CLASSMAP_BITMASK(map->length)) {
> +			pr_warn("%s: input: 0x%x exceeds mask: 0x%x, masking\n",
> +				KP_NAME(kp), *inrep, CLASSMAP_BITMASK(map->length));
> +			*inrep &=3D CLASSMAP_BITMASK(map->length);
> +		}
> +		break;
> +	case DD_CLASS_TYPE_LEVEL_NUM:
> +		/* input is bitpos, of highest verbosity to be enabled */
> +		if (*inrep > map->length) {
> +			pr_warn("%s: level:%d exceeds max:%d, clamping\n",
> +				KP_NAME(kp), *inrep, map->length);
> +			*inrep =3D map->length;
> +		}
> +		break;
> +	}
> +}
> +
> +/*
> + * Called for class-users and native classmaps during module load.
> + *
> + * Initial sync assumes 0 as old_bits, so it only asserts (+p) classes
> + * explicitly set by the parameter. -DDEBUGs invalidate this assumption
> + * for some pr_debugs; a user can override the developer/builder choice
> + * by toggling the param at runtime.
> + *
> + * Parameters are sampled via READ_ONCE without ddebug_lock;
> + * holding ddebug_lock here would deadlock against ddebug_change().
> + */
> +static void ddebug_sync_classbits(const struct kernel_param *kp, const c=
har *modname)
> +{
> +	const struct ddebug_class_param *dcp =3D kp->arg;
> +	u32 val, new_bits;
> +
> +	if (!dcp || !dcp->map)
> +		return;
> +
> +	switch (dcp->map->map_type) {
> +	case DD_CLASS_TYPE_DISJOINT_BITS:
> +		val =3D READ_ONCE(*dcp->bits);
> +		new_bits =3D val;
> +		v2pr_info("  %s: classbits: 0x%x\n", KP_NAME(kp), new_bits);
> +		ddebug_apply_class_bitmap(dcp, &new_bits, 0, modname);
> +		break;
> +	case DD_CLASS_TYPE_LEVEL_NUM:
> +		val =3D READ_ONCE(*dcp->lvl);
> +		new_bits =3D CLASSMAP_BITMASK(val);
> +		v2pr_info("  %s: lvl:%d bits:0x%x\n", KP_NAME(kp), val, new_bits);
> +		ddebug_apply_class_bitmap(dcp, &new_bits, 0, modname);
> +		break;

[Severity: Low]
Is ddebug_class_param_to_bits() intended to be used here, or should it be
dropped? It is introduced in this patch, but never called here or in the re=
st
of the series (while ddebug_class_param_clamp_input() is only wired into
param_set_dyndbg_module_classes() in the later commit "dyndbg-API: promote
DYNAMIC_DEBUG_CLASSMAP_PARAM to API").

Also, in lib/test_dynamic_debug.c (and later in include/linux/dynamic_debug=
.h
when promoted in "dyndbg-API: promote DYNAMIC_DEBUG_CLASSMAP_PARAM to API"),
DYNAMIC_DEBUG_CLASSMAP_PARAM initializes the backing u32 to ~0 when DEBUG is
defined:

#ifdef DEBUG
#define DYNAMIC_DEBUG_CLASSMAP_PARAM(_model, _flags)		\
	DYNAMIC_DEBUG_CLASSMAP_PARAM_(_model, _flags, ~0)
#else
#define DYNAMIC_DEBUG_CLASSMAP_PARAM(_model, _flags)		\
	DYNAMIC_DEBUG_CLASSMAP_PARAM_(_model, _flags, 0)
#endif

Because ddebug_sync_classbits() reads *dcp->bits and *dcp->lvl directly
without masking or clamping them to dcp->map->length, won't
param_get_dyndbg_classes() report 0xffffffff for DD_CLASS_TYPE_DISJOINT_BITS
(instead of CLASSMAP_BITMASK(map->length)) and 4294967295 for
DD_CLASS_TYPE_LEVEL_NUM (instead of map->length) when built with -DDEBUG?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-dd-cmap-pa=
rt2-clean-v13-0-9267923be612@gmail.com?part=3D22
