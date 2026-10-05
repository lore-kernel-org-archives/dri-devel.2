Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0615CA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 07:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E4CE10E309;
	Tue,  6 Oct 2026 07:24:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=laposte.net header.i=@laposte.net header.b="TGt1G7dV";
	dkim-atps=neutral
Received: from smtp-outgoing-1601.laposte.net (smtp-outgoing-1601.laposte.net
 [160.92.124.96])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11F1910ED90
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 15:14:57 +0000 (UTC)
X-mail-filterd: {"version":"1.9.7","queueID":"4hz0Gr36CGz10MQ4","contextId":
 "7682ca06-10ef-447b-8fae-32f653cfad5e"}
Received: from outgoing-mail.laposte.net (localhost.localdomain [127.0.0.1])
 by mlpnf0120.laposte.net (SMTP Server) with ESMTP id 4hz0Gr36CGz10MQ4;
 Mon,  5 Oct 2026 15:14:44 +0200 (CEST)
X-mail-filterd: {"version":"1.9.7","queueID":"4hz0Gq2zdcz10MQQ","contextId":
 "6d16b087-e524-40b2-9d69-a2b67756ca2c"}
X-lpn-mailing: LEGIT
X-lpn-spamrating: 36
X-lpn-spamlevel: not-spam
Received: from PAR-95296130.bcg.com (unknown [147.161.232.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mlpnf0120.laposte.net (SMTP Server) with ESMTPSA id 4hz0Gq2zdcz10MQQ;
 Mon,  5 Oct 2026 15:14:43 +0200 (CEST)
From: Jean-Francois Bobier <jean-francois.bobier@laposte.net>
To: linux-arm-msm@vger.kernel.org
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Xilin Wu <sophon@radxa.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Saim Shujah <saimzst@gmail.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Jean-Francois Bobier <jean-francois.bobier@laposte.net>
Subject: [PATCH 0/3] drm/msm/dp: fix dead link-training fallback on Type-C
 boards
Date: Mon,  5 Oct 2026 15:14:29 +0200
Message-ID: <20261005131432.22840-1-jean-francois.bobier@laposte.net>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=laposte.net; s=lpn-wlmd;
 t=1791213296; bh=w0JzGI4+Rj0ukqWNo8ylMXQXgrJmTHm7pEq5lr59G9w=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding;
 b=TGt1G7dVJoOkqhwIWEGL3pGQYZPhoUrreHZUZWPdDyNrOtS6vzd/mxmZJGdns55NMjd59npS15e5cifO7tE67iuczbnqxnpN+rOFZ956/GDiNO+kEnF62cuIyUepfbSUqRezH5w5SsqWPKT/e01vBivC/Ok0ukeOZ12LkMzAD6b8BYrr8dElOLOOlaKyERuoP173Oo/nK6GXqbhlnkuXIgFk5uXTNiiUhepou2Td0sE+u52PRZEY/+8Eb38Qfk3nn+oeW0i3idziJ79QwCaQKme5hEoXILdVolZsAJiEVtCUpelefQTWohatjDtDJXhO2CrSLVeygyl1Rj59Pe0zQA==;
X-Mailman-Approved-At: Tue, 06 Oct 2026 07:24:11 +0000
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

These three patches come out of bringing up external DisplayPort over
USB-C on a OnePlus 8T (SM8250, msm DP driver). They are not
device-specific: all three are bugs in code paths that run on every
Type-C DP board using this driver, which today includes the Snapdragon
X Elite (x1e80100) laptops as well as phones.

Patch 1 matters most. The link-training rate/lane fallback in
msm_dp_ctrl_setup_main_link() is dead code on every Type-C board, because
its liveness check reads the DP controller's own HPD register, which
never reflects a real signal when HPD arrives out of band through a
drm_dp_hpd_bridge -- which is how every Type-C port gets its HPD. It is
latent: fallback only runs when training fails at full rate, so a good
cable never exercises it. Found with a cable whose lanes 2 and 3 never
achieve clock recovery at any rate.

Patch 2 demotes the per-attempt log lines in that same fallback loop
(plus one unrelated AUX interrupt message) from error to debug level.
Without it, a monitor that settles on two lanes after three attempts
prints nine error lines on a completely healthy attach.

Patch 3 sizes modes in msm_dp_display_mode_valid() against the link's
trained rate/lane count instead of the sink's advertised maximum, so a
fallback doesn't leave the mode list advertising bandwidth the link no
longer carries. It is a partial fix -- making userspace re-probe after a
fallback needs the DRM link-status property, which is the existing
// TODO in msm_dp_bridge_atomic_enable() and is not done here. Happy to
pick that up too if review wants the complete fix before this lands.

All three were found and verified on hardware with a cable that
reliably forces the fallback path (lanes 2 and 3 never complete clock
recovery). DPCD captures and the full fallback sequence are available on
request.

Verified against msm-next as of 5e4a3f7b2 ("drm/msm/dp: add
stream-aware link register accessors"), individually and applied
together in sequence.

Jean-Francois Bobier (3):
  drm/msm/dp: don't gate link-training fallback on the controller's HPD
    block
  drm/msm/dp: don't log an expected link-training fallback as errors
  drm/msm/dp: validate modes against the trained link, not the sink's
    claim

 drivers/gpu/drm/msm/dp/dp_aux.c     |  9 ++++++-
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 39 +++++++++++++++++++----------
 drivers/gpu/drm/msm/dp/dp_display.c | 38 ++++++++++++++++++++++++++--
 3 files changed, 70 insertions(+), 16 deletions(-)

--=20
2.55.0

