Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A94FC5DF66
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFBEF10F262;
	Thu, 13 Aug 2026 09:42:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FbkO8iUY";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B5E110E367
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 06:49:13 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38deea72eebso461142a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 23:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786603753; x=1787208553; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Sj4nAB5UJQSiK8q2P2qqPUYrLHWdF5UCEVGSdlXatDA=;
 b=FbkO8iUYogh4z+PoA4/xqooNNDxTbFhkAIAJqBW9CJNin8grJ5+Ng+KNyjGqcisLBV
 RMklpgQffstQYQ+yObU8JSm5Oqr6S8aA617Xc6pIA8gj+Alns7ZCU5E32wfxEuqmVEND
 gLdqgT9DeYo7mRMh6Gfko1E+NZiuWSbSd72OOqVeGGrRz2tRTgFyIJb75UytBYfrHPPm
 3TkJMjeIaI/AlbR5jf+m+Z2WaPx2I6f9pFMTuOp1IC7X4kzLxmObJ6w4w8gfTUg6hOZe
 C1BVsBHSu7Lw7Yru2JqU3Uz8DIjtKngaS6vcLGiqOBF4vbyUtfI9oVLSZJXZmv+2cE1R
 HQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786603753; x=1787208553;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sj4nAB5UJQSiK8q2P2qqPUYrLHWdF5UCEVGSdlXatDA=;
 b=tRZd4zuMmuJuqhzFgxeKt3V1NZJ9IJ9q3hUPH0CSsQbSw7stPSmTzvMpzi3EgY/dRt
 j7dYCCohokdXfkdqxQjyT7MQFOYMYpkhoPNj/DMC6+3O5fdKUtrE9olxh7wZD32zr9gm
 F5MSwlf1N4qBt2RJ5yGMy3ex97ncQQKW5Qk62w+gfFtO019nRzVHSBfOootBghZ+XVvN
 Ezmxj46nv0PT2Wf/jC6MIn1V+nsLxZT3c6as9mQ1ZdqG7om9HHHqnwdxSy9HK86gUGyj
 XV9SVdWX2sS1wPOJhd8R17mD5XOGh1pWuACaktWhvQwVk2SbkLZpK6h4O5m/VFf8DLED
 NFKQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoreqeUhptSdmGLlpa/FgXvsYEI0oL0d1Y83z9VOdZlaaulv6ciiqdoX57ySu5MF0W001EPHi/vvCA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyoWg68g2dcRWd8kLNx1QWXO2U703syxw74weKcokpPouEp/5ZF
 37Ut1nhxCAVaHavCKmxnzgbiQagXV0OxYVw5XsrI8Us2jqhV8m4Kk3nP
X-Gm-Gg: AR+sD11q/xULEB7xVrfIpwF2d0g49QpBHrbLDi9OwhMh2OWKf3sg4RAQ5JLmCUWMIVM
 2VLn6ei3grwgVo5HSxlq9TL59dLcWChKneY46HGQAwW/3+CXXjv6kJk91C3pIlliRx33AO7mVnb
 G4jY+eIMKStx5vrIVedAPLOX+SV7svukFZ44vWO/IATlWlv/mFRznuhm/mcZhvF36kYrDnEA2Ar
 O5QJzI6uYtYX+lUB1aj5W03yrvKZn7ShziliXYykho/Rxnp5wHcK+cYcshEMPQvc84OgRgOgF1n
 UBYEXUYX8BHnNIUojSdMRPMR9+Q4Onk5LmMtG0WJmLyCo6Mciph2zU1dHOVGcomCgvA+ebR2gN+
 BAWroxY8yACYv54mCQvV91gj/IHf8/0EyvRkCe3SjImvGOlIYeHMoLxedT1/szRd0XVhAEjIVYO
 FvSBOMtuvKnAc87cyoiPP2C/Rtna9ZCFXQFCvlksNBg3kurPVs11Sp6DRlS5yUSobntqLZcS2eR
 dTQlzn44l0eCTQHuhuuczvr7zPUcoxb1yIXpTXVMPe+Raztv0XrzvdCMzu2yDKv
X-Received: by 2002:a17:90b:1d43:b0:38e:3fdc:62e5 with SMTP id
 98e67ed59e1d1-3931e2a0572mr4819755a91.19.1786603753033; 
 Wed, 12 Aug 2026 23:49:13 -0700 (PDT)
Received: from deepanshu-Legion-Pro-5-16AFR10..
 ([2405:201:682f:383f:229c:e2c9:8c03:c9c1])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1412da6c0e0sm7111503c88.13.2026.08.12.23.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 23:49:12 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, krzysztof.karas@intel.com
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Deepanshu Kartikey <kartikey406@gmail.com>,
 syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com,
 stable@vger.kernel.org
Subject: [PATCH v2] drm/i915: Guard against NULL driver_data in
 i915_pci_probe()
Date: Thu, 13 Aug 2026 12:19:02 +0530
Message-ID: <20260813064902.367504-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
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

pci_match_device() can return the dummy pci_device_id_any entry
when a device is force-bound via sysfs driver_override, in which
case ->driver_data is unset (NULL). i915_pci_probe() casts it to
struct intel_device_info * unconditionally and dereferences
intel_info->require_force_probe, causing a NULL-ptr-deref.

Reported-by: syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=db96c5ff032f4292a8dc
Tested-by: syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v2: Drop Fixes tag, this isn't a regression from a single commit -
    the unconditional dereference of ->driver_data has always assumed
    it points into a MODULE_DEVICE_TABLE()-backed entry, an assumption
    broken by the generic driver_override fallback path, not by any
    i915-specific change. Add Cc: stable instead. (Krzysztof, Jani)
---
 drivers/gpu/drm/i915/i915_pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index 82415af47d54..2f03f95945f1 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -958,6 +958,9 @@ static int i915_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		(struct intel_device_info *) ent->driver_data;
 	int err;
 
+	if (!intel_info)
+		return -ENODEV;
+
 	if (intel_info->require_force_probe && !id_forced(pdev->device)) {
 		dev_info(&pdev->dev,
 			 "Your graphics device %04x is not properly supported by i915 in this\n"
-- 
2.43.0

