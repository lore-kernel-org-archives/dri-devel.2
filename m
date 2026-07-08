Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0AFC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 02:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B31510EF95;
	Wed,  8 Jul 2026 02:24:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A3aowv0b";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1481810EF95
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 02:24:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 30DAE6001A;
 Wed,  8 Jul 2026 02:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC02F1F000E9;
 Wed,  8 Jul 2026 02:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783477464;
 bh=0/tpV7om0mq0D47x0oAvdgpxEIffLwqkt+J+RPoXadY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A3aowv0bLRsjT4T3VcBdORmprXrcJB+pcl4Xx6z+LA0pgikoue9uuQZDXBcXoQgvL
 XKD95++6DMza0bkc+rGIOB/DVeXog9AfI9GpKLx71e++TuIdXj5Yi9WjPN7XZpA5qo
 XhhMRcc+d5AYmf2bRHIwdOXfzOmOWuBiblzzGFJg/T2o98Jb8yFfyYNPxEGIijgYuD
 3FVXx0wVRYKOy7F/jqIYlu7lMpWBp26ljTh4NymesZinYL4/kbRmciOK0egJGzd5GP
 ZbxiR69QSxZUKw0w4dxaO6LlS2ReeC7Op2HUa2mEBIiNIGyUnkav80FmlDNJdhZRMe
 4/+ZmILpjAauQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/24] dyndbg: drop NUM_TYPE_ARGS
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260707-dd-maint-2-v6-10-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
 <20260707-dd-maint-2-v6-10-381f3edb0045@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 02:24:24 +0000
Message-Id: <20260708022424.AC02F1F000E9@smtp.kernel.org>
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
- [Low] The newly defined macro __DDEBUG_ARRAY_SIZE is unused because the a=
rray size calculation is manually open-coded.
--

--- Patch [10]: [PATCH v6 10/24] dyndbg: drop NUM_TYPE_ARGS ---
commit 0ca0f4a344ab62c4d4df9c27a60daf65fecad136
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg: drop NUM_TYPE_ARGS

This commit removes the NUM_TYPE_ARGS macro and replaces it with an array
size calculation. The commit message mentions adding a new local macro named
__DDEBUG_ARRAY_SIZE to handle this without causing include conflicts.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index 9607121c3072e..9ae1accb9bf63 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -8,6 +8,8 @@
> =20
>  #include <linux/build_bug.h>
> =20
> +#define __DDEBUG_ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> +

[ ... ]

> @@ -122,11 +124,9 @@ struct ddebug_class_param {
>  		.mod_name =3D KBUILD_MODNAME,				\
>  		.base =3D _base,						\
>  		.map_type =3D _maptype,					\
> -		.length =3D NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
> +		.length =3D (sizeof(_var##_classnames) / sizeof(_var##_classnames[0]))=
, \

[Severity: Low]
This isn't a bug, but should this line use the new __DDEBUG_ARRAY_SIZE macro
introduced above? The calculation appears to be manually open-coded here,
leaving the newly defined macro unused.

>  		.class_names =3D _var##_classnames,			\
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-dd-maint-2=
-v6-0-381f3edb0045@gmail.com?part=3D10
