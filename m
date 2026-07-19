Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473B0C4451B
	for <dri-devel@archiver.kernel.org>; Sun, 19 Jul 2026 15:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29A2B10E050;
	Sun, 19 Jul 2026 15:57:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XeAaBPxn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kQ5TtFSu";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCE2510E050
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 15:57:40 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66JDvpLc686720
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 15:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=9X9h/ZHNxV1EjjP+V3RN+e
 P+77yOxHYAXoHZMjdrp9c=; b=XeAaBPxnklSODzPIJoYwSltkwA9VElHI/Q9Y+j
 MAZBvBEk7VW3jyY3sCC66kUzfNEFlxhQgTj1jtO1EPVkV4HE7+XOiMvhca2jmAuV
 5kqL6w/coMxXW9JSIjU08ipwmjz1PF83Tem2q2QvkLOW22wjMJgStK+4Zd8QbZST
 2EKjByt7c3yEAbjQ1gpQvyjL+4+f0p8sOXsfcCCD9Zmj6zCslOKOgAOk/4QkdTHk
 mRbAUUvipgKzQGcgw/lQ3S0A9g0r+eRRrkrTVjMOy61XGFClgx6WB4oBe5lSphhH
 lecHJtkfZXKl5doqW/IAjhYRFK/vmPeSJD383SONekl5cBhQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2aau0fp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 15:57:39 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-388277fd89aso1235894a91.2
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 08:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784476659; x=1785081459;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9X9h/ZHNxV1EjjP+V3RN+eP+77yOxHYAXoHZMjdrp9c=;
 b=kQ5TtFSuvVW/FnpZRhXIDd+MD8Z5Z4lxiQwZc4EqGnCUg8mEQHMzOAr7OTWZGHCpNt
 A9XCe7SIuaqlJQJAAjCWHmPrvzHEsXeHurUORpGbC1kB6vglNP+HjP774yHjIxjGJ0Os
 AY8fQGNdAO3tE7WVX7+dHel4+anTVOYVI5rTq2LQ7m3uvtiT8f1PzpAWqZ/KEukrGzi6
 CU8ffqcs8R62wzM7oavog5UE5PD9fFpWANNk0anqnHmDKdbkwSYgpgEDRAyobn/QMba7
 +qQXVUwYSBlg2RaKe9c2kw1jxY8B8CYPlDxqrxxd4JemrxAMblAX+8nq3CikYQrfinQB
 I+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784476659; x=1785081459;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9X9h/ZHNxV1EjjP+V3RN+eP+77yOxHYAXoHZMjdrp9c=;
 b=B2t86BJaM+xQ7MKcClZ+BQoA/AeeF9r6VPYtoH6IR3lwq0g5pWzOrV6PlC6wCdsmyo
 7KPuQTSkvoFY+HMsgy4aprn72Wti51np92Z2Ws8MsjmIIqlQJ5xdKCOGbm3WjrrF5GOm
 nNfTO3YMDAGMOXMUylhEpqpKOo6quEzvXNMtiJ1zpPQSsXdRj6OsRODpN/OsMVWu1iUi
 Mk9IHzxC5EyEjEgnfOKUfe5ZzYntIKbXOZBt4YTHJM8VN0Pts/SCsv9eWDTjmZ5lPzdD
 IYCYKi0ESBoQxkPQHCi7Ex+hdErpo+LpIi6FvUL8vTUZddrTD7ca/tZM5aT2K70LMd6D
 llOg==
X-Gm-Message-State: AOJu0YycAVpFofAMeCto0+ob2XOzYMdW8eQZy5TLEFhUEhWUzblAx1mU
 iIGLRXbwL8lCoxTuWpVfclnWwKB83p8yzCzVgSw5akhvQjjn7tgl2ggVooy0EPA8oqje8+SsmwD
 D7KyS8etNdbyJw5oasA/QW8LFN/aDPv34T60S3dM2+DHmH7purlMfnjeD73jk1eNscOciMW4=
X-Gm-Gg: AfdE7ckFwdMvvkYp201OiXDZ6GydlHjMdrbmiUCFmDpY4cG9x263kpwNCLclj19GmU7
 QtQYn/xdrD0r2Xaeh5NkpQla1yElvHVXGccOhVACwCHj758nRZcGUIqMFeo3EUfaDGw0We1bAA4
 9A9bB1r8yUVqa5n5cNtHgs/bEu68W2o0ntjbinzuP0A0N5bCQENXGXqpyCPdl0LPVnacuLyC0sg
 /bGVGnVN6q9D2fECkrxJrA9ssjqaDBzbiOluBYPgEQXsrCet/oZh6n2ARi/z69w+M/ADC0fmrL5
 S8qr/cLs693od+7KZ2b7KMw1ePL9NIhNZWKP8h6OxPhzeFCzpll1uO5/g6o95HkA4mhsbOGxEuX
 pge3AhU+XYIZL/epMufn4sUpEqpH2ySwe4iW1RUl5OwOEsKYdPxer5uXK5es5CUmbhBcWC+soC3
 OxxSO7sZOtQUO5Rum/UDWe
X-Received: by 2002:a17:90b:a48:b0:38e:6a7c:abbc with SMTP id
 98e67ed59e1d1-38e6a7cacfbmr2529370a91.3.1784476659153; 
 Sun, 19 Jul 2026 08:57:39 -0700 (PDT)
X-Received: by 2002:a17:90b:a48:b0:38e:6a7c:abbc with SMTP id
 98e67ed59e1d1-38e6a7cacfbmr2529341a91.3.1784476658680; 
 Sun, 19 Jul 2026 08:57:38 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429f9d439sm33127054eec.5.2026.07.19.08.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 08:57:38 -0700 (PDT)
From: vishnu.saini@oss.qualcomm.com
Subject: [PATCH v6 0/2] This series adds LT9211C bridge driver by extending
 LT9211
Date: Sun, 19 Jul 2026 21:27:24 +0530
Message-Id: <20260719-add-lt9211c-bridge-v6-0-e56d22152586@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOTzXGoC/33NSW7DMAwF0KsEWlcBSU12V71HkYUGuhGQxKmUG
 C0C371KgA4LuxsCn/h8vInKJXMVz5ubKDzlmsdTC/ZpI+Len95Y5tSyICADPYL0KcnDpSfEKEP
 JqTWMJxxiwNiBEu3wXHjIHw/0ddfyPtfLWD4fPya8b//lJpQo9UDKaRgYAV/GWrfvV3+I4/G4b
 UPc1Yl+JERwixJJkAEsWialwcUVSf1KhN2ipJqEzGAdeEiBViT9RyK9KOkmabDsFEfqolmRzLd
 kQZFalEyT+mhVCKBMRLcgzfP8BddLrS/jAQAA
X-Change-ID: 20250910-add-lt9211c-bridge-5a21fcb1c803
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yi Zhang <zhanyi@qti.qualcomm.com>,
 Nilesh Laad <nilesh.laad@oss.qualcomm.com>,
 Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>,
 Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784476650; l=2908;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=7pN9c9zWJA+qGQnOuBukGwvXRude4YVEXtMtrcAKC2o=;
 b=vXuBOFE16iGc+K1KDdxFdx9feUP6Q+h1sWJm/jo7X/tmn/RmnYP+kpU6Ip0PhcF16T6Nq6eH6
 r9MJd7H3/fVCcAUPBaJkLqTMbcmuajh2FOPAQxNyIq8+9izpwVwyLOB
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Proofpoint-GUID: R0KimWdmWETmVeD2DB6IfQYeShresNn5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDE3NyBTYWx0ZWRfX1AOKL6ztu5tE
 jVPNfmhJFnLB74/H4cOQ0E+sONdPTnjaSZT+EDi6Yk8WJabhFd97uSWuqKYMmC5UL7XdVhDExCh
 Gf+y83txABweL6BwKipa71YZSyrMlJQ=
X-Authority-Analysis: v=2.4 cv=b9aCJNGx c=1 sm=1 tr=0 ts=6a5cf3f3 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wkDsqcFfI8a4ryivD6MA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: R0KimWdmWETmVeD2DB6IfQYeShresNn5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDE3NyBTYWx0ZWRfXwgLnH0bSWqPB
 uPxKQfR+/xPCmhgDwwxXmIVuJaKDH0nyNwBKwPXizFtqL4ZEbe54gWlOpTmSl0RZFiOj6f5eZha
 UqoBO1nxHNKpneTxAEpFGCMGpJ2rrMRj1/ngEYNSHTTV831dI3qTf1hUgrAkHYX2xcp2phnD6nA
 ESPhntC4ld5DARv5bKC1hDxrQGIULAhrmcstVr2b24WtuTFEg0nVd2bily7Xy4lnctodk6zt7ac
 QZk9983rn2eYTogdrJV1WOaMF9Yob3GhxFnkAE8RWld9UF16EFNbJ/+U5gbI38mE2vDH9STfAtG
 Obt8ehCAg9MHYZ/qZZ/p9FEZ4aUJJbs42Ly2Yo6uFmxNO8BTnIoQKzVqpH7AAEIfELIa4li8e0T
 0OwuP/e69wOhDxIdJI/rifoSJ18KaRCulSBy4H1T2Tiqvn+RFEo0hZAedK6+Xt3FxVetb5o0C9g
 SFaCsXAUiytKkPW4dLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607190177
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
This adds support for DSI to LVDS bridge configuration. By extending the
existing lontium-lt9211 driver to support DSI-to-LVDS bridge configuration.

Signed-off-by: Yi Zhang <zhanyi@qti.qualcomm.com>
Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
Signed-off-by: Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
---
Changes in v6:
- Nilesh Laad and Gopi Botlagunta  moved to different org in Qualcomm. Further, i will followup on this series with community, will also submit the dt series where LT9211C bridge is used.
- Rebased onto current drm-misc-next (commit 671b7825dbfe)
- Fixed lt9211_read_chipid: LT9211 match no longer checks chipid[2],
  preserving compatibility with LT9211 rev U5 (db74b04edce1)
- Fixed indentation in lt9211_atomic_enable LT9211 path (was double-indented)
- Fixed indentation in lt9211_delayed_work_func body (was double-indented)
- Gated workqueue creation on LT9211C chip type only
- Fixed few formatting warnings with coccinelle and W=1
- Link to v5: https://lore.kernel.org/r/20260323-add-lt9211c-bridge-v5-0-9c63bb035c17@oss.qualcomm.com

Changes in v5:
- Addressed code formatting in lt9211 driver (no functional or design changes)
- Addressed v4 comments on lontium-lt9211.yaml
- Link to v4: https://lore.kernel.org/r/20251224-add-lt9211c-bridge-v4-0-406e73ec28c5@oss.qualcomm.com

Changes in v4:
- Removed lontium-lt9211c.yaml
- Extended lontium-lt9211.yaml to support LT9211C
- Link to v3: https://lore.kernel.org/r/20251218-add-lt9211c-bridge-v3-0-1ee0670a0db2@oss.qualcomm.com

Changes in v3:
- Removed lontium-lt9211c as separate driver
- Add support to lontium-lt9211c bridge driver by extending the existing lontium-lt9211.c
- Fixed kernel test robot reported build errors
- Link to v2: https://lore.kernel.org/lkml/20251107-add-lt9211c-bridge-v2-0-b0616e23407c@oss.qualcomm.com/

Changes in v2:
- Combined driver patch from https://lore.kernel.org/lkml/20250911-lt9211c-bridge-support-v1-1-c221202cbcd5@oss.qualcomm.com/
- Added MODULE_AUTHOR
- Uppercase to lowercase for hex values
- Link to v1: https://lore.kernel.org/r/20250910-add-lt9211c-bridge-v1-1-4f23740fe101@oss.qualcomm.com

---
Yi Zhang (2):
      dt-bindings: display: bridge: lontium,lt9211: Add lt9211c support
      drm/bridge: add support for lontium lt9211c bridge

 .../bindings/display/bridge/lontium,lt9211.yaml    |   5 +-
 drivers/gpu/drm/bridge/lontium-lt9211.c            | 796 ++++++++++++++++++++-
 2 files changed, 782 insertions(+), 19 deletions(-)
---
base-commit: 671b7825dbfe9ea6e3ad3001003aeee0df48d1b5
change-id: 20250910-add-lt9211c-bridge-5a21fcb1c803

Best regards,
-- 
Vishnu Saini <vishnu.saini@oss.qualcomm.com>

