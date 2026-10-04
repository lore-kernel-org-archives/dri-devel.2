Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACCECA5FEC
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 20:48:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BFD110E0EB;
	Sun,  4 Oct 2026 20:48:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="II7G6E+U";
	dkim-atps=neutral
Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A07C10E0EB
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 20:48:54 +0000 (UTC)
Received: by mail-oo2-f2.google.com with SMTP id
 46e09a7af769-824fdec5521so874313a34.0
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 13:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791146933; x=1791751733; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=64dx1BbNweAnxiSqrDwTCBobsnxCeoMwaSiq5ZXWTOc=;
 b=II7G6E+UOzl9FIkRTEtyvCT2EadafbTCKXtcXhF3BOVaZt/f8NYZeX1P2MZ4rLU9l5
 PH+DslGlzMh6m1Be25f92yV1XuvgQeKxxKNJw4YHuH904pcWdb4EjnWhuItfbd1l/xuk
 b7tpZ10YeVNXt3rUlQ9BzcEU/lJeEA4FwfaOtIZTmn0gcx3UkSSM73WK5THKdr/Kj3Nv
 BhuF7tkf/31PBsfpHPDCE9qG6spqzOOSPMR/wzVSQ9r0RSVn5imDRiyGyIL392P1HxtK
 R46ZyB4nuT5fvJsUk/0wHC/yBGPq/IphQWQnr3j5EBJA+O0zFVmMuGbbsSP1BjFn5h9w
 Nk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791146933; x=1791751733;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=64dx1BbNweAnxiSqrDwTCBobsnxCeoMwaSiq5ZXWTOc=;
 b=2j/Erlc92t79B68TvnXre4adaqC4ZinStyxZTD1ZjBscftU9u8sZTfVDA2bre6zc9b
 g6qOs41iDnqDHIFUo9KscfU65WfRNjtw9ePnUFvv3s2IADMY5VhQjOnIAnPtoRyclNpo
 71qE02z1ZuJgZVhMZUkotp1HhJWFwHsNbcIVEWLC058J4h9ZycxrfIHlq8Xpj4yYV56S
 eC22v0A0SWhm8BS/hPytvjihS71k/XTtHoOGi+k3z0azpb80snqD0J7yikMLIbceproT
 EuOIEH0kB2U8FyP9+ejJTJnQ49ylu+clsat7XDRLbHopZbnbxsKe9PITS2gT3dv9eL5e
 t2ZA==
X-Gm-Message-State: AFuF++mqpOM/7QU3RM9CgvzyeK4O5DJZFTRLESeHybYL9UuQUd+gcExJ
 e2G9IiKiiVc2n6LKvf/jpLwJaemiGi74gOlj9tCVKxh4/P7jyBqPlVw5
X-Gm-Gg: AYBFou3a946TeDP6t5KhK/OWprkDpUbf/MZI/PseEQPNVOjdO4lTWgdGRD60RXUSKUa
 sBnS6UjcPmxYHX2fvhN3mwwZL/oTY33URgHt2XNQvsEpzSEw9dxwgxcnw8CDQZtfUZwAZPluQJX
 kirhHkNpcc/8Pa0bE42kng2NoX1m/sGfGhKNSjonom5Tq/4bytKxNazsYSF3nqfPUtK55HPtvuk
 EnBBHo7s0e4p+gd+3aUCQH+22iUx2KxUq4ME9dKb+yeJ/bXw4+k6TMe5rB2TOlubS3WQMdcrnyo
 avLJucMk+6CA0PBF/7sEcGpwn0P+v+g482qpl30GRGwGMn5/oDs2MhZJX16QA3j3L4SwcRxmLqR
 pDhMlgAujYbUs/d+wPhKWcBfrBYrEIVDygtDZj/R8uGMqUlhh8dFNO4/kjpV89ZtoHe9vzt4Xdk
 Qw09NOfvuPdsegFkRAySpHce9YfiMqy0emAupshA3aWbbG2fbuhRhhy+BeVGJ5KB/GEmVMPKQw9
 qb2
X-Received: by 2002:a05:6820:8cc:b0:6dd:5f11:2772 with SMTP id
 006d021491bc7-6e09eb5bb95mr4694735eaf.67.1791146933277; 
 Sun, 04 Oct 2026 13:48:53 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::2620])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6df3bb8ed63sm7997183eaf.15.2026.10.04.13.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 13:48:52 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Sun, 04 Oct 2026 15:48:44 -0500
Subject: [PATCH RESEND] drm/mediatek: dsi: force command mode in
 mtk_dsi_poweron()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-rbrue-suez-upstreaming-mtk-dsi-cmd-mode-v1-1-53a4f46ca489@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791146930; l=2760;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=OcJVs5yn0YnQaQ4cSxKF5bO4C3o583LMnGdciACqpJE=;
 b=1l4cNu6iSTNSIv+NG3qt0kh7o+fG3x0bWp03ylDgdgiAL0DWdqVdOTa9xSzUY40MnsckbQ/8g
 XtXLdSNzganBnvGGX4IVpkwFUR+rd0uh9jLeNxs4jVcDEwbAksd83xb
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
-- 
Ryan Brue <ryanbrue.dev@gmail.com>

