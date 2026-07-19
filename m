Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBE6C4451B
	for <dri-devel@archiver.kernel.org>; Sun, 19 Jul 2026 18:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4999D10E08D;
	Sun, 19 Jul 2026 18:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YQxmDAZ+";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2D6210E085
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 18:01:42 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2ccf2360620so53577355ad.3
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 11:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784484102; x=1785088902; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Mn9ILc7KfHYPQN6h07+6ERrU/MrbOq4Gmsuwq4UE7rc=;
 b=YQxmDAZ+kqiOuoy2k4KccyUZOVeN4l5KxpG4QENcYc3FimGM4kXMtAiWIhR0ZuBtae
 vtPK/o2oREtRRx4H/XRDJ8ciQLqJ2rIAsj4ZaH8qr70ujhC25jD0Jwu3oSFEq7bW9CNU
 yPYc9QO2Sl/ovGUoqqWy/Wsw6Lh9JcdqkR3lUoZS1EQcntldjxWvS7cG2vKsEP7E/Ga8
 JE+Vr6dachRas2yu4VprPtMD9/LtU3YKH1IQv4tfVCWRV6ES1icd8jGQZHfJam6ydI1S
 9i4RZj4sEISQmIRd/hc1J4L1FyGMvb3hA9hTlE9RDnqbJ+aMOaXi0uCmlAP7d0vWZMpB
 j3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784484102; x=1785088902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Mn9ILc7KfHYPQN6h07+6ERrU/MrbOq4Gmsuwq4UE7rc=;
 b=NyiV/74fxXstMCCqCW++TqiFMo5Tmvk0gCYHDcNsG/bpeqPPL1KhJ9XUQ6yH4PNY/n
 DrYyM1ECNTZU2j+YG0mPQK0hX30qm6Q1+TvXi5sVn3gd24/KSgoqwEV2ShtfMpKS+ALe
 rN02o1PsCWMiLPFNHlOfuyCUYg3hI14lpCfCi88NaWw7E3cs/vQvHNazyYfOWR2QSJbQ
 8lSzZGHb2InxskWdxXo3yu6YI4OoQ1HNrQlKJKjvQ6gmNKARCdbqRGNNvFfooZulkBfl
 VbQWRucveuWqUC+lJv9wvPOwPj5Hhg86fVW2gfPbJQ17SDNRYiZ98+jpW2gDgINYgzBi
 xo9g==
X-Forwarded-Encrypted: i=1;
 AHgh+RovKm/a8V2QQM4olWZu0lmqg8/Jykz+9LZlJGmdjM/cETdc2BRKRXgdSzQsciMPwLo5H/GEA8PDYKw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzWorscG67TqoU8l0H9iMSZRTL8/PszbYYU+62N1Q5PNBNrbnGM
 kIJp6jqtHqoouqoqoK0e7aai3RsO5X8xGWd0+p9ydEJUgeDQzXu6G2N4
X-Gm-Gg: AfdE7cl2pV1fqQd7rX1yr045Bc4K2Udq7zRY4igz82KSLdrMe20L0PlUNSjPVQYWRTh
 XYxRm76sJLj8CiOkDmqPzJs/h+xkXDebq0wrQIxdCHn4iPID4EYsbvcFXR4cb5VGvwFzjPCWTNW
 AHquptEYGHo4aLUxEqA60DrEI3LjFhufdi2GULpY8WenI0y5gspnrPc3MxXPQyXbtmVwg2IxEDg
 urn551ND1GFzKVnfLLNeSwi0sfNCEBTV6HJXNbEuisgG0nQMczLzosGfNMwD/61vZ4argb0ZaiR
 PghFh3uOqSm9FwvxWbxc7fHEgYK1eQVzd2TJvA3SG35E6gxmdpJQFlSTd4z14Ht1VkYudT9XfeP
 VWEUoXPYyltd03rW8pjogI+WRj9+SFjV96cHRjT1Q4Y12JsAUL4dGvUIIU2zjBDlPaA==
X-Received: by 2002:a17:902:d586:b0:2ca:4cfd:a6df with SMTP id
 d9443c01a7336-2cf34a0b335mr124560325ad.43.1784484101843; 
 Sun, 19 Jul 2026 11:01:41 -0700 (PDT)
Received: from ap.. ([182.213.254.91]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf34769bd6sm43511065ad.74.2026.07.19.11.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 11:01:40 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Alexei Starovoitov <ast@kernel.org>, amd-gfx@lists.freedesktop.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Andrii Nakryiko <andrii@kernel.org>,
 Bill Wendling <morbo@google.com>, bpf@vger.kernel.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Borkmann <daniel@iogearbox.net>, David Airlie <airlied@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, dri-devel@lists.freedesktop.org,
 Eduard Zingerman <eddyz87@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, Eric Dumazet <edumazet@google.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Hoyeon Lee <hoyeon.rhee@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Leon Romanovsky <leon@kernel.org>, linaro-mm-sig@lists.linaro.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
 Mark Bloch <mbloch@nvidia.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Michael Chan <michael.chan@broadcom.com>,
 Nathan Chancellor <nathan@kernel.org>, netdev@vger.kernel.org,
 Nick Desaulniers <ndesaulniers@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Simon Horman <horms@kernel.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Sumit Semwal <sumit.semwal@linaro.org>, Taehee Yoo <ap420073@gmail.com>,
 Tariq Toukan <tariqt@nvidia.com>, Yonghong Song <yonghong.song@linux.dev>
Subject: [RFC PATCH net-next 10/13] net/mlx5e: add knod XDP offload support
Date: Sun, 19 Jul 2026 17:58:54 +0000
Message-ID: <20260719175857.4071636-11-ap420073@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719175857.4071636-1-ap420073@gmail.com>
References: <20260719175857.4071636-1-ap420073@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Let mlx5e act as a knod NIC: register with the knod core, feed received
packets to the accelerator over the per-queue SPSC ring, and transmit
accelerator verdicts (XDP_TX) back through the XDP SQ.  Restricted to
inline-none TX and single-page MTU.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
(cherry picked from commit 218c3a122d6b53638b99441560b7a0da65f6d8c1)
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  10 +
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 351 ++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |  19 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  38 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 107 +++++-
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c |  45 +++
 6 files changed, 564 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index d507289096c2..1401a24e1740 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -48,6 +48,7 @@
 #include <net/udp_tunnel.h>
 #include <net/switchdev.h>
 #include <net/psp/types.h>
+#include <net/knod.h>
 #include <net/xdp.h>
 #include <linux/dim.h>
 #include <linux/bits.h>
@@ -568,6 +569,8 @@ struct mlx5e_icosq {
 
 struct mlx5e_frag_page {
 	netmem_ref netmem;
+	struct page_pool *pp;
+	u32 page_idx;
 	u16 frags;
 };
 
@@ -739,6 +742,11 @@ struct mlx5e_rq {
 
 	struct mlx5e_xdp_buff mxbuf;
 
+	struct knod_dev *knodev;
+	struct knod_netdev *knetdev;
+	u32                    knod_spsc_prod_head;
+	bool                   knod_spsc_prod_valid;
+
 	/* AF_XDP zero-copy */
 	struct xsk_buff_pool  *xsk_pool;
 
@@ -985,6 +993,8 @@ struct mlx5e_priv {
 	struct dentry             *dfs_root;
 	struct mlx5_devcom_comp_dev *devcom;
 	struct ethtool_fec_hist_range *fec_ranges;
+	struct knod_dev *knodev;
+	struct knod_netdev *knetdev;
 };
 
 static inline u16 mlx5e_stats_nch_read(const struct mlx5e_priv *priv)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index d8c7cb8837d7..82adfc9b7c1b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -35,8 +35,18 @@
 #include "en/xdp.h"
 #include "en/params.h"
 #include <linux/bitfield.h>
+#include <linux/module.h>
 #include <net/page_pool/helpers.h>
 
+INDIRECT_CALLABLE_SCOPE bool
+mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
+		     int check_result, struct xsk_tx_metadata *meta);
+
+static inline struct page_pool *mlx5e_knod_bd_pp(struct spsc_bd *bd)
+{
+	return likely(bd->pp) ? bd->pp : netmem_get_pp(bd->netmem);
+}
+
 int mlx5e_xdp_max_mtu(struct mlx5e_params *params,
 		      struct mlx5e_rq_opt_param *rqo)
 {
@@ -58,6 +68,36 @@ int mlx5e_xdp_max_mtu(struct mlx5e_params *params,
 	return MLX5E_HW2SW_MTU(params, SKB_MAX_HEAD(hr));
 }
 
+static inline bool mlx5e_xmit_xdp_offload_buff(struct mlx5e_xdpsq *sq,
+					       struct mlx5e_rq *rq,
+					       struct spsc_bd *bd)
+{
+	struct mlx5e_xmit_data_frags xdptxdf = {};
+	struct mlx5e_xmit_data *xdptxd;
+
+	/* attach is restricted to inline-none NICs, so the WQE inlines no
+	 * header and xdptxd->data is never read (left NULL here).
+	 */
+	xdptxd = &xdptxdf.xd;
+	xdptxd->len = bd->len;
+	xdptxd->has_frags = 0;
+	xdptxd->dma_addr = netmem_to_net_iov(bd->netmem)->desc.dma_addr +
+			   bd->off;
+
+	if (!mlx5e_xmit_xdp_frame(sq, xdptxd, 0, NULL))
+		return false;
+
+	mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo,
+			     (union mlx5e_xdp_info) {
+				.mode = MLX5E_XDP_XMIT_MODE_OFFLOAD });
+	mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo,
+			     (union mlx5e_xdp_info) {
+				.offload.netmem = bd->netmem,
+				.offload.pp = mlx5e_knod_bd_pp(bd) });
+
+	return true;
+}
+
 static inline bool
 mlx5e_xmit_xdp_buff(struct mlx5e_xdpsq *sq, struct mlx5e_rq *rq,
 		    struct xdp_buff *xdp)
@@ -353,6 +393,154 @@ bool mlx5e_xdp_handle(struct mlx5e_rq *rq,
 	}
 }
 
+static inline u16 mlx5e_xdpsq_get_avail(struct mlx5e_xdpsq *sq)
+{
+	if (sq->pc == sq->cc)
+		return sq->wq.fbc.sz_m1 + 1;
+
+	return sq->wq.fbc.sz_m1 & (sq->cc - sq->pc);
+}
+
+static inline u16 mlx5e_xdpsq_get_avail_after_poll(struct mlx5e_xdpsq *sq)
+{
+	u16 avail = mlx5e_xdpsq_get_avail(sq);
+
+	if (likely(avail))
+		return avail;
+
+	mlx5e_xmit_xdp_doorbell(sq);
+	mlx5e_poll_xdpsq_cq(&sq->cq);
+
+	return mlx5e_xdpsq_get_avail(sq);
+}
+
+struct mlx5e_knod_release_batch {
+	struct spsc_bd *bds[NAPI_POLL_WEIGHT];
+	struct spsc_pass_bd pass[NAPI_POLL_WEIGHT];
+};
+
+static struct mlx5e_knod_release_batch
+mlx5e_knod_release_batch[KNOD_SPSC_MAX];
+
+static noinline int
+mlx5e_rx_offload_release_pending(struct mlx5e_rq *rq,
+				 struct knod_work_priv *wpriv,
+				 bool flush, int budget)
+{
+	struct knod_dev *knodev = rq->knodev;
+	struct mlx5e_xdpsq *sq = rq->xdpsq;
+	struct mlx5e_knod_release_batch *batch =
+		&mlx5e_knod_release_batch[rq->ix];
+	struct spsc_bd **bds = batch->bds;
+	struct spsc_pass_bd *pass = batch->pass;
+	int cnt, i, done = 0;
+
+	while (done < budget) {
+		int pass_cnt = 0;
+
+		if (!mlx5e_xdpsq_get_avail_after_poll(sq))
+			break;
+		cnt = min(NAPI_POLL_WEIGHT, budget - done);
+
+		spsc_release(&wpriv->spsc_bds, (void **)bds, cnt, &cnt);
+		if (!cnt)
+			break;
+
+		for (i = 0; i < cnt; i++) {
+			switch ((u32)bds[i]->act) {
+			case KNOD_ACT_INFLIGHT:
+				fallthrough;
+			case KNOD_IPSEC_INFLIGHT:
+				goto stop_release;
+			case KNOD_IPSEC_PASS:
+				fallthrough;
+			case KNOD_IPSEC_DROP:
+				/* Finish worker has set the final verdict.
+				 * Safe to recycle the netmem page now.
+				 */
+				page_pool_recycle_direct_netmem(
+					mlx5e_knod_bd_pp(bds[i]),
+					bds[i]->netmem);
+				break;
+			case KNOD_TX:
+				if (!mlx5e_xmit_xdp_offload_buff(rq->xdpsq, rq,
+								 bds[i]))
+					goto stop_release;
+				break;
+			case XDP_DROP:
+				fallthrough;
+			case XDP_ABORTED:
+				rq->stats->xdp_drop++;
+				page_pool_recycle_direct_netmem(
+					mlx5e_knod_bd_pp(bds[i]),
+					bds[i]->netmem);
+				break;
+			case XDP_PASS:
+				/* Hand to the common device->host delivery:
+				 * accumulate here, flush to knod_d2h_copy
+				 * after the bd loop.  The source page is
+				 * recycled by knod_d2h_drain once the copy
+				 * has landed, so it is NOT recycled here.
+				 */
+				pass[pass_cnt].netmem = bds[i]->netmem;
+				pass[pass_cnt].page_idx = bds[i]->page_idx;
+				pass[pass_cnt].off = bds[i]->off;
+				pass[pass_cnt].len = bds[i]->len;
+				pass_cnt++;
+				break;
+			case XDP_REDIRECT:
+				/* No redirect delivery path yet; recycle. */
+				page_pool_recycle_direct_netmem(
+					mlx5e_knod_bd_pp(bds[i]),
+					bds[i]->netmem);
+				break;
+			default:
+				/* Unknown value: either the accel shader
+				 * did not stamp a verdict for this slot
+				 * (lane skip bug) or the slot never went
+				 * through an accel at all. Treat as DROP +
+				 * recycle + WARN so the ring keeps advancing.
+				 */
+				rq->stats->xdp_drop++;
+				pr_warn_ratelimited("mlx5 nod: invalid bd->act=0x%llx rq%d, treating as DROP\n",
+						    bds[i]->act, rq->ix);
+				page_pool_recycle_direct_netmem(
+					mlx5e_knod_bd_pp(bds[i]),
+					bds[i]->netmem);
+				break;
+			}
+		}
+stop_release:
+		spsc_release_commit(&wpriv->spsc_bds, i);
+		done += i;
+
+		/* Issue the device->host copies for this batch's PASS bds. */
+		if (pass_cnt)
+			knod_d2h_copy(knodev, rq->ix, pass, pass_cnt);
+
+		if (i < cnt)
+			break;
+	}
+
+	if (flush)
+		mlx5e_xmit_xdp_doorbell(sq);
+
+	return done;
+}
+
+int mlx5e_rx_offload_act_handler(struct mlx5e_rq *rq, bool flush, int budget)
+{
+	struct knod_work_priv *wpriv = &rq->knodev->wpriv[rq->ix];
+
+	if (!spsc_pending(&wpriv->spsc_bds)) {
+		if (flush)
+			mlx5e_xmit_xdp_doorbell(rq->xdpsq);
+		return 0;
+	}
+
+	return mlx5e_rx_offload_release_pending(rq, wpriv, flush, budget);
+}
+
 static u16 mlx5e_xdpsq_get_next_pi(struct mlx5e_xdpsq *sq, u16 size)
 {
 	struct mlx5_wq_cyc *wq = &sq->wq;
@@ -741,6 +929,18 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 			(*xsk_frames)++;
 			break;
 		}
+		case MLX5E_XDP_XMIT_MODE_OFFLOAD: {
+			netmem_ref netmem;
+			struct page_pool *pp;
+
+			xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
+			netmem = xdpi.offload.netmem;
+			pp = xdpi.offload.pp;
+
+			page_pool_recycle_direct_netmem(pp, netmem);
+
+			break;
+		}
 		default:
 			WARN_ON_ONCE(true);
 		}
@@ -974,3 +1174,154 @@ void mlx5e_set_xmit_fp(struct mlx5e_xdpsq *sq, bool is_mpw)
 	sq->xmit_xdp_frame = is_mpw ?
 		mlx5e_xmit_xdp_frame_mpwqe : mlx5e_xmit_xdp_frame;
 }
+
+static int mlx5e_rx_offload_xdp_attach(struct knod_dev *knodev)
+{
+	struct mlx5e_priv *priv = netdev_priv(knodev->netdev);
+	struct mlx5e_params *params = &priv->channels.params;
+	int max_mtu = mlx5e_xdp_max_mtu(params, NULL);
+
+	if (knodev->netdev->mtu > max_mtu) {
+		netdev_warn(knodev->netdev,
+			    "MTU %u too big for single-page RX offload (max %d)\n",
+			    knodev->netdev->mtu, max_mtu);
+		return -EOPNOTSUPP;
+	}
+
+	/* The offload TX WQE carries the packet only in a data segment; the
+	 * eth header is not inlined (a zero dummy stands in). NICs that require
+	 * a minimum inline header (e.g. ConnectX-4) would transmit that dummy,
+	 * so only allow attach when the device needs no inline header.
+	 */
+	if (params->tx_min_inline_mode != MLX5_INLINE_MODE_NONE) {
+		netdev_warn(knodev->netdev,
+			    "knod offload requires a NIC with inline header mode 'none'\n");
+		return -EOPNOTSUPP;
+	}
+
+	pr_debug("Attaching XDP offload to netdev %s\n", knodev->netdev->name);
+	WRITE_ONCE(priv->knodev, knodev);
+
+	return 0;
+}
+
+static int mlx5e_rx_offload_xdp_detach(struct knod_dev *knodev)
+{
+	struct mlx5e_priv *priv = netdev_priv(knodev->netdev);
+
+	pr_debug("Detaching XDP offload from netdev %s\n",
+		 knodev->netdev->name);
+	WRITE_ONCE(priv->knodev, NULL);
+
+	return 0;
+}
+
+struct knod_nic_ops nic_ops = {
+	.attach = mlx5e_rx_offload_xdp_attach,
+	.detach = mlx5e_rx_offload_xdp_detach,
+};
+
+int mlx5e_knod_init(struct mlx5e_priv *priv)
+{
+	struct knod_netdev *knetdev;
+
+	knetdev = kzalloc_obj(struct knod_netdev, GFP_KERNEL);
+	if (!knetdev) {
+		pr_debug("Failed to allocate knetdev\n");
+		return -ENOMEM;
+	}
+
+	INIT_LIST_HEAD(&knetdev->list);
+	knetdev->dev = priv->netdev;
+	knetdev->priv = priv;
+	knetdev->nic_ops = &nic_ops;
+	knetdev->owner = THIS_MODULE;
+	knetdev->flags |= KNOD_FLAGS_XDP;
+	knod_netdev_register(knetdev);
+	priv->knetdev = knetdev;
+
+	return 0;
+}
+
+void mlx5e_knod_uninit(struct mlx5e_priv *priv)
+{
+	knod_netdev_unregister(priv->knetdev);
+	kfree(priv->knetdev);
+	priv->knetdev = NULL;
+	kfree(priv->knodev);
+	WRITE_ONCE(priv->knodev, NULL);
+}
+
+void mlx5e_rx_offload_set_napi(struct mlx5e_priv *priv)
+{
+	struct knod_dev *knodev = priv->knodev;
+	int i;
+
+	if (!knodev)
+		return;
+
+	for (i = 0; i < priv->channels.num; i++) {
+		struct mlx5e_channel *c = priv->channels.c[i];
+		struct spsc_ring *r = &knodev->wpriv[i].spsc_bds;
+
+		WRITE_ONCE(knodev->wpriv[i].napi, &c->napi);
+		c->rq.knod_spsc_prod_head = READ_ONCE(r->head);
+		c->rq.knod_spsc_prod_valid = true;
+	}
+}
+
+void mlx5e_rx_offload_clear_napi(struct mlx5e_priv *priv)
+{
+	struct knod_dev *knodev = priv->knodev;
+	int i;
+
+	if (!knodev)
+		return;
+
+	for (i = 0; i < KNOD_SPSC_MAX; i++)
+		WRITE_ONCE(knodev->wpriv[i].napi, NULL);
+}
+
+void mlx5e_rx_offload_start(struct mlx5e_priv *priv)
+{
+	if (!priv->knodev)
+		return;
+
+	knod_dev_start(priv->knodev);
+}
+
+void mlx5e_rx_offload_stop(struct mlx5e_priv *priv)
+{
+	struct knod_dev *knodev = priv->knodev;
+	int i;
+
+	if (!priv->knodev)
+		return;
+
+	knod_dev_stop(knodev);
+
+	synchronize_net();
+	for (i = 0; i < KNOD_SPSC_MAX; i++) {
+		struct spsc_bd *bd;
+
+		if (i < priv->channels.num) {
+			struct mlx5e_rq *rq = &priv->channels.c[i]->rq;
+
+			mlx5e_knod_spsc_flush(rq);
+			rq->knod_spsc_prod_head = 0;
+			rq->knod_spsc_prod_valid = false;
+		}
+
+		WRITE_ONCE(knodev->wpriv[i].napi, NULL);
+		/*
+		 * RX is quiesced now (worker stopped by knod_dev_stop, NAPI
+		 * drained by synchronize_net).  Return any frames the GPU
+		 * worker did not consume back to the page_pool before the RX
+		 * page_pool is torn down on interface down.
+		 */
+		spsc_rewind(&knodev->wpriv[i].spsc_bds);
+		while (!spsc_pop(&knodev->wpriv[i].spsc_bds, (void **)&bd))
+			page_pool_put_full_netmem(netmem_get_pp(bd->netmem),
+						  bd->netmem, true);
+	}
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
index 3c54f8962664..4de6babdafc5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
@@ -34,6 +34,7 @@
 
 #include <linux/indirect_call_wrapper.h>
 #include <net/xdp_sock.h>
+#include <net/knod.h>
 
 #include "en.h"
 #include "en/txrx.h"
@@ -64,6 +65,8 @@ enum mlx5e_xdp_xmit_mode {
 	 * page. The UMEM Completion Ring producer pointer has to be increased.
 	 */
 	MLX5E_XDP_XMIT_MODE_XSK,
+
+	MLX5E_XDP_XMIT_MODE_OFFLOAD,
 };
 
 /* xmit_mode entry is pushed to the fifo per packet, followed by multiple
@@ -78,6 +81,9 @@ enum mlx5e_xdp_xmit_mode {
  *
  * MLX5E_XDP_XMIT_MODE_XSK:
  *    frame.xsk_meta.
+ *
+ * MLX5E_XDP_XMIT_MODE_OFFLOAD:
+ *    offload.netmem.
  */
 #define MLX5E_XDP_FIFO_ENTRIES2DS_MAX_RATIO 4
 
@@ -93,6 +99,10 @@ union mlx5e_xdp_info {
 		struct page *page;
 	} page;
 	struct xsk_tx_metadata_compl xsk_meta;
+	struct {
+		netmem_ref netmem;
+		struct page_pool *pp;
+	} offload;
 };
 
 struct mlx5e_xsk_param;
@@ -100,14 +110,21 @@ int mlx5e_xdp_max_mtu(struct mlx5e_params *params,
 		      struct mlx5e_rq_opt_param *rqo);
 bool mlx5e_xdp_handle(struct mlx5e_rq *rq,
 		      struct bpf_prog *prog, struct mlx5e_xdp_buff *mlctx);
+int mlx5e_rx_offload_act_handler(struct mlx5e_rq *rq, bool flush, int budget);
+void mlx5e_knod_spsc_flush(struct mlx5e_rq *rq);
 void mlx5e_xdp_mpwqe_complete(struct mlx5e_xdpsq *sq);
 bool mlx5e_poll_xdpsq_cq(struct mlx5e_cq *cq);
 void mlx5e_free_xdpsq_descs(struct mlx5e_xdpsq *sq);
 void mlx5e_set_xmit_fp(struct mlx5e_xdpsq *sq, bool is_mpw);
+int mlx5e_knod_init(struct mlx5e_priv *priv);
+void mlx5e_knod_uninit(struct mlx5e_priv *priv);
 void mlx5e_xdp_rx_poll_complete(struct mlx5e_rq *rq);
 int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 		   u32 flags);
-
+void mlx5e_rx_offload_start(struct mlx5e_priv *priv);
+void mlx5e_rx_offload_stop(struct mlx5e_priv *priv);
+void mlx5e_rx_offload_set_napi(struct mlx5e_priv *priv);
+void mlx5e_rx_offload_clear_napi(struct mlx5e_priv *priv);
 extern const struct xdp_metadata_ops mlx5e_xdp_metadata_ops;
 extern const struct xsk_tx_metadata_ops mlx5e_xsk_tx_metadata_ops;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index aa8610cedaa8..cfc6ba6dc492 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -918,6 +918,7 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 	pool_size = 1 << params->log_rq_mtu_frames;
 
 	rq->mkey_be = cpu_to_be32(mdev->mlx5e_res.hw_objs.mkey);
+	rq->knodev = rq->priv->knodev;
 
 	switch (rq->wq_type) {
 	case MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ:
@@ -1022,7 +1023,7 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		pp_params.queue_idx = rq->ix;
 
 		/* Shampo header data split allow for unreadable netmem */
-		if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
+		if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state) || rq->knodev)
 			pp_params.flags |= PP_FLAG_ALLOW_UNREADABLE_NETMEM;
 
 		/* page_pool can be used even when there is no rq->xdp_prog,
@@ -2873,7 +2874,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	c->netdev   = priv->netdev;
 	c->mkey_be  = cpu_to_be32(mdev->mlx5e_res.hw_objs.mkey);
 	c->num_tc   = mlx5e_get_dcb_num_tc(params);
-	c->xdp      = !!params->xdp_prog;
+	c->xdp      = !!params->xdp_prog || !!priv->knodev;
 	c->stats    = &priv->channel_stats[ix]->ch;
 	c->aff_mask = irq_get_effective_affinity_mask(irq);
 	c->lag_port = mlx5e_enumerate_lag_port(mdev, ix);
@@ -3365,6 +3366,8 @@ void mlx5e_activate_priv_channels(struct mlx5e_priv *priv)
 
 	if (priv->rx_res)
 		mlx5e_rx_res_channels_activate(priv->rx_res, &priv->channels);
+
+	mlx5e_rx_offload_set_napi(priv);
 }
 
 static void mlx5e_cancel_tx_timeout_work(struct mlx5e_priv *priv)
@@ -3376,6 +3379,8 @@ static void mlx5e_cancel_tx_timeout_work(struct mlx5e_priv *priv)
 
 void mlx5e_deactivate_priv_channels(struct mlx5e_priv *priv)
 {
+	mlx5e_rx_offload_clear_napi(priv);
+
 	if (priv->rx_res)
 		mlx5e_rx_res_channels_deactivate(priv->rx_res);
 
@@ -3592,6 +3597,7 @@ int mlx5e_open(struct net_device *netdev)
 		mlx5e_modify_admin_state(priv->mdev, MLX5_PORT_UP);
 	mutex_unlock(&priv->state_lock);
 
+	mlx5e_rx_offload_start(priv);
 	return err;
 }
 
@@ -3623,6 +3629,7 @@ int mlx5e_close(struct net_device *netdev)
 	if (!netif_device_present(netdev))
 		return -ENODEV;
 
+	mlx5e_rx_offload_stop(priv);
 	mutex_lock(&priv->state_lock);
 	mlx5e_modify_admin_state(priv->mdev, MLX5_PORT_DOWN);
 	err = mlx5e_close_locked(netdev);
@@ -4475,7 +4482,7 @@ void mlx5e_set_xdp_feature(struct mlx5e_priv *priv)
 	    params->packet_merge.type == MLX5E_PACKET_MERGE_NONE)
 		val = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 		      NETDEV_XDP_ACT_XSK_ZEROCOPY |
-		      NETDEV_XDP_ACT_RX_SG;
+		      NETDEV_XDP_ACT_RX_SG | NETDEV_XDP_ACT_HW_OFFLOAD;
 
 	if (netdev->netdev_ops->ndo_xdp_xmit && params->xdp_prog)
 		val |= NETDEV_XDP_ACT_NDO_XMIT |
@@ -4738,6 +4745,14 @@ int mlx5e_change_mtu(struct net_device *netdev, int new_mtu,
 		goto out;
 	}
 
+	if (priv->knodev && new_mtu > mlx5e_xdp_max_mtu(&new_params, NULL)) {
+		netdev_warn(netdev,
+			    "MTU %d too big for single-page RX offload (max %d)\n",
+			    new_mtu, mlx5e_xdp_max_mtu(&new_params, NULL));
+		err = -EINVAL;
+		goto out;
+	}
+
 	if (priv->xsk.refcnt &&
 	    !mlx5e_xsk_validate_mtu(netdev, &priv->channels,
 				    &new_params, priv->mdev)) {
@@ -5261,15 +5276,30 @@ static int mlx5e_xdp_set(struct net_device *netdev, struct bpf_prog *prog)
 
 static int mlx5e_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 {
+	struct mlx5e_priv *priv = netdev_priv(dev);
+	struct knod_dev *knodev = priv->knodev;
+	int rc;
+
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
 		return mlx5e_xdp_set(dev, xdp->prog);
 	case XDP_SETUP_XSK_POOL:
 		return mlx5e_xsk_setup_pool(dev, xdp->xsk.pool,
 					    xdp->xsk.queue_id);
+	case XDP_SETUP_PROG_HW:
+	case BPF_OFFLOAD_MAP_ALLOC:
+	case BPF_OFFLOAD_MAP_FREE:
+		if (!knodev)
+			return -EOPNOTSUPP;
+
+		rc = knod_dev_xdp_install(knodev, xdp);
+		break;
+
 	default:
 		return -EINVAL;
 	}
+
+	return rc;
 }
 
 #ifdef CONFIG_MLX5_ESWITCH
@@ -6931,6 +6961,7 @@ static int _mlx5e_probe(struct auxiliary_device *adev)
 	mlx5e_dcbnl_init_app(priv);
 	mlx5_core_uplink_netdev_set(mdev, netdev);
 	mlx5e_params_print_info(mdev, &priv->channels.params);
+	mlx5e_knod_init(priv);
 	return 0;
 
 err_resume:
@@ -6982,6 +7013,7 @@ static void _mlx5e_remove(struct auxiliary_device *adev)
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	struct mlx5_core_dev *mdev = edev->mdev;
 
+	mlx5e_knod_uninit(priv);
 	mlx5_eswitch_safe_aux_devs_remove(mdev);
 	mlx5_core_uplink_netdev_set(mdev, NULL);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 6fbc0441c4b8..ff4627a0895c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -276,15 +276,20 @@ static int mlx5e_page_alloc_fragmented(struct page_pool *pp,
 				       struct mlx5e_frag_page *frag_page)
 {
 	netmem_ref netmem = page_pool_dev_alloc_netmems(pp);
+	u32 page_idx = 0;
 
 	if (unlikely(!netmem))
 		return -ENOMEM;
 
 	page_pool_fragment_netmem(netmem, MLX5E_PAGECNT_BIAS_MAX);
+	if (netmem_is_net_iov(netmem))
+		page_idx = net_iov_binding_idx(netmem_to_net_iov(netmem));
 
 	*frag_page = (struct mlx5e_frag_page) {
-		.netmem	= netmem,
-		.frags	= 0,
+		.netmem		= netmem,
+		.pp		= pp,
+		.page_idx	= page_idx,
+		.frags		= 0,
 	};
 
 	return 0;
@@ -1572,19 +1577,92 @@ static void mlx5e_fill_mxbuf(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe,
 	mxbuf->rq = rq;
 }
 
+static inline int mlx5e_knod_spsc_produce_defer(struct mlx5e_rq *rq,
+						struct knod_work_priv *wpriv,
+						struct spsc_bd **bd)
+{
+	struct spsc_ring *r = &wpriv->spsc_bds;
+	unsigned int head;
+	unsigned int tail;
+
+	if (unlikely(!rq->knod_spsc_prod_valid)) {
+		rq->knod_spsc_prod_head = READ_ONCE(r->head);
+		rq->knod_spsc_prod_valid = true;
+	}
+
+	head = rq->knod_spsc_prod_head;
+	/* acquire tail to observe the slots the GPU worker has released */
+	tail = smp_load_acquire(&r->tail);
+	if (unlikely(head - tail > r->mask))
+		return -ENOSPC;
+
+	*bd = r->slots[head & r->mask];
+	rq->knod_spsc_prod_head = head + 1;
+
+	return 0;
+}
+
+void mlx5e_knod_spsc_flush(struct mlx5e_rq *rq)
+{
+	struct knod_work_priv *wpriv;
+	struct spsc_ring *r;
+	unsigned int head;
+
+	if (unlikely(!rq->knodev || !rq->knod_spsc_prod_valid))
+		return;
+
+	wpriv = &rq->knodev->wpriv[rq->ix];
+	r = &wpriv->spsc_bds;
+	head = rq->knod_spsc_prod_head;
+	if (head == READ_ONCE(r->head))
+		return;
+
+	/* drain WC descriptor stores before publishing the new head */
+	wmb();
+	/* release: publish the produced descriptors to the GPU worker */
+	smp_store_release(&r->head, head);
+}
+
 static struct sk_buff *
 mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
 			  struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
 {
 	struct mlx5e_frag_page *frag_page = wi->frag_page;
 	u16 rx_headroom = rq->buff.headroom;
+	struct knod_work_priv *wpriv;
 	struct bpf_prog *prog;
 	struct sk_buff *skb;
+	struct spsc_bd *bd;
 	u32 metasize = 0;
 	void *va, *data;
 	dma_addr_t addr;
 	u32 frag_size;
 
+	if (likely(rq->knodev)) {
+		wpriv = &rq->knodev->wpriv[rq->ix];
+		if (unlikely(mlx5e_knod_spsc_produce_defer(rq, wpriv, &bd))) {
+			mlx5e_knod_spsc_flush(rq);
+			mlx5e_rx_offload_act_handler(rq, false, INT_MAX);
+			if (mlx5e_knod_spsc_produce_defer(rq, wpriv, &bd)) {
+				rq->stats->buff_alloc_err++;
+				return NULL;
+			}
+		}
+
+		bd->netmem = frag_page->netmem;
+		bd->pp = frag_page->pp;
+		bd->len = cqe_bcnt;
+		bd->off = wi->offset + rx_headroom;
+		bd->page_idx = frag_page->page_idx;
+		frag_page->frags++;
+		rq->stats->packets++;
+		rq->stats->bytes += cqe_bcnt;
+		pr_debug("mlx5_nod: spsc produce q=%d len=%u\n",
+			 rq->ix, cqe_bcnt);
+
+		return NULL;
+	}
+
 	va             = netmem_address(frag_page->netmem) + wi->offset;
 	data           = va + rx_headroom;
 	frag_size      = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
@@ -2101,8 +2179,10 @@ mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 {
 	struct mlx5e_frag_page *frag_page = &wi->alloc_units.frag_pages[page_idx];
 	u16 rx_headroom = rq->buff.headroom;
+	struct knod_work_priv *wpriv;
 	struct bpf_prog *prog;
 	struct sk_buff *skb;
+	struct spsc_bd *bd;
 	u32 metasize = 0;
 	void *va, *data;
 	dma_addr_t addr;
@@ -2114,6 +2194,29 @@ mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 		return NULL;
 	}
 
+	if (likely(rq->knodev)) {
+		wpriv = &rq->knodev->wpriv[rq->ix];
+		if (unlikely(mlx5e_knod_spsc_produce_defer(rq, wpriv, &bd))) {
+			mlx5e_knod_spsc_flush(rq);
+			mlx5e_rx_offload_act_handler(rq, false, INT_MAX);
+			if (mlx5e_knod_spsc_produce_defer(rq, wpriv, &bd)) {
+				rq->stats->buff_alloc_err++;
+				return NULL;
+			}
+		}
+
+		bd->netmem = frag_page->netmem;
+		bd->pp = frag_page->pp;
+		bd->len = cqe_bcnt;
+		bd->off = head_offset + rx_headroom;
+		bd->page_idx = frag_page->page_idx;
+		frag_page->frags++;
+		rq->stats->packets++;
+		rq->stats->bytes += cqe_bcnt;
+
+		return NULL;
+	}
+
 	va             = netmem_address(frag_page->netmem) + head_offset;
 	data           = va + rx_headroom;
 	frag_size      = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index 185105606469..10c2ffd93dab 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -177,6 +177,51 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 	if (likely(budget - work_done))
 		work_done += mlx5e_poll_rx_cq(&rq->cq, budget - work_done);
 
+	if (likely(rq->knodev))
+		mlx5e_knod_spsc_flush(rq);
+
+	/* KNOD release can process thousands of completed verdicts and enqueue
+	 * XDP_TX MPWQEs. Refill RX WQEs first so the NIC is not left waiting
+	 * for descriptors while the release side drains. The normal post below
+	 * stays in place to publish pages recycled by this release pass.
+	 */
+	if (likely(rq->knodev))
+		busy |= INDIRECT_CALL_2(rq->post_wqes,
+					mlx5e_post_rx_mpwqes,
+					mlx5e_post_rx_wqes,
+					rq);
+
+	/* Drain SPSC bd ring + IPsec desc_ring unconditionally.
+	 * napi_schedule from the GPU finish_worker may wake us with
+	 * zero new CQEs, so act_handler (called per-CQE inside
+	 * poll_rx_cq) won't run.  Without this top-level call,
+	 * PASS/DROP-stamped bds are never recycled after traffic stops
+	 * and the SPSC ring fills up.
+	 */
+	if (likely(rq->knodev)) {
+		struct knod_work_priv *wpriv = &rq->knodev->wpriv[rq->ix];
+		struct napi_struct *napi;
+
+		work_done += mlx5e_rx_offload_act_handler(rq, true,
+							  budget - work_done);
+
+		/* KNOD direct XDP_TX keeps the RX netmem owned by the TX SQ
+		 * until the NIC reports TX completion.  The normal NAPI order
+		 * polls the XDP SQ before RX CQ processing, then the KNOD
+		 * release pass can enqueue and doorbell a large burst of
+		 * MPWQEs.  Poll once more here so completions that arrived
+		 * during RX/release processing are visible before the final
+		 * RX repost below.
+		 */
+		if (rq->xdpsq)
+			busy |= mlx5e_poll_xdpsq_cq(&rq->xdpsq->cq);
+
+		napi = READ_ONCE(wpriv->napi);
+		if (napi)
+			knod_dev_xdp_drain_pass(rq->knodev, napi, rq->ix,
+						budget);
+	}
+
 	busy |= work_done == budget;
 
 	mlx5e_poll_ico_cq(&c->icosq.cq);
-- 
2.43.0

