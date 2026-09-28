Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1629DCA5FA5
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:19:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F56410EADB;
	Mon, 28 Sep 2026 15:19:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UQKntXCO";
	dkim-atps=neutral
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2E2B10EADB
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 15:19:44 +0000 (UTC)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-3a494638445so130195a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790608784; x=1791213584; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h2+B+TCtU6LhjPX3KEHp5ZhDWyuT2oD8RctAdhdkStc=;
 b=UQKntXCO5cfqim0D/5yZBwy/Gf61jdKONe12aLFZU6o3BbQoOCfXxvDMlhGz8Xx9cH
 U36sCP9Pwc1mbB7EK9DB/UTnXJGAq1KjIf6gUv+UaROPbrEdMY3VRbiR1U5TGgtEfnh2
 vGUDmHR3g7zEDrqUxIbhXBTZRVK0iqWc8ZNFEGwkxrsd+NOSFvQdMgXar65pXh7TK59k
 LXCi4qYbeyXOKg3q9fyZ/BFykO0/U8XGDIAz+FB9jD/qydUMv+g5WE8BvvoILB7y5AHJ
 EG/zzWzWQQz6Wdtbr3joYJonGRS+8EGlu7rZ9glchk74KAOMQ3+CLHmND2ZbN+unOdJU
 0+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608784; x=1791213584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h2+B+TCtU6LhjPX3KEHp5ZhDWyuT2oD8RctAdhdkStc=;
 b=XzYm6iGBu9Y/03GWTimv6/4AoX/0KPCkuC7Q9M3/KOqcXnw1ZSzKrI8Epbpo6+9E6m
 +sUh7SBvg8cvxWV37riph694ux1/lYFrCUIFu+xhOxcIlSL1bQ1H/MW7Ogcnq3+c//x2
 NhmezTYSCWU8omTkK/HN69qTnBPjT+0bkiUiLlrPNBQB7vlCV7C4tW7pDaIxdQZWjdzW
 6JlnVNb82FqXeVQs5buamt5Fb6/TZOCD0L/TbP7J4/FvcqR4PXenSAwYGYs6Fi4OLfW7
 XnE90CiwhA5FT4P6iGjfTxGzFmjuHdSAoyUAPuhA0zhTwlacapm4/HzkVFMdWxokkBqv
 2acA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHlnv2i1+YTepE8JT5PLlCnF2B1lSus3aAyN8zbV42dr/n0t5g+oWrTjdJd2pDoBVon5qz1RgOsUM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJaZBKQMEw9C7KHEOT3xfMmIh980+H8IrFR9iOFZxRlbUdgo36b
 DSqhbaD1nHgk+Vb9DucBQ3hSfpSGeh52prI5qbb10jWixuwShliGS5mJ
X-Gm-Gg: AYBFou34szPOF4O4BgiJMBXZ6jsfGX/SL0dR83GuL1bdSfqGxX7jQy4yy0wJBf82/6W
 YvJAD1v/5AYEEq1G9W/TsAt38iK6arMzYQ0MwwdG8yzZt9t/TSxz/0EvrkOL85va+DNVY2LvJe0
 QrEMgpT2IB+FS9Rp56LPzqP1cXDbmhR3GfP+M4TB/031vnW6nVpXOjPD25DIkILVvHPCOY3GoE4
 6yUF1qb/xB/znlM6G5uJfjo8dEv0bj+dEQJ0oHO349snfISnm4UZclxHoRi4v1QZFlzMxKyYWbX
 UMuwOX+WgNtpZ5ozqhpKc0w4Uug4ULs+UgJCeSL67VP3Pwc5ELKvspfvCamx+1LLkv4ycBYaatQ
 s+/aAjQ3nHj7IyoB906VFNe4lUNFgsPuH+vdWn4p1JH6W0q9LOxBzqJ3WLzrO9yXi5b+IJYw5xH
 qBSJFjVCZuKQ9pFk/1EjzuqwHKrpKplGRd5OgvBRpPJU/INhAJk/YKVd/0HWykGDX/srrB6rvRn
 uvjRc7/Yr6O2ZGnsFSz3hZS/mCD1qUVTVAWovzSLM8GyCCthlzsdXuqWvUNMLYhQfc9Q9mycWo+
 EexZxvy2Ggkqpd3xfTdGCcl78hrC2gaN+QfntCkuo6l0Xk1oXmliVapT1wQ=
X-Received: by 2002:a17:90b:3908:b0:3a0:c20b:2fdf with SMTP id
 98e67ed59e1d1-3a0c20b3132mr6450444a91.17.1790608784281; 
 Mon, 28 Sep 2026 08:19:44 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b9feddd0sm7247965a91.2.2026.09.28.08.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:19:43 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Johannes Weiner <hannes@cmpxchg.org>,
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Yosry Ahmed <yosry@kernel.org>, Youngjun Park <youngjun.park@lge.com>,
 Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-api@vger.kernel.org, Alejandro Colomar <alx@kernel.org>,
 linux-man@vger.kernel.org, Karel Zak <kzak@redhat.com>,
 util-linux@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] mm/swap: reserve swap areas for deliberate
 offload
Date: Mon, 28 Sep 2026 23:19:34 +0800
Message-ID: <20260928151934.2686418-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <arn4xOIxFRD8qY_x@infradead.org>
References: <20260926045517.3458413-1-matthias.goergens@gmail.com>
 <arn4xOIxFRD8qY_x@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Christoph,

> Either way block devices must be safe to be called from paging paths,
> not just for swap but also for file system based paging.  So this is
> a bug in the implementation, and not something worked around in the
> swap code.

Agreed that a backend used for paging has to make progress under
pressure, and the zvol example was a poor lead.  The series isn't
meant to excuse a backend that can deadlock; that would still be a bug
to fix in the backend.

What I'm after is different: backends that are correct but need
memory to accept a write, where the better policy is to use them for
cold-page offload when memory isn't tight and keep pressure reclaim on
areas that don't need to allocate.  Two in-tree examples: zram
allocates on writes and fails with -ENOMEM, with no fallback, while its
logical size still shows free slots; and filesystem swapfiles must
give up copy-on-write, checksums and compression today, because swap
writes bypass the filesystem.  I'll make that the case for v3 instead.

Thanks,
Matthias
