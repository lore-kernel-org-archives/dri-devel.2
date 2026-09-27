Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7D9C9832F
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 18:25:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9A6A10E672;
	Sun, 27 Sep 2026 18:25:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MFKNtba8";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="S5x1QSNh";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 660D710E672
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 18:25:43 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68R7mFXE2776848;
 Sun, 27 Sep 2026 13:25:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=xUCIwN9ocFgTQxhuSids1TCEqbVQ+x2/cv2Rij9n2
 wU=; b=MFKNtba8Pv0+I2pfPNvm2T9MtJBtgtyZw6Sao8Tqz8ULRyuA7/ajY3UmT
 eqeHxz7GMRE2fxVwKUGLOX8A8QVNLIOrXQ46SdUvQNrwUI2j+m5Q06EEuiGGO7+q
 uPwn+xC8BrU/JwhEpZ0EtgDKG0nftWuxwSGn2H0hL3fKV/duMvij42KsUIJNhF6Z
 tXes9MmSlQADi7sh33MEO1ELslg1IivkSR/yPjLH2q1yTTYZk0YSEPWCZjBWpXKs
 6fuykk5qQmwG6EUCK25zgT6OCOijiW0hoocu6RrFZvT/t3IPq9QoXkylv7smP0DD
 VXT/ke1FCoskvT976XEnbhTl/2b1g==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012006.outbound.protection.outlook.com
 [40.107.200.6])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gxy2nhp09-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 27 Sep 2026 13:25:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oh9KeFM/YflL1kzB4R0YGcg04BeL/aMhcL6c6OGRtweVc2tt+JbHVcrSE8yj04dAdOIqwhjjiPB6lOYF31PTknicHCiBxHRSm0tF5K0l2Oo/aXw1/Es0FnRBIlXp/6HUXnChXTAE2W8XSJgMm/0P7bzWEamqb+UY5kNR4Nd/k3TC3cnJa8tBQ/AKDGa/mArRAfs+2Z/U2S0EP4E1crYbi6G0273r0TFg8B7P2lzFGSsa34PbOTaiq94URBhHaM6eqhF02DY7zH5w2SbnrwUNn0UckwW2eVI2bdirwCFsYSiROiuYV+L4q18VXK9TAu0B+/AZK86UceGhZFvr10E3dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUCIwN9ocFgTQxhuSids1TCEqbVQ+x2/cv2Rij9n2wU=;
 b=dMKvzIhqWNang6GPikJMWZPis/DbOZUiHWNhx579k4lolPV91k2u5xZACSb+WGTWuTXvoPHAvw6e38gJF0eu3W2AITNL+yXTaralY2lGReX6Q/j7d0+sZRf48qKpFMnDSRgO8Unnqcb+tXaCk9it16nXWHYbkQrPUxNkvR7xNReaL/xP4HzjjqAX5nCRWV97RWyCxakJdsW9iwkuKSyq6GojuEOVad4UC+qTY6U1ES2bNhfsvKviY2qyVPaVhfN/seveJWJUFvcuDTT1JKNOPYyXNCo7VLfBlFqyKHxZLW4m1+NlS3yN20ERK+fqpcklv9Nf8P/+keojd0HHzLDrkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUCIwN9ocFgTQxhuSids1TCEqbVQ+x2/cv2Rij9n2wU=;
 b=S5x1QSNhsu+MAmeoCN4oZjGuqRNXiqtAOiAptvrMFw0jPXbnBRJVcNK5Cwdy77LYXpFntfqvoncsd3JCWsMgWQ3JUqZ8lQUPLYwbkQsmfNO2W63Du+byHKvZTYkJz6U08VJh0VoUguvr1Mntnzp9va8CqJOvwbBkU8cpVhYBSaE=
Received: from BN0PR04CA0004.namprd04.prod.outlook.com (2603:10b6:408:ee::9)
 by CH3PR10MB7501.namprd10.prod.outlook.com (2603:10b6:610:15d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sun, 27 Sep
 2026 18:25:36 +0000
Received: from BN1PEPF00018074.namprd04.prod.outlook.com
 (2603:10b6:408:ee:cafe::9a) by BN0PR04CA0004.outlook.office365.com
 (2603:10b6:408:ee::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Sun,
 27 Sep 2026 18:25:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00018074.mail.protection.outlook.com (10.167.245.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 27 Sep 2026 18:25:35 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:25:35 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:25:35 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sun, 27 Sep 2026 13:25:35 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68RIPX2i2547852;
 Sun, 27 Sep 2026 13:25:34 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Devarsh Thakkar <devarsht@ti.com>
Subject: [PATCH v2 09/14] drm/solomon: ssd16xx: Expose color mode as plane
 property
Date: Sun, 27 Sep 2026 23:53:24 +0530
Message-ID: <20260927182329.4193961-10-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260927182329.4193961-1-devarsht@ti.com>
References: <20260927182329.4193961-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018074:EE_|CH3PR10MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: fa04099d-e9b4-41c6-1faa-08df1cc4b95c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|82310400026|36860700016|1800799024|10067099003|56012099006|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: LQomdMVg7mLtqp5V4pYHSZhuCxZgB1ErM2ymojnlp/VWMPAcCPzEON3qWHjgxB6wJlOgCi/yDTp9RrBx7VtSuTxLJdrEwGNrY6yvFgmippq6dmD/JJid1thxsyOncex+DvNVFj2irkAjI8PnQH9Sj3ztjV5KPq9Y5z0pINPIXwUkCGXThYWbK63Q/MCiq/7QTZsrxauwys7FfWeWc4f3JivDKTxhIMXYNpaN1r8ed7fhxHPI7o41thcxfXSqoM2Cj5NA9+jBslKI6FWI+fqcs6hJZHDHXnUQ+xnK0mJEKT8uBdFdg8DqB19v/zv1ZOC3wVXDdyfk3FnBkDzBVMiJA2q1UYL4sgqknnCtIBP97FiYRK0w0hmO4Vh1sTYeY1x/8TZ7LARE9zlwsjTPt31pQM2vEoYtumkzfy2hivfmRxar7bOpQZkUYqssVbkCalQNwD1RbyjD7EgdvuUb/sMtMv3TmETfn3hzX4ppi5MsYI1ZkAEwwvqUJ42PoWIavM9vrkhv+DSuyhaOxLKTq0O8buVN2BmmpPiGUKJ5vC1J3Bsd45pRNL+iYKS5z9XNZP/+Ijgo585AxYwkMrqC7zNUJM5634fV+44p8qCL5J24AV/hbc+2H/PLiylvdCAg3S/hzieU3ca7pXmgmjiFWcYKlF5xyQkRRLxNrdyJEHmm+yuehd8+SrTyrGRUxzViBdZTHOYkjIztmI5vO1pi6A0zXmBWS4gX+Uwv4xpnNkWResQ9aAAk5ec0LlE4TmmGkFot
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Bhehml3VY7OCsUBxVmspHFjWoCKVoWeMNCeymD74uYhubN3aDYPB8QnRc2ArrZGGxUaN5qqrs0LX90k5aV7nVojm9sAm63EvedDcvVClegK0DX8rEgmRiKc1d6rGrYuQICCq7CYhRZV1MJFI9dfwl3EnGKPhw8AhfTihNp8BA26dUIm78GjfMMCie9xkDy6ra2sNgP0y1ijg9BK5Ck9jGRCNiWc9Z7LoX54oj/rZEp7X6c1kJKE9ROv8kCc+cb9hLLu6kGT9XNPI0G/yLP3sRbFFdowULtutLLwM8KcpfTruDBGQGDp1nlp2Fph9q/gmc4f+5harz3xzkntvfQIoWljMjc49bkjxqnUWTNivS9h71Wl+k1/JziDesTxM0lo75RO4d4FaTNCIiQXzV/3k6ziGIJJAQ5a8p8iAMzDrW4S3EsZN7amHiDrFk6iYjgFX
X-Exchange-RoutingPolicyChecked: s1iztwbHAmQ4Qwqp7DwkUUY1iasMaIbQqFhVkMDkJiOA4zibGt11RpjkZInc/2gHorjMfnkMCHGhmCeATZuU6onnRcnNXzISZ9YCwruWYck14vG3i2piwEzB8ebSDERwq+n50T96u2cMPQdojjBk2KrFN68YnKhRtIFVJGzjFmvLu2DyYSgxZTI1XpeiGXVQT4BPHrx1f1sn1svbQfP78WHczYeER0+IJrqru6EBNTgsM9GQmF/d0qsdEAWoadoS1ruVREpWvTzfGy1EA4juz4xHHK3cprMS1bUxzrF8rF1pyLqMRpT5MW+mTZuFXAAQaNJ8YCzmGGxLBPqg/0fhfQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 18:25:35.7725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa04099d-e9b4-41c6-1faa-08df1cc4b95c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7501
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfXypYJ3MT9vq4p
 SP5njVvWbGN8MgilNGwf00S+oTkgSJarpI1l1iCBz5kXsZHibai2qcb7WFdX2CMuDSQdsgiS0Fx
 zBk+wPbgxQhkqT9KW862EdUYKXtPK3Y=
X-Proofpoint-ORIG-GUID: 05MMXSzUN1u5Vw_kdKPGMh03YRgggTz0
X-Authority-Analysis: v=2.4 cv=RLgmjIi+ c=1 sm=1 tr=0 ts=6ab95fa3 cx=c_pps
 a=wcVwjJSTJ+Ev3TLsT0vURw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=6LSqDMkLcgfBYLdHEEsA:9
X-Proofpoint-GUID: 05MMXSzUN1u5Vw_kdKPGMh03YRgggTz0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfX+JPou1Z5mA5C
 LPS4tVqQsnSv6RR0UrYSSJSeNCu6pVORAik3vF+udc2K7gvm0oQz2blT574WmhbZzrnacYp/kVU
 LN1X47KkFf9gPmmsZuL6x4hqdApNc8imPIkcD+/jTi0xBLRFO/VGAxKpeBil/vxVfNJlpgfEYY8
 gcrirofwfx5nxsRAdVTLr0jNIhHdrBkFJ72kFZBdUJ4FppJfU9NCauxweCzgPw9sdw4sokgTS0F
 OnZAYbK/NqmUWYTn6ZVonCV3M1dcwM5JL3omvO9kCnKDo4BrEE2d8kZhMDs2A7qWJcKVQ4wiVqt
 J1eEuhue8Ur3l2qrUZp4RZcQyJdfTcluhLiBSLbQqMT/ZRkrq241IIpWPMfJTbK8WeUI5GTLiVf
 FasJGZT6R7dIR6nOOZJNV7wPiv8y4gAAa7nAsg2JhKSU8gDPwaOXA/05cRjKZ8KlGE+NGA+4Y5p
 KSTgQ1MbiDtpb53ROzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270073
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

Add a DRM plane property "color_mode" for panels that support
3-color (black/white/red) display modes.

The property allows runtime selection between:
  - bw (black/white): R1 format represents black (0) and white (1)
  - 3color: R1 format represents red ink (1) on white background

This property is only created on panels with red_supported = true.
The default is set from the panel configuration's default_color_mode
field (typically BW for monochrome panels).

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
Changes from v1:
  - Extracted color mode property into dedicated patch as
    plane property

 drivers/gpu/drm/solomon/ssd16xx.c | 42 +++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/ssd16xx.c
index dc2b8fe536af..3815af0cee5c 100644
--- a/drivers/gpu/drm/solomon/ssd16xx.c
+++ b/drivers/gpu/drm/solomon/ssd16xx.c
@@ -401,6 +401,7 @@ struct ssd16xx_device {
 
 	struct drm_framebuffer *last_fb;        /* Last drawn FB for reinit redraws */
 	struct drm_property *refresh_mode_property;
+	struct drm_property *color_mode_property;
 };
 
 /* Plane state subclass: refresh_mode lives on the plane, not the connector,
@@ -409,6 +410,7 @@ struct ssd16xx_device {
 struct ssd16xx_plane_state {
 	struct drm_shadow_plane_state base;
 	enum ssd16xx_refresh_mode refresh_mode; /* Pending refresh mode */
+	enum ssd16xx_color_mode color_mode;     /* Pending color mode */
 };
 
 #define to_ssd16xx_plane_state(s) \
@@ -1423,6 +1425,7 @@ static struct drm_plane_state *ssd16xx_plane_atomic_create_state(struct drm_plan
 
 	__drm_gem_shadow_plane_state_init(plane, &ssd_state->base);
 	ssd_state->refresh_mode = device->refresh_mode;
+	ssd_state->color_mode = device->color_mode;
 
 	return &ssd_state->base.base;
 }
@@ -1465,6 +1468,10 @@ static int ssd16xx_plane_atomic_get_property(struct drm_plane *plane,
 		*val = ssd_state->refresh_mode;
 		return 0;
 	}
+	if (property == device->color_mode_property) {
+		*val = ssd_state->color_mode;
+		return 0;
+	}
 	return -EINVAL;
 }
 
@@ -1482,6 +1489,18 @@ static int ssd16xx_plane_atomic_set_property(struct drm_plane *plane,
 		ssd_state->refresh_mode = val;
 		return 0;
 	}
+	if (property == device->color_mode_property) {
+		if (val > SSD16XX_COLOR_MODE_3COLOR)
+			return -EINVAL;
+		if (val == SSD16XX_COLOR_MODE_3COLOR &&
+		    !device->device_cfg->red_supported) {
+			drm_dbg(&device->drm,
+				"3-color not supported by this panel\n");
+			return -EINVAL;
+		}
+		ssd_state->color_mode = val;
+		return 0;
+	}
 	return -EINVAL;
 }
 
@@ -1568,6 +1587,7 @@ static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
 	}
 
 	device->refresh_mode = new_ssd->refresh_mode;
+	device->color_mode = new_ssd->color_mode;
 
 	/*
 	 * When refresh_mode_init was set, use the specified mode for this first
@@ -1872,6 +1892,11 @@ static const struct drm_prop_enum_list ssd16xx_refresh_mode_enum[] = {
 	{ SSD16XX_REFRESH_FAST,    "fast"    },
 };
 
+static const struct drm_prop_enum_list ssd16xx_color_mode_enum[] = {
+	{ SSD16XX_COLOR_MODE_BW,     "black-white" },
+	{ SSD16XX_COLOR_MODE_3COLOR, "3-color"     },
+};
+
 static int ssd16xx_plane_create_properties(struct ssd16xx_device *device)
 {
 	struct drm_device *drm = &device->drm;
@@ -1886,6 +1911,23 @@ static int ssd16xx_plane_create_properties(struct ssd16xx_device *device)
 	drm_object_attach_property(plane_obj,
 				   device->refresh_mode_property,
 				   device->refresh_mode);
+
+	/*
+	 * Color mode: for BW-only panels the property exists but only
+	 * "black-white" is selectable; the 3-color option is restricted
+	 * to panels with a physical red plane.
+	 */
+	device->color_mode_property =
+		drm_property_create_enum(drm, 0, "color_mode",
+					 ssd16xx_color_mode_enum,
+					 device->device_cfg->red_supported
+						? ARRAY_SIZE(ssd16xx_color_mode_enum)
+						: 1);
+	if (!device->color_mode_property)
+		return -ENOMEM;
+	drm_object_attach_property(plane_obj,
+				   device->color_mode_property,
+				   device->color_mode);
 	return 0;
 }
 static const struct drm_connector_funcs ssd16xx_connector_funcs = {
-- 
2.39.1

