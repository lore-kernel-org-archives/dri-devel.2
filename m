Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B79C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 21:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5D5210E4DE;
	Wed, 22 Jul 2026 21:45:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KmzDszZN";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3BD010EECA
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 21:44:55 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-8487214ad2bso12675928b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 14:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784756695; x=1785361495; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WVIK4CTS2ebWqFuX16f+6TzH9lK4l3CZHr+WHLsMqrs=;
 b=KmzDszZNxzpzdxLE7K0gm71K8vtZ79VDkbw2FKhV09Y6zsHW9KTF1GhF/crpYzCi7o
 DvixbWlHrZzHbRcHJnq1dEXgmikSl7+AU2MdHbwkcObpyfM2YVOH6ZnN8teeT0Ccvx1T
 mmS/S7FkD1wZDWEzbeVjs2TAbXM8p42WOd31Ql1b26/xiC9LZO15SbC7IYB7qjbUKyqt
 d7uY6ui0XW3tNrggkVF19DDqyYrVvLzlWighUE2iga6IdNfRvS6wUewBuQyvzEHdNkaO
 uAO7G6jH4ZCjGovxpdyNtGoLi8Q+JqLQvl7sc88uoqnUtTBI1d6bD3f6dsKPawmCpywH
 U01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784756695; x=1785361495;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WVIK4CTS2ebWqFuX16f+6TzH9lK4l3CZHr+WHLsMqrs=;
 b=EV+1FVSODFNcEWB/iRX2haqTEpNU/qsmszVAPRMDb9fU7REbBtUKAZiyC3zsacT1O4
 DP/iC58pAOGw9cNUdqNAJokz6a5XG86xAicLLzMl9duW178flLWPNDmimTyMsD1x3fNa
 KNuSJJvX9/o1IYBFKbcBg2LXCxYidswsDmyYrbkknrLyLrKMTzAdbTZCR8Y2zEAXFg1t
 zzouLLBUM+RF37DOznwl6x/ekpmhy5cmXpXY9EG3G7ESCn8NnZ5sreEMx31ZrcdJh0k2
 QnBp4ymK46TlJXCo4bnmQ9YIyMYeeuXYto41r1DSX2F6+l383BaWTX82sevY/8gSw/b4
 ohWA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5Jn7NKfNQlcjVW7maMaqYEL2E7QGKihTGFYUzn+g0OzYwm9wk4oejeaT7q21i2gjMAFllq2Qr0Gw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyvlsVgI7cQ1KYxtUdjuaB48rVFJfqhoh6kuOZEpn+7rz6ILuzX
 sUfmlAfpGRFsxn/BS4z7HXOYitXC8xlcyjPseEAmc8dl7iqmHfPotMBb
X-Gm-Gg: AR+sD12E39akyh4oSnpzp2l/DXjHiZAbo82OqQ3k5bOhgY8HwmvvkKhFemICDAuPxCA
 UtHfu9wMB1+evjiXOe8OrUWPMWYvw/3+idI0KUkH14PFH6TKD5yiGEAsYp+gF2svoA/xj5Iv02I
 xc3jy/vUDMG8A1TY2ezOLx25xPeAscY+2CbGoekZ1B4eqT6PqmpQA8di9dW95Nww2c4k1uTaA7+
 2S9J1DDAnsaGyHHZRFrJRp1eappdyPgyAsMATVLo1q4AF/0GFRPbXouGsL2Te+Dg2gcxtQ+wCN/
 H3x3H/rII9p9Ynoh7qjHtTfuHI5402iREEY2UkyyxCSO1o/GoQRgW1bjnznn7QogARj2ofyT9tA
 rJsyuKb1/qbWkbnG9VwYnC7G9qYyXlLtLU1McHatPIWthXYIA0i+V6/5z6XwIbQJAr+i/Fcg05x
 VTuCoPvXDrocja4F2f/Ut9gJwY/mg97g2raGlGPJ9tt3KpwgjI
X-Received: by 2002:a05:6a00:852:b0:848:46ea:bbe7 with SMTP id
 d2e1a72fcca58-84e2bc6b5d6mr673956b3a.19.1784756695183; 
 Wed, 22 Jul 2026 14:44:55 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e17237c3fsm1946297b3a.9.2026.07.22.14.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 14:44:54 -0700 (PDT)
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
Date: Wed, 22 Jul 2026 14:44:27 -0700
Subject: [PATCH v10 5/8] drm/nouveau: Use
 hmm_range_fault_unlocked_timeout() for SVM faults
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-hmm-v10-v1-5-606464dd601a@gmail.com>
References: <20260722-hmm-v10-v1-0-606464dd601a@gmail.com>
In-Reply-To: <20260722-hmm-v10-v1-0-606464dd601a@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, 
 Oded Gabbay <ogabbay@kernel.org>, skinsburskii@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
 Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784756683; l=2163;
 i=skinsburskii@gmail.com; s=20260722; h=from:subject:message-id;
 bh=KaVy0LDD2WZ56zIlG4jDVljfxrz2j27JL0AnOSACkpk=;
 b=uKgRFxKY7gMhEFoK0hHnwQl6N8UsouNcazo70jIAxend3BGPO0koGFjjGoE03g3KTWZd66DI6
 5tAsc5/qbDAAjPQ/pjqrtB3km5I7U9rctkdARaqcdzu58Lj+SzHd5bT
X-Developer-Key: i=skinsburskii@gmail.com; a=ed25519;
 pk=bDpriHBYgeTdkIDweZDCemxsU93neJBOCn3YLIuJpnE=
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

nouveau_range_fault() takes mmap_read_lock() only to call
hmm_range_fault(). It also keeps a single HMM_RANGE_DEFAULT_TIMEOUT
deadline across both HMM -EBUSY retries and post-fault
mmu_interval_read_retry() retries.

Use hmm_range_fault_unlocked_timeout() instead. The HMM helper now owns
the mmap lock and refreshes range->notifier_seq for its internal retries.
Nouveau keeps its existing absolute deadline in the outer loop and passes
the remaining jiffies to the helper for each fault attempt, so retries
caused by mmu_interval_read_retry() do not reset the overall retry budget.

Nouveau still validates the interval notifier sequence while holding
svmm->mutex before programming the GPU mapping.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index dcc92131488e..58735446d783 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -678,20 +678,22 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
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
 
-		range.notifier_seq = mmu_interval_read_begin(range.notifier);
-		mmap_read_lock(mm);
-		ret = hmm_range_fault(&range);
-		mmap_read_unlock(mm);
-		if (ret) {
-			if (ret == -EBUSY)
-				continue;
+		ret = hmm_range_fault_unlocked_timeout(&range, remaining);
+		if (ret)
 			goto out;
-		}
 
 		mutex_lock(&svmm->mutex);
 		if (mmu_interval_read_retry(range.notifier,

-- 
2.43.0

