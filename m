Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91339C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 06:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC66610F2C8;
	Fri, 24 Jul 2026 06:45:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aTNVODDM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3210B10F2C8
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 06:45:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6540E600AA;
 Fri, 24 Jul 2026 06:45:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79F01F000E9;
 Fri, 24 Jul 2026 06:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784875528;
 bh=bKSY651wVk+H+z5IxSVPaO9X8qODNhklnr/qhtf8VdI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aTNVODDMtdtmEZX7ROH6qK2QdUkTpaKWQ9MsIjqz5InNc5nXex4lvZ+u4zax6tmyd
 rf2E4ft2MFTPvvahyv1+98sCWbyfYmF8Y2Gk4SWj3ErxRuc6wFlQr9pEuGUfz0L2b4
 wg0dYakRLTiAvOjRT4yQyvw0Llf2lxQNemwRKhGv4IuXmWqMTVYBX/dWPGF6ekgOjv
 hjljzk+1tHpyDlDU9qMwxKogbdlzGN8SqVdW9xUVxX5CRjCmvTQUYbq8YWIKthNMOQ
 BP6fz3UgjMojKd0t/27WHd9Hqlkhyj4Xh2qcI58l+9cLQ2y1hCIiTKVY4udsrE9ejM
 BLQmw+kszjrPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/drv: Add buffer bounds check in
 drm_dev_wedged_event()
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724063005.703631-2-mallesh.koujalagi@intel.com>
References: <20260724063005.703631-2-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 06:45:27 +0000
Message-Id: <20260724064527.E79F01F000E9@smtp.kernel.org>
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

New issues:
- [High] Improper Use of WARN_ON for Valid Input Due to Insufficient Buffer=
 Size

Pre-existing issues:
- [High] NULL Pointer Dereference on Compute Accelerator Devices
--

--- Patch [1]: [PATCH v2] drm/drv: Add buffer bounds check in drm_dev_wedge=
d_event() ---
commit 97688eec142901f13da2ba3b0c76b902728202be
Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: drm/drv: Add buffer bounds check in drm_dev_wedged_event()

This commit adds a bounds check in drm_dev_wedged_event() to prevent
scnprintf() from silently truncating the recovery token. It adds a
drm_WARN_ON() guard to catch cases where the buffer size WEDGE_STR_LEN
is exceeded.

> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 1ff0bf7cba6aa..09175d0e4a5a2 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -578,6 +578,20 @@ int drm_dev_wedged_event(struct drm_device *dev, uns=
igned long method,
>  		if (drm_WARN_ONCE(dev, !recovery, "invalid recovery method %u\n", opt))
>  			break;
> =20
> +		/*
> +		 * scnprintf(buf, size, "%s,", recovery) writes strlen(recovery)+1
> +		 * content bytes (token + comma) and reserves 1 byte for NUL within
> +		 * 'size'.  It fits without truncation when:
> +		 *   len + strlen(recovery) + 1 <=3D WEDGE_STR_LEN - 1  (safe)
> +		 * so warn and bail when:
> +		 *   len + strlen(recovery) + 1 >=3D WEDGE_STR_LEN       (would trunca=
te)
> +		 * Note: ">=3D WEDGE_STR_LEN - 1" would be off-by-one =E2=80=94 it wou=
ld
> +		 * incorrectly reject the exact-fit case where NUL lands on the last
> +		 * valid byte (index WEDGE_STR_LEN - 1).
> +		 */
> +		if (drm_WARN_ON(dev, len + strlen(recovery) + 1 >=3D WEDGE_STR_LEN))
                ^^^^

[Severity: High]
Does this WARN_ON() trigger on perfectly valid API usage?

In drivers/gpu/drm/drm_drv.c:drm_dev_wedged_event(), the exported API suppo=
rts
multiple recovery methods in a bitmask. For example, if a driver passes=20
DRM_WEDGE_RECOVERY_BUS_RESET | DRM_WEDGE_RECOVERY_VENDOR, the combined stri=
ng=20
length will reach 33 bytes (7 for WEDGED=3D + 9 for bus-reset + 1 for comma=
 +
15 for vendor-specific + 1 for comma).=20

Since WEDGE_STR_LEN is hardcoded to 32 bytes, the condition 33 >=3D 32 will=
=20
evaluate to true and trigger the newly added drm_WARN_ON(). On systems with=
=20
panic_on_warn enabled, this will cause a kernel panic, effectively penalizi=
ng
the driver for using a valid API bitmask because of an artificially small
internal buffer size.

> +			break;
> +
>  		len +=3D scnprintf(event_string + len, sizeof(event_string) - len, "%s=
,", recovery);
>  	}

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under revi=
ew,=20
but does the end of drm_dev_wedged_event() unconditionally dereference=20
dev->primary?

drivers/gpu/drm/drm_drv.c:drm_dev_wedged_event() {
...
	if (info && (info->comm[0] !=3D '\0') && (info->pid >=3D 0)) {
		snprintf(pid_string, sizeof(pid_string), "PID=3D%u", info->pid);
		snprintf(comm_string, sizeof(comm_string), "TASK=3D%s", info->comm);
		envp[1] =3D pid_string;
		envp[2] =3D comm_string;
	}

	return kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
                                   ^^^^
}

Compute accelerator drivers (configured with DRIVER_COMPUTE_ACCEL) only
allocate an accel minor (DRM_MINOR_ACCEL) during initialization and
intentionally leave dev->primary as NULL.

If a compute accelerator driver calls drm_dev_wedged_event() to report a=20
hardware wedge state, this will result in a NULL pointer dereference and a
kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724063005.7036=
31-2-mallesh.koujalagi@intel.com?part=3D1
