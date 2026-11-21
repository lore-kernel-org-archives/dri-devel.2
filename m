Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C73606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p8nSWpkj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2004A10E62E;
	Sun, 22 Nov 2026 17:14:32 +0000 (UTC)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF99010E147
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 06:15:20 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-38587f3de36so1934206eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 22:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795241720; x=1795846520; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KpzYn0GzUFdnPwdqQHx2vxNDfinxrzoJcs9m7k9ETRM=;
 b=p8nSWpkjf/e5onmjzzy+H6/cmub869AvBCXla1bPa6KTVdeRYt8vxs8HFLzBgMRl0I
 i+xqFXOeaOT4a9wcAl46aNeTUvUCK4R0aycw+GloRV3LFXQXlhlYHJdmSR+smHvKRqNr
 KRiqtZm9mwyTbVKEt7p8tb890FaSbRNN7W7B1McAqoFpVxuATvf/0hUBOXBcuuzomIRk
 w+4zc6bVkXlZK5Udu+pFrKR82cgdyMJXsFW24pUvBxFf1KgJ+sPGGJcv/2tEvs0S4a9G
 Vr+8OEgWcWjSzx3j5hl9KN2FCsHkYQZjq5PHydcd2rfBp+K4/xtPimAiRNOIaPLDxH85
 hrCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795241720; x=1795846520;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KpzYn0GzUFdnPwdqQHx2vxNDfinxrzoJcs9m7k9ETRM=;
 b=dIE4E2aRRBrC5IB/kKLCi8UsklLjFAo/qgSSZQPv7pkmUCPwG6TekEA0WIrutCNEsI
 aFgswDQCmSb2YaEXIGKxirqK0dZDaqXyZMeJi9qkOi9wwav7p+rxg4wKDLlnpIrM8+Ok
 6H3TBGuA80H7Ku+yVUcJMxErNK5CuRyvwJVJ94UHjXFRaim4YugV150U91Or7rNqm30R
 NlfcNKbbHBRTfMRokoHFAoZEsiiWcFl0p/Lt7oOsIdOLVRh2tBWw2XnaeJ5Zine9GlUE
 XcgN7cCvs5zvxAZBR4jtzEx7glsPfcuZ3/23f2OlDUK7fir2L7J2OYXI4MLMq6NYXoXI
 B+WA==
X-Forwarded-Encrypted: i=1;
 AL+hErHgKqPaoMjc0kB78HBp0qfzowMOthf7DAlW0BkYMbKB6EYiPAimt4DsWO2N+niplSR9uvaiqw7QBaw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/xYFcCsIJlWTiroWihAs7GEpd3PS0h1tM/h2PH8Nk6B1lHsonL
 nGxXTtWo7rsHAUv/rL1unUHPv84djoLOb4mRPrE8FXKd3ItgHimt7Sxf
X-Gm-Gg: AZFdTZcmhUG4mfvp1RMTqSdiaWnTDRnY2oY+sR3jsj+sMEdPpuadeEp7//dGGxYlYNq
 VTrMtKjR7yqlOEEE7Z9suSiqUWugFRUhdr6EjkNqbyJ2Tm7rC6ms00Hnij9aqKPp+RTdJwD+j7o
 9uK4ISoEIRJAt3SdFDUTRcaZIYFS7ZpeXMZJN7ra9z+bOrauWKPRzy4A0SSU2utozKqXhHENtJZ
 tU+ecC0ehP2DJ9oMnm+4PVJQXIs0ezAlxdwi9AX4OxFTecyLxWxhoHuzOleU41sADW6dLj1d42L
 shqu2dWGP/ZVFyaMstF5ZOqBmslO+sXRup3KNxP6OZT5/uc9pLoOSE7wz12pvV7PO4A9GHAawdb
 OHuc+oLPsi90LAkbpJSYG8W43oEWQl71Muk+QbCTR9Zo9m9gqQjmx6khnmatnGCFKSVHXOcmVNl
 XalcybGuGRwuJJuf/fBDpLQinml4FRNzEGRImw0k0Y1y5/kD4Nrh7NtWYyoWRndNzEtu8NHUXFT
 Vy7Z7ISYPTP4+ggsEIvlqRXAP0Nb1UIUAzF0IEQfQHrDJYV1Jz9lW4aQjWx0Q0olmudleObr9bA
 /lWyBqpV3FS17Zjaie6i
X-Received: by 2002:a05:7301:6083:b0:386:a01f:a36b with SMTP id
 5a478bee46e88-386a01fa8d8mr298090eec.35.1795241720086; 
 Fri, 20 Nov 2026 22:15:20 -0800 (PST)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385616f0a3fsm13054023eec.0.2026.11.20.22.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 22:15:19 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH] drm/amd/display: Document the return values of the
 dc_update_state helpers
Date: Sat, 21 Nov 2026 06:15:16 +0000
Message-ID: <20261121061516.1830533-1-takano32@gmail.com>
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

kernel-doc -Wall reports:

  dc.h:2175 No description found for return value of
  'dc_update_state_prepare'
  dc.h:2190 No description found for return value of
  'dc_update_state_cleanup'

Both functions return bool and their comments explain in prose what the
caller must do next, but neither has a Return: section, so kernel-doc
asks for one.  Move the explanation into a Return: section and say when
the scratch slot is released.

No functional change.

Written with Hermes Agent, an LLM assistant; the author reviewed it and
ran kernel-doc on the file with and without the change.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d3c484f45333..231a8ca2b18a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2170,8 +2170,8 @@ struct dc_update_scratch_space *dc_update_state_init(
  * dc_update_state_prepare - Prepare the commit under the global lock.
  * @scratch: commit scratch from dc_update_state_init()
  *
- * On failure the scratch slot is released and false is returned; the caller
- * must not call execute or cleanup.
+ * Return: true on success, false on failure. On failure the scratch slot has
+ * already been released, so the caller must not call execute or cleanup.
  */
 bool dc_update_state_prepare(struct dc_update_scratch_space *scratch);
 
@@ -2185,8 +2185,11 @@ void dc_update_state_execute(const struct dc_update_scratch_space *scratch);
  * dc_update_state_cleanup - Finalise the commit and release the scratch slot.
  * @scratch: commit scratch from dc_update_state_init()
  *
- * Must be called with the global lock held. Returns true if the caller must
- * loop back to prepare (SEAMLESS continuation).
+ * Must be called with the global lock held.
+ *
+ * Return: true if the caller must loop back to prepare (SEAMLESS
+ * continuation), false otherwise; the scratch slot is released before false
+ * is returned.
  */
 bool dc_update_state_cleanup(struct dc_update_scratch_space *scratch);
 

base-commit: d0f871bfb831705d9f55479f5b2b40f636ea7b16
-- 
2.53.0

