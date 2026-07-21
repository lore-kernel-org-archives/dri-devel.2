Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFA9C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:18:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D780E10E648;
	Tue, 21 Jul 2026 07:18:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rb5lPKHc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 357D310E4B6
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 07:18:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1F25840AA5;
 Tue, 21 Jul 2026 07:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0191F000E9;
 Tue, 21 Jul 2026 07:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784618280;
 bh=SiXUCpLnvsmh5s4KIZnYWdkH8YALck8dRgQkppYTETA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Rb5lPKHcEHD6WCas/3vZrDzk0g6h5rzsOoKFPJvZMFmKQDy3GCqcD4tdhELc15TNF
 PQelnvg1pCkR93As9mxCytVPi2hbJ1eM/jO3pcplMy2elg2ThN125Qw5RfI/d9jDma
 SN01Fi7+p1QjLkhaGNE2ak8S8MyZrZCbE0DxT/fNq/LXUys2jYl9HYsCIbEfDtUpC9
 bo+11gSq2Rv58cxumC2MtsRcJTpMFqjhVAWrJXCHn/Xn/jr9vumdfzI6jHGlr3+LnB
 r4FiDtTB1pu0a2PbKaT2Yksb+RsD7obHUJag8dwygmlGhXvbdyd2exj5gxCJP/db7O
 fPLvmFlenQ2Uw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH net-next 10/13] net/mlx5e: add knod XDP offload support
To: "Taehee Yoo" <ap420073@gmail.com>
Cc: bpf@vger.kernel.org, media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260719175857.4071636-11-ap420073@gmail.com>
References: <20260719175857.4071636-1-ap420073@gmail.com>
 <20260719175857.4071636-11-ap420073@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 07:17:59 +0000
Message-Id: <20260721071759.BF0191F000E9@smtp.kernel.org>
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
- [High] mlx5e_open() starts the offload worker unconditionally even if mlx=
5e_open_locked() fails.
- [High] mlx5e_knod_uninit() illegally frees priv->knodev which is owned an=
d freed by the KNOD framework.
- [High] Unbounded iteration over channels causes out-of-bounds accesses on=
 `knodev->wpriv` and `mlx5e_knod_release_batch`.
- [High] mlx5e_xmit_xdp_offload_buff() incorrectly casts standard netmem_re=
f pages to net_iov, reading garbage DMA addresses.
- [High] RX buffers mapped as DMA_FROM_DEVICE are transmitted on the TX que=
ue without remapping, causing IOMMU faults.
- [High] Global static batch array is used concurrently by different netdev=
 NAPI instances.
- [High] Missing channel restart during offload attach/detach leads to sile=
nt failure and Use-After-Free of `rq->knodev`.
- [High] `mlx5e_rx_offload_stop` races with active NAPI RX processing, lead=
ing to SPSC ring corruption and use-after-free of page pool pages.
- [High] A permanent failure during offload transmission (e.g., oversized M=
TU) causes the release loop to wedge forever, breaking the RX queue.
- [Low] The `nic_ops` structure is exported to the global linker namespace =
without the `static` keyword.
--

--- Patch [10]: [RFC PATCH net-next 10/13] net/mlx5e: add knod XDP offload =
support ---
commit de6f2fbf7fa4e2b457c356167b75d55f4c90a073
Author: Taehee Yoo <ap420073@gmail.com>

net/mlx5e: add knod XDP offload support

Let mlx5e act as a knod NIC: register with the knod core, feed received
packets to the accelerator over the per-queue SPSC ring, and transmit
accelerator verdicts (XDP_TX) back through the XDP SQ.  Restricted to
inline-none TX and single-page MTU.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/en/xdp.c
> index d8c7cb8837d74..82adfc9b7c1b6 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c

[ ... ]

> +static inline bool mlx5e_xmit_xdp_offload_buff(struct mlx5e_xdpsq *sq,
> +					       struct mlx5e_rq *rq,
> +					       struct spsc_bd *bd)
> +{
> +	struct mlx5e_xmit_data_frags xdptxdf =3D {};
> +	struct mlx5e_xmit_data *xdptxd;
> +
> +	/* attach is restricted to inline-none NICs, so the WQE inlines no
> +	 * header and xdptxd->data is never read (left NULL here).
> +	 */
> +	xdptxd =3D &xdptxdf.xd;
> +	xdptxd->len =3D bd->len;
> +	xdptxd->has_frags =3D 0;
> +	xdptxd->dma_addr =3D netmem_to_net_iov(bd->netmem)->desc.dma_addr +
> +			   bd->off;

[Severity: High]
Is this cast safe if the memory isn't a devmem/net_iov?

If the interface uses standard host memory, `netmem_to_net_iov()` will read
garbage data for the DMA address instead of properly mapping it.

> +
> +	if (!mlx5e_xmit_xdp_frame(sq, xdptxd, 0, NULL))
> +		return false;

[Severity: High]
Will this trigger an IOMMU access violation?

If rq->buff.map_dir defaults to DMA_FROM_DEVICE (when there's no software
XDP program), this transmits the buffer without remapping it for device
read access.

[ ... ]

> +struct mlx5e_knod_release_batch {
> +	struct spsc_bd *bds[NAPI_POLL_WEIGHT];
> +	struct spsc_pass_bd pass[NAPI_POLL_WEIGHT];
> +};
> +
> +static struct mlx5e_knod_release_batch
> +mlx5e_knod_release_batch[KNOD_SPSC_MAX];

[Severity: High]
Is this static array prone to cross-device data races?

If multiple mlx5e network interfaces are active concurrently, their NAPI
threads might run in parallel on different CPUs. Because this array is
global and indexed only by rq->ix in mlx5e_rx_offload_release_pending(),
they could overwrite each other's batches.

Additionally, since mlx5e supports creating one RX channel per CPU core,
can rq->ix exceed KNOD_SPSC_MAX and cause an out-of-bounds access?

[ ... ]

> +			case KNOD_TX:
> +				if (!mlx5e_xmit_xdp_offload_buff(rq->xdpsq, rq,
> +								 bds[i]))
> +					goto stop_release;

[Severity: High]
Does this cause an infinite retry loop for permanent failures?

If mlx5e_xmit_xdp_offload_buff() fails because a packet exceeds the TX MTU
limit, taking this goto stop_release leaves the buffer in the ring.=20

The next NAPI poll would then retry the exact same oversized packet
indefinitely, stalling the queue.

[ ... ]

> +static int mlx5e_rx_offload_xdp_attach(struct knod_dev *knodev)
> +{
[ ... ]
> +	pr_debug("Attaching XDP offload to netdev %s\n", knodev->netdev->name);
> +	WRITE_ONCE(priv->knodev, knodev);
> +
> +	return 0;
> +}
> +
> +static int mlx5e_rx_offload_xdp_detach(struct knod_dev *knodev)
> +{
> +	struct mlx5e_priv *priv =3D netdev_priv(knodev->netdev);
> +
> +	pr_debug("Detaching XDP offload from netdev %s\n",
> +		 knodev->netdev->name);
> +	WRITE_ONCE(priv->knodev, NULL);
> +
> +	return 0;
> +}

[Severity: High]
Could this lead to use-after-free and silent data path failures if the
interface is administratively UP?

By updating priv->knodev without restarting the active network channels
(e.g., via mlx5e_safe_switch_params()), a hot-detach leaves the active RX
queues holding stale pointers to a knodev structure that the framework
is about to free.

> +
> +struct knod_nic_ops nic_ops =3D {
> +	.attach =3D mlx5e_rx_offload_xdp_attach,
> +	.detach =3D mlx5e_rx_offload_xdp_detach,
> +};

[Severity: Low]
Should this struct be marked static?

Exporting nic_ops to the global namespace could create a collision hazard
if any other driver defines a variable with the same name.

> +
> +int mlx5e_knod_init(struct mlx5e_priv *priv)
[ ... ]
> +void mlx5e_knod_uninit(struct mlx5e_priv *priv)
> +{
> +	knod_netdev_unregister(priv->knetdev);
> +	kfree(priv->knetdev);
> +	priv->knetdev =3D NULL;
> +	kfree(priv->knodev);
> +	WRITE_ONCE(priv->knodev, NULL);
> +}

[Severity: High]
Does this code free memory it doesn't own?

The knodev pointer is a framework-owned object passed via the attach()
callback. Calling kfree(priv->knodev) here could lead to a double-free
when the framework subsequently cleans up the device.

[ ... ]

> +void mlx5e_rx_offload_stop(struct mlx5e_priv *priv)
> +{
[ ... ]
> +	synchronize_net();
> +	for (i =3D 0; i < KNOD_SPSC_MAX; i++) {
[ ... ]
> +		spsc_rewind(&knodev->wpriv[i].spsc_bds);
> +		while (!spsc_pop(&knodev->wpriv[i].spsc_bds, (void **)&bd))
> +			page_pool_put_full_netmem(netmem_get_pp(bd->netmem),
> +						  bd->netmem, true);
> +	}
> +}

[Severity: High]
Could this race with NAPI and corrupt the SPSC ring or page pool?

In mlx5e_close(), mlx5e_rx_offload_stop() is called before
mlx5e_close_locked(), meaning NAPI is still actively processing.

Calling page_pool_put_full_netmem() with allow_direct =3D true concurrently
with NAPI violates the page pool API locking constraints.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_main.c
> index aa8610cedaa85..cfc6ba6dc492b 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -918,6 +918,7 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
>  	pool_size =3D 1 << params->log_rq_mtu_frames;
> =20
>  	rq->mkey_be =3D cpu_to_be32(mdev->mlx5e_res.hw_objs.mkey);
> +	rq->knodev =3D rq->priv->knodev;

[Severity: High]
Does rq->buff.map_dir need to be DMA_BIDIRECTIONAL when hardware offload
is active?

In mlx5e_alloc_rq() just above this addition, rq->buff.map_dir is set to
DMA_FROM_DEVICE if params->xdp_prog is false. This causes IOMMU faults
later when the buffer is transmitted directly on the TX queue without being
remapped.

[ ... ]

> @@ -3592,6 +3597,7 @@ int mlx5e_open(struct net_device *netdev)
>  		mlx5e_modify_admin_state(priv->mdev, MLX5_PORT_UP);
>  	mutex_unlock(&priv->state_lock);
> =20
> +	mlx5e_rx_offload_start(priv);
>  	return err;
>  }

[Severity: High]
Should mlx5e_rx_offload_start() be skipped if mlx5e_open_locked() fails?

If err indicates failure, the netdev remains closed, so mlx5e_close()
won't be called to clean up. This leaves the worker running indefinitely
and can cause a use-after-free when it accesses the failed queues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719175857.4071=
636-1-ap420073@gmail.com?part=3D10
