Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B05606A326
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 04:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iNuRq96S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0F7A10E472;
	Thu, 19 Nov 2026 04:39:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E5FE10E472
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 04:39:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B0B3640323;
 Thu, 19 Nov 2026 04:39:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795063159;
 b=XQjlxMzS8p+LfUg70EcsZ+TgB/ibkpHtSd+HL67t6iKQysMRc2RLW4JCG3xbX4DvonIQ
 08rYhgWDvbZeQ09X4s9k2zl4XaqjeXjAu6Yytiy1rFi4QzyuwF4u2l1KMtqNWjRLbT00y
 yDdkn/y0ThstrLg2s6ckEoJ+xTzx4NL1uSR1vvkuPWMFUd52B5w001yW45w1YtoXJL5iz
 pSEJRAB2fj5qOBZO6F1DJuk3Nzz0t9cMyzxoPaVOOXOPs5Yx95pPf+/ihMjsVs7NTUb2P
 fPmBqCiSk2T1no3+N+fPdT6GJEWipamQOpO7zPc/NzW7+IIYTeXZhOQy9Cqll861tgQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795063159;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=jNlk8Yv4KEgD4czq1miN3C8LXX9JkOAFkE0qaTQnqIU=;
 b=Ll1LdVmjI3Pqdg3y0QZUteZ5Wgm9j0PO3JM6sMW01Gn84bCQeYc7sIowf/Wcy09Kdr9V
 wdwqQqAv4WWKWSKTwIBRHZ5YskSSYB75CGXyVyzSiCEwSnY60n28M3UV7Vb8rlqlYmyYy
 gP5/kywTZXutT9feZBb6OXGnM23miEyQdwMw3/ukMhTP1/d7Kz9Mo42lsBvwsrk73AfIe
 N6ZXpgInXrwJigxr9He0avf4sN1d+MM6ir9MtdqarcXR/J+8o0Kkp74CuzWdSSPEo2uNs
 ecSEkMy+YERIrkL5eVU+s9F2p94ahfR2nUL9tgePGYOhfeAl5HcDKXNd3lWbj0t18tg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 219811F000C4;
 Thu, 19 Nov 2026 04:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795063159;
 bh=jNlk8Yv4KEgD4czq1miN3C8LXX9JkOAFkE0qaTQnqIU=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=iNuRq96Sn4w5r7IcfIpG5P1m0c57lwEQfrY7kOiHpr9ClnwDdC7TzmL98FVlWHl09
 pPCicozRVkUHwbfBg8qoDpAhiv/CR/zIMG2uLOUkRiVuOryTLKzq1UKW3eqg8nPIVq
 ZjQQ1yCFhc+7emnIDtaYIkRl0twssNU3SlGFpjbZORjCEe+rR2sb25SlK+9UzD1yoV
 pK7lmj9Zf6p5pyvQCgTbzkPLw5HaLDdztzMcpXGyboYf0IwKwMqFx5oev+bc7hA//e
 ecyRYsdioHNWi7gWh0iqi8MPe6p5NSxZ/pdAC+eNeqkNG3g2LzPw+MtJo2TOLdbywf
 y3i+NDbsegDVg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 778014B0CE;
 Thu, 19 Nov 2026 04:39:18 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 19 Nov 2026 04:39:18 +0000
Subject: [PATCH v3] drm/debugfs: Accept "reset" with a trailing newline in
 edid_override
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261119-drm-debugfs-edid-reset-v3-1-1cc341d0cf41@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBQFf4V0bU0fyMOV/2FctL0XqBEwLTQaw
 r/bYkzYuJzknJmFeHQWPTlnC3EYrLfjEEEeMmI6NbRILUQmgomCc84ouJ4C6rltPEWwQB16nCg
 7sVwJZooSOInnp8PGvjbx9fZlP+s7minZ0qKzfhrdeysHnna/iPgXCZxymhvgNVTSgBCXtlf2c
 TRjT1IkiL1G/tWIqGFlLWvUWKpK7zXrun4AFLYJyxUBAAA=
X-Change-ID: 20261110-drm-debugfs-edid-reset-0504a20c67d1
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795063158; l=1693;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=jlIJ52+T1x1z/bjrNl0cApVxb+LOrNW+ryJUXQMv/oM=;
 b=4ti2yccUOKqN89evQXTvQl+hFL7Z6TC71awA6+sDSvoKGcdikTS3/JkJ2MCuikEERP8bEOMzm
 x21MmiwNOf6BpGOz01QBYD8jthQ7e4lyL/8AsvpLmXc588cHREp/PVe
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

Writing "reset" to edid_override removes the override only for exactly
those five bytes, so "echo reset > edid_override" fails with -EINVAL.

Compare with sysfs_streq() on a NUL-terminated copy.

Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Tested on an Orange Pi 5 (7.3-based kernel with KASAN) on its DP
connector: setting and reading back the EDID, both reset forms, and
malformed and oversized writes (rejected, override unchanged).

Developed with Claude (Anthropic), which wrote the code and the commit
message. I reviewed every change.
---
Changes in v3:
- Drop the unrelated length check (Jani Nikula)
- Link to v2: https://patch.msgid.link/20261113-drm-debugfs-edid-reset-v2-1-07939ebe7a8b@gmail.com
---
 drivers/gpu/drm/drm_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index a72f9723d3a9..77b22730d091 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -565,11 +565,11 @@ static ssize_t edid_write(struct file *file, const char __user *ubuf,
 	char *buf;
 	int ret;
 
-	buf = memdup_user(ubuf, len);
+	buf = memdup_user_nul(ubuf, len);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
-	if (len == 5 && !strncmp(buf, "reset", 5))
+	if (sysfs_streq(buf, "reset"))
 		ret = drm_edid_override_reset(connector);
 	else
 		ret = drm_edid_override_set(connector, buf, len);

---
base-commit: 467ac0b56aebc804360f276feffbc9032c265a6e
change-id: 20261110-drm-debugfs-edid-reset-0504a20c67d1

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


