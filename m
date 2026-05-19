Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7593CCD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 17:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEF0710E3CB;
	Tue, 19 May 2026 17:27:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jwVfu29S";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AD5C10E3CB
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 17:27:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5D32160216;
 Tue, 19 May 2026 17:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC5BC2BCB3;
 Tue, 19 May 2026 17:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779211675;
 bh=KBC3Nc4aH72MDDN7wEUpqS9TMs92M6VFHpdyi/AgL2I=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
 b=jwVfu29SblsG+4P+aBXxO13QJS40NiLgL8mIXyl4UEhXpizahXky04JFQtE1jdXm1
 KcmoWZXj/8EQx2z5HvWz2Y31jSxHGvxx2LT8p1pd1kkkoZq62V47RYGYHYyOEjo2LE
 Vv+Sw7MdeySOwJlJCye/ombzPr6lwUTRFVSFxGKyQchG7gtZJnK3mbvsnx0lRgALQq
 JEiPS+ZG7Z+PVFQGEdrd4cO1b6Lb5O6rgTnM9rGi3SFjL9GrNPyEkH8TEJuOAeFTpN
 QpXh+mizIZH72OjwMIjOqaaOv7nrO39VjZvFKptfuiQUD9buI0kHXKn3r7lCAIl+jy
 C+7fSOwjTK/NA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 19:27:45 +0200
Message-Id: <DIMTWBHV9E5I.1X2L8UNUWLVT3@kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 19/27] rust: pci: make Bar lifetime-parameterized
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
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
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-20-dakr@kernel.org>
 <DIMSJVKTYX6D.AEN6OPPC2898@garyguo.net>
In-Reply-To: <DIMSJVKTYX6D.AEN6OPPC2898@garyguo.net>
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

On Tue May 19, 2026 at 6:24 PM CEST, Gary Guo wrote:
> Either way, I think we probably want to limit `'bound` to cases where it'=
s
> actually `'bound` and not some possibly shortened lifetime.

Agreed; [1] for reference.

[1] https://lore.kernel.org/driver-core/DIMTSQS1HZM9.326ZOXFP6PV5J@kernel.o=
rg/
