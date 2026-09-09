Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF1EC79FBF
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:06:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E58210F3FE;
	Thu, 10 Sep 2026 10:06:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lhVq5N3O";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IelIU5Gp";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8918F10E153;
 Wed,  9 Sep 2026 13:54:19 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hg2NT6SXqzMlGx;
 Wed, 09 Sep 2026 15:54:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788962057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=I86I8FeIQ9CboiECyhds7s4PMDfhKwAuhY6/wPQfsKQ=;
 b=lhVq5N3OD8kjPbfooqvGlJxyBaSf595m2UeE4yxHf3rjuE6SE44+/FJ+VzYM/TYaOdPcMq
 wPwtNJzS9ox6Qu/VYOZHfuvRC6THeS9j/beDzPE1xnjIn5Kue90XMI64WQLHsa3t+BYotY
 bD/x57zaJpBwHkM2DIIHbKZNEzB3mM8EPlBkE0PLB6sGMysmTXkr5GH4c+UIOuqpHVEHhx
 lix7IaBNgDNz4TL6vi9I5fYZoD839RHEeTcykqJalsM7Bc47Z9B1TsVTekNEkbl/n4sPe0
 oYOLWFlkqmDKEhH4bMhe5+GWOQTKRHn6LTVSIxfcuQ9ZeGChk3DgA2BAC6Mo5g==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=IelIU5Gp;
 spf=pass (outgoing_mbo_mout: domain of manuelebnerli@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=manuelebnerli@mailbox.org
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788962056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=I86I8FeIQ9CboiECyhds7s4PMDfhKwAuhY6/wPQfsKQ=;
 b=IelIU5Gp/3a+vPlbqlA7Ttej7H8OgZdMrx74sqpYN3LT4j8ysRgxNhbnQafPKezX0xjxF5
 sYw+XEie3UNGiMuccaD0kfWbPJnPm7Qrz4cMKh+CDE7MsUws375qnp4rSiuRLXbNyddEE+
 zMjeeReVBW74WHzFLMlH3LpSTf0w3k3+5CU3deL4ml9CbMbaj6tCsD45seHT770cc98rDp
 JvcFGP3i0ZBo8naaBcysvZJjKfq8U3cytSDlFdRDImi5v8pRxcjhCIpKAlv7eXGoxshYKw
 0jRYKQfPK+kRvFZYe2rJ7q6cC8NPiC5zw61nVbVycah6dmu2RV4djUxx/a/57g==
To: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation nova: Fix bracket
Date: Wed,  9 Sep 2026 15:53:19 +0200
Message-ID: <20260909135319.1364776-3-manuelebnerli@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e664e7234a120557280
X-MBO-RS-META: gn6w5n7mnx6r3t4ocy6iurzoatz49587
X-Rspamd-Queue-Id: 4hg2NT6SXqzMlGx
X-Mailman-Approved-At: Thu, 10 Sep 2026 10:06:32 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Add missing ')'.

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 Documentation/gpu/nova/core/todo.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/nova/core/todo.rst b/Documentation/gpu/nova/core/todo.rst
index d5130b2b0..a01c362b1 100644
--- a/Documentation/gpu/nova/core/todo.rst
+++ b/Documentation/gpu/nova/core/todo.rst
@@ -33,7 +33,7 @@ A good example from nova-core would be the ``Chipset`` enum type, which defines
 the value ``AD102``. When probing the GPU the value ``0x192`` can be read from a
 certain register indication the chipset AD102. Hence, the enum value ``AD102``
 should be derived from the number ``0x192``. Currently, nova-core uses a custom
-implementation (``Chipset::from_u32`` for this.
+implementation (``Chipset::from_u32``) for this.
 
 Instead, it would be desirable to have something like the ``FromPrimitive``
 trait [1] from the num crate.
-- 
2.54.0

