Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A00606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.a=rsa-sha256 header.s=fm2 header.b=MG77vmyn;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=M0JZENms
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 947B410F9A3;
	Wed, 21 Oct 2026 09:36:24 +0000 (UTC)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2C8D10F9A3
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 09:36:13 +0000 (UTC)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C69B8140010D
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 05:36:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 21 Oct 2026 05:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:from:from:in-reply-to:message-id
 :mime-version:reply-to:subject:subject:to:to; s=fm2; t=
 1792575372; x=1792661772; bh=8Zx+C5d1JkNk/Z5XCoFYJ/7ryEqDN3JpmcB
 gMrUTPWg=; b=MG77vmynarq6066luAqJW8UkkcKc4yLXtQ8HTQ8dHTNXHPvD74m
 xJ4wVrRhcGQyD5pVTe7MrwM7+TeZzvpdVtjMlYKWT28ALXlezuuoSaxiqcTfzY5H
 mqNM43Rnil0GjrW2q/3NEr0XXPsC5VoxaJZQrn4Ad9VGQs2UaTUjxJG+GamgOfb3
 lih8ADXnYuBPBhKE+msRT138zutEDoyn4rdLpuDYnZdA6Too+9GhpSsZu+/gpwn7
 dWeRpd+0bI375xIwdo3UPnnOJNFGF+mIvXJE0LJNrE9FhJqSpPs2bvngtqx5jrS0
 PEtP0eBP8l6DjeYCiOJMZSkSOUnVhEncPUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1792575372; x=1792661772; bh=8Zx+C5d1JkNk/Z5XCoFYJ/7ryEqDN3JpmcB
 gMrUTPWg=; b=M0JZENms8eFz0hsopbfrKrD9ab3/DVT42ZglA9FhRiBf+1qYfuV
 phBk/P4iGVlvyLa8wlaOAvQiE8/6Y65OEFWanHuI8AifOx652JbLkvZorn1Ne5Tk
 i3/6wHqh22f4s+Ec9uFgst68dCBTxXRu/Du8BmKKBl5xs8My3xuMg8MGXM8SS+qc
 qNOtaBw6cSNNsrYJCOPTE1LBOZYxgnA8+IUBMrSVnUQpfLpLkpgC02J7ug1wotXP
 WdW4h/eNIU+rE0qB5rELlpGrzcfLZ6F3hMwJokEgKD8YU9iXDoSWfbzcFxt45eth
 rrysXIHHfXREpckkCIJ4AsVr3k3sw395S2Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=sign d=invisiblethingslab.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792575372; d=invisiblethingslab.com;
 mf=PHZhbEBpbnZpc2libGV0aGluZ3NsYWIuY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm2:rsa-sha256:Jaiv7IEFzoSM5IEHH1wkypIdx0hBerpmfQPfB1wNmC0IWZ+
 29zspJ5z8Dp2T8poRpzKBaxa0Sd0KYwm75KVr9qGufndYWekMkrSMGjwBgjjbNtG
 sqDYSqdbKySyhDJFksKqc2HkUrD4o2daFm2FXjpfsmysGXn7xxUC52u146Kb9qK4
 sTrm2zGHjNFkZ6gO24cbrdmJcsCtmC0EoGm/H2M6vJS05edlLucD4/GC8yqY/g63
 m6BUSs1bYATHYwKN70w2AS1yBBJ5P9PNWIt7ul4dSDZQCeASHdSAFEva7vwL5ARV
 nZV04MWEZ4oxzGMdkV++v8/yr45d86AFbh6uCdg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=mi-m=1; hc=9;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:XWbcEMqATNH16sDoz5i10t568sQmmwUzD30TNu+kPCU=:R5m8t4dm71B12YzFzaZCJNaMeQLSk5s5vf9VBDZueFI=;
X-ME-Sender: <xms:jIfYakxdgRqmvTLHr-hZSzYbX9brLbeQbbfMGIC5xHsJlOFe6dFyYg>
 <xme:jIfYaq3hqp-QPS0S0ZeVWLOy7fb-sB2r4TrmYfziJNU1cN-niMF031fGJmjmeg175
 uZNhckEuaN4dYMMQs5chEVtqp8_ORBKCbNDy_5vjxPrc9xsIa8s>
X-ME-Received: <xmr:jIfYap9ZHRtLi7HjsJ9QPryCREUydlNq0k92ioMQ1V6Mrywluq-ZWi5ZR-932NS-5tPQUaFqZkAEnyq8cFen2vCgTNbL66hdVwvWPTTn-mKTKrdaJ6l0YJZyTOEn7w>
X-ME-Proxy-Cause: dmFkZTE5p1LkTybyQvb4GLd2y6ERVZq6x/rhMFf20+Er02U+qmODkwgmuqAl5aXzoKWrsX
 iTfx7Or/klNatBO3jtTPknE4EIGBiY/MiKzDAE9BxZXeXkUrqR5xHlkvggHEJNenrm83bo
 b9EPOcLqbKB5uIf6ENT2MjVwFNhnPPrZqv3fbQOrb62xGLgzN/QYJG1wbhN7RK4GeMmSd4
 5YbpZlLgi03GDx0PtdHdaozzCYiKui8XKLdp1W5n+6G07cyKzma/ieIrKVEGEg91Yy4aY1
 N7TB2ohdGdPM7lu2KsXKzTI8xidKDaaCJrV7KMdlLr/HtWtaC/Q/kZlyXj5J6cbewzrbh/
 89i0ie3Fk1scyt0a5JAkulsaH4SYnl9B3xFKpVzPbfaFDBn/QlhlHvvhfKa3MJilV3EEGP
 UrQ0CSq7KwVpAQT0TdzaECii+IjAsOFW0l2oVUA/5Gn310vy10pTgLgAsWWCmasD37mvL7
 ZsOhBTNxndqIiW+LBL4lhqKxKKkgjQs2eLcPL5JFCRmj3N7yWFIlir0/uQ48QTNA86TUfs
 i7EO6H3/uQP5//4SEfTfnq7ZZ+Xjf3Xz2agBdSv6Vc3WnEb+K/4FSkqw1CqAWVYuArdkGT
 4vcL0qWCgNkni+FUQapPwVN/3xaHacu4IBTu+olG9RY44D96eP5KzgIGrMsQ
X-ME-Proxy: <xmx:jIfYaiq4JHhceenqMD5bXmeCqtYyjFwfTQuX9WtQT32KA10UoNpnMQ>
 <xmx:jIfYarRVUNnLmwatXE8EUiykkMSulUuk59eBLXfZe73Z1Z42bF0dGw>
 <xmx:jIfYatPrxd-ZQCdJRhi7tvY_LdPFLeo0-waCLlOV2CYDG3JH1P_r4A>
 <xmx:jIfYahj3r0IvjUNqT-0QKHmNg0StV5g3voWAE2W3FnmznBmZ4EY8OQ>
 <xmx:jIfYakLLB_9JwHHIJharIXe6WRapy5MqlQitMuYP-3QXo8VXW-3kAMRF>
Feedback-ID: i001e48d0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 05:36:10 -0400 (EDT)
From: Val Packett <val@invisiblethingslab.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>
Cc: Val Packett <val@invisiblethingslab.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] dma-buf: Add DMA_BUF_IOCTL_SET_RELEASE_EVENTFD
Date: Wed, 21 Oct 2026 06:08:46 -0300
Message-ID: <20261021093533.1990028-1-val@invisiblethingslab.com>
X-Mailer: git-send-email 2.55.0
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

Introduce a new ioctl that allows userspace to register an eventfd to get
notified when a dma-buf is released.

The current use case comes from virtio-gpu device backends wishing to add
support for guest-owned buffers with host handles (CREATE_GUEST_HANDLE):

* guest creates a guest-only blob resource on the virtgpu
* host creates a udmabuf from the iovecs sent by the guest
* guest attaches the resource to a cross-domain socket send operation
* guest immediately releases the resource (no longer needed by the guest)
* host sends the udmabuf to the compositor, but needs to delay responding
  to the resource release request until the resource is *actually* free
  on the host side, i.e. the compositor no longer uses it

Signed-off-by: Val Packett <val@invisiblethingslab.com>
---

More background on the use case with extra links:
https://lore.kernel.org/virtio-comment/20260903021442.423274-1-val@invisiblethingslab.com/

Funnily enough, gntdev-dmabuf (which is used on Xen hosts instead of
udmabuf for this) offers "a way" to "poll" for these release events
on its dmabufs (IOCTL_GNTDEV_DMABUF_EXP_WAIT_RELEASED), but it's unusable:

* it's a blocking wait!!
* release does not happen while you still have the fd open, so:
  * you can't just timeout and restart, you'd need the fd to restart;
  * and the only way to even close the fd is from a different thread,
    after some arbitrary timeout when hopefully the wait has started.

The buffer lifecycle coordination we need this for applies to KVM as well
and it generally doesn't make sense to have this as a provider-specific
thing since it's not related to the provider in any way, it's just
something we want from dmabufs in general.

Thanks,
~val

---
 drivers/dma-buf/dma-buf.c    | 24 ++++++++++++++++++++++++
 include/linux/dma-buf.h      |  3 +++
 include/uapi/linux/dma-buf.h |  1 +
 3 files changed, 28 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 36cdc342627e..1321fee73656 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -17,6 +17,7 @@
 #include <linux/dma-fence.h>
 #include <linux/dma-fence-unwrap.h>
 #include <linux/anon_inodes.h>
+#include <linux/eventfd.h>
 #include <linux/export.h>
 #include <linux/debugfs.h>
 #include <linux/list.h>
@@ -185,6 +186,11 @@ static void dma_buf_release(struct dentry *dentry)
 	if (dmabuf->resv == (struct dma_resv *)&dmabuf[1])
 		dma_resv_fini(dmabuf->resv);
 
+	if (dmabuf->release_eventfd) {
+		eventfd_signal(dmabuf->release_eventfd);
+		eventfd_ctx_put(dmabuf->release_eventfd);
+	}
+
 	WARN_ON(!list_empty(&dmabuf->attachments));
 	module_put(dmabuf->owner);
 	kfree(dmabuf->name);
@@ -537,6 +543,21 @@ static long dma_buf_import_sync_file(struct dma_buf *dmabuf,
 }
 #endif
 
+static long dma_buf_set_release_eventfd(struct dma_buf *dmabuf,
+					u32 fd)
+{
+	struct eventfd_ctx *ev_fd_ctx = eventfd_ctx_fdget(fd);
+
+	if (IS_ERR(ev_fd_ctx))
+		return PTR_ERR(ev_fd_ctx);
+
+	if (dmabuf->release_eventfd)
+		eventfd_ctx_put(dmabuf->release_eventfd);
+
+	dmabuf->release_eventfd = ev_fd_ctx;
+	return 0;
+}
+
 static long dma_buf_ioctl(struct file *file,
 			  unsigned int cmd, unsigned long arg)
 {
@@ -587,6 +608,9 @@ static long dma_buf_ioctl(struct file *file,
 		return dma_buf_import_sync_file(dmabuf, (const void __user *)arg);
 #endif
 
+	case DMA_BUF_IOCTL_SET_RELEASE_EVENTFD:
+		return dma_buf_set_release_eventfd(dmabuf, (u32)arg);
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index d15b2b31d3c9..07b4a589a793 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -429,6 +429,9 @@ struct dma_buf {
 
 		__poll_t active;
 	} cb_in, cb_out;
+
+	/** @release_eventfd: for userspace release notification */
+	struct eventfd_ctx *release_eventfd;
 };
 
 /**
diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-buf.h
index e827c9d20c5d..566dea778ad0 100644
--- a/include/uapi/linux/dma-buf.h
+++ b/include/uapi/linux/dma-buf.h
@@ -179,5 +179,6 @@ struct dma_buf_import_sync_file {
 #define DMA_BUF_SET_NAME_B	_IOW(DMA_BUF_BASE, 1, __u64)
 #define DMA_BUF_IOCTL_EXPORT_SYNC_FILE	_IOWR(DMA_BUF_BASE, 2, struct dma_buf_export_sync_file)
 #define DMA_BUF_IOCTL_IMPORT_SYNC_FILE	_IOW(DMA_BUF_BASE, 3, struct dma_buf_import_sync_file)
+#define DMA_BUF_IOCTL_SET_RELEASE_EVENTFD	_IOW(DMA_BUF_BASE, 4, __u32)
 
 #endif
-- 
2.55.0

