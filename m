Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042D0C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:50:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5835510E435;
	Mon, 24 Aug 2026 14:50:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=darkrefraction-com.20251104.gappssmtp.com header.i=@darkrefraction-com.20251104.gappssmtp.com header.b="PcauUold";
	dkim-atps=neutral
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com
 [209.85.221.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDD3E10E564
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 14:50:03 +0000 (UTC)
Received: by mail-vk1-f175.google.com with SMTP id
 71dfb90a1353d-5c276bfce7eso2962375e0c.2
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 07:50:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787583002; cv=none;
 d=google.com; s=arc-20260327;
 b=OnZL01JEiSZkbnHsGTM3h3ZOTuv1SG2v8LInI7YwUaKMcrVBF3SHS3SqbOS7nvUzAA
 ufeqSETxedspwe8tmAg1Mz4L57pzmzDtpDMJNP6inMMFp6r4m+TsIp+rLTTGeBIDJZ8C
 2k4luBi0nLb5O6CShiIw3X6QweAt8xe027aztZqaf/tfrr5ut50T/SwDKY+US+dJS/lq
 zGoqs6X9GFayF/1xJAduSb+L6t5ub43maMc+jVCQtxum+N/QoyjZA54BcBcpTL5ZwF7V
 +vrrjS4J8bAeRvCAi34B8R3kSQ3ndpvCEtLrehpAPW35igqCk0o4NUv2Vm9oJIa/lrzp
 f33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1/jnw52bMP72F/qQ2A6RMospuBEdSfYjaMYSZmBMCGU=;
 fh=2TqpaH+kGq1xZByc+QRpMdYXdCgZxmbEQoaFJfJ6UC8=;
 b=F8ulmXxWxLagmkrKh9y99+2nWYRXHZrq4XsjOo7QHFrxSpaspwVqxLYcoVo+r+ZNBf
 01IEKsT2Oc+KS88RPiM8De9dlc7xxeBGMx5Sz7CoeH3DlMruKIj6JSIgM4su6reVkIad
 WEExgJM73NKbMGKS1ESqFD1O+zzJZavntEu+4Cu4wmFm+x6NjP8dSmyq8THSPQq5MqLM
 LOye6/sySvJQytqByxwPaYPZ04jBkQfunishWe42rmO9cIs7ZICTI0aCATG1ZyhWtsk7
 ormbh1Qgb7Y5yIItVj863kvWz+uPaQ4gbRSDhkIfXtFjxJ/NmKKt7EF9Tq/TalYco5wC
 bW6w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=darkrefraction-com.20251104.gappssmtp.com; s=20251104; t=1787583002;
 x=1788187802; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1/jnw52bMP72F/qQ2A6RMospuBEdSfYjaMYSZmBMCGU=;
 b=PcauUoldl/7Tkg61zk7FACG31AjynkpTwCCO1WHudo5ON37o6n0lV8CwM3HAGZzR9s
 SmwKasJ1/CBo78JPWLvxXk31ru/vqMcJ+r8zBin4qK8xDcqQBNVgzmZvvCtFz9PVWpzt
 u65sXHCT9zdCoMlYtdnObTnN0CKUIjFuwrIORtr90iJ5pSxfxvo/VLExO0QjqvwKzFD6
 8OV4yJ7S4sqPV+RK5KELL6gYTySRDjobq2qhrEBLwdLShRe6FFNL71SGnA85iAf8TZqz
 M8VW9Fw8qXONCAx88aB8tNDX5fHJtejOU/Be5jCKzLE8goOBqJZ6pDHVxLEwQK3AKllc
 v1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787583002; x=1788187802;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1/jnw52bMP72F/qQ2A6RMospuBEdSfYjaMYSZmBMCGU=;
 b=NhJWK5adNZ08KAglyvSrzivqSYXxQ3lMwKoIXHB6FQE8rbxZJLsmVaNgzsRnB+cmni
 z5zkrCPNCTmyI373HiQTY0aUwj+sRyws80HRiYNJvlal309AtgSsgtEOwXnHN2UBKbru
 g4hHHiPP2OiKkxomi35WUkXorGLT2WjkwB3gCfzqmSH+Q8k4g8/ifcAiTqs8V63sY8fh
 oYiWORRTGoyhla4Fwl4uLBaPIbD15H2V58aCIxXTLIPPFD572c3IJVPN/Bei4HRrBJLi
 MhKTvqb0n43tFmV3xkjzikhcCk/oG8jDTpp6Wo79oHN2xdZZvlca98SfgD6EhBiQdZ2f
 KZow==
X-Forwarded-Encrypted: i=1;
 AHgh+RoL2QfUCFb8JYp7n7/EXQd3QUASksxMPOzYNqQoOvGZfCrL1lHL+EjORlRb67D7KVp9n/absJ2fAQI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l9oRr7P90YBF1VeDp95I5TguRJSwxucTqK8GId+M2kj0EFhHHx
 5frOol4thUOAMnVqD/eNHpxNjfpQqtZjyBJGroS00ZWWeYdls1w+dUO1oQJxRWnj4snobwzHet7
 M6/vDtOpzTcYnM4mGe7+AOlxbDzQHBaU/kAW2uR5k9g==
X-Gm-Gg: AR+sD12IcR8cEci3pjXUViLCnVjtiEa4NOFHIOTX05FhQh7AMHGTE15z4JZcWAb5H9z
 fgDcO4KG5Fwx0+YCJLyu8mmvcv//hRBpXLMCfdDd8xeGZEjfzmpgeP5wg542nePjAJyFLEB9RPu
 dlE2ulltw5N/ova25M6YYEKprziF1yILD8ZeauyIq8qN0obEtozSgpcNhkAOSr89rGeH6jQAER4
 TITOU3ivQ23FsXegh8dZRyAGrdp+G6jX1tXpkTtrv7Bbhqa+HgBshR12tL1nhi55JRCahUHH5K1
 Izvo8d52WIjeQMFATpyCUHqYUegWyDapMTpkZWG1SsZOCA==
X-Received: by 2002:a05:6122:62e8:b0:5c5:a34e:46ec with SMTP id
 71dfb90a1353d-5c60de7fa8dmr8437650e0c.6.1787583002393; Mon, 24 Aug 2026
 07:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260811050657.646799-1-apopple@nvidia.com>
 <20260811050657.646799-4-apopple@nvidia.com>
In-Reply-To: <20260811050657.646799-4-apopple@nvidia.com>
From: M Henning <mhenning@darkrefraction.com>
Date: Mon, 24 Aug 2026 10:49:36 -0400
X-Gm-Features: AcwNN1VXMSHFTOJVp4EEFY1y9qIYBk2kbt8_wfsDcMgOmSc3agHjk6H3Vsvh59c
Message-ID: <CAAgWFh0VvY4D=-Se+bVO1YonRNFEa28nc7+ZbxEbv6en7oPaDw@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] drm: nova: Add chipid enum to nova-drm UAPI
To: Alistair Popple <apopple@nvidia.com>
Cc: nova-gpu <nova-gpu@lists.linux.dev>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
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

On Tue, Aug 11, 2026 at 1:12=E2=80=AFAM Alistair Popple <apopple@nvidia.com=
> wrote:
> +/*
> + * Opaque chipids. These may be used to determine what chip a particular=
 GPU is
> + * based on the identifier but the values themselves should not be assum=
ed to
> + * carry any particular meaning.
> + */

You say this is opaque, but the userspace MR you posted already treats
the values as non-opaque in eg. sm_for_chipset.
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/43352/diffs?commi=
t_id=3D945a8e7c51939577526974b342c8dc6bafc3372f
So, I guess my question is, is is opaque or not?

I don't see much of a reason to make it opaque since the chipset has
had the same structure on the hardware level for 30 years, so I don't
expect it to change too often. Truly treating this as opaque would
likely require a small refactor on the userspace side without much
value. (I realize this has already been discussed a bit on the
previous version.)
