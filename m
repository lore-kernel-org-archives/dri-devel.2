Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4537C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30CE910F670;
	Fri, 26 Jun 2026 14:57:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T9dLExtQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB46710F669
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 14:57:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F7FD600E2;
 Fri, 26 Jun 2026 14:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36FE1F000E9;
 Fri, 26 Jun 2026 14:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782485837;
 bh=Drf5dNCTcFLdv+BRTeO4nFaAZ0ORjf3oaENDUs4oHWg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T9dLExtQVkxd3TdMkMcf4B9QUM3kUdzwQbLqDm1sEUS/Q/UzQHQZ3+mg4satDNlRM
 NpTUn9JGmRuHTlminfwPD30wmoIhe5enSHEwsh4usA7GPbxEx02wRwAS9I4lLtgTp6
 9DEETHMcEEX72iqmBArTFcE2JG+DpHHLcFdT26uMeIo3wD9fFXQXThUkoSuCaBPb9y
 ebaikb05lLGW3qDT/kofahzvhuigp/Ls6zZ9FSQfZo5AcCPYF4YzPawqeMuG5Z9Gsn
 zK3xedC1DZJLKBrdnbQu7lzzXjM8I2MmEhfScfeacbmwrjc4rD2k6aL89F4fajU8XV
 B5mhm589znUkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/20] rust: io: implement `Io` on reference types
 instead
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260626-io_projection-v5-4-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-4-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 14:57:15 +0000
Message-Id: <20260626145716.C36FE1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

> Currently, `Io` is implemented on owned I/O objects (e.g. `Bar`). This is
> going to change with I/O projections, as then `Io` needs to work both for
> owned objects and views of them. Views are themselves reference-like
> (however they obviously cannot be references, because they belong to a
> different address space).
>=20
> To facilitate the change, change `Io` to be implemented on reference types
> for the owned I/O objects, and make methods take `self` instead of `&self=
`.
> When I/O views are implemented, we can then naturally implement `Io` for
> these objects.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D4

