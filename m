Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A9ECD5BDE
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 07:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 350FC10E74F;
	Wed, 27 May 2026 07:24:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LrX0k0e5";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D4F410E556
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 21:01:04 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-30246cfd41aso685633eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779829263; x=1780434063; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C2x6fxQ+tdvDCPGI0zQ3v4zt0ktfN5BxYIE2BnW2JnA=;
 b=LrX0k0e5D/So0PFaLL0O1uepznZ3hMNcm0WVEDWwhtOEsqIHVXQfeRcIA25FVMmKYN
 cwiItmQt5oOquAIKacFNtojHiDTejnat/x+OIwuv8sTpXu9ALpEKLXaNjf8qawp7+DIp
 8VZjonNG2Bh1yXqVHlEcC7gUS+xfey0FH0hVmTK3iZF2eOs+x73INouLNPZRAZulE7w+
 lDa3vMb9vzsgPto1U2z9qM9IpiHU67N1xPAA4NCBvEmPkJOhsVvsxxiE0G44/t88NYcX
 vjISUvvhObixsMqUc4Jev16Vs0UoQJVTV801GfrR8903RdAmm35laTxhmgzyG/uXPRiU
 DNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779829263; x=1780434063;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C2x6fxQ+tdvDCPGI0zQ3v4zt0ktfN5BxYIE2BnW2JnA=;
 b=V+KgM/dhg7KFY9jS513allySYRZtdr3/GRsuS0o6z4e5W00HnWbYbqzbpCG70v9v1/
 PPOrl3oUt5+9zoJowyAIHFqGG3x2CuakaAkGbQjQK3Dp+OcK6FnZitY2aYPyO+nLZnvc
 hNMJD37RJRlzN2ffgGoq12j8OYpPVSqDL6yIH6/beffkRlLEcKFyvxDedLz+tiOXYlq4
 xJP8whILnp27PCoruPYjC1n4XSPXn98Y3iB/B5xmcOlcoHmovTTwqVp+s1ZCjKvNqH7H
 N5SDEN7lHeQlqUMIK4W1Fh7f4qMHSg0ZMZ16LPL/Zb74pTxdyhszAaImMOk5c/jv6dWU
 d9nQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9LxdwrjNSgwLjzfDZhVShnWzJW07WY+/QFuLocZYNcyeFRCkszJ80a3VxDeITfGrkNxoF3AtKbENk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEuQF1sRDb6pxLdopjPfiXI6os7O/FAAmmhrlr9y+pPE5guR+S
 JH9A+v7HxeO0qtrH+oN5/t18SSTPazX2dPl+8+sjxvTMZk3YfA5fabvN
X-Gm-Gg: Acq92OHEQilT8jvktuJ9d8tLIGC7KJtFCOeq6VcDAWinePtZpeTm4mrxNPFd4LYkWL0
 axfju5vQsej/lbVjDpLlTz2ZrVe7FB4k+TWPVwbBa388ku65vwyXa5Y7BfJzPSBSpQahvUJcxDB
 IV6cuXsPcAWfAd4xi+IziPXaX7ocbmsaQZauhQdg040T7jslIL9/PpROhK83iQ8Ze74hUYkwSAs
 JVo7UVrQ8b/0sQlzG6fUsK3ISFY1zhA920hP486lx8E4KIo9agKvjpp79WLON2ETxG20EuNsOTd
 /I4J2TSmhSuEFbCqPPeffXZh4kKzTW/aAB18lNj0NpustssAJQ1YHPjdFpvuZK0XqgqikhF0Pqt
 ZxOyaByqQiqtMC/pxNbeQWPlP9SzBKGx5aHOPciDcOtepGbDpDok4CvqZICWTK1NQsZVb8y49wE
 ersna/IBV81iZns0MErAxyBbnisZ/RMPcViU1cHSBHW/Qjga0PYG8=
X-Received: by 2002:a05:7300:cd85:b0:2d9:ad46:4a92 with SMTP id
 5a478bee46e88-3044905ce1emr8171506eec.13.1779829263188; 
 Tue, 26 May 2026 14:01:03 -0700 (PDT)
Received: from localhost.localdomain ([187.17.229.0])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451ef3273sm15404389eec.2.2026.05.26.14.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 14:01:02 -0700 (PDT)
From: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
To: harry.wentland@amd.com
Cc: sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 mario.limonciello@amd.com, alex.hung@amd.com, Wayne.Lin@amd.com,
 timur.kristof@gmail.com, superm1@kernel.org, aurabindo.pillai@amd.com,
 ivan.lipski@amd.com, chen-yu.chen@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 edson.drosdeck@gmail.com
Subject: [PATCH] drm/amd/display: Avoid using zero AC/DC brightness levels
Date: Tue, 26 May 2026 18:00:48 -0300
Message-ID: <20260526210048.1162477-1-edson.drosdeck@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 27 May 2026 07:24:11 +0000
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

Some systems report zero AC/DC brightness levels during
backlight initialization, causing the panel brightness to
start at the minimum level on boot.

Only use the firmware brightness levels when both AC and DC
values are non-zero

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5fc5d5608506..f947ce2a8625 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5380,7 +5380,9 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	}
 
 	caps = &dm->backlight_caps[aconnector->bl_idx];
-	if (get_brightness_range(caps, &min, &max)) {
+	if (get_brightness_range(caps, &min, &max) &&
+	    caps->ac_level > 0 &&
+	    caps->dc_level > 0) {
 		if (power_supply_is_system_supplied() > 0)
 			props.brightness = DIV_ROUND_CLOSEST((max - min) * caps->ac_level, 100);
 		else
-- 
2.47.3

