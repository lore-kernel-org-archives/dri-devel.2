Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBEEC79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 19:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55BCF10E172;
	Tue,  8 Sep 2026 19:47:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hw6T8i1n";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA61010E172
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 19:47:29 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39666e7c9edso484662a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 12:47:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788896849; cv=none;
 d=google.com; s=arc-20260327;
 b=WEclFNJfANO7Xio4GYH6TU5b+KyvOajDwyn+ApUWeHD81hA/KNHfmlA0axbQHnVqop
 DIh7qEwermtaEvC7fwmWn8Yz9fvde/Ie7yQveBetoFH3aRTVcIgHOTttLuGQdhl+uWGn
 Xj6MOYdkt4C7dFDbc/FEpUWAY3g1vU1Uy3/rFQDBmfVLZ71KECeNH3XHGiI9V73rR/SL
 pd5A0/pCzbtSVBLumIat/v45UZ3ysO6Y6Em7VLHH96E8DEqrEwwtNQYa2dRe3imu37Bk
 zinToec/6a4PwjcicAJGN9n3CFU22FUXomDsw4TJoiQiYvnbzsRI8HZJ1d0y1QYvaYLU
 Hurw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iY5QnsT4qlVhjZv2PDQCFtybqjTxSMGZqhX7XmXrD0U=;
 fh=KpTxspJqQ+dYYz+xdVFKutkbMTh3R/cWHXvEE9yI4Ys=;
 b=cRlAjJLCi3sNzaXtP2Yy6L/hLzbxZAAgQjSDq0+dDzmX4OFdoyw5W6gfBYUSxy/Mm/
 Z4r+VlPRZmaeehYUzhwd30IBdiDR1j0AqzrEADu9T0BmklYsIs4php/YYR8EiNzle4sh
 BAm1uiCSiI5jmEbp5J+ZyzwWjvqQdvA8nRphe9ffgQOV8v/OPoECx2pDpBfE0OHAtVrO
 LhLDXu9S0AYOtn6a5f23OQg9+mZvkr5NDPkLJaxC9gIu5QanJF5rMkcvWMSNUR00kxaS
 KN5J1qIotaCpT1jvYCFT0/6qYfkwOSA5HdxCeg4LbL6JzcsbrVtPKiuYJ/CWuRC+yI0D
 4Rrg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788896849; x=1789501649; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iY5QnsT4qlVhjZv2PDQCFtybqjTxSMGZqhX7XmXrD0U=;
 b=hw6T8i1nQtssjw8U2tcu+hMlUiCY1fx6OSzmfTcMOdJN5yHafuuWEudnWvCnFo6G4I
 /IJdyZyH2DxoEsuQZx8sY2ohwAUfvtqivJUIFa2QeINnRPKA+JzDCyj3lmpiB8kuvgtj
 OjLHYWv3TA/JeImtnz0Q9BED7nLB0w2dHypxZ3pMxjDQgvZutttYPrkYSaAUfmjSNp8S
 cTSrfrlrYrqn56qiUDQ768eT5Q/ugkMyHImWNsrNATgH2m/FdCkQ/SGSh7GJ+p1PKyD/
 XHGYgx9g/9ROC00BAXkkHIjNS3ewPv4mABaLvXD7tMBtxQhLgWi9d60/AqCLEWyQ/oAi
 DNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788896849; x=1789501649;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iY5QnsT4qlVhjZv2PDQCFtybqjTxSMGZqhX7XmXrD0U=;
 b=SYlFsJs1bVAZbLQSerrjLAlU1KGVAH7pO/TJ16UwcUox9WQxTIytBqyAMKwt1eebFr
 s819kJVlsGjUY/3/c/ZMgY8h6Ih+10/hTLfgJ9IyWSVlY+ZpcYssL0BZYQZWT/MhrcJ7
 Q/S5G7HagDaTJ19AS0C73gBs4J3Qe1HKoiTpyXD4GVWNz0G8+pcWaQ1y/e/uFzNRklKq
 xL0S863b+nbJMpGRC/hr9UxNsVEeMDy/GUdu+FM8j7ntvM5Nk4hi1Z7YpPt4bnMi7qMi
 x4g8Aa6T2/6tL34ukhE1g9lyexP7P0x1Wy8qmJJb5IGoN9cBHEU+3nZep4RsCPxO+veX
 I4Yw==
X-Forwarded-Encrypted: i=1;
 AKwUvByGFIGi/ROGyhiE0UXVxFvz2QYXIdqY2WXkFg3/+SxSdgcL4q/71jS4XoRe82G0Vei9zWPlSTcB4yU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lK2AAH50ty+5VK81wJgqnn1++5QsOfkg2w4Ixm72TT9f/YaWxc
 I7Y4xvGZVgoDr+0KRlnYjfrm06DGO8Cqcj4OQQhcVXUe7+Pox2yEvciN6sixJ95f7KiF9MmbROW
 r2y/CBvhVdeDZWuiP5UXH8dX7FaFqKUQ=
X-Gm-Gg: AYBFou3Nm6Y5Iyoc3/IlBSJEzswBhabuKuJCV7TorO2PeSRha0OiSyQhYJsK+YJP2ve
 QoveSfgR1ZTNHoapRLNcVPAvWtn4qhw4eHldqVOPs7OLHcnnJ54NxaDEHNGYYtG0sopOhDPGhlK
 dKR+wNNg329Bt/xwV5vwY2/sy4ArlXc25Csqajjd4WVvGJhX6Wwz8aC0h5BoB3mpMZqc/K2bnjQ
 BCmZ3w6iYW01DVxQ9K40gTCgX2kwO4NjA/q6T6TA09ynEPgsAOaRLwSsaRJkR8u7m90RNTmwtE/
 lYfLKtSLYkyX0cBJX6+Z1dCGyZs1k7QXHyTzBnUEJJPkCiuST/OBNs2xZIf/AO4rHnQy1XAFz7i
 NBQ5/HsARHQQnNS9fj1CvpUGLWANWnHZHrU89isqqkenQ/FWKT0obQ2d5splv93daLNqan6W5N4
 fSx9tcxDwWgy2iBjJqeJEQKQ+9fOuRFTj6sg4oFKSd4kkkCz+h3oM=
X-Received: by 2002:a17:90b:2801:b0:38f:aa76:88b with SMTP id
 98e67ed59e1d1-39b3d7d056fmr21707651a91.4.1788896849093; Tue, 08 Sep 2026
 12:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260908-tyr-ioctls-v2-0-88bea777df67@kylinos.cn>
 <20260908-tyr-ioctls-v2-1-88bea777df67@kylinos.cn>
In-Reply-To: <20260908-tyr-ioctls-v2-1-88bea777df67@kylinos.cn>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 8 Sep 2026 21:47:15 +0200
X-Gm-Features: AcwNN1XXa9g_iZLSTKQDHhq0xMt2HPgPqo8BFVOYoRvUTe0z8qL0cOKPZrDxOdc
Message-ID: <CANiq72mdp9hS_U=Mtf5F6Qv8M9=m38xOXtCP_a4c_QtkwhpFEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] rust: sizes: add SZ_4G constant
To: sunke@kylinos.cn
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Lyude Paul <lyude@redhat.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, dri-devel@lists.freedesktop.org, 
 Alvin Sun <alvin.sun@linux.dev>
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

On Mon, Sep 7, 2026 at 6:48=E2=80=AFPM Ke Sun via B4 Relay
<devnull+sunke.kylinos.cn@kernel.org> wrote:
>
> SZ_4G is used by the Tyr driver when splitting the GPU VA range into
> user and kernel regions.

The message should explain what changes, e.g. a new paragraph after
this one like "Thus add a new trait that ... and implement it for
`u64` because ...".

> +const unsigned long long RUST_CONST_HELPER_SZ_4G =3D SZ_4G;

Is it added here to be nearby other sizes, or something else?

> +/// Only implemented for `u64`.

Intra-doc link: [`u64`]

With that:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel
