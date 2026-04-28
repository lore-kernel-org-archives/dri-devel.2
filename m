Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA85EFF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 10:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C55E10E316;
	Tue, 28 Apr 2026 10:11:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mYIQSHyp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAFF110E316
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 10:11:46 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 999604446A;
 Tue, 28 Apr 2026 10:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA596C2BCB5;
 Tue, 28 Apr 2026 10:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777371106;
 bh=uUVYRe/SWz7CWkhpaj4lEG2QqReNvGmhl1Bi48ffDwE=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=mYIQSHypxmjuY9JVRb3hTHlbE2NTp6Ym1U26aqZZMnLUIYaneKvzVeqo5G9bUcY2j
 gidiGDIhLUpKl1WZVpicI/s+lm9MNpoRKN2NzvYCfif5yRyMjZkJv7UGAEmf3kNDKu
 fQAgr0Pe6hNLI8OCaZA1hlZJ7vKOiyXroAoVS8TNLPj+HU4oBRw9YecYWEUHigZ8aZ
 nr449W5q6W9qjn6Cnc5qBRtuw81R/E/U/p6WbPPD9+suVuFh1+W5NKBaH2ejoSfWRy
 zSTZ2nCrGHSGaZwbvb1lkhaCYDiMQL4GBvY3I+UbAfHtV+n4aE8kySKH0TtOmmCeVn
 a9nct9/Dr6mMQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 12:11:39 +0200
Message-Id: <DI4PGYYYTNER.BD7J0XRD0BT9@kernel.org>
Subject: Re: [PATCH 06/24] rust: pci: implement Sync for Device<Bound>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260427221155.2144848-1-dakr@kernel.org>
 <20260427221155.2144848-7-dakr@kernel.org>
 <DI4CB68NZI8P.3RA6M7P8XRII4@garyguo.net>
In-Reply-To: <DI4CB68NZI8P.3RA6M7P8XRII4@garyguo.net>
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

On Tue Apr 28, 2026 at 1:52 AM CEST, Gary Guo wrote:
> Given that you're now implementing for two ctx marker types, it might wor=
th changing
> the existing one to spell out the `Normal` explicitly (also saves you fro=
m
> having to spell it out in the comment).

I don't think this belongs in this commit and I'm not sure it is worth crea=
ting
new ones for only this purpose.

> It might also make sense to write a comment to say that why it's not the =
case
> for `Device<Core>`.

I think the documentation in [1] explains (or at least implies) it. Where d=
o you
suggest to put such a comment? It seems a bit repretitive to have it for al=
l bus
devices.

[1] https://rust.docs.kernel.org/kernel/device/struct.Core.html
