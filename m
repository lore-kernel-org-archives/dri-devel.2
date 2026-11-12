Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853CF606A324
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 00:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rafqYhJO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9747C10EACD;
	Thu, 12 Nov 2026 00:26:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 138FC10EACD
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 00:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=3JaUIX8TvleTZ/eyRqexb46r9ox6QF7gVm6ONPKED1k=; b=rafqYhJOPOa4iyEQfoTvTZ4K6T
 JVbDXCbUOkzGjrQC/xfo2SUILYVmHnv+jE1DpCEUr5UyyUxk3wCBssj1LE/zlM9WK6X0g2rkRthwf
 yvfLdVgeFnsmpeZ63A8wNgZzMoPPVqhz+1cMNxhKwCoJxTwN7iPj5kz2Je+KnDPde5Np+p7Pg9+iO
 EOyofX6A557DYr4wnLBnWDkTd7V0+fj6dLF6mYRJ39yinQRTOo/ezE2ND398UgI9HguHC9op42+ko
 fsvSXzyYASfK+vM9pYCGI+HWF0RRni/yWCbKDFhSA+4aIBXHGZTApjFR6G3Fukte5JrpDtPvere0F
 Tj8w+vCQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xRIe6-00000008Em9-1nv8; Thu, 12 Nov 2026 00:26:30 +0000
Message-ID: <a7b1d671-18b0-44e8-b112-ab66893b3bf4@infradead.org>
Date: Wed, 11 Nov 2026 16:26:29 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/zsmalloc: remove CONFIG_ZSMALLOC_STAT
To: Xueyuan Chen <xueyuan.chen21@gmail.com>, Minchan Kim
 <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Helen Koike
 <helen.fornazier@gmail.com>, Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Nhat Pham <nphamcs@gmail.com>
References: <20261111-zsmalloc_stat-v3-1-2d85ed51570e@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261111-zsmalloc_stat-v3-1-2d85ed51570e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/11/26 4:41 AM, Xueyuan Chen wrote:
> CONFIG_ZSMALLOC_STAT only controls the debugfs interface. The class
> counters are updated regardless of this option.
> 
> Remove the CONFIG_ZSMALLOC_STAT guards and rely on the debugfs API
> stubs when CONFIG_DEBUG_FS=n. Skip statistics setup silently when
> debugfs is unavailable.
> 
> Remove the Kconfig entry and replace the existing CONFIG_ZSMALLOC_STAT
> settings with CONFIG_DEBUG_FS=y. Update the English and Chinese
> documentation to match, and clarify the pool name in the debugfs path.
> 
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Xueyuan Chen <xueyuan.chen21@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
> Drop CONFIG_ZSMALLOC_STAT instead of making the counters conditional. The
> option only controls the debugfs interface, while the class counters are
> updated unconditionally. Removing it simplifies the code.
> 
> Following Nhat's suggestion, remove CONFIG_ZSMALLOC_STAT and rely on
> the existing debugfs API stubs when CONFIG_DEBUG_FS=n.
> ---
> Changes in v3:
> - Squash the three patches into one (Nhat, Sergey).
> - Add Nhat's Reviewed-by.
> - Update the documentation wording.
> - Link to v2: https://patch.msgid.link/20261109-zsmalloc_stat-v2-0-caee41684aba@gmail.com
> 
> Changes in v2:
> - Drop CONFIG_ZSMALLOC_STAT instead of making the counters conditional.
> - Update configuration files and documentation.
> - Link to v1: https://patch.msgid.link/20261106-zsmalloc_stat-v1-1-b574f4714adf@gmail.com
> ---
>  Documentation/mm/zsmalloc.rst                    |  4 +--
>  Documentation/translations/zh_CN/mm/zsmalloc.rst |  2 +-
>  arch/s390/configs/debug_defconfig                |  2 +-
>  arch/s390/configs/defconfig                      |  2 +-
>  drivers/gpu/drm/ci/arm.config                    |  2 +-
>  drivers/gpu/drm/ci/arm64.config                  |  2 +-
>  drivers/gpu/drm/ci/x86_64.config                 |  2 +-
>  mm/Kconfig                                       |  9 -------
>  mm/zsmalloc.c                                    | 33 ++----------------------
>  9 files changed, 10 insertions(+), 48 deletions(-)


-- 
~Randy
