Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8354BCA9EC7
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 09:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6014910E013;
	Sun, 11 Oct 2026 09:15:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BvfKGJl+";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A63C010E013
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 09:15:36 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-33e623bd651so116803eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 02:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791710136; cv=none;
 d=google.com; s=arc-20260327;
 b=htpPUn2sYqycSggOo2Eplde9r7sIs5U7+UZ8qGAXqPAm+H9FSfptpzRR1Cc2rORWUg
 ZCzCcBtz3wMFrXDRsUDKDeyN8bP7oFTy9L8w7aIlpiG9qy2bJLw67hRltcNVIuZRXJX3
 xmRM2/kW2O18hzCp/1TxRV1uvcrmcxDOWhnJM0d0JTfg3d60DncYqQ+LIBziToHXkYGS
 /9UMJ3y6rao7JBhTN0SkDKOD4Sr+oQ8OJzr7LnQiSa+CsLLQ9z7Juidm0EjgmdxfhKW9
 C+SbzLyT6NGgAqRpAslXwkPvyTnLFMNFWo/T8PGaniIgyJ9Zzmk/kOkbGwsCVGU3aJHQ
 gKJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hGkdQt3CffghjwhVKgS734IYuXkQ0DDpVgAEI+JBZM4=;
 fh=PhlNItrMytVS9iuU0Hozl7Ybbbv0K6If9kqT9JihNng=;
 b=psBu9d27Il9uLHb+AEYG2UbNpV9OXRNC77QtvJTb5Tq29OBmIbsfayGptQPdCKeIpp
 v807yNScDkFMdOIy3a+0GqG8vZyCbQe15Mjs8fEHqGOWWbfYRBY927Ugtc0xG3nvwLxK
 UHbA1woQDQ9EVScZYT88tyspqHLAl19ETDRJgXgAJ+VohcqXXGa8UnavEuMpfWOXmsKx
 9DWn5fhp58yMVIJmg455a9EYiezRyh9wMl5U/1QWQbaZqp8CAAsfEScwGE9gzEDMJkDG
 UG1FvtKMyr7FMquKfFKu5SOQ0CgorlJpvshxQiXwFY8rV0SDYECGgZuxuo4ZtPi8yejS
 R3/w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791710136; x=1792314936; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hGkdQt3CffghjwhVKgS734IYuXkQ0DDpVgAEI+JBZM4=;
 b=BvfKGJl+wTUDn1rA1Q0KMgeK/1Yswfx/PvAAueYL+eDJ39HiMxgB6OqTqWDS65Yeo7
 I7qkk6zStx3D0Q3HgRvLJj/0ALVrH8mIMJN4BloZCGyfAUJ1tHnwqx8ChMnIjULfWAwh
 /SKrSfcJppS45SOuiwbK6yvRE1VTt/WX8eUOTxPrbiK77aBYsZlAdRLLN3qfF6xMaHHS
 tdYhVdYQywahYdzsrla5lkKPJfluZvl7u1GONpg42lkUnZRxKZmxjMobhYJryrHs/N0j
 CPQ3waf67nrf8ADx5jxfphUk5MmPBrgS3c/GwNVXtGbYUfD4EO0bEyS0xbErFLJky9W3
 5ulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791710136; x=1792314936;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hGkdQt3CffghjwhVKgS734IYuXkQ0DDpVgAEI+JBZM4=;
 b=F3ort1FHwbDxFwFrVyvZ2rBVV8wYfZ2r6oAzLLXauS2EE8FrSogOnYZIwdvZxVq94/
 lacHq1CCUJO45aaJasL9+Uk42UKK7upvXXLMahi2pn6ChKjA8jfsACvEvIrRSJYaK8gR
 41P80imYMvSztWzOYlymjmvOUH3NxpgdACLHAucARaAeSXbCB+TDVJWd8rASDPtiF/vR
 PRkM/tKOh91POGSJfp3PirA8p9L36qPfDGy1mjVXEKyRMI/KQsPg6NaJcroTLNReob1w
 OOBtkJpQT3MFx+svPTIF6F/+wA45kf2fMVz8Ee33Goov6ENOMLuyoN6aBu5Bmdm4VpZg
 tcUg==
X-Forwarded-Encrypted: i=1;
 AKwUvByKdnzwu1t8NOVnSFpwVUgBXA7HRc3oiK6vvpZ8KiqqWtcR72YZGR2WJipe6BVDm2xYHjoqrsfvrq8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLj/S1nqSHxxIPwu3BwTp1DesG+ogh2dCHHXECndA7rvNP/5aOg
 Xc7pUVGPfr78RXC85ibrSpXiEnoaD13EWk4Pe7P3sVClLx6/KGFZprLITmVIZrNG6kvoM0X0cBt
 uAssgPLv9nTTl4YUXPWs/0EJf77qvINI=
X-Gm-Gg: AYBFou2e8i8FIDsl7fI0RPdfCoIzN2Y+8oR6jErIJ7a+/bTnltlhrzkhmgf7ju8NbrE
 xgFDU8FkAEttCrsFbiV3B6O3bIuDjc3e64rnJpXnreqhpp967uUvLQNTTmXwL8T9VXq2joXJTlr
 LKXZsWhANE9BR7oq3itlMlevkY+2CkKaqxpkOG+98voMDELptHZpD9a7HBSqwk8Fo6N2zjRVbOW
 fly6l33XnuWnhk1BkD7SpFLXDVNd7kcxMyJIM41BGNuq4BnCdmiK4qQ4EQi6t3twiKEvKQOVJQY
 cBzeIKxDJPCV+ZALvT09+/EPqu/lSZWlYFM44tvtDT6CgTxr3cGtmotTs2rHbELPCIwBdaWjo0x
 ih29zpuMbgGTeLQrCvIn0l/yUhhk+H1alLDjrNFtkdcuLAOqkaMR+gSJMxh/o7bZVAI8JEArQpD
 MjQdL86babmU4+bGPRB5nHIFqNPNkMBMKojcIDNuSOJnCSDgF7NHQ=
X-Received: by 2002:a05:7300:ea0e:b0:351:6d7f:e2bc with SMTP id
 5a478bee46e88-3537e04ce24mr13816603eec.2.1791710134848; Sun, 11 Oct 2026
 02:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
 <DLZJSCA10YBI.2NIG6CA24G8L@nvidia.com>
In-Reply-To: <DLZJSCA10YBI.2NIG6CA24G8L@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 11 Oct 2026 11:15:22 +0200
X-Gm-Features: AclHuK8oq3naNnD7eambaIbJJqVk3yW7pH0z0MJvkulMtcEMY7rW0rV1YUtor2E
Message-ID: <CANiq72=91-kisxDHJyth3xsy8BdEdqLd3qpHLWqpRxY_bmFSTw@mail.gmail.com>
Subject: Re: [PATCH v9 0/9] rust: Add support for reserving of ranges of IDs
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Eliot Courtney <ecourtney@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Yury Norov <ynorov@nvidia.com>
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

On Thu, Oct 8, 2026 at 5:05=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
> Since that's quite a bit of code outside of nova-core, maybe it is
> better to merge the non-nova bits mentioned above through the Rust tree
> in time for the 7.4 merge window. All the patches I have listed should
> have the required tags, but the `cv!` patch needs one last respin to
> address the remaining comments and add a "Pitfalls" section at the very
> least. Miguel, does that sound doable?

These things have been around for quite a while, so yeah, if we can
land part of this now, then we should definitely try. :)

The "Pitfalls" section can wait, if that simplifies the
discussion/review, since the rest are nits.

Cheers,
Miguel
