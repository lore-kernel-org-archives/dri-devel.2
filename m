Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D9FC982C4
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D72D10E931;
	Wed, 16 Sep 2026 14:27:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JTpJSUp2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8E6C10E5F0
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 14:27:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D17D74335C;
 Wed, 16 Sep 2026 14:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9DF1F000FF;
 Wed, 16 Sep 2026 14:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789568875;
 bh=gGNMMwwE8I4VtksDzzEPRhztJWxVt6+Rp9K8tUrO2sk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JTpJSUp2Z5D5ia+0VWHI+LMPD4v+FCYNgFSLdRozkv/vZMkdbg8Hz07pgQHGDVJ7n
 kouu6CRv/juYtlZ7J+rRDDcryfq/piCfNurmPMb/RO1+Zmcrooe/VtRXmXLgOkH2Bj
 wbSTXZTD9AaNoCoMVtq+HKMEMritjbldpJz8C5FpqeoTX7ArADB1/t0FvZ4J1xYPpG
 gr/RAw4TlflfuzIGe4cdndwamgQ1MO+2+MJ8bgj0zgqJL1I8vdZoF+R6+rgxK1MawR
 +nV5+gKtDTDugZc8N+AQUpdQADlgaFIgBWxgt+N/QGV75E8jz5vuqAkHdyM1AwpE/Q
 pzgjSFSSlEPOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/19] dt-bindings: power: rpmpd: Add MSM8952 power
 domains
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org,
 conor+dt@kernel.org, linux-clk@vger.kernel.org, robh@kernel.org,
 mfd@lists.linux.dev, devicetree@vger.kernel.org, lee@kernel.org,
 linux-input@vger.kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-4-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-4-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:27:54 +0000
Message-Id: <20260916142755.2D9DF1F000FF@smtp.kernel.org>
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
> Document the compatible for the rpmpd found on MSM8952.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D4

