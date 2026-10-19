Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBAF606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jr0nD/C4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D571110E2C2;
	Mon, 19 Oct 2026 20:55:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CB1110E2C2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 20:55:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D6FA74185F;
 Mon, 19 Oct 2026 20:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1FE1F000C7;
 Mon, 19 Oct 2026 20:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792443351;
 bh=sIGyzX3B4y5JmTSJFG3fHckTLqX8QVWJboA+EMd/w/U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Jr0nD/C4vt36bRYbcd8Fsz+oRZZw/Zv0vfmYKNyfcYFWd1satfZ6Wd2PBRrvPjxX3
 Dokvm+GhskSe10i7j75rn0lrOHfP9ug+IIincGl1xqmbBOHMOIcTbRB09pSQfgyP7P
 RpXnFyzRSugWJ/WRe5t4hRauiDh/YlHAszRzDwXJ2+RoRSVCkL0LcEg8T4gtXVfTn4
 OqphB2wfwHXmMliCV/VYmEFWeE8Aqr2osnmHs0JKQnO/qkmJKa7yXsxxzpxxpy32sb
 EMT0HOweSdGQBzCioam6ITZZCr9ysVwSnYXl3ihooC7lL01NvasrHan2iahdf4V5M0
 VV4YoYvBZ9hkA==
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Vadim Nikitushkin <bub4z0r@gmail.com>, stable@vger.kernel.org,
 thomas.hellstrom@linux.intel.com, dri-devel@lists.freedesktop.org,
 skainsworth@gmail.com, Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH 7.2.y] drm/ttm: fix swapped-out resources never leaving
 their bulk_move range
Date: Mon, 19 Oct 2026 16:55:28 -0400
Message-ID: <2026-10-19-1-daily-reply-0002-ttm-bulk-move-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAPM=9twsgnL_SPf7hi+mnPUgJTyGVDFyQdbOSNhQZXSSoxZmNQ@mail.gmail.com>
References: <CAPM=9twsgnL_SPf7hi+mnPUgJTyGVDFyQdbOSNhQZXSSoxZmNQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> So can we just apply the patch in this thread to stable, the squash
> fixes the stupid in master, or apply both patches to stable and leave
> the stupid.

Queued for 6.18, thanks. I took the patch from this thread, since neither
mainline commit applies to 6.18 on its own.

-- 
Thanks,
Sasha
