Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1133AC88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 21:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3415810EA37;
	Sun, 13 Sep 2026 21:34:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fX/n5U6s";
	dkim-atps=neutral
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 708B010EA28
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:34:20 +0000 (UTC)
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-85469e25400so1008833b3a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 14:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789335260; x=1789940060; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eHfVEcK3sauaFk2XrUxZ5yLnrxF9PTr4AtCY8Hi4Vvk=;
 b=fX/n5U6semv5OZ65gSKtBT8IchP5gcdc/dI39Sln985Un/++pQdmacqCaVrHSP6iM2
 MpyJrNyycqGswL8Z2LNDoJ4ieJoXq0QcjroItNofcJpiQ8hJTcNunRJ7dTFMX8f8KwEq
 LJWW3++AIFxW++iQOoitaaq2aAqOUueytGBoa4JZmxy8OtXab2eW9bxD9D8PJqAmFAKF
 UbyBJegjaNXr9l9Tvga2r0U/FNavRCRQwRJpowSdQdX/ymAq0ltCji/265kNaDb7fk3q
 mwk2cDA6viptQCZIW+EkILSKhuD8x19PtyptgZvuSbiq83EnlUhoOreouK3ctsZQn2Pu
 9Nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789335260; x=1789940060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eHfVEcK3sauaFk2XrUxZ5yLnrxF9PTr4AtCY8Hi4Vvk=;
 b=oqm/f815ah2n2vdAMxvlk+ZmdMRtYkCgBdb4tm771czZIoagVfc3u7fpCzReBIfKm5
 ohJeuCaKVl5undo6q3i/jPhtubUWuzcuI7wH2aCE31/DfEQ9xujOi6q+museB6If++5M
 LA62K+NHMEF0vzIVhAytLWi4JTDUJOKgQejWV/qKyMG/UAvtxqTT6GdmPWcy7WiLQd6i
 qYYRtTtr/MpDFIGKLTVpCoOz+a78Bxm2xZmB1oWO730waFlMQ7IaSrqonGU887yq4CII
 aKB/9LRfBjg3s/SACyha3f7KUgP2DZIc4mA4UJd3RL9mE/zrWmw8OaOU0qN5hHWISqCF
 4LCg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz/U/3xbDsI0VS0yPV0j0B8GVy2aatqgUTwdEqPknYZlqjEd7KOoX3sfvLIWAtaG78NwCtst7RuL84=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mytU8R/v6PwFlapOsSyJNqulidHzsH0jtnXCrKKRgtKcOgPfYS
 uLoMHCLaD6HY5wkc6eQJjcCAsxMaw4cYQ009ElI4BNc2lgfqoUPLPkar
X-Gm-Gg: AYBFou09KWrnYBEXyuf4nnLcbIw340SSi6n3gd7IkqBAr9WeZGeFDy5ZTcLfpQfSbn0
 VxzZYe7eWEieMBwuVKI/XWXYaogayRDsJNgtkGX4KTER095d4nzy2pXbjXBgLSKZJfsZ60cOoN3
 DWHjrj7YETvT8I58zzpb0HGR0pCVeGj2XgBQLSAnQ0F0q4KZqmU+qhMtwlEGWxHIj+LmcQA41Yz
 8Yx2EWidVc6gczRFJCJxV3BYSfXIzpJ7Q2qXXATYo1lJebytdjoe6KHb+QoK1ku1jjHNjIvII6P
 DfEoexFSd4CHY+xsFeeW3misZJWL+lesolVjJvcG1c7KvEiuZLP/o+0pe4J+NxTs7vPLxWrOTBN
 aWQvDMtpkglcy9hgXzQ8wvMs7vYJD4hPkJgb6Nb38rgVgDnDWh/UhgB7/PYXlYw9NVXnxtBYLDV
 gObdRbHN9JjixzB1eF+WpwAA9TxxYVvIP3U0GHwjYauyeFxxbTihh3e6MnUge+K02x9CRLMNISj
 UfS9MUlJZozLolX16WQdmciUJHH7INtu0Drye9G8Z7qwycOp3kAzKoGtvsXQLzJOEoCWfec0rXv
 HlNRT7/Xi1SAc0d7YkkqHClqdW6v1N/L+fgpr+imbcUN7Q==
X-Received: by 2002:a05:6a00:a16:b0:86d:9ade:13f3 with SMTP id
 d2e1a72fcca58-86d9ade2b9amr8504968b3a.19.1789335259818; 
 Sun, 13 Sep 2026 14:34:19 -0700 (PDT)
Received: from 0xiviel.ip (122-63-135-80.mobile.spark.co.nz. [122.63.135.80])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b291c5e8dsm3477094b3a.32.2026.09.13.14.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 14:34:19 -0700 (PDT)
From: Eva Crystal <0xiviel@gmail.com>
To: min.ma@amd.com,
	lizhi.hou@amd.com,
	Min Ma <mamin506@gmail.com>
Cc: Eva Crystal <0xiviel@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 1/2] accel/amdxdna: clear the mailbox channel pointer when
 starting it fails
Date: Mon, 14 Sep 2026 09:31:55 +1200
Message-ID: <2fcf0eca215090dbbd95cb86e1bf5076056d3818.1789334558.git.0xiviel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789334558.git.0xiviel@gmail.com>
References: <cover.1789334558.git.0xiviel@gmail.com>
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

aie2_create_context() allocates a mailbox channel, starts it, and on a
failed start frees it again:

	hwctx->priv->mbox_chann = xdna_mailbox_alloc_channel(ndev->mbox);
	...
	ret = xdna_mailbox_start_channel(hwctx->priv->mbox_chann, ...);
	if (ret)
		goto free_channel;
	...
free_channel:
	xdna_mailbox_free_channel(hwctx->priv->mbox_chann);

hwctx->priv->mbox_chann keeps pointing at the freed channel. That
pointer is the driver's own test for whether a hardware context has a
usable channel: aie2_destroy_context() returns early on NULL,
aie2_sched_job_run() refuses to run a job on NULL, and the message
helpers return -ENODEV on NULL. A stale pointer passes all of them.

It matters on the restart path. aie2_hwctx_restart() calls
aie2_create_context() again on a hardware context that is already live,
after aie2_hwctx_stop() has torn its channel down, and the context
survives a failure there: aie2_sched_job_timedout() discards the return
value entirely, and aie2_hwctx_resume() only propagates it. What is
left is a live hardware context holding a freed channel, and every
later user of it takes the non-NULL branch:

  - the next job submitted reaches xdna_mailbox_send_msg() on the freed
    channel, via the !mbox_chann guard in aie2_sched_job_run(),
  - a second command timeout reaches aie2_hwctx_stop() ->
    aie2_destroy_context(),
  - closing the device reaches aie2_hwctx_fini() ->
    aie2_release_resource() -> xrs_release_resource() ->
    aie2_xrs_unload() -> aie2_destroy_context(),

and aie2_destroy_context() then calls xdna_mailbox_stop_channel()
followed by xdna_mailbox_free_channel() on memory that was already
freed: a use-after-free, and a second free of the same channel.

The AIE4 management channel already does this correctly -
aie4_mailbox_start() clears ndev->aie.mgmt_chann right after freeing
it. Do the same here.

The create path itself is not affected: when aie2_xrs_load() fails,
xrs_allocate_resource() removes the solver node without calling
->unload, and aie2_hwctx_init() frees hwctx->priv, so the stale pointer
never outlives the structure holding it.

Starting a channel can fail today without this patch: the ring buffer
sizes firmware reports are rejected unless both are powers of two, and
request_irq() can fail.

Fixes: d5b8b0347fa8 ("accel/amdxdna: Split mailbox channel create function")
Cc: stable@vger.kernel.org
Signed-off-by: Eva Crystal <0xiviel@gmail.com>
---
 drivers/accel/amdxdna/aie2_message.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index b4c49259a1a2..f658760c3d48 100644
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
2.53.0

