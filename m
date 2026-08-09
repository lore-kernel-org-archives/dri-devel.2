Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674A7C5AE5D
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53C7910E65F;
	Mon, 10 Aug 2026 06:38:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CyUzRy7F";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FF7310E05B
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 05:13:14 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2cca0c5799eso7503125ad.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 22:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786252393; x=1786857193; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=deoqn41jn4hqxaXBU0LER8gLC0cAyHmrQg56bcVPpQA=;
 b=CyUzRy7Fl9mcKpeXKlJZCE6dcn2r7CVUIjVqJQsWZpGdXa5kAEUarKf7MNB3LctRU9
 Vv8hbHbHq06ccSF6v8OJm33r5XWrscsteD/ROsiym+rGMPrNJ3w4kO3RsVfpRBJ5HfnF
 BOfRCu1GTeUMVMfYFMUKTEuhBvPlP5ddv4n0tFOW5Wx1LXOwBUYfO9o+Lfsnxe0rUG5W
 r50QTj552Udz9qnIjoW2WTQ3G3Fa9f4+9L6Qa+7UuoKauh+2o7DRkmpQEw/ZSV2m0dBb
 PFXEnXtc50ZNLOFJydOyZeOJT5WJ4QQxexnxd1rH1VS5ee8E5GPf7iSJHPF94idi3IMk
 6fvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786252393; x=1786857193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=deoqn41jn4hqxaXBU0LER8gLC0cAyHmrQg56bcVPpQA=;
 b=NSaJtHt05x5v72nWqrOSo0noDwShAZdrfHkZDIKiYe4yiFNLMCAzvx2IJn/p7eU/aP
 /1HGO0oX9e7AOXyOiY7ZC7q+ZIwa6wP62ArI/0vV7er9apQZ+viYxlH3ufDQzmHIuZly
 evB2dimftxCgF1zw4X36CN/VRPtMrwn6FYUJnUmPd9hzCy2yPQVKGThlHOfUEIGfGxpC
 3phjb9aXvSLr/Sk84ySq8vxwXV+TNdqkhGzwkBNQn6+c4kaCSD713SuvsIRAoQx2uLBS
 /zSI5wHRVw2bCYCxxH7waWLsgaw0Cx7aTgE7q9Rc+v2jplQJDFj68XqXKZtAkHb0l9ic
 XpKg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoxfHm2PYW4HctNRBQyowKC40wucuZA7f/1/ukjicfeVzk058tHOzZNKBYX+FHaC3GB4soUtFQzJlo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwvRvdaF/eSJiR0nn/pJbjM3vs/pefy7wwuZPrEOqctx2r1s7Aq
 v1WozwIaKRos8fAWaDRyvT27DPkW2g8vJsoSuAu3/dm4Xgqgf8g5x9Df
X-Gm-Gg: AR+sD12v0zHPpSr058oBDSc3mmx5CJs+tYT1GYaTib9i6kAK3E1XyOC+0oyBBp/DltC
 Dh9otYE6IbYeQVpvyh0NchxoBEXfjMN3CZ2P5cj5Rg4sTrWzPNLzG/79rsu7otTY+m3MaTuABq2
 AqjaGQsn5K861KWtQs8BYp6LA3BuYQSmNzxtlg2Hd30YkcsxH1msY/OM27MbNBA47tlxaJHZH3P
 bzIIgHfwkhod+KYlwE9mMLFwMJlF5cuOI6gFA+j4tof6MiZitWveQCRZXsO5gdq1j62/eDLgMN5
 MClu7su11jTPl+Xb6qbsAFC7m1sTbzDDqSnloQJEwCS9DQNAWBb2LX9CTUdXGN9h8pnopr/zWM5
 zLBQHDICGgSRApOWn5mplVImvZq6IHlM4d0tU/OJrhpvZOKrP9o6fuxIOai/57IHOHjF7G0p/Fn
 1v/L9ar7L/QPEu2T3kEE+gHwV4GMqnCq1uWQflsc+bSUUlGYLKanhnkfgbxdWd+j/FfMcXPZfED
 cQzQNWEAWn7aNXg0cbdDOJR
X-Received: by 2002:a17:902:f608:b0:2ce:d957:59c4 with SMTP id
 d9443c01a7336-2d2a8692dfamr135589535ad.6.1786252393509; 
 Sat, 08 Aug 2026 22:13:13 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be8a7395sm27095702eec.9.2026.08.08.22.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 22:13:13 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v3 2/6] drm/amdgpu/aca: Add upper bounds check in
 aca_bank_hwip_is_matched
Date: Sun,  9 Aug 2026 05:11:56 +0000
Message-ID: <20260809051200.3276-3-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
References: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

In aca_bank_hwip_is_matched(), the 'type' parameter is used directly
as an array index into aca_hwid_mcatypes[]. The function previously
checked whether 'type' was equal to ACA_HWIP_TYPE_UNKNOW, but did not
validate whether 'type' was less than ACA_HWIP_TYPE_COUNT or negative.

If an invalid or out-of-bounds enum value is passed, an out-of-bounds
memory read occurs on the aca_hwid_mcatypes array.

Fix this by validating that 'type' is strictly greater than
ACA_HWIP_TYPE_UNKNOW and less than ACA_HWIP_TYPE_COUNT before
performing the array lookup.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index d0d473082431..c76664af9902 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -138,7 +138,7 @@ static bool aca_bank_hwip_is_matched(struct aca_bank *bank, enum aca_hwip_type t
 	int hwid, mcatype;
 	u64 ipid;
 
-	if (!bank || type == ACA_HWIP_TYPE_UNKNOW)
+	if (!bank || type <= ACA_HWIP_TYPE_UNKNOW || type >= ACA_HWIP_TYPE_COUNT)
 		return false;
 
 	hwip = &aca_hwid_mcatypes[type];
-- 
2.54.0

