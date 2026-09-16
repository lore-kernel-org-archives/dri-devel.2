Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1835C982C4
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:30:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 361A210EB63;
	Wed, 16 Sep 2026 14:30:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bz/ljGC0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BF4410EB9B
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 14:30:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0CEB243B09;
 Wed, 16 Sep 2026 14:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB101F00899;
 Wed, 16 Sep 2026 14:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789569042;
 bh=kLwMCAGXyJiEdodJAl6IBtwsslfPPzuY7jdwCWLAbzY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bz/ljGC0/B5Zw5OuR5QucGStoy40aiU8jMlEoQCvpC2pDhYZNf+o/ragcos1Y6f/5
 mE3ZVuA94M/YtxQGp9iBDheFyDf23MT1RWg+XfVlq8c8jovVv1KHvIkN6reW1p5++j
 ZPHmP4o1jjRoyITK7L+ZojEU/X98uhPFeV6jcP1PTpFtEhEaD6AdBqQatml9G9o/0g
 hnVMKnNWL2HKN9PBi9UFq78lND+VOsQKqZR7eiOdV+zPxYkE2+XyHvJTr/gaGFFMU2
 dPpUBNe+ApPWqfLNMtVMVYzHsQKeJ3firvfWArMp41R/ki97s69QYpgDNgzjZhxsVA
 dPtN4EinnTb+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/19] dt-bindings: display/msm: qcom, mdp5: Add
 MSM8952 compatible
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: linux-clk@vger.kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, lee@kernel.org, dmitry.torokhov@gmail.com,
 robh@kernel.org, mfd@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260916-msm8952-initial-support-v2-10-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-10-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:30:41 +0000
Message-Id: <20260916143042.5DB101F00899@smtp.kernel.org>
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
> Add the compatible for the MDP5 found on MSM8952.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D10

