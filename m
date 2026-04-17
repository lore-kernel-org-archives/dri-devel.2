Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CDCF99C63
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 21:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D91A510EAB9;
	Fri, 17 Apr 2026 21:55:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ldGg/dju";
	dkim-atps=neutral
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A32D610E2B7
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 12:36:24 +0000 (UTC)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-652fcd5a6d7so779825d50.2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 05:36:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776429384; cv=none;
 d=google.com; s=arc-20240605;
 b=ZKAec1AOwCktlyFZBBqT8EZt7JvEwNB9JgikTZme+JnJYBS8XURjJR1r9cPnvUxNSB
 NyjUnQLT/NiIrV7dWAMViDriPPyuwU9MDLskm4TCyCLkax6mrcgsioX/b3z6tXIvM3nl
 VjvfyzGEh5r7cF1dm/O4BgZ7bheS0yJ+0HYOiXjPeES9sflHz+FXqmajoRlckegqzQf6
 ladKa2EHWx7uHzXkbdg6jZ9nnqfNFUrc1yVKS40O9yqqwphDZQZQoar3i7lW2NgidHBs
 5HVaXUvGPZUoo51Qh7KrPZNJyeAQMyH+7X9qs4IOnoq9JpC/4jkBGqpaxtILZQaQPxLt
 T3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AvWeNtsSDCdBx/HW9jVIkg9xCkQ+v+rgtbFwy9bAGkw=;
 fh=8Pj442Hqz/hz7ubKBTeSBiH1+nVF8VrBZOfKktBdg2I=;
 b=d9WYZHdAz87aMuXFZl54qpfecBXE3sln+eWHzaOWNMHDiB+c8/3jaMOpznRSsNoBqq
 2auzytFc4S86UPB59QgOoOpsh1p2F8FzClt1KlkWhxthkEUotQG2hW/W61MLRpFQn2v/
 amSs5aZn4Nk61jdiOQtMlpNOnyiRnhpX2wug2p+dNx3W2+Kk/rR8N75H2sPbmcWtazBG
 o6m9WLobWvC8u2yGsUepe2NkNVQbXoy5lu6Ajfn8V3ctZuWNWZwiGLWCtLBhN7jvCT84
 mI/MyZY1wC9FHWexTKPCuSSoPEZe4amKDPCSRw89eYqmaneq7Et0J5jPASAv1Ol7DEaP
 gfrQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776429384; x=1777034184; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AvWeNtsSDCdBx/HW9jVIkg9xCkQ+v+rgtbFwy9bAGkw=;
 b=ldGg/djuAjFeOJ8sMSIYFdGQOHvTAvgb4jnEE59MdZfT/2RegS0DvfaDkNLkjqWxDJ
 tRSSg4mxMq/gCcMHeHnQteyWwBkdw4KKofH1zF5UWvW9l8Mv+EOYkfR4N/a9dH9sBALr
 JEKrbwHR+d0dTLqpcQDBf4154Nj42iqAlXMSu56F6FWMbCUSnNx7E9IO5ylIIGI5ORIX
 P2Gf8VQj5VBtUKL8vaqBTFQ42lBhSBYeyTkiCKHacFg4Tte/yIdCMNnne8dran8ow6Ej
 X/utTQMrYz5rxPq/ArnsVjwj9wgQgcDrTYz9QPSZNQTz+0BaT4KrFm/HxVzOuGR6pe8f
 kgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776429384; x=1777034184;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AvWeNtsSDCdBx/HW9jVIkg9xCkQ+v+rgtbFwy9bAGkw=;
 b=ZYddwgNclJVFfe7AuECtKPUebgi6Mdp1CdAJlPTchXL5DDGaewcjVWLTfgoYOJPP80
 GFO83dS0lHjuxC/EoS7t7DpJxQCB/WVe/MAtJJSWj/Sa629cqRyHFjMPgA95PB2J6w+R
 TYmuALtGD5VshSBGDo2wtuuxmspnJR+grgtcY4KAx0BDaAkHAKzKXxUGKY3yEJsm8+yT
 bNudLMNRwO5CERVJBGLRvQobJM18w0bExu86/QzSJoD+dyl4DYGSVJr1Hc0ZkfkRE9Ko
 Brok0IL/+QWeiezFoxs5qoUxQ9/wbeQih06Ss1MmuQE3du9co3KQEow3TwddyCierRsE
 BdgQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GmgmYRYVcgJWGLFtgOCy5OGNvbm72Abqv59+wNA7LMFWF4zWOqxmgGH3phI6IMKF0LOEklkel0Xg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRBF7ghg8YDg5wQ1gd/Ifv76zO7mz7V/xfkP5dl0/4zXJFAP6N
 gUBPGM/Ei4AryuZbt0JFMqRhlkuskmqiJFhL7MS0EX4jTNuS5t+pPu3HPARe1p3pD1sNioxQTq9
 XnAW3/yoVagb+UxPybfWee8wB+BAwJAA=
X-Gm-Gg: AeBDietVRGGCC2p4ahOPs1jglhJf7Dn9YILWCod1H5gxriCui8+0xn95muLgdbUwRpB
 S5KE9TSNb1NnwJw3liv8XiBtHytfLsSm5WX7dlWbtVCQg4garM9TwChQq7E/mjgUZbqDioZQWoe
 Nd9QK+eDzgGbRXQ+KgL4/nlosgTKjPDBkG32nJP/4HOnJc/3XW/zDsugbPJHQUUFP7IPdl6N8l5
 8Wko1CxFH/uCYQb/QMfH6LIETiUhux80L2DSB6pBTxAm7E2gr2DA+lLC7J0KtKVQWRQAMbpVB2t
 rspjBC9AdYelrhihaFZO+xSG78wIWs8BGgkqFE6mihejweLku1cViP/NjvVu/QgpSCEX6Q==
X-Received: by 2002:a05:690e:155a:20b0:651:ce1e:4e82 with SMTP id
 956f58d0204a3-653107f8e21mr1891836d50.3.1776429383627; Fri, 17 Apr 2026
 05:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com>
 <CAHijbEXcrhB=ipaa4-DPD8atQYCkokGfueLafwkeQpxCBkc0bw@mail.gmail.com>
 <7472926.DvuYhMxLoT@workhorse>
 <CAHijbEViae+=Fcnh3v0ODxwTPUaRgU1H4OVGM3VFPSLMPzJzOA@mail.gmail.com>
 <1297f150-b3b4-4a53-ad05-ecb05b8ec420@mailbox.org>
 <aeISNnh6IWGA7P8C@intel.com>
In-Reply-To: <aeISNnh6IWGA7P8C@intel.com>
From: Julian Orth <ju.orth@gmail.com>
Date: Fri, 17 Apr 2026 14:36:11 +0200
X-Gm-Features: AQROBzBsykWATxp_4Dhlwvae7E_j9sX8dyoeCleqlXrVYqQjj3mph9sqNlqrjKY
Message-ID: <CAHijbEW7ZUSAf4HWBGnzC5fOYT9cbQNPNkzL3rL5w8k_-bME3w@mail.gmail.com>
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
> The kernel can of course then decide that the full modeset is not
> actually required and skip the modeset part during the commit. But
> userspace cannot make that determination.
>
> I suppose what we could maybe do there to force userspace's hand is set
> the link-status to bad already when the thing gets disconnected, and keep
> it like that until a full disable+re-enable cycle has been done. Then
> userspace could not think that the ->disconnect->reconnect is a NOP
> (which I still think is incorrect behaviour).

I don't think the kernel can make the assumption that userspace sees
any udev events. For example, say such a disconnect/reconnect cycle
happens that leaves the connector in a state that would require two
modeset. Nobody acts on these modesets and some time later the
compositor starts. Obviously the compositor is not going to receive
any udev events for the disconnect/reconnect cycle that happened long
ago. This would leave the connector in a permanently unusable state.

>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel
