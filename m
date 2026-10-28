Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E954F606A333
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lrsczSxL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 465FA10E103;
	Wed, 28 Oct 2026 20:25:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A34610E134
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 20:25:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D97AC60207;
 Wed, 28 Oct 2026 20:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EB91F01825;
 Wed, 28 Oct 2026 20:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793219120;
 bh=Ch7sW4oN37R+cY4VFTmezwGOny97NPWGWNDoKEDXbyU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lrsczSxLAiJLD3rgActjK/Xi+tSHOcRiRJaE0gBNTTemDGGVHQN75JovHOqeYwWdX
 jkp9VMpoxEXC0QtbEK55c2bw3TNizM7I3rL4jgeGWy/v2jl9Fmw0wWCSEGDdsTToaN
 zu64JetKiAWyg0fd02OHoVvlc/S0QPmi2+j71R8p8ZtosB3lRz/JYckWk44aY7NVOY
 VzBFHYSDd8smK7+NXyQPqzD7KARG6PG1kK8m+0J+2tmph5VoiYU9uMVYSYvSetFn8V
 Oy51hFz/A3tW7spLT989SNYlvQRRQRvZfA2qZZDuxtH4JLkXHQZepXZZkmKlUZBXb0
 a66f1fPgaZimQ==
Message-ID: <sashiko-outbox-188403@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 27/39] dyndbg-API: promote
 DYNAMIC_DEBUG_CLASSMAP_PARAM to API
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
In-Reply-To: <20261027-dd-cmap-part2-clean-v13-27-9267923be612@gmail.com>
References: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
 <20261027-dd-cmap-part2-clean-v13-27-9267923be612@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 20:25:17 +0000
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
- [Low] dyndbg: wrong function name in param_set_dyndbg_module_classes() ke=
rnel-doc
--

commit 43feafd46a08a5ee8ddfaa269bc39a26e9e8a8a4
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg-API: promote DYNAMIC_DEBUG_CLASSMAP_PARAM to API

This commit moves the DYNAMIC_DEBUG_CLASSMAP_PARAM macro from
test_dynamic_debug.c into dynamic_debug.h, splits it into
DYNAMIC_DEBUG_CLASSMAP_PARAM and DYNAMIC_DEBUG_CLASSMAP_PARAM_REF, and adds
fallback definitions for !CONFIG_DYNAMIC_DEBUG.

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 1983f672dcfb2..8d9eb7dc09995 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -698,9 +698,42 @@ static int ddebug_apply_class_bitmap(const struct dd=
ebug_class_param *dcp,

[ ... ]

> +/**
> + * param_set_dyndbg_classes - class FOO >control
> + * @instr: string echo>d to sysfs, input depends on map_type
> + * @kp:    kp->arg has state: bits/lvl, map, map_type
> + * @mod_name: module name or null for all modules with the classes
> + *
> + * Enable/disable prdbgs by their class, as given in the arguments to
> + * DECLARE_DYNDBG_CLASSMAP.  For LEVEL map-types, enforce relative
> + * levels by bitpos.
> + *
> + * Returns: 0 or <0 if error.
>   */
>  static int param_set_dyndbg_module_classes(const char *instr,
>  					   const struct kernel_param *kp,
>  					   const char *mod_name)

[Severity: Low]
Should the kernel-doc identifier here be param_set_dyndbg_module_classes
instead of param_set_dyndbg_classes?

With the comment converted to a /** kernel-doc block in lib/dynamic_debug.c,
building with W=3D1 causes scripts/kernel-doc (via dump_function() in
tools/lib/python/kdoc/kdoc_parser.py) to warn that it was expecting a
prototype for param_set_dyndbg_classes() when encountering the prototype for
param_set_dyndbg_module_classes().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-dd-cmap-pa=
rt2-clean-v13-0-9267923be612@gmail.com?part=3D27
