Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B9510A88FC
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:18:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3283710E066;
	Thu, 26 Mar 2026 18:18:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Og5bnVNN";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 064ED10E066
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 18:18:04 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-12a77005d69so122142c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:18:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774549083; cv=none;
 d=google.com; s=arc-20240605;
 b=jg0OWWZe7XsqquJbI3hsoyc+jWJm26e6Jz8Er2vcZsZ/8oAceUe8tH75RuiJqkP65t
 zIstaoDjH6iACgQwRyg2oibyNUoqnTaExKn0uoEuCJg6QdwPB9I/ynt1ZFHnn9mOJM4w
 UBEEFq6i1TCBn8/QTwrazuu/loXYcduYhKBOQkwp6JKU5rPbuN+jWvmwbBo3omPI6sNn
 mp0xOO+bu3fS4SMJVW5wGt21fMNz7dXId9fFHL9GaPgAWWT2fHNRfFBMscGiPutH718j
 nDVwDsMTuWdsebcyibOpGikjyoELmvwWXBO57h9V5KVhPgrXxBHEn4dLh11ZYx8imviS
 AGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=B7sccmkGDehtyJvcq1YZcs4by1igPiabHUGseQHtgqo=;
 fh=gUVrndkWIO/Sd68nPoH69L2EarvFX1+k3mNXt04rrUE=;
 b=MUddFQbCubDEJk3OZZ/V5g6kle1T+zwH2SYHXLwDK3/bYV9IuUYJEXYk8PdvbiAqYm
 XcUNcTWh5maMuAgw7fCW/t1vJEqdhq6tuYE+xH8LhlziGi3swHzASM7TKqUHfganFrhk
 g9V1BX41WwllPXTiUUa6MOXS/fdvtZkF3svBrPwNtXJb0jSV7nt0N5oX1rM7duHzqVay
 2bwE561x8lpneWyKbowNJNj6FiFksRYxK7/ydaRSUJLY08fxxO792JUFND21h63xkOMY
 n2/MRlprz+Lm0qxZKX1xHNHsBCtU/gjP0sKGHp6uobHVvjlDdqOJOUznDZnLvRacr14f
 tK3w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774549083; x=1775153883; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B7sccmkGDehtyJvcq1YZcs4by1igPiabHUGseQHtgqo=;
 b=Og5bnVNNTDjTcHKQhWp2dTcfLlo4FrFCjBfUQeb/tCwmnQlu/d5bfNZuzeHMqirluT
 4k776ip9+VBVmNowkaeXUxdh46X9GLeSHscsb85ngWMz2HzHlVhoLto1pJ426yHfxQXa
 HP8KTXNdx6KLNmcyjAMEWVKS7q1kQ84QYzUSVdmYwm4uFEUY7XqHfb0iMr+Q+OUA/0Rg
 a+bA4bZkXS7dSfcfsIdcUcFdXDA//pYZSW1a+EfEBpf5WdCU+QnM5UnMke1bOYTLSFhb
 Mr2nW6Dq6/jBJvk8imLtyZlJ36ctp/PfHXaq+RzVX9+z0X1ajnKwe/FWcOt2fxEp5VWI
 ASuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774549083; x=1775153883;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B7sccmkGDehtyJvcq1YZcs4by1igPiabHUGseQHtgqo=;
 b=L48ObZjVuB6qsdvYqdM2hZFpvAwICHZEJOPzgnvxPoIcB/MY8VvpAz4TCk3gvW0szJ
 cN8m0mkjFzohQ23jwu1+ryiPa523VnRyO7Gc7hkFlk2kFlwPZgg1IUkMInbl7o/5AKjI
 sjqSFQZ7T1JSQqZbf1QPAqvVTbJ+v9WaDevqubaIR/sOnOk1HM4I07ts2eH34YsG2L7/
 eKsTqx407K0rv0wzR9cIgM9dMkIrQGdXuO253MD56FKpyIZYWNkry0wHwA7WRLnShCZW
 F8yxd6QsVZYw599gXlJElOGni0hC6pHd239wS7ABT3vp26S8qVrZg0zAWgUwv6dLG+Si
 Nt6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB53hNBxIgXWCQmxeFI3I/48lBul+ikYOwTTDILWZEiUC0qjhHcwc6eSUGcmSadWd340xk7vaJh34=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzsV/mZg/B0eL8wKHn46+9hzS2/lZD9zULGdP8GRDCrrBo3vUzN
 fk9M2AYdp0GjZBtiW9l9G26rx1gsUypaQf0urdANsFxgATbJjpZaxyWEYScUzUI7cPNuJMbb8rN
 d30+g+mOmARuKSvAs26aTmdsvh786ZTc=
X-Gm-Gg: ATEYQzyEw7d1H9DH2EJ2eAk3Rskw+8LdFnjqy9rfreXXFg5MshHsxxbawLTKZDQ5gnS
 Wz/EOJ3vXBfvRk/iCNhjXmGou8lJcgk9+NywiFzRaGiWjDCP1W+hsKdA7EQsF52ykAbt1OjCdB5
 LPH9ZtwVaTpczhVjCQdn22GthKX40QQF/iqT9DxmaR6DsRtqDTcFAKZr+nlbMmUk4jpLEMjPp+W
 Ju9afdp3J4u4BjDjeD00u+YEC2KjCYthpsRJjcgv+EWcNbsuDG6JCzArsycmB0Jrx5jYo71wKkp
 0OA64Iu+GVu+2Lkydt1ksSBbWNQnyuwwTiGJEcalinXij74eRL/lNtkVllIc9L6ZtGgb66tUblP
 sPWTtqT8qcgQQoPUgBfy3lKc=
X-Received: by 2002:a05:7301:7214:b0:2be:1f56:ed0d with SMTP id
 5a478bee46e88-2c15d3e42cbmr2323302eec.6.1774549083220; Thu, 26 Mar 2026
 11:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260325003921.3420-1-dakr@kernel.org>
In-Reply-To: <20260325003921.3420-1-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 26 Mar 2026 19:17:51 +0100
X-Gm-Features: AQROBzDHC8l4cxhgXpM9E7qHhcmsh6Eh0VloN_3mY91VrE0Eq-6JGd81wVQv04g
Message-ID: <CANiq72kqKGA7sqB6WnJxMiTLcRx5t=0xDJhzyq0LmSQVT+9WLw@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: uaccess: generalize write_dma() to accept any
 Coherent<T>
To: Danilo Krummrich <dakr@kernel.org>
Cc: acourbot@nvidia.com, aliceryhl@google.com, abdiel.janulgue@gmail.com, 
 daniel.almeida@collabora.com, robin.murphy@arm.com, a.hindborg@kernel.org, 
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, tmgross@umich.edu, 
 ttabi@nvidia.com, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org
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

On Wed, Mar 25, 2026 at 1:39=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Generalize write_dma() from &Coherent<[u8]> to &Coherent<T> where
> T: KnownSize + AsBytes + ?Sized. The function body only uses as_ptr()
> and size(), which work for any such T, so there is no reason to
> restrict it to byte slices.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
