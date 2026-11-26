Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9ED606A323
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 01:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=L6bYfjcN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B343610E2EF;
	Thu, 26 Nov 2026 01:26:19 +0000 (UTC)
Received: from mta1.migadu.com (out-51.mta1.migadu.com [95.215.58.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4D2D10E2EF
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 01:26:13 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=D1UHaW0a6adTmdkfzXoJGoIQXD78CQO3jmkmbRoDsZs=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795656371; v=1; x=1796261171;
 b=L6bYfjcNYybhhuAVVhb7iBrxhLzwKq7EhTzcqEdESqr11X8cdCB5XjO3qbSpeZWBTjZ4xss/
 liRSHvH+4jDFcp65egpcgJst3HGCejvq1kqdvJViI4JVAeyIt/BHdA3vvTW5pZhYgH0LBVB4Cjc
 BmQYa4wSViD9pFO+KwXTAlZo=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id f65ccc0d161a6465;
 Thu, 26 Nov 2026 01:26:10 +0000
X-Mizu-Trace-ID: f65ccc0d161a6465
X-Migadu-Flow: FLOW_OUT
Message-ID: <3bce3a69-e41c-4683-b1ca-9477dd41a7e0@linux.dev>
Date: Thu, 26 Nov 2026 09:25:51 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/8] ext4: Add dma-buf read/write support
To: Anuj Gupta <anuj20.g@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Pavel Begunkov <asml.silence@gmail.com>,
 Christian Brauner <brauner@kernel.org>
Cc: Anuj Gupta <anuj1072538@gmail.com>, Nitesh Shetty
 <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Koenig <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, Dan Williams <djbw@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Baokun Li <libaokun@linux.alibaba.com>, Ojaswin Mujoo
 <ojaswin@linux.ibm.com>, Ritesh Harjani <ritesh.list@gmail.com>,
 Zhang Yi <yi.zhang@huawei.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Li Wang <liwang@kylinos.cn>,
 Mengmeng Zhao <zhaomengmeng@kylinos.cn>
References: <20261113070621.273953-1-mengmeng.zhao@linux.dev>
 <20261120154153.GC28611@lst.de>
 <361c4312-f77b-495f-9ee4-e0b9612b4463@linux.dev>
 <CGME20261124084131epcas5p3098eab1bc134da7aefcc83c646b54a9d@epcas5p3.samsung.com>
 <20261124084025.2101804-1-anuj20.g@samsung.com>
From: Mengmeng Zhao <mengmeng.zhao@linux.dev>
In-Reply-To: <20261124084025.2101804-1-anuj20.g@samsung.com>
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 16:40, Anuj Gupta wrote:
> On Mon, Nov 23, 2026 at 09:51:41AM +0800, Mengmeng Zhao wrote:
>> Hi Anuj, I'd be happy to help pull our patches together into a single
>> unified series and send it out for review, if you're okay with that—and
>> would appreciate your review once it's posted as well. Please let me know how
>> you'd like to coordinate, or if you have any updates in progress on your
>> side before I put the series together.
> 
> Hi Mengmeng,
> 
> We already have updates in progress on the XFS side.
> 
> We will consolidate the combined series along with your ext4 work and
> related patches, keeping your authorship.
> 
> One more thing that we are looking at combining is the ability to share
> the registration across files. Pavel had mentioned this earlier in our
> xfs series [1] and posted a series too [2] which needs some more work.
> 
> FWIW, we also had ext4 changes, but intentionally started with one
> filesystem (XFS) so that the common interface could settle first.
> 
> [1] https://lore.kernel.org/linux-block/4649a20f-aba9-418e-987f-66f21ab24410@gmail.com/
> [2] https://lore.kernel.org/linux-block/cover.1793751001.git.asml.silence@gmail.com/

Hi Anuj,

Sounds good, that makes sense given the ongoing XFS and shared registration
updates. Thanks for including our ext4 patches and keeping the authorship.
Feel free to loop me in once you post the combined series—I'd be happy to
help review and test it.

I looked at Pavel's patchset as well, and noticed it adds a new f_dma_io_tag
field to struct file, whereas Christoph and Christian want to avoid bloating
struct file. Did I miss something, or do you have a different approach in mind
to avoid adding fields to struct file?
