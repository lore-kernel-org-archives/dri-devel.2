Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B29C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E86A10F3F5;
	Thu,  9 Jul 2026 07:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S+XbBzwy";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF97310EEEE
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 19:47:39 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2cce6a0c9c3so417055ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 12:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783453659; x=1784058459; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+Fuhl2eREcU7wQkONDn3KjcEE0Ws3TgFkFsQfjplBps=;
 b=S+XbBzwy1chi/Hvryk2HkcO/SE67y/mFdRSTOXF2C5+dQqZ5X/pEi6jyANxRapbjWz
 qlRtMM+AFNKs/5n6oWk2y6UIo79vhcVDsDrd8aG9DzzUJroa+RUOS6X1eayiCpqkYNUa
 EsRNBLO6FFWlyLr46jfiHVMSlicVFPWgL2VQvZu+cKSl24ml/vwdHAD2Opp3C+yBirXG
 KUD6yLZwyRdrH24bSgRnhjRIGs5t3DpMPAr515KzK0NkMddZLXtxp9yrPyzio8Z7Ck8R
 sf2Z+ydF4ccgqbX0m6PduYTDUUn7mlysWM7K+QGdpavG+H1xK6ZawqYa9LNanGgeOT3+
 o9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783453659; x=1784058459;
 h=content-transfer-encoding:mime-version:user-agent:references
 :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+Fuhl2eREcU7wQkONDn3KjcEE0Ws3TgFkFsQfjplBps=;
 b=AZKeSqbeCnvyfQQoYQFt2jAMZFVOIFn0jj3YK5Fp/FEBphj8k3rQCPakrnQgaXClUJ
 ZpdgOVgOAWrz+8FQ2FKF5nK+c7h2UJUdn/R1q1zgdZwGJ2HTTLtv3vv6Nxl4nb5jegF0
 m+1jSsFKsIAeLFkKC42g2aABuQFs8S8OmzOYs8ich+myjp3G+nBz8a+2AGACCHqpEPkU
 QvoiXxIvhB5pD86FlI11LZn3EAyU74rZqw7jVG1qj81i9KTZtHedRGSsZRoF6JJYW9aT
 OPIAGmbjBbuux06ME5ONlrDUqYpjDQLq1/LPxpAK+2/O26iZfdYPf278bwrIdDzyazif
 KKEg==
X-Gm-Message-State: AOJu0Yxlkke9t4P/v+W3UvBN1M9KhGV+S6lX9C1yEkAnmcDHatGfhGtX
 RLYXkKIvix00usMRLsDUpkeDe51HzXU1EhUJxPcMeIatUbjcDSonSywX
X-Gm-Gg: AfdE7cne2ViMm4XhzFHInPFcsi6eAHSKAkekTOvBU90feMohx7nUDJfb8QrNtPg+EJG
 wjYKN5h7MUyAD6UtR133r9x+K10UOgSW7XVkvpgl3tWfGN3i/jAyx1jbj8C4rOReH4Hi4MCT1jL
 MTf6PAFVZFbflzCX18lxwcFyCf3uTCDpWP30HG61EZI6Zppc8dLke20992gxFmBMpyWUf7Z66o4
 ZXAutEVIAq9dEi/8xcoJwCuV11WXXq/sjLpwIofGpaLGs9mMw6MvSlKENhFR8GQJLdFst8nt1JM
 ueHpnDUEO7dvroZtofv08Zy5FV3jKNmRh1jweI/e+ph85WH2RQUtD5XGCmXBmjqXPm5qU6FFawp
 tF1hXy9+QTfL4PmAjBRxsJ+4GOo7c+B3EOx1MP/yjMUYvwblBIhqsmgUVJec5Fxlyi9wecYsWzS
 DtrGoke0LmJHTGAdctsPOCab70f7PeDwMzx13NIgMhvRwSAzRoOa546bNXHro=
X-Received: by 2002:a17:902:f68f:b0:2c0:e5ee:f554 with SMTP id
 d9443c01a7336-2ccbe40ee4cmr72069895ad.8.1783453658644; 
 Tue, 07 Jul 2026 12:47:38 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d1ea7fsm17015165ad.38.2026.07.07.12.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 12:47:38 -0700 (PDT)
Subject: [PATCH v7 7/8] accel/amdxdna: Use hmm_range_fault_unlocked_timeout()
 for range population
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
 corbet@lwn.net, dakr@kernel.org, david@kernel.org, decui@microsoft.com,
 haiyangz@microsoft.com, jgg@ziepe.ca, kees@kernel.org, kys@microsoft.com,
 leon@kernel.org, liam@infradead.org, lizhi.hou@amd.com, ljs@kernel.org,
 longli@microsoft.com, lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, skinsburskii@gmail.com, surenb@google.com,
 tzimmermann@suse.de, vbabka@kernel.org, wei.liu@kernel.org,
 skinsburskii@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Date: Tue, 07 Jul 2026 12:47:36 -0700
Message-ID: <178345365679.660027.16671418103486907555.stgit@skinsburskii>
In-Reply-To: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

aie2_populate_range() takes mmap_read_lock() only around hmm_range_fault().
It keeps a single HMM_RANGE_DEFAULT_TIMEOUT deadline for the populate pass
and retries -EBUSY until that deadline expires.

Use hmm_range_fault_unlocked_timeout() instead. The HMM helper now owns
the mmap lock and refreshes mapp->range.notifier_seq for its internal
retries. Pass the remaining jiffies from the existing deadline to HMM,
while preserving the driver's existing outer loop for interval invalidation
retries and for selecting the next invalid mapping.

Keep returning -ETIME when the retry budget expires, matching the driver's
existing timeout error convention.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 drivers/accel/amdxdna/aie2_ctx.c |   17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index e9fbd8c14364..412f812d7c2c 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -1031,22 +1031,11 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 		return -EFAULT;
 	}
 
-	mapp->range.notifier_seq = mmu_interval_read_begin(&mapp->notifier);
-	mmap_read_lock(mm);
-	ret = hmm_range_fault(&mapp->range);
-	mmap_read_unlock(mm);
+	ret = hmm_range_fault_unlocked_timeout(&mapp->range,
+			max_t(long, timeout - jiffies, 1));
 	if (ret) {
-		if (time_after(jiffies, timeout)) {
+		if (ret == -EBUSY)
 			ret = -ETIME;
-			goto put_mm;
-		}
-
-		if (ret == -EBUSY) {
-			amdxdna_umap_put(mapp);
-			mmput(mm);
-			goto again;
-		}
-
 		goto put_mm;
 	}
 


