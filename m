Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD50C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:23:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48BE410E078;
	Mon, 29 Jun 2026 11:23:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UQi6DwbA";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0949D10E078
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 11:17:03 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-37cab825ec9so2595591a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 04:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782731822; x=1783336622; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sf9modGDEu51qoKMDfa6F2dR4atoz1mf0fTmi7rEwIc=;
 b=UQi6DwbAbQDajC2MdJApauWHT9Tv6ypfSESxAzl7rZdghtGhvZnMg9h6iuAPo+OQ7q
 8KWiUqm5woVDNsd1/yRCr1DTvJgLoLUrOlxfWx8RqrGuX/063vaWFlNQlqJWkenWqbG9
 Ut4248Kq1pWQTKv9mBbLLHDTbR5lDuTaDsks1IIjHwfFILf/GFyh6i5emeXhGfMV1NU0
 Os7JI93hJdCRxjxQ6D+WNLS4zerwQC6fdY58Ov3D5x5S+mZ1NUamMbibByWeRhZH2Pln
 C8xE73EEqNWJCdMb4PqJhg8eQ6PTiXzhu10NtSGo2UhdhvCJ7/wOdjhWOVsx5GheQuyT
 D4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782731822; x=1783336622;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sf9modGDEu51qoKMDfa6F2dR4atoz1mf0fTmi7rEwIc=;
 b=bRDPNDVsucF2fXuDsEd+v+H6VT6KTtVZpGmBlzK9eATQPjTFXQfL8tAlNB472uCifb
 Fa74SaU2TsvXs9fFcMiT2bYdzUcvIjLaGT4aSm/ZutoJkTcd5Fiu9z4bRLoiyJ9rTRUF
 n8dLfy1rNqbUWlSgtfl+I7OBiXaiCUyeTk8FBsoW8A9BVKF8c12Cmf6tlGWm4pF4higU
 iUG0Sjate1cMVeqgabSZmWaEo2zpHBPu5ZqmjiCQjdQdxn63PS14SB+SwANPQA0HbTc8
 tDtj/IZXWQC10p7ejsFaeTly44zKt9bJuNAUXL1spa+4MYgiCB4t9iQBI+QlLadV9BUs
 sLgw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpwbcR+/VzX7CKMvWRbBv24W++BIDHr4eY14d1ywwJUe6UFVyHG3IvOypDFr8E5y9013HAt+N4tBEs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzVbHNySSjCdjtaefR5zUhqQkPbx64bT2vvZeeda/ZtX0KRuOV3
 N6J+XprAbnrnSfZWFK4/h6lZf/UV3PhF45JkzAm8O+gxHKYnI8Ztd7tX
X-Gm-Gg: AfdE7ck8gKPEIQ7FVADSYYZgdny20zw0ccVE1X2h1sFSBJPJXnzj5x6zspDp67gY8Jk
 WzjpnjI4wmB5Fva4MqlQmP45snlfpn2QwsMHU/pXSUUqlMIrnSyouk0AnAtja3cGgMPuM0ltBXn
 EfFz0IAGaV/jNMlS/cXrKfMGoQnoEdQOM6IPmfQc8+ME1yWt+/8uobQjN3H49RnbxjmLmH/DvEO
 t+dQHMIQnl7NAzaw1nYEQ+M0yvMqDf1SHA5qBESB01+AWANH7tPeuEV5W22tsflUd73Ck7rX4XD
 PQd6KaGwcHBxeH9cbndr2L5p2s+2OO1T62BgQ85STWUHivFQYHiiv0cqWWOyLQv6NjcF3EC84IX
 72aFwp9bu6OCGtOF7kqBiogFAySilq/1AglUMH4x8dr2F5Enqhu4Hdsr8MdcTujXKc5IxjNnnUT
 0JcEw3+ZjUJk9p2moptDVI9V7kSmM/vgNTt0DQmUNyQ6L+4engdan6H+k2s53+nipyLXmEED64z
 fOYtqQjHIVCyEVbX4BK3M76QgpdqztmXpVlDX/R
X-Received: by 2002:a17:90b:5830:b0:380:38d2:80bb with SMTP id
 98e67ed59e1d1-38038d2824cmr453534a91.8.1782731822431; 
 Mon, 29 Jun 2026 04:17:02 -0700 (PDT)
Received: from localhost ([143.248.188.236]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f5ac7c9asm91594835ad.4.2026.06.29.04.16.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 04:17:02 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 11:16:56 +0000
Message-Id: <DJLHOQA5UAP4.340P2TKXGMME5@gmail.com>
Cc: <engineer.jjhama@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH RFC 0/4] rust: dma: bridge zerocopy-derived types into
 the transmute byte-safety bound
From: "SeungJong Ha" <engineer.jjhama@gmail.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "SeungJong Ha via B4 Relay"
 <devnull+engineer.jjhama.gmail.com@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260628-dma-zerocopy-bridge-v1-0-9a2895ebe30d@gmail.com>
 <DJLCLH7GDSBW.28J4PZW0FD60B@nvidia.com>
In-Reply-To: <DJLCLH7GDSBW.28J4PZW0FD60B@nvidia.com>
X-Mailman-Approved-At: Mon, 29 Jun 2026 11:23:45 +0000
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

On Mon Jun 29, 2026 at 7:17 AM UTC, Alexandre Courbot wrote:
> On Mon Jun 29, 2026 at 2:10 AM JST, SeungJong Ha via B4 Relay wrote:
>> DMA-coherent allocations (CoherentAllocation/Coherent/dma::Pool) bound
>> their element type on kernel::transmute::{AsBytes, FromBytes}. This RFC
>> lets a type satisfy that bound by deriving zerocopy's byte-safety traits
>> instead of a hand-written unsafe impl.
>>
>> The bound cannot be switched to zerocopy wholesale (some DMA structs are
>> unions that IntoBytes cannot derive), and a blanket bridge impl is
>> rejected by coherence. So the series bridges the two per type:
>>
>>   1. add the bridge macro impl_transmute_via_zerocopy!, which emits the
>>      transmute impls only for a zerocopy-derived type.
>>   2. re-export zerocopy::Immutable from the prelude.
>>   3-4. worked example: convert nova-core's GspMem and msgq POD types.
>
> Can you give more details about what the macro is for? My understanding
> is that it is a temporary fix for the generated bindings; if so, I'd
> prefer to apply a definitive solution (like using
> `#[derive(zerocopy_derive::most_traits)]`, or updating the bindings
> generator tool) rather than something that will be removed later.

This macro is giving safe manual derive from zercopy traits to
transmute. However, it is not necessary if the transmute is going to
be fully replaced with zerocopy. I found it seems to be true [1].

> But intuitively I'd say that we can (and should) probably do without
> this intermediate step. But please let me know if there is something I
> missed.

I agree. The only useful parts remain in this RFC patch is explicit
padding in GspMem. AFAIK it is still necessary after the auto
derivaiton of `most_traits`.

Best Regards

SeungJong

[1] https://lore.kernel.org/all/DJLEHDNJCUD0.38PFZ5773D6BX@kernel.org/

