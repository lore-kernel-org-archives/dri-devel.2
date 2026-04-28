Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47ADBFF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 10:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A427510E30B;
	Tue, 28 Apr 2026 10:49:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="STo8fJu+";
	dkim-atps=neutral
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch
 [109.224.244.106])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9179010E30B
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 10:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1777373350; x=1777632550;
 bh=fbT9gWM6XWnCdLK4JLXtdmr86SMczqS/v6a1DSSWQyU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=STo8fJu+8levUckLdh+MyrwEKDrN/W4aY3QauaBmIlzVBrMFVxSoCvRnIh7L3SDRF
 MYvDVIksz6pjM12D+aZzz/Jd7e9UC90h6TWnd6g7KZnqZkWnN/TeL0U9wSXFt0muGD
 wF1gCaW8zO9q29fcxm/3YkB8NPOesU5X5hzMubGSuJxVqH79EtCyFgSGn66QuUX1rt
 zZycvPUz+zo07coScmAZ+zIJG5TOzS8slGTiiaddU0a4Ohp+aH/eixcKeA8uSwOQkY
 4vzw7pOcEhBjQf5XV+wPKTAuhtVSND+xpGGMezvkNuI+j7X09NJRRlIfUfIeluVkzY
 pVlEjt8zEHHVg==
X-Pm-Submission-Id: 4g4cch06QQz2ScpX
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Boqun Feng <boqun@kernel.org>
Cc: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/4] drm/tyr: implement GPU reset API
Date: Tue, 28 Apr 2026 13:49:05 +0300
Message-ID: <20260428104906.180242-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <aeEuZKgnvaz2Y6WO@tardis.local>
References: <20260416171728.205141-1-work@onurozkan.dev>
 <20260416172347.209317-1-work@onurozkan.dev> <aeEuZKgnvaz2Y6WO@tardis.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, 16 Apr 2026 11:45:56 -0700=0D
Boqun Feng <boqun@kernel.org> wrote:=0D
=0D
> On Thu, Apr 16, 2026 at 08:23:45PM +0300, Onur =C3=96zkan wrote:=0D
> > On Thu, 16 Apr 2026 20:17:26 +0300=0D
> > Onur =C3=96zkan <work@onurozkan.dev> wrote:=0D
> > =0D
> > > This series adds GPU reset handling support for Tyr in a new module=0D
> > > drivers/gpu/drm/tyr/driver.rs which encapsulates the low-level reset=
=0D
> > > controller internals and exposes a ResetHandle API to the driver.=0D
> > > =0D
> > > This series is based on Alice's "Creation of workqueues in Rust" [1]=
=0D
> > > series.=0D
> > > =0D
> > > Changes since v1:=0D
> > >   - Removed OrderedQueue and using Alice's workqueue implementation [=
1] instead.=0D
> > >   - Added Resettable trait with pre_reset and post_reset hooks to be =
implemented by=0D
> > >     reset-managed hardwares.=0D
> > >   - Added SRCU abstraction and used it to synchronize the reset work =
and hardware access.=0D
> > > =0D
> > > 3 important points:=0D
> > >   - There is no hardware using this API yet.=0D
> > >   - On post_reset() failure, we don't do anything for now. We should =
unplug the GPU (that's=0D
> > >     what Panthor does) but we don't have the infrastructure for that =
yet (see [2]).=0D
> > >   - In schedule(), similar to panthor_device_schedule_reset(), we sho=
uld have a PM check=0D
> > >     but similar to the note above, we don't have the infrastructure f=
or that yet.=0D
> > > =0D
> > > Link: https://lore.kernel.org/all/20260312-create-workqueue-v4-0-ea39=
c351c38f@google.com/ [1]=0D
> > > Link: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/29#n=
ote_3391826 [2]=0D
> > > Link: https://gitlab.freedesktop.org/panfrost/linux/-/issues/28=0D
> > > =0D
> > > Onur =C3=96zkan (4):=0D
> > >   rust: add SRCU abstraction=0D
> > >   MAINTAINERS: add Rust SRCU files to SRCU entry=0D
> > >   rust: add Work::disable_sync=0D
> > >   drm/tyr: add reset management API=0D
> > > =0D
> > >  MAINTAINERS                          |   3 +=0D
> > >  drivers/gpu/drm/tyr/driver.rs        |  40 +---=0D
> > >  drivers/gpu/drm/tyr/reset.rs         | 293 +++++++++++++++++++++++++=
++=0D
> > >  drivers/gpu/drm/tyr/reset/hw_gate.rs | 155 ++++++++++++++=0D
> > >  drivers/gpu/drm/tyr/tyr.rs           |   1 +=0D
> > >  rust/helpers/helpers.c               |   1 +=0D
> > >  rust/helpers/srcu.c                  |  18 ++=0D
> > >  rust/kernel/sync.rs                  |   2 +=0D
> > >  rust/kernel/sync/srcu.rs             | 109 ++++++++++=0D
> > >  rust/kernel/workqueue/mod.rs         |  15 ++=0D
> > >  10 files changed, 607 insertions(+), 30 deletions(-)=0D
> > >  create mode 100644 drivers/gpu/drm/tyr/reset.rs=0D
> > >  create mode 100644 drivers/gpu/drm/tyr/reset/hw_gate.rs=0D
> > >  create mode 100644 rust/helpers/srcu.c=0D
> > >  create mode 100644 rust/kernel/sync/srcu.rs=0D
> > > =0D
> > > -- =0D
> > > 2.51.2=0D
> > > =0D
> > =0D
> > I messed up when sending the series (part of it was sent as a separate =
series=0D
> > [1]. I will resend this properly, sorry for the noise.=0D
> > =0D
> =0D
> FWIW, I didn't receive your patch #3 (even from my subscription on=0D
> rust-for-linux list).=0D
> =0D
> Could you add a doc test for disable_sync(), I'm curious about it=0D
> because you may disable a work that has not be executed yet, and=0D
> wouldn't that be leaking memory (IIUC, we rely on Arc::drop() in=0D
> WorkItemPointer::run() to decrease the refcounts), but maybe I'm missing=
=0D
> something subtle.=0D
> =0D
> Regards,=0D
> Boqun=0D
> =0D
=0D
Hi Boqun,=0D
=0D
I fixed the leak issue and this change now has its own series at [1]. I cou=
ldn't=0D
figure an easy way to write the doc-test tho, it started to add too much=0D
complextiy and I didn't think it's worth it.=0D
=0D
- Onur=0D
=0D
[1]: https://lore.kernel.org/all/20260428104459.174602-1-work@onurozkan.dev=
=0D
=0D
> > [1]: https://lore.kernel.org/all/20260416171728.205141-1-work@onurozkan=
.dev/=0D
> > =0D
> > -Onur=0D
> > =0D
