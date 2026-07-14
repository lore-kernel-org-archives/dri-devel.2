Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8EFC44511
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBEF910F1DA;
	Thu, 16 Jul 2026 08:21:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qovwK4d+";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC2EA10EE6E
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 22:21:44 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-848643382fcso5402548b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 15:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784067704; x=1784672504; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=O6UyZtJMGWyTXwkf9Ut71gXKM+acqkuQS9WqdrHTITA=;
 b=qovwK4d+u27hpvbvCUVjMBJdX25FzMq8uZeMXgsjDHSIn4u1DJK1j1TFqI6w6R/7aM
 E7iOLA3pmFJZGh1BeWErl8lfaPFVrhWPX1CKv9AbxsFhTgyYqSAh78QLO8JKIsdoeDPx
 DFr/Ksw1M1QSr7sSESTsJFOR1MEnSruLDpNgFTK2atzVWhZaRC62NVKyju6Wi5UJpx19
 BfFl8GwkbvNemjZXiyoiGaIiOA0iUYzR+4IMyG64+Cm090NxZ1s4iXTkMeNB1ELJWQab
 sBd+oYGPJ2UC3DhHqsp+VaaawJbvusOVU2HPj7BPzCbP60S1UjmFNdAuFAh71C5kcmql
 zSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784067704; x=1784672504;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O6UyZtJMGWyTXwkf9Ut71gXKM+acqkuQS9WqdrHTITA=;
 b=cvuRfciW5O3H64Yk5+XubabkV5HcxoKEtJM5FSRiC7aKCGZ0Ke0/JHj0TzVu8nxVB3
 3BiTJdk5uezl5rlujtRmovJx0xvv0P92HGew8Qzihx50TBl3L2ZPheencHhf7ueDiSYb
 zPEGHQqwpUGWt1XVpIMzdCNg3qYkeZi8dxLJtcLSDEa6CLYOZlnysYWh/TrIbkYyjKgs
 d1M5jXOxngVhjE6FiLWmDeEpEvVW84UhTOFFJshqDwuLcgfMX/tIkMbABPaCQJZxj7e7
 NRMDV3MKrd6xRmVcmyOerCRpLu4a1xvNIKXazUmxNhLLl0w9+N6rnA01tdNPLmjkK5UG
 QeUQ==
X-Gm-Message-State: AOJu0YzZdOv5vR2bLNyrRzRE22LLblOF/i1GpJPb2zMw/m1QSFbSXyy+
 RsXLWjCoTeobaad6AkAvI2hXitBXRNGwxUpo8yAMQRIbrGViXWPaqEZj
X-Gm-Gg: AfdE7cnejkuKUAYeM0tAtPuAJYenwPlOPm7I04xbyGmkPfFFRIOkz9YVxu+XQlFPQtK
 aZeZRaekiqexvuxEd+BHxkgA/81GYW60esja4M+Oc3zafMIEV33KCXj/kJBPfU45gMjbNMj1mil
 iZtHVFgOYApL0uJLfzq0sKAkeWvCFuIeJYdkbI4HOzKYEi1e1l14K9DV8yRAhlRTPwPS77Uoj/i
 Sd9be3ERI5Zlq5pa/ENWtqoudgARJRpj5u2llA0qaXUcKHzSwP30j9SnBVGt3SthlFRsXq9E7XR
 X6b0RQtcPlD1HRNVA/7dhugxZRqWIjFebR7bdgZirYBQ9iw8PVQ+3Y3AOwl/qR7sxeGjicxa1rH
 eVAAnCDH6H4PEsTTiihaEyHQ53++ElPVfy2dhSGfaK+sS5donD3Mn2RL2BwstC9h4zr5px8BCKI
 2TG3z1jkmlVxM4/5VevkDI/FWSR26AET6oSfc54Bn5Wl2fef1TFCFZlmPKWfU=
X-Received: by 2002:a05:6a00:1819:b0:848:4742:90a6 with SMTP id
 d2e1a72fcca58-84a5140d4b5mr4845081b3a.15.1784067704431; 
 Tue, 14 Jul 2026 15:21:44 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84a4ff2ea4csm2010807b3a.23.2026.07.14.15.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 15:21:44 -0700 (PDT)
Subject: [PATCH v2 3/4] fixup! accel/amdxdna: use
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
Date: Tue, 14 Jul 2026 15:21:42 -0700
Message-ID: <178406770278.1106335.17232929459598625570.stgit@skinsburskii>
In-Reply-To: <178406760622.1106335.2379450382728057793.stgit@skinsburskii>
References: <178406760622.1106335.2379450382728057793.stgit@skinsburskii>
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

aie2_populate_range() now uses hmm_range_fault_unlocked_timeout() to let
HMM own mmap_lock acquisition and retry handling while populating an
invalid user mapping. The timeout passed to that helper is a relative
HMM retry budget, not an absolute deadline.

Pass HMM_RANGE_DEFAULT_TIMEOUT directly to the HMM helper instead of
computing the remaining time from a local absolute deadline. The broader
command submission path still keeps its existing timeout around repeated
range population attempts, while each HMM fault attempt receives a fresh
retry budget for HMM's internal mmu-notifier retries.

Keep the existing driver-visible timeout errno by translating -EBUSY
from hmm_range_fault_unlocked_timeout() to -ETIME on return.

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


