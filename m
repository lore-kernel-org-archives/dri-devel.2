Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7CC606A33A
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vCSZfjPX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 444951127BD;
	Fri, 13 Nov 2026 20:26:19 +0000 (UTC)
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 289831127BD
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:26:12 +0000 (UTC)
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-67c246c0c60so2437636d50.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794601571; x=1795206371; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FuA2A4au3ewoC5DCp5ZcG8YYlH9ZhO81BzKrIIr0TVo=;
 b=vCSZfjPX3fAaaozKpdn8ZRrdbCSE2K4oodOwVkkLAuK/W1U/uII+UG6DrLkpTTfuXy
 rUWHVQg38eesizu78EGmaliqqx1cbQEE1XwusRJd1PtPhmaWgVqrVEuDEDLZbVJfeCw+
 Kqm5Zr/AzAHs6TKCfO1WbpOXfGq5D4MI+6awM+Vpg9sLtrMp1CrmXbTQlA/7Kpav/aOU
 kyfqbsAimfJU5yPdEINecTZqxgi+fZJKqTGA7BXz47bRXMP2RboCNv5nh1PvYysbQar2
 UmTDd8xZ0zhFr1nvD3j1mLRaUvcKXjL9zxaoWAg2zhRgYhEbyVtHMv9fpME8xYcDrCE2
 nmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794601571; x=1795206371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FuA2A4au3ewoC5DCp5ZcG8YYlH9ZhO81BzKrIIr0TVo=;
 b=e8eCZBa5JBVY1Wiqblj151WrabGsOly5uqs2mjG3O3cjhOoGBHlq0UYHDnRuQw6xBZ
 QxZ5dsLuddo69xeolsLPoA9dxM1oUfvSRe8249KYQzFYcym66i5yIrJYirHvgwrlbCMz
 6DaAhWJyQw+nsmOt9py0TR3J2YwHYWkzWAWi79VbTQord842JqxgInS/wbf3OJijL4lk
 NTYIQc1Bu76N8g/pwrzE6k/wBd3rAL3QR50jWZ0sapJjdYeWg04Bt+2xQNY/hTGvUym3
 1+Fr1qj3VZrDEgw22HMTx4qhNA7v72wxcbvHyDO5CdGFuicpjSNgdAlwg9LESPqDB0Zx
 jXfQ==
X-Gm-Message-State: APuU4Z/nUbOAB8oiytQRuVKy+V1KKymwqePg+mPBNWFnSLnzaqqVRM72
 Zpmq2uCPVCh4Dn5GiiG7CSEL8uTGwXD9nD+MrgqMRv3suP4LgRdZB/WSXmRkxLdgdzk=
X-Gm-Gg: AYBFou2szK7OlwMWAsn9nu1/D08Kg5juam7ORAO2EXj8cseMc34k9STEar50h5Q3xXh
 RXrJZx2Q+EaOSvT1wt2Iy/HbxMtqYtpch8syCGleseRBuDH1F+Ox6czJoDhGZKgjUFzeaDERn3W
 OlYj98OQDZDjI73pU5kNCSQLdpRRmIbvTKpfl92N+KXcYqiY+WqMleuUjhMnAEbVRrhm/uyTeh4
 3XVr2HvA7KlFXB5uHy1bS/PtuJ7c72qGzPdtZIQtFDChyImZknCe9wNj2likNcac+uS9CcadAI7
 6c/leFFXQZmDlBU/4Xk7SycE+aRf4P2RFG6uKREEGsuNqiFk9sAEw+KP72bCbVF3CMcL9REU+zh
 GfyuRa+XjQuX7s/FcAPF7YPAppPN/Oc0SSF0tf8t5b2nYpxVO49/u4YYOHdxrbKw1mLdNRkWkA1
 Jfdd6qzU9jElmxc2j7lJFwfU9vLLMrP3WckXKTl03jfFYImRrswpDI1UrZc6dySBbswal5MRNCg
 R8jwnWGrFewMILP2GsLerRgmyQL5RzCrU1GqnBZu1MK96LawCskGh6Mhu+GJ6Cm/Do9GaX2xisN
 MDDyuzeOZ2LMh5HTpFIgs9aXyBBsAz2SQ9dWixq0YHKcYGIYpT0sZVbJ0RyCA0d7gXY=
X-Received: by 2002:a53:ac9e:0:b0:677:cb43:4b10 with SMTP id
 956f58d0204a3-67c7886b5femr4163088d50.6.1794601571026; 
 Fri, 13 Nov 2026 12:26:11 -0800 (PST)
Received: from localhost.localdomain
 ([2804:1254:81a4:f900:fd83:f7ad:7c00:7806])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67d8a555cf0sm2951273d50.5.2026.11.13.12.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 12:26:10 -0800 (PST)
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Gabriel Gama <operatingsystemsdepression@gmail.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Joseph Telaak <joseph@telaak.dev>
Subject: [PATCH 3/10] drm/gma500: flush the directory entry before unmapping it
Date: Fri, 13 Nov 2026 17:26:05 -0300
Message-ID: <20261113202605.15327-1-operatingsystemsdepression@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAFGNeaiEVnm_b8OBEELseBg9JDgm_PuDzZG2pQu8KxFPnzANyQ@mail.gmail.com>
References: <CAFGNeaiEVnm_b8OBEELseBg9JDgm_PuDzZG2pQu8KxFPnzANyQ@mail.gmail.com>
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

Keep the directory entry mapped through its cache flush. A 32-bit
HIGHMEM kernel with CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP maps even the
lowmem PD page through a temporary fixmap slot; clflush after unmapping
can then access a cleared PTE. Use kmap_local_page() under the existing
page-table spinlock and unmap only after the flush.

Fixes: 8c8f1c958ab5 ("gma500: introduce the GTT and MMU handling logic")
Signed-off-by: Gabriel Gama <operatingsystemsdepression@gmail.com>
---
diff --git a/drivers/gpu/drm/gma500/mmu.c b/drivers/gpu/drm/gma500/mmu.c
index 4fbc22a59ac7a9e76a373b65cd7fcf97aa1605ba..de2dd41ad23884afa486162d3fe8f9c3a4149684 100644
--- a/drivers/gpu/drm/gma500/mmu.c
+++ b/drivers/gpu/drm/gma500/mmu.c
@@ -331,16 +331,15 @@
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
