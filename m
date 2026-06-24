Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C99CDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:11:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ED5F10E0DD;
	Wed, 24 Jun 2026 17:11:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NqagIwMO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E308E10E0DD
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 17:11:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B7E6944453;
 Wed, 24 Jun 2026 17:11:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9551F000E9;
 Wed, 24 Jun 2026 17:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782321099;
 bh=An0yBHpkX4HAJ67H1M2ZTzgGDm/OBm5f+woa2ZIn/xc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NqagIwMOH9u9Y2q79to1BEtxPshpUtZ9NH0QJVk+QTNUumhe2H6PwVhehWULdSo4l
 ckrAkiWNAn2W1qXOtChnX3/yJ1mTwQxBUvGJ3e5FutBu5A23H9JLflhxZPwl5c3F1Y
 6ilzl7j7SBtaBLxdN/hbh2oO0RPuUpIdjVBjJa8JNHanOBLh4F2C/iLkFepXI/Lk9A
 rX7qsFsDGTlBdHfbgws4gqfynUpoQ3eAzIgDZl6AXm67zN5boVxs50lLsqUmuOnZek
 LhA+AepHO64K2KBxa3IL1Mq9xtzIs4GmWmgLeol1bUsO2CjFlHQIlMukG1NUo7GYKA
 zv9PxU1rIN2/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/10] backlight: add kernel-internal backlight API
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624165751.2014759-3-mario.limonciello@amd.com>
References: <20260624165751.2014759-1-mario.limonciello@amd.com>
 <20260624165751.2014759-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 17:11:39 +0000
Message-Id: <20260624171139.7B9551F000E9@smtp.kernel.org>
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
- [Medium] `backlight_set_brightness()` incorrectly returns success (0) and=
 generates an erroneous uevent when called on an unregistered or unbound ba=
cklight device (`bd->ops =3D=3D NULL`).
- [Medium] The function-scoped `guard(mutex)(&bd->ops_lock)` holds the lock=
 during `backlight_generate_event()`, violating established subsystem locki=
ng patterns and risking deadlocks.
--

commit ef4454a90178562afe2f7457649f35d82b14a03f
Author: Mario Limonciello (AMD) <superm1@kernel.org>

backlight: add kernel-internal backlight API

This patch adds kernel-internal backlight helpers to allow modifying
backlights from within DRM. This provides user-space with a way to control
backlight via DRM connector properties rather than relying solely on sysfs.

> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backligh=
t/backlight.c
> index ff2c2084c73a4..cd1a161ae7bc6 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c

[ ... ]

> +int backlight_set_brightness(struct backlight_device *bd, unsigned int v=
alue,
> +			      enum backlight_update_reason reason)
> +{
> +	int rc =3D 0;
> +
> +	guard(mutex)(&bd->ops_lock);
> +	if (bd->ops) {
> +		if (value > bd->props.max_brightness)
> +			return -EINVAL;
> +		bd->props.brightness =3D value;
> +		rc =3D backlight_update_status(bd);
> +	}

[Severity: Medium]
Does this incorrectly return success and generate a spurious event if the
backlight device is unregistered or unbound?

If bd->ops is NULL, the update block is skipped and rc remains 0.  Could th=
is
be initialized to a value like -ENXIO to correctly indicate failure instead?

> +	if (rc =3D=3D 0)
> +		backlight_generate_event(bd, reason);

[Severity: Medium]
Should the ops_lock be released before generating the uevent?

Because guard() is used at function scope, the lock is held across
backlight_generate_event().  This means the lock is held during
kobject_uevent_env() and sysfs_notify(), which might lead to stalls or lock
inversions.

Would it be safer to use a scoped_guard() restricted exclusively to the
bd->ops operations block?

> +
> +	return rc;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624165751.2014=
759-1-mario.limonciello@amd.com?part=3D2
