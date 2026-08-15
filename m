Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180D0C5CFC1
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6173010E48B;
	Sat, 15 Aug 2026 19:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BgV51mD8";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD68B10E608
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 19:54:29 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47f611b3af9so232612f8f.3
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 12:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786823668; x=1787428468; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XxZBcoNm0rPU1Ur89x0ojWr5QvTqSdgFT80aSFgKz/A=;
 b=BgV51mD8/ce9yzqQno+LijQc8t9FUttI6NtvfYbBFVYF3UaohlHjxgb8KExnPdzvx2
 65wjXG0DFjODkCzj0FjROzHXS7jC5SNtmx8ZDaLI6Cn16DZ6KYvWD8KLclXr3Ty26U+I
 4mvkO169LA8gMfI3N7I6CVw7hvs3izIdByVLyJ2+D2qiXCQSoqi5G87fCqXN32IJZ0Jl
 sQ4g0SjEBI+jn5TY4MWvElVsObMyaBx0ji1U7s6W9KTibaOcgtPxwnUnuojFa119b0ig
 soAPA3L253Z0URofSknCLABGeVu7L15wDJW9QFKuoRj131SpseoeUa/KsyMd8gKSkhWq
 DUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823668; x=1787428468;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XxZBcoNm0rPU1Ur89x0ojWr5QvTqSdgFT80aSFgKz/A=;
 b=MgkR88YkVlxbcvdJlt81vAmqqcuz/ATmz9Sr/rmLLfdKB/c0LXA+vJSZM/LPjgpvBb
 RGPqyj7oI/x07KZkxudu7EEgeaMuWajm+6g9lKc5IxjK2lpq+Hs90Lrqp7ur7S/PUbLK
 gJzrezLNB97hAJXxsmBIwAnVv1eZJquttx3EwzfBadUKBcDpqNJ0Cg8QtpF/q58uI60F
 t5PfKRycKqDsL+H9k9FumdoAkUMXOQLwkL12KtNo0VzEsu+LSjhDD0j8g3EufPz32Hc8
 +ERgjWKjNkBu6rXhwlQOyMbxJ/oVLI8kNwVBIlsV8+evt95yMDf4K8hXf3RMK2j0wP5K
 0pSQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqOoiAc3wHviCUYZF3Ruu42WvAO4PkASzOzQMWFp0/7M329a2uURC1eyG2+yTUe4dtk0HdKaYwgii8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCXou6/WHY7OF1IcIwuZLzE5NdiK3nPDoDyH8ChuAanXKXcZFS
 +SiIlUK26hL0MS9+r9WRj5lhPApOb0LmhIZ/6Z+hQhaKQJzFvb7E7FpZ
X-Gm-Gg: AR+sD10VYgglk9HYve7JuT+WbeYX2raeUb4IJtr6duklE6RvGrNfPpObQigdsd5mIgr
 lDsfwBE+7STjVma4aATXTpL0TSBYhTCFS066AVDxUt9Rs36BGcmhm0JyzLOVOnKn5FT1AvZBAEu
 oOM8T0WEqEjKuF/MTyCw4wE4U+q46pKxD0B2CFiYt4Ln/caNTuqyqNeSVFbcEP5dQ4APYixN5/M
 qJS99r+lw8X9PiNK3LOJ7X+fgWtsIeChEKoMBVFUjQP67QtRq3MKSKzGEGH12rNdKDmxT+W0L35
 jLu8A0W/c6SmVOyi1KJhwGj1M1yoe3VGjVnKe2mxDeH6iHvBPtgmnuOP1CedU/TiprI6DN35BwX
 nxhDzZhW9sqzSSObSDcGHzrgr0UINJR/lnYArG8dDcFOLsnxVqERE90aH6FTaZ81jGdDT98WQrb
 9Cv3FQ1/Ua5toZll8Zdire42smixgTqwZbtG1IGxJVgO30GPhuhs7tOYwgYCWsTpnDkeVj52kOX
 T5wISmkS78FFnZ77vxlzlMFO9aSvZNINL5CkqQFig==
X-Received: by 2002:a05:600c:1385:b0:496:c249:ddb1 with SMTP id
 5b1f17b1804b1-499879759bbmr105883175e9.4.1786823667999; 
 Sat, 15 Aug 2026 12:54:27 -0700 (PDT)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de.
 [109.193.28.127]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499899bff2csm133743775e9.7.2026.08.15.12.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 12:54:27 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 2/3] drm/nouveau: cancel the DP IRQ work before freeing the
 connector
Date: Sat, 15 Aug 2026 21:54:20 +0200
Message-ID: <178682366002.3748010.4096452389040554615@gmail.com>
X-Mailer: python-smtplib
In-Reply-To: <178682366001.3748010.7798811159846779765@gmail.com>
References: <178682366001.3748010.7798811159846779765@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

From: Marek Czernohous <marek@czernohous.de>

nouveau_connector_destroy() tears the two nvif events down and then
frees the connector, but never cancels the work the IRQ event queues:

	nvif_event_dtor(&nv_connector->irq);
	nvif_event_dtor(&nv_connector->hpd);
	kfree(nv_connector->edid);
	...
	kfree(connector);

nouveau_connector_irq() queues that work unconditionally:

	schedule_work(&nv_connector->irq_work);
	return NVIF_EVENT_KEEP;

A DP IRQ arriving just before nvif_event_dtor() therefore leaves
nv_connector->irq_work on the system queue past the kfree(). When it
runs, nouveau_dp_irq() derives both nv_connector and connector from the
work_struct and dereferences them, and goes on to take
outp->dp.hpd_irq_lock.

There is no cancel_work_sync() for irq_work anywhere in the driver, so
nothing else covers this. Add it after the event teardown, where no
further work can be queued, and before anything is freed.

Reported by the Sashiko review bot as a pre-existing issue, in its review
of an earlier nv04 FIFO series of mine, and confirmed against the source.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260812231330.705425-1-mczernohous@gmail.com?part=1
Fixes: 773eb04d14a1 ("drm/nouveau/disp: expose conn event class")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Marek Czernohous <marek@czernohous.de>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index b0b0ad9a0c24..e49dcaa6d210 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -397,6 +397,7 @@ nouveau_connector_destroy(struct drm_connector *connector)
 	struct nouveau_connector *nv_connector = nouveau_connector(connector);
 	nvif_event_dtor(&nv_connector->irq);
 	nvif_event_dtor(&nv_connector->hpd);
+	cancel_work_sync(&nv_connector->irq_work);
 	kfree(nv_connector->edid);
 	drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
-- 
2.54.0

