Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAC5CD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 22:26:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A57010E40F;
	Thu,  4 Jun 2026 22:26:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KkUI+f2p";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A65E210E40F
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 22:26:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DEBD96001A
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 22:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886CC1F00898
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 22:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780611976;
 bh=c2MR+MGlTw8lX5aPBv/HTdAPOCuQJY94o4P3+ddv0BA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=KkUI+f2paCqlVNrTPJV/DKDMQBtOpHja5K9t+7DAuZT/kC6VnAOTmCPgbCyezI4dO
 0Xw1w3WVDmHpXGQmA2P1WM1YqpK6zb84OspLy8+LD/+0ibdkAwtkl8Y8X8Fxvdkvon
 NgwHqMI9sWb/jIRZF71ComrhpK/trtPmnXw8O9aoc7Jk3PA8Vpcbk2+N5s+/j3SJ0u
 Ur4dVm/Aw0anZxOmWy3mAdlREiZXTpTLvvxkmjIo4MD75X0Ri7izpH8Gjxm3VkL9rn
 a4IyELeJW33NRqqvY1SnyxL/lThSZPBhYSNQQKdfc7UYcCKOrk8pUgu3ci8sd/DxnH
 yV1ls3nrvctZg==
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-68bac6e24fdso1728091a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 15:26:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/2Hp3Upgjhxl0H4XQaV99KlbStYKdAvaJjb21+QxgqgEHiqLIwFwFdOQjjl70LLeAXxmJ+0llR1qA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YymKv0uW5kZduM+Ii0uliJ0xYBeJ+6u9/m3k9KGapNMKb1GRJaI
 c8JafPfAj1JWDvMMac5qG9A0fqGbBarSDrP/YuaxaSZ7/m+r/Q0YA6GibtxZahW98hiZEajY66s
 8CU05oJ0QZsV5jtDJBSGxii3luL98iQ==
X-Received: by 2002:a05:6402:388f:b0:672:f3e:1475 with SMTP id
 4fb4d7f45d1cf-68fa5035afdmr413318a12.12.1780611975291; Thu, 04 Jun 2026
 15:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260523190843.33977-1-meatuni001@gmail.com>
 <20260523201444.66197-1-meatuni001@gmail.com>
In-Reply-To: <20260523201444.66197-1-meatuni001@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 4 Jun 2026 17:26:03 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+ASCZNaq4h9YFeQDQnepBio0sOqsVuwE2Y6adypzKbGQ@mail.gmail.com>
X-Gm-Features: AVVi8CfdT4Yh-wrCR6LjndEHJQMw31sQLDKGquswe4IP7M9oZaPcoGx1Rgdi2ak
Message-ID: <CAL_Jsq+ASCZNaq4h9YFeQDQnepBio0sOqsVuwE2Y6adypzKbGQ@mail.gmail.com>
Subject: Re: [PATCH] accel/ethosu: fix OOB write in
 ethosu_gem_cmdstream_copy_and_validate()
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: tomeu@tomeuvizoso.net, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

On Sat, May 23, 2026 at 3:15=E2=80=AFPM Muhammad Bilal <meatuni001@gmail.co=
m> wrote:
>
> While reviewing the command stream parser further, I noticed that
> weight[1..3] and scale[1] have their base and length parsed but no
> corresponding WEIGHT1_REGION/SCALE1_REGION commands exist in the UAPI.
> After cmd_state_init() memsets the state to 0xff, their .region field
> stays 0xff and is never assigned, so calc_sizes() never updates
> region_size[] with their extents.
>
> The job submission in ethosu_job.c validates region_size[i] <=3D gem->siz=
e,
> but since secondary weights never wrote into region_size[], a userspace
> caller could supply large base+length values for weight[1..3] or scale[1]
> that exceed the GEM buffer without the kernel catching it.
>
> Does the hardware specification guarantee that weight[1..3] and scale[1]
> are always sub-offsets within weight[0]'s region, or can they reference
> memory independently? If the latter, should their extents be validated
> against region_size[weight[0].region] in calc_sizes()?

There is only 1 weight region and 1 scale region, so the former.

I think we just need to keep a single weight and scale length which is
the max of any base+length.

Rob
