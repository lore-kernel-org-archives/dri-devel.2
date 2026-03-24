Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD49E9A779
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 12:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6861010E69C;
	Tue, 24 Mar 2026 12:47:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TyKcqltR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DDA610E69C
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 12:47:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id ED342429C3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 12:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B41C2BCB2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 12:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774356449;
 bh=zaNQlDH/IYpkir6Zh1G82dzyVoUtO9YPkNS5RZ6NPAk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=TyKcqltR5sHRXGtJsm9mYbzaDJc/5b8g3bzAUpDnKVK2CfrX6o0+0R0OrUvRr6Ore
 u12du/9dDjZdg4zezRspx9k7uPF7pvuxFeT/kq/RfJsWdk5L76Ds0wzP6/E2XalvlL
 eyovR+zQ6KJf3BNVpmzn0Is7c04Y/N2ob22S3VdlHB0CqZ+hU/i9omAtt6csKGXOn4
 38mhP/RLPS+wxVWrPypa/WT+HpLZRvocdUWZnHLTlRMtNDeX+lW28Jr0HaHGUSDZMv
 U07ldCScEZzNkZa9f9RCSAwQ6zX65e5Ecss40NhN/062u0bJoyZ7Bf6nWHlqkUx/vP
 ghxR2+D9YWc2w==
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-40f387a688dso4051870fac.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 05:47:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWc1gV34EGSlvVZeDNsxWWV2BGa0XuMHbhj9NN8P63841EgIYKT4k+w6UxMMiXMpQqpdcjOGz6o6hw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcaSP7pr9I0zEFFTiUgqJPfcnDE0BYFG1LvGy4urHYIpZoWW+e
 jxBIPoZfVgZf2xiSQqVITJ6u1MxpKvQWAKkDNWpn8iizHyhLNcTcfrh9xmAbRmNkzxOYo/PCUBm
 xwWUy83Sa9kbpypoLZXd1GxaskZw5tJ8=
X-Received: by 2002:a05:6870:f150:b0:417:c116:ea79 with SMTP id
 586e51a60fabf-41c10ff9ddcmr9412403fac.12.1774356448889; Tue, 24 Mar 2026
 05:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <5084777.GXAFRqVoOG@rafael.j.wysocki> <acEOf2pI_NpfA4EP@aspen.lan>
In-Reply-To: <acEOf2pI_NpfA4EP@aspen.lan>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Mar 2026 13:47:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0itCrbwM2k4_3F0kQwTfAwKXFQ5G4gcn=bM65Y2NU9YjQ@mail.gmail.com>
X-Gm-Features: AaiRm53t3o66QI9GTm-Ambf1zwPR2-4cMmUQM8M9mJmuxwinEHxg5u9awX495MI
Message-ID: <CAJZ5v0itCrbwM2k4_3F0kQwTfAwKXFQ5G4gcn=bM65Y2NU9YjQ@mail.gmail.com>
Subject: Re: [PATCH v1] backlight: apple_bl: Convert to a platform driver
To: Daniel Thompson <danielt@kernel.org>, dri-devel@lists.freedesktop.org
Cc: Lee Jones <lee@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
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

On Mon, Mar 23, 2026 at 10:57=E2=80=AFAM Daniel Thompson <danielt@kernel.or=
g> wrote:
>
> On Sat, Mar 14, 2026 at 12:50:11PM +0100, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > In all cases in which a struct acpi_driver is used for binding a driver
> > to an ACPI device object, a corresponding platform device is created by
> > the ACPI core and that device is regarded as a proper representation of
> > underlying hardware.  Accordingly, a struct platform_driver should be
> > used by driver code to bind to that device.  There are multiple reasons
> > why drivers should not bind directly to ACPI device objects [1].
> >
> > Overall, it is better to bind drivers to platform devices than to their
> > ACPI companions, so convert the Apple Backlight ACPI driver to a
> > platform one.
> >
> > While this is not expected to alter functionality, it changes sysfs
> > layout and so it will be visible to user space.
> >
> > Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ =
[1]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>

Thanks!

Unless anyone has any objections or concerns (in which case please let
me know), I'm going to queue up this one for 7.1.
