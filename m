Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5FCC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8EE310E651;
	Thu, 27 Aug 2026 10:36:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UxzWd5Uj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E6310E63D;
 Thu, 27 Aug 2026 10:36:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 69106415FA;
 Thu, 27 Aug 2026 10:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219C31F00A3F;
 Thu, 27 Aug 2026 10:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787827008;
 bh=YST2AKdGZj9iStX5CtCRcZSXVXjBYc/9MZV7a3ZHh1A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UxzWd5UjXvdXmVEqC6iao7Ng8GAM5FczI8z9jyS+EDic4jPvAyxJNuRvBGtgqfbm7
 frIkVnCYJNXtcyQebF0uFXQBLiwL/daofWTZVT5cvfpQeDp5zL4+tUdFmZvftM/7/E
 5Ovt9+lu/N6aoz+onyR+jNaNN1oMW5JnJiap6VsYFzC42/HBd0nsjgaAYcB96SVCkM
 BUFG1+NxAmp8hwqHOIRY0g/vsaVjYJcItSTp15G/ohxuTSvifXhOkvPixgJb9cS9zL
 jf9Ts5F2CBSDV7MIuinbsLI6Rx140oS3hz2ZMfkj7o4zWNh6vRdWk7dE3Hp8T3pHiA
 vuI5+M8n7rDsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/13] drm/xe: Separate AER reset state from device wedging
To: "Arvind Yadav" <arvind.yadav@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260827101801.1247654-3-arvind.yadav@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-3-arvind.yadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 10:36:47 +0000
Message-Id: <20260827103648.219C31F00A3F@smtp.kernel.org>
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
- [Medium] guc_ct_send_recv() still checks xe_device_wedged() instead of xe=
_device_io_blocked() when returning cancellation errors, causing state inco=
nsistency.

Pre-existing issues:
- [High] Directly calling probe during AER slot reset bypasses driver core =
error handling, leading to double-remove and crashes if it fails.
--

commit 1cbbd9c3fc1b9bad858f6195cfff20e523edc2ca
Author: Arvind Yadav <arvind.yadav@intel.com>

drm/xe: Separate AER reset state from device wedging

This commit modifies the PCI error recovery path (AER) to use a temporary
in_reset state instead of the permanent wedged flag to block driver I/O.
It introduces the xe_device_io_blocked() helper to check both conditions,
replacing xe_device_wedged() in multiple places where temporary blocks
should also apply.

> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_c=
t.c
> index 5c4733da385c5..3c3fe4928fa20 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ct.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
> @@ -1062,7 +1062,7 @@ static int __guc_ct_send_locked(struct xe_guc_ct *c=
t, const u32 *action,
>  	xe_gt_assert(gt, g2h_len || !num_g2h);
>  	lockdep_assert_held(&ct->lock);
> =20
> -	if (xe_device_wedged(ct_to_xe(ct))) {
> +	if (xe_device_io_blocked(ct_to_xe(ct))) {
>  		ret =3D -ENOTRECOVERABLE;
>  		goto out;
>  	}

[ ... ]

[Severity: Medium]
In guc_ct_send_recv(), the code still checks the old xe_device_wedged() sta=
te
when returning cancellation errors:

	if (g2h_fence.fail) {
		if (g2h_fence.cancel) {
			xe_gt_dbg(gt, "H2G request %#x canceled!\n", action[0]);
			ret =3D xe_device_wedged(ct_to_xe(ct)) ? -ENOTRECOVERABLE : -ECANCELED;
			goto unlock;
		}

Does this leave a state inconsistency during a PCI AER reset? If an in-flig=
ht
H2G request is cancelled because of a temporary IO block, xe_device_wedged()
will evaluate to false. This means the caller receives -ECANCELED instead of
-ENOTRECOVERABLE. Should this check be updated to use xe_device_io_blocked()
as well?

[ ... ]

> diff --git a/drivers/gpu/drm/xe/xe_pci_error.c b/drivers/gpu/drm/xe/xe_pc=
i_error.c
> index 79ce0c671549a..d82256d8721f3 100644
> --- a/drivers/gpu/drm/xe/xe_pci_error.c
> +++ b/drivers/gpu/drm/xe/xe_pci_error.c
[ ... ]
> @@ -116,7 +116,6 @@ static pci_ers_result_t xe_pci_error_slot_reset(struc=
t pci_dev *pdev)
>  	 * TODO: optimize by re-initializing only the hardware state and re-cre=
ating
>  	 * kernel BOs.
>  	 */
> -	xe_device_clear_in_reset(xe);
>  	pdev->driver->remove(pdev);
>  	devres_release_group(&pdev->dev, xe->devres_group);
> =20

[Severity: High]
This is a pre-existing issue, but does manually calling probe here bypass
driver core error handling?

If pdev->driver->probe(pdev, ent) fails during xe_pci_error_slot_reset(), it
returns PCI_ERS_RESULT_DISCONNECT. The PCI AER core will then unbind the
driver and call pdev->driver->remove(pdev).=20

Since the failing probe likely already called xe_device_remove(xe) on its
error path, wouldn't this lead to a double remove and potential crashes?

> @@ -125,8 +124,8 @@ static pci_ers_result_t xe_pci_error_slot_reset(struc=
t pci_dev *pdev)
> =20
>  	xe =3D pdev_to_xe_device(pdev);
> =20
> -	/* Wedge the device to prevent I/O operations till the resume callback =
*/
> -	atomic_set(&xe->wedged.flag, 1);
> +	/* Block the new instance until the resume callback. */
> +	xe_device_set_in_reset(xe);
> =20
>  	return PCI_ERS_RESULT_RECOVERED;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827101801.1247=
654-1-arvind.yadav@intel.com?part=3D2
