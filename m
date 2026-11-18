Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB5B606A334
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=aPjmoR59
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3233410FB97;
	Wed, 18 Nov 2026 12:08:44 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5D9F10FB9D
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:08:37 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso8536235e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795003716; x=1795608516;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SjNyonqAa0eE7Fx/cbQ4HwCRl3zwHsHy92B2Dcu4U+k=;
 b=aPjmoR597ZpGIS+0Hrn1NQ0KWozAsrCvleXqw1WEh5x74ENyX3zdQE8qrUNiySnKQT
 xohM81wmf0hwgVgboDCDrrEuhDZsJcD8y77lyD/GDfrmMMkvtkSiabzJQSXuhOnQnPqo
 k/Mf/8TuvNy9gPUnhZis6xEAM3u3L4oeT/uZFjT3WfZ1ZhOp7baWdhtePJ+t5xFOS+tm
 t+SDgvfHIBqUm5OjaFXePfzzShxiqBGIY/ffGLwsHyuxUiV+27UbJVFEjPCyqTGyPffM
 aXknWEYmVm67xNDmurLLnyc3G+d05eSDcNKC/ahObJcqtOseOMw/lukbewLn0lYoqkTu
 /nDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795003716; x=1795608516;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SjNyonqAa0eE7Fx/cbQ4HwCRl3zwHsHy92B2Dcu4U+k=;
 b=pHQtwDZF17UccYOdrMVOM7Zuo+NOkbI7JccGa0rTpNegyCNIHJH9AuQh8WHiWPpciX
 w9jnsWjj2sTqjRFi1Nk6IN2Vn3sVfnq+UA0hjKtAGcVrzhpC2Jo7mwSb5NfwVWeAIzRm
 8+yIm5kvJAUKekWMV4nEETDVjUaCXih57WNenKK9zvyZEAd09TYm9xlvbNL/16a5ub88
 FLMa2JZgPQZZo1Qlw0SzzO4TaMKDqPBkP0/Zr9yM6iPK40l5DP6eoJRJz2hLeF+mdmq5
 xT4gc72i0l5N/rppyaOBzejtBGj7Kh9yaqn7Bxf25OCZ3yx34QZUs/bAhzqJVu9ntp2V
 2xOw==
X-Forwarded-Encrypted: i=1;
 AL+hErGDoNKAz/lieQaCZq7fJFziPQ6gUv2EmOZUz8IE22b9QEDPL5rnkZ62xngCGqRVxaNBMHiBzVI4Zsg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+guggqdd4cXY+YUPYD296Rv7VoY3F3q54tdmTNum4l19XPWGKU
 zrlGB3zBXD5eTjtgwIpTJO/0OJjNmyTT1HaK+H5CYAOXuGBLPLNBMXngNFMuzN0kDEY=
X-Gm-Gg: AYBFou1BTQcE0NuIOjFaiolIcSmJWLU69fkwmUXVJkH27tmexzezBrWpuis1wq7B+Sf
 4qXRVGVp0CYC103A4NDCQu2Lf5PcMVL1aiSkKqnuEz2NmdH3gXox3HVIQZMA6f5K4Vhi4fa8ZMU
 lJBcaWje3PDGPJv7kHC5WqxYizxexC9Qm5suKsnRxY2ponb7PsIUPdLi/iSOX0JDzCSHDqsOfQK
 rr/BteWqXEOTXwh9yCDa4zoQUVDSozv9KIFo5gVTh1Ek1fhlDPIcf6v86l6PXtFTuzo+DCOfUS9
 /Vz3BSDRj80rQA8DmWWYkY5nwhFLLxpxttw9o+C04EfK4lqBcbXSCcGBxqKn3t4ngdRW1EvxZxM
 hzGXL3CHaelkfPqXttutr/dVHSz4Fklg3UnwJEO6U6CAlCepC5ngZMOOgdUIwlvK06AU5h6UTUq
 DviOOlqMcD+IUwNTm2JvBn3Ziw5bd78vsFMv3xumaQ75G8BEY407k7oEZ+sBNfGbMApmdxxt4Dc
 oHKECnPY5kYBoi8TeI+uEu7GFgotT0H47IVqYpiA72OZSvrV7SQ672A9zHNZn2v6vIVDsxSP4mx
 Ky+DMMlW+600ceBQPmR0GNn4jg6i9q0F7wkO0eC1dsDgg46+RJTk9QFWP54J0ZOuI2MxszB/lwB
 zia77M0N7NSVfKoLlthN9RqTNRQJL07j1gW+t
X-Received: by 2002:a05:600c:1d0f:b0:4bb:56bb:1196 with SMTP id
 5b1f17b1804b1-4bb7da349e2mr45108555e9.23.1795003716150; 
 Wed, 18 Nov 2026 04:08:36 -0800 (PST)
Received: from localhost
 (p200300f65f19a904dea20c2220232395.dip0.t-ipconnect.de.
 [2003:f6:5f19:a904:dea2:c22:2023:2395])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4bb783f8154sm152043755e9.4.2026.11.18.04.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 04:08:35 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 "Yo-Jung Leo Lin (AMD)" <Leo.Lin@amd.com>, Hugo Sales <hugo@hsal.es>,
 Wentao Liang <vulab@iscas.ac.cn>, Zhigang Luo <Zhigang.Luo@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Subject: [PATCH v1 1/9] drm/amdgpu: Use named initializer for acpi_device_id
 array
Date: Wed, 18 Nov 2026 13:08:08 +0100
Message-ID: <cfcf58f6b8db7fb0c16af561d88392ded6b90eed.1795002467.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795002467.git.ukleinek@kernel.org>
References: <cover.1795002467.git.ukleinek@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=944;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=ft4/rQdu1reKvgKzxrhOmRdN8khYNFEACBZQSNlOECo=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq/ZUqx7zRoE1U/CjdK6gW/uFoej0jZtQ514rvH
 Y4soQkxgHKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCav2VKgAKCRCPgPtYfRL+
 TvqKB/97EpSLsgyWyjP60niPUZXPhxY+yNQ0hauypRH8ipaVtk//TURgf1RIWnZMvCharRF6kwd
 Pzdc/HLFchkMd9Gu6EQ3z0CLlHC8hKqJNMIYCXiDVXB/6Qdu71zACkVF0v5C9xFjWXIEkkeiW+d
 Fn6c/Jj9M3D73qb1ycxy5HbLvlhzAfJCJ0XfYBEa5ULg48NPCIgGnwRWe7KwYYJ/livSbuqmuxo
 sju/HBd6ocNUpkA5v0AHhEkXVnB3gJDpdF8wBDqWoJhC7Lc8HsoMUbVi4fC0HDEzR/aw2bes1Wm
 ZpW+htrkPaKtNzD3PlfW3L5s2gk/G1v03kc1PB5Ou8ibj/0J
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Named initializers are better readable and more robust to changes of the
struct definition. This change isn't needed for the planned change to
struct acpi_device_id replacing .driver_data by an anonymous union but
aligns this driver to the common style to define such arrays.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 4874ee864b80..9175680b6a81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1729,7 +1729,7 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 
 #if IS_ENABLED(CONFIG_DRM_AMD_ISP)
 static const struct acpi_device_id isp_sensor_ids[] = {
-	{ "OMNI5C10" },
+	{ .id = "OMNI5C10" },
 	{ }
 };
 
-- 
2.56.0.rc1

