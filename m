Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D33606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Z6bOSGNz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 639AF1124E2;
	Thu, 26 Nov 2026 15:16:16 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC4C1112510
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 15:16:10 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so92068985e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 07:16:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795706169; cv=none;
 d=google.com; s=arc-20260327;
 b=Vb10e79coU2sei8Ra10kos7hHGPHktMjllSJVm6Xpz3eh3I0AvmfjEsxKKNZgYEopq
 z66Nx11ivU/Yaf9WAXRfJ+fbxOYIE57ZPR34/HLADgAov3gu8iT8/MrGZt8C9DOrtRBZ
 kdRRpqOf6KrIjWC8fgcH9OO7mciPO7ya7PJaVHo1cX1vza3UTRIpihLljfTas3vR7dIM
 q37z9KSi1qV91ZXWMl8skVg+sDn24rHWW/1ROQLpxaGLqxu5MFt3eH86wZp74XyoF6Rb
 cCUNcXuyYvQuH2FeSvXrEXOZV27d1bxjgSAo4VOBzLwp5ev4X/NXUvo0uPd6Oc32qrYX
 k2fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mBvXmBLkI+5ZVDxMnAotYXXXMOB1nSxF2QoCNRUPkp8=;
 fh=6JT1HpY83i0qIuprJEUCFRAU72RZvaZJoRmcQg59U8g=;
 b=CGDcPPM4LYkmdMZ5t2KFxjlpK1BSAO0UbjpLeVrwr/vW3HewQAZqEedTL4HpEO8tlu
 B3UqkX6LaUT/AqmH74GbuVByJm92EWNCMLubTBqJfoUTanxpBBDzOErQKeG2OvhcpkdY
 psnW2M18YVfG/owRaJcMtWJP/HSEi7F9IpjeraQO9kppqm/xr6nV/9TVNpYNQPAJig1j
 PYKIM7RsAU76f0WD1aP9am+eS9u+EA66C9Pf4fQqHjyPlTZBrGcljTTQEnNJ8kJCt42M
 tMOFao0krbiMzF4uRNrQwEupg01rJBKLlCo3lohvv1cwb6NTEX/K8qXcexBcSIvyW5i3
 LQHw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795706169; x=1796310969;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mBvXmBLkI+5ZVDxMnAotYXXXMOB1nSxF2QoCNRUPkp8=;
 b=Z6bOSGNzT3otuT0FnD7rnFxXa2TS5sF9vMXotuMyKP/nG4sglko6wxViNANc/GuMQS
 clTmIfo2FZimO+e5GypZLoNGyZ8Jx/asY27ZGKhggCLM9mY2RcHhQXpes23NK48UsWOt
 QWl2Hrjp0kORGLPu9oL/42srdUqCw2OjqZvKZG8mNhyeLBJSuYZRUrwvUPor7s2f9Mjj
 Q5LpB80atmXbxqKOZH4QsIY2WlidirN2TVkJVz8JilqhvoYsLz0pppDAIUalHydspKZu
 ZDu+Ndqw+bt5zIR0WN9cwa7cOGXfQZgrVf7LVOjy3uZlPu9xxmgrus9fK9j9BUlrLHCi
 eqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795706169; x=1796310969;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mBvXmBLkI+5ZVDxMnAotYXXXMOB1nSxF2QoCNRUPkp8=;
 b=Qik34kxuj9cfpsSzh1sMteVKy2UamaF+G6VHjGPLD4k+Wk6NsOv/j39WQGa1+Shd7l
 4fSueSBd7mFB0A0KApypi36LPk/IgpmHRYxlSme1s9QpuIjI/Tr5W6rmu7Mx4jl+/2S4
 ggTj4p24SLoQWoRm3Dy3CegG3FSGxEfNJMAG2tzvOFSZGEAY1D85Um9z5vK9IX39pjq5
 I8i74Rc8AZCXvtPq5tOBT+5O6Sa0gReLlkcNG2tJJW9R69PCOKoRpRKTUFwzIdwMDRqX
 e17Q3Ux8txH3f9elOe00sHULOX2uhxUorNx3COSMMHgBkQnGuFt6vTXrCoQ1LAK1qspI
 FaIQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFZepsO1CJ6yMboS8MfePMKXyZfmoeXEJEMMW8qJEDnNgdk2a2veu6qGvISxaqGSnQTPKZKZFTkHI0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8saNECNoGiWq9jmQbKK2To2uhIWwdrk+39jm9NmtClacrdiZZB
 7f0zI/wUK+slZ4yi9kad442a25IU5r9qPnm0cpF017V+Ki4EviqLT7sXigTiPhgXIlyHr+suE7q
 +NSUZ6ETkMHygYA5GWMralxuykXddMeWsObWxXs+2
X-Gm-Gg: AZFdTZehOwXAls675OpJQY7TUEv/j66TtRqlH9p6SP0OiyAWnt3DSxncLxoAn/x0NEu
 rKe1x5W4T2+BcZnnitaYNXKuwZRzu15b0uJdkJ3pFTDbll1JNvPeVlNgiixdF/keLY7oF507MKB
 RXZUFRlOKagpFpEUDHcuNngUXq8986/EuefnSOMGR84CCVkiAt+EV7B49cLvKeIomrLod09vD+y
 IUAB4IJ/uEz3FCUX6rTlNPKVjCc40wi8Ng66NfiOOSZAMmo3rck/RQAqB4/j0is6/Hhj1JtOI+L
 0ZZG9d1jIk4nRkSmMKdAiTHbfNSOXOLaNN0c9Gu6lXXLFohV8dOla1oei6C1uOtuWZ6FwsoBi74
 DJMS/o49+4beUxAl5k8h49wayYotcGg9pLucAq9q9rHfKus2IIUcn9XF0Rv3Vzij+k8fMaQ2+uu
 x35e99PZE9sJzbHolQEtb4fOoYwe6IRkhRZDuschs2Fpgq
X-Received: by 2002:a05:600c:16c9:b0:4bb:7ad9:311d with SMTP id
 5b1f17b1804b1-4bb861692a1mr332818735e9.19.1795706168571; Thu, 26 Nov 2026
 07:16:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119215046.2892839-1-xinmengs@nvidia.com>
 <20261119215046.2892839-8-xinmengs@nvidia.com>
 <DN4P1UAAVP8G.2TUW0Q8UEQVCG@kernel.org>
In-Reply-To: <DN4P1UAAVP8G.2TUW0Q8UEQVCG@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 26 Nov 2026 15:15:56 +0000
X-Gm-Features: Aa3M54o7yVaAHH6adwEWSabFuYapgO-QYKd3fskOtzrfMLGKtESTl7nq44reziM
Message-ID: <CAH5fLggYpTiLKDXMQ9UYBGZ9VuZBWbNfCZn9fs=i82-xf6A-1g@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] rust: vfio: add PCI variant driver abstractions
To: Danilo Krummrich <dakr@kernel.org>
Cc: Simon Song <xinmengs@nvidia.com>, acourbot@nvidia.com, kvm@vger.kernel.org,
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev, 
 linux-pci@vger.kernel.org, alex@shazbot.org, jgg@nvidia.com, 
 yishaih@nvidia.com, skolothumtho@nvidia.com, kevin.tian@intel.com, 
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, alex.gaynor@gmail.com, 
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
 jhubbard@nvidia.com, ecourtney@nvidia.com, cjia@nvidia.com, smitra@nvidia.com, 
 kjaju@nvidia.com, alkumar@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com, 
 kwankhede@nvidia.com, targupta@nvidia.com, linux-kernel@vger.kernel.org, 
 zhiwang@kernel.org, zhiw@nvidia.com, boqun@kernel.org, 
 daniel.almeida@collabora.com, tamird@kernel.org, work@onurozkan.dev, 
 jgg@ziepe.ca, bhelgaas@google.com, kwilczynski@kernel.org, 
 dri-devel@lists.freedesktop.org, peter@colberg.org
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

On Wed, Nov 25, 2026 at 11:51=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:

I suspect Mapping<'a> should wrap a VmaNew instead of VmaRef.

Alice
