Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51584606A32E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=alessandro.zini@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=ln/tdC+Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F27A112135;
	Thu, 26 Nov 2026 08:11:11 +0000 (UTC)
X-Greylist: delayed 601 seconds by postgrey-1.36 at gabe;
 Wed, 25 Nov 2026 10:29:51 UTC
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1EF110FAFF
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:29:51 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20261125101948aa42dbd68e000207f0
 for <dri-devel@lists.freedesktop.org>;
 Wed, 25 Nov 2026 11:19:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alessandro.zini@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+u+5Y9841agN8wYX0ru8kZoM+mbh0aExOkblBzQFQZY=;
 b=ln/tdC+YOYXf8NrZ6BL7WQFpN1AB8A2IPbTkNZoHaGvt7AJBX2hSgoaNAEud9Em7wnf1Up
 lK+ij9WpEAuEfbS9GRgvVnFHk9CtMmsNQio7W7CGbnqctF4nf/27/Xis4X/eGI6HQ/Srzq2W
 8kHLqwmv+mPYF9lGnMy2KWY6KX+ZukyfuLKHdrPrWNen9tAw6ZeL3NEb2kQlokjHTHj2iAyk
 Spoo+AbYNxbkCx9rwGgcL3AeITMuEoTnPc8lkTxmc7DinW5N7FC5qBgeI/W/5/lL0aNDugii
 /eodUkDzbXALITGehc8qVk2cGYyt3eb+xr65JPtq9UN6oJ5mwr3uXaVw==;
From: Alessandro Zini <alessandro.zini@siemens.com>
To: neil.armstrong@linaro.org, jesszhan0024@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, thierry.reding@gmail.com,
 sam@ravnborg.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, Andrej Valek <andrej.v@skyrain.eu>,
 Alessandro Zini <alessandro.zini@siemens.com>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Techshine
Date: Wed, 25 Nov 2026 11:19:34 +0100
Message-ID: <20261125101936.103094-2-alessandro.zini@siemens.com>
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

Add the vendor prefix for Guangxi Techshine Electronics Co., Ltd., the
manufacturer of the TS-P0700031A LVDS panel.

Signed-off-by: Alessandro Zini <alessandro.zini@siemens.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a846ae023584e..6e896c342f637 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1726,6 +1726,8 @@ patternProperties:
     description: TechNexion
   "^technologic,.*":
     description: Technologic Systems
+  "^techshine,.*":
+    description: Guangxi Techshine Electronics Co., Ltd.
   "^techstar,.*":
     description: Shenzhen Techstar Electronics Co., Ltd.
   "^techvision,.*":
-- 
2.56.1

