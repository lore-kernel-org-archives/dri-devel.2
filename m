Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B39606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=BqQLHNlY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C063112567;
	Fri, 13 Nov 2026 13:43:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id F073510E964;
 Thu, 12 Nov 2026 16:24:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69EC11516;
 Thu, 12 Nov 2026 08:24:08 -0800 (PST)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F8FA3F673;
 Thu, 12 Nov 2026 08:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794500651; bh=1Zrocjmf5KDVgs9C8TWM+FCvnpiEFAfhwrLPqAEVgUs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BqQLHNlYEL+MGcY7ChdyVQ7siuvacMh/KJ7dkXQfKvojNWvmYw/fDWZ9Ui9lqm7F3
 9jsLTQTkZVACGQn88QQYjBHPS96QiYQAoGd6prS231FJxAvj7b4bc6yFRmNPKYKITA
 nPX92trHEYqZSAzvnLx+fsCkWZKwWfoOkTWDUUFU=
Date: Thu, 12 Nov 2026 16:24:05 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>
Cc: linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v17 00/12] migrate on fault for device pages
Message-ID: <avXoJSGh5xjGFgod@raptor>
References: <20261103061629.972669-1-mpenttil@redhat.com>
 <avWpWBl1nPcRVmpQ@raptor>
 <79f33ab0-2e43-4efb-94d0-addaf40745ec@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79f33ab0-2e43-4efb-94d0-addaf40745ec@redhat.com>
X-Mailman-Approved-At: Fri, 13 Nov 2026 13:43:28 +0000
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
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mika,

On Thu, Nov 12, 2026 at 04:00:09PM +0200, Mika Penttilä wrote:
> Hi Alexandru!
> 
> On 11/12/26 13:56, Alexandru Elisei wrote:
> > Hi Mika,
> >
> > I want to help getting this series merged, and I've been familiarizing myself
> > with hmm and device migration, please bare with me if the questions I'm asking
> > are obvious or downright silly.
> 
> Thanks for the interest and willing to help! I am preparing a v18 of the
> series and plan to post it early next week.

The series is big, and as far as I can tell the MM people are hard at work
reviewing bug fixes. It might be better to wait a while, to give people a
chance to have a look? I know that if I see a series being reposted often,
I am less inclined to review the patches since probably a new iteration
will be posted soon. But I can only speak for myself, you know best.

> 
> I try to answer your questions, there are quite a bunch of them!

Thanks for your replies, it's going to take me a while to digest them.
Despite the silence, I'm working on it!

Thanks,
Alex
