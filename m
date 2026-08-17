Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95342C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E7FB10E524;
	Wed, 19 Aug 2026 06:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e+t9Z7cp";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 144E310E8F6
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 20:21:25 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2cc891373e0so50114755ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 13:21:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786998084; cv=none;
 d=google.com; s=arc-20260327;
 b=NzBW0SYPmbY0NJvhF+uEW7U6otqo/kjg2BUFRckR4ZSlIKhRV9Dy7Do2IYHQOkpK6b
 OvsdCmzZ2DXDsi555NLusvKnXZxe4UkYTfX82EBJdHE99/cb8T3Jwh0Wi6oDgX1LXSfC
 IG80NvMr2SSmf0BGTrLcUL8vaUwic+Sny95BoqyFijFmCzY60ximor/bl2djCAmwtGet
 stHtPjGvD7FkpUoXiVUQjlO28Wxr4aFBjKVwXP/s9xXWYhk5O0CbUGhj8BonkSQ/mSu6
 UCMUOMvKplILnsaVkIh1zGxtdx7b4iF2l88lOaQKSYmm/Cu0rBLBNt6DVPbxbao0fSOU
 q62w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lwvuQfJxe+jzb1AKqFkeSinncTSpOJtuzhCaTM05Xok=;
 fh=o9r+ANDgNxZmnGqO75TUSbgyqn/Re09SNTmfne3p6GA=;
 b=P/3MQMoODTqjAVN0aRs35wVL6v8j8UO3HrMwJW1DyDM9TVCuqYk8NFUalWTGria3Mj
 h5+YPt/zaBpjkQQ/PR68csTECb3KDPsNFG1kgK2zRDrsgY/ULB6torXffJFOGoAjRN+6
 Zy804q6OSIH8Jx9CNDyto6zOLd2858wBeiNp+sgqHtGHGjGiLa0O0HE45ygQetXBG//X
 JR5uZIKyWrDF0VwVYwE7tqR6LgL4OmmUi9XeOyYnNB7e+v8TcF+cU8Ew2jpqrb/VMqwA
 YRCfvxv1IHuItAb6V3WVjZF8Fn8AxmeR8aeOH9iCVcdh5s3xg6dacRwxvZ9Yk6lgGCdq
 Ektw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786998084; x=1787602884; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lwvuQfJxe+jzb1AKqFkeSinncTSpOJtuzhCaTM05Xok=;
 b=e+t9Z7cpB31hcR5KAVb/Db4OeaJvz79fvycBT202sJy5m/zxoF5TpBYXhueB6WnztA
 7gBV5A3EcMgjefK87NGJ3ssMMeMG9tuM1chBw2EZmVMXnIzN2GlMnzcoRecgxdKgd4At
 9iazW7/GiBjqIhjaLl9Sa6XXV81AgzyuJ1+TQeVhr/gt8A/kjjMk6VzRGyiZuP97SbgI
 yWcr8f1qVD01UJPPTvAal37L4NIZFfbAMI3dCIGAUn7G2PyYDok0gNt+Or/4A6i1Mr0x
 P84t9AVIvLbPmbGgQENQGxkMxQA62IUMma2SEmGwGUHmua8lBmdTnrUk8gSnVVzDnyCg
 ENgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786998084; x=1787602884;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lwvuQfJxe+jzb1AKqFkeSinncTSpOJtuzhCaTM05Xok=;
 b=ZnP6ZWW0O//8myANMONTgbX7TfsP05PDoCqxTdr5WDtuBY8NR9C7yNm4WYGsZyu/Yw
 xSUWjozUxvNPMcVPfbszTMwu4SAMI+4htWkkIB/f5iCNCJHsj51KJkwhyiLTERY+N4Hs
 Mf13zuT5JLxHC1AagG+yRQ9eLVBEuawW/QSYzSQmuK7fQ8/UVePWEW0t/mjZklLZDRKJ
 xUbRG80nvjuoP8yV1OMTWxKvKIGViQGAK9hCwR3ve1VyEc8m8DWVYOgN5339H7S/G7uz
 a+9JnHSqmSA5PqpULm5WviUTdYOcaiouFPU4MPD45vdp7RiM1PUHvQiK1nuZvUhWcbwq
 sf6g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqQKASlfatHnwaPzg1eGJjGi6oT0AZepoM5iB9H4aT8l8OEToMc5AUuidJKw488TFoZLQf58D2XSLc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzElv6M4B3MZr2QqvFtwIs+M9rdMrKj7N2Mm9HOHhcCUAMW0NaA
 2XTzG7MNZIpQ2kA+ftwzsaDUpeckeB0bJ4m7Cblqgl5IXz76jEihvjMg+MTQYKXHeVsoW6JT3U9
 2DeoCZVL+GEU0YegsEpddoF8Z6wrvlKw=
X-Gm-Gg: AR+sD10vmtDgN14mCkhjRZlQPoFRoyzTjwX2Bjh/MA5tHGRr1DDE+StH/o7AY9MWYlO
 YvqrMS2kSpOpiQKX4grH+/R2Xlin8JlqaWi7/Y76caRokwTTF/oCX5qfEmmsQTsGsaH8WAZuNM0
 xrOCLtCXJp+MDMOrv3X8jztH8HZbCMzdOE3+d9AQdTh/mZzQ1XLA1447aEV2yXCgh+km+/vVKan
 7zcnBAndxyZjtZMcjTVZUCP2+Gu4yaqg1WVK9zPFd/EjV0si0aQSiQNXyUAJxTA6puopFL47bEa
 3yW0TViHFfDWnS9iOJE11s3ur6RX0+f1i3I1RDtfKnUOJH7x3olm3blYzIwoxeNyMOdxQUXbyXf
 vADvuFrtwJiBouPficpVHscFGake3CQ==
X-Received: by 2002:a05:6a20:748a:b0:3c3:a9e1:a819 with SMTP id
 adf61e73a8af0-3cc71fb5781mr30510652637.24.1786998084370; Mon, 17 Aug 2026
 13:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-7-a5872e64d8f4@nvidia.com>
In-Reply-To: <20260817-chid-v7-7-a5872e64d8f4@nvidia.com>
From: Burak Emir <burak.emir@gmail.com>
Date: Mon, 17 Aug 2026 22:21:12 +0200
X-Gm-Features: AcwNN1Uf6g_nlw9gnlPOPGW_J12VrUV1D6JYzwR-ziAxwEvca2A9VHgurt9Kvbc
Message-ID: <CABwQupP+YAvDQkszHWZ13GNPer0j8XSDL3j7Eo1Q233Vd1vW4Q@mail.gmail.com>
Subject: Re: [PATCH v7 07/10] rust: id_pool: add contiguous ID reservation
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Yury Norov <yury.norov@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
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
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

On Mon, Aug 17, 2026 at 9:04=E2=80=AFAM Eliot Courtney <ecourtney@nvidia.co=
m> wrote:
>
> Add `IdPool::reserve_ids` which allocates a contiguous range with the
> given offset, count, and alignment.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Burak Emir <burak.emir@gmail.com>
