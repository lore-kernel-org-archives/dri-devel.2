Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC613C79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1E0010E565;
	Wed,  9 Sep 2026 13:37:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QnhsT7tY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E69A210F164
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:37:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5D13D60211;
 Wed,  9 Sep 2026 13:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7381F00A3E;
 Wed,  9 Sep 2026 13:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788961023;
 bh=gP2J3Cxis167N9i4GkT0UHGuHaQXVlyYWuVTPiqTku8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QnhsT7tYqtVP4BwisJTxLkTlV5J3GPFfdeCo03AGE+GliYqNriirpdxg12t+dU/b6
 reYDXWJVaWvYICLrVwYXLBbzxBF/9wV/cxlqq503aV3YIId1w4UxH4VuAijffEcJiC
 lRUiosTb5K1MSxnKOE+fJo+/BVu+9bVJW5WNX8tO7lWOtkgMkOl8NicA/Az73gnuY0
 Hx4AC5+olnu8zRn/8M1pG25o/TAtKQcKhJX9qxjdmK+dD8dbpvbtse2XlOwFBen3TD
 ogLGzdt03UL5sGbQiO5tR0umQPjexXfcOc+JsPZg7Q6Q/C3pqn2DI9fkye1QcOm5IO
 i6vS9FJfhhMnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/14] mfd: remove unused 88pm80x driver
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-rtc@vger.kernel.org, robh@kernel.org, media-ci@linuxtv.org,
 linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-leds@vger.kernel.org, lee@kernel.org, dmitry.torokhov@gmail.com,
 linux-input@vger.kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
In-Reply-To: <20260909132153.1596191-2-arnd@kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-2-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:37:01 +0000
Message-Id: <20260909133702.4D7381F00A3E@smtp.kernel.org>
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

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> This pair of drivers was originally added as companion chips for pxa/mmp
> SoCs, but the corresponding platform code was never merged, so it has
> been unused the entire time.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909132153.1596=
191-1-arnd@kernel.org?part=3D1

