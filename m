Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE19BC55178
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 07:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1398B10E2E4;
	Sat,  1 Aug 2026 07:58:15 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com
 [209.85.128.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C30A10E266
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 03:11:35 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-81f36179d72so24605037b3.2
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 20:11:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785553894; cv=none;
 d=google.com; s=arc-20260327;
 b=PvnjUhLzUmvZpQU3I8zqHWjYv2LDr2A97cIR6HMYh0RZL/5OIDdnd0+FlmdinuVFva
 sVJFd9WZMSaoND9G1LcHYzDns+mKlIVDQKkddMKOZ/EfowFejad2T1EjJlWbAAvEfry1
 gd3p2/iN8DFXOVDTND00+MXfnjKUBVCzl/lXFaJPqN2KVNXU+l4Fy7hEHve06MEnictZ
 2DBIyCfS5D4Q5UY2y/bakoltn3hW5A1fXTsF/S4R+L96R8Oe6swKwkY6TkTZlt0EQ9hJ
 lUv5qxhmRxe4IZYWa1jSgaLLlOH56anMxUCaSPLF1/IiRewz/NRJqpN009tvrd1skT1n
 8wkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version;
 bh=pZLgpEtcUAsQqnxbw5vm/VU5tDG+DHjyez0puzaBW5Y=;
 fh=2YdF7lzdntaKJksy30kSwxt+Sw6iH1EgG2meSNAHo5Q=;
 b=pgA+D/I7bQNrIypBxoAgMFTyT6hzFmzdnf0FNItvNTw6lr8Uc2C8gbeBiwuBG5Swcu
 sW0fi9f3UjIYQvax/x1pTWQ8NAXSo5aYZ3kSDV6skZ9DL7WXpkAQVqX3greIh2GNG4f6
 pUc5QzKjU/Hidf17jk0TkDZdSIZthFda24OhSrWy9wiav5/qRlUrbRkLfnqAofBIgmse
 jwsggDI6JqY0+MRn3UVwnB7swm5CBl+yj33cqa3/n7kPc0b339wbcOqn1tfxPW0jrf7/
 HHQ/0b3yI8g+YWts0xc0x5OZNIuvk7Cg/XvuIGaS1BBijcyrRwKCKVVKhmKJMg0gidSf
 1Auw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785553894; x=1786158694;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pZLgpEtcUAsQqnxbw5vm/VU5tDG+DHjyez0puzaBW5Y=;
 b=UL7L0Kmp03r87Ertv86qouW5kFS+sA5/lkBMEpRk8rANQOL00JFgC3dxRJz+wr5K8W
 f1BcrE98xzcypCWA3HalRhLGl3IsFBZq1DpeeQl5nHrTu3sJQ/LfKzk9R2VxnfHcyix+
 z6df2gmk5MqJjorosHbUCukzU260IpraCZGDamyhvEfyI+k1wpKmhxF7ySj3V1uNt2hJ
 +X+exbDmbVZeaDYy6Vzojy17P6r6MigT5xAzLpMDvPCL6RiAb4+6nDfbbZVoiJ4lM41A
 y49ctS/p6ert1BfGgZ8NUoSUJIMDTwdzETvcN/+NlTeEU25WEi8qWO0+9w/VnvBi1JmB
 D+BQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtvuNFMjtKMCjBcqtYNaTp/F0woFFBgGIHdds+yHP9zoKlLBMpuDvfkk2wXx6HOQRUWH9oT/1VsOA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyerccpLr2T30CmwyX+1YKi86Vdfqac1vTEVrQn9uXGg+FC5gQs
 vGaJfFb0vKQ5g8M7G4r0fyT0zkx4/LdXLKgm2d2NRBhtEj/7AZiQcoIkyqrCvMfHSeFmH7wSxyl
 itN6dUnNyhGbPqWvOC/UEENm4zhyEjf4=
X-Gm-Gg: AR+sD11hyBsnL2vu7O51mwSzw1MeJy7tBngc+3PDS+7MWHIrDRbdYnwXKk1cq68Ig+g
 AeNPWD81Z9arKRVvL/1DIiMAtlbwCqcVNWhn4jXUdAImKC/jx2eqT2XrkFH4kaEhO0650boJsKK
 VbA2/CqkxKqrL7LtEsJZllJiyt/aT8HtV1B/HMa2Yi8EKvruUbL9vJ2nLlctgzVMLJuFdICANBV
 Wz5EEKZAOwC5FpIi6YhV9cnBJQEsgGYXXSr4JlemUzGCHtonx5rS7sm4Bp2rffmA51eMNc6OJX0
 mbdNv7pJO2z1qnRQedz1qdxqpNRoE6UH1GpSaBu+ZmJPCrNXk0VvYUeDs4z4Rtou5Z00RARjGfS
 vJiOLIYsupKthtA==
X-Received: by 2002:a05:690c:6e0d:b0:7dc:aa85:5c67 with SMTP id
 00721157ae682-81fd4ad3603mr33796237b3.11.1785553894329; Fri, 31 Jul 2026
 20:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-pci_id_fix-v4-0-3580726844e1@garyguo.net>
 <20260728162538.GA1325438@bhelgaas>
In-Reply-To: <20260728162538.GA1325438@bhelgaas>
From: Masanori Goto <gotom@debian.or.jp>
Date: Sat, 1 Aug 2026 12:11:08 +0900
X-Gm-Features: AUfX_mxyWA_P4WiJ1cJyA5G1n-V-moOWOfBAwGwq6DEYH6I7naIQNwiy1NUzFjI
Message-ID: <CALZLnaECkV86Z9aUzpepdDJt45U-zei6saLXevzfMP1xpA3JKg@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="0000000000009957e70657f3a94e"
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

--0000000000009957e70657f3a94e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm a "nsp32 folk", which patch version should I take a look at?

Best regards,
Masanori

2026=E5=B9=B47=E6=9C=8829=E6=97=A5(=E6=B0=B4) 1:27 Bjorn Helgaas <helgaas@k=
ernel.org>:

> On Thu, Jul 23, 2026 at 11:00:39PM +0100, Gary Guo wrote:
> > While working on improving the Rust abstractions [1], Sashiko reported
> that
> > an existing UAF issue related to dynamic ID, which I find to be genuine=
.
> > When taking a look at the code I also find a TOCTOU issue where the
> > existence check of dynamic ID happens in a separate critical section as
> the
> > actual insertion. This series fix both issues.
> >
> > There are two exported functions pci_match_id() and pci_add_dynid()
> which I
> > have to tweak to implement this cleanly; I created separate "do_xxx"
> > functions to keep the existing APIs because they all have multiple user=
s.
> >
> > There're a few existing users which stores their pci_device_id argument
> in
> > probe callback. This is a bad pattern because nothing except driver_dat=
a
> > inside pci_device_id is what they want; actual ID information can be
> > retrieved from pci_dev instead.
> >
> > There are two users that performs pointer arithmetic on the
> pci_device_id;
> > these are also problematic with dynamic ID and driver_override, so fix
> them
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
> > Link:
> https://lore.kernel.org/all/20260618-id_info-v1-0-96af1e559ef9@garyguo.ne=
t/
> [1]
> > Link:
> https://lore.kernel.org/all/20260619170503.518F61F00A3A@smtp.kernel.org/
> [2]
> >
> > ---
> > Changes in v4:
> > - Code and commit message style fixes (Bjorn)
> > - Link to v3:
> https://patch.msgid.link/20260706-pci_id_fix-v3-0-2d48fc025acc@garyguo.ne=
t
> >
> > Changes in v3:
> > - Fix users which uses pci_device_id for pointer arithmetic. (Sashiko)
> > - Convert to scoped_guard. (Danilo)
> > - For static IDs, still give out static pointers and avoid making a cop=
y.
> > - Link to v2:
> https://patch.msgid.link/20260630-pci_id_fix-v2-0-b834a98c0af2@garyguo.ne=
t
> >
> > Changes in v2:
> > - Fix users which store pci_device_id.
> > - Clarify in probe documentation about the lifetime of pci_device_id
> >   parameter.
> > - Dynamic ID conflict check now ignores override_only. (Sashiko)
> > - Link to v1:
> https://patch.msgid.link/20260626-pci_id_fix-v1-0-a35c803f1b95@garyguo.ne=
t
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
> >  drivers/char/agp/via-agp.c                | 308
> +++++++-----------------------
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
>

--0000000000009957e70657f3a94e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;m a &quot;nsp32 folk&quot;, which patch version shou=
ld I take a look at?<div><br></div><div>Best regards,</div><div>Masanori</d=
iv></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"l=
tr" class=3D"gmail_attr">2026=E5=B9=B47=E6=9C=8829=E6=97=A5(=E6=B0=B4) 1:27=
 Bjorn Helgaas &lt;<a href=3D"mailto:helgaas@kernel.org">helgaas@kernel.org=
</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu=
, Jul 23, 2026 at 11:00:39PM +0100, Gary Guo wrote:<br>
&gt; While working on improving the Rust abstractions [1], Sashiko reported=
 that<br>
&gt; an existing UAF issue related to dynamic ID, which I find to be genuin=
e.<br>
&gt; When taking a look at the code I also find a TOCTOU issue where the<br=
>
&gt; existence check of dynamic ID happens in a separate critical section a=
s the<br>
&gt; actual insertion. This series fix both issues.<br>
&gt; <br>
&gt; There are two exported functions pci_match_id() and pci_add_dynid() wh=
ich I<br>
&gt; have to tweak to implement this cleanly; I created separate &quot;do_x=
xx&quot;<br>
&gt; functions to keep the existing APIs because they all have multiple use=
rs.<br>
&gt; <br>
&gt; There&#39;re a few existing users which stores their pci_device_id arg=
ument in<br>
&gt; probe callback. This is a bad pattern because nothing except driver_da=
ta<br>
&gt; inside pci_device_id is what they want; actual ID information can be<b=
r>
&gt; retrieved from pci_dev instead.<br>
&gt; <br>
&gt; There are two users that performs pointer arithmetic on the pci_device=
_id;<br>
&gt; these are also problematic with dynamic ID and driver_override, so fix=
 them<br>
&gt; as well.<br>
&gt; <br>
&gt; I&#39;ve used the following coccinelle script to flag all cases where =
the<br>
&gt; pci_device_id is used other than reading its fields.<br>
&gt; <br>
&gt; @usage@<br>
&gt; identifier fn, id;<br>
&gt; position p;<br>
&gt; @@<br>
&gt;=C2=A0 =C2=A0fn(..., struct pci_device_id *id, ...)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0...<br>
&gt;=C2=A0 =C2=A0 =C2=A0id@p<br>
&gt;=C2=A0 =C2=A0 =C2=A0...<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; <br>
&gt; // Due to cocci isomorphism this needs to be explicit<br>
&gt; @bad@<br>
&gt; identifier fn, id;<br>
&gt; type T;<br>
&gt; position usage.p;<br>
&gt; @@<br>
&gt;=C2=A0 =C2=A0fn(..., struct pci_device_id *id, ...)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0...<br>
&gt;=C2=A0 =C2=A0 =C2=A0(T*)id@p<br>
&gt;=C2=A0 =C2=A0 =C2=A0...<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; <br>
&gt; // Good use cases<br>
&gt; @good@<br>
&gt; identifier fn, id, fld;<br>
&gt; expression E;<br>
&gt; position usage.p;<br>
&gt; @@<br>
&gt;=C2=A0 =C2=A0fn(..., struct pci_device_id *id, ...)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0...<br>
&gt; (<br>
&gt;=C2=A0 =C2=A0 =C2=A0id@p-&gt;fld<br>
&gt; |<br>
&gt;=C2=A0 =C2=A0 =C2=A0E(..., id@p, ...)<br>
&gt; |<br>
&gt; // Redundant checks, but ignore<br>
&gt;=C2=A0 =C2=A0 =C2=A0!id@p<br>
&gt; |<br>
&gt; // Redundant checks, but ignore<br>
&gt;=C2=A0 =C2=A0 =C2=A0id ? ... : ...<br>
&gt; )<br>
&gt;=C2=A0 =C2=A0 =C2=A0...<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; <br>
&gt; @script:python depends on usage &amp;&amp; (bad || !good)@<br>
&gt; p &lt;&lt; usage.p;<br>
&gt; @@<br>
&gt; coccilib.report.print_report(p[0], &quot;suspicious use of pci_device_=
id&quot;)<br>
&gt; <br>
&gt; Link: <a href=3D"https://lore.kernel.org/all/20260618-id_info-v1-0-96a=
f1e559ef9@garyguo.net/" rel=3D"noreferrer" target=3D"_blank">https://lore.k=
ernel.org/all/20260618-id_info-v1-0-96af1e559ef9@garyguo.net/</a> [1]<br>
&gt; Link: <a href=3D"https://lore.kernel.org/all/20260619170503.518F61F00A=
3A@smtp.kernel.org/" rel=3D"noreferrer" target=3D"_blank">https://lore.kern=
el.org/all/20260619170503.518F61F00A3A@smtp.kernel.org/</a> [2]<br>
&gt; <br>
&gt; ---<br>
&gt; Changes in v4:<br>
&gt; - Code and commit message style fixes (Bjorn)<br>
&gt; - Link to v3: <a href=3D"https://patch.msgid.link/20260706-pci_id_fix-=
v3-0-2d48fc025acc@garyguo.net" rel=3D"noreferrer" target=3D"_blank">https:/=
/patch.msgid.link/20260706-pci_id_fix-v3-0-2d48fc025acc@garyguo.net</a><br>
&gt; <br>
&gt; Changes in v3:<br>
&gt; - Fix users which uses pci_device_id for pointer arithmetic. (Sashiko)=
<br>
&gt; - Convert to scoped_guard. (Danilo)<br>
&gt; - For static IDs, still give out static pointers and avoid making a co=
py.<br>
&gt; - Link to v2: <a href=3D"https://patch.msgid.link/20260630-pci_id_fix-=
v2-0-b834a98c0af2@garyguo.net" rel=3D"noreferrer" target=3D"_blank">https:/=
/patch.msgid.link/20260630-pci_id_fix-v2-0-b834a98c0af2@garyguo.net</a><br>
&gt; <br>
&gt; Changes in v2:<br>
&gt; - Fix users which store pci_device_id.<br>
&gt; - Clarify in probe documentation about the lifetime of pci_device_id<b=
r>
&gt;=C2=A0 =C2=A0parameter.<br>
&gt; - Dynamic ID conflict check now ignores override_only. (Sashiko)<br>
&gt; - Link to v1: <a href=3D"https://patch.msgid.link/20260626-pci_id_fix-=
v1-0-a35c803f1b95@garyguo.net" rel=3D"noreferrer" target=3D"_blank">https:/=
/patch.msgid.link/20260626-pci_id_fix-v1-0-a35c803f1b95@garyguo.net</a><br>
&gt; <br>
&gt; ---<br>
&gt; Gary Guo (9):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ata: ata_generic: don&#39;t store pci_device=
_id<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0scsi: nsp32: don&#39;t store pci_device_id<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ipack: tpci200: don&#39;t store pci_device_i=
d<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0mlxsw: pci: don&#39;t store pci_device_id<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0agp/via: Don&#39;t rely on address of pci_de=
vice_id<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0agp/amd-k7: Don&#39;t rely on address of pci=
_device_id<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0PCI: Make pci_match_one_device() match on ID=
 instead of device<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0PCI: Fix dyn_id add TOCTOU<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0PCI: Fix UAF when probe runs concurrent to d=
yn ID removal<br>
&gt; <br>
&gt;=C2=A0 drivers/ata/ata_generic.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 drivers/char/agp/amd-k7-agp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 26 +--<br>
&gt;=C2=A0 drivers/char/agp/via-agp.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 308 +++++++-----------------------<br>
&gt;=C2=A0 drivers/ipack/carriers/tpci200.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A01 -<br>
&gt;=C2=A0 drivers/ipack/carriers/tpci200.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A01 -<br>
&gt;=C2=A0 drivers/net/ethernet/mellanox/mlxsw/pci.c |=C2=A0 11 +-<br>
&gt;=C2=A0 drivers/pci/pci-driver.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 194 ++++++++++---------<br>
&gt;=C2=A0 drivers/pci/pci.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 43 +++--<br>
&gt;=C2=A0 drivers/pci/search.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A08 +-<br>
&gt;=C2=A0 drivers/scsi/nsp32.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A08 +-<br>
&gt;=C2=A0 drivers/scsi/nsp32.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A08 +-<br>
&gt;=C2=A0 include/linux/pci.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 12 files changed, 237 insertions(+), 378 deletions(-)<br>
<br>
I put this on pci/enumeration and plan it for v7.3, hopefully with<br>
acks from the AGP, tpci200, and nsp32 folks.<br>
</blockquote></div>

--0000000000009957e70657f3a94e--
