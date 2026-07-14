Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0309EC43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 07:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3301410E029;
	Tue, 14 Jul 2026 07:53:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jaJ4r2ix";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 292F010E029
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 07:53:25 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gzs4K1CZMzKngh;
 Tue, 14 Jul 2026 09:53:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1784015601; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E86emSsGnNboEBZz/nB/ic8WsIfQJK/xE8FObu6WebA=;
 b=jaJ4r2ixSyy5ZMqCjJ4PkmGeKFvgIbO8WFUlPvQLUoetPOycliithx3DloUAkqUPTXQmv+
 ihGegmn87UF6HycjtAWL3oRgIniHETVJ0ZJwgbVwr7mHCWYltjTl9RTmYicEt1v68xyZUS
 JSTfSDWAedG1qx8q4VcGGwAAsu2YiW1Pn7KrcLJOnOLM5c32qMcml9vjG1rfSZcespulID
 sFFG/XIx9j1Dd8agq3kZCrpAL7fid3sB4WtIhEcoyXgPhVnNVcIiuKSiVxauS0fahlqG06
 4XokDyCKPAqJRPzsWf/Oj/u1nbPoNi1dPpgZQYq8eqzyE1Q72QAGV/EMpM0WUA==
Message-ID: <aee97ce4aad6bcf63ce9e7066e20a4ff6f082669.camel@mailbox.org>
Subject: Re: [PATCH 1/9] dma-buf: add dma_fence_was_initialized function v2
From: Philipp Stanner <phasta@mailbox.org>
To: Jiri Slaby <jirislaby@kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, tursulin@ursulin.net, 
 matthew.brost@intel.com, sumit.semwal@linaro.org
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Date: Tue, 14 Jul 2026 09:53:18 +0200
In-Reply-To: <0d40243b-0929-46d2-be85-e3248d4bd09c@kernel.org>
References: <20260120105655.7134-1-christian.koenig@amd.com>
 <20260120105655.7134-2-christian.koenig@amd.com>
 <0d40243b-0929-46d2-be85-e3248d4bd09c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 34a5d9ee4190364e532
X-MBO-RS-META: mp11rxeenwe8wkcn3hooppsutsh3h59w
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, 2026-07-13 at 10:58 +0200, Jiri Slaby wrote:
> Hi,
>=20
> On 20. 01. 26, 11:54, Christian K=C3=B6nig wrote:
> > Some driver use fence->ops to test if a fence was initialized or not.
> > The problem is that this utilizes internal behavior of the dma_fence
> > implementation.
> >=20
> > So better abstract that into a function.
> >=20
> > v2: use a flag instead of testing fence->ops, rename the function, move
> > =C2=A0=C2=A0=C2=A0=C2=A0 to the beginning of the patch set.
> ...
> > --- a/drivers/gpu/drm/qxl/qxl_release.c
> > +++ b/drivers/gpu/drm/qxl/qxl_release.c
> > @@ -146,7 +146,7 @@ qxl_release_free(struct qxl_device *qdev,
> > =C2=A0=C2=A0	idr_remove(&qdev->release_idr, release->id);
> > =C2=A0=C2=A0	spin_unlock(&qdev->release_idr_lock);
> > =C2=A0=20
> > -	if (release->base.ops) {
> > +	if (dma_fence_was_initialized(&release->base)) {

Could you verify the cause with sth like

if (release->base.ops && dma_fence_was_initialized(=E2=80=A6)) {

?

> > =C2=A0=C2=A0		WARN_ON(list_empty(&release->bos));
> > =C2=A0=C2=A0		qxl_release_free_list(release);
> > =C2=A0=20
>=20
> This likely breaks qxl:
> https://bugzilla.suse.com/show_bug.cgi?id=3D1271081
>=20
> =C2=A0> refcount_t: underflow; use-after-free.
> =C2=A0> WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/0x90,=
=20
> CPU#0: kworker/0:0/1534
> =C2=A0> Modules linked in: af_packet nft_fib_inet ...
> =C2=A0> CPU: 0 UID: 0 PID: 1534 Comm: kworker/0:0 Not tainted 7.1.3-1-def=
ault=20
> #1 PREEMPT(full) openSUSE Tumbleweed=20
> b041a6527f6e58424f4cd3de0fade8d408b378fd
> =C2=A0> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=20
> rel-1.16.3-2-gc13ff2cd-prebuilt.qemu.org 04/01/2014
> =C2=A0> Workqueue: events qxl_gc_work [qxl]
> =C2=A0> RIP: 0010:refcount_warn_saturate+0x59/0x90
> =C2=A0> Code: 44 48 8d 3d a9 72 b7 01 67 48 0f b9 3a c3 cc cc cc cc 48 8d=
 3d=20
> a8 72 b7 01 67 48 0f b9 3a c3 cc cc cc cc 48 8d 3d a7 72 b7 01 <67> 48=
=20
> 0f b9 3a c3 cc cc cc cc 48 8d 3d a6 72 b7 01 67 48 0f b9 3a
> =C2=A0> RSP: 0018:ffffce09019efe00 EFLAGS: 00010246
> =C2=A0> RAX: 0000000000000000 RBX: ffff8b5a56f819c0 RCX: 0000000000000017
> =C2=A0> RDX: 0000000000011696 RSI: 0000000000000003 RDI: ffffffffbc953b70
> =C2=A0> RBP: ffff8b5a4a314000 R08: 0000000000000001 R09: ffffffffc07d488a
> =C2=A0> R10: fffffa6fc4787d80 R11: ffff8b5a40044000 R12: 0000000000000004
> =C2=A0> R13: 0000000000000003 R14: ffffce09003f1434 R15: ffff8b5a410c4640
> =C2=A0> FS:=C2=A0 0000000000000000(0000) GS:ffff8b5afe954000(0000)=20
> knlGS:0000000000000000
> =C2=A0> CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> =C2=A0> CR2: 00007ff463d65000 CR3: 000000012b476004 CR4: 0000000000772ef0
> =C2=A0> PKRU: 55555554
> =C2=A0> Call Trace:
> =C2=A0>=C2=A0 <TASK>
> =C2=A0>=C2=A0 qxl_release_free+0xee/0xf0 [qxl=20
> d93e9381353e619799d56790f5f8dda6cce491f6]
> =C2=A0>=C2=A0 qxl_garbage_collect+0xd1/0x1b0 [qxl=20
> d93e9381353e619799d56790f5f8dda6cce491f6]
> =C2=A0>=C2=A0 process_one_work+0x19e/0x3a0
> =C2=A0> ...
>=20
> The function does now:
>=20
> =C2=A0> void
> =C2=A0> qxl_release_free(struct qxl_device *qdev,
> =C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct qxl_release *release)
> =C2=A0> {
> =C2=A0> ...
> =C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dma_fence_was=
_initialized(&release->base)) {
> =C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON(list_empty(&release->bos));=20
>=20
> =C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qxl_release_free_list(release);=20
>=20
> =C2=A0>=20
>=20
> =C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_fence_signal(&release->base);=20
>=20
> =C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_fence_put(&release->base);=20
>=20
> =C2=A0=20
>=20
> refcount_dec_and_test() in kref_put() in this ^^ crashes. Apparently,
> the reference count was not increased anywhere. QXL does not call=20
> dma_fence_get() -- who is supposed to increase the refcount.
>=20

dma_fence_init() initializes the refcount to 1. So since there is only
one place with dma_fence_put(), it probably aims at countering that.


>  And why it=20
> did not fail before?

My guess would be that base->ops was used as a boolean to see whether
qxl_release contains a valid fence. It seems qxl_release_free() is
intended as some sort of universal function; it is called at many
places. So I would suppose it is sometimes being called without the
fence being initialized.

Should most certainly have been documented. Anyways, verifying the
issue would probably be cool

Cheers,
P.

> =C2=A0=20
>=20
> =C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {=20
>=20
> =C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qxl_release_free_list(release);=20
>=20
> =C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(release);=20
>=20
> =C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }=20
>=20
> =C2=A0>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_dec(&qdev-=
>release_count);=20
>=20
> =C2=A0> }
>=20
> thanks,
