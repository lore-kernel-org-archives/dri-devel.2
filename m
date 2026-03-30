Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E846FB3CFF
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 10:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D022810E5DF;
	Mon, 30 Mar 2026 10:27:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hHwk2xGN";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BAC710E5DF
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:27:44 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-124b07e5fe4so142958c88.3
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 03:27:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774866464; cv=none;
 d=google.com; s=arc-20240605;
 b=j4cI2v/TJDYhyZ68gEx51Izvc36dTTIzgOnncu5w2aCaxvdCQ0v8BauYk8MgcIwJn+
 HaAKrjBBgeXvB+Xl/c8cWIUQZcoGmk0alb/bUNRY0Wn/Hizfe3fG0TDIxBVWG8nXb2v2
 CNXyNh5gOV0ktdYRztOukOrPFsf2bujbNBB2m6wLPBJiMgo/1yOXcK/bonPkCKZGckAg
 BlC9YS94gzXd9ItEaqYnPynJC+GOFwTvKpt+tSN0UAjRCnQWtFYjvPRkWlWu7X6kTyx/
 0L9tyG3++yZ1/WXl8e5oLekz1lN0cMnKROZQlf2d6Rc+JQ1mJ3XxqA+C+nzpaVdeq1T+
 d5oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d9y55bKppxCwu8kQEd9JuS1z3KUYYcK2BoJdPrGox3E=;
 fh=Iietp32vUDJFSVF45OkIFaoLJv0yobyYpuK5QNwCypY=;
 b=O2293Jlv2MPqUATk75QPMQ/iudnRUwRonBe31EysUYQR7MEp0UiR5fZXSNCeTNO8Rt
 45JFyT3O3NKkMhSmZ6O8i+Aweoe+y7rvn9Y73u8ahw0ZS2sPKIONI0qFV67FCaXuxTuf
 7f6UDbGokjBd52MzUB/YVvh+jHKOR2vc17BS+Ca6T8JWzfRKJbNmo4R9xyw829yXrPV3
 JAAUXs9iAkS9V1S4MxrXwX3uTSDGwzniy/z9IkT5Dv20HPZZeH35rcqGN0K3w+gYY+vM
 bIPLkk1OqDyYePyvyUDdwx/YgUpGzHe7x5evndYbVgQMBVK8cRjVI12QFKL8ZjyI8pu1
 uIvw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774866464; x=1775471264; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d9y55bKppxCwu8kQEd9JuS1z3KUYYcK2BoJdPrGox3E=;
 b=hHwk2xGNpk80U3j67dhWnhu7/whDC6Yus8YavAerSUWUy/YEUskr58A7jqTYYG+YwX
 MTM+VBXl4IG8i6QJfFambFkNZbTstaziv4wC2Pho+kI/DQiE23SEunpCPHwHWQ9SeewY
 W9OlVa/Z86K6noVxaxZI4hjBz5JJWDSj938T/UFsEJpaBjwQZlbQNd+iI88WzH9Gm9aO
 Qcp0CoEW6/PKacDdx5WG1jXPGRoOeqRc8ExWOtNDu5GQXdWj84tx15gZS1G4KMvGnFxz
 i0p9+AlDRDeGcxKY7PzwuY/YkUXLAVIDafEfQdvtP4CQeBCseawl9p9o0ygeDRcteOKy
 IVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774866464; x=1775471264;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d9y55bKppxCwu8kQEd9JuS1z3KUYYcK2BoJdPrGox3E=;
 b=tNO/MgcCN007hYDFkDphwry0h+PxOW55ndhzOVpAYecNW2mQT7kpOK6nXC7h/SSyCq
 draECrVybLMHspTIlMhNyxVXnevln4DWDEAVKe13Dk2Xq8zivSqRHHrpqzqutmFbfls6
 cG5FPSumRgk0ceEhgEBuKH0oJYGn9Kcy19Fp6E8LGXdLjikOMx65dGMe5sZM/vS6mUH9
 gLfwzH1XcOB3P83mnG6p5fC73CUnvJLxNv5x4Ljrpn3kj64xdyJlC2Pqcb8baO3DmEwD
 zGRynFXPPUOCOJK0R6HDsR3Gw9+A8rUo/KhJKkhRgaEY+z8mq8FMFkJ3q9DZAtG+9RgQ
 ZKIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeTmCSfCYSxfgXjE9WxBJuRMVEgatbzg8dLrLTcwgNS7Y/SSSWfrjX7fcYNLruHiO9qwsG3m5luIg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx5B4eMudafaRH9MhdKQT5hvBP2ZhhFS2MQk/wDErqoE0YwOveP
 TQ8W4KUtl1YFQdxf6tScZB2iDenZJbTcPTzZ0Qder31IBPMHS9GSqcp7fMJzCfmali7JxyAoxpT
 ycC49lq20FGU8DjXwG3dBe0xiQgXOCQg=
X-Gm-Gg: ATEYQzztN8g2tJlFjqDNN3d4zhSV69/KhKjU6cGYlqljbtvEf1QLxTu/V3npdQlRQn2
 8Fq2SPhs33TO3dcmIqUYXkFNVvWgwE73mWybzB+RuUOxEmanyLJiaegAx4qn1A4bVDQw44DX9kQ
 zElJxa3lpF+TvnHcwfjTsESLRLOjvHz+HwUTBSRP3NWwM55lT88Xapjj+FsvcGZv4gz5UKhdBXx
 kvlyQ8K1WgG7VR1eB1J2/8yNgaQSELM1t3ZRloMq3JVb1oYqG291jRFnTm2wY5FlMixIoRBWP1H
 FNncVoxbrvhpc74Bsb/PSVcSKPCfB/LntbWfpDzwN9+pgBWvYoyHyadBzqyv/g+Kz558Vn9HGER
 9qqp+WGiUMDcr5mL3C/aEroo=
X-Received: by 2002:a05:7300:f794:b0:2c5:704f:7157 with SMTP id
 5a478bee46e88-2c5704f7c1amr684174eec.2.1774866463645; Mon, 30 Mar 2026
 03:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
 <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org>
 <20260321-awesome-hot-kingfisher-5d9f55@houat>
 <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
 <CABx5tqL+G9i1ZW7i5AHaTqUFTVRDmBvP=RycUdwjG-GOp4uzBA@mail.gmail.com>
 <CANiq72=M3H-06L7udG_LqTwLykZkAjfy2d5NXQZn5TYRJ+N37w@mail.gmail.com>
 <acoq7E8NH-ihCq1K@google.com>
In-Reply-To: <acoq7E8NH-ihCq1K@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 30 Mar 2026 12:27:30 +0200
X-Gm-Features: AQROBzBw2zE5e8wBGjGUmjeI3w5sXAYU-mC5MJEbQZIxPhWtE3tBZZKIxgdi_Gk
Message-ID: <CANiq72=b6bFQ=OFEXMedO1JoL4qckRmTPYzFrXGCzgxZZOmbuA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
To: Alice Ryhl <aliceryhl@google.com>
Cc: Brian Masney <bmasney@redhat.com>, Maxime Ripard <mripard@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
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

On Mon, Mar 30, 2026 at 9:49=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> The drm-rust-next branch has closed now that -rc6 is out. If we don't
> hear from Stephen, do you mind picking it up Miguel?

Yeah, I will pick them -- I talked with Danilo about it a few days ago.

Cheers,
Miguel
