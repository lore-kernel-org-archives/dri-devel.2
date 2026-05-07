Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAFACD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 21:24:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 322B110F27C;
	Thu,  7 May 2026 21:24:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PZG0owcZ";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013012.outbound.protection.outlook.com
 [40.93.196.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AF4010F285
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 21:24:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cq6WQZjcHRZ0m1A0Y0fphH42taYZe+ncOBPGNPHyS6PS9z/243903+m+tSZBqrk6Q1vAo61lc1aLLUYar2qGp2BQ2AA9wMLfbp8TraSer/wnzxrRIZjOCw8IDYn5Jn4ZbyoQlOWSG93Dx6G9QxVcOmeaWBMkZThUkzc9Xpro9Kn+OAp+WkisPxhTafmBEXYr/H0yTb0C4qUMm2JfzQwgkj1K8bR33sqxjP4aP9Wn0aXF15t8HHECOVOeT+Qi9ELXCyHtiMTwYvulHqaKgVC1imdt/EIDY0C0ZZqTIhNzQOP/9AYUa5PtnCkvaXTxwupuyKz9eYXQ0Miec7gOPzewZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21YTMuwh/zSmVPtnzY4KpF8Tbnp9kz7vWXXw7zdq5Ic=;
 b=fGo7WIG5TQakZFev9XUhDGOOEUR2M2Ob9KeVb2rT1GgypAHkEtsHBFDFCAd/iRpZmgfN0BbliToNa2/j63bpYCglKKtBMJMDnsZKBt6CDPiJnRQ9qpiZq+t8tvQxooy8sNenKVnVOUyB9q9aEtABtp8xlI/hjIMktN31t4S9BynW4My6Bhy18JXjaPjuZi8dJeSz68RqLT646frcwh8OdiB5zqVFdxQXZquBWuZW3Xm5ghWSn3AcWM6ldzZqXrOBAf16rzATdu9ffZnENP9xjQeQWTAzCSBQhMGVevc/LrEo65mCV9e61t1aDIU/f3B/h4pTNcA66JIQY0iMjkwrXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21YTMuwh/zSmVPtnzY4KpF8Tbnp9kz7vWXXw7zdq5Ic=;
 b=PZG0owcZnenvNX8U8lBoIUzKQIEQTnrDFQZdqDi3GPPEXJCM2ES663JNd9cYxc1h1ylHIb//9BO52qixnaqV0LyFYq2dQsP2G8f1h4+nGeDXHRLYawCWdLPH1mawdty25TOWuJkm7+CkHlVxLm1R/uFw+16lzwdVxMrk8hif7n4=
Received: from BN0PR04CA0197.namprd04.prod.outlook.com (2603:10b6:408:e9::22)
 by BN7PPFA42F4F89B.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6dd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 7 May
 2026 21:23:58 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::df) by BN0PR04CA0197.outlook.office365.com
 (2603:10b6:408:e9::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Thu,
 7 May 2026 21:23:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.1 via Frontend Transport; Thu, 7 May 2026 21:23:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 16:23:57 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 14:23:57 -0700
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 7 May 2026 16:23:57 -0500
Message-ID: <bc1bf9be-f736-c012-4f79-1fe36a07113a@amd.com>
Date: Thu, 7 May 2026 14:23:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1 0/6] SR-IOV Virtual Function support for AIE4 platform
Content-Language: en-US
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20260505160936.3917732-1-lizhi.hou@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260505160936.3917732-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|BN7PPFA42F4F89B:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d5e27ff-070e-47db-c27d-08deac7ef34e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xUhEJ4AtKJ0iPbfgjj6SIni1W70ZwLWf3BXe9cKSKv0saghjM8ZCcnW/MWcjcClrl03cRq+GZYvADXOdWMOffaBIir7XRpJDnW06uiTfn/zYj6xcRiRNTHD3Fgua08qt500jmhhQ+/SYvTODrIwArP2G/tYlCdz5qiRXK674RfUJdNr3mrOAJN+IfZPxIaA9SwHuNxQIfYaFcwP827oXZ81y7CP2m6yf4Z+wb6/aWDWs2DtF0pr8NQsz1vfVcFFWkopERquX7aNYt8Q14Qfu+xXDq7ikOhPnNGJI5hB84bOaK3NpF+uW3GLg6DffCInt7a8JWCr0ouKle8W8uJMpZmKD+OZq4/wSC+9nm/r4l8cmzDOudOUOf9XVUI49zcnlWaDk03/Vs4X5xtO2UrElWxpnvpcqWYgI4/SpHIB8UzGEfzFgzteaH/gKt2sGqCltnPmB+h7x94PpGeQIvKLPH+QxTJxF6pPkSkmlgV7xJK9SZaAK6zd3+6sKxKgBpyo4TNv0ErN7W0oXrIA+wdHdp++68wbynnJmXAtyFTiD2irP01w3xBWll48pUJUnD6OjvxNkQLcqX5KIPKEXNwZK43D85gUyNk3vKk9RRCnkPNJDx9TtBJKeSq3/gOIwkRAe0Fxgr5y4uIUZ7NCGzDIYOBIT/GSTIRyYvYvkxm7diq+WVbV7dGyvQI7a7Lns4HOW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1KWMmK/2FC/w1qVYtKEXBGnHXA+tIl9sqSkURGRupiSBhevY7wl21m3o0rZCJvUdWpMfnb8aHrPCJIP8IoPWQ1tr/AvSsOsotXj52Vfe5kj7DIMNchJpVejGnzrBNDlQu6AFQo7G6Lncj8B9dIcPHM/zvNmDs5WeWlzpfLq1YQFwaj3TGr6NLpKlSItFYDq1lO3FfQ5itl3/DFdJcCtGJzteItECczju6KBFi7sf7DDRNedpX6H+d/C2GUzIvP898PGyHkIbrx+scWrx926NsiyJvQDRigO8sOxFrKuRJDLp2ZzifNqM8TsukDpXmn9OS3hFr/RjW0klhAOW8S/GiA/XjB8U9SzEeGWSWvmP858R2X+FFFApn2EQNkbwce2xn/ryLYhdhoTo0jAV/gYf65IR4ReUBce4sGLhl5q29U4PgqfB6Jdt0clAZDCwcs6r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 21:23:58.0649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5e27ff-070e-47db-c27d-08deac7ef34e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFA42F4F89B
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

Applied to drm-misc-next

On 5/5/26 09:09, Lizhi Hou wrote:
> This series extends amdxdna with initial support for AIE4 Virtual Functions
> and the user-visible execution path.
>
> Move message buffer allocation and device metadata collection to aie.c,
> allowing both AIE2 and AIE4 devices to reuse common code.
>
> Testing:
>    PF + VF: Probe AIE4 PF, enable SR-IOV, bind VF devices, and run
>    end-to-end workloads from a userspace application.
>
>    Regression: Validate existing AIE2 regression tests.
>
> David Zhang (5):
>    accel/amdxdna: Add initial support for AIE4 VF
>    accel/amdxdna: Init AIE4 device partition
>    accel/amdxdna: Add AIE4 VF hardware context create and destroy
>    accel/amdxdna: Add command doorbell and wait support
>    accel/amdxdna: Add AIE4 metadata query support
>
> Nishad Saraf (1):
>    accel/amdxdna: Add AIE4 work buffer initialization
>
>   drivers/accel/amdxdna/Makefile          |   1 +
>   drivers/accel/amdxdna/aie.c             |  79 ++++++
>   drivers/accel/amdxdna/aie.h             |  31 +++
>   drivers/accel/amdxdna/aie2_ctx.c        |   4 +-
>   drivers/accel/amdxdna/aie2_error.c      |   7 +-
>   drivers/accel/amdxdna/aie2_message.c    |  51 +---
>   drivers/accel/amdxdna/aie2_pci.c        |  54 +---
>   drivers/accel/amdxdna/aie2_pci.h        |  28 --
>   drivers/accel/amdxdna/aie4_ctx.c        | 333 ++++++++++++++++++++++++
>   drivers/accel/amdxdna/aie4_host_queue.h |  24 ++
>   drivers/accel/amdxdna/aie4_message.c    |  55 ++++
>   drivers/accel/amdxdna/aie4_msg_priv.h   |  98 +++++++
>   drivers/accel/amdxdna/aie4_pci.c        | 310 +++++++++++++++++-----
>   drivers/accel/amdxdna/aie4_pci.h        |  37 ++-
>   drivers/accel/amdxdna/amdxdna_ctx.c     |  40 +++
>   drivers/accel/amdxdna/amdxdna_ctx.h     |   7 +-
>   drivers/accel/amdxdna/amdxdna_gem.c     |   5 +-
>   drivers/accel/amdxdna/amdxdna_pci_drv.c |  25 +-
>   drivers/accel/amdxdna/amdxdna_pci_drv.h |   4 +
>   drivers/accel/amdxdna/npu3_regs.c       |  25 +-
>   include/uapi/drm/amdxdna_accel.h        |  24 +-
>   21 files changed, 1042 insertions(+), 200 deletions(-)
>   create mode 100644 drivers/accel/amdxdna/aie4_ctx.c
>   create mode 100644 drivers/accel/amdxdna/aie4_host_queue.h
>
