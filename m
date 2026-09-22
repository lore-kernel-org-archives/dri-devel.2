Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3282EC98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:53:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DA7010EE92;
	Tue, 22 Sep 2026 21:53:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="nQDV7CsQ";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3D4510EE92
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 21:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790114025; bh=NVaWs4zBKL323Ekmtc+JE+yof11LKPeYjUbwqN++Tzw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=nQDV7CsQHmaLYDkkWDpLLqIUvBVbHx6EKxo9tp4hBm7SYDziXj/hUNGewmSoZpSk/v9ttMsDJifE27YDhWzfpws0bejTVxxKXTvTrSv1uc7xFMyKpmSgI0snHyga/QqPvboMdowfz6KPKmz4gi0rArtGXDkxM6C0fA4E/g35EzE1KWLXnKvBk2n/sIE2qxnHBi6geaimhQLAu7pV0uMy2iUiY2gI7wcvYAKCFOo65B1ZvaIL7QFLaNQRye2i2smDTklyweJVdFqfh63Snhb4FdXCEL3CfPiW7jisE0WDHnfDOnVGpqytscEiJj4fLOtOs0AYKAu+R+99GWMym+2VEg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790114025; bh=pRq9UB4oHREKdzeQHa8BpbWMwrcG/dWIDAKw8S+xikQ=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=MYpZv9SufsrFazM7UwmbGLNah/irl61yIRCVzjmYKGsoHM2vVTeQ4P+aRpkhLGhLwIbIAofRHqH2R/lBR9ahUT1tNl2woHQoJYFrmGlmQ1IhTzo1q7eIEC9vfvg7zDLQFmmhEDtpzPv9AzAv68o7UD/f3xVDSF/Us+by/d/grofvWKfTnhMwhdjplD1/Celv+IoaQFRB2yIpuGWWmVcyOLIX9/bxG4eX0SET4PfjztCHuDbSCpOjW4rWQ4gBb2iy+uSCvyvDtQhEGkB9MUtVJ4ZY4D5Y5+PNssbQn95Cw27aqjpnUPHJb/dvRwNxtrjAcuNy5n9YiTrYbJ3qlFPYwQ==
X-YMail-OSG: CkIzVCYVM1kGH44IiWbDDYu4XHXNIvZXKec1HrvIcgJmELjKrKNYK8bB5Uajq6I
 4.gN6B1hIakpqfXZJIppf.hCmI2JY1sUtUOJemx0BVNO7q_AWVNrUrVNdod8dnCsJboGRyC5xeeE
 KsxdRrIE1oQxvVWAMb1kbdFmuAVAu0CLyQdpeM1nzr2n3bZUikVxPNnbXSUVLeZzINkRs1N7Qk3_
 3_1XA9E.DOHeg91AoC.dqCnwL6DzACPe5Ew5x9z6CscxrkQOhDtdOYO85SvWVvT9c2U4T75pMCYx
 4xHnRvVIuSMcxshjh9_f449HPk_MH8.TzFww8FaUGbcESmJapTm5P2jkBIWj1s..7V0R3h69oXBu
 5fC5MmuaoT.KhZXATp3whxNa_i_IbLYCP9kPdgk.5qAoiXGu555FSw1xt40G7W5qx4nFoV0b5rLr
 l45u2EBfmEpXumPpbQTntLZqr86q_QoOGDkece_wsHwLcKgoSuLsixCq3zEs4FpAaHvRDIAHYSoE
 CRi.s0iBYTeH9aGmBne686x0fxq8tr1ZQnmIeHbPi6e_vh.vMSta_G54vF8ExnD2A8lrE_q6RW__
 bzn0c_.A54TRE48MSGm5nX7qM1M3sf1x5cMnWLeXYE6O9iaCq7nHKjgkD7k9ZjDA7AImTD5ERN7Z
 GDPyUonUlR5WDhnxsVErtsXCDezilj_rB0FWcjoGP2NjMho82zor64.9gXGg_t2MGKQDCAOztDEj
 2lzq32RhQpvK4xxi_IRmfq65wsCbDZJpMs7R44yuwm_S39xyGMPDkajgOQ4VrQz58r1ZTfVihbrT
 74G_sMeHhsAZnM_BnDMxb20HsXx2wNBhWCCXtVsZ8KvVyfmSlmUv9L_4YcW4XEhxn.fugWHTcrGL
 EbvMrlneAL4yYIRViui.V087LtjYwocqbwlYfI_Ufx7P8SrZLHxiWvbuj4OuoCuJUyfGfzfca5OC
 fVJB17DOlSskWQBmV5fSVM6ok2alJDLIfNNre6oqMCqaMZI_U.7xc4eX2TQybyPJ4hqx_kghD4y6
 wXfGEFYj9kxML5ct_9HoGQLZLyhSINpOWudK7x5h3RG0YpkpGQk2DKetq15MdernVOYCqC.ay8vb
 7Cv0gDtLVFEtwg4Hg9CAATxhSzlNudKqyMMLTHvs35.RBbY5G91AkZvPFLJqr9yO8zpWTaK2yYgo
 uL2eS5smWw5vuAcxfp6astYuSN5oOfM8sH5kSo78WZQn1UKz1CSw6vIre4u5vzB5IJdDAW6FQYHH
 CDdHjElugzP0LpX4pk6rGzZSuEWSHF.kaz39Xw42kM15GUHiGwA8m2AWaLUsbCyCrifuLp5dSKea
 g6mofAoXOeDY4cAQqpsBIOYWIIfbPOXBqajGbqlNG_sQY7x0DKUBttXox5wkbcTrqul22.XddpC_
 .Y6o1stqdt.fUV3k0XdmDUoO6mikvX87LOhMZk_pZFmnaIjtr36E_yGggMPvhfLKRsLH7DXy3Trq
 fOJouG08Y6_SB7PNBFUS0eQn_kNKYN4qaGiKpAS_EBvmUH7XEYZC3uI1KZ7ddKUZnntL0wAm7hjt
 3w1ljF7K4GKPe14rPhKympaUSJRRs8wS41QU5FB2CQf9RThyJnnZHiI2.Zsh2HcAuak0vduxVhVL
 8ddMnYDdkSsXKrm0_X3j8LA_AO__r9DNA6G0IxOYe6EdXmy8ZXaOpO6WOM5KpEUHiQvFt.1nDQwe
 Hht8O1Ij.L5pbAp6u.xfqAOZ0sr_h6jrD3vloQxdnFY2LyDHuMg1CmjAdydURtL486OR74JzRdUp
 .Ffw8mPHBdCS5xGtfFfJVCOqY2K1E7.ZNeiCC7GNWpcyWZ8CKmuJIJLZp3iaC_I.Saag4uhWAqnu
 MkdJG2K7oxR_95HjbdI2vwwhUP.hHRZt5UIQl1lFYL5qINVziqR9KrdxxHCe7yq_5Gh1X2f9jC5e
 .knmAtPqS8I5r225ZdDkP6QgGbojarMbE5y2yHWvC5YizJLse4A73CjutVCyRu5CO_yp3XYwq_x5
 Q0vO608zoZ_WPwl.vWmLRbVB5xmaURuk-
X-Sonic-MF: <Capitain_Jack@yahoo.com>
X-Sonic-ID: a4dc0f60-4fb2-4191-963f-f82f3d4953f2
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-102 with HTTP;
 Tue, 22 Sep 2026 21:53:45 +0000
Received: from dip68.lsn.bf1.yahoo.com ([67.195.177.77])
 by hello (SMTP) with SMTP ID 98779d167a59bfbe653b3ebdee112417;
 Tue, 22 Sep 2026 21:53:42 +0000 (UTC)
From: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org, lyude@redhat.com, dakr@kernel.org,
 Daniel Campos Ramos <Capitain_Jack@yahoo.com>
Subject: [PATCH 1/6] drm/nouveau: add NVC57D output CSC and clamp range methods
Date: Tue, 22 Sep 2026 18:53:31 -0300
Message-ID: <20260922215336.612239-2-Capitain_Jack@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922215336.612239-1-Capitain_Jack@yahoo.com>
References: <20260922215336.612239-1-Capitain_Jack@yahoo.com>
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

Import the HEAD_SET_CLAMP_RANGE_{GREEN,RED_BLUE} and HEAD_SET_OCSC1*
method definitions from NVIDIA's open-gpu-kernel-modules clc57d.h.

These program the head's final colour conversion stage on Turing and
later display classes: OCSC1 converts the RGB pipeline output into
limited-range RGB or YCbCr, and the clamp ranges bound the resulting
codes.  They are needed to output anything other than full-range RGB.

No functional change.

Signed-off-by: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
---
 .../drm/nouveau/include/nvhw/class/clc57d.h   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/include/nvhw/class/clc57d.h b/drivers/gpu/drm/nouveau/include/nvhw/class/clc57d.h
index d4bad2da3e56..ed9de61c5655 100644
--- a/drivers/gpu/drm/nouveau/include/nvhw/class/clc57d.h
+++ b/drivers/gpu/drm/nouveau/include/nvhw/class/clc57d.h
@@ -334,6 +334,12 @@
 #define NVC57D_HEAD_SET_CRC_CONTROL_CRC_DURING_SNOOZE                           9:9
 #define NVC57D_HEAD_SET_CRC_CONTROL_CRC_DURING_SNOOZE_DISABLE                   (0x00000000)
 #define NVC57D_HEAD_SET_CRC_CONTROL_CRC_DURING_SNOOZE_ENABLE                    (0x00000001)
+#define NVC57D_HEAD_SET_CLAMP_RANGE_GREEN(a)                                    (0x00002238 + (a)*0x00000400)
+#define NVC57D_HEAD_SET_CLAMP_RANGE_GREEN_LOW                                   11:0
+#define NVC57D_HEAD_SET_CLAMP_RANGE_GREEN_HIGH                                  27:16
+#define NVC57D_HEAD_SET_CLAMP_RANGE_RED_BLUE(a)                                 (0x0000223C + (a)*0x00000400)
+#define NVC57D_HEAD_SET_CLAMP_RANGE_RED_BLUE_LOW                                11:0
+#define NVC57D_HEAD_SET_CLAMP_RANGE_RED_BLUE_HIGH                               27:16
 #define NVC57D_HEAD_SET_OLUT_CONTROL(a)                                         (0x00002280 + (a)*0x00000400)
 #define NVC57D_HEAD_SET_OLUT_CONTROL_INTERPOLATE                                0:0
 #define NVC57D_HEAD_SET_OLUT_CONTROL_INTERPOLATE_DISABLE                        (0x00000000)
@@ -352,4 +358,32 @@
 #define NVC57D_HEAD_SET_CONTEXT_DMA_OLUT_HANDLE                                 31:0
 #define NVC57D_HEAD_SET_OFFSET_OLUT(a)                                          (0x0000228C + (a)*0x00000400)
 #define NVC57D_HEAD_SET_OFFSET_OLUT_ORIGIN                                      31:0
+#define NVC57D_HEAD_SET_OCSC1CONTROL(a)                                         (0x0000229C + (a)*0x00000400)
+#define NVC57D_HEAD_SET_OCSC1CONTROL_ENABLE                                     0:0
+#define NVC57D_HEAD_SET_OCSC1CONTROL_ENABLE_DISABLE                             (0x00000000)
+#define NVC57D_HEAD_SET_OCSC1CONTROL_ENABLE_ENABLE                              (0x00000001)
+#define NVC57D_HEAD_SET_OCSC1COEFFICIENT_C00(a)                                 (0x000022A0 + (a)*0x00000400)
+#define NVC57D_HEAD_SET_OCSC1COEFFICIENT_C00_VALUE                              20:0
+#define NVC57D_HEAD_SET_OCSC1COEFFICIENT_C01(a)                                 (0x000022A4 + (a)*0x00000400)
+#define NVC57D_HEAD_SET_OCSC1COEFFICIENT_C01_VALUE                              20:0
+#define NVC57D_HEAD_SET_OCSC1COEFFICIENT_C02(a)                                 (0x000022A8 + (a)*0x00000400)
+#define NVC57D_HEAD_SET_OCSC1COEFFICIENT_C02_VALUE                              20:0
+#define NVC57D_HEAD_SET_OCSC1COEFFICIENT_C03(a)                                 (0x000022AC + (a)*0x00000400)
+#define NVC57D_HEAD_SET_OCSC1COEFFICIENT_C03_VALUE                              20:0
+#define NVC57D_HEAD_SET_OCSC1COEFFICIENT_C10(a)                                 (0x000022B0 + (a)*0x00000400)
+#define NVC57D_HEAD_SET_OCSC1COEFFICIENT_C10_VALUE                              20:0
+#define NVC57D_HEAD_SET_OCSC1COEFFICIENT_C11(a)                                 (0x000022B4 + (a)*0x00000400)
+#define NVC57D_HEAD_SET_OCSC1COEFFICIENT_C11_VALUE                              20:0
+#define NVC57D_HEAD_SET_OCSC1COEFFICIENT_C12(a)                                 (0x000022B8 + (a)*0x00000400)
+#define NVC57D_HEAD_SET_OCSC1COEFFICIENT_C12_VALUE                              20:0
+#define NVC57D_HEAD_SET_OCSC1COEFFICIENT_C13(a)                                 (0x000022BC + (a)*0x00000400)
+#define NVC57D_HEAD_SET_OCSC1COEFFICIENT_C13_VALUE                              20:0
+#define NVC57D_HEAD_SET_OCSC1COEFFICIENT_C20(a)                                 (0x000022C0 + (a)*0x00000400)
+#define NVC57D_HEAD_SET_OCSC1COEFFICIENT_C20_VALUE                              20:0
+#define NVC57D_HEAD_SET_OCSC1COEFFICIENT_C21(a)                                 (0x000022C4 + (a)*0x00000400)
+#define NVC57D_HEAD_SET_OCSC1COEFFICIENT_C21_VALUE                              20:0
+#define NVC57D_HEAD_SET_OCSC1COEFFICIENT_C22(a)                                 (0x000022C8 + (a)*0x00000400)
+#define NVC57D_HEAD_SET_OCSC1COEFFICIENT_C22_VALUE                              20:0
+#define NVC57D_HEAD_SET_OCSC1COEFFICIENT_C23(a)                                 (0x000022CC + (a)*0x00000400)
+#define NVC57D_HEAD_SET_OCSC1COEFFICIENT_C23_VALUE                              20:0
 #endif // _clC57d_h
-- 
2.53.0

