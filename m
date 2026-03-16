Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1B0FB5E81
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 22:39:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BDB910E55D;
	Mon, 16 Mar 2026 22:39:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nE24yi+A";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hzvEQ6F3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E30910E40D
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 22:39:05 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GE879f2375172
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 22:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RUqvixG5Wks
 FkWvaUmguT5wloH9h3qhuAtu4mv/i960=; b=nE24yi+AyoZ/YThQsSaCF1IF2Cw
 XbsrUSrLpTKMf7T4+++m6qxsn1F+sJMeUldisbR4LMOfV4tLuuUme+JQ0HLzPdx/
 Jp1Atik3pmeixNshyzxMjvClsPMIaiysy9S5CwZuSYH2La1o+RwT98H2Kb9qSA+u
 LDWcM8Q/ilSk1C/jvN2fMXn2qtCV238vAzhbvUlJ9KPLyWj+ApLCiS1n3qc4VTVX
 tx7ip3JELmUvZFVjmjhh74Cho6gge30+0C7gpFJE0rq9hxklkMbGXSn+7HeTNLfd
 p2rLvrNyjHDxt1pH6acqJc2EJtldPQgZTc90s14txEvCFQmdu0CtbyphD3g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxkby1nrg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 22:39:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-358e425c261so5904618a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 15:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773700743; x=1774305543;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RUqvixG5WksFkWvaUmguT5wloH9h3qhuAtu4mv/i960=;
 b=hzvEQ6F3/1tVIY+Lv1oVxiznDCWVU3N6l5t11Qt+Su6XXapT6rGFvoqI3tzk6VDM4w
 ZvkdYQeWbfaLBnNHa1IZzuQWVZWcyHpxIS6QkKqrK9ENxMuUJ4dP1dHS3aAN32fXSAQ8
 twQ9IPv+jksZFyovaB5ujnUIOWHtM9J3kVFTpMQ/ci+xTUU8lMdP+EtyMxMtW6ScV1hB
 4HYHz985FFTA9TTbZGHNvL9ExI6zxW/v0ZcckZr52fAOiZC2xvFjbDSUs5qANTwWtSNS
 8E5L6W5eiw7cd843oz7ttfmQAlsGEAMrId0DR4Z7SS07JHtYulJ+9EUCDk5a8gqV96so
 mquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773700743; x=1774305543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RUqvixG5WksFkWvaUmguT5wloH9h3qhuAtu4mv/i960=;
 b=Mw+cmVRo0Y96Kabfq3yRNYRMTfp9VSU5FliiEXLEPeMQd5qfwsRm/tWTMHutNc2WcH
 /rEAoF79TRMR7bwvOs6qqohRMpVoUb73ekVpRe1+vUV0IVmIYOPFjQHukdJs/xIMAZTG
 DLA9JaEWZdDzOvOpFacjd0tGjkElon7s9iR4my8BznMpyFWft1238WUxisN8jnpcsqOf
 qSBgQn25YsnXGE+rVAkZIgL7jtLmr0y9Lt3YFyrI45OGgWj8tEJA65KBnmw4g02bTWt6
 jV5Q/DnSMbc7FW/2pWfxLfBA36P9+TabACAoU8tBf6rEazUg/q7o5/jsCn5IKEpDmzJ6
 Grug==
X-Gm-Message-State: AOJu0YwYheOQpGS0mJCXBD9N4whi0DkrD59OPMk8s1SNUnbEnom7JleV
 L3wBHTax+4kWlSYcUJbRinM9+rZw0Y7Y7x5Fiw+EMr76kO7ZskpySdZzRykyaRLOTVknhB0ne5Y
 EWYzCj1PQjGE8huHDzfc98S/yV3x7vzkedIHu9TxrF4Lgg7dSMp0tMpcSzo9KaYyWN0RdPR4ynY
 i3TXA=
X-Gm-Gg: ATEYQzyWLvf9Bvz9+WbiFTuSbSkZELU+Pept3grNCVOz8FxbhXdlZ64hBqe1VzaPfzf
 WqUc7DWClAUmpKZorj9IXzZdHrC6fTGBWLNwcstFzE7DfWePN7SUuzbI9fF+yTMg9SA47zCcNrE
 F1PJMlSyE7FJkGG3kqEWSUGyDigLl0BleN8/qnIIir9J/bHplNPRP3i+HJuq++f2+oIFyLPT/ga
 +KtBmC77OMO6bC5uTd2C857Na6QI4etOZwPkBFUPnbR05ruO4lOqzoDSejJs7pVucNMJvAYQexz
 B8DrkPxDE8uuksfCBl33M+De/uaRAIzil2lciVRdG70Yz+hdShbWDrB6gIk7edYLKqcU5fadSZI
 I/SzZ6ifKatyJu6Z1BS/dBiNedM/D4sOf
X-Received: by 2002:a17:90b:5828:b0:359:ff8a:ee47 with SMTP id
 98e67ed59e1d1-35a21e1c7b6mr13704170a91.6.1773700743262; 
 Mon, 16 Mar 2026 15:39:03 -0700 (PDT)
X-Received: by 2002:a17:90b:5828:b0:359:ff8a:ee47 with SMTP id
 98e67ed59e1d1-35a21e1c7b6mr13704145a91.6.1773700742801; 
 Mon, 16 Mar 2026 15:39:02 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bad8b5cdesm723408a91.0.2026.03.16.15.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 15:39:02 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [RFC 1/2] drm: Add sysrq key to kill current job on GPU
Date: Mon, 16 Mar 2026 15:38:49 -0700
Message-ID: <20260316223855.711574-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316223855.711574-1-robin.clark@oss.qualcomm.com>
References: <20260316223855.711574-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DYdMeSccfZi4GRiRmfp_yfd14W45pQqg
X-Proofpoint-ORIG-GUID: DYdMeSccfZi4GRiRmfp_yfd14W45pQqg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE4NyBTYWx0ZWRfXzQzg8jb7PKE9
 03a3+IAUcYEOpgzKVw1OA5hO6JlgIslRRLVUNvKPJH7zA8b83Zg/u3I3jYQCn4jhANtbKxWmICp
 5AObRYVN5N8WIFjdf2KgcxLkZZA0Dq0L4uq6qLlxosZ8QFlf19ZzDO2l4KQTAV+4OAsbFtSOP+A
 OC12jI5aSAMXtgskbzqnEGh7FykiIiapQY9jOabiDkm+S3ryuvcXjwsG7YgnAYRKIC2xDwJ1Qh5
 nMmVJ10rPgmhKFwa/KO68Iw0jjMUccPFXZtKXspnuZk+NYzEAErcmq6vQoQHztIhC0T2DtUuztH
 s4099Se0Cb5L813XFc/0xjx8RcPuOctJpcsInNLZwfDkmfxUX4OrkDc4u3q0iuwsKcA5VbTrEQ8
 mXYHsue/ho1wLqPXTwiAAtAcGIs6D154CCGi35N27x5q73fXgJec3Quhm6wj+tNCVo5tDyZsqgt
 ues5zU9nyWRryjlopiw==
X-Authority-Analysis: v=2.4 cv=ZpLg6t7G c=1 sm=1 tr=0 ts=69b88688 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=qvQf7nBXRcI791bLINIA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_06,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160187
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

If your compositor is getting starved for GPU time, it is useful to have
a way to kill the current thing that is hogging the GPU.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/Makefile        |  1 +
 drivers/gpu/drm/drm_dev_sysrq.c | 67 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_drv.c       |  3 ++
 drivers/gpu/drm/drm_internal.h  | 11 ++++++
 include/drm/drm_device.h        |  8 ++++
 include/drm/drm_drv.h           |  7 ++++
 6 files changed, 97 insertions(+)
 create mode 100644 drivers/gpu/drm/drm_dev_sysrq.c

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 0e1c668b46d2..337af859753f 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -44,6 +44,7 @@ drm-y := \
 	drm_colorop.o \
 	drm_connector.o \
 	drm_crtc.o \
+	drm_dev_sysrq.o \
 	drm_displayid.o \
 	drm_drv.o \
 	drm_dumb_buffers.o \
diff --git a/drivers/gpu/drm/drm_dev_sysrq.c b/drivers/gpu/drm/drm_dev_sysrq.c
new file mode 100644
index 000000000000..47e029b7cd0b
--- /dev/null
+++ b/drivers/gpu/drm/drm_dev_sysrq.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+
+#include <linux/sysrq.h>
+
+#include <drm/drm_device.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_print.h>
+
+#include "drm_internal.h"
+
+#ifdef CONFIG_MAGIC_SYSRQ
+static LIST_HEAD(drm_dev_sysrq_dev_list);
+static DEFINE_MUTEX(drm_dev_sysrq_dev_lock);
+
+/* emergency restore, don't bother with error reporting */
+static void drm_dev_sysrq_restore_work_fn(struct work_struct *ignored)
+{
+	struct drm_device *dev;
+
+	guard(mutex)(&drm_dev_sysrq_dev_lock);
+
+	list_for_each_entry(dev, &drm_dev_sysrq_dev_list, dev_sysrq_list) {
+		dev->driver->sysrq_kill(dev);
+	}
+}
+
+static DECLARE_WORK(drm_dev_sysrq_restore_work, drm_dev_sysrq_restore_work_fn);
+
+static void drm_dev_sysrq_restore_handler(u8 ignored)
+{
+	schedule_work(&drm_dev_sysrq_restore_work);
+}
+
+static const struct sysrq_key_op drm_dev_sysrq_kill_op = {
+	.handler = drm_dev_sysrq_restore_handler,
+	.help_msg = "kill-gpu-job(G)",
+	.action_msg = "Kill current job on the GPU",
+};
+
+void drm_dev_sysrq_register(struct drm_device *dev)
+{
+	const struct drm_driver *driver = dev->driver;
+
+	if (!driver->sysrq_kill)
+		return;
+
+	guard(mutex)(&drm_dev_sysrq_dev_lock);
+
+	if (list_empty(&drm_dev_sysrq_dev_list))
+		register_sysrq_key('G', &drm_dev_sysrq_kill_op);
+
+	list_add(&dev->dev_sysrq_list, &drm_dev_sysrq_dev_list);
+}
+
+void drm_dev_sysrq_unregister(struct drm_device *dev)
+{
+	guard(mutex)(&drm_dev_sysrq_dev_lock);
+
+	/* remove device from global restore list */
+	if (!drm_WARN_ON(dev, list_empty(&dev->dev_sysrq_list)))
+		list_del(&dev->dev_sysrq_list);
+
+	/* no devices left; unregister key */
+	if (list_empty(&drm_dev_sysrq_dev_list))
+		unregister_sysrq_key('G', &drm_dev_sysrq_kill_op);
+}
+#endif
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 2915118436ce..c1f5a4ee6d58 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -734,6 +734,7 @@ static int drm_dev_init(struct drm_device *dev,
 	INIT_LIST_HEAD(&dev->filelist_internal);
 	INIT_LIST_HEAD(&dev->clientlist);
 	INIT_LIST_HEAD(&dev->client_sysrq_list);
+	INIT_LIST_HEAD(&dev->dev_sysrq_list);
 	INIT_LIST_HEAD(&dev->vblank_event_list);
 
 	spin_lock_init(&dev->event_lock);
@@ -1102,6 +1103,7 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
 	}
 	drm_panic_register(dev);
 	drm_client_sysrq_register(dev);
+	drm_dev_sysrq_register(dev);
 
 	DRM_INFO("Initialized %s %d.%d.%d for %s on minor %d\n",
 		 driver->name, driver->major, driver->minor,
@@ -1146,6 +1148,7 @@ void drm_dev_unregister(struct drm_device *dev)
 {
 	dev->registered = false;
 
+	drm_dev_sysrq_unregister(dev);
 	drm_client_sysrq_unregister(dev);
 	drm_panic_unregister(dev);
 
diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
index f893b1e3a596..164ff588aea4 100644
--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -67,6 +67,17 @@ static inline void drm_client_sysrq_unregister(struct drm_device *dev)
 { }
 #endif
 
+/* drm_dev_sysrq.c */
+#ifdef CONFIG_MAGIC_SYSRQ
+void drm_dev_sysrq_register(struct drm_device *dev);
+void drm_dev_sysrq_unregister(struct drm_device *dev);
+#else
+static inline void drm_dev_sysrq_register(struct drm_device *dev)
+{ }
+static inline void drm_dev_sysrq_unregister(struct drm_device *dev)
+{ }
+#endif
+
 /* drm_file.c */
 extern struct mutex drm_global_mutex;
 bool drm_dev_needs_global_mutex(struct drm_device *dev);
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index 5af49c5c3778..c6c0987dba36 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -246,6 +246,14 @@ struct drm_device {
 	 */
 	struct list_head client_sysrq_list;
 
+	/**
+	 * @dev_sysrq_list:
+	 *
+	 * Entry into list of devices registered for sysrq to kill current
+	 * GPU job.
+	 */
+	struct list_head dev_sysrq_list;
+
 	/**
 	 * @vblank_disable_immediate:
 	 *
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 42fc085f986d..8e9d5d597451 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -385,6 +385,13 @@ struct drm_driver {
 	int (*fbdev_probe)(struct drm_fb_helper *fbdev_helper,
 			   struct drm_fb_helper_surface_size *sizes);
 
+	/**
+	 * @sysrq_kill:
+	 *
+	 * Handler for magic sysrq key to kill current job on the GPU.
+	 */
+	void (*sysrq_kill)(struct drm_device *dev);
+
 	/**
 	 * @show_fdinfo:
 	 *
-- 
2.53.0

