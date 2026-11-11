Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE07C606A338
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Owo7S3hZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2953610E2D8;
	Wed, 11 Nov 2026 16:47:51 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF75210E2D8
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:47:44 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so238905e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794415663; x=1795020463;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JEN1we3zUbJ34wQgamBpttlVbDethKWGuPURScqYgfU=;
 b=Owo7S3hZz3yl2ehvqEC65G2PSL6dmxbG1Mtu/HpUFB1sZcVRbBnSSOc7GyfjDhqjUo
 0foQ/to4//FXOaN0Kn/n+O23ImvtjzRQ0ZWC7XNToNh/v8ZlPCbmIzwdReL97mF3jU8H
 HSeuoyabDp8F2tMHB6YuB2I5vs1LLQatax+CdehoAtNvFlkspR6RXUeGPgL5VzYKLu7Z
 RQTU+5QStf7p8D2LgbbS/nunKhglYB7OJ0JmuQF3UlTzLFV0B53q1h633Vq2e72rdkYh
 lKPgD4A9WY98zRE0/Aagve7bfmMVfcSu717mbJw1cZOl+lVAyi8CZeANQ/uW0xagkaYX
 gT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794415663; x=1795020463;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JEN1we3zUbJ34wQgamBpttlVbDethKWGuPURScqYgfU=;
 b=ptC+BSDgecnFs75ShI/yQtwINEvq2M56+3hSy0E5++Tv2ptzUenKpMhbFSdLQ/42vE
 qkgYAN8PYCor34I0/8mGhflDBxcbfdyy4HJjzCe+jAQ/G8ppXQVmnDXylk5R2cUmStYn
 6yHkwHkJgB9Ijt0qWW3IrC29kyRd/jFSR0Zi0xahbfKLj3IkvN0NBxyXZymg0xMwS5oG
 kZpPPV/VoLhRBRooM3XiVSQKCl4/UpulHCNxGUe9nNh9kAKoXD7wVEsxav4SsslYJqUS
 SuUnJB4jiha3RtgVkbPROlSZ7nH+osBEu14X/oB1aAdi46ob8mhX+Kqf+0yWAK4mgunZ
 To3A==
X-Forwarded-Encrypted: i=1;
 AL+hErHRuBKM9fQnJoe915qtmqjMsssSvQN0gI+lbw9teWR9xRMg5CoXWv5xj8Sjic4vGpXLPWnLUfBdh8Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/PRlIlGeJHd8amaVwAzAPJ/fCkMtNVwhJTQg6Uv3OmEBiP/WfV
 j6LHKsRWPNXYO5Xv8hZ2doXroNIyHnYsDjRJ8c4oTmdn15CCRb4qTwFNj2WgwZDv7Q==
X-Gm-Gg: AYBFou1PpV0Wsh6USanU83r7DgGZ+cNBdHoUBwFSY1nmyNriEsAHvFQyUrLZWu3UKbc
 BtpKq0n5STpm2k2ml50mUumdEs392bjrpzwPryRSoLaj2VOynxleM1r3yEHWuufZfIBb+80kF14
 dyXgIT5Ha7M7shw3Kj8Ssrc2ZdPfKOoYkcNwkM1kNreIcdpqhloKW5ORwtv7YviY6MJefQda9+5
 hsuhJ6tom4GwcYSLNDyiWCwk2llGHPCzPthnBiPT+QG+7jQBr3DynI1DTyneuIERiZik7MhebtO
 pj5WplSiuq4ASTTSitAWr+19/3BQjkBrOoERGZaUK/KJMilQU2E2Ruz2vTcsvfEuqCGdAemfWHv
 2PIgpGNyfKA08gdDXtkW0QUcD92mBSoclLIZt+sK4NzuHAWeBMSifQFoD09rSu+HN8H1J2H130e
 aCoINFMghjd9WmD9LJ0WtUVmA/OZHlONoFLrbFwZkaEunxRo1tdjnGDUQ+LLG8lN6ApumpdvgIg
 yRO5MUQor299w2/xD+fYRTPkEGwKijeiK5k5vC16bA1+cemQr4fErxfGH8M2jDwJLljg257DGHN
 WCl96tThIcDdCVwWJ7rkWUKeZgdAQDT16hOtinMV9olsT3Ui6qfWQcDXQzJdRSLfdQ==
X-Received: by 2002:a05:600c:3f07:b0:4a2:18c4:61a5 with SMTP id
 5b1f17b1804b1-4bb4e27994emr1100895e9.6.1794415662004; 
 Wed, 11 Nov 2026 08:47:42 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498365cd06fsm11724877f8f.40.2026.11.11.08.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 08:47:41 -0800 (PST)
Date: Wed, 11 Nov 2026 16:47:38 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: akpm@linux-foundation.org, dgilbert@interlog.com, mkp@kernel.org,
 loberman@redhat.com, jmeneghi@redhat.com, kraxel@redhat.com,
 vivek.kasireddy@intel.com, mst@redhat.com, jasowangio@gmail.com,
 eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com,
 rostedt@goodmis.org, mhiramat@kernel.org, jgg@ziepe.ca,
 kevin.tian@intel.com, axboe@kernel.dk, linux-mm@kvack.org,
 James.Bottomley@hansenpartnership.com, sumit.semwal@linaro.org,
 christian.koenig@amd.com, phasta@kernel.org, joro@8bytes.org,
 will@kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 iommu@lists.linux.dev, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, bobbyeshleman@meta.com,
 mathieu.desnoyers@efficios.com, robin.murphy@arm.com,
 mason@kernel.org, aesteve@redhat.com, tjmercier@google.com,
 harry@kernel.org, vbabka@suse.cz, cuitao@kylinos.cn
Subject: Re: [PATCH 4/7] tracing: account ring buffer pages and trace_array
 metadata to memcg
Message-ID: <avScKhR22kFOQ1z4@google.com>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-5-cui.tao@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106131829.3228926-5-cui.tao@linux.dev>
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
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 09:18:26PM +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> Creating an instance immediately allocates two full sets of per-cpu
> ring buffers, array buffer plus snapshot, about 1.375MB per cpu per set
> on the default config, plus the trace_array and its name.  None of it
> is charged: neither trace.c nor ring_buffer.c passes __GFP_ACCOUNT,
> while user_events in the same directory accounts everything it
> allocates.
> 
> Instance creation is currently gated by tracefs file permissions
> alone, so a
> rootful container with the host tracefs bound in can create instances
> until the host runs out of memory.  Charge the ring buffer pages and
> the trace_array metadata to the creating cgroup.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  kernel/trace/ring_buffer.c | 8 +++++++-
>  kernel/trace/trace.c       | 6 +++---
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 1fd28a72e6ee..676c059c112c 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -441,7 +441,13 @@ static struct buffer_data_page *alloc_cpu_data(int cpu, int order)
>  	 * gracefully without invoking oom-killer and the system is not
>  	 * destabilized.
>  	 */
> -	mflags = GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_COMP | __GFP_ZERO;
> +	/*
> +	 * The subbuffers are charged to the memcg of whoever caused the
> +	 * allocation: the creator of a trace instance, or root at boot for
> +	 * the global trace.
> +	 */
> +	mflags = GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_COMP | __GFP_ZERO |
> +		  __GFP_ACCOUNT;
>  
>  	page = alloc_pages_node(cpu_to_node(cpu), mflags, order);
>  	if (!page)

Hum, by default tracefs is root only. 

And even if made accessible to other users: 

  1. The life span of a trace instance is not tied to the caller.
  2. The ring buffer is shared by multiple users.

Overall I am not convinced charging the creator makes much sense.

Eventually a few allocations for iterators could be GFP_ACCOUNT.

-- 
Vincent

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index e8c4efa8107b..04b60b9cc4f5 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8693,11 +8693,11 @@ trace_array_create_systems(const char *name, const char *systems,
>  	int ret;
>  
>  	ret = -ENOMEM;
> -	tr = kzalloc_obj(*tr);
> +	tr = kzalloc_obj(*tr, GFP_KERNEL_ACCOUNT);
>  	if (!tr)
>  		return ERR_PTR(ret);
>  
> -	tr->name = kstrdup(name, GFP_KERNEL);
> +	tr->name = kstrdup(name, GFP_KERNEL_ACCOUNT);
>  	if (!tr->name)
>  		goto out_free_tr;
>  
> @@ -8708,7 +8708,7 @@ trace_array_create_systems(const char *name, const char *systems,
>  		goto out_free_tr;
>  
>  	if (systems) {
> -		tr->system_names = kstrdup_const(systems, GFP_KERNEL);
> +		tr->system_names = kstrdup_const(systems, GFP_KERNEL_ACCOUNT);
>  		if (!tr->system_names)
>  			goto out_free_tr;
>  	}
> -- 
> 2.43.0
> 
