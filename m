Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE52CD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 11:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E6B910EADB;
	Tue, 23 Jun 2026 11:59:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="o6IFlnUJ";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BF2D10EAD2
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 11:59:05 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gl3WT44wbz9t9n;
 Tue, 23 Jun 2026 13:59:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1782215941; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pFwdqmW21qxLJH3W3ALeQpHtM3Gll3yJ9POED2YZ2WY=;
 b=o6IFlnUJwHXTp23zSidnt+l/Ma+86RWMLB9P30q8dTUNipVhkSEV2h5LXzceLesT/zcq4g
 dAyfmU+CIz1xqDPjdBGM7jpUJMyPY+7k8i3alJu5UMa9f16AWpA81UZPvY35WPcB1ihj60
 tmYvsCrqNOxHfsyjMD0tPH+SRz01NhJtvKKqXd3Y9dCkFQm72Lbb7dLJAziYfyOd/Z9cWx
 XCR6+30c1gveeRcH/Vf9EwEoH1Sc10rar8gB9rJesU2PdlHN4ak2cxAxX9lrELOhC8+zYq
 eDwev6YJTU6SZLyoUYc2tfhJu9JM75bbssXGkASrOnaL4UGWjlgBarJdtu5LLQ==
Message-ID: <f59d6080cf31f424ebcf0e6086b4a93623813a6e.camel@mailbox.org>
Subject: Re: [PATCH] drm/drm_crtc: fix race with dma_fence_signal() in
 ::get_driver_name()
From: Philipp Stanner <phasta@mailbox.org>
To: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>, 
 phasta@kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,  Simona Vetter
 <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>,  Boris Brezillon
 <boris.brezillon@collabora.com>, Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Juan
 Yescas <jyescas@google.com>, kernel-team@android.com
Date: Tue, 23 Jun 2026 13:58:46 +0200
In-Reply-To: <6483098adae29787862473e39b1f9cf3c3f16625.camel@linaro.org>
References: <20260618-linux-drm_crtc_fix2-v1-1-c03e77b36f34@linaro.org>
 <1cfd56b7f1a166e25d6588d66a621524f3d983de.camel@mailbox.org>
 <6483098adae29787862473e39b1f9cf3c3f16625.camel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: gqq6rmhozrpo34a59ejobmzahu94wzns
X-MBO-RS-ID: f5dd2d7dc6ec6fb48aa
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

On Tue, 2026-06-23 at 12:37 +0100, Andr=C3=A9 Draszik wrote:
> Hi,
>=20
> On Thu, 2026-06-18 at 17:56 +0200, Philipp Stanner wrote:
> > +Cc Danilo
> >=20
> > On Thu, 2026-06-18 at 15:03 +0100, Andr=C3=A9 Draszik wrote:
> > > Since commit 541c8f2468b9 ("dma-buf: detach fence ops on signal v3"),
> > > I'm seeing the BUG_ON() triggering in drm_crtc's fence_to_crtc() via
> > > drm_crtc_fence_get_driver_name() regularly:
> > >=20
> > > =C2=A0=C2=A0=C2=A0 Call trace:
> > > =C2=A0=C2=A0=C2=A0=C2=A0 panic+0x58/0x5c
> > > =C2=A0=C2=A0=C2=A0=C2=A0 die+0x160/0x178
> > > =C2=A0=C2=A0=C2=A0=C2=A0 bug_brk_handler+0x70/0xa4
> > > =C2=A0=C2=A0=C2=A0=C2=A0 call_el1_break_hook+0x3c/0x1a0
> > > =C2=A0=C2=A0=C2=A0=C2=A0 do_el1_brk64+0x24/0x74
> > > =C2=A0=C2=A0=C2=A0=C2=A0 el1_brk64+0x34/0x54
> > > =C2=A0=C2=A0=C2=A0=C2=A0 el1h_64_sync_handler+0x80/0xfc
> > > =C2=A0=C2=A0=C2=A0=C2=A0 el1h_64_sync+0x84/0x88
> > > =C2=A0=C2=A0=C2=A0=C2=A0 drm_crtc_fence_get_driver_name+0x60/0x68 (P)
> > > =C2=A0=C2=A0=C2=A0=C2=A0 sync_file_get_name+0x184/0x45c
> > > =C2=A0=C2=A0=C2=A0=C2=A0 sync_file_ioctl+0x404/0xf70
> > > =C2=A0=C2=A0=C2=A0=C2=A0 __arm64_sys_ioctl+0x124/0x1dc
> > >=20
> > > This looks to be caused by a code flow similar to the following:
> > >=20
> > > +++ snip +++
> > > thread A=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 thread B
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 io=
ctl(SYNC_IOC_FILE_INFO)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sy=
nc_file_ioctl()
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sy=
nc_file_get_name()
> > > dma_fence_signal_timestamp_locked()=C2=A0 dma_fence_driver_name()
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ops =3D rcu_dereference(fence->ops)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (!dma_fence_test_signaled_flag())
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ops->get_driver_name(fence) i.e.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 drm_crtc_fence_get_driver_name()
> > > test_and_set_bit(SIGNALED)
> > > RCU_INIT_POINTER(fence->ops, NULL)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dr=
m_crtc_fence_get_driver_name()
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 BUG_ON(rcu_access_pointer(fence->ops)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !=3D &drm_crtc_fence_op=
s)
> >=20
> > Now this looks like a very similar problem that I have recently been
> > concerned with:
> >=20
> > https://lore.kernel.org/dri-devel/20260612104251.2264707-2-phasta@kerne=
l.org/
> >=20
> > https://lore.kernel.org/dri-devel/fa0dc9757bf8343516c4b156a2b70ec91b64e=
f8f.camel@mailbox.org/
> >=20
> >=20
> > I continue to believe because of bugs like this and the ones I have
> > quoted in the threads above the robustness of the kernel could be
> > greatly improved if we could get dma_fence fully synchronized with its
> > lock.
>=20
> On top of that, sashiko highlighted=C2=A0 (via my other patch) that the e=
xisting
> code is missing some memory barriers:
>=20
> https://sashiko.dev/#/patchset/20260618-linux-drm_crtc_fix-v1-1-801f29c98=
53d@linaro.org?part=3D1
>=20
> I believe Lock synchronization would resolve that (as would adding explic=
it
> memory barriers).

That is being discussed in the thread I linked, where Gary lists which
barriers you would need for (presumably correct) lockless magic.

However, if my issue were to be solved with barriers, the
test_and_set_bit() in dma_fence_signal_timestamp_locked() would have to
be replaced with the more weakly ordered test_bit() and set_bit(),
maybe creating other pitfalls.

The ordering issue in the get_*_name() functions plays into that.
Setting the bit would then be done after setting the ops-pointer to
NULL. So one would have to try to move the NULL set, too.

Long story short, this is painful and subtle.

But I think what we are realizing over and over again is that dma_fence
has many subtleties to its API contract, and the implementation's
sparring use of spinlocks leads to workarounds where people take locks
manually or have to do an RCU dance.

Note that Christian is strongly opposed to guarding everything with
locks, in part for supposedly occuring deadlocks in the fence callbacks
when the driver needs to take its own locks.

The community discussion regarding that problem is currently in some
sort of dead end, where none of us seems to know what the correct path
forward is.

drm_sched users (and future users in Rust) use intermediate fences
which decouple e.g. userspace from the actual hardware fences. So one
path forward might be to question the callbacks in general and think
about some sort of replacement for them.

>=20
> [...]
> > >=20
>=20
> > Does the CRTC or DRM device need to be kept alive for the RCU grace per=
iod,
> > or should the fence hold a proper reference to prevent the use-after-fr=
ee
> > when get_driver_name() and get_timeline_name() access the freed CRTC
> > structure?
>=20
> Do you guys have any preference on that? It appears the use-after-free
> should be resolved before merging the removal of the BUG_ON(), and I'd li=
ke
> to progress on this.

My understanding of the current situation is that as an issuer of
dma_fence's you, in general, should wait for a grace period until you
perform operations like driver unload, or, more generally, have fence-
related resources and such being accessed through callbacks go away.

Danilo has recently mentioned some life-time inconsistencies between
wider kernel device model and DRM device model that might be related to
that discussion, and which made him object against some RCU
requirements.

Maybe he's got the time to share some details with you that are
relevant to your work.


P.

>=20
> Cheers,
> Andre'
