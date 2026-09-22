Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5800C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04AA310EE7C;
	Tue, 22 Sep 2026 21:06:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ipOOjzCT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0583C10EE7C
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 21:06:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CA01A41A7D;
 Tue, 22 Sep 2026 21:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B2E1F000FF;
 Tue, 22 Sep 2026 21:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790111173;
 bh=s5vUryX76rDxFcLHD+7LP5R90xko53/NgSJwpJams+E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ipOOjzCTcVdUyMmYondzPSIfN9vPRf8mbhgZbzE/7DLrQ8xFHzo4g+bfjAe90sQUW
 08mzWDn3NWy6y1ZeXawHtTLVGmmU/2DcJBMhQ2dS9Fr+ThvyoPXIoV6Cv8EeDarYQK
 Dzzu+RTBZZ6VNeVzccXdsTXbrMAi3h/C4Gb5/j4+BxWnpoD9PUM+R7D83d2PX3sboE
 CZq+HVpCr6s3thJCs3PG4bfHv7HLkR5lMKRv0BabQ8mKAqDjhYz8tM1/ucql/qJT3C
 2RWJloVb6oUxt9sAici4Y0HKezB/ojY8pvvsvRsK6xE+Jyj/X7pZIcFsFO37iyzzAN
 b3yILgrKgbf6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 27/27] drm/panthor: Release GPU access immediately
 for out-of-band grants
To: "Karunika Choo" <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260922204535.2850094-28-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-28-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 21:06:13 +0000
Message-Id: <20260922210613.81B2E1F000FF@smtp.kernel.org>
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
- [High] drm/panthor: AW state machine wedges in STOPPED_IDLE on ENOSPC
--

commit fc59dcd4da161e6f76c5425461851d01153db172
Author: Karunika Choo <karunika.choo@arm.com>

    drm/panthor: Release GPU access immediately for out-of-band grants

This commit modifies the window-opened IRQ handler to immediately release
the GPU access when a late grant arrives for a request that has already
timed out and returned to the READY state.

> diff --git a/drivers/gpu/drm/panthor/panthor_aw.c b/drivers/gpu/drm/panth=
or/panthor_aw.c
> index 7ef13db4acf50..27787c0b2f3a2 100644
> --- a/drivers/gpu/drm/panthor/panthor_aw.c
> +++ b/drivers/gpu/drm/panthor/panthor_aw.c
[ ... ]
> @@ -282,8 +282,13 @@ static void panthor_aw_handle_window_opened(struct p=
anthor_aw *aw)
>  		return;
> =20
>  	/* Window opened due to GPU_REQUEST */
> -	panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_REQUEST,
> -				     PANTHOR_AW_STATE_GPU_GRANTED);
> +	if (panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_GPU_REQUEST,
> +				     PANTHOR_AW_STATE_GPU_GRANTED))
> +		return;
> +
> +	if (panthor_aw_state_try_set(aw, PANTHOR_AW_STATE_READY,
> +				     PANTHOR_AW_STATE_STOPPED_IDLE))
> +		panthor_aw_send_msg(aw, VM_ARB_GPU_STOPPED);

[Severity: High]
If panthor_aw_send_msg() drops the message due to the 4-entry message FIFO
being full (-ENOSPC), does the state machine become permanently wedged in
PANTHOR_AW_STATE_STOPPED_IDLE?

Looking at panthor_aw_send_msg(), if the send FIFO is full, it returns
-ENOSPC and simply logs an error without retrying.

Because this runs in the atomic context of panthor_aw_irq_raw_hander(), it
lacks the wait-and-revert timeout fallback that thread-context callers use.
Since the state was already transitioned to PANTHOR_AW_STATE_STOPPED_IDLE
before the message was sent, dropping the message means the hardware is nev=
er
told to stop and the software state never reverts to PANTHOR_AW_STATE_READY.
This could cause all future GPU requests to timeout indefinitely under heavy
GPU load.

>  }
> =20
>  static irqreturn_t panthor_aw_irq_raw_hander(int irq, void *data)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922204535.2850=
094-1-karunika.choo@arm.com?part=3D27
