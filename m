Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E32FC44500
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:24:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E148410E4E4;
	Tue,  7 Jul 2026 13:24:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tj89kf+1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43BB210E4BB
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:24:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2D99F43DFC;
 Tue,  7 Jul 2026 13:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872321F00A3F;
 Tue,  7 Jul 2026 13:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783430691;
 bh=f8K40v15474Lyj6aQ2owDQdvjNay3Tkw5dMYAJ7/Um4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Tj89kf+1bv1fkc2o0jtLyy95Ch2odKt2Odu9Ba/2bxl9Bc/YKx05mZy70dzDq3BW4
 9mnz1BZbKTluES9tQa1MAmvB+e4K+wEJLWtqR29yRxK7yJdEadZpM6u7eaMD7POEtP
 E4PMgl6aBpV1U4ISxZcCTJmBXRFXGwwZiH1fuScFJXHSn4m5BAiBfNC2lsemaEUQvj
 mMI26UL8xSs6DeWhHyRWa+GL5RQTYXD/8rBpGQvgEI8wSiw9RFnvatAtgHc+YP/50O
 +/kY7FoRrwSg7F6cZN1PvHD35U399rV+dZkSLiYFHxHbWo/5QuBOLhQmiICTPAByAT
 BfVhle2MNco5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/20] driver core: platform: provide
 platform_device_set_of_node_from_dev()
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: conor+dt@kernel.org, robh@kernel.org, imx@lists.linux.dev,
 mfd@lists.linux.dev, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, lee@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260706-pdev-fwnode-ref-v3-4-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-4-1ff028e33779@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:24:50 +0000
Message-Id: <20260707132450.872321F00A3F@smtp.kernel.org>
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

> Provide a platform-specific variant of device_set_of_node_from_dev(). In
> addition to bumping the reference count of the OF node being assigned,
> it also assigns the fwnode of the platform device.
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pdev-fwnod=
e-ref-v3-0-1ff028e33779@oss.qualcomm.com?part=3D4

