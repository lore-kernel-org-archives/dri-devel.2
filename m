Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42234CCA48B
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:36:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 288B1112675;
	Fri, 16 Oct 2026 07:35:54 +0000 (UTC)
Received: from mta1.migadu.com (out-224.mta1.migadu.com [95.215.58.224])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6087D10E1A7
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 05:33:36 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=8RuKnhZ40mCLqtZODHDu3kxTqZdJn/bBLwgoyLRXSUQ=; 
 c=simple/simple; d=justthetip.ca;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792128814; v=1; x=1792733614;
 b=JozT5QyCHMcgSKXaL+TTp5OWB8QiO3A3zbBHvWkpttAfRrwengs0voRBEHDh5pvFbmgkeHen
 vnzZ58kmPRzHsId3P6JQcDR5Re/QXhp0hoiKPvAwVsO4m1GXbTEVk0A3OCpbcOabp7l03t2Ivoj
 1hUyo7gyWFAbvDLnke0saY4yiqQoivC5WbWppsVcT4+2cSRZHAMnLDP6SMRSXbHa2EazOrMWtIL
 FmPZjwF1L1bdH6gnusElr/eyzk0gKpFSkcfll2dn8pWQv0ORLaTsfRpYDQP7Q0piCfqMy1NmoH8
 BgNmV+qWztUGEXIGrdkQyqghqBUaOvHrES4m3lU2mNoog==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id fbda3602d4225860;
 Fri, 16 Oct 2026 05:27:30 +0000
X-Mizu-Trace-ID: fbda3602d4225860
X-Migadu-Flow: FLOW_OUT
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: Jocelyn Falempe <jfalempe@redhat.com>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/panic: Accept a trailing newline in panic_screen
Date: Thu, 15 Oct 2026 22:27:22 -0700
Message-ID: <20261016052722.60051-2-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016052722.60051-1-lucid_duck@justthetip.ca>
References: <20261016052722.60051-1-lucid_duck@justthetip.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 07:35:41 +0000
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

Setting the panic screen through sysfs with echo fails with EINVAL,
because the value ends in a newline. Ignore it when matching.

Fixes: e85e9ccf3f84 ("drm/panic: Report invalid or unsupported panic modes")
Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
---
QEMU, 10 runs each, on drm-misc-fixes and drm-misc-next:

                                     before    after
  write of "user\n"                  refused   takes
  write of "bsod\n"                  refused   refused
  drm.panic_screen=user at boot      takes     takes

amdgpu, 2 runs each, 7.2.6 with Arch's source and config:

  echo user                          refused   takes

 drivers/gpu/drm/drm_panic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 29b1487de7ae0..7847b38ba9aab 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -839,7 +839,7 @@ static int drm_panic_type_set(const char *val, const struct kernel_param *kp)
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(drm_panic_type_map); i++) {
-		if (!strcmp(val, drm_panic_type_map[i])) {
+		if (sysfs_streq(val, drm_panic_type_map[i])) {
 			drm_panic_type = i;
 			return 0;
 		}
-- 
2.56.0

