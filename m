Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5399606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 06:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R3im5hpf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D811C10F056;
	Mon,  9 Nov 2026 06:33:22 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7338C10F047
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 06:33:15 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-8b0dba37a7fso4282887b3.0
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 22:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794205994; x=1794810794; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/6xAcNgXFNL57f9BORMWRpcAJ7o4qJ0juj5y7y07eMI=;
 b=R3im5hpfoKkBzRk1Diwjx0/3tWH5WFnHUAehROdYjEnyVtjdRyf//ynLmKzSAkb4za
 Ue+1Nk0thf0oS2szYKLVBqm0AkVkVEsMqcpLel4mkK9gaEX31iFm2cTiHP0Gk9qcJLXi
 PaNDQfqyHA5GgfjQTRNj3rpDl3YDNgg2QOR40Nk6vYKDl3FT9t9W41yKjuH3XQKcJVLO
 UB/+0XuupUzrqEo/dm5PcylM5dJ5W8MZebJpnxK64H/ROIRaJvuuc4lLNV1hUQKjKGg2
 pXN4o12oHxr3Gp69bDlTEk0VZJ/AGms9E8ObdJGbn0hHraWn1ddD2GOnkh/XqOxeVqnv
 oPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794205994; x=1794810794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/6xAcNgXFNL57f9BORMWRpcAJ7o4qJ0juj5y7y07eMI=;
 b=lTTitOYltv3DfLg2NCezj0FbNsVhl8cQLyDIZ8CPDQL40gK8n7nNPBRYr0Ks3awN9u
 N9GQc8THXlpYPIQNMzct8c6hZTxAcTnpgwRLqAj16ads1ir81Yl7E2h1sIeOheAAJ6W/
 X0wFCCySALIPnQigSH2Z2B/D3UvVj0Z3n5anaH6fZv8yCT4uaMYBR2HwWMigwFR3VKuR
 dIZJJaMzLLM9qohBK8qKTDQ4B9x1/vC8c/+sTWMxRpM+A/u/QcyVOEkU+DP5yjE2izhA
 OiUiG+Q7iA/xw19lJ6SbsYhJJa2usLYRO+CcN1dT2DpvhaxRJH22kBk7xSDgOWOEbKL4
 DX7Q==
X-Gm-Message-State: APuU4Z+9YtrUpGfTBGXwJvvLoG0rU5qu2zt76s3u1BS0oVs+ltRfJYuR
 33XyFPDPZqNA6ofDen3GRsXbupepd9svAti/yUEQYqeQJSUcWR3TWAfiZ+piQQ==
X-Gm-Gg: AYBFou2Pqr3ZAoic+WlmbindPhxlZHo4XmmMy5WIV3uAVGRHbp07a2zeBrYU3NisI9K
 fsYTWQf2fIoqQeiHIoeBaOGuLohyU1EacW9K6Ty5cCDAYhCsmF+KXkW9zAdN/ybPR1jUiVtRsxr
 PHDw5GQL8GSiVEBL1SoDDIZAwJAcSVxwJGJpFPbGYLp/A5YTFVWcgxDZbep1olNQCBcitiPfpGZ
 C/XTGMGkfHuxaFFaxK4ajJfyPPgFvfe2RZzi+5taxB0IPYofKntM6kDLVPcQglyyTgJCL9xfOzO
 1zFOad7O6paLI1zAlwI8U3KbGYspwlIuI1aJSn68bSXy+E/VgvxzfAwQVeXOL2Y+XxSvWLkwkij
 jDB8VbanGLEeQQCzNn7zOuxq1JNPjYllJYoqoabsgQcjwfAuq4QbQJS/zKCvBZrz7b+ZlF2W4HU
 1zmQF2+TRSlRnk9nMSclvTfx7nVtVyuW0H/QCBW2BHzYRgXYhAGk5QsQieYGJrEz9/Mf/Ci81L5
 3TvxEhRdwNVfMHL7yvUFBFqgnb7NDsX3HSWaSoXlDWdmr4tRmasZNq3c/d5mb1cTlCwrFTdboL5
 PAVUQK5v0iZ08URUMrs5+Y/txfg/yYaCbqbQWPfqyg9E2UGA7yA+fjPOkxbPh5E3qQ5kytgqg9Q
 nB61q4JJm5vCj
X-Received: by 2002:a05:690c:b03:b0:8b3:2445:8d3e with SMTP id
 00721157ae682-8b36caee12cmr16690497b3.56.1794205994475; 
 Sun, 08 Nov 2026 22:33:14 -0800 (PST)
Received: from localhost.localdomain
 ([2804:1254:81a4:f900:8485:f8a0:b2aa:dee6])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b36bc43733sm29035827b3.33.2026.11.08.22.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 22:33:14 -0800 (PST)
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: patrik.r.jakobsson@gmail.com
Subject: [RFC PATCH v2 3/6] drm/gma500: Fix SGX page-table cache-flush mapping
 lifetime
Date: Mon,  9 Nov 2026 03:33:00 -0300
Message-ID: <20261109063303.32658-4-operatingsystemsdepression@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109063303.32658-1-operatingsystemsdepression@gmail.com>
References: <20261109063303.32658-1-operatingsystemsdepression@gmail.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Flush the modified directory entry before unmapping it. The old order
uses a kmap_atomic pointer outside its mapping lifetime, which DMA32
direct mappings can mask. Use kmap_local_page under the existing spinlock.

Also calculate the CLFLUSH iteration count only on the path that uses it,
avoiding division by an uninitialized cache-line size when CLFLUSH
is absent.

Fixes: 8c8f1c958ab5 ("gma500: introduce the GTT and MMU handling logic")
Signed-off-by: Gabriel Gama <operatingsystemsdepression@gmail.com>
---
 drivers/gpu/drm/gma500/mmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/gma500/mmu.c b/drivers/gpu/drm/gma500/mmu.c
index 4fbc22a59..34ae0f125 100644
--- a/drivers/gpu/drm/gma500/mmu.c
+++ b/drivers/gpu/drm/gma500/mmu.c
@@ -265,7 +265,7 @@ static struct psb_mmu_pt *psb_mmu_alloc_pt(struct psb_mmu_pd *pd)
 	struct psb_mmu_pt *pt = kmalloc_obj(*pt);
 	void *v;
 	uint32_t clflush_add = pd->driver->clflush_add >> PAGE_SHIFT;
-	uint32_t clflush_count = PAGE_SIZE / clflush_add;
+	u32 clflush_count;
 	spinlock_t *lock = &pd->driver->lock;
 	uint8_t *clf;
 	uint32_t *ptes;
@@ -289,6 +289,7 @@ static struct psb_mmu_pt *psb_mmu_alloc_pt(struct psb_mmu_pd *pd)
 		*ptes++ = pd->invalid_pte;
 
 	if (pd->driver->has_clflush && pd->hw_context != -1) {
+		clflush_count = PAGE_SIZE / clflush_add;
 		mb();
 		for (i = 0; i < clflush_count; ++i) {
 			psb_clflush(clf);
@@ -331,16 +332,15 @@ static struct psb_mmu_pt *psb_mmu_pt_alloc_map_lock(struct psb_mmu_pd *pd,
 			continue;
 		}
 
-		v = kmap_atomic(pd->p);
+		v = kmap_local_page(pd->p);
 		pd->tables[index] = pt;
 		v[index] = (page_to_pfn(pt->p) << 12) | pd->pd_mask;
 		pt->index = index;
-		kunmap_atomic((void *) v);
-
 		if (pd->hw_context != -1) {
 			psb_mmu_clflush(pd->driver, (void *)&v[index]);
 			atomic_set(&pd->driver->needs_tlbflush, 1);
 		}
+		kunmap_local(v);
 	}
 	pt->v = kmap_atomic(pt->p);
 	return pt;
