Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780D4C624C2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66C1410E69B;
	Mon, 31 Aug 2026 07:00:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="ck63mK0V";
	dkim-atps=neutral
Received: from mail-244103.protonmail.ch (mail-244103.protonmail.ch
 [109.224.244.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B7CE10E0E8
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 10:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1787999769; x=1788258969;
 bh=9gycK/4wH3LKRRi/ZIX7zEeGMX0rP58XKrd5YTKBKNc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=ck63mK0VCiSeIDvO6v3PE+XFY6CD4/NQk9XxNNCw7Ckdm0aH7li2c1Pwc+VWUzX5K
 CphLkhRzSnzipU8zJQCyrg5qeRw7NQPy+BKz5jiYS1IP4w0RqQXmZa7wK8JIhN2KJM
 9hn77mPiJV7NxhXNMGxteckuaN1M/dKv5kmDipUb7Gvj0T4kuGCZWN6FbhyBhQELbr
 yfrjPPNJMX21669OsQhUhSJwVbVqC8G2kA/ypcqfc4ynyI/8NNtPLDkgsS8JYrc53m
 0ngCcvbdeGZ5ASF0GdcDffGrF03EJRAsnSLX2t1SesyGTsrFSsxQmcRSqR0hR7hp8x
 8VqgVXD7Xq3lw==
Date: Sat, 29 Aug 2026 10:36:04 +0000
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
From: nirbhayykumarr@proton.me
Cc: "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
 "alexander.usyskin@intel.com" <alexander.usyskin@intel.com>,
 "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Subject: Re: [BUG] misc/mei: Race between mei_release() disconnect and
 mei_ioctl_connect_vtag() causes CSME reset storm and i915 freeze
Message-ID: <SWbw2eeUo9ExN9Aw7wAoQuQdmYKIgs4QW6fz-1L8TIVtBowiohgHD7gxkCVeNC_3lT4U20731Kh8LJnrDScvF0-EUj2YxnXMe9yjDto70h0=@proton.me>
In-Reply-To: <2026082929-bath-idiom-06e7@gregkh>
References: <HVTY6-E6fK5xolgZqI7bt1JIKctxL4VdcbteGTvPo7PN58iyvU01QXToLr2v9pvJtGTrUHFLuc7xZQtplf6HaZak1JvG3gySDpazMhbHsnE=@proton.me>
 <2026082929-bath-idiom-06e7@gregkh>
Feedback-ID: 172828574:user:proton
X-Pm-Message-ID: f92cdf5953adc231a5e2c89b01f1e5ad76ebfa01
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:00:03 +0000
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

On Saturday, August 29th, 2026 at 1:00 PM, gregkh@linuxfoundation.org <greg=
kh@linuxfoundation.org> wrote:

> On Sat, Aug 29, 2026 at 07:14:10AM +0000, nirbhayykumarr@proton.me wrote:
> > Hi all,
> >
> > This issue was discovered using a custom multi-threaded C fuzzer
> > designed to stress-test MEI Virtual Tag (vtag) client lifecycles and
> > multiplexing over /dev/mei0. By concurrently racing rapid vtag
> > connections against file descriptor closures and streaming I/O, a
> > race condition is triggered during client teardown.
>=20
> But that's not a normal use case, right?

Yes, you are right. It is definitely not a normal, everyday
workload. it is an extreme edge case that I caught unintentionally while
stress-testing vtag multiplexing during a broader CSME research project.
But because it results in an unrecoverable full system kernel and
DRM/i915 display freeze when hit, I thought it was important to document
and report it.

> > In mei_release(), closing the last file descriptor holding a virtual ta=
g
> > invokes mei_cl_disconnect(). Inside __mei_cl_disconnect(), dev->device_=
lock
> > is dropped while awaiting the firmware disconnect ACK on cl->wait.
> >
> > During this lock-drop window, a concurrent IOCTL_MEI_CONNECT_CLIENT_VTA=
G
> > call on the same UUID (e.g. MKHI) scans dev->file_list, matches the tea=
ring-
> > down client 'pos' (in MEI_FILE_DISCONNECTING), repoints file->private_d=
ata
> > to pos, and adds its new vtag to pos->vtag_map.
> >
> > When the disconnect ACK arrives, __mei_cl_disconnect() calls
> > mei_cl_set_disconnected(cl), setting cl->me_cl =3D NULL and
> > cl->state =3D MEI_FILE_DISCONNECTED. Because pos->vtag_map now contains=
 the
> > second thread's tag, mei_release() skips unlinking/freeing cl. The seco=
nd
> > thread then wakes up and attempts to reconnect via mei_ioctl_connect_cl=
ient().
> >
> > Additionally, shared clients lack tag based demuxing on cl->rd_pending =
in
> > drivers/misc/mei/interrupt.c:
> >   cb =3D list_first_entry_or_null(&cl->rd_pending, struct mei_cl_cb, li=
st);
> >
> > Incoming packets are matched to the head of the FIFO queue regardless o=
f
> > vtag, causing -EPROTO errors, dropped packets, and out-of-order HBM com=
mand
> > sequences. This triggers continuous CSME hardware link resets:
> >   mei mei0: FW not ready: resetting: dev_state =3D 3
> >   mei mei0: unexpected reset: dev_state =3D ENABLED fw status =3D ...
> >
> > During each reset, child client drivers (mei_hdcp, mei_pxp) unbind and =
rebind
> > with i915 DRM. With resets looping at hundreds of cycles per second (>9=
,800
> > events in 27s), mei_cldev_enable() repeatedly fails with -EFAULT / -ENO=
DEV,
> > deadlocking i915 display worker mutexes in TASK_UNINTERRUPTIBLE and cau=
sing
> > an unrecoverable full system freeze.
> >
> > Proposed Fix:
> > - Prevent vtag reuse during teardown: in mei_ioctl_connect_vtag(),
> >    ignore existing clients on dev->file_list if they are in
> >    MEI_FILE_DISCONNECTING or MEI_FILE_DISCONNECTED states or undergoing
> >    teardown.
> > - Implement proper reference counting / lifecycle synchronization on
> >    shared struct mei_cl instances.
> > - In drivers/misc/mei/interrupt.c, demux cl->rd_pending by matching the
> >    incoming packet's vtag header to the corresponding callback rather
> >    than assuming FIFO order.
> > - Add rate-limiting / backoff to MEI client reprobing during hardware
> >    link resets to prevent cascading bus storms into DRM / i915.
>=20
> Please send patches for this if you wish to see these issues addressed.
> As you have a reproducer, it should be simple for you to do so.

I appreciate the nudge. While the reproducer is straightforward, safely=20
resolving the cross-subsystem interaction between MEI and i915 without=20
introducing regressions seemed complex enough that I initially deferred=20
to the Intel maintainers.=20

However, since I've already mapped out the race in mei_ioctl_connect_vtag()=
,=20
I am happy to take a shot at it. I will work on implementing the localized=
=20
state checks to prevent vtag reuse during teardown, and I'll submit a=20
patch for review in the next few days.

> And how does this differ from the patch you have already sent but has
> not yet been merged?

The previous patch addressed a single-client teardown ordering issue where=
=20
incoming IRQ completions populated cl->rd_completed after mei_cl_flush_queu=
es()=20
was called, triggering a WARN_ON() in mei_cl_unlink().

This issue is a separate, multi-client race specific to Virtual Tag (vtag)
multiplexing in mei_ioctl_connect_vtag(). While mei_release() drops
dev->device_lock to wait for firmware disconnect, a concurrent thread
requesting a new vtag matches the tearing-down client on dev->file_list.
When the disconnect finishes, cl->me_cl is cleared/NULL'd while the client
is actively reused, resulting in CSME hardware reset loops and cascading
DRM/i915 display freezes.


Thanks,
Nirbhay Kumar
