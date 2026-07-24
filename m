Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F13C53209
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 07:29:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A51C810F2F6;
	Fri, 24 Jul 2026 07:29:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.b="ImOl3V+3";
	dkim-atps=neutral
X-Greylist: delayed 65036 seconds by postgrey-1.36 at gabe;
 Fri, 24 Jul 2026 02:30:10 UTC
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FB1110E644
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 02:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1784860168;
 bh=OyqXJDBODKL4i9r4faSbxqKqbqbjK9rOASLwkWPXzB4=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=ImOl3V+3qmGjRisyVUVd9mh2AZ0NFSJDdEzDIqUpNvqoNTKhOzOi6KGDffGACMmtR
 Ieie27rcygsxcHg/b5/K/9wRnsRHf46IlOy9eN5HlR7Vl9LPGQaDr1c7Xc6lm8x8IL
 1q3YhVXJS2PN8fyIiZ8h9JL89x+DGRIhNn+dO7mU=
X-QQ-mid: zesmtpip4t1784860161t8fb1ed23
X-QQ-Originating-IP: aBJCglJ9q/YAKBS1d2e+RK0bytOzmdANKIZ+RTuS4uM=
Received: from localhost.localdomain ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 24 Jul 2026 10:29:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 645947347967007313
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
Subject: [PATCH v2 5/6] lib/test_hmm: remove dead NULL checks after GFP_NOFAIL
 allocations
Date: Fri, 24 Jul 2026 10:28:50 +0800
Message-Id: <20260724022851.466017-6-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260724022851.466017-1-gouhao@uniontech.com>
References: <20260724022851.466017-1-gouhao@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: Np0qb5kW85KCuNY3xhEmso47MerfeFTbCZJksQvsspwKG4y8W/dSUAIJ
 o6T2XrDMq8Ny079obbh/15my0oIoTTh5Al/5YBcUGt1SrNHpB6XoRjGZn4I4WIyKhhQD4yp
 wL7/KGUC/5HnZgk+vOC85+Q85wemSC5rwAmNTgxHO7VYvN0cbzDl2XaE7anozmElgRsHxf4
 SwBbBLKDAjZ1hFTffhFP4yPGT4YkayfvoNQSJ96qgKuempHLdy2lFVVGVe7OyvFR0+LrhL1
 ow+Vo3ryePzZI3ZLJBQdS8lOFHch9FxLyJMvSvLYvRNHYGtHA25tDAXaOcGLpPPQ4QEAl3u
 AK7wV3wid9+QuzR+YvEtHrxFoI2XUqVcO9kduuOyGFn1f1A5wASrI+Ms4zuS/Qnmelfqud/
 hgYdWPHGXnp0/5S5Yg3VyTODWbxn8UHMMoNG/FT/DOSmXvldmRiF+zGVPRBlFtFiMqIAUeb
 OMmn4w8UzEAzQuF217Yxnw3q0NJQiTrfhEMHDYpn6qTYy+iaFCxRxcZgZtAO3Tt2xvePc5Z
 Lk1hCqd+HruliBG0wIkiLet8vYVKF4RdemSAmTH55HCPsppaGOIVJA9VhhItBk7q9HPaw/b
 Hon3kA/KYYZxnEBPN2I8+q/ZX/BNjpUy3l+yOTTIG5YJPdZ0YyZjowrqehl/g0j+qVOhSD8
 /eiMyMQarJTFCaV2KE+vYEu5CsF1e4HQVL6BblgB2mb8xSkEIpXhSaJVgkz5ewZP2EFRhAI
 zsV3vbv9d/s+fVkcqmgTpBjo9ZX+XK+B/oKLOEiukvTtTVhnOJfa8xTSbQyzPIo9DBlAhDF
 9Occ8f3ZhFpGklfTu/PjRRvVRW2vrzD+Bk7oy9yvaapbDkuvlp3glUjr7ijgZGub/muIQ+y
 KALgB9mmIAVqAAud3IYSLDySzrSR8e9/BzO/NzCILP+7UnYh3EC6ZhjxgYy6Zsq82jTY73c
 7jdM0SZuDPpkNmKdllRZ34UEXgpDAGb7FLqqSgZab6AJk32fR8DaSerg3iBO4YIhirJwqzb
 X7WJrXUhAh9+l/6CovzVRJbyG4pgo0bAMZaK7aCOJDJPqcIXXWJ9HDz1tdfGY=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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

kvcalloc with the __GFP_NOFAIL flag will never return NULL, so the
subsequent NULL checks are unreachable dead code. Remove them.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 lib/test_hmm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 9c59d1ceb5b57..d615e4e5fc447 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -1209,16 +1209,10 @@ static int dmirror_migrate_to_device(struct dmirror *dmirror,
 	if (!mmget_not_zero(mm))
 		return -EINVAL;
 
-	ret = -ENOMEM;
 	src_pfns = kvcalloc(PTRS_PER_PTE, sizeof(*src_pfns),
 			  GFP_KERNEL | __GFP_NOFAIL);
-	if (!src_pfns)
-		goto free_mem;
-
 	dst_pfns = kvcalloc(PTRS_PER_PTE, sizeof(*dst_pfns),
 			  GFP_KERNEL | __GFP_NOFAIL);
-	if (!dst_pfns)
-		goto free_mem;
 
 	ret = 0;
 	mmap_read_lock(mm);
-- 
2.20.1

