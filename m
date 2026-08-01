Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAC0C55175
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 07:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFF4310E2ED;
	Sat,  1 Aug 2026 07:58:15 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B62810E266
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 03:13:48 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-7dbcb505578so15477067b3.3
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 20:13:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785554027; cv=none;
 d=google.com; s=arc-20260327;
 b=SuCul3tir6vXG7+jDRuYLEt7+0TALRg6HhhcIf5BgomXzFPpGakOdmggmOggaxB9xZ
 k/8ger+iZmHzb1caH1IfAC8ZwsfE9diE42U/l/HeOb/Sd+JgX+CF607XN/tKltSgrN58
 FpBT5T5D+N3MY5Q2mktFIHG3ETjgTVswZ104PBrDwPSdaOXvir5Ep+GW+J+6JDh/Crkj
 lJiFOKYHrdg/BFO9OGs/Uq0k9XiYpBfXsqd0VrEeFIm01B/MlwR0NnqaOMzkJGFTfXzZ
 TluJPzsw7BMUVb/YGdfrniUerkC8C+ILRjTRO6zjWUYWdB0DM52fe+E2vm+RhJm48f2N
 Z8OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=SeAZ9LnHsy3/NLwDMK5sclw7WS1BzURw2kr/GeL6nEM=;
 fh=2rhFIJ7cMw3zBu1eiiZp9Z4LymKvRo2vD9n47mq6LsE=;
 b=BHW4wfKCdWUvfY6CJRr2etaTHGmEi5/tJjPNdiRGsc+t27j5LHR0M/Y/grYUWzwNSj
 BKqi2065qBL8rrFQBeNRnr/eHyyQKK/0Od7xByNYu3ISl/jbQYf9Mn1sq/a/JD0f251w
 50KTowxJJeLvKIlxo6rD4TpSSPsSOTWLAJUBWmHpaSyHUqchkZYfUbgZrWs+Qgkm7dGv
 kLa/Y+V4EC8RLI9jAqIWnCF7N0yS5tBDLus/jgbUuhB2T2/kAva4YwkOn6pmpuDNllrG
 veiyl8LpK1xw7CCQ/6D6zHolwVIQ37Y6sIaCpyDGIQWpcfbgeDzFCxkTVMYPn4Zhae11
 jX8g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785554027; x=1786158827;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SeAZ9LnHsy3/NLwDMK5sclw7WS1BzURw2kr/GeL6nEM=;
 b=TCbdy1Z3ixm+yIKdYC//lfOr/0iiDFCQ5nXmmM7TLps3XBIdZ5zYb3Bmumz1B56u2P
 et7TEDnIxxkCIeFfSaeReIqyEIWvDDKvO++nWoEM1mrZ0otEgU2TwfEmZezWAekBLK1R
 /z63jQ2MKRnEbK40JDkBBh3sxOhRTeh2iBGD1/lyUoO1huAmRuOMDfTT7asMVdZU4VNV
 zj5R0zV5QlDOO1RRvigZ6yMmZ7nsLcoUCWp/QXmHya31jgD2I32BsTmn+Cx/R+lFMCYw
 OTlW8d/AKZuY9PRXKpHz8avy8YSk0OOY6HzDBOJTAakilqlEfoVbpDwnTv1uTe/8BgSF
 yfOA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXYsjb65Z2yOIDIaiHyGKpn99uHLXAakyEV+w9kC/NQNVNOTzFo0SAiyauIg5zmAhM0TuECkIbBHI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzEeNfBZLs2gRAgWGremAGJW9noJbs2/MNjXZ1bVGMeH0fuBv2D
 IE2tGX3ZLHtIQbyI8J3LTI6KmqVdVhsuX1gvRkPjq1rTybozFA0z6hliGFYn7bH7vOzF9E9L5tY
 fhqUZFivV+pYV6ohrn4egjkNlGrXn9Y0=
X-Gm-Gg: AR+sD11iIOFpN+qPfrGBDItFXuvKISIpD4tl4spfhQHJj2co/1yQojmGF9Re5z1FMSY
 Dc1WjRhyZ0Qq9vq6iGPpLnRyDZiu97RiP8VzpJw5j5Y9n0rZ+UeVWfqco5uLwBcHKBG941HcpE0
 /VxAwa8QtfBgC3Mvt+39ipFcVx6PPA3ok7/D9RoKIa7W8Lnq9816g3lf77kXqzoUVxMLgSuRaTQ
 HA5JVJk9ZlmwKCHRXJl8Qbeb/4OyH16Rtlp4ZO3XMETHfXl9rJ1VjQiJeoeZSaQc65eqQGXSOxk
 wRvtcv/KyaCnCmYgVuXDyU9FEoXvj1mCOI7yeDr/BY8uR6iV/e+kfOgum11M3UqEZH3My3N42fx
 WkQ==
X-Received: by 2002:a05:690c:278a:b0:81c:b865:2231 with SMTP id
 00721157ae682-81fd4bf88ecmr32651387b3.33.1785554025363; Fri, 31 Jul 2026
 20:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-pci_id_fix-v4-0-3580726844e1@garyguo.net>
 <20260728162538.GA1325438@bhelgaas>
In-Reply-To: <20260728162538.GA1325438@bhelgaas>
From: Masanori Goto <gotom@debian.or.jp>
Date: Sat, 1 Aug 2026 12:13:18 +0900
X-Gm-Features: AUfX_mz7siEIuZSDLGecSdNp4xhgCzEOOClyi0oT7r0lmGspOzwc1eUhhS3W20M
Message-ID: <CALZLnaEmm5Zi=30n4i7ioX9ii4KMAePnZTAhAcNScSZFSNB7UA@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] PCI: Fix UAF and TOCTOU related to dynamic ID
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Bjorn Helgaas <bhelgaas@google.com>, 
 Zhenzhong Duan <zhenzhong.duan@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Vaibhav Gupta <vaibhavgupta40@gmail.com>, 
 Jens Taprogge <jens.taprogge@taprogge.org>, Ido Schimmel <idosch@nvidia.com>, 
 Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Airlie <airlied@redhat.com>, 
 linux-pci@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
 linux-scsi@vger.kernel.org, industrypack-devel@lists.sourceforge.net, 
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 01 Aug 2026 07:57:53 +0000
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

I'm a "nsp32 folk", which patch version should I take a look at?

Best regards,
Masanori


2026=E5=B9=B47=E6=9C=8829=E6=97=A5(=E6=B0=B4) 1:27 Bjorn Helgaas <helgaas@k=
ernel.org>:
>
> On Thu, Jul 23, 2026 at 11:00:39PM +0100, Gary Guo wrote:
> > While working on improving the Rust abstractions [1], Sashiko reported =
that
> > an existing UAF issue related to dynamic ID, which I find to be genuine=
.
> > When taking a look at the code I also find a TOCTOU issue where the
> > existence check of dynamic ID happens in a separate critical section as=
 the
> > actual insertion. This series fix both issues.
> >
> > There are two exported functions pci_match_id() and pci_add_dynid() whi=
ch I
> > have to tweak to implement this cleanly; I created separate "do_xxx"
> > functions to keep the existing APIs because they all have multiple user=
s.
> >
> > There're a few existing users which stores their pci_device_id argument=
 in
> > probe callback. This is a bad pattern because nothing except driver_dat=
a
> > inside pci_device_id is what they want; actual ID information can be
> > retrieved from pci_dev instead.
> >
> > There are two users that performs pointer arithmetic on the pci_device_=
id;
> > these are also problematic with dynamic ID and driver_override, so fix =
them
> > as well.
> >
> > I've used the following coccinelle script to flag all cases where the
> > pci_device_id is used other than reading its fields.
> >
> > @usage@
> > identifier fn, id;
> > position p;
> > @@
> >   fn(..., struct pci_device_id *id, ...)
> >   {
> >     ...
> >     id@p
> >     ...
> >   }
> >
> > // Due to cocci isomorphism this needs to be explicit
> > @bad@
> > identifier fn, id;
> > type T;
> > position usage.p;
> > @@
> >   fn(..., struct pci_device_id *id, ...)
> >   {
> >     ...
> >     (T*)id@p
> >     ...
> >   }
> >
> > // Good use cases
> > @good@
> > identifier fn, id, fld;
> > expression E;
> > position usage.p;
> > @@
> >   fn(..., struct pci_device_id *id, ...)
> >   {
> >     ...
> > (
> >     id@p->fld
> > |
> >     E(..., id@p, ...)
> > |
> > // Redundant checks, but ignore
> >     !id@p
> > |
> > // Redundant checks, but ignore
> >     id ? ... : ...
> > )
> >     ...
> >   }
> >
> > @script:python depends on usage && (bad || !good)@
> > p << usage.p;
> > @@
> > coccilib.report.print_report(p[0], "suspicious use of pci_device_id")
> >
> > Link: https://lore.kernel.org/all/20260618-id_info-v1-0-96af1e559ef9@ga=
ryguo.net/ [1]
> > Link: https://lore.kernel.org/all/20260619170503.518F61F00A3A@smtp.kern=
el.org/ [2]
> >
> > ---
> > Changes in v4:
> > - Code and commit message style fixes (Bjorn)
> > - Link to v3: https://patch.msgid.link/20260706-pci_id_fix-v3-0-2d48fc0=
25acc@garyguo.net
> >
> > Changes in v3:
> > - Fix users which uses pci_device_id for pointer arithmetic. (Sashiko)
> > - Convert to scoped_guard. (Danilo)
> > - For static IDs, still give out static pointers and avoid making a cop=
y.
> > - Link to v2: https://patch.msgid.link/20260630-pci_id_fix-v2-0-b834a98=
c0af2@garyguo.net
> >
> > Changes in v2:
> > - Fix users which store pci_device_id.
> > - Clarify in probe documentation about the lifetime of pci_device_id
> >   parameter.
> > - Dynamic ID conflict check now ignores override_only. (Sashiko)
> > - Link to v1: https://patch.msgid.link/20260626-pci_id_fix-v1-0-a35c803=
f1b95@garyguo.net
> >
> > ---
> > Gary Guo (9):
> >       ata: ata_generic: don't store pci_device_id
> >       scsi: nsp32: don't store pci_device_id
> >       ipack: tpci200: don't store pci_device_id
> >       mlxsw: pci: don't store pci_device_id
> >       agp/via: Don't rely on address of pci_device_id
> >       agp/amd-k7: Don't rely on address of pci_device_id
> >       PCI: Make pci_match_one_device() match on ID instead of device
> >       PCI: Fix dyn_id add TOCTOU
> >       PCI: Fix UAF when probe runs concurrent to dyn ID removal
> >
> >  drivers/ata/ata_generic.c                 |   6 +-
> >  drivers/char/agp/amd-k7-agp.c             |  26 +--
> >  drivers/char/agp/via-agp.c                | 308 +++++++---------------=
--------
> >  drivers/ipack/carriers/tpci200.c          |   1 -
> >  drivers/ipack/carriers/tpci200.h          |   1 -
> >  drivers/net/ethernet/mellanox/mlxsw/pci.c |  11 +-
> >  drivers/pci/pci-driver.c                  | 194 ++++++++++---------
> >  drivers/pci/pci.h                         |  43 +++--
> >  drivers/pci/search.c                      |   8 +-
> >  drivers/scsi/nsp32.c                      |   8 +-
> >  drivers/scsi/nsp32.h                      |   8 +-
> >  include/linux/pci.h                       |   1 +
> >  12 files changed, 237 insertions(+), 378 deletions(-)
>
> I put this on pci/enumeration and plan it for v7.3, hopefully with
> acks from the AGP, tpci200, and nsp32 folks.
