Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FFD606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PQFSPnoN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65668112D40;
	Fri,  6 Nov 2026 13:25:42 +0000 (UTC)
X-Greylist: delayed 368 seconds by postgrey-1.36 at gabe;
 Fri, 06 Nov 2026 13:25:35 UTC
Received: from mta0.migadu.com (out-13.mta0.migadu.com [91.218.175.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFDE8112D40
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:25:35 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=KO2+Pw/HQKx0a4JyoCFPhhmUGDsn7IBoIsdjd3UIB1k=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793971533; v=1; x=1794576333;
 b=PQFSPnoNzHAiK8C0ha2wMPDCe8EgkinhHoB2lN9gggtMmINvwj0B/eNLEo9Xj2PuSxwffJbA
 qc0KuyTrjbYEgw2Tr7PmN0xL0VCes7PXUHW46zqlXy2zJokg4O8UGBTWlCxN4IQf/IvWf5QSouU
 rSg4CSlXxQT31FvEFrcgm+QI=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 99a7a9ba11e11fd9;
 Fri, 06 Nov 2026 13:19:24 +0000
X-Mizu-Trace-ID: 99a7a9ba11e11fd9
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: akpm@linux-foundation.org, dgilbert@interlog.com, mkp@kernel.org,
 loberman@redhat.com, jmeneghi@redhat.com, kraxel@redhat.com,
 vivek.kasireddy@intel.com, mst@redhat.com, jasowangio@gmail.com,
 eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
 rostedt@goodmis.org, vdonnefort@google.com, mhiramat@kernel.org,
 jgg@ziepe.ca, kevin.tian@intel.com, axboe@kernel.dk
Cc: linux-mm@kvack.org, James.Bottomley@HansenPartnership.com,
 sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org,
 joro@8bytes.org, will@kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 iommu@lists.linux.dev, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, bobbyeshleman@meta.com,
 mathieu.desnoyers@efficios.com, robin.murphy@arm.com, mason@kernel.org,
 aesteve@redhat.com, tjmercier@google.com, harry@kernel.org, vbabka@suse.cz,
 cui.tao@linux.dev, cuitao@kylinos.cn
Subject: [PATCH 1/7] scsi: sg and st: account the command buffer memory to
 memcg
Date: Fri,  6 Nov 2026 21:18:23 +0800
Message-ID: <20261106131829.3228926-2-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106131829.3228926-1-cui.tao@linux.dev>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tao Cui <cuitao@kylinos.cn>

The sg data buffers are unaccounted: the per-fd reserved buffer, the
scatter-gather page array, and the order-0..N pages behind it, plus the
per-device tape buffer in st.  All of it is user controllable.  The
reserved size is capped only by the device max_sectors, SG_MAX_QUEUE
(16) commands can be in flight per fd, and the fd count is bounded by
RLIMIT_NOFILE.  Nothing is charged to the memcg of the process driving
it.  The September 2026 fixes in sg_build_indirect reshaped the element
sizing and left the accounting alone.

Mark these allocations __GFP_ACCOUNT so the driving process pays for
the memory it induces.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 drivers/scsi/sg.c | 23 ++++++++++++++++++++---
 drivers/scsi/st.c |  7 ++++---
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 6551f1284d44..9c1414479b21 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -911,6 +911,19 @@ static int put_compat_request_table(struct compat_sg_req_info __user *o,
 }
 #endif
 
+/*
+ * The sg passthrough of the blktrace ioctls has the same exposure as the
+ * block device path: holding the node is the only requirement today, and
+ * a created trace outlives the fd.  Must match the gate in
+ * blk_trace_ioctl().
+ */
+static bool sg_is_blktrace_cmd(unsigned int cmd)
+{
+	return cmd == BLKTRACESETUP || cmd == BLKTRACESETUP2 ||
+	       cmd == BLKTRACESTART || cmd == BLKTRACESTOP ||
+	       cmd == BLKTRACETEARDOWN;
+}
+
 static long
 sg_ioctl_common(struct file *filp, Sg_device *sdp, Sg_fd *sfp,
 		unsigned int cmd_in, void __user *p)
@@ -920,6 +933,9 @@ sg_ioctl_common(struct file *filp, Sg_device *sdp, Sg_fd *sfp,
 	Sg_request *srp;
 	unsigned long iflags;
 
+	if (sg_is_blktrace_cmd(cmd_in) && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
 				   "sg_ioctl: cmd=0x%x\n", (int) cmd_in));
 	read_only = (O_RDWR != (filp->f_flags & O_ACCMODE));
@@ -1829,7 +1845,7 @@ static int
 sg_build_sgat(Sg_scatter_hold * schp, const Sg_fd * sfp, int tablesize)
 {
 	int sg_bufflen = tablesize * sizeof(struct page *);
-	gfp_t gfp_flags = GFP_ATOMIC | __GFP_NOWARN;
+	gfp_t gfp_flags = GFP_ATOMIC | __GFP_NOWARN | __GFP_ACCOUNT;
 
 	schp->pages = kzalloc(sg_bufflen, gfp_flags);
 	if (!schp->pages)
@@ -1844,7 +1860,8 @@ sg_build_indirect(Sg_scatter_hold * schp, Sg_fd * sfp, int buff_size)
 	int ret_sz = 0, i, k, rem_sz, num, mx_sc_elems;
 	int sg_tablesize = sfp->parentdp->sg_tablesize;
 	int blk_size = buff_size, order;
-	gfp_t gfp_mask = GFP_ATOMIC | __GFP_COMP | __GFP_NOWARN | __GFP_ZERO;
+	gfp_t gfp_mask = GFP_ATOMIC | __GFP_COMP | __GFP_NOWARN |
+			 __GFP_ACCOUNT | __GFP_ZERO;
 
 	if (blk_size < 0)
 		return -EFAULT;
@@ -2134,7 +2151,7 @@ sg_add_sfp(Sg_device * sdp)
 	unsigned long iflags;
 	int bufflen;
 
-	sfp = kzalloc_obj(*sfp, GFP_ATOMIC | __GFP_NOWARN);
+	sfp = kzalloc_obj(*sfp, GFP_ATOMIC | __GFP_NOWARN | __GFP_ACCOUNT);
 	if (!sfp)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index e9d41e3cc2dd..b92633ab2757 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -4074,7 +4074,7 @@ static struct st_buffer *new_tape_buffer(int max_sg)
 {
 	struct st_buffer *tb;
 
-	tb = kzalloc_obj(struct st_buffer);
+	tb = kzalloc_obj(struct st_buffer, GFP_KERNEL_ACCOUNT);
 	if (!tb) {
 		printk(KERN_NOTICE "st: Can't allocate new tape buffer.\n");
 		return NULL;
@@ -4083,7 +4083,8 @@ static struct st_buffer *new_tape_buffer(int max_sg)
 	tb->use_sg = max_sg;
 	tb->buffer_size = 0;
 
-	tb->reserved_pages = kzalloc_objs(struct page *, max_sg);
+	tb->reserved_pages = kzalloc_objs(struct page *, max_sg,
+					  GFP_KERNEL_ACCOUNT);
 	if (!tb->reserved_pages) {
 		kfree(tb);
 		return NULL;
@@ -4109,7 +4110,7 @@ static int enlarge_buffer(struct st_buffer * STbuffer, int new_size)
 
 	max_segs = STbuffer->use_sg;
 
-	priority = GFP_KERNEL | __GFP_NOWARN;
+	priority = GFP_KERNEL | __GFP_NOWARN | __GFP_ACCOUNT;
 
 	if (STbuffer->cleared)
 		priority |= __GFP_ZERO;
-- 
2.43.0

