Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8DB606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=alessandro.zini@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=c7S510qW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D89131120F6;
	Thu, 26 Nov 2026 08:09:16 +0000 (UTC)
X-Greylist: delayed 602 seconds by postgrey-1.36 at gabe;
 Wed, 25 Nov 2026 10:37:30 UTC
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6883E10FB0D
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:37:30 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 202611251027267a781ee7e900020774
 for <dri-devel@lists.freedesktop.org>;
 Wed, 25 Nov 2026 11:27:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alessandro.zini@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Y6uWceI6gpLxBxKPLgaAqLdMT3DH76IqAUvB8Og7sDw=;
 b=c7S510qWBbLU667g4AFTz6LEs349ZUa7MynApLhpcb8FMW10u/PwCr9NRgVUfQQyUeDUNC
 ly4q9Dk5VAtEDbNzQILQZixgYaYIuByc+SqX8lbIBKlG/dnmRiFPxjDD3Jo5Xu34JM1EEfW2
 E4ZiItxL0aS6tHWbqbJ5/ObLS91UB8ZnyfJfukz4XnTKcIKGn5vccAgA/NDrq/e33lqDOlJ5
 2/6/mf+RtCEor3QGhyOTQP2460KXSrG3qrODRD945vVY82VZvAnnuNHUK0gXqwANLwgbnzV8
 YmZ46CKHo0LIuhS3KwhCvmjipE89oxhM8AnyMqlLpEE5okkf/cNz4kGg==;
From: Alessandro Zini <alessandro.zini@siemens.com>
To: neil.armstrong@linaro.org, jesszhan0024@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, thierry.reding@gmail.com,
 sam@ravnborg.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, Wang Yang <yang.wang-wy@siemens.com>,
 Alessandro Zini <alessandro.zini@siemens.com>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Goworld
Date: Wed, 25 Nov 2026 11:26:58 +0100
Message-ID: <20261125102700.126248-2-alessandro.zini@siemens.com>
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

Add the vendor prefix for Shantou Goworld Display Technology Co., Ltd.,
the manufacturer of the ILI6150H6 LVDS panel.

Signed-off-by: Alessandro Zini <alessandro.zini@siemens.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a846ae023584e..c3515feddad22 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -708,6 +708,8 @@ patternProperties:
     description: Google, Inc.
   "^goramo,.*":
     description: Goramo Gorecki
+  "^goworld,.*":
+    description: Shantou Goworld Display Technology Co., Ltd.
   "^gplus,.*":
     description: GPLUS
   "^graperain,.*":
-- 
2.56.1

