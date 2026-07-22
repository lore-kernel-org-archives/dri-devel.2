Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC98C4453A
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 10:17:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD7ED10ED33;
	Wed, 22 Jul 2026 10:17:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="josDyg7s";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8795D10ED33
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 10:17:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E83E40AC1;
 Wed, 22 Jul 2026 10:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939191F000E9;
 Wed, 22 Jul 2026 10:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784715447;
 bh=M6JxxjsQ+mHDkV1NMzQZovrgjRthOQNXC0dEAaFzhpU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=josDyg7sFchp5Ia07fvWoYcBHPL26nN6nKqWsPZ3VNLIOEV3yDNGSwD21ttQFlVOp
 kxYTJ5N+zH8PlZQ85FsnmjhH1Wm1VYUxKM7Kfph/NBg8RYBENbtydLLgof3x+PwDPz
 lx4Kp59Fs15C7xbChYn+Y8fmH3AI3R3gvmcbYhRaeaZ3Rczi+VrmooGs2HXQAArZpc
 zr9+4k+KBmXlerD44U94q3vKYg/7hj8uvIXRcdRt06meFHp00ZfpXT293p8sM8yr0K
 amAlj3HV5/y8JJjqZOUVqINSkKNKPO2WGnNEOAyNXMMVBkXoU9k1eQXzyGa8BQIid8
 hcl+nR/r0bhGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dt-bindings: fix typos and brackets
To: "Manuel Ebner" <manuelebnerli@mailbox.org>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, lee@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org, linux-leds@vger.kernel.org
In-Reply-To: <20260722101246.3113818-2-manuelebnerli@mailbox.org>
References: <20260722101246.3113818-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 10:17:26 +0000
Message-Id: <20260722101726.939191F000E9@smtp.kernel.org>
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

> Add missing '(', ')', '}'
> Remove needless '(', ')', '{', '}'
> 'lover voltage' -> 'lower voltage'
>=20
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722101246.3113=
818-2-manuelebnerli@mailbox.org?part=3D1

