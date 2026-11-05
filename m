Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7D5606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LR0ToNkz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75B2511218A;
	Thu,  5 Nov 2026 07:27:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F9DF112189
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 07:27:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A7CDF60F0B;
 Thu,  5 Nov 2026 07:27:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C4F1F00919;
 Thu,  5 Nov 2026 07:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793863651;
 bh=49UoCEgpyuiXuX8KYfBHZ1O0/bic+sOLxNbkV9ycThE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LR0ToNkz/JgixFo0/E0CGtD3UAjSoVB+nV3N5AADExp6GdGnRDXPduP0oDB8BOqmO
 O0xlYyf4ZV4ys8zJ1bmhPj8Th1q6n5USN18l6PM+xoSYl6qYQhNMmfBqyBTxY9gkHT
 WDZDG9xKYrZOwUuWTvoR3T6zguztzKRGR7HbeGmLNVTCbUNcZ5pgqhQGC3P1qdIxb1
 D3ydtOJW1igsMkMQJ20snLifCb35VijPAxHqus06FTlIoXHwVrTzL86rMIvibYJc0C
 jOqhDZ8pxww6/ABDYs7/RnvWqUErqKLE9FHKtqhPZUTlFIJ+dtF1Fjn0mY9EEcNDG1
 +iyJ8u+OqutpA==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCHv3 11/13] Documentation: media: cec-ioc-dqevent.rst: document
 STATE_HPD_PRESENT flag
Date: Thu,  5 Nov 2026 08:22:25 +0100
Message-ID: <ecdc175d624bb4b5ba7742ad112d3abcd04dcb1d.1793863347.git.hverkuil+cisco@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793863347.git.hverkuil+cisco@kernel.org>
References: <cover.1793863347.git.hverkuil+cisco@kernel.org>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document the CEC_EVENT_FL_STATE_HPD_PRESENT event flag.

Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 .../userspace-api/media/cec/cec-ioc-adap-g-caps.rst    |  3 ++-
 .../userspace-api/media/cec/cec-ioc-dqevent.rst        | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst
index bf734cbee0dd..0afb0e11fd72 100644
--- a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst
+++ b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst
@@ -148,7 +148,8 @@ returns the information to the application. The ioctl never fails.
       - ``CEC_CAP_HAS_HPD_PRESENT``
       - 0x00000400
       - If this capability is set, then
-        :ref:`CEC_LOG_ADDRS_FL_HPD_PRESENT <cec-log-addrs-flags>` is valid.
+        :ref:`CEC_LOG_ADDRS_FL_HPD_PRESENT <cec-log-addrs-flags>` and
+        :ref:`CEC_EVENT_FL_STATE_HPD_PRESENT <cec-event-flags>` are valid.
 	This makes it possible to tell apart the case where the Physical Address
 	is f.f.f.f because no HPD (Hotplug Detect) is present, and the case
 	where it is f.f.f.f because the EDID does not provide a valid Physical
diff --git a/Documentation/userspace-api/media/cec/cec-ioc-dqevent.rst b/Documentation/userspace-api/media/cec/cec-ioc-dqevent.rst
index 71d6a9e81f75..b399c5f1b847 100644
--- a/Documentation/userspace-api/media/cec/cec-ioc-dqevent.rst
+++ b/Documentation/userspace-api/media/cec/cec-ioc-dqevent.rst
@@ -224,6 +224,16 @@ it is guaranteed that the state did change in between the two events.
       - 2
       - Set if one or more events of the given event type have been dropped.
         This is an indication that the application cannot keep up.
+    * .. _`CEC-EVENT-FL-STATE-HPD-PRESENT`:
+
+      - ``CEC_EVENT_FL_STATE_HPD_PRESENT``
+      - 4
+      - Only set for the ``CEC_EVENT_STATE_CHANGE`` event type.
+        If this flag is set, then an HPD is present. This helps tell apart the
+        case where the Physical Address is f.f.f.f because no HPD (Hotplug
+        Detect) is present, and the case where it is f.f.f.f because the EDID
+        does not provide a valid Physical Address. This flag can only be used
+        if ``CEC_CAP_HAS_HPD_PRESENT`` is set in the adapter capabilities.
 
 
 Return Value
-- 
2.53.0

