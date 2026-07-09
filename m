Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CE7C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77AC310F40A;
	Thu,  9 Jul 2026 07:26:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sN0ZmdrL";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A4DF10F38C
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:23:03 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-8484a0b998fso1441085b3a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 23:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783578183; x=1784182983; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4ntJpwww9AG144NhiF2fIApoT06Qh+39umHvBh4GnFU=;
 b=sN0ZmdrLs3/C/uWYawWBCuN2EApBrVtqBQSI+oQiS3dVSQ8fg/gKIRljPtJ/8TH+RJ
 2A0DGMprtSpQLtLVPfCCUoi+OojhsUS0jdXuJOTn6DEcfW2J5jiTo+I1S/ADdje8r3QK
 ra6Nspkr3yygxaOwU0zaMg1ip6aBEF8iSyw0XoVw7o2IYk+7yGYeeNWRcGdbdDtaOL+u
 WXHua97QZsBaSxDEKHZVHhqrLY7cNElc5wFLNragC6gK17czYukyUZWRt1zG5AsJmar+
 QWd0qRWWEBr6eB65pBENqeAOAaJ+Ozt3PqlCnu2sP7dkgqPWTFYPLk2tDsSHOfufIL8B
 Ukxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783578183; x=1784182983;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4ntJpwww9AG144NhiF2fIApoT06Qh+39umHvBh4GnFU=;
 b=saF4tLhSEXfpBxQ7sM896zj0ccc//yoUxCJp4l40bj7mM13VWMP9e3l16YrawBOrXN
 v6V9Z5msYy3TsZX+6i88iBxe5ikjN1tm0TMj1F8kAb+vp/S+klph9IkXIyVCp6l3YoW4
 Xxr7GBY48ZMxXVgWrfRQ23GdFg0Qma3bmcDa9kGMFg48m0rXF5AGE8doXZhWmDqVLFM4
 q6n66qsc9Z6vmYHFyPYvQ8nXxdYJPM1z7q7t92o5PqSoWu9U23v0d9PgOHk3PzV5LawP
 ByGg9NW0EPa2Kp6fu0ohgKX6TzBYrEOH3F3v1dIpDL9ACh01bNWnlxBqRKNP1uofmv9k
 tTcw==
X-Gm-Message-State: AOJu0YyviZxIXH6hui6aDnifod6+eSlWfY3X75RmUWtOYkt0lJFkYtlH
 dbwCLMF1MCQSVoHKtdEKgokYNdMt0JoUm39d+xqiPMfWsdG0GG8Ar2x8
X-Gm-Gg: AfdE7ck7vVW849V2LTyY+mlREuOLPtuoaO6A+GCkdpfzSTNZ9zc1U1OsVtajTzrL+dk
 esd3WYEShAEeNYcxtQvMSXTVoMkpLRqSVUC1AnMZWzVqRRB9+iDUSjSHEHjj5T8YTRYSvgqX4NI
 TjHJHOSh3wZVDlWCCFartueUdSPGu4v8pcChzUXNpfh+MbTWs3OYch/w8ZmbL3dx7JzmLCW6QGs
 RG+zqeEvgxiBm4tq5fMiWQ42/rtNoS70Hztn9aX9lG9O4w6yFuGX7tO/6eOYxQEjUd/9cFdDAcd
 0Ma09EudbfiFUjAPAel5vkQr61AQRwSEZn7Xil5GqEkxC0p3xEKknkskH7/ufXanAR2NxqTwt7E
 6JvE+zfwPtyLBsE1wGnwyMLLxx46mxel2lTRSdyT277EwE50KDBroc38B1qoxwzoVIuwgZAqdnC
 FSJm8xdpLweMIbHWGPJtG4BKeD55NG94lXtpy/7FTTZic=
X-Received: by 2002:a05:6a21:4591:b0:3bf:95f4:dad7 with SMTP id
 adf61e73a8af0-3c0bd1aba77mr6910775637.41.1783578182556; 
 Wed, 08 Jul 2026 23:23:02 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:ea9b:46f2:6d0c:46c7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5b3a2e42bsm3298012a12.30.2026.07.08.23.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 23:23:02 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: ogabbay@kernel.org,
	quic_jhugo@quicinc.com,
	joro@8bytes.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] accel/amdxdna: Clear mailbox channel after create failure
Date: Thu,  9 Jul 2026 14:22:56 +0800
Message-ID: <20260709062256.4166833-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:20 +0000
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

aie2_create_context() stores the allocated mailbox channel in
hwctx->priv->mbox_chann before starting the channel. If
xdna_mailbox_start_channel() fails, the error path frees the channel but
leaves the saved pointer intact.

A later context cleanup only checks whether hwctx->priv->mbox_chann is
NULL before stopping and freeing it. Leaving the freed channel pointer
there can therefore make cleanup operate on stale memory.

Clear hwctx->priv->mbox_chann after freeing the channel on the create
failure path so later cleanup sees that no mailbox channel is owned.

A static analysis checker reported the stale ownership state, and manual
source review confirmed the error path.

Fixes: d5b8b0347fa8 ("accel/amdxdna: Split mailbox channel create function")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/accel/amdxdna/aie2_message.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index c4b364801cc04..a22d025794598 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -277,6 +277,7 @@ int aie2_create_context(struct amdxdna_dev_hdl *ndev, struct amdxdna_hwctx *hwct
 
 free_channel:
 	xdna_mailbox_free_channel(hwctx->priv->mbox_chann);
+	hwctx->priv->mbox_chann = NULL;
 del_ctx_req:
 	aie2_destroy_context_req(ndev, hwctx->fw_ctx_id);
 	return ret;
-- 
2.51.0

