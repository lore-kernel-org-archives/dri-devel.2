Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2ECCDB475
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 17:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E23010E7B2;
	Mon, 22 Jun 2026 17:33:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pgQPT0ma";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7105310E7BA
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 17:33:05 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-1390f75d8bbso3779246c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 10:33:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782149585; cv=none;
 d=google.com; s=arc-20240605;
 b=iaVnqud5pR15ixnJENRFsNjlmu8lCNi74Wse0pOtQKrGTCPdpFXMBJJ+9XmUK4kpUG
 xfLnds8DCkXId6ukIw4KGggm7Z/wdOhpI7NWl+4p0oCVdYdbs6UX6Dy1+wfSFgSExUH2
 rt7lCDx5XJPYfLqua0rICNlZ/tCBRTmNrr65/wfEz/rz24qWwnsLoQ8IJtbIVy7c0dA5
 lLD+mPzNBLsYOD3rP4A+hnjU3XYrRKA+9Lz9uE8lNYgoMguze1ouvs58tnkWQOdDQMWW
 JoiWK/kt5lFxKazPdXyFvmCZKXXr+qcoR9jrbvQM0Sljdbg6b3MV5iA41Xqvv9LrkJVF
 0JVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=m189siMGpQATgehzZD5A3PVqGeqotQKZygN7B0hsQio=;
 fh=5Y/K1Jmo1CwWUNXeXxiOLYa6ZiJ954FuFZVS5sC/ZiY=;
 b=N0RUeprLONYczRGJpNlKGLputN3OrO+rYRAXRm0w/I2rIwZBHAiDvhm5fi91kXr5fB
 9yMOreWsZd5YG5K9attAGirqwbZGtG0sw6JL013TnnjnwtyQW+uMHvsbRLU25cgSQKfN
 bX8115zM/4CV+N8ulf9sA86iwZlSw3Fc9RdCzMpi3aY39TnLBAOoE9ztTCSzIN4lWslY
 8IQzlBxi7F75box7UV7Nizfis+2mUs42X+UT66Z5ueC/JTnAmEZ84Ix+iAMghVTUlogo
 8PS+SRy2v6bDvZx09Rump0Wy1BWQ/1Xdu/jNvtF0vIDNum5NaCdann/uYk7XK/cE2By/
 hiSg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782149585; x=1782754385; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m189siMGpQATgehzZD5A3PVqGeqotQKZygN7B0hsQio=;
 b=pgQPT0maD232McPwlJsGGUMEv1/uTrjYdL+dQu/ZIfJGzUUEA7oZTR1vY79fJHyv4G
 drbgil9umyloGQqd+lHKm9oMI5//FjVAV4nX5bCnp7utl72BejTVcpxumU/FpOlJxJwN
 Wn4dnkMrjSjPsojC1dLlQ54S+McNr9tM7cJQamLt4XeH6Nk+kIRZAhdVrjb1SwuIUORn
 yjAUBpntqftd6dnhfBXF9yJellZyOpX2hQII2Clyq265C2Ey+5MQuPGC+85cSXI5get8
 QhyugDNMZUcfrRsMtbUgGFCMdr0Nr7oGYuzXw6glZ6j7woWySLgoliNBRYNWphBu4LJO
 688A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782149585; x=1782754385;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m189siMGpQATgehzZD5A3PVqGeqotQKZygN7B0hsQio=;
 b=Oeu4UvH/GQngJU6qrXJ3SlAXChJq+LB1U29QIwdIKzc1NnxvYZqJLdWodpPX4LTwHg
 ZniC+JmHvkT0L2JO+DRmuyxw8rEXOiR6HPi0EOBf1OW7MTfcTySZpXRhZm5D+iMFCSHy
 fIKVKfIabSDSG72QLVmk/T/tzFUue18poRHEnTXrxHSZ+MQG+q91zFbHIRqrXHaz+Odw
 ZMSWUdj27HlyTPGtmXo7EEj9UlgjaMH6kK7T3x0LB+Y67IZvWr1NN8ipG9iYlBz23Xt1
 +jstxbCUuxO8wjKj2CldNBBTx2aSLJe2W89OufEtdE8pzuUgpsrosHsxNRnsWcLTf9oU
 jIjw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+LKqXJuWWB8b0Jnc7W0B5qpgLywJma9L+HKo5NL77iWdRdCK2Bal+nLADA9FHNaYzSzKT/pPkVU0w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxVJxHN4coFWaX04f0Qd2c8Y0DIcpchozuiLkRW/6qgx2bPV2Q8
 xvmsiS/JRVXGIEo9uk2I8yklIcGWkvRxdYd0RWzOVAIlkIJGAADxj0FNMjlAQ6TBjYy6WmT1CTW
 2tymRWP/KXLT4uiuMWMmEbsY/fuy4rE0=
X-Gm-Gg: AfdE7cmYo3y2SQ0CQMAyqWz2/y1aqjBc9Y4EPtxBIW0C1wPKLyOv4Ph5WpPV0Bc8B7I
 e/qPV5Um0kelD0qG+qtZZgFxHCYEguFqSJM1W1C8dVzsXTATCCmo6U6kPzFysIZVpUFdmKbJdA2
 73kIyni+LfV3edIZDt/opewtxmr9ZA27EuDY25XkDM02QRYzq5JGn2VNT2du8lhwKU8sNptUwdF
 4FPMytbljyppYZRvfrC/MhqgITQeRPNnbQwfpvVDEg/eX7S8ExryN+rsDahg9plge4WKbCpR6DQ
 vpqQZKqAvWcJixJaDHfeXjo5te76aV0=
X-Received: by 2002:a05:7022:911:b0:138:576:fd with SMTP id
 a92af1059eb24-139a4eb44f1mr7617282c88.2.1782149584465; Mon, 22 Jun 2026
 10:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260612144203.31715-1-ville.syrjala@linux.intel.com>
 <3d441831-71bc-49fd-823f-3af443e55b20@mailbox.org>
 <31da350f-adfc-4b2c-a7c5-5ed884ffd9ca@mailbox.org>
 <ai_40qUa-MVdbOEf@intel.com>
 <18f0c14b-f973-4e1a-948b-5274cc36895c@mailbox.org>
 <ajQ7W44qv28-i6Pq@intel.com>
 <159d862f-f06d-4ed7-bf81-082220cdfdd6@mailbox.org>
 <ajkY958UZbD1-5QQ@intel.com>
In-Reply-To: <ajkY958UZbD1-5QQ@intel.com>
From: Mario Kleiner <mario.kleiner.de@gmail.com>
Date: Mon, 22 Jun 2026 19:32:28 +0200
X-Gm-Features: AVVi8Ce7K_dQKtNJ32UEIGQhIj8B5c70Hqw4e2CZ5E3IdNQQg76f85ps776U4xw
Message-ID: <CAEsyxyjVqFv9xoebALSxzLj_7aKt3dw4dZHTB_JsSAbWPGsHPA@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/i915: Work harder to enable VRR based refresh
 rate changes on eDP
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org
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

If I understand correctly, that this is essentially the same or very
similar to what AMD implemented in amdgpu-kms for VRR capable displays
as "freesync_video", then a thumbs up from the sideline from a happy
user of that amdgpu feature with a native X11 client on the native
X-Server :). Psychtoolbox uses that feature to allow users to select
fine-grained refresh rates on VRR capable displays, without need for
full modesets, ie. almost glitch free. Very useful for vision research
applications that benefit from unusual video refresh rates or the
ability to quickly switch at fine granularity.

The useful feature for us here is the ability to do this with a native
X11 client, using standard RandR api's on existing, unmodified, many
years old, native X-Server versions which generally don't use or
support atomic modesetting. Iow. the apps that don't live in a Wayland
native (or client atomic modesetting) world yet. We are restricted to
what standard X11 api's can do, or setting or reading a standard
connector property exposed as RandR output property - without the need
to first enhance the good ol' X-Server and then hope for a release of
said improved X-Server maybe years down the road - or never.

Psychtoolbox uses this since over a year, see the following commit if
interested:
https://github.com/Psychtoolbox-3/Psychtoolbox-3/commit/96970e6d98c9f6ee293=
f018186d3d898d27e77bb

I'm not saying a more advanced atomic modesetting based approach won't
be better / more flexible etc. Just that this is something that can
benefit real world use cases of people inhabiting non-Wayland world
quickly. Can do one thing without not doing the other thing.

Best
-mario

On Mon, Jun 22, 2026 at 1:14=E2=80=AFPM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Fri, Jun 19, 2026 at 10:48:45AM +0200, Michel D=C3=A4nzer wrote:
> > On 6/18/26 20:39, Ville Syrj=C3=A4l=C3=A4 wrote:
> > > On Tue, Jun 16, 2026 at 09:21:01AM +0200, Michel D=C3=A4nzer wrote:
> > >> On 6/15/26 15:06, Ville Syrj=C3=A4l=C3=A4 wrote:
> > >>>
> > >>> What we're doing here is selecting the actual timings to drive an i=
nternal laptop
> > >>> panel, given some random cooked up modeline from userspace.
> > >>
> > >> How can user space know what cooked-up modes it can (not) expect to =
work with this?
> > >
> > > Without VRR support it can only expect modes that have the same refre=
sh
> > > rate as one of the modes on the connector's mode list to work.
> >
> > This seems to contradict "For non-VRR panels we just pick the fixed mod=
e whose refresh rate is closest to the user specified mode, and reject the =
commit if it's not close enough (<=3D 1 Hz)" below.
> >
> >
> > >>> We pick the actual mode from the set of "fixed modes" (ie. the mode=
s
> > >>> that the panel/system itself has reported as supported via
> > >>> EDID/VBT/ACPI/etc.). For non-VRR panels we just pick the fixed mode
> > >>> whose refresh rate is closest to the user specified mode, and rejec=
t
> > >>> the commit if it's not close enough (<=3D 1 Hz).
> > >>
> > >> Can't programming different mode timings result in the panel blankin=
g intermittently?
> > >
> > > Userspace can specify that a modeset is not allowed, thus if the
> > > driver can't achieve the refresh rate change without blinks the
> > > commit will be rejected.
> >
> > How can the refresh rate change without a modeset (without VRR)?
>
> Given a capable eDP panel we can reprogram the dotclock/Mvid/Nvid
> atomically so that the refresh rate changes from one frame to another.
>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel
