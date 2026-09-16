Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2C6C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 05:24:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9296B10E217;
	Wed, 16 Sep 2026 05:24:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OhWe9we9";
	dkim-atps=neutral
Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com
 [74.125.231.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DA7F10E036
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 05:24:11 +0000 (UTC)
Received: by mail-oo2-f11.google.com with SMTP id
 46e09a7af769-7f4ddb9adf4so2127393a34.1
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 22:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789536250; x=1790141050; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zSwtxaUSQ7K0oB62qUITKeVKiPbi0vng9/BLzWTtzOE=;
 b=OhWe9we9uAduPuaoDwJmizOLTcULGwO3Z/BnJf2SoxfC+KanxVC2YCcJlOK+NFw9el
 L3DDT5uH6xkQn/8G/u/2He5yjCwKdSe5CCLV7dORUyXIYTAU8Blh+lI6M1KuTAcs8t1Q
 SHc6o+GA8ibMS9NdOdhmleAutu36aEYDLcIXB2Ajp9H8QfLoZAn0andzitoh9EtEJ18n
 iKTYz4r+iFbM4xHE/Pq1vxRN9222M/utAWJbRP0bkFdFzdB+WY7Tz0PCBMmxfmWP+G2Y
 6Oiw5iA/hpjICgTVs6FamxmPKD9gkWC7x9WMeoPK+hBcxsqAmm++nYu2K3rKaS+QQm/L
 0unA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789536250; x=1790141050;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zSwtxaUSQ7K0oB62qUITKeVKiPbi0vng9/BLzWTtzOE=;
 b=Kt5iHqGyFcYNqXpOSyJQzMkwKj5qPO3Ew5+mw6YSZlbRPADeWeqc/OuOn/1+oV/SBW
 /Zl/hJT8Af205CpLcvYc4DHN2RDARzjds9Isz/2yTh1xl8WkQvLUcSoTjV6aW8S/crm5
 6cjw31Zn+UoJ34rsXyncyHy3Evw9ACsLby6FlPUg+ObnkP4NfUDaCb6fJo1qVpF618vf
 8N7waW4HWBaJJL+9Br/5YSh/5u7ChvigroIDAIb1ivat3PFhw+9WxVkIHWDmRkgXJhPi
 VuSJJy9WLqfvB9hHdeQqyVNDLhWvY8hXrAsqalFinTghSj6WQXNZd3KQTU/o4VUILT1g
 dS+g==
X-Gm-Message-State: AFuF++mcEeJOnq+eEU/v9a3Q6nkQM4qtmn4z2wH6PU7WLtTEekYwxYzy
 vc7WVMOUqzlE3VqZev80mHHsXzp4akq7stMZDMJgzf1w4IiuWZwcCe3d
X-Gm-Gg: AYBFou3VVNn7Uy8rYR1sSqCRERkAmSPtEA5qdhlMCBXUm7IS6T/Zi9JSn8TDqwgzJTG
 p23bHuopV77D0Z9w/iJrsNFlVCxEWAHlgh+ywFr095ckKGMHZCM8Tl0j65yA1H3ZchBNMSVkP2X
 m8DJ1on9yVLdH4DNbTm13wwhwkR3prtGhXTKle2SQRm2M2xy5zs5WjicO6puWSWVBKC/WGvb0JL
 bFerK9Pk3Zjr8Bh7+Gle7AroqlJyXhOQqrNw1ww8m/XN0mwQZhOIGjaFY+RojbjtDavS0zI5QXz
 b0psuoR/Fu3W7tZNp13p7RM7aw0UW3OavoUqCQm8HXe1r9HHgg6R8Vw963czOU9VEllOUq3LDEC
 eGjxGIxXX3JECCBiuBVscxvOnfqR383xnsWkTp1emnd97oU24hrr7hqd4oK8qC0netsNFhpe1b3
 L2g0taiecCPPRZvpNK8BA/hxvMO8a+i81jzbQe02PHbpw2nJlJGS8XT7wgO2QOJ8bsq4A=
X-Received: by 2002:a05:6830:6d2e:b0:80a:45e1:7677 with SMTP id
 46e09a7af769-80b2f3ac500mr1403318a34.23.1789536250381; 
 Tue, 15 Sep 2026 22:24:10 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::b712])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80b07ad0294sm1562819a34.24.2026.09.15.22.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 22:24:09 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Wed, 16 Sep 2026 00:24:00 -0500
Subject: [PATCH] drm/mediatek: dsi: force command mode in mtk_dsi_poweron()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-rbrue-suez-upstreaming-mtk-dsi-cmd-mode-v1-1-b37f167e25cb@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NwQqDMAyA4VeRnBeonYjuVcYO2kQXRqskdoyJ7
 27x+F3+fwdjFTZ4VDsof8VkSQX1rYLwHtLMKFQM3vnW9XWLOmpmtMx/zKttykOUNGPcPkgmGCJ
 hXIiRunsTnO+nZuyg1FblSX7X6fk6jhM0/FZ9eQAAAA==
X-Change-ID: 20260916-rbrue-suez-upstreaming-mtk-dsi-cmd-mode-d834c029f4b8
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789536248; l=2721;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=hpjXRGa4viZcbFnNO5KBT0ICAECMSKtgFaKjk3ZUers=;
 b=YGYtnMBV27PnM1edrgMETUOi3yg7VZTGrzPFHJou4Uz1zxAGKN1TiUeZkDDsyt2+fjf5MWWPb
 W6IpgB8c/lLB0mGPpb7e2KK71MSkVE3pVyuDUNsENUDYOqVIuiy9cDh
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=
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

mtk_dsi_reset_engine() does not touch DSI_MODE_CTRL, so whatever the
bootloader left there survives power-on. On boards where the bootloader
lights the panel for a boot logo and hands the DSI over still running, the
leftover value is a video mode, and the first mtk_dsi_host_transfer() then
takes the "already streaming" path: it stops the stream and waits for
VM_DONE, which never arrives, because the engine reset has already stopped
the stream. The panel's very first command fails and it is never
initialised:

  [drm] Wait DSI IRQ(0x00000008) Timeout
  *ERROR* failed to switch cmd mode
  sending dcs data 8f a5 failed: -62

Set command mode right after the engine reset, so DSI_MODE_CTRL describes
the state the reset leaves the engine in. The video mode is programmed by
mtk_dsi_set_mode() when the stream is actually started, exactly as today.

Seen on the Amazon Fire HD 10 (2017), whose LK bootloader draws its logo
over DSI in video mode and never stops the stream before jumping to the
kernel.

Assisted-by: LLM
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
The board this was found on, an Amazon Fire HD 10 (2017), is not upstream
yet, so no in-tree board regresses without this. It is a state-consistency
fix either way: mtk_dsi_reset_engine() stops the stream but leaves
DSI_MODE_CTRL still describing the mode the bootloader was driving, and
nothing writes that register again until mtk_dsi_set_mode() at stream start.

This touches the same lines as "drm/mediatek: mtk_dsi: Transfer register
offsets to per-SoC const" from the MT8196 series; I will rebase on top of
that if it lands first.
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 7961139333ad..4cb486f54653 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -737,6 +737,15 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 		       dsi->regs + dsi->driver_data->reg_shadow_dbg_off);
 
 	mtk_dsi_reset_engine(dsi);
+
+	/*
+	 * mtk_dsi_reset_engine() leaves DSI_MODE_CTRL alone, so a video mode
+	 * left there by a bootloader that handed the panel over still running
+	 * would make the first command wait for a VM_DONE that never arrives.
+	 * mtk_dsi_set_mode() programs the real mode when the stream starts.
+	 */
+	mtk_dsi_set_cmd_mode(dsi);
+
 	mtk_dsi_phy_timconfig(dsi);
 
 	mtk_dsi_ps_control(dsi, true);

---
base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
change-id: 20260916-rbrue-suez-upstreaming-mtk-dsi-cmd-mode-d834c029f4b8

Best regards,
--  
Ryan Brue <ryanbrue.dev@gmail.com>

