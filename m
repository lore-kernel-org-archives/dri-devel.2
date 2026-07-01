Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403DBC43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:51:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DD6810F1DA;
	Thu,  2 Jul 2026 07:51:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sunLYG/R";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EC9F10E3D0
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 17:22:10 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-37f7a5a217fso628028a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 10:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782926530; x=1783531330; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TC5t8A+otm8CUKIo7NwZaGoLcg2i72FScsypM7KbePU=;
 b=sunLYG/RQpgw7KB18nFLSftmQ2JkXIBFg/wAKMjqYIWx3G0Z+Ne0B5gWrq4O2QHr9V
 BjK38CELux9V3+SXYlajuAUx+oqLVazrZPZOtq91D4IlTfcD91vjdylOJGK/fGMFENML
 0Lr+BwKyW2SFOjrcZB28vDRMH70CMyyw8I7hUGHDYPPk3IquYY/+Nln+O3aSoyzkbxaV
 e4lWDwR4JOhImTL5rHrS5s3Zg1YR8yKS2YSL+vjXh7BjRA8pWWOaoy/c0yfauGsQ4PCE
 dzrcO8cf66gniCWxDevKlLZjKpvhL96MV7hlH7Xl0kgZDdnUZ1Kx+RXb+ECHGOssbUSQ
 PwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782926530; x=1783531330;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TC5t8A+otm8CUKIo7NwZaGoLcg2i72FScsypM7KbePU=;
 b=O+qWyi1hb2mfK6d5PhywOMrgBo2w4J23XrwcJZfxCxM3+xqy3vv8M5+t7BxxPbHcsT
 Kl/yv8BkYw0FpRteAzfwxBoMHsub6qZfWPtrmjPKrLsrAxBK21mzXAVEcxjKF7lTWbmu
 nzakXH8qsjeevinxfLezI599z3oUJUNvd4pAK5Rw3XiGxORrwQ5QmVMTu3o1xOpsLAAY
 pQSkDDRD7glHCvV04mg/39aaORI0EpQrJ+gWRJgTJuI+71Rdjt27bCh4uwJ4Pn/n6C/a
 DigICF5gQNRbyNHnAaHxaCUzDJft8tjLq+QJJLJyJtcDIjbBlWtIl5jM4FbCu4jPPttp
 1MoQ==
X-Gm-Message-State: AOJu0YzdhKVVsbf62Nr/Pbfugypig3/C33ApT/bRr8xsJF1jxRlouiDn
 P6M/6WrhMwmZdIFSrsOVkpG01RN0oBV3LJeJBHxK6pl48lP4jAoHb/MI
X-Gm-Gg: AfdE7cmKwS7fhKtMjqWI2VfbHzI7nxlBmldXNN3bBA0jzvnCwVdCpgblnxASilaNo57
 0RzrdjAU5CKnCTiuqAJFVWGQ0xj9LDYiHoRMuVxnmj8Dp3iCenLap6PgX1hvWQm0Nk1NrutM+Vs
 AnWuVARIaiCk/d3u59pGPsN4QRfwhBMo/q9HOsOqoWJLknOlJU7wwoiys7wh+UmNOTph3BsChrf
 OduuRtoDzODag5R+8ZA/9r6zoMqCmabOeZzjxa047xu7xMfogJvQ1rILkkcKgg3TQlZMKCwjfcV
 vHgkbgEEMwdsDNAgdLsMzxZYXi5NR6Rvj56fIdioJ1obIQhAUUS4xuBwzCAdrA0e8NeAcAab8Qy
 lqvVwby2DnewSeDvSb6TLc1SPl9q7KNR30OynBxE4WMlOtv56oXOL1hHgXkJWk8opArWIp7Iqi8
 Q1nL3zPqdmVNqJhF1tDFPW
X-Received: by 2002:a17:90b:3e50:b0:37f:9ce1:7359 with SMTP id
 98e67ed59e1d1-380ba91d27emr1405443a91.26.1782926529623; 
 Wed, 01 Jul 2026 10:22:09 -0700 (PDT)
Received: from RodriguezRyzen.. ([181.229.23.179])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee3205993sm23033963eec.24.2026.07.01.10.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:22:08 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: kraxel@redhat.com,
	vivek.kasireddy@intel.com
Cc: dri-devel@lists.freedesktop.org, linux-kselftest@lists.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
Subject: [PATCH 0/1] udmabuf: reject unknown UDMABUF_CREATE flags
Date: Wed,  1 Jul 2026 14:21:58 -0300
Message-ID: <20260701172159.270872-1-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Jul 2026 07:51:30 +0000
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

UDMABUF_CREATE and UDMABUF_CREATE_LIST only define UDMABUF_FLAGS_CLOEXEC
in include/uapi/linux/udmabuf.h. Today the driver masks unknown flag bits
and returns a dmabuf fd anyway, so userspace cannot tell that an
unsupported flag was ignored. dma-heap already rejects unknown fd_flags
and heap_flags with -EINVAL; apply the same policy in udmabuf_create(),
which is shared by both ioctls.

This series adds the driver check, documents the flag semantics in the
uapi header, and extends the existing kselftest with test-unknown-flags
(UDMABUF_FLAGS_CLOEXEC | 0x2 must fail).

Tested with the udmabuf kselftest on a kernel built with this patch
(test-unknown-flags PASS).

Iván Ezequiel Rodriguez (1):
  udmabuf: reject unknown UDMABUF_CREATE flags

 drivers/dma-buf/udmabuf.c                         |  3 +++
 include/uapi/linux/udmabuf.h                      | 13 +++++++++++++
 tools/testing/selftests/drivers/dma-buf/udmabuf.c | 14 +++++++++++++-
 3 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.43.0
