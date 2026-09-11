Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36798C88E4C
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6625810E0C1;
	Fri, 11 Sep 2026 09:05:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Bl0qs9WM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF4B710E0C1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 09:04:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9850142EAA;
 Fri, 11 Sep 2026 09:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046D01F00893;
 Fri, 11 Sep 2026 09:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789117499;
 bh=FvQ0WJXKhilnzUZTfX6OBSl+HEm6Y46X5aJ7DHFEkHI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Bl0qs9WMGfI+o+/T3U36gv77DmWfhrxgReQIyNpYUoSoHUqCsNn0UBorhw4cZNiOe
 5/1aoRK6eidZlSVbM5UM43avMHyKMosZk94OYYBYEJiFSUhIWUvcRccGQbzkapEAlV
 anWR73FiNmMO/Kn0R5ybgCVLKpGEfbVF+ySGexdHurMrt5iN/Lb5mWBwjBn/NwEZ19
 fM7242UknLCMqt4ib1FO/doh5c+TaK7s1CrZurd4qZIiDnCwQK0H6JH22nd4PMHhv5
 8fguM/SVBqF1E5axCQu5c3LKNHylHCF0zcWFobQnmECGHhOiwBFz+k5P/eK0t2dPzl
 xmFM9SCugmYaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 09/10] drm/msm/dsi: separate host link enable from
 video stream enable
To: =?utf-8?b?WcSwxJ7EsFRDQU4gS0FWQUtMSQ==?= <kavakliyigitcan@gmail.com>
Cc: linux-input@vger.kernel.org, robh@kernel.org, linux-leds@vger.kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org, lee@kernel.org,
 dmitry.torokhov@gmail.com, devicetree@vger.kernel.org
In-Reply-To: <20260911-ginkgo-submission-final-v1-9-0e68e63a18d4@gmail.com>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-9-0e68e63a18d4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 09:04:58 +0000
Message-Id: <20260911090459.046D01F00893@smtp.kernel.org>
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

> From: Y=C4=B0=C4=9E=C4=B0TCAN KAVAKLI <kavakliyigitcan@gmail.com>
>=20
> In video mode DSI displays, enabling the host previously engaged the
> hardware video engine immediately during atomic_pre_enable. When panel
> prepare routines transmit initial DCS sleep-out and setup commands,
> concurrent active video transmission causes DMA timeouts (-110).
>=20
> Keep the DSI host in command mode during atomic_pre_enable to permit
> clean panel preparation, and start video streaming in atomic_enable
> after the panel has completed initialization.
>=20
> Signed-off-by: Y=C4=B0=C4=9E=C4=B0TCAN KAVAKLI <kavakliyigitcan@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-ginkgo-sub=
mission-final-v1-0-0e68e63a18d4@gmail.com?part=3D9

