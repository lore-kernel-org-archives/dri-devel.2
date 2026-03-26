Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708DE10A3D7F
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 12:17:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0859E10EA70;
	Thu, 26 Mar 2026 12:17:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="KYPriEpn";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF87010EA70;
 Thu, 26 Mar 2026 12:17:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774527444; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IEcxPQklvirq1vTTgeXJ61rcLF6brb5Sq8KjrmbQPpL1C1UNbpgD7jYgaL/TQvLdC4cZkK9ihGs8J1lnKPZ8s8BtfTowQ06LY4mlFuu1c1d0avhxrRJSSYlP052YYjXf8y8QjUFrI+D8jAHTO/zh2GUP4MBxp9979wtWIAUVfZA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774527444;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Tirp7UAELP3uffwBowPhBSfOvBKTMCo+3Ho7dI9AS4A=; 
 b=UHhNaac37CoMBkCutYt/hxP7SSW07STddoEfZ7PhAmw2oRWggWdKpuhNyzalQkabLR1vA5ayg0SQUC3v2vgkffQPNLjZ8eThzUfij9ctDfRg8vkCxiPKUBlqeLXBfK3kJneXxfh2pPk2UkQ9ch5bpr2sZ/jN7ux7eXoYdTU9PMY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774527444; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=Tirp7UAELP3uffwBowPhBSfOvBKTMCo+3Ho7dI9AS4A=;
 b=KYPriEpn4YIB4eoHua3fr+3hZ0eN+pNCMKPciEFrIFM/BEV4doaWGf2Qxokn3QMU
 RQkVb7bwKsr30MCxpr1K0qFkg30knMH3TAXw5AyCLA9lxJx9wGVIsbmsZOC4HD1ds+z
 Cav7qumtZ6ZJexyE/EIZ5D1wiDeybm2tfQlh26Bw=
Received: by mx.zohomail.com with SMTPS id 1774527443168557.1035634875152;
 Thu, 26 Mar 2026 05:17:23 -0700 (PDT)
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
Date: Thu, 26 Mar 2026 13:17:17 +0100
Message-ID: <5416161.aeNJFYEL58@workhorse>
In-Reply-To: <254c20a4-cce3-4c8e-9902-514586f3e694@mailbox.org>
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <4265353.aeNJFYEL58@workhorse>
 <254c20a4-cce3-4c8e-9902-514586f3e694@mailbox.org>
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

On Tuesday, 24 March 2026 17:44:21 Central European Standard Time you wrote:
> On 3/24/26 16:25, Nicolas Frattaroli wrote:
> > On Monday, 23 March 2026 18:27:41 Central European Standard Time Michel=
 D=C3=A4nzer wrote:
> >> On 3/23/26 17:55, Nicolas Frattaroli wrote:
> >>>
> >>> "Someone might not understand its purpose" is, in my eyes, not a vali=
d reason to
> >>> not have this property, [...]
> >> Per my previous posts, that's not my concern.
> >=20
> > Then what is your concern?
>=20
> Per my previous posts, my concerns are:
>=20
> * The meaning of the "link bpc" property value isn't defined well
> enough vs things like dithering or DSC, which will likely result in
> compositors / users overestimating what value they need / want,
> resulting in compositors spuriously rejecting configurations which=20
> would work perfectly fine, and/or spurious issue reports.

Dithering and DSC are supposed to be transparent, no? Or else why is
amdgpu forcing DSC on for everyone? This doesn't make sense. If a
link bpc is 10 but DSC is on so it's 9 on the wire, it's still 10 bits.
No compositor would care about the compressed-to actual bit depth on
the wire being 9 bits on the intake of a DSC decoder, it's not relevant
for their use case, they're not decoding DSC.

Making it consider DSC as part of the link bpc would lead to what you
describe, since now compositors would need to know the compression
algorithms of every single display protocol to correctly determine
whether unintended degradation has happened. Ignoring DSC, which is
what I am doing, would not do that.
=20
> With my compositor developer hat on, what I'd want to know is something
> like: "How many bits of information can be passed over the link, allowing
> the display to present it in a way which can be perceived by the user?"
> With dithering or DSC, that would be a higher value than the physical
> link bpc.

You're assuming link-bpc isn't precisely that. It is precisely that. It's
not the wire format. Nobody cares about how many bits are on the wire, they
care about the bit depth on the protocol level, that is, whether 10->8 bit
degradation has happened, not whether 10 bits have DSC applied to be actual=
ly
9 bits on the wire but it's not the same as uncompressed 9 bits would be
because compression doesn't work like that.

> * There's no clear use case.
>=20
> This is generally a requirement for new KMS UAPI.
>=20
> The practical usefulness of the corresponding weston MR is dubious
> per the concern above.

As per my previous responses, I outlined you the use case. However, you
seem to be obsessed with the weston MR that adds a warning. This is not
the use case. I will copy-paste my explanation of the use case again, for
your benefit:

A particular real-world use case is for playback of video content.
When playing back YUV 4:2:0 10-bit video content in a full-screen
setting, having RGB 10-bit degrade to YUV 4:2:0 10-bit rather than
RGB 8-bit is more desirable. However, this is a tradeoff only
userspace knows to make; the kernel doesn't necessarily know that
the framebuffer it has been handed as RGB 10-bit is secretly just
a video player's playback of YUV 4:2:0 10-bit content. As for
the property that let's userspace actually set the output color
format, that's a separate series of mine.

> > That the link-bpc property does not consider DSC and dithering?
> > Two things which the max-bpc property also does not consider?
>=20
> It's not (as much of) an issue with the "max bpc" property because
> it's just an upper limit, the driver is free to use a lower effective bpc=
=2E=20

Yes it is. If I request 10 bpc but I'm somehow convinced that this means
"whatever bpc compresses to 10bpc with DSC" then it's not working as this
flawed interpretation would convince me. However, thankfully, nobody thinks
this.

> > If all you want is a clearer description of the property in the comment=
 that
> > accompanies it, then I can do that, and I said I agree with this point.
>=20
> Patch 3 would need to take dithering & DSC into account as well.

There is no patch 3, and I will not break the feedback loop semantics of th=
is
property to please you. It ruins the actual intended use case, so I won't d=
o it.

> > But you seem to be arguing from a position of not wanting the property =
to
> > exist at all, [...]
>=20
> I'm not. However, per the first concern above, a not-well-defined
> property could be worse than none.

So should I remove max-bpc as well? It's not well defined after all.



