Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA52FCD6E5D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 11:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A51510E5FA;
	Fri,  5 Jun 2026 11:33:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="dLdynyJl";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE47810E5FA
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 11:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1780659219; x=1781264019; i=markus.elfring@web.de;
 bh=5xZ+f8SzZDJmAU1EnpH9VXvDuhlbt0Ej9kbmVsUaruM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=dLdynyJlh1XCmK4eki4FCh6AFmyGpsgQ7vwEQkBYCeBk5EwUDxwN2u5lSgh9S3X4
 z0NKR67aXGgzyimPJlNTZ5dhBApb00i/GeOMZCEsoiT4oNGKxK22P5NahwNRjehca
 5Zt74iVcSVbGOcebK9GjjP2hLUvuXdS+UQtoC/PnMs91PFpUgVcnJlBvvlA6H/B2y
 dye52exJmDlZDscivOEHI43c/+IzCuqXYD6bND5nLpKHrWV5efXcqQsmjNLDVvX0t
 RBX7GjYeyvU0WGayMDN73bggmwfhKTcQE9udKTCinsSMnosHQ/aRmHrTz3cxTd+pW
 rBtyvatC95HrTel8qw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkVwi-1wyRmH1mjG-00cggA; Fri, 05
 Jun 2026 13:33:39 +0200
Message-ID: <da65ea0b-81bd-4109-89cd-f4a5120edba0@web.de>
Date: Fri, 5 Jun 2026 13:33:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/3] drm/amd/display: Use seq_putc() in three functions
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
X-Provags-ID: V03:K1:HgInL5ze4wR8Y0N9Mto0KsoCWfwmTzkVA1Oa8BEkJD/EuLbh2Jp
 DN5y0RTawt+zh0CCLaSb5BQKBGPcmCmCPzLF3X6Xb3OapZyQ4NnSpN+QKpQfgnYnOC+SZsU
 l5Dqo+TTFNJr6nFhuN3bA2764Rx+8aGtm3Q+hjF+0XflCCBvf/UoOqISgKPbB0yJzqlGj8t
 YXQ5AK95JhxU5TfANSHCA==
UI-OutboundReport: notjunk:1;M01:P0:I1T3R77/mGA=;szSKutaDa9vuxAmcMX7NMaLqu+e
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
Date: Fri, 5 Jun 2026 12:44:01 +0200

Single characters should occasionally be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 885e9b7bc27a..e45fa6e97fc6 100644
=2D-- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -606,7 +606,7 @@ static int dp_lttpr_status_show(struct seq_file *m, vo=
id *unused)
 		break;
 	}
=20
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 	return 0;
 }
=20
@@ -1081,7 +1081,7 @@ static int psr_capability_show(struct seq_file *m, v=
oid *data)
 		   str_yes_no(link->psr_settings.psr_feature_enabled));
 	if (link->psr_settings.psr_version)
 		seq_printf(m, " [0x%02x]", link->psr_settings.psr_version);
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
=20
 	return 0;
 }
@@ -1266,7 +1266,7 @@ static int hdcp_sink_capability_show(struct seq_file=
 *m, void *data)
 	if (!hdcp_cap && !hdcp2_cap)
 		seq_printf(m, "%s ", "None");
=20
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
=20
 	return 0;
 }
=2D-=20
2.54.0

