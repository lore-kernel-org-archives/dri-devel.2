Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438DDC5B560
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD56F10E64F;
	Mon, 10 Aug 2026 06:37:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cO5kQgwS";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F5D910E149
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 09:04:43 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2ce98cb8165so7858185ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 09 Aug 2026 02:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786266282; x=1786871082; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qP4+vU5/u2vGQjsfNEJwm0ao6bE0Fdbcd+FhWpWbiq8=;
 b=cO5kQgwS2Ay945TKg+pmULSVsD0m2yQliEiankWJPSqb7JBTG6XmQnD8OraNDwhbHV
 oL92o6RiRC0T2hklGvUITK32lRMmeNqlDGujS5ruDtiWGnapWjEthRc8S1Nsny0rTp36
 pFYrUUdnf921mOZxj2uPm1LHJrMRtvji70bmw1gwiM25+J635jZxgED6mcFaXBVxuNHp
 hJaWxRFMLiI799zse5kdiY0n2X+d1OrC9FStCE9OeNZ5ZpDhYTacJdGtmT1rub1/WrOs
 nPgNmFjwOwkl4hEPEaK4RsRkeFxBjslFp7Pbq2G+1zSdscDbxOdn5Y4Q6rnt7Xi+kjEE
 jNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786266282; x=1786871082;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qP4+vU5/u2vGQjsfNEJwm0ao6bE0Fdbcd+FhWpWbiq8=;
 b=TIy7kVWjv/00LsgyS6Z24Mjcw1CPLniW1QXsoTyRXGJpwgOuV9DhOvKOBudAJTOyZ8
 +bF2+WREnM5V9UP7D7QlmvdkYseN1d6URsh0GnRNElgh82eo73eveolZ9gGt5/3b5AH8
 3rFaeNHUci1qCZUUzHh7MpnxXwmkMBe5POYeoypVGiluTzhw7z/a57F9lEd9sc+WMp1d
 8GkOFR6ubMd6WQwXueNQQVY1TL9sj4ZxCIE2oFtUzoviim48d6k6L3VGakGsEEdf7Rg5
 t6TMvXyBx63uNM75op+1j12+QHjmd/vP8xsTA20HDADDulx+Y1hNvrFoF74hHiNn2rr8
 9GSw==
X-Forwarded-Encrypted: i=1;
 AHgh+RococFlxSnq/fPh9lCd+PlMK0Jkd2cAUV4LNkLDbwLXw1L65QAcos4LlmNu2qbRlNtR9z16HXt1TMw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyk1/zZkEOUOS6xiZLG0qJx3RfPcLYlBiJjO1/sWYlU6Rw16q4d
 OU4aWXXCuGABTEXqu+zTWabKJzbGBGPMLbmIcJztjl9SPT07yjysggVx
X-Gm-Gg: AR+sD11Xv/1YXX98iLuPgCbvW3ebJlDLxioz/HQEijXwHpY3uO3QWZbFj1gwVj0GXG5
 1s/2HSxOgJWkwzMqnFBC9UcHFPMvYGA+Ngd/1bNk6gb6kyBcBuQt87Tkfsc/TUdS/EmBbRJWlIG
 rd4ZQ5iPZ8O/v3k8zc4nAcqhjtBK/KEYODs270X7H5p8ZPZeVK3xgHuLEBarwwR+HBNE1U2dALl
 Jy79KJICW2H5H7IxVzGOBhvxwz2WdZjV5RRBXKZyctjG6o41/RzWDqmrG8Od1SjEofme4KkVuqQ
 P88aW8FHDSzMsXCfMcNPcmtEIcpcmSn8qlm5PxUicmIuGL0JLOJSqXOOPn6wEMPZ3vgvK2IddLY
 BVaRmPbvkKizJMhU17HuNdivxMpvPWx13DfRK3I7wEObYhRlIG1FFPTCZ/BhY67eXh+HqyB+ZvI
 JNYVT+FFnlj3X7kW2fpC6SnPuNd6nZFV34irJAjNsWzebpiSIA/s6LnPCd3FNXtZXwQgfxJIde2
 8LQnOOYHYb9fJFcRwinuueQSrnHNMluRK4bVyEWxI6C
X-Received: by 2002:a17:902:e885:b0:2ca:53f7:3c69 with SMTP id
 d9443c01a7336-2d2b2e60fa4mr116531885ad.9.1786266282292; 
 Sun, 09 Aug 2026 02:04:42 -0700 (PDT)
Received: from deepanshu-kernel-hacker..
 ([2405:201:682f:383f:746c:8928:e990:23a8])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315bec68468sm30828864eec.31.2026.08.09.02.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 02:04:41 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch
Cc: chris@chris-wilson.co.uk, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Deepanshu Kartikey <kartikey406@gmail.com>,
 syzbot+db96c5ff032f4292a8dc@syzkaller.appspotmail.com
Subject: [PATCH] drm/i915: Guard against NULL driver_data in i915_pci_probe()
Date: Sun,  9 Aug 2026 14:34:30 +0530
Message-ID: <20260809090430.20577-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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
Fixes: 42f5551d2769 ("drm/i915: Split out the PCI driver interface to i915_pci.c")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
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

