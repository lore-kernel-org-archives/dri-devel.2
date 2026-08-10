Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C0DC5CFC0
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:26:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 292B010EAB8;
	Tue, 11 Aug 2026 07:26:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="QY9ZJZTk";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B51F10E21D
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 18:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1786385141; x=1786644341;
 bh=gK4Pcr3DQwNfN/8k95FgCpPLOLgk+CiAwzBpow6sS+4=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=QY9ZJZTkA2+6A7LZBYgEsHFPFIH5BIuU8Cs6/FAjqmCTCukQ0XVOQ6SxQ/jWZ8/KE
 spawsDJLGROlR/wrKxr7c/x4Qpuh5eFsD1VL5/c8mDlmdnpluMfkdb2MVtwZ5kFc7v
 8Ocd8VJAWWSL9XEGgZaffQGiTeu+CGOLT8AfrGNOOUjn5rdbEdtd2aQE6KAXxm/kE9
 2XbwzcCWQyoGwUO/poGRBIWt2PB/+MWlCVQJ/xKkiZHTJBoQCXdiab66sAqv4FkZW3
 KjZYNijyf7cA669kwB0VGw0JmkUScaRI+0d3wN0IoWdnBmjKBxASYOR86y9vlCWAvj
 wE25uQgZuCI1A==
Date: Mon, 10 Aug 2026 18:05:38 +0000
To: Nathan Lucas <nlucasgit@gmail.com>
From: edu042sjroy@proton.me
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com, sunpeng.li@amd.com,
 siqueira@igalia.com, alexander.deucher@amd.com, Ilya.Bakoulin@amd.com,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/amd/display: Fix BT2020 YCbCr limited range output CSC
Message-ID: <TfUyS8ZAROFt0PXoGV7cW9HCmJCeX30V7o6BJSHAQOkc5aUVRYg5x0Bzui1uOBd5b1jXlYkwajcV4Z0_wSDRSHVaAcnu8HbjDYqhGD6q0Tg=@proton.me>
In-Reply-To: <CACNCB+=r4dAU4+WF2wGzsedbP67ZztWb8xE=CHgAf92BUhmxzA@mail.gmail.com>
References: <20260807182724.51018-1-edu042sjroy@proton.me>
 <CACNCB+=r4dAU4+WF2wGzsedbP67ZztWb8xE=CHgAf92BUhmxzA@mail.gmail.com>
Feedback-ID: 147615787:user:proton
X-Pm-Message-ID: 854a89268099225d9254de5e2b37f9185d92f935
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 11 Aug 2026 07:26:09 +0000
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

Hi Nathan,

Thanks for catching the normalization issue.

I initially used 8-bit normalization because the mode I was debugging was 3=
840x2160@60 YCbCr 4:4:4 at 8 bpc, and I incorrectly tied the CSC normalizat=
ion to the output link bit depth. Your 10-bit normalization is correct.

I built and tested your first patch, "[PATCH 1/2] drm/amd/display: fix BT.2=
020 YCbCr limited output CSC matrix", on Navi33 / DCN 3.2.1 over HDMI to an=
 LG CX with BT.2020/PQ HDR. The limited-range path works correctly with the=
 corrected matrix and fixes the incorrect HDR levels and color I was seeing=
 with the original matrix.

I also confirmed that the resulting amdgpu module contains the corrected li=
mited-range coefficients from that patch. My hardware testing was limited t=
o the DCN limited-range path.

Tested-by: Satyajit Roy edu042sjroy@proton.me

Thanks,
Satyajit
