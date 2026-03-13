Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1DB107BCD0
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 18:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 149E110E47F;
	Fri, 13 Mar 2026 18:27:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Ojd1SazZ";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D53B10E47F
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 18:27:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773426433; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eRnTvKeqbTAzd8i9MKqJxPQHk+pf0xvKZRvdh51hXs9cwepCNVGKtAMgM7j8bsvTOSnKCtHqZpr1UT9Oa522wyro8TLd2S/s39bENzGpjbi6DPQQyPj2TQa2WTNCgQVGtAJ2wyZtShL1RzCzDxeVkHc058YI/pKRwFfDlX1vfUE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773426433;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=CHS3BjQq0VBAi4mRT9TwPnGIyWeOsSa/CugvrbGKyuw=; 
 b=kD8/w0mL4qJfqNejaGZntidZ8SqiCQ3p40S/V9HHqK2Fp9j9GbIE4JAX96XB3JF7uWaNUa3T6XmCjkr28wpkfUv/8yoJxXyC4sZD+j6xR/ujZy+WcdpQ8n9JuhdlFazPFOo6fzEX4exRx+BsDOfSPfz7tVZPzjxraFTXO4hN9Kg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773426433; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
 bh=CHS3BjQq0VBAi4mRT9TwPnGIyWeOsSa/CugvrbGKyuw=;
 b=Ojd1SazZXsiQvi/N+d0kzop2wg4sVp9T9rvh61hrWtgLriyYkXfwzWFFg2IVRPCy
 0AC081juzaxQxVUIITI4tT7pvQltpyyUyb0BcXjrM0EWM+SdxbaRGa4lK54SYAZyyvu
 PxkNb+gi0C7iEYsM/T/6hEb79V3ZJqADTco6Qra0=
Received: by mx.zohomail.com with SMTPS id 1773426430902383.77139251966423;
 Fri, 13 Mar 2026 11:27:10 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 1/5] drm/tyr: Use register! macro for GPU_CONTROL
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260311-b4-tyr-use-register-macro-v2-v2-1-b936d9eb8f51@collabora.com>
Date: Fri, 13 Mar 2026 15:26:52 -0300
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Dirk Behme <dirk.behme@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Boqun Feng <boqun@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7C2EA827-5DA1-4FEC-AC6D-93BF374FCFF3@collabora.com>
References: <20260311-b4-tyr-use-register-macro-v2-v2-0-b936d9eb8f51@collabora.com>
 <20260311-b4-tyr-use-register-macro-v2-v2-1-b936d9eb8f51@collabora.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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

Hi Deb,

I went through the addresses and ranges again. I couldn=E2=80=99t spot =
any errors.

To avoid accidentally damaging devices, let=E2=80=99s not include these:

> +        /// Power state key. Write only.
> +        pub(crate) PWR_KEY(u32) @ 0x50 {
> +            /// Set to [`PWR_KEY::KEY_UNLOCK`] to unlock writes to =
other power state registers.
> +            31:0    key;
> +        }
> +    }
> +
> +    impl PWR_KEY {
> +        /// Key value to unlock writes to other power state =
registers.
> +        /// This value was generated at random.
> +        pub(crate) const KEY_UNLOCK: u32 =3D 0x2968A819;
> +    }
> +
> +    register! {
> +        /// Power manager override settings.
> +        pub(crate) PWR_OVERRIDE0(u32) @ 0x54 {
> +            /// Override the PWRUP signal.
> +            1:0     pwrup_override;
> +            /// Override the ISOLATE signal.
> +            3:2     isolate_override;
> +            /// Override the RESET signal.
> +            5:4     reset_override;
> +            /// Override the PWRUP_ACK signal.
> +            9:8     pwrup_ack_override;
> +            /// Override the ISOLATE_ACK signal.
> +            11:10   isolate_ack_override;
> +            /// Override the FUNC_ISOLATE signal.
> +            13:12   func_iso_override;
> +            /// Override the FUNC_ISOLATE_ACK signal.
> +            15:14   func_iso_ack_override;
> +            /// Maximum number of power transitions.
> +            21:16   pwrtrans_limit;
> +            /// Core startup throttling enabled.
> +            23:23   throttle_enable;
> +            /// Maximum number of simultaneous core startups.
> +            29:24   throttle_limit;
> +        }
> +    }
> +
> +    /// Power override mode constants (`pwr_override_t` in hardware =
spec).
> +    ///
> +    /// These constants can be used with any field in =
[`PWR_OVERRIDE0`] that ends with
> +    /// the `_override` suffix.
> +    impl PWR_OVERRIDE0 {
> +        /// The signal behaves normally.
> +        pub(crate) const NONE: u32 =3D 0;
> +        /// The signal is inverted (on when normally off, and off =
when normally on).
> +        pub(crate) const INVERT: u32 =3D 1;
> +        /// The signal is always kept on.
> +        pub(crate) const ON: u32 =3D 2;
> +        /// The signal is always kept off.
> +        pub(crate) const OFF: u32 =3D 3;
> +    }
> +
> +    register! {
> +        /// Power manager override settings for device manufacturer.
> +        pub(crate) PWR_OVERRIDE1(u32) @ 0x58 {
> +            31:0    pwrtrans_vendor;
> +        }


Alex might have more suggestions as he said, but to me at least, this is =
acceptable.

=E2=80=94 Daniel=
