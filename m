Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07F5606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 01:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XJO+XIkm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CE7910E2F8;
	Mon, 23 Nov 2026 01:52:07 +0000 (UTC)
Received: from mta1.migadu.com (out-82.mta1.migadu.com [95.215.58.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FD3310E2F8
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 01:52:00 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=e+QHWbBPMWAeiyatS48Y4WE7Tii5hCDimKpeiM65Zg8=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795398718; v=1; x=1796003518;
 b=XJO+XIkm3rkM9nMrQaJ88DBU/SbDNDS8sX/2dIaj3cwmRrKirwqyb+I0+uhLyek6+NMpIzpi
 feptrx/ngiR7GStYVclrJX2X302KeSUwM1np0LDwreiaO4CnEGlTK2BETzp5dn6xGe4YcTGokd9
 xsy7UnLpMsmmUcjbVs0s4weY=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 1054823f21723493;
 Mon, 23 Nov 2026 01:51:57 +0000
X-Mizu-Trace-ID: 1054823f21723493
X-Migadu-Flow: FLOW_OUT
Message-ID: <361c4312-f77b-495f-9ee4-e0b9612b4463@linux.dev>
Date: Mon, 23 Nov 2026 09:51:41 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/8] ext4: Add dma-buf read/write support
To: Christoph Hellwig <hch@lst.de>, Anuj Gupta <anuj1072538@gmail.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, asml.silence@gmail.com
Cc: Jens Axboe <axboe@kernel.dk>, Sumit Semwal <sumit.semwal@linaro.org>,
 christian.koenig@amd.com, Philipp Stanner <phasta@kernel.org>,
 Dan Williams <djbw@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Baokun Li <libaokun@linux.alibaba.com>, Ojaswin Mujoo
 <ojaswin@linux.ibm.com>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
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
From: Mengmeng Zhao <mengmeng.zhao@linux.dev>
In-Reply-To: <20261120154153.GC28611@lst.de>
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

On 11/20/26 23:41, Christoph Hellwig wrote:
> On Fri, Nov 13, 2026 at 03:06:13PM +0800, Mengmeng Zhao wrote:
>> From: Mengmeng Zhao <zhaomengmeng@kylinos.cn>
>>
>> This series adds dma-buf read/write support for ext4. The dma-buf direct
>> I/O infrastructure allows dma-buf to be handed to file I/O as an iov_iter,
>> but currently it only supports raw block devices. To better serve the
>> GPU-NVMe direct access through normal filesystems, prior work for XFS has
>> been discussed at [1]. We are also interested in this field and working on
>> it [2].
> 
> Can you an Anuj please work together and merge this into a single
> series covering both XFS and ext4?
> 

Hi Christoph, sure, I'm glad to work with Anuj on this.

Hi Anuj, I'd be happy to help pull our patches together into a single
unified series and send it out for review, if you're okay with that—and
would appreciate your review once it's posted as well. Please let me know how
you'd like to coordinate, or if you have any updates in progress on your
side before I put the series together.


