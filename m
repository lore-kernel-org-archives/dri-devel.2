Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD710606A32F
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 21:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U6hFVOnc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F7810E6BE;
	Tue, 17 Nov 2026 21:44:37 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A3D910E6AC
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 21:44:31 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4bb702a7548so2969885e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794951869; x=1795556669; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d6UTl8IcRMHJ8o1AzBnaOrrvZJhPc7DJaM7kqbvB2L0=;
 b=U6hFVOnck9D5kaa+omcNDYwbmurHh/5XNs7lfOKHpd7ZhTHCCl5tBMwTCabw3+HOhB
 VSlJV5Mc8dK5MK/W+ETBVzLulOqS9AxJi53eNp8NMUBP+c4xVBeQUzIT+Y/FveZDLk2n
 GmSLu+rv9OPCdCWxFL+wKfWP4BTuXB3PAJMt+862tR3WvTtwdqx2JwAk3SsKQC6jUPFZ
 ZDMRKBjxo6UhSbT7U8DWc1kdu4RnHpvCAwWwfcaHVLZrM1MEJ1qqH54LCy3jRMGG/h+f
 wMc0fRSOhPZoicCMYkgaKMMZDC3IvGJKexgGS7jWZ23gv37tqEG+A5vnDiOaidbdQ+kD
 TfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794951869; x=1795556669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d6UTl8IcRMHJ8o1AzBnaOrrvZJhPc7DJaM7kqbvB2L0=;
 b=bNKXvW6MbYliV+jLok+2RxGwX+Rc4Ys6BHAcCxDQcUsOQfSZ0B0CVI/Tb2YerUDDns
 Ce6glKieAH0NaCczChyTFCvhCsWgkmV55haSO8wvECM7BrGYI5bOtzbxIwggxTiyiyM6
 qufzk06g76UYycOoGOUcNOTFaScNWbr+nfqvISdb25XQ9x1ojVMsuu6Chuc83vhTsjSZ
 0AZNuaxxR9AW2T468vqtzVV0RRz28iNQyalb3RUimpvMZ16BFxdB+/iC3v0tdDKn1kqv
 E5Z5nBc37KvYuz4CHfm3zWdSEtfqREOFU4v7NPoPFTEPWXaUcG3sDmZr1/eatkn7x7cY
 yzVA==
X-Gm-Message-State: APuU4Z8M3nAMnQ/a4Vs5ZAMkAEQyz0eR35PUlnQvKY+8Vkw7OtEL7oD0
 z+6/3dro/Aj/k1YhyCZGFVzr++ZwSVScOW9gt6sxvHQ82OMWiVs/wsGt
X-Gm-Gg: AYBFou0lBZJH8cVSMDmVsrfr6oz0nSXT8aHPjJflSplGTh6Ekd+So23FDPBt9hieXrs
 CAAMxWimcaMaL01WOcU3Fdx9P7vMVKNXoQiJIapCTj5UtMaALHZV9pyF3E/pYYuExZjyIx1MeRO
 0hkRK9bRiG9HP/zM6RQFF13FfUoRNvhoydGSmr5g/jz7kKEvA2R4vGTUmc2cdj8G157fs31KPuL
 bdriFPiod2U1sgIX7uzJGRleE9m9WipXq2tpwDtqqnKUDeqojUi5JdpO2uAk1I1IEprbD8FquJS
 hJASm89MoSitB9UtZkpdepVIKcWbdXzbQThoYzkGtE427A2YUXjwvC5MdnwojZeZDjod7Iu16/Z
 4DI9gKNo52E6sEfsLLvAdtuvxuVmWiVTJPih0lSzx3r+8ApU91BH/RstmiE5FvBswvCb5UAexlN
 GsULepkH8joTSE4Xny1Edwmq+VNnEYf9Md9er22HPpiF8A/b0l2cNPn7ksUIMbqP0XplyhFN6Xo
 O1F7WOkRYXd4nVAPBWFMJ9brpO5ehtUl5395h13GdlE+ra+Sad+cIIHBDotyQF1CVsyu3E/jobS
 si0PPfgTYNaFO6GkJM6UnkjGfsuEk51fPTxImX7Wf5U72vLW7XBwYCRfHOvc4Q==
X-Received: by 2002:a05:600c:524d:b0:4a3:59c9:a758 with SMTP id
 5b1f17b1804b1-4bb7da46d69mr8423315e9.32.1794951869309; 
 Tue, 17 Nov 2026 13:44:29 -0800 (PST)
Received: from fedora ([94.200.248.157]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb784231basm95069675e9.11.2026.11.17.13.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 13:44:27 -0800 (PST)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Mary Guillemard <mary@mary.zone>,
 nouveau@lists.freedesktop.org,
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>,
 Thomas Andersen <phomes@gmail.com>
Subject: [PATCH 1/3] drm/nouveau: do not return early from a synchronous
 VM_BIND
Date: Wed, 18 Nov 2026 01:43:50 +0400
Message-ID: <20261117214352.337961-2-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117214352.337961-1-mohamedahmedegypt2001@gmail.com>
References: <20261117214352.337961-1-mohamedahmedegypt2001@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

A synchronous VM_BIND waits for its job with an interruptible wait and
ignores the result. On a signal the ioctl returns 0 while the job is
still queued. Userspace can then use the new mappings before the page
tables are written, and the channel can take an MMU fault.

Wait uninterruptibly. A synchronous job takes no syncobjs, so only the
jobs queued before it on the same scheduler can delay it.

Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Tested-by: Thomas Andersen <phomes@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_sched.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.c b/drivers/gpu/drm/nouveau/nouveau_sched.c
index b3f02c490ecb..680ddffefca1 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sched.c
+++ b/drivers/gpu/drm/nouveau/nouveau_sched.c
@@ -328,7 +328,11 @@ nouveau_job_submit(struct nouveau_job *job)
 	mutex_unlock(&sched->mutex);
 
 	if (done_fence) {
-		dma_fence_wait(done_fence, true);
+		/* The job is queued and its VA space changes are applied. It
+		 * can neither be restarted nor reported as failed, so wait
+		 * until it has run.
+		 */
+		dma_fence_wait(done_fence, false);
 		dma_fence_put(done_fence);
 	}
 
-- 
2.56.1

