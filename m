Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF44C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:32:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D04310F91E;
	Fri, 25 Sep 2026 07:30:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mPR24nkG";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iCpG2bEz";
	dkim-atps=neutral
X-Greylist: delayed 778 seconds by postgrey-1.36 at gabe;
 Thu, 24 Sep 2026 23:54:15 UTC
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B34E10E558;
 Thu, 24 Sep 2026 23:54:15 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OMPtY2485854; Thu, 24 Sep 2026 18:41:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=WtenFQEtwRP4t/ve7kg88QFRBWouW8zHv4orw6JNt
 7k=; b=mPR24nkGEvh9Tpi+BYFrDCEAbkfYrRQIFaE0i1OjWnoKryUSJs3MrEwA+
 6b+AEPO/z7yrodrkcpVfH8Nrz9kKjRWuOEsZbINOO7+m2FfueKbG43a8aOVntj/i
 rlMBK7SBmsfJZNSMpodjnNGpYelF1+PpApb4hkFnDuc3et3B7dKoLQhdp45nkuzs
 QTOurzNFWa8ph5D3mEFUnXsyMFnmPRxiNEZOHL7IdqgX9blrm9MZ2voZB/j0KssJ
 vr9jR63DL7hvYhI2gsmjrHHdnhl3QLx2XxfsvHq1hxVQcirYSHK9scYNG/7q+2LO
 yphL+9h94EvHiqJ2fmKhW2hJgVILA==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012026.outbound.protection.outlook.com
 [40.107.200.26])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gvwm3637b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 18:41:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckBXoRzzyPoB3BseGm9t9ObVW77tGZUxqv7yGdxUXj9UbuBgFsfFVQSUKHe0pYsOSlnRyq/QygcAKBzUWwxGge+D9ZFEQVNC1BbWZpJf7uHUROdvwz0yo/NfZG3D8UOpyKBSDu9X435vH2JJ7S4yS0QkBLl5BLofSjE7wlcuPVyz+YPMavBICmh45X0H4imyuZBpImEMUaAmG+8obGDWyzlRmkcVoaLGBYThJpXo0wBBvN0Y9XZe78kT45Bqgr6amWUCLIYPdfz+Yh3WwCoER1p+zBn+1PRcbTYzsHoFrTYOyNTJmGxFdlOL5k/xIgnqKJjGMDeL39qh4GALi4YZ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtenFQEtwRP4t/ve7kg88QFRBWouW8zHv4orw6JNt7k=;
 b=T6wM7E+nrg285NtVmhQABilzrS8UOF0/b0Fuo8B13ZI11kzrAz3jIfC0Zz9vlmUo7p/QCdLEJRbKvFkbAls4CcoAUMbynuFnxq5CRpyxNG7AQ4NMqE6GUmKB+MJ7d3DRBy3THIHo+73gtJTOQ6c31MpVxqDyb4cMia3i44rZfTcFzK2XIXWM/4mh9nnwEyMsiaSOtysn3VJhsgZloChac/bmPE1DmhP5v/Ur5XfW6cwzNh5+uJh2pjLijcY5n4RSH+tb2ozbsS4p55o8jpkJzqL4K0J9rzLiD+9kY8icn1SGLDy61jP9MoPgzwGk6bVfNdqf/nLPLqk74uuNG0NxVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtenFQEtwRP4t/ve7kg88QFRBWouW8zHv4orw6JNt7k=;
 b=iCpG2bEzObf3JLmENz8X17+cgp1JpDbKoHD90ZYI/3/hnZNsveJA6X0hQUbk+B22F0PNomjZs4PFrfWn9mVRDozvOU2H0bQDI+u50z5Az9LLEmp+bBu6BA4/5xdLbHqoeROBe2w+laSVe0ceONUiBEHXDYXL2T41h1ygrFplH1s=
Received: from CH5PR05CA0018.namprd05.prod.outlook.com (2603:10b6:610:1f0::28)
 by DM4PR10MB6014.namprd10.prod.outlook.com (2603:10b6:8:ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Thu, 24 Sep
 2026 23:41:25 +0000
Received: from BN2PEPF0000A802.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::a4) by CH5PR05CA0018.outlook.office365.com
 (2603:10b6:610:1f0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 23:41:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN2PEPF0000A802.mail.protection.outlook.com (10.167.245.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 23:41:24 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 24 Sep
 2026 18:41:00 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 24 Sep
 2026 18:40:59 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 24 Sep 2026 18:40:59 -0500
Received: from psdkl-workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [10.24.51.24])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68ONeXkx785172;
 Thu, 24 Sep 2026 18:40:53 -0500
From: Aniket Limaye <a-limaye@ti.com>
Date: Fri, 25 Sep 2026 05:10:22 +0530
Subject: [PATCH v2 3/3] i2c: designware: Add ti,tda54-i2c support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260925-tda54-upstream-i2c-v2-3-261785e58493@ti.com>
References: <20260925-tda54-upstream-i2c-v2-0-261785e58493@ti.com>
In-Reply-To: <20260925-tda54-upstream-i2c-v2-0-261785e58493@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A802:EE_|DM4PR10MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d8f649-d15a-4555-caae-08df1a955896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|7416014|921020|10067099003|56012099006|22082099003|18002099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: hWcdf1CaHl5ub+dKk5XYbjEBCpYEaSyQxoCNWjf+EQv0Xm0LAWbqtlitchgPzjn0yQK6B0KuGEIfX+NvIJVFvUjfuoWdRTUSvPxpwklV4IVPfkvtxnozigbYg0PKAbo/MslKumOSQG7WkBFfZ9pS/LaM/d6rlJ9gWWtyP9aH/4vhKhiLXmSLAA72TJxJbBSM8enlm23nLhQDo9k2nmeWTqIaPcHBBpZKx22ux7dP+YpIVagiGrnh30EUGioS6fTWc2FD/hM1TZYl0AHWLativ+T7B6fJaWoNKz4TF3PhypQwEe4NIY8RZ51/AFtp54zWnVla8vWchwaLJcXwF9sX3FtMIE9YpkQG4/yadYy4dHcvvKRDNg0aH58DYM0MUhHCFipA05I/MO+9ejJPoZ8eMj1EDzECqipMt1PCHA+f2DD9ls8EzmjOQ/8kK2o6juuJiOJP01qZGskVTyYpm8ieiyyoEMu8wrlzMw/OAcy715gOP9RbLLqHalTdailFL3SUVp0q2/A/K0+vBHuo+QMC9IT6DLit8VWE6SpZ6/1sG50lvQG0ILZhjA7bBs1AqbVrJueGvxIjsSQIjPvF9d/2kUpY1azDbgbuVGofRoe3WpLJmWug8N2y5V/ATbeFAXTUdeogQKxwETYPjtqZJEgn6NVHek19mdDS5aY/zH/2MNJd35Bl3cW+qV149D+XJqoS
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(7416014)(921020)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QOZnnn83RYUPk8ItYe1jr09c3AgoQ188/NHoJiJYy9YJt3JZ9WYkrkPRbKZKjOa2PgCMXSj6qm5ljtb6MVotY9reztYda4/viTE+c1YD01gCbWpmBLRXrbejGEMwQzxIMqkme9pwiA3k0/r8am3IUT4S1hm5UwuGbtfj/Lo81cunwVVqumSNkWcG3+teNB41CI1uVYe6C4guSERF1PhTR187w19k+5O4x1ciPjfIY4m0iUyrAQ8GZN897WkmjiUUNlBJYlL/v7iVcOxgJLGwWEs5QwPM87HDa265t3SMf+JL7hofvSN/5Vmrrxos/WKOu/nmvsnjqeFfy8HhGQ5d0YBPG/0Res8nEx5vLcnVAx5urCrXyRx7lGv2juBcMFoUjbHmoFey/LZDSOrNj7z+VZkqkb0o16raht6IGmd72gcq4sdWLf+h3t1a6wvXCtx2
X-Exchange-RoutingPolicyChecked: VTSQ85O+ZvuzbZWDtIZGtB6q2It1JH5Rz5A6Af8OWV4FnLDVzOCozK0n8Z4f++rUcCmxCDXURJSUyka9HXe+GKJsN87OuOZcKdGrxDCXDNpxZIDIJIh6cZDSPO2JAT09ajjQZyzlAbCAIpTW+K+f6QTtHTiKZts6XeZgXv/tM9Oxypb3cYtxpM2uBXvmWwcTlKtuRX622nwYRsxwz5gJJd47YPefWusQMwllhBLSFtrqMuDz9EXAMRhkI76eF/M2JacPbv63DzpNPNb0iX+vfsWiLnCmtNKGJ5q+rdY9Yhk+m6bzyE3Z8bcwP+F6oUeYhH4mEQ2Hc+EbDzLI+/+xHA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 23:41:24.7401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d8f649-d15a-4555-caae-08df1a955896
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A802.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6014
X-Proofpoint-GUID: l8_EzvKb_9F3STbirK2Iz_Bnu6Zfk88K
X-Authority-Analysis: v=2.4 cv=EvdHPicA c=1 sm=1 tr=0 ts=6ab5b529 cx=c_pps
 a=A3soYu1h9hn2xD7k0nk5XA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=SFMlj2LtjsmYIoXMqcoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA5NiBTYWx0ZWRfX8wCu8nyS46JL
 biILaeRhuY7hbxbmI+qEU61Fr6mR9FYN3x6SRwLJPOi1WQ/k96TMQQhhEbPhqCUl8SUJrwWf7Kh
 UkFVvzG+Bl2VMfAjsgGPEhREOGlx5tw/54cDS/L0oWfxM9RsMLMOltMuGVmwarSPVR+o1gfPZX5
 lS6Cc6Pi+fO99JaOA8z/wD6/cJIRAhkHPgYUC+csYdf8G7U6bptcvIehb/06p6eCyE0g4tXvigu
 j0ZhK7SM9kN6cgUPKC4MoYMpLBdMHmpQ9NgPMQdfA5qgodhjB6LbMfBDy77MgT3nJfQoOhO2hbb
 0f+nf0qiEHVa8T57Iqo/JfWdwQwcXsuoKMY2dVZDZQD74Gi8IG33vIfJQ7tk7kPYYWUPmB702po
 DxhMEG/M71tzVx5XD+7WA++2WqFH1N9j/maHfjDMJLijNGgD3IkXRHzgyP0BpdcCDXoFcFCA+/f
 DRCLTFie322tMuZMjsw==
X-Proofpoint-ORIG-GUID: l8_EzvKb_9F3STbirK2Iz_Bnu6Zfk88K
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA5NiBTYWx0ZWRfXwaQV9Lx7s9Us
 diANKwXyuMy9gJrwjkuWmpnMA+rv6FqYZ9weJWo0TYRKP6FPo6uK1g0/jtC5a2xeNwbeQXyqfIL
 neOHiAfzdYQLI/BG+RRXsRxqFUOmuuM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240096
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

Compared to the existing DW_apb_i2c layout [1], DWC_i2c present in TDA54
SoC [0] differs enough to need MODEL_TI_TDA54-gated special-casing in a
few places:

- Add new register offsets table for TI TDA54 SoC.
- The DW_IC_CON register bitfields are also updated.
- Interrupts are acknowledged by writing a bitmask to a single CLR_INTR
  register instead of reading N dedicated CLR_* registers;
  i2c_dw_ack_intr() picks the right method based on dev->flags.
- One HCNT/LCNT register pair is shared between standard and fast speed
  instead of having one pair each; i2c_dw_write_timings() writes
  whichever value set matches the configured speed.
- No COMP_PARAM_1 register, so FIFO depth and high-speed-mode support
  can't be autodetected: FIFO depth now comes from the required
  snps,tx-fifo-depth/snps,rx-fifo-depth DT properties, and the
  high-speed capability check is skipped.
- No defined CON.RESTART_EN bit; treated as always set.
- TDA54 SoC does not have SMBus block, skip accesses to those registers.

[0]: DWC_i2c_reference.pdf
[1]: DW_apb_i2c_databook.pdf

Signed-off-by: Aniket Limaye <a-limaye@ti.com>

---

Changes in v2:
- Rename compatible/flag: snps,dwc-i2c -> ti,tda54-i2c,
  MODEL_DWC_I2C -> MODEL_TI_TDA54.
- Remove i2c_dwc_has_smbus(); just skip the SMBUS_INTR_MASK write under
  MODEL_TI_TDA54.
- Link to v1: https://lore.kernel.org/r/20260919-tda54-upstream-i2c-v1-3-b0b9f77be18b@ti.com/
---
 drivers/i2c/busses/i2c-designware-common.c  | 128 +++++++++++++++++++++++++---
 drivers/i2c/busses/i2c-designware-core.h    |  22 ++++-
 drivers/i2c/busses/i2c-designware-master.c  |  26 +++---
 drivers/i2c/busses/i2c-designware-platdrv.c |   1 +
 4 files changed, 153 insertions(+), 24 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index eeeb1f189205..a0a54d4445df 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -72,6 +72,40 @@ static const char *const abort_sources[] = {
 		"incorrect slave-transmitter mode configuration",
 };
 
+/* "ti,tda54-i2c" block-based register layout */
+#define DWC_ADV_OPERATION_BLK_OFFSET		0x00
+#define DWC_ADV_I2C_BLK_OFFSET			0x28
+#define DWC_ADV_FIFO_INTR_BLK_OFFSET		0xbc
+#define DWC_ADV_DEBUG_BLK_OFFSET		0xf8
+
+static const u32 tda54_i2c_reg_offsets[DW_IC_REG_MAX] = {
+	[DW_IC_ENABLE]			= DWC_ADV_OPERATION_BLK_OFFSET + 0x04,
+	[DW_IC_CON]			= DWC_ADV_I2C_BLK_OFFSET + 0x04,
+	[DW_IC_TAR]			= DWC_ADV_I2C_BLK_OFFSET + 0x08,
+	[DW_IC_SAR]			= DWC_ADV_I2C_BLK_OFFSET + 0x0c,
+	[DW_IC_DATA_CMD]		= DWC_ADV_I2C_BLK_OFFSET + 0x58,
+	[DW_IC_SS_SCL_HCNT]		= DWC_ADV_I2C_BLK_OFFSET + 0x24, /* shared SS/FS pair */
+	[DW_IC_SS_SCL_LCNT]		= DWC_ADV_I2C_BLK_OFFSET + 0x28,
+	[DW_IC_FS_SCL_HCNT]		= DWC_ADV_I2C_BLK_OFFSET + 0x24,
+	[DW_IC_FS_SCL_LCNT]		= DWC_ADV_I2C_BLK_OFFSET + 0x28,
+	[DW_IC_HS_SCL_HCNT]		= DWC_ADV_I2C_BLK_OFFSET + 0x2c,
+	[DW_IC_HS_SCL_LCNT]		= DWC_ADV_I2C_BLK_OFFSET + 0x30,
+	[DW_IC_SDA_HOLD]		= DWC_ADV_I2C_BLK_OFFSET + 0x34,
+	[DW_IC_RX_TL]			= DWC_ADV_I2C_BLK_OFFSET + 0x5c,
+	[DW_IC_TX_TL]			= DWC_ADV_I2C_BLK_OFFSET + 0x60,
+	[DW_IC_INTR_STAT]		= DWC_ADV_FIFO_INTR_BLK_OFFSET + 0x04,
+	[DW_IC_INTR_MASK]		= DWC_ADV_FIFO_INTR_BLK_OFFSET + 0x08,
+	[DW_IC_RAW_INTR_STAT]		= DWC_ADV_FIFO_INTR_BLK_OFFSET + 0x0c,
+	[DW_IC_CLR_INTR]		= DWC_ADV_FIFO_INTR_BLK_OFFSET + 0x10,
+	[DW_IC_STATUS]			= DWC_ADV_FIFO_INTR_BLK_OFFSET + 0x1c,
+	[DW_IC_TXFLR]			= DWC_ADV_FIFO_INTR_BLK_OFFSET + 0x20,
+	[DW_IC_RXFLR]			= DWC_ADV_FIFO_INTR_BLK_OFFSET + 0x24,
+	[DW_IC_TX_ABRT_SOURCE]		= DWC_ADV_FIFO_INTR_BLK_OFFSET + 0x18,
+	[DW_IC_ENABLE_STATUS]		= DWC_ADV_FIFO_INTR_BLK_OFFSET + 0x14,
+	[DW_IC_COMP_VERSION]		= DWC_ADV_DEBUG_BLK_OFFSET + 0x08,
+	[DW_IC_COMP_TYPE]		= DWC_ADV_DEBUG_BLK_OFFSET + 0x0c,
+};
+
 static const struct dw_i2c_con_bits dw_i2c_con_bits = {
 	.master			= DW_IC_CON_MASTER,
 	.speed_std		= DW_IC_CON_SPEED_STD,
@@ -88,6 +122,26 @@ static const struct dw_i2c_con_bits dw_i2c_con_bits = {
 	.bus_clear_ctrl		= DW_IC_CON_BUS_CLEAR_CTRL,
 };
 
+/*
+ * DWC_IC_CTRL bit layout for "ti,tda54-i2c".
+ * There is no defined bit for RESTART_EN or SLAVE_DISABLE on this IP.
+ */
+static const struct dw_i2c_con_bits dwc_adv_i2c_con_bits = {
+	.master			= BIT(0),
+	.speed_std		= (1 << 4),
+	.speed_fast		= (2 << 4),
+	.speed_high		= (3 << 4),
+	.speed_mask		= GENMASK(5, 4),
+	.bit10_slave		= BIT(8),
+	.bit10_master		= BIT(9),
+	.restart_en		= 0,
+	.slave_disable		= 0,
+	.stop_det_ifaddressed	= BIT(10),
+	.tx_empty_ctrl		= BIT(11),
+	.rx_fifo_full_hld_ctrl	= BIT(12),
+	.bus_clear_ctrl		= 0,
+};
+
 /* "snps,designware-i2c": dedicated read-to-clear register ID per logical interrupt */
 static const u32 dw_i2c_intr_clr[DW_INTR_IDX_MAX] = {
 	[DW_INTR_IDX_INTR]      = DW_IC_CLR_INTR,
@@ -103,6 +157,21 @@ static const u32 dw_i2c_intr_clr[DW_INTR_IDX_MAX] = {
 	[DW_INTR_IDX_GEN_CALL]  = DW_IC_CLR_GEN_CALL,
 };
 
+/* "ti,tda54-i2c" CLR_INTR bit to write per logical interrupt */
+static const u32 dwc_adv_i2c_intr_clr[DW_INTR_IDX_MAX] = {
+	[DW_INTR_IDX_INTR]      = DWC_ADV_IC_INTR_CLR_INTR,
+	[DW_INTR_IDX_RX_UNDER]  = DWC_ADV_IC_INTR_CLR_RX_UNDER,
+	[DW_INTR_IDX_RX_OVER]   = DWC_ADV_IC_INTR_CLR_RX_OVER,
+	[DW_INTR_IDX_TX_OVER]   = DWC_ADV_IC_INTR_CLR_TX_OVER,
+	[DW_INTR_IDX_RD_REQ]    = DWC_ADV_IC_INTR_CLR_RD_REQ,
+	[DW_INTR_IDX_TX_ABRT]   = DWC_ADV_IC_INTR_CLR_TX_ABRT,
+	[DW_INTR_IDX_RX_DONE]   = DWC_ADV_IC_INTR_CLR_RX_DONE,
+	[DW_INTR_IDX_ACTIVITY]  = DWC_ADV_IC_INTR_CLR_ACTIVITY,
+	[DW_INTR_IDX_STOP_DET]  = DWC_ADV_IC_INTR_CLR_STOP_DET,
+	[DW_INTR_IDX_START_DET] = DWC_ADV_IC_INTR_CLR_START_DET,
+	[DW_INTR_IDX_GEN_CALL]  = DWC_ADV_IC_INTR_CLR_GEN_CALL,
+};
+
 /**
  * i2c_dw_select_variant() - Pick the register offset table, CON-register bit
  * layout and interrupt-ack mapping matching this device's IP variant
@@ -110,9 +179,15 @@ static const u32 dw_i2c_intr_clr[DW_INTR_IDX_MAX] = {
  */
 void i2c_dw_select_variant(struct dw_i2c_dev *dev)
 {
-	dev->regs = dw_i2c_reg_offsets;
-	dev->con_bits = &dw_i2c_con_bits;
-	dev->intr_clr = dw_i2c_intr_clr;
+	if (dev->flags & MODEL_TI_TDA54) {
+		dev->regs = tda54_i2c_reg_offsets;
+		dev->con_bits = &dwc_adv_i2c_con_bits;
+		dev->intr_clr = dwc_adv_i2c_intr_clr;
+	} else {
+		dev->regs = dw_i2c_reg_offsets;
+		dev->con_bits = &dw_i2c_con_bits;
+		dev->intr_clr = dw_i2c_intr_clr;
+	}
 }
 EXPORT_SYMBOL_GPL(i2c_dw_select_variant);
 
@@ -429,13 +504,27 @@ static void i2c_dw_configure_mode(struct dw_i2c_dev *dev, int mode)
 
 static void i2c_dw_write_timings(struct dw_i2c_dev *dev)
 {
-	/* Write standard speed timing parameters */
-	regmap_write(dev->map, DW_IC_SS_SCL_HCNT, dev->ss_hcnt);
-	regmap_write(dev->map, DW_IC_SS_SCL_LCNT, dev->ss_lcnt);
-
-	/* Write fast mode/fast mode plus timing parameters */
-	regmap_write(dev->map, DW_IC_FS_SCL_HCNT, dev->fs_hcnt);
-	regmap_write(dev->map, DW_IC_FS_SCL_LCNT, dev->fs_lcnt);
+	if (dev->flags & MODEL_TI_TDA54) {
+		/*
+		 * Only one HCNT/LCNT register pair backs both speeds on
+		 * this IP -- write whichever value set matches master_cfg.
+		 */
+		if ((dev->master_cfg & dev->con_bits->speed_mask) == dev->con_bits->speed_std) {
+			regmap_write(dev->map, DW_IC_SS_SCL_HCNT, dev->ss_hcnt);
+			regmap_write(dev->map, DW_IC_SS_SCL_LCNT, dev->ss_lcnt);
+		} else {
+			regmap_write(dev->map, DW_IC_FS_SCL_HCNT, dev->fs_hcnt);
+			regmap_write(dev->map, DW_IC_FS_SCL_LCNT, dev->fs_lcnt);
+		}
+	} else {
+		/* Write standard speed timing parameters */
+		regmap_write(dev->map, DW_IC_SS_SCL_HCNT, dev->ss_hcnt);
+		regmap_write(dev->map, DW_IC_SS_SCL_LCNT, dev->ss_lcnt);
+
+		/* Write fast mode/fast mode plus timing parameters */
+		regmap_write(dev->map, DW_IC_FS_SCL_HCNT, dev->fs_hcnt);
+		regmap_write(dev->map, DW_IC_FS_SCL_LCNT, dev->fs_lcnt);
+	}
 
 	/* Write high speed timing parameters */
 	regmap_write(dev->map, DW_IC_HS_SCL_HCNT, dev->hs_hcnt);
@@ -490,8 +579,10 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
 	 * Mask SMBus interrupts to block storms from broken
 	 * firmware that leaves IC_SMBUS=1; the handler never
 	 * services them.
+	 * TDA54 SoC has no SMBus block, so skip it.
 	 */
-	regmap_write(dev->map, DW_IC_SMBUS_INTR_MASK, 0);
+	if (!(dev->flags & MODEL_TI_TDA54))
+		regmap_write(dev->map, DW_IC_SMBUS_INTR_MASK, 0);
 
 	i2c_dw_write_timings(dev);
 
@@ -535,6 +626,14 @@ int i2c_dw_fw_parse_and_configure(struct dw_i2c_dev *dev)
 	if (device_property_read_u32(device, "snps,bus-capacitance-pf", &dev->bus_capacitance_pF))
 		dev->bus_capacitance_pF = DW_IC_DEFAULT_BUS_CAPACITANCE_pF;
 
+	if (dev->flags & MODEL_TI_TDA54) {
+		device_property_read_u32(device, "snps,tx-fifo-depth", &dev->tx_fifo_depth);
+		device_property_read_u32(device, "snps,rx-fifo-depth", &dev->rx_fifo_depth);
+
+		if (!dev->tx_fifo_depth || !dev->rx_fifo_depth)
+			return -EINVAL;
+	}
+
 	dev->clk_freq_optimized = device_property_read_bool(device, "snps,clk-freq-optimized");
 
 	/* Mobileye controllers do not hold the clock on empty FIFO */
@@ -851,6 +950,13 @@ static int i2c_dw_set_fifo_size(struct dw_i2c_dev *dev)
 		return 0;
 	}
 
+	/*
+	 * DW_IC_COMP_PARAM_1 not implemented on this IP;
+	 * fifo depth set in i2c_dw_fw_parse_and_configure().
+	 */
+	if (dev->flags & MODEL_TI_TDA54)
+		return 0;
+
 	/*
 	 * Try to detect the FIFO depth if not set by interface driver,
 	 * the depth could be from 2 to 256 from HW spec.
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 4c782594ab4e..bd96abf63c39 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -79,6 +79,18 @@ enum dw_i2c_intr_idx {
 	DW_INTR_IDX_MAX,
 };
 
+#define DWC_ADV_IC_INTR_CLR_INTR		BIT(0)
+#define DWC_ADV_IC_INTR_CLR_RX_UNDER		BIT(1)
+#define DWC_ADV_IC_INTR_CLR_RX_OVER		BIT(2)
+#define DWC_ADV_IC_INTR_CLR_TX_OVER		BIT(3)
+#define DWC_ADV_IC_INTR_CLR_RD_REQ		BIT(4)
+#define DWC_ADV_IC_INTR_CLR_TX_ABRT		BIT(5)
+#define DWC_ADV_IC_INTR_CLR_RX_DONE		BIT(6)
+#define DWC_ADV_IC_INTR_CLR_ACTIVITY		BIT(7)
+#define DWC_ADV_IC_INTR_CLR_STOP_DET		BIT(8)
+#define DWC_ADV_IC_INTR_CLR_START_DET		BIT(9)
+#define DWC_ADV_IC_INTR_CLR_GEN_CALL		BIT(10)
+
 #define DW_IC_INTR_DEFAULT_MASK			(DW_IC_INTR_RX_FULL | \
 						 DW_IC_INTR_TX_ABRT | \
 						 DW_IC_INTR_STOP_DET)
@@ -291,7 +303,8 @@ struct dw_i2c_dev {
 
 #define MODEL_AMD_NAVI_GPU			BIT(10)
 #define MODEL_WANGXUN_SP			BIT(11)
-#define MODEL_MASK				GENMASK(11, 8)
+#define MODEL_TI_TDA54				BIT(12)
+#define MODEL_MASK				GENMASK(12, 8)
 
 /*
  * Enable UCSI interrupt by writing 0xd at register
@@ -352,12 +365,15 @@ static inline void __i2c_dw_read_intr_mask(struct dw_i2c_dev *dev,
 		*intr_mask = dev->sw_mask;
 }
 
-/* Acknowledge a logical interrupt via dev->intr_clr[]: reg ID */
+/* Acknowledge a logical interrupt via dev->intr_clr[]: reg ID or bit value */
 static inline void i2c_dw_ack_intr(struct dw_i2c_dev *dev, enum dw_i2c_intr_idx intr)
 {
 	unsigned int dummy;
 
-	regmap_read(dev->map, dev->intr_clr[intr], &dummy);
+	if (dev->flags & MODEL_TI_TDA54)
+		regmap_write(dev->map, DW_IC_CLR_INTR, dev->intr_clr[intr]);
+	else
+		regmap_read(dev->map, dev->intr_clr[intr], &dummy);
 }
 
 void __i2c_dw_disable(struct dw_i2c_dev *dev);
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 329f958ded3e..94594f6349d4 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -42,14 +42,16 @@ static int i2c_dw_set_timings_master(struct dw_i2c_dev *dev)
 	u32 ic_clk;
 	int ret;
 
-	ret = i2c_dw_acquire_lock(dev);
-	if (ret)
-		return ret;
-
-	ret = regmap_read(dev->map, DW_IC_COMP_PARAM_1, &comp_param1);
-	i2c_dw_release_lock(dev);
-	if (ret)
-		return ret;
+	if (!(dev->flags & MODEL_TI_TDA54)) {
+		ret = i2c_dw_acquire_lock(dev);
+		if (ret)
+			return ret;
+
+		ret = regmap_read(dev->map, DW_IC_COMP_PARAM_1, &comp_param1);
+		i2c_dw_release_lock(dev);
+		if (ret)
+			return ret;
+	}
 
 	/* Set standard and fast speed dividers for high/low periods */
 	sda_falling_time = t->sda_fall_ns ?: 300; /* ns */
@@ -135,7 +137,8 @@ static int i2c_dw_set_timings_master(struct dw_i2c_dev *dev)
 	/* Check is high speed possible and fall back to fast mode if not */
 	if ((dev->master_cfg & dev->con_bits->speed_mask) ==
 		dev->con_bits->speed_high) {
-		if ((comp_param1 & DW_IC_COMP_PARAM_1_SPEED_MODE_MASK)
+		if (!(dev->flags & MODEL_TI_TDA54) &&
+		    (comp_param1 & DW_IC_COMP_PARAM_1_SPEED_MODE_MASK)
 			!= DW_IC_COMP_PARAM_1_SPEED_MODE_HIGH) {
 			dev_err(dev->dev, "High Speed not supported!\n");
 			t->bus_freq_hz = I2C_MAX_FAST_MODE_FREQ;
@@ -398,8 +401,11 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 			 * If both IC_EMPTYFIFO_HOLD_MASTER_EN and
 			 * IC_RESTART_EN are set, we must manually
 			 * set restart bit between messages.
+			 * ti,tda54-i2c does not define a CON.RESTART_EN
+			 * bit, and behaves like it is set to 1.
 			 */
-			if (dev->master_cfg & dev->con_bits->restart_en &&
+			if (((dev->master_cfg & dev->con_bits->restart_en) ||
+			     (dev->flags & MODEL_TI_TDA54)) &&
 			    dev->msg_write_idx > 0)
 				need_restart = true;
 		}
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 42b34c678146..069c3dc0da10 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -257,6 +257,7 @@ static const struct of_device_id dw_i2c_of_match[] = {
 	{ .compatible = "mobileye,eyeq6lplus-i2c" },
 	{ .compatible = "mscc,ocelot-i2c" },
 	{ .compatible = "snps,designware-i2c" },
+	{ .compatible = "ti,tda54-i2c", .data = (void *)MODEL_TI_TDA54 },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dw_i2c_of_match);

-- 
2.53.0

