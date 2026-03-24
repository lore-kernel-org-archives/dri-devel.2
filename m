Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CD8E9A762
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 11:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67FD910E65A;
	Tue, 24 Mar 2026 11:00:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="doPgZe+8";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D927B10E65A
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 11:00:23 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-439b2965d4bso2690926f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 04:00:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774350022; cv=none;
 d=google.com; s=arc-20240605;
 b=MIgqlBPObEP2J4NN44//Oc/mHwC6SdyRp27d9awJLvZsyTzF/Leq2SUa8ItLeh5Hym
 N2jMmV4q+KtsqtYF8BqFUBWR8ilKRfkS297ZqHwKBDtg9rsaoV6goB8X/J8FxMCY4rLd
 L87tcCi/VGq0Y63LTWbcg/7OMtVAUKJOx0vF2ks6E/WygmCexqJL4gVZcFgWfNs3CIQg
 2V/rQ8y9oG+igsmygjMCF8C3q1uU3MEOQe/xkWTdwtNEa1KO9iyMyskneK+y3k0Ccv3p
 fBsZV664tb3GFbM4PN2VEYLDe7QXEkwrGEMr2jTpteRHzav6EiJtsskmXKQnsZBHjrTH
 W3MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jY/uy3yLMLv8f6bDRqU7cC+l89qOWFndk2uZeXEp37I=;
 fh=iSWyb/38fRRhy1X4cJ1h6Y5VUQDL6bIYBGAZTQvhBXY=;
 b=EPjAgJQWcnK5WEMNip8c5eKyfn3rWKF8e6UwbVDFHN8O+8tyh8dgd4Zmg/V30OoNL/
 r2kYTB9hH+N61GLtXLTvVuiMnTGGGs/e+zPoqxcF+OCVOW3ZfQMJu7zrv8f0722YEeZS
 0MbK6IfSmOA6AchMLB8I6u0AgJlWB1pETfFOu2R+CjgLP8pvtsQnGRC2W5oSNlAP1kBQ
 Q1n2oEYT1LKa0VAIfmXMA+tA6JBBiqA7G4sXxQrYE3JfmmOvY8wojsrUclHckA0YdJAf
 bvJI7p5MEr99vyeF7orrjeNkkJW49UFYII2u+UqDDXgk8guDiPJu4ddiXYhLat1qrLEx
 7wqw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774350022; x=1774954822;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jY/uy3yLMLv8f6bDRqU7cC+l89qOWFndk2uZeXEp37I=;
 b=doPgZe+8PrSWRx3IkKFrs1vsXODckofFevuPc+5yDjFupnvEoYHbD/FLMxKpkNe4do
 wQLHVTQgB4zdSRj+PgH/XFrrYDrpivz3bBp0ztj8pmWGnK6YMsQUtjlQEBD37H1jybNv
 Frk9Q1yhRjppOlOjT3fT6NGmCszWJuKKRmIcFI8Vnm+1In3MwM2N8oR4id4mxlGZlFzp
 zCkW7Ssva+tEfF7u6l9fma62cpBAm8RVX0UdjTxHsPu4Gkn2oMuMU+Gf2hlB7KH+bPvy
 wMqdtzdYr2kyGJlLiryir2xkACpAjrNH8B82H2zUuRzUy3o0T3qIMXG+Pna0tDxsaMrK
 taMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774350022; x=1774954822;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jY/uy3yLMLv8f6bDRqU7cC+l89qOWFndk2uZeXEp37I=;
 b=XC8YAVHt7r2JWWjAun5m1KMwCsSf2bFgMfOq77UCB61D/CFFDZgn7/K8E0iDBOPuqY
 c0s/NOjmVjC+or5uJUFvWm1UPw61ML6BT+FGbUne5Py8glTK2XMhl8Oyj6gZi/3CYwSD
 5Q9PY2zXWqoclv0cV+z7oLIFY7gDS5QZ469ns6i1mQ1fdfQxZszB9INVohBz9jp5pjFl
 iiEly3zuDceIgtHVZg3eC7RKAwcKR64qM57M/B3KNh72LoRXwbFwipBxKHQlO0OLXnmi
 xQkLPIOAgets9x6goGpCKGccd60JqDQtVRyDYLwHm5qF9eVlkqsJw03T2DLyDgKefF2J
 0yog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ93Do+qpU7R2kicEqQNVOjPGc9p5NI2kXCuTiC8+10lMIMKmgECJQnsDnjF++Pj0M630xsHf51nU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFOrRbm27MQneE80tBdAAnS4iMa2jjznQaAMPhPYnYdaOqwpXC
 ew0IFVpLuF3mFRxyQ3ZP4uudpyVrqpNU4bDwkN6c2aXsEQYEnJfG5MJiD70ctD88ZsUiQIYmLHt
 uIDGFTumC5tlckJBAsKys0B0cVCK3n8v4vp4cv9LE
X-Gm-Gg: ATEYQzzbJzb9RDsK11CDt3T3OydytxxW/mfX/2oNhRj1kR1AATRogu/flfmFUtRo5iL
 RTWGo/KW5/ETSQyMlLUHAgLbMjxnIgk3qCvLRk3Vw5zWiyFhcHUmasWRun27GJy7/aNRuEgTc4Z
 IDVxiTlMEzKW9U5WoU1q41JiklNVT/AZ7C1pFqjdbGLXLqQ9yrp9256VLHwvVlqLrNPvmx5Rv1u
 e4+gFk+3mgcHlIWQXc+LkD/nqTDYOxevqDQj8QrL+QxSWl/X0H628BsXafxyGrlUjSlkBqHdLck
 kKADUoyLammm4Sd0vcjWx3lmnQ8eJB+wYJbxHg==
X-Received: by 2002:a05:6000:248a:b0:439:b791:f914 with SMTP id
 ffacd0b85a97d-43b6424e64amr23847803f8f.18.1774350021888; Tue, 24 Mar 2026
 04:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260323-aref-workitem-v3-0-f59729b812aa@collabora.com>
 <20260323-aref-workitem-v3-1-f59729b812aa@collabora.com>
In-Reply-To: <20260323-aref-workitem-v3-1-f59729b812aa@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 24 Mar 2026 12:00:10 +0100
X-Gm-Features: AQROBzDRZFY5heMoUsmb4VM8gbH0UlAUMB94X-WGOk-VF8eusmXF_LNO71WO-WY
Message-ID: <CAH5fLghpT9Sgs621=vCT8_i-ZqkZe0=HY9Wowf1h8cnuCCBegg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] rust: workqueue: add support for ARef<T>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Tue, Mar 24, 2026 at 12:27=E2=80=AFAM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Add support for the ARef<T> smart pointer. This allows an instance of
> ARef<T> to handle deferred work directly, which can be convenient or even
> necessary at times, depending on the specifics of the driver or subsystem=
.
>
> The implementation is similar to that of Arc<T>, and a subsequent patch
> will implement support for drm::Device as the first user. This is notably
> important for work items that need access to the drm device, as it was no=
t
> possible to enqueue work on a ARef<drm::Device<T>> previously without
> failing the orphan rule.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
>  rust/kernel/workqueue.rs | 85 ++++++++++++++++++++++++++++++++++++++++++=
++----
>  1 file changed, 79 insertions(+), 6 deletions(-)
>
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index 706e833e9702..6ae7f3fb3496 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -192,9 +192,9 @@
>      sync::Arc,
>      sync::LockClassKey,
>      time::Jiffies,
> -    types::Opaque,
> +    types::{ARef, AlwaysRefCounted, Opaque},

Should be imported from sync::aref instead. This is using the
deprecated path that we are working on removing.

Alice
