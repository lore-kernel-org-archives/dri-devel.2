Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18E1606A32D
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NfXyR5bf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7149810F025;
	Sat, 14 Nov 2026 16:25:06 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6462910E16F
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 08:19:14 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-35159e0092aso200152eec.2
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 00:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794644354; x=1795249154; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pyx07GG+cQ7r4tHVzwwWnT6ylPidCzpSMdub9ploOvw=;
 b=NfXyR5bfRXt8mIgAziNNkWRTg3VdzoQpAoI7Q4eO3F+DbZWD8UA1b/foJqKr+Q7RNO
 BUf82bPOJMz1HPDWwCOsl7ra2YDhJi4jz50xv2RaK5V+ATEskhcsU2I0ImLgsPBHI7Xm
 WRRgVpxDxM8fpACypx+5Sx8JueU54OZl9uusVap3rhQvhCg60dBL3/SAUoUERmeGU1Dn
 vz8hNaQqPjeQJZ4zw+HkeSaRcdsueHi4VweIfRj6MZ6pe08MKm3tYy15JupDlDwsrUUj
 1DTIa4S/j+DxGSbXpFxbmjIGqR6uOimSKsyELRxCN2UivFB9qO55S+x9k465kxpDV0T+
 egqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794644354; x=1795249154;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pyx07GG+cQ7r4tHVzwwWnT6ylPidCzpSMdub9ploOvw=;
 b=Oko6w+MZrvA2X13kHmDgXWyrZPMJQK/GCnoptQnH1Q33eHTkYq/SR+uUtHy6vr7FYW
 y65QR+ePnQtodnIiU0EbRVtF+CjkY2tpLBnijlXhhDQ001N5X+wxGzZMqsYHEP6LgkbR
 GzUC2t7yqqqmG3yF7qzUDug84m5111AEMnUqoqrrVadJrxVh1UWZ+ydHeMtCAAWXHzmj
 H1mK2fkhuRdKb0Jp4EEJgVhq5wS2mDHtnA5olO5n46ncyzm69d14yTDt4FtAwXm6f+Zv
 x0ClpqDt0ta0cvID4ENHYoROh7EeyG6ng5WtbCXcv37XugJrRtb7kX0H8j0M94RR2dx/
 Sl5Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHKFXeSxwB5Z9OolauWcM2GIz2uVXnoXadAoD6lm7NIX6w5XV6AVCA8V9yvv9c3cfj513gKN3iyuHo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/qo1JT24abTcNtzqbXCsZsG7rpjeieNJ6P/i7r1U03jrthi30l
 laeRbDxAg2B82Em1eCPdj9bkB6EMnnM4GqtTrJJv7ffI3DNgSH5NxY54
X-Gm-Gg: AYBFou0BJ+0D6nn5PLMCaE98GsVw/C9A5WhcggUSu0JmtpcCkZ8T1UxFdLsKa34Ehwq
 UC6hHmpBuVltF45KLbMtnGI4B9iHxaoSVJxYezSTW4uVeOGsZNFfjO9tP2AU9rwG5+8UUjfyP+J
 oqCvLuYa0EiABrlzh9wW4VqoKgIGcBWuw9mU0HTidFzlVMdAnQzdwyIVx0N8oBBVuHT5YHE76/j
 wHxn/jOOVWH5M8eRIshz6vB0XBjb/unRrR3ldbycX4IHi9Sp39a3A7XK8XBjakElOJ/rJIehE+v
 ZnQzfuRo7jTHxO/B/qDSNQFmUpIyq11eygKAXl/Ug/rYrg3kbXAib7avOMwCLdadW2zs8D/koFl
 iEEK+7rhIsMIferMp9xwdhPi25f2ETGeDgzWGcBNt4TS9H0y5PbGsdrzy3ouaK1ihUD8ZCnBFr6
 IK+YeQxRqxaYc8kpZup5NHTx+5vXb4IoxN4mteGhstz0sj8FRH8AZaicRBYomVIGSmvP/wc2y7v
 EJx24TnDLomp6BxaBN9x4OtJPWM8e7xq9h+qg4GtVyjaBsHeCooC3hhpxqyqi8qXsfEc5M6iIth
 lMHthwI7y+f+RBHGkjR8uKV7mteev9wlGzNu4k1rUC6yomthAgJwM3+h9D5j5CwzJnXqwAFSl9B
 qp6F4rVTz/4UjYMZ//h2b9w+5
X-Received: by 2002:a05:693c:83cf:20b0:376:6ba5:6090 with SMTP id
 5a478bee46e88-37964e03109mr8926328eec.1.1794644353569; 
 Sat, 14 Nov 2026 00:19:13 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3795378d7e5sm14008333eec.3.2026.11.14.00.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 00:19:13 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH v2 0/3] drm/msm: Fix VM_BIND job, queue and entity lifetimes
Date: Sat, 14 Nov 2026 17:18:59 +0900
Message-ID: <20261114081902.1669-1-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These fix what happens to VM_BIND jobs, queues and entities when the
file or a VM_BIND queue is closed while jobs are still pending.

Patch 1 makes a VM_BIND job that is freed without having run apply its
queued unmaps before it drops the references that keep the unmapped
pages alive, release its BO pins, and mark the VM unusable, as the VM
no longer matches its pgtables. Patch 2 destroys the VM_BIND entity
when its queue is closed, instead of on the final put, which can come
after the VM's scheduler has been torn down. Patch 3 puts the queue
last in msm_vma_job_free(), as the queue may hold the last reference to
the VM.

Changes in v2:
- New patch 1, for an issue that Sashiko reported on v1 patch 1, which
  that patch makes easier to hit.
- Patch 2: changelog refers to patch 1.

v1: https://lore.kernel.org/r/20261114062541.2001-1-arpe1618@gmail.com

Jiwoo Kim (3):
  drm/msm: Release the pins and ops of a VM_BIND job that never ran
  drm/msm: Destroy the VM_BIND entity when its queue is closed
  drm/msm: Put the VM_BIND queue last in msm_vma_job_free()

 drivers/gpu/drm/msm/msm_gem_vma.c     | 77 +++++++++++++++++++++------
 drivers/gpu/drm/msm/msm_gpu.h         |  6 +++
 drivers/gpu/drm/msm/msm_submitqueue.c | 50 ++++++++++++-----
 3 files changed, 102 insertions(+), 31 deletions(-)


base-commit: 1e59855738454b14021b64115f0090eafc7526ae
-- 
2.43.0

