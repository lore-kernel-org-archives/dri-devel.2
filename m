Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018D5C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6527B10E576;
	Tue, 22 Sep 2026 19:21:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="VpB1hw3V";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70F1B10EE3D
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 19:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790104909; bh=4Bi5XBFZ9yxCwVDjKHwrF0yDTRi5oQ+I6HXTZr8gC/A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=VpB1hw3VCmqftWkAmQVsOFEglmpnvKiyf+azgsMLonsMPeByQZM3SHvmPqbsFfhuicFFyN+WEpSXMWurQRUixh5ehedcRMfHQw9w6q3VRytPfuIcuzd8uDTmsp/etqKa4eoiwu1zgfJXAweyEpChCKLG2d5VnRnqLyeyGlUfXg4tW7z8bOA6Un/bYDGiaZ3DeJHWVcWsu3b9q5lt3sqxMxR8DZ1uASfcObyWXbt+6qrGOylR10vi2rwFlTj/uLrx1b6pLhhpmRRin4pGADGgi71asxV1mqZejl7udzcED6X//pNAu/XHWNVSItu/pTmHjg0gFiQ07/OyRpoRes+Bgw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790104909; bh=uctkBFegAfLww8jsOG8E9KvYJ7jQDC6TJbiuqYm8k8I=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=nG5/2pIRvOV5M57VNURJbItislyMClh8xNkwdpSloo2cGhAAT49EwMgYRU6AcCkvWjNUMVABpYtuO6ssrm1DN6+JHVzUsAULv1/L4BZg4urM3U6zQ2wZygXmHG0xWtjnASLJUuRTt0WyJBoYEAm2c96e7rrs7a59idr6B14ZdmNmUGlT25gUDQ/aWrJv3UwcDX7CO1AEBgrXpCsUOiU5boQmq1J8gLg0GoBwD8K0wi0jpmVO0ImB6LjkxEi83bOhxCQSqg1JUjpUVA0h/4VYSGIPh8lkauD0TdwwmjI7ak5SkacRnVm7gpWrl9NmOO1pQZpbQ4vkMZAm0ssunFL70A==
X-YMail-OSG: CzxJJcYVM1m2uveK.J7jyyO5yeFw_PXefpW9EFOMkimpFg1wJNQIJ0QdeZEpVZj
 zriYz3oFKPyWahpx2o5gf0x2qLXae2lmfmqIyJMSuOsKBgcMZWsp.WQGUQSJZhCkG7h9JgK06fDB
 MpyHseFKeVOq3pBhqWuEHb0nUo_UWWQhZIqbeutKQkBz_ip5zdvBoT_DUOqnlrrzIiU_ntqMxjtK
 A0bCmEI8zieYu1f9fFM9pz0xL0Bf2X3eLlGwkLixpPrlPEGIk7sC7.hgzuDVKWSvDvZnc831sovZ
 jYfdAupsao5amGsFREYqeboSfwcG7w_4DrvMXDyQi2twhDT02IHgB8AxJq4MDNTzgxR_PLdjHLz2
 akvftDWR5rBlxDJJhj5BcO43GDqOeoZkHlC9CVYmy8CY87UaOIk1zr_Jr0J3sS_ties7jeWm3jzl
 rXRvzhUTuZqQ4Q2g_igd77_c0eHg_T_4LNaUHQW9I9KUlYEFludyYN7V5xlZnMsmYPpvL43hTdea
 wyVCoNsnHas0yH6_7qRKJ4AHz5xn3Xnjs3bzsotD4vRHtqHwRPnQ_mxLBLYfA_k2ihc5QbeqDabM
 5epHg0HRcR68b3WQIi0Zh1DeGVlziHOoz2YxFrA5I5gHCeCYQY9Y0W1uf.ojPqEwNfEU1vihqukh
 nGYC12bNpoXeCRapmPGDdfPgRaTjdbVj6jGszHy1CsNhKXHzbnAufJVmK9ZObRtOveDT5fWcP4vo
 eXShVlOR_KvNkLKDy8uZXDapV316gXZ6FkPcnRT9DxgVefodKUwlfv.f1L6uIF2JEMo1hikPdwzs
 gU.GHIu3ChwqVL6NMJWHK1jAKtcdiM7IHZzIICG866P7QY.rrEeXFak2fZsi8pcA_6UbSyM_pW6r
 lPceGjm57pcFtUqCRzSmWUA1KVBEgwhtKIa0u9Za.vZiPjhd5JRR_Ez.GwvqRStg9sFcFVLBjeKS
 BIh_zZJFF1dzsNCew1Pzyu43QZjXxBBHt95MhH2GnH1A9yjGMDDOqiSW1wP.gUOV69DzYfm2Omcz
 J7X60WfRkf94VUqr7ZSMavHvU_IEp8epGoCOSoA3yJn1.Z.dUCf5NXjDTiaH6euxxZu4c1x.Q3kC
 Z7d5fnRL_NJHTZ6o4Dy.hy43jifwdGXnD2I_g92j_d8shymzk74eT35Z9pV7o0Mz1T.VBbW8DdkU
 kLnkBiaEizVDLEh6h0.Oo00uGJYfCjnczohI8VBVVtUAYWTpAj2NBahJODpMmPQK_mAtd.yFOxpo
 O7aLQ4PXqmX4lUcgbbvM0oTTdxv5lOcpht1_vxbDFOjFomHruuM9qzNLVKyG56VCfad9qcNr4Y3_
 T8EWBR_k6_vL0oLxWDKtfphJz6uJ_9f1I_zORKALY1nJGzuSKx85RPNhudnSkGYSLUSk64Zej2Yh
 BpvPrkT5b6Z2r1VVgA8P0AMS9P1OR00w6IkJ_u4lGugNwYz4ZZ9gU1FDwuEGIpV4Pl3nPz_WsarX
 IZKANfOa_XvTB7p7zt0ZFMJ5AhYAje3ciGVjWWpWvsjstp0AP7Wplhp0pnkeiA8Yb_FJEaGvuYFS
 BF0i00nKLkq2uY256zBjFerTkKbJRy88yLAvKuZXuSlEhTsEWBJgqgsWHc1ASbsDLpK.JLXZjRvR
 .CzT5KIGzZsi8qjl4lEApfHaYz49kPfHj0OPADW34hwqMtU13MNxPlRZVS4ySRm3klhO.qxRIhK1
 Gl7AnsBExYbxOOBtSsxie9O4IQXon34L0IO.IivAIJl9WAJNtvSlIWxGz_5deCiC_7w4RiyyfDo.
 vbVgfHcGDyAdaT1nF8ExqLQpV5boqAroU_Vhz8ldcwt1iWDsSDKZ8yaYw4EEFO0wHozN3j8xeIfk
 rfi2L5Ifjj0VrOMgDnWi2PYGVHNH5Rjojy.2YAL2wDPFmIxDANvq87x24oQCoPm10G5O88cMPJ9E
 xYCwSHXvaoGOetDKm5H2p1VOXELmWXx3CNxohp0yyjVSJ4nAHOSKxNBadBCYf6fdmcV23CDAStN0
 8zyUe2fC2cxkmL_RVmphg1UMk8zndWhQ-
X-Sonic-MF: <Capitain_Jack@yahoo.com>
X-Sonic-ID: 216fffb0-d1a4-4b15-a754-4c42644d244e
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-102 with HTTP;
 Tue, 22 Sep 2026 19:21:49 +0000
Received: from dip49.lsn.bf1.yahoo.com ([67.195.177.58])
 by hello (SMTP) with SMTP ID a114298d351310ec48bd21743ed80317;
 Tue, 22 Sep 2026 19:21:44 +0000 (UTC)
From: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org, lyude@redhat.com, dakr@kernel.org,
 Daniel Campos Ramos <Capitain_Jack@yahoo.com>
Subject: [PATCH 3/3] drm/nouveau: program HDMI deep-color GCP fields
Date: Tue, 22 Sep 2026 16:21:32 -0300
Message-ID: <20260922192132.114546-4-Capitain_Jack@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922192132.114546-1-Capitain_Jack@yahoo.com>
References: <20260922192132.114546-1-Capitain_Jack@yahoo.com>
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

The GV100-class GCP writers always program a depth-less packet.  On GSP
systems the HDMI audio setup runs after the display commit and writes that
packet again, replacing any earlier deep-color declaration.

Program cached CD and PP in the direct and GSP GCP paths.  Update only
SB0..SB2 so generation-specific bits sharing the register remain intact,
including GB20x SB1_CTRL.

On a GA106 driving a Sony KDL-46HX855, the depth-less packet produced an
incompatible-signal OSD at 1920x1080p60.  Restoring CD=6 and PP=2 after
audio setup made the same sink accept the image and report 12-bit input.

Signed-off-by: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c | 12 ++++++------
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c |  4 +++-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c |  4 +++-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
index d0360610..517a51ca 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
@@ -66,20 +66,20 @@ gb202_sor_hdmi_infoframe_vsi(struct nvkm_ior *ior, int head, void *data, u32 siz
 }
 
 /* General Control Packet AVMute bracket. The GCP unit moved to slot 1 on
- * NVD5.0. Only SB0 (the AVMute bit) is ours to write so we must not do a
- * full write here: SB1 carries the deep-color CD/PP fields, and SB1_CTRL
- * (bit 24, new with clc871.h) controls where their generation happens (HW
- * or driver) on these chips, with the default being HW.
+ * NVD5.0. SB0 carries AVMute, SB1 carries the deep-color CD/PP fields, and
+ * SB1_CTRL (bit 24, new with clc871.h) controls where their generation
+ * happens (HW or driver). Preserve SB1_CTRL while updating SB0..SB2.
  */
 static void
 gb202_sor_hdmi_gcp(struct nvkm_ior *sor, int head, bool enable)
 {
 	struct nvkm_device *device = sor->disp->engine.subdev.device;
 	const u32 hdmi = head * 0x400;
+	const u32 gcp = (!enable ? 0x00000001 : 0x00000010) |
+			 sor->tmds.gcp_cd << 8 | sor->tmds.gcp_pp << 12;
 
 	nvkm_mask(device, 0x6f0040 + hdmi, 0x00000001, 0x00000000);
-	nvkm_mask(device, 0x6f004c + hdmi, 0x000000ff, !enable ? 0x00000001 :
-								 0x00000010);
+	nvkm_mask(device, 0x6f004c + hdmi, 0x00ffffff, gcp);
 	nvkm_mask(device, 0x6f0040 + hdmi, 0x00000001, 0x00000001);
 }
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
index 06082661..d1e4b38b 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
@@ -149,6 +149,8 @@ gv100_sor_hdmi_ctrl(struct nvkm_ior *ior, int head, bool enable, u8 max_ac_packe
 	const u32 ctrl = 0x40000000 * enable |
 			 max_ac_packet << 16 |
 			 rekey;
+	const u32 gcp = 0x00000010 | ior->tmds.gcp_cd << 8 |
+					   ior->tmds.gcp_pp << 12;
 	const u32 hoff = head * 0x800;
 	const u32 hdmi = head * 0x400;
 
@@ -162,7 +164,7 @@ gv100_sor_hdmi_ctrl(struct nvkm_ior *ior, int head, bool enable, u8 max_ac_packe
 
 	/* General Control (GCP). */
 	nvkm_mask(device, 0x6f00c0 + hdmi, 0x00000001, 0x00000000);
-	nvkm_wr32(device, 0x6f00cc + hdmi, 0x00000010);
+	nvkm_mask(device, 0x6f00cc + hdmi, 0x00ffffff, gcp);
 	nvkm_mask(device, 0x6f00c0 + hdmi, 0x00000001, 0x00000001);
 
 	/* Audio Clock Regeneration (ACR). */
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
index f6c16307..49c84927 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
@@ -39,9 +39,11 @@ tu102_sor_hdmi_gcp(struct nvkm_ior *sor, int head, bool enable)
 {
 	struct nvkm_device *device = sor->disp->engine.subdev.device;
 	const u32 hdmi = head * 0x400;
+	const u32 gcp = (!enable ? 0x00000001 : 0x00000010) |
+			 sor->tmds.gcp_cd << 8 | sor->tmds.gcp_pp << 12;
 
 	nvkm_mask(device, 0x6f00c0 + hdmi, 0x00000001, 0x00000000);
-	nvkm_wr32(device, 0x6f00cc + hdmi, !enable ? 0x00000001 : 0x00000010);
+	nvkm_mask(device, 0x6f00cc + hdmi, 0x00ffffff, gcp);
 	nvkm_mask(device, 0x6f00c0 + hdmi, 0x00000001, 0x00000001);
 }
 
-- 
2.53.0

