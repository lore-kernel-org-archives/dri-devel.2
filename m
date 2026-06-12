Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5B9CD98CC
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 05:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 311B410E680;
	Fri, 12 Jun 2026 05:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rh9bJ1jT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C18810E56F
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 05:22:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E4973600FC;
 Fri, 12 Jun 2026 05:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB2F1F000E9;
 Fri, 12 Jun 2026 05:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781241745;
 bh=2dSAlgDdneDeTOwlCttSC0G8QyJZ0rZv1RohNexOGOA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Rh9bJ1jTJFYk/XQet3y2+0ZBzxQVxWjoQSDgH85wjdUhz6lwxcmoZeV0pJTvLa2x5
 2h6eZtvBfcctDmSux/tBkueSN3/sELKbo7Q+Fnod5o6fiquXFUDuNK6zO5KkM5jY7+
 xCDKhWHTLoWzNgni99fRNPAx2s3BbgMYjHRx1rbEwSmcO0IR22fWRMnHXENLt+yvz8
 XJC6Jf2lKJ/lMQJamVi52/ntDjZF7ckEz/0vniAF2blGGgYsWWV9VFi3u5abzY/z8l
 b01wbeqXJBuKgOzJQelcoMQK8JS90t9JXGdUmZ1LFLKQBf3q75ql0uG8KRqdaMvaC4
 vuS5JimR4lX1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/xe/xe_drm_ras: Add error-event support in XE
 drm_ras
To: "Riana Tauro" <riana.tauro@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260611052144.784969-6-riana.tauro@intel.com>
References: <20260611052144.784969-6-riana.tauro@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 05:22:25 +0000
Message-Id: <20260612052225.7DB2F1F000E9@smtp.kernel.org>
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
- [Medium] Non-ratelimited `drm_err` in atomic context can cause console fl=
ood and soft lockups under memory pressure.
--

commit fadf160f443d10205c2dcc1f2b3421344e7bb067
Author: Riana Tauro <riana.tauro@intel.com>

drm/xe/xe_drm_ras: Add error-event support in XE drm_ras

This commit adds error-event support in the XE drm_ras subsystem. It notifi=
es
userspace via netlink when a hardware error occurs, allowing tools to
subscribe to these events.

> diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_=
ras.c
> index cd236f53699e0..09588e3fd984d 100644
> --- a/drivers/gpu/drm/xe/xe_drm_ras.c
> +++ b/drivers/gpu/drm/xe/xe_drm_ras.c

[ ... ]

> +void xe_drm_ras_event(struct xe_device *xe, u32 component, u32 severity,=
 u32 value, gfp_t flags)
> +{
> +	struct xe_drm_ras *ras =3D &xe->ras;
> +	struct xe_drm_ras_counter *info =3D ras->info[severity];
> +	struct drm_ras_node *node =3D &ras->node[severity];
> +	int ret;
> +
> +	if (!info || !info[component].name)
> +		return;
> +
> +	ret =3D drm_ras_nl_error_event(node, component, info[component].name, v=
alue, flags);
> +	if (ret)
> +		drm_err(&xe->drm, "RAS error-event failed: %d for %s %s\n", ret,
> +			info[component].name, error_severity[severity]);

[Severity: Medium]
Could this un-ratelimited drm_err() cause console flooding and soft lockups
under memory pressure?

This function is called by hw_error_source_handler(), which iterates over
hardware errors while holding xe->irq.lock with interrupts disabled. Since
the netlink message allocation uses GFP_ATOMIC, it can fail repeatedly under
low memory conditions.

If an interrupt storm of hardware errors occurs, repeatedly printing to the
console from within a hard IRQ spinlock could heavily stall the CPU and
trigger RCU stalls or watchdogs.

Would it be safer to use drm_err_ratelimited() here, matching the behavior
of the other error logging in hw_error_source_handler()?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611052144.7849=
69-4-riana.tauro@intel.com?part=3D2
