Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35361606A326
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=w+LYlzeA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BFF510E957;
	Tue, 10 Nov 2026 18:36:12 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFA1710F070
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 18:36:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/wjZs8rLRN8i9yrf+bbjmMM1PIHw8Rxsl9jR6wQ2hWKSutiu6SrIDKPiq1y4CaX8rkRHDXBHJWxdgEggaNjsGiwU5ahUzUaoNfYA2Bld13mWDwtzNfqA3UTtmX12izdGzI9EfLCpm7HBft2JNrKU8RszXGSpKpotEeQSn5D6wTisn4Uguv11XTRKfurJC0VtX4nK8YEJXXvEeY1tr3bC4cW/zkUX2bjjzfhuxzSbLQhNAMekWNBb9vx4mVV3ZNOmecEj8Ia14ywFxWOfGpFRFl3BpAKd8dZV3IyhddIaxjfhae44G0/ob4aw7tz24TUOXQP8pSOUGB5LnkrBASwAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gX54iKe7U3rHK7fz3Yv5uuHDS1kraRODZUfBXc9xtno=;
 b=QLFVBwKmJyLmdoM+v+NkycEDvGA7/20Faec8ULrno7bKs+jIWVejVIvktn8XokmUP6mX6ydgmDRHIwvd19eYwWIlDWSclQWx2Loe4k3ix4fP/WttsYMqSgV7zddRKK1/V/XfoR7ek/DnSKYJLccrlZB3O81533Cr56XyB2oDuT3raELAyfVcRySSbS8xzNJpCFsj5IECUYQvlMol75Fn4ZYGiO+OSk+NzgX7iYScLsTUxB0kECGCKc/C7I4xBODx2nHKxAJMq/5ydeGtwtBK3kwMgnZuY4iFPxXxX/d+pepR82dCtBjGhnjijzZGlkZj47/JvmEjAeQDhdQUFby65Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gX54iKe7U3rHK7fz3Yv5uuHDS1kraRODZUfBXc9xtno=;
 b=w+LYlzeAn+qLdQzLLDAmOKJoAEWdoQ0wR+3B+O2RmlkIWyPtJv5vuvEZNmGg3N8/GRyKL8KYLM9VICh4pq9T9NMEaLUlYxP4u8WQyU8eHRC0ZrK4128FNwDOhqjeYzik7QXVs/gP0w/TJPmoKZNYei3dWbkoEQyudnAk3qpM6Ro=
Received: from SJ0PR03CA0077.namprd03.prod.outlook.com (2603:10b6:a03:331::22)
 by SJ0PR12MB6941.namprd12.prod.outlook.com (2603:10b6:a03:448::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 18:36:01 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::7b) by SJ0PR03CA0077.outlook.office365.com
 (2603:10b6:a03:331::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.11 via Frontend Transport; Tue,
 10 Nov 2026 18:36:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 18:36:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 12:36:00 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 12:36:00 -0600
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 12:35:59 -0600
Message-ID: <83a0f138-8692-62fc-8d27-b3b6b2d25d4a@amd.com>
Date: Tue, 10 Nov 2026 10:35:59 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND V1 2/4] accel/amdxdna: Bump driver version to 1.0
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>
References: <20261104224302.643329-1-yidong.zhang@amd.com>
 <20261104224302.643329-3-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261104224302.643329-3-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|SJ0PR12MB6941:EE_
X-MS-Office365-Filtering-Correlation-Id: 13dbdf2e-df7a-4199-664f-08df3f597837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|4143699003|261102123227099003|56012099006|11063799006|261021121427099003|261021123027099003|261026140227099003|261022105027099003|261009223027099003|261026121527099003|261022075727099003|261028144727099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 2nUS602/ZelUg6+45lRjmL0hdeWzsE/r4WrTpIJ76UgYXF+tgHn7F1deuf+wJHQxQTgxOMf4O7Fe5HQPDmEeedD6KyOUjY+W50FibkcsxK59OswIRV4DrvWj93tSLDT5+Y4loeyuXqxiojDkGrzIyNqBhZv5Uc/iCkZJ8zIZgN3i6dlAzJt4MhBhU9iC5gX1Tp/JXx8J62N2/OWn/fnQ88TQnIXxUbLJHLiWrjBSA2iOzP1A0dBVncK4uCf5sj7XwravZFYb6+bxEHGip0yJvHgU4EW2MGckYvUvAKerAD+07iN4tF70nBj1e67W5jRhkR2B/RK80y1GgywzVQSygnoGZHOusVwFn6Uylx9eVg4oXafNd+KDYlCN72J1eN4mo/tgSIusXwTwu4o6MqIQjYk1mASNA/CqX16PcERrh9DHwxla2orKYR/icbZBONfrQn85xUpG/nyiqTdD6f6Jw+Q6lVlBdTYFygG8Q8IBrLdcLrXOt4XpDgK6eoiIwj1SenjLE0UdP5g0a4NrZlvmIMXLZ+/qkiz2rjaaJL+sYJmLosdSEL5wvzZ24auceAzNhfeJGNq5HftO60+6IgjWGXb2wYHHeaIvB4iDsdnt5RwZqWzKduD+Lg7kPP/xWBNpAqgWSJZCCN4WyAcznJKisGhqlkApba/Y7jwrj4B7x3hG3p2iwAHIC87LAlTrpHf5I9Xukpofe8MPitTw6LNe8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(4143699003)(261102123227099003)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261026140227099003)(261022105027099003)(261009223027099003)(261026121527099003)(261022075727099003)(261028144727099003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8s96BTzcIEQJByVKCNBiy6aHvjOoAjYOSZUcdYtavwFyEIHYcVf3VO0O4PR/bvSEECoU7PhDDr28DoQz2TqBuRlcyz/SI8MYvXW0KwcE7okrkuoNCQ4WEbBKsHAmg0iECReCONUgmtRQj/9jzZgTq8lORJJiQE9d/54A5X7emIxBSRiXuAwaTiV8Fh2sguWgDYksQJhFqv6JHTLxm2jzN5NJplVuCAoVrjFYyKTiAMSpvS83glE43KnQzmIjMy6c2SbZ6/ZdnjbaMgZdUl8Z2m8Op8t7+gyOjI6YLaxYi++aGjTfESw7tgReaLlQ8Xf1qxlESKdXHyewmxL2d88mrpmSP1iDvBXAfNeS6S7s5cUm6SkhoJ9wsywH4uQ2kNfmw8OoS7DMejkVyG75uWPFEmyNnnL+NqWrchykp4xTUGvUXHzLldEnY1cVEZuUwjH/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 18:36:01.0316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13dbdf2e-df7a-4199-664f-08df3f597837
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6941
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
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/4/26 14:43, David Zhang wrote:
> The driver supports AIE4 devices for the official release. Bump the
> driver version to 1.0.
>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> ---
>   drivers/accel/amdxdna/amdxdna_pci_drv.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> index 685fe1a7dd56..0dc156a1c0c0 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -58,9 +58,10 @@ MODULE_FIRMWARE("amdnpu/17f2_15/cert.sbin");
>    * 0.8: Support BO usage query
>    * 0.9: Add new device type AMDXDNA_DEV_TYPE_PF
>    * 0.10: Support AIE4 UMQ
> + * 1.0: Official release with AIE4 device support
>    */
> -#define AMDXDNA_DRIVER_MAJOR		0
> -#define AMDXDNA_DRIVER_MINOR		10
> +#define AMDXDNA_DRIVER_MAJOR		1
> +#define AMDXDNA_DRIVER_MINOR		0
>   
>   /*
>    * Bind the driver base on (vendor_id, device_id) pair and later use the
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
