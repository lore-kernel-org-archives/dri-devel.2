Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1421DC624C6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16AA110E393;
	Tue,  1 Sep 2026 09:21:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K/VCIBHW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 168F110E393
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 09:21:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F054D601DE;
 Tue,  1 Sep 2026 09:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D638F1F000E9;
 Tue,  1 Sep 2026 09:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788254494;
 bh=/tZHkUlwdSISi5MyQBg0Km9NujEW/9lk5PJwr5sbh7E=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=K/VCIBHWA2t8P5IJ8hcGIYi4QmT6lkyrp9mDjv+1X48yoTIjv72N875msAHTJoGfp
 9PRP1ThkDcm1YAlsInZvU8RQJzSQ8Dq02LP5jFzkLfCHQ/3pQBhNSH9am6QxEa3E4N
 jHWu0b8HJ3jOFbkPUHxNpF5KVnizyOn5ytWmfUpLlVaJFV5CJ9YQPYfAowCL+tQ18o
 ShkZmozyvxCmtBAcztRF04+qCpHmp/hq1PWy7vEdYKpUPQPmg8wH7Q73LMvBZ8V+Mz
 Ydr7aKRW2rfdncJYxCi7Z39NcRpMOqXSqoUE7YJ9cuBngYjw0F9peQUBQYfhCmjkim
 ekxAwZXrN305Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 11:21:30 +0200
Message-Id: <DL3VB7MC42DA.1I87BPBGNIVR4@kernel.org>
Subject: Re: [PATCH v5 01/11] gpu: nova-core: Add public driver API to
 nova-core
Cc: "Gary Guo" <gary@garyguo.net>, "nova-gpu" <nova-gpu@lists.linux.dev>, "M
 Henning" <mhenning@darkrefraction.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Alexandre
 Courbot" <acourbot@nvidia.com>, "Benno Lossin" <lossin@kernel.org>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-2-apopple@nvidia.com>
 <DL3EGE1IY4FL.3X49WKCS67UT@kernel.org>
 <DL3F6EKL2F6Z.2DRXPQLYLE7FM@garyguo.net>
 <apZ3_o8hxlMr6SoP@nvdebian.thelocal>
 <DL3SM4UA1QC5.3KA2M1DE6F0F7@kernel.org>
 <apaVyXAV7GvE6_ld@nvdebian.thelocal>
In-Reply-To: <apaVyXAV7GvE6_ld@nvdebian.thelocal>
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

On Tue Sep 1, 2026 at 11:13 AM CEST, Alistair Popple wrote:
> Reason it compiles is because the the Gsp has no lifetime parameter in th=
e chain
> to the mutex:
>
> Gpu<'a> -> GspResources<'a> -> Gsp -> Cmdq -> Mutex<CmdqInner>

Ah, that's on me then, I applied [1] before your series.

In any case, I think we should not write all the code assuming covariance
regardless. Once we do some more series stuff in nova-drm, we will need mor=
e
locks in nova-core around types that carry device resources.

[1] https://lore.kernel.org/driver-core/20260830193824.471089-1-dakr@kernel=
.org/
