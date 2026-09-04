Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14F1C61DD6
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E965810F969;
	Fri,  4 Sep 2026 13:31:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bmlrpCoX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E96B10F97C
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:31:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D4C17600CB;
 Fri,  4 Sep 2026 13:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154A51F00A3D;
 Fri,  4 Sep 2026 13:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788528711;
 bh=gM2+Na6lCEHQBMxk+PB55G0kVJNJHy+Up3YtZhB7FfQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bmlrpCoXqLyfkBbMFcVLNTLDLojXbQolAGXpeaZjpcj/Lw6WF2tJHCT2ZVpQ0mcGm
 Ph7r+XSf2nTnCo7Tx4xb/zFqip8xSUTDcnZ+LCJSkMSxy0viPOXbgE2Q/THo2cmUjW
 ssXQS9/8hZ2bAc673SQckYm52pVIgIPZ7CVLUAravXhQ6OqA7RaFcMiokbXMjkoxTa
 GNeIJ5IhqS1sw6MFLK/AbHXSZN4kaPcDJh6C/k5Oe8BC+26MbU+79nLukASVfsLaCc
 dv8Fu0SFVb94xGHjvCNsF7QH9ajiOuHi5s4mhbpQxv+ECpbscgOuTSg7aFZHrITo8G
 pOhbEhS5J8wFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/19] dt-bindings: display: verisilicon: Add
 starfive,jh7110-dc8200
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: conor+dt@kernel.org, linux-phy@lists.infradead.org,
 neil.armstrong@linaro.org, robh@kernel.org, vkoul@kernel.org,
 mfd@lists.linux.dev, linux-clk@vger.kernel.org, lee@kernel.org,
 devicetree@vger.kernel.org, olteanv@gmail.com, dri-devel@lists.freedesktop.org
In-Reply-To: <20260904-jh7110-clean-send-v3-6-484f9ae72715@samsung.com>
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132719eucas1p1c900149ffa1b8771aca238e6441482ee@eucas1p1.samsung.com>
 <20260904-jh7110-clean-send-v3-6-484f9ae72715@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 13:31:50 +0000
Message-Id: <20260904133151.154A51F00A3D@smtp.kernel.org>
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

> The JH7110 embeds a DC8200. The binding requires an SoC specific
> compatible ahead of the generic one, so add the JH7110 to the enum.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-jh7110-cle=
an-send-v3-0-484f9ae72715@samsung.com?part=3D6

