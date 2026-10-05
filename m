Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30AFCA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 07:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3529110E1DC;
	Tue,  6 Oct 2026 07:24:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="afI3bcwM";
	dkim-atps=neutral
Received: from mail-ej2-f30.google.com (mail-ej2-f30.google.com
 [74.125.228.158])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B7D010E245
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 09:56:00 +0000 (UTC)
Received: by mail-ej2-f30.google.com with SMTP id
 a640c23a62f3a-c2a4fbc5586so273124766b.2
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 02:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791194158; x=1791798958; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lD6pTqRDMSfKXNqb4UUFNdsEKglv/1NbFFOX0KLFSbY=;
 b=afI3bcwMyADXlh1qp3RD1ioSrI3DsKtYQJau9v1gYZQwnxFihsy9FQhTiCAwYD9X65
 yLVTVBZuxOQdHD/RFFNPSr2XIXezPb4d2V+I2i+bxT13bqwxjQBZ198NRLzxOiKzkPrd
 TL+L2jzFFeVrrDEv7cqnQ2tMrz7P7mqrOAJ6CCYSb4YHIIdHqZ9s86rAr+c4t2H9tI/b
 sOUP3Gtsgs/1utc9/XpiGYo2nRR8VjoZKClBvI8cGX0gqKWj7D861jmwZYSn8Ec1Ibxd
 nRdhvYSMCNctZC7xCzYpXWcRdIDDFcJUPoCfgd4TpluNGfLATmLewU5cq2fCDe31Qosh
 PgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791194158; x=1791798958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lD6pTqRDMSfKXNqb4UUFNdsEKglv/1NbFFOX0KLFSbY=;
 b=V2cSaJaCOIMjOUB6FAxTFLgy7+YuWS1uIncGEEuf2dMlUv5HXB8VdXCm5uYfk2EAPR
 avErIoPbvZinVNBE0l/DCTtH7OMGTd4LpkcXsZQwTB+xKIRfYfDBiTg0Eu66jsWlY46z
 jVWAI4MR+iQA/dtHsdxMwgqxiUKg3eKENAFL8I92JRvvnxzoPi8Z/gMtLxs989PtO9kv
 NF0spwwRv/JXyxz8MpJH00szRYCNaslF1G0gV4Reu3xqOPddQ+ZzL8Wj6rQtzdzP/cKT
 zF0imjPf6gizBNfx0eFMjBlUHB4lPYRG4fVKWbX4BJAAz8T5vNeY+D2yHCKFdQx3RSA2
 f1aA==
X-Forwarded-Encrypted: i=1;
 AKwUvByAELNzQJFvPNNXmCoyBRFQZLe0SzpArNirnr0I7eWJ8TyVUCXr9CRndoYAJH/USn4fjrDhf20lDtE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK4432uME6d4ph6an3NgBkCARu4dAxzt7QdTSr+e7x6QtOvgK4N
 5yJEJb0xkf+7OSjaJqTy36QO8dEehCnZZqhVLWQX95Orfb1ptHpt5Mru
X-Gm-Gg: AYBFou3QI4HDjRTGIcMQnRqzg6vB4DAR6/HGmHQ+LanO1N51whUKTT7bnLtl7Rm7Osq
 HWrIikRHdkFGiP2mIiUg94FYy9/jZIDrbREyCOQDjlcEg4TcJR4YzXOcltdNcgOG/ss2p/R9DTM
 IRG7Ib0YhFxFDCAhhWWARnuGp0YWRdQdmJr4c3F8o2SG9IGQnUMHyZWy1O/G0us9jyHfc/PIRdl
 kMap3IcygyT4DyEtzGsRVGXl/euQ/Yh1U6DwHC1uVIo/yZvvTLn5CmwKg73rlcBc3Q5m0CQULe2
 kEcanyegwXBvCppBKM5Ozqa4kpjlaBpWNbstlg50JRB1zMMzK1ufEioaQKG/BCBq/gLCmlEY6UQ
 qP8knP1Mzi9uK7xaIQr1Lm93tafSrb69hvxqXGrj+lXE62N1a+YzJrfH4GR1OgWaxWAoBN1EdDf
 sGn3ExZTrB6I5PAoIkl9VvXr0MUSAVwM5QEbNrytuxvGRu5GwtCY3ZtIsecpTSDFF3GXSGyZoUi
 mISsKDKMG3CW5vuSW62lQZCEGYCsfEjpPGgMlN4IJm7yv8S7dg5YsDfLX+xnkMWsMccW4iqOIyO
 y88uYUKInUc2I+C4mwjWRTPCiPxwuaClUKE=
X-Received: by 2002:a17:907:3da3:b0:c2e:7fe7:288e with SMTP id
 a640c23a62f3a-c2e7fe736eamr411177566b.32.1791194158114; 
 Mon, 05 Oct 2026 02:55:58 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com
 (54-240-197-234.amazon.com. [54.240.197.234])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31562aba16sm50753266b.23.2026.10.05.02.55.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 02:55:57 -0700 (PDT)
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
Subject: [RFC PATCH 3/6] dma-buf: Add ranged mapping invalidation
Date: Mon,  5 Oct 2026 09:55:49 +0000
Message-ID: <20261005095552.52748-4-griffoul@gmail.com>
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

dma_buf_invalidate_mappings() tells every importer that the whole
buffer changed. An exporter that changes one part of its memory cannot
say which bytes changed, so importers throw away mappings that are
still valid.

Add an exporter helper that invalidates a byte range, and an importer
callback that receives it. The callback means that the address, the
attributes or the backing of the range changed. If part of the range is
no longer backed, get_phys() returns -ENOENT for it. Importers must stop
using their old answer before the callback returns. Importers that do
not implement the callback still receive a whole-buffer invalidation.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 drivers/dma-buf/dma-buf.c | 30 ++++++++++++++++++++++++++++++
 include/linux/dma-buf.h   | 16 ++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 66b85d53ed22..e7010163eb2f 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1389,6 +1389,36 @@ void dma_buf_invalidate_mappings(struct dma_buf *dmabuf)
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_invalidate_mappings, "DMA_BUF");
 
+/**
+ * dma_buf_invalidate_mappings_range - notify attachments that a range changed
+ * @dmabuf: buffer whose layout changed
+ * @offset: first changed byte
+ * @length: number of changed bytes
+ *
+ * Importers with a ranged callback stop using their old mappings of the range
+ * before returning. Other importers receive the existing whole-buffer
+ * callback, which is correct but coarser. The reservation lock must be held.
+ */
+void dma_buf_invalidate_mappings_range(struct dma_buf *dmabuf,
+				       unsigned long offset,
+				       unsigned long length)
+{
+	struct dma_buf_attachment *attach;
+
+	dma_resv_assert_held(dmabuf->resv);
+	list_for_each_entry(attach, &dmabuf->attachments, node) {
+		const struct dma_buf_attach_ops *ops = attach->importer_ops;
+
+		if (!ops)
+			continue;
+		if (ops->invalidate_mappings_range)
+			ops->invalidate_mappings_range(attach, offset, length);
+		else if (ops->invalidate_mappings)
+			ops->invalidate_mappings(attach);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_invalidate_mappings_range, "DMA_BUF");
+
 /**
  * dma_buf_get_phys - describe the run that starts at an offset
  * @attach: attachment to query
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index b223962e20c2..55c3fe60a0ba 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -485,6 +485,19 @@ struct dma_buf_attach_ops {
 	 * required behavior.
 	 */
 	void (*invalidate_mappings)(struct dma_buf_attachment *attach);
+
+	/**
+	 * @invalidate_mappings_range: [optional] a byte range changed
+	 *
+	 * The exporter changed the address, attributes or backing of
+	 * [@offset, @offset + @length). The importer must stop using its old
+	 * answer for that range before returning.
+	 * Importers without this callback receive @invalidate_mappings for
+	 * the whole buffer instead.
+	 */
+	void (*invalidate_mappings_range)(struct dma_buf_attachment *attach,
+					  unsigned long offset,
+					  unsigned long length);
 };
 
 /**
@@ -600,6 +613,9 @@ struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *,
 void dma_buf_unmap_attachment(struct dma_buf_attachment *, struct sg_table *,
 				enum dma_data_direction);
 void dma_buf_invalidate_mappings(struct dma_buf *dma_buf);
+void dma_buf_invalidate_mappings_range(struct dma_buf *dma_buf,
+				       unsigned long offset,
+				       unsigned long length);
 bool dma_buf_attach_revocable(struct dma_buf_attachment *attach);
 /* bits 0-7: memory type (a value, not flags) */
 #define DMA_BUF_PHYS_ATTR_TYPE_MASK	GENMASK(7, 0)
-- 
2.47.3

