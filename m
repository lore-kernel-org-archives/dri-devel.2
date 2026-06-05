Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18FCCD6E74
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 11:32:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24B7310E607;
	Fri,  5 Jun 2026 11:32:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="MCxsKBLM";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03B3210E607
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 11:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1780659160; x=1781263960; i=markus.elfring@web.de;
 bh=6LBnlSmiBPuB+N4bVjMCx9ZmUvUeo2H9AeSH0XpS1vo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=MCxsKBLMPPOq4fVDCxgj2CBgHOfgQ1XE5eV9C+hiOzf0+ohtj9hWBjtcZ33xo7ZL
 onhIHLANs6drk5fohnC1TvAzR5UgbyU2zKO5VkiWaxUSZiLEdwjISQQp2NY9AFaPg
 t5xfIJMF3bt1jm5VcT1Mh/gUGC72WXLNsEn8573kcHEXuenEfBb8ySY7O1JzEfzB8
 IPSq52bE+WQu9aEhiurhUUMnCWWRXuxb6M0zYz1fkbOJkZ7ASHj5FPX89XI6Pnc4w
 Wqp7Pv/HL8x16wENKPk3kREMAzeN5BLZtv5qlHqDD4EWiCRF6qUw4bFEHbZVlTP+5
 j6BznKV9Ak/ViEhGDA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N62yY-1xJwop3iDw-00yBxe; Fri, 05
 Jun 2026 13:32:39 +0200
Message-ID: <89f8663f-2a5c-4f1f-a534-0934195e7fc7@web.de>
Date: Fri, 5 Jun 2026 13:32:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/3] drm/amd/display: Simplify data output in ips_status_show()
From: Markus Elfring <Markus.Elfring@web.de>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Kees Cook <kees@kernel.org>, Leo Li <sunpeng.li@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Ray Wu <ray.wu@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Rong Zhang <i@rong.moe>,
 Simona Vetter <simona@ffwll.ch>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Tom Chung <chiahsuan.chung@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <e0689a10-9cd6-4d74-a276-99f8f01c83fa@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <e0689a10-9cd6-4d74-a276-99f8f01c83fa@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CYcxFNZhVdW+vbAHngJKGkF1xlYwzXR59NPAuIrJKPec1oDeQLG
 WAaIQWk+6EoYnZbOIF0aQzCyatQwxPmuQrKSOTgU3yNxIbBME1OaSltj3iCUnAMubey7S5O
 fioytaDxxuGkEfyi5sWb9JIH2ysuV2klHCj/hE7CN7zS6PWQxt8BWBQSHUu+M9J5hOjE1Zm
 nBY0PFbLKrpkAm8zt643A==
UI-OutboundReport: notjunk:1;M01:P0:83GsI4+5n6o=;9R4lKfSV5Wg84CI57AYGb7kEXh+
 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
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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 5 Jun 2026 12:40:31 +0200

Move the specification for a line break from a seq_puts() call
to a previous seq_printf() call.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 6e6f391b640e..885e9b7bc27a 100644
=2D-- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -2705,11 +2705,10 @@ static int ips_status_show(struct seq_file *m, voi=
d *unused)
 		rcg_count =3D ips_fw->rcg_exit_count;
 		ips1_count =3D ips_fw->ips1_exit_count;
 		ips2_count =3D ips_fw->ips2_exit_count;
-		seq_printf(m, "exit counts: rcg=3D%u ips1=3D%u ips2=3D%u",
+		seq_printf(m, "exit counts: rcg=3D%u ips1=3D%u ips2=3D%u\n",
 			   rcg_count,
 			   ips1_count,
 			   ips2_count);
-		seq_puts(m, "\n");
 	}
 	return 0;
 }
=2D-=20
2.54.0

