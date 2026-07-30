Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4573C55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 13:01:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35EF210EE38;
	Thu, 30 Jul 2026 13:01:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k5WG6xJ8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9A2010EE38
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:01:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7997043CAE;
 Thu, 30 Jul 2026 13:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4661F00A3A;
 Thu, 30 Jul 2026 13:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785416464;
 bh=v7vSAQtb6mkF0V00lPz800zsJTCt6ssEaSYpHcusY08=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k5WG6xJ8v7Vxi9NUuaQl5JXYiUW6YweF7GsjQzwVgnvioLi2Ff+fwym3V6wyMUPAL
 koAL0yNlP4FOgV9Sheq9eMKuUU8Kqrh/O/X7cXNwuiZdq5ksqD+Ax0b4hXEDZAwn6U
 C63UGsmpkCthpjpaTQnBg8pMDsXJ8+gAEG8eaukYCQVg+G2oUfFeoM9SEs7iTDqyva
 n6SP+rFx+PUM+/MoIMNhdfVw82/wKwdBdN5+tAtHEErfDgxN+ms1N4Skkf6aMCJ4as
 QysSof+aAHCXHGeiNTYhhhrFehRdrHRr9FKh0/5ObucjmfygAwFPY+IonKF+4j2LzH
 Cib3c3EqH1jiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/atomic-helper: tear down HPD/polling in
 drm_atomic_helper_shutdown()
To: "Mahadevan P" <mahadevan.p@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730-dpshutdown-v2-1-441fc5543bed@oss.qualcomm.com>
References: <20260730-dpshutdown-v2-1-441fc5543bed@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 13:01:03 +0000
Message-Id: <20260730130104.3B4661F00A3A@smtp.kernel.org>
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
- [High] drm_kms_helper_poll_fini() fails to synchronize with in-flight dri=
ver HPD threads and introduces a TOCTOU race with userspace probing, leavin=
g the original late-modeset bug unfixed.
- [Medium] Calling drm_kms_helper_poll_fini() inside drm_atomic_helper_shut=
down() introduces a regression causing a kernel warning stack trace (drm_WA=
RN_ON) during driver unload.
--

--- Patch [1]: [PATCH v2] drm/atomic-helper: tear down HPD/polling in drm_a=
tomic_helper_shutdown() ---
commit e1bd39c97d78edddf053e357bf0f99d72ae55494
Author: Mahadevan P <mahadevan.p@oss.qualcomm.com>

drm/atomic-helper: tear down HPD/polling in drm_atomic_helper_shutdown()

This commit adds a call to drm_kms_helper_poll_fini() within
drm_atomic_helper_shutdown() to tear down output polling and HPD interrupts.
The goal is to prevent late hotplug events from triggering modesets after t=
he
display hardware and IOMMU mappings have been disabled during shutdown.

Link: https://lore.kernel.org/r/20260717-dpshutdown-v1-1-b062c2f7dfb1@oss.q=
ualcomm.com

> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_at=
omic_helper.c
> index 285aac3554dfd..80c67623180a2 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c

[ ... ]

> @@ -3676,6 +3677,8 @@ EXPORT_SYMBOL(drm_atomic_helper_reset_crtc);
>   *
>   * This is just a convenience wrapper around drm_atomic_helper_disable_a=
ll(),
>   * and it is the atomic version of drm_helper_force_disable_all().
> + *
> + * This also tears down output polling and HPD via drm_kms_helper_poll_f=
ini().
>   */
>  void drm_atomic_helper_shutdown(struct drm_device *dev)
>  {
> @@ -3685,6 +3688,8 @@ void drm_atomic_helper_shutdown(struct drm_device *=
dev)
>  	if (dev =3D=3D NULL)
>  		return;
> =20
> +	drm_kms_helper_poll_fini(dev);

[Severity: High]
Does calling drm_kms_helper_poll_fini() here fully synchronize with in-flig=
ht
driver HPD threads?

While this masks hardware interrupts, it doesn't appear to flush pending IRQ
threads since there is no synchronize_irq() equivalent here. If an HPD
interrupt fires just before shutdown and schedules a driver's threaded IRQ
handler (like msm_dp_display_irq_thread), it seems the thread could wake up,
block on mode_config.mutex, and then trigger an unsolicited modeset after
drm_atomic_helper_shutdown() finishes and releases the locks.

Also, can this introduce a race with userspace probing?

drm_kms_helper_poll_fini() modifies poll_enabled locklessly. A concurrent
GETCONNECTOR ioctl holding mode_config.mutex might read poll_enabled as true
and call drm_kms_helper_poll_enable(), which could turn HPD back on during
the shutdown sequence.

[Severity: Medium]
Could this cause a kernel warning during driver unload?

drm_kms_helper_poll_fini() sets dev->mode_config.poll_enabled to false.
However, many drivers explicitly call drm_kms_helper_poll_disable() during
their own teardown sequences after calling drm_atomic_helper_shutdown()
(for example, in nouveau_display_fini() in the nouveau driver).

Since drm_kms_helper_poll_disable() has a guard check:

if (drm_WARN_ON(dev, !dev->mode_config.poll_enabled))
        return;

It looks like drivers performing standard unload routines will hit this
warning stack trace because the core already silently finalized the polling
state.

> +
>  	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, ret);
> =20
>  	ret =3D drm_atomic_helper_disable_all(dev, &ctx);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-dpshutdown=
-v2-1-441fc5543bed@oss.qualcomm.com?part=3D1
