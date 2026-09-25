Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334D4C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7112610F942;
	Fri, 25 Sep 2026 07:57:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="hDWsszEs";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59EE110F942
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 07:57:07 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843f22dcb8so451963f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 00:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790323026; cv=none;
 d=google.com; s=arc-20260327;
 b=hh1efeV8FigAireoJZ8GMLi4sqviaWTs3gcobI7V+lLrYx12SDJbyu6f3PYuPsw1+Q
 JXdzimZajN6+Uv3iYc4ETwiSXSPPqEfaVKTeoUuav+MH5wIEepd7UHLrIFpUA0/hSNQY
 y9qWSg0E0BrxbbXwOo+2i5DY7fRfqi+nMIb2iIYQz4MHlRDeQCXvBpmreUMUwfhmHY3e
 FGDqPnewu4z2ik4GNPlnQ6IFnCHXiHQax0F+18AHBwk3AVkeMTUb1XyXGVNer0XM95dc
 EGmeVHi3SUxR4IYpkPKjJBkHcgz0t8omCWS//4MJIVNODI9Vz95Qwx7LJPtv10kacLQG
 ZjXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=K+5vgDFe5TGrq0mQPO50IjtX5/W4RN5ErRGtT9lE5JE=;
 fh=SPKEHmxcpXv9XVFHAbjSQUjkpmfvin8iRRDtLL89Yos=;
 b=JtQoB2PC4XQZGOwI6RJD/BU85plDIrhj8Rj+UIuB5BSYP0pwU+yhMxqLpJVD8AZR41
 DD41B/OwOaqn2RlxhSkH+e5ytXzmmHRMdRnt0U2xLYAyiBABBYQf5D425I2fI0oHrPnY
 W5h+RX2ackTsw2Nc+p6Jxw2srsNmny1wUv6GvXkeJ4iqWJz6ymMBnraER1UeW8kF44EM
 9qID+DuUI2K4YyrcQUC7ZiojNGeb6SroxzaSpPOkSGuzAPiI9coOhVMoeT0nRoRjHzvB
 pikSInXQOBDaKNufYQKziNecoRflWI8E6Fq05sC8KpRnQauoCsO6Tpu+5oVFlrw2Rebw
 /6hA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790323026; x=1790927826;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K+5vgDFe5TGrq0mQPO50IjtX5/W4RN5ErRGtT9lE5JE=;
 b=hDWsszEsdaWZkpRvRH+aTA4HhYyIL2xVCpgYyma3KdUaERRZooNNqH30F3PPpWMVwL
 EF8S96rA4GPYNqhSdxV46KalzVFNTZREpUj94sfBOUARFx9xyj1/VNqJCqRA126v5BWX
 3J8HB32ADTi/H61WxVX91t90ghu4r4jjRPU2/ugqzXUo5I2aElfAA9h8iWfaBOsmoqbG
 6f2n1ErPWo/xPAM+EGTR/4yzeQMK35e8b6J+IuPzyo6jBp7fp5D6Ji1XUERroppHKCet
 etEiDwYpFFCRx++3EhkMuc2RONv/E1NmWKNGS+jgVrGjmR7KuHazcuAgg1J++heGQwb0
 Je3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790323026; x=1790927826;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K+5vgDFe5TGrq0mQPO50IjtX5/W4RN5ErRGtT9lE5JE=;
 b=iJEXzhoFU21g7PmZPNEMWclvcIVZxJ4vxW/DZqndW0Cf5zO7tvOeokfluiUyg0ORSD
 KeIi8NC0uAlb7jHIGJwY1TzbUxFSZarqglX/peurv6fLxPSgXb9UpMxoRYCnzTFZxqYE
 Xtl3EfjfK9rS9nmB+Aj9ED0XAHcgMycm+8Gx1Z5NpefAVaDzRRuI7RaskFMCo0ez+a3Y
 Gz/v0rbdLehjSf5ivThsEfF5WDayAkv6Xt6ba5i9ICtNpMtY0hADyflA1f39Yz8MHs32
 8lOuz3J+r4xRS0ZBbl6+6yNQS8gyGPU6bFxaL00ZL68DXoU/LOwueYu9sXulpbY/UGYH
 7pVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJgjS6HAP387COFPLC4vYw9Xj//7INzK7BIpQQXiLEraa/iMMfyfEfBbkxSw9lMfcWCEhDlxjzXRI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n+P2XhmACaCp8nVjBczL+hmWyi/CX99MnooBO4JqQgHz+5sGK3
 SzQYnQFgqPh532QLk19jvAvdWV/9CgWF7cSphb/Cf7EGqLvZs2IMiO3xbbMzw114SznwyQE6I+L
 rPRpcJ2UasnumeNTWZrtSZQgDP07YLUnhV3NyEeKO
X-Gm-Gg: AYBFou19B5+RunjZI5m1qtYlghRzWBjIMsAWNsqlYD0UP5/Nc6nERgklnRSa3WMt7WY
 S++eYj+kvvxDKVc03iGN7Wlx3JgPRMvHo59QY613GzJ0Df5KWv1mcJf393QUxGNRhjJIRR9X+O5
 Tr9MuNUTN2Or+1StTdbofsx12iEnWKS1e2xEykzsomWO/l2lzXsT/MsA/OhMBMq4jExPSVDAGhd
 T3cUxsMQNPvzE1fdQpfButRy5V8llUnUbiRBe9qSGceq5iUoAR70E7f0Q8BtmErWZBKbaX347Hm
 ngVw1VR7i7YQpil22E7H26b7ooiA/9Gm0wHuo4MNTH9Th9nH6Kp4pPRQFGabpu9TVm7AcH6N+mi
 FF/b/MaUDzbPCy+tM/mN+p8mCTmi6aRr1JOsM7XIJBGqBJOv7ad+/
X-Received: by 2002:a05:6000:64d:b0:488:7da0:fedb with SMTP id
 ffacd0b85a97d-4887da0ff09mr2217956f8f.40.1790323025312; Fri, 25 Sep 2026
 00:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260924-b4-gpu_info_intobytes-v2-1-1b05e33df8a4@collabora.com>
In-Reply-To: <20260924-b4-gpu_info_intobytes-v2-1-1b05e33df8a4@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 25 Sep 2026 09:56:51 +0200
X-Gm-Features: AclHuK_Dn3TRdt8_mIeczM_Dej9VW3qvC_z6fo4fHT4gwnLFIhhWWIgyFak4gco
Message-ID: <CAH5fLgj=h_riWoOvEX_TOH3+0FNbKBtjO1OrxzwHDQq7uzXg_A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/tyr: safely write GpuInfo to userspace
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
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

On Thu, Sep 24, 2026 at 7:22=E2=80=AFPM Deborah Brouwer
<deborah.brouwer@collabora.com> wrote:
>
> Tyr creates the struct drm_panthor_gpu_info from the Panthor UAPI
> bindings. It initializes this struct by querying the gpu and then writes
> the struct into userspace memory faithfully byte-by-byte.
>
> Currently, the struct drm_panthor_gpu_info does not have any implicit
> padding, but if implicit padding were added in the future Rust does not
> guarantee that it would be initialized. Then when Tyr writes the struct
> back to userspace it could expose uninitialized kernel memory.
>
> Tyr implements the unsafe trait AsBytes for GpuInfo whereby the developer
> guarantees that struct drm_panthor_gpu_info does not include implicit
> padding, pointers, or interior mutability. This allows Tyr to safely copy
> the struct into userspace memory. However, relying on the unsafe trait
> AsBytes is fragile because if the Panthor UAPI changes, the SAFETY
> guarantees may no longer be accurate.
>
> Instead, use the derive macro `zerocopy_derive::most_traits` for struct
> drm_panthor_gpu_info. This macro will attempt to implement the zerocopy
> traits for struct drm_panthor_gpu_info. If the Panthor UAPI changes so
> that the traits IntoBytes or Immutable can no longer be implemented, Tyr
> will no longer compile.
>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

So this looks good to me

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

but needs Miguel's ok since it modifies the Makefile. And I imagine he
may ask the commit to be split into two.
