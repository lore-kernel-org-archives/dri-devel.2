Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A32FC982FE
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD40010E6FA;
	Tue, 22 Sep 2026 05:44:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HrySoxo5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 559DD10E57A;
 Tue, 22 Sep 2026 05:44:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AE03A4051C;
 Tue, 22 Sep 2026 05:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627E61F000FF;
 Tue, 22 Sep 2026 05:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790055896;
 bh=knOHkNNssZC/WCzdPIHr7eyHyYvflgdXLbRxpXx2EmA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HrySoxo5ofyzIao/DXF1DDz/iMQZeSPNaZiGnI1XaB7ezDfrUJSMCLqJG3ZMRQY3S
 NQp1kZlUO2svxoRnqyvtDOLJhayp4z2rxrRUZqHfhhE7KedhOVbrUlsnswCte4rxLb
 O2I42v18gdgtxPsQbzjRFdm2dI3bNcZO0ecPLatlev/9yzofoYqZ3U6z4qLxJMWdrV
 NF2nSxETu4+cb1uMC3Ghu3ha5JjA0gr8a6B9RWADuLq/FAts+qlwqcNXflJeC4D6ME
 bg/jQqD4QajOUf2gKOy2C9kAQfYnt8Ko8/Xv18225k4KlYnlVmfqNpeYA1glvpw90X
 JvHZu465SfLSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 01/12] mm/Kconfig: changes for migrate on fault for
 device pages
To: mpenttil@redhat.com
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260922053421.4092027-2-mpenttil@redhat.com>
References: <20260922053421.4092027-1-mpenttil@redhat.com>
 <20260922053421.4092027-2-mpenttil@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 05:44:55 +0000
Message-Id: <20260922054456.627E61F000FF@smtp.kernel.org>
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
- [Low] mm/Kconfig: DEVICE_MIGRATION selects HMM_MIRROR without MMU depende=
ncy
--

commit 3e1dfa1b4fc87fd67c61777c9c5e43b8e801f019
Author: Mika Penttil=C3=A4 <mpenttil@redhat.com>

mm/Kconfig: changes for migrate on fault for device pages

This commit explicitly enables HMM for the unified HMM/migrate_device
page table walk in migrate_device, since HMM depends on MMU notifiers.

> diff --git a/mm/Kconfig b/mm/Kconfig
> index 604c58199acbf..b7a485beb9a78 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -687,6 +687,7 @@ config MIGRATION
> =20
>  config DEVICE_MIGRATION
>  	def_bool MIGRATION && ZONE_DEVICE
> +	select HMM_MIRROR

[Severity: Low]
Does this regression violate Kconfig dependency rules by selecting HMM_MIRR=
OR
without inheriting its dependencies?

In mm/Kconfig under DEVICE_MIGRATION, HMM_MIRROR is selected but its MMU
dependency is not included.

While currently unreachable because nothing currently selects DEVICE_MIGRAT=
ION,
if another config unconditionally uses select DEVICE_MIGRATION in the futur=
e,
it forces DEVICE_MIGRATION=3Dy (bypassing the def_bool logic).

This would subsequently force HMM_MIRROR=3Dy on non-MMU architectures, caus=
ing
unmet dependency warnings and potential build failures.

The Kconfig subsystem rules require that any config using select must expli=
citly
inherit the selected symbol's dependencies.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922053421.4092=
027-1-mpenttil@redhat.com?part=3D1
