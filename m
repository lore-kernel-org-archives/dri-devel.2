Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B731CC61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 22:02:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 762DA10E1C1;
	Mon, 31 Aug 2026 22:02:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="POGI8c8E";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED39110E1C1;
 Mon, 31 Aug 2026 22:02:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1B791601DE;
 Mon, 31 Aug 2026 22:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828DC1F000E9;
 Mon, 31 Aug 2026 22:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788213724;
 bh=evn7OQKD+lUQL0qPNw9K4hFFAkMKzc7AUGrtcUyzXos=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=POGI8c8EVs8YvQotEOwnDnz51jY7IPac2PbP9bwL6WFpMylJdYO+v5rLj6fXQleHm
 zjAkj8qr1qu+ci7guPbYlPvEOI1XzWBGYkGh2SLrZwWbE+7tAfbKK+rAhSZRmPcMge
 1mF6wfE1QuovVYtX9s7gM8Zscqropdgi6lv8gZzfNpoYQ6raeh3yaB+YHpqEKV9Mzf
 9HERruAPh9IP6DXsz5hlnasFDdKcFImiTOvjek4ecisBR98NEt19NN4cP6mGKVFoo2
 euidvt9JR6ADwouPQBfzEHLQPcySmV07RRDA6sCtbBBDAMu4h7N7t+CyMpuwSots1M
 /THJ0KpefkTzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/12] Revert "backlight: Remove notifier"
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260831210531.2334221-2-mario.limonciello@amd.com>
References: <20260831210531.2334221-1-mario.limonciello@amd.com>
 <20260831210531.2334221-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:02:03 +0000
Message-Id: <20260831220204.828DC1F000E9@smtp.kernel.org>
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
- [High] `backlight_device_get_by_type()` does not take a reference on the =
returned device pointer, leading to Use-After-Free vulnerabilities in calle=
rs.
--

commit 910d8ccf8b36f6154658d6c354c95ebb55830e1d
Author: Mario Limonciello <mario.limonciello@amd.com>

Revert "backlight: Remove notifier"

This reverts commit 5461f3fd74a89757f95f351eb0bc26aafc2a2e91. The
backlight notifier support is needed in order to add backlight control
support into DRM connectors.

> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index f29a9ef1052e7..015183d129f96 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
[ ... ]
> @@ -388,6 +408,8 @@ void devm_backlight_device_unregister(struct device *=
dev,
>  				      struct backlight_device *bd);
>  void backlight_force_update(struct backlight_device *bd,
>  			    enum backlight_update_reason reason);
> +int backlight_register_notifier(struct notifier_block *nb);
> +int backlight_unregister_notifier(struct notifier_block *nb);
>  struct backlight_device *backlight_device_get_by_name(const char *name);
>  struct backlight_device *backlight_device_get_by_type(enum backlight_typ=
e type);

[Severity: High]
This is a pre-existing issue, but does backlight_device_get_by_type() need =
to
increment the reference count of the returned device pointer?

Currently, backlight_device_get_by_type() in
drivers/video/backlight/backlight.c returns a pointer to the backlight
device without taking a reference:

drivers/video/backlight/backlight.c:backlight_device_get_by_type() {
    ...
    mutex_unlock(&backlight_dev_list_mutex);
    return found ? bd : NULL;
}

Callers like int3406_thermal_probe() in
drivers/thermal/intel/int340x_thermal/int3406_thermal.c call this and
permanently cache the returned pointer:

    bd =3D backlight_device_get_by_type(BACKLIGHT_RAW);
    if (!bd)
        return -ENODEV;
    d->raw_bd =3D bd;

Because the reference count is not incremented (for example, via
get_device(&bd->dev)), a concurrent unbind of the raw backlight driver
will unregister and free the backlight device.

The thermal driver remains unaware, and subsequent reads or writes to the
thermal sysfs attributes (such as
/sys/class/thermal/cooling_deviceX/cur_state) will call
int3406_thermal_get_cur_state(), which dereferences the freed pointer
(d->raw_bd->props.brightness).

Could we add get_device() to backlight_device_get_by_type() and update
callers to drop the reference when done?

>  int backlight_device_set_brightness(struct backlight_device *bd,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831210531.2334=
221-1-mario.limonciello@amd.com?part=3D1
