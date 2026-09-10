Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE84C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2203210F3AD;
	Thu, 10 Sep 2026 09:08:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I+8gmVZ1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8515710F3B5
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:08:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5EA32407D3;
 Thu, 10 Sep 2026 09:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77E71F000FF;
 Thu, 10 Sep 2026 09:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789031296;
 bh=L0XS7NLfJCOacJULPOxAmXcuhZuRx9g5eebZR+Y1oro=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I+8gmVZ1B1nV3IPvpIjXB5U1tP8oc4lRY6hJFyEbw6hdTYqr4mCAH20sYHFWkOXba
 8N8SuhQ4ZaoB5IsgWBxHsIcq6e1eWbXyFtrIrPl8w+i6EsOLt3yOumSuwor29Qgxrd
 ceWxLX8y1WtLX2viKXfv6VdZ2g9uQlQ1/nZlKizR2Wp7xncWTDtkQeOcFkQd6+ZPhz
 HOTWQrafeb4EhZhATthV0gngn0Ww1CDvX7OK2OcUvtIVdaj/4PmSbKoWwXUAGOKrMk
 +3V3R3YcuY3u7dPkC7NY5vByk67tC173ns6GUoSXkQXMQb1p7j6oMluj93dtoH74wt
 FJatZ9B5HLMeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 3/9] rust: implement `ForeignOwnable` for `Owned`
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: ojeda@kernel.org, gary@garyguo.net, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260910-unique-ref-v21-3-e83257373062@kernel.org>
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
 <20260910-unique-ref-v21-3-e83257373062@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:08:15 +0000
Message-Id: <20260910090815.E77E71F000FF@smtp.kernel.org>
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

> Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` =
in
> places such as the `XArray`.
>=20
> Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` =
to
> implement `ForeignOwnable`.
>=20
> Assisted-by: LLM
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-unique-ref=
-v21-0-e83257373062@kernel.org?part=3D3

