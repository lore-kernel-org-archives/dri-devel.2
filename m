Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F03C606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FqkBY7NN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D396710E791;
	Mon, 23 Nov 2026 08:48:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ACDD10E6B1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 08:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795423697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pUnM1GAlqWckiyCNJNe7ZYUuta6sBgcZx+7TRlqcMxw=;
 b=FqkBY7NN7ZjySTCtiSIyyDFe9w8tBhlo2jbEW7Ldop4To78wcY6uCycYckbYO/dbe2mH4Y
 nyxlQbmwIEPJTe3HA/GxlfdLQjmMJeJHmGe3GBOLslnVC03XuDDCSDvRpk3lV4iFbaWipK
 bFs203uAxUnide5Y4hQY9SsLmtww9Go=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-xG-hKQ_uOV6U-00iWhdTwA-1; Mon, 23 Nov 2026 08:48:15 +0000
X-MC-Unique: xG-hKQ_uOV6U-00iWhdTwA-1
X-Mimecast-MFC-AGG-ID: xG-hKQ_uOV6U-00iWhdTwA_1795423694
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4a370217dcfso2644085f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 00:48:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795423694; x=1796028494;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZIoXELwpYh1o5DnGcjLjeH54OjVLR8OUMZ7+fanJt4Q=;
 b=Ly17kbuZlXQS9zzUY6PcvK3h1b+iFZh5tyXNe8KMgkhCrm9OE0Xrg6rKf4YuDGhD3S
 wOUO6wqaqLaLLY5OhGo6idyCdjZg83djwHuz3tiCV517I3vPy/36cwxXV0nSKhYnR3MJ
 1SGUJtEve/2kTKKiPcI0iSFUmrt1rSj+PJVS1siYp2tNIWnbSNnHF05m4K03AfLaUYUB
 ZEI6gXTERtVkneVNawE0Dwhs2KN2NVjb2J0kJQ2OthUEGWz6j75ygwMMiPzNawXUfbfg
 3QfOf6ePIaJAQmt7GNpk2xzBBexjTRXCl2NT7HnTOQZhXlw1m0oXPE5Rg/v3n2DZfxYa
 z4hg==
X-Forwarded-Encrypted: i=1;
 AL+hErF9CrRMF4hNyPuZr2OWann29tMm7dgEqGjVe5wrSN0zjL2HLd0SDhg4bIasRIW5y0bEeQF5xkTKw6Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8RWFKl5qZR+b9itAlhRvQb/SpsJBwu9QLjFRzUH6gP4UEie1nh
 CO+PQTMaGbRUWbUsbB8n+E/i88Ue7Ix/U6N3k0yz4jYNGfNaqwSx1AjnTvdFG3abFjQSTTPv05R
 QFTIsClWs+3PvloHV7vvEL0gNpUrwBCzvhExxHdANQIc61vJ5fF97ZskH3V8QpA4TAapdmg==
X-Gm-Gg: AZFdTZc0OP9ZIJmgAthF+v3jmeBCrkPbHm3DxadgRieY0BzqYU+rc5BXaAizjgys0cB
 jN8WoTE0XFwY9rB1R8V24pxWathwrDNllCzEMR2DMkeBZQF5rp+zVqvrnpecb8uaGGoJqcuwV3r
 tunvej+LiXOnmttI4mVuEFLhD6D/CyRgee8//mCJkqGHijnm5AwJFotxwWPvkQtuTw9V51026E+
 xyXpdGUTnjFtLd/hU21pSG+VpYllA5Vo1P+PGW7wKY/343LIfcox937/m8hkjzL6sX7hKRB9q0X
 hVBkfJeaRTtmV/HEz6TtP7oRgsWcDsBwyaAMn73W2az001jSH8C80HbQMk/f2WAHZCr+iXm10YG
 4JB+/eXv4hYsztmyswCMMskyDZVnSm8CfuvGFzZL8rICRkeAoZQH1SIB5eAERG3K7sJl1XV+gVw
 zRxdgpwLbgmlRYRxvcMs7IqiCy8tCZBmQBqqbQ9e0=
X-Received: by 2002:a05:600c:64c6:b0:4a3:598e:e7a8 with SMTP id
 5b1f17b1804b1-4bb887c2c98mr206908955e9.4.1795423693853; 
 Mon, 23 Nov 2026 00:48:13 -0800 (PST)
X-Received: by 2002:a05:600c:64c6:b0:4a3:598e:e7a8 with SMTP id
 5b1f17b1804b1-4bb887c2c98mr206908455e9.4.1795423693410; 
 Mon, 23 Nov 2026 00:48:13 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906d6a13sm155883195e9.3.2026.11.23.00.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 00:48:12 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>, Ville =?utf-8?B?U3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>, Leo Li
 <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, Mario
 Limonciello <superm1@kernel.org>, Xaver Hugl <xaver.hugl@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: Re: [PATCH v12 01/12] drm: add connector LUMINANCE property
In-Reply-To: <awP0nasqAc4pAeMR@houat>
References: <20261119-superm1-backlight-property-v12-0-89d5217d3618@amd.com>
 <20261119-superm1-backlight-property-v12-1-89d5217d3618@amd.com>
 <awB4Qe83u0l0XPKA@intel.com>
 <8713bae1-9782-41d4-b09c-f14031203e88@amd.com> <awPvoLCDeq1YFLE_@houat>
 <awPzsMWZ7e0i6i54@intel.com> <awP0nasqAc4pAeMR@houat>
Date: Mon, 23 Nov 2026 09:48:11 +0100
Message-ID: <xlv14id8rl10.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Wsk73JSdmIYOzsKMkVquEFvg7OspDy4AxniKgrfrjQM_1795423694
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Maxime Ripard <mripard@kernel.org> writes:

> On Mon, Nov 23, 2026 at 10:05:04AM +0200, Ville Syrj=C3=A4l=C3=A4 wrote:
>> On Mon, Nov 23, 2026 at 08:50:29AM +0100, Maxime Ripard wrote:
>> > On Fri, Nov 20, 2026 at 11:19:13AM -0600, Mario Limonciello wrote:
>> > >=20
>> > >=20
>> > > On 11/20/26 10:41, Ville Syrj=C3=A4l=C3=A4 wrote:
>> > > > On Thu, Nov 19, 2026 at 05:27:28PM -0600, Mario Limonciello wrote:

[...]

>> > > > > +config DRM_LUMINANCE
>> > > > > +=09bool "DRM connector luminance support"
>> > > > > +=09help
>> > > > > +=09  Expose relative luminance as an atomic DRM connector prope=
rty. Values
>> > > > > +=09  are driver-defined levels rather than absolute luminance i=
n cd/m^2.
>> > > > > +=09  Drivers provide connector helper callbacks to program thei=
r hardware;
>> > > > > +=09  the DRM core does not depend on a particular backend.
>> > > > > +
>> > > > > +=09  Drivers migrated to this interface will use it instead of =
registering
>> > > > > +=09  a legacy backlight class device. Leave this disabled to pr=
eserve the
>> > > > > +=09  de-facto userspace ABI in /sys/class/backlight.
>> > > >=20
>> > > > I don't think this will fly if it breaks the backlight class inter=
face.
>> > > > No one can actually enable this outside of some niche embedded use
>> > > > cases where backwards compatibility is not an issue. I think what
>> > > > you need is a generic backlight class implementation on top of thi=
s.
>> > > >=20
>> > >=20
>> > > The idea with this was:
>> > > 1) to get the series landed
>> > > 2) let compositors merge solutions around it.
>> > > 3) Then add backwards compatibility to kernel so we can flip the Kco=
nfig
>> > > default.
>> >=20
>> > I said this a few times already, but we keep having those discussions
>> > while the backlight sysfs handling is far from being the main point. Y=
ou
>> > should *really* consider adding support for the luminance property for
>> > something that isn't tied to that interface (like DDC/CI for HDMI), an=
d
>> > treat the sysfs API as a sysfs series.
>> >=20
>> > It looks like people just have conflicting opinions on this particular
>> > part that isn't going to solve itself easily. You should not treat thi=
s
>> > sysfs discussion as a blocker for the infrastructure work.
>>=20
>> You want to be sure backwards compatibility with the backlight
>> class is a solvable problem before you land *anything*. Otherwise
>> you might just paint yourself into a corner with no way out.
>
> I disagree. The luminance property is more useful than *just* for
> backlights but is also useful for HDMI, DP, and MIPI-DSI that would all
> use it.
>
> If that's the corner we paint ourselves into, it's still a pretty nice
> corner.
>

I agree with Maxime. Drivers can choose to not expose the luminance propert=
y
until the sysfs backward compatiblity is sorted. But this shouldn't block t=
he
core infrastructure to land, given that's useful for other drivers/use case=
s.

> Maxime

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

