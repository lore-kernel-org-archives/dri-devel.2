Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E70F60A3808
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hymn3Cxg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8F8610E27F;
	Tue, 10 Nov 2026 07:18:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27C8410E27F
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 07:18:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D657240254;
 Tue, 10 Nov 2026 07:18:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794295130;
 b=v0oEZ35RpOv97k9P285puHgtCS82qPyh1mOdPrQ/OVq+IKoVgWrDM4XohkzN3RnS1sbU
 Lg0JKycLOj1XmMsWPDJPsrgWOQccyKAnNLaX1dGuSGesAan9HDpbg0uQwuwxvS1LZG6rS
 24VrAOsFaIr/qnLvLj3xVLdHgLsLlK0EPMs7NKoV2vshXbVA2DH4U4iodmfVr9TKDEbWD
 wfYJ22+5FYJD3F5weoH6omL2xaC0GGLEY6XykZzOTGjcDprOA/wtCKL4il0t+cOpVUQZ7
 sAM8tqOHeXBUmOEy+XZdX02YbmNNfEeUDVUwchPIdBMMubBM0HDS7BUIbk7zwj5rnWA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794295130;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=crOJU4pdEXVtB/xKliMoCnEF/sNVuIBkiEtqGXLglJY=;
 b=nsEEasZwzh90FPeahS9DZqAN0keOnCOI0m9FrdhUEOoPBTkGIntnBr33tKx4HG27E4g8
 Ws3TyYP3z9uHeddSFSbJaplZDqpgK3OljiFAx6jPoOfXzSnEiESeDTKHttOFilvQhU+BG
 iqBm+/cC1SrgR1IOS/C4cq9UWq9hb8tIhdkELH98J1R07by94uxjKuKcCLRmO1XGRLzHX
 B9XbTINQpmLU5m5JpDzKv0bvQXYadSnGCDrE67F7NFampQnQUXcvO7L5mhanPlNlVNzDj
 giA1JsoHLptgWW7qKETsnCtkWU2O1V9d+AHMa3Off9Cm6T+SMQ6bSC2GG4QZ18gHt7A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 195E21F008A1;
 Tue, 10 Nov 2026 07:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794295130;
 bh=crOJU4pdEXVtB/xKliMoCnEF/sNVuIBkiEtqGXLglJY=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=Hymn3CxglOh+soxIByL21vjqRw27KsQQfL1W6OC+cCup9nBUcYOMD+mPCLVQCiY1G
 WQywsHM/QLfCtSP4qIWCO1XOOdMByGA2IHEKdxhsR0ELm7lWD2d5lE2oA+HQjHv5c2
 tSbcL6L97Gicz2ZouzwiDO64NF5PG8wIOfw6jc106rXXQ6cZDEzgHIis2o8+iCus5R
 k4r/Gq/sDgLLobSI5O7tX1Khhu8KWv89JnXREo0ZPKtovd8G1/u4Z+3MeetlbxsxZ6
 cbtHvcKbw10wv1VaDk3+ytPo2Y/cau5VzOueQEPiSMVY9VmsIezj3n7foO5rOKxYtB
 +xezEoHKhGdEQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id A189F4896C;
 Tue, 10 Nov 2026 07:18:49 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH 0/8] drm/rockchip: vop2: RK3588 clocking, sync polarity,
 AXI port and window fixes
Date: Tue, 10 Nov 2026 07:18:48 +0000
Message-Id: <20261110-vop2-fixes-v1-0-d336e9dd90d3@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSw5AMBAG4KvIrDUxjUe4ilhQU8YC6dBIGndXL
 L/8jwBCjkmgSQI48iy8rRGYJmDmfp1I8RgNOtMlImbKb7tWli8SZfu8wFxXdW0Q4mB39AWx33a
 /5RwWMsf7APf9AJQbo+1uAAAA
X-Change-ID: 20261110-vop2-fixes-fa45142799c1
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794295129; l=4031;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=fo7rQJTAOXCeB/21ZdTRGQqHaTQfZ2L5wF/0HI3nMtM=;
 b=r9LUei76hUrXdgmi2KacbwxDOIS0mEAd6hhWFCzVEP8Kf+EaRuAqe+KnA0v7jAtuB075BZ9b/
 cS5y2FN73XiBanfNEpqhxB3lgYYK8/uGBsuHj824b0xFBnb7nvKN9/Y
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
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

This series collects fixes for the RK3588 VOP2 found while bringing up
HDMI and DisplayPort output on an Orange Pi 5 (RK3588S).

Patches 1 and 2 fix the RK3588 interface setup: rk3588_calc_cru_cfg()
leaves dividers it does not use uninitialised and the garbage ends up in
VP_CLK_CTRL, and rk3588_get_hdmi_pol() decodes the POLFLAG bits it is
handed as DRM mode flags, so the GRF sync polarity bits are wrong for
most modes.

Patch 3 stops the RK3588 Cluster windows from advertising AFBC with the
lossless colour transform (YTR) for RGB565/BGR565, which the decoder
cannot display (black picture plus POST_BUF_EMPTY).

Patches 4 and 5 deal with POST_BUF_EMPTY underflows. The VOP2 fetches
through two AXI read ports but the port of each window is fixed in the
window table, so the usual primary plane plus overlay configuration of
a video port puts both layers on one port while the other sits idle.
One port cannot sustain two full screen 4K@120Hz layers (measured: the
fetch rate collapses from ~6 GB/s to ~3 GB/s and about half of all
lines underflow). Patch 4 assigns the port when a window starts
fetching, balancing the estimated load; patch 5 rate-limits the
POST_BUF_EMPTY interrupt to once per frame, since an underflowing port
otherwise keeps the CPU in the interrupt handler 50000 to 300000 times
per second.

Patches 6 to 8 are smaller fixes: the start mixer search skipped
Esmart3 (for_each_set_bit() was given the highest window id as the bit
count), a gamma LUT update cleared the other fields of LUT_PORT_SEL
(the VP0/VP2 dclk source selection and the VP0/VP1 merge enable), and
the AFBC tile count and transform offset were wrong for a source that
starts inside a 16 pixel superblock.

Tested on an Orange Pi 5 (RK3588S) with an HDMI 2.1 TV and a
DisplayPort monitor, pictures judged with a camera. Patches 1 and 2:
VP0_CLK_CTRL reads back without the garbage dclk_out divider, the sync
polarities seen by the HDMI controller (VIDEO_INTERFACE_STATUS0) match
the mode flags for +/+ (1080p, 2160p) and -/- (720x480, 640x480) modes,
and the picture is correct over TMDS and FRL modes from 27 to
1188 MHz. Patch 3: RGB565 is offered on the Cluster windows only
without YTR, and those planes scan out correctly on three Cluster
windows. Patches 4 and 5: 3840x2160@120 with a full screen overlay
(previously ~120000 POST_BUF_EMPTY per second and a scrambled picture)
and a dual-display session (HDMI 4K@60 plus DP 4K@30, two video players,
ten minutes) run with zero underflows. Patches 6 to 8 were found while
driving Esmart3 and partial AFBC overlays: an AFBC overlay placed at
x=1001 shows correctly. All eight have been in the board's kernel for
the display test runs since.

This series was developed with Claude (Anthropic) as a coding assistant:
it wrote the code and the commit messages, and I reviewed and tested
every change as described above.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Arun Iyengar (8):
      drm/rockchip: vop2: Don't use uninitialised dividers on RK3588
      drm/rockchip: vop2: Fix the HDMI sync polarity on RK3588
      drm/rockchip: vop2: Don't accept AFBC YTR for RGB565 on RK3588
      drm/rockchip: vop2: Balance window fetches across both AXI ports on RK3588
      drm/rockchip: vop2: Report POST_BUF_EMPTY at most once per frame
      drm/rockchip: vop2: Find the first mixer of a video port with Esmart3 too
      drm/rockchip: vop2: Keep the other LUT_PORT_SEL fields on gamma LUT updates
      drm/rockchip: vop2: Fix the AFBC offsets of a source that starts inside a superblock

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 186 +++++++++++++++++++++++++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  24 ++++
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c |  27 +++-
 3 files changed, 223 insertions(+), 14 deletions(-)
---
base-commit: 8deaade4a5a4ff635df91e246e42139ab2b33f6d
change-id: 20261110-vop2-fixes-fa45142799c1

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


