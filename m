Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DAEC982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:05:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC37D89238;
	Wed, 16 Sep 2026 16:05:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hKOEghhf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C23E989238
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 16:05:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 87A4B400E3;
 Wed, 16 Sep 2026 16:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4502A1F000FF;
 Wed, 16 Sep 2026 16:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789574701;
 bh=BGFXcKa4LMmifwRNW3tNkMB2h2wJohAf/+UEkNsg8Bw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hKOEghhfWWSmoxceEBKKdHNr2HiCRnrKpFiTRddFe1CIs0yvs9VpVAuZzMpImnSCh
 wD3zUaxguKMrUSBqc7bbIKcFCrUpIRi6qu0UnyOkpHL4m6dxyRo3mKigT+U75Pdf/l
 XXLAK3ZgGPBsYhpxxrWP/20lfer5m0XH5R/bWGjLyRClkZCpSmPSAfQGKvjH8NbciF
 ylES7vjP7QqWIQ8CkQcvkgASrILx4sk2BKrGyG5ATR1ze/BTGtPKrYyWNg6cUVSKXR
 vYJH2kTSAh6MqIN39Bo+RbFOtUtf/nAnmX/Zlc2rZ+umSUDWi2Wyz0V3FmcrMonsfk
 9Qcx2OOSvMN7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 14/38] dyndbg: Bind callsites and classmaps to
 DDEBUG_MODNAME
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
In-Reply-To: <20260916-dd-cmap-part2-clean-v10-14-af4cf4767707@gmail.com>
References: <20260916-dd-cmap-part2-clean-v10-0-af4cf4767707@gmail.com>
 <20260916-dd-cmap-part2-clean-v10-14-af4cf4767707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:05:00 +0000
Message-Id: <20260916160501.4502A1F000FF@smtp.kernel.org>
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
- [Medium] dyndbg: overriding DDEBUG_MODNAME breaks loadable module classma=
ps
--

commit c306ec85ef6e2f768827879da6cc3ed714ab0291
Author: Jim Cromie <jim.cromie@gmail.com>
dyndbg: Bind callsites and classmaps to DDEBUG_MODNAME

This commit defines DDEBUG_MODNAME to allow subsystems to consolidate their
module names in dynamic debug by overriding it in their Makefiles. It binds
DDEBUG_MODNAME into the callsite and classmap declarator macros instead of
hardcoding KBUILD_MODNAME.

> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index baf5c0853f459..85863e24ad134 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
[ ... ]
> @@ -121,7 +129,7 @@ struct ddebug_class_param {
>  	static struct ddebug_class_map __aligned(8) __used		\
>  		__section("__dyndbg_classes") _var =3D {			\
>  		.mod =3D THIS_MODULE,					\
> -		.mod_name =3D KBUILD_MODNAME,				\
> +		.mod_name =3D DDEBUG_MODNAME,				\

[Severity: Medium]
Will this break loadable module classmaps if a subsystem opts into the
DDEBUG_MODNAME override?

When a module is loaded, the module loader assigns the physical module name
from the .ko filename to dt->mod_name in ddebug_module_notify(). However,
this macro embeds the overridden DDEBUG_MODNAME into cm->mod_name.

In lib/dynamic_debug.c:ddebug_attach_module_classes(), there is a strict
comparison between these two names:

    if (!strcmp(cm->mod_name, dt->mod_name)) {

If the DDEBUG_MODNAME differs from the physical module name, won't the
classmaps be silently discarded for loadable modules?

Also, won't queries against the consolidated module name fail because
ddebug_change() filters using the physical module name?

lib/dynamic_debug.c:ddebug_change() {
    ...
    if (query->module &&
        !match_wildcard(query->module, dt->mod_name))
            continue;
    ...
}

Subsequent patches in the series, such as the one introducing
dd_set_module_subrange(), appear to preserve this logic.

>  		.base =3D _base,						\
>  		.map_type =3D _maptype,					\
>  		.class_names =3D _var##_classnames,			\

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-dd-cmap-pa=
rt2-clean-v10-0-af4cf4767707@gmail.com?part=3D14
