Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23804C982C9
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:27:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7909110E44A;
	Wed, 16 Sep 2026 14:27:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kvhq7k+Z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DF7D10E556
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 14:27:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 50EC0408AA;
 Wed, 16 Sep 2026 14:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31A71F000FF;
 Wed, 16 Sep 2026 14:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789568826;
 bh=oqGl7Y9RJHRAQQrs3tHgPs5iDdohv0EUAEwLeFc3c8s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kvhq7k+Ztt7uDRWy936I4MxeoNiPZcAr2oagrOYLjIXm5uf2ia8oV83u5VpyVcN9Z
 yMR7n2NnZgdhQGOmZAtYqDEgwHtjSayWBtppUOxTroVZDdsOFKS4lJGeiUtgFBndwe
 RwhVcgopH90xW4WUXSLbQMrrW5GpZPxzoM+lmz+DGCHkN0u4K2u+9KE1fQMndG4+qs
 Z9aaMziflIHb7VSOgYkvwEDiANm56tkPbZVVeIPI/yhL5xBGmQ7wbRz7xuCd6Z7C1Z
 fNzYsei7wKSvpwgpxZzMaR6PDsK5SZGQmJ17TlgKYF+PMs9mEQMstZnQeJxHH1OLcb
 2njCWpWjLxXwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/19] soc: qcom: ubwc: Add UBWC config for MSM8952
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: lee@kernel.org, mfd@lists.linux.dev, linux-input@vger.kernel.org,
 dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 linux-clk@vger.kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-14-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-14-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:27:05 +0000
Message-Id: <20260916142705.A31A71F000FF@smtp.kernel.org>
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

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> MSM8952 uses Adreno 405 and predates ubwc just like MSM8939.
>=20
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D14

