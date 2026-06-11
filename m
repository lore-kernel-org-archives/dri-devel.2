Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65560CD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 17:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEFAB10F043;
	Thu, 11 Jun 2026 17:31:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DzY9zR4B";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95A2510F03B
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 17:31:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0412A60142;
 Thu, 11 Jun 2026 17:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6121F00893;
 Thu, 11 Jun 2026 17:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781199068;
 bh=D3wtnpbbGlx7KMSYmBphPEdhLc2D/VXWZwWPFr8KSMY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DzY9zR4BlsFfgvZrdY10kgT0VmgxOKWT67Evq+bl2vpVHRZ7XQ3+4WcDVhe5OI4Jb
 xkGpFHiQ0rPSDwWp2oxOBjCM6jG9ZD2Wr6SRytt2D/QJqHBREGf1g6jy8XjgdCf4yU
 zCoOCuVTcNRPHS0gKTGNayRONIGp3AADnZ0RRfKR+QGqy2MQBac51Bqu5Sdjz8pvO4
 CPi3VTKyBeInohual6yujrYfoxVz0X2heDF7jS3YFqJt9YTzqaH+q0Vtyt+ksr1rek
 xkdL3ViyQ8KXp0dh4XhYrcq4YrzW06JDHbHRO4Y/w+Zes2rTs3aEDXoR95REp1mYAz
 IF6WAvZk2rviQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/20] rust: io: implement `Mmio` as view type
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, ojeda@kernel.org
In-Reply-To: <20260611-io_projection-v4-7-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-7-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:31:07 +0000
Message-Id: <20260611173108.5F6121F00893@smtp.kernel.org>
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

> Implement `Mmio` as view type and convert `RelaxedMmio` to view type as
> well. I/O implementations of `MmioOwned` are changed to delegate to the
> `Mmio` view type.
>=20
> All existing users of `MmioOwned` in the documentation which do not
> actually reflect the owning semantics is converted.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D7

