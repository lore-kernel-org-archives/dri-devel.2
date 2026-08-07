Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC621C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 16:09:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C79B510F562;
	Fri,  7 Aug 2026 16:09:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S6z2TjSn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39CBF10F562
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 16:09:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D088042AE6;
 Fri,  7 Aug 2026 16:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB881F000E9;
 Fri,  7 Aug 2026 16:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786118968;
 bh=i5J2dRc8hhYNRdnFx6+Yskp3/ELg4aKmgxBRtJYEAoE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S6z2TjSnCFLG/YLFbH7dfeWGctTlmvPL2ZFHcW86esgiZaJyVKdJv9rWmzR0Aeek5
 nntjRpCf793bOBAGC5PU6596GIQy9x9fw/jyx5UgiD/lTFKuWMVtQBQuMvhmcqn1+O
 u3DoY6wcTN1UPkKcGSGqyNcJy6V1PDLOAtI+e0z5ghaCbuE7/UNNjpuYe/EZwsARlJ
 cxBMAzfKA7Cmk9TOUxvegOnIicZ9PXtg0/hmt94FxJDXQv1Donhga+TFx+s3CFAhof
 p7bijHhK8nsEGNHqUAl3NhXPEM8INqh2Nv5pewBDRJWQttL7q10mnUySjgkOb4OhA2
 WWTJk1tdIjflg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/10] arm64: tegra: Add VPR placeholder node on
 Tegra264
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: conor+dt@kernel.org, linux-s390@vger.kernel.org, robh@kernel.org,
 "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 devicetree@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, media-ci@linuxtv.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260807-tegra-vpr-v4-10-5510d16af89e@nvidia.com>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-10-5510d16af89e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 16:09:27 +0000
Message-Id: <20260807160928.3AB881F000E9@smtp.kernel.org>
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

> From: Thierry Reding <treding@nvidia.com>
>=20
> This node contains two sets of properties, one for the case where the
> VPR is resizable (in which case the VPR region will be dynamically
> allocated at boot time) and another case where the VPR is fixed in size
> and initialized by early firmware.
>=20
> The firmware running on the device is responsible for updating the node
> with the real physical address for the fixed VPR case and remove the
> properties needed only for resizable VPR. Similarly, if the VPR is
> resizable, the firmware should remove the "reg" property since it is no
> longer needed.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-tegra-vpr-=
v4-0-5510d16af89e@nvidia.com?part=3D10

