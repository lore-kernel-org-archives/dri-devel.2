Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201D9606A320
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 01:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3VIuew7M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CCEF10F18A;
	Tue, 20 Oct 2026 01:44:54 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83E0D10F18A;
 Tue, 20 Oct 2026 01:44:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBmAIbFCSBbh1moZRXUBUx/BaHdY1ZAD0pzA2h/w01WKD3VlJpdyk8zWQJFSrrwZBNT2E/7o6PuI1KMuvVWK9U2E9pA3GckAhwjG1RUTjLXQftl4UCxMzhEGG2fSEoO1GEmbkCP45GY6ArcrXzkLd58ONNufaFst7YX/WMbMYA63xicKrN82lxYNS9egwikhqfCSfFS4K9QREGTXUaRgQXyHzpWWCW1H8wO2FGlj0bfWq8UstcZzM0Y7jwIQ9zGKIzIRzfZh7aBRtMzncjitKhfwAgg3vZ4RHUnAs0Tjr/RH96MoaBcrRH++lozuDttETYUt4/jawKg1Gv47VNOjEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxR7QkM+F1ut3huwzVdFwsygd+bBoGeQj92mWweTnw0=;
 b=T90+VLDToVf3UxQSeccuTgbDKbDLObGcQh72UnjPbfuawm5oQUDYhRj816FI87VPbUgQ1Fe4Sf/hrhV8RI9pA4ubqMzAIkjxnuDevKxBlOUx4zHWQ4cojtNGSl/yfut+j2N+NCtG2evMPsX6HGqZUlLS0Wha3RCw6niwWPFLm17Aro1IYjqZ3j/pSIvOshucWqQEygadjRj7sJTqQQZ4yzw0dF3gUi7CPNcKmWxvE+ic2Xz3wcEbk8sSTTD9KUiOGXBbj2rO7vhFC3TBmSBM6NNlTHgtZR672cvZ7bTcu0CFzhkWh8gsIgJC/Z0fsekG+Q6yzY5LFo1yttWNhn4O/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxR7QkM+F1ut3huwzVdFwsygd+bBoGeQj92mWweTnw0=;
 b=3VIuew7MKdchKgZR30ySgMCUDSMFrc/4ZlzskqrLREt7JkdF/8881hQQeBR44ycdG1M9G/3YUrw73Kfs/7C1LS3R1FXJJMAPqB3WzTfu4Ot2u0ZiNkBwPfdjvExvfh1gWZk46/oi1UbnI1CQrFfz8qRvQa1Et7mXBqwdZs13aD4=
Received: from DS1P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:242::13) by
 CY8PR12MB8067.namprd12.prod.outlook.com (2603:10b6:930:74::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.19; Tue, 20 Oct 2026 01:44:45 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:8:242:cafe::6c) by DS1P221CA0018.outlook.office365.com
 (2603:10b6:8:242::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Tue,
 20 Oct 2026 01:44:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 20 Oct 2026 01:44:44 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 20:44:41 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Mon, 19 Oct 2026 20:44:31 -0500
Subject: [PATCH 1/2] PCI: Preserve the initial bus number in pci_dev
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261019-vfct-regression-v1-1-5a63ddd378dd@amd.com>
References: <20261019-vfct-regression-v1-0-5a63ddd378dd@amd.com>
In-Reply-To: <20261019-vfct-regression-v1-0-5a63ddd378dd@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>
CC: Oz Tiram <oz@shift-computing.de>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|CY8PR12MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: a72a26cc-019e-4a28-40f0-08df2e4bb7aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: y5Qhg/f8NBSI4KaQXNUKhVysIJZYOpFaqCZKVUtmHJzTq9A1UydWIFdEYmR7y/TPjWfMU2tNoImrC13nZSmMEAc1NgPWhL6i7GQlHTMjkc7oHnXrh+POpU4PpH523xrlnvjOlLJGmTohQUHSM+AWBLrlW15tTC4d8OZVa1q9FqSDMLt2QfKQKEluvTxbxpfcxafWC32dRbTsXrScZEs3GOePd3Lpchem1GgnATxbbTtzy6mZqndGo3dxKhzw3YKc3CdH8eCOBf4ycaL5T+PePCTJye7eDDq9fZqdvQy/FmG2SedH7mjE8WcaU8kHQ8bTWdz/gJ0NFSas2gamTsasYeVSAhgGiEfyfJYzUY5m5ooRcTqfbsI7LyaiG9u7YK0bwqh3H/C3vWWtbBmjcj+w2s9ChJTtmFElA7KyRfsL6tgnlQlPiwyDW3j3TTfucaAn3ZrqLiHZB8Ewn8iJESZ9PL75MqiDQVGFeXhpX+SXaIxr+e4WfSlfz4DcTibPTsTTHqzXj7iiWqg3cpyOCYnhDL6pLZJWaHWTpCcnQ346KClyluTWxrSUN6BfC21WBUyOpwSzDycmW9naFjk8rcWexW8QfoZZM9Hb0FFfi59fdveQ4kZzaL4Ap817rLPmzg8vSw22IQaUIBf2Pex5JDxeT2mu0SWknsZ3cqzkV1GlqANE/Pm4lZ8BWQRhS8O2y/xJcOUOsNNDmAg8SqfZszACIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3gEWoy8oNjsC0ymWX0iSdb5tNNcxq8l4JPcc6YO5t7HTCXxjbL8SEY5t8sltQuAROHfhpjFARVb6a/+7aPBtKkg4RuS9SVPQvd53I2Wm4cjgorIIRBkRoOrkSt/8kbGrGSSeM7gBiMgbfZGaq90xU3D5kh6vjvdY5J/ZhSJwPKP4Z/ouZmTamE653eE+YRi5C2XYmrQNPhnhjAwXJpGmyQ+Of1+gNqJ1UYHPisfZolFWXfgHljIcZ1ywmhHle9+lAwPACHf+MOQGvj6uFr5eaqf7ynmgNtosAG+Nr7res/FvsRK5LAcS2giwvIN91kxTbMQxN9stip9WRG1DODVsP+igjcOGR5sIxWcdh+MQw6AINqJwhIy1JRdWbagU2XuFznpT9N+somS7Ho3s89z0x66u5VM95HaiFjjwAksOrcLys/3uQ0B73BJGar+1fUYv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 01:44:44.7873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a72a26cc-019e-4a28-40f0-08df2e4bb7aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8067
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PCI bus numbers can be reassigned after device discovery, for example
during resource reallocation. Preserve the number seen at allocation
time so drivers can match devices using firmware-visible bus numbers.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/probe.c | 1 +
 include/linux/pci.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 27008e2ea5afc..580b288d5c64f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2508,6 +2508,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 	INIT_LIST_HEAD(&dev->bus_list);
 	dev->dev.type = &pci_dev_type;
 	dev->bus = pci_bus_get(bus);
+	dev->initial_bus_number = bus->number;
 	dev->driver_exclusive_resource = (struct resource) {
 		.name = "PCI Exclusive",
 		.start = 0,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5ffcf5ce8c966..dae68b28ce051 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -363,6 +363,7 @@ struct pci_dev {
 	struct pci_slot	*slot;		/* Physical slot this device is in */
 
 	unsigned int	devfn;		/* Encoded device & function index */
+	u8		initial_bus_number;	/* Bus number when device was discovered */
 	unsigned short	vendor;
 	unsigned short	device;
 	unsigned short	subsystem_vendor;

-- 
2.43.0

