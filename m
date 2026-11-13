Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45C4606A335
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 07:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l9LlRlB0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21EAF10EC0A;
	Fri, 13 Nov 2026 07:54:41 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93ABA10EC0A
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:54:34 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-3b0a519049aso1045448a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 23:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794556474; x=1795161274; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/oSrBPXKrNYnAzFH4eNjIUEYe3r0QmvR+RTmTsBOz3A=;
 b=l9LlRlB0OaPPrimI0eNzh1Ln2NMJ+FtbZfI6gwM0OvEzs/92LcJF2yfRV6+xlb0Kns
 GsoFY/GUU+50fEpmNGYjoa9EM7jnPDDEykGCrOhJV5QHbIz1wh77tpizq0Vv+IZc9heQ
 WJ43dIfYeTbz56cWUpincWsCwXb7wMRRBXSASZGLWenJRhWKnEtBGN1kjkB2FB7djOv8
 p2uhTYeDi7sYyFot32KtSjnll/Vx3g6spTEnyoLWv0bhNtnZm/ZUH5DJj8wW24BpcuwK
 E6Pzw1wuPLUVo6LPoiimeasLgTDV8PaMpVz4rclArwSP9dHzrg/KBdweLbbTfwpjr5SG
 8j+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794556474; x=1795161274;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/oSrBPXKrNYnAzFH4eNjIUEYe3r0QmvR+RTmTsBOz3A=;
 b=cVmJKbKj5idPHeWBbxs0GUaZ7x6U2hYzk/yFJMv124XOX37JjwH5y6of6ohNmSQPpm
 Fk51YM1UF41RgCj/sMdsSFyQc53A+L/aIB5PMx2WnkvSh4LLtr5zUDGQbAHzwPdmts9u
 D4qG1msXY0me3ELWOJ2RcB9auKJwRa+izMBLBL/reT4IZbTViRoCsq/tlA2BPxyug8if
 LhHvwqtuyL3f0taKW9YHgn86uHxi2KS7SXqsF/y2PggWSpl+Xuh/Wlo0XonlOxnC4BHQ
 EdW293EW4O2RfSwOg/paR57XBgaXyJqnRZus8fPbTsX4NAt7CRRa0F/dhLAj3cddM761
 d0cw==
X-Forwarded-Encrypted: i=1;
 AL+hErGlBC8kzvODzWFfTd9PsknQSH5ER9cDaulWqMXgBzJTxeeI1lZc/OBdS89u6N2KapO99V5A/If8TKU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+mH+QGoQOw4oBjPGaDvsuxLtVN/mOWWGBEl6NGJ0Z/4cHpVWLI
 iClCwZ/mLsVrZrIO47MXM1ye5KK5qIZa17usZ+atBXeklg9wY0WXAYwL
X-Gm-Gg: AYBFou15KBlZExrZe6jESBC/qtIrcRL9enisCANC69dAjIvtHPprrFfdd+Sl5tpeiQQ
 bNUwxTvgTgBEGVOGvZCBqU8MEwCcQjG9kPsR47FnWr3NeVpahbleIFnmZvFwMLCfbhZcrESqIHu
 9SK/EPHnJ3mDtL6WcGWHeBHohfC9C4CdGcxrp6nUIOZNMjtrOq7+iQdsYP0vknvU0VGTaPy+Bdj
 g11OuyRWc84u5JBqucaySfNojmsByYQwfDKM1NyCDH1LTnI9vbanCrrzK6f+pIC2UXEPNo/ZwIS
 bUuRD3piNbzodcD0NKrR2NE5yKLplpqFicHAjVQzwbJokqFFfMqEjiD9mxd8kkeLFEYTg9tphoD
 CMj6NgTJVD2+Xz5QdMVYLL0YbTV/wXe9pGyOmTHEb/WSQfJZttNx2Aut1vy0buQxmnI2RUNGQ4U
 ysD4XfxbTtRNK4zhZ8jXhHnwWCwYCvsABduDDUb8wsC22NSJw9hL6bpyq30wYsA+spX0Vvsg4nx
 rGSIplGLsd2Ngbki0Qr0W7Rn59gpWwlzHrl/frZiY3BXnk5SfhUWlr5QtCmRbj0g3rNi2mrsC2b
 DUftE2XzlUB/EcxV1WXyJXg5oUwt2SQxOAw=
X-Received: by 2002:a17:90b:2247:b0:3a8:49f2:8ddb with SMTP id
 98e67ed59e1d1-3b1b0d4f314mr1396218a91.60.1794556474024; 
 Thu, 12 Nov 2026 23:54:34 -0800 (PST)
Received: from localhost ([176.210.133.73]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3eaf732sm1024539a91.3.2026.11.12.23.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 23:54:33 -0800 (PST)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	joelagnelf@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ecourtney@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 vladazaharova2018@gmail.com
Subject: [PATCH] gpu: nova-core: mm: keep a page table page before installing
 its PDE
Date: Fri, 13 Nov 2026 14:54:22 +0700
Message-ID: <20261113075422.943779-1-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.56.0
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

install_mappings() writes the PDE of a new page table page before moving
the page into page_table_allocs. If push_within_capacity() then fails,
the page is dropped and its VRAM freed while the PDE still points at it.

Move the page into page_table_allocs first, so that a failure leaves no
PDE pointing at freed memory.

The problem was found by an LLM-assisted code review.

Fixes: 4e4182282d4e ("gpu: nova-core: mm: Add multi-page mapping API to VMM")
Signed-off-by: Vladislav Zaharov <vladazaharova2018@gmail.com>
---
I could not reproduce the failure, as it needs push_within_capacity() to
fail. With the change, the MM self-tests still pass on a GB203.

 drivers/gpu/nova-core/mm/pagetable/map.rs | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/mm/pagetable/map.rs b/drivers/gpu/nova-core/mm/pagetable/map.rs
index f7774b9cc972..e678197ec009 100644
--- a/drivers/gpu/nova-core/mm/pagetable/map.rs
+++ b/drivers/gpu/nova-core/mm/pagetable/map.rs
@@ -209,8 +209,15 @@ pub(super) fn install_mappings(
                 let (install_addr, page) = node.to_key_value();
                 let page_vram =
                     VramAddress::from_raw(page.alloc.iter().next().ok_or(ENOMEM)?.offset());
+                let level = page.level;
 
-                if page.level == M::DUAL_PDE_LEVEL {
+                // Keep the page before pointing a PDE at it, so that a failure here cannot leave a
+                // PDE pointing at freed VRAM.
+                page_table_allocs
+                    .push_within_capacity(page.alloc)
+                    .map_err(|_| ENOMEM)?;
+
+                if level == M::DUAL_PDE_LEVEL {
                     let new_dpde = M::DualPde::new_small(Pfn::from(page_vram));
                     new_dpde.write(pramin, install_addr)?;
                 } else {
@@ -218,10 +225,6 @@ pub(super) fn install_mappings(
                     new_pde.write(pramin, install_addr)?;
                 }
 
-                page_table_allocs
-                    .push_within_capacity(page.alloc)
-                    .map_err(|_| ENOMEM)?;
-
                 cursor = next;
             }
 

base-commit: 0ff9e5b9ff6736c37593cd7db89f4593ec4f8e86
-- 
2.56.0

