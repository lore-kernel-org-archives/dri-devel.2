Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA663606A329
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 03:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R53+y8W1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 043F910E630;
	Thu,  5 Nov 2026 03:13:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3F9410E630
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 03:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793848399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3doFV6CnjvFRGoub00kzIpE0tXcclmnDoklWSfWMlII=;
 b=R53+y8W1mjPHWXn25dinPcSm7mjlrf02tKi9bFrHI3TUIOztIijh+uwYVMQzju6jBD9tio
 znqsdcJSThhFoMtqZhdv5VIH1krZD7IXneHTedP6/JTSrCkdn3Vb04mfw6HBI0f5Tilaw4
 fkpxtA8DaNkEzC3ukMJUc6+b1h/VpfE=
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com
 [74.125.82.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-vgxJ1_9aMg-DG1sIJfMsSw-1; Wed, 04 Nov 2026 22:13:17 -0500
X-MC-Unique: vgxJ1_9aMg-DG1sIJfMsSw-1
X-Mimecast-MFC-AGG-ID: vgxJ1_9aMg-DG1sIJfMsSw_1793848397
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1383723dfddso2427712c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 19:13:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793848396; x=1794453196;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3doFV6CnjvFRGoub00kzIpE0tXcclmnDoklWSfWMlII=;
 b=l9Jp/3dgCkcs5jltYl1/9a77R2wx2HsnuPIxa2v/r7dQGj3aqrdKLvusutZWWBU5Io
 VyssmLSTKZwDE0T2RhSnxekn87Z9toLAiMeagUVRbh/EjtMu8G1JEBi+dUWhQaO5slGO
 C6V1R0WF2sQhNs7lBeolhLfkkiYKnEJJNWavnSbAh+XMO1h1RWRhgAGVgllhoKGsv52s
 LaeafkQINRsvzYaqaVox2Fy9YLPGXKVkM405KKnloJJzMy3tz19aIHnnEVg1KRQDocTx
 pQZBq1mxiX5Mhdshp3UqI6/P0D/MoTLUSvIJEUI4Q/Q7RDbcUZUVvmd+RTAYVETlKlML
 0vmg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6Jl7KWT487ImUyzhmqlai2HKMDz0Le/Ee/ztji/LMyQZLydoWiLlj234r7rc5zeOCwBpXeU+RI3s=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/YvfcGK44Xk0gC3DPQNwVOuYt8gXd+5FSAkafXkicc0FGcJmOr
 8bwVTAt4I0MjEg4AYESs8ulrHU4vylK6WFJB7++SpxpwPLMJXMmUiYjwmmrpuT5xg4apdNQPrmI
 hh+W8Spfflc3jPohfsYxg8nNM49antu9hSfOV4Jgt9oVyJweCskBNQJwhs32q+rUgujweKh6XZ3
 mKOnZb03s5Ot3LIiNwMThvTCxXicskjSI8zJnd4PEEMPfWUnEUBy5n
X-Gm-Gg: AYBFou3shTlQ+9KVzjxKveMEdbf3Q8YpLXs1R/Wjrrywp6anSN0DLbJCV56ZrpqH8lh
 mfSoo/yZSRa6yE24mjHM36n8YP2RfTNKQ0O7GRPC8u6dQAT1yjEyhRk0Dj7oU+jEfcEXDwv56So
 jkdi1BQoiL/82qeQ0xVtO3Sdtgfx6f64RlE6GajpmqBUX/XCqAg5Ft0LsAI7x4pT5ft+S6em3VS
 hHnDfoWWrbSqHyp
X-Received: by 2002:a05:7022:158a:b0:185:869a:8c64 with SMTP id
 a92af1059eb24-1ac56ca0239mr28569106c88.1.1793848396221; 
 Wed, 04 Nov 2026 19:13:16 -0800 (PST)
X-Received: by 2002:a05:7022:158a:b0:185:869a:8c64 with SMTP id
 a92af1059eb24-1ac56ca0239mr28569052c88.1.1793848395411; Wed, 04 Nov 2026
 19:13:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103-nova-timer-v3-0-0cf9bbae8fd9@redhat.com>
 <20261103-nova-timer-v3-2-0cf9bbae8fd9@redhat.com>
 <DMLZABRA2JIK.1T11DDWNFKGJM@kernel.org>
In-Reply-To: <DMLZABRA2JIK.1T11DDWNFKGJM@kernel.org>
From: David Airlie <airlied@redhat.com>
Date: Thu, 5 Nov 2026 13:13:03 +1000
X-Gm-Features: AclHuK-CpByyje97VulgjdYHSCBFSmYY7L1ssu-Sc06OfQsPUh1PUO5AMJaUFbE
Message-ID: <CAMwc25q9_Gdtjem39SG66_cUKJnndmHeU6RRpHhMOU6DCUqqMg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] gpu: nova-core: add support for GPU timer block.
 (v3)
To: Danilo Krummrich <dakr@kernel.org>
Cc: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alexandre Courbot <acourbot@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DJE7QA3RWWWWOkO5X2_MFz_o9aDMdTrGVuTNvt5DXOI_1793848397
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

>
> I feel like this should actually be TimerState, as it is not really a timer
> (instance) representation in the sense of carrying the HAL and providing methods
> to interact with the hardware (which we do not intend).
>
> I'd suggest making Timer a unit struct and giving it an init() function, i.e.
> something like this:

Thanks, looks cleaner, sent out in v4.

> > +    // this value will be passed to GspInitRequest SYS_TIMER_OFFSET_NS
>
> NIT: This should describe what the returned value represents, although in this
> specific case it may also still make sense to give a hint how it is used.

In theory the value doesn't represent anything, since it's hal
dependant, at this
point it should be an opaque value we give to GSP in SYS_TIMER_OFFSET_NS field.

> Please use intra-doc links and markdown where it makes sense.
>
> > +    #[expect(dead_code)]
> > +    pub(crate) fn sys_timer_offset_ns(&self) -> i64 {
> > +        self.sys_timer_offset_ns
> > +    }
> > +}
> > diff --git a/drivers/gpu/nova-core/timer/hal.rs b/drivers/gpu/nova-core/timer/hal.rs
> > new file mode 100644
> > index 000000000000..fd702867b470
> > --- /dev/null
> > +++ b/drivers/gpu/nova-core/timer/hal.rs
> > @@ -0,0 +1,27 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +use kernel::prelude::*;
> > +
> > +use crate::{
> > +    driver::Bar0,
> > +    gpu::{
> > +        Architecture,
> > +        Chipset, //
> > +    },
> > +};
> > +
> > +mod gh100;
> > +mod tu102;
> > +
> > +pub(super) trait TimerHal {
> > +    /// return system timer offset ns
>
> NIT:
>
>         /// Initialize the GPU's system timer.
>         ///
>         /// Returns the system timer offset in nanoseconds.

Just realised I missed this one in v4.

> > +                < FSP_BUG_3957833_FIX_VERSION
>
> I'd move this into regs.rs and make it a method of NV_GFW_FSP_UCODE_VERSION,
> e.g.
>
>         impl NV_GFW_FSP_UCODE_VERSION {
>             pub(crate) fn is_bug_3957833_affected(self) -> bool {
>                 const FSP_BUG_3957833_FIX_VERSION: u32 = 0x44c;
>
>                 self.full().get() < FSP_BUG_3957833_FIX_VERSION
>             }
>         }
>
> so you can just call
>
>         bar.read(regs::gh100::NV_GFW_FSP_UCODE_VERSION).is_bug_3957833_affected()
>
> This also keeps FSP_BUG_3957833_FIX_VERSION local to regs.rs and gets us rid of
> this HAL function.

I don't think we can get rid of the hal function, since GH100 vs GB100
need different behaviour, which is
just setting war flag.

>
> Can't we just use unsigned for the argument and return type? None of those are
> ever expected to be negative, no?

No, I think I got lost in what rust needed to avoid crashing the
machine, so I just stayed on the side of least likely to overflow.

I've reworked it in v4 back to what I had in the first place with checked_sub.

>
> I think we accumulated a bunch of those comments in nova-core, I think it would
> be nice to consider whether we want a prefix for this, similar to TIMEOUT or
> CALC. Maybe OVERFLOW? But this can be a follow-up of course.
>
> On the other hand, this is a fallible method already, so I'd just go with
> checked_sub().
>
>
> This looks similar to NV_TLB_FLUSH_PDB_LO::from_pdb_addr(). I think we should do
> this in the register impl:
>
>         impl NV_PGC6_SCI_SYS_TIMER_OFFSET_1 {
>             /// Creates a register value from bits 60:32 of the offset.
>             pub(crate) fn from_offset_ns(offset_ns: u64) -> Self {
>                 let nsec = Bounded::<u32, 29>::from_expr(
>                     ((offset_ns >> 32) & 0x1fff_ffff) as u32,
>                 );
>
>                 Self::zeroed().with_nsec(nsec)
>             }
>         }

Done in v4.

> > +    register! {
> > +        base: NovaRegisters;
> > +
> > +        /// FSP ucode version, encoded as `major.minor` in bits 11:8 and 7:0, written by the FSP
> > +        /// during boot. (`NV_PFSP_FALCON_COMMON_SCRATCH_GROUP_3(1)` in the hardware headers.)
> > +        pub(crate) NV_GFW_FSP_UCODE_VERSION(u32) @ 0x008f0334 {
> > +            11:0 full;
> > +        }
> > +    }
> > +}
>
> Hm...I feel like it should go into fsp/regs.rs regardless.

Moved in v4.

Dave.

>

