Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAAECD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 19:38:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CF7D10E551;
	Mon, 11 May 2026 19:38:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NlsSeWZ3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB78B10E8A1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 19:38:07 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0320C600CB;
 Mon, 11 May 2026 19:38:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB69EC2BCB0;
 Mon, 11 May 2026 19:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778528286;
 bh=v3ZaN4VpL9Hl5zsxFJzl0kBDXKiuushsUjMXH2kS3gY=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=NlsSeWZ39A92JT+IPpgrVDN8forOFX9Ii2YOYc3OKiFZ2aXkvMP2Mc8d/ZKldK2XL
 MtYFPteH3Zfepl6bdeD3byk1HgXqrSLiqPNpG+8MPC0CVMUYSHaSI7vkYEU73sbPJi
 7R0wbX9d1NsdvPYZSASU1LzC0NCdHVEdIME9R888lhamQr6/Rg87lyfFqcigSHuJys
 3atWaMuB+bTHvH+eCNJyi6jhuYrv0I+lV0tfEN7NUFVJovCQBmDlfr0TMp7SE7h673
 WKWuWTBBgr90ru53k+HpiUi1xWg57PYjdWsheWg9J1b+2XBKIrqYixQt7BwoQtUrpZ
 o03baRFxA+pCQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 21:37:59 +0200
Message-Id: <DIG3NO2QSP5U.2A5UCM1DYQ3ZO@kernel.org>
Subject: Re: [PATCH v2 04/25] rust: driver: make Adapter trait
 lifetime-parameterized
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pm@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260506215113.851360-1-dakr@kernel.org>
 <20260506215113.851360-5-dakr@kernel.org>
 <DICFXB4BLACF.3GTAQPRYURQCB@garyguo.net>
In-Reply-To: <DICFXB4BLACF.3GTAQPRYURQCB@garyguo.net>
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

On Thu May 7, 2026 at 2:24 PM CEST, Gary Guo wrote:
> I applied the following diff and it doesn't require
> additional transmute?

You are correct, this patch isn't needed -- at least it is not needed anymo=
re,
it was at some point during the implementation of this series. I will drop =
it.
