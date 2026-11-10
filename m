Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F94606A332
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PtTe5Ofw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 837D710EE2C;
	Tue, 10 Nov 2026 07:19:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5C9A10EE32
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 07:18:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6862C637BD;
 Tue, 10 Nov 2026 07:18:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794295132;
 b=WwBJE39yOIbwof5m/EK7fxafobMf0rmc43vyPRhUWpVAVYAdPUnwrsHgE1pbDo70+4op
 mOWgupaFGaZqR7BNNvFkBBCXHgcVoOeyXPYqc3yDPyZioShUxVcEFRbP0aAh9tUWy43wo
 geSSLd8xADb1/1qg4pm6qe/Kaw1Avj1octQ3nfjr6EJQRjYvCNHrepbV0y5CXlmmJgTXj
 qaFuZ2/ebs03gVt0+bxNDEXIxJ7CuCbCvym8/+/HMswckPoErX80zIBlGQsF972mb5wF1
 nH4elqIe3/GvOiEucQBHUmqiza12QLHzb9ZCKC6lF7QDuZUk0GYIgEN5PqdJ3WrAxfg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794295132;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=dXRtwq3eD/NFK8IgPBhgp/7A0pFkznKtBS+ZOXdYqTg=;
 b=VRKPCv6PikhzStZZf/YpK6sognT8RfFlmyUpmJHiEcseSAYv9AQFt/jaJFuutJZq+StK
 g8Gl1zv8qb20uHfazwIJ0xpxbaQ2H/iibTkPPF5GUjtleuMXaENgP1gLy9qC49rOncwcc
 Ji+X9mUBz2kQUrbrHYgFrn/9hCwMHorMYFYussRireB6dwVXoiDkq1djOQjv18k1h0CGy
 c1hSNYINlLuHmx2ohBdt/Ooc380Fm6JeuCYB9+zUd3Q+ts3+BhNb4oe1kqwQpdjKJ4c0B
 0jBBygBbyNYIvWuCPGxX5y2WE1LiP/YDxYDNv6CeHAduS5ztBSaV4mgAsH2HYxlL7kQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 4C9661F008BF;
 Tue, 10 Nov 2026 07:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794295132;
 bh=dXRtwq3eD/NFK8IgPBhgp/7A0pFkznKtBS+ZOXdYqTg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=PtTe5OfwJoXiCaUY1JsRgUwo9oS8T7WBVd2J9sb110Kpiw314tVAthNwmklfFirMV
 PY0UBXQ8wgyDM337Ryp48vog9V+QXOJARuFdOPdJ4V7MwV9edxLktlzOv2HAHYCLDV
 3tnL7n124V9kUvAPbpwIjx4LJArPkeyNJpHLfOVT+xmFTCAAsecDqMs5DOGaXAiiCb
 irUux6nD7HtUcqT2uaSm1DgWoikl31C1VJo6c2LNhnCqoku7UArHOZRJRrRrUGHVso
 f4ZxJCsBZ8ETxidvmEwbQrnlBfogzk4iEfBHRTgJ2Ya29XrlePI+ZazyoDtxdOyLUO
 SzRNKwI3M58Sw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 1BCAB489C9;
 Tue, 10 Nov 2026 07:18:50 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:18:54 +0000
Subject: [PATCH 6/8] drm/rockchip: vop2: Find the first mixer of a video
 port with Esmart3 too
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-vop2-fixes-v1-6-d336e9dd90d3@gmail.com>
References: <20261110-vop2-fixes-v1-0-d336e9dd90d3@gmail.com>
In-Reply-To: <20261110-vop2-fixes-v1-0-d336e9dd90d3@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794295129; l=1329;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=SPA5csf/bAh0B83cKoZHeqtof5v0uoSMoUIlfdJ5VbM=;
 b=i+wS43YteQlCqC153QQbNpaUW9KYpgHXaMG3J+LGfX0EkNm9iK+dlaut6m4/8oQ3xynCZDNX1
 5gr1Z+2z7P6Cqe7qW/WBCv9w8qWQfP23ve9Xq9XwUN+ZBKtHQ4+U8qk
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

vop2_find_start_mixer_id_for_vp() looks for the first layer that holds a
window of the video port, but for_each_set_bit() takes the number of bits
to search, and ROCKCHIP_VOP2_ESMART3 is the highest window id, so Esmart3
is never found. A video port whose bottom layer shows Esmart3 then starts
its alpha setup at the mixer of a higher layer, or, if Esmart3 is its
only window, past all layers, and programs mixers of other video ports.

Search all window ids.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index 83203d18865b..2843bfb36341 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -1889,7 +1889,7 @@ static int vop2_find_start_mixer_id_for_vp(struct vop2_video_port *vp)
 
 	for (i = 0; i < 31; i += 4) {
 		match = false;
-		for_each_set_bit(phys_id, &win_mask, ROCKCHIP_VOP2_ESMART3) {
+		for_each_set_bit(phys_id, &win_mask, ROCKCHIP_VOP2_ESMART3 + 1) {
 			win = vop2_find_win_by_phys_id(vop2, phys_id);
 			if (win->data->layer_sel_id[vp->id] == ((layer_sel >> i) & 0xf)) {
 				match = true;

-- 
2.55.0


