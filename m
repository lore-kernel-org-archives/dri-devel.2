Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42F9CD8CAC
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DD7810E19C;
	Tue,  9 Jun 2026 08:24:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qs9tUYOU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EACE10E19C
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 08:24:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 16B27443FF;
 Tue,  9 Jun 2026 08:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84081F00893;
 Tue,  9 Jun 2026 08:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780993458;
 bh=UcSMu1TW87AJWX6Q9mYFWv4qdv3fOEMOWWYN8aMQ0n0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Qs9tUYOUVb6TmhQL73/YtOXJ3yzwLzUBHt43Etsbpbp6cPQZBPBMTpE3sTQkiX7hQ
 cFUSLNydMjT+M5S6kbOKxn5tZxEM8gDOYD2oK2O3Giu2ToNdUYQz4Zn1An5SllME+w
 d5/YRrkxt1lRPrPRKW/V6b2b3Y+kdwNOJSpXvuf2n3g0Bof+n+ppH/XOK07SwkMJ2K
 0Kf2INkGq0J/iawn0TWsS8ZgP7KyZ43Mipo6dM9ukuRrUma9kazOgntNQuH0RMHpWb
 W97byBrvF72Avt3Tk2YqZMlm2d1YdgLVcSlRSHzzk91oAysHi8KaOoT50VwKSiRT0p
 C331KYJy3jZvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] gpu: host1x: Wait for timeout worker completion on
 channel free
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609-b4-host1x-small-fixes-a-v1-1-7c1131c0b3ad@nvidia.com>
References: <20260609-b4-host1x-small-fixes-a-v1-1-7c1131c0b3ad@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 08:24:17 +0000
Message-Id: <20260609082417.C84081F00893@smtp.kernel.org>
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
- [High] Missing teardown of `cdma->update_work` during channel destruction=
 causes workqueue corruption and use-after-free races.
- [High] Spurious timeout handler execution aborts newly-started jobs due t=
o unsafe non-synchronous timer cancellation in `update_cdma_locked()`.
--

commit 716b1c0819a18e8bf5a813661ef56163eb1114aa
Author: Mikko Perttunen <mperttunen@nvidia.com>

gpu: host1x: Wait for timeout worker completion on channel free

This commit addresses a race condition during CDMA teardown. By replacing
cancel_delayed_work() with cancel_delayed_work_sync(), it ensures pending
timeout work completes before the CDMA channel is freed. This prevents the
timeout handler from waiting on a destroyed lock.

> diff --git a/drivers/gpu/host1x/hw/cdma_hw.c b/drivers/gpu/host1x/hw/cdma=
_hw.c
> index 3f3f0018eee0d..ab714d221120c 100644
> --- a/drivers/gpu/host1x/hw/cdma_hw.c
> +++ b/drivers/gpu/host1x/hw/cdma_hw.c
> @@ -355,7 +355,7 @@ static int cdma_timeout_init(struct host1x_cdma *cdma)
>  static void cdma_timeout_destroy(struct host1x_cdma *cdma)
>  {
>  	if (cdma->timeout.initialized)
> -		cancel_delayed_work(&cdma->timeout.wq);
> +		cancel_delayed_work_sync(&cdma->timeout.wq);

[Severity: High]
This isn't a bug introduced by this patch, but does the missing teardown of
cdma->update_work during channel destruction cause workqueue corruption and
use-after-free races?

When release_channel() calls host1x_cdma_deinit(), it destroys the push
buffer but fails to call cancel_work_sync(&cdma->update_work):

drivers/gpu/host1x/cdma.c:host1x_cdma_deinit() {
    ...
	host1x_pushbuffer_destroy(pb);
	host1x_hw_cdma_timeout_destroy(host1x, cdma);

	return 0;
}

The cdma->update_work can be scheduled asynchronously by a hardware syncpoi=
nt
interrupt. If the channel is immediately reallocated to a new client,
host1x_cdma_init() unconditionally executes INIT_WORK(&cdma->update_work, .=
..).

Calling INIT_WORK() on an actively queued or running work struct can corrupt
the workqueue linked lists. Additionally, if the stray cdma_update_work()
executes after the push buffer is destroyed, can it dereference a NULL
cdma->push_buffer.mapped?


[Severity: High]
This is a pre-existing issue, but does spurious timeout handler execution
abort newly-started jobs due to unsafe non-synchronous timer cancellation in
update_cdma_locked()?

When a job finishes, stop_cdma_timer_locked() uses non-sync
cancel_delayed_work() under a lock, leaving the executing handler to run:

drivers/gpu/host1x/cdma.c:stop_cdma_timer_locked() {
	cancel_delayed_work(&cdma->timeout.wq);
	cdma->timeout.client =3D NULL;
}

If the timeout handler cdma_timeout_handler() has already started on another
CPU, it blocks waiting for cdma->lock. The current thread then immediately
starts the next job, updating cdma->timeout.client and syncpt_val, and
releases the lock.

The stale timeout handler wakes up, sees cdma->timeout.client is not NULL,
and checks if the NEW job has completed. Since it hasn't, the handler
spuriously assumes a timeout occurred, freezes the CDMA channel, and aborts
the new job.

Is a generation sequence number or explicit time check against start_ktime =
in
the handler required to fix this race safely, since using
cancel_delayed_work_sync() here would cause a deadlock?

> =20
>  	cdma->timeout.initialized =3D false;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-b4-host1x-=
small-fixes-a-v1-0-7c1131c0b3ad@nvidia.com?part=3D1
