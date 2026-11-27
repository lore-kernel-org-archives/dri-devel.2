Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A04A606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TktZyj1F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3580112948;
	Fri, 27 Nov 2026 09:56:11 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF3BD112939
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:55:28 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4a9be758734so4980591f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 01:55:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795773327; cv=none;
 d=google.com; s=arc-20260327;
 b=IZykFQn172BNC2yCXh70e9hIKZUZXHytrTG0jFsvOsnRyducD290f/SE72oDt7cI+l
 5kvGP0IuN0fpDkKyXYArcXMOwtpr8bPq2tWWRkpwTlrk5Lg4Z6HRC8RWPyGrAAbOJOjs
 wvc2E8A9TR4vKBXs6R1MugD4rmV4xg/jK+/MdO1aU6zuhbDJZ9ykvuFvOXsGDJqYQ7hu
 iMIkWSV5BzunbWY0KoQv7yIsatJ8x0gXDGeqT9EjbecSn7oZDoeZ0RH1lc3kb+JKdmw4
 sRUkXC/pZazOCLmKphnVhnqSW9qcV4NyssFH8j2CXetBOjjtRXETfIn65UkPb8ViXUWA
 BMtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vpy+L8ilFk/xVj47uBuvADr4xljwNe7U/d1k7VvtaJ8=;
 fh=YIF9ftlaK+MsvYLLPrE+IeyREcbyD+1VGGKDaSGJFzA=;
 b=V0RBTZXXY6W7I5p6U5rr2kG3Xaq1KgCRNW8bf8YLH9KWDIs8+X/bt5cl8W5KwE7Rvg
 7CJVVf8RJ/QAIgR7SzWEqEWiE9tfjX2GMu77GP2inZxCJp0Cp/Ds4/5dOdSsMuaTsIKJ
 64WvxhWqqlwCN2pNcFJcqn7S7RyjxSwSmGDg88J0m35sAur9mCDn2TsIqwpFSKKWAbBa
 U5pO0bXDoQKUN77f736fzkom5Wp+okO38pZRQOd9gKlPePL9B8ZEtqYs/+3mwGPX3h2I
 4YdEQ2Q3K8hftO2JgvpDo26aNGsMREuCCmwNrTDBN4szmicKeUAxJfULWS/vdMv+GVrc
 WpZA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795773327; x=1796378127;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vpy+L8ilFk/xVj47uBuvADr4xljwNe7U/d1k7VvtaJ8=;
 b=TktZyj1FjtE6pYsCTJ03i5hdt2zg8DMBmhwUrs+x+g1DThOBX2rJMza5s7wofJ4dl5
 Rqhqza3JQ66Io+YM8MzjWT3GMqi0KF8R/iqlAejUDgkJFDgdIk/cNx+WEc6Vv8VWWBuz
 Gmklr35clXdDeIMmNsr5zsVygNSoGtDSVqnNA80xhvRpF/g8HAAwV7jP0W1xQKLznba7
 2pJzjvrzGpi8mnAcChjK0l05daYDuaWLGmeRU7FzBpG8tCxQDS3IqwELE5aTSGXZUMNm
 IhAbCwHpzlIk84p0D3mEsLhFmyGugCaaDaMOJAaaA8ckg+D1Pod/7HoERebhGsRcaNKo
 b5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795773327; x=1796378127;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vpy+L8ilFk/xVj47uBuvADr4xljwNe7U/d1k7VvtaJ8=;
 b=kWos0yl+MijpCtLA6bLqpVnwE1qLt293jYQwYKB02awOMt58jSY5UI50g5EWkPkKoN
 8VHgmwk5AgCmGerFcJ44rR/EqIpZqUKB9VXcnBYJ5USCRVb01aYOehPExGLRhlLyqGjm
 0NPHO6L/Cdq6GlpG2j4zjT6I3U75GB5IewsEyNNPYAwpr34y68sK5qAMlKj3jrpYQBBD
 vqYnYTj6voit7GHOd5+TqI/5DA34+z2T5F98nFwUwROmlfcAnHVyWNfzSICxoXUbFzGA
 i5f+GdksfS+8X1x9SOq2zYzltN7jE25HzYDr0Lo8l+pJt+Q6VkSQwdwjTRK1gvJNB36N
 aNyA==
X-Forwarded-Encrypted: i=1;
 AL+hErFzl7xiCZ6Eiz6/MOC9rSFeQ5OK/ULgebrXBbPUFoiR71Tq67YXO+yUbUSL6ZdIwM4fvC/m0lvuy/k=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8iTPGnLd2af9oqjYGjWVBGjFKen6A49IzlEScVQ6AFzAV6Ewv1
 qh7ZA7xw1CNnqGm3xvhtRaxaovwgjsUqHpfdMfjvfFgZpnsPZ7tM+IOZdupaHKyqHy+MFZ2SsRq
 75j6FwtgP2rVCM1JaajdrKK0sn4L1jzERdHsFK3hk
X-Gm-Gg: AZFdTZe1v1Uc8S73W56MmTGOK01Hpuw2NmQV3mNgpIIsnnnLPuukLB0PUh+LBijsDzx
 vL6kx7apelmyoaDwMocON14kGcGyaphVm8r49yXYjnHwuyTVZDLqUbKecXIpVExhVXk0CY5CD2D
 cEtGCOCr46zXlMcul17x4C9Ve/1vJ7lOhaMFA2mW+0ofNXxBF5QScoSj+vLOA5DYBMY7ixoB1MG
 5dKj8rVl6Gj6azZSUkzfM1imYrnkSpdtosarRN+o3l4AxG+8Vc7aF95ktR5dgORHf/M0LdZhEpo
 W2BkWhaQpC8tiU217s2j3BdUH23Jq8zlfI6HF3lApCCt1T1DQfPdHyEXAYtVwvOUFVAGrY7dcrr
 CRh0KwJ+PdPUDhX50k1ZuU1zOvZtFnPmwghCt4Cz3mV3bSXuWnI0bhMwj8CQoLs1teUOA/4/mQC
 u5iHZCKdGxO12P9MdfmuJIJ6bYmmB0U/vkLUyhk+NzXgYq
X-Received: by 2002:a5d:588b:0:b0:48e:66d0:664c with SMTP id
 ffacd0b85a97d-4abaf64be12mr50144469f8f.15.1795773326393; Fri, 27 Nov 2026
 01:55:26 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124-rust-drm-gem-shmem-imported-sgt-v2-0-000f7a9ccb8d@jannau.net>
 <20261124-rust-drm-gem-shmem-imported-sgt-v2-3-000f7a9ccb8d@jannau.net>
 <awXA70GWssuU991c@google.com> <20261125113846.GB372978@robin.jannau.net>
In-Reply-To: <20261125113846.GB372978@robin.jannau.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 27 Nov 2026 09:55:14 +0000
X-Gm-Features: Aa3M54oiZNSDgmAEoH9NzLLBRhpgjBRE2cJGZY4MeBf6M2cJPAdsD-3P1zcRduo
Message-ID: <CAH5fLggRtEUopYT0ZacNvczLRTNk4sKDrE7q-isgW=MDn4mqMQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] rust: drm: gem: shmem: Implement
 prime_import_sg_table callback
To: Janne Grunau <j@jannau.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sami Tolvanen <samitolvanen@google.com>, Lyude Paul <lyude@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 nova-gpu@lists.linux.dev, stable+noautosel@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 11:38=E2=80=AFAM Janne Grunau <j@jannau.net> wrote:
>
> On Tue, Nov 24, 2026 at 04:53:03PM +0000, Alice Ryhl wrote:
> > On Tue, Nov 24, 2026 at 12:37:45PM +0100, Janne Grunau wrote:
> > > +        // SAFETY: The DRM shmem helper only invokes this callback f=
or a registered DRM device of
> > > +        // type `T::Driver`, which is `Self`'s driver per the `Alloc=
Impl` impl below.
> > > +        let dev: &Device<T::Driver> =3D unsafe { Device::from_raw(ra=
w_dev) };
> >
> > `drm::Driver` in `rust/kernel/drm/driver.rs` currently declares:
> >
> >     type Object: AllocImpl;
> >
> > without any constraint that `T::Object::Driver =3D T`. I think we shoul=
d
> > introduce one similar to how Driver::File constrains this?
>
> so changing it to `type Object: AllocImpl<Driver =3D Self>;`?

Yeah that's what I meant.

> I think it's hard to get that accidentally wrong but since the change
> relies on that constraint and we can express it sure.
>
> I added it locally for v3 but feel free to make that change before
> pushing this series to drm-rust-next if there is nothing else that
> warrants a v3.

I'm ok with adding it on apply if there's nothing else.

Alice
