Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B697CDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 15:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABE5C10EBC2;
	Tue, 23 Jun 2026 15:06:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TmupfCSi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AE6510EBC2
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 15:06:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 565FD43E8B;
 Tue, 23 Jun 2026 15:06:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253461F000E9;
 Tue, 23 Jun 2026 15:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782227168;
 bh=aAkUYopCJ4t+k7p59owcWo/SC6D1Nk7ZR1JRvytMK7Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TmupfCSicV3bRmFbMv19TMN7InE4yEqUOIFgwCVodHwIg1srw28YoHrZ0E/MkfmR9
 hqUb0OW4szfabj1qd6dqrwqxMdbk8r/f5r0VletLzZkJlEtBYwod59cTz2rxsEXP9C
 QWYIhdeV4aEMYNagKOKpygTQpBEdtrFayEY4if8CBynGuuRljVwhW8qhF3QFeyOnE/
 Wd/P2xBe8NdVXy4/ftw8U9q6EzNOmL2rltWI06MYguE1j3IAMpU2PdI//bLcAYtwsq
 3g7uDuhynh9YeUFz578uArmYNQSQhFw29GNyQQHKIcu6rZd09y9jr1yDu7H2ntlv4v
 +6msuzA6q8bPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9.5] drm/i915: Disable "busy" pmu event on
 CONFIG_PREEMPT_RT
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260623125745.179419-1-dev@lankhorst.se>
References: <20260622181044.39335-31-dev@lankhorst.se>
 <20260623125745.179419-1-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 15:06:07 +0000
Message-Id: <20260623150608.253461F000E9@smtp.kernel.org>
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
- [Low] The patch uses the non-existent macro `CONFIG_ENABLED()`, which cau=
ses a build failure.
- [Low] Passing a struct by value instead of a pointer to `intel_uc_uses_gu=
c_submission()` causes a compilation error.
- [Low] Missing `fallthrough;` annotation or `break;` statement in switch c=
ase causes a `-Wimplicit-fallthrough` build error.
--

commit b45d05f8f8fec20309384c6ec58105a6c7f737dd
Author: Maarten Lankhorst <dev@lankhorst.se>

drm/i915: Disable "busy" pmu event on CONFIG_PREEMPT_RT

The busyness implementation for guc is incompatible with PMU,
so disable it to prevent upsetting lockdep.

> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_=
pmu.c
> index 1c3bafda9c708..d1949bd3b3b24 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.c
> +++ b/drivers/gpu/drm/i915/i915_pmu.c
> @@ -554,6 +554,9 @@ engine_event_status(struct intel_engine_cs *engine,
>  {
>  	switch (sample) {
>  	case I915_SAMPLE_BUSY:
> +		/* The guc submission engine->busyness() callback has issues with CONF=
IG_PREEMPT_RT */
> +		if (CONFIG_ENABLED(CONFIG_PREEMPT_RT) && intel_uc_uses_guc_submission(=
engine->gt->uc))

[Severity: Low]
Is CONFIG_ENABLED() a valid macro here? It appears this might cause a build
failure and should instead be IS_ENABLED().

Additionally, does intel_uc_uses_guc_submission() expect a pointer to the uc
struct? If uc is embedded in struct intel_gt, passing engine->gt->uc by val=
ue
will cause an incompatible type compilation error. Should this be passed as
&engine->gt->uc?

> +			return -ENODEV;

[Severity: Low]
Does this code fall through to I915_SAMPLE_WAIT when the if condition is
false?=20

Now that the I915_SAMPLE_BUSY case is no longer empty, falling through with=
out
an explicit fallthrough; annotation or a break; statement will trigger a
-Wimplicit-fallthrough warning, which breaks the build.

>  	case I915_SAMPLE_WAIT:
>  		break;
>  	case I915_SAMPLE_SEMA:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623125745.1794=
19-1-dev@lankhorst.se?part=3D1
