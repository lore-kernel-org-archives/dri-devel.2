Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC64CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 02:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB62710FA8C;
	Wed, 14 Oct 2026 02:37:04 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C41F10FA86
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 02:36:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ECA6444785;
 Wed, 14 Oct 2026 02:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEFA1F000FF;
 Wed, 14 Oct 2026 02:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791945417;
 bh=KAq2Bz7FaZcJL38Vo13nCjImfnA9ikGPoe2ZVW19bqk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HLIkUzuEA6HLyZVn4lXATs3F31nUhLBTQ6/IItGj+DOIadyu6neszJnPuRvDu3lIl
 8jToSYXvYg2WgEPwZDSbBEVJvwQOw44rg2kgaP4y9rgRJm1kfM9nQeumYzOQ3DcLGG
 q+3UsjY+2l2YPkxKzHhv8xABIqlLEagB732lu6fgbIADKDk0MADRMswqANeI/whka7
 IsCImJgU6vfxXT0xxk81OV7RADPfeCkdHvfvGxFaVtgFl1JVFUctrYtvwWmY+OrK4j
 sQGeGjM0i61WbOiEfw/OFARNbhrsJw2gjJkWzd/pLtOy5+ICSBt5aeRi0VJQgJD5VH
 Whnm9AnEtO7rA==
Message-ID: <sashiko-outbox-170721@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 22/40] dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
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
 =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
 linux-kbuild@vger.kernel.org, "Louis Chauvet" <louis.chauvet@bootlin.com>
In-Reply-To: <20261012-dd-cmap-part2-clean-v12-22-3c8cc5725def@gmail.com>
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
 <20261012-dd-cmap-part2-clean-v12-22-3c8cc5725def@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 02:36:55 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] dyndbg: TOCTOU race causes module debug state desynchronization
- [Low] dyndbg: Missing ARRAY_SIZE include in DYNAMIC_DEBUG_CLASSMAP_DEFINE
- [Low] dyndbg: Unreachable return statement in param_get_dyndbg_classes
--

commit b545d297dc88b17fae1f9dd05bfa8c4854dc7fac
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP

This commit replaces DECLARE_DYNDBG_CLASSMAP with an explicit client-server
model using DYNAMIC_DEBUG_CLASSMAP_DEFINE and DYNAMIC_DEBUG_CLASSMAP_USE.
This allows resolving references to parent classmaps and automatically
applying the initial bitmap to the loading module at load time.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -121,17 +138,86 @@ struct ddebug_class_param {
> [ ... ]
> + * DYNAMIC_DEBUG_CLASSMAP_DEFINE - define debug classes used by a module.
> + * @_var:   name of the classmap, exported for other modules coordinated=
 use.
> + * @_mapty: enum ddebug_class_map_type: 0:DISJOINT - independent, 1:LEVE=
L - v2>v1
> + * @_base:  reserve N classids starting at _base, to split 0..62 classid=
 space
> + * @classes: names of the N classes.
> + *
> + * This tells dyndbg what class_ids the module is using: _base..+N, by
> + * mapping names onto them.  This qualifies "class NAME" >controls on
> + * the defining module, ignoring unknown names.
> + */
> +#define DYNAMIC_DEBUG_CLASSMAP_DEFINE(_var, _mapty, _base, ...)		\
> +	static const char *_var##_classnames[] =3D { __VA_ARGS__ };	\
> +	extern struct ddebug_class_map _var;				\
> +	struct ddebug_class_map __aligned(8) __used			\
> +		__section("__dyndbg_class_maps") _var =3D {		\
> +		.mod =3D THIS_MODULE,					\
> +		.mod_name =3D KBUILD_MODNAME,				\
> +		.base =3D (_base),					\
> +		.map_type =3D (_mapty),					\
> +		.length =3D ARRAY_SIZE(_var##_classnames),		\

[Severity: Low]
Does this macro rely on ARRAY_SIZE without including <linux/array_size.h>
or <linux/kernel.h> in <linux/dynamic_debug.h>?

This can cause implicit declaration build errors for modules that use
this macro without independently including the required headers.

> +		.class_names =3D _var##_classnames,			\
> +	};								\
> +	EXPORT_SYMBOL(_var)
>
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -773,6 +795,7 @@ int param_get_dyndbg_classes(char *buffer, const stru=
ct kernel_param *kp)
>  	default:
>  		return -1;
>  	}
> +	return 0;

[Severity: Low]
Is this return statement reachable?

The switch statement on map->map_type exhaustively handles the valid cases
and the default case, returning from all branches. This appears to make
the subsequent return 0 dead code.

>  }
>  EXPORT_SYMBOL(param_get_dyndbg_classes);
> [ ... ]
> @@ -1210,163 +1404,163 @@ static const struct proc_ops proc_fops =3D {
> [ ... ]
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

[Severity: Medium]
Can this lockless read of the global parameter lead to a desynchronization
of the module debug state?

If a concurrent sysfs write to the parameter occurs via
param_set_dyndbg_module_classes(), it reads the old value, applies the
new state to all modules, and then updates the global parameter.

If the module load thread in ddebug_sync_classbits() reads the global
parameter locklessly before the sysfs thread updates it, it will see the
old value and apply it to the new module, overwriting the sysfs changes.

The sysfs thread would then complete, leaving the global parameter updated
but the new module stuck with the old state.

> +		break;
> +	case DD_CLASS_TYPE_LEVEL_NUM:
> +		val =3D READ_ONCE(*dcp->lvl);
> +		new_bits =3D CLASSMAP_BITMASK(val);
> +		v2pr_info("  %s: lvl:%d bits:0x%x\n", KP_NAME(kp), val, new_bits);
> +		ddebug_apply_class_bitmap(dcp, &new_bits, 0, modname);
> +		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-dd-cmap-pa=
rt2-clean-v12-0-3c8cc5725def@gmail.com?part=3D22
