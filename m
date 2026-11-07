Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F41606A32C
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iVkJsnuT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64BA310E5FE;
	Sat,  7 Nov 2026 13:26:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DFB810E5E9
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 13:26:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 589D940E1A;
 Sat,  7 Nov 2026 13:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C706D1F0089F;
 Sat,  7 Nov 2026 13:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794058008;
 bh=3wI4dPV7vPZzei5+Z1Xw/Btg7c79MJDYSpJrFjLcrW4=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To;
 b=iVkJsnuTbj9D0h5tUL2AUlGhtNba5B0o8VmSwmMIPC4rAR4oqYL0lK7VcFF/Cve+s
 PNtApozniAR7eKqZH/w5AaC1XGtPAiF55QQxeYBf2Viub8dZkBHh8TqBi91CsjIFsm
 GjhVqnkHwoOtDDZyJGdlwV3xEsPv4dOzt6+IFWCNf+x+CpLKVqd21wG80pTCsPu5ZF
 17/+liaZUypikekJSXe+l4uKKch0aAIxwp/WvM4cOgTNNdNxnmfWl/z6B7n2muEtBI
 XWFbp2fTxFvksM9rdQCCPLBbry6boAtfAxqnMKCOsRhzfbiYmStAxxXriuv4nxV+uj
 cxMsQoCBNY/ZA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Nov 2026 14:26:42 +0100
Message-Id: <DMP0HGBVA3Q9.T8UP93DA34UK@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 7/7] rust: drm: make Driver::File lifetime-parameterized
Cc: <acourbot@nvidia.com>, <daniel.almeida@collabora.com>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <work@onurozkan.dev>,
 <brauner@kernel.org>, <lyude@redhat.com>, <j@jananu.net>,
 <alvin.sun@linux.dev>, <deborah.brouwer@collabora.com>,
 <laura.nao@collabora.com>, <beata.michalska@arm.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261107021427.2105374-1-dakr@kernel.org>
 <20261107021427.2105374-8-dakr@kernel.org> <au7eV0D_44ipe3mw@google.com>
In-Reply-To: <au7eV0D_44ipe3mw@google.com>
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

On Sat Nov 7, 2026 at 9:16 AM CET, Alice Ryhl wrote:
> On Sat, Nov 07, 2026 at 03:03:25AM +0100, Danilo Krummrich wrote:
>> +        // Run driver destructors without `filelist_mutex`. Take each l=
ink before dropping its
>> +        // allocation to avoid recursively dropping the entire chain.
>> +        while let Some(mut data) =3D files {
>> +            files =3D data.as_mut().project().next.take();
>> +            drop(data);
>> +            drm.open_count.fetch_sub(1, Release);
>> +        }
>
> Instead of transferring all the files to another linked list, how about
> taking them off the file list one-by-one? If you release the mutex in
> between dropping each file, then we still avoid deadlocks if the file
> private data destructor takes the lock.

I did consider this, and technically it would (currently) work with
list_del_init(), but I did not like it because it would be a very subtle ch=
ange
in semantics from the perspective of the C code. (I.e. for C drivers the li=
st
entry would remain intact after this callback, whereas for Rust drivers it =
would
be removed.)

Actually, I did hesitate to move drop() out of the filelist_mutex protected=
 path
at all because I don't think there's a way this could actually ever produce=
 a
lock inversion, but the "move to a separate list" approach was pretty simpl=
e and
very few code so I thought it's worth ruling it out anyway.

(In any case, I'll soon start working on the C code to implement a common
lifecycle scheme.  Once we have that, the Rust code becomes even more strai=
ght
foward.)
