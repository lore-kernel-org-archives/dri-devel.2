Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A45F532DE
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 06:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93F6310E0DF;
	Tue, 24 Mar 2026 06:02:37 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E70C10E0DF
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 06:02:32 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.202])
 by APP-03 (Coremail) with SMTP id rQCowABXZ87vKMJpkdyiCw--.45232S3;
 Tue, 24 Mar 2026 14:02:25 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>
Subject: [PATCH -next v2 1/2] drm: verisilicon: add max cursor size to HWDB
Date: Tue, 24 Mar 2026 14:02:21 +0800
Message-ID: <20260324060222.2029061-2-zhengxingda@iscas.ac.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260324060222.2029061-1-zhengxingda@iscas.ac.cn>
References: <20260324060222.2029061-1-zhengxingda@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXZ87vKMJpkdyiCw--.45232S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWrAFW5GFWxCF4DWr1ftFb_yoW8uw1kpF
 47tryDWa98Ja13trn7J3y2gFyfCas5JaySgryrK34F9rs0gayUXa43Ca4YkFZ5tr1xAryY
 qF4v9rW3Cr4IyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUm014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
 x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
 A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
 0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
 IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
 Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
 xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
 JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
 kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
 6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
 vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
 vjDU0xZFpf9x0JUqkskUUUUU=
X-Originating-IP: [112.94.102.202]
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
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

Different display controller variants support different maximum cursor
size. All known DC8200 variants support both 32x32 and 64x64, but some
DC8000 variants support either only 32x32 or up to 256x256.

The minimum size is fixed at 32 and only PoT square sizes are supported.

Add the max cursor size field to HWDB and fill all entries with 64.

Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
Changes in v2:
- Added a comment about the cursor being square.

 drivers/gpu/drm/verisilicon/vs_hwdb.c | 4 ++++
 drivers/gpu/drm/verisilicon/vs_hwdb.h | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.c b/drivers/gpu/drm/verisilicon/vs_hwdb.c
index 09336af0900ae..2a0f7c59afa3a 100644
--- a/drivers/gpu/drm/verisilicon/vs_hwdb.c
+++ b/drivers/gpu/drm/verisilicon/vs_hwdb.c
@@ -95,6 +95,7 @@ static struct vs_chip_identity vs_chip_identities[] = {
 		.customer_id = ~0U,
 
 		.display_count = 2,
+		.max_cursor_size = 64,
 		.formats = &vs_formats_no_yuv444,
 	},
 	{
@@ -103,6 +104,7 @@ static struct vs_chip_identity vs_chip_identities[] = {
 		.customer_id = 0x30B,
 
 		.display_count = 2,
+		.max_cursor_size = 64,
 		.formats = &vs_formats_no_yuv444,
 	},
 	{
@@ -111,6 +113,7 @@ static struct vs_chip_identity vs_chip_identities[] = {
 		.customer_id = 0x310,
 
 		.display_count = 2,
+		.max_cursor_size = 64,
 		.formats = &vs_formats_with_yuv444,
 	},
 	{
@@ -119,6 +122,7 @@ static struct vs_chip_identity vs_chip_identities[] = {
 		.customer_id = 0x311,
 
 		.display_count = 2,
+		.max_cursor_size = 64,
 		.formats = &vs_formats_no_yuv444,
 	},
 };
diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.h b/drivers/gpu/drm/verisilicon/vs_hwdb.h
index 92192e4fa0862..2065ecb730437 100644
--- a/drivers/gpu/drm/verisilicon/vs_hwdb.h
+++ b/drivers/gpu/drm/verisilicon/vs_hwdb.h
@@ -20,6 +20,11 @@ struct vs_chip_identity {
 	u32 customer_id;
 
 	u32 display_count;
+	/*
+	 * The hardware only supports square cursor planes, so this field
+	 * is both the maximum width and height in pixels.
+	 */
+	int32_t max_cursor_size;
 	const struct vs_formats *formats;
 };
 
-- 
2.52.0

