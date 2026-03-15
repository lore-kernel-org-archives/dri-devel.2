Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CFAF30283
	for <dri-devel@archiver.kernel.org>; Sun, 15 Mar 2026 21:23:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02FEF10E00F;
	Sun, 15 Mar 2026 21:23:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FZshWHzQ";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B409010E00F
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 21:23:36 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2c0c482dfc8so10628eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 14:23:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773609816; cv=none;
 d=google.com; s=arc-20240605;
 b=cc0UfGqtUL4BCVabt9JPOhcp9xMwsCaSlXANtu2KvbiloLO+KNpDoiyLyPZWb6IzE9
 Z7wACyo+y8FdS4MA6LG48OTsar6MlLab+gE0QkP1pMz1U7D/d6C+tkD00XxteSXeo7C6
 6royzSWj7VDNCXGP2uRxggKKWABN5RBTVtv7RwFsDRaQzwqNE8t5VCokPuokCq2pL42N
 EYR3ByK5kKZn6RX55kAvsNVmhjUZlH6U5cL0TGoDra5BLXZ7fsENQP2douuujaS+Cuw3
 CuJhg/0uYDPVQZcF3qPG+/3YZBV7j6+XeqRat8Uw+lchmJKZcvvkXPIH6tZKeubrTryf
 2kkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IkQe1o5B6paHiUn+z4l+GM/Kq0EzHLVr9WcX/nooLFw=;
 fh=K0hZwRO3EaM/nWpDdnXMydistvZ91JXJiqwa31Le8oQ=;
 b=KSMvtZAG+Os9Nv0d/YLz5bJHjhs+3FGIVbe7XSjj0Ekuy5XAlwJGbGG8jl3fucbTBw
 dYp4rJ/Pj6Ybb8I0ygKpHHwX/KwHYU1E2jFyLqFdMXuC03oFdMVlbrAXhGJoHmF4N+8J
 GkUGDudl5yKBv5YyWm4zXCq1VROeb1RK9xXZB+G5kgyYSE9cvXssJ9e0wVjMQ4dWs/6h
 6eZ+MFuFUmbqOrGLR576OVyZ3g2KNJe4eRkI+6eWKDdiWk35kadCW/cM8l7QONHef+Vd
 kBgq7iACBYz2CUH1Ix3ng4F9TOxzaSUWcLZ4ewn85VWRVMKuLi9cmMElejpCMTzsggjX
 t1qA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773609816; x=1774214616; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IkQe1o5B6paHiUn+z4l+GM/Kq0EzHLVr9WcX/nooLFw=;
 b=FZshWHzQRChw7FYtgzo7HSaujLVfdS7/aOGtK+ESlqLHSNLdYTK2Iu8iAy4g8fxFPQ
 4WPZUczQsVPt72uSI1qFq/CX28Ixqa8Dr3h8yYMW6c38Tmo9YnKca2019cIV1qlRVCSc
 +zXMyJGoMayhHdEXDRrlefNnszyBIwBKRu13sHwtZkT+4VNd908QngYEpEhso/0W6Yui
 sbKi6PS/VgZhx1VDQzQ2W0qCdI0l0qNSJQ8XF2WZnb93APfyebsdTtuafJ4571Hpkws8
 Lc6IQ6bqMwWnJlkd5RzEFjeDFsGcEzxoukVJo7VsVcic5EDK3HzBN0A9yWPOfQDIrSdT
 QAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773609816; x=1774214616;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IkQe1o5B6paHiUn+z4l+GM/Kq0EzHLVr9WcX/nooLFw=;
 b=iDhqJmzkTN9Fs3WbXwxBttvsPjiPlCJUEf31gvI+8hz4xUE+3hY5E67nSwDNXVm3z/
 wZOPGKjB3hac9R4yOT64J8pAUMZeuEfy0cKCyMDcBd/5fqwJy+EdsbQqwy8oK1vLm/rJ
 ZmNwtCdyE/F551f9z23CSgX1Mxa2bhobA2TPxe4AVruSbh7FJSfTck5YaLQr4Tabdipp
 gFUCpCreHW34XDD/3KXzv/QQZO2xZRyRZFbKr+82Z/xWv8x1f6hw9MhotsoupDOSWNem
 imtEVm/sn4F+BsH6oONGGQb1nZ58CQwLupgNaO+YP34lA/H5HWTvIp2u5pS3gq4nHtZM
 2MWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDr+4esbgzJ1slOMCQjeDVko9AWM+optU0a4xtq1vF57UyY/FAuyPDijg5pqiatthDdUJo2AQN0+Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBqyt7yhow6p9ehjQCNFJJ7Wc45BLm6d00Pzf5L9QAcfgT5xzY
 NmPrRu7ebzsXf2TdQeqa0ybhpiO64Y0ZWNEnI2tw9DJpbunBgt5ZakjGfxA4Gejb8UhjMF3G4q3
 xkxn8nr6a/xwBAa3KfgTUL7bdR6zxW3s=
X-Gm-Gg: ATEYQzxoje2adQ7fhBiD+lAJyOe5TnMI+eFOwncG90NUaTka27UQW4hpkdX+DUyi849
 vAYTWvAW/IRkeVNa7R2894FgWV7fyunh/KhCUoDBqT+dSHJhfxevInVGmaC5NSWu5huNRQbiJz9
 VZfXqOjSUuZ4sQ2iLwvR413glj06ev0yV8RQd1zda34U1cTlOqCEYV6Qhu5ZNSA2s5Qk0K1E2zp
 y6kQv9MjNPPgaR2BkI92iz+sS0K0FWyLv0Y8opmx1oBOGnwmdwIPD5NtMsuW8uGCJiHkxVJ/g0G
 yv695yg/kTeOAAIuSU5o6dNl5RbyQK+lP3ejeC+MI+oHNys38KEnRkf9rn1uxINT4nj2Ed/v0db
 hgmny96S1T7yAOj4qMJ/wlj0=
X-Received: by 2002:a05:7300:8ca9:b0:2bd:db75:c28b with SMTP id
 5a478bee46e88-2bea56065damr2711462eec.7.1773609815900; Sun, 15 Mar 2026
 14:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260309-cstr-rename-macro-v2-1-25f7de75944e@kernel.org>
In-Reply-To: <20260309-cstr-rename-macro-v2-1-25f7de75944e@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 15 Mar 2026 22:23:22 +0100
X-Gm-Features: AaiRm53Z5esmB8NqhpEo3Ukkf4yvUe-1ALiBGT0hKmtMX4C3iH5_QYhJU6S78z0
Message-ID: <CANiq72=1koL5z-5WzyPfFX4otxgSL_oKGVt8ju7iShki0LwJhg@mail.gmail.com>
Subject: Re: [PATCH v2] rust: update `kernel::c_str!` documentation
To: Tamir Duberstein <tamird@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Breno Leitao <leitao@debian.org>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, 
 Waiman Long <longman@redhat.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Mon, Mar 9, 2026 at 6:02=E2=80=AFPM Tamir Duberstein <tamird@kernel.org>=
 wrote:
>
> Now that all literals are C-Strings, update the documentation to explain
> that use of this macro should be limited to non-literal strings.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1075
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Tamir Duberstein <tamird@kernel.org>

Applied to `rust-next` -- thanks everyone!

    [ Apply sentence case to comment. Reword title. - Miguel ]

Cheers,
Miguel
