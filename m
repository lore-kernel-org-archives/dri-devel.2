Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1ABCD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16DD610E75C;
	Wed, 10 Jun 2026 07:14:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="saPjXNCC";
	dkim-atps=neutral
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com
 [209.85.208.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F12BE10E75C
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 07:13:57 +0000 (UTC)
Received: by mail-ed1-f74.google.com with SMTP id
 4fb4d7f45d1cf-68c2fe45057so6367929a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 00:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781075636; x=1781680436;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=GgADrub1g4FXQiLnn4LEUgo9LFB1ETRDIU9Hd1IlEMc=;
 b=saPjXNCCJ9cnF6O9jjkY5grZc3YZ1cBYJSZ+W37tFqlxYHxrUP+PPQ2xawO+yuYNs5
 iPPPNtffwoWvnUez0F/BqVhy8+exHcHuIaebhddGFUvAoWIFcPSPvW3NtbdEZvfecS4J
 oI9UrjFk9TfRFWTtauJPLU2evAMrPT64yr1AydNXwojSGYcnVqnZRrcPt6K0ocAzrpjM
 PB4zTQWR8LwsSCaswoXDmG97ygtsixUdOgsX+NdheBzPMfU/TK/YWB8XKF/UVk9wc0fx
 EBAumT8LAt4N/+9ngSd+WcFQSEAz76NR2EOBrL7YYNgrsgbu22Ei0g3ec4z6UdYBk7nQ
 rE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781075636; x=1781680436;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GgADrub1g4FXQiLnn4LEUgo9LFB1ETRDIU9Hd1IlEMc=;
 b=pJlY1aw+4oCMKI2cabI6uLheMPhADwkoO7eX0LduwhjNwVKeSF749LdE9JL9DT/+UT
 UcPnth7+RVQNGD+0iVt9bjxYR/0M/JmFh+RvG4Z463WizSKgeBp86B0Mi/dDzxkW3Ksf
 o4kCK35CfZieg0RJpDnpxq9LV3ym24jFdx3C81v9vPVJ/NCHBj9fr1xfA0dgrVhAstke
 UdfeANneA9D9lzFogESJweTn8FXcGAHSOVbrUx/uTVudL524AjQRsB8mrRt80hwvVZzx
 VYhRmc1x4PcyuBdRP9GKLfzArfaOvU0CvNs3fHjMkbzvce3g19jNH0X77guZxbtOzw27
 WSBA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bC+4LyXlsbIuWMbenGt97oUXT0QVvtL4bmcLv8RpTkNOL9kgUMU0QYOPuhj3EdnXczqMNvCdmfnE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwXpBgZ2Hfc62z6hSlwa+pGOHbTkmVG17QeGSIf/t7bHAqWer2E
 SK09WKVjkt8Q4smcQ+5cjKwktsCUVCsrqkxUxsQI/WBAXniSFpqyClVr3nvxkFsiP0i8ECyviDJ
 lzPF3c0iRq9P9+V3ShA==
X-Received: from edai32.prod.google.com ([2002:a05:6402:f20:b0:68c:5e5a:6095])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:518f:b0:691:b5aa:5a7b with SMTP id
 4fb4d7f45d1cf-69238635440mr3224327a12.17.1781075636160; 
 Wed, 10 Jun 2026 00:13:56 -0700 (PDT)
Date: Wed, 10 Jun 2026 07:13:54 +0000
In-Reply-To: <CABCJKucVW-FF2sti9gVoKkp-StLMof7kSqisbmUvjyEAaKLuTw@mail.gmail.com>
Mime-Version: 1.0
References: <20260609003256.1829625-4-samitolvanen@google.com>
 <20260609003256.1829625-6-samitolvanen@google.com>
 <CABCJKucVW-FF2sti9gVoKkp-StLMof7kSqisbmUvjyEAaKLuTw@mail.gmail.com>
Message-ID: <aikOstbyTYGuV8xp@google.com>
Subject: Re: [PATCH v3 2/2] rust: drm: gpuvm: require Send and Sync for
 GpuVm's shared data
From: Alice Ryhl <aliceryhl@google.com>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 "Thomas =?utf-8?Q?Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Asahi Lina <lina+kernel@asahilina.net>, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
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

On Mon, Jun 08, 2026 at 06:54:28PM -0700, Sami Tolvanen wrote:
> On Mon, Jun 8, 2026 at 5:33=E2=80=AFPM Sami Tolvanen <samitolvanen@google=
.com> wrote:
> >
> > GpuVm implements Send and Sync unconditionally, but it shares and drops
> > T::VmBoData and T::Object across threads: obtain() can return ARefs to
> > the same bo on several threads, and deferred_cleanup() drops them on
> > whichever thread calls it. This is unsound unless both are Send + Sync,
> > so bound both impls accordingly.
>=20
> Sashiko keeps finding more issues here. For the benefit of those not
> subscribed to dri-devel:
>=20
> > This is a pre-existing issue, but does GpuVm also need Send + Sync boun=
ds
> > for T::VaData here?
> >
> > Since GpuVm<T> explicitly bypasses the lack of Send on VaData,
> > UniqueRefGpuVm<T> automatically derives Send. This allows safe code to =
map
> > a VA containing !Send data on one thread, send the UniqueRefGpuVm<T> to
> > another thread, and unmap the VA there.
> >
> > Unmapping via sm_unmap() returns a GpuVaRemoved<T> which drops the !Sen=
d
> > VaData on the wrong thread, potentially causing data races.
>=20
> Looking at the code, UniqueRefGpuVm seems like a better place for this
> than GpuVm. However, before I go add another patch to the series, I
> wonder if it would make more sense to just add these bounds to the
> DriverGpuVm trait instead? I'd be happy to hear some non-AI thoughts
> about this too.

Adding bounds on the trait does sound like a good idea for simplicity.
It's not like we're ever going to use GPUVM with non-thread-safe types.

If it's help, note that you can use `where GpuVm<T>: Send` bounds or
similar to "reuse" the implementations elsewhere. For example,
GpuVmBo<T> being Sync requires GpuVm<T> being Sync because of the
GpuVmBo::gpuvm() method, so you can use `where GpuVm<T>: Send` as a
bound to directly express that if you want.

But if we just add bounds to the trait, it may not be necessary.

Alice
