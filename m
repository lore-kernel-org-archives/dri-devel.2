Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8C6606A321
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=S8Q+2CV4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0809F1127EB;
	Fri, 27 Nov 2026 08:29:10 +0000 (UTC)
X-Greylist: delayed 413 seconds by postgrey-1.36 at gabe;
 Thu, 26 Nov 2026 16:01:39 UTC
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BED1E11257B
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:01:39 +0000 (UTC)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20261126155444epoutp03dcd4ec9596cec66ed694dc1c2cd611a1~ro1pFr0S32621526215epoutp032;
 Thu, 26 Nov 2026 15:54:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20261126155444epoutp03dcd4ec9596cec66ed694dc1c2cd611a1~ro1pFr0S32621526215epoutp032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1795708484;
 bh=5M9xtfTWt/rD6V3Yq9/gJOzmL0PuY9q0JOmTonMrkYc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=S8Q+2CV47r+jcyB/hxRZQoNdHuxQ/gWyvqpTmqCCGD4I8E1N/8Sp5R2e+BT1h5Dit
 Id45RW2ZS5AZJEl/R4M3H3tcJ9xLhuBNVHLz9LrKcWbkmclmhrryoUfbwW/+ukJYtW
 oFWXu+LFCdF+trLev1upv67SG1axo8gAriR3T9dQ=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
 20261126155443epcas5p3efe33a75b41143a93560ac14ae0acd78~ro1oKmgN02527325273epcas5p3D;
 Thu, 26 Nov 2026 15:54:43 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.95]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4jb1MQ68Ssz3hhT3; Thu, 26 Nov
 2026 15:54:42 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20261126140745epcas5p4f87a6186091785f4d3de4b69734aed88~rnYO8DwMQ2019420194epcas5p43;
 Thu, 26 Nov 2026 14:07:45 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20261126140741epsmtip24d507cb1363ab8b6b8b6b2fe8c81b878~rnYK24Eeh1787017870epsmtip2c;
 Thu, 26 Nov 2026 14:07:41 +0000 (GMT)
Date: Thu, 26 Nov 2026 19:36:51 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Mengmeng Zhao <mengmeng.zhao@linux.dev>, Anuj Gupta
 <anuj20.g@samsung.com>, Christoph Hellwig <hch@lst.de>, Christian Brauner
 <brauner@kernel.org>, Anuj Gupta <anuj1072538@gmail.com>, Jens Axboe
 <axboe@kernel.dk>, Sumit Semwal <sumit.semwal@linaro.org>, Christian Koenig
 <christian.koenig@amd.com>, Philipp Stanner <phasta@kernel.org>, Dan
 Williams <djbw@kernel.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara
 <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, Theodore Ts'o
 <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Baokun Li
 <libaokun@linux.alibaba.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Ritesh
 Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy
 Dunlap <rdunlap@infradead.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Li Wang <liwang@kylinos.cn>, Mengmeng Zhao
 <zhaomengmeng@kylinos.cn>
Subject: Re: [RFC PATCH v2 0/8] ext4: Add dma-buf read/write support
Message-ID: <20261126140651.vzs2gdwajemvf6kt@green245.gost>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0b76171b-7f2e-41d2-8a5c-102dbe4cb85b@gmail.com>
X-CMS-MailID: 20261126140745epcas5p4f87a6186091785f4d3de4b69734aed88
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----sfnc.NZyIOBfLTiZTLswaXBSL0w4GQC52Zj1LhBq2cHN2.MV=_ad66_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261124084131epcas5p3098eab1bc134da7aefcc83c646b54a9d
References: <20261113070621.273953-1-mengmeng.zhao@linux.dev>
 <20261120154153.GC28611@lst.de>
 <361c4312-f77b-495f-9ee4-e0b9612b4463@linux.dev>
 <CGME20261124084131epcas5p3098eab1bc134da7aefcc83c646b54a9d@epcas5p3.samsung.com>
 <20261124084025.2101804-1-anuj20.g@samsung.com>
 <3bce3a69-e41c-4683-b1ca-9477dd41a7e0@linux.dev>
 <0b76171b-7f2e-41d2-8a5c-102dbe4cb85b@gmail.com>
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

------sfnc.NZyIOBfLTiZTLswaXBSL0w4GQC52Zj1LhBq2cHN2.MV=_ad66_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 26/11/26 10:44AM, Pavel Begunkov wrote:
>I'll resend it later, how to store the tag is the least interesting
>part, it can just move inside the block/ext4/etc code, which would
>be uglier, but whatever.
>

What about the f_op method instead of storing the
tag in multiple users that we support now i.e., block/ext4/xfs code?
We refined your patches with this approach and it seemed to fit well.

--
Nitesh

------sfnc.NZyIOBfLTiZTLswaXBSL0w4GQC52Zj1LhBq2cHN2.MV=_ad66_
Content-Type: text/plain; charset="utf-8"


------sfnc.NZyIOBfLTiZTLswaXBSL0w4GQC52Zj1LhBq2cHN2.MV=_ad66_--
