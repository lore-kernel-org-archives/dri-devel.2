Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98630D58CDC
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 07:09:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0496E10E3C8;
	Mon, 23 Mar 2026 07:09:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="N3YHFNpV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R/BgUqhV";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DA8810E3C8
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 07:09:13 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MKoNZL424216
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 07:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=e4Onam2xKEprwtaCsFgnfb
 MnloVHrOlcZBQtDZvX3b0=; b=N3YHFNpVRaoj1wn1TNnJozWJX0l5n1gm8KKrZw
 DsN4Y5SYXyFxf1gJUddlPJGflAgjptzgALfOJ9g6+A/uKnq62ItN/21AiE/MqtLk
 YhVqgK+37B1W7Xt2RNsSxfOC3lz07VSZtyQSoignG1OR1Djuz8eVBIIk2a2EpDGp
 vzMDvybsogHmCWnAbQSJ2QlMSH8GFsUGPv/EZBHpTFqycMCFlYcZ4wSsBIx2tc0K
 E8+qHPDj+VJGdwZHldzq+n+6zBJte2MMArmLVXEJNVrsjBVFIn1f1dV0FlqpTutA
 nLUjxWsQjbcEHPOT8uxzZoJqQea7Lps5Y/oRztN1oEGmgjIA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1jwvm7ve-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 07:09:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b0565d77a6so50922405ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 00:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774249751; x=1774854551;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e4Onam2xKEprwtaCsFgnfbMnloVHrOlcZBQtDZvX3b0=;
 b=R/BgUqhVprddo81bth9DajkudYj86OBRt0d+AVNRv9sUbSchJRpsFARCieZoEFKbLG
 a6vIA/tDj4tuiaMq66R+HgabUH8PFDm71FZA5jtwC/p8dcmSvjyJjJEEaGfvpIo5NTBX
 nQ7nRDJZIrZAujZmHnFIq1MXMBxz1qifkWOzlx9XmxA3cK/tVy3NNJwnqByo+DXFuYMN
 SB+0nlOmbc7lbcTRTKqU4ZucFZsrTNmTNIVzaTwbSEdhpJkpqCt1hYDXvfNcM6ZIFFKb
 COFIcngpL8dODhshrHcJQ5sulH0IBXH4w4LIm7huY6evkQnt9aiXqBs+2b0VOeSK5cjI
 YRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774249751; x=1774854551;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e4Onam2xKEprwtaCsFgnfbMnloVHrOlcZBQtDZvX3b0=;
 b=bbjeovQqEC59QFybeEOFFwUaVZTnpeAB+w+QRfxtf3l01Ho4igcwYMJWHcjd6BBfp7
 /+7Gg0TDQAutnEdTXQKm5kdi0HQopNkNou0f3qpt7yDBXxjUZdBft9dqwXC+XC15dZ6a
 M9dGD0MvSmfVyyomUKx+VtWNPjAUalzJW+pYyRk7b+C9cqatZJ1qKC+yRS/l21bi/lXz
 f5narnsU1YotYMBBuhVwSIWBUYfQ2LnpeOjeRXYYptlsgsUUQZkr084V+fBxev1YzIIq
 cLvxt5mZz1eRUhFIvHNwjOz/UUI8Bst838mfzHQBQdRTKIMiZdUnUJ0EuFUK4fLqIvEo
 U/Xw==
X-Gm-Message-State: AOJu0Yzg4H7uX7/RoDJjLAY4sZ7kyluNkEsZhV56Vb3QJaIevEmEPPev
 8cff4m2/AfZGTnb0ejgBlepMJDcxZ9nRLZc1Dt+0fc0bRP44QxfGCKxxFsNMMcBT2BF83Ggw0jc
 FiA7c1W4CEq1z/kJY5Yl8awJ9xstY9UB4L5O0fPVOiJ4aoPbXWXxgiEb7/sFe64PA4vJsKgA=
X-Gm-Gg: ATEYQzy4Ex9ZjI1SId1iuQsFYFwU9DBxRl9zoI6/2Ov3Bp0G/ivUFrDQIkcrJGwScF6
 8XyuKTo0cHlJUulH2tFFOrfMT/EWatmOouAI5jGDqVxwrqfhBkAbaSBnBwAhm2DJ7roj8v0FMJs
 XtcTpalNGDzd8vli1zvmk3v9leJt/L1LbL9iw44X30o1QR8Ztw8SL5nMetCqcdfTj4wgiPvu/0V
 fSbC17I0rqNk/+IwDKP0ghjsPkjW3lQPt4FxWZyz3uDrbaRztQJmjMLuKguGBDkCGoc6jZNP9Po
 lWZQ8JQJ7WiQVO2fsrV2q0bf3DSCAmFx4mfCxEACk8+2KKDbdsVs+Rd8ooyiPVSwj+osn5hoAg9
 PlyibDGo9POrd441Hw9sRKoy20pA0dr2xQp5j0rYwFpcs4Yt/lqayjMu9+M4x4w==
X-Received: by 2002:a17:902:f709:b0:2b0:71da:4ed7 with SMTP id
 d9443c01a7336-2b082769f3cmr104170965ad.25.1774249751327; 
 Mon, 23 Mar 2026 00:09:11 -0700 (PDT)
X-Received: by 2002:a17:902:f709:b0:2b0:71da:4ed7 with SMTP id
 d9443c01a7336-2b082769f3cmr104170625ad.25.1774249750671; 
 Mon, 23 Mar 2026 00:09:10 -0700 (PDT)
Received: from hu-botlagun-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083655b45sm133118795ad.42.2026.03.23.00.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 00:09:10 -0700 (PDT)
From: Venkata Gopi Nagaraju Botlagunta <venkata.botlagunta@oss.qualcomm.com>
Subject: [PATCH v5 0/2] This series adds LT9211C bridge driver by extending
 LT9211.
Date: Mon, 23 Mar 2026 12:38:51 +0530
Message-Id: <20260323-add-lt9211c-bridge-v5-0-9c63bb035c17@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAPnwGkC/33NPQ7CMAwF4KugzKSynfQHJu6BGNLEhUgthQQqE
 OrdSTsghsJi6VnPn18icvAcxXb1EoEHH31/TiFfr4Q9mfORpXcpCwLKYYMgjXOyvW0I0co6eJc
 auSFsbI22AiXS4SVw4x8zuj+kfPLx1ofn/GPAafuXG1Ci1A2pUkPDCLjrY8yud9PavuuyNMSkD
 uojIWG1KCkJEpmhKMGAq+mHpL8k0ouSTpKGgkvFliqbL0jjOL4BExa4cE8BAAA=
X-Change-ID: 20250910-add-lt9211c-bridge-5a21fcb1c803
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>,
 Nilesh Laad <nilesh.laad@oss.qualcomm.com>,
 venkata.valluru@oss.qualcomm.com, jessica.zhang@oss.qualcomm.com,
 Yi Zhang <zhanyi@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774249743; l=2066;
 i=venkata.botlagunta@oss.qualcomm.com; s=20251110; h=from:subject:message-id; 
 bh=ZixNuX96anr+2evLY02oha9TOOZszn+4rGj7MvKNj3k=;
 b=5ENlYrASWDTxfX0mMXw01Vp/f3S1xHPH80VS2hy75iL3AX3qCUPpW1Dw7U/MyDnyQVVGuZyZZ
 kWV28K5Ak3RBbkRhIhNpZBGwcwXZRqmJCnfg+wKhPnDgB6c7Clj8eTW
X-Developer-Key: i=venkata.botlagunta@oss.qualcomm.com; a=ed25519;
 pk=/SnYBwlkTzDCLnHFgEY0qFwPgKIV+aQWRbc3naiLzrk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA1MyBTYWx0ZWRfXzCjz/nMPKWmh
 KY69JFKHXG3TgNMRWjgSeLP0Bi5Legca74KlE7mXVM+xnaJOBQ87Rtm72AID9/PQ9+g8vVwjCwH
 owGMNkA0NQO5EkVaNV3A1+gCBSiuDCMwC+29I0oS2uBdgiFBW23Fo90az8B3h6vaS60umB3SfCC
 z+ehFIxYbF3f4pYHgLh/wvU+b/E8PJDtATYyHqXe/XIggHtJPNh9o/MeLnDI86sNMMkuq021YbL
 eVAe5RByTx1HzXOGbFrkkb8Z6oNiH0pNX9onyoSwLnGiMFAKvr4/ezqSqT4dXYJ+EN7L3o5u5z7
 r5GwvepX9BY87qT4Txgnp/xLgtnANN/a2hr8C4gHwpflepNTSWvRj3S1PDJyIoCdP8Y0nHmVxz+
 VHExaxI+BaVcpQssA00CKzhqekxPIo1l7f8zOJOfeckNcfz/SPSJ+F+4PHwM6VkewwrBx7bovDv
 EJdxNkdVOZnKsl0kSsg==
X-Authority-Analysis: v=2.4 cv=bcdmkePB c=1 sm=1 tr=0 ts=69c0e718 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lZVLp-onbeaezkPo7RwA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: yDzxuQCEOazcGxyAL0UXsxfnOzSvG-E-
X-Proofpoint-GUID: yDzxuQCEOazcGxyAL0UXsxfnOzSvG-E-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230053
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

LT9211c is a Single/Dual-Link DSI/LVDS or Single DPI input to
Single-link/Dual-Link DSI/LVDS or Single DPI output bridge chip.
This adds support for DSI to LVDS bridge configuration.By Extending the
existing lontium-lt9211 driver to support DSI-to-LVDS
bridge configuration.

Signed-off-by: Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
---
Changes in v5:
  - Addressed code formatting in lt9211 driver (no functional or design changes)
  - Addressed v4 comments on lontium-lt9211.yaml.
  - Link to v4: https://lore.kernel.org/r/20251224-add-lt9211c-bridge-v4-0-406e73ec28c5@oss.qualcomm.com

Changes in v4:
  - Removed lontium-lt9211c.yaml.
  - Extended lontium-lt9211.yaml to support LT9211C.
  - Link to v3: https://lore.kernel.org/r/20251218-add-lt9211c-bridge-v3-0-1ee0670a0db2@oss.qualcomm.com

Changes in v3:
  - removed lontium-lt9211c as separate driver
  - Add support to lontium-lt9211c bridge driver by extending the existing lontium-lt9211.c
  - fixed kernel test robot reported build errors
  - Link to v2:https://lore.kernel.org/lkml/20251107-add-lt9211c-bridge-v2-0-b0616e23407c@oss.qualcomm.com/

Changes in v2:
  - Combined driver patch from https://lore.kernel.org/lkml/20250911-lt9211c-bridge-support-v1-1-c221202cbcd5@oss.qualcomm.com/ 
  - Added MODULE_AUTHOR
  - Uppercase to lowercase for hex values
  - Link to v1:https://lore.kernel.org/r/20250910-add-lt9211c-bridge-v1-1-4f23740fe101@oss.qualcomm.com

---
Yi Zhang (2):
      dt-bindings: display: bridge: lontium,lt9211: Add lt9211c support
      drm/bridge: add support for lontium lt9211c bridge

 .../bindings/display/bridge/lontium,lt9211.yaml    |   5 +-
 drivers/gpu/drm/bridge/lontium-lt9211.c            | 846 ++++++++++++++++++++-
 2 files changed, 808 insertions(+), 43 deletions(-)
---
base-commit: f50b969bafafb2810a07f376387350c4c0d72a21
change-id: 20250910-add-lt9211c-bridge-5a21fcb1c803

Best regards,
-- 
Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>

