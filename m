Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49533CDE012
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1BDE10F480;
	Fri, 26 Jun 2026 07:53:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OkLP4cPe";
	dkim-atps=neutral
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 398BB10E1C2
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 08:57:26 +0000 (UTC)
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-662b76dabfcso2187318d50.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 01:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782377845; x=1782982645; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YCYjeG3UoXuLJvf4tB6q96AYo9bWZwxnIXnqLkpJp/o=;
 b=OkLP4cPegPrJHK+6lb3DAAD+ppY9inv2ExcwoXplD1vGSkJBDfXQmu5psVL80K+rJu
 i53iqHq3hF5h8Z0igdfrgll88Q21tUx9HuMnUI1b54VgZvjPvq3H9ZoosHUKYt526TuZ
 Ei7eq486Ig3Ygz93vNJl3fnXsY8hiXczpy5ZPGcvXVNTffjq0WcVDAtE3m1khUIY44/S
 99BDseuYJZlDiATZKmDmCILwiuqXuOyAIBCvzbOoDCILwPWGJzyO9ZWUdyEzajpmW8w1
 KryFCWjhjLwo/NZXB7bCOOjtZam9tAit4MsotfrjdLABmRqj2U5u1leArU0HkH3RzkfN
 9MFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782377845; x=1782982645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YCYjeG3UoXuLJvf4tB6q96AYo9bWZwxnIXnqLkpJp/o=;
 b=j6DjQEMRaGO3rDF6DrQFL94TLt7kw8eYapalJRG7OWWnp4PgdteKJlcc1pPfmDtMRL
 p5OX2bswodMPWE7rnwkk1BNYV4nTU229tf7eD5Kk5cStuZjBQowWNbzV0ExTE7loWfEC
 9C0aGML6TD9g4GNf/39VFSfwA1RTwdAzkwhLPwwOxvAgopdbmVccmWi9gfyo5xq0pTeF
 51tXKli/jCYZIxWEQfyq7VOx6aFOhN9zscRKXZjuxckApgJIiYv/iivoejIApgMrIfBJ
 50rik0ntCtfHp6FKLUaFwOYUd32E+aqdmi9gboAgZWpVbnVsKLXhV0cXiY6MM6AR1Z++
 oaaw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr72RU+BLkBzX2ltxUsHP8f/eB67Djvib+sQgs5oA6Nm7kSMHKZehhWT+XipLpcrbbPFWfgWoi32IY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YweMjGmBroWKBSIo6kiVoajOWURsOZLJV/rZ+r9lf/TnNGq8rrg
 zRdzlIlBclTsF3I4ennGaeOrb6eksJsxllzAKHzFnIX25hWKuDVwoFlQ
X-Gm-Gg: AfdE7cli6A3fK3RBukyiqPPvqUC1hrro4RqXRq6bELe5vaqzC/9z9XzX7OIVNFQogJ1
 SE8EaTuGDfIaaySQ7321mkz3px01aVb6GOA31BP2MVSDyKuwaoZuOAeGcivHWqfnYmQ0pAEsHev
 bgzZpXkw08Rw0Mg2bioj2/4nx7UCEjXDr1eV2SMG5Aw9OhXXzEzV/uFbYLmvY4LCPBOkFfbo1+C
 caRHD0W83A42pApqVwy8NboJ2xMXNlw5496JRZFVirFiTVIULaRIyqnpiPt1vsnCIZUtKLWlFT1
 RvHyJG/6u9nYsk6Kj5gIPJ2mLTq2OZEF1Wk15W2/AITKcoLJz1A61XHmZQ0M1apegZvPwOWbuHt
 7Qd9XuANtZf/iELbPQ2PZndwc0Cr+JJVSvCyBQ75QnLDuovkv0chnR4zXGqOwnp49JPoKnPQPAu
 I7+pi+5QeycIpsXS5EUBqNi04ipoqlBbVOjKRo
X-Received: by 2002:a53:ac9b:0:b0:660:5a7b:9d7f with SMTP id
 956f58d0204a3-66487c7810amr1149739d50.15.1782377845163; 
 Thu, 25 Jun 2026 01:57:25 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6647f785f6bsm1105061d50.6.2026.06.25.01.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 01:57:24 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 2/3] misc: fastrpc: fix map cleanup paths
Date: Thu, 25 Jun 2026 10:56:58 +0200
Message-ID: <20260625085659.4469-2-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625085659.4469-1-alhouseenyousef@gmail.com>
References: <20260625085659.4469-1-alhouseenyousef@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

fastrpc_create_maps() can attach dma-bufs for every scalar argument,
including handle arguments beyond the input and output buffer count.
fastrpc_context_free() only dropped references up to nbufs, leaving
handle maps attached after invoke cleanup.

fastrpc_map_attach() also falls through to fastrpc_map_put() after
manually detaching and putting the dma-buf on late errors. Leave the map
object in a state that matches the resources still owned by the release
path so the attachment and dma-buf are not released twice.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/misc/fastrpc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 8992b5c0c..50f90e17e 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -580,7 +580,7 @@ static void fastrpc_context_free(struct kref *ref)
 	cctx = ctx->cctx;
 	fl = ctx->fl;
 
-	for (i = 0; i < ctx->nbufs; i++)
+	for (i = 0; i < ctx->nscalars; i++)
 		fastrpc_map_put(ctx->maps[i]);
 
 	if (ctx->buf)
@@ -917,7 +917,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 	table = dma_buf_map_attachment_unlocked(map->attach, DMA_BIDIRECTIONAL);
 	if (IS_ERR(table)) {
 		err = PTR_ERR(table);
-		goto map_err;
+		goto detach_err;
 	}
 	map->table = table;
 
@@ -966,9 +966,15 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 	return 0;
 
 map_err:
+	dma_buf_unmap_attachment_unlocked(map->attach, map->table,
+					  DMA_BIDIRECTIONAL);
+	map->table = NULL;
+detach_err:
 	dma_buf_detach(map->buf, map->attach);
+	map->attach = NULL;
 attach_err:
 	dma_buf_put(map->buf);
+	map->buf = NULL;
 get_err:
 	fastrpc_map_put(map);
 
-- 
2.54.0

