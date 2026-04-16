Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276B0F8E49D
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 07:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A7B210E966;
	Fri, 17 Apr 2026 07:06:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H/Id4zkA";
	dkim-atps=neutral
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82A1C10E8E5
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 15:28:01 +0000 (UTC)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-6501725d888so6508027d50.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 08:28:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776353280; cv=none;
 d=google.com; s=arc-20240605;
 b=Hq+JikI1+Uajj94HFs9VVUulxchzX1/fCMZqSrSG6bbboQISJBA+akuFKm3cNbkzbM
 LnCOSHiyR20GyBJRgu8oao+/QFlH3gxz2UI1D4yeUmOwTyxlCLpm7GPO0q4QSKf8SBR7
 7p4rOqurwBff9B2t/iKMDok+m9HRvbseJAAqYuFN2UPyvULnVw53mo4sZF8ybbchxybV
 9pXVQj9AMDityTrmRCzvabEPJ4RiXchr4fXw6lnt6AML6MD8skvBODt0WHY/KEOhNNkf
 6j/VxbhQ1WqjmqlywV6UdcqIUruSLbaS3EI9+lq5WT/UrdQmjrnd2H3wj0ru5mFCKNlB
 /xYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Pnr0Q9JPMj3Vg4oVi339hFZWY7Xp7U29efQnwAV26Jo=;
 fh=rZ3jHcIuntumDBIWXKokhzYciSLMkYNwsg3GuzEU+Tw=;
 b=O0dY6konmtrGMDx+WN02NF0vmFl3nikrqGYXJ2Dmfa2YDWBr1S9ZFbHLtcz0ew1Pb5
 Za/xHRlFDz6pWVmiKCQfeEh+RPr+KxixeSUATzekgo2P8mxgdY85RP0J+poAZbNN/k0h
 RRiCDhD701zBHuUTw3pqoW/7GFT7NkIEV8Q43ULKyqcOYPexPIHFB/r0OdtNGhegwzkY
 Bd2A4zobKcJHBeebmOHcBLKL+0yo0FdTlg90U9bDRS8ON0sTRk5kBINOYwE1VQjeu2A4
 O5y5ZFoYbGOa0GmDHn+I0Sz435WHLqsWwFFesA6RSC8DyWTV7t3rGkldMRx74JncaKiq
 9IKw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776353280; x=1776958080; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pnr0Q9JPMj3Vg4oVi339hFZWY7Xp7U29efQnwAV26Jo=;
 b=H/Id4zkA/ZqdrTmFeVsoHm/ql99AfNx7z6s5QKHVyvG5CcgDK89NZgUVfIR3fA9S5Y
 EgcGRJUvOIwlxxVAnq+V1HpxmuUIXmsrniLX3t8GrtzYgvrlOC3lEjFSgFpWV6FQ/YzC
 q3aOGJI5pFfpAioIdLG080RGmhnjsarKMD8NeMtdsy0EP+YbqulMAulMRG7Heb16iklm
 Flru6OvSSwObA0KLsf8CThKRynJ1ZPFQ3XIhyrCQ6lGck60JDHguw+R+bAwsFZYKbDxR
 xjyKsMYIoQ1kbICJr+K627v9VSyicKts2WqeR3KLe6VmE3fvKt15BZx/nWyyOa5zMzN0
 /RRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776353280; x=1776958080;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pnr0Q9JPMj3Vg4oVi339hFZWY7Xp7U29efQnwAV26Jo=;
 b=bv3UqweyUDOzrjGHBxDmUGvf1HDyD7Plvo6oOB4CKku5wLx+CDAHTxnMZ70dngLZOT
 iWL0qz6VyPKGuMp6ttWfUCdM2Ji3+YGLfoz/d0YjNWUpXGkDC71biJs7oNaTxXb2xg07
 WnIDeosE5/vc+dKljl+UDQYnU+nMchhuBFI7+GIvouZoDlB4+HIQ0WylwjAIytU61IMa
 ec9pZyvjAvYfGP+ku5alK+DPUqpagJ4ltG0taXJVT7lxpGmpwen5xFhbAkIgw73rM+i2
 tSDP/FXkzHCzF+ju6hSUKGExMAvHjsAb4YwOwZxFxhbPICKYsztET9z2K//eXbQbtf57
 26vg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8XshdlMtYrAgKLH3MKYU19jlBYVHyrHPrOYiK7OtAaaSLjehqHXbjrTtiKQ9PEWZThzskm1wV1TqM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8yZqx4HN+DPGkyXzpyZsZGZf4Qhyi3R2us0v1tuopOM2CuRhA
 RA77d8qXAKnek+M3Xfip7UmwPX3HT8nWsduG8hsgtc80/JlewdjP2uDmgHXLm2zGa4aaDM26vmF
 Zma0tilalHJA7KmuOhcVnlmwmHl+EXHo=
X-Gm-Gg: AeBDietepIl62UTkiYIwzRGlai5/mLTXUJ3jipd73K4ZjYTOUBFeLUw74A+Y6x5l6aC
 jJXD6jRUr7+nL19LZQr03W9qFc5LRz0qqPlJo6kcBgxBHeqBoes69e8koF3lBk01VNujMuqOXje
 tDeeXygQUpPbuLK4Q0N13GMQkhfxa05h6Nm2BSlX2REi1BGlnoHfleMeqvnTlOIrpFgBw6UT5cn
 ptWQtTm5XXlIWwHw2mBdHouLicamK5mjb7Ap62ThVNUYjAkLEykHIgRFKtXpu8dnurTzmaT8C7Q
 5ci7MW8KXjNdplbABaV644t5pWf68XFZQBmFjLQIKAdSlyxqUqSFgL2NV2k=
X-Received: by 2002:a05:690e:4185:b0:651:db4c:8066 with SMTP id
 956f58d0204a3-651db4c9747mr10802252d50.39.1776353280441; Thu, 16 Apr 2026
 08:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com>
 <aeDlhJjzS8sxumNn@xpredator>
 <CAHijbEWpsMNyskhe=nTY-Aa2B6bNC1G+Pm+C8OChvByRfS9NqA@mail.gmail.com>
 <4528526.e9J7NaK4W3@workhorse>
In-Reply-To: <4528526.e9J7NaK4W3@workhorse>
From: Julian Orth <ju.orth@gmail.com>
Date: Thu, 16 Apr 2026 17:27:49 +0200
X-Gm-Features: AQROBzAYceAIwgz0QigzF4GC7OkCMn8-5OSoM3p3qZVPAVle0UF7baZeq4Wqj6c
Message-ID: <CAHijbEUnQ2NEFQe3P72kyWFnHmmZueA34njBo54wzfwt8jfqvg@mail.gmail.com>
Subject: Re: [PATCH RESEND v7 0/2] Pass down hot-plug CONNECTOR ID to
 user-space
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Marius Vlad <marius.vlad@collabora.com>, 
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
 wayland-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 17 Apr 2026 07:06:15 +0000
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

On Thu, Apr 16, 2026 at 4:22=E2=80=AFPM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> On Thursday, 16 April 2026 15:55:52 Central European Summer Time Julian O=
rth wrote:
> > On Thu, Apr 16, 2026 at 3:35=E2=80=AFPM Marius Vlad <marius.vlad@collab=
ora.com> wrote:
> > >
> > > On Thu, Apr 16, 2026 at 03:16:39PM +0200, Julian Orth wrote:
> > > > On Thu, Apr 16, 2026 at 9:46=E2=80=AFAM Nicolas Frattaroli
> > > > <nicolas.frattaroli@collabora.com> wrote:
> > > > >
> > > > > On Wednesday, 15 April 2026 20:57:53 Central European Summer Time=
 Julian Orth wrote:
> > > > > > On Wed, Apr 15, 2026 at 8:19=E2=80=AFPM Nicolas Frattaroli
> > > > > > <nicolas.frattaroli@collabora.com> wrote:
> > > > > > >
> > > > > > > I will be taking over this series from Marius Vlad.
> > > > > > >
> > > > > > > This series addresses a shortcoming whereby a hot plug event =
is sent
> > > > > > > without it being passed the actual connector that caused it. =
This takes
> > > > > > > into consideration both the polling path and the HPD (Hot Plu=
g Detect)
> > > > > > > path. It also adds support for the vkms driver (using ConfigF=
S) for
> > > > > > > propagating the connector ID when changing the connector's st=
atus.
> > > > > > >
> > > > > > > The motivation is that user-space applications such as Weston=
 would
> > > > > > > previously receive non-connector-specific hotplug events, and=
 then have
> > > > > > > to figure out themselves which connector needs to have a mode=
set
> > > > > > > executed on. This notably did not work when the hotplug event=
s came in
> > > > > > > too fast, resulting in Weston missing an on-off-on transition=
 of a
> > > > > > > connector, seeing that its state was unchanged from "on" so c=
an't be the
> > > > > > > one that was hotplugged, and skipping reinitialising it as it=
 looks
> > > > > > > through the other connectors that could've caused it.
> > > > > >
> > > > > > Have you considered adding a u64 serial number as a DRM connect=
or
> > > > > > property that is incremented every time the connector changes i=
n some
> > > > > > way? Userspace could then check this serial number to see if th=
e
> > > > > > connector has changed since the last time it queried the serial
> > > > > > number.
> > > > >
> > > > > The connector internally already has an epoch_counter member whic=
h
> > > > > could be used for this. However, for the particular thing this
> > > > > series fixes, I don't think exposing it through the uAPI is neces=
sary
> > > > > or desirable. Sending hotplug events specific to the connector do=
es
> > > > > not need any additional handling on the userspace side as long as=
 it
> > > > > already listens to the per-connector hotplug events in order to
> > > > > avoid the pitfall described in the cover letter.
> > > >
> > > > I currently do not handle per-connector hotplug events. Instead,
> > > > whenever I get a UDEV change event for a device, I re-fetch the ent=
ire
> > > > kernel state for the device. That is
> > > >
> > > > - DRM_IOCTL_MODE_GETRESOURCES
> > > > - DRM_IOCTL_MODE_OBJ_GETPROPERTIES for each connector, crtc, plane
> > > With this change you wouldn't need to go over all of them as the kern=
el
> > > will supply the connector ID that has changed.
> >
> > Is this change only going to add the connector property to existing
> > events or will it send additional events with the connector property
> > set?
>
> It sends additional events if you happen to have multiple connectors
> undergoing a hotplug at the same time. This should not be a cause for
> concern; it's bounded by the number of connectors in the system (which
> is a single digit number, usually).

If the number of udev events stays the same in the
single-connector-hotplug case, then I guess this change is a strict
improvement.

Having access to the serial would still be more efficient in the
scenario you described since then the compositor could see that the
second event is a no-op.

>
> Kind regards,
> Nicolas Frattaroli
>
>
