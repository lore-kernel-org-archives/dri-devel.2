Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B05606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tDQGySs+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E291112C40;
	Fri,  6 Nov 2026 09:18:48 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8923810E2F9
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:07:19 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso25180565e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 12:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793909238; x=1794514038; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M8yk4UoM0PWyZhp628ipm0Nb1+FaTd9tnw6+7GjamRk=;
 b=tDQGySs+wVh72YLlFxWtnXJb/48bXmwb4mebk/btJSs8uiGWkU2QpdHhqHzmYPOBF8
 lfhFy2SR9nqJ6/lK+Nma8G2TBeMYRZmsMbj6FLRhzIpt+SN+ABSaLEa1hwjy3+gigb+w
 +tBORumogOrPu5PKrzqFSz5YH0Xrlkuky7tzQmYC5zF0lmECBCoCfL97V36AikJMnY7L
 8LZd2WehuW4q+E7AkeWhCuwY1DaCx90N5WYl581o6d1UEGyKDruxFReosm7QCZD08yrj
 NFww1X6Nsvg65Ow1duKY5ntq8kYLmtYm53SCn4wkKG3MgjVm5Qlc0RQAC5IWYGpMsiHF
 QSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793909238; x=1794514038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=M8yk4UoM0PWyZhp628ipm0Nb1+FaTd9tnw6+7GjamRk=;
 b=RwCI11CB2v2l7wMB9od1WmUAzma3wIZpLV1NoL+FikqksvJb1wdi1NUObBGUnwQ7Ak
 px+eekr58LT70xuU8Fd7dkUvGe3NIMXRF/dVi+none3g06jqRaxJarY1lYNo4oWIbftJ
 J/LK3myQC7ciMqSYhaMGmqbCLvCsSxt56lbKMCC55zbkxxu4CzMiWRMxpv6B9Bnd2MFg
 0qam6rroIPHoFH4mORDFXi3CSm8QubW2dVC9PdonSwi5Mbo/qGcAAPRFq/cuGl1GTXUc
 D/PGakjYq4iYrvhLZtAovtVh5apCRZI2EkubcsGrcIAxom8143GU5kG5L7Hu17vhUpv3
 XWWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy9Sqb4x7Io60lRme7jeWtvD9olRmE2KA3ELZWGbPYPxkgYqPxU0D1rCKCqsDGaFYTSe5ng7/qKKxk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8U83SsZnafkpdXMZPF0aygecm819jSzOM3o1Hp2HhM3Gjr9oUR
 vFfQUuJRyAdPbYRqHgOASCWg5OEBRN5Rf7QyBalqaUt0+q6LlAXaibZR
X-Gm-Gg: AYBFou07krRIbTD7/b8UyaOPK78krxTa6zLFAnakwGy4wQC3oaIBf+Kefcuy8OQVB0P
 60zX8sAEJDm7bhvAbVKj5aBi48AT7ID9gr/EViUK6tRsBg8SLuuh72it++8p7Hc9TAL8oBa/Ekz
 F9I3V8WCd5OeS8C7kFdrQeb3GQwqdV0SFZJ4uFWxOkE0jUMyTgmSBhbNpvAtd0Pc4FUTIkCqhIG
 ey/lpGHq/ZD8G2v481nA2l4h1TnibevHDLQxrFA1IuULcoytRsb8x4L/82VBMUxDqqhTYq+s4jv
 3jYGL52PKnLxnZdC59fw3oXotbiOpRJf8o3dAJHfVozcyHok3lHOwtTNsqd+/ztlEKJbZOjHekn
 IQ4mDCcojBWY400Z9UO8pD8SkJx9nrJ4C/KbNuCzSl8HjLzb40x14CJZWJocPIQbJs5lnqkwRA3
 hnjo1MWknp8CcfKro/DLGbq19luTC6cPdktECLAwiNY4rpcpeD9V9M4rw9sgYsOYejAJZOK9gEn
 fO6VtR7Rjo49cz1iVIpu2Yq5ueILO8fLNqqhHGKTlufktbOxhOcrjcGF1nRmGykvcnJrZooLnBz
 IE4xwnNAg8aA7pnRiJ4QJ9pJdioy98f/nADPcuriq0ZL9AkxvMkxCo9WxcE=
X-Received: by 2002:a05:600c:138c:b0:4b6:5dac:b61e with SMTP id
 5b1f17b1804b1-4b6df6df5d9mr3339265e9.32.1793909237922; 
 Thu, 05 Nov 2026 12:07:17 -0800 (PST)
Received: from antoniarch (78-212-29-45.subs.proxad.net. [78.212.29.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b433ebd278sm131671835e9.3.2026.11.05.12.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 12:07:17 -0800 (PST)
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
Subject: [PATCH 2/3] ARM: dts: am33xx-l4: Add missing DMAs for I2C controllers
Date: Thu,  5 Nov 2026 21:05:53 +0100
Message-ID: <20261105200556.34240-4-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105200556.34240-2-apokusinski01@gmail.com>
References: <20261105200556.34240-2-apokusinski01@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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

The i2c0 and i2c1 controllers on AM33xx support TX and RX DMA
requests. Add the EDMA request mappings and DMA names for
both controllers.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi b/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
index 57a45609f9f5..89fb1d1eb049 100644
--- a/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
@@ -239,6 +239,8 @@ i2c0: i2c@0 {
 				reg = <0x0 0x1000>;
 				interrupts = <70>;
 				status = "disabled";
+				dmas = <&edma 58 0>, <&edma 59 0>;
+				dma-names = "tx", "rx";
 			};
 		};
 
@@ -1189,6 +1191,8 @@ i2c1: i2c@0 {
 				reg = <0x0 0x1000>;
 				interrupts = <71>;
 				status = "disabled";
+				dmas = <&edma 60 0>, <&edma 61 0>;
+				dma-names = "tx", "rx";
 			};
 		};
 
-- 
2.56.0

