Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E91CD98CE
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 16:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CFF210F017;
	Thu, 11 Jun 2026 16:46:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="OoHKPxa/";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4814910F004
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 16:46:16 +0000 (UTC)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BDxGLh2263096
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 09:46:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=042rDf1bYsfHgsRjwT/IB+2TVDBYS7DHhXWbJC6IyLg=; b=OoHKPxa/O6HZ
 xFD7XEF3eKFgswXMF+l90lAbUF9oUqooDQAD9HEf6Sc10ASDFiQNixKq4ZCt+04C
 lRQLwT9L3YtqA2kEtj0lJ1k0lm5ouI87jvV+M7OnaI9zCy/CgR+U7SCVggUQp4VT
 sm5YVRlMbEXrHYYl5F50hXK/dWekIlZy7tMsoyX8I39wEgiiHVselm9UeOOT51bY
 RVzcG/0LHbUMvZUsb1hBUPRqBGx0MQXz6NiA1s0vdjrCDfosZng3wPz5C/tr3ipz
 5kSUpQQ4MLIgszTN/CNzpjYNszU7sJd/syLXWkwMS9JBhCdWJ06wKKQ3SwAAxyr6
 BEDglh01UA==
Received: from mail.thefacebook.com ([163.114.134.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe7b6r0k-7
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 09:46:15 -0700 (PDT)
Received: from twshared22650.04.snb2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Thu, 11 Jun 2026 16:46:12 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
 id F12833DD363E2; Thu, 11 Jun 2026 09:23:43 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: <netdev@vger.kernel.org>
CC: <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v7 3/5] dma-buf: add optional get_tph() callback
Date: Thu, 11 Jun 2026 09:11:18 -0700
Message-ID: <20260611161546.4075580-4-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260611161546.4075580-1-zhipingz@meta.com>
References: <20260611161546.4075580-1-zhipingz@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE2OCBTYWx0ZWRfXzS+kuQQi1GOW
 0OpMJwsUXv7kiq0YhCFr+EOYw3k+iPEMhO0iQNrsKgMT1CGjOhjgiLZdkWWmLl2gpdKeMy5kKLv
 jdl3NjruQ+SNYOxWdF+Hj6DYtUVuVes=
X-Proofpoint-GUID: ZZawYA5V9W9rJRgUlvKVkp6YyiGtjJbY
X-Proofpoint-ORIG-GUID: ZZawYA5V9W9rJRgUlvKVkp6YyiGtjJbY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE2OCBTYWx0ZWRfX1y2QOwQonzgA
 lmnbyGh4KeaOrIpv6cg9jOpaImfDWPfjvtjt5NkkUQPwQTSB8JDvKlwkdYfhhINUdiNl5tXwbKR
 3hV7t1jRJSr96OgJQUvJwZW0K+MdoS/1D+IUH34HGJozb9iwtOAsBkngAiAVRhrKZWF1QH3RnJx
 epP7Rg+W1P92i8dr7wO5nt0nYc0uIrHuuCGoOVPoK6Mz2BvgdqD6sqOpSOzcRdzbihF4/Aegd+i
 KrcAV/gXPdFB+34Bl1K0tjQWjfXfgYRnapkr6UDs6jRFXt3fHNPoT0K+175inwtOo/nhSFyxiv6
 ODZv5iaSAOd5iN20J5zx+H83DtJNP4/Sv/cr/mxrpxK2AOsKJSxGTiv9mJ4dquVpVq8Z3wMmcM8
 e2WyfjFjZcDUO5iXevzHihWgfD4wpU3b2aw8tOTjdM5k6sdJptQzvU6TonFvupAmB77gU3p3XsF
 e8LZLoMGPCfpacOK4yg==
X-Authority-Analysis: v=2.4 cv=C8nZDwP+ c=1 sm=1 tr=0 ts=6a2ae657 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=xtH7KyWI9dI7BmFOsl-x:22 a=VabnemYjAAAA:8 a=DhvycHomHhz2uGJtbakA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
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

Add an optional dma_buf_ops.get_tph callback and a dma_buf_get_tph()
wrapper for importers.

8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces, so
the importer requests the namespace it can emit and the exporter
returns the matching ST/PH tuple or -EOPNOTSUPP.

dma_buf_get_tph() is the importer entry point. It returns -EOPNOTSUPP
when the exporter lacks the callback and requires dmabuf->resv to be
held while the callback runs.

The first user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with
mlx5 as the first importer.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/dma-buf/dma-buf.c | 25 +++++++++++++++++++++++++
 include/linux/dma-buf.h   | 21 +++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index d504c636dc29..aff79ea12e43 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1144,6 +1144,31 @@ void dma_buf_unpin(struct dma_buf_attachment *atta=
ch)
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
=20
+/**
+ * dma_buf_get_tph - Retrieve TPH metadata from an exporter
+ * @dmabuf: DMA buffer to query
+ * @extended: false for 8-bit ST, true for 16-bit Extended ST
+ * @steering_tag: returns the raw steering tag for the requested namespa=
ce
+ * @ph: returns the TPH processing hint
+ *
+ * Wrapper for the optional &dma_buf_ops.get_tph callback.
+ *
+ * Must be called with &dma_buf.resv held. Returns -EOPNOTSUPP if the
+ * exporter does not implement the callback or has no metadata for the
+ * requested namespace.
+ */
+int dma_buf_get_tph(struct dma_buf *dmabuf, bool extended,
+		    u16 *steering_tag, u8 *ph)
+{
+	dma_resv_assert_held(dmabuf->resv);
+
+	if (!dmabuf->ops->get_tph)
+		return -EOPNOTSUPP;
+
+	return dmabuf->ops->get_tph(dmabuf, extended, steering_tag, ph);
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_get_tph, "DMA_BUF");
+
 /**
  * dma_buf_map_attachment - Returns the scatterlist table of the attachm=
ent;
  * mapped into _device_ address space. Is a wrapper for map_dma_buf() of=
 the
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index d1203da56fc5..6a54e0f251a2 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -113,6 +113,25 @@ struct dma_buf_ops {
 	 */
 	void (*unpin)(struct dma_buf_attachment *attach);
=20
+	/**
+	 * @get_tph:
+	 * @dmabuf: DMA buffer for which to retrieve TPH metadata
+	 * @extended: false for 8-bit ST, true for 16-bit Extended ST
+	 * @steering_tag: Returns the raw TPH steering tag for the requested
+	 *                namespace
+	 * @ph: Returns the TPH processing hint (2-bit value)
+	 *
+	 * Return TPH metadata for the namespace selected by @extended. Return
+	 * 0 on success, or -EOPNOTSUPP if no metadata is available.
+	 *
+	 * This callback is optional. Importers must not call it directly;
+	 * the dma_buf_get_tph() wrapper is the only entry point and handles
+	 * the NULL-callback case. The callback is invoked with
+	 * &dma_buf.resv held.
+	 */
+	int (*get_tph)(struct dma_buf *dmabuf, bool extended,
+		       u16 *steering_tag, u8 *ph);
+
 	/**
 	 * @map_dma_buf:
 	 *
@@ -563,6 +582,8 @@ void dma_buf_detach(struct dma_buf *dmabuf,
 		    struct dma_buf_attachment *attach);
 int dma_buf_pin(struct dma_buf_attachment *attach);
 void dma_buf_unpin(struct dma_buf_attachment *attach);
+int dma_buf_get_tph(struct dma_buf *dmabuf, bool extended,
+		    u16 *steering_tag, u8 *ph);
=20
 struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_inf=
o);
=20
--=20
2.53.0-Meta

