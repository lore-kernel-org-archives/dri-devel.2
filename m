Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F24105F7AC
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 13:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A373710EBEF;
	Fri, 13 Mar 2026 13:23:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nd/Pq6GT";
	dkim-atps=neutral
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62AE110EBF7
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 13:23:10 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-4673790ab85so1445105b6e.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408189; x=1774012989; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q0sBYQSvT/W3L1mc7F8xF1oVUSz9OX/m/AEikTG2UrU=;
 b=nd/Pq6GT3nGpTT+SwcRtjUEdQPnAKTWNE/CT6RIuMu974vq71a2L+kutdFp51duJaI
 ew2wY7xP83poJz+C2RAo1aQNVIaRZifelsnced5HP7ZmTWxVmln6S/qE1SeDZeHPiina
 /pybKCTDVCV9HmTeqp0IA4wy1Xxuizzb3C+Eo3VUDTcxfW8ReddsXeiBdiaj606ohT6y
 bBTxKmAJKpgP0Gj52vj4xZxwgtaMTH3R7RtZXDWNxWQ8YdjiT9DzwDpVxyIOEt4LlNwd
 YuZiU55aaIIhxaSCOdiP7aWWI7vdIkfaiuSopAjzOaGFJ0mNNZGAJPLOUTjTG7UzqL3c
 6QCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408189; x=1774012989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q0sBYQSvT/W3L1mc7F8xF1oVUSz9OX/m/AEikTG2UrU=;
 b=FutGJtrSPbc18CI45KvuMmCW0Ah1AZK7EAMQHS3/N1QI8a1zMUROcl+FYjrstfD2R5
 LuaQy9y3Xf/ZKYW6lUUYl7zIJGZ9aehDH0ClbtrSlmvFLEkRdXs7IIPQGvosWME2xbps
 wSZxNbnfEqj5rwJUOBa917DWGSoWl2ZPOprFD6N+eujR5n76ZCIOo3bpdDOL8fycvZkO
 OdXLPhCNhFOM2RMyBgcH4hbM7LzKKwlpafvKCSeu48aQSOB7p1VwZgeOuO8g2eLVcOO4
 FU0tAJmpZWHsE/+STkB4ZmIUgcB6sUc+j97ipeSsHvrcN5dsQprdQQHanBqzjlDX6/5L
 PAcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4vLdM9BoGI3UHsDy0ZovMYzRAj/UXUkf7QInUErt7kVJdBa7PK5FsdFXNR9SfDr83KpnZ1SWF7vc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAdBq4YbSpR6C5IHDsiikqe8ueg+FbX/NvbG0e8K9o2gCFLYAw
 1VHNWltyd4MFocJbMBKhADDwnRL8TCCzE/PbhNthoU6fX1rM8X9Ufrkw
X-Gm-Gg: ATEYQzyeVH23qBUDpK9nXGfe9p7cYhZQ+T3GGhgKd2/gd3xZEHU6mZ6GrCNVMRejuXz
 +z1ubo4T2cCOQs2ictQoVWk+kU29Coo16OUTxYhNOh7mu3N38NG5qqORWQKFojvzBJAkNyF4SVN
 vALfJSRDYKekTDkst/fIM4OkPZlw4TX5eI0KxSMHtKSYDP8YCbhh96a632OvwNCcxdpF1/1Ekkv
 AKEeCWPRBky4JDc4/rsaTblwa3MJv6+teOwZj3dNNLiSVPEaGdL5bP1V4ZFDIm9y7TClW+isIOa
 VzjRpsLFmACiCIQctPK4yry9U5cTb2D+v9n6Su7dccxyLLtlypmxVIJ4sKA6/p16BmM/m+Z0BkB
 AEs5B4QfIxSbd8ualJXI+zk2O1qR+yoqV3IwSt7ffTyruPb9rjJI4GF7vLwpsERxEBgD0A+Qz13
 SEdVzk9zxg0H+Yr3/Oj8hA/1sp9NHGhc6lb5/SS0xztGqibAsHM60kXnKvHgs=
X-Received: by 2002:a05:6808:4f49:b0:467:1941:1f18 with SMTP id
 5614622812f47-4675715ea52mr1607049b6e.14.1773408189500; 
 Fri, 13 Mar 2026 06:23:09 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:23:09 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: mripard@kernel.org, tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 07/65] dyndbg: reword "class unknown,
 " to "class:_UNKNOWN_"
Date: Fri, 13 Mar 2026 07:19:32 -0600
Message-ID: <20260313132103.2529746-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313132103.2529746-1-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
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

