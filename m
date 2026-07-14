Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E628CC44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E089410F1EC;
	Thu, 16 Jul 2026 08:18:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q/DK8wL2";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E60010E0F5
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 22:21:38 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-8453427d3f4so4251138b3a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 15:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784067697; x=1784672497; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=s/XP8nJGTiSx4jpNVu3XVkKeZD1kh7QswKhz9rXqGp8=;
 b=Q/DK8wL2mr7Tsbp8UGSA/7t4vh1g9Sm6kw2UE6/AAPVQ+RkPPpTFA5YlDPxOPVL6EW
 2YJbqVHpLWuD7XVBNc+89GkI3Zkay7E0fICHcKa43onulGNv4B1wV08WB/n8x0lACRYI
 wEaJ9Zl45/IDlNsH9Lm6oEbiVi5QU0C6hhMiI/Mj/3Xe9qE9BTZ/a4H08xI17A2pSLzy
 jXgNjUNSiUMc55lXNsCC1eFnkM30ODEJeKTvHzK0sVY+hpxe3mWzL5OmB/G0EI+Lg86I
 v9MBdSkhJg8BkvfkF5TckqfJiGAN3Sg3jPNBh19nlTk89xaTtu76jZ4nMxBJ86J5GUQl
 3V+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784067697; x=1784672497;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s/XP8nJGTiSx4jpNVu3XVkKeZD1kh7QswKhz9rXqGp8=;
 b=oXgeo4oASHqSlMVtRk+jIKZ8KnE1Y0LvK53fPQbMvbF4bgIlyyr6iNVTu33HL7CPuz
 C92Q67auBa0DfgcdmvAQq7TJOwWudbv4LRZrE7JaPHtZnEz+yaZ1W/jKRtaHmzUBF9AD
 8+7zelc+/HfnD6uAEL4vr2zmcJuOrg7L1t5w5f7qm05Ny3b8mLe2vZRhDd7oSXXuE+ao
 y1e4SqRbgLdfLqexSsQRGr58Ra/2qjJjCw/Tm6+8utFsDXowRRaXCuWdiQAXv9QGTTAa
 4RidtMNLwlG++Ujs8c4ZUs6P+YgheB34zeZ5ANBTtJKWJj9b2B2GqMEf073sdt7qP8Nq
 02RQ==
X-Gm-Message-State: AOJu0YyI+hUF3z7vqVrej1A5duD7J4dSdcXsT6yamDI+zKGDzJn7hNBE
 CqnrCrgpB1KYPgUxgKLkR9YNSGfMedJpTVlPxBEWHRyNzkE2qw2HlJdx
X-Gm-Gg: AfdE7ckw9kCZKg89FBybcE8vVHGVEFPmCKJhYlQLd3y/JuVLNQkJBQ3RYmBewCfVJ1f
 zp3WaKNvOh//9P50Iq3TKa0q+qMOd+10nwJmc8oWCe2r9A/FVsvBITqIgZ4owSBeRfvH5VAAV94
 u0Pio6fUfsPeIqGEm1XLvlbpu6l+pEfTpCOTWhbBIcJwS7hDSZJwMXbzJFv/CyYxarUSms5pHP3
 CVupjXdiZmvSYdtO23/KYie8zvsrOmSfy7Y+OaOA8o/UQSTz0B2Xg/SKAJbV9WftOv4eN6+0+Mo
 fUK+iW5IG4HhMxMODSVZ50pmWHQQeN361DEIimG7edKRA6MkxpKkozm0ylghpujqE16HgBXgZSZ
 431zNoljOuTBuFYU6pg8f9A0KuC7f1zdtd9IgyNt8lLap+DL3ElrIeL8FjvlyqiFXKmWRYWWgEU
 RDahVmZaE2Dh/o0rK0NsAcPXoN6W43q1Xkii9XbxXJnl+jpf5JUKXPynXBIZA+1YsqNc+B1g==
X-Received: by 2002:a05:6a00:4b13:b0:847:8dec:141f with SMTP id
 d2e1a72fcca58-84a672ea3bfmr293017b3a.51.1784067697563; 
 Tue, 14 Jul 2026 15:21:37 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84a4f238f75sm2119769b3a.9.2026.07.14.15.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 15:21:37 -0700 (PDT)
Subject: [PATCH v2 2/4] fixup! drm/nouveau: use
 hmm_range_fault_unlocked_timeout() for SVM faults
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
Date: Tue, 14 Jul 2026 15:21:35 -0700
Message-ID: <178406769581.1106335.2090301352195900623.stgit@skinsburskii>
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

nouveau_range_fault() now uses hmm_range_fault_unlocked_timeout() for
the HMM fault path. Pass the remaining SVM fault timeout into HMM as a
positive relative timeout instead of open-coding the HMM retry loop in
nouveau.

Keep the outer absolute timeout around nouveau's
mmu_interval_read_retry() loop. HMM's timeout only bounds retries while
HMM is walking and faulting the range. Once HMM returns successfully, a
continuous stream of mmu-notifier invalidations can still make
mmu_interval_read_retry() restart the operation. This path runs from the
GPU fault worker, so fatal signals for the faulting userspace task cannot
be relied on to break that outer loop.

Use time_after_eq() before the HMM call so the remaining timeout passed
to HMM is always positive. This preserves the old timeout behavior at the
expiry boundary and avoids passing 0, which means retry indefinitely, to
hmm_range_fault_unlocked_timeout().

Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 4cfb6eb7c771..58735446d783 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -678,14 +678,20 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
 	range.end = notifier->notifier.interval_tree.last + 1;
 
 	while (true) {
-		if (time_after(jiffies, timeout)) {
+		long remaining = timeout - jiffies;
+
+		/*
+		 * The HMM timeout only bounds retries while HMM is walking and
+		 * faulting the range. This fault is handled by a kernel worker,
+		 * so fatal signals from the faulting process cannot stop an
+		 * endless stream of invalidations here.
+		 */
+		if (time_after_eq(jiffies, timeout)) {
 			ret = -EBUSY;
 			goto out;
 		}
 
-		ret = hmm_range_fault_unlocked_timeout(&range,
-						       max(timeout - jiffies,
-							   1L));
+		ret = hmm_range_fault_unlocked_timeout(&range, remaining);
 		if (ret)
 			goto out;
 


