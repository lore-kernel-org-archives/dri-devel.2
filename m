Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF9ECD98F0
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 20:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D54FA10F11B;
	Wed, 17 Jun 2026 20:16:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XLkAl1Wl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11E3D10F102
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 20:16:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D641340727;
 Wed, 17 Jun 2026 20:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898831F000E9;
 Wed, 17 Jun 2026 20:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781727359;
 bh=1jAo0d/M4c23EkKIYW8dVUOJ++RE/I9vQrdH8jXKup0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XLkAl1Wlq/x4gGvsbcKlMbDb4IEAjLFX03nva60qe5kUtKXMY2WPYbHjMIH4CYVec
 Shgd2IM9m5FmvfZjv70hpJmzZpz96XNjbEYeNDo4/iurvgQ/EisM1zi1Sh3QyhqFgQ
 GPbyPXuknQGPLajUkZysxXTjeKSrg6RVjIOL/zKqcp69j4VPurloEpGhuX6+nGFckT
 QI5MgjVERTmLzI9kqxgZWjE/fGxOxg+REITVouaAXMFKd43ZQr5/St5awaVnHvaujj
 cU+LJQbQ2bsQkfwBKv7LPbsFkX8KSoBRfHiR11emYKrP6+GE3o37RAujZKAprso4es
 h2mI7th4U/8yw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/7] drm/vino: add the AES-CTR/AES-CMAC
 control-plane seal and arm
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260617151249.2937-4-mike@fireburn.co.uk>
References: <20260617151249.2937-1-mike@fireburn.co.uk>
 <20260617151249.2937-4-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 20:15:59 +0000
Message-Id: <20260617201559.898831F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Memory allocation using GFP_KERNEL in functions designed for atomi=
c context.
- [High] Global state used to track per-device control plane engagement.
- [High] Integer overflow in `cursor_image` bypasses buffer size validation.
- [High] DMA mapping violation by passing stack and `.rodata` buffers to US=
B transfers.
- [High] Premature loop termination in `lockstep_reply` drops valid packets=
 and breaks CP handshake.
--

commit ed0df79bff2d18c4e02a6704d484f6b62252ddf5
Author: Mike Lothian <mike@fireburn.co.uk>

drm/vino: add the AES-CTR/AES-CMAC control-plane seal and arm

This commit introduces the AES-CTR/AES-CMAC control-plane for the vino DRM=
=20
driver. It adds the message builders, cryptographic sealing logic, and a=20
post-SKE setup sequence to engage the dock's control plane.

diff --git a/drivers/gpu/drm/vino/cp.rs b/drivers/gpu/drm/vino/cp.rs
index 0000000000000..2668931d8500a
--- /dev/null
+++ b/drivers/gpu/drm/vino/cp.rs
[ ... ]
> +pub(super) fn cursor_move(counter: u16, head: u8, x: u16, y: u16) -> Res=
ult<KVec<u8>> {
> +    let mut b =3D KVec::with_capacity(28, GFP_KERNEL)?;

[Severity: High]
Is it safe to allocate with GFP_KERNEL here?=20

Functions like cursor_move(), cursor_image(), seal_interactive(), and=20
set_mode() are noted to be used by runtime KMS senders. In the DRM subsyste=
m,=20
cursor updates and plane atomic updates run in atomic context during=20
non-blocking commits, where sleeping is not allowed. Since GFP_KERNEL enabl=
es=20
direct reclaim which can sleep, using it in these paths could trigger kerne=
l=20
warnings or deadlocks.

> +    header(&mut b, 0x1a, 0x43, counter)?;
> +    pad_to(&mut b, 22)?;
> +    b.push(head, GFP_KERNEL)?; // off22 head/monitor id
> +    b.push(1, GFP_KERNEL)?; // off23 flag
> +    b.extend_from_slice(&x.to_le_bytes(), GFP_KERNEL)?; // off24
> +    b.extend_from_slice(&y.to_le_bytes(), GFP_KERNEL)?; // off26
> +    Ok(b)
> +}
> +
> +/// cursor image (sec 8.6.1): id=3D0x1c sub=3D0x41. Mirrors cursor_creat=
e's header (the
> +/// 00 02 00 marker + w,h at off20) and appends the w*h BGRA bitmap. bgr=
a must be
> +/// w*h*4 bytes -- DRM hands the driver a 64x64 ARGB8888 cursor buffer a=
nd the caller swaps
> +/// it
> +/// to BGRA. The image sub-layout past the create-style header is captur=
e-unconfirmed (only the
> +/// id and the shared header are decoded); re-check against a capture on=
ce CP engages.
> +pub(super) fn cursor_image(counter: u16, w: u16, h: u16, bgra: &[u8]) ->=
 Result<KVec<u8>> {
> +    if bgra.len() !=3D w as usize * h as usize * 4 {

[Severity: High]
Can this arithmetic wrap around on 32-bit architectures?=20

The expected buffer size is validated using w as usize * h as usize * 4, wh=
ere
w and h are u16 values. Their maximum product can be ~4.29 billion, which
when multiplied by 4 overflows a 32-bit usize. This could allow userspace to
specify dimensions like 65535x65535 with a small buffer that matches the
wrapped size, bypassing the validation and sending truncated control plane
messages.

> +        return Err(EINVAL);
> +    }
[ ... ]
> +pub(super) fn seal_interactive(
> +    ks: &[u8; 16],
> +    riv: &[u8; 8],
> +    id: u16,
> +    wire_seq: u32,
> +    content: &[u8],
> +) -> Result<KVec<u8>> {
> +    let body_len =3D content.len() + 16; // AES-CTR ciphertext + 16-byte=
 Dl3Cmac
> +    let size =3D ((16 + body_len) - 4) as u16;
> +    let aux =3D aux_for_id(id, body_len);
> +    let mut hdr =3D [0u8; 16];
> +    hdr[2..4].copy_from_slice(&size.to_le_bytes());
> +    hdr[4..8].copy_from_slice(&4u32.to_le_bytes()); // type=3D4
> +    hdr[8..10].copy_from_slice(&0x24u16.to_le_bytes()); // sub=3D0x24 (i=
nteractive CP)
> +    hdr[10..12].copy_from_slice(&aux.to_le_bytes());
> +    hdr[12..16].copy_from_slice(&wire_seq.to_le_bytes());
> +    seal_livemac(ks, riv, &hdr, content)

[Severity: High]
Does this wrapper propagate a sleeping allocation into atomic context?

seal_interactive() calls seal_livemac(), which allocates KVec buffers using
GFP_KERNEL. As this function is also intended for runtime KMS senders, call=
ing
it from an atomic commit context could lead to deadlocks.

> +}
diff --git a/drivers/gpu/drm/vino/vino.rs b/drivers/gpu/drm/vino/vino.rs
index db4c38b6dc92f..ef44a625cb70b 100644
--- a/drivers/gpu/drm/vino/vino.rs
+++ b/drivers/gpu/drm/vino/vino.rs
[ ... ]
> +/// Set once the dock has actually engaged the CP cipher (wsub=3D0x45 ac=
ks > 0). EP08 video is
> +/// gated on it: pushing frames at a dock whose CP channel is dead makes=
 it fault and USB-reset.
> +/// NOTE: with the current CP-engagement wall (see the file header) this=
 is never set on real
> +/// hardware -- the dock runs the whole plaintext handshake but never en=
gages the encrypted CP.
> +static CP_ENGAGED: core::sync::atomic::AtomicBool =3D core::sync::atomic=
::AtomicBool::new(false);

[Severity: High]
Is it appropriate to use a global static variable for per-device state?=20

The driver tracks the dock's cipher engagement state using the global
CP_ENGAGED AtomicBool. Since the kernel needs to support multiple concurrent
device instances, sharing this state across devices could create race
conditions where one device's successful engagement globally ungates video
for all docks, or a failure gates video for an already engaged dock.

> +
>  mod proto;
>  mod crypto;
[ ... ]
> +                        let mut edid_out: Option<KVec<u8>> =3D None;
> +                        match VinoDriver::send_cp_setup(dev, &session, &=
mut edid_out) {
> +                            Ok((n, acks, _wseq_end, _ctr_end)) =3D> {
> +                                dev_info!(cdev,
> +                                    "vino: CP setup sent -- {n} messages=
, {acks} dock CP acks (wsub=3D0x45)\n");
> +                                // CP engagement gates EP08 video (added=
 in a later patch): until
> +                                // the dock acks, pushing pixels at it w=
edges the hub.
> +                                CP_ENGAGED.store(acks > 0, core::sync::a=
tomic::Ordering::SeqCst);

[Severity: High]
Does modifying this global static variable here interfere with other
concurrent devices?

Updating the global CP_ENGAGED state based on a specific device instance's
setup outcome could crash other unengaged hubs if video gets incorrectly
ungated for them.

> +                            }
> +                            Err(e) =3D> dev_info!(cdev, "vino: CP setup =
incomplete ({e:?}) -- WIP\n"),
> +                        }
>                      }
[ ... ]
> +        // Plaintext type=3D2 sub=3D0x24+0x45 stream-open arm marker -- =
the mandatory gate
> +        // before the first encrypted frame.
> +        const STREAM_OPEN: [u8; 64] =3D [
> +            0x00, 0x00, 0x1c, 0x00, 0x02, 0x00, 0x00, 0x00, //
> +            0x24, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //
> +            0x04, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, //
> +            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //
> +            0x00, 0x00, 0x1c, 0x00, 0x02, 0x00, 0x00, 0x00, //
> +            0x45, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //
> +            0x05, 0x00, 0x0e, 0x00, 0x00, 0x00, 0x00, 0x00, //
> +            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //
> +        ];
[ ... ]
> +        // Submit the arm marker. Async path: queue it and DO NOT flush =
-- leave it in flight so
> +        // msg0 can be submitted right behind it (the pipelined arm->msg=
0 burst DLM does). Sync
> +        // path: the original blocking send.
> +        let arm_res =3D match out_q.as_mut() {
> +            Some(q) =3D> q.send(&STREAM_OPEN, timeout()),
> +            None =3D> dev.bulk_send(EP_CTRL_OUT, &STREAM_OPEN, timeout()=
).map(|_| ()),
> +        };

[Severity: High]
Does this violate the DMA mapping rules by passing .rodata to a USB transfe=
r?

The STREAM_OPEN buffer is a const array located in .rodata. The Linux DMA A=
PI
forbids using .rodata for DMA transfers because these memory regions cannot
be safely mapped when the IOMMU is enabled.

> +        if let Err(e) =3D arm_res {
> +            pr_err!("vino: CP stream-open marker FAILED ({e:?})\n");
> +            return Err(e);
> +        }
[ ... ]
> +        // DLM sends the 0x24 wValue=3D0 render/commit vendor request ri=
ght after msg0.
> +        match dev.control_send(0x24, 0x40 /* VENDOR_OUT */, 0, 0, &[], t=
imeout()) {
> +            Ok(()) =3D> pr_info!("vino: post-msg0 0x24(wValue=3D0) OK\n"=
),
> +            Err(e) =3D> pr_info!("vino: post-msg0 0x24(wValue=3D0) non-f=
atal ({e:?})\n"),
> +        }
> +        // DLM then re-reads the 0x22 vendor state (0xc1, wValue=3D1, wI=
ndex=3D0, 28 B) -- its SECOND
> +        // 0x22 of the session, immediately after the post-msg0 0x24. vi=
no issued the first 0x22
> +        // pre-arm but stopped here, leaving "DLM-ONLY 0x22" in the pair=
ed diff. Issue it
> +        // unconditionally so the wire matches DLM regardless of whether=
 the dock acks; it is a
> +        // harmless vendor IN read. (0xc1 =3D IN|vendor|INTERFACE recipi=
ent, matching the first 0x22.)
> +        let mut state2 =3D [0u8; 28];
> +        match dev.control_recv(0x22, 0xc1, 1, 0, &mut state2, timeout())=
 {

[Severity: High]
Does this violate the DMA mapping rules by passing a stack array to a USB
transfer?

The state2 buffer is a local array located on the stack. The Linux DMA API
forbids using stack memory for DMA transfers because these regions cannot
be safely mapped when CONFIG_VMAP_STACK or the IOMMU are enabled.

> +            Ok(()) =3D> pr_info!("vino: post-msg0 0x22(wValue=3D1) OK =
=3D {:02x?}\n", state2),
> +            Err(e) =3D> pr_info!("vino: post-msg0 0x22(wValue=3D1) non-f=
atal ({e:?})\n"),
> +        }
[ ... ]
> +    fn lockstep_reply(
> +        dev: &usb::Device,
> +        mut q: Option<&mut usb::BulkInQueue>,
> +        buf: &mut [u8],
> +        session: &Session,
> +        ictr: u16,
> +        edid_out: &mut Option<KVec<u8>>,
> +    ) -> (usize, usize, bool) {
> +        const MAX_READS: usize =3D 8;
> +        let in_riv =3D cp::in_riv(&session.riv);
> +        let mut reads =3D 0usize;
> +        let mut acks =3D 0usize;
> +        let mut matched =3D false;
> +        for _ in 0..MAX_READS {
> +            match Self::read_ep84(dev, q.as_deref_mut(), buf, Delta::fro=
m_millis(30)) {
> +                Ok(len) if len > 16 =3D> {
> +                    reads +=3D 1;
> +                    // sec 5 diagnostic: log every frame the dock return=
s in the lockstep
> +                    // window -- including the non-0x45 frames we otherw=
ise skip -- so the
> +                    // divergence point is paired with the dock's actual=
 reply on the wire.
> +                    Self::log_ep84(session, &buf[..len]);
> +                    if u16::from_le_bytes([buf[8], buf[9]]) !=3D 0x45 {
> +                        continue;
> +                    }
> +                    acks +=3D 1;
> +                    let seq =3D u32::from_le_bytes([buf[12], buf[13], bu=
f[14], buf[15]]);
> +                    // Decrypt just the first block to read the inner co=
unter (off 4).
> +                    let head =3D &buf[16..len.min(32)];
> +                    if let Ok(inner) =3D cp::open_in(&session.ks, &in_ri=
v, seq, head) {
> +                        if inner.len() >=3D 6
> +                            && u16::from_le_bytes([inner[4], inner[5]]) =
=3D=3D ictr
> +                        {
> +                            matched =3D true;
> +                        }
> +                    }
> +                    // Opportunistically capture the EDID (id=3D0x94 rep=
ly, off 22).
> +                    if edid_out.is_none() {
> +                        if let Ok(Some(e)) =3D
> +                            cp::parse_edid_from_reply(&session.ks, &sess=
ion.riv, &buf[..len])
> +                        {
> +                            pr_info!("vino: EDID read from dock ({} byte=
s)\n", e.len());
> +                            *edid_out =3D Some(e);
> +                        }
> +                    }
> +                    if matched {
> +                        break;
> +                    }
> +                }
> +                _ =3D> break,

[Severity: High]
Does this premature loop termination drop valid packets?

If the dock emits a legitimate short packet (such as a ZLP or a small proto=
col
ACK where len <=3D 16), the loop breaks immediately instead of continuing to
read. This drops the polling window and guarantees the driver will miss the
subsequent sub=3D0x45 reply, incorrectly treating the dock's CP initializat=
ion
as failed.

> +            }
> +        }
> +        (reads, acks, matched)
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617151249.2937=
-1-mike@fireburn.co.uk?part=3D3
