Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CF4C982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33F5210EF4E;
	Wed, 23 Sep 2026 10:26:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OrPgyRPU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gI4LDNg4";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A6A510E89A
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:26:43 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NA2tM82951867
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KRU0cZzME1FoG/j+TvL17uJYow6/6D6BMcV1RVr7hUA=; b=OrPgyRPUXd19SZjq
 yxenaCAK/rVMzwNyvviWmyFKvcG++SVPikn61GTUJGKa7KQvF0CukarT6ghNuTi2
 VkaqiMGolVAvn2bb+IGmmlkeT9Gx8X80LfZmyc80n2bihnd3aWsOJ7yB5cbSUvCD
 5gMoLwD1dyreuSrPdCNatkqnKL+yD6iJop4mfRGbaLXnjkyLQEZ16f1LVxRrm53O
 vPvCpS6nEMB22Mx+y1tZ88teXaJyuUSEVmTV2+eZH2z43d4B2pmzAl7XCclEL1ef
 IjeQBeBBv9oe/6M67Ck61X13d+10ZmBn4G6vvVdx0BBi0ehXNdfRBOxgKP1cSC9C
 E2MFLg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv32qtbgf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:26:41 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1438fef603cso1264042c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 03:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790159201; x=1790764001;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KRU0cZzME1FoG/j+TvL17uJYow6/6D6BMcV1RVr7hUA=;
 b=gI4LDNg4xSF2Em+YFw/mmbjQYPLrst2MH1tkR5Bk2UnMZFEzmjbkYtcHNGE921OAse
 51dbUguxSE+W9IiwvmOEyQfkLHs0QWFyOIc0IDqeC9X1ynRYQoNIh0o+25ealzZrIR4e
 X3kyYx8NgW5tb2yEgZqB4eR7KMGDmAoNVobC+55hIuO4IQLz0ZC7qKNpIaawlV9cEdXX
 0ROicLSp3z7qiFwg3JNaJ4nbkwTIsYf4wc1BfPykthUgmkqisshg9gWOyERf8O67EA1L
 iMvPuiDjQ/rz7WMrMCiop7LTxaoiNV25MZ0+Whsp2O3mvIsJdzU9A9lFFeoLHvYbKKdF
 cI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790159201; x=1790764001;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KRU0cZzME1FoG/j+TvL17uJYow6/6D6BMcV1RVr7hUA=;
 b=vtsF1uTiygkpVbnmb+ZZ/V+zU34YguM2wS7eWBGpALPy27z2YgDSYnUamyP1J74439
 dWGpFYsY/M3Ha1OnL09ab5H6JVnrmePbRGGi3zaLQRMDX3OdBD6l8LUDopONGYbmu+WH
 oSXfwTHZlcYS95MSUrc2voQx0iDU+HDTWQDfqemUHVW7v6uTt/9DTOeecP95vTTYz6ZZ
 HJihyiZCt+ZMbJmnj1nzIowVQR5ofN9KRAlyZaSoL1yZO81HmJZhmuKMdlPfqCKe2tA1
 WHX00TTD1XYbqL8uD8fFrozTi4Hff5yo07rMAl7oJolYTQZWvgo7g3Kl/L9aSAYjDOvi
 Zurw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8l+zwbAK7gsds3aUMZgAw0bCizdByOkcwGMRUtkipMv+0xXLv7gA8NmxB0jlSk0XJjAgEOpSz5Qk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n1bbrwLskB7kJBpg87NQXo5fEOnVJgeJFroQraDk28wFd4qrLB
 mg2jDuyZv2vx2ra8U91jDj+z8s9smjcr6XAs9YleEQb2n/jolNhVZUIDpzpYC62vJYwXx+n3AFr
 9jp7mQasxXcQ68eNGkY08DRGPcfiZYLgWBz5D4FGvmopMEr9bLBD6AcbhTh/o6CKLrsTEWRI=
X-Gm-Gg: AYBFou0GJJDhWuKDsiKH3SvV5eFY/7hypqOlAJOQdJUwJKNKwuwiBkkZjyh4Yf+ivIk
 rH8gpJ13pDQSao6XU9uP3C/qx5DpUv9OwmWDJtErm4uHg5/wytBGLq8TcBOq/8uguPjYNn4D/9B
 mupMVTzBGAvmLBS9G0a12lLKCEuSjJgKUmq0aVtFGJ7OShrRWuOyFpw2CDPgkhm7d75XNcWCR+5
 NjJ6L4UxxYyJlL4IxiklukuJJncV/VKU8fpFAO0FCTD3HLvwxRp8c//bYeNQGkb4UQOYS/bYPxr
 JuC3691AKTMHUWMep6v5lkL02oZzCBhzyA43yJVprFO1ZTmBpKqv6Q/fnQfCM2onW3GNXJxPfgQ
 WAdLKk7NVFIQv/3nD6gVDpEY=
X-Received: by 2002:a05:7022:282:20b0:137:ea7d:a5fc with SMTP id
 a92af1059eb24-144f9179536mr2813767c88.22.1790159200909; 
 Wed, 23 Sep 2026 03:26:40 -0700 (PDT)
X-Received: by 2002:a05:7022:282:20b0:137:ea7d:a5fc with SMTP id
 a92af1059eb24-144f9179536mr2813727c88.22.1790159200327; 
 Wed, 23 Sep 2026 03:26:40 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f98a288esm8766646c88.13.2026.09.23.03.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 03:26:39 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 15:55:44 +0530
Subject: [PATCH 04/15] drm/msm/a6xx: Factor out RPMh arc-vote helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-hawi-gpu-v1-4-0c3c79a1a470@oss.qualcomm.com>
References: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
In-Reply-To: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790159163; l=6066;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=CHLjdgbBFmYAxDYgBcG23Bc5Mf99naNoUTb/q1yjs/w=;
 b=+Rp6S1IwhTCXU93ZAg8mgdTbPXp45wPbraxUZ/P1QOMC8I8WlimNA/tiubX2aEmtEVVidHQtk
 H++MFfIe+ZWBNB5U6dNCkDINdR2pBBg6Z0oonZgj5HTa+BTdrZZvthV
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=SJnXx+vH c=1 sm=1 tr=0 ts=6ab3a961 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=5x2u8yzsEs7RXICRzdUA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: msdrPNquT6KnrS0NMzuI3SZsZlvTfq6_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfX0t6+PmV3ekUw
 EE7FoJZ0OzzhEWlS6OOTyxr/zGYJLF7ngmAj2keuNS5g1AAa1Cv65vZMWJCusbHY4nrgm4HRXLM
 p3zw/LNJlX351B4Pa+oSfLBMoU64b0g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfX2NM4qNRDuEe+
 eX3utkY0p/bKAR9kIEE2vzIOuKMv9yAkQn3dvu1/AhTEN4UI6RaipEVJqpkVNIU4/BClVDx/UlC
 +QP9ayQmsrvCKr5GNfZDf/URrtoZjNxFAtppXpQwnPn0EUsAHpQ98/GkOmEmPLanq+4p6O3kT5v
 rqkRp2WNTxTm9ssdMNy04mRTfSmI99JO+pl9vc0zGlPXBe6+MfukuyBbnLF1Te5FLgLK8jlb5Kb
 B82Ga1NqtC/dUwBsI3QXkHuDQ/SMimHEHSPI/5ENI7cqQLSM3cyntWI3upjlQMLfdTkQNkGZMRP
 oSMz92Qo9NfBREC4W34a64aVyDEbFEtojgyvAeWJhbgRHIGDNDlzasWTkB48G4pfxUEgh3S3mDH
 tbfliNYVpd6NTZSOOqRvDtMO1jtlSO5BOp0LIXxxPcLpEa7ziZmlSL2SVZzTRTbdNalte5OdKA3
 fAAaMIopbGUvuUk8oag==
X-Proofpoint-ORIG-GUID: msdrPNquT6KnrS0NMzuI3SZsZlvTfq6_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230041
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

The GMU RPMh vote construction repeats two patterns across
a6xx_gmu_rpmh_arc_votes_init() and a6xx_gmu_rpmh_dep_votes_init():
reading a cmd-db aux-data resource (with the same "halve the byte count
and reject empty" handling), and scanning an arc level array for the
first corner that satisfies a target level.

Refactor out a6xx_gmu_rpmh_read_arc() and a6xx_gmu_rpmh_arc_index() to
reduce code duplication and improve code readability.

Assisted-by: LLM
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 138 ++++++++++++++++------------------
 1 file changed, 63 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 161b360bf3eb..0ed01ce1c5c5 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1711,74 +1711,85 @@ static unsigned int a6xx_gmu_get_arc_level(struct device *dev,
 	return val;
 }
 
+static const u16 *a6xx_gmu_rpmh_read_arc(const char *id, size_t *count)
+{
+	const u16 *vals;
+
+	vals = cmd_db_read_aux_data(id, count);
+	if (IS_ERR(vals))
+		return vals;
+
+	*count >>= 1;
+	/* Exclude the trailing zero paddings if there are any */
+	while (*count && !vals[*count - 1])
+		(*count)--;
+
+	if (!*count)
+		return ERR_PTR(-EINVAL);
+
+	return vals;
+}
+
+/*
+ * Find the first index in an arc level array whose level is greater than or
+ * equal to the target. If no level is high enough, either clamp to the
+ * highest available level (@clamp) or fail, dumping the list.
+ */
+static int a6xx_gmu_rpmh_arc_index(struct device *dev, const u16 *arc,
+				   size_t arc_count, unsigned int level, bool clamp)
+{
+	int j;
+
+	for (j = 0; j < arc_count; j++) {
+		if (arc[j] >= level)
+			return j;
+	}
+
+	if (clamp)
+		return arc_count - 1;
+
+	DRM_DEV_ERROR(dev, "Level %u not found in the RPMh list\n", level);
+	DRM_DEV_ERROR(dev, "Available levels:\n");
+	for (j = 0; j < arc_count; j++)
+		DRM_DEV_ERROR(dev, "  %u\n", arc[j]);
+
+	return -EINVAL;
+}
+
 static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
 		unsigned long *freqs, int freqs_count,
 		const char *pri_id, const char *sec_id)
 {
-	int i, j;
+	int i;
 	const u16 *pri, *sec;
 	size_t pri_count, sec_count;
 
-	pri = cmd_db_read_aux_data(pri_id, &pri_count);
+	pri = a6xx_gmu_rpmh_read_arc(pri_id, &pri_count);
 	if (IS_ERR(pri))
 		return PTR_ERR(pri);
-	/*
-	 * The data comes back as an array of unsigned shorts so adjust the
-	 * count accordingly
-	 */
-	pri_count >>= 1;
-	if (!pri_count)
-		return -EINVAL;
 
-	sec = cmd_db_read_aux_data(sec_id, &sec_count);
+	sec = a6xx_gmu_rpmh_read_arc(sec_id, &sec_count);
 	if (IS_ERR(sec))
 		return PTR_ERR(sec);
 
-	sec_count >>= 1;
-	if (!sec_count)
-		return -EINVAL;
-
 	/* Construct a vote for each frequency */
 	for (i = 0; i < freqs_count; i++) {
-		u8 pindex = 0, sindex = 0;
 		unsigned int level = a6xx_gmu_get_arc_level(dev, freqs[i]);
+		int pindex, sindex;
 
-		/* Get the primary index that matches the arc level */
-		for (j = 0; j < pri_count; j++) {
-			if (pri[j] >= level) {
-				pindex = j;
-				break;
-			}
-		}
-
-		if (j == pri_count) {
-			DRM_DEV_ERROR(dev,
-				      "Level %u not found in the RPMh list\n",
-				      level);
-			DRM_DEV_ERROR(dev, "Available levels:\n");
-			for (j = 0; j < pri_count; j++)
-				DRM_DEV_ERROR(dev, "  %u\n", pri[j]);
-
-			return -EINVAL;
-		}
+		pindex = a6xx_gmu_rpmh_arc_index(dev, pri, pri_count, level, false);
+		if (pindex < 0)
+			return pindex;
 
 		/*
-		 * Look for a level in in the secondary list that matches. If
-		 * nothing fits, use the maximum non zero vote
-		 *
-		 * The secondary rail depends on the primary rail, so match it
-		 * against the quantized primary voltage (which is >= the
-		 * requested level), not the requested level itself.
+		 * Look for a matching level in the secondary list; if nothing
+		 * fits, clamp to the highest available vote. The secondary rail
+		 * depends on the primary rail, so match it against the selected
+		 * primary voltage (which is >= the requested level), not the
+		 * requested level itself.
 		 */
-
-		for (j = 0; j < sec_count; j++) {
-			if (sec[j] >= pri[pindex]) {
-				sindex = j;
-				break;
-			} else if (sec[j]) {
-				sindex = j;
-			}
-		}
+		sindex = a6xx_gmu_rpmh_arc_index(dev, sec, sec_count,
+						 pri[pindex], true);
 
 		/* Construct the vote */
 		votes[i] = ((pri[pindex] & 0xffff) << 16) |
@@ -1794,16 +1805,9 @@ static int a6xx_gmu_rpmh_dep_votes_init(struct device *dev, u32 *votes,
 	const u16 *mx;
 	size_t count;
 
-	mx = cmd_db_read_aux_data("mx.lvl", &count);
+	mx = a6xx_gmu_rpmh_read_arc("mx.lvl", &count);
 	if (IS_ERR(mx))
 		return PTR_ERR(mx);
-	/*
-	 * The data comes back as an array of unsigned shorts so adjust the
-	 * count accordingly
-	 */
-	count >>= 1;
-	if (!count)
-		return -EINVAL;
 
 	/* Fix the vote for zero frequency */
 	votes[0] = 0xffffffff;
@@ -1811,26 +1815,10 @@ static int a6xx_gmu_rpmh_dep_votes_init(struct device *dev, u32 *votes,
 	/* Construct a vote for rest of the corners */
 	for (int i = 1; i < freqs_count; i++) {
 		unsigned int level = a6xx_gmu_get_arc_level(dev, freqs[i]);
-		u8 j, index = 0;
+		int index = a6xx_gmu_rpmh_arc_index(dev, mx, count, level, false);
 
-		/* Get the primary index that matches the arc level */
-		for (j = 0; j < count; j++) {
-			if (mx[j] >= level) {
-				index = j;
-				break;
-			}
-		}
-
-		if (j == count) {
-			DRM_DEV_ERROR(dev,
-				      "Mx Level %u not found in the RPMh list\n",
-				      level);
-			DRM_DEV_ERROR(dev, "Available levels:\n");
-			for (j = 0; j < count; j++)
-				DRM_DEV_ERROR(dev, "  %u\n", mx[j]);
-
-			return -EINVAL;
-		}
+		if (index < 0)
+			return index;
 
 		/* Construct the vote */
 		votes[i] = (0x3fff << 14) | (index << 8) | (0xff);

-- 
2.55.0

