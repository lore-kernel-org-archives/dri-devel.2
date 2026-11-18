Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ED1606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F71prr9R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9703310EB20;
	Wed, 18 Nov 2026 08:23:07 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A7CE10E2F6
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 07:24:56 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-cddee4abc57so201316a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794986696; x=1795591496; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bsjzF6TvIUuw+1BiWPKqYlHDsaiLhXoBbNKg0Yd1gBs=;
 b=F71prr9RA1/h4JfZ8TIUiqBiRzmbMO7lnbRfmAXTIvCxtnqrWRgjo4RoTg6G5oDaas
 k1cjgJXzUnA6IP/qQ+w8v4H/GgqSLa0b4OlI07WQhoMFNDCVYkIUv8NJ1AFu0TRK51d8
 iGbRC0ki49/DB28ERCc6LX3qxXY+KaHzK5I7xyRCMrYqElWBpE4ta6YX9jeKpL8fPdIP
 wqd1zpPtSW8U0qcEpYzuyQkCjcpW9EI4US1e4dexsJsfnHkLUSd72hb1BJhJuQlAGxJG
 oQnd1aXAdVSCMu2avogHY4+1Al8gUkQr0mnfWU7by5kdBR/dOI1Xa76LgV8ZWrVBNvAs
 /6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794986696; x=1795591496;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bsjzF6TvIUuw+1BiWPKqYlHDsaiLhXoBbNKg0Yd1gBs=;
 b=H2YaGvisq46s3/tJ8aul+lKelqaS0WOlqhTeRfDtIo3+pKpHL0dh+nxoqDuIQISxCT
 /BRgE4DsCOf6glo2P0rQUShq0WC/syTYg6iJPemaffAhUv4Wmrr/xEuE8mOuatPSNbRR
 TnnTnUb3U+nby4P/hjL8OgVuP9tRt0HwokOO05Es0HkL1Z8QVppp4SJ1BwtPo3lnc7kZ
 ROGzakW8da8BqMTc32NUGUTjGscUPOlIIWnO6JnYmEMprrO+gtkBBWuVl09Gq/409nQG
 A1lJDwosvBPly7z3mAq2rFRh1kC5wq9cDFDBx5FeXQPLzTj0Oqv2WBsrwrTjQrQeOk+y
 5iOA==
X-Forwarded-Encrypted: i=1;
 AL+hErHkGshse1OT+dhIrWLd7t9/j5VzdqZsGi3s2FuagbWfhYp+0Ybb1kjj8wKwRTSXu/8VJ56hpIjKxtc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9UfsgIpjKif8sG7le7UVuFn35NtXdAi3v0KrH51/TiMtdwGO7G
 b39VwKR+f7zK9uusmiYdg4VC6thaklqouYk/OH6ncLLsGYc0v9C/vHrQ
X-Gm-Gg: AZFdTZcv5vc4Bv7FrU8RLrjlqoMV5IJLXtLRVxKXIQwhF6TcEr6CnFCE5xk2FsyW1zu
 2Kqlv8f00AZWKMLLaep0qA2ufQ9V3M7HBNcnzYNFgEnB5Z5mQS0yWQ7I9u6RiEar6SX3E9tZi+0
 1P5J7P0dxElCpiigWC/hBkJIbdhNafBy46d8M8tURX/FOBXdgELFm6Khj6f32wRLGuRv5Zrhrsa
 /GBgRBLBt+5dk7orrKMTxhfk+X2DRL1l+5RTC8kaVuzn6kDpN2yAfgbSQby0Q38oZbybnZjSXdD
 Zfs1ahCxfT0cnp3JxquGNfOZ3cdk3nv+QbHlZhji1WZB010sSWI1aIIPxna1fdQZeznN9SSOZpB
 9poq1WYGLpMlsrsmeFqXXjZc/IPyc9g4zgNZXLqzCc/Sqpw1asLY05+/lJ6x/FvfbVUccAw+Zoj
 vypN1o3veOwJLL5ZF1uuDtOhH3mZwkBxhD+/WlDk1qtFg8R5a/OwR+dsLD6fPDYXoEzMXLbXOy7
 Q6MjO86p3+XqeSZGSbYdpCzMuEMEgJL0jyDyQu9+zDKB0q8UE6E0fGQCrfze1do0pXyDf7bpfIe
 N95h9LDv7PG5zYL+6zgLZiOnWog2fMw9bwNzFA/Kbg2iLbuz1zE5c6K3IDLk3oiLqBIgWGhu2qi
 Js9/fYwcazxKNR1np90k5LT0vanncuZpJZVEKoGLi0yHLHdiJwr9sqkUfXkyZNw==
X-Received: by 2002:a17:90a:d44b:b0:3ab:884b:65ab with SMTP id
 98e67ed59e1d1-3b3d07c2479mr1638407a91.55.1794986695524; 
 Tue, 17 Nov 2026 23:24:55 -0800 (PST)
Received: from lwq-System-Product-Name.. ([2602:feda:30:cafe:ec49:29ac:0:f6])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3d56ee297sm934947a91.4.2026.11.17.23.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 23:24:55 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: jeff.hugo@oss.qualcomm.com,
	ogabbay@kernel.org
Cc: carl.vanderlip@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jacek.lawrynowicz@linux.intel.com, quic_pkanojiy@quicinc.com,
 stanislaw.gruszka@linux.intel.com
Subject: [PATCH] accel/qaic: drain the control workqueue before the device is
 freed
Date: Wed, 18 Nov 2026 15:24:48 +0800
Message-Id: <20261118072448.1259909-1-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:23:05 +0000
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

Fixes: c501ca23a6a3 ("accel/qaic: Add uapi and core driver file")
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
---
Prepared against v7.4-rc1-1969-g666539eecdf4.

AI assistance: the analysis, the change and its review notes were
prepared with Claude (Anthropic) as a coding assistant.  The author
reviewed the reasoning and takes responsibility for the content.

Testing: compile tested only (arm64, gcc 11.4).  No QAIC hardware was
available, so the teardown race was not run.
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

