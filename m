Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAA7C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 22:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2079F10F1C4;
	Thu, 20 Aug 2026 22:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.pl header.i=@yahoo.pl header.b="IVuRbm2d";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-euwe1-0017.asd.mail.yahoo.com
 [34.2.82.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BFE510F104
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 16:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048;
 t=1787245100; bh=20T8mnv+fo+0/Ee4L8ZXZ+KnWYflUPcl5mZUhp2ixas=;
 h=From:Date:Subject:To:Cc:References:From:Subject:Reply-To;
 b=IVuRbm2dGqY6BEEL/vnxA0wcb26KcIUv9Hjphxx6fE2dvGKrQMC/T2kDGPJp2BvSLe1LwDisZwSyudRUl2yC/t0uvEXmMzr1t2N+WYFZ+SSukCWsBKdDMIAFKfbf1+M3fMUdWZPSYSpLYdQmFqTNm9qFrrONbXy8L3SygBGQomv7q99IoGGpwO/fNEYFYwkp7Fu8Z6JBSLpiHXcFRs2LzkQbESOwS/eq43FSMUQviT9ghl/2smuPUIB6WpVgz8NuXNwyPdiMFpsRTdETOagCw/ZZd6b3kmGEDKZubPVOCQXOTb4zbZOw2Xi7y48o6j/G4AMT+WPyslhWZK4wAULbOA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787245100; bh=gE8N1VxA+5ErlNxa526OLY2U2sgwN7vvxkwH2J/sc2L=;
 h=X-Sonic-MF:From:Date:Subject:To:From:Subject;
 b=hGWmpPnV5KfMKBTYd1Y38gscH+41ZgE6JkwxX5fpZYhq3YlTHS0Uf50qrrTyWEYyJP5Fv2OufeZEWDjJgUVnlCksioD+q8v2gowwcnHc7Iq3fvB4qH9i+gkW4PJ80gcACplMq6p5193YCZ83vo8z+jdfjlo4WKaecywdpK0UBmpYqrOb1527JzSKuV6TbfN8tjDIht50usoh4HLLmeZC38NcWbgTS+dw61UmC0rqukPAVGRg9hZDVOA8x3K2XBjPfSMcitlCdDOcsQd1QFlTlGUDsAbD/V86BW1XU+pOHC1+7TZEkRnCavs6DsZz/M74885oURRatJ/ho+umLq75cg==
X-YMail-OSG: DRhStrYVM1k048MDc.Ky8NnvQQIY0rRNKS3Y6kbs4riPy8utRc0KKFdvkqraSkb
 8Bp448Vu6Dz35kLErW3_Xddn6NXDlQdAnpEG9GQ_f4s._s0qtaGydlcJmk5gKTr46o9Q01VgbSFm
 5UyjSqkWSwX5yx_VoXauuHL9hzq.h2On7mDbwOGQ6wGIUf2tx5kwJtyJeN7KDeqr.pE4eldxkVW9
 Fpb0_4WkjlcFAVJwrXyC97T0sKetTumlqpHtXcCoJAfbWY8sUF0Q19XHXZsE8Gze6rFeIGj4g5OY
 BNqCsBPungBD46nOW3a0b6xqO4EFiw6rjfn_6NfwWHB6NLYkmuVlINy8DSbYZuXQhjlPt2JmNEe7
 t5ToJQGOc2GkNmVhXFfLU9pwXv1RuUk3icDVf.VWuvr1TNadOcUuHecxtHWAGcKEMgdpBf6znpxF
 hXyyySzzC0C3ehOzk0xRWcNt_VjBL5rDCQvpelPCYfO0ukE9AfKw6bVKV8bog9IDwk9NdFYEirFT
 Nyr05z8WyK8qgOK00fTW6Fh555I7QBCAb1c4A9Q3IwAILhgXzPBX_t8yonTLw4MF8hP9JT9Wr5V5
 G2p6OM8y8RymXYBbAN_4CKMDUvrFSuH6wsWpgSNWplMiWTn01jm3ECmLiaEOLPei3UJfKjgPn0cO
 ey_ekjm.kHSSpocTj6FnmmfqYKu462IXS4VYFR4Nh4iDBOaPuPxk7KNRLU3NIq_604MNRVI_uyOB
 JNTSh5Qk5PzBXskcqCLPnNAb8XPkYZy0GwgjHxBOGkb3AADNyCTIgpZvb2IS8w.ytp2_KE_ydQjL
 glmGyRkRAu4SbMPIZxGPqjG.PriRYl.jSTxrhCtQjgnuLucoghGF.KGg0hYo6Cx7BIDSEz_uWN0d
 YglG9q8EMDIC4YhYOFTl4lPUH6WIwa01FlrRZa96KRDWUy2TpPMw_GJirXeaf5D8azxoHJqVODD2
 zfoOXFH60WVGXQr_wR3V9ks09yo0GgV3F_KZ6Lliel2IfzQBfEymHs71pI4bwrujY8zZxLNwbruc
 Lro1prd1VSGS5JA_GVefTcMNfDsRIfqjA2g1LbS9jawGd3Pnpp5eMQ7E0Vf1BV0u1o8YF_uKGNYg
 3qWpVkOVANQJpe1JV3k8Wjce2tIjFeojqFemXUSZ9fK_U58FQY9_CKia4wUGeLRdsCYqL8WmHmZm
 0FH4lWSyr8hIwllZXrMWXlF4z3t.khKnCzDRO79TgJCmks8ewcHxCPx_r3ZrQVPSnI9Q3BZFu65X
 11FVjVjNhYxB4bwwx.BSSvUnI9gYKLSgfbTbR7nw.anvKVZQRhGYq7hO20FTHxhvE6AniAQPX79t
 0FGAPLojAqttJpvdRCOQ2Hpf_oNe3gHuUdZwsQY8mRyEMl7i.TC0yZUPOtvFFI42rAAIWV4VAqOz
 ieNStF4ds_sc78sPVkKmOLpVwlBJnHajL1J9CJlMgv1z2m94yY63OsByKmb33A.J56eG7vKUyden
 4yEOofiMSCZWy_WzrkOkfHVapB5YCgjB2mLRhWQ1KgJz4cKhRZNxZpoGJkQ5wU0p8W.u9k8pPHjU
 9QPuSjRyQ0HmrxD5pmRwCWcJFs9pu7zRBgQMjcL.QVHxjKq8qLrWJsLZQ3q5bJoQoD7lc1p2_3is
 yLfoZtNObXyKkO7fy9pm9dzXPOCFqYCir_QrEwk46VrZuFryRm..IoyCRThHMZyu23CWLR9eNJiS
 iBkvULUCT2.LDIl9RLeO2RSwJzrKwXFjaf43RTBT_s1VjHKAcB1ukVkznFK2BZ6RumOwGD9hktr8
 zwq3qjb6328JCf_wO21IBlHRMRExZCjMkyl3OulS_.8aq64JYg9LvkYhDAxAdMF17Jb.AM9Z3W4X
 _OPQYHhdbTY.IyNf.LMrpUFLuEof5u.pnXCu37NdyCLN2KcMgcA17VEv70ke67tSf9Z51MpZJzt4
 KdnQiQFliktS7eVbypR1UWfbKabYRITY1OIC5tlGn.w1m6xn64JKZY0wQu2deuTLjJGOKihmQz1T
 PO8_8QxiIkVhmlYL6KbFDBx.Hd1jm69Jn7HDSkAYKkQ--
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: 190d7c3d-2ca3-47dd-a859-4ff0c5f6b921
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-euwe1-prod-sonicconsumer-svc-101 with HTTP;
 Thu, 20 Aug 2026 16:58:20 +0000
Received: from dip154.lsn.ir2.yahoo.com ([87.248.99.163])
 by hello (SMTP) with SMTP ID 8cc8ace8c40ab7de35cb50eca70dcdbd;
 Thu, 20 Aug 2026 16:58:15 +0000 (UTC)
From: Tomasz Unger <tomasz.unger@yahoo.pl>
Date: Thu, 20 Aug 2026 18:58:12 +0200
Subject: [PATCH v2] staging: fbtft: prefer snprintf over sprintf in
 fbtft-core.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-fbtft-v2-final-v2-1-44d107b04634@yahoo.pl>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ5FMBBA0V+RWZukZkH5FbFAp4xISdsnLxH/r
 liexb0nBPbCAZrsBM+HBNlcAuUZjHPvJkYxyUCKSqVJoR2ijXgQWnH9ipWuCzamMLpiSNHu2cr
 /Hbbd5/AbFh7jc4HrugHuaWz/cgAAAA==
X-Change-ID: 20260820-fbtft-v2-final-7891edd1d87e
To: Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Dan Carpenter <error27@gmail.com>, Tomasz Unger <tomasz.unger@yahoo.pl>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787245094; l=2352;
 i=tomasz.unger@yahoo.pl; s=20260311; h=from:subject:message-id;
 bh=Vb6a0nlxcTQQQNTbxhFquNvqg+VCLZ0UAyF94lMD/Og=;
 b=3b9EtNix8VYT957kW4pB9zzHtHrNt4t4E3UKE8alsCVDA4txh9vZLbGalXj3DxNQSdGg1lsEV
 xjLWB+So9s7CLnmCLQeEcjRRooDjIKAl/K+75NkYzGYu08w3QnAx7tU
X-Developer-Key: i=tomasz.unger@yahoo.pl; a=ed25519;
 pk=EPPsO91uz/0J2cTQ6ol+dgxYaieEc9dKSXWUb51n46c=
References: <20260820-fbtft-v2-final-v2-1-44d107b04634.ref@yahoo.pl>
X-Mailman-Approved-At: Thu, 20 Aug 2026 22:53:16 +0000
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

Using sprintf has potential for buffer overflows if the formatted
string exceeds the destination buffer size. Replace it with
snprintf, passing sizeof() of the fixed-size stack buffers
(text1[50] and text2[50]) so the write is always bounded.

An overflow is impossible here: even the worst case for the
argument types (size_t for text1, three ints for text2) still
fits within 50 bytes. Use snprintf() rather than scnprintf()
since the return value is not used here.

Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
---
Changes in v2 (per Dan Carpenter's review):
- Switched from scnprintf() to snprintf(), since the return
  value is unused.
- Reworded the commit message: overflow is impossible, not
  merely unlikely, and dropped detail about where the values
  come from.

Verified with checkpatch.pl - no errors or warnings.
Compiled the fbtft module successfully with CONFIG_FB_TFT=m.
fb.ko, syscopyarea.ko, sysimgblt.ko, sysfillrect.ko,
fb_sys_fops.ko and fbtft.ko all load without errors in a QEMU
environment (verified via insmod and lsmod, dmesg shows no
errors).
---
 drivers/staging/fbtft/fbtft-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index ca0c38221c16..9ea0442a337e 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -784,10 +784,10 @@ int fbtft_register_framebuffer(struct fb_info *fb_info)
 	fbtft_sysfs_init(par);
 
 	if (par->txbuf.buf && par->txbuf.len >= 1024)
-		sprintf(text1, ", %zu KiB buffer memory", par->txbuf.len >> 10);
+		snprintf(text1, sizeof(text1), ", %zu KiB buffer memory", par->txbuf.len >> 10);
 	if (spi)
-		sprintf(text2, ", spi%d.%d at %d MHz", spi->controller->bus_num,
-			spi_get_chipselect(spi, 0), spi->max_speed_hz / 1000000);
+		snprintf(text2, sizeof(text2), ", spi%d.%d at %d MHz", spi->controller->bus_num,
+			 spi_get_chipselect(spi, 0), spi->max_speed_hz / 1000000);
 	fb_dbg(fb_info,
 	       "%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
 	       fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,

---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260820-fbtft-v2-final-7891edd1d87e

Best regards,
--  
Tomasz Unger <tomasz.unger@yahoo.pl>

