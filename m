Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A619C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49CE010EDF7;
	Tue,  7 Jul 2026 15:33:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P4tka5Sw";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E2D710EDF7
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:33:40 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493b7612475so41415135e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 08:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783438419; x=1784043219; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ckhp/gzTMi2ZUGo+P0tgl5yB4DRhnm4KfUbhwmtfgbQ=;
 b=P4tka5Sww+O101Q9jMbIU2VHcMuWaAMlsAKi/jE9qlQP/q3HWSIJ/N2Mp1691QhSht
 eDHQdHHAnJo2zd0d3HMMOlGPthCler75QDcqcpvZi5Sqfc59nBu0epWhwCqQ7gQDYqtJ
 ZZjrWGmRtl3ldjXLOzHJrRe6k5HN9KEbBkf39tEujyxBLRipnD9DILvUnQFQLu590Sgg
 8yvirXe68hvsulk25xzvylqdwdiRp0a32+62qFOOfs5gLWsWBJpAnB/dQCkBj1GKeoe2
 +RvEmsJ32YZQtyVsC4Vuo0ACNUNGNXfq1th+B8qkQr5yJKOwynLyVzgAwGk3zQnYRjEO
 xdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783438419; x=1784043219;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ckhp/gzTMi2ZUGo+P0tgl5yB4DRhnm4KfUbhwmtfgbQ=;
 b=MNkC/QwkUhJjrrEJCpHgTpVDzHQXe0dgdbiS/tgBETRr5efHzAGC5ajqP8r3WSNpm/
 XqAMa5bMm02lht7dwHyJtrWCQBYo4xkD0/ddGwOE8BSgz/4VeMvkn8lVxYJkiMVFW8+O
 1pFVMCJw2o6/8J8WyadnwifqM+F2hyqaFLzXriCHRK1B1cO9p3fp0lSSzHvAV4RTLRHA
 2yFH2RNX/0aCV15w7/AK5VivlF/AEb3021lArUtPev5TDpHFR6zD58Mc1SSZRDByoPwV
 v7TEuNuhApTLehzu2iZhG/Ha5VW5jes5tMBgpLCtBAwMjwzZy/zav0D4Gu4aMIF8cEcv
 wxMQ==
X-Gm-Message-State: AOJu0YwtvFx7IUfvb+lDiV8ejeAlaCO157+WK9cIpTDbxr8s2+p0vKmP
 ebmN0RJ0NXMqJ8imzlDzOEM76osWSM/4akkWKw1tgFXNj6MvgGBQ2AIg
X-Gm-Gg: AfdE7cmaojiI/eTo1cmmJe1BkLF5KxgNrGR7NKHJKvgnb3OfPK8ORqZxsGZxfu2Lxw1
 jNgChPZSb7wnaBujJwUKKxcqb/WLJmLty5O8/E9/XWIjcK8bAp4f1pEWjeHpMG/0fba4xNZGwiU
 RSNOE+GDBjUj2Sn0Tp4wD7UAEyzGFjwvPMhBkysSbcAoDV/+NEdjA2SaenCucEz8LjUxaUaERBD
 IxsjROunkV2MJ7WsHrXeRJomA8TYYzxopbQYpKiUJbJgsjTa5NRxY3KtZWS9HibJQ9+pRWft2Yx
 6gXujhEpqJXyaWSQCBT6C6gvPqvAnux6BV9ctxHh5UoX9rlm8YPWlFQDqSZNIGWAybzubIBTQ2l
 WJSNiDXNfZPdw9G+95v1yqNqF8xovg9iUhmwJ5UbYUyv/wQfQxW3n1OegoTuUOpzERJFn94vQHu
 YXq9EOPv9qER5pB+ONXrfE
X-Received: by 2002:a05:600c:2d53:b0:493:b811:e549 with SMTP id
 5b1f17b1804b1-493df093b48mr38127505e9.29.1783438418551; 
 Tue, 07 Jul 2026 08:33:38 -0700 (PDT)
Received: from [127.0.0.2] ([194.35.121.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f5b811sm100622385e9.13.2026.07.07.08.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:33:38 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Subject: [PATCH 0/2] drm/xlnx/zynqmp_dpsub: improve usage of drm encoder
Date: Tue, 07 Jul 2026 17:33:25 +0200
Message-Id: <20260707-xlnx-simple-v1-0-df50c6665b02@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEUcTWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwNz3YqcvArd4szcgpxUXUOj5BQD02TDFHMTUyWgjoKi1LTMCrBp0bG
 1tQDtdrSIXQAAAA==
X-Change-ID: 20260707-xlnx-simple-12cd05c1d745
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Michal Simek <michal.simek@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Diogo Silva <diogompaissilva@gmail.com>
X-Mailer: b4 0.14.3
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

This series addresses two things:
 - Remove the usage of the deprecated drm_simple_encoder_init on the
   zynqmp_dpsub driver, substituting by drm_encoder_init
 - Add a return value check for the drm_encoder_init, preventing a
   potentially uninitialized encoder being cleaned up

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
Diogo Silva (2):
      drm/xlnx/zynqmp_dpsub: remove dependency on DRM simple helpers
      drm/xlnx/zynqmp_dpsub: check return value on drm_encoder_init

 drivers/gpu/drm/xlnx/zynqmp_kms.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)
---
base-commit: 7a8782fa5da551a92ada0aca6f7dbadfc4c36da3
change-id: 20260707-xlnx-simple-12cd05c1d745

Best regards,
-- 
Diogo Silva <diogompaissilva@gmail.com>

