Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E42C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:36:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7CCD10E33B;
	Thu, 16 Jul 2026 12:36:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="hK4P4UEJ";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05EAC10E33B
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 12:36:55 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4798bea72f9so3490648f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 05:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784205414; x=1784810214;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hMlzPGyvzJbIEx1Yj1A1YkSSxKMRLpTm/IL6VYqgYHI=;
 b=hK4P4UEJvrOMDI8JVR4LXfVm/TEThI6BJGn6FCP2amDcsM1cYRVliCzDuzI4QWEsqq
 /pODVH0ZPoG/Lp1NKva9ky7a/+zExnGmsLfQEIi4o2ogzzN6uvaPPD8/PZVvKUiC+53N
 /IncKA8N3f26fTWcRCWAge1F/Biyv1D34KtXWb4ngCisFmRVNLTQaz15NM71EeUTqxWd
 EiCrQ6dN5ltEclgKhACinquuFZyB7ODamilR9+SahjiZn6HKStytc4C3rST87YG+27UD
 CJ6ny2nDVyGS92VecVmCdvE5CTM4aB/JKLl/FM40YgdJ6YyVCdBSJGXXFyuEMFZkw9Or
 EwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205414; x=1784810214;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hMlzPGyvzJbIEx1Yj1A1YkSSxKMRLpTm/IL6VYqgYHI=;
 b=gfLnqb4MqYmyh3aOPoZ/xrKAUer5spoTMzafa/U578KKi1VP3uJmmsKvoQ5AXCE683
 s2qjGO6Yu9mXoi6z/67amjVwOQeve+yf13Trt9l1AUpJiNEYd5Y4jaNKRwnwmotLRfQs
 DKhfr6jL2P3RbrrqJJy/BAY/uDjDtpHMRawl3ngUMhVjzhVdhJWBjnmpOPbnyHRnc/UI
 JdjkI+kdyvp95dwJnsess+Djql7YrkVUcmj4Y8UDDV+4FvkiOGun6iugFyZg430+2IhM
 /bgL5hZ3s45D9hHW/IJz+ybLmq8wwngd41DfYXUbot5lgALR5TXU96bFUmje+EPAZypY
 F0uA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpLrdtmjfwNRgcMpbBy0VJH8Sk2wUY8sHAI4ZFcAQ6iokZhsTtfWGkzhl+LVaMzSIw0l0Q78vxL9Bk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyVxOFyRjUpLkGo9onWwzfFcgeqmP1i5oMiAxn+5hkRaBnoGSfE
 7+4t9GzmOGSaW1kGM7rq89yIFq6ZUO/QOWlL77grHLvIiFtwD78HnI/FuStdKC+xruE=
X-Gm-Gg: AfdE7clHaj2aMx3FfoPcmTLPjcn0wNSJU/DH0lZWm2Pf17BQEmrsILNBW5E3cHs3ryd
 1A9RzAMv1SLjBwbcXUadDE16Z9nW9By9on2tlB7B5QXT6KmvYrPjIlqFVJGyRDz6SuJUfnIjXoO
 dc+nb0x3gn4+K3wh+s1p8fbz6ffnC7PKwH6VBXADkam/efa0EgOlZLycPfsozAuH40iodg5IGPW
 w+2acqITzbnEhkhL1PykFeNV2BKJAa0omylZxEZuU3ewEsQ8KA0k+UrpTUgO1Ph4JLjZ2ZFlXzs
 wDaiD3BpjWGzMcyPz+mPrD6boO4weIMQwvRclOqpfrBvc2I+AcEJPJrMChHaVP58qjWQQXuAWiy
 fOO+SRK4XH5iXO4QMjeM2iBVgpEO8TTr+3qOwUKcsi0o2e82aFjNQRWpKKbMg3P/FWkuJnzKCsl
 4keomDKCGKEgvQJ05EsKg2n4baGj/gHTA5nX+FTwRtKcGgM6Gq81XeEwUfli4xjfOIvw==
X-Received: by 2002:a05:6000:22c2:b0:47d:ef62:cae0 with SMTP id
 ffacd0b85a97d-47f488c9ae9mr13456684f8f.51.1784205413893; 
 Thu, 16 Jul 2026 05:36:53 -0700 (PDT)
Received: from localhost
 (p200300f65f47db046a548a0537ec1e67.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:6a54:8a05:37ec:1e67])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47f464a96cfsm24325718f8f.20.2026.07.16.05.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:36:53 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: Only define radeon_acpi_vfct_match when actually
 used
Date: Thu, 16 Jul 2026 14:36:45 +0200
Message-ID: <20260716123646.1933293-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1497;
 i=u.kleine-koenig@baylibre.com; h=from:subject;
 bh=IKtUF1mcJc4KuUB/Ooi+YU1Vjqw6c7TxzaSph7yF/Ko=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqWNBeLNdSWBkyzCZFGSImvaru90MIq0pcqeEAF
 zy6u8Kq3KqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaljQXgAKCRCPgPtYfRL+
 TtdcB/9JiPDX5arNdnLDQp+bvrkfr0KgD8uJv0WoMoW5hXpj/6+SKiqktl/Wqerc8mH5qE7g/DV
 vNheGPKjYwbZzVxuHJw0L0nlANRtqg4gdLYjOBTQUkp5t6QFGAK9uyj3811uos+R+gG7cgxePus
 yRQeu6vpWUMeJTGVtJrE43mNdvKP5u6YhEdjjLsG54QWw2SnxJoH0ep/O42MUqCAZYdxHJNg04i
 frI6xg1grnSSwlsmpiFMYUE1shT5hi5jt0kwt5Jq2CRT/+bXuFSGj9mJGrliFcrHO4LTqKG1ux/
 RelL9i3jlYE3O1N5FwaHV9WOj+6N3RLXVzmVBTi4u9zDVytn
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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

This fixes the build failure

drivers/gpu/drm/radeon/radeon_bios.c:614:12: error: ‘radeon_acpi_vfct_match’ defined but not used [-Werror=unused-function]
  614 | static int radeon_acpi_vfct_match(struct radeon_device *rdev,
      |            ^~~~~~~~~~~~~~~~~~~~~~

for builds with CONFIG_ACPI unset.

Fixes: 33a18ecd2fbf ("drm/radeon: Fix VFCT bus number matching with soft filter")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

33a18ecd2fbf is currently in next via

	https://gitlab.freedesktop.org/agd5f/linux.git drm-next

.

Best regards
Uwe

 drivers/gpu/drm/radeon/radeon_bios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index cc10880af096..cd7a5d458157 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -596,6 +596,7 @@ static bool radeon_read_disabled_bios(struct radeon_device *rdev)
 		return legacy_read_disabled_bios(rdev);
 }
 
+#ifdef CONFIG_ACPI
 /**
  * radeon_acpi_vfct_match() - Check if a VFCT entry matches the device
  * @rdev: Radeon device
@@ -635,7 +636,6 @@ static int radeon_acpi_vfct_match(struct radeon_device *rdev,
 	return 0;
 }
 
-#ifdef CONFIG_ACPI
 static bool radeon_acpi_vfct_bios(struct radeon_device *rdev)
 {
 	struct acpi_table_header *hdr;

base-commit: 33a18ecd2fbf6bcbf803836e94eb31c26f4c7f41
-- 
2.55.0.11.g153666a7d9bb

