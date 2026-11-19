Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F49160A260D
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yC9mR5ux
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A66E6112594;
	Thu, 19 Nov 2026 15:58:09 +0000 (UTC)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E066B112594
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 15:58:03 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-83c1a9bd428so331508a34.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 07:58:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795103883; cv=none;
 d=google.com; s=arc-20260327;
 b=etcMh6cdcbgq7HmuVgandG8WmoUGAqAS3HTySaBtBYf0Oi47vvJaBo52yj8PPnAhXF
 GQM7kF0P7N5as2K3owYKSG2cLwM7nRTkL2wnoiptHMTne68T4M9evpfeVsKPXui0mTgs
 W0X2Xu57w7S6w2frzz4H9x/1y4bg1arqyO+9bT9KYU7miVtXBlMVSFnekHx82dFbB+9z
 z6p5WpfISiJtVrB3stL3iIc8EZjTRQFMiDzStp3SUUVE6GWBcDtHV4410jPokT/t4LB1
 bXlNeA+FYmuMZXZ/Xfi0vFE9mRmlNvuNiqhkiN6eFft3rla9mUlNw3vQ0Vcawb/kSxi2
 NA0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Zfp/sSG5jLSQxyif0VfIAOH3AOIjZA6+lW+WncRGZ4Q=;
 fh=qB0OIczHUgTdBhp1V/ABJKdpdobW5j5dk18G03Ezq5E=;
 b=OWd4V/ZHwjU/dBMspyUJse516s+jSypLujRi37w5TucPFWWg2uhTRtyWs5u2lj1+ky
 eNVYSX3QcgQcFuquUjBR8QHVSPsSxHDkZ1SL91D3bgpDoZp7QfR3BGYxlvYHsAI9lyMq
 l5h7kZ/8YNxZqte4RnBfbOC6ti7adaQ9hYfEk3IfHy9rtNifSnp1gjkAP0HJ7m2C7b3M
 u11XE385q92HYHz7UbSfztNA05WNMMGf3TRAMEMP/VDkwaec34u+u0S1kYPVea0jkl4S
 FkQn4OJ5kf6Z3bc3yetOaoy9TyVJEEntZC4ik8pkrF/1S6gq6+4wGMOR/nUsEIiz/VsG
 FmAg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795103883; x=1795708683; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Zfp/sSG5jLSQxyif0VfIAOH3AOIjZA6+lW+WncRGZ4Q=;
 b=yC9mR5ux06v/Hev4UANN/B27AJXj+bAROAmifbgjwQyT1jgqYC3uBT6zcjyMQ65saG
 8uuFsGTmQRKDpPycpAXaOF79XqJCLTLBrZWeYSsOdNgkpVi6rAZvXlrghYpiXWWbrWdr
 w7/QxajQu/37zsT950cM51R93QiKO+B9kx1il4BL+sKRVuX3ebXUTDRsKpacGg4a3Sl6
 DhKEd+GT22ytBLGN5aJ8ziPccSB3TGKx9zdKUNjBOTGAkVxhE6474Xr7WIYnMeOS5hQR
 wzEkwN5C1yNu5wwnAy0BAilJ3NeXQDYPUzNSONdW5SguyE1VIV5ou1hdRLJ4HPy8lgej
 236g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795103883; x=1795708683;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zfp/sSG5jLSQxyif0VfIAOH3AOIjZA6+lW+WncRGZ4Q=;
 b=Hj20rh4TXimLTpyuC+l0qDNOxFTCH/aun7waOM3C1YybgiJd6xpM+LkDlz/+SraBxV
 /l8Opkpasdqnu2Pe3i13WaywS5EOgIWSJq+1NPC661R1pRQkMLAvLPkA/xPRrkZOxos6
 UfyWtk3dZDOeAqYHEzS9sQ5kxDPgQjNDUjxznQxXTQ7emD1Vz6V5j1uJiEIYu5MUraEZ
 h5CRUxZPvgKOdFtwTHmoxIiAAbSt76YUpI2F5y4QRp8oPmf1ZHjnHxGNATzicHmZP9S0
 7I3HU5XGRILpyw9FKHELZeuSh26oPwzrCEq4TboFXxHs+/8AjbiERArb21qdZWke8VEW
 Rugw==
X-Forwarded-Encrypted: i=1;
 AL+hErH+w+W6UFZaLECqI4X4AzJcDABFIG7Utsi4M2mJDnjkjq0xpU7srBaRyXvAf9DNTCQccnDZHyWgLcs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+FfKVkn3LJaPDjxaduqXfzW2Lni9KS+UIjjy1dn7vaeLjLECWs
 97hZ1ZRoyJxOsDbcDn1hiLwTUFVzQ1OPgV0N9n+aLC6OtUqrYF///AaWSodVuHE4k4dZyw35Hmj
 krWbj6s299wXDnCSplcSbJuA3anCKKAU=
X-Gm-Gg: AYBFou3KBkmzeRAmzy81TVI340CgrtxpIHBv+PmtePbPnX/ICxW7s1fw/meqJ2908SN
 H/s/xz1YvbPk6KeYXHeEcwbxfZCjGjFwIZqqew5YkA9mo3fI/TkEQ6b1h+JQSpzBhnqV/Z7f9ew
 7VLe6Jizu9kOCsW2vvR2Mz7cb02oPUqey/EaaGjp5FZImm9G/HGFhmrN7g7KgctaMwwGsvb+s29
 i5j1pmjj3J+XsERtegBUzN87pdusKQXy6XTWW89IWGd+nRqjnqL/4nA/li7LKsazgHQGt4/raJ7
 WKa/Su8DS8WcRTJF9Z7/TpCJCJlWBidUYLkedP9ph0PFmdgkMT0XkHmZE3ns+TYBlFMf/Co3p89
 zgRUGM+gmh9Fi3afle3GUldTyM7PojE8ohgtTymqE15yR9pKSgBmjHyo9dtKXhp4Eki2wXD/kKr
 6xyC+8y5zhf8rnjLMQS4KlUh5vsdLE/TXGm6Oz75FisaGCc0PBIOPBVZsLZmXJ
X-Received: by 2002:a05:6808:1a0f:b0:572:f9ab:c2c5 with SMTP id
 5614622812f47-57a0910b919mr443253b6e.4.1795103882844; Thu, 19 Nov 2026
 07:58:02 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111-vfct-regression-v6-0-393797bbb6e3@amd.com>
 <5cf8f937-acc8-475e-ba0c-6be00defbb53@amd.com>
In-Reply-To: <5cf8f937-acc8-475e-ba0c-6be00defbb53@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 19 Nov 2026 10:57:49 -0500
X-Gm-Features: AclHuK-Pw2ItFRgv4vG8DuHpZH3Cm8ObSCuVEl9wVmjZ1BCfQqEiUUdyusvBEWI
Message-ID: <CADnq5_PAarNZ24xOU3MqVfEra1hSOqgrKQxvLppyCWZQebr_yw@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Fix amdgpu detection of pci=realloc
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Oz Tiram <oz@shift-computing.de>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, 
 Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 10:30=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 11/11/26 10:43, Mario Limonciello wrote:
> > amdgpu needs to know the bus number the platform assigned a device to
> > be able to match firmware images against the right device.
> >
> > This was previously adjusted to be a soft filter due to
> > commit 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with
> > soft filter") where if everything but the number matched to take a devi=
ce.
> >
> > This however fails when there are two identical devices.  Instead save =
the
> > initial bus number to the PCI device structure and then match that.
> >
> > Link: https://lore.kernel.org/linux-pci/20261015124843.203905-1-mario.l=
imonciello@amd.com/
> > Link: https://lore.kernel.org/amd-gfx/20261019194106.2796150-1-alexande=
r.deucher@amd.com/
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> > Changes in v6:
> > - Capture the firmware secondary bus number when reading bridge windows=
 and
> >    ignore unconfigured values so rescans cannot replace it with runtime=
 data
> >    (Sashiko).
> > - No change needed in the VFCT consumers; they continue to read the cac=
hed
> >    value from the upstream bridge.
> > - Link to v5: https://patch.msgid.link/20261110-vfct-regression-v5-0-f4=
9fae981bf3@amd.com
> >
> > Changes in v5:
> > - Record the firmware secondary bus number only on the bridge struct pc=
i_dev,
> >    guard it with a validity bit, and keep it across rescans (Bjorn, Lij=
o).
> > - Drop pci_bus::number_initial and have amdgpu/radeon read the saved br=
idge
> >    number when matching VFCT entries.
> >
> > Changes in v4:
> > - Retain secondary bus bus number for a bridge across rescans, and the =
child bus is initialized
> >    from it during allocation, before registration callbacks run. (Sashi=
ko)
> > - Rename variable to clarify it's for bridges (Lijo)
> > - Link to v3: https://patch.msgid.link/20261026-vfct-regression-v3-0-fe=
9586ed6978@amd.com
> >
> > Changes in v3:
> > - Preserve the firmware bus number across bridge renumbering, capturing=
 the
> >    secondary bus number before pci_scan_bridge_extend() clears it.
> > - Adjust member name in all patches
> > - Add tags
> > - Link to v2: https://patch.msgid.link/20261020-vfct-regression-v2-0-d2=
394d11450a@amd.com
> >
> > Changes in v2:
> > - pci_alloc_dev(NULL) remains safe.
> > - For buses behind a reassigned bridge, the PCI core now saves the firm=
ware secondary bus
> >    number before clearing the bridge configuration and carries it into =
the newly allocated bus.
> >    Devices discovered there inherit that original number.
> > - Add changes for radeon too.
> > - Link to v1: https://patch.msgid.link/20261019-vfct-regression-v1-0-5a=
63ddd378dd@amd.com
> >
> > ---
> > Mario Limonciello (3):
> >        PCI: Cache bridge firmware secondary bus number
> >        drm/amdgpu: Match VFCT using initial PCI bus number
> >        drm/radeon: Match VFCT using initial PCI bus number
> >
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23 ++++++++++-------------
> >   drivers/gpu/drm/radeon/radeon_bios.c     | 25 +++++++++++------------=
--
> >   drivers/pci/probe.c                      | 16 ++++++++++++++--
> >   include/linux/pci.h                      |  4 ++++
> >   4 files changed, 39 insertions(+), 29 deletions(-)
> > ---
> > base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> > change-id: 20261019-vfct-regression-2142fc52852a
> >
> > Best regards,
> > --
> > Mario Limonciello <mario.limonciello@amd.com>
>

Is v6 preferred to v7?

Alex
