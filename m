Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA7DC79F99
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 12:41:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBE0D10E382;
	Sun,  6 Sep 2026 12:41:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dMZ0Axdf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C08310E382
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 12:41:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C49B4142C;
 Sun,  6 Sep 2026 12:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918011F00A3A;
 Sun,  6 Sep 2026 12:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788698464;
 bh=U3JfcolKhWuGBZd+pPAMx4DP4zPhwZzJyNp/2+tGFjM=;
 h=From:To:Cc:Subject:Date;
 b=dMZ0AxdfxbfX8Qw/W+iVl5jpZfJh0lDCrVd9YIeeLAR/EKex0xTIIw9Ozz7tWe6AK
 Mfas/DjLnBGb5MD63ScSzkCeM98s8EA2vmcK2VhaPDAymDcjyW4omsX1tJhh2zKeZG
 5nRHGw0gCFbziweExGJKEcatTGoDn95az90obMWbb2s7+WWIOiXdYugcWtop/dTGLY
 X6WPbzBKLWQSs4jKGquOlOjsiAPgbJ8yRqYEikx9bW8qtMBMtSw8TwhtMNPJYKvOeG
 VIcJJMKZGk0ZVS7Xhp4NkNDPUNDMjVtFcyeMz4sqzvPrL9TVovVNeUrwlsCRR/wBxj
 37pXN5oDqo4SQ==
From: Leon Romanovsky <leon@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Logan Gunthorpe <logang@deltatee.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2] dma-buf: Document how exporters and importers agree on
 mapping lifetime
Date: Sun,  6 Sep 2026 15:40:54 +0300
Message-ID: <20260906-document-dma-buf-v2-1-942710fe82c6@nvidia.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260820-document-dma-buf-3f8b41e32f57
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: quoted-printable
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

From: Leon Romanovsky <leonro@nvidia.com>=0D
=0D
Nothing in DMA-buf declares whether a mapping may be moved or taken away.=0D
Nearly every callback on both sides is optional, so the answer follows=0D
from which ones are implemented and from whether dma_buf_pin() succeeds.=0D
Documentation/ says none of this, and the rules sit in the kdoc of=0D
dma_buf_ops.pin, dma_buf_attach_ops.invalidate_mappings and=0D
dma_buf_invalidate_mappings(), which a driver author has to know by name=0D
before finding them.=0D
=0D
Describe the three flows an importer has to handle, the callbacks each=0D
one asks of both sides, and dma_buf_pin() as the runtime negotiation.=0D
=0D
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>=0D
---=0D
Let's try this variant from importer POV.=0D
=0D
Thanks=0D
=0D
Changes in v2:=0D
- Split pci p2p documentation patch to separate series=0D
- Improved dma-buf documentation patch.=0D
- Link to v1: https://patch.msgid.link/20260825-document-dma-buf-v1-0-5ecfb=
3e1371c@nvidia.com=0D
---=0D
 Documentation/driver-api/dma-buf.rst |  6 ++++=0D
 drivers/dma-buf/dma-buf.c            | 69 ++++++++++++++++++++++++++++++++=
+++-=0D
 2 files changed, 74 insertions(+), 1 deletion(-)=0D
=0D
diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/driver-ap=
i/dma-buf.rst=0D
index 2f36c21d9948..39c201f38aa6 100644=0D
--- a/Documentation/driver-api/dma-buf.rst=0D
+++ b/Documentation/driver-api/dma-buf.rst=0D
@@ -113,6 +113,12 @@ Basic Operation and Device DMA Access=0D
 .. kernel-doc:: drivers/dma-buf/dma-buf.c=0D
    :doc: dma buf device access=0D
 =0D
+Mapping Lifetime Negotiation=0D
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~=0D
+=0D
+.. kernel-doc:: drivers/dma-buf/dma-buf.c=0D
+   :doc: mapping lifetime negotiation=0D
+=0D
 CPU Access to DMA Buffer Objects=0D
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=0D
 =0D
diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c=0D
index d504c636dc29..aa47142cd9ed 100644=0D
--- a/drivers/dma-buf/dma-buf.c=0D
+++ b/drivers/dma-buf/dma-buf.c=0D
@@ -684,7 +684,74 @@ static struct file *dma_buf_getfile(size_t size, int f=
lags)=0D
  *    reference acquired with dma_buf_get() by calling dma_buf_put().=0D
  *=0D
  * For the detailed semantics exporters are expected to implement see=0D
- * &dma_buf_ops.=0D
+ * &dma_buf_ops. Whether the exporter may still move or take away the back=
ing=0D
+ * storage after step 3 depends on what both sides implement. See the mapp=
ing=0D
+ * lifetime negotiation section below.=0D
+ */=0D
+=0D
+/**=0D
+ * DOC: mapping lifetime negotiation=0D
+ *=0D
+ * Nearly everything in DMA-buf is optional. No flag or enum says whether =
the=0D
+ * exporter may move or take away the backing storage while an importer ho=
lds=0D
+ * a mapping. Each side simply implements the callbacks it can offer, and=
=0D
+ * dma_buf_pin() settles the result at runtime.=0D
+ *=0D
+ * Out of that optionality the importer sees three main flows. They are na=
med=0D
+ * from the importer's point of view, because each one demands a different=
=0D
+ * capability of its hardware:=0D
+ *=0D
+ * - Pinned: the memory is never taken away. The importer offers no way=0D
+ *   to stop DMA.=0D
+ * - Revoked: the storage never moves, but the exporter may take it away. =
The=0D
+ *   importer must be able to stop DMA, and may hit user visible errors wh=
ile=0D
+ *   doing so.=0D
+ * - Movable: the exporter may relocate the storage at any time. The impor=
ter=0D
+ *   must be able to pause DMA, and must raise no error while the storage =
is=0D
+ *   moving.=0D
+ *=0D
+ * An importer reaches its flow like this:=0D
+ *=0D
+ * 1. Attach with dma_buf_dynamic_attach(). Leaving out the optional=0D
+ *    &dma_buf_attach_ops.invalidate_mappings callback pins the buffer for=
 as=0D
+ *    long as the attachment exists.=0D
+ * 2. Call dma_buf_pin() under the reservation lock.=0D
+ * 3. On failure, run the movable flow or give up.=0D
+ * 4. On success, the flow is the revoked one if the optional=0D
+ *    &dma_buf_attach_ops.invalidate_mappings is implemented, and the pinn=
ed=0D
+ *    one if it is not.=0D
+ *=0D
+ * Pinned flow:=0D
+ *=0D
+ * - Exporter: implement &dma_buf_ops.pin and &dma_buf_ops.unpin to hold t=
he=0D
+ *   storage still on request. An exporter whose storage never moves imple=
ments=0D
+ *   neither, and dma_buf_pin() then succeeds on its own. An exporter whic=
h=0D
+ *   refuses to be pinned implements &dma_buf_ops.pin and fails it.=0D
+ * - Importer: nothing more. The mapping stays valid until the importer un=
maps.=0D
+ *=0D
+ * Revoked flow:=0D
+ *=0D
+ * - Exporter: answer dma_buf_pin() as above. Call=0D
+ *   dma_buf_invalidate_mappings() when the storage goes away and fail=0D
+ *   &dma_buf_ops.map_dma_buf while it is gone. The two waits which comple=
te a=0D
+ *   revocation are described in dma_buf_invalidate_mappings().=0D
+ * - Importer: &dma_buf_attach_ops.invalidate_mappings has to unmap within=
=0D
+ *   bounded time and drop the pin.=0D
+ *=0D
+ * Movable flow:=0D
+ *=0D
+ * - Exporter: call dma_buf_invalidate_mappings() before each move, then w=
ait=0D
+ *   for the &dma_buf.resv fences. &dma_buf_ops.pin and &dma_buf_ops.unpin=
 play=0D
+ *   no part here.=0D
+ * - Importer: hold no pin. &dma_buf_attach_ops.invalidate_mappings drops =
the=0D
+ *   cached mapping and has to lead to dma_buf_unmap_attachment() within=0D
+ *   bounded time. It need not stop the hardware, because access runs unti=
l the=0D
+ *   importer's &dma_buf.resv fences retire. The importer maps again befor=
e the=0D
+ *   next DMA.=0D
+ *=0D
+ * &dma_buf_ops.attach is the best place for an exporter to turn an import=
er=0D
+ * away, because the importer can still fall back to another flow and atta=
ch=0D
+ * again.=0D
  */=0D
 =0D
 /**=0D
=0D
---=0D
base-commit: 63367df6e7255067ad6a83abe0d2799dfa491876=0D
change-id: 20260820-document-dma-buf-3f8b41e32f57=0D
=0D
Best regards,=0D
--  =0D
Leon Romanovsky <leonro@nvidia.com>=0D
=0D
