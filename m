Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B425D58CA3
	for <dri-devel@archiver.kernel.org>; Sun, 22 Mar 2026 23:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83B1E10E013;
	Sun, 22 Mar 2026 23:37:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G5NXkv5b";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A854A10E17F
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 23:37:05 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2c0f4a65bfaso97221eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 16:37:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774222625; cv=none;
 d=google.com; s=arc-20240605;
 b=a3gAa8fEFZhJMOO05T73kAJV797lSLsqTvpYv0UhXzMSat+kmRpBI48oLHhF/NOi9B
 tvjnjmyZj1jFhqHz82VBlHXQUC/ni46RRSGha+wpSXgxX1BfirziZ7mrWuHF6ooN1/nb
 Yb1QFflFatyVz6qzm1vv/E/p52Yl0IRpt1XXs89inVl+QxK1AXlvIN7nRmDATx2MY3ec
 h/JRFceq1tkMWpJ0+udb1ofilYmvdddAQR3CY2B/iwBpK8alPB3I6hdtI7Tnx3FYSmZ+
 5XGXwn0KMM9XYeSQuE8p+fwx6zP9xnkIarJUX8q9EbVCHZ1blHGcUHIjsJm45YV0cnKd
 CQKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3TFkIH6VCknZ8F6Tfn8RBWKBNHE4UMbauIDLil82xYA=;
 fh=lRSEA/X4+opDPWTTrr+HW/7F3fNr61sm+uFfN0e8quc=;
 b=T0TJKoO+eVzEwSepuxi5KuSIuzD9LJ0IkRmzBFI6vmiYFJS4Je3LQsXNbPf7c1Jwwk
 hGoz4hYi4wt2KYMqcbtMa6l3IaUrdI0BB4+PbNT5U9MriAbV2jN/DSGvfR1ZPy6O6Ddn
 A3FRMBBO5pPHZaf+c90CBFv/1M+Ss4KsuH9fUTn0vVygNCQBd75E2gFiDhL+zMucc3h+
 0hd8ukmwNRt8ru5p/7ZFFAQQZB90Fza0AfKlLEnN6EgyqbdnQdYg0dAmIoV6abl2TQ8W
 TrqVSXdTOEu7xmQf65gGEQDWc4224jF/q5aiBRkU3JiA20dYkGb9Q8JlD6cWp/seYwrW
 uMEg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774222625; x=1774827425; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3TFkIH6VCknZ8F6Tfn8RBWKBNHE4UMbauIDLil82xYA=;
 b=G5NXkv5bvDEyUgPqfjWVeX42Rl+R8qTFXb/afze1CucceBf93F0xyFLT0tlw0zWW6a
 6jYCsjKKnoM5Ij90OyDk6/0SlNAIHT/eA/HyLEzW06JfIci2f5Med2dlTtkWicfoe6er
 GJ5h0oBWUb3+bwZOyYMIR1z9PLXQe5wY3QqHwZV+US/v2ZdzpsvARevYf243tthNGEgw
 qiBRpejYflWA3Gk/fzD7S7mMuMCGY/6nqGErC1uWwsoGT+2PFYBAYE3PDB9SB0vyt6/W
 7trrImzVbU+nzcQ69fl1SqTBWiWrJhiwpbIspaMMGP8KW1zyp6KCSrZSv+FQ14lmjLDm
 F/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774222625; x=1774827425;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3TFkIH6VCknZ8F6Tfn8RBWKBNHE4UMbauIDLil82xYA=;
 b=E82dypwNP/MKRPe3fSLB8O2GqjpolB8nmJIDWqkeHkaGDzrQNkAiPBCL8INA55fv1w
 ysiB5Y7ACG4PJfbEeXBnN1rzRAnKx0V11tfCoDGYI/md0fvMgn1lTID+RuRl15qSXInV
 NEBTuk3uWaKiyiiFOFrxciYLfk812pFaAuhqOCQTtIJQa0vk3+HArkrR4XBCil5Em0Q9
 E4yBO8X4JzYIjbkUs0bXM6Wryw/DuwCcEyaNZaAZc3qL+uO6X5KzlW1efC0bLpbLuvZD
 Sy8E1LSZ4al/tdVZAiaFHId3jslVHc//9YYCyeUcBKyLcwZGLwQ519W4OhjN2Z6+W7Il
 nU3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWULNJCuQaKrQz5xICk5pTHaX44sFY8j5XZJN4zyD2ogv5CBB6slBX7CbaI2o4OPYzHdH224HuR7Qc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz++zbCZwLmNlLXStuTotCXlAp5dD5htfMTmv0xy+826gRlbqcq
 qVl0Zp1hyG41mHsly2r85v/K29Tm9Adwu8LbhS6yNoVEFAuJas9Vk7OLBxy8kSSIyTX0Q/rxprR
 KKBr2h0IIPzTAXQ23RpjfgErHYeYkobw=
X-Gm-Gg: ATEYQzwLTG36afH3vL2+GD54DPapp4e4oGTMvg4VrRjaXcU6k9wHa0A24qdJfiTSwhO
 HVVYRoEgmKXAlNSWGvldO+ASWMhipjyZS1YFfgQowAhTYDTocmpw06/cI8pg2zmC0dPP7XlBdLW
 z0F9EfcMN2H2VTW57Ha6IfZKXgFuLTSHVQeLXcKDX+FxLbdDQzW4/a6VxYPBcuQM+dPqEoG1VoU
 EguXN/CopaSAUKlNJadARvAaMycyZDkuq5B56Y2Dr6FivXfn3dAAJNKzg+0vaky7c/M/wYU2XES
 5Ib/QN8caMSwRRpILF24P0pvuKl7+zJBQKoeeSlZk4k+q+tvWCCk+Za5zXAOfF7VJH2TqmS5hsK
 RAjm4GopvpV8MG9PkyzgaQtY=
X-Received: by 2002:a05:7300:d705:b0:2be:681:91b2 with SMTP id
 5a478bee46e88-2c109784e48mr2354158eec.6.1774222624794; Sun, 22 Mar 2026
 16:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260319121653.2975748-1-gary@kernel.org>
 <20260319121653.2975748-5-gary@kernel.org>
In-Reply-To: <20260319121653.2975748-5-gary@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 23 Mar 2026 00:36:52 +0100
X-Gm-Features: AQROBzARASkmL1z31d-SPolLvyqalzs_slFQDBddlVkhvWh2YgJFEiUU-Y1iEYQ
Message-ID: <CANiq72kZH-AX=QQz2V+qCfVzMsUEAPan=o1E=OZOAnivj3L3HQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] rust: make `build_assert` module the home of
 related macros
To: Gary Guo <gary@garyguo.net>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, Boqun Feng <boqun.feng@gmail.com>,
 Tamir Duberstein <tamird@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 Yury Norov <yury.norov@gmail.com>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Yury Norov <ynorov@nvidia.com>, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, netdev@vger.kernel.org
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

On Thu, Mar 19, 2026 at 1:17=E2=80=AFPM Gary Guo <gary@kernel.org> wrote:
>
>  rust/kernel/net/phy/reg.rs           |  8 +++++---

Tomonori: are you OK with these changes?

>  rust/kernel/num/bounded.rs           |  2 +-

Alexandre: are you OK with these changes?

>  rust/kernel/sync/atomic/internal.rs  |  9 ++++++---
>  rust/kernel/sync/atomic/predefine.rs |  2 +-
>  rust/kernel/sync/locked_by.rs        |  2 +-
>  rust/kernel/sync/refcount.rs         |  8 +++++---

Boqun: are you OK with these changes?

>  rust/kernel/xarray.rs                | 10 ++++++++--

Tamir, Andreas: are you OK with these changes?

> -    transmute::{AsBytes, FromBytes},
> +    transmute::{AsBytes, FromBytes}, //

Nit: We should take the chance to expand this.

Thanks all!

Cheers,
Miguel
