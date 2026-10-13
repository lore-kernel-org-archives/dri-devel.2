Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFF7CC6B19
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 17:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBC7910E80C;
	Tue, 13 Oct 2026 17:14:58 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC18E10E80C
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:14:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791911689; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LEUbPmrFFXDtibm9yP4sUR8lKhChibHMPgsjkBJaZp0Bn8BJ0VM7qHrepUd0ZGcJ+4tGxVHTZGfiiJa9X7Hu+rAxX6sHhQxaUb0EhQ1o86YZT6dkqMM274ROs6NkUO5LuujbH9EtLpdsEmOnltkU/Lb8k6zQ62GMaBQ3FTnGLdU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791911689;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ooJLDxSCJEcVNbGZxg1axPiit16FO3fuMRpP0KRlDPk=; 
 b=SkHzPEO07ayq12RR3CekkEHgsVq5BMU3Nk5xwKaDeJipRDEhMnmPLGmY6yzbm928ZOSGqy7xMJu8Mt3Gh2YqMqlSaYdclNSVOk+a8by9VqEc2CvqXKlniNzbKyL79ilXu6DwTf3zdyLA+SwLZIwOlJUYzA9hxVW4yfaryFuQ7ck=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791911689; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=ooJLDxSCJEcVNbGZxg1axPiit16FO3fuMRpP0KRlDPk=;
 b=L2snzBiwFRm2Un298G96nKH8dJJlCKmxondKGHWWovfCxW19Q9t75c2+DNbUymRi
 lUFE/oGR6g17iOLdARIo4IlhGOeotfdA9y380MiIEFtE8t4DcC931MmVyL/ZOE9XHkq
 FraynjClPudlBUeIfmeY8/sv9c3Lp08dzOuyZgPU=
Received: by smtp.zohomail.com with SMTPS id 17919116876531023.9332615568634; 
 Tue, 13 Oct 2026 10:14:47 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH v6 6/7] rust: clk: add `ExclusiveClk`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20261013-clk-type-state-v6-6-a5e9977b3509@collabora.com>
Date: Tue, 13 Oct 2026 14:14:28 -0300
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org,
 linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Maurice Hieronymus <mhi@mailbox.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FCA1D99F-AB7A-414E-AF99-BCCDF2B54FF3@collabora.com>
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
 <20261013-clk-type-state-v6-6-a5e9977b3509@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-ZohoMailClient: External
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



> On 13 Oct 2026, at 14:07, Daniel Almeida =
<daniel.almeida@collabora.com> wrote:
>=20
> Some drivers derive their configuration from a clock rate and cannot
> tolerate the rate changing underneath them. In C, they claim rate
> exclusivity with clk_rate_exclusive_get(), after which the clock
> framework refuses rate changes from other consumers until
> clk_rate_exclusive_put() is called.
>=20
> Add ExclusiveClk<T>, which takes a Clk<T> in any state and holds rate
> exclusivity until it is dropped. ExclusiveClk::new() calls
> clk_rate_exclusive_get(), and dropping the ExclusiveClk or calling
> ExclusiveClk::into_inner() calls clk_rate_exclusive_put().
> ExclusiveClk dereferences to the Clk<T>, so the rate can still be read
> and changed through it. Since a Clk cannot be cloned, the ExclusiveClk
> is the only handle to the consumer that holds the exclusivity.
>=20
> pwm-th1520 is the first user, in the next patch.
>=20
> Co-developed-by: Maurice Hieronymus <mhi@mailbox.org>
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>

Maurice, I changed a few things in the design, so I took ownership with
your co-developed-by tag.

Let me know if that works for you, or what you would rather see instead.

=E2=80=94 Daniel=
