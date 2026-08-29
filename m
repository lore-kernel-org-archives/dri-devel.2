Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA00C61DD7
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 07:30:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFFA610E0BE;
	Sat, 29 Aug 2026 07:30:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LiOZh3F2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2976710E0B0;
 Sat, 29 Aug 2026 07:30:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7212D403E5;
 Sat, 29 Aug 2026 07:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC88F1F000E9;
 Sat, 29 Aug 2026 07:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1787988607;
 bh=gdqDEOzw6jPcRqvtQ9jieT2oIslarDO4T+zjOJWu3Q4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=LiOZh3F2wVjKEDs018U+42ssdRBbdGZkvasPCrlEZ5tFmXTjpz2ivxxCcQrqh8fV9
 0YVPnT9vraWoQ1dtRfh9jbP2z4jZxF/iXYlsAH1yOKNjJb/WpohCjZTcMp7Etj7SFj
 erWESzu/uA7uslybiUbeMrZHobTarfH/83lizZ5U=
Date: Sat, 29 Aug 2026 09:28:24 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: nirbhayykumarr@proton.me
Cc: "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
 "alexander.usyskin@intel.com" <alexander.usyskin@intel.com>,
 "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Subject: Re: [BUG] misc/mei: Race between mei_release() disconnect and
 mei_ioctl_connect_vtag() causes CSME reset storm and i915 freeze
Message-ID: <2026082929-bath-idiom-06e7@gregkh>
References: <HVTY6-E6fK5xolgZqI7bt1JIKctxL4VdcbteGTvPo7PN58iyvU01QXToLr2v9pvJtGTrUHFLuc7xZQtplf6HaZak1JvG3gySDpazMhbHsnE=@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HVTY6-E6fK5xolgZqI7bt1JIKctxL4VdcbteGTvPo7PN58iyvU01QXToLr2v9pvJtGTrUHFLuc7xZQtplf6HaZak1JvG3gySDpazMhbHsnE=@proton.me>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Sat, Aug 29, 2026 at 07:14:10AM +0000, nirbhayykumarr@proton.me wrote:
> Hi all,
> 
> This issue was discovered using a custom multi-threaded C fuzzer
> designed to stress-test MEI Virtual Tag (vtag) client lifecycles and
> multiplexing over /dev/mei0. By concurrently racing rapid vtag
> connections against file descriptor closures and streaming I/O, a
> race condition is triggered during client teardown.

But that's not a normal use case, right?

> System Information & Environment:
> - Kernel Version: 7.1.8-zen1-3-zen x86_64 (drivers/misc/mei is identical to upstream)
> - Kernel Taint: 0 (Not tainted)
> - CPU / Platform: 12th Gen Intel(R) Core(TM) i5-12500H (Alder Lake-P)
> - MEI Controller: 00:16.0 Intel Alder Lake PCH HECI Controller (/dev/mei0)
> - Graphics / DRM: Intel Iris Xe Graphics (i915 driver with mei_hdcp and mei_pxp components)
> - Subsystems:     drivers/misc/mei, drivers/gpu/drm/i915
> 
> In mei_release(), closing the last file descriptor holding a virtual tag
> invokes mei_cl_disconnect(). Inside __mei_cl_disconnect(), dev->device_lock
> is dropped while awaiting the firmware disconnect ACK on cl->wait.
> 
> During this lock-drop window, a concurrent IOCTL_MEI_CONNECT_CLIENT_VTAG
> call on the same UUID (e.g. MKHI) scans dev->file_list, matches the tearing-
> down client 'pos' (in MEI_FILE_DISCONNECTING), repoints file->private_data
> to pos, and adds its new vtag to pos->vtag_map.
> 
> When the disconnect ACK arrives, __mei_cl_disconnect() calls
> mei_cl_set_disconnected(cl), setting cl->me_cl = NULL and
> cl->state = MEI_FILE_DISCONNECTED. Because pos->vtag_map now contains the
> second thread's tag, mei_release() skips unlinking/freeing cl. The second
> thread then wakes up and attempts to reconnect via mei_ioctl_connect_client().
> 
> Additionally, shared clients lack tag based demuxing on cl->rd_pending in
> drivers/misc/mei/interrupt.c:
>   cb = list_first_entry_or_null(&cl->rd_pending, struct mei_cl_cb, list);
> 
> Incoming packets are matched to the head of the FIFO queue regardless of
> vtag, causing -EPROTO errors, dropped packets, and out-of-order HBM command
> sequences. This triggers continuous CSME hardware link resets:
>   mei mei0: FW not ready: resetting: dev_state = 3
>   mei mei0: unexpected reset: dev_state = ENABLED fw status = ...
> 
> During each reset, child client drivers (mei_hdcp, mei_pxp) unbind and rebind
> with i915 DRM. With resets looping at hundreds of cycles per second (>9,800
> events in 27s), mei_cldev_enable() repeatedly fails with -EFAULT / -ENODEV,
> deadlocking i915 display worker mutexes in TASK_UNINTERRUPTIBLE and causing
> an unrecoverable full system freeze.
> 
> Journalctl logs:
>   mei mei0: FW not ready: resetting: dev_state = 3
>   mei mei0: unexpected reset: dev_state = ENABLED fw status = 90000245 89110106 00000020 00004000 00021F03 446003CB
>   mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: mei_cldev_enable Failed. -14
>   mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: probe with driver mei_hdcp failed with error -14
>   mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
>   mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: bound 0000:00:02.0 (ops i915_pxp_tee_component_ops [i915])
>   mei mei0: FW not ready: resetting: dev_state = 3
>   mei mei0: unexpected reset: dev_state = ENABLED fw status = 90000245 89110106 00000020 00004000 00021F03 446003CB
> 
> Proposed Fix:
> - Prevent vtag reuse during teardown: in mei_ioctl_connect_vtag(),
>    ignore existing clients on dev->file_list if they are in
>    MEI_FILE_DISCONNECTING or MEI_FILE_DISCONNECTED states or undergoing
>    teardown.
> - Implement proper reference counting / lifecycle synchronization on
>    shared struct mei_cl instances.
> - In drivers/misc/mei/interrupt.c, demux cl->rd_pending by matching the
>    incoming packet's vtag header to the corresponding callback rather
>    than assuming FIFO order.
> - Add rate-limiting / backoff to MEI client reprobing during hardware
>    link resets to prevent cascading bus storms into DRM / i915.

Please send patches for this if you wish to see these issues addressed.
As you have a reproducer, it should be simple for you to do so.

And how does this differ from the patch you have already sent but has
not yet been merged?

thanks,

greg k-h
