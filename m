Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA1E606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256 header.s=1a1hai header.b=ib0CQ+k4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 431061120E9;
	Thu, 12 Nov 2026 12:55:16 +0000 (UTC)
Received: from outbound.ci.icloud.com (ci-2007l-snip4-4.eps.apple.com
 [57.103.88.117])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F15510E474
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 23:26:22 +0000 (UTC)
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-11 (Postfix) with ESMTPS id
 96BC91800145; Wed, 11 Nov 2026 23:26:19 +0000 (UTC)
X-ICL-RepId: 01a1ccef-07a2-73d3-9a50-990d88191322
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1794439581; x=1825975581; bh=Q0nP5DdkcJ+oG5DRzHz/udyR2V/2gbvh0o/Ol8PCi/8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ib0CQ+k4xAG2nSIUnu/r7KgvGPV/S/3ELMpyvxKmisNx7471EF5pMZxsYL8kVRl4v3zox05fyOKE5J0tEDqjQbWKKH02IN8RKIm+3cp6ystpumbRL8PkWbftiHmpr1It88PjuxtvIP89otCs3lcZRGYaOjjoAZbRlg/dB7878o98T7FcaSkFLNSzIBj698ICjTNEmJYEy7IYz+Y2j34GrerlwzmnzVpXzHzlqOciFduAUjK6N9AoF1/7rVdbqST4AQEbzEPU+xp/J38xMVvxLpXN6PyYBSCVZdFPVS5SgOUZ+meRyqzfyvKFWvC0ak0k6dinrESkuP0vSpIcR2sNcQ==
Received: from 252-PC-W (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-11 (Postfix) with ESMTPSA id
 7F4C71800169; Wed, 11 Nov 2026 23:26:18 +0000 (UTC)
From: Finn Zeruhn <fzeruhn@icloud.com>
To: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
 Coreforge <BC549b@gmail.com>, linux-kernel@vger.kernel.org,
 Finn Zeruhn <fzeruhn@icloud.com>, Sefa Eyeoglu <contact@scrumplex.net>
Subject: [PATCH v3] drm/edid: add non-desktop quirk for Pimax VR headsets
Date: Wed, 11 Nov 2026 18:26:06 -0500
Message-ID: <20261111232606.2986-1-fzeruhn@icloud.com>
X-Mailer: git-send-email 2.54.0.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA5MyBTYWx0ZWRfX69j5URkb1Xnx
 Ze2aVZmsRxZwOLNVMv4HNQRkfQpN9z3+hS9y2UU2wQirNKs3w3BmSdb49l7fC0z7kl1tzCptguW
 46r+jGzE9r7uYylqg7WJo8Vl0QLhOrF/F15lUKQjnWNgJfeJodcMTEUXmeDQad/b1EIptXoXT4A
 mcYYVe3Ksw2nmzycx0c7kryVYYUYqF2CbXOr4ROr9poHBsAIPPKmKy42cPNxbsqqut7u0YetsZ4
 ikdcPmN9YdfHsiD3Kqj3j7zm/UO46ZMz3RVaPCcR+Bsjn7L89jc33JD0GbecW1JUYmg0roquqhv
 uDRhEo7xjTH+IXRTPrpxmIQbsQ8jaNYdI3e1N47JMdthff3aIVR+prgIOk3ICo=
X-Authority-Info-Out: v=2.4 cv=a9WlZkSF c=1 sm=1 tr=0 ts=6af4f99c
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10
 a=UWokjQvqbcQA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EYaFdmsEC1CjpenOt5ir:22
 a=jdzSJ-FtRUh52-zZQ77r:22 a=Tau1HEJIAAAA:20 a=NEAV23lmAAAA:8 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=v3ZZPjhaAAAA:8 a=9LFCdArbAAAA:8 a=ougUob9Pha3KhaONunMA:9
 a=Vxmtnl_E_bksehYqCbjh:22 a=Qd14GjuWW7UXhWQsD3Mv:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: f_Wrhe618QUMRDz3H3KWWya7RxS1vUhD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA5MyBTYWx0ZWRfX+HYEqv3Agppk
 Vy3oP8E+wyC9bDYcPc5x3KZkbo+gogmTTEtEckV0H8x78fWqqupWDWFQyayEOhFmg0RuDUPH4qE
 w+796sNg/ksYKtyvseCu0hSJugoIo1A=
X-Proofpoint-ORIG-GUID: f_Wrhe618QUMRDz3H3KWWya7RxS1vUhD
X-JNJ: AAAAAAABlabcNIdCLpoBHk62ipbZW7323196+AeXmCItgzddApsa2j6QHaba6YFRW7n/4s
 SpFP1xPMg1D+smgxDvKiMjq8BlVUcoukboYxOx7gJVDt309M4h5cvteH9h0KNPRgJkTsN4
 OvLegFkCleZsNFMUjNheHAm5Eba2at13EX/IwLMXh0neG3++ZYInIqoGHM94hPCFxIbpyc
 gIxMAQtZDoyY8lotLuBvWDBNzPbE+Sj9LAumEU0ntANkYrFWIijKcYt0SzpF7fvhAy/hqo
 nwzCiIt+KQCSJfXrmj/2jy+wyc6vIS48QEwprHbFodHe78V944unjGoaDTRiSAIi38TpeT
 w+4sUPIgdlf0REO7s29E1jUv3YVOhwYEpqWjtHMx0A3RROnIS+1mZgOIR3dZlspsoS4Oeq
 OPnQjR8xzdYXBWw2qlz5OLaOdgjqmafeeo34LFhY5q3+VyFmI78K7T6sSA9l/f7WqrBNev
 yrhUOp/pddeLrSwKMrpv8BIqXvb4fVqPs4zthRqrwXw2Qpeq2VSmx88ZsYOFHeGd6h2q48
 zRzUpWhIc6g0zyl9lsU4XDyty5c6jPl74yOfMYZpkoUPIgHhESs1+QTXHnIhaw7zQgZuHo
 0BmaA1fiUdOxXXQbSjzMerkPFk9aYrCzmMnhMlJd5DEByVLDeJ0XUHkr4vybyy6SRfJYGu
 qSRsStf2I/si3a6hlowB3ifGHAQmdGrwuNyVl05kiWbn+h9+CfP96J51pa36eEfaNvQ9ZY
 8U3WuLfd0VbMfJFTxu0jgRSyJvJX9YMGcv35/ds0aTcXCAd2QBs2iZQGzZHQHVZZBYl1QS
 B5VY3zpHQq4tswGlPS6cOaPfceWNcqeNQK0nB27Qmm1RhOPJTwfkW5/0HYImaBwPkF59xD
 6c2gDJtYTCB3MMNnyLWrJpGWVGnDJ+2fftiIU9KNd+8c0pD6Huno07EUkjtxAUet2JLJTt
 Ogzy6Cpn36Vg1WtBGeVHMYHdAZTYgcwF3Ja09pEvXAfktUt2f2PNaoZoIIycQTKBFUmdrE
 5t6Vnj2MU4dERDmJXm/vpyiLt8GObReL3/IA2XbQp8Ra48OH+wSJjoGZD6kohi6lA/JBtv
 caKmuxeUfAD3xkKmRAC014XN2ydSPDQSvzs7DzTHJo8PIpKMu4cHgtfMV2JlSW9Qz+HmJ+
 gfBBUj43aBgW6qFX1XfJ4JinDqBnKSTlTPYip1aJUEsHe58xRWf1xfXbNeITCyondNS4jR
 wkwMsLrpIFBk+Dgn4yAnCBd/0cz3zLsZp/Ptc6OL8SVWoQ7XJaA5HOkz3UGXnTtd77Tg3J
 Dc+nde7hga2+tN8JSKb3WiaX+9Jhsrgtlohsebp9jVgZjDSu8I6nye
X-Apple-Category-Label: MTE1NzgzMjUxMzU6JGNhdGVnb3J5JF9QZXJzb25hbCw=
X-Mailman-Approved-At: Thu, 12 Nov 2026 12:55:13 +0000
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pimax headsets have no Microsoft HMD VSDB, and their DisplayID
extension is version 1.2, while the kernel only checks the primary use
on DisplayID 2.0. They are therefore exposed as desktop monitors and
VR runtimes cannot lease them.

Add non-desktop quirks for the IDs confirmed by EDIDs:

  PVR 0x1019  Dream Air, Dream Air SE, Crystal Light,
              Crystal Super Micro-OLED, P2 8K models
  PVR 0x101a  P2 5K XR and 5K+
  PVR 0x101b  P2 5K Super
  PVR 0x101c  Crystal Super 50 PPD QLED
  VRT 0x4c31  Crystal Super 57 PPD and Ultrawide QLED

The 57 PPD and Ultrawide QLED report Varjo's vendor ID "VRT".
The older Pimax P1 headsets report SVR 0x1019 [1], which is already
covered by the OSVR entry: name them in its comment.

Tested on a Dream Air. sboys3 collected most of the EDIDs, namely those
of the Crystal and Dream Air models [2]. The P2 EDIDs are in the linked
issue #40.

Dream Air EDID:

  00 ff ff ff ff ff ff 00 42 d2 19 10 01 00 00 00
  ff 23 01 04 a5 00 00 78 00 30 fd ae 50 3b b2 23
  0c 47 4a 00 00 00 01 01 01 01 01 01 01 01 01 01
  01 01 01 01 01 01 00 00 00 10 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 10 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 fc 00 50
  69 6d 61 78 0a 20 20 20 20 20 20 20 00 00 00 fd
  08 3c 64 e9 7b ff 01 0a 20 20 20 20 20 20 02 c2

  02 03 0f c0 23 09 07 07 83 01 00 00 e2 00 4a 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 42

  70 12 2b 00 00 03 01 28 43 08 04 88 bf 1b bf 01
  c7 80 2f 00 ff 0e 2f 00 1c 80 00 00 cf 39 03 08
  bf 1b bf 01 c7 80 2f 00 ff 0e 2f 00 1c 80 00 00
  dd 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 90

Link: https://github.com/linuxhw/EDID/blob/master/Digital/Sensics/SVR1019/302D58069F6B [1]
Link: https://github.com/sboys3/DisplayInfo/tree/main/outputs-nv [2]
Suggested-by: Sefa Eyeoglu <contact@scrumplex.net>
Closes: https://gitlab.freedesktop.org/drm/misc/kernel/-/issues/40
Signed-off-by: Finn Zeruhn <fzeruhn@icloud.com>
---
An LLM helped prepare this patch.

v3:
- Add PVR 0x101a and 0x101b: EDIDs from a 5K XR, a 5K+ and a 5K Super
  show them in use.
- Drop the Assisted-by tag, which checkpatch rejects.
v2: https://lore.kernel.org/dri-devel/20261016225621.37572-1-fzeruhn@icloud.com/
- Add PVR 0x101c and VRT 0x4c31 for the Crystal Super QLED models.
- Name the Pimax P1 in the comment of the existing SVR 0x1019 entry.
- Leave out PVR 0x101a and 0x101b from the issue, they are only in
  Pimax Play's device list with no EDID showing them in use.
v1: https://lore.kernel.org/dri-devel/20261002013500.16903-1-fzeruhn@icloud.com/

 drivers/gpu/drm/drm_edid.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 314803874..9e1324454 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -278,6 +278,14 @@ static const struct edid_quirk {
 	EDID_QUIRK('H', 'V', 'R', 0xaa01, BIT(EDID_QUIRK_NON_DESKTOP)),
 	EDID_QUIRK('H', 'V', 'R', 0xaa02, BIT(EDID_QUIRK_NON_DESKTOP)),
 
+	/* Pimax VR Headsets */
+	EDID_QUIRK('P', 'V', 'R', 0x1019, BIT(EDID_QUIRK_NON_DESKTOP)),
+	EDID_QUIRK('P', 'V', 'R', 0x101a, BIT(EDID_QUIRK_NON_DESKTOP)),
+	EDID_QUIRK('P', 'V', 'R', 0x101b, BIT(EDID_QUIRK_NON_DESKTOP)),
+	EDID_QUIRK('P', 'V', 'R', 0x101c, BIT(EDID_QUIRK_NON_DESKTOP)),
+	/* Pimax Crystal Super 57 PPD and Ultrawide QLED, uses Varjo's vendor ID */
+	EDID_QUIRK('V', 'R', 'T', 0x4c31, BIT(EDID_QUIRK_NON_DESKTOP)),
+
 	/* Oculus Rift DK1, DK2, CV1 and Rift S VR Headsets */
 	EDID_QUIRK('O', 'V', 'R', 0x0001, BIT(EDID_QUIRK_NON_DESKTOP)),
 	EDID_QUIRK('O', 'V', 'R', 0x0003, BIT(EDID_QUIRK_NON_DESKTOP)),
@@ -298,7 +306,7 @@ static const struct edid_quirk {
 	/* Sensics VR Headsets */
 	EDID_QUIRK('S', 'E', 'N', 0x1019, BIT(EDID_QUIRK_NON_DESKTOP)),
 
-	/* OSVR HDK and HDK2 VR Headsets */
+	/* OSVR HDK and HDK2, Pimax P1 VR Headsets */
 	EDID_QUIRK('S', 'V', 'R', 0x1019, BIT(EDID_QUIRK_NON_DESKTOP)),
 	EDID_QUIRK('A', 'U', 'O', 0x1111, BIT(EDID_QUIRK_NON_DESKTOP)),
 

base-commit: 3944ca3e6b7d25e545e8ef6498f69941e8e0c8ae
-- 
2.54.0.windows.1

