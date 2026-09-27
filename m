Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C48C98338
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 18:27:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE1B910E680;
	Sun, 27 Sep 2026 18:27:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YlCGSjsZ";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ckkUO9r6";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FDD510E680
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 18:27:21 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68R5uQOh2807075; Sun, 27 Sep 2026 13:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=eCLwqblm3qJEm3zmoTtK6D6IQhmA4NXmhyTRzdDFH
 sE=; b=YlCGSjsZnARQJfhDRUSOzjcEUPL9C4wePGv6E9E8nyKNsSH1PVmIaqjkr
 zI/aBJ9DFnMAC/kwnK+tghoAaV0Re79kCD8QcfwHdsx9cuSxkRHmb6u/hqXXnr1c
 dCvGCmFM9ONX8EUEBHSUHIFCSgW1jMX4TsxLzR8vWCv5jgP0yUfzIM1yySmLktvG
 H+ZIBeblzZP+cfqkT29OH8ZwXvOyC0TBp5hsXZ6ZgILhN7/a5mSwvkn8rBiKgSIv
 REMKsOQzBcQ7871e2pzyJKQJ6VTDas+JZHEc2qkM09U6DfyEW6eeDmSvyAgIORnf
 aUzd5Zwxn/q2SARrYlPX6zKMh+RSQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gxwe5hxmg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 27 Sep 2026 13:27:16 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVi/Z/x+cd1AmCupdC2qjkunQhSVpzBC0Y7Plozm3cDOmZiotPj992dCTnOc/eLm5AFKdUA8Ljm3yAo6BHgRtDthIOWVloXvHtup3CulvK2yPJqjke2ESn1T2c+ZOEDXhWbtGOuUlJlXfS2HpmGceNhLlh15yGgIamDGpx4i9vkxsKlcGhnzNsKcr0vjTv7yliq5l3ACqjZco2uEwdkarg0yn4Ql02mX9k9WGMOYMIL/5UtqEGUcqf7C2nVg+qYPap8XaB62YrE4mvl14nl3a5mwY4WgzRotLTuFOSoCKPa1mJycYbq7JN9oGJKcS8DT16mg7op/0lwV9DV519DaUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCLwqblm3qJEm3zmoTtK6D6IQhmA4NXmhyTRzdDFHsE=;
 b=U8bMxeBS7/yg5HfJ6/brAw30t/WEbVgPAgtI3Ry1+Ddkldf9CWx/6uNl+OkhJ0Vz3t0uRlzFV4Z0ZenD2AZlCL6uGVCkZxTpUe6+Upj7+3XSK95CKddtOPNQ3HB+XTLCbJVIBLMb0qw1Ma9bTzEFLYABkBvyIa7xfxeA1LYvGcTIjiYDIkyq0forSEhl9nwGByDE6iL+KlO8zbsRkUM7ajWv1+gOJZbjeTTico4kZP0yQQOQdOnnykKojYbVEurwxN3hJbTVoHbyPlR9nNQtDh83bRXQcRiLNw7tLFqWUqzb2SmEI9NSA+QtT20VQVybVQV04hjiH5SIvEWsGrDNdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCLwqblm3qJEm3zmoTtK6D6IQhmA4NXmhyTRzdDFHsE=;
 b=ckkUO9r6h/nQIpqOLQXqYjGZhM3rCeOUXZ3WtIfR2UxacQZXjnXqBMJrvpp60wyoTIYgS45TZDvrBJs+LStRtallp9lUcMy9MgwSYlpqxUTnNJUtPa+HTjkrXbPLL2Zlpo5TwKzCEqKx3wYdtEzYDQc6dkXz3DemgkEr0WwukgA=
Received: from BLAPR03CA0151.namprd03.prod.outlook.com (2603:10b6:208:32f::15)
 by DS4PR10MB075839.namprd10.prod.outlook.com (2603:10b6:8:3ec::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Sun, 27 Sep
 2026 18:25:42 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::64) by BLAPR03CA0151.outlook.office365.com
 (2603:10b6:208:32f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Sun,
 27 Sep 2026 18:25:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 27 Sep 2026 18:25:41 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:25:08 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:25:08 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sun, 27 Sep 2026 13:25:08 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68RIP7Ec1629334;
 Sun, 27 Sep 2026 13:25:07 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Devarsh Thakkar <devarsht@ti.com>
Subject: [PATCH v2 05/14] drm/solomon: ssd16xx: Add
 clear_on_init/close/disable session management
Date: Sun, 27 Sep 2026 23:53:20 +0530
Message-ID: <20260927182329.4193961-6-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260927182329.4193961-1-devarsht@ti.com>
References: <20260927182329.4193961-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|DS4PR10MB075839:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b8e5859-f887-4d9b-d285-08df1cc4bca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|36860700016|82310400026|1800799024|921020|56012099006|10067099003|5023799004|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: aKYFUU40vQzj+IXDMBGy2/UXctFdqDksItBLMnxiSroZrh9glvlMsQEdZtO9405qcSv0b5mFOZdw8vlL66QCLTwOwydyDbfXh0QXpJmDaagMdlj4PibfleW5HYbW5ApS33ZShGTij4oIP6reJm6MHRFGzt5KWrvYiF7JOIiwFo7qosb+1/Ndgm5ZPKnbBj94lgJ6zwKIslrh4+1ebsAYRpxk0hx+eNF0XKPsuyB4V5OpQJ7b1N5fBT5LB2Dws4mNlWjLaYhSYoTuqO0+y6Wq11JyeCGpouJ87zQOtpjtUSd8ZeHuc0pCXj5ceSTOclt1I+oolz1KXoNURtACwHygX1/S2f0qOXfBUmUYvZRLjdUzeP9m6a8lQgPTYa2Kl4LwOWT70CRVOZa4dhIa8+ImuTzBhcxOFEmA+EdDx/R6E7wdHuVRxKzZhpN7eKb42q6i8qRl/KhIa9dyza/nj7nqT6nWm8Jcg297FiMNkedClB1Xh80yvhiDQ1z6Yu90YJow4z6m2owFQZAvSOneVlZnSWkDY+pDlGvQQkAJI/uLTb4+8ekxY/SdxPtaoYl0Mewg5lIBsQLYSOehCDBMa8Nah93mg3SrMj+pPs76qye+TNz29yogxauj6zl20WiZEYxkGgy8bDC16WW1E3Q+GCHp5WGRJeAaHWrUyL0Aq8EMd+uUv8b3o2w0dHI3OQcScvSWSne322CaIYMx1k7IYv68dA8sRfFgxwBOgCCOF8QAw6U7EZaGuLpV1jLHAsxZsEfm
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(82310400026)(1800799024)(921020)(56012099006)(10067099003)(5023799004)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V182J88FqIGxZB1LLUgfxHLSLxmhL1V8CiYPqQyjQNGvnh0+d5rz4JRsmxvXQAaBHiUv2ToEpYjoqwFkUIbISBoFY67IwqYWYfLTgz9IfnKN1SlpU9xJ56w+OuULM/LGqLPsCuO1qfUqZ+DAr+PSNJFJRX9wUqOdqZjuovgr9qae2ynODuKRrLHxnxtVqe3J6SDyDXeWXQ6EZq8d7QA00EZCOgHg5sn6IZbrYi6WXxLDHf2YBL/A88eszlgiUr3qA8vDPf0v6Fd1MEOzZ32u48uRSQLkqYaaJeKvLKjCi3R/nUdgXy0N0ZDhJI4ZvThiHw4cTMoSqJpG76uDGHfoWgh/ZlnA10umRcODC6r7UClM/aIpMgQefU2f9dJBgoechbVchFFS9sO+k6BqKI8Flrb3Ymbmg62Vi+gr1X3Ejpe0ZSxhD8TXZ3AIGGgGiCsU
X-Exchange-RoutingPolicyChecked: vPOyNRIOHvKpxDovtnx6VDb9bgHZFKQ93zFg51iOlnuh1N3ZDLjow7AR7TpURbsy9xl3d0UTC5i8Czm2uThrQMM7R+vi4B/rRl+YBw01+lOH61CtM9z2vJfHItQvWWK9n6Nyy7sNnRP450IM1088lypaaJP4nJLldL5L3dXcQaPOIv3Xxc/7Gf1+8bWhIfvIZU1ibkjhUfhr5INSPSDbo/Yk+fRmZZcMi7f0NUHKkrnlvx39+Bbbur/PbMl2Rmm0IADf9XwJ9E4LayyDSK093h/7bIrAqMUgZ6e/erNTU2mJDloC8UWwV3p8HeyKhq7zz+h8jMxka7OMh6NBFv0/Pg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 18:25:41.3075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8e5859-f887-4d9b-d285-08df1cc4bca8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB075839
X-Authority-Analysis: v=2.4 cv=aeP0Dhot c=1 sm=1 tr=0 ts=6ab96005 cx=c_pps
 a=jDwMdcx0fGNsu9pFyB9b3w==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=H0YTK7WFwsOzv62ymnsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfX6s5DBySoHuJb
 hxg7U5hcdIyX1dRv2e13OE+DWfcVz0WE+TBbmW1kUN3JQTQ/XjvajsAVgRN9XAwoY1PbooN8MhC
 lMq/4lQFPRDDYjZI/Q6gzMMJNThTsZv3ew5PfPIjITHThCBGoNp9U6ZR4tLozlqGtQp/7m+W0Hr
 G9WYA81lt8EbXnrn8y2EhfkAoEbMDksdITURGKPiRxyDS6eNHPeV5r7uD8zU/TJ/CwbSbQYEV6f
 OsaiggTZAczVtAMEm0eYUduwcfVkW5JgCBWpHmUc3zWHShDq/f7klwodiWhNz7jad5/jtxivGy3
 xeaGfzxqM4unOxHF289bUgrqcwlV4tvQJKdmrEvfAnB05RggK2R0N1yBJO+GOSHzqsufbqdire5
 5Hyl7ckRKgD5ac6u0gNHoo6UmJaTjLs7TlwhBEtFUpgDf9E7Yz7Y5v3g7wNN1GImxUdQ+b44m4t
 fhcav7oY0krVcuZAdlA==
X-Proofpoint-ORIG-GUID: tFuvtuUBKB-LgL5DQqmVk6cm1HvIKSJd
X-Proofpoint-GUID: tFuvtuUBKB-LgL5DQqmVk6cm1HvIKSJd
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfX9j2LMPS7gxxV
 9j4SQ41ZXT8MAj+tlwXBdzDByhG7wMEoLDeMemF+zBZjUnjcIvFlFfpOFHE7YdUl39wyItiLiyJ
 4b9AjyWNkgs/tbK8v7ZQ73u2vPWCKas=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
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

E-paper displays are bistable: the last rendered image persists
indefinitely across sessions and power cycles. This creates a session
management choice with no LCD/OLED equivalent since unlike volatile
displays, content visibility outlives the rendering process. Whether this
persistence is a feature or a liability depends entirely on the
application.

Add session-lifetime display clearing with three configurable hooks:
clear_on_init: blank the display when a new DRM master opens the device.
Useful for kiosks and applications that need a clean slate on startup.
Example: a hospital patient room sign must start with a clean slate when a
new patient is admitted, discarding the previous patient's name, dietary
restrictions, and risk warnings.

  clear_on_close: blank the display when the DRM master exits (fd close).
Useful for applications that should not leave content visible after exit.
Example: a transit departure board at a remote bus stop must erase stale
schedule data when the service daemon is stopped — displaying yesterday's
departure times actively misleads commuters.

  clear_on_disable: blank the display on CRTC disable / DPMS off.  Provides
an independent clear point separate from master lifecycle.  Example: When
userspace trigger DPMS off, similar to LCD screen, here with the epaper
too, the display would be cleared.

These hooks help enabling diverse use cases:

  - A conference badge sets clear_on_init but leaves clear_on_close
    disabled, leveraging e-paper's bistability to keep the attendee's name
visible indefinitely after the rendering app exits — saving power while
remaining useful.

  - A hospital patient room sign sets both clear_on_init and
    clear_on_close: a clean slate for the new patient and automatic erasure
on discharge so protected health information does not persist on the
display outside the door.

  - An airport boarding pass kiosk sets clear_on_close so the previous
    passenger's name, booking reference, and seat assignment are erased the
moment the session ends — preventing the next person in the queue from
seeing personal travel information.

  - A meeting room booking display sets clear_on_disable so the schedule is
    wiped when the room session ends via DPMS off, independent of whether
the calendar sync daemon continues running.

Each is an integer selecting the refresh waveform for the clear (-1 =
disabled, 0 = partial, 1 = full, 2 = fast), defaulting to -1 (disabled) in
the panel configuration so the behaviour is opt-in.  A
display_cleared_on_deinit guard prevents redundant double-clears when
multiple paths fire for the same session (e.g. compositor does DPMS off
then exits). first_clear_done ensures clear_on_init fires exactly once per
client session; master_drop resets it so the next client gets a fresh
clear.

All three default to -1 (disabled) in the panel configuration so the
behaviour is opt-in per panel and does not affect panels that have not set
an explicit default.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
Changes from v1:
  - New patch: Separated session management feature (clear_on_init, etc.)
    into dedicated patch for better reviewability

 drivers/gpu/drm/solomon/ssd16xx.c | 168 +++++++++++++++++++++++++++++-
 1 file changed, 167 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/ssd16xx.c
index d3af055c6739..c478309d08e9 100644
--- a/drivers/gpu/drm/solomon/ssd16xx.c
+++ b/drivers/gpu/drm/solomon/ssd16xx.c
@@ -298,6 +298,18 @@ struct ssd16xx_device_config {
 	/* Whether to re-send border waveform command before each display update */
 	bool default_border_refresh_on_every_update;
 
+	/*
+	 * Default clear-on-init behaviour.
+	 * -1=disabled, 0=partial, 1=full, 2=fast (matches enum ssd16xx_refresh_mode)
+	 */
+	int default_clear_on_init;
+
+	/* Default clear-on-close behaviour (-1=disabled, 0=partial, 1=full, 2=fast) */
+	int default_clear_on_close;
+
+	/* Default clear-on-disable behaviour (-1=disabled, 0=partial, 1=full, 2=fast) */
+	int default_clear_on_disable;
+
 	/*
 	 * Default refresh-mode-init: -1=disabled, else skip baseline establishment
 	 * and start directly in this refresh mode.
@@ -347,6 +359,8 @@ struct ssd16xx_device {
 
 	bool initialized;
 	bool init_refresh_pending; /* First frame after refresh_mode_init enable */
+	bool first_clear_done;  /* clear_on_init has already fired once */
+	bool display_cleared_on_deinit; /* Avoid redundant clear in atomic_disable/master_drop */
 
 	int orientation; /* Display orientation in degrees: 0/90/180/270 */
 	enum ssd16xx_refresh_mode refresh_mode; /* Active refresh mode */
@@ -360,6 +374,9 @@ struct ssd16xx_device {
 	bool border_waveform_pending;   /* One-shot: send border cmd on next update */
 
 	/* Display control */
+	int clear_on_init;    /* -1=disabled, 0=partial, 1=full, 2=fast */
+	int clear_on_close;   /* -1=disabled, 0=partial, 1=full, 2=fast */
+	int clear_on_disable; /* -1=disabled, 0=partial, 1=full, 2=fast */
 	int refresh_mode_init; /* -1=disabled, else use this mode for the first frame */
 
 	u8  *tx_buf;     /* 1bpp frame buffer (mono + white) */
@@ -418,6 +435,9 @@ static const struct ssd16xx_device_config ssd16xx_device_configs[] = {
 		.default_border_waveform_init   = SSD16XX_BORDER_LUT1,
 		.default_border_waveform_update = SSD16XX_BORDER_VCOM,
 		.default_border_refresh_on_every_update = true,
+		.default_clear_on_init    = -1,
+		.default_clear_on_close   = -1,
+		.default_clear_on_disable = -1,
 		.default_refresh_mode_init = SSD16XX_REFRESH_FULL,
 		.red_supported = false,  /* 2-colour black/white panel */
 		.default_color_mode = SSD16XX_COLOR_MODE_BW,
@@ -746,6 +766,111 @@ static int ssd16xx_hw_init(struct ssd16xx_device *device)
 	return err;
 }
 
+/*
+ * Clear display by writing all-white to both BW and RED RAM.
+ * The ctrl2 argument selects the waveform (full/partial/fast refresh).
+ * Border waveform is set to init value before clearing, then restored
+ * to the update value to preserve the border during subsequent updates.
+ */
+static int ssd16xx_clear_display(struct ssd16xx_device *device, u8 ctrl2)
+{
+	const u8 *bw_tbl = device->controller_cfg->border_waveform_table;
+	int err = 0;
+	unsigned int data_size = (device->width * device->height) / 8;
+	u8 *white_buffer = device->tx_buf;
+
+	memset(white_buffer, 0xFF, data_size);
+
+	ssd16xx_send_cmd(device, SSD16XX_CMD_SET_RAM_X_ADDRESS_COUNTER, &err);
+	ssd16xx_send_x_param(device, 0x00, &err);
+
+	ssd16xx_send_cmd(device, SSD16XX_CMD_SET_RAM_Y_ADDRESS_COUNTER, &err);
+	ssd16xx_send_y_param(device, 0x00, &err);
+
+	ssd16xx_send_cmd(device, SSD16XX_CMD_WRITE_RAM_BW, &err);
+	ssd16xx_send_data_bulk(device, white_buffer, data_size, &err);
+
+	ssd16xx_send_cmd(device, SSD1683_CMD_WRITE_RAM_RED, &err);
+	ssd16xx_send_data_bulk(device, white_buffer, data_size, &err);
+
+	/* Set border waveform for the clear operation */
+	drm_dbg(&device->drm, "clear_display: Set border init waveform: 0x%02x\n",
+		bw_tbl[device->border_waveform_init_idx]);
+	ssd16xx_send_cmd(device, SSD16XX_CMD_BORDER_WAVEFORM_CONTROL, &err);
+	ssd16xx_send_data(device,
+			  bw_tbl[device->border_waveform_init_idx],
+			  &err);
+
+	/* 3-colour mode: CTRL1_NORMAL (read both RAMs); BW mode: bypass RED. */
+	ssd16xx_display_update(device,
+			       device->color_mode == SSD16XX_COLOR_MODE_3COLOR
+					? device->controller_cfg->ctrl1_normal
+					: device->controller_cfg->ctrl1_bypass_red_ram,
+			       SSD16XX_CTRL1_BYTE2_DEFAULT, ctrl2, &err);
+
+	/* Restore border waveform to update/preservation value */
+	drm_dbg(&device->drm, "clear_display: Restored border update waveform: 0x%02x\n",
+		bw_tbl[device->border_waveform_update_idx]);
+	ssd16xx_send_cmd(device, SSD16XX_CMD_BORDER_WAVEFORM_CONTROL, &err);
+	ssd16xx_send_data(device,
+			  bw_tbl[device->border_waveform_update_idx],
+			  &err);
+
+	return err;
+}
+
+static u8 ssd16xx_refresh_mode_to_ctrl2(struct ssd16xx_device *device,
+					enum ssd16xx_refresh_mode mode)
+{
+	if (mode < ARRAY_SIZE(device->controller_cfg->ctrl2_refresh))
+		return device->controller_cfg->ctrl2_refresh[mode];
+	return device->controller_cfg->ctrl2_refresh[SSD16XX_REFRESH_FULL];
+}
+
+/*
+ * Clear display on new DRM master open (if clear_on_init >= 0).
+ * Guarded by device->first_clear_done; master_drop resets it unconditionally
+ * so each new client session gets a fresh clear.
+ */
+static int ssd16xx_clear_display_on_init(struct ssd16xx_device *device)
+{
+	int ret;
+
+	if (device->clear_on_init < 0 || device->first_clear_done)
+		return 0;
+
+	drm_dbg(&device->drm, "clear_on_init: running, mode=%d\n",
+		device->clear_on_init);
+	ret = ssd16xx_clear_display(device,
+				    ssd16xx_refresh_mode_to_ctrl2(device, device->clear_on_init));
+	if (ret)
+		return ret;
+
+	device->first_clear_done = true;
+	return 0;
+}
+
+/*
+ * Clear display when the displaying client exits (if clear_on_close >= 0).
+ * Called from ssd16xx_drm_master_drop().
+ */
+static int ssd16xx_clear_display_on_exit(struct ssd16xx_device *device)
+{
+	int ret;
+
+	if (device->clear_on_close < 0)
+		return 0;
+
+	drm_dbg(&device->drm, "clear_on_close: running, mode=%d\n",
+		device->clear_on_close);
+	ret = ssd16xx_clear_display(device,
+				    ssd16xx_refresh_mode_to_ctrl2(device, device->clear_on_close));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 /*
  * ssd16xx_pixel_luma() - return ITU-R BT.601 luminance (0-255) for one pixel.
  *
@@ -1356,11 +1481,26 @@ static void ssd16xx_crtc_atomic_disable(struct drm_crtc *crtc,
 					struct drm_atomic_commit *state)
 {
 	struct ssd16xx_device *device = crtc_to_ssd16xx_device(crtc);
-	int idx;
+	int ret, idx;
 
 	if (!drm_dev_enter(&device->drm, &idx))
 		return;
 
+	if (device->clear_on_disable < 0 || device->display_cleared_on_deinit)
+		goto out;
+
+	drm_dbg(&device->drm, "clear_on_disable: running, mode=%d\n",
+		device->clear_on_disable);
+	ret = ssd16xx_clear_display(device,
+				    ssd16xx_refresh_mode_to_ctrl2(device,
+								  device->clear_on_disable));
+	if (ret) {
+		drm_err(&device->drm, "atomic_disable: clear failed: %d\n", ret);
+		goto out;
+	}
+
+	device->display_cleared_on_deinit = true;
+out:
 	drm_dev_exit(idx);
 }
 
@@ -1383,6 +1523,11 @@ static void ssd16xx_crtc_atomic_enable(struct drm_crtc *crtc,
 	}
 	device->initialized = true;
 
+	/* Clear display on first app launch if configured */
+	ret = ssd16xx_clear_display_on_init(device);
+	if (ret)
+		drm_err(&device->drm, "crtc_atomic_enable: clear on init failed: %d\n", ret);
+
 	/*
 	 * If refresh_mode_init is set, arm init_refresh_pending so
 	 * plane_atomic_update uses the specified mode for the first frame
@@ -1523,6 +1668,9 @@ static void ssd16xx_drm_master_set(struct drm_device *drm,
 {
 	struct ssd16xx_device *device = to_ssd16xx_device(drm);
 
+	device->display_cleared_on_deinit = false;
+	device->first_clear_done = false;
+
 	if (device->refresh_mode_init >= 0)
 		device->init_refresh_pending = true;
 }
@@ -1535,8 +1683,23 @@ static void ssd16xx_drm_master_drop(struct drm_device *drm,
 				    struct drm_file *file)
 {
 	struct ssd16xx_device *device = to_ssd16xx_device(drm);
+	int ret, idx;
 
 	device->init_refresh_pending = false;
+	device->first_clear_done = false;
+
+	if (device->clear_on_close < 0 || device->display_cleared_on_deinit)
+		return;
+
+	if (!drm_dev_enter(drm, &idx))
+		return;
+
+	ret = ssd16xx_clear_display_on_exit(device);
+	if (ret)
+		drm_err(drm, "master_drop: clear on close failed: %d\n", ret);
+
+	device->display_cleared_on_deinit = true;
+	drm_dev_exit(idx);
 }
 
 static struct drm_driver ssd16xx_drm_driver = {
@@ -1671,6 +1834,9 @@ static int ssd16xx_probe(struct spi_device *spi)
 	device->border_waveform_update_idx = device->device_cfg->default_border_waveform_update;
 	device->border_refresh_on_every_update =
 		device->device_cfg->default_border_refresh_on_every_update;
+	device->clear_on_init    = device->device_cfg->default_clear_on_init;
+	device->clear_on_close   = device->device_cfg->default_clear_on_close;
+	device->clear_on_disable = device->device_cfg->default_clear_on_disable;
 	device->refresh_mode_init = device->device_cfg->default_refresh_mode_init;
 
 	/* Parse "rotation" DT property; swap mode dimensions for portrait. */
-- 
2.39.1

