Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90575606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVvNh44c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F090110E87B;
	Thu, 19 Nov 2026 12:28:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5F0310E87B
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 12:28:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8F82B43B52;
 Thu, 19 Nov 2026 12:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5831F000C4;
 Thu, 19 Nov 2026 12:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795091327;
 bh=OYKLKa88kqYxtvXJjLZgL4uoSuTqh7GrrX11eW0zc38=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To;
 b=NVvNh44cVzTMlynElex+ufbnZilXmrZ5yfrUBv7GCk+AjBzidEaRvibb/QLHEtZ89
 Rk4nz/j315rI5DLnJDrgi7LQ9cz5PXTN/UJDejlo3btteojzKtnG0SEBkUDxYwqXst
 5DrcqIAxFKlso8tCEGhQyfFJlTMth/TmftrGdtbL7wIysUvrmrzjhMxzeUz1x17Ycl
 WwPUrhwadRdDHWMX9s9cePEYRrprNhU/gbaPSHxk6PgIv8bSY/ImXLwilyDbmizZ+s
 DhGl3KfpxnsX6luWq8+llr7qzEIWDN/yFp50yfN0wy4vpEFYVd0cpTACf25bGkdh92
 iOnsWgnkw58Hg==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 13:28:42 +0100
Message-Id: <DMZ6RL5X2UXE.33EY9MDLO2AJA@kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/4] drm/tyr: name resource lifetimes after their types
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <lossin@kernel.org>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <tamird@kernel.org>,
 <acourbot@nvidia.com>, <work@onurozkan.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
References: <20261118233727.3147222-1-dakr@kernel.org>
 <20261118233727.3147222-2-dakr@kernel.org>
 <DMYTKRS80NRC.18PBQHK9SZ8K9@garyguo.net>
 <DMZ4C3GGD9U0.360KJBSFLEK61@kernel.org>
 <DMZ5HM326EKD.1I8KUFD65L91Y@garyguo.net>
In-Reply-To: <DMZ5HM326EKD.1I8KUFD65L91Y@garyguo.net>
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

On Thu Nov 19, 2026 at 12:28 PM CET, Gary Guo wrote:
> On Thu Nov 19, 2026 at 10:34 AM GMT, Danilo Krummrich wrote:
>> On Thu Nov 19, 2026 at 3:08 AM CET, Gary Guo wrote:
>>> On Wed Nov 18, 2026 at 11:37 PM GMT, Danilo Krummrich wrote:
>>>> The firmware, buffer, VM and MMU types use 'drm for their resource
>>>> lifetimes, even though each parameter is local to its type.
>>>
>>> This doesn't make any sense, a lifetime on a type by definition cannot =
refer to
>>> a scope of itself.
>>>
>>> `'sec` is not the lifetime of `Section` and `'fw` is not the lifetime o=
f
>>> `Firmware` and I think this is just confusing.
>>
>> Yes, this was badly phrased. What is actually meant is that e.g. 'fw con=
strains
>> how long a Firmware instance can be used.
>
> I think this is weird still. Any lifetime on a type would constrain how l=
ong an
> instance of that type can be used, that's just type wellformness.
>
> I think what you're saying is basically "I couldn't think of a good name =
so I
> use the name of the type instead". To me I think using `'a` has the same =
effect
> and is less confusing because reader knows that it is a generic name and =
is not
> tied to any specific scope.

Oh, I agree, 'a technically achieves the same thing.

With self-referential pin-init, several lifetime roles appear together. In =
the
Firmware example below, 'fw describes its external borrows, 'res is the (hi=
dden)
invariant device resource lifetime, and 'vm describes the borrow of the emb=
edded
VM.

	pub(crate) struct Firmware<'fw>
	where
	    exists<'res>: 'fw,
	{
	    /// Iomem need to access registers.
	    iomem: &'fw IoMem<'fw>,
=09
	    /// List of firmware sections.
	    #[uses('res: invariant)]
	    sections: KVec<Section<'vm, 'res>>,
=09
	    /// MCU VM.
	    #[pin]
	    #[uses('res: invariant)]
	    vm: Vm<'fw, 'res>,
	}

	pub(crate) struct Vm<'vm, 'res> {
	    as_data: Arc<VmAsData<'res>>,
	    mmu: &'vm Mmu<'res>,
	    dev: &'res Device<Bound>,
	    #[pin]
	    gpuvm_unique: Mutex<UniqueRefGpuVm<GpuVmData<'res>>>,
	    gpuvm: ARef<GpuVm<GpuVmData<'res>>>,
	    va_range: Range<u64>,
	}

I find naming the external borrow parameter after the containing type easie=
r to
follow when reading these definitions.=20

I thought we did settle on this convention in the past; am I misremembering=
?

>> (In the following patch, in TyrDrmRegistrationData, Firmware borrows Mmu=
. That
>> borrow has its own lifetime, distinct from TyrDrmRegistrationData's 'drm
>> parameter.)

