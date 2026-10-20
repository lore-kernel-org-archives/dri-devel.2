Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA7E606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=FXVIyKJz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D1010FAE2;
	Wed, 21 Oct 2026 08:51:52 +0000 (UTC)
X-Greylist: delayed 487 seconds by postgrey-1.36 at gabe;
 Tue, 20 Oct 2026 09:28:04 UTC
Received: from outbound.baidu.com (mx14.baidu.com [220.181.3.101])
 by gabe.freedesktop.org (Postfix) with SMTP id A579910F433
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 09:28:04 +0000 (UTC)
X-MD-Sfrom: zhangyili01@baidu.com
X-MD-SrcIP: 172.31.51.15
From: Yili Zhang <zhangyili01@baidu.com>
To: <zhangyili01@baidu.com>
CC: <alex@shazbot.org>, <ankita@nvidia.com>, <christian.koenig@amd.com>,
 <dri-devel@lists.freedesktop.org>, <leon@kernel.org>,
 <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <nicolinc@nvidia.com>,
 <stable@vger.kernel.org>, <sumit.semwal@linaro.org>,
 <dawid.osuchowski@linux.intel.com>
Subject: Re: [PATCH] dma-buf: Fix IOVA offset when linking phys vecs to sgt
Date: Tue, 20 Oct 2026 17:19:45 +0800
Message-ID: <20261020091945.27327-1-zhangyili01@baidu.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924065508.27245-1-zhangyili01@baidu.com>
References: <20260924065508.27245-1-zhangyili01@baidu.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc7.internal.baidu.com (172.31.50.51) To
 BJKJY-Exc19.internal.baidu.com (172.31.51.15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
 s=selector1; t=1792487994;
 bh=jwuobWmR9Q8VWmW6gJ1VH9w4uh3ahrR+9ZGTOu9b6cc=;
 h=From:To:CC:Subject:Date:Message-ID:Content-Type;
 b=FXVIyKJzDB3e0KVCtiGx959xnBdoaQzbcYeF0xFklPo2cEvtriOeYNd5IrgNMkF1d
 IAKFO/zJBDWBl0n70A+GzNAdfj/2HjR+eLgPGItBKd83V1lR6mrJlc83ag7Br5TTag
 uyUHm42oD5HvjFAPquChK4x9LGnYXuIFuiNtfuO1gRCIGjNM1izr+EGnnDz4x2arrh
 riMLqVUtiUSNIR73ylrMHBholtJoXMXFVmMMcE7/9S9GUHijhKBnot0Q6pAZfEI6E2
 EcUBienSyjF1JJ1D0kcBpRzKd6KuLdLvsMkfuRnGVXVI42jLm7dPfYjQ24ndqaRlk8
 7V6CMJDJQEn1Q==
X-Mailman-Approved-At: Wed, 21 Oct 2026 08:51:51 +0000
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Sumit, Christian,

Gentle ping on this patch.

It has two Reviewed-by tags from Dawid and Leon, but I don't see the fix in
v7.3. Since the 7.4 merge window is now open, could it be queued for v7.4?

I'm happy to resend with the collected Reviewed-by tags if that helps.

Thanks,
Yili
