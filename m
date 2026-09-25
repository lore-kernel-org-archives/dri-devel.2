Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6815DC9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 17:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C18B310FBD1;
	Fri, 25 Sep 2026 17:58:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZL7D9HIN";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34B8610FBD2
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 17:58:28 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-33e630052ebso1334693eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 10:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790359107; x=1790963907; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AyFVOhvCGQIiViIbb7+gjM5CZL+S3jyqr2aX/1FUz8c=;
 b=ZL7D9HINfy6hzF10rAhP7GoOFySlmfVQMxoZMgj3ioOxgcB7Y+unvHtSBP3TvVyejy
 PgcghWHqMOsfxHdVXqNwRj/IKIDSnwqRFrXZuIE0U1V+Xv6K7pVvycTFyDjAOrRAxnOv
 LvzMQDlD7jWFjEhm5cFJu3AN4X+DZCr4laSkf3l0kJ8JJRSNmUvvip7hNMBT9NzUhius
 tFJ1XOWDxpMKvOkYdVLhCMBdEF7DkLxQxfsqg6UL1CBd4292CBYD9AYvXXt2kGx7i6Sd
 Ga4IM6m18KGWAw9i4cNVIfWUpFH/IAfQqUJl1JYcbXHhgMoETAbc9Yb0EHRuTFCnv/Lo
 nxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790359107; x=1790963907;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AyFVOhvCGQIiViIbb7+gjM5CZL+S3jyqr2aX/1FUz8c=;
 b=OrXtxdGvnIHlGN3jhr7GUrlXzrxKwaWYoRcf0xthxsGVpax+Sh2uhzvMqJxawj2g14
 F61vG+P5fD2YIaLeXcV8hXFb5eBaYYc9Wkia7qKnIMxlkEpG+/xRlOSMHvhIzG7nO/fK
 mqxB5gsFna6WgTfuqwhmYYsTX/QfdjjohWb3wY5AzqaLZ9/XoXngTdmplQTnxTd47jK+
 f+TeqiAXfcc3ryBvJvpIBK5Bxk3pGx/rw5e1IYvtAMfUJx+RTu/1AyEsoS6ZMVv9ES7G
 ZXrcrjD5d74w0i45Dx63OkhyE/PFDEx0Dhku94Dh1lBJl4MtUrK+nqDvFC/tThbP+JyH
 sH5g==
X-Forwarded-Encrypted: i=1;
 AKwUvByvrBETV8tu1+oL5Rb02xvd5t5WbsHPZ4P6o2krMYbTfuFe2QJKCVuUY8Ry1HX8wryM+hBhAIK8A2M=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nmb5r+EIXBFSYedf2xZuauJWf61z4eOWAQjERykEcmB8eSAaoY
 812Mb4LvGJLCfcNpT6KGI8afn8eOIhTfujATHxjAWiQRCbQoyN6Ak6ER
X-Gm-Gg: AYBFou0ePQZNodaL99o9bk6yjKz4488AIEWJtmfVjQ80rvccwVJKdfUVFcCgS6Kn3V8
 ME0YUh2r+Oqms3yh3jFXZqiV1HaNNCe6/cx2q4WiOgH4sd3GR36a6DWtJEc5AHdBihjUWrV5GBu
 uHdkMvUkQQLy5znW4ZxOZMFUDKicBgx0Z9Kn3hOAYmeCxGXZzH3R6cR4H+vxwBVvLLn96blDPrP
 Iy307AIZo69B2T+ofb9dbSgVrhOXsdVwV+qDGPPuy15Ly0UXPfDj3NxVIZvKuYdkn+3CJN+AdCg
 9ktNjMD5qUm5RTHp0CnqDTETeYRAY/6xNmgjIV8GCcHGv9ioeAqiMeBgwexDbDsNN087fm1XMs6
 N3xXruRmK+cTNOa57cy1eOIbgvovA07O639NliayhwOHD4kRvg/utcmsps8wsdWnQvEOjuVmJ0E
 LrFPNjRjIB3XKXO1FmHFGhi+xsVFn8NdFflL4qDQ1lEZvCyG6hji6t730SJGEDd0k=
X-Received: by 2002:a05:7300:c394:b0:33b:fae8:bbd6 with SMTP id
 5a478bee46e88-3426febb742mr935256eec.2.1790359107087; 
 Fri, 25 Sep 2026 10:58:27 -0700 (PDT)
Received: from beelink.. ([187.13.30.172]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34145c17074sm6579075eec.26.2026.09.25.10.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 10:58:26 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: airlied@redhat.com,
	dakr@kernel.org,
	bskeggs@nvidia.com
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] drm/nouveau: cancel irq_work before freeing connector
Date: Fri, 25 Sep 2026 14:58:19 -0300
Message-ID: <20260925175819.3699225-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
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

nouveau_connector_irq() schedules irq_work on the system workqueue.
nouveau_connector_destroy() calls nvif_event_dtor() which unregisters
the interrupt event source so no new callbacks will fire, but it does
not drain the system workqueue.  If a work item was already queued,
nouveau_dp_irq() can run after kfree(connector) and dereference freed
memory.

Add cancel_work_sync() after nvif_event_dtor() so any in-flight or
pending irq_work completes before the connector is freed.

Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index XXXXXXX..YYYYYYY 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -395,6 +395,7 @@ nouveau_connector_destroy(struct drm_connector *connector)
 	struct nouveau_connector *nv_connector = nouveau_connector(connector);
 	nvif_event_dtor(&nv_connector->irq);
 	nvif_event_dtor(&nv_connector->hpd);
+	cancel_work_sync(&nv_connector->irq_work);
 	kfree(nv_connector->edid);
 	drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
