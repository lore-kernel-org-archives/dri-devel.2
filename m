Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C054C79F8B
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:23:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8716710E314;
	Sat,  5 Sep 2026 18:23:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mPLP7RiV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE29B10E314
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 18:23:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8F99F43CD2;
 Sat,  5 Sep 2026 18:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B36D1F00A3A;
 Sat,  5 Sep 2026 18:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788632621;
 bh=YUH+lBf0iwqkOAS7me538nbsczAQ8O6W1R0aQjSVNVk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mPLP7RiVZOv3a1wM+oUiPioATwR/33rOigfShLxqYfyWSufCTSU36+8sXkZ4k7SFB
 bKL23TS/Hvj3HGz/rho1r5md0RqArvrovAQBn/r67SJSJ/2c3L/gC+s1+tuAnzBXcf
 Q/7jtiYYgjBNsgsKB/5b+KjGbPe+zhq2nK4geZYyPESdv0RSDFOd4bnZjYaFTnWDO2
 PjHKytadF5ti/vEbL+GwBDgMtfUtDme2D31sL5ahdbb4M0xG46qPXRkXvitb4LzM6P
 ukaIvdM2Am/dO3V/QNVbs730jreTNhAqAjsDsb4XXMjm1WPu+20V4SxrRrVKu71+k+
 RqtNT5uIIiUXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 38/43] docs/dyndbg: add classmap info to howto
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260905-dd-cmap-part2-clean-v8-38-a4cc0674f6fd@gmail.com>
References: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
 <20260905-dd-cmap-part2-clean-v8-38-a4cc0674f6fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:23:40 +0000
Message-Id: <20260905182341.3B36D1F00A3A@smtp.kernel.org>
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
- [Low] The commit message explicitly lists `DYNAMIC_DEBUG_CLASSMAP_PARAM_R=
EF` as one of the API macros being described, but its description is comple=
tely missing from the updated documentation.
- [Low] A grammatical error was introduced when rewording the 'class' keywo=
rd description: 'If the class_name accepted by a module' is missing the wor=
d 'is'.
--

commit 7c3648089dc5012711c87c21ef5abd2076484f7b
Author: Jim Cromie <jim.cromie@gmail.com>

docs/dyndbg: add classmap info to howto

Describe the 3 API macros providing dynamic_debug's classmaps

DYNAMIC_DEBUG_CLASSMAP_DEFINE - create & export a classmap
DYNAMIC_DEBUG_CLASSMAP_USE    - refer to exported map
DYNAMIC_DEBUG_CLASSMAP_PARAM  - bind control param to the classmap
DYNAMIC_DEBUG_CLASSMAP_PARAM_REF + use module's storage - __drm_debug

NB: The _DEFINE & _USE model makes the user dependent on the definer,
just like EXPORT_SYMBOL(__drm_debug) already does.

> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Document=
ation/admin-guide/dynamic-debug-howto.rst
> index 6b934fab695b1..aa3a74deb68f9 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
[ ... ]
> @@ -221,6 +214,25 @@ line
>  	line -1605          // the 1605 lines from line 1 to line 1605
>  	line 1600-          // all lines from line 1600 to the end of the file
> =20
> +class
> +
> +    The given class_name is validated against each module, which may
> +    have declared a list of class_names it accepts.  If the class_name
> +    accepted by a module, callsite & class matching and adjustment

[Severity: Low]
Does this sentence have a missing word? It seems like it should read "If th=
e=20
class_name is accepted by a module".

> +    proceeds.  Examples::
> +
> +	class DRM_UT_KMS	# a drm.debug category
[ ... ]
> @@ -398,3 +415,108 @@ just a shortcut for ``print_hex_dump(KERN_DEBUG)``.
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
The commit message lists DYNAMIC_DEBUG_CLASSMAP_PARAM_REF as one of the API=
=20
macros being described, but its description appears to be missing from this=
=20
section.

Should an explanation for DYNAMIC_DEBUG_CLASSMAP_PARAM_REF be included here=
=20
alongside the others?

> +
> +Classmaps are opt-in: modules invoke _DEFINE or _USE to authorize

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-dd-cmap-pa=
rt2-clean-v8-0-a4cc0674f6fd@gmail.com?part=3D38
