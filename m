Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091C5C531D0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:59:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54DA810E2E9;
	Fri, 24 Jul 2026 00:59:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=mail.ru header.i=@mail.ru header.b="qkpoe/Ke";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="e8GtYPXp";
	dkim-atps=neutral
X-Greylist: delayed 923 seconds by postgrey-1.36 at gabe;
 Fri, 24 Jul 2026 00:59:47 UTC
Received: from send262.i.mail.ru (send262.i.mail.ru [95.163.59.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BC5710E2E9
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:X-Cloud-Ids;
 bh=Rtd8ky7Tg6XlaV1TWUuNmrWi3E8gwM7nMZLhgv4MPPc=; t=1784854787; x=1784944787; 
 b=qkpoe/KeCp4vclAhimgcjWqA3VH07OiV2VAjvLMKlENKqiCeTBHQjDIjzP54w4miE2233OUEAkb
 PvsqqsNU7143iyODwmESE8Ut2s5IaWV59gv0SPrmFnrtGZ2qTk2gDKEQnHtmZRIliPr7psX7OwsDh
 9PyBWXuJiC/s2Rsw/o70fIlD0B3V77rbHPvjcO5AthugBLRFwdsU0rdpFyVFElVReXJ5kW3yvn29a
 BTqbtARdPTt3pHJWU4wQicwEeHbQPjwUNjZ6CcUwbASpU9CPiS9s7YwukOsKxPOmHMoMPkzS/S/Dc
 /Ivxxcr49fKVd7JJj2rOlAw1g4Cq272+wYgg==;
Received: from [10.113.250.159] (port=35298 helo=send197.i.mail.ru)
 by exim-fallback-5cf4fc9bf6-r2bvk with esmtp (envelope-from
 <listdansp@mail.ru>)
 id 1wn41f-00000000GpX-01lz; Fri, 24 Jul 2026 03:44:31 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
 To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
 X-Cloud-Ids:Disposition-Notification-To;
 bh=Rtd8ky7Tg6XlaV1TWUuNmrWi3E8gwM7nMZLhgv4MPPc=; t=1784853871; x=1784943871; 
 b=e8GtYPXp1Fau+dtSeAB+4EikvQ/t0Uz6WjhRs8EKYCWH/qqgWl+QkMTUTVgiFsXPBtzQXQDsxrs
 ob/dXg7XpTuL0L2xjxCGLgg8/3VNspzwVDOmN+GPTYG9giFeVOcVdD9LWFaagKPwEtsUOYUhEPm5t
 obD+BD6CZvsA1mHBRQxC1h1CYJ2YoHgr6NjV6ZZvojFs0+iOUmgZhbCqMct1huNt2V6lVTThLbl/r
 2TQ9sLbJMrdSuKgV4iIxzDbBeonrjeXbHe36XQlGEfESKAXVzkr50V730CCoAdeRvEhRVRvDiWnuW
 nkKmVymS1ZapexpOHYywOB3JPe2WVGtUICuA==;
Received: by exim-smtp-6c76488b9f-8v22z with esmtpa (envelope-from
 <listdansp@mail.ru>)
 id 1wn41V-00000000DVg-35hX; Fri, 24 Jul 2026 03:44:22 +0300
From: Danila Chernetsov <listdansp@mail.ru>
To: Helge Deller <deller@gmx.de>
Cc: Danila Chernetsov <listdansp@mail.ru>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: [PATCH] video: fbdev: kyro: Validate overlay viewport coordinates
Date: Fri, 24 Jul 2026 00:42:45 +0000
Message-Id: <20260724004245.86764-1-listdansp@mail.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD93ED3C6BF6FFA701FD3C8ECD4FF8890A5380F22FAED472B72182A05F538085040F0329FB34171AA1C3DE06ABAFEAF6705B2F25C2E3F6C2D406E7FBB2604E51819C892232EBC88F8E3
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE79E448936ADEE6ED1C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6759CC434672EE6371C2A783ECEC0211ADC4224003CC836476D5A39DEEDB180909611E41BBFE2FEB2B425B3C7DD974D21E99D8ED0A570A0D9E3541874920DF14D8AC0BAA1718A056FB0C819B32DFABC24A725E5C173C3A84C30AA277257C6A5E3D117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC47272755C61AA17BA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735201E561CDFBCA1751F6FD1C55BDD38FC3FD2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEB28585415E75ADA945B9AC499A3C791CD8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE31DAA61796BF5227BC0837EA9F3D19764C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F79006371F786DB530BF6A41EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A5FF06105F19F045E55002B1117B3ED696446AD625B662FB47886DC9BC01168B20823CB91A9FED034534781492E4B8EEADF1165EFABA1780A6C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659D9211A6C063DF336D10A79C6D5479CC65398BA23D8F2FEFB5FB40F1AB36D860F9B42238A6BB07B20B8341EE9D5BE9A0ABE27447A2D41BFB87F99C81D8AE6C234641E20B7D76C708C721D270AA2B885D14C41F94D744909CE04437D853D7CD20871FE3B1D98EC473624A389F0E278DBF4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVYrk7BQKFwEtRb0VZaIGsl7/HKcDglhOzA==
X-Mailru-Sender: 4CE1109FD677D277C46683902DBBBB3CADBD7FD9A065D1F43DE06ABAFEAF6705B2F25C2E3F6C2D40977EED7048DEDC7C8A08967417F2D5E3FB559BB5D741EB96C31AF20DAA089319D7A14DD9E34ECE7467EA787935ED9F1B
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B486472E5A48B460E48232B7BA1535077BC45AB681B994A4B2049FFFDB7839CE9E426FEB9BE7554530A20C0A4E4655530875365ED4D4FD200EE5DB799F969F6D522813E4807F0BFD26
X-7FA49CB5: 0D63561A33F958A5E997EACC6F49A31F5002B1117B3ED696951B7014FDAC8C054E82D2634811542802ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZZPCF/+5TxQBDWC0la/4ZPg==
X-Mailru-MI: 20000000020000000000000800
X-Mras: Ok
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

The overlay viewport end coordinates are computed from the viewport
origin and dimensions using 32-bit unsigned arithmetic. Large input
values can cause these calculations to wrap around before the resulting
coordinates are passed to SetOverlayViewPort().

SetOverlayViewPort() packs the viewport coordinates into 16-bit
register fields. The X coordinates are additionally adjusted by +2
and +1 before being written. Validate the coordinate calculations
for 32-bit wraparound and ensure that the adjusted coordinates fit
within their 16-bit register fields before calling
SetOverlayViewPort().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Danila Chernetsov <listdansp@mail.ru>
---
 drivers/video/fbdev/kyro/fbdev.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
index d756b3603fa6..133c91716c49 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -369,6 +369,9 @@ static int kyro_dev_overlay_create(u32 ulWidth,
 
 static int kyro_dev_overlay_viewport_set(u32 x, u32 y, u32 ulWidth, u32 ulHeight)
 {
+	u32 right;
+	u32 bottom;
+
 	if (deviceInfo.ulOverlayOffset == 0)
 		/* probably haven't called CreateOverlay yet */
 		return -EINVAL;
@@ -378,11 +381,30 @@ static int kyro_dev_overlay_viewport_set(u32 x, u32 y, u32 ulWidth, u32 ulHeight
 	    (x < 2 && ulWidth + 2 == 0))
 		return -EINVAL;
 
+	/*
+	 * SetOverlayViewPort() adjusts X coordinates by +2 (left) and +1
+	 * (right) before packing them into 16-bit register fields.
+	 */
+	if (x > U16_MAX - 2 || y > U16_MAX)
+		return -EINVAL;
+
+	right = x + ulWidth;
+	bottom = y + ulHeight;
+
+	if (right < x || bottom < y)
+		return -EINVAL;
+
+	right--;
+	bottom--;
+
+	if (right > U16_MAX - 1 || bottom > U16_MAX)
+		return -EINVAL;
+
 	/* Stop Ramdac Output */
 	DisableRamdacOutput(deviceInfo.pSTGReg);
 
 	SetOverlayViewPort(deviceInfo.pSTGReg,
-			   x, y, x + ulWidth - 1, y + ulHeight - 1);
+			x, y, right, bottom);
 
 	EnableOverlayPlane(deviceInfo.pSTGReg);
 	/* Start Ramdac Output */
-- 
2.25.1

