Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB78C531CF
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:28:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E567310F11B;
	Thu, 23 Jul 2026 13:28:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.b="i+ls9Mc2";
	dkim-atps=neutral
X-Greylist: delayed 380 seconds by postgrey-1.36 at gabe;
 Thu, 23 Jul 2026 08:26:02 UTC
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36AB210F02B
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 08:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1784795144;
 bh=e6BVBwF2oSnNk0Jyon9PloP7eEkl7Bfr8eX/NbegyP0=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=i+ls9Mc2HrvDgyAEynEuy0u/RN5b07G14pa+YtgMkYUPbEldUk/z9t+2xiBCFTBXb
 HSI7SNUr02GOwOjRM44oyrLqpfha8+XVkRbrYfFqMihsyH9u5jBdcCMGRAJAbowPP+
 VsYejWsJMa8Qwd1xiiCRZgVEdIH2CkWH6Ym2yYeo=
X-QQ-mid: zesmtpip2t1784794697t42615382
X-QQ-Originating-IP: NWrmr4ibVq33NqKXMPStiRl7JDz4LdgCYIBewkjnVFM=
Received: from localhost.localdomain ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 23 Jul 2026 16:18:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6575503778562141203
EX-QQ-RecipientCnt: 26
From: Gou Hao <gouhao@uniontech.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 bharat@chelsio.com, jgg@ziepe.ca, leon@kernel.org,
 akpm@linux-foundation.org, ynorov@nvidia.com, namcao@linutronix.de,
 mkchauras@gmail.com, sshegde@linux.ibm.com, nilay@linux.ibm.com,
 kees@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, gouhaojake@163.com, kernel@uniontech.com
Subject: [PATCH 0/4] remove dead NULL checks after GFP_NOFAIL allocations
Date: Thu, 23 Jul 2026 16:18:09 +0800
Message-Id: <20260723081813.176792-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: NMB3uNxca02m93879V3HllBfmWcx5BuPQBHnSrzXePSMCJdzhmff3WFG
 E6cj+fXzrNE9uDOXP+UUChIk3uRlvv4HfXR4jcABuYTSj79h9pyipWrm3b4lPQ0sy1ynFsD
 B9E19ZL0zrtPJVP7qe+45e9RUEORHNKpLLTbX9FGBGHYTkVlGdW3stBnzI+vBr26Cb1hyuz
 9GcQbbzHcpjSysrR57uNRl5M8j729whSIRZ/wYhaH+MOakM8TWA6CotpNRsSE93hcY0TiMp
 ikwQBf3m5IablSHE8m7hbAd5MWn1JO189IGp0czkSnw6viBKgLTRWfVDiLDhaxMmo1vkvFn
 2gGmhBTS7sqKmWuz9PGIGUlBuG9F1LZdonv/SZWkpyOjtxTEDePan1GPcVdcYLkKn3cFrC8
 qzQn18evg/iquDhip2YdNO7hONofWX3YKunNLAzsNKL2ZmURARAuLLKqUwcWlXJ3DqMast3
 S9Zz8KerTfVvnR5Glld2qWMskUi0ObpvQ68aPGdJ9FSJI7tET5wAlTth21pZNdxVMItElvN
 f1oAscQnv9xku+JHFvtQUuNx15DqsTWTMNvEKwfQeqOwak6teYTL+piHApk2c3By2pTub+y
 lI948To8An50S1w7N9UEFvQ/vBbpimWqSoqHgP2yGaeGYcVSHJAJMnwDNt3wIToCAFBdBEf
 n19TnC3TpD/eupyEW2GhxQob/VtCqhwVblFHzumv37/2yiA+zG1CSZN8dYYyhb9kVezvvEA
 T41DB8x1JwwInhb33XDwRRtkfyvLFABpWPf0jchePCSb5OpezD/XQ7iV371BBnH7vDaR+Ag
 oSJj/9jwy+YCGBw22AeBN/jPrmjJv2NJXMuBN9MQ4om11N4mV/Sv0jLCUo6OPSVvTNztJdW
 d5IbSoYs0X3osEe+0OdUfw0wGVOF/tgWAoDLcCdEOtEpmyQ6a67muIYN10q1FYA9uSRcgf1
 Zy9qV8YoNxV3ohrxdkmov/pBVOT974wbDrZXTB/dpIzPWz8F8UgvuU/ACKwVdiPcqcyCTso
 0DPhlM00lz5AE+jJYV
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Thu, 23 Jul 2026 13:28:03 +0000
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

This is a code cleanup series that removes unreachable
NULL checks (and associated error handling) that follow allocations
using __GFP_NOFAIL, which guarantees non-NULL return.

Gou Hao (4):
  powerpc/xive: remove dead NULL check after GFP_NOFAIL allocation
  drm: remove dead WARN_ON NULL check after GFP_NOFAIL allocation
  lib/test_hmm: remove dead NULL checks after GFP_NOFAIL allocations
  RDMA/cxgb4: remove dead NULL checks after GFP_NOFAIL allocations

 arch/powerpc/sysdev/xive/common.c  |  3 ---
 drivers/gpu/drm/drm_modeset_lock.c |  4 ----
 drivers/infiniband/hw/cxgb4/mem.c  | 10 ++--------
 lib/test_hmm.c                     |  6 ------
 4 files changed, 2 insertions(+), 21 deletions(-)

-- 
2.20.1

