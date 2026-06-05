Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1466DCD6E5D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 11:30:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FFB010E5F6;
	Fri,  5 Jun 2026 11:30:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="ohPk2Quy";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6FC910E5E7
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 11:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1780659020; x=1781263820; i=markus.elfring@web.de;
 bh=CMdHGUxs8Ri/zAHYzo036fmvdg11ZbV7UKbl7K5xoYQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
 Cc:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ohPk2Quy+oBAD1bMOFbOIljb7PbSYy7x9KOMEu/5fxxPXl9ikWeDY4q8yTZ5hS6r
 Gn5NbwT5FMyk4dzuW/ikcWfXEGqezWlYLDLEOK3h0otcu3XnXFE/pZlvvXTURjPBM
 t3QHI0jhEH8LVqKgZ4BnrBZO4mWkG4/pXwO5biTwDXZFUPv00cWt1lBOOUg1olMLr
 ZZ9PK5YMyXlWEFajzIgHE2ifYLnvUj98NUm/as3UwD5yppP6NBDuzVfYjf+DN8gNs
 hsSMh7Oivm/hiJhe3OhKfKflkiwnR4ayS+dPj5mD4dpYWi4HpK7osxlTLijMRr6Jt
 5mWxayMNuETTsUc7pg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNfU1-1wtRWZ1mRP-00XLds; Fri, 05
 Jun 2026 13:30:20 +0200
Message-ID: <e0689a10-9cd6-4d74-a276-99f8f01c83fa@web.de>
Date: Fri, 5 Jun 2026 13:30:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/3] drm/amd/display: More efficient data output in four
 functions
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YjRKuUg1oNMMi6pzfxyr7Gew5lL6jPzt8INLbghegPb013dsjpc
 EQFfb98aUrrebZIY9gGod8s/rvckYRI7mJHU7px+/AzcP/Zwu+m2Lw7B9xl9gCZevONFr2E
 L9cJjMCpI5TgL18pcMZlzF0KfGoF0OfTIAH6dmmiWYG7ED2uVb5yAY9rOeggSWoIqO7nF84
 0LqZMRCeyTnsu3vSNR+Eg==
UI-OutboundReport: notjunk:1;M01:P0:5fAsn9/c7C8=;MZ82GXX6h+R5tnv1pDz7QMXtYn3
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
Date: Fri, 5 Jun 2026 13:00:03 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Simplify data output in psr_capability_show()
  Simplify data output in ips_status_show()
  Use seq_putc() in three functions

 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c   | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

=2D-=20
2.54.0

