Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7052C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED9AB10F4FD;
	Thu,  3 Sep 2026 10:36:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OwM9M3bi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F26B910F4FA;
 Thu,  3 Sep 2026 10:36:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3B177601FB;
 Thu,  3 Sep 2026 10:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838241F000E9;
 Thu,  3 Sep 2026 10:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788431804;
 bh=22ZUzMnXtdQYEitOopngvwk/ja6iLf/slwghthetBoc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OwM9M3bi2++tXyKq/GDB2qV08xvz6cdsaQwJdAuVcttmqXnn2TcZnhMTcoBUPWZWP
 aUt0t6UQIeXnbxmuriuIBz55Q6Zu/VyR8fR1kHL0AA835goHcSDgdWS0QHmCqI9FIa
 VO9W1UAL5Q14yccYG53TOFfZKiWnN8XAwrD+wESP2TGudJhjdnbfJYvJ8JCPU3j/UX
 h5SpRGIfoSrktyIEp2GF8MBiFn/T/CkMts7ld0YbHZAD4TDIXyU7bbNCAaHNgu4+J4
 8DvoFzpBDqajoq69zYumLZNiuagsHFYEg8ukmx+cBOyyKscZVX5o0FwJoqvRofI2iF
 J0PzwyzQjmsGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/8] drm/i915: use hw_pte_t for PTE range callbacks
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: linux-perf-users@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org,
 damon@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260903103002.1091859-8-usama.anjum@arm.com>
References: <20260903103002.1091859-1-usama.anjum@arm.com>
 <20260903103002.1091859-8-usama.anjum@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 10:36:44 +0000
Message-Id: <20260903103644.838241F000E9@smtp.kernel.org>
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

> apply_to_page_range() now passes PTE table storage to its callback as
> hw_pte_t *. Update the i915 remap and selftest callbacks to match the new
> type.
>=20
> Continue to use ptep_get() for software PTE values and set_pte_at() for
> updates.
> The type remains an alias of pte_t on x86 until that architecture opts in.
>=20
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903103002.1091=
859-1-usama.anjum@arm.com?part=3D7

