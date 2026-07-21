Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1970FC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CCEB10E631;
	Tue, 21 Jul 2026 07:18:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WYeAnUkM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 928A410E3DF
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 07:18:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1785460A99;
 Tue, 21 Jul 2026 07:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFE91F00A3D;
 Tue, 21 Jul 2026 07:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784618280;
 bh=qKeT3kgS8bqc/M0HXp/jRNFK4uxiHEl2Szl+Hx3XJtY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WYeAnUkMIBa1wUgJHPQpHwdlrdj/5wVTtyxb4FaQn0mgXYDvCDGUuJEIPieD+ktwa
 9RKDnWUAu1uy2udh80L21QNDWa6jfISCypgCTF+omY9pElK4MkR/fUG2670rGqykI3
 UDI44xEXGziJYncnwhHQ+Z4TmtELbUgs/z3zGeJFy1yoAQy9beqeM4CoDmFnV4XhDr
 JOlPM9MPDNWhcl3ig+IxXM7JKrdIplGfhWR4DtoPBX72WwdQM4+H3dqGnDF3fqbc8V
 bV6Yz95evQjB5nZ/O5ShoD01Iw6ZuHn1s0nBqcnxoyNEu1/N959FKoEA6H/w/U/6Lc
 UHeymO2xENzEw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH net-next 11/13] bnxt_en: add knod XDP offload support
To: "Taehee Yoo" <ap420073@gmail.com>
Cc: dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20260719175857.4071636-12-ap420073@gmail.com>
References: <20260719175857.4071636-1-ap420073@gmail.com>
 <20260719175857.4071636-12-ap420073@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 07:18:00 +0000
Message-Id: <20260721071800.8CFE91F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [High] Memory leaks in `bnxt_rx_pkt` when `BNXT_RX_OFFLOAD_MODE` is activ=
e.
- [High] Incomplete error rollback during offload attach leads to NULL poin=
ter dereferences.
- [High] Invalid free of knod core-owned memory in `bnxt_knod_uninit()`.
- [High] Detaching the offload accelerator silently corrupts standard XDP s=
tate.
- [High] Type confusion via unconditional cast of `netmem_ref` to `net_iov`.
- [High] Prematurely setting `bp->knodev` to NULL during detach triggers mu=
ltiple NULL pointer dereferences.
- [High] Ignoring the return value of `bnxt_knod_init()` causes a NULL poin=
ter dereference on unload.
- [High] Head-of-line blocking and packet stalls in `bnxt_rx_offload_act_ha=
ndler` due to restrictive limit based on TX availability.
- [High] Unbalanced lifecycle operations for `knod_dev_start` leading to op=
erational failure or resource leaks.
- [High] Incorrect queue bounds check in `bnxt_rx_offload_act_handler()` le=
ads to out-of-bounds access and stalls.
--

--- Patch [11]: [RFC PATCH net-next 11/13] bnxt_en: add knod XDP offload su=
pport ---
commit bc105761ac52d8c362d8a3b4da5f278514f84ca4
Author: Taehee Yoo <ap420073@gmail.com>

bnxt_en: add knod XDP offload support

This commit introduces knod XDP offload support for the bnxt_en driver,
allowing it to register as a knod NIC. It sets up the transmission of
accelerator verdicts through the XDP TX ring and feeds received packets
to the accelerator over the per-queue SPSC ring.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 7513618793daf..6ddf4bafc3d47 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
[ ... ]
> @@ -2249,6 +2303,36 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnx=
t_cp_ring_info *cpr,
>  	len =3D flags >> RX_CMP_LEN_SHIFT;
>  	dma_addr =3D rx_buf->mapping;
> =20
> +	if (BNXT_RX_OFFLOAD_MODE(bp)) {
> +		if (bnxt_alloc_rx_off_netmem(bp, rxr, rxr->rx_prod,
> +					     GFP_ATOMIC)) {
> +			bnxt_reuse_rx_data(rxr, cons, data);
> +			bnapi->cp_ring.sw_stats->rx.rx_buf_errors++;
> +		} else {
> +			struct knod_work_priv *wpriv;
> +			struct spsc_bd *bd;
> +
> +			if (bnapi->index >=3D KNOD_SPSC_MAX) {
> +				rc =3D 1;
> +				goto next_rx;

[Severity: High]
Does this path leak the current data buffer? It appears to jump to
next_rx without freeing or reusing data.

> +			}
> +
> +			wpriv =3D &bp->knodev->wpriv[bnapi->index];
> +			if (spsc_produce(&wpriv->spsc_bds, (void **)&bd)) {
> +				bnxt_reuse_rx_data(rxr, cons, data);

[Severity: High]
If the accelerator SPSC ring is full and spsc_produce() fails, doesn't
calling bnxt_reuse_rx_data() here permanently leak the newly allocated
replacement buffer by overwriting it with the old data?

> +			} else {
> +				bd->netmem =3D (netmem_ref)data;
> +				bd->len =3D len;
> +				bd->off =3D bp->rx_offset;
> +				bd->page_idx =3D net_iov_binding_idx(
> +					netmem_to_net_iov((netmem_ref)data));

[Severity: High]
Is it safe to unconditionally cast data to a net_iov here? The RX page pool
allows standard pages, so if a standard page is used, could this cause type
confusion and out-of-bounds reads?

> +				spsc_produce_commit(&wpriv->spsc_bds);
> +			}
> +		}
> +		rc =3D 1;
> +		goto next_rx;
> +	}
> +
>  	if (bnxt_xdp_attached(bp, rxr)) {
[ ... ]
> @@ -13356,6 +13489,7 @@ static int bnxt_open(struct net_device *dev)
>  						   BNXT_RESTART_ULP_SP_EVENT);
>  		}
>  	}
> +	bnxt_rx_offload_start(bp);

[Severity: High]
Is it intended to unconditionally call bnxt_rx_offload_start() here? If the
preceding __bnxt_open_nic() fails, this will start the accelerator while
the NIC remains down, which could leak active workers.

> =20
>  	return rc;
>  }
[ ... ]
> @@ -17198,6 +17336,7 @@ static int bnxt_init_one(struct pci_dev *pdev, co=
nst struct pci_device_id *ent)
>  	bnxt_print_device_info(bp);
> =20
>  	pci_save_state(pdev);
> +	bnxt_knod_init(bp);

[Severity: High]
Could this leave the driver in a corrupted state if memory allocation fails?
bnxt_knod_init() can return -ENOMEM, but the error is ignored here. If it
fails, bp->knetdev remains NULL, which might lead to a NULL pointer
dereference during module unload in bnxt_knod_uninit().

> =20
>  	return 0;
>  init_err_cleanup:
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/=
ethernet/broadcom/bnxt/bnxt_xdp.c
> index 9e5009be8e989..a264a2cf8302a 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
[ ... ]
> @@ -441,19 +446,123 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bp=
f_prog *prog)
>  	return 0;
>  }
> =20
> +
> +static int bnxt_xdp_offload_set(struct bnxt *bp, int enable)
> +{
[ ... ]
> +	if (enable) {
> +		bnxt_set_rx_skb_mode(bp, BNXT_FLAG_RX_OFFLOAD_MODE);
> +		xdp_features_set_redirect_target_locked(dev, true);
> +	} else {
> +		xdp_features_clear_redirect_target_locked(dev);
> +		bnxt_set_rx_skb_mode(bp, false);

[Severity: High]
Does detaching the offload accelerator silently corrupt standard XDP state?
If a standard XDP program is still active (bp->xdp_prog), explicitly cleari=
ng
the BNXT_FLAG_RX_PAGE_MODE flag here without restoring the correct settings
for the active standard XDP program could cause packet processing failures.

> +	}
> +	bp->tx_nr_rings_xdp =3D tx_xdp;
> +	bp->tx_nr_rings =3D bp->tx_nr_rings_per_tc * tc + tx_xdp;
> +	tx_cp =3D bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
> +	bp->cp_nr_rings =3D max_t(int, tx_cp, bp->rx_nr_rings);
> +	bnxt_set_tpa_flags(bp);
> +	bnxt_set_ring_params(bp);
> +
> +	if (netif_running(dev))
> +		return bnxt_open_nic(bp, true, false);

[Severity: High]
When attaching offload to an already-running interface, is the accelerator
ever started? This restarts the NIC via bnxt_open_nic(), but it seems to
omit a call to bnxt_rx_offload_start(), which might leave the accelerator
unable to process packets.

> +
> +	return 0;
> +}
[ ... ]
> +static int bnxt_rx_offload_xdp_attach(struct knod_dev *knodev)
> +{
> +	struct bnxt *bp =3D netdev_priv(knodev->netdev);
> +	int rc;
> +
> +	WRITE_ONCE(bp->knodev, knodev);
> +	rc =3D bnxt_xdp_offload_set(bp, true);
> +	if (rc)
> +		WRITE_ONCE(bp->knodev, NULL);

[Severity: High]
Could this error handling path lead to a NULL pointer dereference? If
bnxt_xdp_offload_set() sets BNXT_FLAG_RX_OFFLOAD_MODE but subsequently
fails, bp->knodev is set back to NULL without clearing the offload flag. A
later stats read or interface up might see the flag and dereference the
NULL knodev.

> +
> +	return rc;
> +}
> +
> +static int bnxt_rx_offload_xdp_detach(struct knod_dev *knodev)
> +{
> +	struct bnxt *bp =3D netdev_priv(knodev->netdev);
> +
> +	WRITE_ONCE(bp->knodev, NULL);
> +	bnxt_xdp_offload_set(bp, false);

[Severity: High]
Is it safe to set bp->knodev to NULL before shutting down the interface?
Since BNXT_RX_OFFLOAD_MODE is still active until bnxt_xdp_offload_set()
finishes, concurrent NAPI polling in bnxt_rx_pkt() or teardown paths like
bnxt_rx_offload_clear_napi() could observe the flag and dereference the NULL
pointer.

> +
> +	return 0;
> +}
[ ... ]
> +int bnxt_rx_offload_act_handler(struct bnxt_napi *bnapi, int budget)
> +{
> +	struct bnxt_tx_ring_info *txr =3D bnapi->tx_ring[0];
> +	struct bnxt_rx_ring_info *rxr =3D bnapi->rx_ring;
> +	struct spsc_bd *bds[NAPI_POLL_WEIGHT];
> +	u32 tx_avail, cnt, i, nxmit =3D 0;
> +	struct knod_dev *knodev;
> +	struct knod_work_priv *wpriv;
> +	struct napi_struct *napi;
> +	struct bnxt *bp =3D bnapi->bp;
> +	dma_addr_t mapping;
> +
> +	knodev =3D bp->knodev;
> +	if (!knodev)
> +		return 0;
> +
> +	if (bnapi->index >=3D bp->dev->real_num_tx_queues) {

[Severity: High]
Should this bounds check compare against KNOD_SPSC_MAX instead of the number
of TX queues? If there are more RX queues than TX queues, valid RX NAPI
instances might return early and abandon packets. Conversely, if there are
many TX queues, this could fail to properly bound accesses to the wpriv arr=
ay.

> +		this_cpu_inc(knodev->stats->tx_dropped);
> +		return 0;
> +	}
> +
> +	wpriv =3D &knodev->wpriv[bnapi->index];
> +	napi =3D READ_ONCE(wpriv->napi);
> +	if (!napi)
> +		return 0;
> +
> +	tx_avail =3D bnxt_tx_avail(bp, txr);
> +	cnt =3D min_t(u32, NAPI_POLL_WEIGHT, tx_avail);
> +	cnt =3D min_t(u32, cnt, budget);
> +	if (!cnt)
> +		return 0;

[Severity: High]
Could this early return cause head-of-line blocking and permanent packet
stalls? If the TX ring is full (tx_avail =3D=3D 0), cnt becomes 0. Returning
immediately skips knod_dev_xdp_drain_pass(), which could trap packets meant
for the host stack indefinitely.

> +
> +	spsc_release(&wpriv->spsc_bds, (void **)bds, cnt, &cnt);
> +	if (!cnt)
> +		return 0;
> +
> +	for (i =3D 0; i < cnt; i++) {
> +		switch (bds[i]->act) {
> +		case KNOD_ACT_INFLIGHT:
> +		case KNOD_IPSEC_INFLIGHT:
> +			goto stop_release;
> +		case XDP_TX:
> +			mapping =3D netmem_to_net_iov(bds[i]->netmem)->desc.dma_addr +
> +				  bds[i]->off;

[Severity: High]
Can this path be reached when netmem is a standard page rather than a DMABU=
F?
If so, using netmem_to_net_iov() without verifying netmem_is_net_iov() could
misinterpret standard page structure fields as DMA addresses, potentially
causing memory corruption.

> +			__bnxt_xmit_netmem(bp, txr, mapping, bds[i]->len,
> +					   bds[i]->netmem);
[ ... ]
> +void bnxt_knod_uninit(struct bnxt *bp)
> +{
> +	knod_netdev_unregister(bp->knetdev);
> +	kfree(bp->knetdev);
> +	bp->knetdev =3D NULL;
> +	kfree(bp->knodev);

[Severity: High]
Is it correct to call kfree(bp->knodev) here? bp->knodev points to a
struct knod_dev allocated and managed by the knod core framework, so freeing
it from the driver could result in heap corruption or a use-after-free
during device unbind.

> +	WRITE_ONCE(bp->knodev, NULL);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719175857.4071=
636-1-ap420073@gmail.com?part=3D11
