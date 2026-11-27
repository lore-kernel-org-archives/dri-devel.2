Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E29606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=asvmTp1e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA305112B3F;
	Fri, 27 Nov 2026 14:50:36 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DCD9112B3F
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 14:50:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9CE4E4537B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 14:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2CA1F00899
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 14:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795791029;
 bh=3jNoWnulbrsDpVqqs904fRidVqIbZWsGQHKPgCx74o0=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
 b=asvmTp1eHdvI/IZXhgvTmgWBGVGWINsxFfv71+oro5tsHYG9zv/HhjEIicEE+VfXz
 wWDsg9tMFeXqveIKChi3wbKSCL9rVkS5a39EVtZBJu9VHHItnWI9nS1Kp/fAIUDRFl
 sr2H4J+FeZKJNkfqnwwjRzgmyEUkPEFqwkS2AyozNYOD3Bb52EWAxnjQ9mH0q+H1lb
 5YFqJLdstQJvsMU+PE4CPe+sP/2cqiTGkMSLJjoQqi8788H/LPlMeLXZpJvFd/aRDb
 AvzT05/HWtdV6qQ6ZN0pvu90wxtShu3uUc0nri5ZkNZ/iRrbwi8w6QjSrWwYMuu+Xp
 yWndXD6iO/xaw==
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-5bcdae234ecso3256735e87.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 06:50:29 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErFGvTh8IJRvJpG56cJKc/BxfoHJtQa6wV7dShIkLdtZLUJoXMrpHG4oy3s9u8vhx5uvKRhDPWzo/Xo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8RCnx2PEkM7r2D9UzsmUzgA8nMyx3bTFUdDSZ82fDDj3sBCBhj
 Uuxxb5xnmAHLB1NULcZyr9uIWQA4iScrSVivQxvJHvAAbgDW57N+gdsZatxbIXDoXS0ra/G1Nt3
 /Sclt2Fg5BugvRAfBsTn77lSSp05YOX8=
X-Received: by 2002:a05:6512:2353:b0:5bf:c3e2:41c1 with SMTP id
 2adb3069b0e04-5c1bc809895mr7113918e87.44.1795791027796; Fri, 27 Nov 2026
 06:50:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261127080649.1982883-1-alastair@d-silva.org>
 <18637573-d20f-4a58-9e63-6bf71b015cef@arm.com>
 <d4a41c5cfb33d6d39f0ba927541beca1175ad001.camel@d-silva.org>
In-Reply-To: <d4a41c5cfb33d6d39f0ba927541beca1175ad001.camel@d-silva.org>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 27 Nov 2026 22:50:15 +0800
X-Gmail-Original-Message-ID: <CAGb2v65KRdVqauuJ0F-fb3Fvtx5HJqv-fUTaFJS+xEsQ+Wb78w@mail.gmail.com>
X-Gm-Features: Aa3M54oOaQujivp7_3Q1utEL14RKW5So41dM2VxpASzKJxC7DwsjG9miI_JHOKg
Message-ID: <CAGb2v65KRdVqauuJ0F-fb3Fvtx5HJqv-fUTaFJS+xEsQ+Wb78w@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: dts: allwinner: sun60i-a733: Add simplefb HDMI
 support
To: "Alastair D'Silva" <alastair@d-silva.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Hans de Goede <hansg@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev
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
Reply-To: wens@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 27, 2026 at 9:58=E2=80=AFPM Alastair D'Silva <alastair@d-silva.=
org> wrote:
>
>
> On Fri, 2026-11-27 at 10:03 +0000, Andre Przywara wrote:
> > Hi,
> >
> > On 11/27/26 09:06, Alastair D'Silva wrote:
> > > This series adds boot-time simplefb HDMI support for Allwinner A733
> > > (sun60i-a733). U-Boot enables DE3.5, TCON_TV0, and DW-HDMI2.0 and
> >
> > Where does it do that and which U-Boot version does?
> > I don't think we really want simplefb in the mainline DTs any more,
> > unless there is a big blocker or delay for proper Linux DE support (lik=
e
> > there was back in the A64 days).
> > In Jernej's HDMI series he hints about A733 support being pretty
> > straight-forward with the reworked H616 DE code, so chances are we see
> > proper DE3.5 support in DRM rather sooner than later.
> >
> > Cheers,
> > Andre
> >
>
> I think the blocker was firmware for DE for this SoC - it can be ripped o=
ut
> of the Orange Pi OS blobs, but that won't be acceptable for linux-firmwar=
e.
>
> I'm currently reverse engineering the GPU firmware blob, it's not very la=
rge,
> and is a well understood instruction set (MIPs) so that may be a path for=
ward
> without the vendor contributing the blob to linux-firmware themselves.

GPU and DE are completely separate blocks. You don't need the GPU to have
display.

And slow down. You sent out dozens of patches at -rc5 (closing in on -rc6).
Realistically none of them will make it.
