Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06902FF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:14:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59D6410E142;
	Tue, 28 Apr 2026 07:14:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cJ1aTtFs";
	dkim-atps=neutral
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F66C10E142
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:14:06 +0000 (UTC)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-8a016799d2cso121642656d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 00:14:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777360445; cv=none;
 d=google.com; s=arc-20240605;
 b=MX6uM4uD+FGPldMn3yQYe+IhAy6EswYR7GukK/ByDh9JXy34z9DsyTDCdZAxGQtQ7E
 2+wFcgS3QBrv4aFOR8tmR/um8osfK68cZKiSh8AFR/Mq9VjYmUjLcc1QI6QxmcEVqjPp
 41R/zxpSzG2GGkFplnCzBwMrRfLxq57oR5EsNmjKQcSm7A9as+NR41IYw/K99KvS7B0i
 pEWRIQjOL7TIxpSh/OlowUErUX9oV3ByJJK7RsBwI3P7Xoy7LbzGklCQECKVQ4nCz4J3
 YTtRUhZOQA39OT87RIzdOKZCfJ/yGVhIGUPmBc5VGqBcahMxeXLirwSsR5YU2kp+WhyC
 G/YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4W/BRRXVZrOrIYfHk58kcoL0ZIugS6jzrDp2fpxbXyE=;
 fh=JzMJtsGa+jZOcb54sk0AwXZ7gVBMCgPMa3Df4XWWzoY=;
 b=Bmo+/6z43t37GmsYPbdQdKJSSpZ7lbgVmC106qeIlw4svggbT6oofW991ikPB474lM
 OvAgPTt/g6QWq8xaW+0Thl6vtODR9xYRSV7SUUV68f+0S40ZwSxCSirng6iqFHSVyHtJ
 mLZOnmARrl6DiGBPHrtBPJhoKwdU/FN+K2z4SD9+A5tTnwaU4edICiC0ajr+ZdsIzgjE
 LCYjcR7qiCSy2A8qfLhtvl0+K7fcbhJ4RhJQiEsVGtmmgi7fBgy+iy9htEdzaAMR5DgP
 fep5E7N5mZ3M43AM4PHqH9cxK8hiTY4jMBvOYi901IrXYyiySo2xTcLXgWjKoU2QD9MS
 1o4Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777360445; x=1777965245; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4W/BRRXVZrOrIYfHk58kcoL0ZIugS6jzrDp2fpxbXyE=;
 b=cJ1aTtFsW3tlRSjG4GrGtnq1fcaYwn5BPA4G4FE7DhiDzPHtUkFfEXcuru6GXH4AKO
 dRL3yxsjJ3H28Fe3+T+JXOP5czj2mP+yjz4K7tp/uP1CfC/YNazg5KDBV1De7IIJ+bFS
 9w66fb7cMkNKN12ntgBNtomG/qLcJHgJ2w+FnPRCQqQd29tia30W9c/cmodIAiU7oL/7
 UIPIWzJLjwm2bLFQ2jIAFJNhW6w5KaB5vRXh4oI02Y8EDcFQK0sB2/tGEW4/DOfEnKuJ
 KKQG1NwxL00qJ/bTxLQ/TeQgent2llKtrJQikijjimcaz1bizjUNBwAPIHzXAKv3e+fq
 GIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777360445; x=1777965245;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4W/BRRXVZrOrIYfHk58kcoL0ZIugS6jzrDp2fpxbXyE=;
 b=olfXpGGchx4umTFghsXju5xRRFY6b3Ykf0stjY43l8ZWgb5YKlyNbmsh9ImRoISkWW
 q/MLS05QBGnZm9GWEBTPpMCFgtBzCokDGFG2ks26bPibMzcYyALnIl47eu/3D9bRg9Ii
 VmAmSICEahYbBVbGS2rMg/L9YJsWjUWEH+T7/w9/NgMJLzSgdnfVpD/LYLOLGyDq6x0Y
 VSG8PoHmeUK5efpm4xOUMQu5EViyZsZ2WNrcluZt6iGKhg6oqZX2vqgAIPIOJ8hDjHaI
 VzXDHC0o7da92Rz6Ft2CleqIGwO/C+sXc+HpuYeTy30Pdssy+tqYcNRpbP+M6z7ediFg
 EzQg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ptxaUlJnzo+EMIGjFN2mm2VCtggP4Fhb8YDVMAoECM868iffkis8zNit75YpypbKR/FxLx8BXuxA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmPYShJoYgiCF/h+vAnYgAbkwmBa8Y05jNYNBVLHF4qUsyRoPI
 ONwdPJHu31ns2P/s8Dp+nQAzNM2aH30FpC2pOnR62KIsxrM7WUnZcxbroe50V1TJih4NAUUV70K
 6gMYEX1DTgXEccJ7ohicTVONAqVUlKdc=
X-Gm-Gg: AeBDievsEMKxVlTrB5ZVbWj1wSXV2bBciMZ+g6Y0n1dameizN0+GChdWzobnSqkXmwh
 xzgFTGapRgP8rI7qO3G9bxlqFX3jTHlAk6/WfWnAF7cv3ubFzpdLdaMa3Wn3WFGI1hinYEpa5j4
 6U92VPUzyAtySg2r9Kv4Z2ZR4BKMkFmkL4O3hb0tJR+dAtQqTEqbxago8NPzSOwMB73PkL3eZPH
 o2ClOS+gQv92XiQ0elSwu0G1KcIfynT1M7f7jcwkhvCRqoFhT8e2gWkSytGY0+2vDRZpTsH9PVb
 YqG5yKXnb3KEafYQiTQlIDYI4EsSTmsUgCwNuQQsQNIu9tdJVyXZBD0TdY+kalRGAz3woN+/A4p
 vH4/KtCUjo01H
X-Received: by 2002:a05:6214:c85:b0:8ac:7e8d:859b with SMTP id
 6a1803df08f44-8b3e3042234mr33557846d6.16.1777360444839; Tue, 28 Apr 2026
 00:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-nova-unload-v4-0-e145ccddae66@nvidia.com>
 <20260427-nova-unload-v4-6-e145ccddae66@nvidia.com>
In-Reply-To: <20260427-nova-unload-v4-6-e145ccddae66@nvidia.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 28 Apr 2026 17:13:53 +1000
X-Gm-Features: AVHnY4JXyz-pKFTieaHSl_cn50HfzH5pJCH8mAkupYMsNUdKe3qRNzjTlM-mr8Q
Message-ID: <CAPM=9tx_QJf1VNh7TDMFuaWoaZqAhte5ybADef7vfroeB5HSew@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] gpu: nova-core: gsp: shuffle boot code a bit to
 keep chipset-specific parts close
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Simona Vetter <simona@ffwll.ch>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 27 Apr 2026 at 16:57, Alexandre Courbot <acourbot@nvidia.com> wrote:
>
> Some parts of the GSP boot process are chip-specific actions, whereas
> others (like sending the initial post-boot messages) deal directly with
> the working GSP.
>
> Reorganize the boot code a bit so the chipset-specific parts are clumped
> together, which will make their extraction into a HAL easier.
>
> This has no effect on the GSP boot process.

So this is something that has changed in open-gpu over firmwares.

Older firmwares pre-595 always queued up the async messages before
hitting the boot sequence,

on 595 and later you send the async message later in the boot process
once GSP is booted.

I can't read enough context in this patch to know if that matters, but
I just thought I'd point it out.

Dave.

>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/boot.rs | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
> index e75c4b235aab..2e1401cd6171 100644
> --- a/drivers/gpu/nova-core/gsp/boot.rs
> +++ b/drivers/gpu/nova-core/gsp/boot.rs
> @@ -187,18 +187,13 @@ pub(crate) fn boot(
>          let fb_layout = FbLayout::new(chipset, bar, &gsp_fw)?;
>          dev_dbg!(dev, "{:#x?}\n", fb_layout);
>
> +        let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
> +
>          // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
>          if !fb_layout.frts.is_empty() {
>              Self::run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, &fb_layout)?;
>          }
>
> -        let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
> -
> -        self.cmdq
> -            .send_command_no_wait(bar, commands::SetSystemInfo::new(pdev))?;
> -        self.cmdq
> -            .send_command_no_wait(bar, commands::SetRegistry::new())?;
> -
>          gsp_falcon.reset(bar)?;
>          let libos_handle = self.libos.dma_handle();
>          let (mbox0, mbox1) = gsp_falcon.boot(
> @@ -227,6 +222,11 @@ pub(crate) fn boot(
>
>          dev_dbg!(pdev, "RISC-V active? {}\n", gsp_falcon.is_riscv_active(bar),);
>
> +        self.cmdq
> +            .send_command_no_wait(bar, commands::SetSystemInfo::new(pdev))?;
> +        self.cmdq
> +            .send_command_no_wait(bar, commands::SetRegistry::new())?;
> +
>          // Create and run the GSP sequencer.
>          let seq_params = GspSequencerParams {
>              bootloader_app_version: gsp_fw.bootloader.app_version,
>
> --
> 2.54.0
>
