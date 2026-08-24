Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48946C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABD9110E73C;
	Mon, 24 Aug 2026 11:25:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZaffPDYG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7400810E73B
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:25:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 34C5842A8E
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC78C1F000E9;
 Mon, 24 Aug 2026 11:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787570738;
 bh=Ll2jJmxtsLgo7IRAD2PHMqXHyOAN/VbyEsmOlIL8gfU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZaffPDYG6O/pkAuaO6E6Reibdd9NqFKniHuLzL6BoAzBNVKjygdqTIERD3+WQgqJd
 pxkkPXfCkTXpYJgmqvUCQof2eG7QslsVqb8Vz4GheaLLbuCQUel1GuzzD2UIUIdvYu
 2CAkv4zRChtCU4wm9lYWMZ+dUEvuXAD/edwz/kSjegrgiAVq4nfy1MwXLmsxuGfBWs
 VoaCTGTRBt24iNYu7cpPQTDEKvy81zhRMyL98LwbN7+z/lLsRrtYHGQ2OlCNygASUP
 0GMGmZUmmOaSk/G0mot9D6fr03by9GVsd6OdpmAxLtmobSzc3jYhROHN77m1aUg3uE
 80eSQIW5LXQCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 8/8] rust: page: add `from_raw()`
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org
In-Reply-To: <20260824-unique-ref-v20-8-490735672187@kernel.org>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-8-490735672187@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 11:25:37 +0000
Message-Id: <20260824112537.CC78C1F000E9@smtp.kernel.org>
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

> From: Andreas Hindborg <a.hindborg@samsung.com>
>=20
> Add a method to `Page` that allows construction of an instance from `stru=
ct
> page` pointer.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-unique-ref=
-v20-0-490735672187@kernel.org?part=3D8

