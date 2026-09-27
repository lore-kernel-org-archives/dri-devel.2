Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32907C98338
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 18:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86D1010E66D;
	Sun, 27 Sep 2026 18:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Az8BQim0";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fXBO31Uj";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22C8E10E66D
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 18:25:59 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68R8rHsG3708951;
 Sun, 27 Sep 2026 13:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=sAPmBhoK4Gelg6R9Zn8TEWsux1ZHBNuAqYvEmwZIo
 8A=; b=Az8BQim02QQobV6eOfWKm1Wl/wF5mDB/zKtY9p7U7EOplA70NvJW6k2CF
 KCg6D9hBSfY3eWKFtH6kRlSAHKE73+tjftVVtmzhwYvkC9jWKx3mH7ltma5daFYi
 uy7LFRc17pJq+TOBLz20QaFsLkRHX6ndi3GrwoQ1zdGPNTB9lhPQOG2VUhiPHHzN
 G6yjwjGxERpHevPO9MOT+r2oKnAX+IQaBe3Dcgs8PMMweWzxc0YbOXo9rxHoRqUa
 mJjF+R0YDOku3tDCMmkLvM2mDosvs8gjSnDXBxHRC6dDcR3uaFEGwpUtnrFYwiNw
 eHmqAmHY932Or2Za21k5HD9P6L5cQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gy00n9hrw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 27 Sep 2026 13:25:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTEKDu2GdwznbKyYZ3/SlIefnD/T7JXofwKqpNR/HCr684w94fnq+wBU0T5mnZKwMRMpanB5bNKBFL76OtPrfQRL8vfxrqpjbi2CzfSgKpFzfiE21ykoM8tUQDAtG3q4Y+IYrc7gNJvbyiu8CbrKMnjSO08RiN1nZaK8reRSAtpEs2xeZdrZCtY3y8BZN8XCRCstLvwSe7sdg4eteCc1ozxawl42c2V4yBRK3nTfox4cH0QkoC4XZr0oc6jfxYFqlX5xpNaJEokeM/oaUS3YvocMZCPGPS29kNedSfyvxLy11HR70l1pPmfU2b7lv9c7ZwfPv2Hpcr8T0YyWh+rUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAPmBhoK4Gelg6R9Zn8TEWsux1ZHBNuAqYvEmwZIo8A=;
 b=Sbz26Eh1lovwrVHhyAGwhhosRWfZJB2ofCUg/jMP69gfui9mb0bt2pg2Q1XpmBEfXcaFkOjAI/q3VnBLaAVNqzms9ExdwMiGv+RfLVgHO2adjsx31nHVNp1HV+0QRhJeEpflWPxDBDLKlXmnF+ii10Kqa4t5vLr70VWqpKhub5iJTE7wumsbL2pWK4JGUlOwzMG8TabRWlgE/qxA0wiVN6ZfxPsJ0tlAQUuYuFq62jQeXsH6DWkSNrKmTWHTk9dejfvYt4bxC0hK+ZiRACCIMDzirj+HCNp8YJ1z/n0EQ0GsxM5E24CEc7d0/ulild+aGe8jm8rNJocMW3YjztxrwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAPmBhoK4Gelg6R9Zn8TEWsux1ZHBNuAqYvEmwZIo8A=;
 b=fXBO31UjclnpehDZboiaqlZLuHCRA50aUp/ENbekkATN+EZvfkaK+0ajLjnXmSn/o9MPkM3X/GfRYqQS7ayPMV4fnibRrM4Eq/TsnmFfGDStCtx/1AcneKZWE4JPwO2d3smGSicHprekgLRV65d0U9wpXs7RVBkqrcI0d2fahXw=
Received: from SJ0PR03CA0148.namprd03.prod.outlook.com (2603:10b6:a03:33c::33)
 by MN0PR10MB5960.namprd10.prod.outlook.com (2603:10b6:208:3cc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Sun, 27 Sep
 2026 18:25:53 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:a03:33c:cafe::ad) by SJ0PR03CA0148.outlook.office365.com
 (2603:10b6:a03:33c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Sun, 27
 Sep 2026 18:25:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Sun, 27 Sep 2026 18:25:52 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:25:52 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:25:51 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sun, 27 Sep 2026 13:25:51 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68RIPosF2548095;
 Sun, 27 Sep 2026 13:25:51 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Devarsh Thakkar <devarsht@ti.com>
Subject: [PATCH v2 12/14] MAINTAINERS: Add entry for Solomon SSD16xx DRM driver
Date: Sun, 27 Sep 2026 23:53:27 +0530
Message-ID: <20260927182329.4193961-13-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260927182329.4193961-1-devarsht@ti.com>
References: <20260927182329.4193961-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|MN0PR10MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d976d2-829d-4058-ee35-08df1cc4c37f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|23010399003|22082099003|18002099003|10067099003|13003099007|921020|56012099006;
X-Microsoft-Antispam-Message-Info: MWzpYXbTJ6n0cJgSLIQddyqaqAKy5qdjMLCmaVdjxsDgeNEGCGhs4dHGXqYlERFbzsy46wZ2fXmqGXHC5wdx6BfQW6n6xgB4JAkN6rN0WKnOWO8lTTBPwImE3bc9dcFVhMR4nZBYMVgtKBuFco1cDKZ6+tZtstvI91bqC7I58Otn4O5O8kzJlVbje1Fp7loegbDt3aVHlwdnz7lphRhMw2ivAC3DEGuaU0J++32/dAl79uw3yDZs5EnPJiODWQFykusHjx3EYNVu/+D8FpCDBVFSiGrY7AJ1lStrxik50h4CSCQUKzic5U6qkFMp6lvF5Kl5HNFkOpGCcHyFSIqmbBPMqIjvNg3IxTjd8nh1pXn0soNemuSbyW24DcFaQtMJOle+gsO+nAQzRHXZHR3ptBAcOs1vT+B/0qejibR3/K7eJON6YoIAQnAdL3vlLiRrZnDGleu/SroFKiOzMrywYUyl8umN/q2OhbrVcvfTGmFifbMwswezvjhoW/2lf/VGuShb9JtC9woLpS5Zvel0n7xavfxFeODEYroJknPCtlJs1ItKunrgNWeUhmFNBzkStGhbCVqnLClBmziPZTAhbUq+RoakpaAlK/Z8aNI7oLpSpEIqDUygGZUTb4EJl0lKtGbx2aTCMR8sj3KYj9DjOhNIjUkfcgQxaa6P8wP9pJB1+BMspJLuR7ibEdren5fX
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(13003099007)(921020)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Vx6GzXT3kQN37K2umN7hhFw9DYbcs2+LXGnoLr1zMxutgaAV9MxurH+ngJ7VwP4j9qRwjgKRzZIg4+QKvadFbiTJmuEHOPZK0yh0uYRiPRHUwjzDqedb78nBZrZKzZzQyGtU/6QIA7fQuA7MUTTsXr5EGFP3MnVGqdAZsAJ3faJK6MRPJmKkV3ONfXTxn3Ej5qLGSiId5wNgTen0gWDRdebvbSrGVpQ1n5Dl3oElDwFq4FTsrO26MD3ydQ3f5LA+/u/CQgnhveflZFILusqqxnaGpiIY5mg8bp57kyS31sEJfA5e3/W/2qu0Z9qJtKpMzc9T839JhDpOBzyTxQK2ObbweAid3W50yDIttOKjQSO0URSJaliUaZhWo6uMdHLH1NCFaLPmoYLsrwZQaJIS+r4PYfBo3qY9ai7B7gR2cKosbR9HMeZLmIZQ2IyNbwzC
X-Exchange-RoutingPolicyChecked: Dtw2oP8klHC3F52IcR1u5VGiH2qTc8mokT7EBfmsWKMwLepafxtpXm2Z2pnQio6ykaXeONbjzQCl6KgvL3Mi0Gxyb8qswNrOuQ9cThLS835PIOnjNJL8gmQBAFwRxkdUMt1zvR1chQ6pUoxs1A6MunebYENw9jDi0lcW0rj10m+N6zrYTzn6yeAID/0hkuE0nRP2GaisYNnuHTx3eca2jBtPQlt0PR3fS4SciGI8U7Ut8xav4JcOpBtSLWj9UodI12spxtdLQy9eFNjb/jjyb+oZQQvG4Farje6k97D2zMa+9IRLx5atpUBwzMSAGempKpKDlLCCwfOrL7cmLm1iLA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 18:25:52.7761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d976d2-829d-4058-ee35-08df1cc4c37f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5960
X-Proofpoint-GUID: j89wq6eEG74-MH6YuSd0SL9PeV-uugg1
X-Authority-Analysis: v=2.4 cv=fKysTpae c=1 sm=1 tr=0 ts=6ab95fb3 cx=c_pps
 a=98eAHdF884nMI2WayFaxAg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=e5mUnYsNAAAA:8 a=sozttTNsAAAA:8 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=dsgmgDBIb9Jk0SDifa0A:9 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: j89wq6eEG74-MH6YuSd0SL9PeV-uugg1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfX5GxwW8U/9JN0
 yRFqsta8YAKwEE6hPosAvuB3zyfExFJwGlCp9BGPbm+aSPvRLaY9Bo1q4/sjVMRtn0tc0Cz7D0+
 4r2hLSIsGd+qptGejkzlyEMgnmHcbWo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfX4Gk2BZuELuxr
 SGSh4Jtwfr5emhCz+n470pElC80nJ0TOBLUDqFP+TAMORaMhNHdVWZ3fLFXr/DyDzT5zb2aOx7N
 slnOnsJjQwlhup6pFRlIzZJPQX0/ZDAOsZlP8w9ZIRjKPwzipTkoch1qAGGKHfCIn1PLxQjnn7b
 ERm5t6AQgQWBVZFZ2zugLxQVp2QKc1Yh6L26eCJuOkDo/j4fs4W8t171MGsHBKBWdl3zxGNXmgm
 9oIJU7kbx2fBwdMmYD8J1QlrAeDsL5l+OlUjrBtEx+yy2JJ0T6ngvm1ZhgF+0N0JemaSxPlrn9C
 6JPOFifbDd5L2KzE0UKi2uvnPLGHfwgarGeW4kzCJB3+SuJfspkFgwTTsydCuCdflEng9cPvdiW
 FoQIYVbcBe5MGGK1kaa6Zex0CxiZQLJHPXodLEPAWjZ/8tZubswS7pnb64x+hMtPoxOxWcH+mDj
 4k7GzVw8TVmS8THFBFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
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

Add maintainer entry for the ssd16xx DRM driver covering the SSD16xx
e-paper controller family (SSD1673/SSD1680/SSD1681/SSD1683/SSD1677).

Also add LiangCheng Wang as reviewer too since pixpaper uses
ssd1677 supported by this driver.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
Changes from v1:
  - Updated MAINTAINERS entry for new drm/solomon driver structure
  - Added LiangCheng Wang as reviewer per discussion in mailing list

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d108339f44e..5019f290e9cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8566,6 +8566,14 @@ F:	Documentation/devicetree/bindings/display/solomon,ssd-common.yaml
 F:	Documentation/devicetree/bindings/display/solomon,ssd13*.yaml
 F:	drivers/gpu/drm/solomon/ssd130x*
 
+DRM DRIVER FOR SOLOMON SSD16XX E-PAPER DISPLAY CONTROLLERS
+M:	Devarsh Thakkar <devarsht@ti.com>
+R:	LiangCheng Wang <zaq14760@gmail.com>
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml
+F:	drivers/gpu/drm/solomon/ssd16xx.c
+
 DRM DRIVER FOR ST-ERICSSON MCDE
 M:	Linus Walleij <linusw@kernel.org>
 S:	Maintained
-- 
2.39.1

