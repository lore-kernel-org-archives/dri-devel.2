Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47833F34C49
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 12:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA83810E416;
	Mon, 13 Apr 2026 12:10:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="XgDbUsd0";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C6E10E418;
 Mon, 13 Apr 2026 12:10:19 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 406224E4296E;
 Mon, 13 Apr 2026 12:10:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EEFD25FFB9;
 Mon, 13 Apr 2026 12:10:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AA50A104500A2; 
 Mon, 13 Apr 2026 14:10:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776082215; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=dhpDLI3GbjEnq5ea2C3CSlaeOYOoDERSaq/PhF217/g=;
 b=XgDbUsd0kza50SBVz4+wc3tba3Gea/Rw9Wtl9Oh3cj1zYYyx83GshUatFgLe99itaxWAJf
 dbLqFjb/kWwi0Lrqgc0awLQeFS+zivNYqgAQVEqYi8w3nolcV+k65uHo3kdCaoU8FmQRYi
 FNnxTfJNQn5FvhrAeOubTD8A5Hs74ZXx+AAtTu4zM20gVeAwAclh1G1dVmBb9dY1Eir7Jq
 fvH5aaDiIW27DKzBoQbqfzu2fOc/1o1RsElFMmpjnd6CCy0Z1XUpibM/HsTJ3u3RLvDctq
 J8mv0Uvt+qvEaqgfRTVFVct2t/QHp9kY5w5CLgxJtUaDj7TEc6nIau/Ea77HiQ==
Date: Mon, 13 Apr 2026 14:10:00 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Jani
 Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Dave
 Airlie <airlied@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Eric
 Anholt <eric@anholt.net>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Chun-Kuang Hu
 <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Chris Wilson
 <chris@chris-wilson.co.uk>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Mark Yacoub <markyacoub@google.com>, Sean
 Paul <seanpaul@google.com>, Louis Chauvet <louis.chauvet@bootlin.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH RFC 00/12] Add support for DisplayPort link training
 information report
Message-ID: <20260413141000.0e190dcc@kmaincent-XPS-13-7390>
In-Reply-To: <u4ononk4cpccx77gvlywtfen5rmyslvr72v7olkhdrjf65aqce@xo777vofhcan>
References: <20260409-feat_link_cap-v1-0-7069e8199ce2@bootlin.com>
 <adgNxaFhbQaxC5E_@intel.com>
 <u4ononk4cpccx77gvlywtfen5rmyslvr72v7olkhdrjf65aqce@xo777vofhcan>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Fri, 10 Apr 2026 00:36:09 +0300
Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> wrote:

> On Thu, Apr 09, 2026 at 11:36:21PM +0300, Ville Syrj=C3=A4l=C3=A4 wrote:
> > On Thu, Apr 09, 2026 at 07:08:16PM +0200, Kory Maincent wrote: =20
> > > DisplayPort link training negotiates the physical-layer parameters ne=
eded
> > > for a reliable connection: lane count, link rate, voltage swing,
> > > pre-emphasis, and optionally Display Stream Compression (DSC). Curren=
tly,
> > > each driver exposes this state in its own way, often through
> > > driver-specific debugfs entries, with no standard interface for users=
pace
> > > diagnostic and monitoring tools.
> > >=20
> > > This series introduces a generic, DRM-managed framework for exposing =
DP
> > > link training state as standard connector properties, modeled after t=
he
> > > existing HDMI helper drmm_connector_hdmi_init().
> > >=20
> > > The new drmm_connector_dp_init() helper initializes a DP connector and
> > > registers the following connector properties to expose the negotiated=
 link
> > > state to userspace:
> > >=20
> > > - num_lanes:      negotiated lane count (1, 2 or 4)
> > > - link_rate:      negotiated link rate
> > > - dsc_en:         whether Display Stream Compression is active
> > > - voltage_swingN: per-lane voltage swing level (lanes 0-3)
> > > - pre_emphasisN:  per-lane pre-emphasis level (lanes 0-3) =20
> >=20
> > I don't see why any real userspace would be interested in those (apart
> > from maybe DSC). If this is just for diagnostics and whatnot then I
> > think sysfs/debugfs could be a better fit. =20
>=20
> I'd agree here. Please consider implementing it as a debugfs interface,
> possibly reusing the Intel's format.

Sorry, I completely forgot to include a paragraph explaining the rationale
behind using DRM properties.

This DisplayPort link information report was requested by OSes to allow the=
m to
assess the capabilities of each DisplayPort connector on the system, and to
guide users from the most to least capable ones. It will also enable the OS=
 to
warn the user when a cable is too long or experiencing noise (indicated by =
high
voltage swing and pre-emphasis levels).

Since this is information that OSes will consume on a regular basis, exposi=
ng
it directly as DRM properties seems the most appropriate approach.=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
