Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A09ECC6B22
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 02:37:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1A2010FA8B;
	Wed, 14 Oct 2026 02:37:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7B1710FA8B
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 02:37:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 85C34434E0;
 Wed, 14 Oct 2026 02:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6F71F000FF;
 Wed, 14 Oct 2026 02:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791945424;
 bh=qvXUCGz/HJTAYiOJIcwOHti2jnT5T+d//JhOF/D+Pso=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=N9gP/woHuYkHkTk+j13TZBPk8Y9/2GCT30K5MJcI3cl6oiavPIqkilCY117VCrKEg
 9rv/G0uKFBm2HXv09wWYgDDY7OGN+497gjrk/ot1EISun/1bi6RGInUSZzsQCzaI/b
 ga783A4BIjdNLLoZUsdG6pgQZpFd4Nz7GqYz/rP+oRtsfH1KA5lfnJq220inm18QtL
 Ze89skgsfIhfEGgPg+RhHQ5xUqXdOZxyuWCvHZmEZwwiaHX5D1gJPx/g/F/LGwY07I
 Id21NxmfSwR+ro+/TyIiDR7sxGGGzfRWCxPtAc13iHG3Mo3sbvACXElDdAR33lHHuc
 Jy5v/AdqjRiZQ==
Message-ID: <sashiko-outbox-170731@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 32/40] docs/dyndbg: add classmap info to howto
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
In-Reply-To: <20261012-dd-cmap-part2-clean-v12-32-3c8cc5725def@gmail.com>
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
 <20261012-dd-cmap-part2-clean-v12-32-3c8cc5725def@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 02:37:02 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] docs/dyndbg: incorrect signature for DYNAMIC_DEBUG_CLASSMAP_PARAM
- [Low] docs/dyndbg: commit message count mismatch for API macros
--

commit 28be193f6b722396acbf0216c1b36e74ba099d0b
Author: Jim Cromie <jim.cromie@gmail.com>

docs/dyndbg: add classmap info to howto

Describes the dynamic debug classmaps API and macro usage in the howto
documentation.

> Describe the 3 API macros providing dynamic_debug's classmaps
>=20
> DYNAMIC_DEBUG_CLASSMAP_DEFINE - create & export a classmap
> DYNAMIC_DEBUG_CLASSMAP_USE    - refer to exported map
> DYNAMIC_DEBUG_CLASSMAP_PARAM  - bind control param to the classmap
> DYNAMIC_DEBUG_CLASSMAP_PARAM_REF + use module's storage - __drm_debug

[Severity: Low]
This isn't a bug, but the commit message states it will describe 3 API macr=
os
while actually listing and describing 4 of them. Should this count be updat=
ed
to match the list?

> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Document=
ation/admin-guide/dynamic-debug-howto.rst
> index a8962ab22aaf0..f5b1470a4b881 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
[ ... ]
> +Dynamic Debug Classmap API
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +DYNAMIC_DEBUG_CLASSMAP_DEFINE(clname,type,_base,classnames) - this maps
> +classnames (a list of strings) onto class-ids consecutively, starting
> +at _base.
> +
> +DYNAMIC_DEBUG_CLASSMAP_USE(clname) & _USE_(clname,_base) - modules
> +call this to refer to the var _DEFINEd elsewhere (and exported).
> +
> +DYNAMIC_DEBUG_CLASSMAP_PARAM(clname) - creates the sysfs/kparam,
> +maps/exposes bits 0..N as class-names.

[Severity: Low]
Does DYNAMIC_DEBUG_CLASSMAP_PARAM only take one argument here?

The kernel macro defined in include/linux/dynamic_debug.h requires three
arguments: _name, _var, and _flags. Could this discrepancy mislead develope=
rs
attempting to use the API?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-dd-cmap-pa=
rt2-clean-v12-0-3c8cc5725def@gmail.com?part=3D32
