Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77431FEC0E6
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 17:16:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2FD710E0F3;
	Tue, 24 Mar 2026 17:16:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D8GIU8z4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E25B010E0F3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 17:16:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 903BA43BF7
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 17:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78069C2BCB7
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 17:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774372561;
 bh=rJ1pctPs0xvOqyF2SiLanfq2whzraxuHaYE2pLWCFnQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=D8GIU8z42uPdqQnOgaUsOMsL9PsqF7sj3VlsmHDWfwi1TkinZ4lHEHzHUL+mFgGBM
 VZMhX6TrJmjfa/8euQPq1+b6iCfqsa56/I7pJGV7H7eWzlo9do/kwsmHx19ChupPGq
 6iK8D344oEcEqh626AYWFAs/+PdpEWtVr4h48eynkyaAbKCY5dwQw9ZvDA59DDGsmA
 /KccpwmFA/FAmNGz2ytCLFsKkh/CLVSlbWy/mgQmWAhHAwmsQtqe1cu26Qzobsla58
 Y/dtfgTz5Gzs3uSI4uoh3kucRK0ZtkOWAiLCfLKLXDZaN5iUFKb8+mz0xPBdIrrGp4
 ItW1gRe+KosjQ==
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-7d7e565c877so2374409a34.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:16:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWUnKAMR01oNMpO65c4w6wIV1xeq96XfFrDrfc/LrKpnYjR5zkMbMiXWjeCEs6+jUypbzTOPDv9rJ0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwUZbqHBL8+vBvrELa6dmNJl+CVKAbi1PI3dbxZ1Qx1ucQ85cUM
 beh65kRJO/mNUyrAdy65jIfgT9cqSKBk1RBpewowdOhTOIDqSJPY1IaYGaYbNHmO9uYh5MPg/UE
 7uJd4oTuTPzXYGI0QdCS7qLUuZ2ToEsg=
X-Received: by 2002:a05:6830:6afa:b0:7d7:5032:cc86 with SMTP id
 46e09a7af769-7d9d696e682mr54612a34.23.1774372560392; Tue, 24 Mar 2026
 10:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <5084777.GXAFRqVoOG@rafael.j.wysocki> <acEOf2pI_NpfA4EP@aspen.lan>
 <CAJZ5v0itCrbwM2k4_3F0kQwTfAwKXFQ5G4gcn=bM65Y2NU9YjQ@mail.gmail.com>
 <20260324164023.GE2902881@google.com>
In-Reply-To: <20260324164023.GE2902881@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Mar 2026 18:15:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hOguJV5QxjewOnFXc5zcGWTGkvvXO85ntuq=dD7uu3xQ@mail.gmail.com>
X-Gm-Features: AQROBzBNhJuJrMCZzWjpU-Y01kAsHD8yJNab0EMozPdjoBqQ2WLuUdt66_JkkCg
Message-ID: <CAJZ5v0hOguJV5QxjewOnFXc5zcGWTGkvvXO85ntuq=dD7uu3xQ@mail.gmail.com>
Subject: Re: [PATCH v1] backlight: apple_bl: Convert to a platform driver
To: Lee Jones <lee@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Thompson <danielt@kernel.org>, 
 dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
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

On Tue, Mar 24, 2026 at 5:40=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Tue, 24 Mar 2026, Rafael J. Wysocki wrote:
>
> > On Mon, Mar 23, 2026 at 10:57=E2=80=AFAM Daniel Thompson <danielt@kerne=
l.org> wrote:
> > >
> > > On Sat, Mar 14, 2026 at 12:50:11PM +0100, Rafael J. Wysocki wrote:
> > > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > >
> > > > In all cases in which a struct acpi_driver is used for binding a dr=
iver
> > > > to an ACPI device object, a corresponding platform device is create=
d by
> > > > the ACPI core and that device is regarded as a proper representatio=
n of
> > > > underlying hardware.  Accordingly, a struct platform_driver should =
be
> > > > used by driver code to bind to that device.  There are multiple rea=
sons
> > > > why drivers should not bind directly to ACPI device objects [1].
> > > >
> > > > Overall, it is better to bind drivers to platform devices than to t=
heir
> > > > ACPI companions, so convert the Apple Backlight ACPI driver to a
> > > > platform one.
> > > >
> > > > While this is not expected to alter functionality, it changes sysfs
> > > > layout and so it will be visible to user space.
> > > >
> > > > Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysoc=
ki/ [1]
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
> >
> > Thanks!
> >
> > Unless anyone has any objections or concerns (in which case please let
> > me know), I'm going to queue up this one for 7.1.
>
> Why would you queue-up a Backlight patch?

Because I care about this change and it's mostly about ACPI.

> I'd rather this goes in via the Backlight tree.

Sure, no problem with that.
