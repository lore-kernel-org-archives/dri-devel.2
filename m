Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F6E103E18F
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 14:30:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEB6A10E858;
	Wed, 18 Mar 2026 14:30:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="APFO8JnJ";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F3A210E798
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 14:30:46 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-128d428ba0cso453439c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:30:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773844245; cv=none;
 d=google.com; s=arc-20240605;
 b=jk2WlibiIImBhRv3UEILQEToD5+9uia+ogoPkCbEoLZ/LTEBooGwAUfeaKO8k1rgsG
 zYKjCS2ARdbnKxcbmcnOFBKRThHu2/0/03YaASMMddlmkbOh7yacqedINDULFP0Fv3pz
 1ZQwurGB5pN3vKKZVQJtr4TuMZj6yhbxMVwwL2x2aInw30lWoVaSJEvFB9cofgiUB7Y6
 Ce/RCDL+UAgvIcqZFpKcvirFL8cUKsWT8rbfL71knwToOzeNlsp7wgLQSutu9KYh1c/c
 sBVjLx2cNlnJykyNN4PIqoDrFFMAdo10+dYsnBWe2Ll+eyUKT0wTie3sm33ks4AAIHY8
 8WTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Lz2XCxRPQhc2ZncmeIQiQRFj2Y2HhTtKvhZaZiMtVkM=;
 fh=RQOIV7kIUsz16IlShVDk8QcsCeOuq1u2VcnFHN6oYQs=;
 b=kq4f4drIez/KftUxj6aSQMtr6SpNhw7+f6OR2cdDbOkXhK5TggGQQTwK/Mc7pMxniM
 fC8SC6evVrtwFi/2UXXjnBtLjWdKIZPNmu8iDOoR0TK4Moo75DhbLxM9DW0W1crubca+
 e1XN9/j9fG9CB2vN9oSp1AKFnuXpQpzuBnFVNO0uMlKOE8rpVRt3puAFmbAyOpNBHspc
 L+WJRuhxu8SSkIBMxVULAENG40LN+YTKJFgcZAQQFSPc9zASDz0mMRnxnfu5VvDdiltf
 qBdcefihQhZ2KMaCfCtSGQxXsoCxL2zD/tFJE3xZIwDiQV9zPsBd99qafj4q1yjyg7b7
 KWLw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773844245; x=1774449045; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lz2XCxRPQhc2ZncmeIQiQRFj2Y2HhTtKvhZaZiMtVkM=;
 b=APFO8JnJ1yOoESUujcgaa6jVuaKJ+IvM89d3gFOWGcbiaYfaF8HgHZ5zc6lRral7r3
 ux2M8j6RSBU0vZ24PNLPK15xLa+ASU6gnt5Op8mDHwASbjJEuDEvQylNbQz8yO/G7yw9
 DdKbVOiN8J3DWqQADX4jPbr/V25XaW/0jzMyeHfCLkPViNXj3thVDqhw0/WzU7R3m55R
 SHZ/rziRd90fvETjLOvH3outj3i1jSnekOBcz+ZjlwuwgEZ+x1CTXb9dVZ4rikrJDYPo
 EpOAWkx+JhMC61oj78qloUcNQ+bL+a4xRuEgJ9QTSFKz3nt2QlvH3RysOtepAOYQhDm7
 S4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773844245; x=1774449045;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lz2XCxRPQhc2ZncmeIQiQRFj2Y2HhTtKvhZaZiMtVkM=;
 b=nBlmg0FyaY2QP1oYdSNxEOkL4tBur3FHYn8eMQMMFNX/t5RZ4qEmDAr3fqW6jnUarQ
 DLlBxuBZ/85KUSlCg2OaGDNbNpI781r9bwtz5Lr5FBcZAelNDk6luqjOj/C3C895USQ2
 n/2Y/lnOPqhluODeK92no4NRS2KS0wvEBg8gRfAN7k97uQxHm+o7yUF7h5mCRXdU6cdX
 EFgCxyRhWpaDdE9AlByXqxJiDBAdPt6yUqZnodkzumgyww8We8QChB7HL2ycE4gwZAF4
 LHzh4PoglVOqCaNB3noIvpDcruA4pw0rJiAvveRjlIByVtQZA3w5aS9ajeVl9zI8AvAf
 gzDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlI3WLjgyuvI5bZnNogeEN3QP8m+NYHFVyTrP48agh5ObDto+mBIXLLMbOxfNwRZ2ghNTQfyasQIY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxuU5pmmpDMnVO+RlTjT/g+HDjVhHtXfaJefbVxsogZXnwgkDek
 826lUFUJjyQb+RI/bln/ZnHWKEOaMYwumsmqMlIOZADgdLLrzUzXqKDbcBfzUp55lHrITHIZJ+G
 r6Y/384qJnGpg5cvjF2KRT/bTEvBA2i4=
X-Gm-Gg: ATEYQzx4Na4x3QQ6U7Nf097gGJXQ3MKRIb4WAQVvuDInZsY9qlYTJO8ZZq6EspSGQ9N
 m0AOV0KNwgYVqK5evvysSg4TptO7vr6wZeeghnipIDqnf93ssFLi7uHw/DdBXJc4YYOVscQ5M3p
 iSEHsl6gH77O5OKPIi/3jpy/T0xjJb57UUvHnGUwYRkmh8NDxcUhZVVgn8tggPxEA0zd0ciFzMW
 /0v5bijR0Eat2eTDxBrxtGUk9ReAO+Wy39IBg1e3SMiAXAiFfpkGVChQ3PYhtzaijsKnqOuuxkv
 YY8lE8PYIBdO47D9WtxvIVzwJiRLO1jtfLaXpuLohScc2qfEV5ksEAaVBfJ0r7D/epFvC3Sverc
 ArQNSQcyG
X-Received: by 2002:a05:7301:1e96:b0:2bd:fa8f:77f4 with SMTP id
 5a478bee46e88-2c0e518610dmr846274eec.4.1773844245396; Wed, 18 Mar 2026
 07:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com>
 <46986da6-8c89-475c-8561-964adaa7d034@nvidia.com>
 <abppV3e91iVzplcv@google.com> <DH5UOS96171T.Z8XSRX583Q60@nvidia.com>
 <CAH5fLgjUMaC5v3SERZLosdD1ajU-fvKSgNq6OgbBBcoTS21-Sg@mail.gmail.com>
In-Reply-To: <CAH5fLgjUMaC5v3SERZLosdD1ajU-fvKSgNq6OgbBBcoTS21-Sg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Mar 2026 15:30:32 +0100
X-Gm-Features: AaiRm50bVmwgAQrBl1Sd2LWxaRmG-ZY7uRxgxq5LrbNAlb0we3rijRktUCTLM4o
Message-ID: <CANiq72=GGicUCODkY3C8U53wQfsuRYeu9GiwrM5eFhkP99kiHw@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked list
 interface
To: Alice Ryhl <aliceryhl@google.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, 
 linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Koen Koning <koen.koning@linux.intel.com>, 
 Nikola Djukic <ndjukic@nvidia.com>, Philipp Stanner <phasta@kernel.org>, 
 Elle Rhumsaa <elle@weathered-steel.dev>, Jonathan Corbet <corbet@lwn.net>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Helge Deller <deller@gmx.de>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Edwin Peer <epeer@nvidia.com>, 
 Andrea Righi <arighi@nvidia.com>, Andy Ritger <aritger@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 Balbir Singh <balbirs@nvidia.com>, alexeyi@nvidia.com, 
 Eliot Courtney <ecourtney@nvidia.com>, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-fbdev@vger.kernel.org
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

On Wed, Mar 18, 2026 at 11:59=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> I'm not sure we have discussed it in detail yet. Both are used in-tree.

Yeah, we have discussed this several times in the list and in meetings
-- please see by other reply.

The handful existing ones I think were all created by Lina (so perhaps
some were kept as-is to avoid extra modifications of the patch -- not
sure) or by you (so those don't count ;)

Cheers,
Miguel
