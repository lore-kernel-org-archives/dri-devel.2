Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07C4CD6E5D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 11:31:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0913B10E5FD;
	Fri,  5 Jun 2026 11:31:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="ARosZ9SD";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30B2D10E5FA
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 11:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1780659089; x=1781263889; i=markus.elfring@web.de;
 bh=wgEiKtbllfO9OonOAtpb3Ylmk6jkA2e38dIKpcgdKjQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ARosZ9SDlXjU8SK6cibCeDNToijhtEL+ZnG3Sw+T4l/u9H4M55F/PmRAJ3/qaFer
 VH4k8UfDWN1gH4GidVKskmZCcnhWGbetC2K6HIcwmYu/Chl00o6V1knGo2cLlMM4Q
 iS1KFja6g0fNjQ3SP+sau8KTcftoCAq8UIM+OBQc83YTyHq7q16Sqr3p5H5q84yfN
 loQLoTQy/aLYJvjSDgTHrIft1Ii7hzyeVqlRz9LlyDCJpx37gpGVZgbi62h5+rA0s
 ygvQTB1j2ZRYLbuDg55DBs9vtYlEIRCLu3/8L1YDngF9RlhJiK7Bowk33erY9hI/W
 kXaPS8AK3q5ZE6Jedg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdfCN-1x4nSL3XTF-00itXn; Fri, 05
 Jun 2026 13:31:28 +0200
Message-ID: <e2023393-da68-4775-9f55-16363191328a@web.de>
Date: Fri, 5 Jun 2026 13:31:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/3] drm/amd/display: Simplify data output in
 psr_capability_show()
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
X-Provags-ID: V03:K1:Y/EQ0GSwyX3z+Tzi/Qanb8V+kF6+He3zHX1nm6+wzGCmVTCCTEz
 KPvt9us1UKEfPMYfjMeZq4WW1LJ9mT7rJoRgyG61nIVrc35eYRvG4vz34cCXsNU7MJ2bcfv
 m6erlnW8z7AdvYFUvKgVBOhoeHTy04779+ioe8CjHWdpI4GIGn+9lQ4fwJwoME5S7PH816I
 Rtt7TGJafY4m6yKY5v4Ew==
UI-OutboundReport: notjunk:1;M01:P0:Sa1CzUKVhSk=;y2W34j8YU5fC+WLyjuZePcAs6Dv
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
Date: Fri, 5 Jun 2026 11:39:13 +0200

Move the specification for a line break from a seq_puts() call
to a seq_printf() call.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 4b09a740f205..6e6f391b640e 100644
=2D-- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1076,9 +1076,9 @@ static int psr_capability_show(struct seq_file *m, v=
oid *data)
 	seq_printf(m, "Sink support: %s", str_yes_no(link->dpcd_caps.psr_info.ps=
r_version !=3D 0));
 	if (link->dpcd_caps.psr_info.psr_version)
 		seq_printf(m, " [0x%02x]", link->dpcd_caps.psr_info.psr_version);
-	seq_puts(m, "\n");
=20
-	seq_printf(m, "Driver support: %s", str_yes_no(link->psr_settings.psr_fe=
ature_enabled));
+	seq_printf(m, "\nDriver support: %s",
+		   str_yes_no(link->psr_settings.psr_feature_enabled));
 	if (link->psr_settings.psr_version)
 		seq_printf(m, " [0x%02x]", link->psr_settings.psr_version);
 	seq_puts(m, "\n");
=2D-=20
2.54.0

