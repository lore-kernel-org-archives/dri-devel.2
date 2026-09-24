Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CDBC9831A
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 12:10:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CA4210F4DF;
	Thu, 24 Sep 2026 12:10:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Xu+gcUfb";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14D9710F4DF;
 Thu, 24 Sep 2026 12:10:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790251823; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SMMG8NlP4fqBNXx529QZu5Zdtb4p9tbuMOQ91soQIHcDnn4ZYV2Qq6DwCOwr678Uo7p8enklMkZmlGtEeJGziTS1PKR38Ch/HKt4o33k5EJ7Vn5Q4viwpc3HWxbVLfSZ2E0v1befX4gf1zmvugKkk/KyrSeBPBpn9VFZmOokLPs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790251823;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=j/JN7+ozPHQKLl/xICwnFADe4iQfIt+/rqVhH5CZrYA=; 
 b=JA02mZ1JM5S0BN3yBf3uyS3rHRpQxWB4DFfmHKkMiPasUG1Oj8qL1w/U6XepZzR2eFpxM5PIYcUrWJusagOO9ZEQ+jQPQMSc0WlC2bLpOSUi2Z23Yxe4/RwXxRq0p4pDbMr3OfPvJzEp1NzpH95dhfCqZ97kDljvcaqPxuUeohg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790251823; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=j/JN7+ozPHQKLl/xICwnFADe4iQfIt+/rqVhH5CZrYA=;
 b=Xu+gcUfbDupdDGdO0xZeIAWmvh740ouAqQ7g8/OfYe3MpyVK0wF1tXyDTwBDYT7Y
 xzFD/uVYj2XViaDeb0kVdScnlodkBeibyV7UnNF63LSAYs+THvk3+ng2ALMvv9/0UXO
 CFkcvJQVJ5wXPkjrdhI7uNuS90bR8L/xns/jDyGA=
Received: by smtp.zohomail.com with SMTPS id 1790251821166727.927772036528;
 Thu, 24 Sep 2026 05:10:21 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Vidith Madhu <vmadhu@nvidia.com>
Cc: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 Leo Li <sunpeng.li@amd.com>, Daniel Stone <daniels@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>,
 Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 Derek Foreman <derek.foreman@collabora.com>,
 wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH RFC 13/25] drm: Add VRR target frame rate properties
Date: Thu, 24 Sep 2026 14:10:13 +0200
Message-ID: <JMjFKVeURZyGX22Pj_CGcQ@collabora.com>
In-Reply-To: <6fb8aaed-5abc-db9c-b09b-3390d8b87686@nvidia.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <YozwdeJLQh-0GBcK9P3QvQ@collabora.com>
 <6fb8aaed-5abc-db9c-b09b-3390d8b87686@nvidia.com>
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

On Thursday, 24 September 2026 09:01:05 Central European Summer Time Vidith=
 Madhu wrote:
>=20
> On Wed, 23 Sep 2026, Nicolas Frattaroli wrote:
>=20
> > On Wednesday, 23 September 2026 11:51:45 Central European Summer Time M=
ichel D=C3=A4nzer wrote:
> > > On 9/21/26 17:51, Nicolas Frattaroli wrote:
> > > >=20
> > > > + * .. _VRR-MIN-NUMERATOR:
> > > > + *
> > > > + * "VRR_MIN_NUMERATOR":
> > > > + *	Default &drm_crtc integer property forming the numerator of a
> > > > + *	numerator/denominator pair of a frame rate to set as the minimu=
m VRR
> > > > + *	target rate. Set to 0 to disable.
> > > > + *
> > > > + * "VRR_MIN_DENOMINATOR":
> > > > + *	Default &drm_crtc integer property forming the denominator of a
> > > > + *	numerator/denominator pair of a frame rate to set as the minimu=
m VRR
> > > > + *	target rate. If :ref:`VRR_MIN_NUMERATOR <VRR-MIN-NUMERATOR>` is=
 not
> > > > + *	zero, it must be non-zero.
> > > > + *	Otherwise, must also be zero.
> > > > + *
> > > > + * .. _VRR-MAX-NUMERATOR:
> > > > + *
> > > > + * "VRR_MAX_NUMERATOR":
> > > > + *	Default &drm_crtc integer property forming the numerator of a
> > > > + *	numerator/denominator pair of a frame rate to set as the maximu=
m VRR
> > > > + *	target rate. Set to 0 to disable.
> > > > + *
> > > > + * "VRR_MAX_DENOMINATOR":
> > > > + *	Default &drm_crtc integer property forming the denominator of a
> > > > + *	numerator/denominator pair of a frame rate to set as the maximu=
m VRR
> > > > + *	target rate. If :ref:`VRR_MAX_NUMERATOR <VRR-MAX-NUMERATOR>` is=
 not
> > > > + *	zero, it must be non-zero. Otherwise, must also be zero.
> > > >   */
> > >=20
> > > Is there a reason that DENOMINATOR must be 0 when the corresponding N=
UMERATOR is? 0 divided by any number is still 0.
> >=20
> > No, I think that's an arbitrary convention I settled on and don't enfor=
ce. I
> > guess it should be "Otherwise, may also be zero", because the only situ=
ation
> > I'm making userspace avoid is x/0 where x !=3D 0.
> >=20
> > > > Either way, should these rules be enforced in drm_atomic_crtc_set_p=
roperty?
> > >=20
> > > Or rather in atomic_check.
> >=20
> > Due to complicating factors like EDID, CinemaVRR, and QMS TFRmin/TFRmax=
, checking
> > the properties for sensible values is done in the HDMI state helpers at=
 the moment.
> >=20
> > If/when there is a similar mechanism for DP, we can probably factor the=
 common
> > parts out. I really do hope all drivers (including those that don't use=
 the HDMI
> > state helpers) can at least share the hdmi_validate_vrr() logic, but I =
haven't
> > factored this out into an exported function yet because I don't know ho=
w similar
> > the DisplayPort-equivalent mechanisms requirements are, or how much of =
the state
> > derivation non-state-helper drivers (i.e. i915 and amdgpu) need.
> >=20
> > Kind regards,
> > Nicolas Frattaroli
>=20
> Thanks for bringing up support for VRR features on DP. Concerning the=20
> frame rate limits themselves, as I mentioned in patch [02/25] I don't=20
> think there's a reason to limit the validation to HDMI.

Agreed. I think factoring most of the stuff out into the CRTC atomic check
phase is what I'll do, and then keep the HDMI-specific validation and
derivation within the HDMI state helpers. That should somewhat simplify
the code as well I think.

> There is in fact an analog of QMS for DP, called DP-FAVT mode - this is
> quite a bit more streamlined than QMS and the validation should be
> simpler. Would be nice to see these properties support that as well

Yep, the intent is that the properties are display protocol agnostic,
it just so happens that the only implementation I wrote so far is
specific to HDMI.

Also, good to hear the DP QMS-equivalent is more streamlined. :)

> (this was briefly discussed at DisplayNext HackFest, if I understood
> access to the DP spec is the main blocker here?).

It certainly is a blocker. We also don't have any fancy testing/validation
equipment, so validating implementations for protocols before they reach
consumer devices is difficult for us (Collabora) at this time. That's also
why it's a good idea for anyone who has access to the expensive specialised
protocol test equipment to validate that the HDMI VTEM EMP packets we're
constructing are actually within spec and not just a "happens to work" kind
of deal.

Kind regards
Nicolas Frattaroli


