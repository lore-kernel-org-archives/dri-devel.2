Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68500C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 11:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 995B010E5EC;
	Sun, 28 Jun 2026 11:48:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lowGEg3Q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32A1E10E5EC
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 11:48:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7DD336001D;
 Sun, 28 Jun 2026 11:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB481F000E9;
 Sun, 28 Jun 2026 11:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782647325;
 bh=D6S969FdKxRxzsXfeij/hOBRf8OLN/sJF/5cgzUHH3g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lowGEg3Q3yYdmiOH8fBYyNQK+tP5O54N7D/w+EyyPpCIwmFTbP8r7KTg51XZVucNu
 wNQLz055A1o7fvHY9uNtL8kUNOdQK9Nbmr2OP4F4SaMtiAVf7OdREJYyL73YpkguGI
 67BxqaeWTgN50T06t5yZYKPE1SXNwjSKLira4wRn4tC4P9ro+BYC2N4G4L8I1oy4NK
 hCFo19WyZ6NCd48f0tyOteGU3cWygqmB20f9E2ULAenbkgz2lJldxJceSGragBugWj
 1lO1QShys+vtSLBYFgSkIFqY5po0uLqDiM76XEsKA4famtaT02TjM2kfP3+zs0zBUf
 /m+U5Dxywe0aQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] accel/habanalabs: fix kref underflow in
 hl_cs_signal_sob_wraparound_handler
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260628113020.43942-1-vulab@iscas.ac.cn>
References: <20260628113020.43942-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 11:48:44 +0000
Message-Id: <20260628114845.0AB481F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Unconditionally incrementing the reference count of the new SOB du=
ring a wraparound causes a permanent reference leak when `encaps_sig` is fa=
lse, eventually causing a denial of service.

Pre-existing issues:
- [High] Pre-existing reference underflow on the old SOB during a wraparoun=
d in `init_signal_cs()`.
- [High] Pre-existing mismatch between the hardware signal generation and t=
he SOB address returned to userspace, leading to an indefinite userspace ha=
ng.
--

commit c04dffdbf27c2cf3b267257e4a97f77648c44492
Author: WenTao Liang <vulab@iscas.ac.cn>

accel/habanalabs: fix kref underflow in hl_cs_signal_sob_wraparound_handler

When other_sob->need_reset is true and encaps_sig is false,
hw_sob_put(other_sob) decrements the kref to 0, but the matching
hw_sob_get(other_sob) is skipped because it is inside the encaps_sig
block. The function returns other_sob with kref=3D0, causing a subsequent
kref_put to underflow. Fix by adding hw_sob_get(other_sob) in the else
branch.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Fixes: dadf17abb724 ("habanalabs: add support for encapsulated signals rese=
rvation")
Cc: stable@vger.kernel.org
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

> diff --git a/drivers/accel/habanalabs/common/command_submission.c b/drive=
rs/accel/habanalabs/common/command_submission.c
> index d51b4cf332b2a..ffcdf29b7e070 100644
> --- a/drivers/accel/habanalabs/common/command_submission.c
> +++ b/drivers/accel/habanalabs/common/command_submission.c

[ ... ]

> @@ -1869,11 +1869,10 @@ int hl_cs_signal_sob_wraparound_handler(struct hl=
_device *hdev, u32 q_idx,
>  		if (other_sob->need_reset)
>  			hw_sob_put(other_sob);
> =20
> -		if (encaps_sig) {
> +		if (encaps_sig)
>  			/* set reset indication for the sob */
>  			sob->need_reset =3D true;
> -			hw_sob_get(other_sob);
> -		}
> +		hw_sob_get(other_sob);

[Severity: High]
Does this unconditional get leak the reference count when encaps_sig is fal=
se?

If encaps_sig is false, init_signal_cs() retains the old SOB in
cs_cmpl->hw_sob and ignores the new SOB returned by this wraparound handler.

Since no object takes ownership of this newly acquired reference, does it
permanently leak the other_sob reference?

Could this inflated refcount cause the kref_read(&other_sob->kref) !=3D 1
check to fail during future wraparounds, leading to a denial of service?

[ ... ]

[Severity: High]
This is a pre-existing issue, but can init_signal_cs() cause a reference
underflow on the old SOB during a wraparound?

In drivers/accel/habanalabs/common/hw_queue.c:init_signal_cs(), the
completion object retains a pointer to the old SOB before calling the
wraparound handler:

    cs_cmpl->hw_sob =3D hw_sob;
    ...
    rc =3D hl_cs_signal_sob_wraparound_handler(hdev, q_idx, &hw_sob, 1,
                                             false);

If a wraparound occurs, the handler calls hw_sob_put_err(sob) on the old
SOB. Later, when the job completes, cs_do_release() calls
cs_release_sob_reset_handler() which unconditionally calls
hw_sob_put(hl_cs_cmpl->hw_sob).

Since the completion object still points to the old SOB, does this decrement
the old SOB's refcount without a corresponding increment, leading to premat=
ure
release?

[Severity: High]
This is a pre-existing issue, but is there a mismatch between the
hardware signal generation and the SOB address returned to userspace?

In drivers/accel/habanalabs/common/hw_queue.c:init_signal_cs(), the hardware
command is generated using the old SOB's ID:

    hdev->asic_funcs->gen_signal_cb(hdev, job->patched_cb,
                                    cs_cmpl->hw_sob->sob_id, 0, true);

Immediately after, the wraparound handler executes and updates the local hw=
_sob
pointer to the new SOB:

    rc =3D hl_cs_signal_sob_wraparound_handler(hdev, q_idx, &hw_sob, 1,
                                             false);

The function then assigns the new SOB's address to the job:

    job->cs->sob_addr_offset =3D hw_sob->sob_addr;

If userspace waits on this exported offset, it waits on the new SOB, but
the hardware was programmed to signal the old SOB. Can this cause an
indefinite userspace hang?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628113020.4394=
2-1-vulab@iscas.ac.cn?part=3D1
