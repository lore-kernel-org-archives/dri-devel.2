Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B12CCD5BA4
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 13:03:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 623D610ECCD;
	Tue, 19 May 2026 13:03:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZFAci2d8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9217210ECBE
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 13:03:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BF52660126;
 Tue, 19 May 2026 13:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FEEC2BCB3;
 Tue, 19 May 2026 13:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779195790;
 bh=+C2REwytvDpqdC7fpylSr1kFZZwJ6+smFl9XkzZoNGk=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
 b=ZFAci2d8oxkEgzfKQypntDGC4/3sOl/EZD/Cif7IJcuE7YJmmxxvopoVOP513Ofvs
 YqZUHh6U76CV6qrXtkZmNjzwIC+TqPB/8rn1VBqRcmhDD6BuAREpNZhWHyaiV0ntSA
 EEa2w+3k32v9tDTHdL/35qponLjn3dwNCS+pWF/LekRMX/aktpdkLIlUYU8q3eWATc
 CTcujhS70SxHn6HZQ6zFOLTQ0QvyyhRJmPj3zyE2XiTzL7nCJ3J4ozxFuJnBCGei8O
 QUoBU8WAwJ347ud+tCTWDQab54U41ELMrzpY3F1iyjs7+E1rWk4Ni+0+jsd8zjgRj8
 EOFP+ednMG2HA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 15:03:02 +0200
Message-Id: <DIMO9MW468B5.2KSIVYEMY31YF@kernel.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 16/27] rust: types: add `ForLt` trait for
 higher-ranked lifetime support
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-17-dakr@kernel.org>
 <DIMLSVG1IO07.28UMFL4GTCQG4@nvidia.com>
 <DIMMHPLUV2LK.39WF9SGO8TLK5@garyguo.net>
In-Reply-To: <DIMMHPLUV2LK.39WF9SGO8TLK5@garyguo.net>
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

On Tue May 19, 2026 at 1:39 PM CEST, Gary Guo wrote:
> Danilo, what do you think?

Two thoughts about this:

  (1) The blast radius is bigger than just auxiliary device registrations; =
this
      pattern is applicable to all kinds of registrations that provide the
      guarantee to be scoped to the bus device being bound. I.e. it is true=
 for
      any class device registration, IRQ registration, etc. They should all
      support HRT eventually; there is a subsequent series where I started =
to
      implement this for DRM.

  (2) I'm not concerned about the UnsafeForLtImpl approach, as I think for =
a
      human one would really need to be willing to abuse it by intention. I=
.e.
      it is not really different to just using unsafe {} while knowing not =
to be
      able to satisfy the safety requirement.

      That said, I expect LLMs to be (heavily) used to write drivers, and L=
LMs
      are typically trained to be compliant. So, I could imagine that a pro=
mpt
      along the lines of "Can't we make this work without unsafe somehow?" =
leads
      to an LLM abusing this, while going unnoticed for the user.

That said, I think that requiring define_for_lt!() wouldn't be that big of =
an
issue; the number of registrations per driver is rather limited.

Besides that, considering (2) it may actually address a practical concern.

If you want to make the change I'm happy to integrate it in a v4, otherwise=
 a
follow-up seems reasonable as well.
