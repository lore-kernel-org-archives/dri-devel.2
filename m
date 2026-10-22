Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C8F606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 23:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=DlE5AX0E
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC1E210E37A;
	Thu, 22 Oct 2026 23:53:20 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8237B10E37A
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 23:53:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792713190; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=USsdMuU5gMmdKZAKLj6NLOnUxRJnM4QSY1B11nzzY4L1EyIng8Vwyn6fHNtwax5k0qXlTIOv5+35ydqbHPlqPxrxi7bsQineaZDPQH9DdT/I0A3I2PKmyMYD9kF/726Pxj487v/KAZFX5ZCJ5tIwUCyETV5tWl+1bdODBVaycHk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792713190;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=XZVFc2cY2YdRXjDiQkdwMYAg1zQFmPzyWnIcVt7gubM=; 
 b=MbLhPZWuQeuUjHbNqy673eyDyO+yGb1zmqZcoF/feyV1ZcEI5BP/LbKjQ0VfGae2gn6wwCpD//dw7iIdIJP5MtqiojDvAS6H/Q1ixEQI/AR5nk5pW2SHQN7Qa1sXUuGnckDMRMre+ETbODlIdLg/I27ANEQpJWE8op4qdbjc96k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792713190; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=XZVFc2cY2YdRXjDiQkdwMYAg1zQFmPzyWnIcVt7gubM=;
 b=DlE5AX0EJFn4+qNw7TJfzSEARTLOr+0xnH049vabN+TeMo7m+gjRnq+GOfyedonw
 6jdQcP40bT46n4YNFimPPDK5k7gw91j1nW5O9+88r9/dkxpMGYkjuNOT4MniYXMst7b
 bHzd0Z/HLqnpV+zwqzsH3arHsPdqA6fHVhM4VEDI=
Received: by smtp.zohomail.com with SMTPS id 179271318893732.044990374067766; 
 Thu, 22 Oct 2026 16:53:08 -0700 (PDT)
Date: Thu, 22 Oct 2026 16:53:07 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Ke Sun <sunke@kylinos.cn>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 rust-for-linux@vger.kernel.org, linux-mm@kvack.org,
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>
Subject: Re: [PATCH v4 02/11] rust: mm: add `task_size` helper
Message-ID: <atqh41vrlC4xVtaj@um790>
References: <20261020-tyr-ioctls-v4-0-704de77da223@kylinos.cn>
 <20261020-tyr-ioctls-v4-2-704de77da223@kylinos.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020-tyr-ioctls-v4-2-704de77da223@kylinos.cn>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/292.705.96
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 04:25:19PM +0800, Ke Sun wrote:
> From: Alvin Sun <alvin.sun@linux.dev>

I was testing Tyr's auto allocation for the user va range,
and was surprised to see that mm.task_size() is always returning 0.
It seems like it should work since it uses the task_size from
struct mm_struct, but it doesn't, at least for me. 

If you look at tyr-dev, I think it would be better to use Sami's approach:
  428d71932b6f rust: task: add task_size()

Sami creates a task_size() method for CurrentTask which is our equivalent
to the `current` global and then you can see that task_size becomes much
more clearly the equivalent of "TASK_SIZE_OF" used by panthor.

This approach also correctly returns a user va range when Tyr has to
assign it in my tests, so let's switch over.

> 
> Expose the task's address space size. It is used by the Tyr driver
> for splitting a VM's GPU address space into user and kernel regions.
> 
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
>  rust/kernel/mm.rs | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> index 4764d7b68f2a7..d2dfbb7d43972 100644
> --- a/rust/kernel/mm.rs
> +++ b/rust/kernel/mm.rs
> @@ -149,6 +149,13 @@ pub fn mmget_not_zero(&self) -> Option<ARef<MmWithUser>> {
>              None
>          }
>      }
> +
> +    /// The size of the process virtual address space.
> +    #[inline]
> +    pub fn task_size(&self) -> usize {
> +        // SAFETY: `self.as_raw()` is a valid pointer to an `mm_struct` per the type invariants.
> +        unsafe { (*self.as_raw()).__bindgen_anon_1.task_size }
> +    }
>  }
>  
>  // These methods require `mm_users` to be non-zero.
> 
> -- 
> 2.43.0
> 
