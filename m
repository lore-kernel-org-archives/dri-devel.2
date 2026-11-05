Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A234F606A330
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ugreen.com header.i=@ugreen.com header.a=rsa-sha256 header.s=pkvm2402 header.b=q1zdsM6t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2486112C87;
	Fri,  6 Nov 2026 09:20:37 +0000 (UTC)
X-Greylist: delayed 346 seconds by postgrey-1.36 at gabe;
 Thu, 05 Nov 2026 13:53:22 UTC
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA53610E028;
 Thu,  5 Nov 2026 13:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
 s=pkvm2402; t=1793886797;
 bh=uWmr2ZKtpH5h2OBV51HqQXW86BPRnxbtgCLgC9kQTMc=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=q1zdsM6tOq7ieGS8iHqv4aJObV5BZcPF+E0QhFE/7RTjw2O3CRZKOepFXGVtpRKNW
 r1sj4CsF/MqQP6NM86gpCuTighaL1H/fVqqC/StiDQ+IXtZwfscdJFWdVgiF5WlFNU
 n6IEEpRuJ/3pwJUeN0jOPcCrRe7ryv5qN54Rdol0=
X-QQ-mid: esmtpsz16t1793886427t16ce7834
X-QQ-Originating-IP: KKWTrCpi6UQoea4zvr1hB8wuxKsh3btIMCG7n8Tta0I=
Received: from exmail.qq.com ( [113.89.160.251])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 05 Nov 2026 21:47:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13853959520253082465
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
Subject: [PATCH] drm/i915/dsb: Fill all padding before GOSUB
Date: Thu,  5 Nov 2026 21:46:58 +0800
Message-Id: <20261105134658.3724628-1-hanson.wang@ugreen.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OBupBPlx2MQ7edX+gYnAZbXL458segYHv0zB8Fyakxq9ghgn/g+TGnbt
 3cU4fyOw+rXrAWvmu56XNteobRofspeiYXXqpI3YuUOIjLfZe6ZbK5X8MaTrD8jUQtv98bd
 Y9X9SdYdnR0lvPRuIZGUPm7AKIGqTiH2R27gkwojcsqJfHG3ZA6dwJg/Zw1/Xx1/5siiEAT
 spJpUhvi9S0jXhtOzsBhyji3EicuMDN/j+r/R4nFzoG1JT3JQyb3bf5XFj8lQwwLE3W9gYp
 l8Zp/RD98cfKn6StRMlU/Scfuf9QQ/prLjjh2eemUVdmDCpFgtCMOtlyb66ui2qi6nwHPZp
 VcFNFjsRUlhP2wTktZWlfLNm/kx6w8DXZINTgseDOWTDmziAzg/djXrZ8j/49iO5PJWH7fm
 Am2j6PZNYUODuG+G+QsILzgCu4lr/MDEytvqvIxcRQYGX/I0vKGdgZ3FQGq2ERjn7lofcui
 QqiNsgvwsdQoYZmSjVjejBLcXkPL4OEwS8+bT8YS9rwBG32+5r7cmP5XJoAXwKHc7qCakmq
 UtB/s1voApDVbpaRq84xIf7yASrBztwEMZ/y9mGYLb/fw0rggen/Urja6LPlAd/B5QCn4dW
 g6Ch7ZaGny9SO2nIgzLruosQlRd4ZNsZDztp/BfWdEpPecBIZ4aZLjPgU1wZwVNrHn0rCqd
 r5f/6dQ48lJG/xDcfYjMGuNliEsI5HjjNi+tiN1dKgc94iQkPwRAFkD+tXS7LROk9xCNnn+
 c2pikJQDBvLAnAOTXE7hiRbkOOEHneza5b0EVs7t/mrWo7emWIW4SpvIqz0RV37KNNFTGZX
 zq6fZq7Vrrp4xvBUChA89rwdqHcWBGYL4Pv2uifD7Ry4Spp0+vEyU/sAOzbmb/9fmCnO6+Z
 RsLp8SQj9BS/KmhPz7B/rwtBlEz8PAn6uXjNTUDv5X0sS5H3sN0vAPQtLPhKP1gOCmulVhz
 DccTdjQwfQ0gtM9RmSwlc/2YQP1LtI1Lmubd5qexO3oG2zYyiTejNk3YAYoW95zcewDd7ge
 AWXnMP+CMsGCM+8ztI03lPSaEF8zU=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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

intel_dsb_gosub_align() aligns free_pos to a cacheline boundary
before emitting GOSUB, but zeroes the skipped bytes only when at most
two QW slots remain. Any larger gap stays between head and tail and is
fetched as DSB instructions.

A Panther Lake dump taken from a DSB idle timeout shows that gap: the
tail is 0x58, GOSUB is at 0x80, and the 40 bytes between them are
nonzero instead of NOP (opcode 0).

Zero every byte skipped by the existing alignment. Preserve the GOSUB
placement, which avoids cacheline QW slots 6 and 7 as required by
Wa_16024917128.

Fixes: 2c41d62f6fb1 ("drm/i915/dsb: Implement intel_dsb_gosub()")
Cc: stable@vger.kernel.org # v6.17+
Signed-off-by: Hanson Wang <hanson.wang@ugreen.com>
---
Hardware: Intel Core Ultra 5 336H (Panther Lake), 6.18-based kernel
Reboots:  7/100 DSB idle timeouts before this fix, 0/200 after
Build:    6.18 backport; both xe and i915 intel_dsb.o
Upstream: not built or booted
Reproducer: upstream intel_dsb_gosub_align(), buffer prefilled with
            0xa5. 5/8 cacheline positions missed NOPs before; 32/32
            pass after, including the 0x58 -> 0x80 gap from the dump
Limit:    these results do not show that every DSB or flip_done
          timeout has the same cause

 drivers/gpu/drm/i915/display/intel_dsb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsb.c b/drivers/gpu/drm/i915/display/intel_dsb.c
index d9a270362a82..b71e99ed8705 100644
--- a/drivers/gpu/drm/i915/display/intel_dsb.c
+++ b/drivers/gpu/drm/i915/display/intel_dsb.c
@@ -607,8 +607,13 @@ static void intel_dsb_gosub_align(struct intel_dsb *dsb)
 	/*
 	 * Wa_16024917128
 	 * "Ensure GOSUB is not placed in cacheline QW slot 6 or 7 (numbered 0-7)"
+	 *
+	 * free_pos always advances to the next cacheline, so the skipped
+	 * bytes remain inside the programmed command range. Fill the whole
+	 * gap with NOPs; clearing only slots 6 and 7 leaves a larger gap
+	 * uninitialized.
 	 */
-	if (aligned_tail - tail <= 2 * 8)
+	if (aligned_tail > tail)
 		dsb_buffer_fill(dsb, dsb->free_pos, 0, aligned_tail - tail);
 
 	dsb->free_pos = aligned_tail / 4;
-- 
2.34.1

