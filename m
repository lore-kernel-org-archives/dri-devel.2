Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B75C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7189F10EE8D;
	Tue, 22 Sep 2026 21:53:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="Iv1x51OH";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 052FF10EE8D
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 21:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790114015; bh=RFMyv37nfT1ThIcxnUyGgIkus6kLsG8MS9T4H/vlFk4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=Iv1x51OHDUqcaHxm4/8sU5smQ3o+LSP+STS5xtUTpngFjLeJZP3xUQBXRdD6bOsNAbucWzKkjExeSajUMdYSLBqTqW/ogW8poqSeEFIzwhS3vXg1LSx+unf4HoVje9E8UFx7hLPdi+uFX1ENXl40KmZhUou0fU8HrG5KbYyXoYUSZPZozCg2gd1YRebh64MCCIWjkzIMWAYi3dUTP1Bs0ezNFC9IhOSDvbWn5dI6U+fFbMT1legU9Ng2WUqirIz9kUNBBr03edG0IXYLRUFha+u5VUgB+TQFI2RW937U78nRvRw7hAu8xqNcrd6XnGIeMB/whas6bunWbZ571alcbg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790114015; bh=PNcpsoObonkYRniT5Fj7+fIlI/7XxQiYiLgYwvpYQHy=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=Jrrc8lMyrXlXW+86JJIXqmtemQo2483FfbbhKm3vOnrNuGzVJ8+FalgRBk/5e0P3BAlOMGyN+FplaoF51WSNnDMDgG99o+5X/Ix1VxKjx4MLvaiH2FRTnsr/SZlRn4LKWTrj0In2IIrugsOxQ7Sw9Af8VMDleN39fn+z8bvVuiJnu0Cj2Xkx292pnqvK4Pf6irTJAQHLIdCuDaJuYlgK6JA0gtsn3CczFPHS19HQdwup8xTPV5bbAjOdCGvN9ZX814fSDDkZzNH+mck5QBNA4TuKEHy+3GUlagbXlbi+gpzMjPLQA0ZiJgQXBZelckqke/hODGhHJZKk/IgzQI21SA==
X-YMail-OSG: ITs51cMVM1lSMGP.3fCwpaEP4Hs8mR7oxneeG58zg2MAv0nE9cbhpB75KSkQDbk
 tW.k1EKz7OgBBVsvM.kH2HkD_BVeBavM5KPjQ95MSLg1tpVoIaLOWJ05VuX08wVSJsJnCCITMERb
 4cr_ZyeIAmx1pRLz3wF3ToLWDyPXjFw8ejVzbV89bQ8pG8Ad8fzPNnLyDITNS2ldVggwfBtnxEat
 nk.gljUQAxP4sHXtEf3HI9i27t79WONqonLhWe1nuWSm05sw0IJv9nb2pyx1iuRgFJ.oOYQISfeV
 1MKyjpGjfx2lCa_dH61rkCrRD4XjWz5wgADW1eGIVtcYZsQCaDl44fGzHUpJzAtYTYfSbk.M7pOt
 ap6_L4NCdtWP1eGtuPWu5eiwrPp2M7_yEBI8J9BFFL_DUw._vk8lAzjW7NoJ_JPRz3ffu2m17Gsy
 NhlM2Vfj21ya5d0dc721q7nBPkcQn.swON5NHaKq1r45hvc7K4yUX4BbAeAIptv6MLf3a5.4KMdy
 iwDIPapT3CEjp14FZKknCgXYoAlKfq.6l0cXDbrxl1pom6n9VkuUpt5fytE5mwkfUECAd9.Ddbcl
 t.HUfrf0yS5cy1ZWleKgsGvdEz_OP5rmaR7opnNw3dGBNUJrVOCDBTY8rYGVAhuZJriGdsMoC3Z4
 D6l63XjolzZYzlYp3b2ZqNLQ7QjVuDbyrZyk62vhXTqItTYM5I9Vu.a5uv8hiXlv4IdLfqJ0swy.
 cFDF_6wi0b_S42HtwF1hL95zVPkU1Kc1nJY6F3nMY6fNwFaKcFfSD.31T1Fz.AVEgE5aM5jphKNw
 7OBOi8oVjVuLMVEtAV4pVHKxY9K_ezAT8Yu6ft3MaWlqHiuImAG.lDJRQNDbwGZwN1qf01BraZsx
 6mnM1x823ILF7BTlJ8DSBlqdiYH3kKBI0usATb4pa_yYqlu2SJQTia21M7QWViy_PcPn8ph3jGYa
 UG2jZH.3YtMc29IwQTFEaozCpGdbFgHVQwt6iN3UjopsO8H9xth.COrluvLCFpJcasnwew9f8Mqr
 8KBgPNrlldyHzbXTufnkNKq_qaUUF85Dc7jun71UcuS0mAXhNskPzbtIVAYad7tgzY4r8q4FlsPY
 erfirrzovyEse8nHoYHpLj2v_dhliXxZtA_tTCHA_cDJJNQoV.3IRGn0M3Ky0RHBO31UyIFvlZy3
 HG0guPk1i6Jc8EZHeLpJST7jK8nNeOwud6SmPZ1Py.Dw02Wo4TDO9IRZxzXOj8ZmYKEFvfoZiz5b
 sXTVn2jpwnerqnutuVPK_g.4BjGNL8rD2NimW70NIjgSZQOUDr0lnDaLUNrUbS4S4AYZvB_wMx5x
 Z88kABp1ANwY2CO9I95JiyTaaa5uVuMFAi_Dy57Mwq5GJwg9hFmcOFp2020Ew7v0JsEZbk8o4.pC
 jeXdScS_45ij9RMGmzghrpc4Vml25MGZyhsQaPB0zQECe0BtV.eUisAvH.HMyz_12xM0a5RnrqqU
 7t1htAIBkVSiXwLFlNHha2tKUYMNrrAMSD0ixEDdSxr5KHRbYi_5yOPDeyUNMcBMYzmrcQRyy7AV
 Aj3_NZJnA1pzH..iI7ypKV8RHS3DwM1dBbmRvEam8cMm6WyNGYF96Rq0Ulppb7t4CcpztTIMVlHr
 A8pLQjgewFl.yCzSBiJcod0.XTtMvPJEsxKT7M.BjZZsEi7lZMi5bhXHD8Ld3KeO7m2Jo8elzmX8
 oa2VCs3gMFBKuJofyRBVtR3GHycgre9eWWSokndy8AH1JdguYryQXiVhB.A0NghWFXkuiosfEDud
 D2c3TOAr8g4n6O6s2zOdFUPUzKToNCZ7P7KqkzVNwYR4ZI760SvL75pZoSkNn255EV7O0rQA2msz
 89Hm8IHuf4_196r9pSwP.DOykhlOM1fNpS_rE1QNGwjUh_OewA4ZBcOt9k54fNjB1MARqctGYsl9
 SheQ6UUGPr6ep4i28zLpUC7OAeLB9.u1fEwfgIACFC3mZioqMFx2sekxo0Gv07PEgMYIMWL6JhRb
 zCXgtG40OfWOYn4heYbaPs14EANZT
X-Sonic-MF: <Capitain_Jack@yahoo.com>
X-Sonic-ID: 77fd0c1c-e3c7-4a95-9628-373e461e910e
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-101 with HTTP;
 Tue, 22 Sep 2026 21:53:35 +0000
Received: from dip33.lsn.bf1.yahoo.com ([67.195.177.42])
 by hello (SMTP) with SMTP ID a34e68627d724ee34c25b40bae8a8d59;
 Tue, 22 Sep 2026 21:53:29 +0000 (UTC)
From: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org, lyude@redhat.com, dakr@kernel.org,
 Daniel Campos Ramos <Capitain_Jack@yahoo.com>
Subject: [PATCH v2 3/3] drm/nouveau: program HDMI deep-color GCP fields
Date: Tue, 22 Sep 2026 18:53:17 -0300
Message-ID: <20260922215317.611388-4-Capitain_Jack@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922215317.611388-1-Capitain_Jack@yahoo.com>
References: <20260922215317.611388-1-Capitain_Jack@yahoo.com>
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
index d0360610f9fa..517a51caed2a 100644
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
index 0608266188d3..d1e4b38b90a5 100644
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
index f6c163072ff6..49c84927583e 100644
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

