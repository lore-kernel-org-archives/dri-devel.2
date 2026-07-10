Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E554C44506
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89FC310E7D9;
	Mon, 13 Jul 2026 07:10:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LB00bvgt";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A242A10E494
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 21:27:15 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-8478fe07f0fso1478809b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 14:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783718835; x=1784323635; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SsZ1Rl/n/xZapvBLsULQnfYoRJnC5F850v9mJm5328I=;
 b=LB00bvgttTI29BSFvJxkKHWxTgwiu9llCFgDnPe/usTt2ghuy0rFA1LlJzTStos4zf
 4BPbI62aN2u8jPrz70NGprLzKtY2OAeXwCq7tqT6Sl1aItSJueiiHqZmBhaI68zqgNf5
 EqtWlY2WvFE4vNU6XTFrZc+IIrd4tA/OqEoFuU2IpagRioH56e1vCDgOTh+GTN42/bcp
 Dc/F1awNTDE79TzVbn7N3CBVIOxLjNO8Bc6DudofDEuajNlwA5HSXeIDFB/KJovssjpK
 DGkBqr/ePkmVCPamyNcoibZfBUM3QwKScKKJw8funHBskeJzftLzykSp+/rMNjHGzCIJ
 FZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783718835; x=1784323635;
 h=content-transfer-encoding:content-type:mime-version:user-agent
 :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SsZ1Rl/n/xZapvBLsULQnfYoRJnC5F850v9mJm5328I=;
 b=fMDGEmIo1K7RKEESnzMpWyF7+xeeA2vGqVWwr0p3Kj2CsuxcHLlCMWbNSgvRY66P30
 kDseMvdVp9SW200aro/dR962cJZ9TAisRu9pUeA5cXrv0H5IKQxYQjxVYTVbzKbI6DdD
 OOyLR/XVaBIj73QQk95xaLMNqlMuQoyE221GVHJW4XvESjdLLLccLqexY0wYF/jtk00j
 QhqNNIDOBVdCc8Tsvz7WVJBfE9id1oGRE5gx4z0Ac2/2bx4KBXjdk2sDNC/izEd4J/Nu
 cAdMZ8fH6v/6POTZviRmN2QaioO6BWfLR1JvhphgAOY/HNFxSbY2AmPAev41dMs4VFGk
 b5Hg==
X-Gm-Message-State: AOJu0YzyOGjeLCKgUzIT4MKWVaHz9YO6OAS0nlmIo/9tdDUGKeA1vLO2
 UmBXwdHLGn8eBAHD0BxA6KEOeHFrX6jRhPURER2+MMEt0Y9MMY+omNYl
X-Gm-Gg: AfdE7cn3w8MGdz1shluMdGAslG0je2wC59piFeWa7UouvTtMKPIn3iXMjuXftgrGRRH
 0LkIkDx2Ga94tdCYYkLf/3mj7VIo8dlGnY0uZu5XB5oHmj1U5emayn2jrirjnbDs/2Oo6EAHYnq
 MObqZgRaBwv7OwoS2Yc1lpi5Yz5WBOIDVxpqslso03CskyK4X3d13e88yRlkc3/4x2LsdP6XIVX
 6NLrc0bsCvwlpbgEZp0A3ihAWGhDEW4QIJT4LFOFGfs2VOPNcHJMcdZW+v51Mld+R3dLp6jvCrP
 BwLC0jcEQdWCF60j/urxd43YWCiaLFio4+8vYidCYorSG0+Ul8/emN1dKoJ8WkX/t1+ymO/6IlM
 nH20eeenIcobhroRQxTdU+hGoGf5bAIS38LmwjztgbkEXV7n4DGhRjXcgl7ZKSt3SwK30siosng
 VUs1Ea5AU15sAHkEyhFS3ep++/oZBrQk+UhT5cerLfW5ecQC0Q+J0W00BjcRnma8VcaXJlZA==
X-Received: by 2002:a05:6a00:3397:b0:848:2f84:737 with SMTP id
 d2e1a72fcca58-8488990b261mr583131b3a.74.1783718835015; 
 Fri, 10 Jul 2026 14:27:15 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84870d76ce7sm1801076b3a.55.2026.07.10.14.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:27:14 -0700 (PDT)
Subject: [PATCH v8 7/8] accel/amdxdna: Use hmm_range_fault_unlocked_timeout()
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
Date: Fri, 10 Jul 2026 14:27:12 -0700
Message-ID: <178371883276.900500.12789147320642521200.stgit@skinsburskii>
In-Reply-To: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:10:39 +0000
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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/accel/amdxdna/aie2_ctx.c |   17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 54486960cbf5..a16b8d7deaea 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -1061,22 +1061,11 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
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
 


