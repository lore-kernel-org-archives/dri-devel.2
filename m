Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DA9F33831
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 10:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9308210E352;
	Tue, 17 Mar 2026 10:03:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KsdqE9YW";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F236B10E352
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 10:03:27 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6634197cd98so623501a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 03:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773741806; x=1774346606; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=LXDnZwc0UQAioOB74HdZQyDfdGqfb34J+A9oDeiAkgU=;
 b=KsdqE9YWReiEqYyBrck8IoXxBUE4enjNnwkEIYIngEQYrFyRk2ugaOKDexHa2jqnEm
 8ALfXQQFiDBpbWc8/kButdleSblzEFwx22Dbylek+lgD7tH9gmylw0gi0ooKJZ8d8VJQ
 hc6G75K9CvKXkXxCL1p8MDi9alp7pYlgje42kD48VFQIm0FkESZU+hrCcLgbYTswRA6z
 S32aXYk0RlX9y/wbduE+43IgZqYoQMQYvnVROtJaMi5BTuOBncfrx2pgfAilTwLGfNVp
 1cqO0F1i/Js9lHe7n0JnpYr74/uNkoO2tPm5qBjNUsOcWN00vDaMfre48fBz8ObNu7pQ
 Mnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773741806; x=1774346606;
 h=mime-version:user-agent:content-transfer-encoding
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LXDnZwc0UQAioOB74HdZQyDfdGqfb34J+A9oDeiAkgU=;
 b=Vjh1QDD8mV1aoo9RjU4YTiLmGLoCnY50UdS+natYWwQN+NHNT8gQWHR3K4xii50wMH
 vlLXW6U6w7USrOyFplL6KpEa4Nz9f3ux1v5WnJecTlRtaI3bKDVDkSEKd12vWBlNthgj
 GXnVsRUO5hwUTFD4RZRate3Itu71d123iH+4n13jg4oI3xlLqdQsdcj1TnzpX898CNOS
 zHHhhyXDs36PvtZgqm/9ERl8wpJKlrVOp6EUWUwl1UnbRbSxu+AUnjz4k5gbhVnmQVCn
 mc1igy6/tWI6U+qzvv7PXqRQc4mCryNxQsONegPL9yiPJeI+ZUOjrtVsHo+c0c2qhjv0
 yVMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhFTtE6WiIvrmMN5c1y8gLsv3HxSZkgPbbEduFj+rB2NoCghPLG/3uaDST+uScRYvnzrsmUCDXTiA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhQm9ldCsARVIKyXNx50D4ZkQzaPGJmQTNaeWEtrf7ZmRp5I5B
 4eaY7lpURM6Qw2MVX2g5xma9jQUJOJM8hwS6hexNtOyVKvUcy2hO/3uP
X-Gm-Gg: ATEYQzyjTqlIiW8rUlw2apq57J2ZNSuc8e/oZ3bAhUyeTR/0OrnuKByGIBG4OZ+pQpi
 tswHZbimETQ2Ukq1lREjLEV92fNMbj1ITFg1MlocBXtZMx/dR8V9u8RpTDzimPIAau8PfuQCXCs
 Mx7O+FNEB+MHwmBUCTZw6RWuvfH048MXCAl7uW//7tIBA8kJWB/5a8EmV2FM3iP7+PaAk39w9OO
 TNtF7WSLOZLnR4CvrbOW11tMQGBzhq/BpZY8G8kKVJRbaE6rwtwxUDOt5NLZJELvrjEyvJT40yb
 w5r/cHCge8W+EJCHqkjBnQl5UgSmlZ1Rozot3QjXFp+JBA/c0lW00HUmk/rkZt0mq6U3Aiwyyal
 YZOH6Hwmn9Ys37IzOEZEPc5VCKsVXPGLwdVi0q6Xcvr7GuEFMIvceMheAqAXfH3dHb+fgq/ZRYC
 OyAGGffHduJi4JRJzbJLJB2zmBt7mFNySq1/yxdopDjYutYMeodnODT6ZaGKHBCkJJHHJ5RFfwB
 /QpEyjdmA==
X-Received: by 2002:a05:6402:3548:b0:663:4965:6bac with SMTP id
 4fb4d7f45d1cf-663babc294dmr4693237a12.3.1773741806180; 
 Tue, 17 Mar 2026 03:03:26 -0700 (PDT)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl.
 [87.205.5.123]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6635088fa23sm6336330a12.16.2026.03.17.03.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 03:03:25 -0700 (PDT)
Message-ID: <5649c232fa0243c2c3ca7be91529409921604d69.camel@gmail.com>
Subject: Re: [PATCH v4 07/27] drm/amd/display: Use bigger VRR range if found
 in AMD vsdb
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, alexander.deucher@amd.com, 
 harry.wentland@amd.com, sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, 	airlied@gmail.com, simona@ffwll.ch,
 siqueira@igalia.com, 	dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, 	linux-kernel@vger.kernel.org,
 bernhard.berger@gmail.com, 	michel.daenzer@mailbox.org, daniel@fooishbar.org
Date: Tue, 17 Mar 2026 11:03:22 +0100
In-Reply-To: <7da80c4be3e20c126017646f783b80136bb0700e@intel.com>
References: <20260216164516.36803-1-tomasz.pakula.oficjalny@gmail.com>
 <20260216164516.36803-8-tomasz.pakula.oficjalny@gmail.com>
 <7da80c4be3e20c126017646f783b80136bb0700e@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
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

On Thu, 2026-02-26 at 14:36 +0200, Jani Nikula wrote:
> On Mon, 16 Feb 2026, Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.co=
m> wrote:
> > [Why]
> > Some monitors only expose their full VRR range in AMD vsdb for some
> > reason.
> >=20
> > [How]
> > Compare exposed ranges and use the bigger one.
> > Only adjust lower limit if it doesn't support LFC
> >=20
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4177
> > Signed-off-by: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
> > ---
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 31 +++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index b3bf5e0c19a5..f36059bb0324 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -13269,6 +13269,34 @@ static bool copy_range_to_amdgpu_connector(str=
uct drm_connector *conn)
> >  	return is_freesync_capable(range);
> >  }
> > =20
> > +static void extend_range_from_vsdb(struct drm_display_info *display,
> > +				   const struct amdgpu_hdmi_vsdb_info *vsdb)
> > +{
> > +	u16 vrr_min =3D display->monitor_range.min_vfreq;
> > +	u16 vrr_max =3D display->monitor_range.max_vfreq;
> > +
> > +	/* Always extend upper limit */
> > +	if (vsdb->max_refresh_rate_hz > vrr_max)
> > +		vrr_max =3D vsdb->max_refresh_rate_hz;
> > +
> > +	/*
> > +	 * Only extend lower limit if current one disables LFC.
> > +
> > +	 * During widespread testing, we found that some manufacturers probab=
ly
> > +	 * had issues with their monitors' lower VRR boundaries and adjusted
> > +	 * them up (Gigabyte X34GS with official range 48 - 180, AMD vsdb 48 =
-
> > +	 * 180 yet Monitor Ranges 55 - 180). After setting the lower boundary
> > +	 * from AMD vsdb, such monitors start having blanking issues.
> > +	 *
> > +	 * Work around that by not touching VRR min if it still supports LFC.
> > +	 */
> > +	if (vsdb->min_refresh_rate_hz < vrr_min && (vrr_min * 2 >=3D vrr_max)=
)
> > +		vrr_min =3D vsdb->min_refresh_rate_hz;
> > +
> > +	display->monitor_range.min_vfreq =3D vrr_min;
> > +	display->monitor_range.max_vfreq =3D vrr_max;
>=20
> Random driver code should *not* modify struct drm_display_info,
> especially the fields that drm_edid.c parses. Drivers should cease to
> parse EDID and DisplayID altogether.
>=20
> I'm on the verge of NAKing, to the extent that I have control over this,
> any further improvements on driver EDID/DisplayID parsing, with the
> expectation that everything's moved to shared EDID parser in drm_edid.c
> first, and improved there.
>=20
> BR,
> Jani.

Hi!

So I prepared a version which completely removes the drm_display_info
modifications from this part of the driver, but I think I know why it
was there in there in the first place. Without changing these fields,
the dri debug information, reports wrong vrr range vs what the driver
decided to do.

Basically, with monitor that have different vrr range in 'monitor
ranges' and AMD vsdb, it only reports the range from monitor ranges,
worse, for monitors that report GTF range (all HDMI TV, even some DP
monitors) the vrr_range for the connector in dri debug is reported to be
0 - 0 even though the correct range was picked up from other places like
DisplayID, AMD vsdb, HDMI Forum vsdb or nvidia specific vsdb.

Moving all this into generic edid handling could be quite a problem as
well since different manufacturers might want to handle VRR differenty.
For example, Intel could decide to support FreeSync sinnalling or just
getting the range from there, or not. HDMI VRR is another issue where
one brand could decide to prioritize their own solution over the generic
one (FreeSync over HDMI vs HDMI VRR).

The vrr_range in debug ony exposes display_info.monitor_range but it's
name suggests that it does something different. Maybe it needs a
dedicated place for drivers to show what they ended up deciding upon?
monitr_range alrady is only used to expose the range if it has 'range
limits only' flag so only for VRR. My concern is that we would have bad
debug info in there now.

I'm working on adding a drp connector property that would expose the vrr
range so compositors could easily parse it instead of relying on edid
parsing, that will be impossible to match.

And again, I'm just a guy providing fixes, I think bigger changes should
be taken with AMD. The functionality is already in the driver and my
patches do not change what it does with it. I'm not even changing how it
parses anything when it comes to edid, just using what's already there
to decide how to handle VRR.

Tomasz
