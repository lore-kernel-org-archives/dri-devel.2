Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A08E606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=i5NDv0j6;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=jb2KpqjK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDA4910E0DD;
	Thu, 26 Nov 2026 06:06:51 +0000 (UTC)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87BA910E1C0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:06:41 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AQ36H6J2540379;
 Thu, 26 Nov 2026 00:06:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=WvO3tNmXei+rw
 ywxsJkfhYYS/v9MyoQlI5lF9uvu+/o=; b=i5NDv0j6HSrlLnxweYfxco859oNYn
 ZcaJStCrq78xJUEggO05b6i4v4YHk2ahZp4Ql+IT1NdnetLJ7g2v/18WzgaFwnV0
 JlZDrhmifeuVgc9OuanmKxAau6Z8tXyYkF9DWtOudFDo3EGy+8bJOxysymwkq614
 MlP4GOfnOf03EZdbytQIcOZ0VjOiBuJrgzzNur6o9r74lezLTQpeUSMnScisp3C4
 rKB+CGOMqyhXyfBa3G2JGesSN/drlMyQwYbf9w9hKzmj6piEkTXJUhIUNmSLuCS0
 hlhwlwJ0QePMlx/sJMvGsUia5VvZ2GPzqnlKKUkBQWq347IGVs955Zu7Q==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010045.outbound.protection.outlook.com [52.101.61.45])
 by m0384305.ppops.net (PPS) with ESMTPS id 4j606fcxnx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 26 Nov 2026 00:06:13 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oo1He9Cv3cVeFwM/FQvCSJ0FpRrLjxNQ2YcMYgviBh7T0NIGsJ3MiLX7Q0v6nfQppJ5mUXnGel2+Ca39WytymleDGvjamK8THPa1hVwrWBlfpX4gf0uATgIil9awN9lPks5vn7PsjhBLgeVJeN5xC7x9lNj2mSuauWAd52xysTaCR/OYIac3aHsBbgqqR4HuVdSTHvssMkBtk/xHWK0VGc0u3Tqnza1beuwR5AuLCxwF+I6tWV0udRXWMyFCYTT/xqZ2XWiZ0UMS+thCBypEGJz28W8AEl/3/mSc03KTQio7SPzukYLiSgW/6k+Vu75Ne20GeI1inz8n4smZ+HtqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvO3tNmXei+rwywxsJkfhYYS/v9MyoQlI5lF9uvu+/o=;
 b=gzzxzkX9uc4OExl2GqE0oCSvgDNs9F+xf2b6RWLRsoesiVxAMidP7Jqvxj28LbD7e7beXlt7Fpl1mgW4zyR6uqbSgfTTztmPkZDRpokLt/i5fWrKaFscA/aXxHmv34i/2sVYax4Awa2XB4II8KjMNwP0m00lRKaggKJHScFDsA4Eds3UKCQZ1Ic73rLUBtRPQceCgJu0xT1XIyfk78EGxoItyAOQHGRF5bBQv7ZiTIbpGUy27JClG+Wy5xN5bIsKFqMuqaCPYnUA2EPjrkreqEwZYqMnWOW3ytmdaykr4UpLMOWXfMw4qZ0sm7aK74ak7l0AvOUMlKD29z7QOfXdDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvO3tNmXei+rwywxsJkfhYYS/v9MyoQlI5lF9uvu+/o=;
 b=jb2KpqjK9tWLqecnUqPwBgG15Chb77JFqgxLCanjccflQnqg9w5xVkp9VOq8T0kS1t/c67wTFRjV+YAezF3EfTARm4J8nrFQJUyBT628bfvRwuYwCOeY8SpxVk0VCd6wciVA6SJW8JEH06RTeq9acU3awsrEqrlzi1xwDXnHyn0=
Received: from CY5PR03CA0007.namprd03.prod.outlook.com (2603:10b6:930:b::39)
 by LV0PR10MB276679.namprd10.prod.outlook.com (2603:10b6:408:606::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 06:06:10 +0000
Received: from EA8PEPF0000000A.namprd05.prod.outlook.com
 (2603:10b6:930:b:cafe::32) by CY5PR03CA0007.outlook.office365.com
 (2603:10b6:930:b::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 06:06:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 EA8PEPF0000000A.mail.protection.outlook.com (10.167.249.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 06:06:07 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 26 Nov
 2026 00:05:51 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 26 Nov
 2026 00:05:50 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 26 Nov 2026 00:05:50 -0600
Received: from uda0543015.dhcp.ti.com (uda0543015.dhcp.ti.com [10.24.50.243])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 6AQ65jM31082743; Thu, 26 Nov 2026 00:05:45 -0600
From: Abhash Kumar Jha <a-kumar2@ti.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <devarsht@ti.com>, <u-kumar1@ti.com>,
 <sjakhade@cadence.com>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <s-jain1@ti.com>, <y-d@ti.com>,
 <tomi.valkeinen@ideasonboard.com>, <benjamin.robin@bootlin.com>
Subject: [PATCH v4] drm/bridge: cdns-mhdp8546: Add suspend resume support to
 the bridge driver
Date: Thu, 26 Nov 2026 11:35:32 +0530
Message-ID: <20261126060532.2379444-1-a-kumar2@ti.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF0000000A:EE_|LV0PR10MB276679:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d8a87f-e20a-406c-9804-08df4b835cd4
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|7416014|82310400026|376014|921020|10067099003|56012099006|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261028144727099003|261021123027099003|261021135927099003|261021121427099003|261102123227099003|261009223027099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: klgeWfWB4uIHdyLg+xgFnfGnWzZEb70ODVmObR091+60k++x+XehR4ftmA+85MLOAXIIUsumu9ZPOyDRe/mR5cQ9blsA7Xb5BJg+W56v/JlPjlEpX0XfartxNBBepC0NW2j1Gngp6RB14/ghcMrGux/2oYbtPywE7gc0MUzcim7HBb6dTUcl+g3NItNsFFbNUWRT6DqzN6jcFu9ZRI/ihDEF5gKQXqP0HRPu6YYnTqcDDceq3VofNaM1rpmllZwRS4lIsl2jM0hfyE6jHpY6RYpuUWmYKrARdgDGrbFc8offKkZq7Dw1pQ3l47J92lsj+k59wt/zI8em78O+9i9ds47NvgOiflkbVjlaD53Eryp8XE7AC1vxG+WggqVVYCezcNGnOupOwSgEuSQD0p+nAoNYtHFv9JSnaHvBdFmGClYipWFz5Q8b6mcdDFsfC/8zNTu6+LBEQWyeNkjR4GYkx9zmLuRwfyiA2dfMedxmRsreUnm7hhou552rw/hnp1d1dzdXnsR+7xzqGRK30r5pBRI6xwP+fNTcpFbCksVfhX3C0VZ+94B6oWFZUB8i+PRR784VumVQohfkYtb/2zJBQ8mX4K5jEAHOYjC2A6Gy7Ofqp2u1+Qv95DXtlOlywMMH7Kq9UdLph8clnz9/R5L/zrtvgScgNKK0+fN5T3n3tkAy/QS6WNwRQ9ArLf3Wqg9K
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(7416014)(82310400026)(376014)(921020)(10067099003)(56012099006)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021123027099003)(261021135927099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bsaW+AbtzHIUOIhVBAQCMjXeMhC27P8zhhR2oEhzFV7J8FVfXdxh4va0dMmOZ+veKwhCee3lWYvsdXefU6rE08k072iRQ5DwtPTPX5oPpL9A4IKk0WABqxGo/RO+aqyOVLwJMPY56bu95/c23UW/I9Hg6JkttmdXKPRFor4QMYAPmJ3Zs288of6txpfvXwGCJJSDxY6UUKNmbetz6TUDK1G8BM3YmWNPpzVFI0hSYwHB1HqstbhPLExuaSQEEQ8oyNTL+oNa4/4zy2CHi0CoEld+ijPLGeKfzsUGohG62PC2rScVoxmrNzvaRsF7niZPLwE/4aSKXgnKlv5di2wUlJbeqHRxCJk5XexqyBsb0HRWArVPRrtcm4qHQeleI6lmnSS5kDVdNTu+3QVCMdVr+eBSSPobHm9q2BfIsP4COUD3hAupbiEgxLeBtfJ/ItCb
X-Exchange-RoutingPolicyChecked: NrQHjkwuRWTx4od0n9UU+WuLMwHrXk99oDKjimnPRSBpIlE4l1nW4ZfOqxPOm4sRxuESopZlxET7Lyw658EtXKKLNMFvvyRX7KCX5XarFHp4mq8uVb69pF6UZd/SDcRTF0J3trr5xS01S2tHEsjTlGm07NJ+GmZwA+kSR8UTGnvJ/pntI8ZwI7ZYVilJibU9fegRqEZSk5fpRXM+tkbxe1Br1iRg+C4Ndo8VdloZZi662FUYXkAXEbeDCRfap1fLz02vRahkHLm2R9u0vhlP7Tep7t/ppu6+vUDRkj4A6GTTQvu/CDH3RScV6GHzG+jiRludCmmkDgciDozCill4Vg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 06:06:07.8749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d8a87f-e20a-406c-9804-08df4b835cd4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF0000000A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB276679
X-Proofpoint-GUID: tbX-dsi-km0pj8R0LN3xUOjxUH27VkOA
X-Proofpoint-ORIG-GUID: tbX-dsi-km0pj8R0LN3xUOjxUH27VkOA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyMyBTYWx0ZWRfX3Md2KkXqRL31
 e1eSZ+OsFJqjfco8i0MScRwZlmKVeweazgtYwiSucmCX2k9EEIBGtXKJx57UnCkchiU6gkfkHB6
 v5bxpzjR6cDoY8bVGj7/yCZZIDZYFFE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyMyBTYWx0ZWRfX5j+aB8u7t74N
 rf83EgZJQpSW0jlZTFrmsS8DHnVElCpdd2XtyftsRDQz0HWgVlSij1Nvv0zrOj13aEmNG9PWmC9
 L3YJ5GF0snqKnMcU5i8TFkx3LGXkxQX96oCB7sp4h/kJQ3cM5R0sswYyX386VjbDTyde55T8R8f
 fGwWf3H+usGo1IKDZXLSi+TogPbA22p5InLIHC+w+2OKiE+3cH9JwVvDzOSHhrFoH/EjFsNBXRL
 ayTdfYgQA12SAXFWxA88j7985MlWssbXGrRbDQlu4IBbvgotxL8X9M/eE9rYlLvW5kO7UThP2Zj
 ScDzveo0YILdgNLTtBuglVCHJ8P2KnnUVVWePpE0ilvefF4thrNp//V57pLVmE/y8rNVyufp2sa
 cj1LmgT2ttVY5yqbxUWfnoeViJXIdjpqTt+soDGV0maN6D6NSHyTu4XshbKHoaa8tAESftr+IOI
 c94AGTIIiZ+mPqx0Fqg==
X-Authority-Analysis: v=2.4 cv=Ss4Fe/O0 c=1 sm=1 tr=0 ts=6b07cc55 cx=c_pps
 a=0llFe6yxug+qBfU07gGDXw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=O2zAO_9vvrOw1WHnYYsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260023
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add system suspend and resume hooks to the cdns-mhdp8546 bridge driver.

While resuming we either load the firmware or activate it. Firmware
is loaded only when resuming from a successful suspend-resume cycle.

If resuming due to an aborted suspend, loading the firmware is not
possible because the uCPU's IMEM is only accessible after a reset and the
bridge has not gone through a reset in this case. Hence, activate the
firmware that is already loaded.

Use the KEEP_ALIVE register to determine if there is a firmware already
running or not and load the FW accordingly.

Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
---

Hi,

Changes in v4:
- Use LATE_SYSTEM_SLEEP_PM_OPS for the pm_ops.
- Replace genpd_notifier callback with reading the KEEP_ALIVE register
to determine if FW is already running in the bridge
- Link to v3: https://lore.kernel.org/all/20260601095041.3042950-1-a-kumar2@ti.com/

Changes in v3:
- Register genpd_notifier callback only when genpd is available.
- Mark mhdp->powered_off = false after resume is successful.
- Use SIMPLE_DEV_PM_OPS instead of SET_SYSTEM_SLEEP_PM_OPS.
- Set mhdp->hw_state appropriately in error paths.
- Link to v2: https://lore.kernel.org/all/20260205085233.81678-1-a-kumar2@ti.com/

Changes in v2:
- Fixed defined but not used [-Wunused-function] warning for suspend and resume calls.
- Link to v1: https://lore.kernel.org/all/20260129112016.2448037-1-a-kumar2@ti.com/

Thanks and Regards,
Abhash

 .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 121 +++++++++++++++++-
 1 file changed, 120 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index cdee05380fd29..4b0f51b309505 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -12,7 +12,6 @@
  *
  * TODO:
  *     - Implement optimized mailbox communication using mailbox interrupts
- *     - Add support for power management
  *     - Add support for features like audio, MST and fast link training
  *     - Implement request_fw_cancel to handle HW_STATE
  *     - Fix asynchronous loading of firmware implementation
@@ -2287,6 +2286,125 @@ static void cdns_mhdp_hpd_work(struct work_struct *work)
 	drm_bridge_hpd_notify(&mhdp->bridge, cdns_mhdp_detect(mhdp));
 }
 
+static int cdns_mhdp_resume(struct device *dev)
+{
+	struct cdns_mhdp_device *mhdp = dev_get_drvdata(dev);
+	unsigned int keep_alive, keep_alive_inc;
+	unsigned long rate;
+	int ret;
+
+	ret = clk_prepare_enable(mhdp->clk);
+	if (ret)
+		return ret;
+
+	rate = clk_get_rate(mhdp->clk);
+	writel(rate % 1000000, mhdp->regs + CDNS_SW_CLK_L);
+	writel(rate / 1000000, mhdp->regs + CDNS_SW_CLK_H);
+	writel(~0, mhdp->regs + CDNS_APB_INT_MASK);
+
+	ret = phy_init(mhdp->phy);
+	if (ret) {
+		dev_err(mhdp->dev, "Failed to initialize PHY: %d\n", ret);
+		goto disable_clk;
+	}
+	ret = phy_power_on(mhdp->phy);
+	if (ret < 0) {
+		dev_err(mhdp->dev, "Failed to power on PHY: %d\n", ret);
+		goto phy_exit;
+	}
+
+	/*
+	 * The KEEP_ALIVE register is incremented at every scheduler loop of the
+	 * firmware. If it changes between reads, the firmware is still running
+	 * (e.g. the suspend was aborted) and only needs to be activated. If it
+	 * does not change, the bridge lost power and the firmware must be loaded
+	 * again.
+	 */
+	keep_alive = readl(mhdp->regs + CDNS_KEEP_ALIVE) & CDNS_KEEP_ALIVE_MASK;
+	ret = readl_poll_timeout(mhdp->regs + CDNS_KEEP_ALIVE, keep_alive_inc,
+				 (keep_alive_inc & CDNS_KEEP_ALIVE_MASK) != keep_alive,
+				 2000, 2 * CDNS_KEEP_ALIVE_TIMEOUT);
+	if (ret) {
+		ret = cdns_mhdp_load_firmware(mhdp);
+		if (ret)
+			goto phy_off;
+
+		ret = wait_event_timeout(mhdp->fw_load_wq,
+					 mhdp->hw_state == MHDP_HW_READY,
+					 msecs_to_jiffies(1000));
+		if (ret == 0) {
+			dev_err(mhdp->dev, "%s: Timeout waiting for fw loading\n",
+				__func__);
+			ret = -ETIMEDOUT;
+			goto phy_off;
+		}
+	} else {
+		ret = cdns_mhdp_set_firmware_active(mhdp, true);
+		if (ret) {
+			dev_err(mhdp->dev, "Failed to activate firmware (%pe)\n",
+				ERR_PTR(ret));
+			goto phy_off;
+		}
+
+		spin_lock(&mhdp->start_lock);
+		mhdp->hw_state = MHDP_HW_READY;
+		if (!mhdp->no_hpd)
+			cdns_mhdp_bridge_hpd_enable(&mhdp->bridge);
+		spin_unlock(&mhdp->start_lock);
+	}
+
+	return 0;
+
+phy_off:
+	phy_power_off(mhdp->phy);
+phy_exit:
+	phy_exit(mhdp->phy);
+disable_clk:
+	clk_disable_unprepare(mhdp->clk);
+
+	return ret;
+}
+
+static int cdns_mhdp_suspend(struct device *dev)
+{
+	struct cdns_mhdp_device *mhdp = dev_get_drvdata(dev);
+	unsigned long timeout = msecs_to_jiffies(100);
+	int ret;
+
+	cancel_work_sync(&mhdp->hpd_work);
+
+	ret = wait_event_timeout(mhdp->fw_load_wq,
+				 mhdp->hw_state == MHDP_HW_READY,
+				 timeout);
+	if (ret == 0) {
+		dev_err(mhdp->dev, "%s: Timeout waiting for fw loading\n", __func__);
+		return -ETIMEDOUT;
+	}
+
+	spin_lock(&mhdp->start_lock);
+	mhdp->hw_state = MHDP_HW_STOPPED;
+	spin_unlock(&mhdp->start_lock);
+
+	ret = cdns_mhdp_set_firmware_active(mhdp, false);
+	if (ret) {
+		dev_err(mhdp->dev, "Failed to stop firmware (%pe)\n", ERR_PTR(ret));
+		spin_lock(&mhdp->start_lock);
+		mhdp->hw_state = MHDP_HW_READY;
+		spin_unlock(&mhdp->start_lock);
+		return ret;
+	}
+
+	phy_power_off(mhdp->phy);
+	phy_exit(mhdp->phy);
+	clk_disable_unprepare(mhdp->clk);
+
+	return 0;
+}
+
+static const struct dev_pm_ops cdns_mhdp_pm_ops = {
+	LATE_SYSTEM_SLEEP_PM_OPS(cdns_mhdp_suspend, cdns_mhdp_resume)
+};
+
 static int cdns_mhdp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -2497,6 +2615,7 @@ static struct platform_driver mhdp_driver = {
 	.driver	= {
 		.name		= "cdns-mhdp8546",
 		.of_match_table	= mhdp_ids,
+		.pm = pm_sleep_ptr(&cdns_mhdp_pm_ops),
 	},
 	.probe	= cdns_mhdp_probe,
 	.remove = cdns_mhdp_remove,
-- 
2.34.1

