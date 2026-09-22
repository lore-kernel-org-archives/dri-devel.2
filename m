Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB22C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:27:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D05010E6AE;
	Tue, 22 Sep 2026 10:27:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kVVGX+OY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFFD310E6AE;
 Tue, 22 Sep 2026 10:27:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D812460200;
 Tue, 22 Sep 2026 10:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5870D1F000FF;
 Tue, 22 Sep 2026 10:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790072841;
 bh=dKrHXYtcSPic1yyH/8gIcbUHVwe6uz4bOTP3sL2MwCE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kVVGX+OYwC3LzCX2oc/Zd/NdUyMNI/+L07aLaZV4y/xo8tStD4O51wb9DUKFOboo/
 CKibq6d0XanGRIPNlNwCrA2uwNbo9s0VzkK87AgQhjM6H2ynEMzlc4pSGfIxK4xnqt
 df4ZWA9EGBg2E40ZlByPyTGq1Ay4vT5kE5Sdp5e9ZpKOQE9ezqbPM9TE69BC7R4bDS
 4Hj3j7zhBFfzrluG8zUgOo4gBzmPr5xKIXRcno+iUsin6I3xL6n05AvH4r26t5kbvc
 KRUWIIaIew6gZT8lKxWwhGeCCk9l1jXZyvtOHTVMmi5QTbf0DT99CVO/Ww/xDUMrmD
 5GYDCtSK+LMsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/15] drm/xe: Send wedged notification from a worker
To: "Arvind Yadav" <arvind.yadav@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260922101721.1583542-8-arvind.yadav@intel.com>
References: <20260922101721.1583542-1-arvind.yadav@intel.com>
 <20260922101721.1583542-8-arvind.yadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 10:27:20 +0000
Message-Id: <20260922102721.5870D1F000FF@smtp.kernel.org>
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
- [Medium] xe: TOCTOU race in xe_device_declare_wedged() overwrites recover=
y method
--

commit 8a75aea67f604c5a996849e643c64617844ddad3
Author: Arvind Yadav <arvind.yadav@intel.com>
Subject: drm/xe: Send wedged notification from a worker

This commit moves the wedged event to a sleepable device worker to allow
isolation work to complete before userspace is notified. It updates the
wedge bookkeeping to rescan the GT state on later declarations and tracks
the last reported method to avoid lost updates.

> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_devic=
e.c
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c

[ ... ]

> @@ -1435,14 +1482,22 @@ void xe_device_declare_wedged(struct xe_device *x=
e)
>  		 */
>  		if (xe->wedged.mode =3D=3D XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET)
>  			xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_NONE);
>  	}
> +
> +	/* Re-scan GT submission state on every declaration. */
> +	for_each_gt(gt, xe, id)
> +		xe_gt_declare_wedged(gt);
> +
> +	/* If no wedge recovery method is set, use default */
> +	if (!READ_ONCE(xe->wedged.method))
> +		xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_REBIND |
> +					    DRM_WEDGE_RECOVERY_BUS_RESET);

[Severity: Medium]
Is there a Time-of-Check to Time-of-Use (TOCTOU) race condition here in
xe_device_declare_wedged()?

If multiple threads invoke xe_device_declare_wedged() concurrently (for
example, during simultaneous GT hangs), could Thread A evaluate the
!READ_ONCE(xe->wedged.method) condition as true, get preempted, and then
allow Thread B to successfully set a specific method like
DRM_WEDGE_RECOVERY_NONE?

If Thread A then resumes, it seems it would unconditionally call
xe_device_set_wedged_method() with the default REBIND | BUS_RESET flags,
silently overwriting Thread B's legitimately set method.

Does this check-and-set sequence need atomic protection, such as cmpxchg,
to prevent concurrent threads from overwriting a newly set recovery method
with the default fallback?

> +
> +	if (!atomic_read(&xe->wedged.stopping) &&
> +	    (first ||
> +	     READ_ONCE(xe->wedged.method) !=3D
> +	     READ_ONCE(xe->wedged.reported_method)))
> +		queue_work(xe->unordered_wq, &xe->wedged.work);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922101721.1583=
542-1-arvind.yadav@intel.com?part=3D7
