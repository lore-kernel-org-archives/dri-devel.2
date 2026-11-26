Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BAD606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=a7snv.com header.i=@a7snv.com header.a=rsa-sha256 header.s=protonmail header.b=p1g/GpoD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21FCF11283D;
	Fri, 27 Nov 2026 08:29:18 +0000 (UTC)
X-Greylist: delayed 65048 seconds by postgrey-1.36 at gabe;
 Thu, 26 Nov 2026 11:21:04 UTC
Received: from mail-4399.protonmail.ch (mail-4399.protonmail.ch [185.70.43.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CABB4112306
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=a7snv.com;
 s=protonmail; t=1795692062; x=1795951262;
 bh=zIHuFarcS6Fh+RV7UoaafACerN1VwcUrnwEg4Ma6T9A=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=p1g/GpoDV6p7G8RLn4E9/ZRlEjWREq/H7gMEJDVN8w2qTVpNiYpGtLrnfZ2w/Jq2b
 YjLex073ORmJ96TZskqlPlWefWjlWF66QwRQgFFV8jyPQSoysKBXlQLrBCgWsqhC9c
 qYtJtNtDZNH5G8Ipy3xHuO2j9zAUoh242AE/A4nQmsfxl3ryFIDOiaZKHb2uc08hIg
 Z+W60M0z1dGneIWDqYHEbqnbxQtXznj7h3FwDO85GbyNpmSed0gI8ztf8Fennn8Sao
 EjAWQWHNIthrKSbYAlC1t7XgYlZNMG7kBB9YdylUGEZvTaW0U7xasX6w82/xANjPUU
 s8R1iDb55pnMA==
Date: Thu, 26 Nov 2026 11:20:51 +0000
To: Mengmeng Zhao <mengmeng.zhao@linux.dev>
From: arsenova@a7snv.com
Cc: Anuj Gupta <anuj1072538@gmail.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 hch@lst.de, anuj20.g@samsung.com, axboe@kernel.dk, sumit.semwal@linaro.org,
 christian.koenig@amd.com, phasta@kernel.org, djbw@kernel.org,
 willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, libaokun@linux.alibaba.com,
 ojaswin@linux.ibm.com, ritesh.list@gmail.com, yi.zhang@huawei.com,
 asml.silence@gmail.com, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, liwang@kylinos.cn, zhaomengmeng@kylinos.cn,
 mcgrof@kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [RFC PATCH v2 2/8] iomap: add dma-buf direct I/O guards
Message-ID: <XNQ-E6Q8GZFQ7mImRSSv-9Rn2rFxrM6VjLvIp5yb01GOtKLUp6q5lc7ZLXO-gylrW13D6rxO-KSHTrnWFowX8zKQnZvpm0QYHBHGDjyn-ZE=@a7snv.com>
In-Reply-To: <bff85d7b-84dd-4f4a-91c1-7f5c9ef2e51a@linux.dev>
References: <20261125171600.4053585-1-arsenova@a7snv.com>
 <bff85d7b-84dd-4f4a-91c1-7f5c9ef2e51a@linux.dev>
Feedback-ID: 235448903:user:proton
X-Pm-Message-ID: 61e994b372b81e8b5a2d310c657a2284db10d784
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FROM_FMBLA_NEWDOM14,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 06:23:06PM +0800, Mengmeng Zhao wrote:
> Since Anuj is currently consolidating the XFS and ext4 dma-buf work
> (along with the cross-file registration sharing updates) into a unified
> series, I fold your diff into this patch and send a seperated V3 version
> with your Co-developed-by and Signed-off-by (if you're okay with that)[1]=
.

Yes, I'm fine with the Co-developed-by and Signed-off-by, both in v3
and in Anuj's unified series.  Good to hear it holds up on real NVMe.

Thanks,
Yun
