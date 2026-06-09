Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD76CD8CA8
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DB7210E5E4;
	Tue,  9 Jun 2026 19:28:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UD/omq6n";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38FD110E5E4
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 19:28:25 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-304e86ecebfso367463eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 12:28:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781033304; cv=none;
 d=google.com; s=arc-20240605;
 b=eGGXhVea9XVaB8rpqkCxcE+JtS7LVyyQ7r2ZL6pZSEqo67U2/VBUamNNb84amL2KRJ
 I014u7bdRe8+/F/LvQyADAWjwo1tuDLckrh0uC8iKPLN+CH8rv8X/oZRj589F3AcXDQg
 wWbrgE4mzs1EIhJgV4utsbZ47BVwCwNFFQ2uD8MqyeR9CoAVEmmSzGtunYgi6cviwNYF
 6yxtQ2rJ5h/IsswoFf6a8ytOrjLly+dgg2MgPFgLOZrLFWfh7o+v4eCZZsVu+ruIIXr6
 AVp2+M3sxsIqW00kuuI8d3sQQkjamWj6hELClTnBpoXDSqn1/TcAgYCq95HvU9FuODq9
 5nww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OJg9nwIv9ACqjDswvJZaERxDdDEAwRUfl02ZMVnz9zo=;
 fh=cZAZRCcZsNFaFZo49JlQ15ks2M2qoBQSHl19jIDKY3M=;
 b=C68TLWnaa8vjtJHSg5nO55x/VUBN4HV54fRaTauVKl6FiX7Itynkg0+FuiLaQa4yjb
 PME+rOlJ/extgIWuB3RTiLxBVck/8MoXk5OzhqpJK9QMwVDlIPftLXivnWXgeMmZhTYa
 6w4sNnyRU0hJiSTk1z/XS6faafbTubbKpTpoMfyYZDnqLMO4VTKVCFbS3GtqYvXyM09R
 8FNQ5SO8kQH0YBRzTRutR4rMnjpTRkjzfXo0yea/vo2ibFWowfiTui6lI3kqJ8A03+ki
 +p9/ScA+smkfe88sJUVFI6S8/pujDsJCadSkdDjYHn2hodqeorTgu0vy7teQF/IQYaXw
 h27g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781033304; x=1781638104; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OJg9nwIv9ACqjDswvJZaERxDdDEAwRUfl02ZMVnz9zo=;
 b=UD/omq6nf9VcmL/m9QlcUZeXZeVIi1u5xsInIii5QQ3pjnrR9aZQdZM5tZBgoh9QCm
 yvQKKu3HbJQsZZXqnI2IDa9wGUqkRA/9bh2QG5WC1NH6wEvlCc1fwmksHoG0LS7ARQoU
 Pii668Ae9mbpj/1nSNzIfL4ElyluF/9IEfB3F6XbdI39FETAlKlNKaPGzkfl2KRnLu8R
 c7ZuJ0abZBoZyWV5RUt7uJV6RtMzqKjPoGYhI2zZIoxfxQZzFH0WFMzmWasBU0XqPZe1
 svMTk/o00/8RJhLpO3RraAwOb0zaFVrFdYcHoaGoVLeKY9eaSdSQpBpn2hepTN0c6I3a
 HCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781033304; x=1781638104;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OJg9nwIv9ACqjDswvJZaERxDdDEAwRUfl02ZMVnz9zo=;
 b=D/F/ankiJ7yz9ptdEgjJ60rK0+GJvnqKRR/jWbvr0mRzyYFQrGHtFIuf63uszf9mzk
 L10+fzyMD3LMIc0r1batX0onm2cocSfp2q0Ru83Fp1lIQ5Sq/RjucFytga+Z0lvfPfhL
 9TXIYBC17dehFhHqLJe+/R5eCSe0A6lZW6gZoq+HZnN6RJ7gfYciPE5mFzFeXCG6OCnU
 758LcM5tDmJsh4lf8V/cb82q6gmnlLq/REkMpKqbbeWanJohU4Sn5TS5hYE7nX1D0ZmY
 cyU3CBFGwOss6UOQray8U+F4YsDElTh/kKBpEX0tzNuTueatfk53nck3dDIvtHFIapfK
 r47g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9GjhKiD3kBuAT4k5SCQBF8LqyPb3k7IQgCl4mAo9k8rqvPFXsbwG2xivElTyTsRtQICJ+29vIUMZM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyOGPDQk4DV7UitTALYSarO7IT1g0O3GyQdC4qjiWPY8MK8ledS
 it6yOC+6w5pElW6VaOym62+0lxXyCYevsNxIMl4wrV3giNT7rsJUEHU1GpUotynHeTTExrWVrw/
 b2CMk0WqyOrD758jeI/WXasBhHzKxGls=
X-Gm-Gg: Acq92OH2pZ0Wdr55F/tkjAcZgt2KRQnsaLizeiPjH5P0qj+M/Azrq9ZIN5LVH4G68lR
 zxi1u2rM/Jv5Bql++Pm6DCSM6Bj6nFKlt89qeaFgoBa1pHfAaQuFm3OcJociV4N3mVW/SybXyO9
 k+0kmOEGeHjn1laCbW6JgaoqahIjYoFBCN5TrkV9ep9g0yZPME2hVZdBdYSVzqDlUfCwMNHTUxm
 nDHbnESya5/Ipc+6d1YL49nHQacRbtTHqa1cljeTiQyyC6x5/bZTDNM+/LzYi6t5rUEj8FavAVZ
 ggWlOFNKfyQNJWAq01w8jiSd4niQ7RCNpoXUzzaeDJNFXmI1Q8cfzDHeAS6yEtSoDgEphiLngCc
 I8WgHJUauCm6Nof5MP6si7o0NvQe8On9dXVHoRQxkLYMh
X-Received: by 2002:a05:7300:a509:b0:304:f860:3ae3 with SMTP id
 5a478bee46e88-307d5cf2045mr1484875eec.1.1781033304355; Tue, 09 Jun 2026
 12:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260608183057.2001376-2-lyude@redhat.com>
 <20260608184329.0BF6C1F00893@smtp.kernel.org>
 <8898fc261aded12d8adf4c5a74cc6bd830072f27.camel@redhat.com>
In-Reply-To: <8898fc261aded12d8adf4c5a74cc6bd830072f27.camel@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Jun 2026 21:28:10 +0200
X-Gm-Features: AVVi8CfVgY4o06ZxMCThAreiMyLunTvD8jssVSLsOSZ1KkZvxyFM72Kt74QKoKE
Message-ID: <CANiq72=_t6wc1mx-AmiOCQKf0i0VvvjFLf29uCBgbgS1PmPU3g@mail.gmail.com>
Subject: Re: [PATCH v19 1/4] rust: drm: gem: shmem: Add DmaResvGuard helper
To: lyude@redhat.com, Gary Guo <gary@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 ojeda@kernel.org
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

On Tue, Jun 9, 2026 at 8:19=E2=80=AFPM <lyude@redhat.com> wrote:
>
> Looks like the magic 8 ball is either hallucinating or this needs to be
> added to the documentation, because there's clearly nothing about this
> in the documentation. Ugh.
>
> If anyone can correct me here let me know, otherwise I just assume
> hallucination from the hallucination machine

This is the the prompts we currently have to guide the AI:

  https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/rust=
.md

The goal is to eventually have a single source of truth for this.

Having said that, it is a slight hallucination in the sense that we
don't say `inline(always)` is "reserved" just for `build_assert!`.

Cc'ing Gary.

I hope that clarifies.

Cheers,
Miguel
