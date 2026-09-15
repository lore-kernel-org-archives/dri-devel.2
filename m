Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885F2C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 04:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3BE810F2EE;
	Tue, 15 Sep 2026 04:14:38 +0000 (UTC)
X-Greylist: delayed 358 seconds by postgrey-1.36 at gabe;
 Tue, 15 Sep 2026 04:14:37 UTC
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 063E910F924
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 04:14:36 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAB3TvLExKhqehYICA--.49463S2;
 Tue, 15 Sep 2026 12:08:37 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: dri-devel@lists.freedesktop.org
Cc: farah.kassabri@intel.com, koby.elbaz@intel.com,
 konstantin.sinyuk@intel.com, linux-kernel@vger.kernel.org,
 ogabbay@kernel.org, lkml@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>,
 stable@vger.kernel.org
Subject: [PATCH 1/4] accel/habanalabs: fix ctx refcount leak in hl_direct_io()
 on vzalloc failure
Date: Tue, 15 Sep 2026 04:08:08 +0000
Message-Id: <20260915040808.1724806-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAB3TvLExKhqehYICA--.49463S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4DWFyfAry3Zw18Jw4DXFb_yoW8Gw4DpF
 WDKFySyr9xG342ga4jvF1kuFyFkanxKry3GF129w45ur1rX34xZFy5u3Wqqrn8CrZ5C3Wq
 vF1kGryru3WUArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
 6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
 AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
 c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
 AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
 Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1go2U
 UUUUU==
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwELA2qowpAKpgAAsy
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

hl_direct_io() takes a reference on the context through
hl_dio_get_iopath() before allocating the bio vector.  If vzalloc()
fails, the function returns -ENOMEM directly instead of going through
the cleanup label, so the context reference taken by
hl_dio_get_iopath() is never released by hl_dio_put_iopath() (and the
inflight IO counter is left incremented).

Jump to the cleanup label so the iopath reference is dropped and the
counter balanced on the failure path too.

Fixes: 8cbacc9a2703 ("accel/habanalabs: add NVMe Direct I/O (HLDIO) infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/accel/habanalabs/common/hldio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/common/hldio.c b/drivers/accel/habanalabs/common/hldio.c
index c33c817a962a..0577dd8ec59d 100644
--- a/drivers/accel/habanalabs/common/hldio.c
+++ b/drivers/accel/habanalabs/common/hldio.c
@@ -248,8 +248,10 @@ static ssize_t hl_direct_io(struct hl_device *hdev, struct hl_direct_io *io)
 	 * closest one.
 	 */
 	io->bv = vzalloc(npages * sizeof(struct bio_vec));
-	if (!io->bv)
-		return -ENOMEM;
+	if (!io->bv) {
+		rc = -ENOMEM;
+		goto cleanup;
+	}
 
 	for (i = 0, device_va = io->device_va; i < npages ; ++i, device_va += PAGE_SIZE) {
 		io->bv[i].bv_page = hl_dio_va2page(hdev, io->f.ctx, device_va);
-- 
2.34.1

