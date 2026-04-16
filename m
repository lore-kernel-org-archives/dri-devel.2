Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3906DF8E4B6
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 07:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E52E10E971;
	Fri, 17 Apr 2026 07:06:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tHgRyKnn";
	dkim-atps=neutral
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com
 [74.125.224.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C373010E1B1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 13:56:05 +0000 (UTC)
Received: by mail-yx1-f48.google.com with SMTP id
 956f58d0204a3-649278a69c5so6680997d50.3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 06:56:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776347765; cv=none;
 d=google.com; s=arc-20240605;
 b=acSCei5VZWqBFT+9QZ6USMW9q6vbQ3673yZKOe3DHSoE1lSarFnLOoMR5waBMYzrZ5
 swBzilMdqvox/VdY0sI6tYEZyMcAcve0OR/H9S6cOs910VrNEyh5Rl7ShVMtoA5+8JFE
 PkC+M7AYkAUm+RmzLTXtmEejadZM5nSp2qU5ZQf8GunoCrbphz3WLP/RS85Jm1ustne7
 UGFN+eAuELiwTlCCn8UeBaGv4u5Py6jG9Vn1qSWLpmOU1Lxy5yMShyxajCDTwa3+ShXv
 NrrACWOAN7tMLpIpiTE2PGjLPcAJUOlN8aAFVcZRdOCCcxMHhGYH4vJX+WaruESTBw64
 rwHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hIS9QMPOToMHZsYs73H8+f6epXXLKYHKMoQnGiHqC0I=;
 fh=0CJfZAHnD0mZDyk+vUyPKrIeiVxlvZZv6+3wLgAHMdQ=;
 b=U/smFmUJy8mrTmHRR6HRcCIydePzx14BKwZBWfOhBkPm6qDo+GbQzif0R/O6a/MKpt
 qkJ+3Q3g0EGVR9H8iaJaKvvi0udIPxwMjfr8la+0souabbFdin408vZVeIl/jYgKzlf5
 F/Hta10cw3RHYNdiZOjr4TOrMZeMzh7At0AfLt5x5YrDMRNavL16jBn0KAKsaTy7biHi
 D5pn54vJyyrc5OUfG5Uakn+oXCzE0dHx2Hr50llPBj9LBsmViUWW0/tBK0/T8Tga5FOX
 BE281GrARN64IMr0GPYI/iRQN9st9SPHAuaD2hWcFfUldvK3Meg4dX3Q2Ej3OStGY1JF
 +0zA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776347765; x=1776952565; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hIS9QMPOToMHZsYs73H8+f6epXXLKYHKMoQnGiHqC0I=;
 b=tHgRyKnnSBjU2E+7v04k8BUVhWbtIXPsAqDyEo0jOuJzs1hQn4w/o51ru5s+sfTvGG
 aTHVEwHY2ZXRBGUUclLSI0w7wIZMYlJeUTghnF2qpPxnyDg0DmkCFO0QOXc61N5AoXLr
 WyeGVDiIvj/EYCN0bzMnAkcV5etc/++4vVVT1hfjemU+kfEih54GW6JlOGa4MPqIZfaX
 xrl5YMqQsOSsxdJaouKoS3/5PKBEFoPAmZqFvSIaVW67f4+lcZkJzhGSS31i0bhDodAq
 l4ZOOec3SzRDBfmw/1DmLykgBQsD4pENN6HyQjGoWpu5WwM9XVefSFLkJ6OZtroQJzGQ
 WzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776347765; x=1776952565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hIS9QMPOToMHZsYs73H8+f6epXXLKYHKMoQnGiHqC0I=;
 b=ojFZwkCYzT8Kkvv4RlSWVJ6rATsOIdJ3tnuX+QzEuDhMNC3CBr2i67/1qWCv+Qnvoe
 p6BD6H4L8wp/CpJcXo8717+j6j/9JxSfgGsjYjtuEnlZGc0BtHcTddDCloLJzg0bRdf9
 gekzMVD4zSg1qcddu9Y2KYKV8dlWVsADPc3Cdrpu6cqv0mtpjdjC94xy4dVkpK9TXY/c
 ourPJYYQqq1SljvQlLkFsag4OSAD0v8nTiazbR7jgRYe+wYekUXJ3yMEYzJm/DDNFm5r
 m0h+Egs3zbwDQhrlLDybAKPX0LZx7ZZNfE3KNie5wCheUE5wZ9fRQKM69RikFCkM8WG4
 EBmA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FF1FCMjkEMGxSPmyyDNVi7ZG9icriEebgk1Q5DSysi3C5FwmguF3+Ypc0Mv8DtXtXDKMnSGUlSOc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxXQz9BcPlKh5mukGKD6/Ny4pjaArNEqK54kNsYVDRkHmVALHiR
 JF+tpZOmgpY/YfTqBNXM/2POBotmnaJJqGi0KWtXWXiZDgQaz0Bdxd30wbMTx2FM/hlDSx8Ollr
 WZfYNcU75i0FJV0AJGRp2oeL7csf9EMQ=
X-Gm-Gg: AeBDieshN9u9s6CQqXPHAVvSvrjEgdiPsCkty3Kl48qA2AFejsV9Wn5XIaMjH1bcqte
 8bhaOE8hB398yMQECpHYFyRRNGFag0ZWK5Hf8rWwj/+SA/TS7gyJVYQRIMWezaoiWNcHNTvwPP9
 iLUwPZUrSJP/SQNLgNzvtiFhN63XdsaiVongG0Z0k7fiqxogEGEl7u/Hf78GkS8fOWKY5Ew2hsA
 /ecj8d7WAb8QeCrFLt/wicMntN25Zo8yHQXEaKq1F8ikZixkOlxRejRy2jWQoewB3hWRUVUWzJb
 UyCqVP+fp0y2lnIUJJi312qDdTreFs8hsluy6+vI7kFZYlMPGeAUJdtgvHI=
X-Received: by 2002:a05:690e:190c:b0:652:55ec:6a1a with SMTP id
 956f58d0204a3-65255ec7219mr9726274d50.60.1776347764438; Thu, 16 Apr 2026
 06:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com>
 <CAHijbEXcrhB=ipaa4-DPD8atQYCkokGfueLafwkeQpxCBkc0bw@mail.gmail.com>
 <7472926.DvuYhMxLoT@workhorse>
 <CAHijbEViae+=Fcnh3v0ODxwTPUaRgU1H4OVGM3VFPSLMPzJzOA@mail.gmail.com>
 <aeDlhJjzS8sxumNn@xpredator>
In-Reply-To: <aeDlhJjzS8sxumNn@xpredator>
From: Julian Orth <ju.orth@gmail.com>
Date: Thu, 16 Apr 2026 15:55:52 +0200
X-Gm-Features: AQROBzCPdF-fJ-3cPviky8UAN3ioKyadV00oORBPQ3Rw-BdbYHcJQ2CuLWkyc_s
Message-ID: <CAHijbEWpsMNyskhe=nTY-Aa2B6bNC1G+Pm+C8OChvByRfS9NqA@mail.gmail.com>
Subject: Re: [PATCH RESEND v7 0/2] Pass down hot-plug CONNECTOR ID to
 user-space
To: Marius Vlad <marius.vlad@collabora.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, Daniel Stone <daniel.stone@collabora.com>,
 Ian Forbes <ian.forbes@broadcom.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 wayland-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 17 Apr 2026 07:06:15 +0000
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

On Thu, Apr 16, 2026 at 3:35=E2=80=AFPM Marius Vlad <marius.vlad@collabora.=
com> wrote:
>
> On Thu, Apr 16, 2026 at 03:16:39PM +0200, Julian Orth wrote:
> > On Thu, Apr 16, 2026 at 9:46=E2=80=AFAM Nicolas Frattaroli
> > <nicolas.frattaroli@collabora.com> wrote:
> > >
> > > On Wednesday, 15 April 2026 20:57:53 Central European Summer Time Jul=
ian Orth wrote:
> > > > On Wed, Apr 15, 2026 at 8:19=E2=80=AFPM Nicolas Frattaroli
> > > > <nicolas.frattaroli@collabora.com> wrote:
> > > > >
> > > > > I will be taking over this series from Marius Vlad.
> > > > >
> > > > > This series addresses a shortcoming whereby a hot plug event is s=
ent
> > > > > without it being passed the actual connector that caused it. This=
 takes
> > > > > into consideration both the polling path and the HPD (Hot Plug De=
tect)
> > > > > path. It also adds support for the vkms driver (using ConfigFS) f=
or
> > > > > propagating the connector ID when changing the connector's status=
.
> > > > >
> > > > > The motivation is that user-space applications such as Weston wou=
ld
> > > > > previously receive non-connector-specific hotplug events, and the=
n have
> > > > > to figure out themselves which connector needs to have a modeset
> > > > > executed on. This notably did not work when the hotplug events ca=
me in
> > > > > too fast, resulting in Weston missing an on-off-on transition of =
a
> > > > > connector, seeing that its state was unchanged from "on" so can't=
 be the
> > > > > one that was hotplugged, and skipping reinitialising it as it loo=
ks
> > > > > through the other connectors that could've caused it.
> > > >
> > > > Have you considered adding a u64 serial number as a DRM connector
> > > > property that is incremented every time the connector changes in so=
me
> > > > way? Userspace could then check this serial number to see if the
> > > > connector has changed since the last time it queried the serial
> > > > number.
> > >
> > > The connector internally already has an epoch_counter member which
> > > could be used for this. However, for the particular thing this
> > > series fixes, I don't think exposing it through the uAPI is necessary
> > > or desirable. Sending hotplug events specific to the connector does
> > > not need any additional handling on the userspace side as long as it
> > > already listens to the per-connector hotplug events in order to
> > > avoid the pitfall described in the cover letter.
> >
> > I currently do not handle per-connector hotplug events. Instead,
> > whenever I get a UDEV change event for a device, I re-fetch the entire
> > kernel state for the device. That is
> >
> > - DRM_IOCTL_MODE_GETRESOURCES
> > - DRM_IOCTL_MODE_OBJ_GETPROPERTIES for each connector, crtc, plane
> With this change you wouldn't need to go over all of them as the kernel
> will supply the connector ID that has changed.

Is this change only going to add the connector property to existing
events or will it send additional events with the connector property
set?

> > - DRM_IOCTL_MODE_GETCONNECTOR for each connector
> > - DRM_IOCTL_MODE_GETPROPERTY for each connector property
> > - DRM_IOCTL_MODE_GETPROPBLOB for the EDID
> >
> > Once I have the new state, I compare it against the desired compositor
> > state and perform a modeset if necessary.
> >
> > This makes it robust against the situation you're describing, but also
> > means that a lot of work is done for unchanged objects. If the change
> > makes a modeset necessary, then that work is almost negligible
> > compared to the time the modeset takes.
> >
> > I don't know if your patches will cause more change events to be sent
> > or if they will just add the connector property to existing events. If
> > there are additional events, then I'd prefer to have an early out for
> > some of this work. E.g. by having access to the epoch_counter.
> >
> > >
> > > Kind regards,
> > > Nicolas Frattaroli
> > >
> > > > >
> > > > > The real world implication is that on setups with slightly sketch=
y HDMI
> > > > > connections, a brief flicker in the HPD signal could result in vi=
deo
> > > > > output bidding farewell entirely until a manual proper re-plug wa=
s
> > > > > performed.
> > > > >
> > > > > By sending connector specific hotplug events, this ambiguity is
> > > > > resolved without any change to the user-space API.
> > > > >
> > > > > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.c=
om>
> > > > > ---
> > > > > Changes in v7 RESEND:
> > > > > - None, other than removing the leftover diffstat from the cover =
letter
> > > > > - Link to v7: https://lore.kernel.org/r/20260217-hot-plug-passup-=
v7-0-f8221b2aab51@collabora.com
> > > > >
> > > > > Changes in v7:
> > > > > - Drop the two vkms patches, as I don't want them to be blocked o=
n
> > > > >   review. I still think they're correct, but they're not essentia=
l and
> > > > >   don't need to block this series.
> > > > > - Link to v6: https://lore.kernel.org/r/20260123-hot-plug-passup-=
v6-0-aaaf61d960bb@collabora.com
> > > > >
> > > > > Changes in v6:
> > > > > - Rewrote cover letter to explain the motivation for this series =
more
> > > > >   plainly
> > > > > - Rename "status_changed" to "pending_hp"
> > > > > - Set "pending_hp" in the existing path that would also affect
> > > > >   epoch_counter
> > > > > - No longer set the boolean in drm_helper_probe_single_connector_=
modes,
> > > > >   as it does not appear to be necessary
> > > > > - Reword commits to better justify the changes
> > > > > - Link to v5: https://lore.kernel.org/r/20251111162338.15141-1-ma=
rius.vlad@collabora.com/
> > > > >
> > > > > Changes in v5:
> > > > > - vkms: add support for sending the CONNECTOR ID when hot-pluggin=
g through
> > > > >   ConfigFS - as reported by Louis, vkms can now make use of Confi=
gFS to
> > > > >   simulate connector status.
> > > > > - vkms: add a small change to ignore previous/old drm connector s=
tatus
> > > > >   when sending out hot-plug uevent.
> > > > > - Link to v4: https://lore.kernel.org/r/20251103174558.7709-1-mar=
ius.vlad@collabora.com/
> > > > >
> > > > > Changes in v4:
> > > > > - removed the "This patch" bit - Dmitry
> > > > > - added a short note when the flag is set and cleared - Dmitry
> > > > > - address double dead-locking detected - kbot: https://lore.kerne=
l.org/dri-devel/202509251410.fdfbcac3-lkp@intel.com/
> > > > > - virtual connectors do not seem have any kind of hotplug - added
> > > > >   polling in vkms - as noted by Ian
> > > > > - Link to v3: https://lore.kernel.org/r/20250923083636.4749-1-mar=
ius.vlad@collabora.com/
> > > > >
> > > > > Changes in v3:
> > > > > - Address comments from Dmitry:
> > > > >   - guard connector status write with mode_config.mutex
> > > > >   - avoid setting up the connector status and immediately unset i=
t. Do the
> > > > >     unset in drm_kms_helper_hotplug_event/drm_kms_helper_connecto=
r_hotplug_event
> > > > > - Link to v2: https://lore.kernel.org/r/20250729165708.9947-1-mar=
ius.vlad@collabora.com/
> > > > >
> > > > > Changes in v2:
> > > > > - Address comments from Daniel:
> > > > >   - split patch into 2, one that introduces a bool to track conne=
ctor
> > > > >     connection status change and a patch that uses that to be abl=
e to send
> > > > >     hot plug events with the proper CONNECTOR ID to udev and furt=
her pass
> > > > >     that down to user-space
> > > > >   - nuke out mutex when iterating connector list
> > > > >   - fix typo
> > > > > - Link to v1: https://lore.kernel.org/r/20250627131751.2004-1-mar=
ius.vlad@collabora.com/
> > > > >
> > > > > ---
> > > > > Marius Vlad (2):
> > > > >       drm: Introduce pending_hp to drm_connector
> > > > >       drm: Send per-connector hotplug events
> > > > >
> > > > >  drivers/gpu/drm/drm_connector.c    |  1 +
> > > > >  drivers/gpu/drm/drm_probe_helper.c | 39 ++++++++++++++++++++++++=
+++++++++-----
> > > > >  drivers/gpu/drm/drm_sysfs.c        |  2 ++
> > > > >  include/drm/drm_connector.h        |  3 +++
> > > > >  4 files changed, 40 insertions(+), 5 deletions(-)
> > > > > ---
> > > > > base-commit: 4c59525db84aca677fd9f052e662912ad9d88448
> > > > > change-id: 20260121-hot-plug-passup-f8ed03f7c202
> > > > >
> > > > > Best regards,
> > > > > --
> > > > > Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > > > >
> > > >
> > >
> > >
> > >
> > >
