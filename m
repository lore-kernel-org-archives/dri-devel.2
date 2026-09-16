Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AD0C982C3
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:25:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6671D10E8E6;
	Wed, 16 Sep 2026 14:25:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aILRVYGC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 554D710E8E6
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 14:25:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 12D934386B;
 Wed, 16 Sep 2026 14:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CB41F0089A;
 Wed, 16 Sep 2026 14:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789568738;
 bh=IpdiSSGwSt1aQj4eb/hpjw2YAEYJmBmtbJNJ7SSVmMI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aILRVYGCytaC4RBLhqxzhs5YzZd4p9KqvjFD1Yvd6CczrfBQqV7cGsKUfGHkI6eMk
 XZkobmT0GNIwxNEaQCN4xH9KQ5ius1nZccFuWZ3pVtGv1myOgGBNHKVBJwB00WNTzf
 vCeFAB1g9Z72to4piG4LGfU/CGt3DQ09iEfJtjPV3SUCahcDCFfPYupdLBsvd96MyP
 3W8T1XWBlpzNPioJIeM4Hrq93fQQDnfuz8jbESImKiC6q+OrruaumvX9d2tAQWK8rW
 qGi2nyH4LNXoRBF0ESLtEzp152865MecfHHIMrsrNS+FQlfOoDFY6/F6TkG/weRbCk
 RXRCHCH5NFiqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/19] dt-bindings: vendor-prefixes: Add General Mobile
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: linux-input@vger.kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org,
 dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, lee@kernel.org,
 dri-devel@lists.freedesktop.org, mfd@lists.linux.dev, robh@kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-6-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-6-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:25:37 +0000
Message-Id: <20260916142538.87CB41F0089A@smtp.kernel.org>
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
> Add vendor prefix for General Mobile.
> Link: https://www.generalmobile.com
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D6

