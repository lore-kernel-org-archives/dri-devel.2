Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E967F8E4B4
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 07:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76D2210E974;
	Fri, 17 Apr 2026 07:06:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ARit3EPN";
	dkim-atps=neutral
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22EBA10E1D7
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 13:16:53 +0000 (UTC)
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-6530287803cso419112d50.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 06:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776345412; cv=none;
 d=google.com; s=arc-20240605;
 b=Wu282fSWjiXzWx69JzOf5cByAv2lrie+sO0fcVINBuOgGE7GdznN67moGE2/HaOy4f
 x75TcvFX3ftBHEOYZ+nE0y0Rewn+DKIEjYy89awrVIcbhSeD2d2talOkQqzkIl1J40HA
 w/H0EJ+E4BJBA/E53j19QlDek82AbeI6Kz7B0DFiMMfmjYKZkpIxc+ZZo8SBuUr3+8vF
 I4/qAkMM9DyBCfUssshUEBG0+aw2lJrXxBD50QzHOAy9xIsBoltBkOUnNbHwbEw58Yw9
 6LKyA1+FDJAjW1BDs8MqlO02cNVW4a2DEYkD76m4FAMeTsKaZlN/nRatnlDc/+Ew9C5M
 XcYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8Y4TTlp7lhh5Kw+bAxWFhzr/KZXrxFFbfx+tWQSmcLo=;
 fh=X+ySa8Me5lant0q9Lbo6tgyvqqxVfrOiYJUMKRZ3I5M=;
 b=kbMlXK/An6Tfbo+LRs14oKmoMyQb225C9jTG8WsYfZp9j6jpN/qtU3Efl0ZupuOLZ9
 2/n4T9G+Gijv8WWPwTO7FrjGHdbCmwpf8Q/P9eKIbgOoZBNni1yZ/qXrDfVQ8GN7ejkO
 Db4MLkptVzycUbj/eAEgKetGjIKFXsyp485byHfjESgr6wJW1ZB2znmsahcaD93XnQTg
 BUH98LoUIBwLKZK/9lVUgRytecwvFDtbIwyANrHy3ZFmfGdYWMia7E/VWbIYIeri55py
 dx9cqlNzuqeWNdRcJNDAD0mSd2VwOXpM9gfoniS46jBcaME3F0qdo6CetQqnx95n4EjH
 BtFg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776345412; x=1776950212; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Y4TTlp7lhh5Kw+bAxWFhzr/KZXrxFFbfx+tWQSmcLo=;
 b=ARit3EPNtmaya/VdVlhJ5xzn1FHR6ixJNBoKCivxLsfKVBGWo9SFzmg23WGSdYb2aM
 TuPyk0o5DenkArLorXJ32iFJylOvqij0HYQrY6+0WVN+vVu8JRHW9xfAe+wGTNNcEfNc
 8e5cgWHlHr384H/McttmpkQP35sQCaEtuGy5zaRPg0yi6yOEYOUMagc9QPhIvjBdsdJp
 awYqNBwO+xYH95SaBllHwFv2DY5ey/m3ffzQ2rXv/BV0pSNuImGnuy4yLkRbStE5qasl
 IvzBZCmi7SbUpeOPamxehvaIxjQczEPe35F512rK2Pnzr7VKna/0/hjRPBDT8fCpfMQp
 y3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776345412; x=1776950212;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Y4TTlp7lhh5Kw+bAxWFhzr/KZXrxFFbfx+tWQSmcLo=;
 b=nulK9Xt9/iEIEY0DNGtPxS3QbOJONdayLntJMQj0kXhCc6MWGF5f6pboOlhpJXn7Q0
 hkfEoyJckGQFDOUzY50ailR219t0grJzI9niE8VVDvWU7lNC+SyAM/rYDf/xmx4QrXL1
 NvpwaELyyi3JSdqydpolx0KzqA7baDntW+xgtY2J4lXtrFbEkevxNjRyK1bjCM+R77Ml
 kvH/eqW5XnfZoc6D52Z9/0MAYi1AJgCF6TKYO9lD3LueWZSChZWzYjHL4fDSC7iddsLA
 oPnWhLO0zVDa8HMnXXST6mI9ZHd1ZeYBvMxmO9AT+3qQuMBM+PdwYgcJelarZV12Ejwh
 dkOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/5gu1rJ0p0uzvFwlpWtwfD8DM9w9r35WHONKol0snKerTzxu3BR99ghq7eC67l78t3y1zyAWm9dI4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0tWJDY/eKMTZNhia+xNasP+hP6Il7CI9hVyNUDvdpvV/hLZKW
 uzLxGBPKoAUbsfGHhrW2aOB5KKZOlJL89JYCpT1dZIwKpEPdsFjZCl0s95wugg1fYOf9kKz/1RK
 CImv8TsWVrWeHZCebglG4UiLBmSimNiA=
X-Gm-Gg: AeBDies3zEx/bgU932R2C90Q6liGVMfHyUuibU5XllseTMRyIeDN0yOspixckwHfgPH
 EXBR6mH55hIgQa5fevieRlbQpO1+Kt/YM23wbKpcQRClYnYH3XqQSWfUevZ7sjDfFopXcv3xUVo
 53MJ0H7d/BZ9pIMMcEOL2zGCoxex8wpiL/6or8ufZIAw/jDpi6Yy0OS00aly/ero/mY1d6q3b2j
 PQ2je+zz5AC9zZvCxXnV6KsvAwKa+dmVG9MSOQkODrD/dgoeFoNfBeOTUr9rg7u6u9S/y5pV8W0
 nnnpeuwm8vUWFaVfGmAm68UIwGltN2B1iShf9pHTTZeyc0YlB4QDFLTJj+M=
X-Received: by 2002:a05:690e:dcb:b0:651:bd70:1622 with SMTP id
 956f58d0204a3-651bd701d12mr16765260d50.10.1776345411845; Thu, 16 Apr 2026
 06:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com>
 <CAHijbEXcrhB=ipaa4-DPD8atQYCkokGfueLafwkeQpxCBkc0bw@mail.gmail.com>
 <7472926.DvuYhMxLoT@workhorse>
In-Reply-To: <7472926.DvuYhMxLoT@workhorse>
From: Julian Orth <ju.orth@gmail.com>
Date: Thu, 16 Apr 2026 15:16:39 +0200
X-Gm-Features: AQROBzBXbJ7d6HAJlKXhd63gAm5FBuT7JpsUTNIQW2l7uUKkWF7FcPplO8eQEEU
Message-ID: <CAHijbEViae+=Fcnh3v0ODxwTPUaRgU1H4OVGM3VFPSLMPzJzOA@mail.gmail.com>
Subject: Re: [PATCH RESEND v7 0/2] Pass down hot-plug CONNECTOR ID to
 user-space
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
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

On Thu, Apr 16, 2026 at 9:46=E2=80=AFAM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> On Wednesday, 15 April 2026 20:57:53 Central European Summer Time Julian =
Orth wrote:
> > On Wed, Apr 15, 2026 at 8:19=E2=80=AFPM Nicolas Frattaroli
> > <nicolas.frattaroli@collabora.com> wrote:
> > >
> > > I will be taking over this series from Marius Vlad.
> > >
> > > This series addresses a shortcoming whereby a hot plug event is sent
> > > without it being passed the actual connector that caused it. This tak=
es
> > > into consideration both the polling path and the HPD (Hot Plug Detect=
)
> > > path. It also adds support for the vkms driver (using ConfigFS) for
> > > propagating the connector ID when changing the connector's status.
> > >
> > > The motivation is that user-space applications such as Weston would
> > > previously receive non-connector-specific hotplug events, and then ha=
ve
> > > to figure out themselves which connector needs to have a modeset
> > > executed on. This notably did not work when the hotplug events came i=
n
> > > too fast, resulting in Weston missing an on-off-on transition of a
> > > connector, seeing that its state was unchanged from "on" so can't be =
the
> > > one that was hotplugged, and skipping reinitialising it as it looks
> > > through the other connectors that could've caused it.
> >
> > Have you considered adding a u64 serial number as a DRM connector
> > property that is incremented every time the connector changes in some
> > way? Userspace could then check this serial number to see if the
> > connector has changed since the last time it queried the serial
> > number.
>
> The connector internally already has an epoch_counter member which
> could be used for this. However, for the particular thing this
> series fixes, I don't think exposing it through the uAPI is necessary
> or desirable. Sending hotplug events specific to the connector does
> not need any additional handling on the userspace side as long as it
> already listens to the per-connector hotplug events in order to
> avoid the pitfall described in the cover letter.

I currently do not handle per-connector hotplug events. Instead,
whenever I get a UDEV change event for a device, I re-fetch the entire
kernel state for the device. That is

- DRM_IOCTL_MODE_GETRESOURCES
- DRM_IOCTL_MODE_OBJ_GETPROPERTIES for each connector, crtc, plane
- DRM_IOCTL_MODE_GETCONNECTOR for each connector
- DRM_IOCTL_MODE_GETPROPERTY for each connector property
- DRM_IOCTL_MODE_GETPROPBLOB for the EDID

Once I have the new state, I compare it against the desired compositor
state and perform a modeset if necessary.

This makes it robust against the situation you're describing, but also
means that a lot of work is done for unchanged objects. If the change
makes a modeset necessary, then that work is almost negligible
compared to the time the modeset takes.

I don't know if your patches will cause more change events to be sent
or if they will just add the connector property to existing events. If
there are additional events, then I'd prefer to have an early out for
some of this work. E.g. by having access to the epoch_counter.

>
> Kind regards,
> Nicolas Frattaroli
>
> > >
> > > The real world implication is that on setups with slightly sketchy HD=
MI
> > > connections, a brief flicker in the HPD signal could result in video
> > > output bidding farewell entirely until a manual proper re-plug was
> > > performed.
> > >
> > > By sending connector specific hotplug events, this ambiguity is
> > > resolved without any change to the user-space API.
> > >
> > > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > > ---
> > > Changes in v7 RESEND:
> > > - None, other than removing the leftover diffstat from the cover lett=
er
> > > - Link to v7: https://lore.kernel.org/r/20260217-hot-plug-passup-v7-0=
-f8221b2aab51@collabora.com
> > >
> > > Changes in v7:
> > > - Drop the two vkms patches, as I don't want them to be blocked on
> > >   review. I still think they're correct, but they're not essential an=
d
> > >   don't need to block this series.
> > > - Link to v6: https://lore.kernel.org/r/20260123-hot-plug-passup-v6-0=
-aaaf61d960bb@collabora.com
> > >
> > > Changes in v6:
> > > - Rewrote cover letter to explain the motivation for this series more
> > >   plainly
> > > - Rename "status_changed" to "pending_hp"
> > > - Set "pending_hp" in the existing path that would also affect
> > >   epoch_counter
> > > - No longer set the boolean in drm_helper_probe_single_connector_mode=
s,
> > >   as it does not appear to be necessary
> > > - Reword commits to better justify the changes
> > > - Link to v5: https://lore.kernel.org/r/20251111162338.15141-1-marius=
.vlad@collabora.com/
> > >
> > > Changes in v5:
> > > - vkms: add support for sending the CONNECTOR ID when hot-plugging th=
rough
> > >   ConfigFS - as reported by Louis, vkms can now make use of ConfigFS =
to
> > >   simulate connector status.
> > > - vkms: add a small change to ignore previous/old drm connector statu=
s
> > >   when sending out hot-plug uevent.
> > > - Link to v4: https://lore.kernel.org/r/20251103174558.7709-1-marius.=
vlad@collabora.com/
> > >
> > > Changes in v4:
> > > - removed the "This patch" bit - Dmitry
> > > - added a short note when the flag is set and cleared - Dmitry
> > > - address double dead-locking detected - kbot: https://lore.kernel.or=
g/dri-devel/202509251410.fdfbcac3-lkp@intel.com/
> > > - virtual connectors do not seem have any kind of hotplug - added
> > >   polling in vkms - as noted by Ian
> > > - Link to v3: https://lore.kernel.org/r/20250923083636.4749-1-marius.=
vlad@collabora.com/
> > >
> > > Changes in v3:
> > > - Address comments from Dmitry:
> > >   - guard connector status write with mode_config.mutex
> > >   - avoid setting up the connector status and immediately unset it. D=
o the
> > >     unset in drm_kms_helper_hotplug_event/drm_kms_helper_connector_ho=
tplug_event
> > > - Link to v2: https://lore.kernel.org/r/20250729165708.9947-1-marius.=
vlad@collabora.com/
> > >
> > > Changes in v2:
> > > - Address comments from Daniel:
> > >   - split patch into 2, one that introduces a bool to track connector
> > >     connection status change and a patch that uses that to be able to=
 send
> > >     hot plug events with the proper CONNECTOR ID to udev and further =
pass
> > >     that down to user-space
> > >   - nuke out mutex when iterating connector list
> > >   - fix typo
> > > - Link to v1: https://lore.kernel.org/r/20250627131751.2004-1-marius.=
vlad@collabora.com/
> > >
> > > ---
> > > Marius Vlad (2):
> > >       drm: Introduce pending_hp to drm_connector
> > >       drm: Send per-connector hotplug events
> > >
> > >  drivers/gpu/drm/drm_connector.c    |  1 +
> > >  drivers/gpu/drm/drm_probe_helper.c | 39 ++++++++++++++++++++++++++++=
+++++-----
> > >  drivers/gpu/drm/drm_sysfs.c        |  2 ++
> > >  include/drm/drm_connector.h        |  3 +++
> > >  4 files changed, 40 insertions(+), 5 deletions(-)
> > > ---
> > > base-commit: 4c59525db84aca677fd9f052e662912ad9d88448
> > > change-id: 20260121-hot-plug-passup-f8ed03f7c202
> > >
> > > Best regards,
> > > --
> > > Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > >
> >
>
>
>
>
