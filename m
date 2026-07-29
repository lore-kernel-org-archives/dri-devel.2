Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46916C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:45:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9929510EB0D;
	Wed, 29 Jul 2026 08:45:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="CLxF/7iH";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64E9610EB0D
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=p7
 PyRVmGi7sxGuxdw1sNjF/1/6w92PpU946PtBPDzWI=; b=CLxF/7iHd2acLpweJ8
 QG1lhTJftufp3U76z6LHQ8+XyByuhq3hz7XIhiu/rQuoElxKvf7E6FTKqvFnrVoN
 fcH4ald0bqexWhg04obXUvMRjk5rF+GWdEH88rEjhnrmiqbmHKC87u4+LJQszPtZ
 3Up70VkgmDkq3qU7Z3nu03Vms=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wDHu0yhvWlqbOVpMg--.26952S2; 
 Wed, 29 Jul 2026 16:45:23 +0800 (CST)
From: oushixiong1025@163.com
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH 1/4] drm/log: Fix out-of-bounds read on empty message length
Date: Wed, 29 Jul 2026 16:45:17 +0800
Message-Id: <20260729084520.688087-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHu0yhvWlqbOVpMg--.26952S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWfXw15trW3uw45XF1xuFg_yoWftwc_CF
 1Sqrn3Gr4DC3Z2g342kFy2qFyavF15ur4rXFnFqay3G347ArnrZr929asrZr47GFWIyas5
 ta4DuryUJrn2yjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8fR67UUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC4gOMm2ppvaO6vgAA3v
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

From: Shixiong Ou <oushixiong@kylinos.cn>

drm_log_draw_kmsg_record() accesses s[len - 1] to strip the trailing
newline, but len is unsigned int. If len is 0, the subtraction wraps
to UINT_MAX, causing an out-of-bounds read.

Add an early return when len is 0.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/clients/drm_log.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
index e3e02c84a4cf..294b3be1a6b3 100644
--- a/drivers/gpu/drm/clients/drm_log.c
+++ b/drivers/gpu/drm/clients/drm_log.c
@@ -162,6 +162,9 @@ static void drm_log_draw_kmsg_record(struct drm_log_scanout *scanout,
 {
 	u32 prefix_len = 0;
 
+	if (!len)
+		return;
+
 	if (len > TS_PREFIX_LEN && s[0] == '[' && s[6] == '.' && s[TS_PREFIX_LEN] == ']')
 		prefix_len = TS_PREFIX_LEN + 1;
 
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

