Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5338D606A327
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bZhF5vGD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03C6B10ECFF;
	Mon,  2 Nov 2026 10:55:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 263DC10ECF7
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 10:55:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9FC6E60F4D;
 Mon,  2 Nov 2026 10:55:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6491F00A16;
 Mon,  2 Nov 2026 10:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793616913;
 bh=qdx2BkWqosqnUNeKXOVUifF3kLiaRnwfjemg//knEvA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bZhF5vGDapMSBHsz5k6SKiMsGhe0lcXQ1hELK/IwrcVUlWcSjNVsgF3GBYeL7L1iq
 fGmx9wzLq8I3Pj4kYjaGEHz+7esVAPTjT/gURuU5ofU7padQE/oL44OdPE9RU+x9iY
 eQ/RPCN4gsJvgaBB96YEWYKC+ojvn4XlszifKbLT69mNtJ1lEDEHdW7zA5L51yahRV
 ZlOOnFsvUrmy+yfsFZelOnrvAXgj65cX4F/0pjk3ycylJNS70QRTy1wbRnCr4EjayJ
 3vPi3ma/Jb+ykWLpXHD1BuaIMXcsjPABNlzwzCcaTBIUxrI3ayAMIDY5uShUdbCusH
 LG69+hr1Y4+rA==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 11/13] Documentation: media: cec-ioc-dqevent.rst: document
 STATE_EDID_PRESENT flag
Date: Mon,  2 Nov 2026 11:37:02 +0100
Message-ID: <f4e77dea0774b109d775bf3d12d25cff74d6843e.1793615824.git.hverkuil+cisco@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793615824.git.hverkuil+cisco@kernel.org>
References: <cover.1793615824.git.hverkuil+cisco@kernel.org>
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

