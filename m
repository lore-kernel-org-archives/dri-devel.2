Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4EF606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 00:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVtkqYVE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0D3410E75B;
	Wed, 25 Nov 2026 00:29:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4BC410E75B;
 Wed, 25 Nov 2026 00:29:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 683804364C;
 Wed, 25 Nov 2026 00:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141A81F000CF;
 Wed, 25 Nov 2026 00:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795566566;
 bh=EFGoYii1SC1+bbZRrgGUgBUua7WO9ouNbjRGTkCeEYI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=UVtkqYVEf6NtA5gxi3S0rdQNpRRBSmEaLl1BtoFmgWy4CWWvC5eRnx1jKQOO99qVj
 +MdqYunFW4TbGBGy7Z9umkmIjR8xsLget/7k1c3HsJdCTZLaO1mr6nRRiQOP0wZh6L
 Bj6Pav125NsImzsgaZsLLwbPr7zZMCQUuw2i7aZaY4p5w6Htd9gkuvdTs5rqYA84eV
 lCdbDCqe5Bx3dZbr+C6WamIXfK1zVMa+KwS50lqRDGZu/HS0ViOtFNG0SDFO7W8Mgf
 Qio+iR8T4ev15tk648F4G7wSQm7H8/ekS6kGCf97nko82Snv9s4ssvQNrTspCyv/7A
 Qsw4lj/7q26VQ==
Date: Tue, 24 Nov 2026 14:29:25 -1000
Message-ID: <2efd4eef27cbd033bae9e4f5d5ba30bb@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] workqueue: fix cancel_work_sync() on ordered
 workqueues
In-Reply-To: <20261118-ordered-wq-cancel-v1-1-916e01f9affe@google.com>
References: <20261118-ordered-wq-cancel-v1-0-916e01f9affe@google.com>
 <20261118-ordered-wq-cancel-v1-1-916e01f9affe@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello, Alice.

On Wed, Nov 18, 2026 at 05:09:51PM +0000, Alice Ryhl wrote:
> +		if (unlikely(pwq->wq->flags & __WQ_ORDERED)) {
> +			struct pool_workqueue *oldest_pwq =
> +				list_first_or_null_rcu(&pwq->wq->pwqs,
> +						       struct pool_workqueue,
> +						       pwqs_node);
> +
> +			if (oldest_pwq)
> +				offq_pool = oldest_pwq->pool;
> +		}

@pwq still has @work queued on it here, so it's linked on wq->pwqs and the
list can't be empty. Maybe drop the NULL check? e.g.

  if (unlikely(pwq->wq->flags & __WQ_ORDERED))
  	offq_pool = list_entry_rcu(pwq->wq->pwqs.next, struct pool_workqueue,
  				   pwqs_node)->pool;

Thanks.

--
tejun
