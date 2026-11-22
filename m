Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFB7606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=aU5C9H5w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB09B10E2E0;
	Sun, 22 Nov 2026 15:47:45 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B34810E28E
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 15:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=2qdjp2ma6GziNpWie7aRmBjMaJqhYZ4Ns3+DoQD46PE=; t=1795362454; x=2110722454; 
 b=aU5C9H5wJi2sZ0YmeYfs3y8XPOUEuyhoGk2PF6PuGkEVqG/OwSOfqQPCBc99McU7B6KRszHrH71
 3ch1oesI6Zr5WEwDpCuIpnYIyFuUReQVsvxdJAkYq430rVZgABPuZWsaeocoXt0AqJNGZ7UQ9m0sM
 Tfr9s8PfmoRx8Q0Y5pDqopB0855DPSE0A87QvgxEA3exT2zDhgT+j99d+P/JBVNl3VoJygRs9xSHf
 zwQytYM7+RCOidbQ1ZaM5FK3karW2UCCiCAmW8TpFzj7q9aXfIzUre/edxpQv2As79FuWxLB6QiTX
 yFk6OcPXbLtgQwcCbF0iuKIM7MNDKr9HP+TA==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xV9mu-00000002er2-2ooI; Sun, 22 Nov 2026 16:47:32 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 22 Nov 2026 12:47:23 -0300
Subject: [PATCH 1/2] dt-bindings: gpu: v3d: Require resets for BCM2711 and
 BCM2712
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261122-v3d-remove-33-41-v1-1-52152b454ad8@igalia.com>
References: <20261122-v3d-remove-33-41-v1-0-52152b454ad8@igalia.com>
In-Reply-To: <20261122-v3d-remove-33-41-v1-0-52152b454ad8@igalia.com>
To: Iago Toral <itoral@igalia.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Melissa Wen <mwen@igalia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1099; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=2ZFLVlkZjB5+Zv1b8WTNaVPfKQOEYPDvPhWVyPmnJ6A=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBrAw6OtGBXbiqv4VElVP8K3g5wELV7vheKEPepx
 p3VU3FUUqWJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCawMOjgAKCRA/8w6Kdoj6
 ql/xB/9uVjg2KkbMj83qLs4SS5Wq15y2vDKbqh/QoBs0qn1/rFOpXGfZlh8vjDMa86UStK4AcSa
 xF1hDVRl1UPzY8m66ghfxgbcQQcDVLkdvTa/OcIIdXVeV4GHjAiOWEHjXyYI7M4vW0EDUoB1YSn
 M1daqdBCZbgoQiI12/03YqiDS5f6Szhh053HNTXKpkmmCXZaW1WZlmL0/R9JA3LZ1kHC5xKM/0p
 UGOzCzQlKmgohUfsRl1CpaGEQWL/mCu7cOzXuhx3SKWD4+TkrN1Rw7MDb083HpFFn4owXQPbvjt
 tvzrgCf8dkZw5b+8FqwXRu16CK9Z/glH2SPdJMAU8reoBzpB
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

BCM2711 and BCM2712 reset V3D through the reset controller and have no
bridge registers to fall back on. Make "resets" required for them.

BCM7268 and BCM7278 have a register set for bridge resets, so "resets"
remains optional for them.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml b/Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml
index 43c6d2d72456..45bd54a633a7 100644
--- a/Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml
+++ b/Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml
@@ -66,6 +66,8 @@ allOf:
           items:
             - const: hub
             - const: core0
+      required:
+        - resets
   - if:
       properties:
         compatible:
@@ -83,6 +85,8 @@ allOf:
             - const: hub
             - const: core0
             - const: sms
+      required:
+        - resets
   - if:
       properties:
         compatible:

-- 
2.56.0

