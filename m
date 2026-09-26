Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B23C98328
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 13:17:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABE4F10E33A;
	Sat, 26 Sep 2026 13:17:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FkFakfgs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B83B010E330
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 13:17:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A043843719;
 Sat, 26 Sep 2026 13:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A741F000FF;
 Sat, 26 Sep 2026 13:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790428650;
 bh=xesDfc46FjdNUrU03GdS54iNMypHI7NDbKh/2TBUW74=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=FkFakfgsvGbAMFpaecTmNi/oJXdPobPulgg2tzounnp7pqkdl7IpeEB9aPkI8FK0s
 10nTUMD5w3LnR4Fv4EjHYzMvgTwomLBUQMN0r9w7Uei5WJoUVT4ck6jLvT66MmGpuC
 OoNKr4kzEPK1TPYvSi16t/1enSyfI8f6+VUdQz65MKtnqUrK+o7LzHkeZDZHEY1XZT
 KnNwGmlVX3y4HgXONWbfopYV1z8r4CLTw8IO8cjI/L4GR9fwWBKYCKNAnhgB271JC7
 b5cqK9Gy5HD6kHzxBZqTmSyhjF+IxKyd14cS6KVRBpCFv8g4qELPBJ1+Onec+vs4zr
 DhJPS8hMbNNoQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sat, 26 Sep 2026 14:17:02 +0100
Subject: [PATCH 4/6] fbdev: udlfb: check for fb_deferred_io_init() error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-fix-fbdefio-error-handling-v1-4-a94810b6e263@kernel.org>
References: <20260926-fix-fbdefio-error-handling-v1-0-a94810b6e263@kernel.org>
In-Reply-To: <20260926-fix-fbdefio-error-handling-v1-0-a94810b6e263@kernel.org>
To: Helge Deller <deller@gmx.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Bernie Thompson <bernie@plugable.com>, Greg Kroah-Hartman <gregkh@suse.de>, 
 Steve Glendinning <steve.glendinning@shawell.net>, 
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 Steve Glendinning <steve.glendinning@smsc.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2151; i=ljs@kernel.org;
 h=from:subject:message-id; bh=E90q+qqT5/p0VmzcsN+cuUAfl/rwqMLv9if4aPGwJno=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK2H72yvmhDr+rPHrmL9+elMPha//5aHfa1T8bnGMP1+
 ZN+796f1VHKwiDGxSArpsjy/Iv4/iCRsHmdF/zdYOawMoEMYeDiFICJzFJhZFh25+xsY9tdX5wr
 GXhXHcgKPLrPPsRwz39hxoX62/7OCj/K8Ff0r/bj7tOzdm64b3KoeXbA0QM5C2KM2l4cME57GSm
 rYMsDAA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14
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

fb_deferred_io_init() allocates deferred I/O state, populating
info->fbdefio_state, or leaving it NULL if an error occurs.

Currently dlfb_ops_open() ignores its return value.

Therefore if an error arises in fb_deferred_io_init() (for instance, due to
an allocation failure) info->fbdefio_state is left NULL.

fb_open() will then dereference a NULL pointer (calling
fb_deferred_io_open()) as soon as dlfb_ops_open() returns.

Additionally, if the allocation of info->fbdefio itself fails,
dlfb_ops_open() sets info->fbdefio to NULL and invokes
fb_deferred_io_init() regardless, hitting BUG_ON(!fbdefio).

Fix this by only invoking fb_deferred_io_init() if the allocation
succeeded, and checking for the error.

The driver already supports operating without deferred I/O, so in either
case fall back to that by setting info->fbdefio to NULL.

The ignored return value was introduced in commit 56c134f7f1b5 ("fbdev:
Track deferred-I/O pages in pageref struct").

However, the BUG_ON() issue originates from the earlier
commit 5bea1fbf9423 ("staging: udlfb: fix incorrect fb_defio
implementation for multiple framebuffers"), so target that for the fix.

Fixes: 5bea1fbf9423 ("staging: udlfb: fix incorrect fb_defio implementation for multiple framebuffers")
Cc: <stable@vger.kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 drivers/video/fbdev/udlfb.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index e78d6f95c9c5..5fbad9355e57 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -947,10 +947,13 @@ static int dlfb_ops_open(struct fb_info *info, int user)
 			fbdefio->delay = DL_DEFIO_WRITE_DELAY;
 			fbdefio->sort_pagereflist = true;
 			fbdefio->deferred_io = dlfb_dpy_deferred_io;
-		}
 
-		info->fbdefio = fbdefio;
-		fb_deferred_io_init(info);
+			info->fbdefio = fbdefio;
+			if (fb_deferred_io_init(info)) {
+				kfree(fbdefio);
+				info->fbdefio = NULL;
+			}
+		}
 	}
 
 	dev_dbg(info->dev, "open, user=%d fb_info=%p count=%d\n",

-- 
2.55.0

