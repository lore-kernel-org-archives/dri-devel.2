Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1F8606A32D
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PPTkD4Ja
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECB2910F3FD;
	Tue,  3 Nov 2026 07:40:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D662310F3FA
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 07:40:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BFFD043F4D;
 Tue,  3 Nov 2026 07:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3421F01577;
 Tue,  3 Nov 2026 07:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793691639;
 bh=qdx2BkWqosqnUNeKXOVUifF3kLiaRnwfjemg//knEvA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PPTkD4Ja/PRJDdfyafN9V/67F9tcKBP2U3+V4R4O7RXIQs5NZp3AkfldxQcuDqBe5
 RAnUgi96Z7cj0ZQllZTUxv4MDeup0/PsLTHNjAFFLMHZD3yRtabcC5zBxQekSSbP2Q
 I8n4AnIaUc5rcjmOuiAvSjXXHLFAg3W3TULhHe9ykodYSAyBFHDFDsjXpIN5sPIfXH
 Uy8T577Do6GOa7mVAg9TFRp7qJOVR9wliV8f3b4m7XY0Qp8YvKXn38HESJ0bEM+19o
 KnsjnDPybM2cF+yzMWfBurAt7m7A0kYi6fM4Xm146JfyI7yDlOq2jb05MPB4H7QQVl
 Uui3XSQRIxGqA==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCHv2 11/13] Documentation: media: cec-ioc-dqevent.rst: document
 STATE_EDID_PRESENT flag
Date: Tue,  3 Nov 2026 08:32:02 +0100
Message-ID: <03aefa129e683778cc461142891bcc8eab72a0ff.1793691124.git.hverkuil+cisco@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793691124.git.hverkuil+cisco@kernel.org>
References: <cover.1793691124.git.hverkuil+cisco@kernel.org>
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

Document the CEC_EVENT_FL_STATE_EDID_PRESENT event flag.

Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 .../userspace-api/media/cec/cec-ioc-adap-g-caps.rst    |  3 ++-
 .../userspace-api/media/cec/cec-ioc-dqevent.rst        | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst
index abd62ac64541..49bd90d9392f 100644
--- a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst
+++ b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst
@@ -148,7 +148,8 @@ returns the information to the application. The ioctl never fails.
       - ``CEC_CAP_HAS_EDID_PRESENT``
       - 0x00000400
       - If this capability is set, then
-        :ref:`CEC_LOG_ADDRS_FL_EDID_PRESENT <cec-log-addrs-flags>` is valid.
+        :ref:`CEC_LOG_ADDRS_FL_EDID_PRESENT <cec-log-addrs-flags>` and
+        :ref:`CEC_EVENT_FL_STATE_EDID_PRESENT <cec-event-flags>` are valid.
 	This makes it possible to tell apart the case where the Physical Address
 	is f.f.f.f because no EDID is present, and the case where it is f.f.f.f
 	because the EDID does not provide a valid Physical Address.
diff --git a/Documentation/userspace-api/media/cec/cec-ioc-dqevent.rst b/Documentation/userspace-api/media/cec/cec-ioc-dqevent.rst
index 71d6a9e81f75..188600dff3c7 100644
--- a/Documentation/userspace-api/media/cec/cec-ioc-dqevent.rst
+++ b/Documentation/userspace-api/media/cec/cec-ioc-dqevent.rst
@@ -224,6 +224,16 @@ it is guaranteed that the state did change in between the two events.
       - 2
       - Set if one or more events of the given event type have been dropped.
         This is an indication that the application cannot keep up.
+    * .. _`CEC-EVENT-FL-STATE-EDID-PRESENT`:
+
+      - ``CEC_EVENT_FL_STATE_EDID_PRESENT``
+      - 4
+      - Only set for the ``CEC_EVENT_STATE_CHANGE`` event type.
+        If this flag is set, then an EDID is present. This helps tell apart the
+        case where the Physical Address is f.f.f.f because no EDID is present,
+        and the case where it is f.f.f.f because the EDID does not provide a
+        valid Physical Address. This flag can only be used if
+        ``CEC_CAP_HAS_EDID_PRESENT`` is set in the adapter capabilities.
 
 
 Return Value
-- 
2.53.0

