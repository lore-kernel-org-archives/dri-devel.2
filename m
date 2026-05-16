Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5AECD4F51
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 07:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E1DF10E6E3;
	Mon, 18 May 2026 07:41:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icloud.com header.i=@icloud.com header.b="L+HWPK+Z";
	dkim-atps=neutral
X-Greylist: delayed 2242 seconds by postgrey-1.36 at gabe;
 Sat, 16 May 2026 10:41:50 UTC
Received: from outbound.mr.icloud.com
 (p-west2-cluster4-host5-snip4-10.eps.apple.com [57.103.69.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3976010E151
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 10:41:50 +0000 (UTC)
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-1 (Postfix) with ESMTPS id
 AC1C9180014E; Sat, 16 May 2026 10:04:25 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQhKBUMDRQBBCFYBWANLVxQEG1sIUhhXE1gTVl8OXQIwUBtfAkIPHBNWFRMLU1ZRGFwdQAhUClkVC0EFXXcCURxWDVdDVARfUEsbDlwDS1oVVRcOAkIfUB9MFldDWhkcGVoUXBhTRVEfVFhDGUVWaUELTx1dGVscQmRYVwkKAlEcVg1XQ1QEX1BUEVdQC1kCQg9IBlwBWgJADUgFQwVaAkcJVQJAVANXFUodUAxcDgBJD0hzBFQHXQVdVlACWlUSBEAIVlBeCF4fTBw=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1778925868; x=1781517868; bh=z1uuttnWHoBOGMCJ+W0SZTjwptXK7tsCW7idcPuBMhg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=L+HWPK+ZZ9XszwBkH4w4sS6HBkaDqJ980O4aY/W2yQl2KEZQ2vU8Wt+JJMA3T25e7yrnucLR2faBPKeyv7zV1BAfTT+aYVAar4WqybN3g3/gGVEwcFkjJssvkdchnObG+xpfzfmbpDHsKbdkolj+gIA+8XLVHtHhRMh0J7t1vVSz3Rdu6PfL7i3/jgsvy06cAXRjdLLPDCvA/WKu2lDOXCxirwWiFw71+2Oe9x2mHW9dERxKK5wGegyw/bsesFZX5O89TGBtnMS2qZnZEHxEjwbnDuSMhU1VkTUi12IONRmX1PR1XLFRDenUqhdB7RrcVGl0ujsVLBAcXdwzaT1mNw==
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-1 (Postfix) with ESMTPSA id
 E186D1800105; Sat, 16 May 2026 10:04:21 +0000 (UTC)
From: Cheesecake <cheesecake2960@icloud.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Cheesecake <cheesecake2960@icloud.com>
Subject: [PATCH] docs: fix typo in mpo-overview.rst
Date: Sat, 16 May 2026 19:04:02 +0900
Message-ID: <20260516100406.21070-1-cheesecake2960@icloud.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8dRHMVkqXsqwYlhI4dVFsmnKaMI5Dsd6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDA5OCBTYWx0ZWRfX4HidBCuWzT9w
 1e3II25Qqo5DiR/Aw/ZWD1eir2jpeDTfpmMlARwq8CsBWAfgVKz8bq2238MiKKxWune315LK/jl
 1X0HmEA5gGS48jykLglxBkfTW5ld3WzhyDN+OcK9sXt9uhJ0I6hCtlzXjkP8vlbi2Cc6ITT9jhp
 cryyQblHHEHeMpRyIVjZa1qpb2q7lpeIECwVqw1BESLo/yRAXghjI45tcTRi/p0Ac4EQnak6JLi
 W59mbCWh84hFuHs8HB+1nuh0rPSNkBiuAL7/YsUmYkN8WL9HCIcnt3hNrqzsiPLkimy/y6JR0O8
 Cs7S8okeHYQJZ9VHwN4Vyv9/pOoB3Lly/7dOvWwB3+hxGJH+HXxlD6WVnB4ci0=
X-Proofpoint-ORIG-GUID: 8dRHMVkqXsqwYlhI4dVFsmnKaMI5Dsd6
X-Authority-Info-Out: v=2.4 cv=V41wEOni c=1 sm=1 tr=0 ts=6a08412a
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=sIGCgqHK338A:10 a=VkNPw1HP01LnGYTKEx00:22 a=v3ZZPjhaAAAA:8
 a=IDD1vTIlNhPWhZ1IPAAA:9
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

Replace "transparant" with "transparent"

Signed-off-by: Cheesecake <cheesecake2960@icloud.com>
---
 Documentation/gpu/amdgpu/display/mpo-overview.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/amdgpu/display/mpo-overview.rst b/Documentation/gpu/amdgpu/display/mpo-overview.rst
index 59a4f54a3..ed39e53ff 100644
--- a/Documentation/gpu/amdgpu/display/mpo-overview.rst
+++ b/Documentation/gpu/amdgpu/display/mpo-overview.rst
@@ -167,7 +167,7 @@ and interactions with operations such as DPMS and S3:
 - ``kms_plane_multiple@atomic-pipe-*-tiling-``
 - ``kms_plane_scaling@pipe-*-plane-scaling``
 - ``kms_plane_alpha_blend@pipe-*-alpha-basic``
-- ``kms_plane_alpha_blend@pipe-*-alpha-transparant-fb``
+- ``kms_plane_alpha_blend@pipe-*-alpha-transparent-fb``
 - ``kms_plane_alpha_blend@pipe-*-alpha-opaque-fb``
 - ``kms_plane_alpha_blend@pipe-*-constant-alpha-min``
 - ``kms_plane_alpha_blend@pipe-*-constant-alpha-mid``
-- 
2.54.0

