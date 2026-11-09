Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB739606A320
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 01:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fSdxsQ7c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5302810E72E;
	Mon,  9 Nov 2026 01:53:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 329B810E72E
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 01:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794189183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cwykLh2oqFT+B3VAP4+bD6cFXZaoX6stvsW77dDqnIU=;
 b=fSdxsQ7ctZnMJBl+waRIaIOr2bEStKP4V1yuurhvyEml3bj8SMIxC6FYFm0iZ1A9JalC9i
 bG3DofnYP7uvNd+GqC4Um41PP6+BqRFowYKOjTgFZ/X55+1PBLYzGgMkf0EbCGlCtCEHuw
 Or0lnTY0f9i5YnaBHcpbsvFBh882wMc=
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com
 [74.125.82.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-lnh7L-9xOLCYp28NR7u3dg-1; Sun, 08 Nov 2026 20:53:01 -0500
X-MC-Unique: lnh7L-9xOLCYp28NR7u3dg-1
X-Mimecast-MFC-AGG-ID: lnh7L-9xOLCYp28NR7u3dg_1794189181
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1aa0fb7f157so683279c88.0
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 17:53:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794189181; x=1794793981;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cwykLh2oqFT+B3VAP4+bD6cFXZaoX6stvsW77dDqnIU=;
 b=bm/hFBXVeS8eMBP1O5JxNhIfo7BsGOj8ZGjfGNc+igt8SDyp/ZBaFVCdmb5F2XdX8H
 1Lk8m51P656zvJTOWDRAQpgKklxba3lh7gDBciSXD0PqHgxLqDtXA9E04tiMeQk6A7Fh
 zqQHDqpWnogvNsiviwZWJ1WHdO9u62/U/Iz4K/yrwg2NRznPwkLZM4Uc7OBFrbbGmWox
 JvZy6Q9zXbBehEPaXJlnGn4X+v1skmO+7pcM5SN7ntzlWxL1v46rOejTLHNWI7316xPt
 8kGUh1C9Hzim7iBSJ0NHkOHbuSZqDoKcG8i5ioWpO51b6GZBhfsIslkaB77+wwA/VNUo
 ++sg==
X-Forwarded-Encrypted: i=1;
 AL+hErHhW1IgEuuKDVbqq57KTwxNx60KdsEYoFSCY8l84FDwmjjv4xQCuZEgxwbQTHtZyu+DxM9kUrvglwo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/u9R1u4Tpp9ZZv5g2ktZ35+sskgRJtw4DsYclFfJAFACTVVAGC
 fnvgCw4NinhnUhdVus0rQkNgRnb5L0r/o91M6g9eq+bzfVDrmfiNoGuzdb75tfKkcJVIaHuvT3Y
 WK4ODFdD/NVrDgsLj5Q+0iWTW/3baLe665k6lnR42AAjTiGBDdRBuhBheowi1VV3FC4lLcQjAlM
 L0ZOJ+06v8sIhngliaxU0ICfhsjAXielch6OTGplx5Scdj
X-Gm-Gg: AYBFou0Wka2BaE4hYP41Pzb4tlveLHxR4bXAHZWGwUVIvRsuefa1EC/TLL7zKqVZo/D
 Tzauj/hhQ82vKbWM6cEi+v2GU0HPNqa16ED4kEQy5+0GMtJP5A1vdvUHi1jQU1PNQDyDreQjbrr
 slFIOD1ilZIIdB1V08XsUOm/OfpgpM1hqzBlSX2Ne74cc6OyhGC45dMfC4cBFkgDwG9AH3HZ0+K
 JYlQYQBqV4yTGGF
X-Received: by 2002:a05:7022:1701:b0:1b2:5884:a020 with SMTP id
 a92af1059eb24-1b39fe31f42mr3918549c88.6.1794189180523; 
 Sun, 08 Nov 2026 17:53:00 -0800 (PST)
X-Received: by 2002:a05:7022:1701:b0:1b2:5884:a020 with SMTP id
 a92af1059eb24-1b39fe31f42mr3918520c88.6.1794189179953; Sun, 08 Nov 2026
 17:52:59 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106-nova-timer-v5-0-a0cd25f3ee18@redhat.com>
 <20261106-nova-timer-v5-2-a0cd25f3ee18@redhat.com>
 <DMPVNWCP35KX.177YD8SUQTBT7@nvidia.com>
In-Reply-To: <DMPVNWCP35KX.177YD8SUQTBT7@nvidia.com>
From: David Airlie <airlied@redhat.com>
Date: Mon, 9 Nov 2026 11:52:48 +1000
X-Gm-Features: AclHuK8WpacYDKwI_bUzZvmSTqdDoFyyPN-aSZy1PpBb3G3Iq2ZXfYXHjOwFeOc
Message-ID: <CAMwc25rdXBBmDjbTOE6PMv=24USP+y11TrTec3WbC7pjnD11sQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] gpu: nova-core: add support for GPU timer block.
 (v5)
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 028O4Z1P0mNlZ6C2TlzTtRPApbcYRn0o_GgYZTF2kMU_1794189181
X-Mimecast-Originator: redhat.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 8, 2026 at 11:52=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> On Fri Nov 6, 2026 at 2:34 PM JST, Dave Airlie via B4 Relay wrote:
> > From: Dave Airlie <airlied@redhat.com>
> >
> > This is needed to calculate the system timer offset that is passed
> > to GSP init.
> >
> > 2 HALs exist:
> >
> > a) tu102 is the gv100 path from open-gpu, the priv level is checked
> > and the cpu time is written to the gpu timer. no offset is used.
> >
> > b) gh100 is for hopper+
> > This is the gh100 path from open-gpu, where the secure system
> > timer is read, the offset is calculated.
> > On gh100 which need a work around to avoid sending it to registers
>
> nit: "On gh100 a work around is needed to avoid..." maybe?
>
> > if the FSP firmware is too old.
> > Otherwise we write the offset to the offset registers.
> >
> > Signed-off-by: Dave Airlie <airlied@redhat.com>
> > ---
> >  drivers/gpu/nova-core/fsp.rs             | 19 ++++++-
> >  drivers/gpu/nova-core/fsp/hal.rs         |  5 ++
> >  drivers/gpu/nova-core/fsp/hal/gh100.rs   |  6 ++
> >  drivers/gpu/nova-core/fsp/regs.rs        | 28 +++++++++
> >  drivers/gpu/nova-core/gpu.rs             |  8 +++
> >  drivers/gpu/nova-core/nova_core.rs       |  1 +
> >  drivers/gpu/nova-core/timer.rs           | 38 +++++++++++++
> >  drivers/gpu/nova-core/timer/hal.rs       | 31 ++++++++++
> >  drivers/gpu/nova-core/timer/hal/gh100.rs | 62 ++++++++++++++++++++
> >  drivers/gpu/nova-core/timer/hal/tu102.rs | 53 +++++++++++++++++
> >  drivers/gpu/nova-core/timer/regs.rs      | 98 ++++++++++++++++++++++++=
++++++++
> >  11 files changed, 346 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.r=
s
> > index 3a4a10487f33..a2ea50465a55 100644
> > --- a/drivers/gpu/nova-core/fsp.rs
> > +++ b/drivers/gpu/nova-core/fsp.rs
> > @@ -50,10 +50,11 @@
> >          NvdmHeader,
> >          NvdmType, //
> >      },
> > -    regs, //
> > +    regs as bootregs, //
> >  };
> >
> >  mod hal;
> > +mod regs;
> >
> >  /// PRC message sub-command.
> >  #[derive(Debug, Clone, Copy, PartialEq, Eq)]
> > @@ -389,6 +390,7 @@ pub(crate) fn boot_params(&self) -> &Coherent<'_, G=
spFmcBootParams> {
> >  pub(crate) struct Fsp<'a> {
> >      falcon: Falcon<'a, FspEngine>,
> >      fmc_fw: GspFmcFirmware<'a>,
> > +    chipset: Chipset,
> >  }
> >
> >  impl<'a> Fsp<'a> {
> > @@ -428,7 +430,7 @@ fn wait_secure_boot(
> >
> >          read_poll_timeout(
> >              || Ok(hal.fsp_boot_status(bar)),
> > -            |&status| status =3D=3D regs::NV_THERM_I2CS_SCRATCH_FSP_BO=
OT_COMPLETE_STATUS_SUCCESS,
> > +            |&status| status =3D=3D bootregs::NV_THERM_I2CS_SCRATCH_FS=
P_BOOT_COMPLETE_STATUS_SUCCESS,
> >              Delta::from_millis(10),
> >              Delta::from_millis(FSP_SECURE_BOOT_TIMEOUT_MS),
> >          )
> > @@ -436,7 +438,11 @@ fn wait_secure_boot(
> >              dev_err!(dev, "FSP secure boot completion error: {:?}\n", =
e);
> >          })?;
> >
> > -        Ok(Fsp { falcon, fmc_fw })
> > +        Ok(Fsp {
> > +            falcon,
> > +            fmc_fw,
> > +            chipset,
> > +        })
> >      }
> >
> >      /// Sends a message to FSP and waits for the response.
> > @@ -549,4 +555,11 @@ pub(crate) fn boot_fmc(
> >          dev_dbg!(dev, "FSP Chain of Trust completed successfully\n");
> >          Ok(())
> >      }
> > +
> > +    pub(crate) fn is_bug_3957833_affected(&self, bar: Bar0<'_>) -> boo=
l {
> > +        match hal::fsp_hal(self.chipset) {
> > +            Some(hal) =3D> hal.is_bug_3957833_affected(bar),
> > +            None =3D> false,
>
> As I mentioned in my other comment, storing the HAL instead of the
> chipset is technically better, but I'm ok if this is not done just for
> this single-use method.

Okay I've done it for v6, there are places we don't do this already,
but I'll do it for fsp.

> > +fn sys_timer_offset(bar: Bar0<'_>, fsp: &Fsp<'_>, time_ns: u64) -> Res=
ult<u64> {
> > +    let sec_timer_ns =3D sec_timer_read(bar);
> > +
> > +    let sys_timer_offset_ns =3D time_ns.wrapping_sub(sec_timer_ns);
> > +
> > +    if !fsp.is_bug_3957833_affected(bar) {
> > +        bar.write_reg(regs::gh100::NV_PGC6_SCI_SYS_TIMER_OFFSET_1::fro=
m_nsec(
> > +            sys_timer_offset_ns,
> > +        ));
> > +        bar.write_reg(
> > +            regs::gh100::NV_PGC6_SCI_SYS_TIMER_OFFSET_0::from_nsec(sys=
_timer_offset_ns)
> > +                .with_update(true),
> > +        );
> > +    }
> > +    Ok(sys_timer_offset_ns)
> > +}
>
> So I know we discussed that on v4, but this function is named like it
> just returns a value, whereas it also might program some registers. Can
> we mirror what `tu102` does and extract the `if fsp.is_bug...` block
> into another function that `setup` calls?

No, this gives the workaround too much recognition. I've renamed this
function to set_sys_timer_offset,
That is the point of this function, to calculate and set the system
timer offset in hardware. Broken hardware
should not direct the function's focus, working hardware calculates
and programs the registers.

> Regarding the truncated MSBs in `nsec_hi`, I *think* it is ok to
> truncate them indeed, as the value written would still be a valid anchor
> value for the GPU. It also shouldn't manifest itself until 2043 or so
> for chips < GH100, unless someone decides to mess with their system
> clock.
>
> I guess this issue is the reason why GH100+ are storing a delta instead
> of an absolute value.

For v6, I've done everything else asked,

For how the timer hw works, I unfortunately can't know this, because
it isn't documented in public docs, if you guys want to pursue this
internally, I can only do what OpenRM does.

Also are we okay using OpenRM? like I know there was some issues in
the past, maybe we need to have a proper way to reference the NVIDIA
open-gpu-kernel-drivers.

Dave.

