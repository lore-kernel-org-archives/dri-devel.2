Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F08106ACD6
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 19:15:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E1C310EA83;
	Thu, 12 Mar 2026 19:15:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="homXtovm";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9A1C10EA8F
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 19:15:46 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-1273c690e5bso106210c88.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 12:15:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773342946; cv=none;
 d=google.com; s=arc-20240605;
 b=Z/xEzi7urb5gyG6li1Zk8ui274BteK6TB4MFK6dqbpmxANHjNTKVdHZCsSlqBBbZCD
 EjnwzMHf2mfKqRBU0SKB1HsLaCP2QrP2l6hj3PChhAsdfwK0SZ+ZICHc33CcPjAdi7c9
 2ChhgFjafNPN0EsImRUD2EW6D9O1sI2KgYGR7GpRSRS6siaCVWAyo01Ze4ijdJ6p1F4q
 6QZgfj3jYPJl+/zDFmrLTnwL0GgIo3kLtO4/3LX8U04edzxKn+Huov3PiyrHtwZlvT/X
 /IAVIj1mpODXom9FY0G5XOegaa1wTA3x9BK8nBv3+jNdE+Cqjb1wUXnZB9Fz9zowCWzx
 9s7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4VzEC4HlHoK4vh0lvr6EYPz1Eqp/YdbOqaCW1vewwOg=;
 fh=yuQ/ETl4WE9cFFO6xcq0DeMphOoT9iw2WG0uFElU9Gw=;
 b=RhbieLPHXmKg/Y+yIckoMkAoTBkwwiozt+yvGGRafoPV99v5ejICJtGy8U9pGXWiac
 YN4Yptpv/M0lwV09iz+QsBq4Y0fS1cIvBB59u5Kg7z2/wfAfF5BFqDIHLdMAoQZTfhrd
 88qmeC1HgMN7PmQ58W4zidnjb0fHPyOU4NNzhDQHJD00yahhAlLvg42rtiLiAMzsbL/F
 qkK79EvQPsZ293DNBHZu7P7wY0Yg9KH5VNIZbHpV11Lh+X/5FH1WTBHA/ijhpotPRkzO
 t1gjuCJpnZzX4SPIPyXcbmAddDyv3piiJMbZTYW9pFombx+GEfEXkG67UyNgFtWpv0iP
 zLdg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773342946; x=1773947746; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4VzEC4HlHoK4vh0lvr6EYPz1Eqp/YdbOqaCW1vewwOg=;
 b=homXtovmL7d23e1KalTVecPCknznywPIJhKJxhlfi9r/A8gMAxe1ycrez11l4fcHPC
 UGvAcbrIPdP8O+4oEK+JchQu580zby3Tlf2fh6+ztzz+HhH8wE21U6foC5E2j5gyYoFM
 iVKydSWkzJza/5PFWOm3qlqzqrH0RYniiCSWHJ1PfXLSa0w+zNGzVtbdj14pTcR66X9s
 PMwush3kC20A/nl6ZSDn+yMNBkGgnQh7jo+XNOknpROw63oeMZPgx2RpLGBP9QLTA78P
 EDwErEtf6ttnw7STJmy01IEfICVkOTw7TU9vyyi7EmAcaP7446w5CnqMgfCZ9NDSjUeO
 zzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773342946; x=1773947746;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4VzEC4HlHoK4vh0lvr6EYPz1Eqp/YdbOqaCW1vewwOg=;
 b=MSdookITfJTHE9mUMbGPNvtfb5ji8xr+S/l6IJS5t33mg6rnAzb1/38L904QCNYzS5
 Q7hWGxWiQ03424FzG6J/L5Ryb34foWcJkrFaCX37mk7hKRtJf2aKZ/pfrLvXC7YF7XwQ
 +mrYVO5XZfplUOGTOJxVl8xmvz9bEkHuVmZjCpbBgd1DQTF1KDymJxlpApnQbU7nETSe
 dsLao5X+W3M/Cre2rO2Ixpe5bWHqo9F3Qcxb311/9AXqLHhrXUxec5HgUXynBCXI+Tnh
 UZBr4Sx+GbBwgQ36Mix4HQ+a+Df7mGjK2DP0eKUDhM090cc4ICWYRzJRPWb1rpZwKJ9j
 tD5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/0UOYNOa9zW3Dt3iAItxJld2ElHn5pelDls6Uz+dLEumu6oaooQeqANtVIlx9P1McoLJFJ5UqudE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwyaQqSrIp3ej+HHXIYd4s/VzWrOFEW3JkWZfcyQ4A0ywq+CTet
 obV1dXibZ8AodXe0WabbviQuuGZ/w+xBErBM5pJceqfW/eHtYYHBvV2nkPyNlK63vf0IUUxjFP/
 kaPYOF5py7R5BF3/uFJdYx0OLPAQmA/4=
X-Gm-Gg: ATEYQzy3ZYcpO0gZCoJLphnxpQd5GTU4ji6Ry2pLmM+alk6KvOzAUJ0bvZ3XHb0Ocrq
 dnR4HfHCnZ94XTyNmz3krUJOgXP6y1VAPD3YSGvgNaJ/mNm04v4WoaV31R5c0dApOQ4X9aP9mdy
 RmD08wIvV2RE7gP8SSaCY0Dsu5kX+foR6IsPgMrZV7pHj4VrQkLiSJXAK7rHYn6uAE4VhFODuae
 7c8a6rK0ZNvmrnXrd+Mad1m5GI2B0+IdV9IRzOp83f5Agy3cGXrXwnFgvB9zVVxbREfHEtgc6Cy
 Gm9ReTrlfc7Dmq6V1zD63Ab09TVLsEAT8JM+BfEd3xK1yEB6BIcM3ShOG0vwV0LexDLBL+gKpfd
 xnMNbjrEMHVRXZaLvg+i6YIg=
X-Received: by 2002:a05:7301:1924:b0:2bd:d8e6:90a0 with SMTP id
 5a478bee46e88-2bea555c8d0mr231898eec.3.1773342945899; Thu, 12 Mar 2026
 12:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260306203648.1136554-1-joelagnelf@nvidia.com>
 <20260306203648.1136554-2-joelagnelf@nvidia.com>
 <DH0ZMJKN6OE6.243UPT928HIIX@kernel.org>
In-Reply-To: <DH0ZMJKN6OE6.243UPT928HIIX@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Mar 2026 20:15:33 +0100
X-Gm-Features: AaiRm53560zXAmoL0EVQHDBxYh33LaVByeeBz-QChPDevjdBJ65drv5v7FGkL1c
Message-ID: <CANiq72n6ccEz71V3nkJxtY_BNbTw3F_eekt+Dyhvfb1FNP-srw@mail.gmail.com>
Subject: Re: [PATCH v12 1/1] rust: interop: Add list module for C linked list
 interface
To: Danilo Krummrich <dakr@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, 
 linux-kernel@vger.kernel.org, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Dave Airlie <airlied@redhat.com>, 
 David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>, Daniel Almeida <daniel.almeida@collabora.com>,
 Koen Koning <koen.koning@linux.intel.com>, Nikola Djukic <ndjukic@nvidia.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, Philipp Stanner <phasta@kernel.org>, 
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
 nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-doc@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org
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

On Thu, Mar 12, 2026 at 6:42=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Was this given off-list? I can't find a corresponding reply from Miguel.

Thanks for double-checking that -- it is fine.

I am sending some nits and Clippy issues independently though.

Cheers,
Miguel
