Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3201E606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=jzbaWNa8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9119210E10E;
	Wed, 21 Oct 2026 14:56:13 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F3910E11D
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=s0vwMCS9/ucQMJZRfUVj300DP1dP0wLoeI+b2Q+mzis=; b=jzbaWNa8MoLnL0gS8/Y4VO91ra
 yJd4gtCh3qZWqobS9UVRd70qoYEsDVYK4YK+Gs4vK5NTDG/FPhANxbkepBji78sLAtj1X0OAIFnve
 k+amxipFep2toUmlvohO9mBZu9tGENUPfKlrdOXZkk0mBZelN5E2K6Uv9WVRL5z6NQU7hpeEFZXRG
 /aDtwgnhWCK310uLkPA0qgBBDOS1mjoURA9q3J1pM0+41Qs3mPxMi3H6SM2soGAZRsGq1muUhkIH6
 IGv5J3/C26Q5AtPwZ1In9rxcfjFKWymBFGqiUquTU4c+EE3H0vvcXn9LqtW/hGRzNOtVlGfrH/fJ8
 h7RFhRuw==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJXjW-005jXv-Ds; Wed, 21 Oct 2026 16:56:02 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Wed, 21 Oct 2026 11:55:30 -0300
Subject: [PATCH 1/3] drm/v3d: Validate the v71 fields of the TFU submit ioctl
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261021-v3d-tfu-ccol-v1-1-4c99240cca28@igalia.com>
References: <20261021-v3d-tfu-ccol-v1-0-4c99240cca28@igalia.com>
In-Reply-To: <20261021-v3d-tfu-ccol-v1-0-4c99240cca28@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=VtPx201mZWDrh3y9gOqnNhmoKYi1b5mi1oTuP7BNJsA=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq2NJ8xNr2QtVC4KMWufvvfhNUqCQWYLy/FlJhu
 LZj6enVA0iJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCatjSfAAKCRA/8w6Kdoj6
 qoFOCACgIO6B2NggBYzRaneb5kxIZVrL90CIpZEZJ9Gv8YSRIH/sKfCxlu8Jb6hWuzu1pPYxjcy
 T7Ys3Fes9C3BWkfBGxzVJeAJ087eI/djllS7uYK7zuvuSPQD3WyRTfpwdWdiphFo6AWG12ht4Bt
 j0rXN3/6pApa0fVaPP0xHwWgViUdJ5Fzh2zayy3et10ee7SN+EpbpZE2RUfN1NWQuBQIS7XnPVW
 ajbXpNb0QGToiOuEROOhwtvVB81pSCTkWUGaVugEQjzuE8Ct+rbvcNZRhNiM6JIqnd7ObPI1b0o
 p5HIW5GqUkJmPgPJO8Tlur5lD4NW1nYSbQ/EV4phuo62dDF7
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

The v71 fields of drm_v3d_submit_tfu are only meaningful on V3D 7.x, but
the kernel silently accepts any value in them on older GPUs, as well as a
non-zero pad.

Reject the job if any v71 field is set on GPUs older than V3D 7.1, or if
the pad is non-zero.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 7548faab67ba..eada30a31701 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -1261,12 +1261,21 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 	struct v3d_submit submit = { .v3d = to_v3d_dev(dev), .file_priv = file_priv };
 	struct drm_v3d_submit_tfu *args = data;
 	struct drm_syncobj *sync_out = NULL;
+	struct v3d_dev *v3d = submit.v3d;
 	struct v3d_submit_ext se = {0};
 	struct v3d_tfu_job *job;
 	int ret = 0;
 
 	trace_v3d_submit_tfu_ioctl(dev, args->iia);
 
+	if (v3d->ver < V3D_GEN_71 && !mem_is_zero(&args->v71, sizeof(args->v71))) {
+		drm_dbg(dev, "v71 fields set on V3D %d\n", v3d->ver);
+		return -EINVAL;
+	}
+
+	if (args->v71.pad)
+		return -EINVAL;
+
 	if (args->flags && !(args->flags & DRM_V3D_SUBMIT_EXTENSION)) {
 		drm_dbg(dev, "invalid flags: %d\n", args->flags);
 		return -EINVAL;

-- 
2.56.0

