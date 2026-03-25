Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6662106B530
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 13:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE9FB10E8D1;
	Wed, 25 Mar 2026 13:06:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Ab5EiQmQ";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3DA210E886;
 Wed, 25 Mar 2026 13:06:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774443970; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UyyGRzF+XFGQ9R2DLKmx+D7RhagOPIl+9zqbr/u2pumuzC+pBAxeugJUR8Dj/FqMIgPB/4cThx+4WFmtc6PiIo5YOWq6UzuZP/Rt0jV7daYjIyEZmDzscuWRJstrJ5eFk268CyTl0w7zYD9V4BurG72UMIDwcI+MTi0zburbhy8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774443970;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=DnPb2CCqVOsKX/2d2bIu7XGCPxBh8nCgmEw3NE41NDw=; 
 b=Ev5TihT8R1h7Xv7ZPDngvHgmiHdQBjtwgeCYnyMN9bq8E/Cya0ioTtkMjtUEuFS0mgsoMRk2JKDzXiZaE8z2m2bVUIo1MXDie3QGgKb91yw0LtM3NKSlnyjGxwO7Iv0zgbyai6IEDCOs7TR9nC6b5UQh+DOsaYBB/8DcPKSRWm4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774443970; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=DnPb2CCqVOsKX/2d2bIu7XGCPxBh8nCgmEw3NE41NDw=;
 b=Ab5EiQmQxWoXwMoCfpkgGbuuS50nWqqvAJgDp8AvMyzROtH3qNVr9l3VpFKM7Isa
 bFDXuKi81+fWUzrUKXpwp4EhAXoEAXukMC9kLXH+ScZqpOkfWdfv0PDipBT0GgWc16R
 6WQvZseU5SEEYlHmdsOBcH/3l/KNwJadzh6hjCvo=
Received: by mx.zohomail.com with SMTPS id 1774443969491826.1863477055813;
 Wed, 25 Mar 2026 06:06:09 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Dmitry Baryshkov <lumag@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 kernel@collabora.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-doc@vger.kernel.org, Werner Sembach <wse@tuxedocomputers.com>,
 Andri Yngvason <andri@yngvason.is>, Marius Vlad <marius.vlad@collabora.com>
Subject: Re: [PATCH v11 03/22] drm: Add new general DRM property "color format"
Date: Wed, 25 Mar 2026 14:05:57 +0100
Message-ID: <6660830.GXAFRqVoOG@workhorse>
In-Reply-To: <acLrv5hLyNss-Px5@intel.com>
References: <20260324-color-format-v11-0-605559af4fb4@collabora.com>
 <23910073.EfDdHjke4D@workhorse> <acLrv5hLyNss-Px5@intel.com>
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

On Tuesday, 24 March 2026 20:53:35 Central European Standard Time Ville Syr=
j=C3=A4l=C3=A4 wrote:
> On Tue, Mar 24, 2026 at 08:10:11PM +0100, Nicolas Frattaroli wrote:
> > On Tuesday, 24 March 2026 18:00:45 Central European Standard Time Ville=
 Syrj=C3=A4l=C3=A4 wrote:
> > > On Tue, Mar 24, 2026 at 05:01:07PM +0100, Nicolas Frattaroli wrote:
> > > > +enum drm_connector_color_format {
> > > > +	/**
> > > > +	 * @DRM_CONNECTOR_COLOR_FORMAT_AUTO: The driver or display protoc=
ol
> > > > +	 * helpers should pick a suitable color format. All implementatio=
ns of a
> > > > +	 * specific display protocol must behave the same way with "AUTO"=
, but
> > > > +	 * different display protocols do not necessarily have the same "=
AUTO"
> > > > +	 * semantics.
> > > > +	 *
> > > > +	 * For HDMI, "AUTO" picks RGB, but falls back to YCbCr 4:2:0 if t=
he
> > > > +	 * bandwidth required for full-scale RGB is not available, or the=
 mode
> > > > +	 * is YCbCr 4:2:0-only, as long as the mode and output both suppo=
rt
> > > > +	 * YCbCr 4:2:0.
> > > > +	 *
> > > > +	 * For display protocols other than HDMI, the recursive bridge ch=
ain
> > > > +	 * format selection picks the first chain of bridge formats that =
works,
> > > > +	 * as has already been the case before the introduction of the "c=
olor
> > > > +	 * format" property. Non-HDMI bridges should therefore either sor=
t their
> > > > +	 * bus output formats by preference, or agree on a unified auto f=
ormat
> > > > +	 * selection logic that's implemented in a common state helper (l=
ike
> > > > +	 * how HDMI does it).
> > > > +	 */
> > > > +	DRM_CONNECTOR_COLOR_FORMAT_AUTO =3D 0,
> > > > +
> > > > +	/**
> > > > +	 * @DRM_CONNECTOR_COLOR_FORMAT_RGB444: RGB output format
> > > > +	 */
> > > > +	DRM_CONNECTOR_COLOR_FORMAT_RGB444,
> > > > +
> > > > +	/**
> > > > +	 * @DRM_CONNECTOR_COLOR_FORMAT_YCBCR444: YCbCr 4:4:4 output forma=
t (ie.
> > > > +	 * not subsampled)
> > > > +	 */
> > > > +	DRM_CONNECTOR_COLOR_FORMAT_YCBCR444,
> > > > +
> > > > +	/**
> > > > +	 * @DRM_CONNECTOR_COLOR_FORMAT_YCBCR422: YCbCr 4:2:2 output forma=
t (ie.
> > > > +	 * with horizontal subsampling)
> > > > +	 */
> > > > +	DRM_CONNECTOR_COLOR_FORMAT_YCBCR422,
> > > > +
> > > > +	/**
> > > > +	 * @DRM_CONNECTOR_COLOR_FORMAT_YCBCR420: YCbCr 4:2:0 output forma=
t (ie.
> > > > +	 * with horizontal and vertical subsampling)
> > > > +	 */
> > > > +	DRM_CONNECTOR_COLOR_FORMAT_YCBCR420,
> > >=20
> > > Seems like this should document what the quantization range
> > > should be for each format.
> > >=20
> >=20
> > I don't think so? If you want per-component bit depth values,
> > DRM_FORMAT_* defines would be the appropriate values to use. This
> > enum is more abstract than that, and is there to communicate
> > YUV vs. RGB and chroma subsampling, with bit depth being handled
> > by other properties.
> >=20
> > If you mean the factor used for subsampling, then that'd only be
> > relevant if YCBCR410 was supported where one chroma plane isn't
> > halved but quartered in resolution. I suspect 4:1:0 will never
> > be added; no digital display protocol standard supports it to my
> > knowledge, and hopefully none ever will.
>=20
> No, I mean the quantization range (16-235 vs. 0-255 etc).
>=20
> The i915 behaviour is that YCbCr is always limited range,
> RGB can either be full or limited range depending on the=20
> "Broadcast RGB" property and other related factors.
>=20
>=20

I do agree that this would be useful to be precise about, but I'm
not sure mainline is currently capable of even making a definitive
statement about this because every implementation will do its own
thing probably.

If we do add YCbCr quantization range as a separate property (though
I'd really would've loved it if "Broadcast RGB" was named differently
so it wouldn't be confusing if we overloaded that property's meaning
to also apply to YCbCr) then the resulting docs change for these
enums would be to say that quantization range is a separate property.

I do think making it separate is the best path forward, and I'm willing
to adjust the docs to mention this, but I think implementing YCbCr limited
versus full range in this series as well would drastically widen the scope
again.

Kind regards,
Nicolas Frattaroli


