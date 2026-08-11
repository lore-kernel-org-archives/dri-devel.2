Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69AEC5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD9F888F94;
	Tue, 11 Aug 2026 20:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="CbGp+fup";
	dkim-atps=neutral
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72B9388F94
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 20:41:28 +0000 (UTC)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb6cf425e86so232696a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 13:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786480888; x=1787085688;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HJ+kHjelH5pg9wQKl1OmAN9lbWOp3U72jOs17+JTkO0=;
 b=CbGp+fup4d1fF/lB1RCmlz6IvK1MonDQsbNHGdfe+sinVJ5AkmX/24YqhUt1f063X7
 itltwOxcCg72XvQhW8U9VcOok3O5Aic7rVR33QNebA6XwWBhW1rBK++8p0PYce1FYCDI
 oYBJy1UNlYaioG1bqmVNGYuN/CkYQLUVn+rRtMXhYeliTXbMfdImIy724aWen6GBgRVN
 68GRtobpe4zJ0JfKPA8JUd/vgFtijRfXSWH3oAMcxJcZmz/wQN4TymX2iebhF5ImIb8O
 VzfD97vQNGoi4iEaEnWyM3dOkN5+LpClPRY/qWccB7XtpitqeO0j61+0aKkHl4JaQiQY
 3rVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786480888; x=1787085688;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HJ+kHjelH5pg9wQKl1OmAN9lbWOp3U72jOs17+JTkO0=;
 b=j1Fe2pDDuM6+d/EtYoYzxtQgr46jifqfrCevu0loZES5Taqjyak8q7yEr3nKAqDUze
 1ElD+VR9F5CYiZC2hrlIJV2ED4whkxuM9ipgokjHUDfQnm1Dugv0srN6kIkIy94T+ExG
 USfUoGQ9VHxWQ5BipmWAkouBjqOyNcv4x/KdAO+T2bUF8BTCoFA9RKRdko2pQtkotkvK
 bCt/8WOpglFxsqfzB6Jp23zvu1BAbW9B8X4QV8FcBP9Z7Pwj+S4DE43qsOVS6WITe7tE
 P9P5LPNj7n3nY0TgeaQ7I97vt/SH/MqZ/EFpVmkGdNMS77PtcZGCeTgIPxrIomx4G4FZ
 EKjg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpjFAdmB0Ot27vX9HqAWQnsKv6LmwCdJnEuSZU/65eN/mFR0x5eAGbSqcWORR70CV+x8QbcEk+YvOk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7gDpRhvJq4Axk+nax6nC8vRlcJdjvqfGi8WDae0Wv1/FUYZx+
 e4ME/5hjyopukW4FWEvs3J5gP95oX/Ci0pFL2bw6YP17a105B20Jd32Wv93JeL6noSH4g/BJYgX
 FygQsM5brLGxtoQUDLg==
X-Received: from pgvq11.prod.google.com ([2002:a65:624b:0:b0:c9b:f0c9:631a])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:bea6:b0:3c1:b9c:4890 with SMTP id
 adf61e73a8af0-3cc2ba60c41mr7899605637.22.1786480887687; 
 Tue, 11 Aug 2026 13:41:27 -0700 (PDT)
Date: Tue, 11 Aug 2026 13:41:23 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260811204123.3198370-1-tjmercier@google.com>
Subject: [PATCH] kselftests: dmabuf-heaps: Open heap device files O_RDONLY
From: "T.J. Mercier" <tjmercier@google.com>
To: sumit.semwal@linaro.org, benjamin.gaignard@collabora.com, 
 Brian.Starkey@arm.com, jstultz@google.com, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: christian.koenig@amd.com, shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "T.J. Mercier" <tjmercier@google.com>
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

Write permissions on the /dev/dma_heap/* device files are not required
to issue ioctls and allocate dmabufs. Applications should be opening
these file as O_RDONLY. The BPF dmabuf_iter selftest already does
this. [1]

Users are pointing to these selftests as examples of how use dmabuf,
and encountering permission errors on systems where write permissions
are not available on /dev/dma_heap/*. Apply the principle of least
privilege to selftests which open dmabuf heaps by removing the write
access mode and using O_RDONLY for the open() instead.

The same is true for the vgem test using /dev/dri/card.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c?h=v7.1#n49

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index fc9694fc4e89..45b420e37c97 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -48,7 +48,7 @@ static int open_vgem(void)
 
 		snprintf(name, 80, "%s%u", drmstr, i);
 
-		fd = open(name, O_RDWR);
+		fd = open(name, O_RDONLY);
 		if (fd < 0)
 			continue;
 
@@ -96,7 +96,7 @@ static int dmabuf_heap_open(char *name)
 	if (ret < 0)
 		ksft_exit_fail_msg("snprintf failed! %d\n", ret);
 
-	fd = open(buf, O_RDWR);
+	fd = open(buf, O_RDONLY);
 	if (fd < 0)
 		ksft_exit_fail_msg("open %s failed: %s\n", buf, strerror(errno));
 

base-commit: 9a11db68872055e6ead919bad04d6330851c522d
-- 
2.55.0.679.g6767b8d81c-goog

