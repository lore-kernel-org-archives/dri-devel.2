Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443E8606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IWfERWUF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90C9A10E0B9;
	Thu, 19 Nov 2026 16:23:51 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C467710E0B9
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 16:23:45 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4a5024b3c28so802986f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:23:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795105424; cv=none;
 d=google.com; s=arc-20260327;
 b=Dita8CbKLDXreR6StgmiwfRMhml5B0cYXyB3sPIyKP+118vrjNTDNkbQS71Khgs3Er
 igQLINbFcXNSS1C9sdBsUnREerY3rq2yyA37RIXkGDTFyEp6+edXuyldzYAAdqWZ/4F8
 8qK9IVBjATyD9pmbSUtj83oBzBAbi4h16VDad6ZSwbAvS+4u+EKkBF7YHhUf2v87IUg1
 zK+3JL7+Tj96MLdXaTgoeH9hgxtJG+1FwYgUnxrKgrysCyXQx7D0SaxYNygR5Se5/und
 di8STykgrT0LnxR0ye0pmUeqnM8VNPfW5/+VnmMYCNKSVuuz97+n9XugO/GjytEg9TAO
 Fvzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+PcaAwQ0PR5vU4PI0WrkTjiNqMUtnDUUt58Dd2LFEBo=;
 fh=AHtw7EdnClvIx/S0/ChX3ICMbrhHSmeu+6DKSLqsJik=;
 b=bbbgav7Gnqx+eNgGk3yZLTb/zv7mhIcspIwIGMJ+4OdkrMmJ8qHHxizSgXMKremW56
 1yxHZRPIFEfhoWLm4XTuak7UAL8UX3EjA0Cu+RWRIhhQ6sNwOJKMJcRQqmGUyJNNWKFs
 Jwl8O0GT7EICMObPRPnPlrclgwbrukB3SGtyvDPtcCfIWkBTBHZ/eUBC2+RibCp4A1e/
 Btrfm7gjXretGOVHkalL1NGQMGHkMqk/L77FkhoSMh6fiHJmQ2Uh2bbfJNsCqkClx6j5
 N0x7PC6NfWyErL2RcYGL7bYKOYP5T3cTDUcDhLjNNPUk+oVSFgL9yQ9XqrkfyAI8A8OY
 RBww==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795105424; x=1795710224;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+PcaAwQ0PR5vU4PI0WrkTjiNqMUtnDUUt58Dd2LFEBo=;
 b=IWfERWUFxAG+wNHoX25ZH/wLqJvjz6ce2Tt1X4vjeZU4zac3DFzFITOJoXoy+zNmFb
 mRWC/gMsIbdfQ7RcvPN1d5aHisPuldBr/1yhc6UvjpAX2tapjD+PQ4mPBhHl9QgYNfWh
 HTfbV4lKFn4a6janEu3WvD+C+ggXXuUixR1wG0iT78rfSNnNJXJ4b0IKfJEFtcMY47Ui
 GgSaFnxWdsdvs4fVn5IdOslqbYCXHfdWFeBXG0yJeEKjBHzq6jTxutx71970Y2fhENxs
 fns+0ZDPATDa5V1ipStV7mrTNTzFHTmnTDB7ivrdkhlX0kjMLactQ6TrVLThiA10Cuwv
 1e7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795105424; x=1795710224;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+PcaAwQ0PR5vU4PI0WrkTjiNqMUtnDUUt58Dd2LFEBo=;
 b=XSAgCBP89II+9E3eAXK+syQ+36jq7bvJ2fWGg+06M7mnGLny3uaFR6T295jMCH9Cf9
 XwPJ9J8WvXZkj5CZmOlYMrimJujTKd6J42fdBz1p7XBMyi93zGZ1xv/abklkbnnNXvyC
 zPQZ5+dVvUQM6mwvjn2oQXZBUfUFhSUKly17kgbgBRKoemiyRHNUf1mbofrrXSrrrcJx
 BDIeJhtrnIrGrqaJPntvpOIjraJkPPArRzb/qDmf6E3QRJ+5oYHObCp82zH9w6/F1+lh
 WeVpAiKQTwPfjvD3G7QZ/BhoxptEL7NxtG9BsbeHVwX5AVBcbpjn6xhjg8Z09o2CqKk8
 mh9Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFXNbVJfpWf24hln2FE4QbXPvtLzRJ4gEGxik5uxuh6RzNRwWN9xE/adcv55cFnK8ikRWKr08XeG3U=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9jb2zTDnw00xBizLSLxpQItG8T7t3tiSEkLpbDVGs19duvFZVw
 yANXxjdx3OUEb7j9datL2vt2kC9wd/AP2boOOVcP7PinX9MrH8bEaMxVnS6Jrh3eeRKfKDvC8Zl
 o584lpb+F1p+DCgSqETQkuGF1sVGTRVxrM9sHFUd8
X-Gm-Gg: AZFdTZfZVa9OuJEFXCvJ7WbvzST+1lJlphb0HWGrm8wklWJNU+BXePFF0IKDFpnPUPU
 qBNkkwah25qcsTNVrG8mjLMKlyLcMlaWO0oDXFfE7Hb8kCH5EMG+y0ARrHpLvIEZXEh3dZtSXYj
 87RcmZOH6eZ3/oViEDFPyxAA2tUWWJBo0LoD3w0xAY/+2yww2tOYioyCXfmxtcLmBvHheG5F3gf
 PsTcofam6+LvWL2Mu+gSCwMi7/jOWPenS4SfiQvNADBS0qZivguSDiUJHjD7ia513C3CICkiocz
 KA4FvWxA9g/5CbCfL82kyfS4QroLnV+NamcruAQmKDvvee7EoRIYNrGKgAkYjFSmPpIwM6UmRVL
 SLKbxYjifPhABhId7CF2UiJaJ5xTXTAyDI+3hJqRdhAptO3QqKl7A5WrUSw1qh+ZmHm+oT+wHJG
 f6P4je1Zto0cQCiSgcDoe+gXkMx+HxHEQByyk2MPI+6l20
X-Received: by 2002:a05:6000:401f:b0:48e:7475:fe7b with SMTP id
 ffacd0b85a97d-4aa545e305fmr3959097f8f.6.1795105414756; Thu, 19 Nov 2026
 08:23:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117-tyr-remap-2mb-v1-0-2a8efd4c8180@google.com>
 <20261117-tyr-remap-2mb-v1-2-2a8efd4c8180@google.com>
In-Reply-To: <20261117-tyr-remap-2mb-v1-2-2a8efd4c8180@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 19 Nov 2026 17:23:22 +0100
X-Gm-Features: Aa3M54q16wzTGtbS81z0CLg8Zo7Ll8Oq1HQJT0nxCo6CHGOwHrlaM2Dzo0-8z18
Message-ID: <CAH5fLgjwOypVwBGaac100KiyCCwb+SqQU6Fz=CO98tJCd3zG4w@mail.gmail.com>
Subject: Re: [PATCH 2/4] rust: iommu: pgtable: add iova_to_phys
To: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Robin Murphy <robin.murphy@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 Deborah Brouwer <deborah.brouwer@collabora.com>,
 Sami Tolvanen <samitolvanen@google.com>
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
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 8:32=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> From: Sami Tolvanen <samitolvanen@google.com>
>
> Tyr's VM_BIND remap path rebuilds the page-table mappings that a partial
> unmap sweeps away, recovering their backing from the still-present
> entries. Add IoPageTable::iova_to_phys(), which returns the physical
> address that an iova maps to.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> [aliceryhl: split into separate gpuvm and iommu commits]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Joerg, Will, any objections to merging this through drm-rust-next?
