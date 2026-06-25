Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869D9CDE00E
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC3C310E2AE;
	Thu, 25 Jun 2026 21:38:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nF4zWIOz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50DD010E2AE
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 21:38:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0F9C0416FB;
 Thu, 25 Jun 2026 21:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AC81F000E9;
 Thu, 25 Jun 2026 21:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782423500;
 bh=PQcX6Uv/dH97W7ij5LT6LvrgrCGKDXJ0aE2uWqv2s34=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=nF4zWIOzesPxsOAIEfecPfbFiXcfj4ZK7OVTC6kBYOGtAjY5YpPRp1W+8Sjn1Z8Fo
 ZH1s2ZiNAQdkOW1vky/g5ZOvXBJazIe0q0vhaYwtEwqkAiDVDX79gnMlPli2VNwNiz
 ftXqqyNQ/WHO2BgGHxcOYGTUGhtMumeLwIP4MsCu75/oKfDG/oC2rLL4OcjelI/kA6
 UJ/IOAEz8YJgoWsTPpHFbfBdWaAApGf9gEQcLN9v84eGlIRuuAjXwwrnHsO+EM2iLB
 cEC1BiPt3pi517v/KeosvdaUbUqUDhryjInVZ41gxtX1frFMLCHh6OBNaKRo3Ks3W1
 +s/H2V1qsn6qQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jun 2026 23:38:17 +0200
Message-Id: <DJIGEANGKENH.3L3T55PFRGY3Q@kernel.org>
Cc: <acourbot@nvida.com>, <nova-gpu@lists.linux.dev>,
 <aliceryhl@google.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <ojeda@kernel.org>,
 <rust-for-linux@vgdm.kernel.org>, =?utf-8?q?Nicol=C3=A1s_Antinori?=
 <nico.antinori.7@gmail.com>
To: "Pedro Yudi Honda" <niyudi.honda@usp.br>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 0/7] drm/nova: replace `transmute` with `zerocopy`
References: <20260625190553.7245-1-niyudi.honda@usp.br>
In-Reply-To: <20260625190553.7245-1-niyudi.honda@usp.br>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

(Cc: Nicol=C3=A1s)

On Thu Jun 25, 2026 at 9:05 PM CEST, Pedro Yudi Honda wrote:
> This series follows the introduction of `zerocopy` to rust-next and
> replaces `transmute` traits with `zerocopy` traits. These changes are
> mechanical and don't alter functionality.

Thanks for your contribution!

Please note that this patch series does not apply to the development tree o=
f the
Nova driver; patches for the Nova driver must be based on the drm-rust tree=
 [1].
Please see this related explanation [2].

Also note that there's already a submission implementing a subset of this
series. Nicol=C3=A1s mentioned to resend once the backmerge of Linus's tree=
 into
drm-rust-next has happened, please align with Nicol=C3=A1s and base your ch=
anges on
top of his changes.

Thanks,
Danilo

[1] https://gitlab.freedesktop.org/drm/rust/kernel/-/tree/drm-rust-next
[2] https://lore.kernel.org/nova-gpu/DJFVRMR67B0W.2AJBHU1PWDPFT@kernel.org/
[3] https://lore.kernel.org/nova-gpu/20260621143647.264770-1-nico.antinori.=
7@gmail.com/
