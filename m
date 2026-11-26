Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DC7606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=PabZVgmO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=w0MB20Sn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A7FF112848;
	Fri, 27 Nov 2026 08:29:33 +0000 (UTC)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2B7B112594
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:05:42 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 429987A057F
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:05:42 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 26 Nov 2026 11:05:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1795709140; x=1795795540; bh=0jJSJ14/au0I5tvGdZLv3
 VBdYXYm14UxYMphMpPpqg0=; b=PabZVgmOfamECvaOL1H8mHIQUtt/Q2CbaTdWV
 uiWdtuD9ovRmhYcNM/c760gOa6jDaOjEuXW2SuXIb2jciC4yJVtUQLkyp0lsPoT+
 EYVqpY3CnxHSIis4SlEqFePIpXvXIORFksKtDJAyQ+uqe5HK5dUIs06Nf+Queis3
 zCI9fDxB1LuDbQdKjWSwebl2SpOfu2aaCKeLIbnJM9Eu0kNHTAo44laLGvpdxobV
 psZ7rkcAl61yQfgsVsPqBQ1rRvC595KVSklKlZxVRABANVFe98G2mqz6LiPtvMqj
 qlI+Xnp4q4EqG8a8/Z4V1vzS+cbsJTGxdE/iUtRGp7otLWfPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1795709140; x=1795795540; bh=0jJSJ14/au0I5tvGdZLv3VBdYXYm14UxYMp
 hMpPpqg0=; b=w0MB20Sn6Hjt7deu5NuNlpKMCC70pKa/u0+lv5M+glrjgCxOBhd
 VLpH8PnW5z9WhTredz5vsB8ut842ZdHXYQ13+K+RJ8GYBPuiUHvtlW6xNqNcSGtL
 o9R5AvFKzXpIotHsyObl8ap2caRmvDVJDWt0VY2sGEsSfaxQOGViBqobD3qhedfS
 956p1GYZaShyj48LwHpPaaXOkmAInehWaEEo6pRyzZD0oIUXgL4OMxwcn9pMzopn
 jIp95lJH1wTFTZHXtD5nv9a9GeCrlFeCvZYHfC8iwbFS39wN6Lc1hQIRJHDViUkj
 qL7VCfA5V1zbFHvEbBPTp1YAEZi2K68eK8g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795709140; d=fastmail.com;
 mf=PGJhcmFudEBmYXN0bWFpbC5jb20+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm3:rsa-sha256:ADQi3BYYyG2fuV3C+5ZhR7IP5Xpb3yqTF4A9e1Ro6SH8yR4
 PQJMhpPVcsbKozpEc8BdWUuwcimOzrKGR4iX/uN93kuYXTr6a6ZtpOc+LZrlBMQH
 XIugAVLvjDshKlUr5M2xWLdpb+yiiRNU2NyO9f2D/eMCv/7k6UkTCjS3mx5Y/xGY
 N2ozHjMdk8mJvBhDb40Ondf4bRxGcgSI6wz2pj6uRd2UWb6AOJCNU8BfauWPwWFB
 1DzxhpJNDjF2LAuQvhJ2eoZvkViFuUn/PV9vKD1cbcbpgyYCo9LJ84FoGiqSfB1f
 AoS3c4b8kZj+BdX++6wfuVgvfwjVrtPMX9slX4A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=9;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:F6kfNk6FSJJLJjYOLQdGJdV+34dbXvz59y5HSzyjEDQ=:vQqCiOEAJ5fdy/X2Eu1ZZCDteP3JyJpjgB8/9HEG7Pw=;
X-ME-Sender: <xms:1FgIa6NWkeiPJ0uJUA_56QIIhEFk_Mi49__RqafDYFdb2IHBp3MQbQ>
 <xme:1FgIazmFfFMGGLEzm8Reb018XvdLhke2ERjEWjf7aCVUoK3oykzQDn1ZE8WBZlvbj
 jMvba94XBY59iCD9CTfjkkFqM4S10JKFeFogdsffZvIMstCKche_jo>
X-ME-Received: <xmr:1FgIa3Sl47u0SeG-9VjeqRS-3EHZZOkYQik77cqQ6hgvi6LpXawqV9zz>
X-ME-Proxy-Cause: dmFkZTEbOjtD6V/wkwTVGH9xCFVJJKrdCMFjVFjGnd6lcfh2GndMeiOBdtUvzQWH9iYIcz
 Ct1PhE8RwksXbz7aefrdX56LROZT/pPlPokU7SszlhN/E5nmLV7xzdB0aHN8efmY4GefHQ
 fMoBQH7SY+RThmSTYhQLfFMZj+3eLOzXI0oA4qdr/AeVbI/NYs6vm9NYXm1JkMPe74h348
 qH0NFvS8/oXjBACPslIq2upoNdLJq6fSC+n3t0OxC5xKvSOuDlGzV7ieZJ7SUh+ZwYykAJ
 5Iwj7kJE53juRfCix+4+63/AO7O3gicL8E1dLetP5YLBLYt2t5g48KBvPwvYtlhdWuWsDU
 COwdhqk2zpFvaf5UvdKBue2+MPzLyXANOsYZHQ0LZGLcJ5h5yDZmclhfad6bxctpRSed49
 FAhqZxNRAWtZgKvIMyigA/JvdmLifrZwBClPQ/QdBdX4DuN6aOsJcSmlbQGTDLqjK0P4XT
 2Zlo1AQmsK3FjY6YCrJ5t0JtHQZ+fWKVbbxc3Eof9XOiyNIZmv/4q9t4hK2fRwitW9XTOE
 Yq13vOdPi0ZFbMnp9jyGyxuGbsRysUvrIPfXIbS5by2XZG8+yf0ZvL0oy/tKRiCuhwT+mw
 TRlKxKlnjLauC1QFc8Mtky+dtxl84eJRk2J02sHTO/gyD3T3HM6KXR0dadtg
X-ME-Proxy: <xmx:1FgIa6Wmim6r8lblNpmXrENxNmK_VAWqWezdL5Rqx5CH0ZnS6C8vMA>
 <xmx:1FgIazIZqdDah1xoAAxRCGCi9eUEGKNjb6_VoQYPgLNWBmFq17-98A>
 <xmx:1FgIay3fYM4HN6SAp7USru6COEfg_PaalIIdyR5VLwI2bwUQRty1rg>
 <xmx:1FgIa4J1stsui1Y_vK8CbmFlXCCjrG200VsDcGimSlDVRoLxgsTkig>
 <xmx:1FgIa1_51uEc7wpV1pUcK3unFHoE_Bq0BCr9uK_TYhhpCB4ItrdaLpwG>
Feedback-ID: i9dce4b48:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 11:05:38 -0500 (EST)
From: Baran Tuna <barant@fastmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Use str_enable_disable() helper
Date: Thu, 26 Nov 2026 19:05:29 +0300
Message-ID: <321392d0d9dba36777ec771663c677509fb49c15.1795702369.git.barant@fastmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
Message-ID: <20261126160529.xj9JvAhUd7wgAhUYCpnHomfivSX7XPi3prteyWIXi_c@z>

Replace the open-coded enable ? "enable" : "disable" ternary with
the str_enable_disable() helper from <linux/string_choices.h>.

Found by scripts/coccinelle/api/string_choices.cocci.

Signed-off-by: Baran Tuna <barant@fastmail.com>
---
Compile-tested only.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5d1b010bec9b..870b4653314f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -85,6 +85,7 @@
 #include <linux/firmware.h>
 #include <linux/component.h>
 #include <linux/sort.h>
+#include <linux/string_choices.h>
 
 #include <drm/drm_privacy_screen_consumer.h>
 #include <drm/display/drm_dp_mst_helper.h>
@@ -1468,7 +1469,7 @@ STATIC_IFN_KUNIT void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 			rc = amdgpu_dm_irq_set(adev, irq_source, enable) ? 0 : -EBUSY;
 			if (rc)
 				drm_warn(adev_to_drm(adev), "Failed to %s pflip interrupts\n",
-					 enable ? "enable" : "disable");
+					 str_enable_disable(enable));
 
 			if (dc_supports_vrr(adev->dm.dc->ctx->dce_version)) {
 				if (enable) {

base-commit: 25faec9ce61c01fb45abf812a222c5b43c3cd5c5
-- 
2.53.0

