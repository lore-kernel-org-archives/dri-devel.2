Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA5CCA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 07:24:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA6E110F1EF;
	Tue,  6 Oct 2026 07:24:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fkFKqvXk";
	dkim-atps=neutral
Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com
 [74.125.228.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B78710E245
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 09:56:01 +0000 (UTC)
Received: by mail-ej2-f41.google.com with SMTP id
 a640c23a62f3a-c2e028ed54dso254867966b.1
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 02:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791194160; x=1791798960; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JwlAWAAy7BYUoB7+a9T937QVUxmXXORCOGD20YZnv/k=;
 b=fkFKqvXkvhSo2W4uO1EAoAVcXiVBHT5VQkhIjUjmA1nu4qQi7aABZgmSHj6H75qpyj
 OsyMxV2IGyKU7qmiMi8PPWO1F+0SUmayTSG3qc4hwMvrchlTNOOaobKywjVeJUjLz2zm
 xA+KXcJi+rVPaICni95y9jcK5+7ELR2JVx+Aot7rxTKKAMgdzxgemScXtFEZyEOdvbj3
 iCf1YP12uPmBCeNX5zgPuS791ishta1XEfnIxjN3iHs7HYIufUcTVdLCm4Y1Ww3SStJb
 yLlxzXMAt1BZJXjpAwOsyS7g4ih6TXceaMWCsac/TbXS2CnWg0jr+0DHprwpItrhWapz
 9tmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791194160; x=1791798960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JwlAWAAy7BYUoB7+a9T937QVUxmXXORCOGD20YZnv/k=;
 b=PVS8pFV7v8TNMP2ZH86kRrpEQnAhh1yrpUwuplNP38D0dA82wHAUybrYWY5nEiqyVE
 6cEqIt90kAs5mbABeEGsl3cJzCowW7wPd520KUHw12xce6Wm3i6mSVZNmH9Yj1oP9GWE
 BaaTY5SaalNp3tUWTWIV/gVrywpcJ6IzJfuKnSxL+52LkW/ubPoWk/QVJRdfCAgxf7Sd
 1IY5mXR8MAu4h4TKM14cX9X6WpFMZp6L5jxu092R+OscT1U3GOJFqn3BI2leOwz0iA/l
 UtS+C/9WQrb61i3erj8OGEn4mETQ3/mk7xta+MbPQmlHyGj0EuPtB8pkCqZp91fF9hTZ
 J/aA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+zi+UVi2AjaJwLBIaafLWmYPXqNfZ7H9Tbi2qsg4lI4RDhuF72p4hGk7hkEt0PiL3tzuSmwIVcSI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lZli0x/tKgzCoMxltAbXBIBMhCwWU06qnyktIc3GO6LiqAT9MU
 29vzxbmMp/iO3WdWkdkJreSsZesKv9+hO6PUGalwqY9YkyD1FwHMlEWn
X-Gm-Gg: AYBFou0nEtx5z0RMOqab2eq3OsknJU6l3LWc25QlsV/yVtVjX5j64iHu8dJbfSE9Zu7
 JlsGbVwuBShKFGYL1ZWMY0MqnqErbIz+gIvvDbzM7J19uoX3bwHGrJAy6dl+2+F6gGKBXh18tTQ
 pEg1B3Wj/HJwmtWI58CdFqiC/and/8zqkdw4saWjNU5W7IhKn2luIGXaRqsUvmgGwRvnRvB1B/m
 tIfLO9+CjbLYBUTYQwc/MUP7k9jg03p9PKR2dO96jwlgKiWmVlDtnbVS1EsE2/xKoUJDFUk0Nbr
 d+fT05fWP/31y7rUtqgsi+2m+fpY2tgx/mxc9VosIeea4ax3LuzK5L0CAOk5B3VhO7wE7ICUBpF
 3fNkuMhojNTarAMWiT3PAJ9ihCq3TeFd3uCLSNddDnFik5J1Twev0t7kySOjG+et8qDgsmmiYQA
 eRPt7Xv+ecGQbXhoBpLLsSHrJ59Yz2kIbudWsHqhsMkioswxXcOw7WEX3ZD3vSKhcxlMWEfpp/J
 TtMAMGeziR4dyGtx16PcS9Nfs8PcRCTTlTiwDyFyOQTr6lWSDP7d4Ga1zV08Dfa8ONF8fE6nva1
 68fWmQ8kiAxKHADuNuJT4WXSd2It3Kmr7BMutyxmKVmd2w==
X-Received: by 2002:a17:907:6d11:b0:c25:2688:8212 with SMTP id
 a640c23a62f3a-c2e4a6a273emr858285166b.0.1791194159542; 
 Mon, 05 Oct 2026 02:55:59 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com
 (54-240-197-234.amazon.com. [54.240.197.234])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31562aba16sm50753266b.23.2026.10.05.02.55.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 02:55:59 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oupton@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
 Ackerley Tng <ackerleytng@google.com>, Joey Gouly <joey.gouly@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Steffen Eiden <seiden@linux.ibm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>, Alex Williamson <alex@shazbot.org>,
 Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org
Subject: [RFC PATCH 4/6] dma-buf: Allow dynamic attach without a device
Date: Mon,  5 Oct 2026 09:55:50 +0000
Message-ID: <20261005095552.52748-5-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005095552.52748-1-griffoul@gmail.com>
References: <20260720111259.122911-1-dwmw2@infradead.org>
 <20261005095552.52748-1-griffoul@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 06 Oct 2026 07:24:11 +0000
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

From: Fred Griffoul <fgriffo@amazon.co.uk>

dma_buf_dynamic_attach() requires a struct device: the device for which
the buffer is mapped for DMA. Exporters may also check it before they
accept the attachment. An importer that does not perform DMA has no
such device. iommufd already attaches with a global placeholder device
for this reason. KVM would need one too, although it only needs to know
where the memory is so that it can map it into a guest.

Allow @dev to be NULL for a dynamic importer. Such an importer learns
where the memory is from get_phys() and builds its own mappings. It
must not map the attachment for DMA, and dma_buf_map_attachment()
refuses an attachment without a device. An exporter that needs a device
to answer can refuse the attachment in its attach op, as it can for any
other reason.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 drivers/dma-buf/dma-buf.c      | 15 +++++++++++++--
 include/trace/events/dma_buf.h |  2 +-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index e7010163eb2f..3d43b529a523 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1007,6 +1007,13 @@ dma_buf_pin_on_map(struct dma_buf_attachment *attach)
  * Note that this can fail if the backing storage of @dmabuf is in a place not
  * accessible to @dev, and cannot be moved to a more suitable place. This is
  * indicated with the error code -EBUSY.
+ *
+ * @dev may be NULL for a dynamic importer that is not a DMA master: one that
+ * only asks the exporter where the memory is, through &dma_buf_ops.get_phys,
+ * and builds its own mappings from the answer.  Such an importer must never
+ * call dma_buf_map_attachment(), and an exporter that needs a device to
+ * answer (a peer-to-peer check, say) refuses the attachment in its
+ * &dma_buf_ops.attach.
  */
 struct dma_buf_attachment *
 dma_buf_dynamic_attach(struct dma_buf *dmabuf, struct device *dev,
@@ -1016,7 +1023,7 @@ dma_buf_dynamic_attach(struct dma_buf *dmabuf, struct device *dev,
 	struct dma_buf_attachment *attach;
 	int ret;
 
-	if (WARN_ON(!dmabuf || !dev))
+	if (WARN_ON(!dmabuf || (!dev && !importer_ops)))
 		return ERR_PTR(-EINVAL);
 
 	attach = kzalloc_obj(*attach);
@@ -1175,6 +1182,9 @@ struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *attach,
 
 	if (WARN_ON(!attach || !attach->dmabuf))
 		return ERR_PTR(-EINVAL);
+	/* An importer without a device cannot be a DMA master. */
+	if (WARN_ON(!attach->dev))
+		return ERR_PTR(-EINVAL);
 
 	dma_resv_assert_held(attach->dmabuf->resv);
 
@@ -1847,7 +1857,8 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
 		attach_count = 0;
 
 		list_for_each_entry(attach_obj, &buf_obj->attachments, node) {
-			seq_printf(s, "\t%s\n", dev_name(attach_obj->dev));
+			seq_printf(s, "\t%s\n", attach_obj->dev ?
+				   dev_name(attach_obj->dev) : "none");
 			attach_count++;
 		}
 		dma_resv_unlock(buf_obj->resv);
diff --git a/include/trace/events/dma_buf.h b/include/trace/events/dma_buf.h
index 3bb88d05bcc8..7cabca53b798 100644
--- a/include/trace/events/dma_buf.h
+++ b/include/trace/events/dma_buf.h
@@ -40,7 +40,7 @@ DECLARE_EVENT_CLASS(dma_buf_attach_dev,
 	TP_ARGS(dmabuf, attach, is_dynamic, dev),
 
 	TP_STRUCT__entry(
-		__string(	dev_name,			dev_name(dev))
+		__string(dev_name, dev ? dev_name(dev) : "none")
 		__string(	exp_name,			dmabuf->exp_name)
 		__field(	size_t,				size)
 		__field(	ino_t,				ino)
-- 
2.47.3

