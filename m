Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF7E60A381E
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=VzJ2Iqkf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5968112A3A;
	Fri, 20 Nov 2026 13:11:22 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1522E112A36
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:11:15 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 845091A1748;
 Fri, 20 Nov 2026 13:11:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4797E601B9;
 Fri, 20 Nov 2026 13:11:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 40E3311BC0089; Fri, 20 Nov 2026 14:11:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795180271; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=uUoED0cDbcz0KfAteKUfnKCWp0vpsdbr7J4+2b7eRPI=;
 b=VzJ2Iqkf6sZd0IczGzHfI/apvv15DT1Hdj5+U5RNpmAf93PGyoh41fNj6NG0jumXvWitu2
 t8qGQy08hBxYViD5dl2huEMrkGQ657tqh1KNZDfYj/t70+rqTsKM9bbkmT7TZVOmHO13os
 WTp4OcGuFESxx7gRJseneWHHpSe1nASKRPScDIjDbObkYpwF2IVaLc1vwFBvlD8RbhV8w2
 O+F/N3I8ZK9/T/ShgrvssKdxa8R2IQdBYMqlPqbE+m8sfgVC5/uvpoU8g9FeGI1k8RoJ1y
 Scl/POdT6KuJLFmAYxQjQ1PUUBuQkhulTeO+R2K9cN3hGlCC//dCH8JLPyxc6A==
From: Benjamin Robin <benjamin.robin@bootlin.com>
To: "Kumar, Abhash" <a-kumar2@ti.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 s-jain1@ti.com, y-d@ti.com, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, devarsht@ti.com,
 u-kumar1@ti.com, sjakhade@cadence.com
Subject: Re: [PATCH v3] drm/bridge: cdns-mhdp8546: Add suspend resume support
 to the bridge driver
Date: Fri, 20 Nov 2026 14:11:04 +0100
Message-ID: <oN6DWNeSTbeo_5NexR3j3A@bootlin.com>
In-Reply-To: <73ebfed6-a3ad-4134-a8b9-d17213442fa9@ideasonboard.com>
References: <20260601095041.3042950-1-a-kumar2@ti.com>
 <f1089720-2a8e-4f0f-b995-fc7ef0836da0@ti.com>
 <73ebfed6-a3ad-4134-a8b9-d17213442fa9@ideasonboard.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wednesday, October 14, 2026 at 3:25=E2=80=AFPM, Tomi Valkeinen wrote:
> Hi,
>=20
> On 06/10/2026 11:49, Kumar, Abhash wrote:
> > Hi,
> >=20
> > On 10/1/2026 1:10 PM, Tomi Valkeinen wrote:
> >> Hi,
> >>
> >> On 29/06/2026 13:32, abhash wrote:
> >>>
> >>> Hi Tomi,
> >>>
> >>> Thanks for the review.
> >>>
> >>> On 18/06/26 14:19, Tomi Valkeinen wrote:
> >>>> Hi,
> >>>>
> >>>> On 01/06/2026 12:50, Abhash Kumar Jha wrote:
> >>>>> Add system suspend and resume hooks to the cdns-mhdp8546 bridge=20
> >>>>> driver.
> >>>>>
> >>>>> While resuming we either load the firmware or activate it. Firmware
> >>>>> is loaded only when resuming from a successful suspend-resume cycle.
> >>>>
> >>>> It's not clear from the patch if this is a fix or improvement. It=20
> >>>> sounds a bit like a fix, but it doesn't mention any kind of issue in=
=20
> >>>> the driver. So, why is this patch needed?
> >>>
> >>> The driver lacked support for suspend-resume as stated in the todo on=
=20
> >>> the driver, So the patch adds this improvement.
> >>
> >> The patch doesn't remove any todo lines. Was that just a miss, or is=20
> >> there more to add wrt. PM?
> > Yeah, i will remove the TODO in the next revision.
> >>
> >> What does it mean it didn't support PM? Does the driver not work after=
=20
> >> suspend-resume cycle? Or does the driver prevent a proper suspend?=20
> >=20
> > When we resume, the cdns_mhdp_link_up function fails.
> >=20
> > Failure log at resume:
> >=20
> > [  55.329452] tidss 4a00000.dss: PM: calling tidss_resume [tidss] @=20
> > 1053, parent: bus@100000
> >=20
> > [ 183.381228] cdns-mhdp8546 a000000.bridge: Failed to read receiver=20
> > capabilities
> >=20
> > [ 191.391548] cdns-mhdp8546 a000000.bridge: get block[0] edid failed: -=
110
> >=20
> > [ 193.392713] cdns-mhdp8546 a000000.bridge: Failed to read register
> >=20
> > [ 261.415544] cdns-mhdp8546 a000000.bridge: Failed to read register
> >=20
> > [ 263.946153] tidss 4a00000.dss: Timeout waiting for framedone on crtc 0
> >=20
> > [ 391.991358] cdns-mhdp8546 a000000.bridge: Failed to read receiver=20
> > capabilities
> >=20
> > [ 392.026847] tidss 4a00000.dss: PM: tidss_resume [tidss] returned 0=20
> > after 336689133 usecs
> >=20
> > I guess it is fair to say that the driver does not work after suspend-=
=20
> > resume cycle.
> >=20
> >>>>> If resuming due to an aborted suspend, loading the firmware is not
> >>>>> possible because the uCPU's IMEM is only accessible after a reset=20
> >>>>> and the
> >>>>> bridge has not gone through a reset in this case. Hence, Activate t=
he
> >>>>> firmware that is already loaded.
> >>>>>
> >>>>> Use genpd_notifier to get the power domain status of the bridge and
> >>>>> accordingly load the firmware.
> >>>>>
> >>>>> Additionally, introduce phy_power_off/on to control the power to=20
> >>>>> the phy.
> >>>>
> >>>> If you write "also" or "additionally" or such in a commit desc, you=
=20
> >>>> should stop and think if that part should actually be a separate=20
> >>>> patch. Also, why is that change needed?=20
> >>>
> >>> The phy device could be powered off while resuming. So we are=20
> >>> explicitly powering it on.
> >>>
> >>> The phy driver api also recommends to always call phy_init() first=20
> >>> followed by a phy_power_on().
> >>>
> >>> "Some PHY drivers may not implement `phy_init` or `phy_power_on`, but=
=20
> >>> controllers should always call these functions to be compatible with=
=20
> >>> other PHYs"
> >>
> >> It still sounds like a separate patch to me: the current driver is=20
> >> missing phy_power_on/off from the probe/remove functions.
> >>
> > I will add that as a separate patch
> >>>> Overall, this sounds fragile/hacky to me.
> >>>>
> >>>> The first thing is that usually you shouldn't use system suspend/=20
> >>>> resume in a bridge driver. When a system suspend happend, the=20
> >>>> display pipeline will be disabled, so this driver will get an=20
> >>>> atomic_disable() call, and enable when resuming. You can use runtime=
=20
> >>>> PM hooks if you need resume/suspend hooks.
> >>>>
> >>> Thanks for the suggestion, I will use the runtime PM instead.
> >>>
> >>>> The second thing is the PD notifier. Is there really no way we can=20
> >>>> see the state from the MDHP IP registers?=20
> >>>
> >>> The other way that i found was to read the MHDP KEEP_ALIVE_p register=
=20
> >>> twice to know if the firmware is incrementing the counter.
> >>>
> >>> Based on that we can decide if the bridge is active or not. Do you=20
> >>> think this approach would be okay over the PD notifier?
> >> I think it would be best to be able somehow to ask this from the HW to=
=20
> >> find the true state, instead of guessing it second hand from the PD=20
> >> notifier (which also doesn't tell us the initial HW state at probe).
> >>
> >> KEEP_ALIVE_p sounds fine. Or what does the mdhp IP do if you send a=20
> >> message to the firmware when it's not up? Say, if you always do=20
> >> cdns_mhdp_set_firmware_active, what happens if the FW has not been=20
> >> loaded? I would guess that there's a timeout, and that could be used=20
> >> to find out the FW is not up.
> >>
> > Yes, there is a 2 second timeout if we send a message and the firmware=
=20
> > is not up. I would prefer the KEEP_ALIVE_p method, as that is a better=
=20
> > indication of the
>=20
> But that's a driver imposed timeout, and it sounds rather arbitrary (and=
=20
> bad). How quickly does the firmware usually reply? What would be the=20
> situation where the firmware takes e.g. 1.5s to reply? I would guess=20
> that if the FW updates the KEEP_ALIVE_p every N us, it would also reply=20
> to us in that time.
>=20
> In any case, changing MAILBOX_TIMEOUT_US would be another patch.=20
> KEEP_ALIVE_p sounds fine if you know how often the FW updates it.
>=20
>   Tomi

Hi,

I wanted to check on the status of this series, as I'm quite interested
in it since my series [1] depends on it.

=46or my use case, the suspend/resume support isn't essential, but the
calls to phy_power_on() and phy_power_off() are.

Thanks for any update.

[1] https://lore.kernel.org/all/20261120-phy-cadence-torrent-ng-v1-0-da2db7=
125cd7@bootlin.com/T/

=2D-=20
Benjamin Robin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



