Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B1AC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 12:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C71DE10E4C3;
	Sat, 27 Jun 2026 12:26:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dXtifRtR";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C675F10E4C3
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 12:26:54 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-30bb87c90deso224661eec.3
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 05:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782563214; cv=none;
 d=google.com; s=arc-20260327;
 b=U2ywjQs1v4GeugWrWAHJIfk0IpvtCa2UVur83gFEVkmoVN1JRV+spw76vhyPyqhQQQ
 j4mMtLQTAELBdusUMxQKLHWUqWDr7/1ijrubZlihqf+72JJh25Tsf0wzs3aqXxtwEwJ/
 QofCQKqeXr8e84slSTsjlNbLynB12FEj69kyZo9tUZcFR40B5pcwd/sXtuL+UR0GWU8f
 DZOjVmBPxK9lWXeT2TP+HGdW9gUOJ2+lvGc0bj+VgAjfzQubIflkvh07HjR3D/Bz+cGS
 ULde6UKPZicVXRHEoQKOKTTa+fZLm249djL/vOKqr2Q3wvhHb56w6YSkUrD1tz5l6Eis
 FR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FFA3P0ucfKK/nr2i/TjAG0TaOdJ/VCYkxmATJyLWDko=;
 fh=TNG8Oz1L6OWdl/QAfybRf5gR/sduAhe+Yl7r4LLDxh8=;
 b=M809CX3FAGBkW4Be6LI4S2R2oqm0ou2hWbY/EgXjoU11Lp0fJ6M/xWiAoP0/L67/FF
 34jUs4Igz56K8EXcaUH+fePywmU1/Cij/Z53ewWuhcdXRk9yC5uVlyCTa3wOUVmC9tMs
 PzOVByu4TiQ9G37ZmeACvRrhr0XkW08lQBylH2A8l1GSfXzGiecrYxdt+GJOynoAoloj
 4oZ3ErOm8R0VaFl1bFJno8E94Lo1QP47/VS/rAgvmlJ0SiODQfqnrjMoVlIkKNshhywt
 xGz/LstmbeHjPiLhDq9wbCWYpcxV+N+7/i0qIigAgmN30bVUu9deoeTgrWwGIFmv64PW
 lV7Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782563214; x=1783168014; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FFA3P0ucfKK/nr2i/TjAG0TaOdJ/VCYkxmATJyLWDko=;
 b=dXtifRtRtvnsWY15QDDtrEyAodAD4jqPka3wRVQLln55UbJIwdkAJiLL2DMyZ3KoGH
 pEX0DIKc9zshZCS7zWY9H+C4TVVVPjvilWue8c8L3cvgYEyfKNgJ7006BEScXcRjcMwS
 3AXEV8zulAWpHqu8bGKVjxZs2YEQMZeFIUkdN52RdUB8fLKf/FP3zosAdSKpF9FnSmmj
 WP5fyRKyVDxr87IrMYQZnaIcEuQDETlrinqMAia8Gwu4zlC/8rLHI4TGaMdQHT0YJ/iZ
 XjrOn88FuQEXQYXe2kRO/x/vSX51ZlIqFv1DbFvPtbagMWTjSQUxIU1HxNuuwd6Ojzbe
 OC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782563214; x=1783168014;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FFA3P0ucfKK/nr2i/TjAG0TaOdJ/VCYkxmATJyLWDko=;
 b=mlxRFCtKufVaqmcLfmkV+i/jWbKylSwb3grgqUSehY62mgTvzuQphJAJf50NuD8XSl
 6wvtVvKM60EHtl2v0BbSaXEyaeMDXH0twPyRdVOUwzuSSmjY1ByjyVQgGpQHhrPY+LWQ
 b/j5xAz87XZsD524CqN4SJWU3QBNZPbhtzZgOzHihu13P3Um0d2UZkp/lsJBBUYltLvx
 aziKkYnPyHVx2qShPdWIgskT5eyKJHaTalfGm5Xw1LiQeM4J9M1Rh5uk3JeZWVHwLS4G
 y47XNZt5rsM1iIE1x0MtKStCZLj4PzQKIDb7efbQyRJ7Kh/ViSdTV/4LL+2P3GrlkoKi
 cosw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqrLSBnTmL9FZsK2n/j9J/MMDJzaJaxfJTGOmr2tCtAK6Nxl2Yh/w6TwYUskX+mH6hEnC6bFfQXSP0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwaNOzW5yZdQM/J20PwhpYoBXhs01mRGWNic/tFFLYZhIWKAss5
 V6buAVqHB2byZwTP9RED5WdU2r4QoUzZoumnZYbbSC/Kpd+8DizAGItBka0EQ/tnnXEzIGU/aOS
 mQVyFCxMI2F5wP+R+Sj0J6v/2BP6t4WM=
X-Gm-Gg: AfdE7cl9Jp6Wvgzb9BmaCsPQsRWnGzasH7O7NH/ayDSeoxv5r8qCP1tetVG9jACYNbO
 ZzmPCHMdYtUNH073pwxQf6tqDOl3m2hK/jWAbafHNMX+m/VyjvkFOsrTSeTeq0uVEcI8guxR8uC
 z/o15130ANajgwXWyOxc1fIUwZnY/cPzuxrWKoQCY7Vhe1EtzvZUbvg6QOSy8HGCSwr9S7/fC/W
 G7xopYREeiTFO0pVnP7nhhIuh4YbB/44Nrl1Shw6XbnExPWBENRECyAnkMxkcnjZmj4wEMJBY89
 SYJGyuBz9fnjB8culY/YfsisLzbwQDDPZjBIXpfg1l8vlGTcbb4TK9/IijT+PXXIpZAnr08+Oc5
 6Ewyuj5T70EEOoznobZQkBFA=
X-Received: by 2002:a05:7301:608e:b0:30c:a4bb:71c9 with SMTP id
 5a478bee46e88-30ca4bb7593mr2120179eec.0.1782563213899; Sat, 27 Jun 2026
 05:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260626183630.2585057-1-dakr@kernel.org>
 <20260626183630.2585057-3-dakr@kernel.org>
In-Reply-To: <20260626183630.2585057-3-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 27 Jun 2026 14:26:40 +0200
X-Gm-Features: AVVi8CfTJDNVo1KxD-2qMWkEFrV45PAxG53CiKejEkAqP1d75q9UdnCynZyU0Y4
Message-ID: <CANiq72=0OOgc6NtbpF0Ysdk3ytRWCGGbWg00u0Le2AzQmKGKxg@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] rust: types: introduce ForLt base trait for
 CovariantForLt
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
 tmgross@umich.edu, acourbot@nvidia.com, ecourtney@nvidia.com, 
 m.wilczynski@samsung.com, david.m.ertman@intel.com, ira.weiny@intel.com, 
 leon@kernel.org, daniel.almeida@collabora.com, bhelgaas@google.com, 
 kwilczynski@kernel.org, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, 
 rust-for-linux@vger.kernel.org
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

On Fri, Jun 26, 2026 at 8:36=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Add a new ForLt trait as a base for CovariantForLt:
>
>   - ForLt (non-unsafe): represents a type generic over a lifetime, with
>     no covariance guarantee.
>
>   - CovariantForLt (unsafe): becomes a subtrait of ForLt that
>     additionally proves the type is covariant over its lifetime
>     parameter, providing a safe cast_ref() method.
>
> This split allows non-covariant types (e.g. types behind a Mutex) to
> implement ForLt and participate in DevresLt / registration data patterns
> that use HRTB closures for sound access, without requiring a covariance
> proof that would fail to compile.
>
> Both macros share the UnsafeForLtImpl helper type, distinguished by
> a const generic N: ForLt! emits N =3D 0 (no covariance proof),
> CovariantForLt! emits N =3D 1 (with compile-time covariance proof).
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

If this goes in at the same time as the move (as I assume), then am I
understanding it right that if someone else was using `ForLt`
(trait/macro) things would either break at compile-time (which is OK)
or, in the covariant type case with no `cast_ref()`, it would build,
but someone could in principle have relied on `ForLt` providing the
covariance guarantee in unsafe code?

Acked-by: Miguel Ojeda <ojeda@kernel.org>

We could take the chance to add some missing intra-doc links, but I
can add a good first issue.

Thanks!

Cheers,
Miguel
