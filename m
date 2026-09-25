Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA972C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 20:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DA5410FCB0;
	Fri, 25 Sep 2026 20:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="vBQ/Q1zG";
	dkim-atps=neutral
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2ACD10FCB0
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 20:44:29 +0000 (UTC)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3a0ca0344aaso680582a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 13:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790369069; x=1790973869;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HF1Qmy6ruPKeRtkKuZoMA0fFwHNLsCEq59RB62k4IKQ=;
 b=vBQ/Q1zG1KJ6MpwzXtwAYE9mgMAgxwf/YRJVQ9Xa7GCkJiff05ViR9NXmW5Xu2cyD5
 E/8OTcATDToWLjyuBlA2dDmqvgtI1mgGT9FbEyJWjY6zQwqHB0UcwZ1Kl8sX8w36bttF
 +OQ5LtdLg1ut0N8Jq1GkgmHPXNgKIffmAMHv3ZNTcVwkmiPGt0Q3/wip2lGGGOEqGxOI
 2/uw5VbaIK1Bnlvz2XG9sn/XxODUxZKpKYWekXrX3Tcjr9kOXpmd/1eVoHX/lRQVA+nd
 aUjUlZTENrKjkyw4WFn0TpiL0LiEgKZ9N/p0v4vzMMNa5UCEhQcHvl5y0aEBXZm0bp6U
 VswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790369069; x=1790973869;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HF1Qmy6ruPKeRtkKuZoMA0fFwHNLsCEq59RB62k4IKQ=;
 b=tonpgFiM1pwx4FmTy/BKMklfr4sJQUJTkKfu/Jt5cO2mpbXnYMvpgwLnJpkwMkIh/N
 rQLwTSkuixWOS+NEGTxM1LoT3J9SrgXaU1K2kiY71DRan4ybwue3KFFFyqMA3AluR/w3
 GL/BywsJkgLCrtHH5XM4X689263GK3o0+fBoctwY+7SMzPlQdP8Oeut1OoXD/57DCytN
 p012TJ/Vt/E3UftcJMQ0Bc1SlvX/+kPxNZLLYG3ViN90W+lQWSdNmYAj2M8cT9OfWS/q
 E8Sp5/X9IXKjolb0Voubr3AKMT7rR6b6L1SfPOkRmXSK0LZkZAOY3+mGKXlfuS3wsqwr
 VZFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMIryfzjeXmJVlt9BC+UNOeqRTADeerQffgP3oTY1gwPkL2XBtQIPUehkUNzt9VwdYiCJdSywS3fs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nYGiFYeW7z5836s2rz0aPi7YfeebwqSy63h+Qxf/Hbetd74QEd
 xyAAqphI90D3eLG3kiSy9UBdazIruM3AcSiGCSDz6c+Nl/any1U237nzKfMAO9r1YfC0h16N6Xa
 t
X-Received: from pjbmp23.prod.google.com ([2002:a17:90b:1917:b0:3a0:ca11:2396])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4fc9:b0:3a0:c5d7:cec
 with SMTP id 98e67ed59e1d1-3a0c5d713camr1775083a91.24.1790369069068; Fri, 25
 Sep 2026 13:44:29 -0700 (PDT)
Date: Fri, 25 Sep 2026 20:44:23 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260925204423.80661-1-morbo@google.com>
Subject: [PATCH] gpu/buddy: add __counted_by_ptr attribute to roots
From: Bill Wendling <morbo@google.com>
To: Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"
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

In 'struct gpu_buddy', the 'roots' field points to an array of pointers
to 'struct gpu_buddy_block'. The number of allocated roots is tracked
by the 'n_roots' field.

Annotate the 'roots' pointer with the '__counted_by_ptr' attribute
referencing 'n_roots' to enable compile-time and runtime bounds-checking
via KASAN and '__builtin_dynamic_object_size'.

In 'gpu_buddy_init', 'mm->n_roots' is initialized first, and 'mm->roots' is
subsequently allocated with 'kmalloc_objs(struct gpu_buddy_block *,
mm->n_roots)'.

Since the bounds associated with 'roots' ('n_roots') are fully set prior
to any array allocation or access and remain invariant, this annotation
will not cause runtime panics or false-positive bounds checks.

Cc: codemender-patching+linux@google.com
Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
 include/linux/gpu_buddy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
index 2c36124bb696..d7249e500ab6 100644
--- a/include/linux/gpu_buddy.h
+++ b/include/linux/gpu_buddy.h
@@ -172,7 +172,7 @@ struct gpu_buddy {
 	 * a power of two, with each root being the largest power-of-two
 	 * that fits in the remaining space.
 	 */
-	struct gpu_buddy_block **roots;
+	struct gpu_buddy_block **roots __counted_by_ptr(n_roots);
 	/*
 	 * Per-order free block scoreboard: free_scoreboard[order] holds the
 	 * number of blocks of that order currently in the free state.
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

