Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F3CC44514
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A57A10F218;
	Thu, 16 Jul 2026 08:21:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fErgMhjl";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92BAE10E58D
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 20:13:48 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2caed617615so52427905ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784060028; x=1784664828; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=d214MLGyf83e1Jqi9SjyzgCBFipAoJ9SSnt0shamnDY=;
 b=fErgMhjlDhfDZj1gTfk9a62EM1y8nxQBlAna4HzC6PcMd+qSRVcQWRcgx9yM9NIuRi
 MCtufhTx+ohbRUPqgqa9G/Pk5pd8U0kw2aOui7IfidFazFroRGARe52aORGbFVeeOjit
 1SAapZXeUnsJS8i4TJ2+P079bj65tvsDMJmafF4mf7WOr+Svq9UBrzTwg1BccdZWI6CL
 526kRlbmJCGkCVEVogLOmtzad5/3TtPTAsy0UVEtRNh5/IfDBkQlhg0KU7FpqpCqKFpS
 IdE95/SExQigVF+1IWkkx1z0fWUIJdXomscNVCgMI/GCbLKdVH5E/h9bJaO8V/tp/URW
 XQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784060028; x=1784664828;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d214MLGyf83e1Jqi9SjyzgCBFipAoJ9SSnt0shamnDY=;
 b=LjqhE8ykl02ldYKXZZMEDGiXYbUuk/nhdlqp8WVYea26mVzdWheI59ZYmeMgS5FIjp
 6wcN9UN1EpBmRIkYgJZ+wOstM/KlDk0XkXk64HfEIkCyozcrQUmzBWmDat8wvQrBkguh
 Ju4YhhoK3UHnTnfuPJW9TxDvC39cK7WV0q3Axwnz6CJ9Ob/lti/x2hnRhONo904MVgp7
 4grQKAAE0m1AiRLCATIYOs4IYjcoRrCA8gVyieT3WTSOm31FiR9iZayYyE0gayYwQZCw
 8VrZJ/FqVXUwodTYZQUGcRUZOi74Z67XhVxBJuV30rCVSApZMbST1rgQiYpAlTbuMeJC
 FqfQ==
X-Gm-Message-State: AOJu0YwhJL3LABCGgwuhOMTErqXREHTRbqacbi6bV87mu+OqkBa1SIwR
 QhGQQ/2LS8CxFPDh/rOlGfzKMF5XOSy4lkvtzghXCeQCC3uTYU3F/az0
X-Gm-Gg: AfdE7ckOBgsLE3BanXyFWndpz9xa6xWen1iCJgq3euI9ZK1fZbwkyiV26jHrkpuk6xF
 UPjWDyQStLFhV4696R5kgebV3nvNkDwzDvmfAo1OwIjQrb0Hb8uD1zVS/TNk61od0dpcE/86POW
 iiet3fHZGXp7cCH3jb0apJDYsE9SePbzlmo75F/i6CKrZgkCoNhjohOhPDXWbdNt6k/UGYK0RXk
 xgYmjJNvdFb67cMBxlRhTS7eO9v62fhIewapFANBlqfB27IkNMoFArv3bxbcN7pO+hQwVASYpnS
 uRBLNKk4MWXK6vVTfKoVQFTrDH//bU+zIvqO2fhvSC9h0zJ3OsYMi6YpFTGDqlfcvM8TpxYDsx8
 ihJNqSRL061YByrigrLcQOc+dVkti6C18BB9CeiEANcU2hhpio71XksyGumdeXvOeLXMgesDI3B
 67+jcjaa4dw3mpPVJfG10phhYf2DbmyxPJc9NN+KVZX/jsxoAcfxVNQblDpyY=
X-Received: by 2002:a17:902:d591:b0:2ca:c68:c554 with SMTP id
 d9443c01a7336-2ce9f15d1f6mr140607525ad.38.1784060028032; 
 Tue, 14 Jul 2026 13:13:48 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3d45csm120844995ad.62.2026.07.14.13.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 13:13:47 -0700 (PDT)
Subject: [PATCH 3/4] fixup! accel/amdxdna: use
 hmm_range_fault_unlocked_timeout() for range population
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
 corbet@lwn.net, dakr@kernel.org, david@kernel.org, jgg@ziepe.ca,
 kees@kernel.org, leon@kernel.org, liam@infradead.org, lizhi.hou@amd.com,
 ljs@kernel.org, lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, skinsburskii@gmail.com, surenb@google.com,
 tzimmermann@suse.de, vbabka@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Date: Tue, 14 Jul 2026 13:13:46 -0700
Message-ID: <178406002613.1082778.11295976907808029605.stgit@skinsburskii>
In-Reply-To: <178405975214.1082778.5193079941156341151.stgit@skinsburskii>
References: <178405975214.1082778.5193079941156341151.stgit@skinsburskii>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:18:22 +0000
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

nouveau_range_fault() now uses hmm_range_fault_unlocked_timeout() for
the HMM fault path. The timeout passed to that helper is meant to bound
HMM's internal mmu-notifier retry loop, not the whole nouveau retry loop
around mmu_interval_read_retry().

Pass the full relative HMM_RANGE_DEFAULT_TIMEOUT value to
hmm_range_fault_unlocked_timeout() on each attempt, and retry from the
nouveau-side mmu_interval_read_retry() check with a fresh HMM retry
budget. This lets HMM continue when it has made progress, while still
preserving a timeout for repeated notifier invalidation retries inside
one HMM fault attempt.

This also removes the open-coded absolute deadline and remaining-time
calculation from nouveau_range_fault().

Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 drivers/accel/amdxdna/aie2_ctx.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 548ba4315554..21f2817751f9 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -1037,7 +1037,7 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 	bool found;
 	int ret;
 
-	timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+	timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
 again:
 	found = false;
 	down_write(&xdna->notifier_lock);
@@ -1062,13 +1062,9 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 		return -EFAULT;
 	}
 
-	ret = hmm_range_fault_unlocked_timeout(&mapp->range,
-			max_t(long, timeout - jiffies, 1));
-	if (ret) {
-		if (ret == -EBUSY)
-			ret = -ETIME;
+	ret = hmm_range_fault_unlocked_timeout(&mapp->range, timeout);
+	if (ret)
 		goto put_mm;
-	}
 
 	down_write(&xdna->notifier_lock);
 	if (mmu_interval_read_retry(&mapp->notifier, mapp->range.notifier_seq)) {
@@ -1086,7 +1082,7 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 put_mm:
 	amdxdna_umap_put(mapp);
 	mmput(mm);
-	return ret;
+	return ret == -EBUSY ? -ETIME : ret;
 }
 
 int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job, u64 *seq)


