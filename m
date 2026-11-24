Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5E3606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=FmBAPLPP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F222410F129;
	Wed, 25 Nov 2026 08:41:20 +0000 (UTC)
X-Greylist: delayed 480 seconds by postgrey-1.36 at gabe;
 Tue, 24 Nov 2026 08:51:38 UTC
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 559B910F37D
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 08:51:38 +0000 (UTC)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20261124084335epoutp0378f116da01da84f15e0af23bfa22fa36~q7qogInvm1692416924epoutp03d;
 Tue, 24 Nov 2026 08:43:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20261124084335epoutp0378f116da01da84f15e0af23bfa22fa36~q7qogInvm1692416924epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1795509815;
 bh=bv+w4SPqJHgJSc/Ri/nAxGFknxpTeekag4KmQjPOdAY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FmBAPLPP2mhGFVwNHvYu9RLbxnRYBoVw/8ymAq7p6DsxiuqRByG2O+15P/bQz45wH
 ONOcDc3+s/GAA8aVXLubnSYuAWzZF6xY/sedOKG3cCL32MYutURDGQnzSa2eejzxiF
 6GioVndOT2s5GhkSElScO45slA2g1jz2ijYeqjn0=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
 20261124084335epcas5p2c84e920886d69e131764edcb7537c200~q7qnxZ8BJ1183811838epcas5p2V;
 Tue, 24 Nov 2026 08:43:35 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.87]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4jYbtt2JwWz6B9mC; Tue, 24 Nov
 2026 08:43:34 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20261124084131epcas5p3098eab1bc134da7aefcc83c646b54a9d~q7o0df1RC0651506515epcas5p3W;
 Tue, 24 Nov 2026 08:41:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20261124084126epsmtip20d1bb7fc51b7be9416c78f041855e347~q7owLbH482941029410epsmtip2v;
 Tue, 24 Nov 2026 08:41:26 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: Mengmeng Zhao <mengmeng.zhao@linux.dev>
Cc: Anuj Gupta <anuj20.g@samsung.com>, Christoph Hellwig <hch@lst.de>, Anuj
 Gupta <anuj1072538@gmail.com>, Nitesh Shetty <nj.shetty@samsung.com>, Pavel
 Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, Sumit
 Semwal <sumit.semwal@linaro.org>, Christian Koenig
 <christian.koenig@amd.com>, Philipp Stanner <phasta@kernel.org>, Dan
 Williams <djbw@kernel.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara
 <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Baokun Li <libaokun@linux.alibaba.com>, Ojaswin
 Mujoo <ojaswin@linux.ibm.com>, Ritesh Harjani <ritesh.list@gmail.com>, Zhang
 Yi <yi.zhang@huawei.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, Li Wang
 <liwang@kylinos.cn>, Mengmeng Zhao <zhaomengmeng@kylinos.cn>
Subject: Re: [RFC PATCH v2 0/8] ext4: Add dma-buf read/write support
Date: Tue, 24 Nov 2026 14:10:25 +0530
Message-Id: <20261124084025.2101804-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <361c4312-f77b-495f-9ee4-e0b9612b4463@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261124084131epcas5p3098eab1bc134da7aefcc83c646b54a9d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261124084131epcas5p3098eab1bc134da7aefcc83c646b54a9d
References: <20261113070621.273953-1-mengmeng.zhao@linux.dev>
 <20261120154153.GC28611@lst.de>
 <361c4312-f77b-495f-9ee4-e0b9612b4463@linux.dev>
 <CGME20261124084131epcas5p3098eab1bc134da7aefcc83c646b54a9d@epcas5p3.samsung.com>
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:41:18 +0000
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 09:51:41AM +0800, Mengmeng Zhao wrote:
> Hi Anuj, I'd be happy to help pull our patches together into a single
> unified series and send it out for review, if you're okay with that—and
> would appreciate your review once it's posted as well. Please let me know how
> you'd like to coordinate, or if you have any updates in progress on your
> side before I put the series together.

Hi Mengmeng,

We already have updates in progress on the XFS side.

We will consolidate the combined series along with your ext4 work and
related patches, keeping your authorship.

One more thing that we are looking at combining is the ability to share
the registration across files. Pavel had mentioned this earlier in our
xfs series [1] and posted a series too [2] which needs some more work.

FWIW, we also had ext4 changes, but intentionally started with one
filesystem (XFS) so that the common interface could settle first.

[1] https://lore.kernel.org/linux-block/4649a20f-aba9-418e-987f-66f21ab24410@gmail.com/
[2] https://lore.kernel.org/linux-block/cover.1793751001.git.asml.silence@gmail.com/
