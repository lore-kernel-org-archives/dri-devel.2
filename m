Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A62606A325
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 10:30:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25A7C10EB7E;
	Mon,  9 Nov 2026 10:30:25 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023089.outbound.protection.outlook.com [52.101.127.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A958210E871
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 10:30:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZY+OS+s/fPwnZ31oPO4pVhS3/78N0pmWXev2Y3NPpZ3CddM+FMQzE73dsszaF9y4ftQ0jvSWUlddYLagLVKV68N/pNXj3klh0BJ0eUV02f4ZDvFOuU3Mw4oEgkkuo+e+IHCjaZOgBFWdhp6FmCgCYoYiioZDxeN9rTnbuPyG0ghR4ALHStMqnV9qsoOQVoH/5jYxjJ0XUOZ4WFUKA6H2/uVV1bfsebq4gLF7BfZ79lDmvIYcvJrIy50JVeWf+zKBQ3ENu/ZQutSADW9ZKKZua1BG2ehffBs6I19Nx0G+zXDLPWs6xzpw4q0AsUu1OaxSwpyVDsdcX+hhIop4X8v9mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LP0Z8TA/eZkuzNwDEz9YUF9pu7NoYEjCfCEun5no4/4=;
 b=UB/dziT8hNeO2CPDUPe1++sgkKM5pUEt1G0qT7pC3vNYWWNPyMVeeIxzdCsOA9wCxdPu/AXDaqefOK6SVI7yUENk+i+grpi/dY6vvrYjYEI90AAaaA96nKO96v1eyzg0EgtcRbITCc40b0ohUsH29FvLUWdQIczauvrCXxBsmWk3DAUacbFO1TMPVb700XrsoGmGWQUq41/22nGMxh7WaOWiQAW1vhBga1eRtMD2nCc90peHSnIUEui9watz0eE8n1q20jwkbgUHu5NsQXEE4vwLxiAVUtRnkZtkBMyVs4bNbKUgSfVv+CHswGMcHX6BAFgeELJhkQfEamOrouSVlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::13) by KL1PR06MB6577.apcprd06.prod.outlook.com
 (2603:1096:820:f8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Mon, 9 Nov 2026
 10:30:12 +0000
Received: from TY2PEPF0000AB84.apcprd03.prod.outlook.com
 (2603:1096:300:2d:cafe::b) by PS2PR01CA0001.outlook.office365.com
 (2603:1096:300:2d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 10:30:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB84.mail.protection.outlook.com (10.167.253.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 10:30:11 +0000
Received: from localhost.localdomain (unknown [172.16.64.56])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 985764102E65;
 Mon,  9 Nov 2026 18:30:10 +0800 (CST)
From: Luo Liu <Luo.Liu@cixtech.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 Luo.Liu@cixtech.com, wuyi.shen@cixtech.com, cix-kernel-upstream@cixtech.com
Subject: [PATCH 0/2] drm/cix: add Sky1 DisplayPort transmitter
Date: Mon,  9 Nov 2026 18:30:08 +0800
Message-Id: <20261109103010.110911-1-Luo.Liu@cixtech.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB84:EE_|KL1PR06MB6577:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 49cd6db0-599c-43f6-7353-08df3e4c6f70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|42112799006|23010399003|261102123227099003|261028144727099003|261009223027099003|261021121427099003|261022105027099003|261026121527099003|261026140227099003|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: vDGEfVuS4GoMjcptpGYW+BHJutETE9fSi57do+IhC1wo3LUWq3UmJnyTcTsQe0K1djp4R0EgRAWHSAaKW1G0R6TBNeCTfem9SMwi7GY+k+P5kHrTCeDHWZrVOIUOhRyhC+cYEqXnKWGkJlctLC4EtSSOsL2HmqNMcfejEoB/8oBVXpgjFIRWh49KXHFmeMgMxJMT9rQwQu5zT0RcTaZV9bFnf3ibOJaHLgUgiuRzvZH3CWBS2RuIiBA2+LfikGTOjqoWR63jwG93QsKnRs3Q6476r9xYpZdOSMu5R5ZW8IYERXgs6SPSpR1EqfBEbd8k3rQQW3lQabR6bTI2E+efNSe0WtmLYJbQSPOYL2CjFYhKA36yI0lvvgORSfTUjl4u151ElViQVVQjkl1B8S290Zj8mm4NMqy1BvOl2a60yVfISxRQZrxAErPStMiEaMWlQ4VaDU+9xNEiMwbIj3CljyEOVgqgs3w8Aem4oWxrrst4cE2lmfCi1jbv12RvEyyP4Ca7pn998tgdeYaSDJoErj3XBFbiEdsLwoYWQY5dVNY34SBBUuq+U84ckk1atSbrM9907C5QyS5hmzsX7EdDovht48Z4DcgmqOt7GkcW72Yt5pXWejkY92f9mjyUFXP/NqVIeIuCr476cleXPKH0ain7ynycmyRyv0ftgWFwjIpGLS8ZKTKmEVXRqDK8pyvCRfeIVC/2VsI5lngCkqHD5w==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(42112799006)(23010399003)(261102123227099003)(261028144727099003)(261009223027099003)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N6NvxQ1rsINRiQMyM8kYEQXVP8OkXuvxqV28tj15DsSVELjBwYvFCpM1yriC52XdbVLpLl+wtBL/AuTJ9nTHZnTZ0uAJ1Bd+CFdA9d78J03rIU9OrYO/R46AWTgI3xnZNP9a5WUWmGgc900Kgxbvd2ps+Bic2EpWiNVPFUve1i/nQmkrWLcTsDllu/Xc33EARtkDzCCqtjXP9i7q15AXRbOqsWCGwhFunHTuDvjPvt9FavdQEoWF9yOr308IE5kYcwkKcIyqumK8ygxiEmM4vTdKcFwgIhhrvO5EFUEWy3458W6qiCyEr1KDZEh9yQW/nhr19Q5SvlqPQHU+X9uH2jP3nd/0BDljXJISu/uxkcHMYOxHgh2Y2nKWmZX/7VjFE6kX7KQiTYXR5SAjELDi4ZCT/CiKyf1Vtyq8uBnqL5GioIADR3XhFcYAjOSCYu9s
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 10:30:11.4001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49cd6db0-599c-43f6-7353-08df3e4c6f70
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF0000AB84.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6577
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the binding and the DRM bridge driver for the CIX Sky1
DisplayPort transmitter.

The devicetree nodes are left out of this series. They depend on the
DisplayPort PHY binding and driver, which are not yet upstream. The
SoC and board nodes will be sent once that PHY series is accepted.

Luo Liu (2):
  dt-bindings: display: add CIX Sky1 DisplayPort transmitter
  drm/cix: add Sky1 DisplayPort transmitter driver

 .../bindings/display/cix,sky1-dptx.yaml       |  108 +
 MAINTAINERS                                   |    9 +
 drivers/gpu/drm/Kconfig                       |    1 +
 drivers/gpu/drm/Makefile                      |    1 +
 drivers/gpu/drm/cix/Kconfig                   |    3 +
 drivers/gpu/drm/cix/Makefile                  |    3 +
 drivers/gpu/drm/cix/dptx/Kconfig              |   16 +
 drivers/gpu/drm/cix/dptx/Makefile             |    4 +
 drivers/gpu/drm/cix/dptx/cix_dptx.c           | 2086 +++++++++++++++++
 drivers/gpu/drm/cix/dptx/cix_dptx.h           |  370 +++
 drivers/gpu/drm/cix/dptx/cix_dptx_drm.c       |  653 ++++++
 drivers/gpu/drm/cix/dptx/cix_dptx_drm.h       |   16 +
 12 files changed, 3270 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/cix,sky1-dptx.yaml
 create mode 100644 drivers/gpu/drm/cix/Kconfig
 create mode 100644 drivers/gpu/drm/cix/Makefile
 create mode 100644 drivers/gpu/drm/cix/dptx/Kconfig
 create mode 100644 drivers/gpu/drm/cix/dptx/Makefile
 create mode 100644 drivers/gpu/drm/cix/dptx/cix_dptx.c
 create mode 100644 drivers/gpu/drm/cix/dptx/cix_dptx.h
 create mode 100644 drivers/gpu/drm/cix/dptx/cix_dptx_drm.c
 create mode 100644 drivers/gpu/drm/cix/dptx/cix_dptx_drm.h


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.25.1

