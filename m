Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C63710F2847
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 15:42:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0978310ED16;
	Fri, 27 Mar 2026 15:42:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sOBZ6IJg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADDAD10ED16
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 15:42:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 94CD160127;
 Fri, 27 Mar 2026 15:42:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AEDC19423;
 Fri, 27 Mar 2026 15:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774626171;
 bh=N5QspxPejw9w7zUpfqwNJA5lxWidOkYMOUOW5hyNY4o=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=sOBZ6IJgRdrDctxoaRi9B4+iVWwtU8840GbGAX2CiFIFvRyghghoZqzAvmBqnDYza
 nZUsXT0OkOdN2YAvgAf5Xpwy7K0EHAR6wn/yr/Q1IamnDB3Bgjn1198pUj6FEJenGg
 rhu2EPCmAwKg1mcsC8H7nl6WAWB4mOYhAc2Otu2bgexuMOyupuFmQRAjal5sYDeAtc
 0up4UCvSb2SJNM7ainpxfFQfMnVCeZVIgSbNnj9FongxWa5+0NJrGFN6sjHLjVDPD9
 lhkXEwQu31BAAjjTuu4Z/zxqE5aIsb3+LTZqLsQD2qj81A+OvPXPlTvnrkhap1KMEZ
 aojhI5ZJRtvNQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Mar 2026 16:42:44 +0100
Message-Id: <DHDOH1FXTIZT.1QKZIPZ73YNLI@kernel.org>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
Cc: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Stephen Boyd" <sboyd@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Michael Turquette" <mturquette@baylibre.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Drew Fustini"
 <fustini@kernel.org>, "Guo Ren" <guoren@kernel.org>, "Fu Wei"
 <wefu@redhat.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 "Michal Wilczynski" <m.wilczynski@samsung.com>, "Viresh Kumar"
 <viresh.kumar@linaro.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Daniel Almeida" <daniel.almeida@collabora.com>,
 <linux-clk@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>, "Boqun Feng" <boqun@kernel.org>
To: "Brian Masney" <bmasney@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
 <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org>
 <20260321-awesome-hot-kingfisher-5d9f55@houat>
 <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
 <CABx5tqL+G9i1ZW7i5AHaTqUFTVRDmBvP=RycUdwjG-GOp4uzBA@mail.gmail.com>
 <CANiq72=M3H-06L7udG_LqTwLykZkAjfy2d5NXQZn5TYRJ+N37w@mail.gmail.com>
 <CABx5tq+TdGvL+SCUe87qWFgeAq-1Zf5w63jn2hLe9+YTyz4sNw@mail.gmail.com>
In-Reply-To: <CABx5tq+TdGvL+SCUe87qWFgeAq-1Zf5w63jn2hLe9+YTyz4sNw@mail.gmail.com>
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

On Fri Mar 27, 2026 at 4:17 PM CET, Brian Masney wrote:
> I am not a clk maintainer, so I can't leave an Acked-by for you to
> pick this up unfortunately. I've been quite active in the clk
> subsystem though the last 6 months or so.

I'm not involved in the CLK subsystem, but maybe it would be a good chance =
to
offer stepping up as co-maintainer (also given that Michael seems to be ina=
ctive
for a couple of years now). :)
