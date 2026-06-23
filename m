Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9D1CDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:39:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F87610E521;
	Tue, 23 Jun 2026 13:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="daJhQVYI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2902110E521
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 13:39:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DAFDC4405F;
 Tue, 23 Jun 2026 13:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3A41F00ADB;
 Tue, 23 Jun 2026 13:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782221967;
 bh=aLffZc1jrUP8ipjVzuN0KXm8e8UQtX6yaL6i1BWgqEc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=daJhQVYIn2wfYx562RDK6QeYrTD24rhEAAITmU85a/GkTOw5HMlYEeP+CzJYkTDJr
 YFgelkJUpCYD0nA/hNSZRMXBk3k0NYl9wtNNkQj+LMGVQVxaLwaGHKg3Ldu9p4gauM
 Co1r4Boa93B/oOPHLNFmcLt1pxQhJNw/IoCrA0it0ZMJLUq62XNZ9IlIb8/Hv4uQlN
 n8qK23g0VhNCiWdqRzMRGLPxzwvma0MqFJXesV+BGWLSa8D7FEUGl2+x1/BriP+EVo
 y6kmFmTfQFlXjsYqa4yZY9yNzevvfwlvGKnQ4gbWvavxleJhVuqyffblvLKXoZSdkU
 S+Hv/FNCtlS8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9.6] drm/i915: Disable "busy" pmu event on
 CONFIG_PREEMPT_RT
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260623132734.227322-1-dev@lankhorst.se>
References: <20260622181044.39335-31-dev@lankhorst.se>
 <20260623132734.227322-1-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 13:39:27 +0000
Message-Id: <20260623133927.AA3A41F00ADB@smtp.kernel.org>
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
- [Low] Missing `fallthrough;` or `break;` annotation in switch case causes=
 implicit fallthrough warning, which breaks the build.
--

commit e0b7d47d4c0056e301a2d2f6858efe90c7e7bb10
Author: Maarten Lankhorst <dev@lankhorst.se>

drm/i915: Disable "busy" pmu event on CONFIG_PREEMPT_RT

The busyness implementation for guc is incompatible with PMU,
so disable it to prevent upsetting lockdep.

> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_=
pmu.c
> index 1c3bafda9c708..bd7116732285f 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.c
> +++ b/drivers/gpu/drm/i915/i915_pmu.c
> @@ -554,6 +554,9 @@ engine_event_status(struct intel_engine_cs *engine,
>  {
>  	switch (sample) {
>  	case I915_SAMPLE_BUSY:
> +		/* The guc submission engine->busyness() callback has issues with CONF=
IG_PREEMPT_RT */
> +		if (IS_ENABLED(CONFIG_PREEMPT_RT) && intel_uc_uses_guc_submission(&eng=
ine->gt->uc))
> +			return -ENODEV;

[Severity: Low]
Will this trigger a -Wimplicit-fallthrough compiler warning? The case now
contains statements but does not explicitly terminate with a fallthrough;
annotation before the next case.

>  	case I915_SAMPLE_WAIT:
>  		break;
>  	case I915_SAMPLE_SEMA:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623132734.2273=
22-1-dev@lankhorst.se?part=3D1
