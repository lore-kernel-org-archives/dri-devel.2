Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1C7606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 23:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BTJJYr8o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CC19112014;
	Wed, 25 Nov 2026 23:26:55 +0000 (UTC)
Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 762B511200E
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 23:26:44 +0000 (UTC)
Received: by mail-oo2-f5.google.com with SMTP id
 46e09a7af769-862a1dbb516so1149307a34.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795649203; x=1796254003; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6h7kwsZNiIakcDOBteqgCk42cVXx+EQMyY+qUW44Ixg=;
 b=BTJJYr8oIjNc04srcBA/cgamA8n7xYKEyAtczJnyYpN8IOUcHA8QvuK8OacgnqV+do
 RDGreWRnRpYe1OvFs7zEeO8Kgo+j7fBkUAWRhSTWoTCTZRylrNOWJAb3gcuXgP+yadHD
 TC1oca2H4fZI4CFpwN8zTfTDzTq5bJrV9zdTBI/Hpc2uhN5ZwBusACieW6h9UQMXcQf+
 aBDxWr6hlKfEtC3Amcn0NAzrTjyRoc7pk4W4eG0PWaTfT4IZIEUK8ZGZ2Z25lHNy+FGX
 gxzejvZWaHC/XLC9yfoIvCA7rFAX3m65vhJZ5uA9oIiOd/P44vK4FuMxstPTorSHQgT+
 Agdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795649203; x=1796254003;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6h7kwsZNiIakcDOBteqgCk42cVXx+EQMyY+qUW44Ixg=;
 b=wH5/SAdeVKzBaHRJ24KvJR5LGY3Hi8h3xfl3Jc7OxiSK7kwhH2tZfFqaItB91SPL72
 251XkYLQXwt59SJqpRdlcZGr/qt6mfHW4kVjTFl8YJyk35KBeExvitO7jr37pYCFJnw2
 CGcAT6g6meqrGlrgjANDcomEsX6wLKeyddJEZgtOPZKzHUTDDheXOI1Qqd1LUk/WiAWR
 uxVLA/rEGHOrjCw07xxOc+MiVd1BZ9TGMeZ/d3XGv0fDERgOE1gS8/hqzclMQk3egMye
 p6ajARaM+Au+J1pWGPah8vEeArYkmP1WcVeqzBsfnNIcRxTiWKtYv1Wjq63DZ8G5j4W3
 Al1w==
X-Forwarded-Encrypted: i=1;
 AL+hErE1eBHLfpkfp0netT6kt7pfqfrfgka3ROKIo879K2FQkMQ1uZ0HXbiwTyimNxYJm4nN+ELj6+HIs5M=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+AWr2F/6G+UY6vnESm5cYojgNsc1oNDvl29slHchdrd1XWOeaz
 1BqHNYQrf7d1s7ri/4i2QA56Lml41GZ5Nk82FaOaLc7iaOMgxRGY99x8
X-Gm-Gg: AZFdTZcgtJbzjWukBAr/HvxnC/2putP2a+GaJQ5PQqRA0XMLH3cDlRnYeEFBqI45ygt
 s7x2yK/zhQGB5l6X0IBs2ZqM0mn0VOVCUln4xvq0DNhhLxR+8dhM5OD1dtpqNOEUPQQUCZSDnfU
 RXeOIoOl3rPGdcFeON3C5IGGrPVK55yQF66wMxKpY51byXC6GzslKjfJIjGaUydAllDrC7mzckI
 SF5rpcLpdvznEoBn11aRR4CEWeHCCYL17ARnDg96uTe/jJnjg7iJ1r7tgt2isCqcZjG2BcESJhf
 95sOxX/wddsnbbykdkyTteKOvHIDXXn1z9t/TdYv/IqAHf8Ky57iHMz0xRJ1JavdEH4VzsDIQ+g
 d+f3uAvCsRdnc/E+AnUJ+ThEahx0BJkbnGBCaqq+V5zlZE/myPGZO8yMt2EGXSEYgYE2QgIzjFn
 w5mFLTZ7/YBNJ5qYrABD5LJnPn1IpR3X6qSLHaNuZ8+0HqOsXVxodrSMcQLIACOCI10KfjhzYcg
 81982WZDWDYweC20GqlOxpglNkHf48Wdzzc3C2iKJxCmKiLcCa4ICAc6lOkELPtacEsoZtl4S4P
 HDbNubSyqxSmPbtI5a5xjADKRl8FRLoa94o=
X-Received: by 2002:a05:6830:310d:b0:83f:f24d:fe19 with SMTP id
 46e09a7af769-863151bafcamr28010483a34.3.1795649203395; 
 Wed, 25 Nov 2026 15:26:43 -0800 (PST)
Received: from [192.168.0.98] ([50.26.120.197])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8631692f049sm14304892a34.25.2026.11.25.15.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 15:26:42 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Wed, 25 Nov 2026 17:26:06 -0600
Subject: [PATCH 1/2] drm/imagination: Report firmware page faults
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-rbrue-suez-pvr-reset-recovery-v1-1-2cea8b163e7e@gmail.com>
References: <20261125-rbrue-suez-pvr-reset-recovery-v1-0-2cea8b163e7e@gmail.com>
In-Reply-To: <20261125-rbrue-suez-pvr-reset-recovery-v1-0-2cea8b163e7e@gmail.com>
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Donald Robson <donald.robson@imgtec.com>, 
 Sarah Walker <sarah.walker@imgtec.com>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795649198; l=1161;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=0immpeEVfo1V2B9tlmsJ5GtsVBowBS1U3ikCLcI8PL8=;
 b=VxmzF7BQwsqcVZ+C2zOAWyW7mWer5SCFRdV+aW4tFsuXDHQHHURY7JLUxsHbLkW6L7d1zPeZS
 dmX18LpCAF6AydZWUlqXqDAxXO/qGDUfztNAHSS8d0RR+sQdtNLRLuO
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The firmware tells the host about a page fault of its own with
ROGUE_FWIF_FWCCB_CMD_CONTEXT_FW_PF_NOTIFICATION. The driver has no case
for it, so it logs "Received unknown FWCCB command (type=112)" and
drops the faulting address.

Log the address as an error.

Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 drivers/gpu/drm/imagination/pvr_ccb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/imagination/pvr_ccb.c b/drivers/gpu/drm/imagination/pvr_ccb.c
index 7043b491fe54..0a4d338ca47e 100644
--- a/drivers/gpu/drm/imagination/pvr_ccb.c
+++ b/drivers/gpu/drm/imagination/pvr_ccb.c
@@ -167,6 +167,11 @@ process_fwccb_command(struct pvr_device *pvr_dev, struct rogue_fwif_fwccb_cmd *c
 						    &cmd->cmd_data.cmd_context_reset_notification);
 		break;
 
+	case ROGUE_FWIF_FWCCB_CMD_CONTEXT_FW_PF_NOTIFICATION:
+		drm_err_ratelimited(drm_dev, "Firmware page fault at address 0x%llx\n",
+				    cmd->cmd_data.cmd_fw_pagefault.fw_fault_addr);
+		break;
+
 	default:
 		drm_info(drm_dev, "Received unknown FWCCB command (type=%d)\n",
 			 cmd->cmd_type & ~ROGUE_CMD_MAGIC_DWORD_MASK);

-- 
2.56.1

