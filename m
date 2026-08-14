Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BF7C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 08:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7404910F41D;
	Fri, 14 Aug 2026 08:07:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hl0T3Nc4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A50B10F41D
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 08:07:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 616CE601DE;
 Fri, 14 Aug 2026 08:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A1D1F000E9;
 Fri, 14 Aug 2026 08:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786694867;
 bh=5HFNvyO3XSeklWel2cwO+qWjaKCCvjlB9q88jOGOTeQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hl0T3Nc4J9YvKgeHjmyCKevVciuXY/ZWAhmo92Mjltb/HGen/44XXuNacolsK7lCt
 cJpbiwWD0mGbkiTTL1KS6VSY9QZSuXukSryyXDC4zYcuoTfmv/v6ZRZzPkMbwMT5Bs
 OdtwfOvPPOTGvMn8ezGGOFsM2ToV0l7r3gjkzxnv1M0KYs4+Xd8ZTauEtCOlo5V2vV
 igKENW0scQCrNIVap2iWsFexMZjCoXhpC2xXIeEfoBNqaXkTHz4QcPNV/xKFOCRxgk
 wcHuQ+xFbzZ/Lw+/8EtOCzGhhYBlJ4Yt5MPazrHMANM3dDEe2vhLihlTDX1JrCSzfd
 /dBzuyq99PvEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/imagination: Propagate all errors from KCCB
 command submission code
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v2-1-35355fad50ae@imgtec.com>
References: <20260814-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v2-1-35355fad50ae@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 08:07:42 +0000
Message-Id: <20260814080746.E2A1D1F000E9@smtp.kernel.org>
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
- [Medium] pvr_kccb_send_cmd_powered() leaks KCCB slot reservations when th=
e underlying command submission fails.
--

--- Patch [1]: [PATCH v2] drm/imagination: Propagate all errors from KCCB c=
ommand submission code ---
commit 87e39c90e9f4c3d67e6107ed28de0875ca7379af
Author: Alessio Belle <alessio.belle@imgtec.com>

drm/imagination: Propagate all errors from KCCB command submission code

This commit updates pvr_kccb_send_cmd_reserved_powered() to return an int
instead of void, propagating errors like -EIO and -EINVAL up the call chain.

Link: https://patch.msgid.link/20260811-b4-upstream-propagate-all-errors-fr=
om-kccb-cmd-submission-code-v1-1-ffd55254d6d2@imgtec.com

> diff --git a/drivers/gpu/drm/imagination/pvr_ccb.c b/drivers/gpu/drm/imag=
ination/pvr_ccb.c
> index 4accf18e23418..8182babd8ad81 100644
> --- a/drivers/gpu/drm/imagination/pvr_ccb.c
> +++ b/drivers/gpu/drm/imagination/pvr_ccb.c
> @@ -268,19 +273,25 @@ pvr_kccb_send_cmd_reserved_powered(struct pvr_devic=
e *pvr_dev,
>  	struct rogue_fwif_ccb_ctl *ctrl =3D pvr_ccb->ctrl;
>  	u32 old_write_offset;
>  	u32 new_write_offset;
> +	int err;
> =20
> -	WARN_ON(pvr_dev->lost);
> +	if (pvr_dev->lost)
> +		return -EIO;
> =20
>  	mutex_lock(&pvr_ccb->lock);
> =20
> -	if (WARN_ON(!pvr_dev->kccb.reserved_count))
> +	if (WARN_ON(!pvr_dev->kccb.reserved_count)) {
> +		err =3D -EINVAL;
>  		goto out_unlock;
> +	}
> =20
>  	old_write_offset =3D READ_ONCE(ctrl->write_offset);
> =20
>  	/* We reserved the slot, we should have one available. */
> -	if (WARN_ON(!pvr_ccb_slot_available_locked(pvr_ccb, &new_write_offset)))
> +	if (WARN_ON(!pvr_ccb_slot_available_locked(pvr_ccb, &new_write_offset))=
) {
> +		err =3D -EINVAL;
>  		goto out_unlock;
> +	}
> =20
>  	memcpy(&kccb[old_write_offset], cmd,
>  	       sizeof(struct rogue_fwif_kccb_cmd));
[ ... ]
> @@ -378,8 +396,7 @@ pvr_kccb_send_cmd_powered(struct pvr_device *pvr_dev,=
 struct rogue_fwif_kccb_cmd
>  	if (err)
>  		return err;
> =20
> -	pvr_kccb_send_cmd_reserved_powered(pvr_dev, cmd, kccb_slot);
> -	return 0;
> +	return pvr_kccb_send_cmd_reserved_powered(pvr_dev, cmd, kccb_slot);
>  }

[Severity: Medium]
Does this code leak a KCCB slot reservation when the command submission fai=
ls?

Looking at pvr_kccb_send_cmd_powered(), it calls pvr_kccb_reserve_slot_sync=
()
which increments pvr_dev->kccb.reserved_count on success.

If the subsequent call to pvr_kccb_send_cmd_reserved_powered() fails (for e=
xample,
returning -EIO if pvr_dev->lost is true), it returns early without decremen=
ting
the reservation count.

Since pvr_kccb_send_cmd_powered() directly returns this error without calli=
ng
pvr_kccb_release_slot(), this permanently elevates the reserved count, whic=
h will
eventually trigger a WARN_ON in pvr_kccb_fini() during device teardown.

Should pvr_kccb_send_cmd_powered() check the return value and call
pvr_kccb_release_slot() on error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-b4-upstrea=
m-propagate-all-errors-from-kccb-cmd-submission-code-v2-1-35355fad50ae@imgt=
ec.com?part=3D1
