Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5750606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=younes.io header.i=@younes.io header.a=rsa-sha256 header.s=purelymail2 header.b=WEOgnaLp;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail2 header.b=rMKX5RLn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73D1B10E6A4;
	Wed,  4 Nov 2026 08:58:04 +0000 (UTC)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59C8A10E357
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 22:27:44 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=WEOgnaLpfE8i+jsglAmkqHM5VbIWJQG1CWzEPffhfvaX3Qmex7PeFjG+Wu5jpUu+T+kBR1Jg1Cp454IaDPgPFT1nlmL2LzYOshcgQvle+zLFeqCNT3j4234NUNO132k6pA4FeR+juJj9bFZZT0REkDmgF366pd3bntkbOWU+EAJzMB5Vh3IOKrI3uiPNP6uS6DiEGI9tRmzxhkoSSe/cxpdyEPnmk8bcTOpIcEjxiKufuuOWUpwl1HTZTLv0Q5txymOHqAtSx2XYvF+SfF+aKgCtQxgICqmdLY9/AQQ/UU9dD9US84j38UYHPLdTaDfmN/Ukqx8r3y3dpc4pxQWi0g==;
 s=purelymail2; d=younes.io; v=1;
 bh=d+vV3gaJFjmLIOLiJUMcIH25fkVHN9ZB+h3Maan5FdE=;
 h=Received:From:To:Subject:Date; 
DKIM-Signature: a=rsa-sha256;
 b=rMKX5RLnYe6l3x4zWy0Jy5YeDMTN0ifRpBrUh0FLCWPOdzSclItz35a9Yd0uZsadUR8YTOD8d5ZPS+FchX22OaTYGx+2ymd62sqkaNLxnq9SSUPFLTobqX4FTBKSiqZptXCaWkbOAzpcGJ1/R75LEmqZ7Fch1J1C6NQx+lXj0RZFD11fqisJYfB7X39SEUke9CMNd8Ab52ZPUHhLc+pe4Sb04xqFfarvDYBSqd0AqLnmfmlL34azA+epbr1+bll04ZmFBjG5omJjnlp18clZ1W/A7Lp/b56gi54B8onUlS3Jrj7cSuZJoWgUM5aTGyW7D2Y++M3L9LIyQbqg7qN0Cg==;
 s=purelymail2; d=purelymail.com; v=1;
 bh=d+vV3gaJFjmLIOLiJUMcIH25fkVHN9ZB+h3Maan5FdE=;
 h=Feedback-ID:Received:From:To:Subject:Date; 
Feedback-ID: 1578161:62319:null:purelymail
X-Pm-Original-To: dri-devel@lists.freedesktop.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 465182662; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 03 Nov 2026 22:27:04 +0000 (UTC)
From: Younes Akhouayri <git@younes.io>
To: Philipp Stanner <phasta@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [RFC PATCH v7 8/8] samples: rust: Add JobQueue Tester
Date: Tue, 3 Nov 2026 22:27:01 +0000
Message-ID: <kw-1793744821.998563484-558346-1@younes.io>
In-Reply-To: <20261103153138.1087330-10-phasta@kernel.org>
References: <20261103153138.1087330-2-phasta@kernel.org>
 <20261103153138.1087330-10-phasta@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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

On Tue, 3 Nov 2026 16:31:38 +0100, Philipp Stanner wrote:
> +            drop(jq); // Release lock.
> +            T::run_job(work.fctx, runnable_job);
> +            jq = work.inner.lock(); // Retake lock.
> +
> +            // run_job() above needs to be called without lock protection. Thus,
> +            // it is possible that the driver instructed completion right before
> +            // we could re-take the lock.
> +            if jq.last_completed >= seqno {
> +                fence.signal(Ok(()));
> +
> +                // Drop here directly if possible. Otherwise, let the DropWorker
> +                // take care of it.
> +                if core::mem::needs_drop::<T::JobDataType>() {
> +                    jq.drop_list.push_back(job);
> +                }
> +            } else {
> +                jq.running_jobs.push_back(job);
> +            }

Hi Philip,

The job's cost is subtracted from jq.capacity further up in the loop.
complete_jobs_up_to_seqno() restores capacity only for jobs it pops from
running_jobs, and a job that takes this branch never gets there. So each
completion that wins the race against the worker leaves `cost` credits
consumed for good, and a queue with a small capacity would stall after a few
of them.

The tester takes this branch too, since it calls complete_jobs_up_to_seqno()
right after submit, before the worker has run. Each job costs 1 out of a
capacity of 1_000_000, so the leak never shows there.

Is there a reason the credits are meant to stay consumed here, or should
this branch do

+               *jq.as_mut().project().capacity += u64::from(job.cost);

as well?

> +                last_completed: 0,

FenceContext::new(initial_seqno, ...) hands out initial_seqno as the first
fence seqno, and both the doc example and the tester pass 0. For that first
job the check above becomes `0 >= 0`, so the worker signals the fence Ok
right after run_job() returns, while the hardware is still working on it.

Should last_completed start at initial_seqno.wrapping_sub(1), or is
initial_seqno >= 1 an intended requirement that just needs documenting?

Best regards,
Younes
