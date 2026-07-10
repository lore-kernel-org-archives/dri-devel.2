Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3ECEC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 11:28:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5056310F88E;
	Fri, 10 Jul 2026 11:28:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A09tL/es";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48D3910F88E
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 11:28:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E8EB24163A;
 Fri, 10 Jul 2026 11:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245921F00A3D;
 Fri, 10 Jul 2026 11:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783682896;
 bh=anwGYWlUhs49zhjSlIBuI2L+xq4LO/mhdTy2WntYYWw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A09tL/esE+lvGPPJcBDmIatFVN2Q8wHChDwx1Qhs7ico1wLqakBNOmeA47etmhQlB
 OAVj8+OrVoRShn0p5hOPCjMBgoaJsZ7oOSWvfRXRDAmg0OEoVwZS5GR95+/P10FSUn
 CsiBO6SQvACJWywv2TCQm63OVxtQnWVIJsiL+pmeS3Jkze+fmBAspNi3YWk5sGr2yG
 lXLjv+C7WLg7xNdep3eqdeZVzHWVxOZek/kvqs++mlUkJ4KIE5KsxqJ7Z/nFHgmXLg
 EpJUnO6P4WB2G5e976e9TCDP0TCI6UZkTn+OfZfUYxH1Y/FspIRTDb/zKys4MD5Vdc
 6J6cQx1HEEIbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: Add missing bracket
To: "Manuel Ebner" <manuelebner@mailbox.org>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, lee@kernel.org,
 linux-leds@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260710112529.435341-2-manuelebner@mailbox.org>
References: <20260710112529.435341-2-manuelebner@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 11:28:15 +0000
Message-Id: <20260710112816.245921F00A3D@smtp.kernel.org>
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

> Add missing '};' to code.
>=20
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710112529.4353=
41-2-manuelebner@mailbox.org?part=3D1

