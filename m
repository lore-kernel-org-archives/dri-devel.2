Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6809CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 07:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2459910E6D4;
	Mon, 18 May 2026 07:41:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icloud.com header.i=@icloud.com header.b="GL86WyF6";
	dkim-atps=neutral
X-Greylist: delayed 4200 seconds by postgrey-1.36 at gabe;
 Sun, 17 May 2026 12:26:43 UTC
Received: from outbound.st.icloud.com
 (p-east2-cluster5-host11-snip4-5.eps.apple.com [57.103.79.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECCAC10E049
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 12:26:43 +0000 (UTC)
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-3 (Postfix) with ESMTPS id
 1B07C18002BF; Sun, 17 May 2026 11:08:57 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhKBUMDRQBBCFYBWANLVxQEC0AFBlgARnkRUAFYHlZeWhdeTVEPDwNKEAJeBV1yGVoUXBhTRVEfVFhBDgpaA1BRHV8CCgRHBFsXRgNTRUEEFxFQAVgeVl5aF15NRx9ATWJJAVoZWxxAF0puTVMPDxlaFFwYU0VRH1RYXgRTVg5CCUoFXQJaBUEISAVZAEUHQwtJCkAGRkEDUUkAXwErWxNVF0YJGQhdHQdYRxRHDg8ZWhRcGFM=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1779016138; x=1781608138; bh=z71PqENSr7vFfogwsyZJQ+3mEvrdaF546GeFnxFzzfg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=GL86WyF6rNk9T0QJWDP7kQAKA6Ue/zKUhhggtiiE+Yb3chIwHYYjVMIXTSvHUEA+Gv8N1xfZLUIVGCmKcbJA/UbrQfo5wVgKdl/ZF2tO416pii0qVUzBD9CbTjmGmVe2UtElPvbyuhH0Y7ooavBI6BLaUBQnxjj4prjFMF2n5BeLW2boGw4of6db+yD12TdCQna/1Sb2sWAqR5WjXqLytXrSvneihS3RT744+P4HGHpHQZYmOND5z7PcoasScTTYr/gdNpHtkv/ZdLyVM7kE7MRE05TZr+LOFftKoEx/Fo+7bNjGdKoNY5R5J5N0t1sj+nDUlJr9FRqsWWg7k41ACQ==
mail-alias-created-date: 1778972301885
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-3 (Postfix) with ESMTPSA id
 CDC8A1800115; Sun, 17 May 2026 11:08:53 +0000 (UTC)
From: Sakurai Shun <ssh1326@icloud.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Sakurai Shun <ssh1326@icloud.com>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs/gpu: fix typo in msm-crash-dump.rst
Date: Sun, 17 May 2026 20:06:38 +0900
Message-ID: <20260517110647.53219-1-ssh1326@icloud.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=eu/SD4pX c=1 sm=1 tr=0 ts=6a09a1c9
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=ZxuoajvSgW0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=v3ZZPjhaAAAA:8
 a=SEPSIZnlKA0O9iT1Kh8A:9 a=IxSG75etxsVYPPdR13TJ:22 a=m7rIf0WiDq7R2lvFmMRz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDExOSBTYWx0ZWRfX92+4zMWvPwvl
 cg1MVS6qvE5pwJHuqo766lMBSeKABw+PlQzy3+XDhr5vGuPROc94gaQh6oVbMXnwsTM9RI41Y2F
 voQewbcxRiDr/bhVffJ4VSWKQ8TcKDFld/useXKqa7qmD8twntJPYX52n1Wl+wsttlXbRutoFE9
 +jJiFrQES1WKoJLEwPMXQ1EbAg0zmKczJeqFrqQtpGNPWr2ccBpvNPl0TXXyJI8BZZNUEkHQZve
 VxicdgNWDF5UvhtMeq06O+8A2j0fi9nSrpBZ6WJzxrk5hrScCcap4a1DE4c7WET5aevQnSI/7R/
 O3b6uz6LrcFYi9InR+LKGAeKK115Y2Zd7lcSOFgZ2I+jmmrjGUOpp3saD5PNLY=
X-Proofpoint-GUID: Zt4l9sG8gBM9onD0Qf4VAdXvnm_RYueo
X-Proofpoint-ORIG-GUID: Zt4l9sG8gBM9onD0Qf4VAdXvnm_RYueo
X-Apple-Category-Label: MjE0Nzk4NjU5NzY6JGNhdGVnb3J5JF9QZXJzb25hbCw=
X-Mailman-Approved-At: Mon, 18 May 2026 07:41:36 +0000
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

Replace "uinque" with "unique"

Signed-off-by: Sakurai Shun <ssh1326@icloud.com>
---
 Documentation/gpu/msm-crash-dump.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/msm-crash-dump.rst b/Documentation/gpu/msm-crash-dump.rst
index 9509cc422..474c0d265 100644
--- a/Documentation/gpu/msm-crash-dump.rst
+++ b/Documentation/gpu/msm-crash-dump.rst
@@ -70,7 +70,7 @@ ringbuffer
 
 bo
 	List of buffers from the hanging submission if available.
-	Each buffer object will have a uinque iova.
+	Each buffer object will have a unique iova.
 
 	iova
 		GPU address of the buffer object.
-- 
2.54.0

