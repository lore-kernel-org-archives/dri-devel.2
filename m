Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71911CA9EDD
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E461B10E4E9;
	Mon, 12 Oct 2026 07:32:02 +0000 (UTC)
Received: from mail-qk2-f6.google.com (mail-qk2-f6.google.com [74.125.230.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FF3D10E0CD
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 00:43:07 +0000 (UTC)
Received: by mail-qk2-f6.google.com with SMTP id
 af79cd13be357-93bfb25817cso77594185a.0
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 17:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791679386; x=1792284186; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wKMM/5NJTGuE+7PUxcL8x7aaEFcwMXWe96PcY9zklq0=;
 b=DhRkrheVeIWSNaXr7z/QAP80wP1YgMRZBQYX0c2WDqbufrql/U18Q+BinH4dICZNoi
 4iLcSwm3oXW3+EJOFAYFhuRQESTFSRIuSUOeFhCJGx6YOhN293+It08YY0NUOp+bUCsN
 w8CICm3JUDTY4HdHSBAresrQpqJn5A4aikylxF/68wd/OTZer08ZFXYgm2F3x4fzSXTR
 Vt4rjRgc9FeuaG9YyRxZZ9vkNjcE9SeRblFkZGelVCb4BRkNjvcr4bXHbpoziBeuYDp0
 Wk5CnMIyIovPhoHnaQ5uSCynzbK3duqkqGZhm32nb2PN48NEw7OYYjpBBquOqdacxIMa
 lZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791679386; x=1792284186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wKMM/5NJTGuE+7PUxcL8x7aaEFcwMXWe96PcY9zklq0=;
 b=rAm0y3NgsPgu2XSnpgZj3bsQRcuAEwIW3GNObKWpQS0TG7vAdxnXovjRc0kgPicRbC
 6uby3wrOFQAtBVIS8uNf6TuGRTFJ6NoxeatoAPgeneRt9ixTPy2JEK0L4KTA1493VJlz
 0AEK36N7mrzR1+reywjQCQ6PJzn4SvpDHO9HnAddG5jEADPJsub9C2tDDd5COMqeyROR
 lWWqkYrgp8A2N3sKJES4eyPehvPrm1y6+ld7L0k6Npb1014yHWLGfx2ziyMwg1U97A6k
 Cx84pARFI4ECWMi7WXG3M8PBihlvGjW3IRAjRflhb0+2QZtYkCRNaBHirsWXIx3rQlPQ
 NJoA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPrDUUjqp90+pr6vaZRH9VOweUB7Ww/LJhsj+NtScQJQEjKVNIihXG0LPa7epuRG5GxZAt8vI5sYo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIijVQ6f1f1OUzJgbK1HV1gw40uDaDg82cy/82IetNwkSaupDsz
 fWZke7SQfeXzDh2MRMMpp49ukMSO/t6jsJ3vVPhSshhmPQdZDATJD6UZ
X-Gm-Gg: AYBFou0SqVd5CUf657XBF4zgXiKcWRQNjkFXJdwPGtt1YzkgF8KxMEq2+o33E8hbUSp
 MrS+wbGFDqh2c5hrFa1zDDR8GJz3oumHcY+p9PnAFuzQnqJXRk3TEOvo3tx7snzuxDJXqzXiPOd
 rqN3ihvyIg6d4zVi8dZ2GBI+q+iOA8dF0AjT3RdlkxsBgTTmyoTkLBlgqTUoJQJetOSpI9NyCye
 d8T6BMp3LjtnVqO74Bgcn+6GsA4xAQ78qQVLU0ZoeJwGRd8U9pf2lBxopju2PRiyOx0FyeciHU2
 HsF4plBI3HkqZMX0hy97GM+lsHEWWFCxaOdZI+TqgZIrL6A8aCP9qs2slT/ZxF2jz2JbVqp24Zm
 WIfcYSqn1KwQHYV1wxiwa1WbVxRUjRC+aIUsYANNjtL+XD5AyX2Al9vuIzdVbTkG1QhonSbwZTz
 GsiQLxLqGV9y1/XAN/R1Di4rcurxLuMnoX2wd2uIob2pimKmCZE7YkGK0dK7NztTH+rxM=
X-Received: by 2002:a05:620a:3187:b0:93e:c12c:9b73 with SMTP id
 af79cd13be357-93ec12c9f14mr906360385a.78.1791679386387; 
 Sat, 10 Oct 2026 17:43:06 -0700 (PDT)
Received: from omarchy ([2601:804:8780:3df1:6ff:277e:31c7:ac13])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93eb9848702sm532320085a.12.2026.10.10.17.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 17:43:05 -0700 (PDT)
From: zoan37 <agentzoan@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jason-JH Lin <jason-jh.lin@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
 Nancy Lin <nancy.lin@mediatek.com>, Nathan Lu <nathan.lu@mediatek.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm/mediatek: mtk_crtc: Pick the connector route on every
 CRTC enable
Date: Sat, 10 Oct 2026 20:42:48 -0400
Message-ID: <20261011004248.1117649-4-agentzoan@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261011004248.1117649-1-agentzoan@gmail.com>
References: <20261011004248.1117649-1-agentzoan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 07:32:01 +0000
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

mtk_crtc_update_output() only picks the output component of a CRTC
with connector routes when connectors_changed is set in the commit that
enables the CRTC. But connectors_changed only says that the connectors
changed in that commit, not since the CRTC was last enabled. A connector
can be attached to (or moved to) the CRTC while it is inactive, and the
later commit that only sets ACTIVE then has active_changed but not
connectors_changed:

- If the CRTC had never been enabled, the route slot is still NULL and
  mtk_crtc_ddp_hw_init() dereferences it (mtk_ddp_comp_clk_enable()
  and so on).
- If the CRTC was driven through another route before, e.g. a CRTC
  shared by an HDMI bridge on DSI and a DisplayPort output that is
  switched off (DPMS) while the monitor moves from one to the other,
  the pipeline is set up for the old output.

update_output() only runs from atomic_enable and the lookup is a short
loop over the routes, so do it on every enable.

Fixes: 01389b324c97 ("drm/mediatek: Add connector dynamic selection capability")
Assisted-by: LLM
Signed-off-by: zoan37 <agentzoan@gmail.com>
---

Notes:
    Testing: found by reading the code. The same change runs on the MT8189
    Chromebook described in patch 1, where one routed CRTC drives either
    HDMI or USB-C DisplayPort: DPMS off/on and suspend/resume with a DP
    monitor attached come back. The sequence that fails without it
    (connector attached or swapped while the CRTC is inactive, then only
    ACTIVE set) was not reproduced on purpose. Compile-tested (W=1) on
    next-20261008.

 drivers/gpu/drm/mediatek/mtk_crtc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index 704931b369b6..0bfd17f68282 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -695,9 +695,6 @@ static void mtk_crtc_update_output(struct drm_crtc *crtc,
 	struct mtk_drm_private *priv;
 	unsigned int encoder_mask = crtc_state->encoder_mask;
 
-	if (!crtc_state->connectors_changed)
-		return;
-
 	if (!mtk_crtc->num_conn_routes)
 		return;
 
-- 
2.43.0

