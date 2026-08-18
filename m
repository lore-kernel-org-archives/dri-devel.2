Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E972CC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:37:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3EE010ED14;
	Wed, 19 Aug 2026 06:37:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p5ENDBK5";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E9110E4E6
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 16:37:27 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso181851a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 09:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787071047; x=1787675847; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mqCuwsa4VpZFmo9BwOMyVrlgBZwX/1hDO4fvPHFhOQ0=;
 b=p5ENDBK5eIFIGcHSSfB6fEh96CfYTNo6WsR+nHlw898LMzihDZqNgd3BanNV6K9t+r
 qYP3CD/aK7g0TnCKuGVuhtLp/tiRpngh2LobLPchDUVfxhTDpPpkkzd+UaJVTJWHd9RP
 LBd1Tm+Z6/KQ2kFMue8J8i1+ImPs98O65Le6iyue47q+2oMGzUhGe6heti4aqeVaQMo2
 2rTyVjQ8TPK3Yn7bcwrvztidLH+39WRWuLYVn7tyQ4vQS/GkrtnJmREFNRmKBYLeIn0+
 EdFSff3L+V6NDakD7sLh2SDu1ufYYWmrW4i1U+jnY+w0tS2bKNIpLTfibf2LyHpZCJw8
 EFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787071047; x=1787675847;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mqCuwsa4VpZFmo9BwOMyVrlgBZwX/1hDO4fvPHFhOQ0=;
 b=LP77sWZYX9tAm4NcWA8Y1Z0nC6QMMOA7XMPSZP1qHnBU1/XBXi588BBpDQMs6u8Qmu
 3yAa/gorWRGkrNXVW2IMEUaKwRRaTSk9fauJQIG6ZSfkq3fj8ltR6NWMDdn9iZow0e35
 hRTynch3J+Zq8fLj/1GaJmEVtQ15WwcbmW0r/gnX/9fXKPapUiIpTMG2RbjcqE/7KGCS
 Sb/fb45RD7yZCDKYabp0RpBOuhtZ9tDKjLNQWj/5wqykoh8MKOoLpY+VdpMd0urE0aSU
 htYqIMHaGA5wisqDUfD2GKJU071/XO5iokn0N9uJqX+ma+B0lJBVN3YUEYXHpiv1+W4o
 nK+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq8p0PZfLJW2WeXNXn4GTJ39DvpYGyC2MgYfEfGDvHs+J5jZScyPrEVWoVTFy7QA7BgmFlwNTWm2FY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGSnnywr8qUE8JLqksONZUkNFiRpdKSlSMJqMnA8GIF4S8AiVR
 PeyGf9xDl7Hhr654JFRqYc9f0pyIb76euZq9Ca8S//zumsFmGUZfaa/z
X-Gm-Gg: AR+sD12Zf0T/zgS2UrKuGe2jR/ge4WbB1NkCMK1sGkFqi6BfgiGLmv7HyY5z+/FnJhh
 dyuxuWoN5DgL5wVd1G9mqxQAP6+J8Qh3/piEPk04EABozNR2HkN3bW+L/ea8rr4muLB+M2Mywdp
 6n6ocrJ2xJmkssorUOWn5kJcOjtZZNE12J0QV5BfrsNNygG4YmH7Ysp61ASCrCHUMvcCjn0ZDbZ
 oTk0dLClhB+tzhz5XTIr4O8K5+P96caEEJsotYEGxor0bCvtnLVdpqRegn86pqor1tcM/zPRItN
 0ET8BXJg03pN+7QjQMurvgXgWZyohTAJRTk6cpjQoz/5jvQtBcKVayM7JArQzWerPUjC2KbnlJJ
 fEmcK+aXdWRhoWDS7ZtowyHPGZyyvUI2kLixdkm4tY++/bD7M8jY8dXM4jGEpt0Ti2oYkDm9NVG
 uVgKVtplqj7VsHMNHfLpnHQzCnyn5q76++rgIq50cfcRobZUQ1P2Fl2T51s4hq+o9guwjQx4AtB
 hOHsoDVMfOl6WIIaWVAoDoth93GbawTV0fo8TQ8RXJVJNcaj8w7znghCw==
X-Received: by 2002:a17:90a:6c96:b0:395:4de4:92c8 with SMTP id
 98e67ed59e1d1-3954de49a7bmr11153638a91.15.1787071046853; 
 Tue, 18 Aug 2026 09:37:26 -0700 (PDT)
Received: from LAPTOP-M4N25KQ5.tail73068d.ts.net
 (1-160-197-194.dynamic-ip.hinet.net. [1.160.197.194])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39531ff679fsm9195992a91.14.2026.08.18.09.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 09:37:26 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v2 0/2] drm/ttm: two small ttm_bo.c cleanups
Date: Wed, 19 Aug 2026 00:37:17 +0800
Message-ID: <20260818163719.115946-1-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:31 +0000
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

This series contains two independent, minor cleanups to
drivers/gpu/drm/ttm/ttm_bo.c found while auditing the file. They do
not depend on each other and could be applied in either order or
separately.

Patch 1 removes a stale @ctx kernel-doc entry left over from an
earlier struct change, fixing a kernel-doc / W=1 mismatch warning.

Patch 2 gives ttm_swap_ops static linkage since it is not used
outside this file and is not exported, fixing a sparse
"was not declared, should it be static?" warning.

Both patches were build-tested with make W=1 C=2.

---
v2:
 - Correct target function name in patch 1 commit message to
   ttm_bo_alloc_at_place.

Sean Chang (2):
  drm/ttm: drop stale @ctx kernel-doc entry
  drm/ttm: make ttm_swap_ops static

 drivers/gpu/drm/ttm/ttm_bo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.43.0

