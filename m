Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07379606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KRcOXJVB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5F5910E55D;
	Thu, 19 Nov 2026 07:48:43 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 127D010E664
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 02:29:27 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-380b40319bdso2588420eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795055366; x=1795660166; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C3K0E2vNrzLhMfNcPaWTZ4EGNNKVe3QGEsiFAnE9hUA=;
 b=KRcOXJVBuMnXx5rtmRJkRbhplHKth1uzac6NMWaDUlhFcIAycgg8B0dRryei6KJT8f
 OKvBgzx0Ifmz+yQihbcp/VFSkH15aZ/0+tXT4wb12P4gciahvMqeu+IuUe281mira1zA
 rzyyPAYqdYhfXzqAKT2ODf7f7w3BDBqr58GcyLizbNUD++YHYrZ1Zljv9VPHoTTufIcE
 KIT96OjFjldGKjpWtT2uE0zFohIjc18qq4LHKtLqLbQyEqf1cjqjM45twdNQh0AJJ/lY
 ZzYK0j2FM+GiJq094e1TBBoRFWtf2DN81eJpncy13gb4TKoJ4oNzeKA7tO/uNycnZUXd
 r/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795055366; x=1795660166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C3K0E2vNrzLhMfNcPaWTZ4EGNNKVe3QGEsiFAnE9hUA=;
 b=JTPhqfEpO4FRdFlTxQdr+ZHx04PhkcrMI3/S2pUpK+eymWuZanemFh67R+4vJTE5Bp
 tf7Rw7zl6XzIOSCWkNJyTREvXv385JiY8YgAu+YzyVWcLaUnvOTX4qq+QFutv4A4S8TS
 ZktYwQ5/+iRL8uss4FpDTqmvcJorkGGMilXRKULgjEtAv6pAJNCV53uTYWZLJq1O0/uP
 pbzYR1Z00pjO+bFU5OplV6M35xHbWsIXfawV610o8aQHHq7mBG/M0XoIANLHLQ1xCZD0
 Rlhn1jAFtMbJsDsR8JM3eZLnLEoYnXZddqDjOn2aN6reQXTeUu60+cb5AV5zu49lVTXQ
 CqrA==
X-Forwarded-Encrypted: i=1;
 AL+hErH7RQqc9/o5o1If4+TCQd8FjbWmadPRAYRiUMNyAcmLO38eP1Hn+8ckKTn8mNBJsDdqlFIS2Gr2qOk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9mZ5JvXm0Xx/GXHpa3d6Uwm0ackOnW92uRVhJUw6H9dzWWErxG
 N9rYc61DG1qzxWPKj+iL54KiwpIEAlWFxlmw0YUyMsOjR1jFCWAvFE4Q
X-Gm-Gg: AZFdTZeBZfWL3FbQkx7jyIrSr46sQVMpBkS+5XjcttCDQVQrDVumRLsY/alGgevyeGb
 tteWgHSStKkrQrnlfTHX5kjM5G1WjK7Y+RMOz+ldas6Pfqs5pny9pEAoHZ4x4zje5KM6BTWCmDv
 k7Ut425mov7kVSP8GVysBfMvpN3lkBDNWBH4aUklWTlgKB/WvTJ2gINfVWx6WFKy3BQYQerqOlY
 pZfxSq/ZZOobWd2LO89jg4gFrWYGBmUuzNRoQdC/k2i5MtxWvI/pOzCF7cB6uun5aYVHUlLbKXO
 ghX1CjxUKgly3z59lLi/4sB6Zjbd6lkimBFWeBq7psij0w+tWpwHjGOQuvfF3UHaOMakAkDJWJH
 1U3NfJnJM0uQDDWV67vgDq5vzY+Mzp/eoEkfUDr2C90s9FhJIZzi+Psk6xF1zjQ+id+U/qdBY/H
 h9iEn3xZ/92swVNrmNoTQZYwz4WiKGPtktoKN1Ks2XlRH5RV+gEWqLI7VgBiUk4yzqBRnkdzD3/
 7DI8mRFYNUv42ZhvMKQw8jnL/2H+xMv/nmz2iMotwtaZfczEfd8hRFIwq9o4ellLUOMbc78qbZE
 4L1k/9SvMru7Ret6rWtbEfDngId6tlQI7Nx/6dhGbPU3bYyYuLZIomMpX+cZkMjQ8qHqTQT2v0V
 LEek8N6dnBdGU+LHCGmgicRY/Z32HN7N0cZveniBE
X-Received: by 2002:a05:7301:fd84:b0:384:7a8f:3bc1 with SMTP id
 5a478bee46e88-3847a8f4f1cmr130310eec.17.1795055365946; 
 Wed, 18 Nov 2026 18:29:25 -0800 (PST)
Received: from lwq-System-Product-Name.. ([2602:feda:30:cafe:ec49:38a8:0:f6])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a79c96b2sm13193964eec.24.2026.11.18.18.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 18:29:25 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: jeff.hugo@oss.qualcomm.com,
	ogabbay@kernel.org
Cc: carl.vanderlip@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jacek.lawrynowicz@linux.intel.com
Subject: [PATCH v2] accel/qaic: drain the control workqueue before the device
 is freed
Date: Thu, 19 Nov 2026 10:29:19 +0800
Message-Id: <20261119022919.1493567-1-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118072448.1259909-1-shunsheng1218@gmail.com>
References: <20261118072448.1259909-1-shunsheng1218@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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

qaic_pci_remove() tears the MHI controller down and destroys the DRM
device, but nothing drains qdev->cntl_wq.  qdev itself is allocated with
devm_kzalloc_flex() and is freed as soon as the PCI device is unbound,
while cntl_wq is a DRM-managed resource that survives until the last
open file drops its reference to the DRM device.

resp_work is queued from qaic_mhi_dl_xfer_cb() and resp_worker()
dereferences qdev, so a work item that is still queued, or still
running, when the driver instance goes away touches freed memory.

mhi_power_down() moves the controller to the shutdown state, disables
the interrupt and flushes the state worker that destroys the channel
devices, and mhi_unregister_controller() removes the controller, so no
data event can reach qaic_mhi_dl_xfer_cb() once
qaic_mhi_free_controller() has returned.  Flushing the workqueue after
it therefore covers every work item that can still be queued.

Fixes: 22ec9a3b73dd ("accel/qaic: Leverage DRM managed APIs to release resources")
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>

---
Prepared against v7.4-rc1-1969-g666539eecdf4.

Compile tested only: arm64, aarch64-linux-gnu-gcc 11.4, CONFIG_DRM_ACCEL=y and
CONFIG_DRM_ACCEL_QAIC=m.  No hardware was available, so the removal path was
not exercised and no race injection was run.

AI assistance: prepared with Claude (Anthropic) as a coding assistant; the
author reviewed the reasoning and takes responsibility for the content.

Changes in v2:
 - Correct Fixes: to 22ec9a3b73dd, the commit that moved the device release
   to DRM managed resources.  No code change.
---
 drivers/accel/qaic/qaic_drv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
index 90c0d31e414a..c4c3f450e67b 100644
--- a/drivers/accel/qaic/qaic_drv.c
+++ b/drivers/accel/qaic/qaic_drv.c
@@ -625,6 +625,15 @@ static void qaic_pci_remove(struct pci_dev *pdev)
 
 	qaic_dev_reset_clean_local_state(qdev);
 	qaic_mhi_free_controller(qdev->mhi_cntrl, link_up);
+
+	/*
+	 * The control channel is gone, so nothing can queue resp_work any
+	 * more.  Drain it before qdev is freed: the workqueue belongs to the
+	 * DRM device and may outlive this driver instance, and resp_worker()
+	 * dereferences qdev.
+	 */
+	flush_workqueue(qdev->cntl_wq);
+
 	qaic_destroy_drm_device(qdev, QAIC_NO_PARTITION);
 }
 
-- 
2.34.1

