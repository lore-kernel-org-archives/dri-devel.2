Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9188DC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E7FA10F1B2;
	Thu,  2 Jul 2026 07:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="asUDfRS9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6733D10F1B2
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 07:36:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 292EE40B5A;
 Thu,  2 Jul 2026 07:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09DB1F00A3A;
 Thu,  2 Jul 2026 07:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782977791;
 bh=0fx1uo4SlnxLF8fEyxW8GnoASHqT4BjRnKDgtPWbkqU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=asUDfRS9FN1XKcvAgrhvp2ZLghYvcRH0cBvOvhKhSpeOGeH6WLlJ3xSzS7rjY/Nzz
 F8TygWqhoIvtOCWRSiAPK2s2BxCN8zIqplDjJVo9RhjJNeCwiQ9npVpeii8Fk0D1uI
 V5jYqMG9SZ5HIhUfLyhUlOAG2nDSjuWqDHnqIsQQ9r8kJMQKdbrGBar1kJwlzyb+ui
 0homkssAhR/cIUeniuK81n4tz6r7KImI//mn/0fpKl1O8gISd+itrGgpSpmNwvtWGx
 9XqQkWIPwaahj1M1ZKwEpTGDw7zVL9f8Oj2MLy2Dx8LJSJsAXsciJebIUlNIHE+1AJ
 HuRcY9bPZeVIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/10] drm/i915: Use preempt_disable/enable_rt() where
 recommended
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702072154.171324-9-dev@lankhorst.se>
References: <20260702072154.171324-1-dev@lankhorst.se>
 <20260702072154.171324-9-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 07:36:30 +0000
Message-Id: <20260702073630.E09DB1F00A3A@smtp.kernel.org>
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
- [Medium] The patch inadvertently removes `local_irq_save()` protection fr=
om the Xe driver's vblank timestamping critical section, allowing hard IRQs=
 to interrupt timing-critical register reads.
- [Low] The sparse context annotations `__acquires(i915->uncore.lock)` and =
`__releases(i915->uncore.lock)` reference an undeclared identifier `i915`.
--

(Note: The format of this report is altered to provide a free-form summary
without directly quoting the patch code, due to automated recitation
restrictions.)

commit 8fb6242d95640a7bbab92fc65f4627e01aae6b0b
Author: Mike Galbraith <umgwanakikbuti@gmail.com>
drm/i915: Use preempt_disable/enable_rt() where recommended

This patch changes preemption disabling in the intel vblank timestamping
critical section, moving spin_lock_irqsave() into helper functions and
explicitly disabling preemption for preempt-rt configurations.

[Severity: Low]
Will this cause a build failure when running the sparse static analyzer?

The sparse annotations __acquires(i915->uncore.lock) and
__releases(i915->uncore.lock) reference the i915 identifier in
intel_vblank_section_enter_irqf() and intel_vblank_section_exit_irqf().
However, the function parameter is named display, and i915 is not locally
declared. Should this reference the uncore lock through the display paramet=
er
instead?

[Severity: Medium]
Could this inadvertently remove IRQ protection for the Xe driver during tim=
ing
critical register reads?

Previously, i915_get_crtc_scanoutpos() explicitly called local_irq_save()
before calling the intel_vblank_section_enter() stub. With this patch, the
IRQ save is moved inside intel_vblank_section_enter_irqf().

However, the #else block implementation of intel_vblank_section_enter_irqf()
merely sets *flags =3D 0. This means builds where that #else block is active
(like the Xe driver) will no longer disable interrupts during this critical
section.

Might this allow hard IRQs to interrupt the sequence, creating an
artificially large time delta between stime and etime, and causing the DRM
core's max_error check to spuriously fail?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702072154.1713=
24-1-dev@lankhorst.se?part=3D8
