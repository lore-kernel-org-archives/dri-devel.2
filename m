Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E262FF8D74B
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 14:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4653A10E1FD;
	Thu, 16 Apr 2026 14:22:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="A7wUTAQo";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22BFD10E1FD;
 Thu, 16 Apr 2026 14:22:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776349318; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lyCSpASUysdJ/1FZC+rvl/jTqqRnswZx1bAcPdawhj0AYHcJZisMt4ayrO1yqC3jBFZ9MDyeo6KrMNZTalwNU7Ma/lMaenAhAQPls5A4bPxBZh3QIHNjf0soNQC+gC6UA+RlJZgZJnNy+4oASsKJhvlOLD5o/DjoVh0Lt0TerlQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776349318;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=34qmR7b2ElegFJW94CbQDjfTQXNI9OIIGbOEJgOSC68=; 
 b=GtjCn2U8TzZqEcpzxvh35Fgp30DXqs8g7VZgrjndJ6S/YF3konW0ap+prp1AA7IFobNnYpZjJ1OBa4+/rBs8OWhuXByTf4iMnYhGoC+Io+/qUbvysQBSJqwH3yrRBvGfldE6EeafK0ZjBxRIGguBM/slRsYylmh6VbHSuctWt10=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776349318; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=34qmR7b2ElegFJW94CbQDjfTQXNI9OIIGbOEJgOSC68=;
 b=A7wUTAQo1aNiHEZ8DWg7VK9gVGvII+nx4au6VaPYnAvySV/M6TAZfvo0DT990RcN
 o0W/0yvUBWHvxrtvRXz3m9X/WLzlNBziWVRlN07sPY+NEyybyGIqEpphTzJBq3wyMyv
 kSrpE56XRD+ThGvRFPIxHHyvlTJa1n7FYS+kdMZg=
Received: by mx.zohomail.com with SMTPS id 1776349315605672.3983268488863;
 Thu, 16 Apr 2026 07:21:55 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Marius Vlad <marius.vlad@collabora.com>, Julian Orth <ju.orth@gmail.com>
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
 kernel@collabora.com, wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH RESEND v7 0/2] Pass down hot-plug CONNECTOR ID to
 user-space
Date: Thu, 16 Apr 2026 16:21:49 +0200
Message-ID: <4528526.e9J7NaK4W3@workhorse>
In-Reply-To: <CAHijbEWpsMNyskhe=nTY-Aa2B6bNC1G+Pm+C8OChvByRfS9NqA@mail.gmail.com>
References: <20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com>
 <aeDlhJjzS8sxumNn@xpredator>
 <CAHijbEWpsMNyskhe=nTY-Aa2B6bNC1G+Pm+C8OChvByRfS9NqA@mail.gmail.com>
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

On Thursday, 16 April 2026 15:55:52 Central European Summer Time Julian Ort=
h wrote:
> On Thu, Apr 16, 2026 at 3:35=E2=80=AFPM Marius Vlad <marius.vlad@collabor=
a.com> wrote:
> >
> > On Thu, Apr 16, 2026 at 03:16:39PM +0200, Julian Orth wrote:
> > > On Thu, Apr 16, 2026 at 9:46=E2=80=AFAM Nicolas Frattaroli
> > > <nicolas.frattaroli@collabora.com> wrote:
> > > >
> > > > On Wednesday, 15 April 2026 20:57:53 Central European Summer Time J=
ulian Orth wrote:
> > > > > On Wed, Apr 15, 2026 at 8:19=E2=80=AFPM Nicolas Frattaroli
> > > > > <nicolas.frattaroli@collabora.com> wrote:
> > > > > >
> > > > > > I will be taking over this series from Marius Vlad.
> > > > > >
> > > > > > This series addresses a shortcoming whereby a hot plug event is=
 sent
> > > > > > without it being passed the actual connector that caused it. Th=
is takes
> > > > > > into consideration both the polling path and the HPD (Hot Plug =
Detect)
> > > > > > path. It also adds support for the vkms driver (using ConfigFS)=
 for
> > > > > > propagating the connector ID when changing the connector's stat=
us.
> > > > > >
> > > > > > The motivation is that user-space applications such as Weston w=
ould
> > > > > > previously receive non-connector-specific hotplug events, and t=
hen have
> > > > > > to figure out themselves which connector needs to have a modeset
> > > > > > executed on. This notably did not work when the hotplug events =
came in
> > > > > > too fast, resulting in Weston missing an on-off-on transition o=
f a
> > > > > > connector, seeing that its state was unchanged from "on" so can=
't be the
> > > > > > one that was hotplugged, and skipping reinitialising it as it l=
ooks
> > > > > > through the other connectors that could've caused it.
> > > > >
> > > > > Have you considered adding a u64 serial number as a DRM connector
> > > > > property that is incremented every time the connector changes in =
some
> > > > > way? Userspace could then check this serial number to see if the
> > > > > connector has changed since the last time it queried the serial
> > > > > number.
> > > >
> > > > The connector internally already has an epoch_counter member which
> > > > could be used for this. However, for the particular thing this
> > > > series fixes, I don't think exposing it through the uAPI is necessa=
ry
> > > > or desirable. Sending hotplug events specific to the connector does
> > > > not need any additional handling on the userspace side as long as it
> > > > already listens to the per-connector hotplug events in order to
> > > > avoid the pitfall described in the cover letter.
> > >
> > > I currently do not handle per-connector hotplug events. Instead,
> > > whenever I get a UDEV change event for a device, I re-fetch the entire
> > > kernel state for the device. That is
> > >
> > > - DRM_IOCTL_MODE_GETRESOURCES
> > > - DRM_IOCTL_MODE_OBJ_GETPROPERTIES for each connector, crtc, plane
> > With this change you wouldn't need to go over all of them as the kernel
> > will supply the connector ID that has changed.
>=20
> Is this change only going to add the connector property to existing
> events or will it send additional events with the connector property
> set?

It sends additional events if you happen to have multiple connectors
undergoing a hotplug at the same time. This should not be a cause for
concern; it's bounded by the number of connectors in the system (which
is a single digit number, usually).

Kind regards,
Nicolas Frattaroli


