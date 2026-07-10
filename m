Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5298EC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 408F410E588;
	Mon, 13 Jul 2026 07:10:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.b="fZ1trGYW";
	dkim-atps=neutral
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11013038.outbound.protection.outlook.com
 [40.107.44.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B84B10E186
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 10:59:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Klkf6UF0ngoTl8J8XGL8PNxl5dHG50C+NqdFvL41lgkZ0vvERmyKZ5GCE/naXHgwQBQ+wWUO/L6flAedB88hol8bOou5nlgIBBe+CSgHPwbGH13A+SF1JOqQOQ87vUFGhjGrvDrVGmP2urkrcq+UyI4LskJQCUqxH8zICzqOG28LfScIZCKc42vBpjM56y3NEG2bF796UMDT2u43S3U7LLh+3RjcAGz0qs9ar87DZOEd4vbBd2eOw5AmfJsTzrBGgNHScGkV14betUT5ejwkkJOynIqO8m5zDQDf8rPAUoArp28rugChNGD1WBexHxggObgfWLUeLogwdk3jkJxLjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35x4wwV5MYKQzeenme6BJZgLkf5o9ZguyQuDmYfDE1s=;
 b=lZPoxyr/8xcfX5Vr6TjiUcXj12fOKXETBibCS64rNy19mmO7lLKzoYgX9dy57Ow2VJk25IXXicJ0rJ9wLTYXBQoz2DYU/4/v70HDbvHNVKkJqiRIdvJ8rIuONdkwdJTDGzB4eEO8ZveDOZ7z+T0bqHc5PAVSrzLHLzUc/XHRjOnX+qDhwmX4n/8QZMiEijnWFCnpXxrZLf4wXWwg+8kpxdzoQ04NdB9yKW8w7e+x4kFfKv27Xnbx9N3iPgNpUlpPc+TpLeUsJb8i34YALA2yAeeNleIb0e8uoaDMZHT6463sxI9JWCE1ed5A12nvs0CoWULcpr3uEhc0wYoavrH6Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35x4wwV5MYKQzeenme6BJZgLkf5o9ZguyQuDmYfDE1s=;
 b=fZ1trGYW57ZufWuTGJuRnoIqQDJiXFJY9OrbCUYOQ7mYSZsOzcm5yQY/FsiORKKiDZhz7Tx0mXRb7iCaYbKPoh32GjuxzKPQqOMo9BdsMeUa2/uvXhxr90vnHsg99ELQUaTUnYjqMfBA7vzaoc6rihz2BE3inWb5AOTUvEeF+Py+qOPdvP2HpBLfPGp4ncqTXhU2mW3Fh0K+k4ZH6rC8M5ZcBlL+E8IA4T5ucw/Dbkq+mPBrm41DvQlBluTjTh/7ZcJZfrPqhGfkvhaCpgfbLaseqD+Glrd79qVvicbNM5WIHyxRTweeoiKb1hDofuTl7lsLP/WVBySR5ylwsN5FtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KU4PR06MB8388.apcprd06.prod.outlook.com (2603:1096:d10:7b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 10:59:53 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 10:59:53 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org (open list:DRM ACCEL DRIVER FOR ROCKCHIP NPU), 
 linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 2/2] accel: rocket: Remove redundant dev_err()
Date: Fri, 10 Jul 2026 18:59:36 +0800
Message-Id: <20260710105937.409992-3-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710105937.409992-1-panchuang@vivo.com>
References: <20260710105937.409992-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0030.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::16) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|KU4PR06MB8388:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ebe32a-28fa-4a5c-8e25-08dede725e9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|52116014|1800799024|366016|38350700014|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1yyWVQlExtk1zkgXOpbpj5XqnO3EqTXtZ72ldDNjUmo24GD5msQ63BaNrVjSCwDM8FfkleXHXXCzHLRL67yKD/2IBUIJiR6tAqSzAFsfvGvmZhFDbN+lLxRQT4aXNVwHQQAUJU+wpXav2GLyTSm9iIMb8U644UObcWA3N8oGiOXsNjh89Yq+bGQFKfXjZO8cGZxUIH8lcPtrG2cdFpRFmitslep28MwKYUjul/SODLscvAiAG2SeLUSsNfn7q5TK9oQLt1PFqy6TMTRFtdXqfrqg5+vUS3gggkMSgkvcrFCjVrjj8CKaiYkE+w2bQscsbfLHaPuoP3/1FQdGaKoGNNK0s15GoC0lyR+yVSmMY4mVBmuOrvPiZv9r3dNvsS7G/MCCpIuVZP/OhTtXc9qVjXa2UCQYQkiZaxMziR7wFG6j5LMc5gypCfuGepjmYR2LoKXU9Yc3z5c+Oih847kW5Vm2MkR2CFJsa8RaVj9sX9i6PQsfP8N+bAwPYdoXf3IJHEbdJvd8aVF08fsBNYiER2vCG6BcCwmzBrTOVx3aeMZCQSio6PehxmWWpOUWHaWG8CFhOEpUexHSzWz/pw6GK3HUpPtHYUFhTY0EzcmnbQbR5j3LTeLY1c7RYabG3ZOrh5qGBe3ANHFOVAsKIfQ20sCsq8jicRr8Wu4x8JJOb37ZkLJO4+regSaqFQEbHNZgo6qym9ijC8cMlLjxiwqBCxH+fJFYg3iUkhmljUuIMJ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB5832.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(52116014)(1800799024)(366016)(38350700014)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y3izpr9Iy3qxJ6QP2Acxmdm8k6HQziMyFOXhIO+P5fzyrbEHAJu2aMv3mPY7?=
 =?us-ascii?Q?pWjsZciFaFaxHriTQganDt0aOvZNAOlMSgoOrJDfqHCrmA5T47OsyoZXrc3i?=
 =?us-ascii?Q?5NSgmRWWUMSQB/PzaQ3XEUEBigRxhXJsyPp+P+uE/HGreVWSlwzr14pbIXqi?=
 =?us-ascii?Q?q+J+joWbO+Qh8hH+LYjTMG6d3zSdwqXg3qdJ7SYfE9wdkkfTPFw6j+3XZXBB?=
 =?us-ascii?Q?FLiJ9ZF015gv6mYc+f+TmSLCCz0ltVy3IcyZWI/1aUwyRy2C9/pGMnLMMHdl?=
 =?us-ascii?Q?SY4V2F6ngHtAnHpxZr/mIJtj+S2TqLSa4FdC/GvoMxnQh0EJTBeAFc4u5TOF?=
 =?us-ascii?Q?PF7OjAQHaV1/Cc07cJrZtZ55+AM/9IXe8tXFyMkCIFCkEC7CQsFYUiBf12eu?=
 =?us-ascii?Q?YRuKoqSPOQ0LXqvoX3tGZtlSqdDYna+m+iyN8KNgntCL9FZGlVs2vjrs4F0b?=
 =?us-ascii?Q?GDxlh0OOGubJb2UDXWGrB4mMdbWMtjdQn6g0aN1ZYL2LmGhwWsW5Jb9HmE9p?=
 =?us-ascii?Q?wnE21W/I4XkK5IMg2jXpjO7LFsi7AxGJdvJUCSx/2IlZLTKDslLSLTlMSH0+?=
 =?us-ascii?Q?piUeC8kAoMcv4wfbMq3q25NdzIvHN/eiMGXMOkRC5ByChVSFN9jrzY62JWSn?=
 =?us-ascii?Q?k+Mg7ifpwkQMxQ2WTVACCXvBC3AQGBNFAijUVdBLEEtKQS+juQguq3uRDwBg?=
 =?us-ascii?Q?TLZMtjaQjwTfdboRId5Me1cz//bIaMF5KfvW7EtTo7KV8xD3Ad7KrpUFIMpa?=
 =?us-ascii?Q?86Y5zkDAKGnqpU7EC9lLC0y/GHnuM+SPNjGRg4Ykt5tFAisEIj3hnJ0hl3Rd?=
 =?us-ascii?Q?suiLxVHus4XE7SQhQs6nzLJaRBs/FtxXThpsWXer0Gmlid0mltuWt43PeTuk?=
 =?us-ascii?Q?fnd09WlFSp7GN1ENwD6f705LoziGP47BxI/Blkq6sbKtJiHabpybXQVK0OGg?=
 =?us-ascii?Q?OOevOJ7VvJZPEvRpTVgj7UcsaXlhyJRSBs82aCG8ibW3plbuTvLChpn4/QFt?=
 =?us-ascii?Q?ix5xEd/Mjgb3fvotl3J5CPpdydepIKz7tB1BNZ4SD+9XZoc8f6BtyfvI0fXB?=
 =?us-ascii?Q?XO09iJjV153kKZu7PH+w937ySMIZm671o02c0Ly90q28r7LMB11mz5eEigCT?=
 =?us-ascii?Q?aslSuEkmO/rxsyvw9U41ZpcDbQgHSnsALj6Uhns3vAYVyxR4uaA08KWlW7kq?=
 =?us-ascii?Q?kCY+ixZGhoekBJmjiLO3U1BJcYR7vjf7vYnpmZ+jtW1Dpwd3fWiZmlsk9ZgK?=
 =?us-ascii?Q?aCajkjCJYb3fSRq+S34c6qAS79ziU/uU5DxVdB5nJEEW5CxfHPiuP6JpMzt3?=
 =?us-ascii?Q?Wrv1CiRZ6jiBtKwdWg2FORgm/fdqRum4DWK5mprSyutbgLJmR3uuqzgoZ0k5?=
 =?us-ascii?Q?mZYRoRCY8YQUWwzUrKQC0Ic2oLXTHszmN7+7qhE8PoDJLcvx8kphss12JDTS?=
 =?us-ascii?Q?0lzRRb5pGsv+qPECYRWjJJr1M87Nij86C4ZggKtUlAWtvzlFOKGHMJv5RsD0?=
 =?us-ascii?Q?AVQm2MjXTraFp7jfPkYmo+ju/RlqVJVzASam4SmpJUru0mATLFKz2DG0v9kW?=
 =?us-ascii?Q?xLTDVxgkFhvJPOxCDx+jqdDazodf1QRkqg19uAXeYPj2w+OLP5Ucps0MMzwF?=
 =?us-ascii?Q?hejra5sjIFvhQMq76X/QQSUKnRQwgHEMroNCP9KFukJTnMP67QnoErY5/db9?=
 =?us-ascii?Q?d4woOjOiiE70ZwQcq5xJRvt/E+hZmK66YynacD/BwszxGJ609ic6UoEC9StC?=
 =?us-ascii?Q?nGp4KsnnQw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ebe32a-28fa-4a5c-8e25-08dede725e9c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 10:59:53.0111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TJ6INYPIoqvT5piA1JcBoH7w+cFxjTLtdWhKG2WlrX2l4J9lEAznlPM+C4Ed8DAkkRCEm7yxLA2fLsQuZNHZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8388
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:10:39 +0000
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

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/accel/rocket/rocket_job.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 2f1861f960cc..8619981782ed 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -457,10 +457,8 @@ int rocket_job_init(struct rocket_core *core)
 					rocket_job_irq_handler_thread,
 					IRQF_SHARED, dev_name(core->dev),
 					core);
-	if (ret) {
-		dev_err(core->dev, "failed to request job irq");
+	if (ret)
 		return ret;
-	}
 
 	core->reset.wq = alloc_ordered_workqueue("rocket-reset-%d", 0, core->index);
 	if (!core->reset.wq)
-- 
2.34.1

