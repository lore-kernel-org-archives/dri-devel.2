Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499B8606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tl0ZEzM7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AE8B10E2FB;
	Sat, 21 Nov 2026 16:28:44 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2888710E2FB
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 16:28:38 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-9495c633eb5so112338885a.1
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 08:28:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795278517; cv=none;
 d=google.com; s=arc-20260327;
 b=ArSwyKjqSLg3ikIkEfDrYDgLMwSowRCfdh+FJK4n6ZdFmOFE4JrdsywPYF3Z+MpWSh
 TYMVbBNKlS5idxmVIJpa4WjL5xro1YuEWDwbt7hJtuSbLWt6LWI9Dqw1YnN/TcYG2ouC
 8kCXiA0/0435LHzHIs370Tp2j51Uxr/lBqsy00Zv2tKZUqlCLJ+BZiDzvQo3DcGgUxrM
 xUw2y9UOOHbE7haYuOUrQ2AwA7vVX1I9CTfdZs24aM59YuZHl7WkIwMNQWSHoqlhvFoM
 FQMCeVDoHX8k7R0QZGNdk/4BWlshTbMJ0CNUzJIlSRVXThThdUxm7QYg61E8x8NFA7LD
 fWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+LGVfan7wS4hE7ubgJBRuwS2i7S/HbZrHu5p96veSQw=;
 fh=j9iZVwCtwVBe5AZNZt7pxP146hYI5sJ6ldDq/hX+cd0=;
 b=N+ZptzMCMQChTXSb6UQixWgtV6OfO/DBPkl8xYvaxax2ULWkBbk70JnXk4UrAsY2u9
 udC8DG6Xv2USPZJ38ZjZkMrBIM+gc1fcvLzcDegDxVWDCoR0m0dYX5i8Pvalp5q9LjFp
 /F7oQbSkVz4NII30tviTp49Wa73RE2UAX+3im1L+5SqUQd2GereqBkGDRsmooia97DLH
 CdktLrIW0h370X5Cdn1sfl274+T6rHCt8NoX3TrdYN3OXi4R9LdSc9O0l0xkisn+BLxU
 mRwgWU3zG7MKQaviCI9N8EjPCMT9iYgz8stjvIo0yXPODXnlKvCpvrGqbshPEfjkTa/D
 ttcg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795278517; x=1795883317; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+LGVfan7wS4hE7ubgJBRuwS2i7S/HbZrHu5p96veSQw=;
 b=tl0ZEzM7CGiGmCLJ3A1r6z0Idw6DVIu9S4c8JTW/GGXw91q1ySB2ymdV2ZgDCoUjMK
 YI9qsGvAJmNm6z1hT+BgWhe8wIBsjAe6cyi0/C/wPB4VOdQvRBJP4XSmQfhnBEICMssa
 mitKin40sntrX8j40LLvkkBWofZo4f/WyMIVD4bJs212DyIljtTY+LwzIoLAIm099B3J
 MEuw+soRd08QTVulPgVudYe71pueBab9+JuSYwmWynMCcFqqQVp0pe2dMaotGi/XGNiy
 eT+ObnLB3cGl7cGPmT0/iZGEasfxhk/NfXtBp9LxDavU3+W/NlTHAUh7niGWdxgb7r2U
 5fIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795278517; x=1795883317;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+LGVfan7wS4hE7ubgJBRuwS2i7S/HbZrHu5p96veSQw=;
 b=jo1VW/ApLJRof3NScgkAF9L51m0hae3FLlLX4u8ebItiyDnHUy+1j3Zq8JE4cP9rhz
 /TAbLlWXzFh1KjLTi2m2vtzZQC9K96Pq3s09EE3eJHEhP93D7Kn45RivIforaJqSsxUE
 4GqGRfWL5kOBTxsvjxYqFuj8SB7xGyQFjcNQMoJ+mEwXSdW264Z0vzH3z2SnnJKtxSBk
 44FTyhEJoQUx4OQhGDozIpxkekHvxKWCObVKmzIxexHb1BxeBUVxqzc0IjD13MXBwAsz
 q2bx7kPnXuJwLeBahPZk+ss5ULat78/SgavpDzrW+xTFDFvQEN+Ha1Ippa7gt7w/uQ/s
 qixw==
X-Forwarded-Encrypted: i=1;
 AL+hErEC/eOdl0j5p4SNCviHa+aAjS+vnyfhin1BnlKePx+1seB8F/E2wjIagj0PqE95x21GRg/9L0MZ8rQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8XhIUxo9Lu5A4VRjVwPNGx6/ITvAY/WY6BDtqPnJQBAw54p4hH
 USTZTuTLIM/O6C575ef+2lHqrDg0qBf/1elFqTv5X4HljD8pkyeGidqMWUfgvIdTEQ9BSiJsw/L
 4lBXraW8/Qs72hYvg862TWxlKI5V9nfQ=
X-Gm-Gg: AZFdTZdooJKE4MJ5QpOs9KslrKsiYvqeTogQQiV/E/cIhpLrUs/EBJLN5Kknl0E1wnp
 bjnhdy2FTj6Tb4xn1YY6s58nPpVjd/3zCF28/z2cgearUigA1rF/AohltYNL80+pugh3h/fsrOU
 lSkeiJDHI38xB/on4k0K3csaSH56MCS42m4uubS4xyCczHnwGF5+Ip5ek3m3YObLCaj9Cp1E7Kl
 jrSXrm1ZkInhCDOt46I/UjKbh13Qt+ZYvaIfp6WuLEm0Ub0Oub6ss2PHp9hiyh8vQFH2Zdf3BgJ
 rmCqz1BsfN5W3FivWBjmhxPOj43JPSLApd7qcLF7fUxZd5nt0SFpXsJe0ZvwakJYMQsFCLw2Qq+
 NgcYOLF0rEDUElp/tIkX3uFGHec7h9bN0kiQL
X-Received: by 2002:a05:620a:17aa:b0:949:68b4:6dfd with SMTP id
 af79cd13be357-949bab68a6bmr982581485a.70.1795278516567; Sat, 21 Nov 2026
 08:28:36 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119111850.33270-1-mbkchelofficialdev@gmail.com>
 <DN0ZUECUCER4.QK2US2HOR3I4@kernel.org>
In-Reply-To: <DN0ZUECUCER4.QK2US2HOR3I4@kernel.org>
From: Ivan Tverdokhleb <mbkchelofficialdev@gmail.com>
Date: Sat, 21 Nov 2026 18:28:25 +0200
X-Gm-Features: Aa3M54qxaLLJMpAz3ziEfzSAwX7WvkoUi-S7MpjoDWzxyu7IuqrwsQMeFE1oYHc
Message-ID: <CA+YDrKAxh8cQPb0=jBEmZbUYfBMu6E=dh+PHLYz+LyMsKXtDSg@mail.gmail.com>
Subject: Re: [PATCH v2] rust: gpu: buddy: store the allocator inside the Mutex
To: Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
 Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>, 
 Joel Fernandes <jfern@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 dri-devel@lists.freedesktop.org
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Danilo,

Sure, I'll rename the `lock` field back to `inner` in v3.

Joel, thanks for the review!

Best,
Ivan

=D1=81=D0=B1, 21 =D0=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3. =D0=B2 17:2=
8, Danilo Krummrich <dakr@kernel.org>:
>
> On Thu Nov 19, 2026 at 12:18 PM CET, Ivan Tverdokhleb wrote:
> > @@ -313,16 +313,11 @@ pub struct GpuBuddyParams {
> >  ///
> >  /// # Invariants
> >  ///
> > -/// The inner [`Opaque`] contains an initialized buddy allocator.
> > +/// The `lock` field contains an initialized buddy allocator wrapped i=
n `Opaque`.
> >  #[pin_data(PinnedDrop)]
> >  struct GpuBuddyInner {
> >      #[pin]
> > -    inner: Opaque<bindings::gpu_buddy>,
> > -
> > -    // TODO: Replace `Mutex<()>` with `Mutex<Opaque<..>>` once `Mutex:=
:new()`
> > -    // accepts `impl PinInit<T>`.
> > -    #[pin]
> > -    lock: Mutex<()>,
> > +    lock: Mutex<Opaque<bindings::gpu_buddy>>,
>
> I think we should keep the name inner.
