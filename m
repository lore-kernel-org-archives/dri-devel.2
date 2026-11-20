Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A174606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kjIMwmPt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF6811128EE;
	Fri, 20 Nov 2026 10:54:43 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C004F10E202
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 10:54:37 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5c0ace36e8eso56347e87.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 02:54:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795172076; cv=none;
 d=google.com; s=arc-20260327;
 b=pf+L9+/Yjt1NaeHd8YNb7n1BXHhc6kkzEpoDAjqy646Mdl5zOaUydpeL3MYdMKJdlq
 1Pqyn49nPW5vFLbxNMQ6XFjSZlfIn/ZI1vW4lAl/ubZgkXMHsvJY+A8+rU/0hawcchKw
 eN1FUcjJ53v8FNqY1zn7mYu7pMHi44isIbc774HITAL7pRLEP2viYbMfOXsv1UGK5ouF
 jUbQI6zBrgTSAqpoi3LX0x9R0jjvNZx90jWI88BupKZiK7/+dfzmmnAVdN5gUS/vqtd3
 n4M+D1v5pyQSmmWP8UofjxZOzU5DVHyKvnjKQ7RzqUj6qE4k3EJcgKMPFhv57zKszEBo
 uKEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vievxvMoQb39fU5dw8Ha4cqfcWmcBRrBY8uU/a8nTv8=;
 fh=LB4esriHsxmhMfnZo/ygS+dFvsgFS9xi47EEyDbKutI=;
 b=T/fHWiyK/YLFaDopS7ZthuqE2pRt4am1wsds1/dJ25P7gMC6211boTE47+z+1yf3Jh
 I2mJLeuHCIrTJX0zpAW+25cNK+f0QfffbrTuQ1ey++fGq4y6FBNHj0E2b2VGbyp0Exw9
 CUtnR+Os2T0VedChjXrjanLDWOs33R27xqIUBYaZWrl3Juf86IF4uPg/EpKpiVydC3p7
 i++0LCLSelQKgECB5Emf2sNWoSgVz9uyJ/lvG3z/2MnE4whbdwQhtezUGHMaO1mUO9bE
 3SM2tVQzZI5tiJPydxMzCwkcsyXBVHP65AqzhufM4MkPvBN0+36R7oUffU2tYHZRM2Cv
 tryA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795172076; x=1795776876; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vievxvMoQb39fU5dw8Ha4cqfcWmcBRrBY8uU/a8nTv8=;
 b=kjIMwmPtELpfY9UjAlpEwu67FrJexHE4MKk3NAYmNaLzaxPklh8etmUdwGAQ0Z6OhJ
 zGcM7oAWKZG5H+JuqPEvrV7QtotT+kMgP+WxDMAbViybhl5d4VoNwJ8mFB2+1LnzgW1E
 3cdz/MrvlHFyvjVk+U45c8Us2OKRnPIhVxp2EIEPlxG0t9UocTsQ7HF/NPGEguw82D+P
 qvKxSU1go4uwq9f2SW3QE1xVt1VsuyYiH59E2TFDw2qS+bDM42d2jbo6vblnyNxmBODs
 5skQOsWjny8vApfXoqZQqwIc+jh6CCuGQT4DXIB/ABp1QxZPxQRxn0Dads7vCnLC5NOs
 pAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795172076; x=1795776876;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vievxvMoQb39fU5dw8Ha4cqfcWmcBRrBY8uU/a8nTv8=;
 b=Z/SydyVn/JSyy+RR/u1fN8LthzCSHZ40GFv89/i0WW1aQ+xhrlZtbqYfs0HFWhVxBG
 SDWJsW+g86sq2e0peVYbTGamumSYScg7vRu00Kw7f7677Jfh73q4Qv7rh3nvn5P8eOgL
 yZudAtxi98shPfyBvsbeEZmOplloQDbw9zGY/Ur0US+ABKnNYwJy9+MwquRbel9Jt14W
 8CQy6me9UfOUPhYe/eDgKk8N6Q7Y5oup/Nyk0T+sYzLKObkhlxESF+YXYQ2UEc+AwxrK
 HD02tz1bufJ05ozmxAJ96Ihz3+7RqB8FyG+vD0Ued+s/R6R6NyP1zbgXDYyseB023uq1
 NrVw==
X-Forwarded-Encrypted: i=1;
 AL+hErHKlC0qQQ2Vj8YF8CI8wz0o3h3WVmy89OD7NqsI6688l6TXEuTEvqOcRazxABWkagT7v/yOxApyMe0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z84ahn1UjDVOp0kxSVvij2AoqJ7sgOBdZDVjOF7wAi30PTNF8A+
 Ad5fCIvHQ7zZUzNuB4jNIIL/1YJTvyHSEB9Un0hrWZnijaQaLZSxJBwgxhMrAIUIk9ftQxOMzgS
 fxd86BMWwMIFAfJWElP09VShyc569vDQ=
X-Gm-Gg: AZFdTZdYHmkLKiWa9ZBwOOarb1UpQ8pgtfZjQvosfYoExSu5SV8Oz3PQ9qCXpYbHHGl
 BeDZgVVfMG8XN7PODOSRGsW710Vgyn4bRzPXOtVNh4W9bac7RFI5rKmrxTM99/MOFsOJx1Gt3fR
 Vo1RS0k/PujgLGlUp/jx+042+qSRS1Cuym2jx23lrDnZsmNi9XAFA/cNVXft4c05M2WlqrO3fM5
 1kJFX1XAbPZzLDbEa2p4MAXaNrC2t52A+MlymI4tNXKUAqLvJyIPuc2x658N/Xf2ynE8TOODxV3
 K1FoZQ1QAC9q07s7mEbJWcr2MGZ9w6gqYcHscyaMZlYkpIutZY1mzOqpKDWdbMnq2/HfQiO2Uz2
 wDUXDEmCEFdWec8z4+tQlUOaXEx7xPlhF3pPaPwXtXI86OCWk1iPnqKKspc9HJ67LIhSdnefhl9
 gaSgNv/V1zTUKGVQ4USH/T0/L6aNoz0s2gmyU935Bx5SAe9sYFYdIepW0dGp670hRjfUB3q+1Km
 znMDl4FVCUi6lPCqoR9nMNlb0GSzARAQ7c8QcO/ibwnEWLOCkJC3N6o/9Xq7x0suTKU70aE
X-Received: by 2002:a05:6512:6812:b0:5c1:5703:46ed with SMTP id
 2adb3069b0e04-5c1bc89ca10mr714804e87.6.1795172075335; Fri, 20 Nov 2026
 02:54:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020-b4-gpu_info_intobytes-v5-0-3e0c7c93223c@collabora.com>
 <20261020-b4-gpu_info_intobytes-v5-1-3e0c7c93223c@collabora.com>
In-Reply-To: <20261020-b4-gpu_info_intobytes-v5-1-3e0c7c93223c@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Nov 2026 11:54:23 +0100
X-Gm-Features: Aa3M54o513_u4OJXnC_4PJiTfbRDccCUiJK3hUcQFc9fkLbXWHCQET8-3sinerE
Message-ID: <CANiq72nX+94ie+0RjysjKT+FSoTH0TvWUCOciPObvnrkrnH-eA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] rust: add zerocopy to bindings and uapi
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Jesung Yang <y.j3ms.n@gmail.com>, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 1:48=E2=80=AFAM Deborah Brouwer
<deborah.brouwer@collabora.com> wrote:
>
> Make the zerocopy and zerocopy_derive crates available to use when
> building the bindings and uapi crates and their tests. Also make the
> zerocopy and zerocopy_derive crates available to rust-analyzer when it
> runs on the bindings and uapi crates.
>
> This will be used by the Tyr driver that needs the traits IntoBytes and
> Immutable to safely copy the struct byte-for-byte to userspace.
>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

Looks fine, please feel free to take it through your tree:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
