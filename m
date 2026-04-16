Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8260BF8A177
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 13:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D27DB10E8AD;
	Thu, 16 Apr 2026 13:35:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=marius.vlad@collabora.com header.b="M+ZRd2au";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89E0C10E8AD;
 Thu, 16 Apr 2026 13:35:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776346509; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nC1fzDElmOSeknz0mHi3Tj+kTSdnTq5J6J3Lj+kXdCHb8kddNfbJyXhlCrtzqKkOerI/wAZlw9gdInYUCeORaHFRBhvtVRM4EoPaf+OER066OXbuMiLtESc0MWr3OEODs4eiFoibvmnIj4SH38UuMbJHKU6LZIc/bT5d0kBytIU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776346509;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=JRwsZqiGrkrPfHGVAd9I6AQ2qPu4nYXsKDR0qYhfIDw=; 
 b=J2blvi9+Z14KW4utxFNs18qOkOGutwX/RXrKF9F1dzOSCAxMfV6henpff1hOwO+p4Wre9Pq1yYjSgZQp1CHUdD3Qrlh3CjmzYF+mbCYdF+dK6LnUfUw2EwkblBSr98wsajhfxvHHeL5HRjnEEXCQFnTSWebijpklCmB9hOsaTA0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=marius.vlad@collabora.com;
 dmarc=pass header.from=<marius.vlad@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776346509; 
 s=zohomail; d=collabora.com; i=marius.vlad@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=JRwsZqiGrkrPfHGVAd9I6AQ2qPu4nYXsKDR0qYhfIDw=;
 b=M+ZRd2aufQ/eco/YAH8cIK1xIxktbgjtqSCFP2CucNTDUNkrKhPitxK1CgWL/G8T
 BYNSydGLuzjYhTFfJ3IoYzig0gcZVtHrnIjDmxfU41ZQYIw/y+wocDbmBDOuON9ANXO
 tYy7YitThx0PxC7RSAY2EX7YtDw4+4gGt1GCdIbU=
Received: by mx.zohomail.com with SMTPS id 1776346507604492.97438483168105;
 Thu, 16 Apr 2026 06:35:07 -0700 (PDT)
Date: Thu, 16 Apr 2026 16:35:00 +0300
From: Marius Vlad <marius.vlad@collabora.com>
To: Julian Orth <ju.orth@gmail.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Daniel Stone <daniel.stone@collabora.com>,
 Ian Forbes <ian.forbes@broadcom.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH RESEND v7 0/2] Pass down hot-plug CONNECTOR ID to
 user-space
Message-ID: <aeDlhJjzS8sxumNn@xpredator>
References: <20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com>
 <CAHijbEXcrhB=ipaa4-DPD8atQYCkokGfueLafwkeQpxCBkc0bw@mail.gmail.com>
 <7472926.DvuYhMxLoT@workhorse>
 <CAHijbEViae+=Fcnh3v0ODxwTPUaRgU1H4OVGM3VFPSLMPzJzOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lXiFNBDVU8/eg6mM"
Content-Disposition: inline
In-Reply-To: <CAHijbEViae+=Fcnh3v0ODxwTPUaRgU1H4OVGM3VFPSLMPzJzOA@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.2.1.5.2/276.323.67
X-ZohoMailClient: External
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


--lXiFNBDVU8/eg6mM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 03:16:39PM +0200, Julian Orth wrote:
> On Thu, Apr 16, 2026 at 9:46=E2=80=AFAM Nicolas Frattaroli
> <nicolas.frattaroli@collabora.com> wrote:
> >
> > On Wednesday, 15 April 2026 20:57:53 Central European Summer Time Julia=
n Orth wrote:
> > > On Wed, Apr 15, 2026 at 8:19=E2=80=AFPM Nicolas Frattaroli
> > > <nicolas.frattaroli@collabora.com> wrote:
> > > >
> > > > I will be taking over this series from Marius Vlad.
> > > >
> > > > This series addresses a shortcoming whereby a hot plug event is sent
> > > > without it being passed the actual connector that caused it. This t=
akes
> > > > into consideration both the polling path and the HPD (Hot Plug Dete=
ct)
> > > > path. It also adds support for the vkms driver (using ConfigFS) for
> > > > propagating the connector ID when changing the connector's status.
> > > >
> > > > The motivation is that user-space applications such as Weston would
> > > > previously receive non-connector-specific hotplug events, and then =
have
> > > > to figure out themselves which connector needs to have a modeset
> > > > executed on. This notably did not work when the hotplug events came=
 in
> > > > too fast, resulting in Weston missing an on-off-on transition of a
> > > > connector, seeing that its state was unchanged from "on" so can't b=
e the
> > > > one that was hotplugged, and skipping reinitialising it as it looks
> > > > through the other connectors that could've caused it.
> > >
> > > Have you considered adding a u64 serial number as a DRM connector
> > > property that is incremented every time the connector changes in some
> > > way? Userspace could then check this serial number to see if the
> > > connector has changed since the last time it queried the serial
> > > number.
> >
> > The connector internally already has an epoch_counter member which
> > could be used for this. However, for the particular thing this
> > series fixes, I don't think exposing it through the uAPI is necessary
> > or desirable. Sending hotplug events specific to the connector does
> > not need any additional handling on the userspace side as long as it
> > already listens to the per-connector hotplug events in order to
> > avoid the pitfall described in the cover letter.
>=20
> I currently do not handle per-connector hotplug events. Instead,
> whenever I get a UDEV change event for a device, I re-fetch the entire
> kernel state for the device. That is
>=20
> - DRM_IOCTL_MODE_GETRESOURCES
> - DRM_IOCTL_MODE_OBJ_GETPROPERTIES for each connector, crtc, plane
With this change you wouldn't need to go over all of them as the kernel
will supply the connector ID that has changed.
> - DRM_IOCTL_MODE_GETCONNECTOR for each connector
> - DRM_IOCTL_MODE_GETPROPERTY for each connector property
> - DRM_IOCTL_MODE_GETPROPBLOB for the EDID
>=20
> Once I have the new state, I compare it against the desired compositor
> state and perform a modeset if necessary.
>=20
> This makes it robust against the situation you're describing, but also
> means that a lot of work is done for unchanged objects. If the change
> makes a modeset necessary, then that work is almost negligible
> compared to the time the modeset takes.
>=20
> I don't know if your patches will cause more change events to be sent
> or if they will just add the connector property to existing events. If
> there are additional events, then I'd prefer to have an early out for
> some of this work. E.g. by having access to the epoch_counter.
>=20
> >
> > Kind regards,
> > Nicolas Frattaroli
> >
> > > >
> > > > The real world implication is that on setups with slightly sketchy =
HDMI
> > > > connections, a brief flicker in the HPD signal could result in video
> > > > output bidding farewell entirely until a manual proper re-plug was
> > > > performed.
> > > >
> > > > By sending connector specific hotplug events, this ambiguity is
> > > > resolved without any change to the user-space API.
> > > >
> > > > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > > > ---
> > > > Changes in v7 RESEND:
> > > > - None, other than removing the leftover diffstat from the cover le=
tter
> > > > - Link to v7: https://lore.kernel.org/r/20260217-hot-plug-passup-v7=
-0-f8221b2aab51@collabora.com
> > > >
> > > > Changes in v7:
> > > > - Drop the two vkms patches, as I don't want them to be blocked on
> > > >   review. I still think they're correct, but they're not essential =
and
> > > >   don't need to block this series.
> > > > - Link to v6: https://lore.kernel.org/r/20260123-hot-plug-passup-v6=
-0-aaaf61d960bb@collabora.com
> > > >
> > > > Changes in v6:
> > > > - Rewrote cover letter to explain the motivation for this series mo=
re
> > > >   plainly
> > > > - Rename "status_changed" to "pending_hp"
> > > > - Set "pending_hp" in the existing path that would also affect
> > > >   epoch_counter
> > > > - No longer set the boolean in drm_helper_probe_single_connector_mo=
des,
> > > >   as it does not appear to be necessary
> > > > - Reword commits to better justify the changes
> > > > - Link to v5: https://lore.kernel.org/r/20251111162338.15141-1-mari=
us.vlad@collabora.com/
> > > >
> > > > Changes in v5:
> > > > - vkms: add support for sending the CONNECTOR ID when hot-plugging =
through
> > > >   ConfigFS - as reported by Louis, vkms can now make use of ConfigF=
S to
> > > >   simulate connector status.
> > > > - vkms: add a small change to ignore previous/old drm connector sta=
tus
> > > >   when sending out hot-plug uevent.
> > > > - Link to v4: https://lore.kernel.org/r/20251103174558.7709-1-mariu=
s.vlad@collabora.com/
> > > >
> > > > Changes in v4:
> > > > - removed the "This patch" bit - Dmitry
> > > > - added a short note when the flag is set and cleared - Dmitry
> > > > - address double dead-locking detected - kbot: https://lore.kernel.=
org/dri-devel/202509251410.fdfbcac3-lkp@intel.com/
> > > > - virtual connectors do not seem have any kind of hotplug - added
> > > >   polling in vkms - as noted by Ian
> > > > - Link to v3: https://lore.kernel.org/r/20250923083636.4749-1-mariu=
s.vlad@collabora.com/
> > > >
> > > > Changes in v3:
> > > > - Address comments from Dmitry:
> > > >   - guard connector status write with mode_config.mutex
> > > >   - avoid setting up the connector status and immediately unset it.=
 Do the
> > > >     unset in drm_kms_helper_hotplug_event/drm_kms_helper_connector_=
hotplug_event
> > > > - Link to v2: https://lore.kernel.org/r/20250729165708.9947-1-mariu=
s.vlad@collabora.com/
> > > >
> > > > Changes in v2:
> > > > - Address comments from Daniel:
> > > >   - split patch into 2, one that introduces a bool to track connect=
or
> > > >     connection status change and a patch that uses that to be able =
to send
> > > >     hot plug events with the proper CONNECTOR ID to udev and furthe=
r pass
> > > >     that down to user-space
> > > >   - nuke out mutex when iterating connector list
> > > >   - fix typo
> > > > - Link to v1: https://lore.kernel.org/r/20250627131751.2004-1-mariu=
s.vlad@collabora.com/
> > > >
> > > > ---
> > > > Marius Vlad (2):
> > > >       drm: Introduce pending_hp to drm_connector
> > > >       drm: Send per-connector hotplug events
> > > >
> > > >  drivers/gpu/drm/drm_connector.c    |  1 +
> > > >  drivers/gpu/drm/drm_probe_helper.c | 39 ++++++++++++++++++++++++++=
+++++++-----
> > > >  drivers/gpu/drm/drm_sysfs.c        |  2 ++
> > > >  include/drm/drm_connector.h        |  3 +++
> > > >  4 files changed, 40 insertions(+), 5 deletions(-)
> > > > ---
> > > > base-commit: 4c59525db84aca677fd9f052e662912ad9d88448
> > > > change-id: 20260121-hot-plug-passup-f8ed03f7c202
> > > >
> > > > Best regards,
> > > > --
> > > > Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > > >
> > >
> >
> >
> >
> >

--lXiFNBDVU8/eg6mM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEcDKHej6x6uPk3J379jQS5glH1u8FAmng5XgACgkQ9jQS5glH
1u+Dyg/9Gz0VRZmFBNVNjdWk8SvnIzXNu/aUL2J/lm6Mq3ZzzTeSL+SLpkPUlzmm
4CMqaPUwqviCQ+wlE1C/9y+Bq0xZnxUazGIL9KSnv853A5ayjM5CnBIcnA3BMaQm
Wk0g8yLgwsjdf+NLNe05kOc5OqeWKLSzr3B0mzNDdpsc82+bycVWMBzcaPYsGDFU
3PLZFF3jLZ6XqXSkSZRGkNw7D7B5ALKm+So9eY6Y4c+ikL4xHOHSEz9ZGqRIIW6S
YrN8PJdmukhPwdl40X27WhV9nnoTUQBlJpMW7GRJ3QoUEhCv8njsXm3WM6G/R82A
Nh7sfNOtnuhJg23niMIi7Lwea4tVVx2Rd8QAZIKx5AUNDkT2Cp4lK2WSXNuLIw7D
DBH3ST0xAPjeiFBhV4lidYosTUVLJ4KdzJSF6ycEdvGQnNX7qAzdptvhq2YoWMyd
YsZn4P1neL8JreAuqF9bOZY/VvgjZ6OMJQsd0PY83nJ9jZaS9V4luTo+3jr7raeE
HUnBjI+yGBa6PhJWSF/UG0V8rD+EWAnc+G0IEvjL6pmt095ehiqfXNjf+dpbFgK+
FK+ys2JhCBtplEtkA+me4K2B3GeciHpJzha2o5v/cD2pJqnC6xa/GTYteT80VGm5
jzpXDDdIYVccPBeiAFRWX04Po/KDDqYDLH+5Cyr4OTLfvfjaDV0=
=vDxj
-----END PGP SIGNATURE-----

--lXiFNBDVU8/eg6mM--
