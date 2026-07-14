Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22481C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69C4E10F1E7;
	Thu, 16 Jul 2026 08:18:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZhUaPRK5";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E4A110E58D
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 20:13:41 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-8487b7b4066so4657392b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784060021; x=1784664821; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SKEncuDEb35sxzE1YTlJf1hRIKo4X4QhyOOQXqSLrW4=;
 b=ZhUaPRK5qf0KPCH0IJyAZTKFh6459gGiUI7sUBRpK0PuYY7g9bBJNyC3B5paaiYxwk
 HMC8cYc8dMaGR09wcRG6lSyCcXj2IvxROb7SBzJn+uOFVywHjaiuGoMKTvPqxOAnqpJM
 82KWfol0va8rISfWS4fWSntgKhyf/CisNbNzCq3iizCYuiXSdNhqFK7C4i1X+sYAcwnA
 tV4BPuGuWAhtsurnoF6ZrvNcWUlP6uSNdHqi/Lex/Lanm9twxQFp4nBPJ0+0sulabwAq
 or+rbYVJZqULL4Owu1THLTfsf9PhrDGpnyMWHRAcFeetFct2npvxb6+gptkmzYx2GXbO
 WkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784060021; x=1784664821;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SKEncuDEb35sxzE1YTlJf1hRIKo4X4QhyOOQXqSLrW4=;
 b=Vunz+tNxlQZ86ITrqHVW+kDckLjqIFRX+gczTqcsSuJPW8E2Zg50j3hgBRn3R33cnH
 SBi69qGPn6tKbG45YqDQ3JIBU81+CjhkoRnFn+DdXXTnpQCnF/p6SxyUlEFo31utJohB
 MN+Q0tszT+oq8UceSDMVUK61cX12+v4aw++HaTZn2ZjliyTQ6Fllt6o0TWGNk+8QHy3f
 xQ80HtFwfBwHJm4UcubFo3I18a8G3H4kxLnEDVs8TyQT/4LJFWYU4cHcR8Njp/SQKx8Y
 CXT7O9Ib5gN03gNSOe7wx5ip8pFE9jjmyMjZGtrPHo8kz9fw25vMIxLqoYbA30/WE07V
 cvLA==
X-Gm-Message-State: AOJu0Yztd+chI5mkunaIHwcgYEx+NJqDQMbCesQv2u4JeDs0yZ9lK1/G
 A4pKVGp5v4kKfq3Xm7SdAK1GyF6Mqi+9lcvpnw8UOLG4LGkwC3Z3gjB9
X-Gm-Gg: AfdE7cm5l/Fx2NP4Wy12C35ddq/XgeLBT9F9WW7kS1U7OIq5H0FqtH4wOfbmKtqhH/P
 Lk0KSZQu4EXLqBOdgLogJCW6xnjnNcvDZuts5TaAIFztbeEFIv2AxpXCcm0ozk2Lb1hF1j/tuMr
 G3YsjmUtyAXUqEsvKxIbFEQm0c6OhsaZ+54LuR2WaehLjxoiXBEptH/ngxurtpH3c+8xzYVqFeJ
 xmjFJet7JoBy4bqEgESCrkcTVuXy6hvlexdGL4XNAQlCCbuR8G4hmTf0C00ZWBH8/HWNyrD2Ez4
 QiYsSvLtnDBR49SzpquKY0DmxoemkzlotDFW0OXBMeYD1jePNtIS7xTH+Ey+Crxiqibk2ZmGxxM
 Jhoq5sJ4hPPGHWN+QRV3PfUGkUuNG5mUzgPgaLSMT7FNnTGfJYUC4ovpETSsuhlZ1Fu8OuCC0qP
 odRQbsgzBVSxwj0imMpur5af0DMkhRQ5ub1hmm9pbnlQL1UtUiRNDzLPrbfjI=
X-Received: by 2002:a05:6a00:2e16:b0:846:f502:4cd4 with SMTP id
 d2e1a72fcca58-84a671da73cmr45857b3a.4.1784060020856; 
 Tue, 14 Jul 2026 13:13:40 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84a4f81d770sm1966491b3a.61.2026.07.14.13.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 13:13:39 -0700 (PDT)
Subject: [PATCH 2/4] fixup! drm/nouveau: use
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
Date: Tue, 14 Jul 2026 13:13:38 -0700
Message-ID: <178406001808.1082778.17299764648397654220.stgit@skinsburskii>
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
 drivers/gpu/drm/nouveau/nouveau_svm.c |   30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 4cfb6eb7c771..b1415c2e49fc 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -655,8 +655,7 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
 			       unsigned long hmm_flags,
 			       struct svm_notifier *notifier)
 {
-	unsigned long timeout =
-		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+	unsigned long timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
 	/* Have HMM fault pages within the fault window to the GPU. */
 	unsigned long hmm_pfns[1];
 	struct hmm_range range = {
@@ -677,25 +676,16 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
 	range.start = notifier->notifier.interval_tree.start;
 	range.end = notifier->notifier.interval_tree.last + 1;
 
-	while (true) {
-		if (time_after(jiffies, timeout)) {
-			ret = -EBUSY;
-			goto out;
-		}
-
-		ret = hmm_range_fault_unlocked_timeout(&range,
-						       max(timeout - jiffies,
-							   1L));
-		if (ret)
-			goto out;
+again:
+	ret = hmm_range_fault_unlocked_timeout(&range, timeout);
+	if (ret)
+		goto out;
 
-		mutex_lock(&svmm->mutex);
-		if (mmu_interval_read_retry(range.notifier,
-					    range.notifier_seq)) {
-			mutex_unlock(&svmm->mutex);
-			continue;
-		}
-		break;
+	mutex_lock(&svmm->mutex);
+	if (mmu_interval_read_retry(range.notifier,
+				    range.notifier_seq)) {
+		mutex_unlock(&svmm->mutex);
+		goto again;
 	}
 
 	nouveau_hmm_convert_pfn(drm, &range, args);


