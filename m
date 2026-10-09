Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB11CA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 06:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7A6E10FEED;
	Fri,  9 Oct 2026 06:57:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="Of3io1WE";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44D6C10FED9
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 06:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1791529041; bh=3NjxC5M5lg/RA5MwmPOKbOgmDERC/b/v0LWiQ2VGm7I=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=Of3io1WEu9UP4h7CHNEYniM/0reeDIMOKUP2Xobn7Nn0G0V/43LmJPNcKXe3kZ/rPV6j1sWjsEZSNyHkmx9hGI5OtnWMlK0zs+DHnwak+RseCMuYkhe3TuqeFy/txkglM20mP9f0fNd0CobS+mchAngTwr1S8jv+9v45kpTJmSz5akmt+j7OzoG98C9GG1AD79g9+UFUXMMKi6Kh0j1P6PrRJPD4NzDUY0Ci81LR3KAvwnjmaB0ek987wOFtvn/5fExybRSVnuGxkbGoNZ7bxtrKtF88kLdu1Qx0wpNntDowGklDTdJjD0emesS3iIWZ/E1k294L8nDPLkOhR2POBQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1791529041; bh=2S0aVmr8XrU+uelAAHfkdyBCRjPDadmfhs769dbi28P=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=aKW58jk9cULuXHtLia4nrS05SUmm04Hx8SXil38N9T8OgA6wpiuSLsDxBcc1FejCOY+KNkOe1NkOca2lk4PoCS4sdzO+Fuz8nPzWJSw+w9KD/BgDAzs5NVr6sG4nxuPNvfNc1fVeV+4HM7oa2g6iuVrMp2lhDrdTmye1eRp451FAuJBkSBmYHEtt3jKxoImxx0X3+tU0zzZWtJ0TEpr9Wam6pgBPv+Lw+PL1IvHnLFvgC8ToOKhbGpRTSA0Z5BPX4ROipjAW9PjNjnL7j6HG0qo/zSFeaL/ct2xCQtw0a8xRfzU8w8igyGMD39ayWxY7oN0S5RbaKa9PpgwWafYimg==
X-YMail-OSG: QhWuxTQVM1m5mwPOZJzhUlhHlYAsMw7xOMmTKOGKkm9HHzHrUzaoI_bGKKHfuQf
 NYDNGJAmUPr08OjZv8prComOUhy6mXbWQUWmM.OpKfv1Yr5rswPh5GXcuZM8uIX2A8wu2BTDd8hU
 JOdJ3ZcXcCmRKfywBd4RlZi7QzSCboyQSQiibLI9YXUW5rXtlsDgrepoD1cU0AEsJzYSlhkBJEXD
 G8jPmVkuZbYuQH_xity1tcdsQaOfxgr4POHNXfIlBGC5PyBDj1Pyr2p4Ahc40Vp1xgHr7YUyPIYe
 u1uFk3tK_AT8ubNoFr7_eD4RD59Ei9xtYXVXrlxava1HHA1eRqrKGKhWt6aVeM5bICL45Bv9fEYw
 8f_Loq9dAaxb_35EUp2EyWtOcvHRWjBjszbFk3YSarNnUuqabLTZ3B8fMooCNHtVPm8VBK4Df4wr
 qPgveg9juh8WM__OL.lX1ZrAlEerDdqXXTeU6LS8tEYqhUlAG.nmHmKoa9R8t4Nx12tZHkIlj31p
 FHfjZYTfeRujgozRPoUsB4mjxWST3r1AHfUIrQrPR77h8Z__WpKyBEJG2ifNIFlgJw4p90gMNs3e
 6_60BRmRm3gIbrcjzXFwfmPvMH8fTOsKvZDMECN3ivllUHvc.SB6nRUfhhmkqqh5QlSTb3OI9Qja
 8gmaC4Np5CZJ6OsTeYletSmo6LosAhHqNxQtVkRdttxVejepwbUS2JUGaB6sXpW9Pkc8QQFUExp6
 UDBdqSq0ttRN52Ibf5NmZc4dcbOXkQ8Uzq9H0sBd_OCbqzBLmReTUf3TZN0cOAakOmD72IrV1CZ1
 Ypamp_UhbDvarPE1b4uHop4Q8CqOeprALyliiISzDIErZXl8kgH4q_sNzuuew25sFawjZKDy7UPU
 0V0YDA3q4S7.RKynS_AITwqptrLxp.IbPpewpfAp6e9cj98NAOdLH_CkwQq3mLtKZ_9BV2IhVaQZ
 YzcBmGbaaZOgUvTUNtXJ1G.4EHjAqVi9GOOSpzYKHwAMBH8Mbj_Ykd7kMIeDyzstSehsgl.MpxpV
 bDeK0osbgQ4p6g5bl_ILnv.4WAGHdYt9clA_zqk_SjyfUplsb_QXfCwXJgucUpfr6fsX7AG3PwuD
 7n7urFhb3WNSVtLL_VtpcWRCRj9uJg.KPGhhg2xFGGeFjj4_AsIRp9QrtZAZb6BLHsVJWYJj.cmV
 qWQUfI9oFakmw30vI_nZOTphDNk_8BvqEE4npylqukiWYp_jumoVXguwwbVYL2rsRVS0My477Nc6
 HbLoxI4RaSrLYfezU5tN5wpXrAH1WK00TBUSuFQuYcgE0LyTzSoUqhfzwvqb7cjxubeCu.1qawcI
 6_wkEN5WrBM8GvA94sscgyTpJGFP1IAZRZBM5Zvut_TmbRqspdzzh91B2nv5g1lnaYRqPsoUNUh1
 7XTiVPJPE_vaEhqA5ojs5_NxgBg1zoSgUZmjtVMZ4CZW7KcTCyuzPWM.kFLhA2F5_3iSG5DrdlBz
 o7hmkvTQ8r7GRCaMMrNJtljm9C5YpR1SF8KbIDnOQxeGvUsGY8a42Ul5zsRsQHDAvdeq9GXKyc6O
 D0dn9kTdw0rqXQybtY7It_CbjLsw1PMYDTfNU5SHa_D4Bn4B9eQoF4CgGWEOZ6urA2EbqFV76lDs
 at4DGODPMS89jch20mVa7YPj3L1HwWOaKbjMomc.xKhU701U.P2lw9XGYhH.y_WH_KRQqYgq9.NJ
 o9BNhhGCBgG5bspGU.NK7vNp5MmSo4iNktr.5zmRD_2V5UbEhy4XvSTCKqaGeFjAQ3LWgUWrrItS
 2yuz127p12z02nVm9oF8g_h.3mWYQkftHfb.ORxm6oWf4ihZRZa5SdVXkYmCHzQYICECC46wnBvk
 8zudnjVziTPdtiYZoqudyrqfq4AYk4acc9vdSyn5KGyNesdvkLppoWZgmEVe9lQTZtStjX2Nlzdo
 AK2LKFB0WWLPwTrOuEl3vBTJkTFP0LJKfkS9b_k0e3EWqh4C0O42z0mey_ivvs6.nCiUbYHSUye1
 puxeky82cGoN13ctkVtoeJoehvf1LbESWKew4a72mNR.S.iRQGQ2pDdkcIw0BLGaV1a43
X-Sonic-MF: <Capitain_Jack@yahoo.com>
X-Sonic-ID: f5ad2f6e-b087-43e9-92f3-81045e1d9fef
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-101 with HTTP;
 Fri, 9 Oct 2026 06:57:21 +0000
Received: from dip44.lsn.bf1.yahoo.com ([67.195.177.53])
 by hello (SMTP) with SMTP ID 9892a3ad3218e50826b25c7d9c5c3a6d;
 Fri, 09 Oct 2026 06:57:17 +0000 (UTC)
From: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] drm/vkms: Stereo (HDMI 3D) modes
Date: Fri, 09 Oct 2026 03:57:12 -0300
Message-ID: <179152903254.1726604.8785647683993800694@yahoo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
References: <179152903254.1726604.8785647683993800694.ref@yahoo.com>
X-Mailer: WebService/1.1.26668
 mail.core.serving.mcws.prd.acl:role.token.mcws.jsmtp.yahoo
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

With Louis's configfs series [1], a VKMS connector can read an EDID. An
EDID whose HDMI Vendor-Specific Data Block declares 3D (HDMI 1.4b) makes
the EDID parser list stereo modes, but the probe helper drops them
because VKMS never sets stereo_allowed, and VKMS would not show them
right anyway: a frame packing mode describes one eye, while its frame
holds both eyes and the vertical blanking between them.

This series lets the composer and the writeback connector use the frame
of both eyes, allows stereo modes, and adds KUnit tests. A VKMS
connector then behaves like an HDMI 3D sink for compositor and IGT
tests: a test sets a stereo mode with a known left and right eye and
reads each eye back from the writeback buffer, with no 3D display.

Tested in QEMU/KVM on the base below, with Louis's v5 and the two v5
fixes proposed in [2] and [3] applied:

- KUnit: vkms-stereo passes next to vkms-config, vkms-configfs,
  vkms-format and vkms-color. Without patches 1 and 2, the test reports
  all 14 stereo formats of its EDID as not listed; with patch 2 but not
  patch 1, frame packing fails both writeback size checks (the
  frame-sized buffer is refused, the one-eye buffer accepted).

- A userspace test that sets every stereo mode a test EDID and a Sony
  KDL-46HX855's EDID (a 3D TV) give, with known eyes, and compares the
  writeback buffer pixel by pixel: 91 of 91 checks pass. Frame packing
  1080p is 1920x2205 with the right eye from line 1125, 720p is
  1280x1470 from line 750; top-and-bottom and side by side (half) stay
  in the 2D frame; one plane per eye at its place gives the same frame;
  a 2D mode stays 2D; the vblank period of 1080p24 frame packing is the
  same 41666.7 us as 1080p24. Without patch 1, every frame packing
  commit with a frame-sized writeback buffer is refused.

- IGT kms_3d: pass, ten stereo modes set. This needs the PATH fix [2]:
  with v5 as posted, kms_3d fails in kmstest_get_path_blob() on any
  VKMS connector.

- With KASAN on, the three runs above give no report.

- The same changes on a 7.3-rc1 based tree, with a KWin build that
  supports HDMI 3D modes (Sparky Stereo OS): KWin lists the stereo modes
  of the VKMS connector, sets them, and its frames hold each eye where
  the layout puts it.

Not covered: interlaced stereo modes (VKMS does not set
interlace_allowed, so the mandatory 1080i side by side (half) formats
are not listed), and the HDMI vendor InfoFrame, which VKMS has no link
to send.

The test and its EDIDs: https://github.com/Sparky-OS/sparky-stereo-os/tree/main/tools/vkms-stereo-bench

[1] https://lore.kernel.org/dri-devel/20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com/
[2] https://lore.kernel.org/dri-devel/179152766117.1436711.17646397822774209185@yahoo.com/
[3] https://lore.kernel.org/dri-devel/179152764385.1436711.6215580184547295403@yahoo.com/

Daniel Campos Ramos (3):
  drm/vkms: Compose the frame of both eyes for stereo modes
  drm/vkms: Allow stereo modes
  drm/vkms: Add KUnit tests for stereo modes

 drivers/gpu/drm/vkms/Kconfig                  |   1 +
 drivers/gpu/drm/vkms/tests/Makefile           |   1 +
 drivers/gpu/drm/vkms/tests/vkms_stereo_test.c | 476 ++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_composer.c          |   9 +-
 drivers/gpu/drm/vkms/vkms_connector.c         |   2 +
 drivers/gpu/drm/vkms/vkms_output.c            |   2 +
 drivers/gpu/drm/vkms/vkms_writeback.c         |  11 +-
 7 files changed, 494 insertions(+), 8 deletions(-)
 create mode 100644 drivers/gpu/drm/vkms/tests/vkms_stereo_test.c

base-commit: 6648301c5bb2ef23f0fb15bcb01d21ff66f36799
prerequisite-message-id: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
