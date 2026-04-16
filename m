Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9361F8809D
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 204C810E836;
	Thu, 16 Apr 2026 07:46:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="QXiz5Yck";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 420FE10E836;
 Thu, 16 Apr 2026 07:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776325531; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bO1dbh4u4TJr5GiXF4P4hBAZHfq/EXZg2BV37Gm86MMzAKegZ78iZVjIZyeDZKUc05wkBR6Hj+4GtXCQvUhpLFwfwxBk1PHQ41lOhhQeL6N4yBq+w415iNIYthtuDJFl5Y1ShvV+TBpflMQYFbo39sGZVrLGNsYs8PzoHi0y/q4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776325531;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=8drU7CaaWz2L3LoGRQR9uecRsIjtQNLF3eckn0OG+6o=; 
 b=J8bUYQOU9UGyeMS83O1nyGpk0gFLJiNpqJNfawt8wBII69v/5N8/wfdRmaYTYK5ZU3QnLmIBa0mieHDkWoHrLv4wtFZExS/xJDErvAaU3h6klOLS8f+2zrTELXWYf37Bxhr8l73pE98nRJt8Ob0HHBmXcj5yDqBQDwz4mts4mqA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776325531; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=8drU7CaaWz2L3LoGRQR9uecRsIjtQNLF3eckn0OG+6o=;
 b=QXiz5YckgV4wm1oRwiFD4AkTQFZjATMz4yluV7Amu6I88lofUwCDQymc8JB79Nuf
 gk3SpI7eF0lLcGybXkkm8DfO42UtEPqQN3L6wE/5D9clBm+HA0ESoL9nY9s5Juci4HC
 iuBJED13S6hqlGAYYpUjQr9s7jrqDcYCZngoFHjE=
Received: by mx.zohomail.com with SMTPS id 1776325529446210.397657818909;
 Thu, 16 Apr 2026 00:45:29 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Julian Orth <ju.orth@gmail.com>
Cc: Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
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
 Marius Vlad <marius.vlad@collabora.com>
Subject: Re: [PATCH RESEND v7 0/2] Pass down hot-plug CONNECTOR ID to
 user-space
Date: Thu, 16 Apr 2026 09:45:22 +0200
Message-ID: <7472926.DvuYhMxLoT@workhorse>
In-Reply-To: <CAHijbEXcrhB=ipaa4-DPD8atQYCkokGfueLafwkeQpxCBkc0bw@mail.gmail.com>
References: <20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com>
 <CAHijbEXcrhB=ipaa4-DPD8atQYCkokGfueLafwkeQpxCBkc0bw@mail.gmail.com>
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

On Wednesday, 15 April 2026 20:57:53 Central European Summer Time Julian Or=
th wrote:
> On Wed, Apr 15, 2026 at 8:19=E2=80=AFPM Nicolas Frattaroli
> <nicolas.frattaroli@collabora.com> wrote:
> >
> > I will be taking over this series from Marius Vlad.
> >
> > This series addresses a shortcoming whereby a hot plug event is sent
> > without it being passed the actual connector that caused it. This takes
> > into consideration both the polling path and the HPD (Hot Plug Detect)
> > path. It also adds support for the vkms driver (using ConfigFS) for
> > propagating the connector ID when changing the connector's status.
> >
> > The motivation is that user-space applications such as Weston would
> > previously receive non-connector-specific hotplug events, and then have
> > to figure out themselves which connector needs to have a modeset
> > executed on. This notably did not work when the hotplug events came in
> > too fast, resulting in Weston missing an on-off-on transition of a
> > connector, seeing that its state was unchanged from "on" so can't be the
> > one that was hotplugged, and skipping reinitialising it as it looks
> > through the other connectors that could've caused it.
>=20
> Have you considered adding a u64 serial number as a DRM connector
> property that is incremented every time the connector changes in some
> way? Userspace could then check this serial number to see if the
> connector has changed since the last time it queried the serial
> number.

The connector internally already has an epoch_counter member which
could be used for this. However, for the particular thing this
series fixes, I don't think exposing it through the uAPI is necessary
or desirable. Sending hotplug events specific to the connector does
not need any additional handling on the userspace side as long as it
already listens to the per-connector hotplug events in order to
avoid the pitfall described in the cover letter.

Kind regards,
Nicolas Frattaroli

> >
> > The real world implication is that on setups with slightly sketchy HDMI
> > connections, a brief flicker in the HPD signal could result in video
> > output bidding farewell entirely until a manual proper re-plug was
> > performed.
> >
> > By sending connector specific hotplug events, this ambiguity is
> > resolved without any change to the user-space API.
> >
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> > Changes in v7 RESEND:
> > - None, other than removing the leftover diffstat from the cover letter
> > - Link to v7: https://lore.kernel.org/r/20260217-hot-plug-passup-v7-0-f=
8221b2aab51@collabora.com
> >
> > Changes in v7:
> > - Drop the two vkms patches, as I don't want them to be blocked on
> >   review. I still think they're correct, but they're not essential and
> >   don't need to block this series.
> > - Link to v6: https://lore.kernel.org/r/20260123-hot-plug-passup-v6-0-a=
aaf61d960bb@collabora.com
> >
> > Changes in v6:
> > - Rewrote cover letter to explain the motivation for this series more
> >   plainly
> > - Rename "status_changed" to "pending_hp"
> > - Set "pending_hp" in the existing path that would also affect
> >   epoch_counter
> > - No longer set the boolean in drm_helper_probe_single_connector_modes,
> >   as it does not appear to be necessary
> > - Reword commits to better justify the changes
> > - Link to v5: https://lore.kernel.org/r/20251111162338.15141-1-marius.v=
lad@collabora.com/
> >
> > Changes in v5:
> > - vkms: add support for sending the CONNECTOR ID when hot-plugging thro=
ugh
> >   ConfigFS - as reported by Louis, vkms can now make use of ConfigFS to
> >   simulate connector status.
> > - vkms: add a small change to ignore previous/old drm connector status
> >   when sending out hot-plug uevent.
> > - Link to v4: https://lore.kernel.org/r/20251103174558.7709-1-marius.vl=
ad@collabora.com/
> >
> > Changes in v4:
> > - removed the "This patch" bit - Dmitry
> > - added a short note when the flag is set and cleared - Dmitry
> > - address double dead-locking detected - kbot: https://lore.kernel.org/=
dri-devel/202509251410.fdfbcac3-lkp@intel.com/
> > - virtual connectors do not seem have any kind of hotplug - added
> >   polling in vkms - as noted by Ian
> > - Link to v3: https://lore.kernel.org/r/20250923083636.4749-1-marius.vl=
ad@collabora.com/
> >
> > Changes in v3:
> > - Address comments from Dmitry:
> >   - guard connector status write with mode_config.mutex
> >   - avoid setting up the connector status and immediately unset it. Do =
the
> >     unset in drm_kms_helper_hotplug_event/drm_kms_helper_connector_hotp=
lug_event
> > - Link to v2: https://lore.kernel.org/r/20250729165708.9947-1-marius.vl=
ad@collabora.com/
> >
> > Changes in v2:
> > - Address comments from Daniel:
> >   - split patch into 2, one that introduces a bool to track connector
> >     connection status change and a patch that uses that to be able to s=
end
> >     hot plug events with the proper CONNECTOR ID to udev and further pa=
ss
> >     that down to user-space
> >   - nuke out mutex when iterating connector list
> >   - fix typo
> > - Link to v1: https://lore.kernel.org/r/20250627131751.2004-1-marius.vl=
ad@collabora.com/
> >
> > ---
> > Marius Vlad (2):
> >       drm: Introduce pending_hp to drm_connector
> >       drm: Send per-connector hotplug events
> >
> >  drivers/gpu/drm/drm_connector.c    |  1 +
> >  drivers/gpu/drm/drm_probe_helper.c | 39 ++++++++++++++++++++++++++++++=
+++-----
> >  drivers/gpu/drm/drm_sysfs.c        |  2 ++
> >  include/drm/drm_connector.h        |  3 +++
> >  4 files changed, 40 insertions(+), 5 deletions(-)
> > ---
> > base-commit: 4c59525db84aca677fd9f052e662912ad9d88448
> > change-id: 20260121-hot-plug-passup-f8ed03f7c202
> >
> > Best regards,
> > --
> > Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> >
>=20




