Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CB8F99C63
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 21:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DCFD10EAB3;
	Fri, 17 Apr 2026 21:55:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iFokpvu/";
	dkim-atps=neutral
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com
 [74.125.224.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29C8310E2AC
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 12:18:42 +0000 (UTC)
Received: by mail-yx1-f51.google.com with SMTP id
 956f58d0204a3-64eaf8aa893so478126d50.3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 05:18:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776428321; cv=none;
 d=google.com; s=arc-20240605;
 b=T+vctrXdNpNdupKL9HUN9WwmRBJxXD51G8DXQuidg6EAGOAMTL9zGjJYTaqNRUBtri
 5XNL4mihKcQsQjPAu4a57LWYdI2ptPzCP3b6spe3dBmnuuRFDZ2PBvaNFiK2ANlBW3Mz
 DN6gEOsnPDPjdmg1S/e9uosZpJ6I3SwN6nSYbu6/uCObQ+JpHdIMl+Mn0ZP3ddunGMWS
 0LXt/KOBqLmFmip+ayJCMzGUelibv5+tk5uydESiWwGL0quBiQj9WXXqWtON3gbmZgOq
 /nmcHD19PC6rq5mQHfbqvt4VPq7g+bXDFUlwUZAUQgPWyQV19erT0TK0DIOIc8xNzHmJ
 Dngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SVbVVT/pTu8XYbWjBmeh7tdkypyk9XNWT6IkWwbvxR0=;
 fh=HE8rjNOtYOTNpH4bjbSi64FdkewinLgYmUNH+zx6G6Y=;
 b=Wa7sb9lvIaSuiIXes7EW0RF5TEO//6FDSfxOj9T+AzNRS//kaIP4RB8ai4FGlewsdp
 YHfGqsqZWw3y1QCGBTKXfsPJ45Cj7u/+0528PCbqu1++DlKj8XVJxUi4y2wm25dPJTSI
 hnXE/+SBFEB25ptsnNE2ENaffue6uRxKDEcJibLmtAdUVmQT2DodoTIlpbuZZwBf7mo4
 SVo3fKyfsBV1gHt/42iDzaPZQ3n6XwW367O6xrjILdwlZDXQP2nmxrv5eYgSUL5rmCa1
 ClEjj/llSuvOASPgUEXM1A7xjzPdy3Hwl0s7d9zNucSRxi/OVp5CkLIn5MILpTcayWkA
 MsIA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776428321; x=1777033121; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SVbVVT/pTu8XYbWjBmeh7tdkypyk9XNWT6IkWwbvxR0=;
 b=iFokpvu/+tbwADmXfDnDGuf+50c23zcUKUtmNYfcYSO5FWaJfSWhtcYDzUJ54pcvLa
 Z+6bq6hS4ufohJkgDVlpjXdc+lFXp7qk+QJDVu61dW+ZtyaIapsxGS633h0xIxBJ//bV
 MSaE6F8IbNzojtm4WjvSQLZt9ZH/zWBChjRx2Y+uZStUxuekBknAq3lQwfBqmu10oExd
 l++tVBdJNlGaGoeNXVXHIVE3dHQCTROxiFGM8PLQJZPI5+DOocVOWzZxDzcoInv3joI7
 5F41/T1FaP323SXH57F5tRwLBBIJXR5+VoUAO0ZWMqPgeXvlXtvRglhK1dU8r+LX8oWj
 mRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776428321; x=1777033121;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SVbVVT/pTu8XYbWjBmeh7tdkypyk9XNWT6IkWwbvxR0=;
 b=fyPLEiRTcDGG6+VCCJQJWai9w/5ObiNibYwi79EAH49NUMrJP4SvZzkFdWAn+eXn+c
 dQg/yiLOix73CjBKjXjPF+Z6mXp3UOQ3YFeNgjZVS9rflS8PF7jBGEstyLtWD0KE/S/e
 1YX4ZZnzoVFRSzEPNkt7wVMSzw3ojRFRAnImQIYNXyK4GYqyMUG1SkYobhkieUYEeRYu
 5oojvs5G8U0kCRyE62lpyUPof48tGoqBznBh//Sjkzai1jZ25rQJuPLwS4Jki+Cao+fj
 3o5of6ALlWGhMnZF9Yk6ZxGRB8d/4Zgw5OrVyeQNsImOsvqlyZI4KB5H4nlJzzXrQZjH
 sdLQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8QHa6pFml/HUO8kJlVbQDWXjwh50xvLlK76aHmg8OL50j2EtuXWBl17l8pVoNUAUd2yYjuM93JhFE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywp4oS9nBRf3AeiKciY/bVYQ+ZQTRytGfZv8r8vF0d8paZouKfx
 ZHr4Dcvzf97Se0ep8/Q5qk/d29YVletzVA6hIcAFRTxNUz3nkM6fQhuZhvs4cR4sTB33GlVpYsu
 WvtkyyVhppZ+A7fRMffBftcof50V7yuo=
X-Gm-Gg: AeBDievyfdVwzFKbQ9sAv2vcckQt2VlSRYfkrtnq3cfkxn/2JGWTBrK9pscwbHisVbY
 wuWgVwOT1lJ1l3P+BWtEjNOJeqH2BivNxj7KOeM/2TUFtOE1lxp33s/Y6m/zaZFlu2x/GkvW0h6
 JzlfNwR29PoUob7OKsk2eqFNQT46GcEMFGsQIyGS27uxr0nSXv5WZK+H5t0RpQwBXOB5vw2NPwz
 OM3dwqnlcKRsmtNmfz4CvNMuQTIXD6NQ60zJpbSOqvkcltrC+ByKQZRScOfZWkQykxeRrR+dSoP
 ftLmX2zA/MBdRmhbvddbEhGZAarNpVkphXc6XyY7sCgyDec3jeQ4t3dlLfs=
X-Received: by 2002:a05:690e:dcd:b0:64e:d610:71cf with SMTP id
 956f58d0204a3-65310b56e9fmr2406291d50.58.1776428321028; Fri, 17 Apr 2026
 05:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com>
 <CAHijbEXcrhB=ipaa4-DPD8atQYCkokGfueLafwkeQpxCBkc0bw@mail.gmail.com>
 <7472926.DvuYhMxLoT@workhorse>
 <CAHijbEViae+=Fcnh3v0ODxwTPUaRgU1H4OVGM3VFPSLMPzJzOA@mail.gmail.com>
 <1297f150-b3b4-4a53-ad05-ecb05b8ec420@mailbox.org>
 <aeISNnh6IWGA7P8C@intel.com>
In-Reply-To: <aeISNnh6IWGA7P8C@intel.com>
From: Julian Orth <ju.orth@gmail.com>
Date: Fri, 17 Apr 2026 14:18:29 +0200
X-Gm-Features: AQROBzBgmKJHrijC1xijlucn_ZLH51yx-q8EK-bG-7hZF5Q558K1IOplMnVlicY
Message-ID: <CAHijbEXQcLoy8krX4DP4LgZ3WLdwPLwDXyv_ww097HvtefAZKQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v7 0/2] Pass down hot-plug CONNECTOR ID to
 user-space
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, Daniel Stone <daniel.stone@collabora.com>,
 Ian Forbes <ian.forbes@broadcom.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 wayland-devel@lists.freedesktop.org, Marius Vlad <marius.vlad@collabora.com>, 
 Imre Deak <imre.deak@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 17 Apr 2026 21:55:06 +0000
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

On Fri, Apr 17, 2026 at 12:58=E2=80=AFPM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Fri, Apr 17, 2026 at 09:49:36AM +0200, Michel D=C3=A4nzer wrote:
> > On 4/16/26 15:16, Julian Orth wrote:
> > > On Thu, Apr 16, 2026 at 9:46=E2=80=AFAM Nicolas Frattaroli
> > > <nicolas.frattaroli@collabora.com> wrote:
> > >> On Wednesday, 15 April 2026 20:57:53 Central European Summer Time Ju=
lian Orth wrote:
> > >>> On Wed, Apr 15, 2026 at 8:19=E2=80=AFPM Nicolas Frattaroli
> > >>> <nicolas.frattaroli@collabora.com> wrote:
> > >>>>
> > >>>> This series addresses a shortcoming whereby a hot plug event is se=
nt
> > >>>> without it being passed the actual connector that caused it. This =
takes
> > >>>> into consideration both the polling path and the HPD (Hot Plug Det=
ect)
> > >>>> path. It also adds support for the vkms driver (using ConfigFS) fo=
r
> > >>>> propagating the connector ID when changing the connector's status.
> > >>>>
> > >>>> The motivation is that user-space applications such as Weston woul=
d
> > >>>> previously receive non-connector-specific hotplug events, and then=
 have
> > >>>> to figure out themselves which connector needs to have a modeset
> > >>>> executed on. This notably did not work when the hotplug events cam=
e in
> > >>>> too fast, resulting in Weston missing an on-off-on transition of a
> > >>>> connector, seeing that its state was unchanged from "on" so can't =
be the
> > >>>> one that was hotplugged, and skipping reinitialising it as it look=
s
> > >>>> through the other connectors that could've caused it.
> > >>>
> > >>> Have you considered adding a u64 serial number as a DRM connector
> > >>> property that is incremented every time the connector changes in so=
me
> > >>> way? Userspace could then check this serial number to see if the
> > >>> connector has changed since the last time it queried the serial
> > >>> number.
> > >>
> > >> The connector internally already has an epoch_counter member which
> > >> could be used for this. However, for the particular thing this
> > >> series fixes, I don't think exposing it through the uAPI is necessar=
y
> > >> or desirable. Sending hotplug events specific to the connector does
> > >> not need any additional handling on the userspace side as long as it
> > >> already listens to the per-connector hotplug events in order to
> > >> avoid the pitfall described in the cover letter.
> > >
> > > I currently do not handle per-connector hotplug events. Instead,
> > > whenever I get a UDEV change event for a device, I re-fetch the entir=
e
> > > kernel state for the device. That is
> > >
> > > - DRM_IOCTL_MODE_GETRESOURCES
> > > - DRM_IOCTL_MODE_OBJ_GETPROPERTIES for each connector, crtc, plane
> > > - DRM_IOCTL_MODE_GETCONNECTOR for each connector
> > > - DRM_IOCTL_MODE_GETPROPERTY for each connector property
> > > - DRM_IOCTL_MODE_GETPROPBLOB for the EDID
> > >
> > > Once I have the new state, I compare it against the desired composito=
r
> > > state and perform a modeset if necessary.
> >
> > mutter is doing something similar as well.
> >
> >
> > Note that some are arguing a modeset is always required after a hotplug=
 event, even if the state hasn't changed.
> >
> > The most convincing argument I've seen is the scenario of a GPU reset, =
after which a modeset is required to light up the displays again.
>
> GPU reset should relight the display on its own really. That's what
> i915 does, albeit somewhat badly at the moment.
>
> > A hotplug event seems the only mechanism available for the kernel to re=
quest a modeset from the compositor. (The kernel may not be able to reliabl=
y do the modeset on its own, e.g. due to interactions with user-space atomi=
c commits)
>
> There's nothing preventing the kernel from doing extra atomic
> commits whenever it wants. But if you want to punt the thing to
> userspace then the kernel must set the link-status property to
> bad, and then fire the hotplug uevent.
>
> > If this "modeset required after hotplug event" rule is confirmed, it me=
ans that after a hotplug event without connector ID, the compositor must do=
 a modeset for all connectors.
>
> Only for connectors where things changed, or the link-status shows bad.
>
> >
> >
> > P.S. https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/14420#=
note_2984697 even argued that two modesets are required after a hotplug eve=
nt, one which turns things off and another one which turns them on again. I=
 don't agree with that though, a single modeset should suffice.
>
> The actual argument is that you should not defer the hotplug
> handling when things get disconnected, mainly because of crap type-c
> firmware.
>
> I think the userspace behaviour there was that you get a disconnected,
> defer processing it, and then you get a reconnect, and then decide that
> nothing actually changed and a modeset is not needed after all. That is
> not correct IMO. Clearly a ->disconnect->reconnect should count as a
> change in the connector's state, and a full modeset is thus required.

The connector state, AIUI from userspace, is the set of all DRM
connector properties. If the true state changes in a way that requires
userspace to act but the DRM properties are unchanged, then I would
argue that that is a kernel bug.

The link-status property seems like it is perfect for this.

> The kernel can of course then decide that the full modeset is not
> actually required and skip the modeset part during the commit. But
> userspace cannot make that determination.
>
> I suppose what we could maybe do there to force userspace's hand is set
> the link-status to bad already when the thing gets disconnected, and keep
> it like that until a full disable+re-enable cycle has been done. Then
> userspace could not think that the ->disconnect->reconnect is a NOP
> (which I still think is incorrect behaviour).
>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel
