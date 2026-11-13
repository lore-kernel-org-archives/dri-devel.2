Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1B9606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vJQm8vVf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2894010FC0F;
	Fri, 13 Nov 2026 09:04:09 +0000 (UTC)
X-Greylist: delayed 1802 seconds by postgrey-1.36 at gabe;
 Fri, 13 Nov 2026 09:04:02 UTC
Received: from mta0.migadu.com (out-197.mta0.migadu.com [91.218.175.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4FC810FC0F
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:04:02 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=nYLdUbk5QLSfx/0QfCJHyY1+wwz8sy2W4IX1D6WfX7w=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794560641; v=1; x=1795165441;
 b=vJQm8vVfwAI4QHGlm4d6HC8HTQV1evEHXZ6qB67ck3/vD6BVo25ZV6a9TOpjKU3s82qHMnFz
 2fC6HfCmA84ZdUwUafHLaQPKy+P0GHJO8jwM2JRppOddJqTVvzAMsfwlCwwu2AkChkYyNH6iCc6
 we9Suzmwdebf7lq7q13YV6xE=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id c52c70c0dd39456d;
 Fri, 13 Nov 2026 08:27:53 +0000
X-Mizu-Trace-ID: c52c70c0dd39456d
X-Migadu-Flow: FLOW_OUT
From: Ruben Wauters <ruben.wauters@linux.dev>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Ruben Wauters <ruben.wauters@linux.dev>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ruben Wauters <rubenru09@aol.com>
Subject: [PATCH] MAINTAINERS: Update Ruben Wauters email address
Date: Fri, 13 Nov 2026 08:25:57 +0000
Message-ID: <20261113082738.6447-1-ruben.wauters@linux.dev>
X-Mailer: git-send-email 2.56.1
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
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Due to issues from my mailhost with sending and receiving patches, I am
moving to a linux.dev address.

Signed-off-by: Ruben Wauters <ruben.wauters@linux.dev>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 7fb33babc931..70491b2d8199 100644
--- a/.mailmap
+++ b/.mailmap
@@ -820,6 +820,7 @@ Ronak Doshi <ronak.doshi@broadcom.com> <doshir@vmware.com>
 Muchun Song <muchun.song@linux.dev> <songmuchun@bytedance.com>
 Muchun Song <muchun.song@linux.dev> <smuchun@gmail.com>
 Ross Zwisler <zwisler@kernel.org> <ross.zwisler@linux.intel.com>
+Ruben Wauters <ruben.wauters@linux.dev> <rubenru09@aol.com>
 Rudolf Marek <R.Marek@sh.cvut.cz>
 Rui Saraiva <rmps@joel.ist.utl.pt>
 Sachin Mokashi <sachin.mokashi@intel.com> <sachinx.mokashi@intel.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index c4f4e48774d0..17bd2c76f737 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8337,7 +8337,7 @@ F:	Documentation/devicetree/bindings/display/panel/panel-edp.yaml
 F:	drivers/gpu/drm/panel/panel-edp.c

 DRM DRIVER FOR GENERIC USB DISPLAY
-M:	Ruben Wauters <rubenru09@aol.com>
+M:	Ruben Wauters <ruben.wauters@linux.dev>
 S:	Maintained
 W:	https://github.com/notro/gud/wiki
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
--
2.56.1
