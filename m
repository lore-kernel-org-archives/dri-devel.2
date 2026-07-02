Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E301EC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABC0210F4F9;
	Thu,  2 Jul 2026 16:41:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="o23mEZ88";
	dkim-atps=neutral
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D96610F4F9
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 16:41:20 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id
 5614622812f47-48f0e5e6698so1267226b6e.1
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 09:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783010479; x=1783615279; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NxiUl+/bAdRLvWtuMhB2y4s8JQp74XEt9Vmqk681vy8=;
 b=o23mEZ88XJUuLcHoP+MVEjS6swCMUR24DfSj3ZG71ZdDm1TJ2TjaRDvi5JuZtMfKeR
 E1rGKBp8SSb/BdeopNlBJNpobVE67auKYscHUswL2nD5jat8J25vdwfuE+bvztXEXt7V
 i5pyxxObyFD7/O47utvh9Xp6Mo+C1FrmUeJFRavUZ8kUhxxS/gyaFtAdokl1MmSN2nN4
 r2yz/1Ubi0TfQ0afCNve4RLLTzNIbRqb2pHB89KPmc6v5piurC9ta+eYTy/vtM5ivCO8
 BkKPyfGg2lstMnmMHzmZyhqqqHD7V0rWG6/N8pmGk4pGyPXBDq9FJaKidZN7PNA0CPpk
 NN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783010479; x=1783615279;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NxiUl+/bAdRLvWtuMhB2y4s8JQp74XEt9Vmqk681vy8=;
 b=U1BcBQy11WfdpS0CNFzMTEJT6FF1CAqdpmqPm/m+UgkmmOMh3yl6vLR3sumlkZfPyt
 QaEEkVZbOyZr5QE4F1IaEiIhKYPw+uoVAMxkE461HMZiHnJvSkaKpcAXuEF3O8v9Ow6e
 8DKKyk6WM4gU//mftJ4INfpbf10QlrCneHI6fdrjd72Cz6yTqCSDAh3FpvcqDkONRT8b
 VxaD6lCEgNnc3dqKX+4FKcIns1hlDsCJFDYe1M0PJR/v3YuCj4p6XhSONjNw3axY1ehn
 Eou54wrC4sExlHT7s/n2/RLCThS9St1Qu+tZzYZwwWFr8bgpt9MVHnyzpxibv6tgJz43
 h2Yw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Ky3kGPMlmFNyLtfAQoo+jFf1KJARj9KYgM6TooxxIVGrmBSdbxEIW7QLykSLURwqu891L1B1EtsM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywp3D4uVLUFi1Sh/i6VYFcCRU3P8eHb7Q5RS6aj2Tjf1GXecvOx
 xj5DT7Eq7nuGFDiaqmxgonfnWsUQKw1lV936GZSfFGRck7m6Gb8+bQZO
X-Gm-Gg: AfdE7cnW9IV7WCVLz4XhabBTLhB1Q11wXfV3QErxxNAPs0vG5oXvDqkMe6paG2Qpu9I
 tgioy44rM1dsTRYZgisx9xOFSZSTAysc5VBBpUFr/OxqYuX7fIV6MW7x5LMhqYM7Otltm5p/I59
 SZRrwdabydUFwZ7HzxANNsgI6zOjHD3SoUg5qf2vzkVfceQRlXO1UHqbRR5oUaodkVp9+zUDOf0
 lxSG2FWHeOQvfqjeTZ3iELxbLNWEGIZDrsPY/IdUjbojxFdARQ0WVp++0ETYcdQmVgdI8kYRVI0
 ZkbPVBwN8IkqAyMFofSlmXFRYvwE1A9Zxknh5el/GAlBbF6umuGyrVQERlcGDJ1icmoRHIL9DKT
 81YehS+yWnRWOPfoP+1elRQ7nxKEUSz767+BYNRjjPMoajmEBAe+p7H5ADHp++nbTcxlWFMueAi
 qUmFWVxGLqEb72R8+CsReLwZFhDbA9j1DGO1wYo1L4tnz8n08Vh6Sw1SG/SEqWSA==
X-Received: by 2002:a05:6808:6559:b0:496:1009:ec5a with SMTP id
 5614622812f47-4961009eecbmr3729241b6e.1.1783010479414; 
 Thu, 02 Jul 2026 09:41:19 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net.
 [98.38.17.99]) by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 09:41:18 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:40:55 -0600
Subject: [PATCH v5 03/18] dyndbg: reword "class unknown," to "class:_UNKNOWN_"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-3-24f22b052bf2@gmail.com>
References: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
In-Reply-To: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=1363;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=VSikVomK4BH1ns73BMbLgc83yqlpizqOwQQtNSd/MAc=;
 b=f0lvV79do3jHCXCXSsYbRpRtarC9mgVSKkhulER6lRcGhcvk+QN8AmvDyyE0Yrb439HzJKCM9
 5692WESkvotCUwwymrnmi79GE4b/yzm8Zs7jmAni+A9AaI16Dt2MWCi
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
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

When a dyndbg classname is unknown to a kernel module, the callsite is
un-addressable via >control queries, and therefore uncontrollable.

The control-file displays this condition as "class unknown,"
currently.  That spelling is sub-optimal/too-generic, so change it to
"class:_UNKNOWN_" to loudly announce the erroneous situation, and to
make it uniquely greppable.

NB: while this might be seen as a user-visible change, this shouldn't
disqualify the change:

a- it reports a classmap coding error condition, which should be
   detected in (or before) review.
b- SHOUTING the error makes it more visible, uniquely greppable.
c- the classmap feature is marked BROKEN for its only current user.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 577a07916072..a86e1d5845e6 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1170,7 +1170,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_putc(m, '\n');
 

-- 
2.54.0

