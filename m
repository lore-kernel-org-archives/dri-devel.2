Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685E9F436AE
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA24810E25D;
	Fri, 17 Apr 2026 14:26:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aFXqNx1t";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DCA310E25D
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 14:26:09 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2d9472c97dbso69087eec.3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 07:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776435968; cv=none;
 d=google.com; s=arc-20240605;
 b=bWO9/IR+4vrQOyLd+WCb4v1UwKmzenD49w6PzEE3rL+0sdKoDpjf8e2oRkIZbVnhK0
 MSP0nLWwkPCLgjV7PnA5Qjq5DNr0WNEHc4sX09x3uLVm8xBgmIxfjT9PZTLT4ACX5LcS
 tMC+FtRCdjUoYp2LH+1EvzUIHg74aPHC5MFwZxlRCxmZ74jwLFt06DLISOqHPHe/lKhx
 4IRuK14oGP/X7lrmZT8N2zS94R79ekb71oK789jDTbnbFhvOcEGEIIY8C94IclkmJrSA
 YOgoydb8Z+1ry3waJZ6fZts6SwPnKTLobnWHyqSdfW65vaI56RnqvCvZ8SRVqh87VlQF
 5nSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/iIeuIEAqweGkBF7/CekFg8CQetIkSYQB7ggtHht1c8=;
 fh=kd5K7vvtY4O1NHnyx6aQS6IkuHEFGM9guQfEl9yrWzk=;
 b=TGxWA+1SmTytswCXX223KMu4VdtH8ATRp19jLGMm2nmvBn0Es97t8KQUhR5U8kXhb+
 hvs1CeCFpsAJd5zrroC2XF+EVnIYUXXkeWFqTUlsTGllvamkNc4rnIdJAQZfBW6oX4WY
 dq4q7BkrX2t8DiANO8Iw3fdQC4Ac7HGNf7RO1eOLKcf7yjiH27CDKFcNS5RzRdeB/FIz
 3XtcGjH1djeWtit6pVg8dHiUQ8h6ATHEF/H/ZTrZG9z5sLiBQg/yf3d8NB8MUjawcI6x
 3/wVtsuEDyOq/sdjM4gWEpbHxc1FBAIWWa/0U2gX3tzDKHZ6v1L0mQwUX+tEUR8X2+WJ
 9Aug==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776435968; x=1777040768; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/iIeuIEAqweGkBF7/CekFg8CQetIkSYQB7ggtHht1c8=;
 b=aFXqNx1tu/7Ex/gaXjIAPtGHiNjeM5ZdFA6JUPVjuIdf+i74rKi4cC1PXXIhMH7gzk
 crGZl7TrV4tZ2wmL0nwGcsRMg3ZQ7nS7aGYbj+Db1CBhhabW+tYJLKn1B+fL9V8SJBom
 H9w+X1ke1k48Clpb6oNyRV0geL4RQoSKJpiE7IiSvH7Abk4RzmhFWaslb8/+KuIuBrQE
 SafDZKAi2f+BQSPVmpQrk0jsrNKObvPwd0N2uJyRTIFEoiH+pnieSXzcpaQM+DtwLWPf
 +JwjWQa+BlofEzcqB/kK2xC5MsLpBvQQD23HC2yKwlP1/XZE1DORDXxdbRx3WVD94vTk
 RVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776435968; x=1777040768;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/iIeuIEAqweGkBF7/CekFg8CQetIkSYQB7ggtHht1c8=;
 b=rSzIYNbTSZMcXclPAzhUtYFC3CcBtxs1EQX1i/cfQ4XtiEeZU0+ZcNCxaEjj0/EOYo
 hNvMllgcfgc1djdxtFwGRSiqpD6XzCmEKAbvZcwibOMP3jRraDl1gveOv1Pj3laEzXyi
 yuzlmor4Qw/827S1+3/mT8MYUsinwcQibbRvjS4EQdtYQ27p0kJ5w1ZmjvaACAm+dcrY
 8/UqTwfozFG1qaoZ0mHZgGe3QBZ+Zmeb0OszRw7H2O4QcoBlNzeNYElJ4djoq/rqyxlR
 NGV/IyeC+FmxogfEZ82/6+ZPoJIIeGKd0QB8VqKaiWjw07oMcMMEdVoh4pWwPqfPoc91
 GL+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wfh8tThYHuddW2Sq8bJfBZwmUV/dLg1A6QyZ8IHqLMvAkiOgzGXKpnxcdfNfuZD56wcFKiErWQu8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yybll0PoPvqZg7/nv8gedw4HDtLtlyT453CMyPl3x+gr85JBIeH
 WP1gVvXu1svtzItpwFLChL8molgRmsgbFU3JVPZPnShrLn4G5yEEVz/pKwtWZNDblNd9LlHi/z3
 2Z3VP6+T992QMftzEBDgMPB39cRwxnwQ=
X-Gm-Gg: AeBDietvIjltxLhn31IKgO68G3j7iGclPoWTOBFelRpL7iPgZJ4qwgXzA6/EsHigGYO
 A1xMt7p5AQj74Jhr5QDg3k+1PfW+DETvcPG1nzZhLBFKtea6nBnXeFo3ihzAkcnC9Taoe3GFLaP
 tns7lJ+O2TdZ92LYm0RXxiM/f2cbzYEhyRRYtgmMMysL0j3GYbJzG5ExetNAElafF70y7cOprpV
 QPWKri0/G371c3RMUrUsF4UFKPELdFTJYomGfxuLy9sAW/Wq4PS4+hrfw2A6mgkRPY6YQjZ6NmG
 9ZTsiUiZ+8C6508+BNKPmK6zRcb5IAhDjpYol7dXfQZr21mdDljtBlo0h81h3ysjIxWudDPldRj
 KKsS3
X-Received: by 2002:a05:7022:6889:b0:124:af80:9d0c with SMTP id
 a92af1059eb24-12c73d26cc4mr544420c88.0.1776435968142; Fri, 17 Apr 2026
 07:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com>
 <CAHijbEXcrhB=ipaa4-DPD8atQYCkokGfueLafwkeQpxCBkc0bw@mail.gmail.com>
 <7472926.DvuYhMxLoT@workhorse>
 <CAHijbEViae+=Fcnh3v0ODxwTPUaRgU1H4OVGM3VFPSLMPzJzOA@mail.gmail.com>
 <1297f150-b3b4-4a53-ad05-ecb05b8ec420@mailbox.org>
In-Reply-To: <1297f150-b3b4-4a53-ad05-ecb05b8ec420@mailbox.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Apr 2026 10:25:55 -0400
X-Gm-Features: AQROBzDyVBnbcJ1W2JYvXu9K2ogpGALGGD5qRUbyqkVurx9-C1rEFwcqhXkXRUk
Message-ID: <CADnq5_NRY1h6Z3R3faDPHfHqZL7ZkDPKpOFk7WXSm09DsDH5zw@mail.gmail.com>
Subject: Re: [PATCH RESEND v7 0/2] Pass down hot-plug CONNECTOR ID to
 user-space
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: Julian Orth <ju.orth@gmail.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
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
 wayland-devel@lists.freedesktop.org, Marius Vlad <marius.vlad@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Apr 17, 2026 at 3:49=E2=80=AFAM Michel D=C3=A4nzer
<michel.daenzer@mailbox.org> wrote:
>
> On 4/16/26 15:16, Julian Orth wrote:
> > On Thu, Apr 16, 2026 at 9:46=E2=80=AFAM Nicolas Frattaroli
> > <nicolas.frattaroli@collabora.com> wrote:
> >> On Wednesday, 15 April 2026 20:57:53 Central European Summer Time Juli=
an Orth wrote:
> >>> On Wed, Apr 15, 2026 at 8:19=E2=80=AFPM Nicolas Frattaroli
> >>> <nicolas.frattaroli@collabora.com> wrote:
> >>>>
> >>>> This series addresses a shortcoming whereby a hot plug event is sent
> >>>> without it being passed the actual connector that caused it. This ta=
kes
> >>>> into consideration both the polling path and the HPD (Hot Plug Detec=
t)
> >>>> path. It also adds support for the vkms driver (using ConfigFS) for
> >>>> propagating the connector ID when changing the connector's status.
> >>>>
> >>>> The motivation is that user-space applications such as Weston would
> >>>> previously receive non-connector-specific hotplug events, and then h=
ave
> >>>> to figure out themselves which connector needs to have a modeset
> >>>> executed on. This notably did not work when the hotplug events came =
in
> >>>> too fast, resulting in Weston missing an on-off-on transition of a
> >>>> connector, seeing that its state was unchanged from "on" so can't be=
 the
> >>>> one that was hotplugged, and skipping reinitialising it as it looks
> >>>> through the other connectors that could've caused it.
> >>>
> >>> Have you considered adding a u64 serial number as a DRM connector
> >>> property that is incremented every time the connector changes in some
> >>> way? Userspace could then check this serial number to see if the
> >>> connector has changed since the last time it queried the serial
> >>> number.
> >>
> >> The connector internally already has an epoch_counter member which
> >> could be used for this. However, for the particular thing this
> >> series fixes, I don't think exposing it through the uAPI is necessary
> >> or desirable. Sending hotplug events specific to the connector does
> >> not need any additional handling on the userspace side as long as it
> >> already listens to the per-connector hotplug events in order to
> >> avoid the pitfall described in the cover letter.
> >
> > I currently do not handle per-connector hotplug events. Instead,
> > whenever I get a UDEV change event for a device, I re-fetch the entire
> > kernel state for the device. That is
> >
> > - DRM_IOCTL_MODE_GETRESOURCES
> > - DRM_IOCTL_MODE_OBJ_GETPROPERTIES for each connector, crtc, plane
> > - DRM_IOCTL_MODE_GETCONNECTOR for each connector
> > - DRM_IOCTL_MODE_GETPROPERTY for each connector property
> > - DRM_IOCTL_MODE_GETPROPBLOB for the EDID
> >
> > Once I have the new state, I compare it against the desired compositor
> > state and perform a modeset if necessary.
>
> mutter is doing something similar as well.
>
>
> Note that some are arguing a modeset is always required after a hotplug e=
vent, even if the state hasn't changed.
>
> The most convincing argument I've seen is the scenario of a GPU reset, af=
ter which a modeset is required to light up the displays again. A hotplug e=
vent seems the only mechanism available for the kernel to request a modeset=
 from the compositor. (The kernel may not be able to reliably do the modese=
t on its own, e.g. due to interactions with user-space atomic commits)
>
>
> If this "modeset required after hotplug event" rule is confirmed, it mean=
s that after a hotplug event without connector ID, the compositor must do a=
 modeset for all connectors.
>

One thing we've run into is how to deal with hotplugs over suspend.
If you suspend your system, amdgpu sends a hotplug event on resume in
case anything got changed while the system was suspended.  However, we
can also suspend the driver at runtime and we use the same path so
when the driver runtime resumes, it also sends a hotplug event.  This
is probably fine in most cases, but there are some problematic corner
cases.  E.g., while the GPU is runtime suspended, if the monitors are
in DPMS off, and then a rendering command comes in or something else
that wakes the GPU, we send a hotplug event on resume and then
userspace lights up the monitors again which is not what the user
wants if the monitors are in DPMS off and the topology hasn't changed.

Alex

>
> P.S. https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/14420#no=
te_2984697 even argued that two modesets are required after a hotplug event=
, one which turns things off and another one which turns them on again. I d=
on't agree with that though, a single modeset should suffice.
>
>
> --
> Earthling Michel D=C3=A4nzer       \        GNOME / Xwayland / Mesa devel=
oper
> https://redhat.com             \               Libre software enthusiast
