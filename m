Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324B5CD98C5
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 09:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A06410E2E7;
	Sat, 13 Jun 2026 09:49:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qVhQbnWj";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 447DA10E2E7
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 09:49:25 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-304dc707c7eso156826eec.1
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 02:49:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781344164; cv=none;
 d=google.com; s=arc-20240605;
 b=X55cDSeGAClibzP01ImatLmuZASzpnkgXdyYjkywsct9NOCYisQYNeUYNRngOaVLni
 Vggpw3kF3r1gO+K/I+9vqWowXnGiynSlmBVaTQVGe7obCFShF34+Y2x1LnBPzbx5Zs6o
 i8KaWoqGM7KusGGG4a/B+0+LMO1DfYpfYohK9m83B3WIOMfmJ9h1/G7Rfq1/US56foFO
 X/Z015Qrxk+I6JOwc9lL8IMpy7dTUO+E55xZmHunENDMPzXxrf1fI8BhByE5DWb1Gx5C
 YIfBnBi2D6WMd26ctYnN5tZo34uQjLC3lQPfSd9DK7O+uDZ11rmK69Sf8GkCw7jUrPwU
 BC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OkM4+eHaDUAb02aEnfu5B6pMfFHeevNTKhJz3xUQyG8=;
 fh=SWdhcGCkguOAWDSZhzZ3+9D5pbXwAzLVwxK+5gwxndA=;
 b=lcsAzJcOiNJis335XN78kd3PfmF6dk92YmGZWv+AixWe2AAT/m0dQrNhNApCQrL0OK
 3QgpvYyeLe+ss8Bnxp+VeSZIHEF2fSxI3DsNEQeaUshCqb+vEMUpRPsf0lE8dJezLneH
 ZfHxz3niSy9hWn4z6kwBpQYvwaVza1vZyglCxJalHmMhUVT9Bk+1DxW2n7AApPRCaDNJ
 OLK3wpRdOeENQ8P1fRkXgjrYOLj5Iab/B7wdXhe+9EpDuDfpsKE2d8zklFzTMDtDBAaC
 QuWV8M9Kaq8RNGlchhJSVsrDJ/4C9a6le2w49DeaTMNcjmy54eomlGmAAbQ9SGO4ttpy
 CcdA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781344164; x=1781948964; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OkM4+eHaDUAb02aEnfu5B6pMfFHeevNTKhJz3xUQyG8=;
 b=qVhQbnWjgQAZBSEKXC37NEgSVnt9YB19u/wlMOxqszxxk8k4BR0IvCvcgnS9YoPaJS
 T6SlT5Ot4CO3vIJNIde556gNNTyAkT7STzu+r11nY3Co8yD5lgKEtq85cuT9F3rzK2py
 uBFuiO5e/bW3ggQayb6yD2nfjqMLHc+WlU/ckkE00VGSjgMJasklvO7C67kK6cvrRytd
 cnJihFJyCYIStCzZ3Ed18hA27aZt3Kvh2DgQPLbSyiniMgM12vpHrtKZMYzhnwju2Wg4
 x6vMHRB84v0pB3S83N56il+Ou4TcJg7UsblWIsaLmxIrkKnftXvdSWuIdu8JdFoEncqb
 G0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781344164; x=1781948964;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OkM4+eHaDUAb02aEnfu5B6pMfFHeevNTKhJz3xUQyG8=;
 b=WRxvqWOh7TPu4/Y674MTVk3jr4bKQU2neXvEgbOV772P8RNRiWO943hBNK0/RzuMfb
 XOZIAnbw0GlQo2Mv1Bv4DNlGxEjhnGON0ZaOwdfGdofvGiouk4yPb1jLCrYA3xHhwZgT
 uV0lUhfTxOgj0zPIOjp1vsVPJhVFEJp06Hr/ko6j6NmcUXOCVQj7u83i/gcJByY1P9U0
 ENv8xVu+cczVoROvPnvkrUEJq4dXLq68qt0zMv7stv7DYaVxdAWTns/e/6xVs8MfXhgn
 dnVP1RiAcQmaFb1NYwh7YvCHS+HdkQSlgnhhavOJ1OEoLht5EFJGVX9FJOwxXRKpNMbM
 Glgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ96vvGt+nJI4UUYyuBFDBRYAp9o3S3yiWvRBSCZmfvtsyx7IPGYHE4JP8okQejsDp9nP63vVf6Z2ww=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyBsrZLq10vGR8ONGtoqeYVHlP/VeqPNYmDblcdvKgovCkFbKwD
 Z3qKk1ep/tsJ5LS0/L4BOflBwStV0AEJGxA59caM3QePtCQOApAGah7tSq9peSAX90WcrPkka59
 QVZ5gqna/xKGFIxdUMBfVxFBEG3VaBpQ=
X-Gm-Gg: Acq92OG9xW3URYfKVBBaMf1Uvv/rMIYZYPpL3mo1qIjMxrS8PDfJ1yIeXZIckGyO8FH
 liq0/QO97vYyggFqQFOEpA7Z0FWVYENsijkyt66VgvSxICIKzSttpxGLobIEvMUpztS7dPmxUN6
 S6lDAZvanJggofmpA0CDfzSM4hac0m8Ne+dKp0qOLEuNxhauooeNeD4xZj3pedCayy4yE+g0wFo
 hE38MK3mbzFI1QJsyO+a0V6txishwWifQSxFWYCWybqB2GYP+3ai78mX90syB1casU4BRdoF5Yl
 ErmgkVSF1jxiZDTwMLWR4KU5BNKjH0LoE+VN4Ot3ES0gGg6PEu+vdEtbMn6PWDA93qTPfWQKtZh
 fWAlgrlFMtaE+xpYpMNbocjk=
X-Received: by 2002:a05:7300:730f:b0:307:2e1c:17ed with SMTP id
 5a478bee46e88-308200d09dcmr1479282eec.7.1781344164338; Sat, 13 Jun 2026
 02:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <DJ4Q5J5OILOX.1KCPFIVUFN2VV@garyguo.net>
 <20260610072947.338278-1-ojeda@kernel.org>
 <DJ5A6AM2FDGQ.19T1Y9N1T6JST@garyguo.net>
 <CANiq72khOCLC5kG5vWhDeXpHv6n7Yo9Nv=PewNS0D73AxUDB4Q@mail.gmail.com>
 <DJ65HZ2867HB.2ZK56NEAURVJO@garyguo.net>
In-Reply-To: <DJ65HZ2867HB.2ZK56NEAURVJO@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 13 Jun 2026 11:49:11 +0200
X-Gm-Features: AVVi8CdobUhfSP0GVHy-aYqTcvmFqhk07mdunfn978mPaEmklHiQcpFapjBPE1g
Message-ID: <CANiq72mhdy3i+X-9ZDiwe-mAYu9DX2B29dQQi=2iAYMS8JMzXg@mail.gmail.com>
Subject: Re: [PATCH v4] rust: make `build_assert` module the home of related
 macros
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, a.hindborg@kernel.org, acourbot@nvidia.com,
 airlied@gmail.com, aliceryhl@google.com, bjorn3_gh@protonmail.com, 
 boqun@kernel.org, dakr@kernel.org, daniel.almeida@collabora.com, 
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev, 
 fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org, longman@redhat.com, 
 lossin@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
 netdev@vger.kernel.org, nova-gpu@lists.linux.dev, peterz@infradead.org, 
 rust-for-linux@vger.kernel.org, simona@ffwll.ch, tamird@kernel.org, 
 tmgross@umich.edu, will@kernel.org, yury.norov@gmail.com
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

On Thu, Jun 11, 2026 at 1:50=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> > Good first issue?
>
> Agreed.

For future reference:

  https://github.com/Rust-for-Linux/linux/issues/1242

Cheers,
Miguel
