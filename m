Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08093C88E78
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:17:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DD5A10EEF0;
	Mon, 14 Sep 2026 14:17:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BlpkF+5I";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 366A710E13D
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 13:29:44 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6a5e971c970so4980735a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 06:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789392582; x=1789997382; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JytMekM1O3tqnBvhWTtqVwMI/KxX0kYwHkxZRtcjzKg=;
 b=BlpkF+5IKILPqw2a5pzf5ef/HMIKwPCGO7Y26L5Sj2m6lMsLWVhJojsvhxCeUF6YKO
 NyinZ0UZ6l8zNjSRYQG5ANdAeqOeaE6qryIe9pO9LaIth+F6eq8OD7rlnPmETH6el3jA
 he5aRqTe/DTMfqJRwM6RjMsM0QSOTU7V5gkf5jrWdQIO9nHmR13r0ZJ9c4jKfSbXbBsS
 pBo10U8sMI19hZOKvw0cHvFJfm+x4lnAksZgdMS/g86f7+UvEz113jbiINc1RIuwt6M/
 S6RGm2+6X9Aj3IZXaLnTFlQhE9LeeBcBDYvwlc+osxLJ2nWGy0uxdvtffSFHSxlzeOEV
 rWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789392582; x=1789997382;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JytMekM1O3tqnBvhWTtqVwMI/KxX0kYwHkxZRtcjzKg=;
 b=pWw/j1sp6v5h4Mf1L3zZ4RFiC6qVr/Hk5Z1NTiORIkSxHTGe13uwLUyLDcxairtBMh
 l3D3gfaX1qzdtjS0LiZ5kPE7y7mWyDHH2Br8odw+cie9vyKgj/at0n3CS4FwvsneZnDk
 OfB5oL5QM2uCcXbUWri4WZMLtHVv5DQmfhRatkWqaXznV7exAD2pumNsPJeYMg9UluoG
 pk2lOgzmYjANQq+CEusmvu4qUisCndsayOLKPcISSH7SiPFCbMUK4hheMqs3ZPCBYcy3
 g/+TeYj7bKTUgo793TqWsjxxnO0ADtmxJXdwjxF3HToD0AmTfEBR0aRUMjosGzP8VdaB
 UHfw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiRqXHFsZEFavhD1EcbLvsSiRpntljcSSh8Vc1ZD2ZdYm6FHE9Yxz4qQb0LMkxs1bjk2tnF9fIThk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mNnj9zQlsHz/Zdw5rXBW8tOiF/t5BMfYiZHO26Lxugum2JOUgI
 L+9ZW2Qb9RjSiuV+afgZGvhC27jq9rdyO6nHoXOrsCq6hpwnegKrI74x
X-Gm-Gg: AYBFou0PWirZyL5q/Sp8WBJczfz7M4RsuvgY4yrLRt1aD+Hcy1IuEeMXXlFra2Bqqu3
 hbIMNquPCrLrWuYvnEPAdhFOzDp5TAtyfeHnVOldOzhgaP+ZX0Kd2Xl09V9dWZwxL1FyEnqsFhk
 EzQ06kQcApOMhoR/XCXCAsNphzGetMzADEsLNGNWrPud/CultXY/zGeO4hrSg+3vMpjLu5IVkwv
 udWmZFm0sAbRNZ6zfJrxLdSqWxy2MVaG6nXlfT5mul9ZkKh0Ju4rHWKQ0ADq8oyvlKCeUME0lU7
 yBKfyafyJ7l6AOEpaE1NCE2GY5TJy2fWRuaEyegeLbEiJyuzynVLeuy8zAGy4BYszNa1YauQV52
 N/aY5kr6iXGh8neHT94HaK+0VctG7CPIJPNUvScI8cTOY0l2XHVuzFC+6DLM7EUlZ4LcShLRCaJ
 Lnm5/l69p8Ykt4160FHw73ZoknKBDitPif41EV5kR+Ru9IiR5TFBXo21fuu85Syz2JwIkQvJb+Q
 fY2r0DvVjtjVu4QohMPXvv3wq529Cq8hNjzR2NntLyRD2RHSaSpkU8FCCWSlFM=
X-Received: by 2002:a17:907:3f20:b0:c26:1f8f:ed53 with SMTP id
 a640c23a62f3a-c29a4339baemr362278166b.12.1789392582327; 
 Mon, 14 Sep 2026 06:29:42 -0700 (PDT)
Received: from misharu.home
 (2a02-a463-a071-0-7759-cb87-66e5-4165.fixed6.kpn.net.
 [2a02:a463:a071:0:7759:cb87:66e5:4165])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2965c4dfc7sm437207966b.4.2026.09.14.06.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 06:29:41 -0700 (PDT)
From: Hari Mishal <harimishal1@gmail.com>
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Xiang Liu <xiang.liu@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Yang Wang <kevinyang.wang@amd.com>,
 Asad Kamal <asad.kamal@amd.com>, Rex Zhu <Rex.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hari Mishal <harimishal1@gmail.com>
Subject: [PATCH] drm/amd/pm: bound SCLK FCW range entries to the table size
Date: Mon, 14 Sep 2026 15:29:20 +0200
Message-ID: <20260914132920.10127-1-harimishal1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 14:17:08 +0000
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

atomctrl_get_smc_sclk_range_table() copies ucSclkEntryNum entries from
the VBIOS SMU_Info table into pp_atom_ctrl_sclk_range_table. Both the
source (asSclkFcwRangeEntry[]) and destination (table->entry[]) arrays
are fixed at MAX_SCLK_RANGE (8) entries, but ucSclkEntryNum is an
unchecked u8 read straight from the VBIOS, so it can be up to 255. The
destination is stack-allocated in both callers
(polaris10_get_sclk_range_table(), vegam_get_sclk_range_table()), so a
count above 8 overflows a stack buffer, not just a heap read.

Reject counts above MAX_SCLK_RANGE rather than clamping to it. Only
one version of this VBIOS struct (ATOM_SMU_INFO_V2_1) has ever
existed, so a count above 8 corresponds to no legitimate table format
and means either a corrupted or a tampered VBIOS.

Fixes: a23eefa2f461 ("drm/amd/powerplay: enable dpm for baffin.")
Assisted-by: gkh_clanker_t1000
Signed-off-by: Hari Mishal <harimishal1@gmail.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
index 4b796d60b03d..3217ad3c1d17 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
@@ -1025,6 +1025,9 @@ int atomctrl_get_smc_sclk_range_table(struct pp_hwmgr *hwmgr, struct pp_atom_ctr
 	if (!psmu_info)
 		return -EINVAL;
 
+	if (psmu_info->ucSclkEntryNum > MAX_SCLK_RANGE)
+		return -EINVAL;
+
 	for (i = 0; i < psmu_info->ucSclkEntryNum; i++) {
 		table->entry[i].ucVco_setting = psmu_info->asSclkFcwRangeEntry[i].ucVco_setting;
 		table->entry[i].ucPostdiv = psmu_info->asSclkFcwRangeEntry[i].ucPostdiv;
-- 
2.43.0

