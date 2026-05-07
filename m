Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4761CD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 08:14:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3473A10F074;
	Thu,  7 May 2026 08:14:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ispras.ru header.i=@ispras.ru header.b="VaR7Nx4i";
	dkim-atps=neutral
X-Greylist: delayed 491 seconds by postgrey-1.36 at gabe;
 Thu, 07 May 2026 08:14:19 UTC
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AFEC10F074;
 Thu,  7 May 2026 08:14:19 +0000 (UTC)
Received: from debian.lan (unknown [95.24.24.108])
 by mail.ispras.ru (Postfix) with ESMTPSA id 0FEE945A1D2A;
 Thu,  7 May 2026 08:06:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0FEE945A1D2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1778141164;
 bh=t6msmjqawU/IEsj5CPxud70TuqJjAjCucEWvMJ3Guhk=;
 h=From:To:Cc:Subject:Date:From;
 b=VaR7Nx4iurJc2k38ZCC7sKPUbG60TZzh7zWCskj64/r4czrnXDx1pFOSS1dizzxNP
 wBq7v7eOONtbPocEz7tHcevL23XJV6XUduTbRQL971Nov5XqcgXBwRfmg4XIKQdCUS
 +SkSk6FIcNQkkmyra6AbeboWACBXhpWV3ReiyMnA=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
 Matt Roper <matthew.d.roper@intel.com>,
 Michael Cheng <michael.cheng@intel.com>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: [PATCH] drm/i915/gt: fix up region size calculation for flushing
 dcache lines
Date: Thu,  7 May 2026 11:05:43 +0300
Message-ID: <20260507080544.57053-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Computing region size for flushing dcache lines currently involves

  execlists->csb_size * sizeof(execlists->csb_status)

while the second operand should represent the size of the csb status array
element (u64), not the size of the pointer variable.  It works on a 64-bit
kernel, but it's not correct for exotic 32-bit ones and may result in an
incomplete flush when the number of csb entries covers more than a single
cacheline.

Found by Linux Verification Center (linuxtesting.org) with Svace static
analysis tool.

Fixes: dc0406820ee7 ("drm/i915/gt: Drop invalidate_csb_entries")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

The patch is against drm-intel/drm-intel-next,
HEAD:775fb670745015d679a65f948b3da0fbff3f100c

 drivers/gpu/drm/i915/gt/intel_execlists_submission.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
index 1359fc9cb88e..31037ee3c2c4 100644
--- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
@@ -2833,7 +2833,7 @@ static void reset_csb_pointers(struct intel_engine_cs *engine)
 	memset(execlists->csb_status, -1, (reset_value + 1) * sizeof(u64));
 	drm_clflush_virt_range(execlists->csb_status,
 			       execlists->csb_size *
-			       sizeof(execlists->csb_status));
+			       sizeof(execlists->csb_status[0]));
 
 	/* Once more for luck and our trusty paranoia */
 	ENGINE_WRITE(engine, RING_CONTEXT_STATUS_PTR,
-- 
2.53.0

