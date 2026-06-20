Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CD2CD98E4
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 16:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C72EA10E22D;
	Sat, 20 Jun 2026 16:09:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g2sGJY/H";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71C3010E22D
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 16:09:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4FBB0601E1;
 Sat, 20 Jun 2026 16:08:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAF81F000E9;
 Sat, 20 Jun 2026 16:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781971738;
 bh=/yFAf+8vhME8D8a7xAdMKKuxGBktexQepsvJBGmIdsU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g2sGJY/HORyfsWvjJpqcD/FtCo8SF2DDTdmle1s1MZeayiKlVAm2MeU8qzNDIaU28
 Fv0H8dsdc+tor1e0a5/IC+lEBZKqn7YwoAJ13Jv0vVgVXjOw1UqzhetfL1qPVgLMKM
 Tmr9dMXCURFrJtdqKAGt8jV2n2G57QYNuq4TzWAaiZ21nj/FceFcnWeqICdVrgiqYi
 EExt9NOpe74EL139ELGfJwBU4ptlXlSMyCWRb66J7M0hKd1S+ufUn8jYgAC+V8LNGd
 zBECTP9PH8sk5no/KmUTgs/3VLasxh1gkNJqQKZ0FHYnsZdv/Cf0SbEnMQRSB5rwOU
 3iPqE7cWM0Vkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/habanalabs: publish signal handle after SOB setup
To: "Ruoyu Wang" <ruoyuw560@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260620155313.79464-1-ruoyuw560@gmail.com>
References: <20260620155313.79464-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 16:08:56 +0000
Message-Id: <20260620160857.5AAF81F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] cs_ioctl_unreserve_signals directly frees the reference-counte=
d encapsulated signal handle using kfree(), leading to a reliable Use-After=
-Free.
- [High] cs_ioctl_reserve_signals dereferences the signal handle after maki=
ng it globally visible in the IDR, opening a Use-After-Free race condition.
--

commit e876f03fdbac8aca21d399cce254b40bfee1df02
Author: Ruoyu Wang <ruoyuw560@gmail.com>

accel/habanalabs: publish signal handle after SOB setup

cs_ioctl_reserve_signals() makes the encapsulated signal handle visible
in the context IDR before the SOB pointer and pre-reserve SOB value are
set. Concurrent unreserve and wait paths dereference those fields after
IDR lookup.

> diff --git a/drivers/accel/habanalabs/common/command_submission.c b/drive=
rs/accel/habanalabs/common/command_submission.c
> index d51b4cf332b2a..0ed0950fee652 100644
> --- a/drivers/accel/habanalabs/common/command_submission.c
> +++ b/drivers/accel/habanalabs/common/command_submission.c
[ ... ]
> @@ -2102,11 +2104,18 @@ static int cs_ioctl_reserve_signals(struct hl_fpr=
iv *hpriv,
>  	 */
>  	handle->pre_sob_val =3D prop->next_sob_val - handle->count;
> =20
> -	handle->cs_seq =3D ULLONG_MAX;
> -
>  	*signals_count =3D prop->next_sob_val;
>  	hdev->asic_funcs->hw_queues_unlock(hdev);
> =20
> +	spin_lock(&mgr->lock);
> +	old =3D idr_replace(&mgr->handles, handle, hdl_id);
> +	spin_unlock(&mgr->lock);
> +
> +	if (WARN_ON(IS_ERR(old))) {
> +		rc =3D PTR_ERR(old);
> +		goto remove_idr;
> +	}
> +
>  	*sob_addr =3D handle->hw_sob->sob_addr;

[Severity: High]
This is a pre-existing issue, but does dereferencing the handle here=20
expose us to a use-after-free?

Once idr_replace() publishes the handle to mgr->handles and the lock is=20
dropped, a concurrent thread could guess the IDR allocation ID and call=20
cs_ioctl_unreserve_signals(). This would free the handle memory before=20
this thread dereferences it to read sob_addr.

Since hw_sob is available as a local variable, could we assign this using=20
the local hw_sob pointer instead of accessing the handle post-publication?

>  	*handle_id =3D hdl_id;
> =20

While reviewing the reservation changes, I also noticed a related=20
pre-existing issue in the unreserve path:

drivers/accel/habanalabs/common/command_submission.c:cs_ioctl_unreserve_sig=
nals() {
    ...
    kfree(encaps_sig_hdl);
    ...
}

[Severity: Critical]
This isn't a bug introduced by this patch, but does=20
cs_ioctl_unreserve_signals() skip dropping the reference count when freeing=
=20
the encapsulated signal handle?

The handle is initialized with kref_init(), and concurrent wait command=20
submissions can acquire a reference to it via kref_get_unless_zero().=20
Because wait submissions do not modify next_sob_val or sob_addr, the=20
validation checks in cs_ioctl_unreserve_signals() can succeed while a wait=
=20
submission is active.

Since the unreserve path calls kfree() directly instead of using=20
kref_put(), could this lead to a use-after-free when the wait submission=20
eventually completes and tries to drop its reference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620155313.7946=
4-1-ruoyuw560@gmail.com?part=3D1
