Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C9BC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 16:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B17B110E1F5;
	Wed, 12 Aug 2026 16:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MLTs9HL0";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1D9F10E1F5
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 16:33:43 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2d03fcd26a6so1806605ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 09:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786552423; cv=none;
 d=google.com; s=arc-20260327;
 b=UtCSrkdVbUHFH+EWfjEvNCej7LhmbTjx3FLgkn3HIYtpiw5qw6Dqc9jJSvAtqA6m47
 0gnIoVSkl66iqg8hjI529Ad3Omn+lb+bcj0nU4QDb6Mne5FCDzAIWuF4PANkHFkaeQr3
 6Sc1YrqO4Hm5gs9DEwEfzjQaVYeL7jpuRUC1KVJ3ylR76cr8mREyckh3ASEPyq24yi8j
 jvcmrshdQt25V0fsXx04zXLzN5mEU2asMxV2GnDFh2fKgz9KcUVvgSQdgOG9ue8WIGuy
 Ucsfnqq5olmRpiQoNNClIWsmfP+zolMq+WI8FibZ1eDerliRHD2gF36eLclbE8fPt6v5
 myyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=D4SZ6u0V1SghQBdqtC98mKtc1SLMxMH5ah0RWt1B7vw=;
 fh=uFrVC4s2CHGkV80YSEJ1DeQnjtzKxDKbeihFV4PrVcY=;
 b=Bw9v/zkrafeFBdhuLCwJjcTADwbRXE3eAgzxHASVCmWRzKPz2ccHTiVQUPaJqIEaNU
 gkJzOhh2XMcaZfa/VirIwMsQIVujoPRz9BKyayOm3geYN+6xkpMiYZVZhbt+o6BsLJIt
 oDe5kLfdjrKd4wpbdSJm90Y14Cnhiee6nOnyuGYRBE6Wz6zcYBL0zyw/9XYaLvcKvb27
 CpdQUr2CrXVzwDuFNr7ExQrAXEQYeqUUocg1HwZgTr/Ej64sm7ZZ0UhlpGBPHs0j5xLz
 jGUo1Dhn1ysSfefGzbtZ0rbWFdKaLe+lEpVVsbTGvfge9iNdXTLhnPfbk90QtIaz0Pw5
 cMkg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786552423; x=1787157223; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D4SZ6u0V1SghQBdqtC98mKtc1SLMxMH5ah0RWt1B7vw=;
 b=MLTs9HL03Cm6MI/Lt2HMj37vKghqBlWf49/SpX8CuxFW7dbbD0k+dFfv0VjMZXwR68
 0WpT98GmFWyaVgqIIOQV3t72SyWUj0MWJD6K8czJ8/VzIxmNLTbpe7tSCgsanY07DlNM
 sw1pNteZMHpmr3anfuUMMgA6CXacqyvncPODqTiD9hbgU3qFUbcGkrsGuOO2DlCepX4q
 lCKgOuw61XMGw1A4F2KvlG8B8UTB1oOqyLINbaLmFcNz6p3+VKGibPQ1eej9C0gSIawF
 4pye6K6Yzx50b//gU1n5fqNSbJR4JzA9l6/qVvaQ3Ot0q3M9P/PgtgWlRxa3spYoPiFe
 V3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786552423; x=1787157223;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D4SZ6u0V1SghQBdqtC98mKtc1SLMxMH5ah0RWt1B7vw=;
 b=oXaYoq+UDmUMgxBap8grGrP6XIjG5Gwvu+PZLyarzWASw1zHykByorPpgsILXZkEt+
 U6t1dQ7PqddV0yweCDJamoZaYzcNjtpO4Q2zdKahkXvEI/qNHeCe5Z/WRm+C6LJerjHz
 O6r1rzQJlXQ3QW1ydO47Of/xCoqvqH04X6qJ5vwdlk3zlNCJjdhnt6UjvgDnlapi6LrZ
 33Yn5V4mYDvS/KwOnIndX4hDNRNac7H1jS+SXQQr0dpO0i8MJWGPSZvIxcXcQy08koJc
 L31Zb9leW4p45ijMmq07z2bmspCZUYuEE7pb2aZ1NrqL1n23l7Tgj0b41oPxaxQ9YYMA
 o9oA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpVe2Go+douwnLJllgh60/0M/nYkubzJlXVjIKG4MSft8PC7roCyLaiu2j8GQ7A4SHnIocLKKXJAcU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+aAlT/lrYIdkWyogcFJKZNoqdsf+iomnn/ms3WnGq17it+t1w
 4fxgWXyS4fm9GZq59HumDzJnHE6109M4OnOSE5Sh4hOkqb85yuDWUDy8GRADtsAMQrtfutzWHP5
 SqCI922O/msfBa9hjRKCDZfCFhdAz2Z4=
X-Gm-Gg: AR+sD11HltXnDO6Blj/4U46YFFp0JtFzQYmFwxCxgOWUdKJ9zNJuS3P4JE74V9XxVR/
 YTtyVR0DKEmjhHW97npJy3oOW02DcnHc+zzWEnlRDkPVkkkjszfPICTUuXbFTaEsUuRVznRZjgv
 umUroh/DFhRn/rSov4RjMO92IsYgEuC3DX45lSgIgALOlDlVtlMLyC0E6vRSdYHE5b1M4NPgp2J
 VLnmmAKXEYdwfRUxkdYRtqxRoCtKaU2IJxP0cBnOOeBSCkHElBvWnD75Dtd+/0D0ak2mV1kSi1A
 W/1Z2PAKctgAEtQFEqQGiyZ5bzWo51fRjFo1FBIETrTL5E6aU+w8/1G0nwuO+Smd0eQA6qTCcPz
 G3ja2PBgdXU6Ji5jlYAX7snBbjl41LINcC1TJsUGt6E4T5zMVQzmG++hFqQrJ
X-Received: by 2002:a17:902:d552:b0:2cf:9e90:8be with SMTP id
 d9443c01a7336-2d3456e7622mr58880125ad.4.1786552423044; Wed, 12 Aug 2026
 09:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
In-Reply-To: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Aug 2026 18:33:27 +0200
X-Gm-Features: AUfX_mzHM3XF1m8TGRbbbrVs79_o_CCgi7jI9gpogE6umN7ICq8ixcdhm-skrqA
Message-ID: <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc
 abstractions
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>,
 Jens Axboe <axboe@kernel.dk>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Igor Korotin <igor.korotin@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
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

On Tue, Aug 11, 2026 at 8:41=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wro=
te:
>
> The series moves `THIS_MODULE` into the `ModuleMetadata` as a const, thre=
ads it
> through `#[vtable]` to set `fops.owner` in DRM/miscdevice, and updates co=
nfigfs
> and rnull to use `this_module::<LocalModule>()`.

Applied to `rust-next` -- thanks everyone!

    [ Fixed `clippy::undocumented_unsafe_blocks` lint by wrapping with
      a block. Added interim `#[allow(dead_code)]`. - Miguel ]

    [ Fixed `rusttest` by adding a dummy `LocalModule`. Removed interim
      `#[allow(dead_code)]`. - Miguel ]

    [ Rebased to avoid the imports cleanup patch. - Miguel ]

    [ Removed Acked-by and Cc. - Miguel ]

By the way, I removed the Acked-by in that last patch since I think it
came from an older version as a series-tag that didn't have the patch.
Please let me know if I should re-add it.

And since I was editing that commit for that reason, I took the chance
to remove the Cc because Petr already gave the Acked-by which you
collected, so normally you don't need to keep both in that case.

I hope that clarifies! :)

Cheers,
Miguel
