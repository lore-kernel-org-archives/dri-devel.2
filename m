Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59374C531FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 07:28:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DDEE10F2E6;
	Fri, 24 Jul 2026 07:28:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.b="Thpc9fD+";
	dkim-atps=neutral
X-Greylist: delayed 65408 seconds by postgrey-1.36 at gabe;
 Fri, 24 Jul 2026 02:29:45 UTC
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91C1010F277
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 02:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1784860149;
 bh=XcvnlsC3HhT/It5VuOwr2y7sGHW1GiSiBgnaGk3guqk=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=Thpc9fD+snLZvia4IvIECJR4/9ngZ61H2O5O1Og1QqoADevADqPMz/Bq1/8BXRRWz
 JCrXR8+gXkama1LSqp+3/GKFYENpvhaX29P6kuiuDXji9ZyCg63LOcE/Yq33QZNkGR
 BEJyJj84Px6hBhmJtbdXUe181psxM+dEj5Zv63ag=
X-QQ-mid: zesmtpip4t1784860141tf7457151
X-QQ-Originating-IP: mFrNixuyb/9G3t9a9hZZYveY0Gmd34ZMyBS60EAtLAY=
Received: from localhost.localdomain ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 24 Jul 2026 10:28:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9941543075585726979
EX-QQ-RecipientCnt: 26
From: Gou Hao <gouhao@uniontech.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 bharat@chelsio.com, jgg@ziepe.ca, leon@kernel.org,
 akpm@linux-foundation.org, gouhao@uniontech.com, namcao@linutronix.de,
 ynorov@nvidia.com, sshegde@linux.ibm.com, nilay@linux.ibm.com, clg@kaod.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, gouhaojake@163.com, kernel@uniontech.com
Subject: [PATCH v2 1/6] powerpc/xive: remove dead NULL check after GFP_NOFAIL
 allocation
Date: Fri, 24 Jul 2026 10:28:46 +0800
Message-Id: <20260724022851.466017-2-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260724022851.466017-1-gouhao@uniontech.com>
References: <20260724022851.466017-1-gouhao@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: OZlI6rIAaqeCVBIJuOg6pSyzi2+V+qNJtXg/EdBlSl5leSYjAVpsVf8P
 4gyphOqRJvHke/U8z2EiQrL16xMAWfhmMUqq+TndOPgznxr06vEKPDe30trkjzQgYhatzsr
 5EWcCTo/4tCi71Ycj3WwxK7f8BDVkizacgveBvZfPt4kPmIV//9FJF3sGBTIqpkRl/CDlVp
 is36P/De2EY5WFqUpIeD4Mj9v3YZ/G2DlHEYq+Wu7DYYdEtwofDtFtWSnrIpm9ZmAOPBGJ3
 O54a2Fj7goQL6dvay0Hr+aokTz6bEl8yApWha629eIaTs2uC4k2eABDIfBpYrlhw0Ee38k5
 lUnc5X6RbtTrUOjZyH3IDIhaAEW+oajchAvV8DAFGM65I5uHsrZYlclgKw0BuXOa5wxk80h
 ET5+zJRwE3tcbTq7OkP4O6/tYyDNiJyvxIPYYQAFTJxTx4loS1ChCMXh0A521nldbTCMyb6
 GYUpqE0OMhErjLdM/QgdlzaWDVmwkO1+LOWGI4zM0pIgu2uApw85BbMPHWmQS03hLZYkX1E
 3BewGtX94DlAWLKO9MLUOyuGto14uP6RcrCK8NSWARq2WmBIpIQGqCZL6X43aNEX9InnX/8
 c/L7X7IxLZZ06t2orM+8oDo7r1PIJzuQKtedEiSIOosysnhRkU9Y+mQRJYlhzQG/h/j8lTe
 piMlo5t7UMX6SyfK8bAUXhqMtab/tpHOG5WkaZWqA98hh7+fPIvmwcKd6j9+YxdK5YRE70e
 OYG1EIkTAceKxm8wFX7ZcJbTKz2r1kuGTPhU66xnL1PcaN76+o9CwwpNEb1FAxvJFd1rLsi
 M6FW/6HIkHVfdjBLkNBWl5HvomQrtqrtELzNhmnAl58WO8tz5xZAPfqgDhH4wJQGwuDMQo8
 uQqtawgJiLOxXeKKH7OcskceNBA150RA3DvxqUKou79x7vnA70zxReWm/6B68gVDfoa+s7s
 T9MBcUDpmB2wgZAxz+Yy5GgJkIL/KyHa7j8514qvmq2kchkYiTZC7eGm5kIPfgsWZGrcv5Q
 I0LkxYTCDPyzYm6FQlq9bATbaDqPHB8iHmhYwZ5c/uXXx/F5tmqqhvGZnHb+NV/L/LHpXTW
 YCFIdp4JpzG83IydauxFhw=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Fri, 24 Jul 2026 07:28:31 +0000
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

kzalloc_objs with the __GFP_NOFAIL flag will never return NULL, so the
subsequent NULL check is unreachable dead code. Remove it.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
Reviewed-by: Wentao Guan <guanwentao@uniontech.com>
Reviewed-by: jiazhenyuan <jiazhenyuan@uniontech.com>
---
 arch/powerpc/sysdev/xive/common.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index dadd1f46ec939..f2904a5c2b7bf 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1134,9 +1134,6 @@ static int __init xive_init_ipis(void)
 
 	xive_ipis = kzalloc_objs(*xive_ipis, nr_node_ids,
 				 GFP_KERNEL | __GFP_NOFAIL);
-	if (!xive_ipis)
-		goto out_free_domain;
-
 	for_each_node(node) {
 		struct xive_ipi_desc *xid = &xive_ipis[node];
 		struct xive_ipi_alloc_info info = { node };
@@ -1158,7 +1155,7 @@ static int __init xive_init_ipis(void)
 
 out_free_xive_ipis:
 	kfree(xive_ipis);
-out_free_domain:
+	xive_ipis = NULL;
 	irq_domain_remove(ipi_domain);
 out_free_fwnode:
 	irq_domain_free_fwnode(fwnode);
-- 
2.20.1

