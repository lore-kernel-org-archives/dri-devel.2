Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671F7606A32F
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ugreen.com header.i=@ugreen.com header.a=rsa-sha256 header.s=pkvm2402 header.b=WK0uuDtx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA2910EAB1;
	Sat,  7 Nov 2026 14:28:20 +0000 (UTC)
X-Greylist: delayed 74172 seconds by postgrey-1.36 at gabe;
 Fri, 06 Nov 2026 10:23:54 UTC
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0D0710E220;
 Fri,  6 Nov 2026 10:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
 s=pkvm2402; t=1793960612;
 bh=9AfE/cfKfBtCctU1Gai/X++88Iu6z+gq2zm4ryifuSg=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=WK0uuDtxaPPzmKOUMwakGUNc990TLe4iy0Ajf8hsFR7OJEVfXWcEM5a3CI0Izd9n7
 nHKkLKLSzmbcwxsrXYpfzZG8jMXZXzz7ZLzGyagB7t5DG9wNbrLsDj5WES9sq8tsZB
 GG4X+UgWh07ob3vJHkm/KQM6FqoFbVg2Np8kPDn4=
X-QQ-mid: zesmtpsz3t1793960606t071e06aa
X-QQ-Originating-IP: S3UmKB0bvoMHHcYgWAGxlLQXFmqsu4Zb9qoHPz9nc7A=
Received: from exmail.qq.com ( [183.16.164.172])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 06 Nov 2026 18:23:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8634473018609808824
From: Hanson Wang <hanson.wang@ugreen.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>,
 Animesh Manna <animesh.manna@intel.com>, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
Subject: [PATCH v2] drm/i915/dsb: Realign GOSUB only for QW slots 6 and 7
Date: Fri,  6 Nov 2026 18:23:15 +0800
Message-Id: <20261106102315.1361645-1-hanson.wang@ugreen.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105134658.3724628-1-hanson.wang@ugreen.com>
References: <20261105134658.3724628-1-hanson.wang@ugreen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MpvVxjO9l39xd6tLpiMIVI1u2Nmd3/JrG0kWbNZAaKMafAJgdk5O34BZ
 b8LlY20ubhQwNuUMI+yJbNXTXCnDYaJyKEV4bsg0/xyjoVrg6ZbqnhLOp0u3m0bsDrhT657
 odl25FSZIPdg7Rtzur0qQAleJL08gtUXd0Cgeef7cW1ewMyVV4ojDV8IfcDRAGEBx5Zt5+s
 fsgiQv+eYlrnB4pYPRJZO94uO94CdDvFKw2m/buImn6+qrstPEa3dCRebIeyOSEQOxCgNxk
 VYdCz9SGvM1P1uaKMgNV8fqoZfS+1Z2abbeq9lyBYSjkl4vnwVR/jo6yfvH69nSe0nSwwZ7
 e+bsj1D4ruuyZGs2+VNQx+4LCgesHK9xLI4/DIZnf+cC4H8kGRGVH0aADkaHgrOX9eDmzwb
 TFAj4lXCZjJwy8yMfDt+87blroD73jgsI71LbQrHaOfAK7aeMvzbLpGzZpV7J6K4J5n0eIh
 6IH5QcSGa/M/35GdPX6rTw2wXJW9PaAsUJMA2z8a2q6B/rkoHuh6NX1hqMj9jKU1vFvsBm1
 eRDwBGBuTGTCGvz5dw9X0PUrdeFeEV3xe8aNBW5PGRmi7o6sfP0rWElMTudTKDdkLWhrKTi
 5d8wZ1S8Rg9rJCKzUaDWzBctr8Al/asIxaKggaL1jv4CquBINKgTiYVDLfH7fs0784pleP9
 sleqcpxZPu3xU4zc0Ja38MTMzSWxHouCdvaBqYPHfysZJhaSHL/Q0kNdCpjMCrCPLGKoWLG
 tf9DIUosiggNCM3sWVT0qO5eZZVtjHbvqIclgsEEWn9LasnvjjvgRSHmYYpjlDgjSrMTkxm
 kywdjBi6F+vxBIncWM/9Xs9FY7PJ3ttbLUVd5WyNm+xzwdTbNfan1E1ksjVQR+MwqC4HRNC
 eISgIp7lT5DXv7SmNKh9Uon8IAPeE4g0QjDa/rsySQG49apeA/zoK/s0dztSR9HybXflqPM
 F9DMcMBHSTd9GEGuLuf96TnBLqZa7MeLEQtJRPmNvYYW6q1rayCmN3sG8JOVdkiDHj0+RP/
 rVoz0DeJj7hzQVJMdoABSEzz2PFNyCjou2JcniFgHSPB7WF8Pp
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Sat, 07 Nov 2026 14:27:39 +0000
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

intel_dsb_gosub_align() moves free_pos to the next cacheline
unconditionally, but only clears the skipped bytes when at most two
QW slots remain. Wa_16024917128 forbids GOSUB in slots 6 and 7 only.
A larger gap is still executed. A Panther Lake DSB dump showed
nonzero data in that gap, with the tail at 0x58 and GOSUB at 0x80.

Advance free_pos only when the instruction would land in slot 6 or 7,
and fill that gap with NOPs. Emit GOSUB in place for every other slot.
intel_dsb_align_tail() still clears the rest of the cacheline.

Update free_pos inside the existing gap check in intel_dsb_align_tail()
as well, so the two helpers keep the same shape.

Fixes: 2c41d62f6fb1 ("drm/i915/dsb: Implement intel_dsb_gosub()")
Cc: stable@vger.kernel.org # v6.17+
Signed-off-by: Hanson Wang <hanson.wang@ugreen.com>
---
v2:
- Advance free_pos only for QW slots 6 and 7, and NOP-fill that gap
  (Ville)
- Update free_pos inside the existing check in intel_dsb_align_tail()
  so the two helpers stay in the same shape

Hardware: Intel Core Ultra 5 336H (Panther Lake), 6.18-based kernel
Build:    6.18 backport; both xe and i915 intel_dsb.o
Upstream: not built or booted
Reboots:  7/100 DSB idle timeouts before either fix
          v1 (always align): 0/200
          v2 (this patch):   0/200

 drivers/gpu/drm/i915/display/intel_dsb.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsb.c b/drivers/gpu/drm/i915/display/intel_dsb.c
index d9a270362a82..07d864039e82 100644
--- a/drivers/gpu/drm/i915/display/intel_dsb.c
+++ b/drivers/gpu/drm/i915/display/intel_dsb.c
@@ -589,10 +589,10 @@ static void intel_dsb_align_tail(struct intel_dsb *dsb)
 	tail = dsb->free_pos * 4;
 	aligned_tail = ALIGN(tail, CACHELINE_BYTES);
 
-	if (aligned_tail > tail)
+	if (aligned_tail > tail) {
 		dsb_buffer_fill(dsb, dsb->free_pos, 0, aligned_tail - tail);
-
-	dsb->free_pos = aligned_tail / 4;
+		dsb->free_pos = aligned_tail / 4;
+	}
 }
 
 static void intel_dsb_gosub_align(struct intel_dsb *dsb)
@@ -607,11 +607,15 @@ static void intel_dsb_gosub_align(struct intel_dsb *dsb)
 	/*
 	 * Wa_16024917128
 	 * "Ensure GOSUB is not placed in cacheline QW slot 6 or 7 (numbered 0-7)"
+	 *
+	 * Move to the next cacheline only for those two slots. The skipped
+	 * bytes stay in the programmed range, so fill them with NOPs. Any
+	 * other slot can take the GOSUB directly.
 	 */
-	if (aligned_tail - tail <= 2 * 8)
+	if (aligned_tail - tail <= 2 * 8) {
 		dsb_buffer_fill(dsb, dsb->free_pos, 0, aligned_tail - tail);
-
-	dsb->free_pos = aligned_tail / 4;
+		dsb->free_pos = aligned_tail / 4;
+	}
 }
 
 void intel_dsb_gosub(struct intel_dsb *dsb,
-- 
2.34.1

