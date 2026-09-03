Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A504FC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8B9110F5A7;
	Thu,  3 Sep 2026 13:28:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KHLXY1Wm";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D4AC10F5A7
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 13:28:57 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2d900ac39ffso2954925ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 06:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788442137; cv=none;
 d=google.com; s=arc-20260327;
 b=AGLED/4WyecCV5nf0RqDq7EGJatFxtHpEyBfQyrnYl7EnmMWTRAMlObbhk2LG9mZj9
 eEik+C9VgluJHDTWg3x51nhJPTXuBarPuYP8n0S+K+44dpaxpL+3kmd4uV9byfWgLsk8
 7k6VIhveIprYdO42J+WU0RiXU94vvdFPlY+YSjXomXOXZ6RgcDLjsNkP1Pu079bmxqQW
 EABjhaUWs0C93Zu9PGkEFSDgLuJWDmqC/+sEe5TbTLkWSJ8DMvllzltP+pGpmh8Vl9KR
 QU7r5SSGA+CHkPTm9dJ/BaXrQO1WKA9D1IGtS+SrrXKtM+PZ/qMJ6uWIk31hHKMYEcOm
 5bVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
 fh=ZWi9REe/2vBaN5Yxt7Gd9Fz6aTRIloDZ+bA2xmVyrsk=;
 b=Hm5cTMI58YF3NTtTZUqADDdqz9v6YVZUt/ItNAPoJ08y8+gEwYAxtwOzRM4Wq4OMA7
 /UIEID9wl1o0XHqvvGJ1ZiGixmb4M/Dbi6PIFpFb9tcpVxvEk0euzp+ciprZ7vS3ibKd
 3bPQTFQbxMOg5gTuM4+Y0Bxr4hb65LW8L2H4T1tj/VbCK2EwkVHMb6vJ8rlASelTnXrE
 2WDZmrQZofsLVZWoApGI0Abu7TNhI/VXgOzmLcQ7caikRYmwrGPsQg30/BgRXKti3C2Y
 UKeiLCJIIW9rPj1C/HGvl50vgJiOa0qNANrppBkwpbuRmlo5cuwR7vNc1gPpty4byLO5
 6yrg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788442137; x=1789046937; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
 b=KHLXY1WmoN12E7K4HR+tTkE+17yIzKBONUg246J1f7FHM8RVMeNB7vDNOpGBFm3eGM
 B9GkeOxKgo6lt1x+bJsSAcUadciM74kwZ4j2JCMQXkJq1EAoAN51aCHG5GdIz0zxXMQ2
 KEviBqAprfZeklOaXKOyDh0vU4XpARa1i2+m1W1ZUdYNCUNHZatE9b2JFXbchySjDVxt
 2+1dP6rW0B9cBElXbcb1gEfUpRy+iZz4mDQsvmhYuJ+3XPGvWZWmknjArloGeDwAoY6q
 jirizPUS5K5zFgwWXZPkoZX7wzL8ioOvjFoxLL2x8oDnSc0143Zf91idT5Sogq97j6/7
 Rhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788442137; x=1789046937;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0lzGBDpPSFyRzORpVpv5BVqn0OH17bvA2nEL9BC2eGk=;
 b=GDwU6bW+VDRhsPbqEqZZ1RzVHnW7o1cvSLpjgOV8WugKU/WmITfhwOOOC7eA5MUWpl
 CVIUSjT6k+xO1+8wCuDONkpKjCGoS8JHRvP8BrVNklO2AJfL/P83KjUfAU+1CM/+451l
 l64AOMZ0e4w4Ejnuzd32mds1S+XClzXVw2QQVzQrcxb6eb8Eq1Fcd1PvrEnX1iJKzcjG
 DDl3lJeX14zUH6G0FZ7jJwAVWwxObpw10P33Z42AT6MJGedIbRg50JRLD4iIEZbMbyEH
 tJFlTIkOf7cRbwamZwYRNCVE6FvrdEPR3O0EDmiovJWs/V1LHYudPp2e5oxYHERtFXuK
 LrGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhsg2cZuXbJQbfAmPetK1kOUrEz+OSeS9DpFiApTW02HU8qxrVTdYqRzFhVkD5Z7Hi4IKc5blaK2U=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mLpaVQOY6w6BqsnDM+zafymVNrrrqDK7TCzj28YoNFLzfsDjvg
 UgB62NvD1y88UoRj3ELy/i/65CxATfQNtiE+Tsp5C6s4Tg8588Br1FKOoH9NccgvswZw5UXAzTT
 WNt2MREo7RUC8EVpVUHALFLPQJwdWuZ0=
X-Gm-Gg: AYBFou3TErqSGOw5cByz6FUvtC0kpbhhW0mKmXBu0EljpUyOUgyoUngRXRXw0aXL+ra
 en8ZRjAR/CJXMsYVmOgwZOxedrUH67TwpvSXw0YSdNZxO8jEQRyCKIE7gGDtUKa0opseP+iT4zz
 kjJfZ3Yt3tl+Dts+VpvS6mvZmahLnimIl4kayYNS8J/pGyUUe52n3ifS7VniBf3BnZ7twB39JGh
 g5uAh2/5XO9FSur5atJwWE71qdqAvfNYqvFuw09o8Ws0NYbys4V0kdevZ/JF1ImZASET6SQ8UnQ
 UVMwsxF1pgx7HMbwnLUkmOV6aVk4JswHYw7nlkH7b91FVPUZ2afNncsGD/6psSXW96ErYhR+JjX
 8xTGlFqPaeBfWn5V2MefXZRBu/+W5H3J3RZzZUtzJAPfCol+334FK/Nh79zc+
X-Received: by 2002:a17:90b:1d0d:b0:38e:c140:2a0b with SMTP id
 98e67ed59e1d1-39aee0e6ed8mr12609481a91.3.1788442136905; Thu, 03 Sep 2026
 06:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-6-490735672187@kernel.org>
 <CANiq72mPLrKQMzb37ow2969m5r3Z2Kh_4LHERUun6ALw3ea6tg@mail.gmail.com>
 <87y0dt1b8b.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87y0dt1b8b.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Sep 2026 15:28:43 +0200
X-Gm-Features: AcwNN1XsmuEPyO39jqyvRGfAMw_DGGPMkiDRHtfg1ZEoNlBhpVDCHnmjvBP_pa8
Message-ID: <CANiq72muo8SotJHJQhEe=2kiprbrQTvrEMqd1Uw_7yNSfA3Gpw@mail.gmail.com>
Subject: Re: [PATCH v20 6/8] rust: Add missing SAFETY documentation for `ARef`
 example
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Ira Weiny <iweiny@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
 Oliver Mangold <oliver.mangold@pm.me>
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

On Wed, Aug 26, 2026 at 11:29=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> Do you want a link to this issue with a regular `Link:` tag?

Yeah, thanks!

Cheers,
Miguel
