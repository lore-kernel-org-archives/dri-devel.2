Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20153606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 05:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F12dJUjT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4599910E108;
	Fri,  6 Nov 2026 05:31:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0003210E108
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 05:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793943078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ETCF0+HmnthE7J+xY9bu/qhg07qsCOC241t1Ub+aMNg=;
 b=F12dJUjTjf4IzkowJaDvMYYMs6DximIADGK8AF08rW33GTVc17tQP3K+vEgUY5kJWWfFr9
 t60xWZ4Ra7AlvcRm/6FwClgJSWMByUTNkOZb9AKIMEJvnsfPhOB2wob6sF3PuFftDbfhI/
 +QpVV6gpB/Tw6PhkkQRdhAxcd1w7k1o=
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com
 [74.125.82.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-P5SF8TbHMZWvj5XePpaGrA-1; Fri, 06 Nov 2026 00:31:16 -0500
X-MC-Unique: P5SF8TbHMZWvj5XePpaGrA-1
X-Mimecast-MFC-AGG-ID: P5SF8TbHMZWvj5XePpaGrA_1793943076
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1aa0fb7f157so843233c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 21:31:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793943076; x=1794547876;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ETCF0+HmnthE7J+xY9bu/qhg07qsCOC241t1Ub+aMNg=;
 b=Vj9/QK9eoVVEvyKH9cKSqS1KGQIhHkgYoPNhjQOHlZjFequQFzdP2j2UwUvwstsZOK
 aum8+uNTs0u6Q4XB0aNXfjNxTroDuhfiA3OvIOzLwzGLyto+OO/Ko9qHs/XoP1HL+9JM
 Qbt8Emj8C81YV4/wSa16xp8prcdj/BoX8x2xlu3r1WDvJplVksX/vc8/jqK0Q2Yj2pqq
 fSIMJJtwQQtGp2HQfELkm8+vE/JouU46ya8ROBhd4y1smbVrXLWN4euCosCy0F1A9LMf
 HB24tO7V2i1LXgztEGz3gFQV8bZtlzSBTLF0EqdgFy0LGJ41gLnAVrcbSHOxMSabQKT9
 2PJw==
X-Forwarded-Encrypted: i=1;
 AKwUvByDo85s1WXAyZw3dDbyTSfoQcSsENwrIFPupiwP5m3tklr2FNiVP8o1IbKU6WqudjQPwyqjioezUtw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+W6VYAJXV0UDz27nFrZSm73SIg05gmXICW/OakH14JQuaSlZtn
 4IwoWDPGepXKPVlfCtAIDhOAEwLm8qldbCoSa5s2+CYzdTyN01JPkMOp5ffA+CoQbBgJyFT8Z85
 UOPgSDIPqZcB1GF8p5XPWVqfTevCWbiVOg1rr/2urcv8POX1dzYoRsUl4p8CvYYcxcvkI3jMb9H
 ujYSnLghr65I+CycwNkmc0EZEuWp9hHXR8rGhPenLRHOUC
X-Gm-Gg: AYBFou0PssYzSRbdBTzPtIRRorOnN1GEt41BOkgqD1EWG1oAn82MCRhGeGMcov51Yz+
 cgXvDnZNPVNls6K40wE7oDe10oPrRaYVyWnwde0Cwyz3eDymGOQYOiH4jSmZgEy1NRneRFWil2t
 fPQ/sf6T3SeRtSbohUL7eXFLnatBSDP2u0MHyud3MmQSnlq73yy+ZAVvFQCfAFEmGrCEP5HqOMN
 WcMLQqFnfK49JBa
X-Received: by 2002:a05:7022:7f06:b0:1b2:39fd:3252 with SMTP id
 a92af1059eb24-1b25d334f98mr1947906c88.19.1793943075559; 
 Thu, 05 Nov 2026 21:31:15 -0800 (PST)
X-Received: by 2002:a05:7022:7f06:b0:1b2:39fd:3252 with SMTP id
 a92af1059eb24-1b25d334f98mr1947867c88.19.1793943074925; Thu, 05 Nov 2026
 21:31:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-nova-timer-v4-0-45a7c121d4de@redhat.com>
 <20261105-nova-timer-v4-2-45a7c121d4de@redhat.com>
 <DMNCVDFYPL3I.3CCYXY4641F13@nvidia.com>
In-Reply-To: <DMNCVDFYPL3I.3CCYXY4641F13@nvidia.com>
From: David Airlie <airlied@redhat.com>
Date: Fri, 6 Nov 2026 15:31:02 +1000
X-Gm-Features: AclHuK-DTWKg6aYOUpY0pREYQ38U7SrWdoYt0n6El0ClXUXgo4yA4tGhZW8hdlI
Message-ID: <CAMwc25rODe5F7MdhWEr80q+eOitKqg-O0LQhEWOMSVWZodfyMg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] gpu: nova-core: add support for GPU timer block.
 (v4)
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QbQPaOx7neCIf3qeutAuo0eB8Q3Sh3WnZC3JP0VG7X8_1793943076
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 6, 2026 at 12:43=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> On Thu Nov 5, 2026 at 12:07 PM JST, Dave Airlie via B4 Relay wrote:
> > From: Dave Airlie <airlied@redhat.com>
> >
> > This is needed to calculate the system timer offset that is passed
> > to GSP init.
> >
> > 2 HALs exist:
> to build with `CLIPPY=3D1`. `make rustfmt` also reformatted a few lines.
>
> <...>
> > diff --git a/drivers/gpu/nova-core/fsp/regs.rs b/drivers/gpu/nova-core/=
fsp/regs.rs
> > new file mode 100644
> > index 000000000000..d4b8482a6854
> > --- /dev/null
> > +++ b/drivers/gpu/nova-core/fsp/regs.rs
> > @@ -0,0 +1,30 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +pub(crate) mod gh100 {
>
> FSP only makes sense for GH100 and more recent, so I guess we can do
> without this sub-module?
>
> > +    use kernel::io::register;
> > +
> > +    use crate::{
> > +        driver::NovaRegisters,
> > +    };
> > +
> > +    // FSP PRI space; the timer is its only consumer so far.
>
> I guess we don't need to mention who the consumer is here; especially
> since the list might increase in the future.
>
> > +    register! {
> > +        base: NovaRegisters;
> > +
> > +        /// FSP ucode version, encoded as `major.minor` in bits 11:8 a=
nd 7:0, written by the FSP
> > +        /// during boot. (`NV_PFSP_FALCON_COMMON_SCRATCH_GROUP_3(1)` i=
n the hardware headers.)
> > +        pub(crate) NV_GFW_FSP_UCODE_VERSION(u32) @ 0x008f0334 {
>
> We are trying to keep registers (at least those defined within
> sub-modules) local to their owning module, so ideally the visibility
> should be `pub(super)`. And instead of accessing the register directly
> in `timer`, a `Fsp::is_bug3957833_affected()` method would expose the
> functionality we need.
>
> > +            11:0 full;
> > +        }
> > +    }
> > +
> > +    impl NV_GFW_FSP_UCODE_VERSION {
> > +        /// Check if the hopper only workaround is required
> > +        pub(crate) fn is_bug3957833_affected(self) -> bool {
>
> So as mentioned above, this method would be moved to a method of `Fsp`
> that `timer` would call, keeping registers local to their module.
>
> We will need to store the hal and `Chipset` into the `Fsp` struct for
> that, but that's standard practice.

I've done nearly everything you requested for v5.

I've just stored Chipset in there, is it worth storing hal? It might
happen later I suppose if needed, but for this I just rederive hal for
the one entrypoint.

> Maybe also explain that this can program some timer-related registers,
> otherwise the name `init` isn't justified for someone who believes that
> this just returns the time without any side-effect.

I used setup, I don't have a good name.

The main thing is I didn't use the NSEC_SHIFT thing, but just write
nsec_hi and lo wrappers that hardcode the values since to me it looks
cleaner than trying to infer that from the register definitions,
especially since I don't see a good way of doing it for nsec_hi. I
remove all falling from these paths and just went with truncation
because that is what actually makes sense.

nsec_lo/hi are now used in the register from_nsec for both tu102 and
gh100 registers.

> I'd ignore Sashiko's suggestion as it looks like it is trying to
> reconcile the code against the comment instead of the other way around.

I just fixed things to truncate and used wrapping_sub, to be honest
being careful here is probably the wrong answer, my local review bot
pointed out some wierdness can occur in 2043 with the current scheme,
so let's just keep it simple, wrapping subtract, and feed the result
to the hardware which is what the other driver does and what nouveau
did.

>
> Once we have moved the timer read loop into its own method, I guess the
> remainder can be nicely folded into `init` directly, and we don't need
> `timer_time` anymore?

I didn't do this, I think resume support might need to program this
also, and it didn't look very clean.

Dave.

