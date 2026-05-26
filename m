Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17122CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 18:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FD6F10E1DA;
	Tue, 26 May 2026 18:22:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q9IMEDAW";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C65810E1DA
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 18:22:00 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2f6e6a0a215so943870eec.2
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 11:22:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779819719; cv=none;
 d=google.com; s=arc-20240605;
 b=j0RdKB5xbpbvXcDgZy16Cu7nN3jEWrP4dKGQf4P+T3pdgg1KTJfWqgnY1mWZWZUgfu
 Y6SIsBhXhoEvfWQYMLivCTX5PaceIhVu/9pLfmYcfu5GDeJ5a2mM+/btgoA+Nc5ur82G
 uzlpq0nJutumQvBFI8jOkabtE3bV1SsV5fMT36rpsm59Pg8RrMIly3YpxAGTL9ZyreNx
 +yfz0iAy3cQHiTSuahrtHjutwyoWfk30V+b9QgHTmoMwSdvXqTQmwAKd12tIEKrwbbmw
 nolU8sd62pYR+GT/6k0n8YxG1hD9mS42fRpVvAZ3IxQvU6qyc78vA5g8oHND9JjXRu2P
 zrWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zZlGXRWOTNjKRRnkKz6c2KolMrR/moiIJiI92PNpY/U=;
 fh=VdPvztCFJ/o2qZ36vlhCOxyF3+gya0GnNud/uM0FLMA=;
 b=GTgKLB19q1CzfXnQ+jDtnW2Buj7p8ocOk4a5IYPPZSdOydTR4qTHPmZp+RUr3ObrhF
 v/OYxXeAUIvZioD0zkBJnpa8bf4N1uqUp2t2eUyfl/CEKBbUElj9hMIYMyTGkypR/S3j
 2qV4AqpCYNWv4h62q83AN9k1Mkmb3yC72C6QmRpQMRJFnklHSzgNkxC/0Me/RqzRLc/E
 RPIiQDUAKSPrAVm8F3GDY+1EH4vkBKbiw2UqcqPrPbjHL6RNUZBWUWRZs2S+sTGQEAtx
 xdvRfuqWr+Pqx82XRXD94K1L6Uel+8qRrfFd8Tvgga0RPkg7S/3iDaqHHPOhtcdiya5o
 E8+g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779819719; x=1780424519; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZlGXRWOTNjKRRnkKz6c2KolMrR/moiIJiI92PNpY/U=;
 b=q9IMEDAWLDB1vzjoPw52L4e4AA/n+qDy9HCvmtJD0mO0/INSb9VZf/iWtyXsawCizR
 0g6TbkN+XCB+homWN5Q/vo4DuHC6yNlc9lS9GILsSvFpasD9XP/cJecFtxiOzX7570ZO
 rzSgTkevhD0R2bZzaCKl5rMVmt4L9FudsKquMLhMziuPGw1nQyN13WOejVl7fWsDFbty
 0rwpi3E+uBT+eddY/3tKlC2KZIP5W3Gh9N3H0au5BIWSUbkPgXDtYH4SGBcxXYwrbU0X
 bq+clbSCPkkGPgCVLDxhL4oQHw2zZwnO8UPRbj3kffcpmt6gv+Y0CrvPdDwT89bw9SLl
 lZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779819719; x=1780424519;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zZlGXRWOTNjKRRnkKz6c2KolMrR/moiIJiI92PNpY/U=;
 b=MBK5tnIJyS7E8CLNU898ehBscq3It8YWeVMq3kQO0t/Q1ZPTTO/tTqPGC2NM6N6vK6
 HgMG9gJivI/Xb1m2d7yRo/cLlkDGOAw2vmaz8Z4KzHfG3GsBcUmtoZ74Qfp2pLhUjlc1
 tsw72hsQg9if8T5qBDNrSjdESzCHcWNTHxRRyVbswKlyeYvV+1H5aEpLbXLhU1mBEEhm
 Fa8dIXvwV9s8mn27Xgag2afZgCYUOFm1It7s1gDrJWjFCUMT2XjP3WxjK/in9V602ZzM
 C6+dOEoYol+4WaD9N6NBIjXdCeFJcs2ebAQmj/6cRxdJDzu3px7vmW/TqWQSK0M8O2b6
 AzzA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+uzU/PDWs8jDnZAsJjLOkXxnk781EujzChEDPLupoSvEgLnlw8qarELl8Bw5cvs53fCOXuHNi+s8c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzW8CMSai8G5zS44QrwW/SLNCK+m1u+0z3ORSGte1R1jqJPQiBk
 WHFdRJ2TdUWjSMpwZoNZdArt64z4YJwgpeXBH9woV2iMC2NYkbXEnnY9fbzmEA1h2qj6acWWB8A
 TUvXoU+0B8mwSEqv4r8HXIgUCn/ySwrA=
X-Gm-Gg: Acq92OH2p7lcQ3MKoB0UeQ9U2mjfa8tdvxyRF9uky6QiRncny4CgZOP3sT/stR75OZ5
 sgfpl2sURQ1VXr2tDsW1WJNKAziRzUlWkVW7n8pa3Co/+ElKaGV279GfAhJ8c+6g7LND8lvp4ks
 l3sV8Cu0IqQr5jbHO4RhTxT8IMZfi2b7tptxAj5HF5yKMFCnRnl9M4aUrma9BuP+1K0hNIJ1Bk0
 qtaiq3jtVG6/IdlMNO7qR+qGUfBSbEzlW52jCOzuxe2wo2towx3ueEIf11rBsKnM6/RcNvCAOXt
 23MRJC6B0k//sZ8fzi8uFOOr5BpovqCe6AgWS7tQwTqKrT/Vh798oUvGcTbPlxBhAFoile8ni/U
 w2yoQAm/ml9IxjuJOJoY98PE=
X-Received: by 2002:a05:7301:2b06:b0:304:2af3:5fef with SMTP id
 5a478bee46e88-3044921564fmr4123223eec.8.1779819719412; Tue, 26 May 2026
 11:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260525202921.124698-1-dakr@kernel.org>
 <20260525202921.124698-3-dakr@kernel.org>
In-Reply-To: <20260525202921.124698-3-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 May 2026 20:21:47 +0200
X-Gm-Features: AVHnY4LERaGUubmcoHWuZ6pDVh-Er4DRAsv1wa0D_Oc3ExDNDH2ULqOUOsIQmwA
Message-ID: <CANiq72mNqdOmQ3Va=EF-Fg+-BXW=O=px4z4+YQTS6wzL87=ZHQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/24] rust: alloc: remove `'static` bound on
 `ForeignOwnable`
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com, 
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com, 
 leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com, 
 ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, 
 abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de, 
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
 tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com, 
 pcolberg@redhat.com, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-pci@vger.kernel.org, 
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

On Mon, May 25, 2026 at 10:29=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> From: Gary Guo <gary@garyguo.net>
>
> The `'static` bound is currently necessary because there's no
> restriction on the lifetime of the GAT. Add a `Self: 'a` bound to
> restrict possible lifetimes on `Borrowed` and `BorrowedMut`, and lift
> the `'static` requirement.
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
