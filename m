Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE630C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBB6C10EE56;
	Tue, 22 Sep 2026 20:47:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="K9NgT65l";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="K9NgT65l";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA3FF10EE54
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:47:49 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=va5p4AOC4wxvh5V5uGtfCbDEdaLlztYZU4rkCxO9bzHkboYvGJuYhI8QSynatkp3zaQFLJGSR2MX6aAxaeAO1AbJT09tRXqF2E77dDZL/sXziL7AnZ5iT+IWi51UgR72qo+YarcVqiKpPwR+ERtpgRiOojvvIeYu0R7MEm5+EcOr8hB8ktC4SXvo7+DvPbj531CemlVsNgWsGa+JEQD1FIjOeFjk692kAIsWPlhJIV30zCHFbD0gyZgFNp82JNXHJPz97xNsr4GSBsDyvI29LvO/OJXeuO5xn0HPKA2zclhxLb5hDKF5MdHBusPWkmB3XXOVFXdKrzaKGJOh0dptDQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAEXG57BKTHSgLa9mJDl/tH2/ad8mlmwECtgHmgFib8=;
 b=Jwn1ZY9PwbU50CGMs3DWsRXgrrZCcuQYAKGlyNy7DEf/V4q8L5E6EKNo0i4KPZ33kDmqf9/mBbafAnyYWGN4II0BZsJB0rQzgDHpzXHo810tpb8rh3b4WsqX4fLAbHsTrA1pAC0VUGvD/DekcNsChYJ+EXlp6t5WA9bK6nraicL7pXDxnzHtNgKPEl2Z7G2BLxmxXYPcHtp6trr6Aa6HFvSu5baVrF3SGqCFwB2J3SIiMKkUHJy46jbtfjNiTEHLxja9fz6d487rMSLfAiEYFhm8Ijs4zgeysRmOQmj7gINOkFXKRl2dy+U1yX9z0sbXPfK00h/0vdEUDZvSRTtOZQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAEXG57BKTHSgLa9mJDl/tH2/ad8mlmwECtgHmgFib8=;
 b=K9NgT65lLUuv8rg2R4wIVdwzMphdCzzaal8qCv2BzEPoylTCGTefR6Rjwi2luVF7zc2oxeMTZWCJpqYq8dIN6y3+qtjiShKH6k4MJvmQgG+3P2rsVQ1Af76c/ZS4Xf/j1h5d5fb0O68BHIpVcYytcYaEaq7Z4fNnEofhQ3nHKsU=
Received: from LO4P123CA0631.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:294::17)
 by DB9PR08MB7699.eurprd08.prod.outlook.com (2603:10a6:10:392::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:47:43 +0000
Received: from MI3PEPF00008554.eurprd05.prod.outlook.com
 (2603:10a6:600:294:cafe::76) by LO4P123CA0631.outlook.office365.com
 (2603:10a6:600:294::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 20:47:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008554.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 20:47:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNc+/9vg8EpUwDqguk3T0B6QzgiV9AZ85VQ4jhwIja/4ZxvmZvpRrMgaJ2+w1NZtr/TNLOPpSCSvEuuSnoo8tTr3KycwtjV+rQmzLghJ3n3Ocitu8nA2pRZ4/UXVSD+Xxl8fj9QhJn1UbkZQzT6FiTpgEsBt4ewRUjb155w7jeG77xyGi346lVHlMKCAgR4Kd8F0DKTaUo2beTRQtAEpHJcrhaPzhr41OsKUtIAsg5V6MlNbn2efCyxUGHqrEPA7sU2JdefaC1YXkPHFiiK+LHypDZlBPj4an78iiTIHm5BDkX8bIj6MbbM+KJQuZkQA5GUoRbe/3c93XYTzqL4Cug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAEXG57BKTHSgLa9mJDl/tH2/ad8mlmwECtgHmgFib8=;
 b=mD+PNOlOZibyhfpwxxsmZid6eOlpvgYyJQyzh90lI+BImlMqw+aeg+u8Tu9+xmpc0bMHL8LNIU3LGMI7CwLMhE+pmV4jiA4orfu2kf4UH6U2n9XlqJ5S3DdZwAH3QcqW5luPUvx/azRJlZq8LVRFjzl4AH5TaCDlYr24qlmNVqK4Zk2mOwA3HMyHpn5DTuzLQNsMY4lOS9EiIMgvV+Ayjnv1+4HiFMfNLzCR1l0vzpgevgvmYsJqIn+OI7SRlFOnpVHDPaYi97QiWwVsljGfMHklI2J9AcqKhImC+cSeswxVAz9Y4UgzUV1hAlFFgoVKyGX2AtduGnEYYmbKdEXaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAEXG57BKTHSgLa9mJDl/tH2/ad8mlmwECtgHmgFib8=;
 b=K9NgT65lLUuv8rg2R4wIVdwzMphdCzzaal8qCv2BzEPoylTCGTefR6Rjwi2luVF7zc2oxeMTZWCJpqYq8dIN6y3+qtjiShKH6k4MJvmQgG+3P2rsVQ1Af76c/ZS4Xf/j1h5d5fb0O68BHIpVcYytcYaEaq7Z4fNnEofhQ3nHKsU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by GV1PR08MB8743.eurprd08.prod.outlook.com
 (2603:10a6:150:87::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 20:47:09 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:47:09 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v1 18/27] dt-bindings: gpu: panthor: Document AW assignment DT
 property
Date: Tue, 22 Sep 2026 21:45:12 +0100
Message-ID: <20260922204535.2850094-19-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0228.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::16) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|GV1PR08MB8743:EE_|MI3PEPF00008554:EE_|DB9PR08MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d00dd1-d125-46ae-8821-08df18eabfe0
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|366016|10067099003|3023799007|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: FqxatPFpH2Ckh4vhFnCDOyct6vtPxmtFe5Uq9cng9jEdSjByWbQy34DLD7tM+zkE4VaiP98LTTKlH2h8CzyZ2Hlg96qkoUz+raS0FTpCNhNTLKjtYf43bkgLJ+OJp92qtp02KJLSvsa0oQRGujlmFp0LkCPasqMG2HApe8SzYsT89p4/mtBTqSBWCyNQLp/dlfVCss52vJD1eiFeISkJeFJR/xbi2QGYs+7WlTGktqhHyIy9FVIkKNl3PLV7YENYXfMkEpHeeTxo/vX/dvUkeyzIqPmUOx6fTL20MmRgRYGqZM7GRuhxAli7DmR3dI0sHf3O3UrdB0fkTRLHyqwpIdDgcXZ4Ca0q6gaqnVLwnUxI6HxE5vUQO/L3OtyqNtquFX7xMYvKLhlvZF6wELHoSSvSZigvXLpW1FLPwiqiJ+pOkVJjXfGZBvd2ISR4zVWRbw3XSZAFBdWTXyh1wlZSJ0ghevKS8hxKuzpHPjfxHkAKkJ4tt5kWfQ9zOrQPhefjec+oIeLQnRGAFbiOjKmzVyh+s8cLsrF4YTRVTyxHHBbiWeQztrOjqebvKT4WFmC8sG6cCz82LRP1TXogqyOjJy/WO34pAi9hQVDz4djp/lDIDbCq/QogLYud2fiPc6j1AFvVeqeaxTpIT6Pb8oon0aHpcYznNFwNjKgTcFrGWaw=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10067099003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: u28Q32wbXP8Sz7+JEtYAAQ4JnaJwxYjjmjFphGxMA9INJ7aEaU29RAWWzwyP3GUaGSUsQvy830DRwTvYDQGgFTnRDynytk6AROQ6mTbq0XgdzYMGPiO0gFxleNppFafHexSgHEzIswCV8B37eH3qYwe5zKsM5LtM/Hl4QIGKhr4YyyVcQ/u+hd3GIBm6ux0PhiMWbtiUEMolb0jMu9S3Gth3xJMnmQEc1bvVC7r9S4TwWJuEKgwlwLv+guNePR4uEy3o7VbjMWO7Rbg70oGPLSJAuePCUEDQSm9gVo8LM3+WyoDXwgVdG7HWfnE2FkOPc9NTXzZRqlkIFKu69KtpcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8743
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008554.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5e8eac63-341b-4494-a491-08df18eaabdb
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|36860700016|35042699022|82310400026|14060799003|376014|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hOWH2KAUVCQLnbuTXiGxfvnXQNa/AeyhMa/eYKnRFax972AB3D/0uBIsirBxFI9AbD2WR4DypQBR53Q6ZsZTaRM37SftfOtssziJdyszH3mAY7D+X5OPMhS9eCWFbaFAPRJlC8UVDjpttAQBS8ty+HybSWEgRQkflw9p9SGxoOi5qf6UjiETGQ7y9UmAdoeTvrs5Qr3X2i5wCp5ebhDF53NckvgNG7nTyEymIxwKFHG3qs+0WzajNsetKrNNbhJIhwItbuNxaFfWL94EWDmC9Wj7lPihcGs10UZ31UaN352vDjMM2ZWHA9XMxIumpuSXtJ7ZL1Ru/c8cQ+lYQFqo1r4GxIh/swR+9n5PDne4tVXc6ZeCJySgii29jiLIrQjtVBBSkH2MO8rT742yu2UatSt/jDQMxiYK42IRjZ/1ZW7+bcIygDtpdZRcLwrZiI8ZH5+RbjiNtyFquMG8FH3ZRkVcyp6b8CT1+OOFanmuDzDPibHW2hAn7BUgMHPvqrNGLGOpNP7dEpWZnSKe5bDobDWTBX9SYPfE6fOw1S0M3zM3HWkneWgoH8XZtM3SMFijEXhSdycOXVkfpDBWZXeGVi+iZES2Gyc4k/f8fjkngOy6qrTc71fQZ+FUJ86K6h0SkfMcLifR9/5Q15XRU+svNLNZSdSLvpWsc6ZbRgIKIkBBKyU1+AbGut5sx+TzJwHkTvunixy6SbfKLDmvxSYypQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(36860700016)(35042699022)(82310400026)(14060799003)(376014)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vdQs+uSp2ejMRtk9Mv/lvbVmRKgdJq3WsMJ1xohK7lLygccQwx44Kz5fNAAShAP5csBd/a6Co2V8HMBqdLwQK5dE0OhPANT5AMIao+fhNMx98c92phcXBoEraPhDOBNkf9LySivBCaiMGm79Um7fwv2ZgMTInEq0Obq+w8/20RNVDsGv73J8purrpkBdXZtEKQle8j1SobCou/0hj3NxIB4aN+NuhuPu6M9ac+7+7SwBN3GYk/cQ3Xy54mAHz1i3tGct6eO9a+ViCxktIhg2yOw1yWd7z4kUfSaCEGO7t46V5zG0JtnAzAkPHGi+wop5CY8lwclVtCz82xAVSnaiG2s3EuuMuiw+c9O4sp6wrCcYOgN6PtFbQBxzaxr3wk8THBQghLBactOdm8emwO5dqL5T/NRteyagyGxxikjw35qIG5aESPUi0mhNOYzB2RHU
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:47:42.8783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d00dd1-d125-46ae-8821-08df18eabfe0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008554.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7699
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

Introduce arm,access-window-mask property to allow partitions to define
the assigned access windows at probe time.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 .../bindings/gpu/arm,mali-gen5-am-arbitration.yaml     | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbitration.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbitration.yaml
index 9ea2b4bb9a344..4e7933829e2be 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbitration.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbitration.yaml
@@ -52,6 +52,15 @@ patternProperties:
           Hardware partition control index. Must identify a partition present on
           the GPU and be unique among this device's partition nodes.
 
+      arm,access-window-mask:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        maximum: 0xffff
+        default: 0
+        description:
+          Initial access window assignment mask. Bit N selects global
+          access window ID N. Masks must be disjoint across partitions.
+          If omitted, no access windows are assigned by default.
+
     required:
       - reg
       - interrupts
@@ -113,6 +122,7 @@ examples:
             reg = <0x50000 0x10000>;
             interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH 0>;
             arm,id = <0>;
+            arm,access-window-mask = <0xffff>;
         };
 
         resource-group@c0000 {
-- 
2.43.0

