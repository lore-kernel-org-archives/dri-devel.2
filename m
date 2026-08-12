Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555F9C5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 23:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8D6310E40B;
	Wed, 12 Aug 2026 23:44:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cTRaB0u8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A56D10E40B
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 23:44:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D7766600AD;
 Wed, 12 Aug 2026 23:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AB31F000E9;
 Wed, 12 Aug 2026 23:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786578242;
 bh=qN1nHzHYc9IBamgWW2yAn7hhH8RW5Ex2R8ZyORav0sg=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=cTRaB0u8/UBL3SSClUBBNIBqRw4pXYvnih8umtI2tBUEqCiQFvlO/DDZwf4qGHBn6
 Jh2PrV0WgItWD1B4SRDk0Nbci6O5qzF6Alu+ocJDwubjZRttmhiuh1/MrKNAxM2E1N
 Fot/pGW/5Xkd47UuhaN8kv+E+ATiXVvwCDZafgPT4XsumeTmUGucmWWhbhGg35qW9g
 wCTK6dH4g0cHJfSDiQ70Apyk8kKZc0aclQoEEzJUvj46resDEOtmK+vyOFcJVZeYvz
 fx6Ph5WHG/ewhsPf+BwCB7WpCwicuBB99NDDmdIBJD+CM7E17vldh+xKbWxf7dp8Jb
 /ZXWkDK7V0n1g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 01:43:59 +0200
Message-Id: <DKND4OSMTWUQ.27FAHZ1JSUKYJ@kernel.org>
Subject: Re: [PATCH 1/2] gpu: nova-core: gsp: retain the GSP-RM log buffers
 after unbind
Cc: <acourbot@nvidia.com>, <aliceryhl@google.com>, <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
To: "Vladislav Zaharov" <vladazaharova2018@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260812113752.532537-1-vladazaharova2018@gmail.com>
 <20260812113752.532537-2-vladazaharova2018@gmail.com>
In-Reply-To: <20260812113752.532537-2-vladazaharova2018@gmail.com>
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

On Wed Aug 12, 2026 at 1:37 PM CEST, Vladislav Zaharov wrote:
>  struct LogBuffers {
> +    /// Device the buffers belong to. Also names their debugfs directory=
.
> +    #[cfg(CONFIG_NOVA_CORE_KEEP_GSP_LOGS)]
> +    dev: ARef<device::Device>,
>      /// Init log buffer.
>      loginit: LogBuffer,
>      /// Interrupts log buffer.
> @@ -144,6 +167,127 @@ struct LogBuffers {
>      logrm: LogBuffer,
>  }
> =20
> +/// Copies of the log buffers of a GPU that is no longer around.
> +#[cfg(CONFIG_NOVA_CORE_KEEP_GSP_LOGS)]
> +struct RetainedLogBuffers {
> +    /// Device the buffers came from.
> +    dev: ARef<device::Device>,
> +    /// Contents of the init log buffer, empty if it was never written t=
o.
> +    loginit: KVec<u8>,
> +    /// Contents of the interrupts log buffer, empty if it was never wri=
tten to.
> +    logintr: KVec<u8>,
> +    /// Contents of the RM log buffer, empty if it was never written to.
> +    logrm: KVec<u8>,

I think those should use VVec.

> +}

Let's move all the LogBuffer code into gsp/logbuffer.rs to keep gsp.rs clea=
n.

> +#[cfg(CONFIG_NOVA_CORE_KEEP_GSP_LOGS)]
> +impl LogBuffers {
> +    /// Preserves whatever the GSP logged, so it can still be read once =
the GPU is gone.
> +    ///
> +    /// The buffers are DMA allocations of the device and cannot outlive=
 it, so their contents are
> +    /// copied into memory owned by the module and exposed through fresh=
 debugfs entries. Those
> +    /// live until the module is unloaded.
> +    fn retain(&self) -> Result {
> +        let logs =3D RetainedLogBuffers {
> +            dev: self.dev.clone(),
> +            loginit: self.loginit.snapshot()?,
> +            logintr: self.logintr.snapshot()?,
> +            logrm: self.logrm.snapshot()?,
> +        };
> +
> +        if logs.loginit.is_empty() && logs.logintr.is_empty() && logs.lo=
grm.is_empty() {
> +            return Ok(());
> +        }
> +
> +        let mut retained =3D crate::RETAINED_LOGS.lock();
> +
> +        // An earlier run of the same device may have left a copy behind=
. Its directory carries
> +        // the name about to be used again, and its logs are the older o=
nes, so drop it first.
> +        retained
> +            .gpus
> +            .retain(|gpu| gpu.dev.name() !=3D self.dev.name());
> +
> +        let dir =3D match retained.dir.clone() {
> +            Some(dir) =3D> dir,
> +            None =3D> {
> +                #[allow(static_mut_refs)]
> +                // SAFETY: `DEBUGFS_ROOT` is set before driver registrat=
ion and cleared after
> +                // driver unregistration. This runs while a device is st=
ill bound, or on the way
> +                // out of a failed probe, so the driver is registered an=
d nothing can be modifying
> +                // it.
> +                let root: &debugfs::Dir =3D unsafe { crate::DEBUGFS_ROOT=
.as_ref() }.ok_or(ENODEV)?;

I think we can avoid this additional unsafe if we just create the retained =
dir
right away in module_init().

> +
> +                let dir =3D root.subdir(c"retained");
> +                retained.dir =3D Some(dir.clone());
> +
> +                dir
> +            }
> +        };
> +
> +        let scope =3D KBox::pin_init(
> +            dir.scope(logs, self.dev.name(), |logs, dir| {
> +                if !logs.loginit.is_empty() {
> +                    dir.read_binary_file(c"loginit", &logs.loginit);
> +                }
> +                if !logs.logintr.is_empty() {
> +                    dir.read_binary_file(c"logintr", &logs.logintr);
> +                }
> +                if !logs.logrm.is_empty() {
> +                    dir.read_binary_file(c"logrm", &logs.logrm);
> +                }
> +            }),
> +            GFP_KERNEL,
> +        )?;
> +
> +        retained.gpus.push(scope, GFP_KERNEL)?;
> +
> +        dev_info!(

dev_dbg!() should be good enough.

> +            self.dev,
> +            "GSP-RM log buffers retained until the module is unloaded\n"
> +        );
> +
> +        Ok(())
> +    }
