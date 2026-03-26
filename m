Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B1E10AB805
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24F4810EBC9;
	Thu, 26 Mar 2026 18:55:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k2rJ5HDF";
	dkim-atps=neutral
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com
 [209.85.160.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDB2910EB9B
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:54:45 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id
 586e51a60fabf-409de4132b5so816035fac.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551285; x=1775156085; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q0sBYQSvT/W3L1mc7F8xF1oVUSz9OX/m/AEikTG2UrU=;
 b=k2rJ5HDF1ha7PEtUWfC5Z8ZonvFK8KviMkOUsanftQekjClC9Dc6NUiftoY+Ei+BqK
 GvqEZTLwwglzDPGhVxvPM8x8dDCDRzGEbW/4h7xbp5oukTd96MaxzJD/xDyJNc2hJZDN
 B5ITDp/xrPoc77yLljW9UkgVl2GyCj5oOgJ9v+pdX3FbNposuIx4KvpXKGMhlU8UhlxZ
 EMxvI1abDiLlJBFy0W1jFDSMTSpvKr4aQCDOGYgo+z7C29yXpb0LAMt4IS/zvjzKu5Lc
 evccn8Q0uArQFHzSAgc8p5DeNhq7PzYzfYgrAwqcUqmEqjfN9uq34RGuIvQ1xx6VIFpN
 Wysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551285; x=1775156085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q0sBYQSvT/W3L1mc7F8xF1oVUSz9OX/m/AEikTG2UrU=;
 b=hD1qs0VCt9BlSfUvsCeW88poNzGGUTxJ+Wm63bD4LW5J2P548sL1BFYR8Wetm18BvZ
 /HhKDVlATp7vKM+AzSeflNa3T9fj3l8uy9X/A0BfpMmD+36GW1dag6beABdB03COMYtb
 2bc1Vu2/OzT8sov9IDuRvyIevnVGjXEB5CaOK2sg1xFCyJcJb2V+K/UBbMrfkITH4a9p
 ohRRogFWtSrjkT8cLFVvZ91kc7/3TkgROihtvZkL17DudUOE8dJoE6/06k3ygTiwAQ7b
 ShcL1hYFsVHPLL6b0JgBJ2zLojoY4Ig3tTgq91bI1v2Nd6rabldODOBJ8v97kYA9AS2Z
 bI0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsB4uDsIBwGX4dIRayQguZfhkJwIYCDeocaEItNDvL0gG7mNMS7oOvd5fsUZFtqXiF6zbBwSXT1Ag=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPh+ncGYVz/54+4pYYm6jvEyumPpBXOrZc+jfJ7rvWJs3k22Jz
 bXKGocQ2G79MYMJ30Lm9zOv+KZGOxrYxlPTMzKLMqEj4RBXwx2ve0PKp
X-Gm-Gg: ATEYQzxm9wN4QX/gcw8lXAgf98t7foITSvrVed2q19nt5WJgBG6o7KA7iuhOTs3eYGm
 X8E/4jZ1tI1vOTRl4SMYkYnuHbwTtO7sVPFn7JnBMoNbGgXVZJDLoqcLdqSgRcZ1sLwTjUy/LZI
 Zy8IncrN9hLW2LtBQFyG0AvWkiFFh8YdYCr60CT6XGvOaeLCuxmE2/clJdxadUmPbY2SERGvMwH
 FyIDKHPRLL4ABe+pFnfoFHL8oTMWaihICZprAsGbVFXF2a5hMjHW14salkhOsk2fGXWM7pwzbbB
 q/xrLw4fVSl8V1lmFylvL9Iqk0+uBGUbJ7+P9jLcxRTmkGGp72MxaJW9EVkOQaOcA0SRBx8QqSr
 GMCJmI3+t98L0wEJ/yDZ/K3Izge0rE2hX9MyiGfJPWmzGGNSOYx0CMC3PUzlLdSf2x+xNUS+4En
 wnE4YiW8eRWkTRaIaAXVJ0KqsVGq2AOyd0d2iU9Hka1vzc0Y9QRhoYZsyk6vc=
X-Received: by 2002:a05:6870:20c:b0:417:2156:ffea with SMTP id
 586e51a60fabf-41ca6fcb4f3mr4549318fac.13.1774551284964; 
 Thu, 26 Mar 2026 11:54:44 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:54:44 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jbaron@akamai.com, gregkh@linuxfoundation.org
Cc: jim.cromie@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v12 10/69] dyndbg: reword "class unknown,
 " to "class:_UNKNOWN_"
Date: Thu, 26 Mar 2026 12:53:14 -0600
Message-ID: <20260326185413.1205870-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326185413.1205870-1-jim.cromie@gmail.com>
References: <20260326185413.1205870-1-jim.cromie@gmail.com>
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

When a dyndbg classname is unknown to a kernel module (as before
previous patch), the callsite is un-addressable via >control queries.

The control-file displays this condition as "class unknown,"
currently.  That spelling is sub-optimal/too-generic, so change it to
"class:_UNKNOWN_" to loudly announce the erroneous situation, and to
make it uniquely greppable.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6b1e983cfedc..a9caf84ddb22 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1166,7 +1166,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_putc(m, '\n');
 
-- 
2.53.0

