Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D70D606A32C
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zq/vSxMb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C19711218E;
	Thu,  5 Nov 2026 07:27:34 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E3F311219E
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 07:27:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A6962602C3;
 Thu,  5 Nov 2026 07:27:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271FE1F000C1;
 Thu,  5 Nov 2026 07:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793863646;
 bh=cJ+jyiHcrkuFKlcBlqPpHulH/buCVf33DuiMRw6GxEY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Zq/vSxMbHBQBXSIwnBd04Nw6Y4nK8LkwbGrlWmnvYvgQxL/ge1URqfMVAcMtJ+x+o
 xOhDLTSoW7tpKpWzohoT+9cF7CaW9DWDBRyJMe3A5jbI5Nbpc+Oa0G69FUIrCnkHPH
 mHBVaqCiPEJygCCIcL7EFfterSoloX2A1SI0XrvbIGn0hjuVImaZPEpgoIDw6vRQi+
 HhjDqkUo1inUMUepqpmQqLolk/expJFQUmBQe5gzfOKZM6wxakH4sYhoX4h6GW1SMJ
 EmTu4RnpE2ULVZLBYCAUNztL56E8eycBTQQGCAOTwiKJCCLSgWlB4M0V8jeFunZxNX
 T9NytCNV402kw==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCHv3 08/13] Documentation: media: document HPD_PRESENT cap and
 flag.
Date: Thu,  5 Nov 2026 08:22:22 +0100
Message-ID: <e98308c0db382c09ce698b34ca54f798ab0e3557.1793863347.git.hverkuil+cisco@kernel.org>
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

Document CEC_CAP_HAS_HPD_PRESENT and CEC_LOG_ADDRS_FL_HPD_PRESENT.

Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 .../userspace-api/media/cec/cec-ioc-adap-g-caps.rst    | 10 ++++++++++
 .../media/cec/cec-ioc-adap-g-log-addrs.rst             | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst
index 1d5248979a6d..bf734cbee0dd 100644
--- a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst
+++ b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst
@@ -143,6 +143,16 @@ returns the information to the application. The ioctl never fails.
       - 0x00000200
       - If this capability is set, then
         :ref:`CEC_MSG_FL_REPLY_VENDOR_ID <cec-msg-flags>` can be used.
+    * .. _`CEC-CAP-HAS-HPD-PRESENT`:
+
+      - ``CEC_CAP_HAS_HPD_PRESENT``
+      - 0x00000400
+      - If this capability is set, then
+        :ref:`CEC_LOG_ADDRS_FL_HPD_PRESENT <cec-log-addrs-flags>` is valid.
+	This makes it possible to tell apart the case where the Physical Address
+	is f.f.f.f because no HPD (Hotplug Detect) is present, and the case
+	where it is f.f.f.f because the EDID does not provide a valid Physical
+	Address.
 
 Return Value
 ============
diff --git a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-log-addrs.rst b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-log-addrs.rst
index 8397bf573798..e37898750ab5 100644
--- a/Documentation/userspace-api/media/cec/cec-ioc-adap-g-log-addrs.rst
+++ b/Documentation/userspace-api/media/cec/cec-ioc-adap-g-log-addrs.rst
@@ -192,6 +192,16 @@ logical address types are already defined will return with error ``EBUSY``.
       - If this flag is set, then the CEC device failed to claim a free logical
         address and is in the unconfigured state. This can never happen if
 	``CEC_LOG_ADDRS_FL_ALLOW_UNREG_FALLBACK`` was set as well.
+    * .. _`CEC-LOG-ADDRS-FL-HPD-PRESENT`:
+
+      - ``CEC_LOG_ADDRS_FL_HPD_PRESENT``
+      - 16
+      - If this flag is set, then the HPD (Hotplug Detect) is present. This
+	 helps tell apart the case where the Physical Address is f.f.f.f
+	 because no HPD is present, and the case where it is f.f.f.f because the
+	 EDID does not provide a valid Physical Address. This flag can only be
+	 used if ``CEC_CAP_HAS_HPD_PRESENT`` is set in the adapter
+	 capabilities.
 
 .. tabularcolumns:: |p{7.8cm}|p{1.0cm}|p{8.5cm}|
 
-- 
2.53.0

