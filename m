Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9146F483C8
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:55:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 197DF10E047;
	Mon, 23 Mar 2026 16:55:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="NwbZ64iu";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F33F10E5B1;
 Mon, 23 Mar 2026 16:55:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774284936; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hn01+A1MpwSwu42ddL8NIjneXPC773MdPO3N/cVPmkSUizy78h68Kn6xtxU2p27DJNEXvHLbQdK269h1azz9lAr8fsw2S4TTHGDGAPFsHvsDo+HeWcAmALg/oTA1gCujhpHXMP8dNH+xYyQ4/mbzZCNOVDYmMSH8j2Hs5q3p4rA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774284936;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1RIp2XliOHFyhsE2i39U7wdZc+w/m/jcDr9m8q9DG1o=; 
 b=N+68h7LnGXwBl++4P+cvAYG7kmAk/2YEy0/487NeII+H7dL5BmeM/YO8mjWk9adbrAnQ/zAUp3qsPK+MtNVimWuXBowawyF4cJlueJJZ4BGoFeD6A207Umhmxx/NY8TsdRfKWaAL/kxWwlkzdgcYRbRDXWhlKoRqAMlvrcDQTDc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774284936; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=1RIp2XliOHFyhsE2i39U7wdZc+w/m/jcDr9m8q9DG1o=;
 b=NwbZ64iue9c5uA2EGuqXTv+09nX90SlyFmqA3OEsn2ri5mcvGxFTMMJsjsFgjRU0
 sVzBSkUq/z+4L1MN67CJSCFkVHG51s28SNkokwndqkQNC8sHIizHrt4HDzKkmspYgj3
 0qQ4ze77WMC1ek/DzFsmphF4hy8k4EEAaxLBDgp8=
Received: by mx.zohomail.com with SMTPS id 1774284934084912.9501784983873;
 Mon, 23 Mar 2026 09:55:34 -0700 (PDT)
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
Date: Mon, 23 Mar 2026 17:55:27 +0100
Message-ID: <8676926.T7Z3S40VBb@workhorse>
In-Reply-To: <aead136d-4da5-42de-aef8-3f91815a95a9@mailbox.org>
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <5995842.DvuYhMxLoT@workhorse>
 <aead136d-4da5-42de-aef8-3f91815a95a9@mailbox.org>
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

On Monday, 23 March 2026 15:38:58 Central European Standard Time Michel D=
=C3=A4nzer wrote:
> On 3/23/26 13:05, Nicolas Frattaroli wrote:
> > On Monday, 23 March 2026 11:55:34 Central European Standard Time Michel=
 D=C3=A4nzer wrote:
> >> On 3/20/26 19:02, Nicolas Frattaroli wrote:
> >>> On Friday, 20 March 2026 15:32:37 Central European Standard Time Mich=
el D=C3=A4nzer wrote:
> >>>> On 3/19/26 13:28, Nicolas Frattaroli wrote:
> >>>>> This series adds a new "link bpc" DRM property. It reflects the dis=
play
> >>>>> link's actual achieved output bits per component, considering any
> >>>>> degradation of the bit depth done by drivers for bandwidth or other
> >>>>> reasons. The property's value is updated during an atomic commit, w=
hich
> >>>>> is also when it fires an uevent if it changed to let userspace know.
> >>>>>
> >>>>> There's a weston implementation at [1] which makes use of this new
> >>>>> property to warn when a user's requested bpc could not be reached.
> >>>>>
> >>>>> [1]: https://gitlab.freedesktop.org/wayland/weston/-/merge_requests=
/1850
> >>>>
> >>>> I see no description of a real-world use case, either in this series
> >>>> or in the weston MR, beyond logging a message when the "link bpc" &
> >>>> "max bpc" property values don't match. They are not expected to match
> >>>> in general, so I have a hard time seeing the usefulness of that.
> >>>
> >>> Hello,
> >>>
> >>> these are valid concerns. The problem being addressed is related to
> >>> userspace being able to detect whether the link has degraded due to,
> >>> say, a sketchy cable.
> >>>
> >>> This patch started out as a method of forcing the output link's BPC
> >>> value to a certain value, but this is not desirable. The max bpc
> >>> property is already used to restrict the link's bpc due to sketchy
> >>> hardware that advertises a higher max bpc than it can actually
> >>> achieve.
> >>
> >> Not really.
> >>
> >> The "max bpc" property is simply an upper limit for the effective bpc =
that can be used by the driver; nothing more or less. The driver is free to=
 use any lower bpc value though, that doesn't mean anything's wrong.
> >>
> >> It doesn't imply that the "max bpc" value can actually be achieved und=
er any circumstances.
> >>
> >> The practical purpose is mainly to restrict bpc in cases where higher =
bpc would prevent e.g. higher refresh rate.
> >=20
> > The max bpc property's upper limit is an arbitrary driver-set value as
> > you stated, but that's not what I'm talking about here.
>=20
> I'm not talking about the maximum value of the property itself either.
>=20
> The value of the "max bpc" property, which can be modified by user space,=
 defines the upper limit for the effective bpc used by the driver.

Yes, I know what the max bpc property does. I do not think it defines
a fixed bpc the driver was required to use, as if it did, the link bpc
property would be useless.

> >>> I agree that the weston implementation isn't a great showcase,
> >>> but it's actually supposed to compare link bpc with an explicitly
> >>> set max bpc config value, not the property value. The config value
> >>> exists to request a certain bpc.
> >>
> >> Per above, the "max bpc" property isn't really useful for that.
> >=20
> > This is straight up false. Setting a max bpc value in weston's config
> > sets the max bpc DRM property to that value, which in turn sets
> > max_requested_bpc. On atomic_check, the minimum of state->max_bpc
> > and state->max_requested_bpc is taken for the new value of
> > state->max_bpc, i.e. what is set through the property does constrain
> > the max bpc.
>=20
> What I mean is that the "max bpc" property isn't useful for the purpose o=
f "request a certain bpc".

Yes it is? It requests an upper limit for BPC and every driver
will try to pick the highest that's practically possible.

> It only affects the upper limit, not the effective value, which can legit=
imately be lower.

I am aware, that is why the link bpc property is added, to evaluate
what the driver ended up picking. See "practically possible" above.

> Logging a message in that case may be a false positive which may result i=
n a spurious issue report.

That is not what any of this is used for. In the MR, it acts on the weston
option of the name max-bpc, which incidentally sets the max bpc
property, but is an explicit request by a user made through a config
file. The use here is just a basic userspace use of it, the point is
not to create a new warning out of nothing for the fun of it.

The whole point of this property is to close the feedback loop
between requesting a new bpc with max-bpc and seeing what comes out
the other end with link-bpc. This answers all questions you should
have about the definition of what bits per component is (same as
with max bpc), and why this property should exist. "Someone might
not understand its purpose" is, in my eyes, not a valid reason to
not have this property, as this argument applies to every property.




