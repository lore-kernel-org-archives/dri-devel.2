Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAA6606A330
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MrqyM2Dg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A43AF10EBE9;
	Sat, 14 Nov 2026 16:10:54 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94DCA10EC66
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 16:10:48 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-36eb1cb7aabso2557814eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 08:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794672648; x=1795277448; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KPSDYqCooXPcCbLVRB9OOYzMNaTmNZPbW1+34+f9KRM=;
 b=MrqyM2Dg6suhF3bMVseGwv1uK8DsQ9g0+omaZlNZ0VEYWfVJ6mmNymvmuSgcAfzOke
 hfV2yYfN7UQjo/gDbwNzWXYHfBHzXZVAxea2BhV1uTcznJQ5D3f0kLMPh+LebNyKKx3v
 RiGR/VYo2UBQC8NufwvYyQuwweBH7PP5dciY9zrBcT2AeXfNK82eQTtBOoAMonTsPVx9
 VlpTBsiqWgzVAbQp+Ax+Mhp7lNc7sQ/YLjcZoW9no7A8BjC/rl5aiIT9t6L0ciDO68aA
 kOkElbAAOQgQPeoOUUcxcsiDeghK3QwnTeDlOWdL0qQlJaBhrUujrpQr25mvh/1zPwD3
 R9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672648; x=1795277448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KPSDYqCooXPcCbLVRB9OOYzMNaTmNZPbW1+34+f9KRM=;
 b=VDnctEtS4vQNeoIcI5ujBMVzqc0FrW5g2CCyBiDY14bdMYfTF+XaH5Lr49aqCV8cCS
 6GFlFERWJ9oy2L65jvIXsO4OlRyxVu53blwxHXIDsfj7ChIwDYRHBkqZXEAsd9JEtP4/
 shaHmyXaP9P3ydhjd9G8mHJvumx6yyvaAIziSJcgBVIWyYvZTB58wLCFlNyYoasWP9VX
 p1pHqm0qRwzsmgZmzCE0u0C9zlIRAPn4/gTrDDUx70FsSJB6Kcx7Fh8iEkGQrCpy0Mcq
 am3NUZcw3ujvxEahVdxCU0mbzL3+GVhYGhT83XSeat47bALSoBRcGjli8+TvcMzUtWif
 0w7A==
X-Forwarded-Encrypted: i=1;
 AL+hErHzgsurcV57UTuo35WRTme6H7L7D7Xa3tjHsUKwqLA4k9qJI+A1YwCEQf58SPtHU4vG5yNFVUeS3ow=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/ApDjOm0oY1PYtmBJbXuIQPKVeLzlt+sbydNX8HZp/tK8zwmva
 rr/xI00iJH6CEsBs3eUGAvacb/kuKjFGC6wXH1cfi96UCMhvy+MIEvA=
X-Gm-Gg: AYBFou3C3aTqosPDVZLY2mAHw+sjizXwfmSQBVTpSgVb8ZWYRSqADH5FoF3GyfCJFtC
 1nADSiWzM9GnTAx1pQsILnSbzH4B8N5pMmHisDTkACaFS/MgLj/mxPOTAkvJ0WI7YWPPw3swr5k
 Eucoab8xKHsIrwPpnUA3bc33BqGzCUqYtMb0+NtXWbAT+VIcWmCznzNTkhGbJ7ZFZeRzmFGT0e1
 +qhoHd0u7VCD92i42QTX+sM7Z5D7PVYHIoijhdIwItFhfQMHTSlQKNLmu/tI9cyA7wayOiBikQO
 nnY/ln81j/Tl2mA4SFZUvBbusS2HPy+xLhPBZusJ8PPDQR7OMLny212QkB0AHYoa1TJFXEBeFBo
 dfp7ICTm6NR1lWtp7Il1zm3ZyLiSGwI4BZi3b0nZM5s4uEzANRI/b/8L/bN6/h25Kv+cE2g/o0Y
 TJxcJsTf2YVaOX6RZDfAS4S6P4Ld7n/b11PSULuIz9tCH8VHDpyYxp10rW99pCzXjm1wrGsQonp
 5mJWsOQLLux8b0U+9GvQAw8AYO+DeFLoX6puxTP4PWJ+oLpotL7CR+zIY+Cww9mhfdz6UDKXez2
 Cvb6I8AV8GdLA9O/p8KysYth+pUNJoeeYzdRKYYz0pctc/BMfnIj4E/DK42QQAoHaQ==
X-Received: by 2002:a05:7301:5401:b0:35c:8b96:94d9 with SMTP id
 5a478bee46e88-37966f31fddmr5041718eec.19.1794672647666; 
 Sat, 14 Nov 2026 08:10:47 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.127.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bb0919sm17567582eec.29.2026.11.14.08.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:10:47 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Andre Eikmeyer <dev@deq.rocks>, Sebastian Zygadlo <szgit@icloud.com>,
 Yossef Osman <yossef.osman@proton.me>,
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
 linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)), 
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH v2 10/12] drm/amd/display: Refuse DP AUX while GMUX keeps the
 GPU off
Date: Sat, 14 Nov 2026 11:06:34 -0500
Message-ID: <20261114160731.3756-11-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
References: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Andre Eikmeyer <dev@deq.rocks>

fwupd reads /dev/drm_dp_aux* while the GPU is runtime suspended. The AUX
device holds no runtime PM reference, so the transfer touched registers of
the powered off GPU and caused a CPU CATTER.

Tested-by: Sebastian Zygadlo <szgit@icloud.com>
Tested-by: Yossef Osman <yossef.osman@proton.me>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 7261317d4..0d11a9443 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -24,6 +24,7 @@
  *
  */
 
+#include <linux/pm_runtime.h>
 #include <linux/vmalloc.h>
 #include <drm/display/drm_dp_helper.h>
 #include <drm/display/drm_dp_mst_helper.h>
@@ -111,6 +112,20 @@ STATIC_IFN_KUNIT ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 	if (WARN_ON(msg->size > 16))
 		return -E2BIG;
 
+	ddc = TO_DM_AUX(aux)->ddc_service;
+	adev = ddc->ctx->driver_context;
+
+	/*
+	 * User space reaches this through the drm_dp_aux_dev character device
+	 * check if the gpu is active or not.
+	 */
+	if (adev->dev) {
+		pm_runtime_get_noresume(adev->dev);
+		if (!READ_ONCE(adev->runpm_active)) {
+			pm_runtime_put_noidle(adev->dev);
+			return -EBUSY;
+		}
+	}
 	payload.address = msg->address;
 	payload.data = msg->buffer;
 	payload.length = msg->size;
@@ -126,13 +141,13 @@ STATIC_IFN_KUNIT ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 	result = dc_link_aux_transfer_raw(TO_DM_AUX(aux)->ddc_service, &payload,
 				      &operation_result);
 
+	if (adev->dev)
+		pm_runtime_put_autosuspend(adev->dev);
 	/*
 	 * w/a on certain intel platform where hpd is unexpected to pull low during
 	 * 1st sideband message transaction by return AUX_RET_ERROR_HPD_DISCON
 	 * aux transaction is succuess in such case, therefore bypass the error
 	 */
-	ddc = TO_DM_AUX(aux)->ddc_service;
-	adev = ddc->ctx->driver_context;
 	if (adev->dm.aux_hpd_discon_quirk) {
 		if (msg->address == DP_SIDEBAND_MSG_DOWN_REQ_BASE &&
 			operation_result == AUX_RET_ERROR_HPD_DISCON) {
-- 
2.55.0

