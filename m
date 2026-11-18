Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A503606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z/fj1YHi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3005910FCD5;
	Thu, 19 Nov 2026 07:48:48 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3821110ECAE
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 20:53:11 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c247f6687dcso222420366b.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795035189; x=1795639989; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yM3BPJ8QKqRePbbotO/o8nLTIwSIfzAlG3YqharGRPA=;
 b=z/fj1YHia66pHA3OYzS00qjAd+FrSLM5oJ4Y2lMxU+pAbCuQOnFbM0ajiqXbjMvAV7
 O6OCmOkqJwzvV2eEIHP08rIfmT6+/cslgAllHrTw2ehop1QUnTdZ6zoNboBUjYZjdLEx
 dw1CVcWG1WZn+qoMOHnHih78HpJ5xteb20HKLeBYOMWcMjGoc3dln/5v8XxIHrcwD8Nf
 ItNBvkDbSarpxotiEK6RXP+MBL3uCMPLHvmCGmonX5ItCW+QiyYaphjDQAldLJ5ZmtjA
 C/dQgTyzoolfEdSHztPZoglvy/Hh/BojLa9NnavgjHEADEjEXjbZJFtDp1iCo6v97V1H
 Sb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795035189; x=1795639989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yM3BPJ8QKqRePbbotO/o8nLTIwSIfzAlG3YqharGRPA=;
 b=S8Zj8QfZfTpDUn80boVCtapBVTVSiPAKWD6l9bYqIJleH4Dd2RnEoTigWY0zO0Qm4Z
 8MFbtLLZMV1y31n1RhhY+uaRtXj6fKQY3GHfy3NruDQUvVQnyXvZ2Y6s/BUVKrGD46IT
 b/a7EwbFgw2xpAKGlt1ZwLsf2eYkjzhUXl2QPBYi6dNmaCHHVkClZBLEYwKjurQ87O7V
 E8P3Wcl4ukV+/Jw5Eay49tnZwp87/iggPJ26RfhLc9ecAW2ehvSjy4+hVtJnYhzO8/CW
 WTzhNAqW4Z1oOPg9TITpF0K7K0G26rizVdUNCRgcYHOjd0EkGIEk5AI+dRTVGhgDkasX
 fG+w==
X-Forwarded-Encrypted: i=1;
 AL+hErE9d4zu+WQPCPgwozOFPk4HEunKJfc6whgafgOxrfSrVsE08tP45qNDQIw76AE+mcXLrT7qbKoVd1g=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/AuxrWIZL3JBF8QQ7TkVG2eg8ZijzfqWZYPOnAlU13SmUqa+HJ
 AuiFcZBDmFcD8as3dn6CkDKuNrgwnIEWDBI68RwhENuGvnkuJBbn9fZW
X-Gm-Gg: AYBFou3QTLg/k0qD2M9T334kbdT4vbJl3hqTyLQiBs5oNrOuz2tR2DKyfKOd1MXwRK1
 7yHFqw+sp4cFB9kz+Fi+9UoHOqVIVYk4MvDuYk0gBCOWH+AR2YFnI4AE4OetXCnSPQMA6etkFwX
 iuJgQcT7e/u0HkZoGNwcfbYNItLwIKoWaBB/o9ALiJXoBmyN3dIKlmPR1Lgr5gVB4L9BiGX8RSn
 ArywmCOOVnW8g2U0gPGXuUMLvvjwbjnUNuaLDvErpbNxttlStP1cBTLb/v7eNnZiK1QJMc/FuKK
 LM+WGOXby+0Dp6UP+rnJfh6Hq4eLLCr46DnKkDvFO243cBswzF48JOxYpy9e5OlOoxcJgThFtB1
 F3n8FJ2WrQEWnuW1104cwQJia/QY26EMotmbHAJM/4fEzDuxmjmA1mDBsH2vmE0nWTv5HL0uSQY
 VvUtRCf5QJHe8fA5UrdEY6wLA50QZH2AyehDyatt79ij3DL6q3Z6qLAoDvdYOFRiJ4hn3fico/I
 YXkgllWjbVgdfePBW6AoVepfZYNYJk3nDulsLRTmGz2ChAxnjjCAGItpitZ8nIjDjbYJFn7wAhM
 AByPT/Hr3BzjvmCmy+2ledyHLsOBLRFCyZD5yDvpEJWKfFkB95AGUSEidqyN2A==
X-Received: by 2002:a17:906:9f8a:b0:c41:61b9:6ef6 with SMTP id
 a640c23a62f3a-c510e376c7dmr374133066b.27.1795035189529; 
 Wed, 18 Nov 2026 12:53:09 -0800 (PST)
Received: from antoniarch (84-40-238-230.cgnat.inetia.pl. [84.40.238.230])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5123421612sm35303166b.41.2026.11.18.12.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 12:53:09 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: vigneshr@ti.com, andi.shyti@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, aaro.koskinen@iki.fi,
 andreas@kemnade.info, khilman@baylibre.com, rogerq@kernel.org,
 tony@atomide.com, jmkrzyszt@gmail.com, sumit.semwal@linaro.org,
 christian.koenig@amd.com, phasta@kernel.org
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2 3/4] i2c: omap: remove unused is_rdr and is_xdr function
 arguments
Date: Wed, 18 Nov 2026 21:52:06 +0100
Message-ID: <20261118205213.88778-4-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118205213.88778-1-apokusinski01@gmail.com>
References: <20261118205213.88778-1-apokusinski01@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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

Both functions omap_i2c_{receive|transmit}_data() have unused arguments
is_{r|x}dr which can be deleted.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/i2c/busses/i2c-omap.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f02d294db42a..3f7060d57a86 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -996,8 +996,7 @@ static int errata_omap3_i462(struct omap_i2c_dev *omap)
 	return 0;
 }
 
-static void omap_i2c_receive_data(struct omap_i2c_dev *omap, u8 num_bytes,
-		bool is_rdr)
+static void omap_i2c_receive_data(struct omap_i2c_dev *omap, u8 num_bytes)
 {
 	u16		w;
 
@@ -1017,8 +1016,7 @@ static void omap_i2c_receive_data(struct omap_i2c_dev *omap, u8 num_bytes,
 	}
 }
 
-static int omap_i2c_transmit_data(struct omap_i2c_dev *omap, u8 num_bytes,
-		bool is_xdr)
+static int omap_i2c_transmit_data(struct omap_i2c_dev *omap, u8 num_bytes)
 {
 	u16		w;
 
@@ -1122,7 +1120,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 					OMAP_I2C_BUFSTAT_REG) >> 8) & 0x3F;
 			}
 
-			omap_i2c_receive_data(omap, num_bytes, true);
+			omap_i2c_receive_data(omap, num_bytes);
 			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_RDR);
 			continue;
 		}
@@ -1133,7 +1131,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 			if (omap->threshold)
 				num_bytes = omap->threshold;
 
-			omap_i2c_receive_data(omap, num_bytes, false);
+			omap_i2c_receive_data(omap, num_bytes);
 			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_RRDY);
 			continue;
 		}
@@ -1145,7 +1143,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 			if (omap->fifo_size)
 				num_bytes = omap->buf_len;
 
-			ret = omap_i2c_transmit_data(omap, num_bytes, true);
+			ret = omap_i2c_transmit_data(omap, num_bytes);
 			if (ret < 0)
 				break;
 
@@ -1160,7 +1158,7 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 			if (omap->threshold)
 				num_bytes = omap->threshold;
 
-			ret = omap_i2c_transmit_data(omap, num_bytes, false);
+			ret = omap_i2c_transmit_data(omap, num_bytes);
 			if (ret < 0)
 				break;
 
-- 
2.56.1

