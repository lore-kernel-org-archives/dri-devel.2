Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C88BC624D6
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:48:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC5F210E120;
	Thu,  3 Sep 2026 14:48:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SSDiITRn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0D1C10E120
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 14:48:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8E3E36053C;
 Thu,  3 Sep 2026 14:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236AB1F00A3A;
 Thu,  3 Sep 2026 14:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788446907;
 bh=y2W37P03ffrB97JHXYS4j1PsCwPsw7kaw4r59oA0FVQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SSDiITRnlYJa0TZXZtPHRWX0duj0+ertBW/MFlgl9IO4ACJ5w2PrjXvrmrMVlLWxc
 5JAqecrTP9+NC3S4v9tOB6to865j1AprrK1Prjd+UrJu2q3jcRsgOk4aMa8Tq4UY5G
 xKAayK7sFPErRYgm6tCCAqy6RbYHVwycYCZhpPQK5Iwhikn7RqewbtqRpDFpzVK+45
 AOl+D5gUX48EBuCZsMz53TJ+p4yP7JnF0c+YZplBUftH0lXkS1dbRlZ5A98wP9dYdg
 7O4Kz0YkLDlbtzVB8VHniW0Zq+OM5fCUqx2o5LZc1HXJtB7+1yPqgnligJZCXuZkXk
 SGyWhxXpRFaJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/dpu: delete timeout timer when encoder is not busy
To: "Jun Nie" <jun.nie@linaro.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260903143004.1026181-1-jun.nie@linaro.org>
References: <20260903143004.1026181-1-jun.nie@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 14:48:26 +0000
Message-Id: <20260903144827.236AB1F00A3A@smtp.kernel.org>
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
- [High] A Time-of-Check to Time-of-Use (TOCTOU) race condition in the lock=
less timer deletion allows an IRQ handler to inadvertently delete the watch=
dog timer for a newly started frame on another CPU.
- [Medium] The patch fails to address the root cause of the race condition =
and relies on a subsequent, unrelated IRQ to mask the bug, leaving the orig=
inal false timeout issue unfixed in many scenarios.

Pre-existing issues:
- [High] Missing synchronization in `dpu_encoder_virt_atomic_disable` allow=
s the driver to disable hardware resources while the timer callback is stil=
l executing, leading to crashes.
--

commit 91dd8b2e3a127693bc37ea9250d6d6a4bd503cf0
Author: Jun Nie <jun.nie@linaro.org>

drm/msm/dpu: delete timeout timer when encoder is not busy

This commit attempts to fix a spurious timeout error message during encoder
disable. It adds a check in the frame done IRQ callback to delete the
watchdog timer if the frame busy bits are cleared.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/dr=
m/msm/disp/dpu1/dpu_encoder.c
> index 1f20695f81e35..d83d387973311 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -1573,6 +1573,21 @@ void dpu_encoder_frame_done_callback(
>  			| DPU_ENCODER_FRAME_EVENT_PANEL_DEAD)) {
> =20
>  		if (!dpu_enc->frame_busy_mask[0]) {
> +			/*
> +			 * dpu_crtc_commit_kickoff calls dpu_encoder_kickoff to
> +			 * mark busy bits, starts the framedone timer next.
> +			 * It is possibile that irq happens between the 2
> +			 * operations. Thus timer is running with busy bits
> +			 * cleared by irq handler and timer will not be deleted
> +			 * anymore. Then false timeout introduces unnecessary
> +			 * confusion and visual defect.
> +			 * delete the timer here to fix it.
> +			 */
> +			if (atomic_read(&dpu_enc->frame_done_timeout_ms)) {
> +				atomic_set(&dpu_enc->frame_done_timeout_ms, 0);
> +				timer_delete(&dpu_enc->frame_done_timer);
> +			}

[Severity: Medium]
Does this patch rely on a subsequent IRQ to fix the false timeout in all
scenarios?

If no subsequent IRQ (like autorefresh or a TE interrupt) fires after the
timer is armed with an empty frame_busy_mask, the timer will expire normall=
y.
When it expires, dpu_encoder_frame_done_timeout() returns early because
frame_busy_mask is empty, but it fails to clear frame_done_timeout_ms:

dpu_encoder_frame_done_timeout() {
    ...
    if (!dpu_enc->frame_busy_mask[0] || !dpu_enc->crtc) {
        return;
    }
    ...
}

Later, dpu_encoder_virt_atomic_disable() checks frame_done_timeout_ms,
finds it non-zero, and still falsely prints the 'timeout pending' error.
Will this leave the bug unfixed for standard operations that do not trigger
extra IRQs?

[Severity: High]
Could this lockless timer deletion introduce a race condition with a new
commit?

CPU1 handling a spurious IRQ in dpu_encoder_frame_done_callback()
evaluates if (!dpu_enc->frame_busy_mask[0]) as true locklessly.

Concurrently, CPU2 starts a new commit:
dpu_encoder_kickoff() sets frame_busy_mask to 1.
dpu_encoder_start_frame_done_timer() arms the timer and sets
frame_done_timeout_ms to 500.

CPU1 continues execution, reads frame_done_timeout_ms (now 500 from CPU2),
sets it to 0, and calls timer_delete().

Does this silently delete the newly armed watchdog timer for CPU2's commit,
leaving it without watchdog protection if the hardware hangs?

[Severity: High]
This is a pre-existing issue, but does dpu_encoder_virt_atomic_disable()
lack synchronization when disabling hardware resources?

dpu_encoder_frame_done_timeout() clears frame_done_timeout_ms via
atomic_xchg() early in its execution:

dpu_encoder_frame_done_timeout() {
    ...
    } else if (!atomic_xchg(&dpu_enc->frame_done_timeout_ms, 0)) {
        return;
    }
    ...
}

If dpu_encoder_virt_atomic_disable() runs concurrently, it checks:

    if (atomic_xchg(&dpu_enc->frame_done_timeout_ms, 0)) {
        timer_delete_sync(&dpu_enc->frame_done_timer);
    }

If the timeout callback has already cleared the variable, the disable path
sees 0, skips timer_delete_sync(), and proceeds to disable clocks and power
domains. Meanwhile, the timeout callback is still executing and accesses
hardware registers, which can cause a synchronous external abort when clocks
are disabled. Should this path always synchronize with the timer callback?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903143004.1026=
181-1-jun.nie@linaro.org?part=3D1
