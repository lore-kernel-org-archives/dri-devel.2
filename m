Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D8BCCFA13
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 11:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 648A98908B;
	Fri,  1 May 2026 11:05:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="bWQGrRSA";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFA3B8908B
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 11:04:58 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-43cfce3a195so956559f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 04:04:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777633497; cv=none;
 d=google.com; s=arc-20240605;
 b=TlNjajvVRBtZA+P1GZ+7r2vBX09ARvaR5co5/ALiPx6ykr216hlp0D1M8Gh1WtbdgB
 yuUthtgxnaobJsTcDJT3a75xYV4W88VYAzC7BRz9jvlk1NOcGhZOb1aHfnU9UvlXBFYA
 Vbpty6HbV3NDQFmjwa0qLA/vnqEYKkkjI4C43DVj7KgAE1r7lPZNIxN5nVgX/HKKbYxU
 mSn/GkBvSR0983PH0aYA6pldLMj4RcicF8+EqDkP4NV9ju5yErK5BgjS546pbq+l4RTP
 tAvE6+l+cnQzKEUIK1ERiSHhfFNhBU+slfvXjWkgKfzmCAnzSNjSocAojQ3SFzHwGFZS
 s70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aznkOgw0hfDMNO16Jlxs4pcxjp8M3M03zZP41tgMQiA=;
 fh=JnFelZHS3ALta+0CqgE10eTZ0NbWuJ4n3Yh6WbiUVII=;
 b=M+uvw8VBoNcviU/02S9/QORCHY8K/5W/szPORs0DVryuItOJuRAFSlUdkOQgo/tCT7
 bMyAV28Wjxqv7roS1VHgHCpjWEq01XufhYn83qHGWu76pRHphDKrc7SN8/pMNZG/dVmU
 aOwhzPIuuQkBDy7dAUiQDBS+qWforYaqjtbpuZshivn6vP9Pn/Gqb7SfMBil34KzIQt6
 0+C1NLtNkgJRt9jS2OLPzv6cdWyFtoLNlpc75cpBhXFhmZt7TmWWM7l3WHNKy30NL0fn
 /Prfx7FJ5746wXThfHw6OjMNZsFhcRscSuMzg8Wwc2RX0/D9P7vBELu37eDDW4Rq3/wm
 +m7A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777633497; x=1778238297;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aznkOgw0hfDMNO16Jlxs4pcxjp8M3M03zZP41tgMQiA=;
 b=bWQGrRSASd7CkbGDbMcHQGbKkfjMztpE5He4pD61I6l8QcRiOC4WMJwZIVCLDHxsCi
 iQPkny23ut16gY3o0sZDvPFjUpljoWaC7QmEAI9eSsOLNX8ACAiI2ulo96vutw51y/oC
 jJHo3fJGO9udU7r6/oSg1gi/VWX1hy8cnkLVmQdD57smf9Fk3e+2VUR3lMn/XtRzUtko
 OaMcImLOU0B/gkYWNcd7wXsvUlpreW7MtthDUJUhhXO+iZ0Q1DW3Gh412uL5y1oVd8dD
 i3/db+Gdo6VtOoBSjr+2q176RZiG+CLluwrpsIC+3SsWWwMfeCv24LsyzicNRpH9VY5c
 rigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777633497; x=1778238297;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aznkOgw0hfDMNO16Jlxs4pcxjp8M3M03zZP41tgMQiA=;
 b=D/Tz5/INuxEDS1CDs9+vMO/Vw+AIz+r75wTg+rkzD/0UZzcyXkYZFybm3At32wzoaC
 FhmgmbDft6HpnKWvmBda3LM6jmwDll5jsd/favzGw+nc9wdn8/dvw2ZCYpc3/ZyLWGzh
 Gn3pllIcLTwxGfe4RiJfdfLIcgbfZ7DzGOSET/zAOgFicNuWRloBulOv2gtUAUN1iae0
 NCN+bUo3tTNMa1Tm1Ki+B8aou5DfbRAB2L4JitNfzsngRbjB94eqSmiGWYb3l9fu8sZi
 7v7FFLVbJp9bwiNxyyvmEpU5TKVKCTHoWmE71TYnfkqeuQVFN1QNR9k3jNquX3GMfIXo
 VX9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ZFSrHNOldY1g8DfH4/5rGOugJHGbpxsdnjHJ5/cR198kc1frrs+t+bQxCwODA9ZStviMs7iXXYQY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUDeWPyRwtCkfDTAHFlcnjc14hoEeWQ60tZY5LljFx6XzcVLGZ
 ZxiFtkKi8Bn+wbouyAWZYfj+uRioyNazhJVbUT03ZLZ+AGF2LgJTyks+3OisnTLypMfYfQ7Hxqk
 PTB/EX/JfLjOmwhWqcqjMWVyAEvHvVhn6WhnUCkKV
X-Gm-Gg: AeBDieulknGCwA7J5JbvmYipEvo7W73mLynmR147YJR07EY2g7J1tL0e1T1Cq8Fv4NE
 o+g2v/Yk5GcwlnH5eykYxT1QVLO2+77SyUVvNK/X21PYLZsjOVuCA5ugRVu7wO3ZiPQVObGKaCZ
 wsQIYTeNox/XeN7vrV+GEyZIss9Oqx4kWX49cVV/CDdm92RydRMalH6iOMtVyXJ/6EiuM2Sh9w4
 bNyZrAhvN3dkk3UG7Xskzh5yEW4bZ+MDlOJ44mJCPCJ+QLlPhIjmrEfVXuLJA6Q114+q190KFhb
 XK5Ypetr4wuF1UrWzOum+b5IUCGRyJl1DzM7JzOtQqVOqe2a1kmbjBXS74zk0mF/QaFuz/wyo8v
 nJmR2wYZD6f7uB7c=
X-Received: by 2002:a5d:584e:0:b0:43b:962b:5314 with SMTP id
 ffacd0b85a97d-4493e4a8845mr11675608f8f.19.1777633496842; Fri, 01 May 2026
 04:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260428-fw-boot-prerequisites-v1-0-c69af9abe1af@collabora.com>
In-Reply-To: <20260428-fw-boot-prerequisites-v1-0-c69af9abe1af@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 1 May 2026 13:04:43 +0200
X-Gm-Features: AVHnY4JxeTAK4DyMhi8egeWxOPl5ePCvaTAv7se_MjYItqUfwrwytrxgt9dqIvs
Message-ID: <CAH5fLghnAVmmpjfaST0+DKm66zwg_2eBD2LyEd=AsQ5OiOVsJw@mail.gmail.com>
Subject: Re: [PATCH 0/5] drm/tyr: prereqs for firmware loading and MCU boot
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com, 
 beata.michalska@arm.com, work@onurozkan.dev, alvin.sun@linux.dev
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

On Tue, Apr 28, 2026 at 9:20=E2=80=AFPM Deborah Brouwer
<deborah.brouwer@collabora.com> wrote:
>
> This series extracts patches from the Tyr firmware boot series that have
> no additional prerequisites and can be applied directly to drm-rust-next.
>
> Most of the patches are unchanged from the fw-boot series, except
> "drm/tyr: use shmem GEM object type in TyrDrmDriver"
> which now also selects RUST_DRM_GEM_SHMEM_HELPER in Kconfig.
>
> Link to [PATCH v4 00/20] drm/tyr: firmware loading and MCU boot support
> - https://lore.kernel.org/rust-for-linux/20260424-b4-fw-boot-v4-v4-0-a5d9=
1050789d@collabora.com/
>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
> Alvin Sun (1):
>       drm/tyr: use shmem GEM object type in TyrDrmDriver
>
> Beata Michalska (1):
>       drm/tyr: set DMA mask using GPU physical address
>
> Boris Brezillon (1):
>       drm/tyr: rename TyrObject to BoData
>
> Deborah Brouwer (2):
>       drm/tyr: move clock cleanup into Clocks Drop impl
>       drm/tyr: add shmem backing for GEM objects
>
>  drivers/gpu/drm/tyr/Kconfig   |  1 +
>  drivers/gpu/drm/tyr/driver.rs | 39 +++++++++++++++++++++++--------------=
--
>  drivers/gpu/drm/tyr/gem.rs    | 24 ++++++++++++++++++------
>  3 files changed, 42 insertions(+), 22 deletions(-)

Applied to drm-rust-next. Thanks!
