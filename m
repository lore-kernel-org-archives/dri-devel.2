Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF70FF885A
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 23:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F6FB10F703;
	Fri, 24 Apr 2026 23:39:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="U1zxm/6M";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 062D310F6FD
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 23:39:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777073977; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=j4yqZFlbhRNRcTkG38zUXIyGNscKDK86d/SNZy0+lPdND0/b8eQtGiLs4Rgx8m6Q3mvEy+wd/oehXLvonqBBNf/61mHcQ+jz9RCrNkskFA4gSPIvYM3XyoOPC9WHqXm2i+wA2/azdv8YptlFwbIaU0xI7gOMSpi5t7kB+FNmpiU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777073977;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=/+Bs/0J8wvLVIMnAWGrioccsFmMau99uV3OrtjMxSks=; 
 b=aMWUe+EpN9o6uWLQO+w0lEZ0rr/5nReI+3eiCczHoyZ0bnSaEFLVyHkqBRbTcekJNLTBRideudJGNs56fXVtI/+0JbVaqLeu09U55qnChlIhlSgSWUhjbrS7S4hEDMDEhUL4rUQAfN/PwVRWl1UXiua7s5UxdORtOJVYbhluv/8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777073977; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=/+Bs/0J8wvLVIMnAWGrioccsFmMau99uV3OrtjMxSks=;
 b=U1zxm/6MMafbnOVCMkNrmUzIdois5VNBdLV/u9rLmvFJilx6VRdfLaXRJiYpLWyD
 fq+2SFoXLjBs3slgYvLfaS83jUSIbGuddSNtPT+mfL78ngQFSDnjQ0kUN3IEVhum4gG
 y0lFVtLzlbTiqhwB9A7UYOr68qp7wB/XTS/tnjqw=
Received: by mx.zohomail.com with SMTPS id 1777073975875885.6417438018601;
 Fri, 24 Apr 2026 16:39:35 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Fri, 24 Apr 2026 16:39:11 -0700
Subject: [PATCH v4 17/20] drm/tyr: validate presence of CSF shared section
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-b4-fw-boot-v4-v4-17-a5d91050789d@collabora.com>
References: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
In-Reply-To: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com, 
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com, 
 work@onurozkan.dev, alvin.sun@linux.dev, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=neGeXBLLWv+VgHlNwEcO7pTsPBbTnR339iSnYWTHwb8=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJmv/yvw6vibHUnx4y6OiVp6oPh/UqG3MfdOtruMvycsC
 yycd/FrRykLgxgXg6yYIstZe6Me8ar3Rrrz/zfDzGFlAhnCwMUpABNhqWBkmDL/ySp95w79oB6R
 YCatk0ftPz6c+ph1n2FsjUTsy570P4wMU+qFZEwWepW+cVkVf2jidIs/Bte2ie5+3B3YZ8UT51T
 HDQA=
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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

The firmware binary must have a shared section for communicating with
the MCU. Check for this section after parsing and fail with -EINVAL if it
is missing.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/fw/parser.rs | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/tyr/fw/parser.rs b/drivers/gpu/drm/tyr/fw/parser.rs
index 638707430701..0be3b740ea65 100644
--- a/drivers/gpu/drm/tyr/fw/parser.rs
+++ b/drivers/gpu/drm/tyr/fw/parser.rs
@@ -175,6 +175,19 @@ pub(super) fn parse(&mut self) -> Result<KVec<ParsedSection>> {
             }
         }
 
+        // Validate that the firmware contains the required shared memory section.
+        let has_shared_section = parsed_sections
+            .iter()
+            .any(|section| section.va.start == super::CSF_MCU_SHARED_REGION_START);
+
+        if !has_shared_section {
+            pr_err!(
+                "No shared section found at 0x{:08x} in firmware\n",
+                super::CSF_MCU_SHARED_REGION_START
+            );
+            return Err(EINVAL);
+        }
+
         Ok(parsed_sections)
     }
 

-- 
2.53.0

