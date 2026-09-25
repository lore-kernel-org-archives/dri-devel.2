Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAAAC9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 18:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7979D10E2AA;
	Fri, 25 Sep 2026 18:34:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WTGzciwx";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84DF210E284
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 18:34:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6ZbuMa5Blrnd+uZ3U/uYipwMdwoA4YAZuuuiyoF5pEtS0V3JWespI9Dr5jlW5xjxK94yFSpqVlZDESoD7F8V489PtXO47VZYdXwLHMduwVir+CpPULA0+GnPo7PTEa9kfLHZIsdFi39k6zbBCcp/CbKfFUPiMLAV4RmViebg6Q3LDdlBBEcF9hNhIXW7zEjvanZyh/vJA8nCYPE1C2PpJvsBfEJul0fJCk2LmhwN2leZpCtOVTg37H+kp/vM+j1+7aZ07hmR/1N+aaO6UYeYaH5g7gYExqeq3RuFQPawX9uI9nC/Pv5M6hzl8s8VGfzxEli1BpgMPcWKljdM8Euaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0ejlw8sVY+S3Im4bVAWiELxOU7IhoE3iDJWgUY9MwI=;
 b=NxRaaN53EmYKmAXhGsSByTaRFxe60KHjPcRezlnKqwPc8w7cCwFsLW4FpiKxY6HezLRxwgj/3t4B8B1Z1nJIzzeBS2awxR0CgSStVzPgSzj7+ITVGqjU8w8nf9bjqHGgCJqjnBTufdhNZTSL7//KOo+WNJjLWhnKriFo0I9c4E+5suAkzubBUQ4BIoaxCNZJmasWb63xI/kZY4SXdkJa3xvsyZZ6QevV3vek+Q2TQdu9Dw1cZD3AnTBzGk73+nkY385jT3VYzQHaUwXJBHpx0wjVUZOnkCF/11GW1HXFyhkZHWT3Y1YrAob0WCfUPffk/VzgiNY26WcMO2H5MMYF3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0ejlw8sVY+S3Im4bVAWiELxOU7IhoE3iDJWgUY9MwI=;
 b=WTGzciwxE+67FOhq01fdPFEQ2ZWKB3173lSGo3eRy5yHcMKzTh78XrBsa7pwqiq5HZgEmn3lR3Ufy4NSPDHxFdXbqat+txLZMiFCb1z+5m1pxlPAlbnnebwFn59T6EZXf3v8L3OC5gqZqk2X/HxZXPpCfleUG3xm5y7gEHzpcXA=
Received: from PH8PR02CA0039.namprd02.prod.outlook.com (2603:10b6:510:2da::26)
 by DS4PR12MB9794.namprd12.prod.outlook.com (2603:10b6:8:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 18:34:13 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::89) by PH8PR02CA0039.outlook.office365.com
 (2603:10b6:510:2da::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.19 via Frontend Transport; Fri,
 25 Sep 2026 18:34:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 18:34:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 13:34:12 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 13:34:12 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 25 Sep 2026 13:34:11 -0500
Message-ID: <d99bb6ed-7cff-6f8a-d5b2-23069fe0fcfc@amd.com>
Date: Fri, 25 Sep 2026 11:34:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] accel/amdxdna: Replace create_singlethread_workqueue
 with alloc_ordered_workqueue
Content-Language: en-US
To: George Karagounis <taterraster@gmail.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>
CC: Koby Elbaz <koby.elbaz@intel.com>, Konstantin Sinyuk
 <konstantin.sinyuk@intel.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <mail@taterr.org>
References: <20260925124804.58808-1-mail@taterr.org>
 <20260925124804.58808-2-mail@taterr.org>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260925124804.58808-2-mail@taterr.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|DS4PR12MB9794:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5004eb-c344-4d08-43ef-08df1b3398d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|56012099006|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: cA7IIzbPTP0oUtSx5sdbj6rxnszI4lkMospauKP2pj5vnE2k7NY+4QGzQ9BG1lgSluIFhypOhfbqFtwIwU2TQuzx7Mk5Mat9T1q9w1oZcXGxyFW/Zga9bTa/8ugFz1iFb3X00ZxSalj5nZttlvBC/sKPuLT1dnuMUVVmA9+trX81Rm1HWZ5GAc9FHC3XDKMftGQ+ZzNhT0a71O8hDtd/J7q07iE34gv70zHedMj7d9KM21bQy/hXoTZsFXdSqxfLS+PUpVRUdCCWvKEr0GoAdsskHJiWxcrwREmdOejwB6lIBfHtfF/hKs8llcoPBa8xMRtVQjEcXgiKsQx8PbwXgAhHvJuwQC2NuoyTh8pWmu1Fik4EZ3t/cKUdEY6RUU3pVRzKD81vQQzi2jTBcHwRKtc7OCpNPY9olDKiNyUjq43UcNFu5f8lSOP9LdPPSHDSHhERsA7sc7qUAuJifKMUQ+gJf3dxJqwE0YnEWY2QEuAgxt3tvGVRXtix8hl+Of07/SFDX4LdgVJqSd0nbLJN23vQWMF2CfQ8MSOsk+9hDrmCKHbHF2P3aOTP6YBX7J4eo2GPPNO4waSW4POZFCOxkNWIgUJQwmJPk+6smqRPcG7x5ZloPlPoZifuGSIC7SA/ULayYk9FBaDSVd6KDnj0coOyOth8vsbCTHnUM33EGXyuDQHYxMNHmiq+N9FGFBr0KDpYLNVVaXO0hTmdQ0CUPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Mr8NRc++B1FfVb5I9PdL05YI4Sao3wSL/a3ClLW9ZIHSyw3tQzJe8NsAePhXRdR5ppDBnNTVoUzsmnGzjdqvyRxRQ7iQ58db1uTGCIFUzJoxsq4fczxoB/Im8l1KhcuvWwFKg41dqPoKcQ5WBMwR1F378IYWKlxkbT3JcqUY90ejvHn+rh+PEOB+vjuMR7oezB7P6k0VSJjoGCV+ZyKixVwuQFx0a99e+lh9xjhVDCues6qBQJxKPV5eZ3K3lnvDCTIL866e6J96PgwSuD5E6vaJ/k4mLRIi6fTiFwqAQIN50dtYiY0kasMHMo9J8xEq0lkmPpSjZc0o/Cic3ywWAqdOpgMcoI5Ezr7ySyF2gBaMTOqc2o56Y9nr42pQAHVm7nluoJlF8gBE01jvrZLBN4QBjeUpJ1gnofOXeTkzrDy19lE4WX3KvElq2gv3a/3N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 18:34:13.0275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5004eb-c344-4d08-43ef-08df1b3398d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9794
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


On 9/25/26 05:48, George Karagounis wrote:
> create_singlethread_workqueue() is deprecated. Replace it with
>
> alloc_ordered_workqueue() to use the shared system workqueue
>
> infrastructure more efficiently.
>
> WQ_MEM_RECLAIM is added to ensure the mailbox can process
>
> interrupts under memory pressure.
>
> Signed-off-by: George Karagounis <mail@taterr.org>
> ---
>   drivers/accel/amdxdna/amdxdna_mailbox.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
> index cc8865f4e79c..05c3786de135 100644
> --- a/drivers/accel/amdxdna/amdxdna_mailbox.c
> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
> @@ -481,7 +481,7 @@ struct mailbox_channel *xdna_mailbox_alloc_channel(struct mailbox *mb)
>   		return NULL;
>   
>   	INIT_WORK(&mb_chann->rx_work, mailbox_rx_worker);
> -	mb_chann->work_q = create_singlethread_workqueue(MAILBOX_NAME);
> +	mb_chann->work_q = alloc_ordered_workqueue(MAILBOX_NAME, WQ_MEM_RECLAIM);
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>   	if (!mb_chann->work_q) {
>   		MB_ERR(mb_chann, "Create workqueue failed");
>   		goto free_chann;
