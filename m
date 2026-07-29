Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E3EC53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:25:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 537C410E046;
	Wed, 29 Jul 2026 12:25:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ow0T7gqj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C52110E046
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 12:25:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F1AA643DFF;
 Wed, 29 Jul 2026 12:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99081F00A3A;
 Wed, 29 Jul 2026 12:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785327933;
 bh=9QnSBR2RnTREcAh+z0cnmp7b/14MwucqRLrFsytNM3I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ow0T7gqjfgpaG61cJpd0iAMOswHfTvF1GkI4XtNXVE/Zj3rbPHoq+nfKQ95sNDpo4
 np7ADETQGe60PbU6LuqxjBgxOPAMoTj20slXOJaonhI7YjSw+V1IAieNwjSckCgqPN
 10DK18p7F7ZFsvtLbd8vACI6rf3Kw0/MQt0UK+f5pLRymEmVvt1o9hsT3fyW5m7I7d
 IoPVpKar2QQvdbsBw1W7mUN97VUl0J8N8CwKjbHGgTuSwibDa8X/LdFZirLsTLAmYJ
 jtwK/7bezZjTUa1pQgWzMJrgu/o8M49sdRNmVusYzQ6JlbQ670ON7gn9fCuP+/cabn
 sB59/wsql5HNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] drm/connector: Introduce "min bpc" connector
 property
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729-min-bpc-v2-1-7d0036ef437c@collabora.com>
References: <20260729-min-bpc-v2-0-7d0036ef437c@collabora.com>
 <20260729-min-bpc-v2-1-7d0036ef437c@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 12:25:33 +0000
Message-Id: <20260729122533.A99081F00A3A@smtp.kernel.org>
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
- [Medium] Missing generic bounds validation for `min_requested_bpc` agains=
t `max_bpc` in core DRM atomic check.
- [Low] The newly introduced 'min_requested_bpc' field is not printed in de=
bugfs atomic state dumps.
--

--- Patch [1]: [PATCH v2 1/2] drm/connector: Introduce "min bpc" connector =
property ---
commit c6fed32ee27d744d2ae9e2fb7635ec916f3ea61f
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

    drm/connector: Introduce "min bpc" connector property
   =20
    Add a new KMS connector property called "min bpc". Its purpose is to
    allow userspace to mandate that the output bit depth ends up greater
    than or equal to a specified depth, or else have the commit fail. This
    is useful for checking for output depth degradation in combination with
    atomic test commits.

> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index a0cf0268de483..35f395d46f6b9 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1267,6 +1267,11 @@ struct drm_connector_state {
>  	 */
>  	u8 max_requested_bpc;
> =20
> +	/**
> +	 * @min_requested_bpc: Minimum output bit depth requested by userspace
> +	 */
> +	u8 min_requested_bpc;
> +

[Severity: Low]
Does this omit printing the newly added min_requested_bpc?

When a developer or user reads /sys/kernel/debug/dri/*/state to inspect the
atomic KMS configuration, drm_atomic_connector_print_state() in
drivers/gpu/drm/drm_atomic.c prints max_requested_bpc but doesn't seem to
print min_requested_bpc, which could lead to incomplete state dumps.

[Severity: Medium]
Does the DRM core need to validate that min_requested_bpc <=3D max_bpc?

The core drm_atomic_connector_check() function in drivers/gpu/drm/drm_atomi=
c.c
calculates state->max_bpc but doesn't verify that
state->min_requested_bpc <=3D state->max_bpc.=20

If userspace sets the "min bpc" property to a value higher than max_bpc and
issues an atomic commit, this impossible constraint isn't rejected by the D=
RM
core.

This forces every driver implementing this property to manually check for t=
his
contradiction. If a driver fails to do so, it may silently configure a bit
depth lower than min_requested_bpc, violating the explicit uAPI contract
that the commit must fail if the minimum bit depth cannot be met.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-min-bpc-v2=
-0-7d0036ef437c@collabora.com?part=3D1
