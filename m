Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAFB10F2840
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 15:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 077FC10EEC3;
	Fri, 27 Mar 2026 15:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="J7DZ82QZ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C102E10EE96
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 15:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774624678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N+FUxj1Gl+zVCUHvFBWeIGI6C2A3mF/PTd7CkfeomPo=;
 b=J7DZ82QZHXy6rPpKE7z2gacwQ9LBZbmNcXkJODpMmH/EgscFG9u58cYiOJpvpzKy/3lc1n
 KXVNKi3ktgRYlHQ+4TyPyaXBH69BWsTPv4c9qCXubjIEHP5iPkP0pPXXbMXB/GQAKcREgJ
 Fc17CCR1OBWGP5aULzRKXGHIEBGtdtI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-Ux0JavlFOm-b9VSPPlLGOw-1; Fri, 27 Mar 2026 11:17:57 -0400
X-MC-Unique: Ux0JavlFOm-b9VSPPlLGOw-1
X-Mimecast-MFC-AGG-ID: Ux0JavlFOm-b9VSPPlLGOw_1774624676
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b982536b5cbso179424666b.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 08:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774624676; x=1775229476;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N+FUxj1Gl+zVCUHvFBWeIGI6C2A3mF/PTd7CkfeomPo=;
 b=BMF2y3I0x5P6avuZQPRwlnBwUmq7pxxWadmLx/K4adDx0Dx0OH9ZT8AF36bcH2m0dy
 EWmfdKj9Sf5Twx/lYjSjQamPByN7QCRw4W1N1UY2sN4Fvl3bB6eXyo2QDi2jr3p3/yI+
 hWmyJkOFglsHkF0bQSzL87MFRko02gjcQHCSA1tCJ0zLqZPYQXOPpAOvteBNcSbajJKR
 EooSHISe/PCPw/Y2z7Dthd3zuSfY4MTno0LaL2vA+DCxc1EnLcPK43iDB7S65Ke8Vc6r
 N6wydI4Eu/8r93fVGvZBh6eGdoN1lyoW+50Md4OaeiWGW0by+AzJiOIfIfxHjZwkbgG/
 3WsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtx+AczbZ93ZuZ5I4GUHHdBJmmtVkml+P5FI5U/97GyTihMWwQUljjVKDZ4x6OxA83wyIVlF20ghU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yza35vq9ivZC3xlaIWQ4dQEcRXXfcxWibQKFMa/W8JmKPvz9gkY
 wozArDokFbMMvCT8ThLWj/V4DFEQ32aHT3TD6/Nx9CRLe83rMoEbvKNpOwwd8y/nnx2E6RUckoL
 L41Q63HmBQx9OBoQwR1ffPsoGq+1S/W+y3Znv0DMaLziKwbNmeTZicr8hoB6X55mYTaeiK/Pqqa
 9kRHMbSJf0rqIfIaMNdrY0ypW8W4A0qfNnDVsmNdxw+MSm
X-Gm-Gg: ATEYQzx0JshNkFa+d8p2ODX0BVETfutAsRY4s8B6l0pzZkpRAfjhqjcrUpErtHK4XzS
 4qZEMK2FWrQB27VpnC0CuiKxQPtAd55jOarlcqhPr0y4gLvVLWVqvsz07qDiyhB/qz1GvmQMie4
 wVNfdXQe3L5Tbf8IOv2wph0sVzPlleTz7FS+9Xdl4nSyGyjuAvMOxfl4qmsyjPJ8Elt3gtU8gjr
 GGQrA==
X-Received: by 2002:a17:906:c112:b0:b98:36cd:7e14 with SMTP id
 a640c23a62f3a-b9b5095329cmr217770966b.42.1774624675986; 
 Fri, 27 Mar 2026 08:17:55 -0700 (PDT)
X-Received: by 2002:a17:906:c112:b0:b98:36cd:7e14 with SMTP id
 a640c23a62f3a-b9b5095329cmr217766666b.42.1774624675436; Fri, 27 Mar 2026
 08:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
 <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org>
 <20260321-awesome-hot-kingfisher-5d9f55@houat>
 <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
 <CABx5tqL+G9i1ZW7i5AHaTqUFTVRDmBvP=RycUdwjG-GOp4uzBA@mail.gmail.com>
 <CANiq72=M3H-06L7udG_LqTwLykZkAjfy2d5NXQZn5TYRJ+N37w@mail.gmail.com>
In-Reply-To: <CANiq72=M3H-06L7udG_LqTwLykZkAjfy2d5NXQZn5TYRJ+N37w@mail.gmail.com>
From: Brian Masney <bmasney@redhat.com>
Date: Fri, 27 Mar 2026 11:17:41 -0400
X-Gm-Features: AQROBzDgpgoaKrafOSYhxekTKjnPTVIaXvtE8lmpvFqxHDMdDYL6dEArDWvsT-E
Message-ID: <CABx5tq+TdGvL+SCUe87qWFgeAq-1Zf5w63jn2hLe9+YTyz4sNw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Michael Turquette <mturquette@baylibre.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Drew Fustini <fustini@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
 Michal Wilczynski <m.wilczynski@samsung.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-pwm@vger.kernel.org, Boqun Feng <boqun@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xBXxyX4aaOLBoLLIF90APxVN5fEWy5qD5a8F_U7PCc4_1774624676
X-Mimecast-Originator: redhat.com
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

On Fri, Mar 27, 2026 at 11:00=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Fri, Mar 27, 2026 at 2:19=E2=80=AFPM Brian Masney <bmasney@redhat.com>=
 wrote:
> >
> > Stephen came on the list and started to merge this things this week. I
> > was going to collect up more patches for him if he wasn't around, and
> > intended to include this. However, since he's starting to collect
> > things, I'm not going to send him a clk pull today.
> >
> > It's up to you if you want to send this in via drm-rust or wait for Ste=
phen.
>
> I guess it depends if he plans to pick it up this cycle or not.
>
> If he doesn't, then it may be best to just go forward with your
> Acked-bys -- Danilo can pick it up if DRM needs it in their branch,
> otherwise I can pick it up.

I am not a clk maintainer, so I can't leave an Acked-by for you to
pick this up unfortunately. I've been quite active in the clk
subsystem though the last 6 months or so.

Brian

