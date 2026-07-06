Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7910C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1159610E92D;
	Mon,  6 Jul 2026 12:03:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fa9CyTnM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11C2F10E92D
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 12:03:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4744F600BB;
 Mon,  6 Jul 2026 12:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDA11F000E9;
 Mon,  6 Jul 2026 12:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783339394;
 bh=4VUHGscTyh1hRhgOtbe/TJZc92NRl9NzOAWSlEs/Ov0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fa9CyTnMcl+S9PiyBP3aXCmCPAfoSNJ7oNRWSb7tPChfZt5Rd36lIA5iddiqzD3EA
 x04U4oYrkqtkaWGKldkvTbXI8ZWTCO4/hBGLAn1ngaHZNi90rJLilQiNvnALv7YL72
 WGhpix2mBBocr7raF35sGDpouVQ0z8kKlotgfh08PVry8jWHFMfkDUPIQi4b5gFJYN
 Cn5Y0jvrQFsYaJT88K8vPxhMBdn4AQjMmK778Vbf5YRw4YJxjB4l4ODAh72Q7oyvaw
 ZTtdJx7Vn8t7pMPGdV33c8XUnFnWoU5CAzvuKv4m4+6I7D+zvt0uVw6QL28i7IeY8P
 6HsxTsYwMSNnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/7] drm/i915/gt: Use spin_lock_irq() instead of
 local_irq_disable() + spin_lock()
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706114823.752313-2-dev@lankhorst.se>
References: <20260706114823.752313-1-dev@lankhorst.se>
 <20260706114823.752313-2-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 12:03:13 +0000
Message-Id: <20260706120313.CFDA11F000E9@smtp.kernel.org>
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
- [High] Hardware MMIO submission sequence in `execlists_submit_ports()` is=
 executed with interrupts and preemption enabled, violating the requirement=
 for atomic hardware submission.
--

commit a1c2160ec1a5e4791ddd349b07f9fe856a1bb2e5
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

drm/i915/gt: Use spin_lock_irq() instead of local_irq_disable() + spin_lock=
()

This commit replaces local_irq_disable() and spin_lock() with spin_lock_irq=
()
to improve PREEMPT_RT compatibility, and removes the execlists_dequeue_irq()
wrapper.

> diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drive=
rs/gpu/drm/i915/gt/intel_execlists_submission.c
> index 1359fc9cb88ef..e11db81dca9c5 100644
> --- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
> +++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c

[ ... ]

> @@ -1588,7 +1588,7 @@ static void execlists_dequeue(struct intel_engine_c=
s *engine)
>  	 */
>  	sched_engine->queue_priority_hint =3D queue_prio(sched_engine);
>  	i915_sched_engine_reset_on_empty(sched_engine);
> -	spin_unlock(&sched_engine->lock);
> +	spin_unlock_irq(&sched_engine->lock);

[Severity: High]
Is it safe to unconditionally re-enable interrupts and preemption here befo=
re
the hardware submission?

Looking at execlists_dequeue(), shortly after this unlock the code calls
execlists_submit_ports(). The Execlist Submit Port (ELSP) mechanism typical=
ly
requires consecutive MMIO writes to submit hardware contexts.

Previously, the entire function was wrapped in local_irq_disable() via
execlists_dequeue_irq(). With spin_unlock_irq() completely enabling
interrupts (and preemption on PREEMPT_RT) prior to the submission, could a
hard interrupt or task preemption delay the sequence of MMIO writes?

This seems like it might lead to partial submissions, hardware timeouts, or
GPU hangs if the hardware submission sequence is no longer atomic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706114823.7523=
13-1-dev@lankhorst.se?part=3D1
