Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD12F43697
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 12:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E82710EA24;
	Fri, 17 Apr 2026 12:43:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="jLipx3+3";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 829FF10EA24;
 Fri, 17 Apr 2026 12:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776429765; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YWkTq8REn7C4hkCXtafPpQ9HmHVWT4g5rpsTVnKMqAYMktm40YBtuufsZGUxagO/4Ayd4YEfLmf0z05elJizozLW5ceNHtP2Y7nQHoAtvnsCLR718J6KSxi3r9Zf0M1fT5uq6Ma7DE1KJRqhJp0a7SX3jy5+UfxpaPtjm3krQmQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776429765;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1hvv0OAsjUPpDtYqqyqOXJ2Xp8BUZOKLIvuzK60DB1Y=; 
 b=eRrUJDLaaCF/bG848NNPR9n6mNUtohn0BfWzhI0e4XzYjzXqV4ZZh0ivDiH0mKRrj6gXIG2qYdQ4jIKP57O9YDJf6xByHg6fHT+uovjy82guJ7egqFUSC8j+CR5NwI52ZOUtfrzY6g1MJebE+j3h5MCQ+xlPoNeyIsaztg0ei2o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776429765; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=1hvv0OAsjUPpDtYqqyqOXJ2Xp8BUZOKLIvuzK60DB1Y=;
 b=jLipx3+3hOQvtgGhlxQ37TkBnuThJWq8KA3kiZUCvF7oMNK5nqqutL53C119b/2J
 taV4TR0hQJdC+X/Upmr37GnA8NyT9dxeEQoX0eoLnvgOOOgHDPuctzRm2YTuUxN5J3d
 KCvqssKy5YQ0C/PR5kOy+LC22htIA5SdVFPsP93I=
Received: by mx.zohomail.com with SMTPS id 1776429762492299.7476801113813;
 Fri, 17 Apr 2026 05:42:42 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>,
 Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Julian Orth <ju.orth@gmail.com>,
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
Date: Fri, 17 Apr 2026 14:42:36 +0200
Message-ID: <6501274.LvFx2qVVIh@workhorse>
In-Reply-To: <aeISNnh6IWGA7P8C@intel.com>
References: <20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com>
 <1297f150-b3b4-4a53-ad05-ecb05b8ec420@mailbox.org>
 <aeISNnh6IWGA7P8C@intel.com>
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

On Friday, 17 April 2026 12:57:58 Central European Summer Time Ville Syrj=
=C3=A4l=C3=A4 wrote:
> On Fri, Apr 17, 2026 at 09:49:36AM +0200, Michel D=C3=A4nzer wrote:
> > On 4/16/26 15:16, Julian Orth wrote:
> > > On Thu, Apr 16, 2026 at 9:46=E2=80=AFAM Nicolas Frattaroli
> > > <nicolas.frattaroli@collabora.com> wrote:
> > >> On Wednesday, 15 April 2026 20:57:53 Central European Summer Time Ju=
lian Orth wrote:
> > >>> On Wed, Apr 15, 2026 at 8:19=E2=80=AFPM Nicolas Frattaroli
> > >>> <nicolas.frattaroli@collabora.com> wrote:
> > >>>>
> > >>>> This series addresses a shortcoming whereby a hot plug event is se=
nt
> > >>>> without it being passed the actual connector that caused it. This =
takes
> > >>>> into consideration both the polling path and the HPD (Hot Plug Det=
ect)
> > >>>> path. It also adds support for the vkms driver (using ConfigFS) for
> > >>>> propagating the connector ID when changing the connector's status.
> > >>>>
> > >>>> The motivation is that user-space applications such as Weston would
> > >>>> previously receive non-connector-specific hotplug events, and then=
 have
> > >>>> to figure out themselves which connector needs to have a modeset
> > >>>> executed on. This notably did not work when the hotplug events cam=
e in
> > >>>> too fast, resulting in Weston missing an on-off-on transition of a
> > >>>> connector, seeing that its state was unchanged from "on" so can't =
be the
> > >>>> one that was hotplugged, and skipping reinitialising it as it looks
> > >>>> through the other connectors that could've caused it.
> > >>>
> > >>> Have you considered adding a u64 serial number as a DRM connector
> > >>> property that is incremented every time the connector changes in so=
me
> > >>> way? Userspace could then check this serial number to see if the
> > >>> connector has changed since the last time it queried the serial
> > >>> number.
> > >>
> > >> The connector internally already has an epoch_counter member which
> > >> could be used for this. However, for the particular thing this
> > >> series fixes, I don't think exposing it through the uAPI is necessary
> > >> or desirable. Sending hotplug events specific to the connector does
> > >> not need any additional handling on the userspace side as long as it
> > >> already listens to the per-connector hotplug events in order to
> > >> avoid the pitfall described in the cover letter.
> > >=20
> > > I currently do not handle per-connector hotplug events. Instead,
> > > whenever I get a UDEV change event for a device, I re-fetch the entire
> > > kernel state for the device. That is
> > >=20
> > > - DRM_IOCTL_MODE_GETRESOURCES
> > > - DRM_IOCTL_MODE_OBJ_GETPROPERTIES for each connector, crtc, plane
> > > - DRM_IOCTL_MODE_GETCONNECTOR for each connector
> > > - DRM_IOCTL_MODE_GETPROPERTY for each connector property
> > > - DRM_IOCTL_MODE_GETPROPBLOB for the EDID
> > >=20
> > > Once I have the new state, I compare it against the desired compositor
> > > state and perform a modeset if necessary.
> >=20
> > mutter is doing something similar as well.
> >=20
> >=20
> > Note that some are arguing a modeset is always required after a hotplug=
 event, even if the state hasn't changed.
> >=20
> > The most convincing argument I've seen is the scenario of a GPU reset, =
after which a modeset is required to light up the displays again.
>=20
> GPU reset should relight the display on its own really. That's what
> i915 does, albeit somewhat badly at the moment.
>=20
> > A hotplug event seems the only mechanism available for the kernel to re=
quest a modeset from the compositor. (The kernel may not be able to reliabl=
y do the modeset on its own, e.g. due to interactions with user-space atomi=
c commits)
>=20
> There's nothing preventing the kernel from doing extra atomic
> commits whenever it wants. But if you want to punt the thing to
> userspace then the kernel must set the link-status property to
> bad, and then fire the hotplug uevent.
>=20
> > If this "modeset required after hotplug event" rule is confirmed, it me=
ans that after a hotplug event without connector ID, the compositor must do=
 a modeset for all connectors.
>=20
> Only for connectors where things changed, or the link-status shows bad.
>=20
> >=20
> >=20
> > P.S. https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/14420#=
note_2984697 even argued that two modesets are required after a hotplug eve=
nt, one which turns things off and another one which turns them on again. I=
 don't agree with that though, a single modeset should suffice.
>=20
> The actual argument is that you should not defer the hotplug
> handling when things get disconnected, mainly because of crap type-c
> firmware.
>=20
> I think the userspace behaviour there was that you get a disconnected,
> defer processing it, and then you get a reconnect, and then decide that
> nothing actually changed and a modeset is not needed after all. That is
> not correct IMO. Clearly a ->disconnect->reconnect should count as a
> change in the connector's state, and a full modeset is thus required.
> The kernel can of course then decide that the full modeset is not
> actually required and skip the modeset part during the commit. But
> userspace cannot make that determination.

So just to loop around to the patches here: is sending per-connector
hotplug events not acceptable? Your review[1] on v5 indicated you had
a problem with the implementation, not a fundamental issue with the
behaviour the patch tried to change.

> I suppose what we could maybe do there to force userspace's hand is set
> the link-status to bad already when the thing gets disconnected, and keep
> it like that until a full disable+re-enable cycle has been done. Then
> userspace could not think that the ->disconnect->reconnect is a NOP
> (which I still think is incorrect behaviour).

The documentation of drm_connector_set_link_status_property explicitly
states:

    * Note: Drivers cannot rely on userspace to support this property and
    * issue a modeset. As such, they may choose to handle issues (like
    * re-training a link) without userspace's intervention.

which I think conflicts with your suggestion.

Kind regards,
Nicolas Frattaroli

https://lore.kernel.org/dri-devel/aROKwmZxFt52g4ed@intel.com/ [1]



