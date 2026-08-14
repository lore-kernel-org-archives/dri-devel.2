Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33353C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84D7310F68B;
	Fri, 14 Aug 2026 15:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LEwKJOo2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAA3010F68B
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:36:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6989C40BC6;
 Fri, 14 Aug 2026 15:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15F51F000E9;
 Fri, 14 Aug 2026 15:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786721792;
 bh=M4r3BwoQNU9gLVTSw353pUvHGkJPqya89SGYxrJkN8Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LEwKJOo20dfoXM6ZnoeQzTjxOx/CMySwRDV/wSeWHs2YZ3x0hAsRVTAm1XNl3qttE
 vIM17Z1GPuQ1+YjGohRCsvHCv8qvxsyR0dHIdhZ3MLsCak2Bmh/HFHdd3IOlnWjqHa
 9Q+g+apqewfhLviHCBr1dCLoSw61OLkvn3afvuqQ+JOrGQr/qlo74aPyPlMlvFy7FY
 ZYAWG45EnO+5zhMiNeuiCDl6avgXhwAKhFQeaLpUy+R2A4DGl/E2Qw0y3ceYlzh/j1
 JEf8W5JQn4MCaPLw3RAfC0LsY4BqxicbP6iJEGLTOeeSYflpsRFtQdOnBhvxXjVk+a
 Rg488B8fW5IUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/10] dt-bindings: display: tegra: Document memory
 regions
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org,
 conor+dt@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 devicetree@vger.kernel.org, linux-s390@vger.kernel.org, media-ci@linuxtv.org,
 robh@kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260814-tegra-vpr-v5-2-71832b5d0246@nvidia.com>
References: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
 <20260814-tegra-vpr-v5-2-71832b5d0246@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:36:31 +0000
Message-Id: <20260814153631.B15F51F000E9@smtp.kernel.org>
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
> Add the memory-region and memory-region-names properties to the bindings
> for the display controllers and the host1x engine found on various Tegra
> generations. These memory regions are used to access firmware-provided
> framebuffer memory as well as the video protection region.
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-tegra-vpr-=
v5-0-71832b5d0246@nvidia.com?part=3D2

