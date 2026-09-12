Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5477AC88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 08:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB78D10E691;
	Sat, 12 Sep 2026 08:42:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JNrT4JEa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88DFB10E691
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:42:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0CD3B601F1;
 Sat, 12 Sep 2026 08:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC271F000FF;
 Sat, 12 Sep 2026 08:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789202558;
 bh=OF37lqCTggQhqObjLxJvaki9WQUPt/AeuzuVGIkE7uE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JNrT4JEa6/FwOSCb/kQiSrMmdd2ANutT5km42EegVcV9YNBxuYGWei5rGiHzsZPu3
 lZd2q1MVdCB21C+baUsXs/cV+H659YSHZBHnOLeR2lcJUl98IY7ouIYuiSnxsgmMd+
 FfRHRsr6f1qInRbhq/8TRpE3W6XEOsZPUEXHTQQQjXZ68+V3QYs5nsbsJ6QG1FTiAB
 bHIOrV6IRgVRsYRzmqYvR5Qc1XHjREan7JjSGwaq3R0SlTT7sYp8UKufluZomqvS+a
 1MHtp7N7LIKpXKei6gWhSrogpjc1GjdrF1V/Eh/alsArAC7Q7ATyVmjQUuhlpigksS
 7M8FtZMfGjssg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 08/20] dt-bindings: iommu: qcom,iommu: Add MSM8952
 IOMMU to SMMUv2 compatibles
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: mfd@lists.linux.dev, linux-clk@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, devicetree@vger.kernel.org,
 lee@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260912-msm8952-initial-support-v1-8-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-8-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:42:37 +0000
Message-Id: <20260912084238.2FC271F000FF@smtp.kernel.org>
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
> Add MSM8952 compatible string with "qcom,msm-iommu-v2" as fallback
> for the MSM8952 IOMMU which is compatible with Qualcomm's secure
> fw "SMMU v2" implementation.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D8

