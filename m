Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1756510A62D6
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5931310EA2D;
	Thu, 26 Mar 2026 13:57:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="DVLBtxKr";
	dkim-atps=neutral
Received: from mail-4321.protonmail.ch (mail-4321.protonmail.ch [185.70.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52E1C10EA1A
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 13:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1774533323; x=1774792523;
 bh=c7GysOWWyI49BgSyflC0GvQahJMzLXH7DggqPDsDW+0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=DVLBtxKrOB0Fnd2rp80AtsSauSbUo140hj09qD4tgS3kYpsTBIfdg7pgAmGM0K/cn
 gb1heltniJ2cTZMGmUNHJDUrDHEm21aTP2Fy0U7xawvl+qdtD4X8NAoNlrbTMjQBnj
 gNjDeDaWahBdgzne8ETn3Kl4TmgGfYSYr7PiQ+o3Yq4BuwbM/Kx1LhftK7eVzcw6ME
 K7k4uylwyYnT4KE8bt+RQX7Ehv+6hyNxZJKVgj4+eJ7pt1xuLebkvVs1FwVQhpwaHr
 kUOZJEdortD1t136+YIh8W+LV9T9YdylSDBuiiDHe4fCRWdDWiDKZJ4OBwK9An1lls
 kDBgVX8pjhC1Q==
Date: Thu, 26 Mar 2026 13:55:18 +0000
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
From: Simon Ser <contact@emersion.fr>
Cc: Vishal Sagar <vishal.sagar@amd.com>,
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Pekka Paalanen <ppaalanen@gmail.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: Re: [PATCH v8 04/11] drm/fourcc: Add DRM_FORMAT_Y10_P32
Message-ID: <tdkWFF71nLgRvNFp-OQtohBXQL6tLPCOKUUOaMDR0YyvFjmZ40KCDeM5NrBeev1BKVurfJ5UdBhcUTUjW6x5qbuSang4S2qZ5sTBbQSNum8=@emersion.fr>
In-Reply-To: <d0728f98-f964-4321-a34a-022f28f268cc@ideasonboard.com>
References: <20260128-xilinx-formats-v8-0-9ea8adb70269@ideasonboard.com>
 <20260128-xilinx-formats-v8-4-9ea8adb70269@ideasonboard.com>
 <5zkelJBm0aeSnp__adMEfjOl_GAg7G_W1GyDWix8dQ48gqSmuM1if1c2Vz_xPNNpKy8_SiUh4l7WRs-12b8_DkD0PUWLdCwubo2k_DLh5eE=@emersion.fr>
 <d0728f98-f964-4321-a34a-022f28f268cc@ideasonboard.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: 91e26191d2ffb68d0f86cf59163c92c8ee1971b0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On Friday, March 20th, 2026 at 11:48, Tomi Valkeinen <tomi.valkeinen@ideaso=
nboard.com> wrote:

> Hi,
>=20
> On 19/03/2026 16:59, Simon Ser wrote:
> > On Wednesday, January 28th, 2026 at 18:25, Tomi Valkeinen <tomi.valkein=
en@ideasonboard.com> wrote:
> >
> >> Add Y10_P32, a 10 bit greyscale format, with 3 pixels packed into
> >> 32-bit container.
> >>
> >> The fourcc for the format is 'YPA4', which comes from Y - Y only, P -
> >> packed, A - 10 (as in 0xA), 4 - 4 bytes.
> >
> > I know we aren't super consistent about DRM format names, but=E2=80=
=A6 this _P32
> > suffix doesn't make sense to me: we never had it before, and a lot of
> > DRM formats are packed (in the Vulkan sense [1]), so I'm not sure why
> > this one would need it.
> >
> > What's special about this one is that it's the first (AFAIK) which has
> > 3 pixels per block. Some YCbCr formats are sub-sampled, but always use =
a
> > square block.
> >
> > I would suggest something like YYYX1010102. We use the "channels
> > followed by bits per component" pattern elsewhere.
> I'm ok with that. But wouldn't it be XYYY2101010 instead?

Oh yes, indeed.

> And then we just wait for someone to add a x:Y0:Y1:Y2 format (instead of
> x:Y2:Y1:Y0). Should we be more specific, and already make this one
> XY2Y1Y0_2101010...

Looking at all existing YCbCr formats, they all use the Y2-Y1-Y0 ordering,
none of them use the reverse. So I'd say it's safe enough to just leave it
out and treat it as the default. We can think of a new pattern if/when we
hit the reverse case.
