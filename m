Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D9CEC01DD
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 12:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E52D10E101;
	Mon, 23 Mar 2026 12:05:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="TkmCunsj";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6237C10E101;
 Mon, 23 Mar 2026 12:05:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774267524; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VTXkphppy8+W88fOqN/b//QigWYt7YrMw5sKkdwsQ+8hCIIjgLpqr6AzGNmowYG/pEtf9LWmTWHXUPxec6AfCEF30IDjcPP1E3sSl8UIOdAJKmwAPdE4cH5hX3RPo3aJIVf9CTGm305SGAMLVMXOUhxm1xcKSwPGMBHzDEP6f0o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774267524;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ZWv0IoWA5epHfToB99lEQCP6b+VCT7VtM2YpOFnH+XY=; 
 b=ST8RocsKlbmUeI10jofrr9ejIfOcNAlthjlbfGbcVUiySjKEdtt8rXu1W6+F2YeyA4BzpkfM346aLks8HRNGGaqDVLcAxpOdV7fzU8Lvop+mDG0V9yX2TiWo8yhQ5I2GozC2ZdSsT8GM+JDUAoJ7f9iKscnvOsvVNCeFvW3uV04=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774267524; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=ZWv0IoWA5epHfToB99lEQCP6b+VCT7VtM2YpOFnH+XY=;
 b=TkmCunsjnkukSCJYSV7hkfKe3VqHhBLsidsq8CtnXeBR+wDHi123p+FDNLNYfIpT
 zswomBM8hOnSQUHpVvAsDE1pybKN/L/VGCY+5ynFtDDu5iLQf8kzVrkA2rklsYKWnz3
 vV6yfk1obgpjKkWf88nehYID+aULrZZS6kyp6SS0=
Received: by mx.zohomail.com with SMTPS id 1774267521930650.1010496194826;
 Mon, 23 Mar 2026 05:05:21 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Daniel Stone <daniels@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, kernel@collabora.com,
 Derek Foreman <derek.foreman@collabora.com>,
 Marius Vlad <marius.vlad@collabora.com>
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
Date: Mon, 23 Mar 2026 13:05:14 +0100
Message-ID: <5995842.DvuYhMxLoT@workhorse>
In-Reply-To: <6baaebff-ea82-4b40-a4d9-419045526cfa@mailbox.org>
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <5797606.kQq0lBPeGt@workhorse>
 <6baaebff-ea82-4b40-a4d9-419045526cfa@mailbox.org>
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

On Monday, 23 March 2026 11:55:34 Central European Standard Time Michel D=
=C3=A4nzer wrote:
> On 3/20/26 19:02, Nicolas Frattaroli wrote:
> > On Friday, 20 March 2026 15:32:37 Central European Standard Time Michel=
 D=C3=A4nzer wrote:
> >> On 3/19/26 13:28, Nicolas Frattaroli wrote:
> >>> This series adds a new "link bpc" DRM property. It reflects the displ=
ay
> >>> link's actual achieved output bits per component, considering any
> >>> degradation of the bit depth done by drivers for bandwidth or other
> >>> reasons. The property's value is updated during an atomic commit, whi=
ch
> >>> is also when it fires an uevent if it changed to let userspace know.
> >>>
> >>> There's a weston implementation at [1] which makes use of this new
> >>> property to warn when a user's requested bpc could not be reached.
> >>>
> >>> [1]: https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/1=
850
> >>
> >> I see no description of a real-world use case, either in this series
> >> or in the weston MR, beyond logging a message when the "link bpc" &
> >> "max bpc" property values don't match. They are not expected to match
> >> in general, so I have a hard time seeing the usefulness of that.
> >=20
> > Hello,
> >=20
> > these are valid concerns. The problem being addressed is related to
> > userspace being able to detect whether the link has degraded due to,
> > say, a sketchy cable.
> >=20
> > This patch started out as a method of forcing the output link's BPC
> > value to a certain value, but this is not desirable. The max bpc
> > property is already used to restrict the link's bpc due to sketchy
> > hardware that advertises a higher max bpc than it can actually
> > achieve.
>=20
> Not really.
>=20
> The "max bpc" property is simply an upper limit for the effective bpc tha=
t can be used by the driver; nothing more or less. The driver is free to us=
e any lower bpc value though, that doesn't mean anything's wrong.
>=20
> It doesn't imply that the "max bpc" value can actually be achieved under =
any circumstances.
>=20
> The practical purpose is mainly to restrict bpc in cases where higher bpc=
 would prevent e.g. higher refresh rate.

The max bpc property's upper limit is an arbitrary driver-set value as
you stated, but that's not what I'm talking about here. Please look at
the code in drm_atomic_uapi.c.

>=20
>=20
> > I agree that the weston implementation isn't a great showcase,
> > but it's actually supposed to compare link bpc with an explicitly
> > set max bpc config value, not the property value. The config value
> > exists to request a certain bpc.
>=20
> Per above, the "max bpc" property isn't really useful for that.

This is straight up false. Setting a max bpc value in weston's config
sets the max bpc DRM property to that value, which in turn sets
max_requested_bpc. On atomic_check, the minimum of state->max_bpc
and state->max_requested_bpc is taken for the new value of
state->max_bpc, i.e. what is set through the property does constrain
the max bpc.

>=20
>=20
> >> Moreover, there's no description of what exactly the "link bpc" proper=
ty
> >> value means, e.g. vs things like DSC or dithering, or how a compositor=
 /=20
> >> user would determine which value they need / want under given circumst=
ances.
> >=20
> > I agree that I should've expanded on this after splitting it out of the
> > HDMI patch. It's the output BPC as HDMI understands it. That means DSC =
is not
> > a factor. I don't know if any display protocols do dithering at the
> > protocol level, I only know some monitors dither internally, which isn't
> > something that can be detected.
>=20
> I know AMD GPUs can do at least temporal dithering of the data they send =
over the link, I suspect non-temporal as well.
>=20
> Either way, the user may be able to distinguish more information than the=
 "link bpc" property value implies.
>=20
>=20
>=20




