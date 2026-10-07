Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC499CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C2D410F640;
	Wed,  7 Oct 2026 14:36:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=mary.zone header.i=@mary.zone header.b="UIpphGnW";
	dkim-atps=neutral
X-Greylist: delayed 364 seconds by postgrey-1.36 at gabe;
 Wed, 07 Oct 2026 14:36:47 UTC
Received: from mta1.migadu.com (out-125.mta1.migadu.com [95.215.58.125])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02F6810F638
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 14:36:46 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=k9AnQ5XvJt8ZcIfhZU8VWP5jz5T3cT4ex6UF/oaPJlM=; 
 c=simple/simple; d=mary.zone;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791383804; v=1; x=1791988604;
 b=UIpphGnWxKVlAunh5O6OzUZu5I+NMIONF5UJX+TD3uxn71CVgMWyJbdQIs0pADA9xyo0/Tz7
 hVOpxcPOUSA/mgo9YmRFY17HdQXC/3Ak48Q5fsGG4ZaioQ74UX3uZs2sbkiIrAlPDzdqFxnVvGr
 ieTY7SEoKHJuvy+/T/5QSNafsW8TEcckHIzPouLTTo6gHdWSqMg/5ZyiD8SqyeC7b96Qo3x5nw7
 HSQJctsSKd8MUmJqWhTLKIS5ksNzbJWyb7MWtJ7NtlLYieHGUqLShzJe7S1qOTL3GNRnw4e7hLy
 wOz09FFV9sueHsJJXajnrbcnw8VdJWZh9hd5HFCpKAEzg==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id c8ba96c4795c968d;
 Wed, 07 Oct 2026 14:30:33 +0000
X-Mizu-Trace-ID: c8ba96c4795c968d
X-Migadu-Flow: FLOW_OUT
From: Mary Guillemard <mary@mary.zone>
Date: Wed, 07 Oct 2026 16:30:15 +0200
Subject: [PATCH] drm/nouveau: Skip the Turing CE workaround object for
 non-GR channels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-turing-async-ce-fix-v1-1-12ee6ccd1a3c@mary.zone>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvyJ7bkFFkvpKdBDdbC8WWlGEf086z
 sDMC4UyU4FRvJDp4sJbaqA6AX51KRJyaAxa6l5JafE4M6eIrjzJoydc+EajSdmBtA3GQSv3TE3
 /12mu9QNVwD9XZQAAAA==
X-Change-ID: 20261007-turing-async-ce-fix-42e179e27d4a
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Mary Guillemard <mary@mary.zone>
X-Mailer: b4 0.14.3
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

This workaround is here for the old Gallium driver and predate async CE
and NVDEC.  Instead of only skipping it for NVDEC, let's only apply it
in case of GR channels.

This should make async CE work properly on Turing by stopping the assign
of a GRCE. (here CE0)

Signed-off-by: Mary Guillemard <mary@mary.zone>
---
 drivers/gpu/drm/nouveau/nouveau_abi16.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/nouveau/nouveau_abi16.c
index e907c1d07887..e876f154963d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
+++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
@@ -488,7 +488,7 @@ nouveau_abi16_ioctl_channel_alloc(ABI16_IOCTL_ARGS)
 			goto done;
 		break;
 	case NV_DEVICE_INFO_V0_TURING:
-		if (engine != NV_DEVICE_HOST_RUNLIST_ENGINES_NVDEC) {
+		if (engine == NV_DEVICE_HOST_RUNLIST_ENGINES_GR) {
 			ret = nvif_object_ctor(&chan->chan->user, "abi16CeWar",
 					       0, TURING_DMA_COPY_A, NULL, 0,
 					       &chan->ce);

---
base-commit: 70456f05d4b6396b22048c4b8cd3cb98ecf9f9e3
change-id: 20261007-turing-async-ce-fix-42e179e27d4a

Best regards,
-- 
Mary Guillemard <mary@mary.zone>

