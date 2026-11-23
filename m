Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613FD606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=eHJokMoE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9601110EC1B;
	Mon, 23 Nov 2026 14:16:41 +0000 (UTC)
Received: from retz.cirad.fr (retz.cirad.fr [194.199.235.221])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B88510EBDE
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 10:17:27 +0000 (UTC)
Received: from retz.cirad.fr (localhost [127.0.0.1])
 by retz.cirad.fr (Postfix) with ESMTPS id CA4A620DD902;
 Mon, 23 Nov 2026 11:17:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by retz.cirad.fr (Postfix) with ESMTP id A4FDF20DDA67;
 Mon, 23 Nov 2026 11:17:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 retz.cirad.fr A4FDF20DDA67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirad.fr;
 s=573E3878-7916-11F1-BF4B-F68474317960; t=1795429045;
 bh=scyNyDk/jOtyvkCVY3fYW+SYyXZzMiVW3G2UUGiHmA0=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=eHJokMoEfa4ZQtyd8qNVxg9971B7DmDvXaspMLJrLukrrcbl1GQLbfLdyY/4bcL5e
 iESoxAOm0LtFgwTT3uSrKiPK/ubR7C1DLOfcJUq/Hv41sYsdns7P09bY3RIQgT7Nu8
 tuRaEfebEivw6Pi6IA1qppblpaB+Uj0cON5fOc5zITi83eTTK/M0UTZZhCbNGaZanx
 Tx258lwQ4+5a2sa5ruCc83j17PImCmbRrcM9yA74MjcbdO8mMqkurYkJN1R9Roojfc
 C1Ki9fRFuVfDlxhIjbBDk5cYSflrTnM2/bxPAPtMojmyPhFBKa1FvHyvS62+Xl7qmv
 r2jpn/0NrlyVw==
X-Virus-Scanned: amavis at retz.cirad.fr
Received: from retz.cirad.fr ([127.0.0.1])
 by localhost (retz.cirad.fr [127.0.0.1]) (amavis, port 10026) with ESMTP
 id HmLyNAWB0j4K; Mon, 23 Nov 2026 11:17:25 +0100 (CET)
Received: from localhost.localdomain (78-196-243-100.subs.proxad.net
 [78.196.243.100])
 by retz.cirad.fr (Postfix) with ESMTPSA id 38EB820DD902;
 Mon, 23 Nov 2026 11:17:25 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>
To: nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>
Subject: [PATCH 0/2] drm/nouveau: fix crash when DP link training fails
Date: Mon, 23 Nov 2026 11:16:57 +0100
Message-ID: <20261123101659.600247-1-frederic.mahe@cirad.fr>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 23 Nov 2026 14:16:40 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On a Quadro 600 (GF108), any failed DisplayPort link training during a
modeset crashes the kernel with a divide error in
nv50_disp_super_2_2_dp(), because the supervisor divides by the lane
count that training left at 0. Two ways to get there:

- Xorg (modesetting) builds 3840x2160@60 (533 MHz) from the EDID of a
  4K monitor and sets it on the card's DP 1.1 output, which can carry at
  most 4 x 2.7 Gbit/s even at 6 bpc;
- a connector forced on while the monitor sleeps or is unplugged, then
  any mode set on it.

Patch 1 stops the crash. Patch 2 makes atomic check reject DP modes that
cannot fit the link, so userspace gets -EINVAL instead of a dark screen.

Tested on Ubuntu's 7.0 kernel with a libdrm reproducer (SETCRTC with a
user-defined mode) and with Xorg; the patches apply unchanged on
drm-misc-fixes.

Written with help from Claude (Anthropic); reviewed and tested on
hardware.

Fr=C3=A9d=C3=A9ric Mah=C3=A9 (2):
  drm/nouveau/disp/nv50-: don't divide by zero when the DP link is not
    trained
  drm/nouveau/dispnv50: reject DP modes that don't fit the link

 drivers/gpu/drm/nouveau/dispnv50/disp.c         | 15 +++++++++++++++
 drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c | 10 ++++++++++
 2 files changed, 25 insertions(+)

--=20
2.53.0

