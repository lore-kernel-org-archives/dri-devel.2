Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3E4CD98E0
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56C0F10E708;
	Mon, 15 Jun 2026 20:39:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZVjB7Q7S";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A44510E708
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 20:39:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3385C44486;
 Mon, 15 Jun 2026 20:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E231F000E9;
 Mon, 15 Jun 2026 20:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781555977;
 bh=98bAbI4gaGex3JmSfN5+zCVhCyTvdoXAT92LvlqfEOk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZVjB7Q7SgqZPhQlIkzt3kj0EvDWvw8+kHCrYnkgldyOK/phmSC1jnZXbSH/5Vzqdb
 ncjuXSRqeprJQzQHAYhBlNiv2QJiRVclKRVErSj6MAU6nXASJBBq3ccwvkCXbROdgt
 bYylMCQg/OjpRgV0vH6pRXkaLjxof3BtMxJ8zhsMwdr64TvHOD1h7DvlTaOYMC17Qr
 XK28rwQMJaSY9xXQXMPJguNPZqR5j35VswUoCOolJ+IdSOdM3NVbPHqrwWRZ0daBAZ
 i+M9dHurjhy+1t1kTKy7fWGY2Ferb0S21Vo/fDuir14RvU0C+12pueKKZXrooRoKLR
 mcDuGqL/gik6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 23/27] PREEMPT_RT injection
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260615201846.307297-24-dev@lankhorst.se>
References: <20260615201846.307297-24-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:39:36 +0000
Message-Id: <20260615203936.E6E231F000E9@smtp.kernel.org>
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
- [High] PREEMPT_RT is unconditionally enabled for all supported architectu=
res, removing the user prompt.
- [High] DRM_I915_DEBUG_VBLANK_EVADE is moved to the DRM_XE Kconfig and for=
cefully enabled, breaking i915-only builds.
--

commit 64632b1f6e588fa66b14871b397cbf599d637abc
Author: Maarten Lankhorst <dev@lankhorst.se>

PREEMPT_RT injection

This commit forces PREEMPT_RT to be unconditionally enabled for supported
architectures. It also moves DRM_I915_DEBUG_VBLANK_EVADE from the i915
Kconfig to the xe Kconfig, enabling it by default.

> diff --git a/drivers/gpu/drm/i915/Kconfig.debug b/drivers/gpu/drm/i915/Kc=
onfig.debug
> index 52a3a59b4ba2c..5977d0b262b85 100644
> --- a/drivers/gpu/drm/i915/Kconfig.debug
> +++ b/drivers/gpu/drm/i915/Kconfig.debug

[ ... ]

> -config DRM_I915_DEBUG_VBLANK_EVADE
> -	bool "Enable extra debug warnings for vblank evasion"
> -	depends on DRM_I915
> -	default n
> -	help
> -	  Choose this option to turn on extra debug warnings for the
> -	  vblank evade mechanism. This gives a warning every time the
> -	  the deadline allotted for the vblank evade critical section
> -	  is exceeded, even if there isn't an actual risk of missing
> -	  the vblank.
> -
> -	  Recommended for driver developers only.
> -
> -	  If in doubt, say "N".
> -
>  config DRM_I915_DEBUG_RUNTIME_PM
> diff --git a/drivers/gpu/drm/xe/Kconfig.debug b/drivers/gpu/drm/xe/Kconfi=
g.debug
> index 01227c77f6d70..1d5f11c6e88f3 100644
> --- a/drivers/gpu/drm/xe/Kconfig.debug
> +++ b/drivers/gpu/drm/xe/Kconfig.debug

[ ... ]

> @@ -30,6 +30,11 @@ config DRM_XE_DEBUG
> =20
>  	  If in doubt, say "N".
> =20
> +config DRM_I915_DEBUG_VBLANK_EVADE
> +        def_bool y
> +        depends on DRM_XE
> +

[Severity: High]
Does this code break the vblank evasion debug logic for i915-only builds?

By moving DRM_I915_DEBUG_VBLANK_EVADE out of i915 and defining it as
def_bool y with a dependency on DRM_XE, developers building only i915 can
no longer enable this feature.=20

Additionally, does this unconditionally force the extra debug warnings and
overhead on all xe driver users without providing a way to opt out?

> +
>  config DRM_XE_DEBUG_VM
> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
> index 88c594c6d7fcd..11bec9be95405 100644
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt

[ ... ]

> @@ -90,9 +90,9 @@ config PREEMPT_LAZY
>  endchoice
> =20
>  config PREEMPT_RT
> -	bool "Fully Preemptible Kernel (Real-Time)"
> -	depends on EXPERT && ARCH_SUPPORTS_RT && !COMPILE_TEST
> +	def_bool y
>  	select PREEMPTION
> +	depends on ARCH_SUPPORTS_RT

[Severity: High]
Does this change unintentionally force a Real-Time kernel build on any
architecture where ARCH_SUPPORTS_RT is true?

By changing PREEMPT_RT to def_bool y and removing the prompt, it appears
users are completely prevented from selecting standard preemption models
like PREEMPT_NONE or PREEMPT_VOLUNTARY.=20

This universally alters locking semantics across the entire kernel (for
example, converting spinlocks to rt_mutexes) regardless of whether drivers =
or
systems are prepared for RT.

>  	help
>  	  This option turns the kernel into a real-time kernel by replacing
>  	  various locking primitives (spinlocks, rwlocks, etc.) with

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615201846.3072=
97-1-dev@lankhorst.se?part=3D23
