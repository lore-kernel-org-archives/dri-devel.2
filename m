Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9365CCCF2E7
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:39:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9752C10E154;
	Mon, 19 Oct 2026 14:39:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2CF710E154
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 14:39:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 86B33437D3
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 14:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDED1F000C4;
 Mon, 19 Oct 2026 14:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792420772;
 bh=OGUUNRvWEJDIAIrGT4wId5beYzFczrGRc0OrL6Fseto=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bCJw8/Glg6Cvqzx+bo9Ie05292JAu9XNQnMUXEcvdbY0fTfIuu7PodTj1Ug5pJZtz
 PRH5VviyhW+c8ZfdCrly9KvzDnEptPpD6TNIEbhgNV3FWeUw5jsg3AZiSRnRFg/LF+
 HAogSxGtOS0wmBuusgcISKphVET3lZ0mFJc8pgAjHSuAy4FPmg5cFoRimKrW/O9E+L
 0ZKgMVII/oK6qS7gF3A81vA1DocM5oN6o2nks15VSMssH4bC4F4k4t5dX7RgIPtavS
 VepN7jY7vn1vD3Ul5IS+gYFDCZSLz5cCPRJi9RuIIQg/A/smc+ZyqU9T2ht0JT19j1
 tb1/36ButIxlg==
Message-ID: <sashiko-outbox-177463@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] gpu: host1x: Wait for timeout worker
 completion on channel free
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261019135441.1420968-140-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-140-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:39:31 +0000
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
- [High] gpu: host1x: self-deadlock in cdma_timeout_destroy() from timeout =
worker
--

commit b332f714cbff777dfee1bb3478ceeef598654573
Author: Mikko Perttunen <mperttunen@nvidia.com>

gpu: host1x: Wait for timeout worker completion on channel free

This commit updates cdma_timeout_destroy() to use
cancel_delayed_work_sync() instead of cancel_delayed_work() so that any
running timeout handler finishes before CDMA teardown proceeds.

Link: https://patch.msgid.link/20260609-b4-host1x-small-fixes-a-v1-1-7c1131=
c0b3ad@nvidia.com

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
Can calling cancel_delayed_work_sync(&cdma->timeout.wq) here self-deadlock
when invoked from within cdma_timeout_handler() itself?

Before taking cdma->lock, cdma_timeout_handler() runs without holding a
reference of its own on struct host1x_channel and calls
host1x_debug_dump():

drivers/gpu/host1x/hw/cdma_hw.c:cdma_timeout_handler() {
	...
	host1x_debug_dump(cdma_to_host1x(cdma));

	mutex_lock(&cdma->lock);
	...
}

host1x_debug_dump() calls show_all(), which iterates over all channels,
acquires a temporary kref via host1x_channel_get_index(), dumps the
channel, and drops that reference via host1x_channel_put():

drivers/gpu/host1x/debug.c:show_all() {
	...
	for (i =3D 0; i < m->info->nb_channels; ++i) {
		struct host1x_channel *ch =3D host1x_channel_get_index(m, i);

		if (ch) {
			show_channel(ch, o, show_fifo);
			host1x_channel_put(ch);
		}
	}
	...
}

If the channel owner closes the channel and calls host1x_channel_put()
while cdma_timeout_handler() is inside show_channel() holding that
temporary reference on its own channel, the owner's kref_put() decrements
ch->refcount from 2 to 1 and returns without releasing the channel.

When show_channel() finishes, the host1x_channel_put(ch) in show_all()
drops ch->refcount from 1 to 0 and synchronously calls release_channel()
from the cdma->timeout.wq worker context:

cdma_timeout_handler()
  -> host1x_debug_dump()
    -> show_all()
      -> host1x_channel_put()
        -> release_channel()
          -> host1x_hw_cdma_stop()
          -> host1x_cdma_deinit()
            -> host1x_hw_cdma_timeout_destroy()
              -> cdma_timeout_destroy()
                -> cancel_delayed_work_sync(&cdma->timeout.wq)

At that point, if cdma->sync_queue is not yet empty, host1x_hw_cdma_stop()
blocks indefinitely waiting on CDMA_EVENT_SYNC_QUEUE_EMPTY; otherwise it
proceeds to cdma_timeout_destroy(), where cancel_delayed_work_sync() waits
for the currently executing cdma->timeout.wq work item to complete,
deadlocking the worker thread.

> =20
>  	cdma->timeout.initialized =3D false;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-140-sashal@kernel.org?part=3D1
