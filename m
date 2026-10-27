Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9659606A334
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 998AC10F323;
	Tue, 27 Oct 2026 09:32:00 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5C0110F2D4
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 09:09:32 +0000 (UTC)
X-UUID: 1987d506d1e611f19a56ed5b684f684d-20261027
X-CTIC-Tags: HR_CC_CHARSET, HR_CC_CHARSET_NUM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT,
 HR_CC_NAME
 HR_CC_NO_NAME, HR_CHARSET, HR_CHARSET_NUM, HR_CTE_8B, HR_CTT_MISS
 HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
 HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
 HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
 IP_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_EXISTED
 SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD
 CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI, GTI_FG_IT, GTI_RG_INFO
 GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:5f6cbece-d184-49ac-b33b-594d089d587c, IP:10,
 URL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
 ION:release,TS:10
X-CID-INFO: VERSION:1.3.19, REQID:5f6cbece-d184-49ac-b33b-594d089d587c, IP:10,
 UR
 L:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:10
X-CID-META: VersionHash:7db8b62, CLOUDID:e3a70b43f31232cc92f72e18734d7e70,
 BulkI
 D:261027170927OXGODN0I,BulkQuantity:0,SF:17|19|38|66|78|81|82|102|127|865|
 898,TC:nil,Content:0|15|50|99|100|102|151,EDM:5,IP:-2|1,URL:99|1,File:nil,
 RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,D
 KP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR, TF_CID_SPAM_FAS, TF_CID_SPAM_FSD,
 TF_CID_SPAM_IBB, TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1987d506d1e611f19a56ed5b684f684d-20261027
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.169)] by mailgw.kylinos.cn
 (envelope-from <liwang@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 995450277; Tue, 27 Oct 2026 17:09:22 +0800
From: Li Wang <liwang@kylinos.cn>
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 Li Wang <liwang@kylinos.cn>
Subject: [RFC PATCH v2 0/1] misc: fgds: introduce GPU-File direct I/O via
 dma-buf
Date: Tue, 27 Oct 2026 17:08:52 +0800
Message-Id: <20261027090853.30099-1-liwang@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908131545.105987-1-liwang@kylinos.cn>
References: <20260908131545.105987-1-liwang@kylinos.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
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
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch introduces a driver named fgds that allows moving data between 
a GPU dma-buf and a regular file on NVME without staging it through the 
page cache. This is particularly useful for LLM workloads, such as model 
loading, KV cache offloading, and checkpointing. The fgds device 
corresponds one-to-one with the PCIe GPU on the machine. The usage is 
straightforward: an application first calls ioctl on the corresponding 
fgds device with REGISTER_BUF, passing the target GPU memory buffer 
address (represented as a dma-buf fd). Subsequently, the application can 
perform direct data transfer between a regular file on NVMe and GPU memory 
by invoking ioctl on the fgds device with READ/WRITE, passing the file 
descriptor and the handle returned by REGISTER_BUF.

This solution allows both applications and the fgds device to work 
seamlessly with GPUs from different vendors without any modifications. 
Furthermore, applications no longer need to call vendor-specific 
proprietary APIs (such as NVIDIA's cuFile API) or install vendor-specific 
kernel modules (such as NVIDIA's nvidia-fs.ko) for different GPU vendors. 
We have tested fgds on NVDIA and AMD GPU cards, and theoretically, it also 
works on GPUs from other vendors that support exporting GPU memory via 
dma-buf. Some performance test results can be found in [1].

This implementation offers several advantages:
- Simplicity and Efficiency: It provides a lightweight and intuitive 
  interface. The single ioctl call mimics the parameter structure of 
  pread/pwrite, and its return value semantics are fully compatible with 
  pread/pwrite
- Isolation and Security: The interface is independent and has a minimal 
  impact scope. This isolation facilitates fine-grained permission control 
  on the device node, enhancing security management

Changes since v1:
- Refactor implementation per Christian's feedback, on top of Pavel's 
  DMA-buf support for io_uring [2]
- Add validation checks in the XFS I/O submission path to ensure that 
  bios with the REQ_DMABUF flag are only processed via direct I/O, and 
  prevents the kernel from attempting to fall back to buffered I/O, which 
  is incompatible with DMA-buf backed GPU memory regions. While currently 
  supports only XFS, the underlying mechanism is filesystem-agnostic and 
  can be adapted for other filesystems with similar minor changes
- Address the comments from Greg and the Sashiko AI

[1] https://github.com/Storage-and-OS-for-AI/fgds
[2] https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/
    tag/?h=for-7.4/io_uring-dmabuf-20261023

Mengmeng Zhao (1):
  misc: fgds: introduce GPU-File direct I/O via dma-buf

 .../userspace-api/ioctl/ioctl-number.rst      |   2 +
 drivers/dma-buf/dma-buf-io.c                  |   3 +
 drivers/misc/Kconfig                          |  16 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/fgds.c                           | 506 ++++++++++++++++++
 fs/iomap/buffered-io.c                        |  11 +
 fs/iomap/direct-io.c                          |  23 +-
 fs/xfs/xfs_file.c                             |   4 +
 include/linux/iov_iter.h                      |   4 +
 include/uapi/linux/fgds.h                     | 124 +++++
 lib/iov_iter.c                                |   1 +
 mm/filemap.c                                  |  22 +-
 12 files changed, 713 insertions(+), 4 deletions(-)
 create mode 100644 drivers/misc/fgds.c
 create mode 100644 include/uapi/linux/fgds.h

-- 
2.34.1

