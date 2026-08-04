Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4C9C55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 10:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3F8610E9AF;
	Tue,  4 Aug 2026 10:21:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bVypkoEX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5450C10E9B3
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 10:21:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2FB3C60A83;
 Tue,  4 Aug 2026 10:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3DD1F000E9;
 Tue,  4 Aug 2026 10:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785838865;
 bh=VByj07q9OLyU3eqMtcABjq5yMEODLVx8l74bnYhlig8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bVypkoEX/oHJgdynburNi9fyRRrT8xapAcsIiiExIHRS4e3PJHIf0lxELBiIovGlS
 48LooAjfN3hYuyj0NSAwanb9dEMSpMJK21ToG4QMa828HFlV/cbMRKjDY5m4CaDw6p
 c5iOvtOVxWdk7Z3Oo6FFObpRiHYSMw4nXmzslyQNSpDyq1XgbD7MD57DTtP4Xi3SFg
 WoHzvPn4N8Mq3HEXyYRWqFLnClQ9c5iK2IBAqEyto1Tc1LuNJ1803GZwxAtonvab/e
 3hW3yBtNe1jyrQpXizB4DteMPOkvaInUIXryndZDqW12j0l0WSCI2rZHoNsCPhHSdG
 s9pJlkiOJnKzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/12] drm/panthor: Disable reset work before unplug
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260804-panthor-unplug-fixes-v1-1-abbbd2d41b13@collabora.com>
References: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
 <20260804-panthor-unplug-fixes-v1-1-abbbd2d41b13@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 10:21:04 +0000
Message-Id: <20260804102105.8C3DD1F000E9@smtp.kernel.org>
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
- [High] Deadlock (both self-deadlock and AB-BA) between `panthor_device_un=
plug()` and `panthor_device_reset_work()`.
--

--- Patch [1]: [PATCH 01/12] drm/panthor: Disable reset work before unplug =
---
commit 116cfe13ccbee774afdfc7f2e6251c1738450020
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/panthor: Disable reset work before unplug

This commit disables the reset work during the unplug process to prevent
interruptions.

> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/p=
anthor/panthor_device.c
> index 0b25abebb803c..e7f5744bc1e31 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -86,6 +86,9 @@ void panthor_device_unplug(struct panthor_device *ptdev)
>  	 */
>  	drm_dev_unplug(&ptdev->base);
> =20
> +	/* Make sure we're not interrupted by resets while we're unplugging. */
> +	disable_work_sync(&ptdev->reset.work);

[Severity: High]
Does this introduce a deadlock when the reset work fails?

Looking at panthor_device_reset_work(), if the reset fails, it calls
panthor_device_unplug(). This would result in panthor_device_unplug() calli=
ng
disable_work_sync() on the currently executing work item, causing a
self-deadlock:

panthor_device_reset_work() {
	...
	if (ret) {
		panthor_device_unplug(ptdev);
			...
			disable_work_sync(&ptdev->reset.work);

Additionally, since panthor_device_unplug() acquires ptdev->unplug.lock
before calling disable_work_sync(), does this create an AB-BA deadlock if
driver removal happens concurrently with a reset failure?

The driver removal thread would acquire ptdev->unplug.lock and wait in
disable_work_sync(), while the reset work would block trying to acquire
ptdev->unplug.lock inside its call to panthor_device_unplug().

>  	/* We do the rest of the unplug with the unplug lock released,
>  	 * future callers will wait on ptdev->unplug.done anyway.
>  	 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-panthor-un=
plug-fixes-v1-0-abbbd2d41b13@collabora.com?part=3D1
