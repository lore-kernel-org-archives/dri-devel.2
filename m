Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76E1CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D95410E656;
	Fri,  2 Oct 2026 17:15:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PgoBQtbD";
	dkim-atps=neutral
Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com
 [74.125.229.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48C5910E66F
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 17:15:40 +0000 (UTC)
Received: by mail-dy2-f12.google.com with SMTP id
 5a478bee46e88-32be7127c64so969453eec.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 10:15:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790961339; cv=none;
 d=google.com; s=arc-20260327;
 b=l8GlJJZkq11tbymK1Qgq+m/MGnWkSMmYTiU2QFdTQuzImhKeqSgzrqZdGJuTCy2BKB
 e+Q0vfaMRvYLv7oUUMua78b+P8vQkmiZE61tPinoqyyciVCKbg0GlSxYJ5YkdPrZgC7M
 ZgJUvef+5ygYn6lpHrJdBIGgMfnWeBMO10EGMtfAtdaaQ5XpQ7EKSRHpanJGAUsopUwJ
 o9rH7B77lOOHF+g/Op/elkYTDY/RaF17icsdSKlF/K3O/58nI1Aa5bmInHVD2fdz8OyU
 ek+8Ilj5n48CQXOP4jpLZR7O38yMawftnWg0OXuluoxDNygOIgoOL2zUoiLT6I0miQAs
 5Flw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EN1cEQoe0e3LCZQ89Wmj7iyw49pEd9peoNHzrA2Y4aU=;
 fh=Lc4yW5LESWMRyH3ay7BWXp3t0pKfiVNcDqtKLagZxEY=;
 b=YXZzzcaGnhtIi34BNwH8b4MFQs10knS//l3sjcM/+BYeDSBMotxvN+Qy6k8UgVbcuE
 cwzx4DX/6Fz6ZdE5FlR9twIjUpzIwzrDulW4CK4IXbxr2KqLnp/QwqoBKKcedmOu1xAU
 NIlotjiwP1SVC9S51an5KNMLxvazzZjO2ax8v6OoLhpqCRGA0iBtdg3hKXjX/3L19Og7
 shsK6Fm0VnhVpiu7a29Q+D0Ed2Ri/64DW8sb0i/+4qdixb/D/S3wIeAopQASodW/i24c
 TzqpPTSn+bgnhq6sbZRas405ZSkglJRF1WOpVPPMZPrXS4UaeAS325mYZmFvazBZYyo4
 OQqw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790961339; x=1791566139; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EN1cEQoe0e3LCZQ89Wmj7iyw49pEd9peoNHzrA2Y4aU=;
 b=PgoBQtbD28YpghSbTdXVEq8jwTHLy6FldqKfUkCYAQ0wrexHlHus7lpnoG4v5ZxW2k
 lRQDZrSW1Kf+kDWaXq6VCsBJTNYuwWRVtE79kttvzEKG1+bZemgfnQk+44my9frEMrE1
 vGxYy0P8kACrm0wcNfqCirSjTG6gC++phcBuGfXhobF3wg2my5s2TZ4bIv4w6sa2UF+a
 z8c6uOFApbjW52tTnbMzT2PfgxwukzLtZX6lczAl5qsI+WlZTirMcipubd/WtVBe+4iG
 kJUt2XPc2WE/jxAgBfWMoo3s6W24f0Ts6FGG+fRo8uwp++vY5HvHGW7iER0YPohKPi2j
 ds+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790961339; x=1791566139;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EN1cEQoe0e3LCZQ89Wmj7iyw49pEd9peoNHzrA2Y4aU=;
 b=zy3aYcsA60aUlOpwy36yJfbu54VRalFWezmwTCU+x4ceLX5Jo1krqyeVxgljN4vqGh
 auFXH3lCeTTkxM2evodEJ0tZVchTkW5umx+Hd9qusFIRBanC1VLxnhLZJV45Gh8lG+SA
 9KWQ4vVX7XZRX6Y4keDP9ABuSLRz75rge/S57ezyfE/CGqnIHCB3LiIlqyW8cxJoJICE
 Jv3y1pxZVfJAzXQw8zmZzmPXhtM5TI/lq0KGFUjuI/L4ghce6P5dK1u834vEVx6Q751I
 VNKiSOdZ/wZ3xcjVtdlFSXoiXwshgNxrLuzQ4bSVA2t41c5oGW0sG6zzm9ciE4pGNWMi
 T0VQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHlLwbyqlKowhE8x0/wZY5ykZplqTLLnS9r893Dn6OR4jTlix9qUiNf5UjerTPSOXqSkXwWOWtLOg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIJP+tIwWHThV/1ARrT1/6s3D+y9KeDbOuXZJNQ/PvHVHnaua3h
 W5+UnuZZzIerMPjELxdsSW/Uq3u3BbAQcjSfY1nu6wLjQbaIXSdgY5xc2aE8cFdBBuRiGRGEjjl
 PAQQLonD1UwflLkySM0SGUCdIDgh/1YQ=
X-Gm-Gg: AYBFou0i67MVjDXAF0dvmbjXUyCTv7om2MZoiZ9UdLjHi5UxX3GNj4alIwXm4SwS6O+
 CFPPRlXWqUxF0u5ntM8jXUmZxnE0JcGg5VpQrpg94NZLRXcqT8rQLp/OvfU7Bs8MPUWkNrHubpr
 THcniFHaNoxCJvbxxELRixw2rRB3Mkkuky9vxwbCUPw4xn0sCIvhQrsofq61qtumZ55qOP5jmMK
 cUofE2Z7ozsyk4EthA2EYaaI7oo2/XzD6gMrRDVSDjzvorRyHqxXdI3aQo6K2TAMmEZbZleG8bp
 yQ/B/iM0JiDLW/5Os5Zl6GYexFrPmrzQD953IN1WLiJY6jQTIIV3b8l901aIiFSITW4aoMkVcK4
 flDrYIajw5Ab2XxdXaFe64eOpWfqwRjn2V5MMJAAI+8a92V7bn2BeDGBO8ebJB7MNjh53GJbIAN
 lvNxFTjx1uHac6X9ucVis2MQX+7azt1NSXC/0bOyX/8wxMhYiXZ5A=
X-Received: by 2002:a05:693c:8951:20b0:34c:15b5:b4e7 with SMTP id
 5a478bee46e88-34f1503d60cmr5903420eec.2.1790961339293; Fri, 02 Oct 2026
 10:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260902-cv-v3-0-0f90659e711d@nvidia.com>
 <20260902-cv-v3-1-0f90659e711d@nvidia.com>
 <DLFPWSS3LZSN.12G96EM0FI18C@nvidia.com>
 <DLHFKT44IHW9.2QWQB0O0LJHJJ@nvidia.com>
In-Reply-To: <DLHFKT44IHW9.2QWQB0O0LJHJJ@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 2 Oct 2026 19:15:27 +0200
X-Gm-Features: AclHuK8WU7MmTRz2zVr217nxxpeT8qmaOpCUrJpN90HnuhJSuc8jn6MdcGDQfTo
Message-ID: <CANiq72mrp7qw5jikznfRoWMjcWk3Vwm3dzPdWcC1AZ8jGzdibw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rust: num: add cv! macro to create values from
 constant expressions
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Yury Norov <yury.norov@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, 
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
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

On Thu, Sep 17, 2026 at 9:59=E2=80=AFAM Eliot Courtney <ecourtney@nvidia.co=
m> wrote:
>
> Will send the next version based on drm-rust-next, but Miguel please let
> us know if it's ok to take through drm-rust-next. Thanks!

Ok, given the recent discussions, let's move this forward... I have
replied in v4 with the Acked-by, although with some feedback.

Cheers,
Miguel
