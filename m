Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E17CC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1584F10F248;
	Thu, 13 Aug 2026 09:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lIB27nUK";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8557210F009
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:56:43 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47f706438c3so90339f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 06:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786543002; x=1787147802; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cjqqYdlJxczb+huWu8sxbAJ3m1jklduZMwUdXKo3Ujw=;
 b=lIB27nUKqnwRv9StQQX2ra9M5Lb6klstSyBZjEH1NtCECxiz4BS1VpzJPhAQmNndhb
 vnm4vFPfgKKycsg9w49VbKPwbvzWh4cTNUwsUzNVgLaaMqpnJSFIhAqcUDx/mQcwtq7L
 fPM0BOKKBg/StZM8ObxI1BLRtvPhIv78Lj8jAAZ4daIaEqzd4yzAbZHFdHEn4I3lNgFA
 1cpxomHm50k/xKJzx6x/PPpImUEl2n1anhLun+LOUnZCt0B/TMdvKRHcMtaW7Yd5er99
 YYtqbtTql69xauYQC25MBPsJEqA8vfixEJ7h7k3w7quq/sSyBMjdU/sUnFHtx3iZZMfV
 /F3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786543002; x=1787147802;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cjqqYdlJxczb+huWu8sxbAJ3m1jklduZMwUdXKo3Ujw=;
 b=ZtLA4lixjQ/X5OOyX87kxkiJvGd+IFwbrteUXAH2XZvJ4065WLco55kGRCVRXaGDG7
 2kpeclESVQAef9YRTx0IIRzF3bNFVhqelnzo58ijaiQxIKI6EYLwyNQqvRYClcq6oXsZ
 8HBZGFEEjOSqZ8D6DnpCvVVM/vdwjaUq4CAHW8E+TioJjVz3zHwaACBz5D0MMuK+KD+Q
 +sdatD0DOvUqVQulyltYPR25/y7tTvD3OoZmjEANXMXIc4yawp2K5H6Bh1/G8G5z8yCk
 hg0iclAhibxCQEViG/dCKzfCQ5LS97kpc/D8+uw0x46p7WQaG4y0Dti5Mg/ArnWSGKjd
 lz3A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5TeGgBL/L1ykvRDz51hWxIaFNVncBwV2P6mlDJTQhOWueOcIfgAEI719ZUcEruhGqb/KyZ82T5E8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMyAFx1GPjX4Y5+jxogzyH6pv2J3u+IDjY2gr8vNCkVWWs6w4G
 3P3jC3NuHoRy51d73hFXSfpS3gUzUnf+FvLjkzurJvmPzugYPYB7/ppL
X-Gm-Gg: AR+sD11Gx5Vk9v1c3qNHtky/B5BA85CakHrgJAd1+0SSztI90Jc5EuL+7qTcDi3vD7g
 IdsyqJyjizPpsChRXO3qdci/wjOjxfnGzcwBIrFRvUPE+65wc/FPYBbgFkrp6ruNEgaD9lrEp7b
 pClnViwnHIgQMzidEKlEwjqhV9xubZKtR4wQWSM8BuPIn7H1Jgeao/SZH0x7IqE7H5Y4qXlT7Hr
 OEA1sxrkHD5NHeXxA8Ev5fWb4WWVr4ikVqDtXTQ2HmzNOVYs5aXOwRZs9ldWn7K002TCQVZxxFi
 PzQ4Fj7k7Lfn8mr4QXeBkfNFyj0aNyXxcqm2JybSjLB4BzUDIh7Dk2TvNcnbKmbDD8gQhWSw2om
 6qqrD/WeaJtJ/RwW2QVt0B5ZMXjDPQSFWmE41FXF8+j89pXc2ZPyrxvuBc+E1J7RXiKYTMT0csb
 xlI1AlRE24vjEz2X3vC4RrTa3WDTNZKxGGlWmOk0GlhDA5xspd8GthY15YC2IR38y45BM=
X-Received: by 2002:a5d:5f41:0:b0:47f:6fbd:f23e with SMTP id
 ffacd0b85a97d-48152cba2aamr4137759f8f.4.1786543001607; 
 Wed, 12 Aug 2026 06:56:41 -0700 (PDT)
Received: from localhost.biz ([185.61.25.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150bf5f27sm7351303f8f.1.2026.08.12.06.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 06:56:41 -0700 (PDT)
From: Dmitriy Okunev <dokunevdmitriy@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
 Matt Roper <matthew.d.roper@intel.com>,
 Michael Cheng <michael.cheng@intel.com>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: [PATCH] drm: i915: fix sizeof argument in reset_csb_pointers
Date: Wed, 12 Aug 2026 16:56:26 +0300
Message-ID: <20260812135626.16959-1-dokunevdmitriy@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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

In reset_csb_pointers(), drm_clflush_virt_range() is called with a size
calculated using sizeof(execlists->csb_status), which returns the size
of the pointer rather than the size of the object it points to. This
could lead to incomplete cache flushing on 32-bit systems where pointer
size differs from u64.

Replace sizeof(execlists->csb_status) with
sizeof(*execlists->csb_status).

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: dc0406820ee7 ("drm/i915/gt: Drop invalidate_csb_entries")
Signed-off-by: Dmitriy Okunev <dokunevdmitriy@gmail.com>
---
 drivers/gpu/drm/i915/gt/intel_execlists_submission.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
index e693b0c9d2a3..9ac67a0cbb1f 100644
--- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
@@ -2833,7 +2833,7 @@ static void reset_csb_pointers(struct intel_engine_cs *engine)
 	memset(execlists->csb_status, -1, (reset_value + 1) * sizeof(u64));
 	drm_clflush_virt_range(execlists->csb_status,
 			       execlists->csb_size *
-			       sizeof(execlists->csb_status));
+			       sizeof(*execlists->csb_status));
 
 	/* Once more for luck and our trusty paranoia */
 	ENGINE_WRITE(engine, RING_CONTEXT_STATUS_PTR,
-- 
2.53.0

