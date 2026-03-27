Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8526210F285E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:39:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E93A910EF32;
	Fri, 27 Mar 2026 17:39:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="YrHMNSYj";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 842CF10EF32
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 17:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774633149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GhPdolAuW7P0xgBhYuWJf3nGp5Pv13lQ9qoFlr8i+xY=;
 b=YrHMNSYjaWo8QwzVuju9pbfftecgjCE5YyPd4ymooJ2yAdlMRnPjQAnhf7vx+OnmaySLE+
 kSkyP8qGvo20+lJz7gumuCVZZdeb0i9raWPrd0Lf0L/s21K3QPxgQLA4nIHL8KWIOxZ5uC
 s/FwYV1dyQKz+KOnXFytXIA+6qw9ntU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-5Me6B8h8PE6DylKtYWp-UQ-1; Fri, 27 Mar 2026 13:39:08 -0400
X-MC-Unique: 5Me6B8h8PE6DylKtYWp-UQ-1
X-Mimecast-MFC-AGG-ID: 5Me6B8h8PE6DylKtYWp-UQ_1774633147
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b97f04b44b9so133822466b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774633147; x=1775237947;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GhPdolAuW7P0xgBhYuWJf3nGp5Pv13lQ9qoFlr8i+xY=;
 b=ICm7tIQf+dd7barwVWT1NgW0qHnp7tPVG+LGBAFAnNoYjpVyJtHZq0HCXa9mkRxodI
 cOotbtqgEIF5sE49P5DPBHMX9msmcdIP6RIDkCTS54RSpeKxyTjZ7+o7d7qpa+PCogBB
 zjpLi1UH3LVuUwtTlH4V4Pt4ImbQh12WmuVtGzwPD5XXSPIp7+HDqg1GfT9q3Sx76S7B
 qR5AnNhlaMMOkC1Lp/SMA8/vTf5ogXndD9G0cwJX24nKHJu/wva94i1CJxTXHkEL4WVG
 UtzgG03EmsvCqtLh+ofmHnw8XgnBHVzA0Bbzstk2qCQ/wpQE0j0CIN4fXob1RC438UYs
 JdYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6BPnkF/J4Uq1tcW33rHbLpmpTsxqkgwdlhExn8FdacELtMjkMcYgJ4T8qTuia3JabMYSZ7IjR0Zc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwilgkGqnf6LRU1brNSpiCGXP1d5nw9PBwixrt+270B8vsupTzf
 4MUb6KGkM8tUbsQf0XilI5JgZVZbmthLsKuQhdKQk7tGKUxOwG4dyguqFPdJFhk5B2Xcx+dowyV
 NetDnUgZQpbYxP36opPnaPPxyyiHz/IjVrNi/udGqNIIlfRK5FovO04kFxp1Pjdgrtf6KUx1VUV
 ykdETK4O91VQmGk6L/6ZKCWoSrfsj4cULrwAIvfs/EydYi
X-Gm-Gg: ATEYQzwlWdx+tvWOId/kQ3sZp0Pg5OpeVIi7l26sVYpBE1afgnWpVx7zPPUXMzUfs8t
 lh5KmlgZ5Jc9gZV5dfczKEPzkhwYAn4hCpR4ZjhTKzKOyUci+ex21/o/bsSFS2bxVztQ2lPsCg9
 gd+9cwt9HNQeyoNnlAfzEskG0ttFtA72syf8mMvxZ3IXn9NnsWJ1BQpMQTZMp1erUNO/g9Iaz4l
 xbL+g==
X-Received: by 2002:a17:907:a28d:b0:b98:22e7:72b with SMTP id
 a640c23a62f3a-b9b507a7bf9mr218777866b.30.1774633146683; 
 Fri, 27 Mar 2026 10:39:06 -0700 (PDT)
X-Received: by 2002:a17:907:a28d:b0:b98:22e7:72b with SMTP id
 a640c23a62f3a-b9b507a7bf9mr218776066b.30.1774633146199; Fri, 27 Mar 2026
 10:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
 <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org>
 <20260321-awesome-hot-kingfisher-5d9f55@houat>
 <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
 <CABx5tqL+G9i1ZW7i5AHaTqUFTVRDmBvP=RycUdwjG-GOp4uzBA@mail.gmail.com>
 <CANiq72=M3H-06L7udG_LqTwLykZkAjfy2d5NXQZn5TYRJ+N37w@mail.gmail.com>
 <CABx5tq+TdGvL+SCUe87qWFgeAq-1Zf5w63jn2hLe9+YTyz4sNw@mail.gmail.com>
 <CANiq72ktmUFsdpBUKnU-OvTj7rE5iZKFucubL_1bF1Ws_KYXcg@mail.gmail.com>
In-Reply-To: <CANiq72ktmUFsdpBUKnU-OvTj7rE5iZKFucubL_1bF1Ws_KYXcg@mail.gmail.com>
From: Brian Masney <bmasney@redhat.com>
Date: Fri, 27 Mar 2026 13:38:54 -0400
X-Gm-Features: AQROBzB7WfnAtTWMTsWRSmdXifxpUbNDAg86GKrLb9ikVgnMGrHcwDI5L3K7rv8
Message-ID: <CABx5tqKKHvFPYrL=gjaOn+frDXfXpxM3-6oTzSo6QVgYMaEMPg@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: C8f6Bns7_6-GJ4xjyDqQGtSSFI8K2hhBPLOtJgdzcYQ_1774633147
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

On Fri, Mar 27, 2026 at 1:28=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
=3D> On Fri, Mar 27, 2026 at 4:17=E2=80=AFPM Brian Masney <bmasney@redhat.c=
om> wrote:
> >
> > I am not a clk maintainer, so I can't leave an Acked-by for you to
> > pick this up unfortunately. I've been quite active in the clk
> > subsystem though the last 6 months or so.
>
> In that case, I could take your Acked-by as an active contributor of
> clk if you are willing to provide it, i.e. with the "# Suffix"
> notation I introduced a year ago:
>
>   https://docs.kernel.org/process/submitting-patches.html#when-to-use-ack=
ed-by-cc-and-co-developed-by
>
>   cd9123eeb224 ("docs: submitting-patches: clarify Acked-by and
> introduce "# Suffix"")
>
> i.e. Acked-bys can nowadays be provided by other stakeholders apart
> from maintainers, e.g. people with domain knowledge, userspace
> reviewers of uAPI patches, key users and so on.
>
> Especially so since you offered to be a co-maintainer long term, so I
> think having your Acked-by is way better that having no tag at all :)

Sure...

Acked-by: Brian Masney <bmasney@redhat.com> # Active contributor to clk

