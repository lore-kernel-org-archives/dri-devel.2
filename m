Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D521ACD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 11:03:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 054D010E0A9;
	Fri, 26 Jun 2026 11:03:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SOWxQ5Nn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76B3110E0A9
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 11:03:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A846760098;
 Fri, 26 Jun 2026 11:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4EB1F000E9;
 Fri, 26 Jun 2026 11:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782471799;
 bh=suHsoPZp/Bwr6seo6oww87FIY2kWZVBrs/L1pphy860=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SOWxQ5NnmTH366hNYt0nfo4zW2hFV6zLA8kYZ+uL1lkuJiaYH0E7Bw7GisSQF4l6o
 ZuOUqkBJmz5EgAAPsFULeHzGJ03nYEvYt8VoqXMyk/AVJrtQ5Yd/4FbxkhmL7s0s53
 5Hg4HRCSzB9zPl9UiLsAAyad4zFjKTXRNNE9UIsi58vGap7xpLzzTQ1lZzTRvOHMPw
 gqBDt0a4j7Og3EoD5+h+iIOtlR1NRwXfw/OW0pzwvqclrHkE/OtxAk/VfG1JNIGyKj
 NpkukWvv47yw/Cmi3CN8ucy9Guk7nlMPmU9y1TAQRW/DjTkGfPzmMuz4J5OhHYy83V
 2MT+Bg/q+6mQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fix: accel/habanalabs:
 hl_cs_signal_sob_wraparound_handler: missing   hw_sob_get when need_reset
 is true and encaps_sig is false
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626104453.32301-1-vulab@iscas.ac.cn>
References: <20260626104453.32301-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 11:03:17 +0000
Message-Id: <20260626110318.9A4EB1F000E9@smtp.kernel.org>
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
- [High] Unconditional hw_sob_get() causes permanent reference leak and bre=
aks hardware SOB reset

Pre-existing issues:
- [High] SOB reference leak on hl_hw_queue_schedule_cs error path
--

commit 3b275b62c13a1feac292163762a58fb995072f8e
Author: WenTao Liang <vulab@iscas.ac.cn>

fix: accel/habanalabs: hl_cs_signal_sob_wraparound_handler: missing hw_sob_=
get when need_reset is true and encaps_sig is false

When other_sob->need_reset is true and encaps_sig is false,
  hw_sob_put(other_sob) decrements the kref to 0, but the matching
  hw_sob_get(other_sob) is skipped because it is inside the encaps_sig
  block. The function returns other_sob with kref=3D0, causing a subsequent
  kref_put to underflow. Fix by adding hw_sob_get(other_sob) in the else
  branch.

Cc: stable@vger.kernel.org
Fixes: dadf17abb724 ("habanalabs: add support for encapsulated signals rese=
rvation")

> diff --git a/drivers/accel/habanalabs/common/command_submission.c b/drive=
rs/accel/habanalabs/common/command_submission.c
> index d51b4cf332b2a..ffcdf29b7e070 100644
> --- a/drivers/accel/habanalabs/common/command_submission.c
> +++ b/drivers/accel/habanalabs/common/command_submission.c
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
Does this unconditional increment cause a permanent reference leak when
encaps_sig is false and need_reset is false?

For regular signals (encaps_sig =3D=3D false), cs_cmpl->hw_sob is not updat=
ed to
point to the new SOB in drivers/accel/habanalabs/common/hw_queue.c:init_sig=
nal_cs():

    cs_cmpl->hw_sob =3D hw_sob;
    ...
    rc =3D hl_cs_signal_sob_wraparound_handler(hdev, q_idx, &hw_sob, 1, fal=
se);

Because cs_cmpl->hw_sob retains the old SOB, this new reference acquired he=
re
in the wraparound handler is never tracked for release. This will prevent t=
he
hardware SOB refcount from ever reaching 0, breaking the sync stream mechan=
ism.

[Severity: High]
This is a pre-existing issue, but does the hl_hw_queue_schedule_cs() error
path leak the SOB reference if a check fails after acquiring it?

In drivers/accel/habanalabs/common/hw_queue.c:hl_hw_queue_schedule_cs(), if
hl_staged_cs_find_first() fails, it aborts after init_signal_wait_cs() has
already acquired a reference to the SOB:

    staged_cs =3D hl_staged_cs_find_first(hdev, cs->staged_sequence);
    if (!staged_cs) {
        ...
        rc =3D -EINVAL;
        goto unlock_cs_mirror;
    }

During the rollback, cs_release_sob_reset_handler() in
drivers/accel/habanalabs/common/command_submission.c skips releasing the
reference because cs->submitted is false:

    if (!hl_cs_cmpl->hw_sob || !cs->submitted)
        return;
    ...
    hw_sob_put(hl_cs_cmpl->hw_sob);

Could this be triggered by submitting an IOCTL with an invalid staged
submission sequence to cause a denial of service?

> =20
>  		dev_dbg(hdev->dev, "switched to SOB %d, q_idx: %d\n",
>  				prop->curr_sob_offset, q_idx);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626104453.3230=
1-1-vulab@iscas.ac.cn?part=3D1
