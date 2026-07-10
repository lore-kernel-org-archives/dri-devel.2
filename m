Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83561C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 08:10:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEAD910F805;
	Fri, 10 Jul 2026 08:10:36 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 651F410F805
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 08:10:35 +0000 (UTC)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[IPv6:::1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <l.stach@pengutronix.de>)
 id 1wi6JR-0005QS-ED; Fri, 10 Jul 2026 10:10:21 +0200
Message-ID: <26876decb5bcf4df8bb01abe47f9e70a4e5d63ef.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] drm/etnaviv: Add GPU reset counters
From: Lucas Stach <l.stach@pengutronix.de>
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Russell King <linux+etnaviv@armlinux.org.uk>, David Airlie	
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, etnaviv@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, 	linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, Christian Gmeiner	 <cgmeiner@igalia.com>
Date: Fri, 10 Jul 2026 10:10:20 +0200
In-Reply-To: <CAH9NwWe9gDjg-6_e1KHdUQ8_Pi2sjhfDizZGzWavQAnnuymQ2g@mail.gmail.com>
References: <20260709-etnaviv-reset-notification-v1-0-64c617496958@igalia.com>
 <20260709-etnaviv-reset-notification-v1-2-64c617496958@igalia.com>
 <bb5b8c8ff15f8d8b9ad9a61e4887c14b9f77f3d6.camel@pengutronix.de>
 <CAH9NwWe9gDjg-6_e1KHdUQ8_Pi2sjhfDizZGzWavQAnnuymQ2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: dri-devel@lists.freedesktop.org
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

Am Donnerstag, dem 09.07.2026 um 21:41 +0200 schrieb Christian Gmeiner:
> Hi Lucas,
>=20
> > > The OpenGL and Vulkan robustness extensions let an application detect=
 a
> > > GPU reset and check if its own context caused it, so the application =
can
> > > drop the broken context and build a new one. The kernel knows both
> > > facts, but etnaviv has no way to report them to userspace.
> > >=20
> > > Add two counters and expose them through GET_PARAM: a per-GPU counter
> > > that counts every reset of that GPU, and a per-context counter that o=
nly
> > > counts the resets this context was guilty of. Userspace compares the
> > > counters with saved values: if the context counter moved the context =
was
> > > guilty, if only the GPU counter moved the context was an innocent
> > > victim.
> >=20
> > I don't really agree with the design of exposing this through
> > GET_PARAM.
> >=20
> >=20
> > First it assumes that each etnaviv_file_private can only have a single
> > context, something that is true today but which I would very much like
> > to change to rid of false dependencies when the application uses
> > multiple GL contexts through the same screen. I have a rework to do
> > this in the pipe, which I didn't get around to finish, yet. While I
> > don't want to block any of your work on this rework, I also wouldn't
> > like to see UAPI land which bakes in the single context per file
> > private assumption.
> >=20
>=20
> Makes sense. I only picked it because msm and v3d expose their fault
> counters that way.
>=20
> For v2 I have replaced the two params with a dedicated ioctl:
>=20
> struct drm_etnaviv_reset_query {
>     __u32 pipe;            /* in */
>     __u32 flags;            /* in, must be 0 */
>     __u64 global_reset_counter;    /* out */
>     __u64 context_reset_counter;    /* out */
> };
>=20
> flags must be zero for now and is rejected with EINVAL otherwise, so
> your multi context rework can later add a flag plus a context field to
> query a specific context.
>=20
Looks good to me.

> >=20
> > Second, with this design each userspace query incurs two roundtrips
> > into the kernel, as userspace needs to know both counter values to tell
> > innocent vs guilty resets apart.
> >=20
> > My vote would be on adding a new ioctl to query both reset counters at
> > the same time, with a flags argument baked in, so it can be extended
> > once I manage to finish the multi context rework.
> >=20
>=20
> One thing to note: the global counter is per GPU core, so a context
> that uses more than one pipe still needs one query per pipe. I think
> that is fine for the robustness use case, but tell me if you would
> rather have a variant that returns all pipes at once.

I think the current design is fine. While there might be some
configurations where a context uses multiple pipes (2D GPU texture
upload or one of those chips with multiple 3D GPUs), I think that those
are sufficiently rare that we might want to deal with the additional
kernel transitions for those rather than complicating the ioctl for the
common case of a context using a single pipe.

Regards,
Lucas
