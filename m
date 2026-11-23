Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D045606A332
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=P3M2eT1f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3730F10F32D;
	Tue, 24 Nov 2026 08:43:33 +0000 (UTC)
Received: from retz.cirad.fr (retz.cirad.fr [194.199.235.221])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08B6710EDCF;
 Mon, 23 Nov 2026 16:33:16 +0000 (UTC)
Received: from retz.cirad.fr (localhost [127.0.0.1])
 by retz.cirad.fr (Postfix) with ESMTPS id 80DA520DDAF9;
 Mon, 23 Nov 2026 17:33:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by retz.cirad.fr (Postfix) with ESMTP id 5D21920E2A2F;
 Mon, 23 Nov 2026 17:33:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 retz.cirad.fr 5D21920E2A2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirad.fr;
 s=573E3878-7916-11F1-BF4B-F68474317960; t=1795451594;
 bh=vf1TLH91M3JAl7BBpNThyu/WlxB9Lfb7fGRdpCfPCgk=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=P3M2eT1f4RoGsYswGrPXcxbPEBs80wtOgAedxdawRWPeL7lj7waNjrndoRH8G6Ih+
 3zaAVcj6X9A/xfwvWEzK8q3vfPkym2m0iQ1QK04Y/0k2btYNMI5Uam2bTe9fuVnlGN
 j1XKyzxpltUa4XKloFy/neLn2MWXN2FPdMnetoOkiYRWCS2asrnsXnRoSJF9niEj+J
 ULqj9W6z95xVqTjSCL7Lx9ozFruLb811miTsHdvXzdRYQvMu7MbVmXAvT1ixHcbPDj
 3BXqNsgFoeYORs6SNVs41LC3ytqkIea++/e/8B8qJwdCVc8w7wyxVU26BrFm1XhCoq
 x49S0nEm1V7wA==
X-Virus-Scanned: amavis at retz.cirad.fr
Received: from retz.cirad.fr ([127.0.0.1])
 by localhost (retz.cirad.fr [127.0.0.1]) (amavis, port 10026) with ESMTP
 id XJ-EQxWpCIvu; Mon, 23 Nov 2026 17:33:14 +0100 (CET)
Received: from localhost.localdomain (78-196-243-100.subs.proxad.net
 [78.196.243.100])
 by retz.cirad.fr (Postfix) with ESMTPSA id EEE9A20DDAF9;
 Mon, 23 Nov 2026 17:33:13 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>
To: nouveau@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 "David R . Hedges" <linuxdev844@thelittleman.net>
Subject: Re: [PATCH 0/2] drm/nouveau: fix crash when DP link training fails
Date: Mon, 23 Nov 2026 17:33:06 +0100
Message-ID: <20261123163307.637332-1-frederic.mahe@cirad.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123101659.600247-1-frederic.mahe@cirad.fr>
References: <20261123101659.600247-1-frederic.mahe@cirad.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:39:44 +0000
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

After sending this I found David Hedges' series "drm/nouveau: recover
DP links the sink drops after waking" (Cc'd). His patch 1/5 does what my
patch 2/2 does, more completely, and touches the same function, so I am
dropping 2/2 in favour of his. That also covers the points the Sashiko
review raised on 2/2 (the check only ran when mode_changed and active
were both set).

Patch 1/2 (divide by zero in nv50_disp_super_2_2_dp() when the DP link
is not trained) is not in his series and still applies: it protects nvkm
itself, whatever the DRM side does, and it is tagged for stable. I can
resend it alone if that is easier.

I tested his series on a Quadro 600 (GF108, no GSP-RM) and will reply
in his thread with the results.

Fr=C3=A9d=C3=A9ric
