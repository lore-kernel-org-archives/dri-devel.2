Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF52606A32D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=alessandro.zini@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=bfORKQLy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4510A112128;
	Thu, 26 Nov 2026 08:11:05 +0000 (UTC)
X-Greylist: delayed 602 seconds by postgrey-1.36 at gabe;
 Wed, 25 Nov 2026 10:29:54 UTC
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E3E710FB03
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:29:54 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 2026112510195063a13d7365000207e5
 for <dri-devel@lists.freedesktop.org>;
 Wed, 25 Nov 2026 11:19:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alessandro.zini@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Tp8EWDBlw09/za6VVbHUXILROD5Fv65N0+O1lixBQxY=;
 b=bfORKQLysZN2zJIoLiYn5hqAfNjLtEPEN6RxM1uVUrzE22cpfV0nY16tlQ4lSHfLNiWCXL
 Qkt/bhFBzarbS0kYbb3wL+9pBZU3xwHZifAWlvbDn6KrFUMNLu9Hbhz95Nb2S//VD+W07CRU
 b70Cnqr8IGoEmYeSSRZeyAZv0WzaG3/jBMxJnok+hIFJ/yO0ZA5un2+SU52JVPFJP6PJX4y5
 XByxlDHBCWf5EEzMMuEMOBQrejy/97hYKruORudFeNoGO+Vpsy1gkUIsvQZ09q19VyspSU1L
 s2O2060am1xFt07SPy+kUR1bV4WNE8yNVtkMuzMvO8YNklYrwygQ0GPQ==;
From: Alessandro Zini <alessandro.zini@siemens.com>
To: neil.armstrong@linaro.org, jesszhan0024@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, thierry.reding@gmail.com,
 sam@ravnborg.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, Andrej Valek <andrej.v@skyrain.eu>,
 Alessandro Zini <alessandro.zini@siemens.com>
Subject: [PATCH 2/3] dt-bindings: display: simple: Add Techshine TS-P0700031A
 panel
Date: Wed, 25 Nov 2026 11:19:35 +0100
Message-ID: <20261125101936.103094-3-alessandro.zini@siemens.com>
In-Reply-To: <20261125101936.103094-1-alessandro.zini@siemens.com>
References: <20261125101936.103094-1-alessandro.zini@siemens.com>
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

Document the compatible string for the Guangxi Techshine Electronics
Co., Ltd. TS-P0700031A 1024x600 single-channel 24-bit LVDS (SPWG) TFT
LCD panel, which is driven by the panel-simple driver.

Signed-off-by: Alessandro Zini <alessandro.zini@siemens.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 11d4a8275ecde..385ee9acf5e1b 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -318,6 +318,8 @@ properties:
       - startek,kd070wvfpa
         # Team Source Display Technology TST043015CMHX 4.3" WQVGA TFT LCD panel
       - team-source-display,tst043015cmhx
+        # Guangxi Techshine Electronics Co., Ltd. TS-P0700031A 1024x600 LVDS TFT LCD panel
+      - techshine,ts-p0700031a
         # Tianma Micro-electronics P0700WXF1MBAA 7.0" WXGA (1280x800) LVDS TFT LCD panel
       - tianma,p0700wxf1mbaa
         # Tianma Micro-electronics TM050RDH03 5.0" WVGA TFT LCD panel
-- 
2.56.1

