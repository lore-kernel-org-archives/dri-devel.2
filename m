Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DFCC61DD6
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FCF610E175;
	Fri,  4 Sep 2026 13:47:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Dyu6nehj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA1A310E175
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:47:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7CFC7404D8;
 Fri,  4 Sep 2026 13:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9221F00A3D;
 Fri,  4 Sep 2026 13:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788529624;
 bh=jrOd4Hrk+SVGKObt8qkwvbAXHOaE3Px7VkO0WQZppE8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Dyu6nehjd2JvJaJbiBkjcbMQogvSASDoqkHljYhLXcxKxX/9LLcV3Mkxtf2D+IkFI
 eGw4QLrGbEONJF49g1QW6dbGk23boud0dm/Vhv0oPNMHOoqyR5OiXW+t9uiDfZXQgx
 +uPeP3ui6daZZOmvkLxZRXjuLTR+24sOZb6Xt6pmxwSiHEbF40/TVTF/81n4CcOQeb
 I4GGjdbIbt9vsFnctyaWdJpa1nUoxXnUxKNDk1L2QE+HONC3FyrBAw+Z3nRYqmPcw4
 CtnEMMMoNp5Q9cXGs3SOK0I/6n5PFKPDCntLvti1OxoKCptzTkLiYj2kMOuzb/kXy9
 09GjtdzesRRBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/19] soc: starfive: Add jh7110-vout-subsystem driver
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 olteanv@gmail.com, lee@kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org
In-Reply-To: <20260904-jh7110-clean-send-v3-12-484f9ae72715@samsung.com>
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132731eucas1p182c607567520f7c6f482a9c85ab64ece@eucas1p1.samsung.com>
 <20260904-jh7110-clean-send-v3-12-484f9ae72715@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 13:47:03 +0000
Message-Id: <20260904134703.BC9221F00A3D@smtp.kernel.org>
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

> Nothing in the video output subsystem can reach its own registers until
> the NoC display bus clock and reset are up and PD_VOUT is powered, and
> those are shared by every device in the region. Leaving them to whichever
> consumer probes first works by accident and stops working as soon as the
> probe order changes.
>=20
> Add a driver for the subsystem node that takes the bus clock and reset,
> holds a runtime PM reference so genpd keeps PD_VOUT powered, and then
> populates its children. All three are released only once the last child
> is gone.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-jh7110-cle=
an-send-v3-0-484f9ae72715@samsung.com?part=3D12

