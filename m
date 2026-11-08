Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5796606A31C
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 07:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=ChHBQSFD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KB1oFD/x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BF7210E3AC;
	Sun,  8 Nov 2026 07:06:39 +0000 (UTC)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6663910E3AC
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 07:06:20 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id E5AC31D000D6
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 02:00:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Sun, 08 Nov 2026 02:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1794121220; x=
 1794207620; bh=6rGVUa+CyQ5+8OE1lg9RqFmhgqn4N3N/qaz4m3cLuMg=; b=C
 hHBQSFDn/kV236uLe15oy5JFDL6sFxb4Sd/cTxl9qA4XEDu6c/tlLSOxrAyjoFG/
 DQ3uGq09Geb4hAE+NnPUmR+6CeXYF+2FPBg29Aef2ceKPVkJvaoTOo174cA29ZT9
 y8wrGYb+xxESLELoQG8YnccHRUMG9d3ljKFFstuuQfWu64P1NNzhY6cJtr/mBcAg
 yQhvw5s9z8N9JT4VxgF3W0xmDrp+JHBl74TaehtPX8nJMRO+ZCOvesS1+f795VZL
 vTWtcYrtO0MDWMa7gYvs4UadWbmLjdV9aMojinxEMHA71adoRPp/2P9MLredrJM6
 /GWYqANutTHa5FhNBQvJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1794121220; x=1794207620; bh=6
 rGVUa+CyQ5+8OE1lg9RqFmhgqn4N3N/qaz4m3cLuMg=; b=KB1oFD/xUpG5KsGBU
 GSeQpBhFoaMnOB2i7ELK/HphG0vGPoWWo2nw3eg7J3NM0HjWP/6Fb9gVazF0IRJ1
 I6hAvUSmgn2quHkcTk5vWaAoJCYxssj3zM+lcri7x1H4X3gQvTq26B5oqK3rP7Sp
 ZMFZeGKItVfqpw1Y8p8lOMeipO7BGzm4TiHXfm62daqS8wOtx9YiiaRd8ruJK+0X
 0Ayyg530CvRTFx8zsZU0jcjWKFWM39rvxzbHLFjaJjDuk2av59Vj2Nq30VDKDncR
 mNGfkd+jBWg28DfHmtVYiyNUnHE67oA3PuKwNjlAqzYKLMFOP+cvDfIQn26Zj3Lr
 UQVIg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794121220; d=gahingwoo.com;
 mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:AxaiWkuFUAYUweXxHt3h+aq8s6pBkqY4NlfnwvJNkutsg6M
 pYiJZIZ6wKOpxCKdyihkahsWj3x9oNDwX13E2C/A5P/F1xfGPzyXCBCe6DEmCNYd
 m2NqzHeFQDPTHaEcUu41x671zVb5Eapo/m+1E/5+QKfutmKPDYnVprfRaqB8e49J
 i6owICK/81b8zSGyRKYniupiNvTpy97gG0kS5kK1KIattM1QEndYrQHMP0IOunje
 gbo8aolapI7C08IiD3nMR5ZI1ySM4avA0atQtATbAK+rxvGZa0PNxc5pZPgFFEk8
 ep3LpDwwZMv7MQt4x9F8MgfG/1Z/dUYmgn0RFqQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:KSJ+rX/WU7s5r3p9C9QBvEFpFsrkJxqxj1NdHkYMHgo=:aLGKxOhk/Y5O51G6Z2X6eFH/ptjQRlHxYL48BlDz94k=;
X-ME-Sender: <xms:BB7wajl1AgOqaBTytaQbx0ExFoToF9y7efuU1kPLBKyjX8nfqJyXQA>
 <xme:BB7wajSgeN8bl3acuyjrv8vohYhRP85zQxa1jwAthiHeh_4RBYZJthazkvK0b_BvV
 qsEpxvQp8uNW7gQZM5XwKCRcJI7Gch6fYnnL_SiH8er3oRtIrrNYcqD>
X-ME-Received: <xmr:BB7wag45GVlEbyv7BJ5LaL1Jb7lPwBemZfFhznA9io3HFtaEJYJHY7HNsl3iN0rmKbybuaH5>
X-ME-Proxy-Cause: dmFkZTEojRzwG8iXRxYpa/ehTSrYvEGv2oLw/Sk/XkMhq5fX7wZiH3xNi1i0ePqUksiFNz
 sCK5tgn3drkA0GtZvSRZKNCREkKgu/YMGTTKzlUjMYOltePFLEn+es0ErbEI87KjVOcqOy
 mJZ8Y9WoBILSXaY0XWkvqHJyxkZjLtwvzmsA/lOvpFWhD7iZIxn8BM8zTXzZDCDvthlILm
 FlZT/QuuevvKq197qlFGbgWkjTdBS5qUbMOigtsa22hAV8v3lOMNUn1gIhhZdPwhpoOUHq
 yOFXOpYOVuwQ8q1j3LqMXoUd7NYjCYyYc3T8lblVK3pqWZ0wyQS6WwTyQ4N1Z0W2O8eMAc
 FTaw9OjoXOh02DbnZdrI669OxVzlXEUQnEHYZoOREn84oF43kx5S1hxoQ55L2zZP0S9P8i
 IYpCYNbSHB6BRQZ1PyQZKmhKeYO6fZSnh5M8WzzxQrXPmNILP1YbdnPqG7wsWdiZA+sSEx
 mF37kg4lsW6RAVwNe/agSFxScYHTxNTyYmReIJ48sMRYXu44wVKz+ywA5AGhprrJ0/OoPZ
 tJKdAK15kKr2wj2OmUt4YmKxlazKqLaLGzxk88MnxotiF4pfYmBkuwdux+lKAXuEU1jAad
 T+DRYXTEuC32S8v8mXnF6scAlcq59rSV6mU12rlz+ElLcfk7ppQPiIotlSsQ
X-ME-Proxy: <xmx:BB7waiH7PBOdPKDjTKuw-TH2Ff8EJnH-saXy16V9QgNDf5vkU6vh1Q>
 <xmx:BB7waiH45W6a6U2NeSLmizL1B1JNIuiPeEqfgMVQYDpTFnIuvjTazQ>
 <xmx:BB7wagtDxIcz4HefRIvDg0qrNYYIcG_yJPMug9-CBO4UeVfQyKHucw>
 <xmx:BB7waoJi0k_3QuG2EqI8WkEpomvqAapdfz8H5ExD5_QLOXwsyDf5ww>
 <xmx:BB7waqMJkZX3cjftF5cpv3vgA_PWFGxneohIKH5JV0tjIRGnmMW1gYO_>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 02:00:12 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 shawn.lin@rock-chips.com, finley.xiao@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 jeff.hugo@oss.qualcomm.com, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v16 03/16] accel/rocket: wait for a running IRQ handler before
 resetting a core
Date: Sun,  8 Nov 2026 19:59:04 +1300
Message-ID: <20261108065917.135194-4-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108065917.135194-1-gahing@gahingwoo.com>
References: <20261108065917.135194-1-gahing@gahingwoo.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_sched_stop() does not wait for a threaded IRQ handler that is already
running, so call synchronize_irq() after it to make sure the handler has
finished before the reset.

Before synchronize_irq(), mask the interrupt and clear the raw status, so
that the NPU core cannot report a completion afterwards.

Do this under job_lock, because the submit path sets the interrupt mask
under the same lock.

Only touch these registers when the device is powered: check with
pm_runtime_get_if_active(), so that a register access with the power
domain off cannot raise an SError.

Suggested-by: Igor Paunovic <royalnet026@gmail.com>
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2
---
 drivers/accel/rocket/rocket_job.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 03e5f094f60b..abef12b86d48 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -400,6 +400,16 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
 
 	drm_sched_stop(&core->sched, bad);
 
+	scoped_guard(mutex, &core->job_lock) {
+		if (pm_runtime_get_if_active(core->dev) > 0) {
+			rocket_pc_writel(core, INTERRUPT_MASK, 0x0);
+			rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
+			pm_runtime_put_autosuspend(core->dev);
+		}
+	}
+
+	synchronize_irq(core->irq);
+
 	/*
 	 * Remaining interrupts have been handled, but we might still have
 	 * stuck jobs. Let's make sure the PM counters stay balanced by
-- 
2.43.0

