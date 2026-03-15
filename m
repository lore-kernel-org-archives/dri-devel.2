Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C194F3027F
	for <dri-devel@archiver.kernel.org>; Sun, 15 Mar 2026 22:35:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD49D10E1BA;
	Sun, 15 Mar 2026 22:35:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ldKH9K/n";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 743CA10E219
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 22:35:00 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-439cd6b09f8so3133974f8f.3
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 15:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773614099; x=1774218899; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OpWnHUk+3SPsGecPBlRkfmE78MiNGD1gTyiflQvv2gI=;
 b=ldKH9K/nmEEOARuJtjrejUtdEx5wkxmREmlXlKYJVwvaxA4YdC6I9PSv5HDfSOPeF0
 va8OSkZRdt7qThNwNB+HbMFHTiwTxtM7m7lTW7dH++DkAgdW6jiucjigXuWdYcvEkxis
 D0laU3KyK2XeTn6PkfogQ0S5B5bX4aIW08jmr1XBUyxrZLnnc6iPPlWRoMRNvR/Oy26K
 6h6R34pl1WPGHgzpZ3YcSckEv85E7Fn0I/xLScqH2xdQZXCZq4SSTvHr65RvjrFUjZLp
 wDV7eJQr9smNXuxQ3kDXpGOIedd74qGhgOfuMqpfI/G2xoZZlVMQYWZG0PpnIaFbxfv6
 mKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773614099; x=1774218899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OpWnHUk+3SPsGecPBlRkfmE78MiNGD1gTyiflQvv2gI=;
 b=d7j5PmHjcw4Nk/MnIntNYC3qFVPt6MJV/qwB2C4UWWb46sTvHD1O7Q74qYOweZC/4+
 lsz8/+wZ+LYu6h7SEKb5Wj3NkXFDbq3vFjtmTnl7RlH1g5sxx6wJs/BKloYPbV24vytJ
 nY4sOmG1WpcrPmM9ycMKSY9d0Hi+wJd1iGjeJ8wAK1phJoIljLSnECZTc/aGUNGmO8CW
 izpgelPjgxVClb4QrvK+Etj/EOg9h3waaICbKiMTqvKgCCtm3gaS5brpudk0mdGpO8O5
 SlAe6f+cGwXH29yBvCOYeNXMDRb8oVCqe91XtKSd+jwOxHVb2SSC1fpTamyYc3rd+TOO
 hT4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYeFgRg7fBsyzC51na3pu3M4Fb1ayXJ4TfQmo4TlfGcz7Ye5ewQaVx5t9fUjDy7IgD4R5yVF/3yTk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXHsHd6YaXhX3kWxVVxhmtRgHsdMQQOxTL+/qVwLqiXw881dP1
 c9r0l1kSvJhjum5YUYQNrdRsbwNTuLqIV+rdtz5HLDQGaMoPCXAja1hK
X-Gm-Gg: ATEYQzxG+pORnlLVLjVt+yvQoddGN7Q1rDj5C0wkSazfaUihJC0hy9VhLuErxdECui8
 a+drcSvnMKZnQOCNKAKd1yZMudYwUmhEN5LOV94ZQpBcpCDvzGgwwHasG6ALJRLANdGfG4f5O1g
 UuHbGQxzsmQxp/DZjeNILrlyTf1Z0DCcsgV15/E6XaNUsHaoAMqxfZhPwZ8cuj07P3oOp0trmYK
 jDGX0vjmeYhbNOaCU3b2PbJ8vZiMQ7dlUw5koEUN2LAawWDijrxE4069jRtwLjOFL8eU/YVryv9
 Yh0dSJ2Iod7uytQBNRR3Sl7tMMEEjnFsfpJioqeTVh4w/pYBDVtnarWnnUv8tSokJl4nE6Zsh0A
 IHj49/QOkvTGhCKoPQgIdTiV5xctyjDwLlYa6ByWDGzwihk9192+wM17GhzU4mSBEQ5xwSQLNTb
 8HeEyzs4hhB2LV4JdS/MhSOCBbCCpNDYt6hcOMEPNdoQe1gXFLJ08TbXQMkxK2Iih5p8UrVpWPV
 en2XcNfBRbzlPqdecVs
X-Received: by 2002:a5d:5c89:0:b0:43b:45d1:f44f with SMTP id
 ffacd0b85a97d-43b45d1f733mr476847f8f.41.1773614098847; 
 Sun, 15 Mar 2026 15:34:58 -0700 (PDT)
Received: from localhost
 (p200300eba70b6e00ca7f54fffe019321.dip0.t-ipconnect.de.
 [2003:eb:a70b:6e00:ca7f:54ff:fe01:9321])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20c473sm38616488f8f.24.2026.03.15.15.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 15:34:58 -0700 (PDT)
From: =?UTF-8?q?Johannes=20W=C3=BCller?= <johanneswueller@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Johannes=20W=C3=BCller?= <johanneswueller@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/4] drm/amd: treat max_tmds_clock==0 as unconstrained
Date: Sun, 15 Mar 2026 23:33:05 +0100
Message-ID: <20260315223307.45807-4-johanneswueller@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260315223307.45807-1-johanneswueller@gmail.com>
References: <20260315223307.45807-1-johanneswueller@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

If max_tmds_clock is not specified by the EDID, it should be treated
as unconstrained rather than as a zero MHz limit, since it would cause
adjust_colour_depth_from_display_info() to reject all color depths
unconditionally.

Signed-off-by: Johannes Wüller <johanneswueller@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bc853f7555a9..82c8dc8dd39f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6612,7 +6612,8 @@ static bool adjust_colour_depth_from_display_info(
 			/* The above depths are the only ones valid for HDMI. */
 			return false;
 		}
-		if (normalized_clk <= info->max_tmds_clock) {
+		if (info->max_tmds_clock == 0 ||
+		    normalized_clk <= info->max_tmds_clock) {
 			timing_out->display_color_depth = depth;
 			return true;
 		}
-- 
2.53.0

