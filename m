Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEDFCC6B1F
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 02:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACBBE10FA7C;
	Wed, 14 Oct 2026 02:36:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A7E410FA7C
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 02:36:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9FEC642455;
 Wed, 14 Oct 2026 02:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEB21F000FF;
 Wed, 14 Oct 2026 02:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791945413;
 bh=2FfgC2VWYJxMAMF2UyabFWui5TujrsyoVwpq5ybA3QQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ge+uskZW48jKdYTJzxeeYjVLIj7IQSapgt1gGLJQQBP+t+vYAGnd0GSWu38KGRS6W
 6beqOnefcLSmcYKNXKmQQVuvDVhlpXCDA9VI+kZ1OAEWrOQUEpPtlGuGPiewBQMQR5
 FtKL1uA9kMMn40uN/Stj/5J7rohvz9AqiGW6tzK3BhpPPc2CduaCj1cfwUc5QMdfln
 c7uWjdonvfW4YhUnZz3wLRC7xOG1TkoSn1rfTyoHj3JBuKskTqS/WSrN/VUH8CyCm7
 Gn5nPtsoed3lm7WBegWrH1XgcsiflIDH/vn1vKuPtDIhPz8l8E4KQyJ29byvAkn1F9
 J6JWr/N7suYOA==
Message-ID: <sashiko-outbox-170703@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 10/40] dyndbg-API: remove
 DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code
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
In-Reply-To: <20261012-dd-cmap-part2-clean-v12-10-3c8cc5725def@gmail.com>
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
 <20261012-dd-cmap-part2-clean-v12-10-3c8cc5725def@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 02:36:51 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dyndbg: documentation references future struct _ddebug_class_map
--

commit 4edbf52dcd2e7bd06805f06e89c8d2ce8672c81b
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg-API: remove DD_CLASS_TYPE_(DISJOINT|LEVEL)_NAMES and code

This commit removes the unused DD_CLASS_TYPE_DISJOINT_NAMES and
DD_CLASS_TYPE_LEVEL_NAMES classmap types and their corresponding code.
It also renames enum class_map_type to enum ddebug_class_map_type.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index a10adac8e8f00..9607121c3072e 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h

[ ... ]

> @@ -119,8 +109,8 @@ struct ddebug_class_param {
> =20
>  /**
>   * DECLARE_DYNDBG_CLASSMAP - declare classnames known by a module
> - * @_var:   a struct ddebug_class_map, passed to module_param_cb
> - * @_type:  enum class_map_type, chooses bits/verbose, numeric/symbolic
> + * @_var:   a struct _ddebug_class_map, passed to module_param_cb

[Severity: Low]
This isn't a bug, but does this documentation reference a struct that doesn=
't
exist yet?

The comment here refers to struct _ddebug_class_map (with an underscore),
but the macro DECLARE_DYNDBG_CLASSMAP currently instantiates struct
ddebug_class_map. Is it intentional to document the future name before the
actual struct rename occurs in a later patch?

> + * @_maptype: enum ddebug_class_map_type, chooses bits/verbose
>   * @_base:  offset of 1st class-name. splits .class_id space
>   * @classes: class-names used to control class'd prdbgs
>   */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-dd-cmap-pa=
rt2-clean-v12-0-3c8cc5725def@gmail.com?part=3D10
