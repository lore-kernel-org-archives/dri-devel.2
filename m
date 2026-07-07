Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3E3C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F4E10ECE4;
	Tue,  7 Jul 2026 13:05:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="CvH1pVjW";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2696B10ECE4
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:05:00 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-493c19bad03so39168715e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 06:05:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783429498; cv=none;
 d=google.com; s=arc-20260327;
 b=dQ2cM8vHoaqrGCChhc5GAs2gkic8GCz2yJ4XeN7/f/nbkJOWJntkBhkhyKI/n+qAWM
 K6UZuaf3LrnxS5EUsJCRDA2/mNWRKf2JVuy2SOnYoVadq5CsLhRkFtCC3rqAn2XD1Rsk
 JaL8uK35JLw83FsFSwPq7ZtwxPg+TKN2cjCntAf0e1AGtp1Jrq/qO9ycr42GvhW4KOHk
 sNUscFf40wt8pdyoSIDcVp99Rm/Nwu85lPKkcJZIgviQgybK1UfAa/R+pd6lTkPrr5il
 a+jjXGXLXhgYmQ2K0ryOLzE/yOh/GxO54VsJNHGGuK2k77BMZpY+d/uRN5ikgyrm15Q5
 3wTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
 fh=UgzNeEGuhMxVQor//12HSCjdEoC7TZoBua1CBq9OaRc=;
 b=r+e+QAh2jTrEwZS4HkIgRGps3zBUYqKq1G8oQv30bhnI+A5kzNXtiWlssEGiUjk3LX
 2ypTUZ005KdalN/V9kwahKb7kfeyFH7l6azTlUv/mMet5AA64PrKUIWUPrv7kI3A1QP/
 TdVsDpw3OWtwGhsdz4gBukCRd8tjqsQgDKOZZLHDomzwVsBMfy+4uJPcHm6LbZMhzGYr
 RdqYm6Ucxlwb5b+sAdsldETeE2KOVbvq0xg/xPESaKT7JDipRkZAvfhS3yjGfTWmzAq0
 4p+8xNsPRCR3Uc0O1jFv4y4AaNWnOvNep3lxatFTNp+e5tPdf24xRbI3O6s4tNTFtzVq
 DgmA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783429498; x=1784034298;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
 b=CvH1pVjWhkCp2+OB8wjhtru1By9tcsQvaPNsao5eYd7hXxCUiS0fQz06tBXVWgQ5Qr
 j45IrhMJtbx4W6B0G2K+bsCuQe7CtYfvqzbxnkRMhuRj+JNa1hrF7LNYxEfN7zqIsFFb
 TjKiNDapanuLovAx/VOvwfzvvPiacQHa3KD3FYRPuYQjnb8Zk0pLLZKgJXHEzX547jIa
 lHMtGtklRK3MQABAokZzZtC+DM1Pz0Sgq8zxc8CwD1p0cpUTxb5VVkO5kcEe6SF6uEI/
 P4dMXrtS6P4uY/0rtuO2O6OxLGb3gLrbfj2p4bvDm8HBwJLwzrUt7e42skLdtXydOCgF
 0OJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783429498; x=1784034298;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
 b=rW+dMWqb868zzUVaCybOBpSwaWU27AvKCRV1HUSFo5TywoW78X+6l5zn5pYsgTjcag
 ljxDupZ8WrRKOoeeD8ZBMFnBRMGuLr50EPIJXdLt1LWiB/X8azWga5EbFqzhRzYo5oyk
 lMiNLtrvrcWAJxc5T94JMHaFA7h33WaRCvkpvlENk9EENKM1n9elfQ6OWey5HglovPBG
 Nk+Xypek8701e3vJehBQ/kB0KgRXYFc0lp0llvQv0fjH2bWc4tvrF8sWcnkvXzTaAIU/
 IrrESTWrJPSLrQSYaw60HZpo6/PJNpTG56TIynX/DkCP8rwgxUCA4XppvUBcakkIKSGl
 j7+A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpyMXX43QZ9lA2P9/8A73wcvYSfxAzVY0LjGD8g8s8Jogin4vn12JQQ3KtCmW/NWCXuGyXI/YmcNmI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxUiTaFqAeDbzjrvWGAKqlhnIpr2CjM4JBXQXIgoAPc81qX27su
 X1xvT1azCepG9FygOcEuIXEt7gXcMg9rzigj8Mgj7cy665oMd/S5z8kCQB+8WONHyrXwNmtHB3A
 y6cND/lcuhcsWr/2xtlAdvA7ol7UCLgB5cG0IIMTe
X-Gm-Gg: AfdE7cncTA08ZCrJq0WGTB9NEWhMQV1zpUgxSFfxYmWUNyCE2jI/bCFdnGISSaeyQNR
 mK1IIwaNgwBrWKl236QAmtMZiPiBAgF9aEj0kPtdZs2PxzhArfK0JxWve8OIWMTSaK39/WUTEI4
 hqLjH08aThf5AU3y2Ok1kY90XA049Gdk1m13aqYfZWF0M5ZIEO40Sekkuav8tJJw71RTFSh9JKO
 p5muSwy7/O6qXd8K01AKKCpuOcnlw1WhNNLhFpy3YU30PDeRXIGovUFq3ZeN4B8ORvsw7ooU5VI
 sTAkel01LjYVqPctF3Gg7YLOcLU=
X-Received: by 2002:a05:600c:8b70:b0:493:b6e4:fb2b with SMTP id
 5b1f17b1804b1-493df06e943mr52096855e9.25.1783429497735; Tue, 07 Jul 2026
 06:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
 <20260626-unique-ref-v19-3-2607ca88dfdf@kernel.org>
In-Reply-To: <20260626-unique-ref-v19-3-2607ca88dfdf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 7 Jul 2026 15:04:45 +0200
X-Gm-Features: AVVi8Cd8GrEsrkEwxzhRkanTcpbMUA7MU6OpTudOnt7DIfIGqhosSlF_BI7LYTM
Message-ID: <CAH5fLggMeHUgXj7JGYSJejUrR2PdWymOOb+3E1VmHokzcox4hg@mail.gmail.com>
Subject: Re: [PATCH v19 3/8] rust: implement `ForeignOwnable` for `Owned`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>,
 Serge Hallyn <sergeh@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pwm@vger.kernel.org
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

On Fri, Jun 26, 2026 at 1:55=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` =
in
> places such as the `XArray`.
>
> Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` =
to
> implement `ForeignOwnable`.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
