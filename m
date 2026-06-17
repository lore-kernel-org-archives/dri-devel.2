Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741C1CD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:11:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE46110F030;
	Wed, 17 Jun 2026 15:11:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UbrjY2I/";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8673710F036
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 15:11:35 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-137e836ccc8so412083c88.2
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:11:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781709095; cv=none;
 d=google.com; s=arc-20240605;
 b=Ofbj+m0AdIOUagXXYCENYlqyCsg+ZmC1VlOqgcbibfkBuW1nESU14/eR9kF7b/npUJ
 +g4pPeCfYojxJrr35ZEmx2ml09WgXV3neoHP6VRqZyu9/QVWy7vrc3d7CJjCAlAcvCt1
 Rj4pF81UkQ91WGGi126tGVdRivOMzzqBCSJtzy1fijFssca2FXrkFFi802fMpZcFzufx
 E2iSkzoRCdskUfbF0MgICssL44yvFjGrlHhnK5xa2McyK0Vcu3gRKVnT9ChxnKpSFtsp
 A07Hu476MUZw8Fk06ltQw4fAC7IkIppfiAbTy2vk6apqPz8t9bWJAnJXqMy1PVg8qLH5
 JN3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AH6TzLeaF9pIDFr0hAkgF7LI4JXf/uaA52xkp3m/Png=;
 fh=Fn0lsZmzMJfqTRiYM+Mcr3BHqACvi9PdR/x9sk52o8s=;
 b=FJxlj0ENGwfZ2Hg8J6fc+gVEbL3bC2RliCnLSKDLr1laOXf4DCSCk+OMNarHapLyKf
 l8WDzIKrpw4H8Gs+Jg28rSroZcto8AM33IzcZNCF9UdTjO1+n/mHy0b5lR31x6e6AXne
 WsoloKZ7J/+t29xa89shmqZBzjKYCJgtYmI8fSZIWhQMjZPXVUCV8c+CSQA/slAvSbew
 VqCXVsgidIDQR7CVkCbfPIghkUWWgSQ9ls1jaeBvHc3RWbPnfBbMYpzuR/J2ww4i0jv7
 PobFiY+I+HHJCGU0PGPJzkIlAFhzlM2TRxJ0S06WMydVrAZuumMEvzzi+iER67TqUGUv
 vrMg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781709095; x=1782313895; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AH6TzLeaF9pIDFr0hAkgF7LI4JXf/uaA52xkp3m/Png=;
 b=UbrjY2I/R8C3lQCE9j53Wf+6Wx7kbuqwES17sumZMUOnreqxAZvJprOdk8Qi9LCobt
 ZV9HnghYpFhASjbujL6nd/y/tDmTWQKjmsDItfVz6M/YIO+P6DdjPttSQhT6NJAtts5B
 hP4WKDFfIEPywGVWciI9hD/roq6hc4xoaXFbu9hG1AKealO5zs/abiiaBnPKSb2EH4pL
 JXErvceWehqNgjqg1nITmp3n88WH0WaIxN+v0Bj+gYRKyJtmYP6dRDVAQENjdQrX586w
 XB7d4Pybv+DdS5r1LxWcgHv4sc3urK4/URGfHe70j6ih/v7SfbToozJVPGQOiDEorLOr
 vWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781709095; x=1782313895;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AH6TzLeaF9pIDFr0hAkgF7LI4JXf/uaA52xkp3m/Png=;
 b=k5/dG1P2XpzLZWCqmvgmU8PusX4pYs75Cr5wv5TweGFxAWzNdyBzl87gcHxntqS3j4
 x4iXLe462vBv/j2Bc4p0Vd6Q+iE/2xKq6MzN/m1Vs5kBQEFA71p8SlT0T+geCP/yZyF9
 AHqkPNXt3lwU9omGZMSzK4S0vCG5BYK6+FnCzfZ4tR3P7v8+HMPj7U/XRiIeKAOGwGKY
 19rV27pIRlb+uWMl13wWLP3Mp4UdxlFkBc2l/eJDTI7Feg+3O27zAHaRKy+o2eSKlhHl
 mQRzw6eyguA6kg3YjUbl+tQ66FLWGoS+Y0zhV1QpJFROsQB6cKSPsfNnCziVU6uzV6Y9
 rUww==
X-Gm-Message-State: AOJu0Yz/Ri48xykfmz3eCWg00idRSAN2AdPvqvhCGHjutefSti/w6Grm
 gInw7nxcGOWiYnHmMvcVqa1Ijwvy92hG6V5wloUiFNptrYoZgm0LNyhV9am2nGqWqwMjOAguEDi
 Sc93bl7JytXO2uL/Z1F/m33v1f/asMIU=
X-Gm-Gg: AfdE7ck9YQZvUupK1MVrrB77ndNAkErT8G/mo+dysE9rdf2VUHQ044yHa5Vnsh3z0h5
 JAj144VPxCoL+5QVJ62SUq7Zn8BTAUVIO9tpdBu3UKOP6h6skeJPUK9+OGrCT1zluORIYAtIxwp
 DCwRefXwlzIyHu4wIzRHXW2xNs1zHECuzCfgy61V8V4kmwyMriae9CvNd0oSWQGe/W51SO92KmE
 8whr9+jpeYRCmg01xYwHSZgAPZEFMI+JUPqDprb1Sh9B48DPMbG7Tr65tlqXyxzKnZqW3RMoNNm
 peOvAsi6DZ+Hn7NmkW/HhOMMZmz9xWf2WxcOwGOLbb0lv9b+Tvzn3GL+hZdZY/W6DKtL3vxdPMh
 qJOJBjFcarSYQ
X-Received: by 2002:a05:7301:1298:b0:2f0:ddce:8468 with SMTP id
 5a478bee46e88-30bca21caddmr933276eec.8.1781709094242; Wed, 17 Jun 2026
 08:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260617150232.2210-1-mike@fireburn.co.uk>
In-Reply-To: <20260617150232.2210-1-mike@fireburn.co.uk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 17 Jun 2026 17:11:21 +0200
X-Gm-Features: AVVi8CdZnL9JO8r2T42R7lYCwOeoWy3VmEc9cj3VyPuVSQ7bMcrxUVbNYko7up8
Message-ID: <CANiq72=PBnUkJ6yGk-CiiR7972=oHTfv0ebw0EfRchVarwoEGw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] rust: drm: minimal KMS bindings, EDID read,
 rotation, HDCP defs
To: mike@fireburn.co.uk
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Lyude Paul <lyude@redhat.com>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Mike,

A few questions on the cover letter that may give context to
readers... (for this and the other series you just sent)

On Wed, Jun 17, 2026 at 5:02=E2=80=AFPM Mike Lothian <mike@fireburn.co.uk> =
wrote:
>
> It is deliberately an RFC and interim: it does NOT add safe Rust KMS
> abstractions (CRTC/plane/connector wrappers - an active upstream effort),
> only the raw binding surface plus the trait/visibility tweaks a driver
> needs to call the C helpers itself.

Do you mean this is not meant to go upstream?

Or do you actually want to land this interim state? If so, then it
needs to be well-justified why we would want to make this exception.

> drm::Device::as_raw() is made pub as a documented temporary escape hatch
> for calling the C KMS helpers until safe wrappers exist. That is the part
> most likely to draw objections, so it is split into its own patch (3/3):
> the feature flags and header bindings in 1/3 and 2/3 are useful on their
> own and can land even if the escape hatch is reworked or dropped (e.g.
> replaced by narrow per-helper safe wrappers).

Yeah... this sort of escape hatches aren't great. What is the reason
for not directly working on safe abstractions?

> Factored out of an out-of-tree in-kernel Rust DisplayLink DL3 dock driver
> that drives a virtual connector and reads the dock's downstream EDID; but
> the bindings are generic (the same path simpledrm/gud/udl use).
> Compile-tested in-tree against drm-next.

What is the use case? It is an out-of-tree driver? If so, the
maintainers may not be able to take the code unless there is an actual
user in-tree.

Or is this driver expected to land upstream? Do you have a link to the
source code?

Thanks!

Cheers,
Miguel
