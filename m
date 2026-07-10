Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF6DC44509
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F71210E7C2;
	Mon, 13 Jul 2026 07:10:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.b="BS3sQXSq";
	dkim-atps=neutral
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11013038.outbound.protection.outlook.com
 [40.107.44.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E2EA10E186
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 10:59:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+2aXXnP8yKAo0qhoXKT+aDcDvdViyRTJcsY7kit/DTJnh+qHgiimV+mCI5fH7Z3BrMhm4C67KpEsPTbZsXV14a3dhHVVVTAb1vxcgYCmC52eMJgVOKhuVM7fOD7HI0faJlFp4gZuhuIi+APzOG94Pn5rCUeRQr2S4SWCpn1wfpsKzvakqAPJnNbWk9L4lseP8o4Df6VUQRXrSPilTnk4sJwplrKt/GdRrTMUTdo0SDujvnhBj1Qwh/T4MJ5u9ZRxOo42VlmTSmVYmP7CgenUXe9AO/x5DZMxu1oatNr6WQA65qqcynErGkOTp2vPh8k8bIbtBxtecEe+WNjP7oV6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjvKIEs+wxGsft1fGiF11jff+ceqewDLz8P5yL+gcRA=;
 b=O9xv4BaPWjqV6HI4I78jlnYIm1TPLG1mUUTQ4C3bArgZYFmIMI81fi2gLdXicCWTyf4rBUDYCiYMfWks6QD1lG1vTf1qVEnzuLLKyk/dYo/GaTlCJi2KBWJZGlht/uRGAGjKwv0S/k3uixG7wvoJFu7CMRayagY+gDgxvkXtKCXaSAz2Lbrx7h1zbrh4K1irkqVMgclVMUUjr+PZYYrwDRKmDzvTY0gMWJftdZhROm+v9ELShan8THp42n8u0l9tWjBIjrgC/2y2OVx9zeaUxpGy6cSpuKymrf2+wQHotcDbsihl8JuZ4w91LXMWRZ+DX7CVD6QtQdl888AK4zp/Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjvKIEs+wxGsft1fGiF11jff+ceqewDLz8P5yL+gcRA=;
 b=BS3sQXSq3FD0BIO2v06MJgfgKB0CsN6sr30UG5A//QeY7u88cnjpQME7xmNvjfJx4xOVBaZKLRXc24YxmxKI6qyYFX/eJ+emkzckCcIVh/WDZtq7mm9UuNo8zTLllVNaTTMtWPRx++APoNH7I0n0Ggd1zh8sZamEk2p2637m1LQ1gRiwjU6+WxMgOLSFOQsZmFFbt2WeDCyN1I6YiZ/2cbd7j4Su5zd4IflAMSNvVrGkWMU/haGdC2MA84vLFHGKktliVJh01cN4rizGycaiigfmwZB6AmgkyTyYpuhrs77b4AQJlVg6OS6udjAcSrUWJ5Ux/0UmzMcrX5EzhaYDSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KU4PR06MB8388.apcprd06.prod.outlook.com (2603:1096:d10:7b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 10:59:51 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 10:59:51 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org (open list:ARM ETHOS-U NPU DRIVER),
 linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 1/2] accel: ethosu: Remove redundant dev_err()
Date: Fri, 10 Jul 2026 18:59:35 +0800
Message-Id: <20260710105937.409992-2-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: cd44fbca-132c-42a9-c019-08dede725d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|52116014|1800799024|366016|38350700014|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vJqCU5hak65WEL7aQhFc7Pg4QiOD+rjYhemutUdtd67cUOat4kTbit3k/g69tTzz8pQAqCEMkm8Ef8ZDcOhG/C/MV3549mbrtn+q+pBOcYa/WX8NdyqmJ+XwaM/Ag9X4T8Mp3W37oJye9Y2o4DSD2eYvqh1+7Dyo0hRIPuor6S5L+1Xb6vHL10sI6LNtwH0dt3wYxadaQ0WZ4qmgBJao47c7ukzI9D7Is+dSePxk03pJtePZUcwL6rd9h9IhmmZR21Ljs1n9kBK/qas12Km/0Du7Qjg24Ot4BPSbodD5ZoBPUj+ZlCVX1ktDdREbPgaujj+RsAZc6qD6Oio9+o811E2ral8F0P4FZeoPqAsPh7WY2eX4y0XDFIMO5StY7ZRwmKeRoPWa/y+aPRbpNro7xqOse2Ri9xYO9qcK8uWf1Q/Ob4L+yml24OJTPU2ikd8kzndUufm1RjEGDL8UGL1Z3l01Y726LGo0jZyUaO1XBf7dQPfuuCiDosU0QVO1vEd5CBBg5ziMzRjesg7vqMXSTNYlFEuTBU6zd4xCIQIk+NB4X/MBGDR7OAp9+Dii4EL0uzO5itmq0ggXqW0y/EdEeT/kCO+rw4UiWE/9NHv6iykXA9iJ2p410d/hMX+ulpuR7H11Hr1sTq9w75hCV5cM00gwiFP8v2pJPHaYIXDSoJxpHUrH+Nij1QSHrthV/F2oBr09jEY6tamzh9lO+nszI9oPpqxX5iE7uIlg92VJC6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB5832.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(52116014)(1800799024)(366016)(38350700014)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JitlJuY7MYBVa/CUC7qtoZLJWzJj3MZHa74om4Yevi8idXpu5yHRNiQoT4Gb?=
 =?us-ascii?Q?3Agsp1M58GlyZOsz2WyTookfuOfq454znR/H28zYLJfHL7VGUWNHfXO1VsE5?=
 =?us-ascii?Q?eLYgVaEHOG46qX2cZ9KN3GZ8JgJEbwNGadQiYATNRnR5gTPixqIAxdVHki0F?=
 =?us-ascii?Q?tavvgFIG8YY4dXk+plqocZv+QA5rOPkwZvDSruDmXG1GVmGyz29MaD0QxZOP?=
 =?us-ascii?Q?FD9ME+V+/Zf0IsDPWTnICAtO8OUNypB3Z96LJ9IEkW3GKfk6e1PxFSit/NcB?=
 =?us-ascii?Q?G338yp89+eH6AO1qLVdn30Zv2U1hmXQHaXe5yDCZcNNjTDxHXjERLg786sQF?=
 =?us-ascii?Q?MNuIy8LmWTCFuOUIpDDRwiEw2C37gJPXVQ2WJ726yntQd360oqsCeKrKp9ix?=
 =?us-ascii?Q?tzqR/pWjW/Kodpy04tH3a9Cu6OOKiRJhPUwpJmb062gHAu6oqqa0fZVi/F5X?=
 =?us-ascii?Q?7EoYzVH97d6bc99AESK6Mys5XvZxNsVMJ9gVouFzBwIq9rls+L506aHjdaJd?=
 =?us-ascii?Q?MYGrBfm8svNKO7OONIv8Ux/NqOTUWTdAqdj3zptdXzHkF98ooSkwZU0QcRoI?=
 =?us-ascii?Q?WW9d6LLB9j7zsoHT/w6gQcqCuCcCE+YyZEPkzNvVP1eo37YLHmhyU9f2NJpm?=
 =?us-ascii?Q?R7PzLXQ6lXElttsssSSO1rLM2sThfjfzfAyFXy35pUeX1cJLCwzz2F/Ld27H?=
 =?us-ascii?Q?6pT9JDbHlS4O48xQl2okHWBFLbQQUtS9fU/3hdAVZjK5xEcO+efBHAfnMSCG?=
 =?us-ascii?Q?nACP+N7IHufyLY8JkmISSqlJIU/a1z6SrHSkRgK+BY3K5fnpbt2kuKqhzUMz?=
 =?us-ascii?Q?NwfPwrm59iW8GCXw6p0B8oeawqBmRKQpNxqKwiNVn5/geMeoNLgzCaQXUiD5?=
 =?us-ascii?Q?NXX+EIhfeO2RjG6qxcgLfonXwYM+rE9TAvrhrqPKSucjukkug3Px0oQBfEen?=
 =?us-ascii?Q?JfNcGXP4cgWABGE13wOrnSImwE+fiOavlfDWZqOJsYUZLGNkuz6gXPLFtW+Y?=
 =?us-ascii?Q?IUwhMc3UyaeN0Xg9v0aoDU2HMdxRauoaBooEC3oNytlMXOeoJ6GXfmEBW0ps?=
 =?us-ascii?Q?D5Lzq045Axn2X+XKbtz+3CnahDeYQTdS4+HyXHESLa7SR+qbj+AE1Dx+BhSn?=
 =?us-ascii?Q?1S1IGRo+UQF5HXhUsGMFs24/BLDz/kguTsq8COpNKeJO/JuyHzy0OcwuhMNP?=
 =?us-ascii?Q?tEmn+UmOq79MowomA11aB7B5EkMgzcTslZu93pWrrzkcSuFwBPEFGnyzE2bE?=
 =?us-ascii?Q?omptJVaXRtVBO1GDtusZXpIPDGLw5FV8CbmbUYNsD1pWzp+N2u5IA8tpCOqb?=
 =?us-ascii?Q?DgoXW5PNaN6S9l05k4tq9lJ+1MFyTjzWkorlyzupCCSicg9iGbgYal9Vf7NF?=
 =?us-ascii?Q?d34Qqw5Vv40DRqltyekhsdImPfBKhclD6BDRJwAI5at9a5Wo5OvDKOtkiuzj?=
 =?us-ascii?Q?ZI8EZeW3soBLjrGxMbYIgaD8ZvbsWvh1TkAp7cXge1PM+9R1Q64xWJPCIczA?=
 =?us-ascii?Q?nlk1Qsih3LDyCq4biAcp/GfW3idUBzir2LNXsw2tGDIcrC5R+RLv5Zrf41Dx?=
 =?us-ascii?Q?kcvboKi8gvppfUOpY4nX5/XjSVGn7f2ct95XBXjsO88o906N2j5aBRm8xKmu?=
 =?us-ascii?Q?W1U2ZSOLP3BlMJof63QbHO1d2AqM6ldTyNH+NRiTQfDM/0kyXFn0vwu8k7ys?=
 =?us-ascii?Q?xtxQRCmkclYxtdW/5J2DMunOnlGSpNu1vPnXiDkbAvPwP7HNApq3yrscv8xx?=
 =?us-ascii?Q?RnRpy2qbBw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd44fbca-132c-42a9-c019-08dede725d94
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 10:59:51.3523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrgwMxd9yryraQNmTjTbv2U37LzYKuv8hLEPRcHqd1bDvTu0/QvDwfgNNTcgdYf73iaGhUB8uZaa4uXSf3XvkA==
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
 drivers/accel/ethosu/ethosu_job.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
index 74f3493fb11a..cdc0d61ee53d 100644
--- a/drivers/accel/ethosu/ethosu_job.c
+++ b/drivers/accel/ethosu/ethosu_job.c
@@ -338,10 +338,8 @@ int ethosu_job_init(struct ethosu_device *edev)
 					ethosu_job_irq_handler_thread,
 					IRQF_SHARED, KBUILD_MODNAME,
 					edev);
-	if (ret) {
-		dev_err(dev, "failed to request irq\n");
+	if (ret)
 		return ret;
-	}
 
 	edev->fence_context = dma_fence_context_alloc(1);
 
-- 
2.34.1

