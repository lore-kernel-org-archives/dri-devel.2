Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7A1CA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6A5710FF56;
	Fri,  9 Oct 2026 07:59:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MqKMQ7be";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6DC010FF56
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 07:59:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 81FA843745;
 Fri,  9 Oct 2026 07:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F7A1F000FF;
 Fri,  9 Oct 2026 07:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791532753;
 bh=gXtPib0RE6hspBksSoMJbmzs7zXiRey/gqluAFwnhtw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MqKMQ7be+yDDSQFsXrzRrr4Ynwe3UHvHmHhjZ6+j/X8Npcaku3P3JiUebD4QIg2Bv
 bD+gAvKgnAAqB0NOgZcxHk0s8k+66VRRUuzNLIbmnC5ijDd6/gl6KpP9BNvyrBsId6
 WZyFtCigxBq2Kso6gQwSaEz5vrJO96BTk62xMma3KyJZXSyHGEL/P/9h4Et8Z3yYam
 rGn74vMtz0vAuG0850gFB4EzSfzvAf0gtnFFSvZNMLC0pacnaqNMwa0ACOe3EDOk7k
 IkG9ecGcB3p418eF2kAi5eA/m4w4X0HXoFrF91ZpJfR4RWBsYJt/Y8vAkw/0b+IQLK
 P10QYpmwH0Wfg==
Message-ID: <sashiko-outbox-165047@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: arm: qcom: document Radxa Dragon Q8B
To: "Xilin Wu" <sophon@radxa.com>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, linux-gpio@vger.kernel.org
In-Reply-To: <20261009-q8b-dts-v2-3-eda11e5dea8b@radxa.com>
References: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
 <20261009-q8b-dts-v2-3-eda11e5dea8b@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 07:59:12 +0000
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

> The Radxa Dragon Q8B is a single-board computer based on the Qualcomm
> SC8280XP platform.
>=20
> Document its radxa,dragon-q8b compatible.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Tested-by: Daniele Briguglio <hello@superkali.me>
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-q8b-dts-v2=
-0-eda11e5dea8b@radxa.com?part=3D3

