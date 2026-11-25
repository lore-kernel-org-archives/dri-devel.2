Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEA4606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=alessandro.zini@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=I3YmTEFk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E60E01120A3;
	Thu, 26 Nov 2026 08:09:02 +0000 (UTC)
X-Greylist: delayed 602 seconds by postgrey-1.36 at gabe;
 Wed, 25 Nov 2026 10:37:33 UTC
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2506A10FB0E
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:37:33 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20261125102729df5073accf0002072b
 for <dri-devel@lists.freedesktop.org>;
 Wed, 25 Nov 2026 11:27:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alessandro.zini@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+1eDKjoOcrtWwLGX9PBuZf4Wp7y6OLqWwRZOf/G6PLA=;
 b=I3YmTEFkZMv7N02Kv83dOyyXsRhf7JpOdoy1c6y0ADCFt0Tsk9jdYDvgarTTrIhpl8y6nF
 /PGiqGtV2ElAtGO3Zz00BpyBaBYqDEKXHsJtwJ1u7ujplfDfkhyNO1ov5NHVpbwpe/DiquIt
 035pIHZeCFm3EllSva7VprR8ejgyR7Qtl1W57oWRokC+jU+TbW8j2lJ2rrUXgAQlhbdup4Jw
 RyUivOgS3irZPuLrymutRTYEnu5bSevhuEI8Gqirb5hoSYwVuImvdozuNxJtIgBYHqOPB0ea
 wYnlwqun7cOJqxfwMIy9fe+Cp1isyGjPDcJd8oQv35NQDvXKSW7zUSCg==;
From: Alessandro Zini <alessandro.zini@siemens.com>
To: neil.armstrong@linaro.org, jesszhan0024@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, thierry.reding@gmail.com,
 sam@ravnborg.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, Wang Yang <yang.wang-wy@siemens.com>,
 Alessandro Zini <alessandro.zini@siemens.com>
Subject: [PATCH 2/3] dt-bindings: display: simple: Add Goworld ILI6150H6 panel
Date: Wed, 25 Nov 2026 11:26:59 +0100
Message-ID: <20261125102700.126248-3-alessandro.zini@siemens.com>
In-Reply-To: <20261125102700.126248-1-alessandro.zini@siemens.com>
References: <20261125102700.126248-1-alessandro.zini@siemens.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1327013:519-21489:flowmailer
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:59 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document the compatible string for the Shantou Goworld Display
Technology Co., Ltd. ILI6150H6 7.0" 1024x600 single-channel 24-bit LVDS
(SPWG) TFT LCD panel, which is driven by the panel-simple driver.

Signed-off-by: Alessandro Zini <alessandro.zini@siemens.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 11d4a8275ecde..3c664175b528b 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -154,6 +154,8 @@ properties:
       - giantplus,gpg48273qs5
         # GiantPlus GPM940B0 3.0" QVGA TFT LCD panel
       - giantplus,gpm940b0
+        # Shantou Goworld Display Technology Co., Ltd. ILI6150H6 7.0" 1024x600 LVDS TFT LCD panel
+      - goworld,ili6150h6
         # HannStar Display Corp. HSD070PWW1 7.0" WXGA TFT LCD panel
       - hannstar,hsd070pww1
         # HannStar Display Corp. HSD100PXN1 10.1" XGA LVDS panel
-- 
2.56.1

