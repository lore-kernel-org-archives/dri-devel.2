Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10530606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kvqO87V/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 381AD10E2CA;
	Sun, 15 Nov 2026 08:58:49 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7ABD10E1D1
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 08:58:41 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c4cdc606b47so441718566b.0
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 00:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794733120; x=1795337920; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lX4a0Ka8ixKkPEy+ySSNBY0xRQ2Dwb5GC2sClh81gUM=;
 b=kvqO87V/qcz9aSvRp4kIIqbtSY1NbHZ3N0QBn+tEdena3Jkh8f+XjxdbNU1PN4fPMO
 a3C1gIl6crrTCCBPh3LsCqs0hFf/pyfrMNXse2j8gA8/TaB3gXxzeYHQ5WHDZMdXxyK0
 LcZMWDdyNgmmHHQeZBXUJ+L+qnK31njRvr64xnkR58HVibr36vfKFPf6ecatue8Zr5+B
 4pfh+aOolGzlH5w7EK/ZNn+soOqRh/R4N9ql4Y+ZoDtltLr0fBmbw90O2qMZylMysLEm
 09wSm7+f9mCxWI+QQvi1rz1Bw4WgniqrJkd+ha7Rjv1wft5RLOSjmRn1J5z7tzEFDHbh
 mbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794733120; x=1795337920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lX4a0Ka8ixKkPEy+ySSNBY0xRQ2Dwb5GC2sClh81gUM=;
 b=x9v4uQg0OLgfB/9LFihjZLV/WHQqd7oEFfM+7OiGlyeMOrfNyAEOurzp6n4wIIG0CI
 Jvss/PaLF9C5xwAGy9q8SGzZTokMIk9laR1qT+oqVRpceKWdmqdhGMZS9U/lZxWsuoeF
 /L0N5XkHLZxOwMr8nuK4i1k3wW4GuM9omgwcxDfRQAA8zqHrXQJZWV9TfydqY+R9qREQ
 NSi/43BAKJtBuBFMxww90KrQsRkhhP13OMeCXhVNpVDd5RK9F+gu6/+WxD1FlK6t7Voa
 Lb3p7cexnzdhwi43z2N5yivnUWvV1Y+Msut34toPpoo9EtW96Sw20n61vHpyW6M8zcum
 rZ1A==
X-Forwarded-Encrypted: i=1;
 AL+hErF1RZIO3R5Ta96jjQVANBnDIH22Mt3pSwXPB+0N2Nx5AhUrozxosn96FGnKklI2iSxSBAtx2yvclGA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/cxR8ZC25TMYtzs84ZSK4W7qoWbEN31THegNVBWj0iEiD0n4iv
 GkrX/VJwbrz0SMBq9Digf4tNlBGCr8+qzA8VZ1cd8ngrG3MdSJXmfD6i
X-Gm-Gg: AYBFou3TOcJ2kq8luVbzZL8/l7cIDPOYoYh7gAhDil1n8Vtl9xTk5FF8uG08hL+0Shv
 epJfT43GkWWy+MGN4hr0FX0d+sjXx5GCeVJpxln/li1jILRIS/0LtLqLlajJW0HyVaI9u1utBMh
 pxaPsj4w3MMeHR6odNhRJYtmxSRvSotBzf6X+H3jAXKLf7WU3lS+PugAKqyUypaFonU6hh7avlo
 Tzi+DDv4K57PYAdbCrhoJ6w4p6TD9CByN0Sv2NC4mEEsOSwTaVxTGRUYWy8q0K/1+oly8yFge7E
 L2Y98Ylb/obU7CFqTkmZKv0m8bdZua7iSfoWnoudShEK70UWQhGXEuv0TeuqijrxurSY8PXQ7Il
 ir3U8Lk7hXMbAKVFT6h7ot9uAasHwOtWeM0Nwqxr8BDwXCH2Pb0gRsWraKWt+GxNyYMg0iY8xfV
 ok8dcdATy7Tp0yccKsMUL7Td6FLySln3h340Ze1702les1E1PEI3NLoosMRKV73J0BZn0Q1QSh7
 jsqNaH4w02timhAFU5pkYbkFZ8d/r1z72v+xoDCJ4uED6Ihbzb3WW4fB7Tmal+Zfsaz7FU5j8E7
 YULvPDs/nufU1rE1z8vRs3geru7RBY3Dkao5JjSrvuVMY2hh8N7Wcv6LUfk4zHN/rhPgFyep9fr
 H3/0o4ycTtNWI+hYMV6vTt6A5Nyr3yQ0=
X-Received: by 2002:a17:907:3f20:b0:c41:4d5:e97c with SMTP id
 a640c23a62f3a-c509640f665mr613525366b.37.1794733120092; 
 Sun, 15 Nov 2026 00:58:40 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095a5c4b7sm287613266b.1.2026.11.15.00.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 00:58:39 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Griffin Kroah-Hartman <griffin@kroah.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v7 2/4] backlight: aat2870: Derive brightness steps from max
 current
Date: Sun, 15 Nov 2026 10:58:23 +0200
Message-ID: <20261115085826.89641-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115085826.89641-1-clamor95@gmail.com>
References: <20261115085826.89641-1-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The AAT2870 allows only 32 steps of brightness, with this amount defined
by the maximum supported current. Remove the need for max_brightness by
calculating the allowed number of steps from the maximum current.

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
Reviewed-by: Griffin Kroah-Hartman <griffin@kroah.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/backlight/aat2870_bl.c | 35 +++++++++-------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backlight/aat2870_bl.c
index 5af36d3784f11..ea955b55bca18 100644
--- a/drivers/video/backlight/aat2870_bl.c
+++ b/drivers/video/backlight/aat2870_bl.c
@@ -20,22 +20,9 @@ struct aat2870_bl_driver_data {
 	struct backlight_device *bd;
 
 	int channels;
-	int max_current;
 	int brightness; /* current brightness */
 };
 
-static inline int aat2870_brightness(struct aat2870_bl_driver_data *aat2870_bl,
-				     int brightness)
-{
-	struct backlight_device *bd = aat2870_bl->bd;
-	int val;
-
-	val = brightness * (aat2870_bl->max_current - 1);
-	val /= bd->props.max_brightness;
-
-	return val;
-}
-
 static inline int aat2870_bl_enable(struct aat2870_bl_driver_data *aat2870_bl)
 {
 	struct aat2870_data *aat2870
@@ -69,10 +56,11 @@ static int aat2870_bl_update_status(struct backlight_device *bd)
 	dev_dbg(&bd->dev, "brightness=%d, power=%d, state=%d\n",
 		 bd->props.brightness, bd->props.power, bd->props.state);
 
-	ret = aat2870->write(aat2870, AAT2870_BLM,
-			     (u8)aat2870_brightness(aat2870_bl, brightness));
-	if (ret < 0)
-		return ret;
+	if (brightness) {
+		ret = aat2870->write(aat2870, AAT2870_BLM, (u8)brightness - 1);
+		if (ret < 0)
+			return ret;
+	}
 
 	if (brightness == 0) {
 		ret = aat2870_bl_disable(aat2870_bl);
@@ -143,15 +131,14 @@ static int aat2870_bl_probe(struct platform_device *pdev)
 	else
 		aat2870_bl->channels = AAT2870_BL_CH_ALL;
 
+	/*
+	 * The maximum number of brightness steps is determined by the max current.
+	 * The aat2870_current enum maps directly to the allowed brightness steps.
+	 */
 	if (pdata->max_current > 0)
-		aat2870_bl->max_current = pdata->max_current;
-	else
-		aat2870_bl->max_current = AAT2870_CURRENT_27_9;
-
-	if (pdata->max_brightness > 0)
-		bd->props.max_brightness = pdata->max_brightness;
+		bd->props.max_brightness = pdata->max_current;
 	else
-		bd->props.max_brightness = 255;
+		bd->props.max_brightness = AAT2870_CURRENT_27_9;
 
 	aat2870_bl->brightness = 0;
 	bd->props.power = BACKLIGHT_POWER_ON;
-- 
2.53.0

