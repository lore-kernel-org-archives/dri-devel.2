Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33F9C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 823C610E4B6;
	Tue, 21 Jul 2026 07:18:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V144pLNd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9568A10E3DF
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 07:18:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7E02140AA5;
 Tue, 21 Jul 2026 07:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2EA1F000E9;
 Tue, 21 Jul 2026 07:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784618282;
 bh=fbKa74v/5Eri/Nvr/E/z/29EU0KF0VFOA34mrHZf9/s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V144pLNdQs9y+GSiziyfrcMsqhgy6E4W49tx5GjriR7sDGqnza+9uIWSeR3Y7VJF6
 D9SNDAfffQAumKB9vbh7vQj7YW+38S3lG1WGkn36UJl/23v2R4+axARRtXgVo3JuvZ
 yEzQ9He26ApHh5YOHFOUalJea3fxJb6aBtzKN9lQniwRswyWcTXdjDMBoMAvRIgI5r
 7nSwSDpRGDAPXfvoa3We+MZoQWrhE/dJHUF8nhuqgowJpx5Jnbfl8WyCGm7mvgxL8u
 t1vx+P1ElHwoki8kpwr1NhSa3tsw/gUHhPfKCb+BrHHYlPrkogphICfSt8U4C+ztAZ
 tk2y2bc4bDxfQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH net-next 13/13] drm/amdkfd: add IPsec full-packet
 offload
To: "Taehee Yoo" <ap420073@gmail.com>
Cc: bpf@vger.kernel.org, media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260719175857.4071636-14-ap420073@gmail.com>
References: <20260719175857.4071636-1-ap420073@gmail.com>
 <20260719175857.4071636-14-ap420073@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 07:18:01 +0000
Message-Id: <20260721071802.2B2EA1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 23 potential issue=
(s) to consider:
- [Critical] The anti-replay sliding window is maintained per RX queue inst=
ead of globally per SA, allowing attackers to bypass anti-replay protection.
- [Critical] An undersized packet causes an integer underflow in the GPU sh=
ader's ciphertext length calculation, leading to an out-of-bounds VRAM read=
 that crashes the GPU (Remote Denial of Service).
- [High] The GPU shader does not include the high-order 32 bits of the Exte=
nded Sequence Number (`seq_hi`) in the AAD computation, causing all ESN pac=
kets to fail ICV verification.
- [High] The GPU shader is hardcoded to process exactly 254 ciphertext bloc=
ks, breaking Jumbo frame support and causing out-of-bounds VRAM reads on la=
rge packets.
- [High] Missing `dma_wmb()` in `knod_ipsec_write_sa_entry` causes a TOCTOU=
 race condition between the CPU and the GPU shader, leading to GPU page fau=
lts.
- [High] If `xa_insert` fails during SA addition, the active GPU SA entry i=
s not rolled back, leading to a GPU use-after-free.
- [High] Freeing SA VRAM allocations in `xdo_state_free` after an RCU grace=
 period does not protect asynchronous GPU executions, causing a VRAM use-af=
ter-free.
- [High] The GPU verdict only returns the bare slot index without an SA ver=
sion or SPI check. If a slot is freed and rapidly reallocated, an old decry=
pted packet will be incorrectly attributed to the new SA.
- [High] Premature `KNOD_IPSEC_PASS` assignment for bypassed/missed packets=
 causes data corruption via early netmem recycling.
- [High] Unlocked access to `slot->x` in the dispatcher and NAPI hook races=
 with `xfrm_state` teardown, leading to UAF.
- [High] Use-After-Free of `ipsec_priv` during device teardown due to missi=
ng RCU read lock in XFRM callbacks.
- [High] The in-kernel KAT selftest backs up, zeroes, and restores the live=
 GPU SA table without locks, allowing concurrent traffic or configurations =
to permanently corrupt the table.
- [High] Unsafe allocation from `page_pool` in preemptible kthread context.
- [High] The SDMA engine writes up to 40 bytes past the end of the `PAGE_SI=
ZE` delivery pool buffer for valid jumbo packets due to a flawed length che=
ck.
- [High] The CPU passes unmapped NIC DMA addresses from the page pool to th=
e AMDGPU SDMA engine, which will cause a GPU VM or IOMMU fault.
- [High] Timeouts in `knod_ipsec_fence_wait` and `knod_ipsec_dispatch_wait`=
 fail open, leading to processing of incomplete GPU/SDMA operations.
- [Medium] Use of `this_cpu_inc()` and `this_cpu_ptr()` in preemptible cont=
exts causes smp_processor_id() warnings and stat corruption.
- [Medium] The RX shader checks the IP version but fails to verify that the=
 protocol is ESP (IPPROTO_ESP / 50), allowing attackers to drop valid non-E=
SP traffic.
- [Medium] `knod_ipsec_xdo_state_update_stats` overwrites `x->curlft` inste=
ad of adding the hardware delta, destroying software-accumulated statistics.
- [Medium] Extremely large array allocation on the kernel stack in `knod_ip=
sec_kat_h_one`.
- [Medium] The self-test inadvertently unparks a dispatcher thread that may=
 have been intentionally stopped by the control plane.
- [Medium] Missing RCU read lock around `xa_load` in `knod_ipsec_xdo_state_=
update_stats`.
- [Medium] Racy zeroing of remote per-CPU statistics.
--

--- Patch [13]: [RFC PATCH net-next 13/13] drm/amdkfd: add IPsec full-packe=
t offload ---
commit a531874de77887797921e4f4aa4a3418e089408c
Author: Taehee Yoo <ap420073@gmail.com>
Subject: drm/amdkfd: add IPsec full-packet offload

This patch adds a KNOD feature for GPU-offloaded IPsec ESP, allowing
XFRM_DEV_OFFLOAD_PACKET SAs to decrypt AES-GCM payloads directly on the GPU.

> diff --git a/drivers/gpu/drm/amd/amdkfd/knod/ipsec_fused_gfx10.h b/driver=
s/gpu/drm/amd/amdkfd/knod/ipsec_fused_gfx10.h
> --- a/drivers/gpu/drm/amd/amdkfd/knod/ipsec_fused_gfx10.h
> +++ b/drivers/gpu/drm/amd/amdkfd/knod/ipsec_fused_gfx10.h
> @@ -216,8 +216,6 @@ static inline int kfd_ipsec_gen_fused_shader_gfx10(vo=
id *vbuf)
>  	_E(emit_gfx10_s_and_b32_p, I10(buf, n), P_S(28), P_I(0xF), P_S(28));
> =20
>  	/* Check IPv4 (version=3D=3D4) */
>  	_E(emit_gfx10_s_cmp_eq_u32, I10(buf, n), P_S(28), P_I(4));

[Severity: Medium]
Does the shader only check the IP version without verifying that the
protocol is ESP (IPPROTO_ESP)? Could valid non-ESP traffic that
accidentally matches an active SPI be dropped?

>  	br_ipv4 =3D _BR(emit_gfx10_s_cbranch_scc1, I10(buf, n), 0);
> =20

[ ... ]

> @@ -493,8 +491,6 @@ static inline int kfd_ipsec_gen_fused_shader_gfx10(vo=
id *vbuf)
>  	_E(emit_gfx10_v_readfirstlane_b32, I10(buf, n), SR_CTEXT_LEN,
>  	   VR_SAVE_PKTLEN);
>  	_E(emit_gfx10_s_sub_u32_p, I10(buf, n), P_S(SR_CTEXT_LEN),
>  	   P_S(SR_CTEXT_LEN), P_S(28));

[Severity: Critical]
If bd->len is smaller than the combined headers and ICV overhead, could this
calculation underflow, producing a massive block count that leads to
out-of-bounds VRAM reads and a GPU crash?

>  	/* s[SR_NBLOCKS_GCM] =3D (ctext_len + 15) >> 4 */
>  	_E(emit_gfx10_s_add_u32, I10(buf, n), P_S(SR_NBLOCKS_GCM), P_I(15),

[ ... ]

> @@ -626,8 +622,6 @@ static inline int kfd_ipsec_gen_fused_shader_gfx10(vo=
id *vbuf)
>  	 * here then free for reuse by the ctext section.
>  	 */
>  	_E(emit_gfx10_v_sub_nc_u32, I10(buf, n), P_V(VR_TMP),
>  	   P_S(SR_TOTAL_GHASH_BLK), P_V(VR_TID));

[Severity: High]
With the workgroup size hardcoded to 256 threads, won't packets exceeding
254 ciphertext blocks (like MTU 9000 jumbo frames) fail decryption and
cause out-of-bounds VRAM reads when accessing the H-power table?

>  	_E(emit_gfx10_v_add_nc_u32, I10(buf, n), P_V(VR_TMP),
>  	   P_L(0xFFFFFFFF), P_V(VR_TMP));

[ ... ]

> @@ -649,8 +643,6 @@ static inline int kfd_ipsec_gen_fused_shader_gfx10(vo=
id *vbuf)
>  	 */
>  	_E(emit_gfx10_v_mov_b32_e32, I10(buf, n), P_V(VR_DATA0),
>  	   P_V(VR_SAVE_SPI));
>  	_E(emit_gfx10_v_mov_b32_e32, I10(buf, n), P_V(VR_DATA1),
>  	   P_V(VR_SAVE_SEQ));

[Severity: High]
If the control plane accepts SAs with ESN enabled, but the shader only uses
the 32-bit seq_lo when assembling the AAD, won't all valid ESN packets fail
the ICV verification?

>  	/* DATA2, DATA3 already 0 */
> =20

> diff --git a/drivers/gpu/drm/amd/amdkfd/knod/knod_ipsec.h b/drivers/gpu/d=
rm/amd/amdkfd/knod/knod_ipsec.h
> --- a/drivers/gpu/drm/amd/amdkfd/knod/knod_ipsec.h
> +++ b/drivers/gpu/drm/amd/amdkfd/knod/knod_ipsec.h
> @@ -266,4 +266,3 @@ struct knod_ipsec_sa_slot {
>  	 * queue - do not touch from control plane while SA is active.
>  	 */
>  	struct knod_ipsec_sa_window win[KNOD_SPSC_MAX];

[Severity: Critical]
Does maintaining the anti-replay sliding window per RX queue rather than
globally per SA allow an attacker to bypass replay protection by altering
outer headers to change the RSS hash?

>  };
> =20

> diff --git a/drivers/gpu/drm/amd/amdkfd/knod/knod_ipsec.c b/drivers/gpu/d=
rm/amd/amdkfd/knod/knod_ipsec.c
> --- a/drivers/gpu/drm/amd/amdkfd/knod/knod_ipsec.c
> +++ b/drivers/gpu/drm/amd/amdkfd/knod/knod_ipsec.c
> @@ -329,4 +329,3 @@ static void knod_ipsec_write_sa_entry(struct knod_ips=
ec_priv *priv,
>  	e =3D (struct knod_ipsec_sa_entry *)priv->sa_table->kaddr;
>  	e +=3D slot_idx;
>  	memset(e, 0, sizeof(*e));

[Severity: High]
Could clearing the SA entry here without a dma_wmb() allow the GPU shader
to match a valid spi but read a zeroed key_gpu_addr or htable_gpu_addr,
causing a fatal GPU page fault?

> =20
>  	if (!slot || !x) {

[ ... ]

> @@ -424,4 +423,3 @@ static int knod_ipsec_xdo_state_add(struct knod_dev *=
knodev,
> =20
>  	if (x->props.flags & XFRM_STATE_ESN)
>  		flags |=3D 1u << 0;

[Severity: High]
Are ESN packets expected to be supported by the shader? If the control
plane accepts SAs with ESN enabled, but the shader lacks full seq_hi
support for the AAD, won't all valid ESN packets drop?

> =20
>  	/* Store SPI in host byte order (little-endian on this platform).

[ ... ]

> @@ -493,4 +491,3 @@ static int knod_ipsec_xdo_state_add(struct knod_dev *=
knodev,
>  	err =3D xa_insert(&priv->spi_to_slot, spi, slot, GFP_KERNEL);
>  	if (err)
>  		goto err_replay;

[Severity: High]
If xa_insert() fails here, the error path frees the VRAM allocations but
leaves the SA entry active in the GPU sa_table. Could a concurrent GPU
dispatch dereference these freed VRAM allocations?

> =20
>  	x->xso.offload_handle =3D (unsigned long)slot;
> =20
>  	mutex_unlock(&priv->slot_lock);
> =20
>  	this_cpu_inc(priv->stats->sa_add);

[Severity: Medium]
Can using this_cpu_inc() in process contexts trigger smp_processor_id()
warnings and corrupt statistics upon migration?

> =20
>  	e_dbg =3D (struct knod_ipsec_sa_entry *)priv->sa_table->kaddr + slot_id=
x;

[ ... ]

> @@ -524,4 +521,3 @@ static void knod_ipsec_xdo_state_delete(struct knod_d=
ev *knodev,
>  	spi =3D be32_to_cpu(x->id.spi);
> =20
>  	mutex_lock(&priv->slot_lock);

[Severity: High]
Since XFRM callbacks like knod_ipsec_xdo_state_delete() can be invoked from
process context without rcu_read_lock(), could knod_ipsec_nod_exit() free
priv concurrently, causing a Use-After-Free?

>  	slot =3D knod_ipsec_lookup_slot_by_spi(priv, spi);
>  	if (!slot) {

[ ... ]

> @@ -561,4 +557,3 @@ static void knod_ipsec_xdo_state_free(struct knod_dev=
 *knodev,
>  		knod_free_mem(priv->knod, slot->htable_mem);
>  	if (slot->key_mem)
>  		knod_free_mem(priv->knod, slot->key_mem);

[Severity: High]
Because the GPU dispatcher doesn't participate in the CPU RCU grace period,
is it possible for an in-flight GPU dispatch to access key_mem or
htable_mem while it is being freed here?

> =20
>  	memset(slot, 0, sizeof(*slot));

[ ... ]

> @@ -597,4 +592,3 @@ static void knod_ipsec_xdo_state_update_stats(struct =
knod_dev *knodev,
>  	spi =3D be32_to_cpu(x->id.spi);
>  	slot =3D xa_load(&priv->spi_to_slot, spi);

[Severity: Medium]
Since this can be called from process context without holding the RCU read
lock, is it safe to call xa_load() here?

>  	if (!slot || !slot->active)
>  		return;
> =20
>  	/* Read GPU-side per-SA counters (atomically updated by shader). */
>  	gs =3D (struct knod_ipsec_sa_gpu_stats *)
>  		((u8 *)priv->sa_table->kaddr + KNOD_IPSEC_STATS_REGION_OFF +
>  		 slot->slot_idx * KNOD_IPSEC_SA_STATS_SIZE);
> =20
>  	x->curlft.packets =3D le64_to_cpu(READ_ONCE(gs->rx_packets));
>  	x->curlft.bytes   =3D le64_to_cpu(READ_ONCE(gs->rx_bytes));

[Severity: Medium]
Does assigning the hardware counter directly to x->curlft.packets overwrite
any software-accumulated statistics (e.g., from bypassed packets)? Should
this add the hardware delta instead?

>  }
> =20

[ ... ]

> @@ -885,4 +878,3 @@ static void knod_ipsec_nod_exit(struct knod_dev *knod=
ev)
>  	knodev->post_copy =3D NULL;
>  	WRITE_ONCE(ipsec_priv, NULL);
>  	synchronize_net();

[Severity: High]
Is it safe to assume all readers are finished here? As asked earlier, if
XFRM callbacks run without rcu_read_lock(), wouldn't this synchronize_net()
fail to wait for them, resulting in a Use-After-Free of priv below?

> =20
>  	knod_ipsec_disp_destroy_all(priv);

[ ... ]

> @@ -1287,4 +1279,3 @@ static void knod_ipsec_fill_dispatch(struct knod *k=
nod,
>  {
>  	p->workgroup_size_x =3D 256;
>  	p->grid_size_x =3D 256;

[Severity: High]
With the workgroup size hardcoded to 256 threads, won't packets exceeding
254 ciphertext blocks (like MTU 9000 jumbo frames) fail decryption?

>  	p->grid_size_y =3D max(work->nr_packets, 1);
>  	p->private_segment_size =3D 0;

[ ... ]

> @@ -1406,4 +1397,3 @@ static void knod_ipsec_fence_wait(struct knod_ipsec=
_work *w)
>  	while (!knod_ipsec_fence_passed(w)) {
>  		if (--timeout <=3D 0)
>  			break;

[Severity: High]
If the bounded spin loops in knod_ipsec_fence_wait() and
knod_ipsec_dispatch_wait() time out, does the dispatcher unconditionally
proceed and process incomplete GPU/SDMA operations?

>  		cpu_relax();
>  	}

[ ... ]

> @@ -1513,4 +1503,3 @@ static void knod_ipsec_finish_rx_deliver(struct kno=
d_ipsec_dispatcher *disp,
>  			n_sdma++;
> =20
>  			bd->act =3D KNOD_IPSEC_PASS;

[Severity: High]
For bypassed or missed packets, does assigning KNOD_IPSEC_PASS immediately
after submitting the asynchronous SDMA copy allow the NIC NAPI to recycle
and overwrite the source buffer before the copy completes?

>  			continue;
>  		}

[ ... ]

> @@ -1535,4 +1524,3 @@ static void knod_ipsec_finish_rx_deliver(struct kno=
d_ipsec_dispatcher *disp,
>  		inner_len =3D bd->len;
>  		if (inner_len =3D=3D 0 || inner_len > PAGE_SIZE) {

[Severity: High]
Since copies[0].dst is advanced by l3_hdr_len below, could an inner_len
close to PAGE_SIZE cause the SDMA engine to write up to 40 bytes past the
end of the PAGE_SIZE delivery pool buffer?

>  			if (stats_on)
>  				s->rx_drop_malformed++;

[ ... ]

> @@ -1544,4 +1532,3 @@ static void knod_ipsec_finish_rx_deliver(struct kno=
d_ipsec_dispatcher *disp,
> =20
>  		netmem =3D pool ? page_pool_dev_alloc_netmems(pool) : 0;

[Severity: High]
Because the dispatcher kthread runs with preemption enabled, can calling
page_pool_dev_alloc_netmems() corrupt the page_pool unprotected allocation
cache?

>  		if (!netmem) {
>  			if (stats_on)

[ ... ]

> @@ -1553,4 +1540,3 @@ static void knod_ipsec_finish_rx_deliver(struct kno=
d_ipsec_dispatcher *disp,
>  		pkt_gaddr =3D le64_to_cpu(param->sub[i].pkt_addr);
>  		out_gaddr =3D le64_to_cpu(param->sub[i].out_addr);
>  		dst_base =3D page_pool_get_dma_addr_netmem(netmem);

[Severity: High]
Since these host pages are retrieved from the NIC page pool, are they
mapped into the AMDGPU virtual address space or IOMMU domain? Could passing
them to the SDMA engine trigger a GPU VM or IOMMU fault?

> =20
>  		if (pkt_mode =3D=3D XFRM_MODE_TRANSPORT) {

[ ... ]

> @@ -1785,4 +1771,3 @@ static bool knod_ipsec_post_copy(struct knod_dev *k=
nodev, struct sk_buff *skb,
> =20
>  	slot =3D &priv->slots[sa_slot];
>  	if (!slot->active) {

[Severity: High]
If an SA is rapidly deleted and its slot reallocated while its decrypted
packets are still pending in the delivery ring, could this accept those
packets under the new SA context since there is no SPI or version
validation?

>  		if (stats_on)
>  			s->rx_drop_no_sa++;

[ ... ]

> @@ -1800,4 +1785,3 @@ static bool knod_ipsec_post_copy(struct knod_dev *k=
nodev, struct sk_buff *skb,
>  	seq =3D ((u64)desc->feat.seq_hi << 32) | (u64)desc->feat.seq_lo;
>  	if (!knod_ipsec_sa_window_check(&slot->win[queue_idx], seq)) {

[Severity: Critical]
Does maintaining the anti-replay sliding window per RX queue here rather
than globally per SA allow an attacker to bypass replay protection by
altering outer headers to change the RSS hash?

>  		if (stats_on)
>  			s->rx_drop_replay++;

[ ... ]

> @@ -1861,4 +1845,3 @@ static bool knod_ipsec_post_copy(struct knod_dev *k=
nodev, struct sk_buff *skb,
>  			return false;
>  		}
>  		xfrm_state_hold(slot->x);

[Severity: High]
Is it safe to access and take a reference on slot->x here without locks? If
the SA is deleted concurrently, could this lead to a Use-After-Free when
accessing the freed xfrm_state?

>  		sp->xvec[sp->len++] =3D slot->x;
>  		sp->olen++;

[ ... ]

> @@ -1983,4 +1966,3 @@ static void knod_ipsec_dispatch_wait(struct knod_ip=
sec_dispatcher *disp,
>  	while (READ_ONCE(signal->value) > work->sigval) {
>  		if (--timeout <=3D 0) {

[Severity: High]
Does breaking early on this timeout cause the dispatcher to process
incomplete GPU/SDMA operations?

>  			pr_warn_ratelimited("knod_ipsec: GPU signal timeout nr=3D%d\n",
>  					    work->nr_packets);

[ ... ]

> @@ -2166,4 +2148,3 @@ static bool knod_ipsec_dispatcher_try_rx(struct kno=
d_ipsec_dispatcher *disp,
>  				param->sub[si].bd_addr  =3D
>  					cpu_to_le64(bd_gaddr);
>  				param->sub[si].pkt_len  =3D
>  					cpu_to_le32(bd->len);

[Severity: Critical]
If bd->len is smaller than the combined headers and ICV overhead, could
this calculation underflow later in the shader, producing a massive block
count that leads to out-of-bounds VRAM reads and a GPU crash?

>  				param->sub[si].result_seq =3D 0;
> =20

[ ... ]

> @@ -2178,4 +2159,3 @@ static bool knod_ipsec_dispatcher_try_rx(struct kno=
d_ipsec_dispatcher *disp,
> =20
>  	if (static_branch_unlikely(&ipsec_stats_enabled_key)) {
>  		struct knod_ipsec_stats *cs =3D this_cpu_ptr(priv->stats);

[Severity: Medium]
Can using this_cpu_ptr() here in preemptible kthread contexts trigger
smp_processor_id() warnings and corrupt statistics upon migration?

> =20
>  		cs->rx_peek_total +=3D total_n;

[ ... ]

> @@ -2328,4 +2308,3 @@ static bool knod_ipsec_finalise_inflight(struct kno=
d_ipsec_dispatcher *disp,
>  	if (work->n_sdma_pending > 0) {
>  		if (stats_on) {
>  			struct knod_ipsec_stats *s =3D this_cpu_ptr(priv->stats);

[Severity: Medium]
Is it safe to use this_cpu_ptr() here when preemption isn't disabled?

>  			u64 build_ns =3D work->t_build_end - work->t_build_start;
>  			u64 gpu_ns =3D t_gpu_end > work->t_submit

[ ... ]

> @@ -2581,4 +2560,3 @@ static void knod_ipsec_dispatcher_drain(struct knod=
_ipsec_dispatcher *disp)
>  		if (w->state =3D=3D KNOD_WORK_INFLIGHT) {
>  			knod_ipsec_dispatch_wait(disp, w);
>  			if (!knod_ipsec_finalise_inflight(disp, w)) {

[Severity: High]
If knod_ipsec_dispatch_wait() times out, does this unconditionally proceed
to finalise the work item with incomplete GPU results?

>  				/*
>  				 * SDMA started - spin-wait, we can't

[ ... ]

> @@ -2782,4 +2760,3 @@ static int knod_ipsec_kat_h_one(const u8 *key, int =
key_len)
>  {
>  	u8 h_table[KNOD_GCM_H_TABLE_SIZE];

[Severity: Medium]
Given that KNOD_GCM_H_TABLE_SIZE is 4096 bytes, could allocating this array
on the kernel stack cause a stack overflow?

>  	struct aes_enckey enckey;
>  	u8 zero[AES_BLOCK_SIZE] =3D {};

[ ... ]

> @@ -2868,4 +2845,3 @@ static int knod_ipsec_run_shader_kat_n(struct knod_=
ipsec_priv *priv, int nr)
>  	 * ALIGNed to 8 pages in the alloc path to dodge the KNOD VRAM
>  	 * 7-page alloc bug; the logical payload is still SA_BO_SIZE.
>  	 */
>  	memset(e, 0, KNOD_IPSEC_SA_BO_SIZE);

[Severity: High]
Does clearing the live GPU SA table here without holding priv->slot_lock
permanently overwrite any SA modifications made by concurrent
administrative operations?

>  	for (i =3D 0; i < nr; i++) {
>  		e[i].spi    =3D cpu_to_le32(SPI_KAT_BASE | (u32)i);

[ ... ]

> @@ -3012,4 +2988,3 @@ static int knod_ipsec_run_shader_kat_n(struct knod_=
ipsec_priv *priv, int nr)
>  	knod_ipsec_dispatch_and_wait(&priv->disp[0], dbg_work);
>  	if (priv->disp[0].kthread)
>  		kthread_unpark(priv->disp[0].kthread);

[Severity: Medium]
If the device was previously stopped via knod_ipsec_nod_stop(), does this
unconditionally unpark the thread and violate the stopped state of the
device?

>  	ret =3D 0;
>  	pr_info("knod_ipsec: shader-dispatch[%d] submitted, signal %lld -> (don=
e)\n",

[ ... ]

> @@ -3338,4 +3313,3 @@ static int knod_ipsec_run_crypto_kat(struct knod_ip=
sec_priv *priv)
>  	}
>  	memcpy(sa_backup, priv->sa_table->kaddr, KNOD_IPSEC_SA_BO_SIZE);
>  	memset(priv->sa_table->kaddr, 0, KNOD_IPSEC_SA_BO_SIZE);

[Severity: High]
Can modifying the live SA table here without locks cause permanent
corruption if a user adds or deletes an SA during this selftest?

> =20
>  	sa_entry =3D (struct knod_ipsec_sa_entry *)priv->sa_table->kaddr;

[ ... ]

> @@ -3934,4 +3908,3 @@ static ssize_t knod_ipsec_stats_reset_write(struct =
file *file,
>  		u64 sa_rekey =3D s->sa_rekey;
> =20
>  		memset(s, 0, sizeof(*s));

[Severity: Medium]
Does using memset() on remote per-CPU statistics without synchronization
cause data races and corruption if those CPUs are concurrently updating
their local stats?

>  		s->sa_add =3D sa_add;
>  		s->sa_del =3D sa_del;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719175857.4071=
636-1-ap420073@gmail.com?part=3D13
