Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3323F436B4
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 15:00:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14EA910EA4F;
	Fri, 17 Apr 2026 15:00:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Xfe6b/Kf";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12F4610EA4D;
 Fri, 17 Apr 2026 15:00:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776438018; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HZYqzEo/B04pD7VNu7K3nqPbqWxthsxmsKdSJbOtjwQm87gOZn11KVKfFY4ihxAL3VU+YkQw6967OCfWCsS0TP9Whhbj3v766NNfDvH4SQkXAn9ZM4/1DK0Kfm/6SIuXttWLbtpYjW3QnL9A5UfqTPhSy+9QB9ZkDSpK0Z6kj8I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776438018;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=u5WtyRsiIihxw2oSc8xeFSTKHQxxaaLCpm8Rhts4FMI=; 
 b=iyBOCp9wKBDcKnZtItJ5vax92FHFPk5BvZlcAEBlbNT9QpKKGf2QdaWuELW+j/F6+QJKawLmobP0Tn8kknGyrBG73L7ZAPJwJxxVQMeVcvUHxbfy1r1Ww/b3iRQKnq9kOEEsydVv0wd0HK3x59W1ZZpVElnE3Gw1N5/1WQGwBug=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776438018; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=u5WtyRsiIihxw2oSc8xeFSTKHQxxaaLCpm8Rhts4FMI=;
 b=Xfe6b/Kf9jTf9VMg+JcZ6gmVYo4UtOSTpBV5DQAIzf4m1pjYPhWuIYEi5ibgmQVQ
 PktGIpyvDSPtuUDDihVb7BwmRUV2SpBSPAsA+tV4cLC44hc/SmuQa14xKhnBwSbdLjX
 d0G3MkrdgaM+OlSz9f5MiY4izH+q5yuH9HpiRcvU=
Received: by mx.zohomail.com with SMTPS id 177643801657417.550012720170912;
 Fri, 17 Apr 2026 08:00:16 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>,
 Julian Orth <ju.orth@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Daniel Stone <daniel.stone@collabora.com>,
 Ian Forbes <ian.forbes@broadcom.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, wayland-devel@lists.freedesktop.org,
 Marius Vlad <marius.vlad@collabora.com>, Imre Deak <imre.deak@intel.com>
Subject: Re: [PATCH RESEND v7 0/2] Pass down hot-plug CONNECTOR ID to
 user-space
Date: Fri, 17 Apr 2026 17:00:10 +0200
Message-ID: <5186396.44csPzL39Z@workhorse>
In-Reply-To: <aeJAofA04bOuxlGA@intel.com>
References: <20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com>
 <6501274.LvFx2qVVIh@workhorse> <aeJAofA04bOuxlGA@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Friday, 17 April 2026 16:16:01 Central European Summer Time Ville Syrj=
=C3=A4l=C3=A4 wrote:
> On Fri, Apr 17, 2026 at 02:42:36PM +0200, Nicolas Frattaroli wrote:
> > On Friday, 17 April 2026 12:57:58 Central European Summer Time Ville Sy=
rj=C3=A4l=C3=A4 wrote:
> > > On Fri, Apr 17, 2026 at 09:49:36AM +0200, Michel D=C3=A4nzer wrote:
> > > > On 4/16/26 15:16, Julian Orth wrote:
> > > > > On Thu, Apr 16, 2026 at 9:46=E2=80=AFAM Nicolas Frattaroli
> > > > > <nicolas.frattaroli@collabora.com> wrote:
> > > > >> On Wednesday, 15 April 2026 20:57:53 Central European Summer Tim=
e Julian Orth wrote:
> > > > >>> On Wed, Apr 15, 2026 at 8:19=E2=80=AFPM Nicolas Frattaroli
> > > > >>> <nicolas.frattaroli@collabora.com> wrote:
> > > > >>>>
> > > > >>>> This series addresses a shortcoming whereby a hot plug event i=
s sent
> > > > >>>> without it being passed the actual connector that caused it. T=
his takes
> > > > >>>> into consideration both the polling path and the HPD (Hot Plug=
 Detect)
> > > > >>>> path. It also adds support for the vkms driver (using ConfigFS=
) for
> > > > >>>> propagating the connector ID when changing the connector's sta=
tus.
> > > > >>>>
> > > > >>>> The motivation is that user-space applications such as Weston =
would
> > > > >>>> previously receive non-connector-specific hotplug events, and =
then have
> > > > >>>> to figure out themselves which connector needs to have a modes=
et
> > > > >>>> executed on. This notably did not work when the hotplug events=
 came in
> > > > >>>> too fast, resulting in Weston missing an on-off-on transition =
of a
> > > > >>>> connector, seeing that its state was unchanged from "on" so ca=
n't be the
> > > > >>>> one that was hotplugged, and skipping reinitialising it as it =
looks
> > > > >>>> through the other connectors that could've caused it.
> > > > >>>
> > > > >>> Have you considered adding a u64 serial number as a DRM connect=
or
> > > > >>> property that is incremented every time the connector changes i=
n some
> > > > >>> way? Userspace could then check this serial number to see if the
> > > > >>> connector has changed since the last time it queried the serial
> > > > >>> number.
> > > > >>
> > > > >> The connector internally already has an epoch_counter member whi=
ch
> > > > >> could be used for this. However, for the particular thing this
> > > > >> series fixes, I don't think exposing it through the uAPI is nece=
ssary
> > > > >> or desirable. Sending hotplug events specific to the connector d=
oes
> > > > >> not need any additional handling on the userspace side as long a=
s it
> > > > >> already listens to the per-connector hotplug events in order to
> > > > >> avoid the pitfall described in the cover letter.
> > > > >=20
> > > > > I currently do not handle per-connector hotplug events. Instead,
> > > > > whenever I get a UDEV change event for a device, I re-fetch the e=
ntire
> > > > > kernel state for the device. That is
> > > > >=20
> > > > > - DRM_IOCTL_MODE_GETRESOURCES
> > > > > - DRM_IOCTL_MODE_OBJ_GETPROPERTIES for each connector, crtc, plane
> > > > > - DRM_IOCTL_MODE_GETCONNECTOR for each connector
> > > > > - DRM_IOCTL_MODE_GETPROPERTY for each connector property
> > > > > - DRM_IOCTL_MODE_GETPROPBLOB for the EDID
> > > > >=20
> > > > > Once I have the new state, I compare it against the desired compo=
sitor
> > > > > state and perform a modeset if necessary.
> > > >=20
> > > > mutter is doing something similar as well.
> > > >=20
> > > >=20
> > > > Note that some are arguing a modeset is always required after a hot=
plug event, even if the state hasn't changed.
> > > >=20
> > > > The most convincing argument I've seen is the scenario of a GPU res=
et, after which a modeset is required to light up the displays again.
> > >=20
> > > GPU reset should relight the display on its own really. That's what
> > > i915 does, albeit somewhat badly at the moment.
> > >=20
> > > > A hotplug event seems the only mechanism available for the kernel t=
o request a modeset from the compositor. (The kernel may not be able to rel=
iably do the modeset on its own, e.g. due to interactions with user-space a=
tomic commits)
> > >=20
> > > There's nothing preventing the kernel from doing extra atomic
> > > commits whenever it wants. But if you want to punt the thing to
> > > userspace then the kernel must set the link-status property to
> > > bad, and then fire the hotplug uevent.
> > >=20
> > > > If this "modeset required after hotplug event" rule is confirmed, i=
t means that after a hotplug event without connector ID, the compositor mus=
t do a modeset for all connectors.
> > >=20
> > > Only for connectors where things changed, or the link-status shows ba=
d.
> > >=20
> > > >=20
> > > >=20
> > > > P.S. https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/14=
420#note_2984697 even argued that two modesets are required after a hotplug=
 event, one which turns things off and another one which turns them on agai=
n. I don't agree with that though, a single modeset should suffice.
> > >=20
> > > The actual argument is that you should not defer the hotplug
> > > handling when things get disconnected, mainly because of crap type-c
> > > firmware.
> > >=20
> > > I think the userspace behaviour there was that you get a disconnected,
> > > defer processing it, and then you get a reconnect, and then decide th=
at
> > > nothing actually changed and a modeset is not needed after all. That =
is
> > > not correct IMO. Clearly a ->disconnect->reconnect should count as a
> > > change in the connector's state, and a full modeset is thus required.
> > > The kernel can of course then decide that the full modeset is not
> > > actually required and skip the modeset part during the commit. But
> > > userspace cannot make that determination.
> >=20
> > So just to loop around to the patches here: is sending per-connector
> > hotplug events not acceptable? Your review[1] on v5 indicated you had
> > a problem with the implementation, not a fundamental issue with the
> > behaviour the patch tried to change.
>=20
> What I was saying is that we already have the epoch_counter. If
> there are gaps in the implementation then those should just be
> fixed. We don't want a second implementation of the same
> mechanism.

epoch_counter is explicitly documented as "used to detect any other changes
in connector, besides status". pending_hp is changed if the status changes.

If we use epoch_counter for this, I think we'll need to keep track of the
last epoch_counter an hpd was sent for each connector, so we wouldn't win
anything in reduced state being tracked.

> >=20
> > > I suppose what we could maybe do there to force userspace's hand is s=
et
> > > the link-status to bad already when the thing gets disconnected, and =
keep
> > > it like that until a full disable+re-enable cycle has been done. Then
> > > userspace could not think that the ->disconnect->reconnect is a NOP
> > > (which I still think is incorrect behaviour).
> >=20
> > The documentation of drm_connector_set_link_status_property explicitly
> > states:
> >=20
> >     * Note: Drivers cannot rely on userspace to support this property a=
nd
> >     * issue a modeset. As such, they may choose to handle issues (like
> >     * re-training a link) without userspace's intervention.
> >=20
> > which I think conflicts with your suggestion.
>=20
> In i915 we do the retraining in kernel. IIRC we only really use the bad
> link stuff once retraining has failed hard enough that userspace
> intervention is needed, ie. when we cannot reduce the link parameters
> anymore without userspace selecting a mode with a lower resolution.
>=20
> I think some more recent drivers may have opted to forego all in kernel
> retraining and just punt it all to userspace. I think the link-status
> property has existed for long enough that any userspace that doesn't
> support it could simply be considered broken.

Is breaking userspace a better choice than sending per-connector hotplug
events rather than a single global hotplug event? I get where you're
coming from, in that userspace should not be trying to optimise away
modesets, as that's something the kernel can do in a race-free way. I'm
just not familiar enough with the landscape to know whether setting
link-status to bad will actually result in userspace doing a modeset,
and whether drivers in practice then optimise that modeset away if it
wasn't needed.

> Actually I know of a single "userspace" that to my knowledge doesn't
> implement the link-status stuff, and that is the in kernel fb helper.
> That should probably be remedied...

Kind regards,
Nicolas Frattaroli


