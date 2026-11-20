Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564E5606A32A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QZ9TT60C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 098DD10E619;
	Sun, 22 Nov 2026 17:14:31 +0000 (UTC)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1E5910E6B7
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 20:56:44 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1b3ada81853so1536818c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795208204; x=1795813004; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=waGADWzE6IdQu0VH1ZdbZFR3KhKgWCtUwN6jG/+XHqY=;
 b=QZ9TT60C2ZLxojXUB6HCL76/aB61241oG2R2V96KFB9E92hPX7ReAR9T/2CXkr+c8G
 ENg6OHupXVzh5cqtKpY1l4dG8cUWEzCglTISZBJc+uixIbpPez92WD0s5ssSU8iWtiLf
 gw7RR7+rJH0EEGOxhiiqXS5FBLDdTVK8obks2baXIdj/HiH1r6CsfLd399ZM2tMN03qI
 WxlZQ5p0FpwIkYhrSmbqo7xNr0dlcY4nOTKAK/VyJa/g0Irz50u7Gf8R2x8earOOzcsd
 TRLYno+PD1nDymvH24LwFF8mCN2Hop8q5rU8WBwzgOIR1fPh1U3CzozN+PAHF9aPAwhR
 7OPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795208204; x=1795813004;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=waGADWzE6IdQu0VH1ZdbZFR3KhKgWCtUwN6jG/+XHqY=;
 b=jEUODVuZFJ+mZp9F82pPPJXgt1b7RVcW2oMJD7m0Vf68KMJiTmvvd5oTNNPxsSBLIf
 lHw2Ddp+8OlGeVaEvOGt08JOYz5Ir04SyJqzDqYd8OGbK5nnWEMCXn8Wc08IggFFAqI5
 xY85vxKTCfyb0cWULLFPNFx6A4rcxc0dIBYn6UlOEx137Y9kK6yqitG8iLeWEpMjHkei
 WqQFyCn+AdmVF23OZQvlwIQ3OIGUHf6pADgJQtmQG+YyNTpw9CJuOM/E+fSkRTYb+Y+K
 MpeFkdh0fjlSKoy0hY9QGYm3BSfPatsCvEt7I1Hw54ZNz6U99+Y4dRRbg0tjtnlQLx01
 j1BA==
X-Gm-Message-State: APuU4Z9xEN8UqsDfreNpY6M2z7qJumjgTma6Z1OixTAGl/IrX3VFgf03
 N8ZheiZVcRW44veXLQh3AUXcU4WaKvAHaixylshb45v9BRhXGPlU6gzf3gZfOsQa
X-Gm-Gg: AYBFou17X3/1w5xc4TxTUNxg+pNn3a1GvxV3WCPSzmdb/zV9YIF92Gz5+8ddWfCizXv
 gFqdpQaeOL+bHSDBlY8ArYivApQlOOpHtDTmcoCZMEknGLVzy7BfMx2CxlBYeXiqmZVET02BvIP
 ns5EfDEVDNgWC1oubWi4U4ht89w+rmelVbySqAQVW42WX5nB212e0tHFvvuuBYFQTGMxWjyLIL3
 1U8UFPORHjswMsMDdddAp0kDiNh/wLCY3lXBTVkg+l7VosBDc/SHyapzPWc7ThKw5GU4vVbWj8S
 40MHU0wnSmMcTsXmea/iyl8pD3BVHxdWge4DJNAkp2XHF2cRu9T3QAIbN6w4+06YCaOUub2SRh9
 0E2WJvwX7L0iuSloYWjsPZh3ktAbmf5b2dARyZInijyVb3VaCTReKBKxczN70WKCyW+6456qFNN
 EI3vM3ZkOhr6Z1zb8nYbCy59yU/CrtZGaXaCSSl3ieimUpA+jsXD6pObbGWNds5wTqDJHRj2wBs
 LkZ3U3bJwY+mx3CcmDTKlHdE+31bcNA+CS050MPfqcMMBMQ4G+PlIflvo1RyOW8Qa7/F29ICLBj
 9vyOF+geRBTmSZzZ5X29
X-Received: by 2002:a05:701b:21cd:b0:1b2:4871:b1f7 with SMTP id
 a92af1059eb24-1b5568fbfcbmr3472015c88.39.1795208203965; 
 Fri, 20 Nov 2026 12:56:43 -0800 (PST)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b562a82b3fsm1598373c88.5.2026.11.20.12.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:56:43 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>, linux-kernel@vger.kernel.org,
 TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH] drm/connector: Fix misspellings in the HDMI 2.1 capability
 comments
Date: Fri, 20 Nov 2026 20:56:40 +0000
Message-ID: <20261120205640.1466229-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 22 Nov 2026 17:13:42 +0000
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

Three comment lines misspell a word: "fom" for "from" in the kernel-doc of
both struct drm_hdmi_vrr_cap and struct drm_hdmi_dsc_cap, and "inide" for
"inside" in the comment of the vrr_min member.

The two in struct drm_hdmi_vrr_cap came in with 014da1db5e64, the one in
struct drm_hdmi_dsc_cap with 76ee7b905678.

Two members of struct drm_hdmi_vrr_cap are documented under a name with a
leading "m" that the struct does not have, @mcnmvrr for cnmvrr and
@mcinema_vrr for cinema_vrr.  A patch for that is on the list already, so
it is left out here, and kernel-doc reports the same warnings with and
without this change.

Written with Hermes Agent, an LLM assistant; the author reviewed it and ran
kernel-doc on the file with and without the change.

Fixes: 014da1db5e64 ("drm/edid: parse HDMI 2.1 gaming (ALLM/VRR) capabilities from HF-VSDB")
Fixes: 76ee7b905678 ("drm/edid: Parse DSC1.2 cap fields from HFVSDB block")
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 include/drm/drm_connector.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 2ee7c59329aa..f5bfb0f0e7ed 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -259,7 +259,7 @@ struct drm_scdc {
  * struct drm_hdmi_vrr_cap - Information about VRR capabilities of a HDMI sink
  *
  * Describes the VRR support provided by HDMI 2.1 sink. The information is
- * fetched fom additional HFVSDB blocks defined for HDMI 2.1.
+ * fetched from additional HFVSDB blocks defined for HDMI 2.1.
  */
 struct drm_hdmi_vrr_cap {
 	/** @fva: flag for Fast VActive (Quick Frame Transport) support */
@@ -276,7 +276,7 @@ struct drm_hdmi_vrr_cap {
 
 	/**
 	 * @vrr_min : minimum supported variable refresh rate in Hz.
-	 * Valid values only inide 1 - 48 range
+	 * Valid values only inside 1 - 48 range
 	 */
 	u16 vrr_min;
 
@@ -297,7 +297,7 @@ struct drm_hdmi_vrr_cap {
  * struct drm_hdmi_dsc_cap - DSC capabilities of HDMI sink
  *
  * Describes the DSC support provided by HDMI 2.1 sink.
- * The information is fetched fom additional HFVSDB blocks defined
+ * The information is fetched from additional HFVSDB blocks defined
  * for HDMI 2.1.
  */
 struct drm_hdmi_dsc_cap {

base-commit: d0f871bfb831705d9f55479f5b2b40f636ea7b16
-- 
2.53.0

