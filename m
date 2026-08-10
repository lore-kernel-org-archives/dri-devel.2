Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D806FC5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA27C10E16E;
	Mon, 10 Aug 2026 06:00:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bJQwG0Xp";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D006010E156
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 06:00:46 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2ceeee8c46bso4548585ad.2
 for <dri-devel@lists.freedesktop.org>; Sun, 09 Aug 2026 23:00:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786341646; cv=none;
 d=google.com; s=arc-20260327;
 b=ORb+0HGO1IK5/m58+zfRcDVDXtEYuDJbAK21NLj6IcMmJ3q5bg3LqoHSX1ifT7ai+i
 5keteT6GZOYc56VSPjBnXGzH45mYeL3in4eB9rXQqKLb3MjyprB7uaweVAaEQpQrPdq1
 SaPNqaWseXKygmlIndTcs0tiS4609UhDT0uJ5pXH4nSjyoKz9A+8Cdv5rceEgTwgn/t/
 0Yr7zWZSqoEOuIRMZ41nWOv0uIUwox+lA63xnIKTtHhThWWvcFGOBl5znaNaz/a/ip4o
 Kgqyfube/2UC2JXhIRk7ydNj8utzeWf89921wFDLdtU3346sAM4zv/2eugqt8ak3qOrc
 k9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/zktKh644DXHbJuaAdqY5YkWn6ygQvUdVRJDbRh3y/s=;
 fh=zxYKlEC5EQcVOrlTZbUTQlP4rRScL5wFZTCyaGQtf+g=;
 b=gn/VXOCLwUsvCRv26rSCv3M40th/TkMwHM1PqOmq/lbqIMeGd35fvktm9bxPXYKqHE
 h03xe2x+zCM+6RffbzlAd2pkBb6vT0CcTZmvOF7w8k0JpfNCSY+RY/MJvQMrSm5mDnAs
 xu1EWyMWcVZEaQGweEVd398M/fpzAi7Izpu1oKnLMeH26tOGrXV9xbc+56TWhBbqUuTA
 j5Ym3kltEwwxkooz11iDEH82Zv0gTAPEHIB82BokKlOJfZ0szzvqpngVlItAjQT+zA2x
 Bilbmkr80cxLb3h8gW+UjrAFlvjv3voUSxEw4J3y/rCRGc7y+WT+gahGOaA/7NLg5/ff
 LyNg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786341646; x=1786946446; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/zktKh644DXHbJuaAdqY5YkWn6ygQvUdVRJDbRh3y/s=;
 b=bJQwG0XpG7bycBXteTp+TeE0SBJFCtlHAwrRUervOM0nWiBl0NQk+e3v2CTDA/ip+z
 194G0/E4Xt3ibvAsNT094EsQv5oxMSW8SHopfHXwFIgYXSdV7+3goPbwCzYU1AEVUkJW
 H3/csUuM1FJ1oMBmyqcUxjEdhC2f6fxtDClmJ8dGPwVWRqn+iUyi8vkz55dH6RtMnhLn
 IwZSQgX9pEEOsm4UT1DX0+Xb748WjkO7uO0cvF7ITYujo4LMdGnsnr/UmpXyswDIkZuj
 bySZVMdmfISaQtCE4wBcHNNd3cAgGq6Kuji4ZlzM//koWnkA53gMGI1RH27EghG/ROZg
 YoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786341646; x=1786946446;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/zktKh644DXHbJuaAdqY5YkWn6ygQvUdVRJDbRh3y/s=;
 b=UF1KBdtXXUMAWdSO6+1VcQt8TEelX6RCHI8783ISm4W/bZWZHR/nGsYSXvh7eoSnPr
 ndM9rTzgTrYHN+JA5ar6K1R5i4rlOgXMZRQDwawW7SmqHgccUf1aRH/Zkm0JXgjF4LPb
 Uj4sH8HSNjQlWdLbflUk1ScUUI26Tf6dy7gqwZyToexe/U0RxMjkJ7fpiip0moUYGafn
 gi4OxCHajW/kxESJFQeej6EZQE5QKlxptYSpxi0CvPSXiVKn23pCskMoXxrdnEWx74yn
 HiHMBX10JIJ4RtzSJ4Q4LRq/c6i22qjFMQrHlMN6e+fbXiJCU8HNKELhERTwAlVX3jw1
 fv1A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrzaByzN6je1AHOIX9RTdiQxJygzBgfrWUo/opWuC6ufVtNoIfi1GgeZnT8ArXe6CwFAynsnuyjHpU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxjtNvleWesAbh7fHaKcvTCT31OiCILPeASU1GlShOByhB0u3r0
 T1qmo1WVfhHRg2up4YOS3Wx9fF0SK7D6Iu7D/2x39dhN7KSyKMwjcdExb2q0Rp/OxBTaz7Nd777
 TJ+IyI9dkKgqnF3xzO7LpSzRmcjIQ+f8=
X-Gm-Gg: AR+sD11h2RT/buEYlNBbQrS9WxdXhuTqfV9AzACoKdIN7MzcjTMXcXNRGbdJDdVNKKY
 KiB8fS/yjgvPPyDydedx8GtVjWbMEkIWJ27Uv6cgHYCCCwHAhHqcydhDvbJuSqiBpDpBfwIoRoW
 Iu3QWeijGkzqaxrFyoJWVkAgI2UD/LKqknVqf5s3TRF0495bEfELWGBfBD0HDSog1aJdmZchf+7
 XArnXs8qMzoNZt+92XqPNsyK/Auo/ADifs4bUGIIAsKkQqU/IIZgZvTGCJx+KBHBeN4izbVLiHr
 oo86MANxRsMv8xYlDw6nRcxQiNO+AmMPh6XJiInpvykSx95iVBB23dd2PR3m4ojVg2e6wrKvCoz
 N2Pg5TmY86vdI9uAYYaXAgJ7F+jdxo+5XLwrmSM/xB2JgpVPdfYHVGTcb8cZB
X-Received: by 2002:a17:903:1b43:b0:2c9:d298:6c0a with SMTP id
 d9443c01a7336-2d0ca9ab066mr333546215ad.2.1786341646217; Sun, 09 Aug 2026
 23:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260805145949.938505-2-phasta@kernel.org>
In-Reply-To: <20260805145949.938505-2-phasta@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Aug 2026 08:00:33 +0200
X-Gm-Features: AUfX_mwcm7oQ_Y3CUbVf59t9d9A6DohexL7x3OfKArvNRPUGCPEC33TB28La-48
Message-ID: <CANiq72nZ25wkxVHpz9GTA_m5E_vyBmRKdDSUNMsJAZ=6zk=zhw@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] rust / dma_buf: Add abstractions for dma_fence
To: Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Lyude Paul <lyude@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, 
 Zqiang <qiang.zhang@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Asahi Lina <lina+kernel@asahilina.net>, Burak Emir <bqe@google.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Mirko Adzic <adzicmirko97@gmail.com>, 
 Timur Tabi <ttabi@nvidia.com>, 
 Daniel del Castillo <delcastillodelarosadaniel@gmail.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 rcu@vger.kernel.org
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

On Wed, Aug 5, 2026 at 5:01=E2=80=AFPM Philipp Stanner <phasta@kernel.org> =
wrote:
>
>   rust: types: implement ForeignOwnable for ARef<T>
>   rust: sync: Add abstraction for rcu_barrier()
>   rust: error: add remaining error codes

Applied (these three) to `rust-next` -- thanks everyone!

Please note that your Signed-off-by is required when sending a patch
from someone else:

  https://docs.kernel.org/process/submitting-patches.html#sign-your-work-th=
e-developer-s-certificate-of-origin

I added it here on apply for you -- please let me know if that is not
what you intended!

    [ Formatted comments. Added the submitter's Signed-off-by tag. - Miguel=
 ]

    [ Relaxed `'static` bound and added `#[inline]` as discussed. Added
      the submitter's Signed-off-by tag. - Miguel ]

    [ Formatted documentation. Sorted tags. - Miguel ]

Thanks!

Cheers,
Miguel
