Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA76CD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59AA410E3EA;
	Tue, 23 Jun 2026 13:02:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OwlkIiMU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD1AC10E3EA
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 13:02:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B712A41E61;
 Tue, 23 Jun 2026 13:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862511F000E9;
 Tue, 23 Jun 2026 13:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782219752;
 bh=AQ99PVZ7h3RBOmObmcqXNFqrwZbzVRLjUGHllYq7AOk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OwlkIiMUwuL5RytxgH/C96QSD3FLVi4LuLqoYW/f0fSLddMJtQZFnblBq5rtcC8xp
 ePeBrI3op5G3o9jaDnmwmHD9tvy3kat0q1s0qXBJfscL+cEQ9kliGL+Gq6dD0qwyUZ
 esG/B2EE4hd3TTcS3c7MkGENca7zsXCNPtfm6cflUOmn7QVKSgudFaT8bn2OI6Ddel
 gWmBOBdgGRpS2QVufpnmwF14aTns98+f4O3yMmvAb6fYjhsd7vgcLBTXpZcRcXYWEt
 Ggi39SlioeC6YXWaRk40OJicCUSyyMszqwkMGby35ZwZXgsx6Bcuf0U1gA2xTGwMof
 wvQtzzQNBKkLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/7] drm/panthor: Replace the panthor_irq macro
 machinery by inline helpers
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260623-panthor-signal-from-irq-v3-3-2ece396f8ee0@collabora.com>
References: <20260623-panthor-signal-from-irq-v3-0-2ece396f8ee0@collabora.com>
 <20260623-panthor-signal-from-irq-v3-3-2ece396f8ee0@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 13:02:32 +0000
Message-Id: <20260623130232.862511F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Hardware interrupts are unmasked before the OS interrupt handler i=
s successfully registered, risking an unhandled IRQ storm.
--

commit 4e867b9890a5ecc61feefa09f80bbc3aaddcd675
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Replace the panthor_irq macro machinery by inline helpers

This commit removes the panthor_irq macro generation logic and replaces it
with inline helpers to rely on compiler optimization. It also refactors the
prototype of IRQ handlers to take struct panthor_irq instead of struct
panthor_device.

> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/p=
anthor/panthor_device.h
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
[ ... ]
> +static inline int
> +panthor_irq_request(struct panthor_device *ptdev, struct panthor_irq *pi=
rq,
> +		    int irq, u32 mask, void __iomem *iomem, const char *name,
> +		    irqreturn_t (*threaded_handler)(int, void *data))
> +{
[ ... ]
> +	panthor_irq_resume(pirq);
> +	return devm_request_threaded_irq(ptdev->base.dev, irq,
> +					 panthor_irq_default_raw_handler,
> +					 threaded_handler,
> +					 IRQF_SHARED, full_name, pirq);
>  }

[Severity: High]
This is a pre-existing issue, but by calling panthor_irq_resume() before
devm_request_threaded_irq(), does this leave a window where the hardware
interrupt is unmasked before the OS handler is successfully registered?

If the device asserts an interrupt before the handler is fully registered,
or if devm_request_threaded_irq() fails entirely and returns without
subsequently masking the hardware interrupt, could this unhandled interrupt
trigger an IRQ storm? This might cause the kernel's irq core to permanently
disable the shared interrupt line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623-panthor-si=
gnal-from-irq-v3-0-2ece396f8ee0@collabora.com?part=3D3
