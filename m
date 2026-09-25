Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD47C98326
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8268610F92B;
	Fri, 25 Sep 2026 07:30:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UGUJP1Tj";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qI1ihQ/z";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BF2F10E586;
 Fri, 25 Sep 2026 06:57:17 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68P4a00W1381420;
 Fri, 25 Sep 2026 01:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=SrwyNyw9k7v1to3Ev/5KUeczCAYJjKkF3WRRUkoZs
 7M=; b=UGUJP1Tj1O7D4ae3IZNGgGlcl+s8EXiuyL0P4CIDjfAfo2Ivm45YSFFcg
 j8OiWgziOiOEZdnqGNkL3rDsaxfs19XcC96iwfzwAcxH+cYQSstMu9m99Fw4y+XW
 oxJw4rLdun2ZJalT5B+9A9dSfNCtFu/RdxFPItVXWLzDIy8KIj+DBMuPVtFEOoUJ
 1w6akejNNIUqt7OMjaSAD9NZerY+H7C2NBIMEnhV+Negp80nQ/uWYwguyz/A+Kn0
 kxjn3oxmfLGCOqyDvYfrhugqn3ayKzcCkgS9oCeebiM1u+fqZdg9yyVfkGLwThha
 E0Fz73V0ZOXFQMXigsP5J7JB9+ypA==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gw13rf08b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 01:57:03 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TF48Mf/ne7KQ8bPgk35TaGpnpIq/oWsxdq5jx/aNp/P0ekBBMoLvBrWb2GtH+lF6oFKcedl1CJUGUp7UPIaGeoJghyws14mYdBnI2uyVEASXHHFzHLL2XS7fHbSpTLTPwts+4pVtDqispJXAxlBbgLpJY73F4SvlO0eAZI6g9oW68+h2YZTr10asgHnuWTQZsEKKFvfHDf0hNuCabvH47bOfm/4LKrCEmNA0pVPV1fN8SWmXeMiucAQ33BhUtOLbI357KxeA7jVVAGGmse2hR3IxRw3WwzTID4bIKi8/vScXyTaDhfmd2FmHDwXL00GGRXVnmqo4823E1oADViDKHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrwyNyw9k7v1to3Ev/5KUeczCAYJjKkF3WRRUkoZs7M=;
 b=MUxdLeoE8Zqp0x/7i3lklqbwvNd6GTxEjyKoyK7ugEA88YH17GbSHoxJgaQ8nWf7EitIKnTbq4WmKjDb6/QfoFjhrFLUXNK+ZbcQD9zuuHOYkMdfuWBu7wS8R+h3yZwIaiH9PgiV2SqKy0FiCkPynnUZJIs0XmAe8eZaglAzHp4gOvqMFvNSFunUr1XmrY2qwboxOG5Vcb+pcFi6Gkf41m4lHZt1IhJQD6W1+LgkjDVNTOxEeCBfT6C36sWlLCtFUx2bL9MQR4PXDrOf+TgeCQuS/BcFl4tK6vsf31cIVocV0r5Wp1neeGFednd6Ie+8L+CxwWvonpaQT6sSC1ljHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrwyNyw9k7v1to3Ev/5KUeczCAYJjKkF3WRRUkoZs7M=;
 b=qI1ihQ/zz5z341Qri9iI6sNHkBPobeLB6XPvaNu9xL+tGm/+16bJNHgMHdurR/HH4QwHYG/pplM0CUlTYMAl9LMQxjMaZyMu8kC5jKX9Hl2nmKf1ydbYanmBI0N2TpVTseobHL14wG5O08MN5QU6xjVX9dQoOiA2xneQk8PgUrc=
Received: from BN9PR03CA0841.namprd03.prod.outlook.com (2603:10b6:408:13d::6)
 by CH0PR10MB5083.namprd10.prod.outlook.com (2603:10b6:610:dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Fri, 25 Sep
 2026 06:56:59 +0000
Received: from LV8PEPF00000065.namprd03.prod.outlook.com
 (2603:10b6:408:13d:cafe::e) by BN9PR03CA0841.outlook.office365.com
 (2603:10b6:408:13d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 06:56:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 LV8PEPF00000065.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 06:56:59 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 01:56:55 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 01:56:55 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 25 Sep 2026 01:56:55 -0500
Received: from psdkl-workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [10.24.51.24])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68P6uZ1K1371804;
 Fri, 25 Sep 2026 01:56:49 -0500
From: Aniket Limaye <a-limaye@ti.com>
Date: Fri, 25 Sep 2026 12:26:29 +0530
Subject: [PATCH v3 2/3] i2c: designware: Support per-variant reg/bit
 offsets and intr handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260925-tda54-upstream-i2c-v3-2-544d74e992ff@ti.com>
References: <20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com>
In-Reply-To: <20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>, Nirujogi Pratap
 <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
CC: <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
 <u-kumar1@ti.com>, <lianfeng.ouyang@starfivetech.com>,
 <Ritwick.Sharma@arm.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, Aniket Limaye <a-limaye@ti.com>
X-Mailer: b4 0.14.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000065:EE_|CH0PR10MB5083:EE_
X-MS-Office365-Filtering-Correlation-Id: cd12c5d1-7f4e-46e7-6918-08df1ad231de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|82310400026|36860700016|13003099007|921020|6133799003|3023799007|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /o5kqg5bto5KcOhSGB7gb+/vljN9aeAtwMgUkN+MWVj/tHOrcEJJGxzDCfqwHYCxfHIOFUnXjS6R6jU2qxiOfKf/67uMGIBodlo96/LyNMEHnveD8bx2VSgBFBTau36d3pgVeF9In+CNt5MvFKUQzSU4ny1m1dwHQnyHZOWeI3/6G3pQnrHLWRZ2e0PYcd3ZLstH8TqfhSAVUNXBhmqe/4yO3Wi5Gmz/GfmSY1YYzz88SNG2Quv5eA4tHYDgANZIg03nOCXMeJP1BVuvsf12O4s79P3SaigfNP07e+3LkI0o0Vg3pAkPtdddKOl8q8E2ZPEmcq73wV4uO5OWreguU7bisIq5B3XTTG6xtKbFOPRG0RGZeT6FIb8bagSLiBVf6lMCfbTELSN0ZNfSmzHpdvm2sKm1LEoEu9L7zkTEMbKXYO8/VZEj82X3h/BLRq+VNUCa8ut8ZdMS9vmuuVM+Mb/9S9gVoUDN0AfaWqSa/UbAXvB7tw68rLuhDvHNhd5Iu10xuQCgeYxK9xAkqULypwE2+8ntUmYObvkidBd+U7SlhR0jANA3wgH4inYmL8bJqBV9HZ3vzC0JkMqGPGN1yWZ2O/JC8oXz6NytdTCuFq6DODzJ+lgu8J0tIPy3W5lNazTNlcJiVm8/5MqpAwA47KUZ/mcamDnvHbPurLQ31wuk2B6UAtp29N++Cooyl3PSMRM8aHHAhG8cBfqluk1A8g==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(82310400026)(36860700016)(13003099007)(921020)(6133799003)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7fVrZqcaJttulq0tbDSV+HUG9Vt8hfpdoHbDJ6F2OCStXzxoQ0nkzUtFai+cPoY7qh6Qh26rkZJqrVTCkeMPvddTS5ua2IcAR/3Ge+gD4Ki4ZrkO2VmY+Gp0pX1KCBawo54mTIXfcnggp/E8/UhdN7tgLcsPU0i7hn8U65PNH7eUc39LY7pETppHoXHeUf+MGFldzU+1P88YjcZd1IIxARVgnZT+r56lOruO+oBG/YcA7Ns0pBzvKZZkZZtMS47GFaV6TV/Nf7e5mpS3jIzCnYSFyqaOB7lfPXKtj32pHb8JvfRF8Oj6YYewmoiwdEI+EuG7kBJHmLujmJ2m4VRPA2bWxFCTjwemrbAJ1VaeXD5c3KWZoZFUu5Zf5J4645xJnE35NlZjoDG9HDvUIrTneTrpPKRVPwjX3k3Ys5oXd6Co3gCsYHUK/VfaP1+Gkuaf
X-Exchange-RoutingPolicyChecked: nIbhnn79H5Y3F8Jfd+SsmF2itmXPGgFMinobVGm2zCc+8D4Ze8cg/fRHZiZh9tGiHbNt/k7Fr1hmAtRQbozg4pmLr/0OepbBo0fjWg0VnjfN/Icxqi19zGyqY6PDoJFi/7wepNUyjOUdcRDHKwPpF+VdeVtxaknr2YDFkWy23aq6CKFTXwkyMqkr/jOwdoCorZsStbtKnMv8UkGt2OX+gkKIWrByb5lzb6jTGQKZ7gYsu82hrba1raLUAmJg0suGBBhFK2uRq6iRMVM8Lh4QzFLBpG4HSLKvF0ZFPv8+2dkpzjoaMALBboAIWVuYtj7c32RENRMklXNTlTEIonmMug==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 06:56:59.0904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd12c5d1-7f4e-46e7-6918-08df1ad231de
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000065.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5083
X-Proofpoint-ORIG-GUID: Ud0fbOnRt5ZTsLQGE---80bghYJ2qsGR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyNyBTYWx0ZWRfX9Tgq/mlAGC0p
 HDscWCrDglUIYyS3dbUqGHoabwZPmUEqREHrL6LiuZ5/krPKqaJDbxjcLxXpyOT83L6HM+lYDK1
 +LMl8gO9Ry0tYz8WRWw9h3ytrX3HYjoAo+fnwGvFzhOgMQ5KHn0RjXwjSgNEsctq1lyr070QsWw
 qgsSrl05OXI8tcFGosgrZIiQeumvLulrNc4jTKNDjrRTWUcLYEHQMRcevTLNJOtQdiLOBINRzrJ
 WjA2Akl7N3ydwdtUutuNGovDTD1Z+jfO7Se6WZ5jtn+rVeTaAmsy4Z3DiOscTYiEzVMeOUYZQYf
 rImGqZRHLFK9lAjyWjV0pxy1e6PY97Fut+Nz/frAAp+KPsKYeXSxgRxO2A5Z1N+WaTy2tRcCkai
 Micz767ntDoTO+wpdFuOQ2rrjPi9Srz96vOJpBiVv//PHkeaqjha3a4QhOuZBO55wSVaD2Ok524
 xo/fOSVfmFesbu/PhCQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyNyBTYWx0ZWRfXyXlcV+FD+Ho/
 1SdaQsbqyZDXxMRJ6CyjRzNX8rpvJCd0bwQ+ui5vmZ/yFZj043/RwVElprBwLhkulxLVXtoe7Gg
 GdUEII8qJTLFmjjG0Lkvcmy87IMVFDc=
X-Authority-Analysis: v=2.4 cv=OICyTiaB c=1 sm=1 tr=0 ts=6ab61b3f cx=c_pps
 a=5NePcLBJi4TpPzNSyn8y/w==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=tzzCRWtc428owdMtJjoA:9 a=9V93FWCAGymWaS7Q:21
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ud0fbOnRt5ZTsLQGE---80bghYJ2qsGR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250027
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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

Every DW_IC_* register offset and CON-register bit position is currently
baked in as a compile-time constant, which only works while there is a
single register layout.

- Make DW_IC_* a logical enum (enum dw_ic_reg_id) and the regmap
  internally translates to physical offsets.
- Add a struct to hold the CON-register bitfield positions.
- Fold the read-to-clear interrupt-acknowledgment pattern into a new
  i2c_dw_ack_intr() helper, driven by a per-variant dev->intr_clr[].

All of these are selected at probe time via the new
i2c_dw_select_variant().

Only one variant exists at this point (DW_apb_i2c), so this is a
mechanical, behavior-preserving change. It lays the groundwork for
adding a second register layout without duplicating the whole driver.

Signed-off-by: Aniket Limaye <a-limaye@ti.com>

---

Changes in v3:
- Revert to special handling for the max_register in regmap for
  MODEL_AMD_NAVI_GPU instead of unconditionally including
  AMD_UCSI_INTR_REG in the legal regmap range.
- Link to v2: https://lore.kernel.org/all/20260925-tda54-upstream-i2c-v2-2-261785e58493@ti.com/

Changes in v2:
- Move the Reg ID -> Offset mapping inside the regmap functions such
  that existing calls to reg_read/write are unaltered. This does change
  the reg_read()/reg_write() functions to take reg IDs as input rather
  than their physical offsets, which also requires updates to the
  xe_i2c.c driver to handle the same mapping.
- Link to v1: https://lore.kernel.org/r/20260919-tda54-upstream-i2c-v1-2-b0b9f77be18b@ti.com/
---
 drivers/gpu/drm/xe/regs/xe_i2c_regs.h       |   3 +-
 drivers/i2c/busses/i2c-designware-amdisp.c  |   1 +
 drivers/i2c/busses/i2c-designware-common.c  |  71 +++++++++++---
 drivers/i2c/busses/i2c-designware-core.h    |  52 ++++++++++-
 drivers/i2c/busses/i2c-designware-master.c  |  54 +++++------
 drivers/i2c/busses/i2c-designware-pcidrv.c  |   2 +
 drivers/i2c/busses/i2c-designware-platdrv.c |   2 +
 drivers/i2c/busses/i2c-designware-slave.c   |  26 +++---
 include/linux/designware_i2c.h              | 137 +++++++++++++++++++---------
 9 files changed, 252 insertions(+), 96 deletions(-)

diff --git a/drivers/gpu/drm/xe/regs/xe_i2c_regs.h b/drivers/gpu/drm/xe/regs/xe_i2c_regs.h
index 37550e4a20f8..86449efb4a98 100644
--- a/drivers/gpu/drm/xe/regs/xe_i2c_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_i2c_regs.h
@@ -2,6 +2,7 @@
 #ifndef _XE_I2C_REGS_H_
 #define _XE_I2C_REGS_H_
 
+#include <linux/designware_i2c.h>
 #include <linux/pci_regs.h>
 
 #include "xe_reg_defs.h"
@@ -20,6 +21,6 @@
 #define I2C_CONFIG_CMD			XE_REG(I2C_CONFIG_SPACE_OFFSET + PCI_COMMAND)
 #define I2C_CONFIG_PMCSR		XE_REG(I2C_CONFIG_SPACE_OFFSET + 0x84)
 
-#define I2C_REG(reg)			XE_REG((reg) + I2C_MEM_SPACE_OFFSET)
+#define I2C_REG(reg)			XE_REG(dw_i2c_reg_offsets[reg] + I2C_MEM_SPACE_OFFSET)
 
 #endif /* _XE_I2C_REGS_H_ */
diff --git a/drivers/i2c/busses/i2c-designware-amdisp.c b/drivers/i2c/busses/i2c-designware-amdisp.c
index 9f0ec0fae6f2..f7aa075c9977 100644
--- a/drivers/i2c/busses/i2c-designware-amdisp.c
+++ b/drivers/i2c/busses/i2c-designware-amdisp.c
@@ -46,6 +46,7 @@ static int amd_isp_dw_i2c_plat_probe(struct platform_device *pdev)
 	isp_i2c_dev->flags |= ACCESS_POLLING;
 	platform_set_drvdata(pdev, isp_i2c_dev);
 
+	i2c_dw_select_variant(isp_i2c_dev);
 	isp_i2c_dev->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(isp_i2c_dev->base))
 		return dev_err_probe(&pdev->dev, PTR_ERR(isp_i2c_dev->base),
diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index a1eca6cd4b75..bd25b9c582c1 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -72,11 +72,55 @@ static const char *const abort_sources[] = {
 		"incorrect slave-transmitter mode configuration",
 };
 
+static const struct dw_i2c_con_bits dw_i2c_con_bits = {
+	.master			= DW_IC_CON_MASTER,
+	.speed_std		= DW_IC_CON_SPEED_STD,
+	.speed_fast		= DW_IC_CON_SPEED_FAST,
+	.speed_high		= DW_IC_CON_SPEED_HIGH,
+	.speed_mask		= DW_IC_CON_SPEED_MASK,
+	.bit10_slave		= DW_IC_CON_10BITADDR_SLAVE,
+	.bit10_master		= DW_IC_CON_10BITADDR_MASTER,
+	.restart_en		= DW_IC_CON_RESTART_EN,
+	.slave_disable		= DW_IC_CON_SLAVE_DISABLE,
+	.stop_det_ifaddressed	= DW_IC_CON_STOP_DET_IFADDRESSED,
+	.tx_empty_ctrl		= DW_IC_CON_TX_EMPTY_CTRL,
+	.rx_fifo_full_hld_ctrl	= DW_IC_CON_RX_FIFO_FULL_HLD_CTRL,
+	.bus_clear_ctrl		= DW_IC_CON_BUS_CLEAR_CTRL,
+};
+
+/* "snps,designware-i2c": dedicated read-to-clear register ID per logical interrupt */
+static const u32 dw_i2c_intr_clr[DW_INTR_IDX_MAX] = {
+	[DW_INTR_IDX_INTR]      = DW_IC_CLR_INTR,
+	[DW_INTR_IDX_RX_UNDER]  = DW_IC_CLR_RX_UNDER,
+	[DW_INTR_IDX_RX_OVER]   = DW_IC_CLR_RX_OVER,
+	[DW_INTR_IDX_TX_OVER]   = DW_IC_CLR_TX_OVER,
+	[DW_INTR_IDX_RD_REQ]    = DW_IC_CLR_RD_REQ,
+	[DW_INTR_IDX_TX_ABRT]   = DW_IC_CLR_TX_ABRT,
+	[DW_INTR_IDX_RX_DONE]   = DW_IC_CLR_RX_DONE,
+	[DW_INTR_IDX_ACTIVITY]  = DW_IC_CLR_ACTIVITY,
+	[DW_INTR_IDX_STOP_DET]  = DW_IC_CLR_STOP_DET,
+	[DW_INTR_IDX_START_DET] = DW_IC_CLR_START_DET,
+	[DW_INTR_IDX_GEN_CALL]  = DW_IC_CLR_GEN_CALL,
+};
+
+/**
+ * i2c_dw_select_variant() - Pick the register offset table, CON-register bit
+ * layout and interrupt-ack mapping matching this device's IP variant
+ * @dev: device private data
+ */
+void i2c_dw_select_variant(struct dw_i2c_dev *dev)
+{
+	dev->regs = dw_i2c_reg_offsets;
+	dev->con_bits = &dw_i2c_con_bits;
+	dev->intr_clr = dw_i2c_intr_clr;
+}
+EXPORT_SYMBOL_GPL(i2c_dw_select_variant);
+
 static int dw_reg_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct dw_i2c_dev *dev = context;
 
-	*val = readl(dev->base + reg);
+	*val = readl(dev->base + dev->regs[reg]);
 
 	return 0;
 }
@@ -85,7 +129,7 @@ static int dw_reg_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct dw_i2c_dev *dev = context;
 
-	writel(val, dev->base + reg);
+	writel(val, dev->base + dev->regs[reg]);
 
 	return 0;
 }
@@ -94,7 +138,7 @@ static int dw_reg_read_swab(void *context, unsigned int reg, unsigned int *val)
 {
 	struct dw_i2c_dev *dev = context;
 
-	*val = swab32(readl(dev->base + reg));
+	*val = swab32(readl(dev->base + dev->regs[reg]));
 
 	return 0;
 }
@@ -103,7 +147,7 @@ static int dw_reg_write_swab(void *context, unsigned int reg, unsigned int val)
 {
 	struct dw_i2c_dev *dev = context;
 
-	writel(swab32(val), dev->base + reg);
+	writel(swab32(val), dev->base + dev->regs[reg]);
 
 	return 0;
 }
@@ -111,9 +155,10 @@ static int dw_reg_write_swab(void *context, unsigned int reg, unsigned int val)
 static int dw_reg_read_word(void *context, unsigned int reg, unsigned int *val)
 {
 	struct dw_i2c_dev *dev = context;
+	unsigned int offset = dev->regs[reg];
 
-	*val = readw(dev->base + reg) |
-		(readw(dev->base + reg + DW_IC_REG_STEP_BYTES) << DW_IC_REG_WORD_SHIFT);
+	*val = readw(dev->base + offset) |
+		(readw(dev->base + offset + DW_IC_REG_STEP_BYTES) << DW_IC_REG_WORD_SHIFT);
 
 	return 0;
 }
@@ -121,9 +166,10 @@ static int dw_reg_read_word(void *context, unsigned int reg, unsigned int *val)
 static int dw_reg_write_word(void *context, unsigned int reg, unsigned int val)
 {
 	struct dw_i2c_dev *dev = context;
+	unsigned int offset = dev->regs[reg];
 
-	writew(val, dev->base + reg);
-	writew(val >> DW_IC_REG_WORD_SHIFT, dev->base + reg + DW_IC_REG_STEP_BYTES);
+	writew(val, dev->base + offset);
+	writew(val >> DW_IC_REG_WORD_SHIFT, dev->base + offset + DW_IC_REG_STEP_BYTES);
 
 	return 0;
 }
@@ -143,7 +189,7 @@ static int i2c_dw_init_regmap(struct dw_i2c_dev *dev)
 	struct regmap_config map_cfg = {
 		.reg_bits = 32,
 		.val_bits = 32,
-		.reg_stride = 4,
+		.reg_stride = 1,
 		.disable_locking = true,
 		.reg_read = dw_reg_read,
 		.reg_write = dw_reg_write,
@@ -163,7 +209,7 @@ static int i2c_dw_init_regmap(struct dw_i2c_dev *dev)
 	if (ret)
 		return ret;
 
-	reg = readl(dev->base + DW_IC_COMP_TYPE);
+	reg = readl(dev->base + dev->regs[DW_IC_COMP_TYPE]);
 	i2c_dw_release_lock(dev);
 
 	if ((dev->flags & MODEL_MASK) == MODEL_AMD_NAVI_GPU)
@@ -845,7 +891,6 @@ u32 i2c_dw_func(struct i2c_adapter *adap)
 
 void i2c_dw_disable(struct dw_i2c_dev *dev)
 {
-	unsigned int dummy;
 	int ret;
 
 	ret = i2c_dw_acquire_lock(dev);
@@ -857,7 +902,7 @@ void i2c_dw_disable(struct dw_i2c_dev *dev)
 
 	/* Disable all interrupts */
 	__i2c_dw_write_intr_mask(dev, 0);
-	regmap_read(dev->map, DW_IC_CLR_INTR, &dummy);
+	i2c_dw_ack_intr(dev, DW_INTR_IDX_INTR);
 
 	i2c_dw_release_lock(dev);
 }
@@ -1055,7 +1100,7 @@ void i2c_dw_shutdown(struct dw_i2c_dev *dev)
 	 * disable bit while the controller is still enabled.
 	 */
 	regmap_read(dev->map, DW_IC_CON, &con);
-	con |= DW_IC_CON_SLAVE_DISABLE;
+	con |= dev->con_bits->slave_disable;
 	regmap_write(dev->map, DW_IC_CON, con);
 
 	i2c_dw_disable(dev);
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 2c929a6e8da2..4c782594ab4e 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -43,6 +43,42 @@
 #define DW_IC_SDA_HOLD_MIN_VERS			0x3131312A /* "111*" == v1.11* */
 #define DW_IC_COMP_TYPE_VALUE			0x44570140 /* "DW" + 0x0140 */
 
+/*
+ * Bit positions within the CON register that could differ between IP
+ * variants.
+ */
+struct dw_i2c_con_bits {
+	u32 master;
+	u32 speed_std;
+	u32 speed_fast;
+	u32 speed_high;
+	u32 speed_mask;
+	u32 bit10_slave;
+	u32 bit10_master;
+	u32 restart_en;
+	u32 slave_disable;
+	u32 stop_det_ifaddressed;
+	u32 tx_empty_ctrl;
+	u32 rx_fifo_full_hld_ctrl;
+	u32 bus_clear_ctrl;
+};
+
+/* Logical interrupt IDs for i2c_dw_ack_intr() */
+enum dw_i2c_intr_idx {
+	DW_INTR_IDX_INTR,
+	DW_INTR_IDX_RX_UNDER,
+	DW_INTR_IDX_RX_OVER,
+	DW_INTR_IDX_TX_OVER,
+	DW_INTR_IDX_RD_REQ,
+	DW_INTR_IDX_TX_ABRT,
+	DW_INTR_IDX_RX_DONE,
+	DW_INTR_IDX_ACTIVITY,
+	DW_INTR_IDX_STOP_DET,
+	DW_INTR_IDX_START_DET,
+	DW_INTR_IDX_GEN_CALL,
+	DW_INTR_IDX_MAX,
+};
+
 #define DW_IC_INTR_DEFAULT_MASK			(DW_IC_INTR_RX_FULL | \
 						 DW_IC_INTR_TX_ABRT | \
 						 DW_IC_INTR_STOP_DET)
@@ -126,6 +162,9 @@ struct reset_control;
  * struct dw_i2c_dev - private i2c-designware data
  * @dev: driver model device node
  * @map: IO registers map
+ * @regs: logical-to-physical register offset table for the active IP variant
+ * @con_bits: CON register bit-layout for the active IP variant
+ * @intr_clr: logical intr number to reg table for the active IP variant
  * @sysmap: System controller registers map
  * @base: IO registers pointer
  * @ext: Extended IO registers pointer
@@ -189,6 +228,9 @@ struct reset_control;
 struct dw_i2c_dev {
 	struct device		*dev;
 	struct regmap		*map;
+	const u32		*regs;
+	const struct dw_i2c_con_bits *con_bits;
+	const u32		*intr_clr;
 	struct regmap		*sysmap;
 	void __iomem		*base;
 	void __iomem		*ext;
@@ -255,7 +297,6 @@ struct dw_i2c_dev {
  * Enable UCSI interrupt by writing 0xd at register
  * offset 0x474 specified in hardware specification.
  */
-#define AMD_UCSI_INTR_REG			0x474
 #define AMD_UCSI_INTR_EN			0xd
 
 #define TXGBE_TX_FIFO_DEPTH			4
@@ -265,6 +306,7 @@ struct i2c_dw_semaphore_callbacks {
 	int	(*probe)(struct dw_i2c_dev *dev);
 };
 
+void i2c_dw_select_variant(struct dw_i2c_dev *dev);
 u32 i2c_dw_scl_hcnt(struct dw_i2c_dev *dev, unsigned int reg, u32 ic_clk,
 		    u32 tSYMBOL, u32 tf, int offset);
 u32 i2c_dw_scl_lcnt(struct dw_i2c_dev *dev, unsigned int reg, u32 ic_clk,
@@ -310,6 +352,14 @@ static inline void __i2c_dw_read_intr_mask(struct dw_i2c_dev *dev,
 		*intr_mask = dev->sw_mask;
 }
 
+/* Acknowledge a logical interrupt via dev->intr_clr[]: reg ID */
+static inline void i2c_dw_ack_intr(struct dw_i2c_dev *dev, enum dw_i2c_intr_idx intr)
+{
+	unsigned int dummy;
+
+	regmap_read(dev->map, dev->intr_clr[intr], &dummy);
+}
+
 void __i2c_dw_disable(struct dw_i2c_dev *dev);
 void i2c_dw_disable(struct dw_i2c_dev *dev);
 
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index a1bcc3797e4f..329f958ded3e 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -133,14 +133,14 @@ static int i2c_dw_set_timings_master(struct dw_i2c_dev *dev)
 		fp_str, dev->fs_hcnt, dev->fs_lcnt);
 
 	/* Check is high speed possible and fall back to fast mode if not */
-	if ((dev->master_cfg & DW_IC_CON_SPEED_MASK) ==
-		DW_IC_CON_SPEED_HIGH) {
+	if ((dev->master_cfg & dev->con_bits->speed_mask) ==
+		dev->con_bits->speed_high) {
 		if ((comp_param1 & DW_IC_COMP_PARAM_1_SPEED_MODE_MASK)
 			!= DW_IC_COMP_PARAM_1_SPEED_MODE_HIGH) {
 			dev_err(dev->dev, "High Speed not supported!\n");
 			t->bus_freq_hz = I2C_MAX_FAST_MODE_FREQ;
-			dev->master_cfg &= ~DW_IC_CON_SPEED_MASK;
-			dev->master_cfg |= DW_IC_CON_SPEED_FAST;
+			dev->master_cfg &= ~dev->con_bits->speed_mask;
+			dev->master_cfg |= dev->con_bits->speed_fast;
 			dev->hs_hcnt = 0;
 			dev->hs_lcnt = 0;
 		} else if (!dev->hs_hcnt || !dev->hs_lcnt) {
@@ -200,7 +200,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 
 	/* If the slave address is ten bit address, enable 10BITADDR */
 	if (msgs[dev->msg_write_idx].flags & I2C_M_TEN) {
-		ic_con = DW_IC_CON_10BITADDR_MASTER;
+		ic_con = dev->con_bits->bit10_master;
 		/*
 		 * If I2C_DYNAMIC_TAR_UPDATE is set, the 10-bit addressing
 		 * mode has to be enabled via bit 12 of IC_TAR register.
@@ -210,7 +210,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 		ic_tar = DW_IC_TAR_10BITADDR_MASTER;
 	}
 
-	regmap_update_bits(dev->map, DW_IC_CON, DW_IC_CON_10BITADDR_MASTER,
+	regmap_update_bits(dev->map, DW_IC_CON, dev->con_bits->bit10_master,
 			   ic_con);
 
 	/*
@@ -230,7 +230,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 	regmap_read(dev->map, DW_IC_ENABLE_STATUS, &dummy);
 
 	/* Clear and enable interrupts */
-	regmap_read(dev->map, DW_IC_CLR_INTR, &dummy);
+	i2c_dw_ack_intr(dev, DW_INTR_IDX_INTR);
 	__i2c_dw_write_intr_mask(dev, DW_IC_INTR_MASTER_MASK);
 }
 
@@ -399,8 +399,8 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 			 * IC_RESTART_EN are set, we must manually
 			 * set restart bit between messages.
 			 */
-			if ((dev->master_cfg & DW_IC_CON_RESTART_EN) &&
-					(dev->msg_write_idx > 0))
+			if (dev->master_cfg & dev->con_bits->restart_en &&
+			    dev->msg_write_idx > 0)
 				need_restart = true;
 		}
 
@@ -574,7 +574,7 @@ i2c_dw_read(struct dw_i2c_dev *dev)
 
 static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
 {
-	unsigned int stat, dummy;
+	unsigned int stat;
 
 	/*
 	 * The IC_INTR_STAT register just indicates "enabled" interrupts.
@@ -603,32 +603,32 @@ static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
 	 * Instead, use the separately-prepared IC_CLR_* registers.
 	 */
 	if (stat & DW_IC_INTR_RX_UNDER)
-		regmap_read(dev->map, DW_IC_CLR_RX_UNDER, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_RX_UNDER);
 	if (stat & DW_IC_INTR_RX_OVER)
-		regmap_read(dev->map, DW_IC_CLR_RX_OVER, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_RX_OVER);
 	if (stat & DW_IC_INTR_TX_OVER)
-		regmap_read(dev->map, DW_IC_CLR_TX_OVER, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_TX_OVER);
 	if (stat & DW_IC_INTR_RD_REQ)
-		regmap_read(dev->map, DW_IC_CLR_RD_REQ, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_RD_REQ);
 	if (stat & DW_IC_INTR_TX_ABRT) {
 		/*
 		 * The IC_TX_ABRT_SOURCE register is cleared whenever
 		 * the IC_CLR_TX_ABRT is read.  Preserve it beforehand.
 		 */
 		regmap_read(dev->map, DW_IC_TX_ABRT_SOURCE, &dev->abort_source);
-		regmap_read(dev->map, DW_IC_CLR_TX_ABRT, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_TX_ABRT);
 	}
 	if (stat & DW_IC_INTR_RX_DONE)
-		regmap_read(dev->map, DW_IC_CLR_RX_DONE, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_RX_DONE);
 	if (stat & DW_IC_INTR_ACTIVITY)
-		regmap_read(dev->map, DW_IC_CLR_ACTIVITY, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_ACTIVITY);
 	if ((stat & DW_IC_INTR_STOP_DET) &&
 	    ((dev->rx_outstanding == 0) || (stat & DW_IC_INTR_RX_FULL)))
-		regmap_read(dev->map, DW_IC_CLR_STOP_DET, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_STOP_DET);
 	if (stat & DW_IC_INTR_START_DET)
-		regmap_read(dev->map, DW_IC_CLR_START_DET, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_START_DET);
 	if (stat & DW_IC_INTR_GEN_CALL)
-		regmap_read(dev->map, DW_IC_CLR_GEN_CALL, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_GEN_CALL);
 
 	return stat;
 }
@@ -940,20 +940,20 @@ void i2c_dw_configure_master(struct dw_i2c_dev *dev)
 	if ((dev->flags & MODEL_MASK) != MODEL_AMD_NAVI_GPU)
 		dev->functionality |= I2C_FUNC_PROTOCOL_MANGLING;
 
-	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
-			  DW_IC_CON_RESTART_EN;
+	dev->master_cfg = dev->con_bits->master | dev->con_bits->slave_disable |
+			  dev->con_bits->restart_en;
 
 	dev->mode = DW_IC_MASTER;
 
 	switch (t->bus_freq_hz) {
 	case I2C_MAX_STANDARD_MODE_FREQ:
-		dev->master_cfg |= DW_IC_CON_SPEED_STD;
+		dev->master_cfg |= dev->con_bits->speed_std;
 		break;
 	case I2C_MAX_HIGH_SPEED_MODE_FREQ:
-		dev->master_cfg |= DW_IC_CON_SPEED_HIGH;
+		dev->master_cfg |= dev->con_bits->speed_high;
 		break;
 	default:
-		dev->master_cfg |= DW_IC_CON_SPEED_FAST;
+		dev->master_cfg |= dev->con_bits->speed_fast;
 	}
 }
 EXPORT_SYMBOL_GPL(i2c_dw_configure_master);
@@ -1042,8 +1042,8 @@ int i2c_dw_probe_master(struct dw_i2c_dev *dev)
 	if (ret)
 		return ret;
 
-	if (ic_con & DW_IC_CON_BUS_CLEAR_CTRL)
-		dev->master_cfg |= DW_IC_CON_BUS_CLEAR_CTRL;
+	if (ic_con & dev->con_bits->bus_clear_ctrl)
+		dev->master_cfg |= dev->con_bits->bus_clear_ctrl;
 
 	return i2c_dw_init_recovery_info(dev);
 }
diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 468287922363..fc73106fb0f9 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -246,6 +246,8 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, dev);
 
+	i2c_dw_select_variant(dev);
+
 	if (controller->setup) {
 		r = controller->setup(pdev, controller);
 		if (r)
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 447af5523c2e..42b34c678146 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -156,6 +156,8 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	dev->flags = flags;
 	platform_set_drvdata(pdev, dev);
 
+	i2c_dw_select_variant(dev);
+
 	ret = dw_i2c_plat_request_regs(dev);
 	if (ret)
 		return ret;
diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index 0abcc7757b23..0985e907c9c3 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -65,7 +65,7 @@ int i2c_dw_unreg_slave(struct i2c_client *slave)
 
 static u32 i2c_dw_read_clear_intrbits_slave(struct dw_i2c_dev *dev)
 {
-	unsigned int stat, dummy;
+	unsigned int stat;
 
 	/*
 	 * The IC_INTR_STAT register just indicates "enabled" interrupts.
@@ -89,23 +89,23 @@ static u32 i2c_dw_read_clear_intrbits_slave(struct dw_i2c_dev *dev)
 	 * Instead, use the separately-prepared IC_CLR_* registers.
 	 */
 	if (stat & DW_IC_INTR_TX_ABRT)
-		regmap_read(dev->map, DW_IC_CLR_TX_ABRT, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_TX_ABRT);
 	if (stat & DW_IC_INTR_RX_UNDER)
-		regmap_read(dev->map, DW_IC_CLR_RX_UNDER, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_RX_UNDER);
 	if (stat & DW_IC_INTR_RX_OVER)
-		regmap_read(dev->map, DW_IC_CLR_RX_OVER, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_RX_OVER);
 	if (stat & DW_IC_INTR_TX_OVER)
-		regmap_read(dev->map, DW_IC_CLR_TX_OVER, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_TX_OVER);
 	if (stat & DW_IC_INTR_RX_DONE)
-		regmap_read(dev->map, DW_IC_CLR_RX_DONE, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_RX_DONE);
 	if (stat & DW_IC_INTR_ACTIVITY)
-		regmap_read(dev->map, DW_IC_CLR_ACTIVITY, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_ACTIVITY);
 	if (stat & DW_IC_INTR_STOP_DET)
-		regmap_read(dev->map, DW_IC_CLR_STOP_DET, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_STOP_DET);
 	if (stat & DW_IC_INTR_START_DET)
-		regmap_read(dev->map, DW_IC_CLR_START_DET, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_START_DET);
 	if (stat & DW_IC_INTR_GEN_CALL)
-		regmap_read(dev->map, DW_IC_CLR_GEN_CALL, &dummy);
+		i2c_dw_ack_intr(dev, DW_INTR_IDX_GEN_CALL);
 
 	return stat;
 }
@@ -155,7 +155,7 @@ irqreturn_t i2c_dw_isr_slave(struct dw_i2c_dev *dev)
 
 	if (stat & DW_IC_INTR_RD_REQ) {
 		if (slave_activity) {
-			regmap_read(dev->map, DW_IC_CLR_RD_REQ, &tmp);
+			i2c_dw_ack_intr(dev, DW_INTR_IDX_RD_REQ);
 
 			if (!(dev->status & STATUS_READ_IN_PROGRESS)) {
 				i2c_slave_event(dev->slave,
@@ -185,8 +185,8 @@ void i2c_dw_configure_slave(struct dw_i2c_dev *dev)
 
 	dev->functionality |= I2C_FUNC_SLAVE;
 
-	dev->slave_cfg = DW_IC_CON_RX_FIFO_FULL_HLD_CTRL |
-			 DW_IC_CON_RESTART_EN | DW_IC_CON_STOP_DET_IFADDRESSED;
+	dev->slave_cfg = dev->con_bits->rx_fifo_full_hld_ctrl |
+			 dev->con_bits->restart_en | dev->con_bits->stop_det_ifaddressed;
 }
 EXPORT_SYMBOL_GPL(i2c_dw_configure_slave);
 
diff --git a/include/linux/designware_i2c.h b/include/linux/designware_i2c.h
index 53f37f18a722..994e0e5ea623 100644
--- a/include/linux/designware_i2c.h
+++ b/include/linux/designware_i2c.h
@@ -11,48 +11,103 @@
 #include <linux/bits.h>
 
 /*
- * Registers offset
+ * Logical register IDs. Each ID is resolved to a physical offset via a
+ * per-variant table (see dw_i2c_reg_offsets[] below); regmap backends
+ * (dw_reg_read()/dw_reg_write() and the Xe I2C_REG() macro) perform that
+ * lookup so callers never need to know the real offset.
  */
-#define DW_IC_CON				0x00
-#define DW_IC_TAR				0x04
-#define DW_IC_SAR				0x08
-#define DW_IC_DATA_CMD				0x10
-#define DW_IC_SS_SCL_HCNT			0x14
-#define DW_IC_SS_SCL_LCNT			0x18
-#define DW_IC_FS_SCL_HCNT			0x1c
-#define DW_IC_FS_SCL_LCNT			0x20
-#define DW_IC_HS_SCL_HCNT			0x24
-#define DW_IC_HS_SCL_LCNT			0x28
-#define DW_IC_INTR_STAT				0x2c
-#define DW_IC_INTR_MASK				0x30
-#define DW_IC_RAW_INTR_STAT			0x34
-#define DW_IC_RX_TL				0x38
-#define DW_IC_TX_TL				0x3c
-#define DW_IC_CLR_INTR				0x40
-#define DW_IC_CLR_RX_UNDER			0x44
-#define DW_IC_CLR_RX_OVER			0x48
-#define DW_IC_CLR_TX_OVER			0x4c
-#define DW_IC_CLR_RD_REQ			0x50
-#define DW_IC_CLR_TX_ABRT			0x54
-#define DW_IC_CLR_RX_DONE			0x58
-#define DW_IC_CLR_ACTIVITY			0x5c
-#define DW_IC_CLR_STOP_DET			0x60
-#define DW_IC_CLR_START_DET			0x64
-#define DW_IC_CLR_GEN_CALL			0x68
-#define DW_IC_ENABLE				0x6c
-#define DW_IC_STATUS				0x70
-#define DW_IC_TXFLR				0x74
-#define DW_IC_RXFLR				0x78
-#define DW_IC_SDA_HOLD				0x7c
-#define DW_IC_TX_ABRT_SOURCE			0x80
-#define DW_IC_ENABLE_STATUS			0x9c
-#define DW_IC_CLR_RESTART_DET			0xa8
-#define DW_IC_SMBUS_INTR_STAT			0xc8
-#define DW_IC_SMBUS_INTR_MASK			0xcc
-#define DW_IC_CLR_SMBUS_INTR			0xd4
-#define DW_IC_COMP_PARAM_1			0xf4
-#define DW_IC_COMP_VERSION			0xf8
-#define DW_IC_COMP_TYPE				0xfc
+enum dw_ic_reg_id {
+	DW_IC_CON,
+	DW_IC_TAR,
+	DW_IC_SAR,
+	DW_IC_DATA_CMD,
+	DW_IC_SS_SCL_HCNT,
+	DW_IC_SS_SCL_LCNT,
+	DW_IC_FS_SCL_HCNT,
+	DW_IC_FS_SCL_LCNT,
+	DW_IC_HS_SCL_HCNT,
+	DW_IC_HS_SCL_LCNT,
+	DW_IC_INTR_STAT,
+	DW_IC_INTR_MASK,
+	DW_IC_RAW_INTR_STAT,
+	DW_IC_RX_TL,
+	DW_IC_TX_TL,
+	DW_IC_CLR_INTR,
+	DW_IC_CLR_RX_UNDER,
+	DW_IC_CLR_RX_OVER,
+	DW_IC_CLR_TX_OVER,
+	DW_IC_CLR_RD_REQ,
+	DW_IC_CLR_TX_ABRT,
+	DW_IC_CLR_RX_DONE,
+	DW_IC_CLR_ACTIVITY,
+	DW_IC_CLR_STOP_DET,
+	DW_IC_CLR_START_DET,
+	DW_IC_CLR_GEN_CALL,
+	DW_IC_ENABLE,
+	DW_IC_STATUS,
+	DW_IC_TXFLR,
+	DW_IC_RXFLR,
+	DW_IC_SDA_HOLD,
+	DW_IC_TX_ABRT_SOURCE,
+	DW_IC_ENABLE_STATUS,
+	DW_IC_CLR_RESTART_DET,
+	DW_IC_SMBUS_INTR_STAT,
+	DW_IC_SMBUS_INTR_MASK,
+	DW_IC_CLR_SMBUS_INTR,
+	DW_IC_COMP_PARAM_1,
+	DW_IC_COMP_VERSION,
+	DW_IC_COMP_TYPE,
+	AMD_UCSI_INTR_REG,
+	DW_IC_REG_MAX
+};
+
+/*
+ * Default "snps,designware-i2c" register offsets, indexed by
+ * enum dw_ic_reg_id.
+ */
+static const __maybe_unused u32 dw_i2c_reg_offsets[DW_IC_REG_MAX] = {
+	[DW_IC_CON]			= 0x00,
+	[DW_IC_TAR]			= 0x04,
+	[DW_IC_SAR]			= 0x08,
+	[DW_IC_DATA_CMD]		= 0x10,
+	[DW_IC_SS_SCL_HCNT]		= 0x14,
+	[DW_IC_SS_SCL_LCNT]		= 0x18,
+	[DW_IC_FS_SCL_HCNT]		= 0x1c,
+	[DW_IC_FS_SCL_LCNT]		= 0x20,
+	[DW_IC_HS_SCL_HCNT]		= 0x24,
+	[DW_IC_HS_SCL_LCNT]		= 0x28,
+	[DW_IC_INTR_STAT]		= 0x2c,
+	[DW_IC_INTR_MASK]		= 0x30,
+	[DW_IC_RAW_INTR_STAT]		= 0x34,
+	[DW_IC_RX_TL]			= 0x38,
+	[DW_IC_TX_TL]			= 0x3c,
+	[DW_IC_CLR_INTR]		= 0x40,
+	[DW_IC_CLR_RX_UNDER]		= 0x44,
+	[DW_IC_CLR_RX_OVER]		= 0x48,
+	[DW_IC_CLR_TX_OVER]		= 0x4c,
+	[DW_IC_CLR_RD_REQ]		= 0x50,
+	[DW_IC_CLR_TX_ABRT]		= 0x54,
+	[DW_IC_CLR_RX_DONE]		= 0x58,
+	[DW_IC_CLR_ACTIVITY]		= 0x5c,
+	[DW_IC_CLR_STOP_DET]		= 0x60,
+	[DW_IC_CLR_START_DET]		= 0x64,
+	[DW_IC_CLR_GEN_CALL]		= 0x68,
+	[DW_IC_ENABLE]			= 0x6c,
+	[DW_IC_STATUS]			= 0x70,
+	[DW_IC_TXFLR]			= 0x74,
+	[DW_IC_RXFLR]			= 0x78,
+	[DW_IC_SDA_HOLD]		= 0x7c,
+	[DW_IC_TX_ABRT_SOURCE]		= 0x80,
+	[DW_IC_ENABLE_STATUS]		= 0x9c,
+	[DW_IC_CLR_RESTART_DET]		= 0xa8,
+	[DW_IC_SMBUS_INTR_STAT]		= 0xc8,
+	[DW_IC_SMBUS_INTR_MASK]		= 0xcc,
+	[DW_IC_CLR_SMBUS_INTR]		= 0xd4,
+	[DW_IC_COMP_PARAM_1]		= 0xf4,
+	[DW_IC_COMP_VERSION]		= 0xf8,
+	[DW_IC_COMP_TYPE]		= 0xfc,
+	[AMD_UCSI_INTR_REG]		= 0x474,
+};
 
 /* DW_IC_CON bits */
 #define DW_IC_CON_MASTER			BIT(0)

-- 
2.53.0

