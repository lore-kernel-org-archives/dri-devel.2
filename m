Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B74F8D765
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 18:46:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 362C410E219;
	Thu, 16 Apr 2026 18:46:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b9DwWfLR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 946BA10E219
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 18:46:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9A29A60127;
 Thu, 16 Apr 2026 18:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1061CC4AF09;
 Thu, 16 Apr 2026 18:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776365159;
 bh=QJycfzYK/iKLQag2CxHKrlbhQSrWb5pi5rDHTNBpzyE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=b9DwWfLRq4qutaJemSlcJIUFpyweL1vl4KxHUiiqXEtsdQOtYBR3cOJ96odkhOHny
 VBWUD4AvHw5s8I3tkYhpALYGVhBST2a9kzHu+faFD57BNnYhHW+9lXv1AVC8ojV01M
 4ndE0c4FJLXaYNRGRtRpJzqfZ1An4ZMBJ7fItFzwAZ/6VQtr5kuhaYpZLDccRnuFo1
 GzbDgP1jsLMC4CycnFHi8MtnqpzHZO03BnrkDynGFsQKqBFUygqwx+v6B1ohZQzjVa
 M5F9vif21MCTPjWR4PxBxI9hhX/i2htopBVN3AImBoTAJV1u1l2IvcpCHvZ1NgrWIc
 h+ao9DqfLo6sg==
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfauth.phl.internal (Postfix) with ESMTP id 15A56F40068;
 Thu, 16 Apr 2026 14:45:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Thu, 16 Apr 2026 14:45:58 -0400
X-ME-Sender: <xms:ZS7haaL9N-Onj8ZQ4nwwgGI0QBH_yqixqCiSC4eKJ5gYpouMQm3yuA>
 <xme:ZS7haYIBETNXCEds933RJcmCfIpN3pqJgEbiRH12gL0ZCz8VDQwG06_vdNv1VDY3N
 M-QY9YR3DG1JMeFIgq4QvRGvFOcoK7i3DvoCOz9zjVOdDP5KNhcWg>
X-ME-Received: <xmr:ZS7haVjZMLmC1lXsWjZjCWOH2iZiMABK4TTg-WztWJKfd3NpDQfqRMIYDQZT1nBnZby8hz9y64Bu9C_4zQryrm_22rcDxifV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeejiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
 dttddunecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnsehkvghrnhgvlhdr
 ohhrgheqnecuggftrfgrthhtvghrnhepteeiveelteelleelkeekieejjeevvdektdfhgf
 fhgfevkeevudehleettdevgfelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpfhhr
 vggvuggvshhkthhophdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
 thihqdduieejtdelkeegjeduqddujeejkeehheehvddqsghoqhhunheppehkvghrnhgvlh
 drohhrghesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtohepfihorhhksehonhhurhhoiihkrghnrdguvghvpdhrtg
 hpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhih
 hhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopegurghnihgvlhdrrghlmhgvihgurg
 estgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhl
 rdgtohhmpdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrdgthhdprhgtphhtthhope
 gurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghp
 thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
 hpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Zi7haSOroywv0hmlp5h5LZKKNQNqLMdKtEj8aCXcp4XRgBmZurJanQ>
 <xmx:Zi7haQoSMLUl5TcPSGDmjuoO49y3JXCix7P1TjqRsv_HUiGnsYSWVQ>
 <xmx:Zi7haU4wXQUFUEusv-ehzsJ-syd_er3gp9cFOZLIuKP7iwPZ-uoBMA>
 <xmx:Zi7haejoSSXd6h82gvo88SbgaJnO2nbRUATDGD-onJHUbYFW69ar_g>
 <xmx:Zi7haa5tfSTbGCpPmhGUAUIoJSIy2dn6KqC-Bcr9LDyI0gV8aQVPoBG0>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 14:45:57 -0400 (EDT)
Date: Thu, 16 Apr 2026 11:45:56 -0700
From: Boqun Feng <boqun@kernel.org>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/4] drm/tyr: implement GPU reset API
Message-ID: <aeEuZKgnvaz2Y6WO@tardis.local>
References: <20260416171728.205141-1-work@onurozkan.dev>
 <20260416172347.209317-1-work@onurozkan.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416172347.209317-1-work@onurozkan.dev>
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

On Thu, Apr 16, 2026 at 08:23:45PM +0300, Onur Özkan wrote:
> On Thu, 16 Apr 2026 20:17:26 +0300
> Onur Özkan <work@onurozkan.dev> wrote:
> 
> > This series adds GPU reset handling support for Tyr in a new module
> > drivers/gpu/drm/tyr/driver.rs which encapsulates the low-level reset
> > controller internals and exposes a ResetHandle API to the driver.
> > 
> > This series is based on Alice's "Creation of workqueues in Rust" [1]
> > series.
> > 
> > Changes since v1:
> >   - Removed OrderedQueue and using Alice's workqueue implementation [1] instead.
> >   - Added Resettable trait with pre_reset and post_reset hooks to be implemented by
> >     reset-managed hardwares.
> >   - Added SRCU abstraction and used it to synchronize the reset work and hardware access.
> > 
> > 3 important points:
> >   - There is no hardware using this API yet.
> >   - On post_reset() failure, we don't do anything for now. We should unplug the GPU (that's
> >     what Panthor does) but we don't have the infrastructure for that yet (see [2]).
> >   - In schedule(), similar to panthor_device_schedule_reset(), we should have a PM check
> >     but similar to the note above, we don't have the infrastructure for that yet.
> > 
> > Link: https://lore.kernel.org/all/20260312-create-workqueue-v4-0-ea39c351c38f@google.com/ [1]
> > Link: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/29#note_3391826 [2]
> > Link: https://gitlab.freedesktop.org/panfrost/linux/-/issues/28
> > 
> > Onur Özkan (4):
> >   rust: add SRCU abstraction
> >   MAINTAINERS: add Rust SRCU files to SRCU entry
> >   rust: add Work::disable_sync
> >   drm/tyr: add reset management API
> > 
> >  MAINTAINERS                          |   3 +
> >  drivers/gpu/drm/tyr/driver.rs        |  40 +---
> >  drivers/gpu/drm/tyr/reset.rs         | 293 +++++++++++++++++++++++++++
> >  drivers/gpu/drm/tyr/reset/hw_gate.rs | 155 ++++++++++++++
> >  drivers/gpu/drm/tyr/tyr.rs           |   1 +
> >  rust/helpers/helpers.c               |   1 +
> >  rust/helpers/srcu.c                  |  18 ++
> >  rust/kernel/sync.rs                  |   2 +
> >  rust/kernel/sync/srcu.rs             | 109 ++++++++++
> >  rust/kernel/workqueue/mod.rs         |  15 ++
> >  10 files changed, 607 insertions(+), 30 deletions(-)
> >  create mode 100644 drivers/gpu/drm/tyr/reset.rs
> >  create mode 100644 drivers/gpu/drm/tyr/reset/hw_gate.rs
> >  create mode 100644 rust/helpers/srcu.c
> >  create mode 100644 rust/kernel/sync/srcu.rs
> > 
> > -- 
> > 2.51.2
> > 
> 
> I messed up when sending the series (part of it was sent as a separate series
> [1]. I will resend this properly, sorry for the noise.
> 

FWIW, I didn't receive your patch #3 (even from my subscription on
rust-for-linux list).

Could you add a doc test for disable_sync(), I'm curious about it
because you may disable a work that has not be executed yet, and
wouldn't that be leaking memory (IIUC, we rely on Arc::drop() in
WorkItemPointer::run() to decrease the refcounts), but maybe I'm missing
something subtle.

Regards,
Boqun

> [1]: https://lore.kernel.org/all/20260416171728.205141-1-work@onurozkan.dev/
> 
> -Onur
> 
