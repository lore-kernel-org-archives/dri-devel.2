Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1387EC5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:36:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBEB610E711;
	Wed, 19 Aug 2026 06:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UoS7n4Ja";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1C1210E44C
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 19:42:36 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cbee846deecso4064827a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:42:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786995756; cv=none;
 d=google.com; s=arc-20260327;
 b=LgTpPMAbJG6mzb0e06LuRBtNqr6W/srqTTT6mRR5n7nsqZ0ZlgDgX5B3+85GYPWGTJ
 U0ZY6Vkb59gqG3hfwQr0SwE64S7Lh+JyISzXs2vyuNu1ywCzvTmRV2KMg4O/vsFuEmaG
 Ngjx1Ba+ll2SkpQ+WLVCLvq45/yBxZ+uiPowGSK4rV5sTtfxGK/DeWxPu1Emu42704ZT
 lD08ARvLNT3AsPbO5t5iASmV46GBqfDWNFOG9pmNzTLXVYJjz9OSzejqPIObFjr5f1NB
 F7yn+slzcJpxpCoULKaaGYA+bnUFrpqPpbdYznVyrReP0EabNXrZ3bJYpQ4xoFll77O/
 sY+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vixakSBqG8jvCwQICQq4eyAI0L2WXXSanuKhJ9r0hgg=;
 fh=nPSlkDuXBqFx2Zi2/wJYZUvGLK8mNiBnirXrTSqap04=;
 b=FI03PCYID9sFo8hd/Lb+zUaw2ue2rQH2cEArfw96J+4pWD9fRJ0SBYKpFGVEFUKjx6
 O+NoW+MHctv4BATb8otd540d5H3MnneFI8/sfqUPpB2CpMstaWpO3YIYUU+vgcK23E3f
 rm5VPErTIs6hEUG8svMR+VzYTYgReLljS52VvfMetd0/qvc4TZI82RxZ7yIT2tTNk1QP
 7wkx++ymREkRspJIN8Y077hyLC83A6uvjJDFD6ze3Oi33C73UW0CiZsQoGjNXRF/U5CG
 2EQ0iScy77UWaEL3ikG10m9hJEZUBkym6Z9/VrnXoHQ6s+/pzVDukFnLvi8iWIODh6Kw
 FAgQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786995756; x=1787600556; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vixakSBqG8jvCwQICQq4eyAI0L2WXXSanuKhJ9r0hgg=;
 b=UoS7n4JaJv2SdDeJuQV4Zs/1iWlhSsZkoIti+/NrlCpFM26M4Adtabj6wcB1z54QG5
 ly1mZFFOduhX9LrhbEOokB8UTU9mVbcHlTkbTD5t7maOXecc57TEs4FwoS6DUK+U3jq6
 aZh8HtEbT77EQQk9RK5SUMyuNSPHR3azmBUrTuGwpenBRuEoXB1GZ44GEykSu/y7Lz6V
 OjuBl9C+fAkmqa7RmtIOrauNxosTsyh0ZbkYecvXZ8G92/aSTw5Yr/zmUP3eCuVN/Li2
 2AIYbFFbpY5kGJn19Lg+Z8a6onUdin3DGX4zjZ4e6+HqXCTX84hYqHmG34aH/Z2uUCkf
 FZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786995756; x=1787600556;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vixakSBqG8jvCwQICQq4eyAI0L2WXXSanuKhJ9r0hgg=;
 b=VnTNBZXr61/2zgBbjrA169q5JDrMc/LH8yjH8HYaNI+DFlfAjR5o78QltGFCY3XSzd
 RdHe8OOKRpf+brvj3GlbWDTuinYxEy3bhS4Yymp/7h6fHc0Z0MdIjajfnWRQxGW2xw/C
 viTVwMh6bR66fdZUjfnVlZ50nlXuRgs9Lmm0qDclhTP6FIfRgfTEXVEwYB9ziDEE/jeW
 cwN/D8G9h7YtnsCAiknjFLLW57z+IJqfLsN11ZjYLGx79as/81u623maMFZKmamIXun9
 5J4NasPqvM2Rqg3gDut39KLo3Dk9BjzHCySlx/zM2P+ss7rY9osKqIQWEZam/WKJVdKO
 yPMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrxDjFc4fbcJXhJ++qZiDvhbGB2mWQBr4/AxHPz3D0LkTQ5VLy4okrVsXDzwHdXYWAGKBfsBpkWoRA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgBzy6zR60LrgPBLH4fLSYG220nzHQTJs7JbiJ2iXkMGIa7a9x
 6RBGqp5eW83Z6qSiGcwOyJewKMdYJqq65hgs0hdvx3IuCTQldLZMIB6Py8az+wYe+GEdHwENtRt
 7+37Mp6Ud1JmHqpqVtjslHMXgq0MrE7c=
X-Gm-Gg: AR+sD131as1+THqp8nb7erkXsmlYiPfCCMs1WV2+R1BFajZhFC/Zx5z5W6YxRJyFXTS
 rCjJCEqRftx6sYzhej6bZj9sjTTw4ibqUb6CVH289iVe9z+y0jEhPln6+X9mnURmQJ2xL5PY9te
 9JlgvUhR2r9MEr49P7sOaX5e+CV6x3YbbodvjnfFxxc/+jAByyhUrxP4zDWwdAEGWcvjK0TKR5Y
 uaKxEZnNyAuuluqwSskMyf99z8y8UpaPYLAD6G8KWpLusK0/7YI7L6VNGVsdc9j2VvH7kH+T1HI
 xPiIVT3WSv6V2c2bhVzrv7MrrEO15Gyl77gVgRzZVoiuCyasu4umhSavw4IFl5mns0zS6on6OxM
 eiwJoiM2MD0KWknSLrVwVU7gh2hj1fA==
X-Received: by 2002:a05:6a20:258c:b0:3c3:8129:a492 with SMTP id
 adf61e73a8af0-3cc71e0f012mr28014271637.38.1786995756083; Mon, 17 Aug 2026
 12:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-1-a5872e64d8f4@nvidia.com>
 <DKR5D0EQTMIG.15W9AGBY0I7YM@garyguo.net>
In-Reply-To: <DKR5D0EQTMIG.15W9AGBY0I7YM@garyguo.net>
From: Burak Emir <burak.emir@gmail.com>
Date: Mon, 17 Aug 2026 21:42:22 +0200
X-Gm-Features: AcwNN1VsQNOhBePpFFtV90j_U_qeRDlqUCWptv1GTTKIn2pB6mHEM8ZqqsTol8g
Message-ID: <CABwQupPn7mEGu7oS7R_F84werNFMxN-uoxGb0An9e9D7tsYvdg@mail.gmail.com>
Subject: Re: [PATCH v7 01/10] rust: bitmap: use function-level cfg on kunit
 test
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Yury Norov <yury.norov@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Yury Norov <ynorov@nvidia.com>, Gary Guo <gary@garyguo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:31 +0000
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

Thanks for cleaning this up!

On Mon, Aug 17, 2026 at 12:29=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Mon Aug 17, 2026 at 8:04 AM BST, Eliot Courtney wrote:
> > Since commit c652dc44192d ("rust: kunit: allow `cfg` on `test`s"),
> > we no longer need this workaround.
> >
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Reviewed-by: Yury Norov <ynorov@nvidia.com>
> > Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>
> Reviewed-by: Gary Guo <gary@garyguo.net>
>
Reviewed-by: Burak Emir <burak.emir@gmail.com>
