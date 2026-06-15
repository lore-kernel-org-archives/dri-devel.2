Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A70CD98E2
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:35:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C784810E6C2;
	Mon, 15 Jun 2026 20:35:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PVA/sENt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BD5010E6C0
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 20:35:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0BC6A601E5;
 Mon, 15 Jun 2026 20:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C56A1F000E9;
 Mon, 15 Jun 2026 20:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781555744;
 bh=RV6BN/1IHP1CvSY7NEJpLKmlmYPhNadpbu6aWJ+G+jw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PVA/sENtnA22LBd3R1BweDeslrLLxZhMNd4pKR/a6jjRkhY0sn6KZIedmLMJyxUEA
 me00Rl5doPEAks7Fs15QMMsqTadTs+RCjHSyM7dzTuj2i7IwFjqq+wdz5cd229dXuS
 2O3kkpNbFxqL0r1smKSSMzlIEmYyRYMDlk5HllFZzTibZtl9pkOZDvVqRI4AmVIZ16
 T+MZRL24OOTlxh8jkIlRKkM+BFygdL7S66FXhvBAQ3j3TLJmrehmC78VDmOrzSKfJ+
 5h8iesQD1Cp2XoIOGyLw/QF7kFlgzaPMMScHKcPp9LEcrUtNCzfPRTTNdwuag7YtBh
 iXX1rq069UqPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 24/27] FOR-CI: bump MAX_STACK_TRACE_ENTRIES
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260615201846.307297-25-dev@lankhorst.se>
References: <20260615201846.307297-25-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:35:43 +0000
Message-Id: <20260615203544.8C56A1F000E9@smtp.kernel.org>
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
- [High] Unacceptable minimum memory footprint for lockdep and global CI ha=
ck
- [Medium] Commit message and code mismatch: missing 'reset lockdep' logic
- [Low] Stale Kconfig help text regarding KASAN default
--

commit 6acd80559fe23be49729943270ef9f9a1fa2feeb
Author: Maarten Lankhorst <dev@lankhorst.se>

FOR-CI: bump MAX_STACK_TRACE_ENTRIES

This patch modifies the LOCKDEP_STACK_TRACE_BITS Kconfig limits to address a
bug in CI where MAX_STACK_TRACE_ENTRIES is set too low. It restricts the
allowed range for this value and sets a new default of 22.

> FOR-CI: bump MAX_STACK_TRACE_ENTRIES
>
> We're hitting a bug in CI where MAX_STACK_TRACE_ENTRIES is set too low.
> My guess is the repeated loading/unloading is creating multiples of the
> same entries. As a hack just reset lockdep. This might only be necessary
> for CI + PREEMPT_RT.

[Severity: Medium]
Is the commit message outdated, or is the logic to reset lockdep missing?

The message mentions resetting lockdep as a hack, but the patch only modifi=
es
the LOCKDEP_STACK_TRACE_BITS limits in Kconfig and includes no code changes
to perform any lockdep reset.

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index e2f976c3301b6..1e670aa6a0812 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1617,9 +1617,8 @@ config LOCKDEP_CHAINS_BITS
>  config LOCKDEP_STACK_TRACE_BITS
>  	int "Size for MAX_STACK_TRACE_ENTRIES (as Nth power of 2)"
>  	depends on LOCKDEP && !LOCKDEP_SMALL
> -	range 10 26
> -	default 21 if KASAN
> -	default 19
> +	range 22 26
> +	default 22

[Severity: High]
Does this force a massive minimum memory footprint on all systems?

Bumping the range to a minimum of 22 forces 2^22 (4,194,304) entries global=
ly
for all builds with lockdep enabled. On 64-bit systems, this mandates a
minimum allocation of roughly 33.5 MB of kernel memory.=20

Is it possible to avoid forcing this large footprint on memory-constrained
embedded systems just for a CI workaround?

>  	help
>  	  Try increasing this value if you hit "BUG: MAX_STACK_TRACE_ENTRIES to=
o low!" message.

[Severity: Low]
Does the help text below this line need to be updated?

The KASAN conditional default was removed, but the extended help text still
reads "The higher default when KASAN is enabled costs ~12MB extra..." which
is now stale and contradicts the new configuration limits.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615201846.3072=
97-1-dev@lankhorst.se?part=3D24
