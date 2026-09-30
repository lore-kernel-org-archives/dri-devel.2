Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EFCCA5FCE
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 06:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEA3E10F227;
	Thu,  1 Oct 2026 06:52:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="noVSUcwR";
	dkim-atps=neutral
Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com
 [74.125.228.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E38A10E0F8
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:29:10 +0000 (UTC)
Received: by mail-ed2-f35.google.com with SMTP id
 4fb4d7f45d1cf-6a996c8adf3so8910423a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 09:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790785748; cv=none;
 d=google.com; s=arc-20260327;
 b=a/u/Mc1Nidz96EOQdcIdBRsZAa3/rFIBxtwHo50Kc/+TQCN0V2odoI7NeGcdEEM3ba
 pNAmC9VUt5pma4YMVgcJaCW0vyu1LoG4PU8tDFMP/2PwpFQm+8ItKKi+uGVExXdkDlzJ
 DxqWKeIJc2rkACwbwvo9E19BImxuS+xt9ala61B/wMsKHtCJjmlusKIyEfa2213z7cRO
 8fL49m4yrjmABDlgv21kult/gPEFzk7RfPndKDRz24UbuOoU7BPpylHU871a/guSPjtC
 ODH4X5/dhN8LXKRVnpFu5nj85flU+CeYZuXuKctr3Y8rO1wRSnp31ESZg6f2FFMDY7Ub
 Zgrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qeh1LiNKQeZHlQZt3TuO+nbUO4zd0nfDJzQn7e6twMk=;
 fh=5ca8HE/uS9UpN7fq9KfXA5lNqRgpukfz/KlG8RPNWm8=;
 b=VLbW4DfCLqCGJb/87wYdTUJ5HVGU+mgdXc8GvupyayTI0N5gUmT5CBM3RsmK8p4bIM
 tMhGXYwwY6WjSXqEQRYYQhkDTzs+T8vqaa7QIFFFP/4zpopLvY5rEwKJRk/XsBUgk9nR
 kqPvKmhFlLpKSePCHE5fJu5ESm6X5fFkpvfch1CCvyJ3mzk7/KWaEi7+0lM3N+3gXPAt
 55ySU4oCoehSFW3OvrCWjjqWxcI3Y6DxrFi9LTKwqPjCkg+FPjfoDi0XJok3yoVcHt5v
 +tm57g1qrxqjDAggmC20CzOTbSiiTGfVBCvGAcnjn+i/Sd2K02ZaZ0e3QdY7lXNam37f
 cMRg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790785748; x=1791390548; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qeh1LiNKQeZHlQZt3TuO+nbUO4zd0nfDJzQn7e6twMk=;
 b=noVSUcwRciqu+slTxouWH+jpJQJ2yl1sIUmT5TI2W0aRXc7ZZX2JQ3Y5TQDiLaSoXA
 lv3TtjWwMQ5yBfxpo6472nTzXFu7osJznOUAgYaznMRVqJh+IgEEpP7S0gXUDAYZhoR3
 oBQOzdxgLjrbBRParZbx1Bg13GmuJrP/J0/mvPKGFX0ftkAPBHjLG+/YynlcFM+NL9VI
 UqWx4NS7eiGLhL6//b+Jzb8zpx4JjmuCdzyb/SxXdj/DxotPbDB1ntl6CWDRJ/uamiJI
 pihsJOVU7DU7cSA14UEF7AKERJJO5mx/j1qfHJDN7xPOCOQTKCrIOhCrJDerb4FQS1qB
 PzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790785748; x=1791390548;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qeh1LiNKQeZHlQZt3TuO+nbUO4zd0nfDJzQn7e6twMk=;
 b=dU4GLvfM323LVfIjcFvS8Qd2QYjwmjzk3O5imIKxk+3/bB7BF7j+/yUEcS2SkkSvig
 ApX5rmQbI5spvI0vvcYJkyeM3uSKo0fDVvZO7wLkY35NWRLP3WGZXC4RhzJIQFSW0DZ/
 r3nUmqIYfN9F+KHDI9p4ldA1GnNq1lzhjT4U+yp8P8gj79LPOWHeMzjOPXfeeSD7mHSu
 +6O+Ib7RW8GYm36nYT0z5LJoscn4meFApBCQ/gEqUHLLVhSsockV++Nh/YKASG8VX95a
 y09fIGd+8mH6y8GFEPfOqvuagYLRBihyhK64vpGTeQj7h+0wkgVA4wibovEsra6C/jPz
 Z3QA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw9tzsSN3BhA8bL7A9TM+oqG3h+nHJjrk8+uZHsxAaSXn1ydAktYBnenjWleKCK/vkz0KnPdDZ863o=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK/cMEe8vCoMwhoU5R6UNRzpMtf+HnyIJ0u64o4gW6TdBUklhX+
 BXh2mS20Fcm9Q9eKT+Z3884so5NmDiRcJ3tUW3KCO809tuKQ4DhZdEvCUNcO2Y5oLQ7v3WUg9Ok
 xva6wxyMcd+ohrpLMCPAPHU0n0A5Zub0=
X-Gm-Gg: AYBFou0t4ImQZNXXjE1UaE3XmUjhS8Hx0/ukOuzb/IA125uul1cx+VugedXQxqyPQtm
 j7vGWo1IWOLHVxwMDtH+bPxEvDpTf/2xxKeWRvVlPa4hqvCiw6nw0Tyb/TzqUFpHapCFfDh6eVJ
 wn1P+OeNKNY9mJK5MOAFhla2w0xi8X9S+uyd4sQVFK0PzXOuOiqh27yBXLjd5ujKEZFCHqcv5su
 /WlOzn0gx2naFIeMgLTYXZbIvzxHclYVXqbI5g43Tb7pqehAdgz/g+EIlTulJfYf6cWPjNIMHuL
 QSuLneGIf8exyv8WEEbvDjJw18BUH52jNnRvLyDXdzj021RmVHCj+cwr
X-Received: by 2002:a05:6402:1d54:b0:6aa:734a:a084 with SMTP id
 4fb4d7f45d1cf-6ae198f00d8mr1568406a12.27.1790785748326; Wed, 30 Sep 2026
 09:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260920-add-from-raw-conversions-v2-1-cef8e6e23ae2@gmail.com>
 <DLKOI7QW5M8O.II2G717YJDB7@nvidia.com>
In-Reply-To: <DLKOI7QW5M8O.II2G717YJDB7@nvidia.com>
From: Felipe Agger <felipeaggger@gmail.com>
Date: Wed, 30 Sep 2026 13:28:57 -0300
X-Gm-Features: AclHuK9uPC1AAVAFHpuASHRR5VxleuHnGeiAFO-3sqvHcRGMxC0vMih1ABiqeGE
Message-ID: <CAETh986oFE-dHtB_diDETGXQZWsxqx-i7sg5T_wCzVJ2ux6YJg@mail.gmail.com>
Subject: Re: [PATCH v2] rust: impl_flags: add conversions for raw flag
 representations
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Filipe Xavier <felipe_life@live.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 01 Oct 2026 06:52:04 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Em seg., 21 de set. de 2026 =C3=A0s 00:36, Alexandre Courbot
<acourbot@nvidia.com> escreveu:
>
> On Mon Sep 21, 2026 at 4:18 AM JST, Filipe Xavier wrote:
> > Extend the impl_flags! macro to support conversions between generated f=
lag
> > types and raw C/UAPI integers. Implement TryFrom<Repr> for individual f=
lags
> > (exact variant match) and flag sets (rejecting unknown bits), along wit=
h an
> > unsafe from_raw() constructor for flag sets. Additionally, add BitOr an=
d
> > BitOrAssign implementations between the raw representation and flag typ=
es.
>
> This does 3 different things and would be much more comfortable to
> review if split into 3 distinct patches.

Some things are directly related to this patch, and sending them
separately wouldn't work,
as it would break the build (as happened with v1 for Tyr).
It also seems odd to me to create a class without using it anywhere,
only to use it in a later patch. But I=E2=80=99m open to hearing other opin=
ions on this.
