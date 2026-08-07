Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7986C2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 16:05:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B481410E448;
	Fri,  7 Aug 2026 16:05:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jffF9L1B";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0294C10F55F
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 16:05:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B64B143D00;
 Fri,  7 Aug 2026 16:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C351F00A3A;
 Fri,  7 Aug 2026 16:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786118747;
 bh=S0SMr5hHf6De81dA2KYEJpkRtQZeFcGScVbJMtaRXhI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jffF9L1BmmP/5Hrzjr6cpxRvD+TwKy2wadSIU9kSouAp1K5IH0OMOfRvgxDuVFxlS
 KtZdTkuSWaWImcgNTYr4WdJkbp0CjnbuIheEnIgRmXIiLQeOngjkqtYWS0VkBkwuMa
 S0pdMFoiBak5OlM2Tuyf6QS+OiAaaxTJcbHydo0OAF+uKY0wV5r5olGQHv9448HV5q
 DezdrjBvlLa0qFrMn31K/QrpAwuHESmnR8DdtvO87+7i9celw7mFL5P7YL3KYVmg4y
 v1wpdGe+7ul55N6UBHU8k3hGe/bpa8o+4S4FaCryQ2qxNV8ur6TeawhLAkrmsCLexw
 QWuN9F1T3aljA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/10] dt-bindings: display: tegra: Document memory
 regions
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: devicetree@vger.kernel.org, linux-s390@vger.kernel.org,
 "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, dri-devel@lists.freedesktop.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, media-ci@linuxtv.org, robh@kernel.org,
 conor+dt@kernel.org
In-Reply-To: <20260807-tegra-vpr-v4-2-5510d16af89e@nvidia.com>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-2-5510d16af89e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 16:05:45 +0000
Message-Id: <20260807160546.61C351F00A3A@smtp.kernel.org>
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
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-tegra-vpr-=
v4-0-5510d16af89e@nvidia.com?part=3D2

