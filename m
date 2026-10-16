Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D5CCCF2C4
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3142010E650;
	Sun, 18 Oct 2026 14:53:15 +0000 (UTC)
Received: from outbound.st.icloud.com (st-2004f-snip4-6.eps.apple.com
 [57.103.78.207])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CED9210E025
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 23:03:01 +0000 (UTC)
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-6 (Postfix) with ESMTPS id
 79E971800B84; Fri, 16 Oct 2026 22:56:28 +0000 (UTC)
X-ICL-RepId: 01a146ee-5b1a-733c-85ca-324e79cba4c9
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ5NHVoERQZFF0kFVBcOVk1fAlYfQgNcMFAbXwJCDxwTVhUTC1NWWxNVF0YJGQhdHRkKUFAGWhIYXBRcUFgeRhJWDV0JGRhGXlAbXwJCDxwTVhUTHUMZDysISgRDB0UCXgslEwlTVlsTVRdGCRkIXR0ZFVoJClcAQAtOAl0GXQBCDE4BXBlYBUUOSh5cGg1IFUsNWwN3AlEcVg1XQ1QEX04ZDEodUlZbE1UXRgk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1792191391; x=1823727391; bh=D8k+q+arHbHoWH+eKFHhgLofV6H0DicxRM3TSYV45hk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=OYXu4HWw3CNRh5UlVDpMwjFbGUHo8x/QXQmeO09w8C7N8tXKn5Ou1xhRipEBjo5MP/kgtLG4tQt9hBo9JZ2AVuvMe9gTO3uM62ZKt0EsadNfEypqUp2U71aHOrE6rPDhrWb96JCb6Rz/n1+VEtR0vclJrE83zghOJ8aCPBp33zIDJ6YuzQWg1icByoHY+m8LjIwmH+601TLrp5sYjwAxKfVzDwwq0hYVnHQMU/+BTJgYxsDK4xuUsL3Nj1LKR1INEUROtG6rWX883tF2k9kM8NDXK4GKdvJsgrsr0Sr7hVl0hAYPM+7kc3GPpIpu8crV/BDRxPIFebYDZctOxliLtg==
Received: from 252-PC-L.device.rit.edu (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-6 (Postfix) with ESMTPSA id
 10974180028F; Fri, 16 Oct 2026 22:56:26 +0000 (UTC)
From: Finn Zeruhn <fzeruhn@icloud.com>
To: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
 Sefa Eyeoglu <contact@scrumplex.net>, Coreforge <BC549b@gmail.com>,
 linux-kernel@vger.kernel.org, Finn Zeruhn <fzeruhn@icloud.com>
Subject: [PATCH v2] drm/edid: add non-desktop quirk for Pimax VR headsets
Date: Fri, 16 Oct 2026 18:56:21 -0400
Message-ID: <20261016225621.37572-1-fzeruhn@icloud.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261002013500.16903-1-fzeruhn@icloud.com>
References: <20261002013500.16903-1-fzeruhn@icloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CSkEvnX4graYTv-U4qk3b-ndBRss01nm
X-Proofpoint-GUID: CSkEvnX4graYTv-U4qk3b-ndBRss01nm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA5MSBTYWx0ZWRfXyLY9v2lfsUeh
 6id8nlM+3TWub+SbezwwZFdwdYNinwUPvtBQlDBo4IZ3iBGzxZxas84T5sfyBgOUlnyrUcL/3gO
 KePIMGYWUz4iYyn6y1o2szYKpQn+e3pF62BHU1NXUT47B+s/O1nMSKav50kLxDPMbiphyoKlmtC
 Yw7W+QMMZl/HUYCt6XtLFYuPq6WnVkpoefNuSU3m/+IlQoqmLhYZkEyZMxpxxjwfv8s4YO9yQvM
 oKQ0cnL07KSL0nyz9jIOl2036OzaueOe9tj2DvJ/LK3qCW5oU9Q+0wK6k+gfKjspElvjtm0aDOy
 2JYBYn45ZQwv96CIFUEnHo8UT1n1pBZ4amh8tJgmyUMckrqelwzOEENuOmpKiE=
X-Authority-Info-Out: v=2.4 cv=XNM9iAhE c=1 sm=1 tr=0 ts=6ad2ab9d
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10
 a=UWokjQvqbcQA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Tau1HEJIAAAA:20
 a=NEAV23lmAAAA:8 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=v3ZZPjhaAAAA:8
 a=9LFCdArbAAAA:8 a=ougUob9Pha3KhaONunMA:9 a=Vxmtnl_E_bksehYqCbjh:22
 a=Qd14GjuWW7UXhWQsD3Mv:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-JNJ: AAAAAAABUkq9VCyyT8kfz5Bkz0N0Kill39Wl+sXFX/rCZFqiqk2wgq9DajKJo3AD772SHBkkN8jjVPkQ0w42Ch6iB3F7llJKbey7CytESlXsa0EvdfGIx/+OIaxPxC74F6In5DYtX0p2NysaiGBKDREFEoI708lllF/pjhwsEmQXYk0e/ZlK8kx+trpCotwseD63kl85WMOkk1KaUKRTezJTQR+NriKnqnAGB95bdZva9m6hsNonaA+bPvZMMghcPO+CY8u14kC8/UYetrIkzREkBA0GyglRWYOsfk2Atf3M1GixsKOyd4lrITzc/VhYOMX9wqYvokltoVkNtgIIrbv+IgnskendsweEJHOSG+kKJtflUGZnyOvvAjb2n0emd6ql5nXoR5o63/EQ1nIXbY6u2blE1ADmeYHa1JEUz1fi3/PCnEdqvzJqUX17teQw0Yl+S0vkLvuZDj6XF5L2/7mMAgjgTCOXBqZDi+ealpO48z9xnyIwelCS2olfgaOnKRTqT1uS0gHceN5RR6++NsUzS2BeaybbUfBjssF2sfnaQV+MTAMUE6cYigwC1RYJBhIp42ruHttZvCfVoLPiK1aacx2jBjM9mGVQb6zdSdKs1VBB7WM7uNlIMJXrA9vZ2TxWrcmHJzDu7jWqHydLwThD9v3d4K/+6ZP3sH+sN0zqgifgJn8q91PM3QyWsUw5KEHsvWTos5v35S0WpzaOlOkLbNOxzMGmoAqr5nFH9m4qgMe7s+O9J84ewffq6Fl7DhOwedqPE/mTRiq+GFnoad+bK9i7gO6+v+hJcH1+4tW4kFnuEbq7Ug6UE0gQACHQ8aE6PE9EdMq3fymPKo0m1oWMsPVYeFEqJmckS9a6GDy56i3ZRdsONxvV2qsfZ+K6cW0eUFRLBRHW5vnwUDBFjx3M1fOqykRO8sf1VdiM11IXMi313Dwjes4n8SNCq1UvGfKqyrGLTQGl2Arz9Qbo3sRcWXgZchp
 kcojxXI0CWjNrFTVLf54tpTGb5QKzJ/FljJDm1f3EU9wGpzxA5mkIh3xiJ2wJSplrUtZWRNK34hXFVr5d4ymDIKGl+iMsGkB1Gj4Y3L7U2K3Te+ytArZy/DTjDqqqHplcqMbXrP5BR64HvS3aOXh5Cq9TzLGxsMHth3/tv1T2Cj8GqxoA5v+Lp+PcJvNY6LPb31Guu9rtizTS9mRtT5G+uUnXYoenfCJ/N6wGQWMl4KMHs2uI39Esf/qhUqUBHoQjgm92cbHZ6c5Bq8aHV08pgTvqT+48v1ORkfDprPl/QfknqF432D90X4Fz+z4HTzM2HTqZi90dtbPkvMMqCS9xEk72qF0kQATcoBDHlL007+FjpC5I7a5bnHJwxUQDW54Q91k=
X-Apple-Category-Label: MTE1NzgzMjUxMzU6JGNhdGVnb3J5JF9QZXJzb25hbCw=
X-Mailman-Approved-At: Sun, 18 Oct 2026 14:53:13 +0000
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

Pimax headsets have no Microsoft HMD VSDB, and their DisplayID
extension is version 1.2, while the kernel only checks the primary use
on DisplayID 2.0. They are therefore exposed as desktop monitors and
VR runtimes cannot lease them.

Add non-desktop quirks for the IDs used by current models:

  PVR 0x1019  Dream Air, Dream Air SE, Crystal Light,
              Crystal Super Micro-OLED, P2 series
  PVR 0x101c  Crystal Super 50 PPD QLED
  VRT 0x4c31  Crystal Super 57 PPD and Ultrawide QLED

The 57 PPD and Ultrawide QLED report Varjo's vendor ID "VRT".
The older Pimax P1 headsets report SVR 0x1019 [1], which is already
covered by the OSVR entry: name them in its comment.

Tested on a Dream Air. sboys3 collected the EDIDs and the list of
models [2]. The P2A EDID is in the linked issue #40.

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
Assisted-by: LLM
Signed-off-by: Finn Zeruhn <fzeruhn@icloud.com>
---
v2:
- Add PVR 0x101c and VRT 0x4c31 for the Crystal Super QLED models.
- Name the Pimax P1 in the comment of the existing SVR 0x1019 entry.
- Leave out PVR 0x101a and 0x101b from the issue, they are only in
  Pimax Play's device list with no EDID showing them in use.
v1: https://lore.kernel.org/dri-devel/20261002013500.16903-1-fzeruhn@icloud.com/
---
 drivers/gpu/drm/drm_edid.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 3148038747b6..e206a8246a9f 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -278,6 +278,12 @@ static const struct edid_quirk {
 	EDID_QUIRK('H', 'V', 'R', 0xaa01, BIT(EDID_QUIRK_NON_DESKTOP)),
 	EDID_QUIRK('H', 'V', 'R', 0xaa02, BIT(EDID_QUIRK_NON_DESKTOP)),
 
+	/* Pimax VR Headsets */
+	EDID_QUIRK('P', 'V', 'R', 0x1019, BIT(EDID_QUIRK_NON_DESKTOP)),
+	EDID_QUIRK('P', 'V', 'R', 0x101c, BIT(EDID_QUIRK_NON_DESKTOP)),
+	/* Pimax Crystal Super 57 PPD and Ultrawide QLED, uses Varjo's vendor ID */
+	EDID_QUIRK('V', 'R', 'T', 0x4c31, BIT(EDID_QUIRK_NON_DESKTOP)),
+
 	/* Oculus Rift DK1, DK2, CV1 and Rift S VR Headsets */
 	EDID_QUIRK('O', 'V', 'R', 0x0001, BIT(EDID_QUIRK_NON_DESKTOP)),
 	EDID_QUIRK('O', 'V', 'R', 0x0003, BIT(EDID_QUIRK_NON_DESKTOP)),
@@ -298,7 +304,7 @@ static const struct edid_quirk {
 	/* Sensics VR Headsets */
 	EDID_QUIRK('S', 'E', 'N', 0x1019, BIT(EDID_QUIRK_NON_DESKTOP)),
 
-	/* OSVR HDK and HDK2 VR Headsets */
+	/* OSVR HDK and HDK2, Pimax P1 VR Headsets */
 	EDID_QUIRK('S', 'V', 'R', 0x1019, BIT(EDID_QUIRK_NON_DESKTOP)),
 	EDID_QUIRK('A', 'U', 'O', 0x1111, BIT(EDID_QUIRK_NON_DESKTOP)),
 

base-commit: 509a6256d3fd8561d8864a56688dc6442441f878
-- 
2.56.0

