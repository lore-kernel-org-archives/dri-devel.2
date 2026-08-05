Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9329EC561E6
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E94BA10ED33;
	Wed,  5 Aug 2026 07:24:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MM3HPnZx";
	dkim-atps=neutral
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06E4210E186
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 07:02:44 +0000 (UTC)
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-66771ded50aso914934d50.1
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 00:02:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785913363; cv=none;
 d=google.com; s=arc-20260327;
 b=nIUilClj5o7fU+rnKk0Cp+/Sf0CjTaS/dPqCkP4PHA3VLsywPpm2JLj+8m53LQg0WQ
 MqiHBnXQJuU6ksC0jpGDh64dfZhMwjPtX2R2SX3E1F6NbUokJr6XcVPRfeTYoW2Ewfyg
 h4NnaaNawL4lg6azBz4cMhbkYarUB4r/qj5Ys0HvDz02NemfUrXanlmioVbAqFJ5tucM
 0eVOo9MCeW9t928JBTmXE44s/9QZRC97v8859nedx5/TZQgrESRPNdYeZFY2PGOiKAFy
 oRuf1hT8+KcWANmcOtpCoajE/LB3X2J3tKXHVQ4N/TNzGFIt0dioCsV7O11QlD072y5l
 CCvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Y60TCRk5n5yLOLon2qFjPKh9SFL9tvHl6trgyo4bm3Q=;
 fh=ipmmXpedrOLLVWkG+kFevjWGhKYZAL0GGJNlMGvpib0=;
 b=d1bDgzMBcTxV80gxxKXF6A/MwRTy8Y5mFZ4maY/YqdYjayatSbHh5shdS4t8fXbdLP
 6Sx2WbHOv1OcnSLUHcHpJQ8StYo7Ya2qKshJrhh7ANIwLFKG7FB7kPGUrAvXfcDzdZ42
 Opr8MOb40vsDW3OkEKo0W3bhdbhck9IY4Oo2auvUcAPrYIFzwmSEp3E/1aLSunoFRk8A
 cZPH47ijZAjAel/ByHysHqmSZ6aJb0NkE4ACQdSCvg+TAW3NxhwUVAU+z95T5Bj3NHy0
 IsnzYl4Y/ITavHUdKUspVHg51atu9VaHpTUWO/6o5VAw2SVh+5dr0j7EpEwHRgjIokly
 ae4A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785913363; x=1786518163; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Y60TCRk5n5yLOLon2qFjPKh9SFL9tvHl6trgyo4bm3Q=;
 b=MM3HPnZxGsx4PUpWrxmRqC4H1hR/mrh5EtXIun1pltMZ7nWbZ6wEW6deS+Z+p7IIfV
 a9nU0AKjmVuy07ucewmV5Bnt2IyoR8kBNfxseaXsnF7DHyDqDmX0Ky6gF22n4KDxCySw
 NwBbh3IFGGr9z9Nwt0doZcmZVe/HOGTNM0Se4xygJu1iSmxZiVupkR4Pa4JQesg/C+7q
 SPCHGiCUB55Q7Q377nxqFX4orh5+Z/BXDsg+VBFPUmxDddhi0U31/9y8EgQfp2TH80YK
 iQz7UwHuOquSzS/rUJJJJphcC0l5C07hkLtqmZ/SLs6o2Q51k2W7qD/nENQ6wAUmMMk4
 FrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785913363; x=1786518163;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y60TCRk5n5yLOLon2qFjPKh9SFL9tvHl6trgyo4bm3Q=;
 b=VgaxCj+ltxqdQETJuBlKmy3rcRwYJCE0s3+LRKkerppcykp2zCfCfYZXb1nsJqrbRY
 984RWbxPed6N67YFDDuV44P14LOwg93Ey1F/uMVWbU/671LxPTD5Bhkpf71a7FpuCXE0
 x9t3pJqksk1wCuF3thbT3KLICGkN/ft1Zig4UU2ZAHD7h19kSRREABBwaACmAZt6wSjz
 lnUxQ1/JdM3eCx+6JOqcsAEKckNuD3x/9VkOrvmU+0wL4tlezdmjTso1a9rBm/wrRwkL
 Yz8RhlknoflKbXIBZ+H4OQVXJdyH/EvNQ7nJ4GWyS/F7FR1XvHovfTPJMMBld32uxf5P
 R0YQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+FZxqcbdzz5VzIT7nl4Tn4+VQJQmq9b0d58M/yNbEkrf8AZvZnwLoyQtqJ6/UD/h2QFyPpmk1ULY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7tPEp9UjW1Z0HRjzsmjOdAK8qvHDcsyBretGJ1TPdMoo5rnOu
 zD4o1HjpiU0WnsQqdkH1M4tZpQ22etvDf6kT3HWmJtNphLwYlIJFdO8lsJQ8qBqRoRrUaNogMyp
 hykKn7/ywJ1cZs9EdzwJCNlpcqc26tGw=
X-Gm-Gg: AR+sD11f3D9bQ+4LcvobnjnIoibGhIj90nYQbF9ZvotEv+0WMBjyRNb484Dnwvwctd0
 ir6ZBK0CgzgMdB93M8Bb7adRiHe40F73AOP73P9fzQy/MFucCUgHIttKRbC9ha/oU3eaTcC5Z5g
 Z7bm5MKLk+aBmlJtsorDQ4hKYYhAYHCEJ4q6zwTOjIzcRaagKLXitYQHKbYFLURS3LP3bpzSmof
 qPGRXrjmEl+vt7wcGEcqWYUBcn4t5+MmptxBlNDm5s/fgHwy2wVvTAE3gvZ1nys013IpuQ1mHgI
 QnfNdd/breOINXabhdbU+Td7+oNvYfXxq0L515bRro5C
X-Received: by 2002:a05:690e:11ca:b0:664:dbfc:e454 with SMTP id
 956f58d0204a3-6699a892fe6mr2574216d50.3.1785913362887; Wed, 05 Aug 2026
 00:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260805-falcon-dma-projections-v2-0-4cc9f3f13ee9@nvidia.com>
 <20260805-falcon-dma-projections-v2-1-4cc9f3f13ee9@nvidia.com>
In-Reply-To: <20260805-falcon-dma-projections-v2-1-4cc9f3f13ee9@nvidia.com>
From: Ethan Plant <plant.ethan@gmail.com>
Date: Wed, 5 Aug 2026 00:02:31 -0700
X-Gm-Features: AUfX_mwzehL-ePDmTswSjyc9hlF-NtAAFmKSmV6DsLAB8oAWcLbYIszSPAFss0U
Message-ID: <CA+ZM=sFFWx-yCWaWsUk0usONc7BMh3xckFxZj5tQx70SXtao+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] gpu: nova-core: falcon: remove unnecessary check
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Tamir Duberstein <tamird@kernel.org>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 05 Aug 2026 07:24:24 +0000
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

On Tue, Aug 4, 2026 at 10:03=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> The `try_with_base` call performed on `NV_PFALCON_FALCON_DMATRFBASE1`
> already returns `EOVERFLOW` if the address is too large for the
> register, making this check redundant.
>
> -        // The DMATRFBASE/1 register pair only supports a 49-bit address=
.
> -        if dma_start > DmaMask::new::<49>().value() {
> -            dev_err!(self.dev, "DMA address {:#x} exceeds 49 bits\n", dm=
a_start);
> -            return Err(ERANGE);
> -        }

This also changes the error returned for an address that does not fit
from `ERANGE` to `EOVERFLOW`, and drops the `dev_err!` diagnostic.

Is that change intentional? If so, would it be worth
mentioning that in the commit message?

Thanks,
Ethan
