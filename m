Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED965606A32C
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 18:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58BB710E45C;
	Sat,  7 Nov 2026 18:42:53 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F376810E45C
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 18:42:51 +0000 (UTC)
Received: from [172.100.0.8] (unknown [36.110.52.2])
 by APP-05 (Coremail) with SMTP id zQCowABnArgnce9qi1yKAA--.6774S2;
 Sun, 08 Nov 2026 02:42:47 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH v2] firmware/sysfb: Fix device reference count leak in
 sysfb_disable()
Date: Sat, 07 Nov 2026 17:05:00 +0000
Message-ID: <1794071765.2669957.4378216502938475@iscas.ac.cn>
In-Reply-To: <2d89b88f-863c-4e8d-839c-5e800b4c4902@suse.de>
References: <20260916073815.1972045-1-vulab@iscas.ac.cn> =?utf-8?q?=3CBN9PR1?=
 =?utf-8?q?2MB5146B7A8975825C3623CFF97F7B92=40BN9PR12MB5146=2Enamprd12=2Epro?=
 =?utf-8?q?d=2Eoutlook=2Ecom=3E?=
 <2d89b88f-863c-4e8d-839c-5e800b4c4902@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABnArgnce9qi1yKAA--.6774S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4UtF1Dtr1kWrykKw13CFg_yoW5WF18pr
 4fGFW5trWDGF429a1UuF10ya4YyFn7Aa4rCr1kJFyruwn8JryI9r1xtFyrWF1UArZ5GF1F
 qF4Yqw18CF4UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvv1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
 w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
 IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
 jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4
 CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
 JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64
 vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
 7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
 1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
 14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
 IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
 87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
 IFyTuYvjfUruWLUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwMEA2rvPodDrwABsS
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Thomas, Alex,

Sorry for the very late reply, and thanks for the review.

Alex, you asked whether sysfb_unregister() would still need to be called
when the parent device lookup returns an error. It does: without a known
parent we cannot tell whether the system framebuffer belongs to the
calling device, and leaving it registered could make sysfb interfere with
the native driver. Thomas, that is the defensive behaviour you suggested,
so v2 unregisters unconditionally when sysfb_parent_dev() fails and only
drops the reference on the non-error path.

The reference leak fix itself is unchanged.

From 8c5f084941a3b6aca5d3ae8cff0c3bd1d4ae1e6f Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Sat, 7 Nov 2026 17:02:27 +0000
Subject: [PATCH v2] firmware/sysfb: Fix device reference count leak in
 sysfb_disable()

sysfb_parent_dev() returns a pointer to &pdev->dev with an acquired
reference when it finds the PCI device that contains the system
framebuffer. sysfb_disable() never drops that reference, so a reference
to the PCI device is leaked on every call that resolves a parent.

Release the reference with put_device() before leaving the critical
section.

If the parent device cannot be determined, unregister the system
framebuffer unconditionally, as it might still belong to the calling
device. Leaving sysfb registered in that case can make it interfere
with the native driver.

Fixes: b49420d6a1ae ("video/aperture: optionally match the device in sysfb_disable()")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Sorry for the late reply.
- Unregister the system framebuffer when the parent device lookup fails,
  as pointed out by Alex Deucher and Thomas Zimmermann.

Disclosure: the candidate was found with our static analysis tooling, and
the audit and the fix were assisted by DeepSeek and GPT 6.1 sol.
---
 drivers/firmware/sysfb.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index 8833582c1883..4cd6e9f86962 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -71,10 +71,20 @@ void sysfb_disable(struct device *dev)
 
 	mutex_lock(&disable_lock);
 	parent = sysfb_parent_dev(si);
-	if (!dev || !parent || dev == parent) {
+
+	/*
+	 * If the parent device cannot be determined, unregister the system
+	 * framebuffer unconditionally. It might belong to the calling device
+	 * and would otherwise interfere with the native driver.
+	 */
+	if (IS_ERR_OR_NULL(parent) || !dev || dev == parent) {
 		sysfb_unregister();
 		disabled = true;
 	}
+
+	if (!IS_ERR(parent))
+		put_device(parent);
+
 	mutex_unlock(&disable_lock);
 }
 EXPORT_SYMBOL_GPL(sysfb_disable);
-- 
2.34.1

