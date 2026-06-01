Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D10CD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 18:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53154113753;
	Mon,  1 Jun 2026 18:41:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3OsGwfcO";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011023.outbound.protection.outlook.com
 [40.93.194.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DC8311375D;
 Mon,  1 Jun 2026 18:41:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWOudtHNAQx3LLXi79CDvESE5CsMbA6cMkAvAgo7giyYUxRv6ESIM4XC1aXIVqLgGwu6RgV8itbExXcOW2tCvuZtpiYDUeoAEtBiX6RCMC+/ktCeEP7UvCWe1xzhzjH5C5VMnmowM6aHkn3WJJqVApJp0qEtoHrol0NMw5k1htwSCpmYVKXW8LiyM7CDQGYdcZYDXhasnUKzOwvAXybBn78is059kkoVdd1iQRtgtBYCoM9fp32URuGShj5TA6ZyvvX82xFFZHv+jWf/y6CN0ZR92R/removGIbcY8lYW5DJWUCE/sQ6SwXNtZWKs9P2IrrsZw0UtykNmutcPmHrKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41qPCiRQ3B5gNPcP9bfTRZh4iA3eyqJxr0gBesXyME4=;
 b=Ni1DHH+IeIBmH90dmGL+XXsah5K2/WuYxPpAK++b1TiqflHLh8aBgaY4Bs7CTTcl9gGjQiPjpygbpAdIMFJJIo8w/dHffstFFoxYHRdWaW5JjR24sD+1FuzXSuyx4FBpUQzq4NHS7J6HBeOHrL7gqjVBfeI1kyyFR7MttFTlmNkrudKsT9yr1e+YCmicDCQvrzRhjyvnNC+QQtvzJN0CjQN6tiWUt94XbIP1hNYq27fxXQxUr54MtPawOBZe7/sFFJrSCN6XOCvslugthUN3DA+x14b6H8nsdczUwV2jNTWOwVq2Ky/JBA9I2Jgp7aVpJKzNWrD6lgwYprpQx0tstQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=mandelbit.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41qPCiRQ3B5gNPcP9bfTRZh4iA3eyqJxr0gBesXyME4=;
 b=3OsGwfcOHhyDk9auj8x9ftpAhE5xL8haroXctRiwYzdSbtsZHGltL7CVdgAiBlXa/9j393u/d2V1DRqYRMnFMLqdGtj2Zpy3d3t1plqaiRM1tWxmZ0/XNx7aAnjVoSMH0NfFejk8WwC9/JB2+A7WYRYMPPQJ74/qL7Iq6BiOBl8=
Received: from BN9P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::19)
 by BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 18:41:21 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:10a:cafe::1) by BN9P221CA0014.outlook.office365.com
 (2603:10b6:408:10a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 18:41:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 18:41:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 13:41:18 -0500
Received: from [10.4.12.116] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 13:41:17 -0500
Message-ID: <4cbec10c-5d09-45f2-87d8-ff2d19059a37@amd.com>
Date: Mon, 1 Jun 2026 14:41:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] amdgpu: fix compressed buffer config routine waiting time
To: Antonio Quartulli <antonio@mandelbit.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Leung,
 Martin" <Martin.Leung@amd.com>, "Pinninti, Bhuvana Chandra"
 <BhuvanaChandra.Pinninti@amd.com>, "Ahmed, Muhammad"
 <Muhammad.Ahmed@amd.com>, "Chen, Karen" <Karen.Chen@amd.com>, "Chen, Leo"
 <Leo.Chen@amd.com>, "Khachatrian, Gaghik" <Gaghik.Khachatrian@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "siqueira@igalia.com" <siqueira@igalia.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "airlied@gmail.com" <airlied@gmail.com>, "Li, Sun peng
 (Leo)" <Sunpeng.Li@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>
References: <20260519144509.2646680-1-antonio@mandelbit.com>
 <CH0PR12MB52849BD9E94D9290EFB51B528B002@CH0PR12MB5284.namprd12.prod.outlook.com>
 <79bea78e-fef7-4815-9574-eefaf166a11f@mandelbit.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <79bea78e-fef7-4815-9574-eefaf166a11f@mandelbit.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|BL4PR12MB9533:EE_
X-MS-Office365-Filtering-Correlation-Id: adf76d20-faad-42fd-afcd-08dec00d5fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099006|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: vSaIOyA65wJGKne4U+Ee9U/8Xkk0NLbGDmSb5OpczwIYr30Hwh8Yc6kMLb7ThP1wp1p0ZqFQVx1gxZYbu0Kd7FCi+fdycE992YiWQYh7fLN2iebOCFe4RrBj+tBY/GZgltLv/MRMCZPWX0d/7v45lhcfYmSomX1wLrYh/vyj9R6sl3mvIeZgoOMUQ4kpDuB7T725X5AVh54sPYMur1VghBxVCPgTh0+FlS0WytMaDCOF0aO5Wu4OtfGFL7bVU/Myz++Do2QGu8NYaezoTnIBJ3X6Da3apW4jQimIdpJiLdbOZZuiyTqbKeFAlP4Z8bcE327x5F+mgGNVYTkwrVJKH1cw2d4lE3OlfVNBtd4T9fvZO6S19rDv5t7wv4TE1padKcL54DxHUbc5zBagh4RQRN79v7s9/9lWcgPA37w7SH7+mfED2afzgswtFUpFWqRmbnDByM4lXMk2mlmy+ZplQjdDY92IsF0Km2ql98OKrohg5aJTDvxWURBrdLlWrQ1IVZRbzZvi0bzKcu/977cpqnufv0GoejvHCYg6d5XZOLQ9pCAKv9PF7WQZvCM8qErwM5gJehM7IGLEVHWTiSAhzYuFvfMVGl6aXX1h+F5IoSGLghNHwABtCeRv6KQX7IWUlWHgjU6sYtXJPDq+VJ49o4ZQGQaWUrKPoxTFco7IwIfpRkHfNZ5d8rDj0h9Q2xJd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099006)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xguA4bxoy0nafaDu5fWXKwjO8LlxQOVz9QNM81THbCfgxOMBuO+2GsZZqBqDsVhgFlnYNkvMMhOXhzeB+UbAD9ArlC85lmdyTELCIQBUY/DvtxBH3vI3MfGAsaZIBIL8OXD8VN+N5APcI13iw4mJG6CGeR2Rj3PgiYbETwJlIP4LBhkt9DjQjzC41EFNInckLrIHqnc/QxbbowNk6/S0eADnULSn20V6RDsnepFOz1NkdvPR3XilD9Vn02rYNZ4ELXNmWmGoNg7/HW5qs7AconbFZAspzP6Sp8Gs9JhYt+UDRtqpZXTTi14PrkJFjyHipTDLJsrSzWpHHAb1vfADYH5Pc/PJPpz2vHjEGUPusKB8ARhZJo6dM0zX6wklK/0WSJ0vvyBVIfZ2S8P7yVUto+u8sNfO+BlX7ddRmo2uOgLZGJG7oREcKcNf6F1e0TmO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 18:41:20.5503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adf76d20-faad-42fd-afcd-08dec00d5fb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9533
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



On 5/31/26 4:40 PM, Antonio Quartulli wrote:
> [Some people who received this message don't often get email from 
> antonio@mandelbit.com. Learn why this is important at https://aka.ms/ 
> LearnAboutSenderIdentification ]
> 
> On 19/05/2026 17:57, Pillai, Aurabindo wrote:
>> AMD General
>>
>> Hi Antonio,
>>
>> Thanks for the patch. We'll add it to our weekly cycle for testing.
> 
> Hi there,
> 
> just checking if this RFC had a chance to be considered.
> If there is anything I can do on my side, please let me know.
> 
> As of now the only option for many users is to patch the kernel
> manually, because otherwise the video is basically unstable.

Thanks for the patch. We'll add it to this week's testing candidates.

> 
> 
> Thanks a lot!
> Best Regards,
> 
> 
> -- 
> Antonio Quartulli
> 
> CEO and Co-Founder
> Mandelbit Srl
> https://www.mandelbit.com
> 

