Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17232606A328
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=P37CKcwS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4B4310F128;
	Wed,  4 Nov 2026 08:58:27 +0000 (UTC)
X-Greylist: delayed 322 seconds by postgrey-1.36 at gabe;
 Tue, 03 Nov 2026 11:47:11 UTC
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.64.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6807210E14F
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 11:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
 s=iohv2404; t=1793706422;
 bh=jjfU3ITG+1Ysae0i08XoA5rOkoEAvvwcgiCSL+a+RQ4=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=P37CKcwST8OucMVjNdrIuRes8vH9DHGn3o3AxK+pzs9s6okoEtn0Wkyobx98Uj7RH
 tTCK2rLJ9gMSce67o7G76z4MIoM+0s8MQlDEfwADfnD5ueViWPby/KGVqFZRNzv9IS
 6P9syEiYkp985xshiXILpEaiQ+aoEw7B1OuO13aM=
X-QQ-mid: zesmtpip3t1793706055tf286fde0
X-QQ-Originating-IP: qDU+okGXTubXWh454M3F6joKk3mhoSRF6jYFHwiqPck=
Received: from workstation-Precision-7920-Towe ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 03 Nov 2026 19:40:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15823312286614678572
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: reject invalid ATRM results
Date: Tue,  3 Nov 2026 19:40:53 +0800
Message-Id: <20261103114053.73761-1-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MW//binZVb2s8OzTooxAXph2ckOBDM2XFhyr+yvRuLcJrdEf+1nH7x3d
 TvnnEN+dzxIBFLUcsQ0uLbPOqI+sWBUNvimFlR9qtzGeyTkj30/Nj/s3bXzFKKtF6hK6Qbs
 0OKtCm0PYDnzwYmQfXaST955cqEQNNqzpyrw5Q5JyJO75Ai38A35+mhNZ5cJDLFfoZuK0U1
 HoxawL2qkHdh4Ya4eByFgqfgeRsCjhu1yEEW5a8oTWoVw9XjhBNwMoGVFj7Oqg67J2YeXu/
 mvDHCM6vhz96kdMZZyl3B2GniOanx610LcSkDtg0CVgkTuPrxCXoaN0VVAIDOn8gk1zwHWO
 J4pWwxsdZdounEEkB2x8QkpIsq/kPkkqYbzv1XXK+XY4yqXyKDo0q1A/opU/hseLkBVqe36
 b1TacLEPzoqlxxnA9kX2l8L0ifc371KQi1IwfW7ZuJN3IXsPTyh1tWuCSrcTJfKenh3a6Yw
 fFWYWmDa2dsVmOxu04dGuBQidCyQMWao0SQ/PalyzIAaaVNSwaStTejzOuTkTOuy47VV75u
 ktGRvXyfK+IfMmw7N6jrDsaFNxhHQSnyI/Zf9zqD/XBfRnxySxi/QpQS7X59KBMN+7R91Cw
 HMzZW6/XfAfZnx+ZsbOSt3K6Gc3162ysJ8CgD8/Ghj7pbibeNwkgiMwkMQpN/vkAnl0dROU
 XjpRP7CWoIxzk6uo6CTYcvfqQzbHxQZrmpCGlz5wJ9OdtodqC1nV2hllMhQzH0s5hpxTiSp
 UEB6Y+GTpofM2kXtV8Boh+pLfWojDZl8+KEy/ffHkbm70sGuyLZ2qRFogzQRE2inVyz8/CY
 Im6n4XxvMtJuaFlFzo3CXpDaubw1hP5LfdsAW33pqSXsociZW0LmDXNM2BAsGai1SfadmKu
 /VBLkbhAqYHBf/NNuSi+dWKxNivbH1nuBsOS/8yjjm19LIDnZDN4UrLS5IIFIXtXy02xjO+
 iR3Mb1tjCiNj9RZ+ssY7Rgs+elxX6ZSRdCjvPusdBzxaKufFa723ZN41quzY75jafmEwj1t
 NTXVOIQhAgXR42q/DwBcuvjYg1zMMEXuUgXUZXEQ==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

radeon_atrm_call() trusts the buffer returned by the ATRM method: it
copies obj->buffer.length bytes into the VBIOS image without checking
the object type or that the length fits in the requested chunk.  A
firmware-provided ATRM method returning a non-buffer object or a buffer
larger than the requested 4 KiB chunk can write beyond the 256 KiB
VBIOS allocation.

Reject the response unless it is an ACPI buffer no larger than the
requested chunk.  The only caller always requests ATRM_BIOS_PAGE-sized
chunks inside the VBIOS allocation, so checking the returned length
against len is sufficient.

Fixes: c61e2775873f ("drm/radeon: split ATRM support out from the ATPX handler (v3)")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
 drivers/gpu/drm/radeon/radeon_bios.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index 1da6bf1c17ff..c23892470265 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -183,7 +183,12 @@ static int radeon_atrm_call(acpi_handle atrm_handle, uint8_t *bios,
 	}
 
 	obj = (union acpi_object *)buffer.pointer;
-	memcpy(bios+offset, obj->buffer.pointer, obj->buffer.length);
+	if (!obj || obj->type != ACPI_TYPE_BUFFER || obj->buffer.length > len) {
+		kfree(buffer.pointer);
+		return -ENODEV;
+	}
+
+	memcpy(bios + offset, obj->buffer.pointer, obj->buffer.length);
 	len = obj->buffer.length;
 	kfree(buffer.pointer);
 	return len;
-- 
2.34.1

