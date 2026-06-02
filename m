Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166A2CD6E60
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 12:00:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74CF010EFFB;
	Tue,  2 Jun 2026 12:00:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lue3vKup";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DD8310EFFB
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 12:00:33 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-307263ad0cbso2226592eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 05:00:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780401632; cv=none;
 d=google.com; s=arc-20240605;
 b=Yq93RdzhzWAHzkc6FR9rDBiAaY0ehT5HDdDx1phydlOgrf0ghqOxS6UvDvLQhKiYri
 1PTt4QnlAJpfaRMPdeK2iQbvbMnkdeGJyCpAXkZugouSQJwFE4YRNmRnfrIMY1v1hkrk
 VHohiOGyOki5xNtln+SszRlmuyd9xEsi07uC3DKvgVSJOjipBGMr8zK8DoDI6fmb3uFF
 FhrOBNcUSj5ewV2J8Kv1AM4ToUvEWUuPwMvSauIVivu4Np8lQNsG4peCo8RYE0sNVGZ1
 STg3oRMRdgk167Fay/6hhpCBkCMp0Uy06SjyjCbM7rVaePcAqFMhVJ5qyDEcvPB8QK/c
 a9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ltXCCc4wpurtipYSrGSPv75JAWyLn0B0neQXenFUA+U=;
 fh=tb84XwqVu+myrqL8zNfGeeeBzIPk3uJwwSU1fdJ52+I=;
 b=fGNb9UjKo1Is5eBz7RoDaqEpVd8923zF4DfuhKQ+eMDf54oHDTE8Y2xJg6y6ZRnZgR
 iyRe6zd0KfADt+o0wjetXP6qiRW8asyuVuiWDQOeMGGb36i1JhewuMs/skZQi9vG95dt
 ILoZX66VmwW5kLz+JnkTs0nVH6lA2IGzA80ZgwkrI+SP91sXAa/kYGFkuPpCVLNYJNJu
 8TPFkBZ7zFYwoRVHlCEdxgDJAvCcRPeNXAkqNgXTJHsJONbjPV+EI0zMGFeXRNRAmh9R
 4k8M4q0JE2HDwbzEwQ+CXb+bO3ghYoOqUMvULxDt/7q8/02MrwJY9QKQuK7ONrEHxG0S
 xgpg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780401632; x=1781006432; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ltXCCc4wpurtipYSrGSPv75JAWyLn0B0neQXenFUA+U=;
 b=Lue3vKupE+pwxfYDZdcWsau0qFmI75JvXZBYubrnsD5f+cs8ZiUouO3yt+4zPL4ge5
 LMucPFncbVc/68DOcpKnxfURQAPAp98tcyjRhHNT3x9WlIg1SkR9DV2NWYnYxoa946yw
 cI8Azub/EcYNPVBet9RQ845gF2AsTc5yFNx+uOB5ii9fT9LjZnSjTJfVzHs3Zoxw/XG+
 Bi2BaR4HHkmdMkLfmMI8nPIW1VY3n34PQJlNuDMsgfYW2GZMDBR5cWe9GcmbqalvOv/W
 blruRMmNC2F9RaF1NUbpqGAjpSPKq+Tir3U4FAHNkhXf0EIW5uVWsEQbn11vtS1ogz5k
 wlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780401632; x=1781006432;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ltXCCc4wpurtipYSrGSPv75JAWyLn0B0neQXenFUA+U=;
 b=b+Rl16QSHSqYPzhbG2uN0IbiGvYyv2Buk+HHAdTBv3v0bmqkR4F02TCXjEd4S5Bp0A
 xoC4m6U9S9Qp/Ct6d3IGy7TLksJtj9FcbzS4uChv1bPqYrv1Nx+3Nd+VM8q35eoXMnOK
 gcdO2Tl2bsVcOQGIg0Atggro4JwZ8gh+R7YkdA4t4t1Ps3mC7+l2rIsJmsEJxGYt+jUc
 qYNHezWRLrN6+LSZEiSuobkMaZdVeRxFbANQSqEf4u7XfUg/xVVfmUJo/ESzF60SNx63
 vXUe0rBkvydvf2iEJrHUBGT9nG+2aa2m6ecpLcBZnh2W5AmopYgzc3kxQIsZ7zpH5GnP
 3PjQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qfZGBIGcCdVgrl+IaoYpTIxCsOpSdviJ3qRy830AFsbH07Ih1Vz8ErW5Hu5IKosSzrIEaWw11oak=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKAKbyzRoVI3zKVG3wVXXu0bzYlcm+Q6y/l1hDiITo474Om4aF
 QXnkTlyapXW9DWEJwqwwGOE66v2MO/YJp7H5Iws9DlxqeTUlCxAYwAKyAgVzCMkg+9CQFX7ayL4
 4Em2aGMLk4HfPhPtXW3y3JOvZzZjdx9U=
X-Gm-Gg: Acq92OH+muRosueIxxRmIM9DwNanvuGDSdb884ZlEgNGKNQSYpd+vsGamEU/aFMXlEW
 9MBOSfpY7oKiqLhB6tdbzwf2UhO+ItdLZefUaGFnMrI8+lvx9Bqtz4mbGlnTUq2UKdgzUQanbTq
 jLDaqYupPiB6C+Z/rj76Yotl7BhdeN0OPQXkEUfm1q8WaHgxXeEJyqvNsg0ErZxPmitzEsx+9mt
 qWt/2qAyc0NljUbeaiQWcc24kWoY+G8jERTyjgJJZcNAJZK9w6zo+t1vTqk5YIGO/R34pkrt1gJ
 9LvMJMVLEHiOb2Wje/E=
X-Received: by 2002:a05:7300:6da3:b0:304:cf6c:4cfe with SMTP id
 5a478bee46e88-304fa4d506emr7133140eec.9.1780401626958; Tue, 02 Jun 2026
 05:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260601151831.76350-1-clamor95@gmail.com>
 <20260601151831.76350-6-clamor95@gmail.com>
 <ah6TGjRNnDpQGO60@ashevche-desk.local>
 <CAPVz0n21RGAaJc1sda4xyp1h0z+6R6FJ4=XWdOtB1mgtV8=RUA@mail.gmail.com>
 <ah648F2plc4UHTM1@ashevche-desk.local>
In-Reply-To: <ah648F2plc4UHTM1@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 2 Jun 2026 15:00:15 +0300
X-Gm-Features: AVHnY4JW9CHRHy50Nkm6GtBSzM61Oxt7rnaqb6kAIuOEvYU0rp0GBajm0chAidM
Message-ID: <CAPVz0n2J6cmWyYWL5aQcFJeDEezD0P_ianTjqUzXiFuDsYbVmQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] mfd: lm3533: Convert to use OF bindings
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Johan Hovold <johan@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
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

=D0=B2=D1=82, 2 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 14:05=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Jun 02, 2026 at 01:31:44PM +0300, Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 2 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 1=
1:24 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5=
:
> > > On Mon, Jun 01, 2026 at 06:18:25PM +0300, Svyatoslav Ryhel wrote:
>
>
> ...
>
> > > > +     device_for_each_child_node_scoped(lm3533->dev, child) {
> > >
> > > > +             if (!fwnode_device_is_available(child))
> > > > +                     continue;
> > >
> > > Do we need this check?
> >
> > This is nice to have if the node is disabled. If we assume that there
> > are no disabled nodes, I can remove it.
>
> It's already implied. See
>
> static struct fwnode_handle *
> of_fwnode_get_next_child_node(const struct fwnode_handle *fwnode, struct =
fwnode_handle *child)
> {
>         return of_fwnode_handle(of_get_next_available_child(to_of_node(fw=
node), to_of_node(child)));
> }
>
> And I believe it's written somewhere in the documentation (if not, feel f=
ree to
> patch that).
>

Very nice. Thank you.

> ...
>
> > > > +     ret =3D sysfs_create_group(&dev->kobj, &lm3533_attribute_grou=
p);
> > >
> > > No way. You should use .dev_groups.
> >
> > I did not change how driver does this, just swapped lm3533->dev to
> > dev. I will set is back as it was.
>
> This is a serious race condition that needs to be addressed. Since you ar=
e
> touching this driver the fixes against known issues probably are the firs=
t
> things that have to be done.
>

Fine, I will have a look.

> > > > +     if (ret) {
> > > > +             dev_err(dev, "failed to create sysfs attributes\n");
> > > >               goto err_unregister;
> > > >       }
>
> ...
>
> > > Can you think on how to split this change to smaller steps? I believe=
 it's
> > > possible.
> >
> > No, I am done with tinkering with this patchset. It is broken enough
> > and it has inflated enough.
>
> Probably you don't want this to be reviewed then? I believe other kernel
> developers and maintainers will ask you the same.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
