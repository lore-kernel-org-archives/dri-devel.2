Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757F4C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 17:49:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E07110E143;
	Tue,  8 Sep 2026 17:49:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rS5Vt09X";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011061.outbound.protection.outlook.com [52.101.57.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EDC110E143
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 17:49:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZM0K2ouQFpFcLXxyY16NrBgJgiDq7cHk8BDRzvoP2JpYdGgcNqVHwKG8bETDf8Bf73bgLfBL9XY0oyac3Z3WE/yPeY38F44sizn50nCes8tlMzM9iMVwEsQqJR0v+VVSMNOXrO5amtPrqStVT98HJaKEoiteTGthNUMmRC217+Qgq08XL8G9FGXr2yNBL1/Pu6pMkhl82j1TjGDUyBRYnIaEhBaxWRpGDkfvRY99Q3aAYe9o72JeRrNvh2amKw8GJ/krUAHMQs76cM47Se4+cYaYNDjs4bHW8anvHo6hqhgN5i76GuN9q42SkkxlhlZYZtWdUtrMoYGqXc+5Yi/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9cw8cbQhT59sIljmtQrf7wIbKIBQesFFDAn5VxKNFQ=;
 b=aUlpto8ZIq3ahyGzbdGw8CdlTqHnmTsWY0NpaYyA2E5jEqWaLx+rIlN7foD+bIMCJX4oKK+JGlW4LT91ovJSgXMItJ7eBuby80TKhBOQ86r58I7hGGyb0bH0vmJ25X7v70fuxCfjmKLp2vO0D1q/GrHp71M84FhjhTn4FvaUSagaNLM5nzLIcaAjYLuv4QRCgQ1cROJFKU/7uD52ByUFUKZQZBIAdNk8P0EFRYX9Dal9DrQNoxleRsq2g9WX+Vh3BlxH26aaNpBgUgkx+gbRwf+w8e+gLxCsz8X9waA/SgOxrekjPGfmO8oiR8CAhaRWt35h1yFwxccxDrsysNlJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9cw8cbQhT59sIljmtQrf7wIbKIBQesFFDAn5VxKNFQ=;
 b=rS5Vt09XWhSTFy4gehKG5isYzP9GtFGIMeKLPIq3J+UvIabp0PsICKFAUZ0YLE9XYi5bYyOs0f1g9qv7ve6hy3Gjav2afa2x+UUsz2s9nliEB++6a5ifYTqzacVxvE7sErMOQy1vs1+2/opUHEP1a7gUkOVyoT94Pl5PIk5Axz4=
Received: from MW4PR04CA0372.namprd04.prod.outlook.com (2603:10b6:303:81::17)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Tue, 8 Sep
 2026 17:48:47 +0000
Received: from MWH0EPF000C6195.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::33) by MW4PR04CA0372.outlook.office365.com
 (2603:10b6:303:81::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 17:48:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6195.mail.protection.outlook.com (10.167.249.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 17:48:47 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 12:48:46 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 12:48:46 -0500
Message-ID: <ac5833e0-aebe-d60e-5fb8-782398451673@amd.com>
Date: Tue, 8 Sep 2026 10:48:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [QUESTION] accel/amdxdna: AIE2 maps unspecified QoS priority to
 PRIORITY_HIGH, AIE4 to NORMAL
Content-Language: en-US
To: =?UTF-8?B?7JWI7Jqp7Zi4?= <nanhosoft@gmail.com>,
 <dri-devel@lists.freedesktop.org>
CC: <min.ma@amd.com>
References: <CAGehT5fQWOXgftdfmq+GDZf9wHJacQ_g93iKGRKvsY0Dm0r0Lg@mail.gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <CAGehT5fQWOXgftdfmq+GDZf9wHJacQ_g93iKGRKvsY0Dm0r0Lg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6195:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: df617d11-ba96-4191-5149-08df0dd16f2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Bxx3eM4GstO/A7wVAJAG2YUnJYoTO0dr358QUNCxhuhthrd2vvWt7Hxwt9PhnomNIUMCBP2E71omhDF2MlfyDip5cqYpvBdxKA4sHWloxqiFWFxPcnBFZ6+Hf+eCIPfQtkTL1rcePxrdVDu1j6bjlJIP8t99rQc+fi9RAWolZwdkVRPSvCwltdb94YNJT2T9djBeYBgCJ6mBn0xFd0FXtAmkad1y4KSOdRpfxAkHsk1FKIs0QgPKq8pzhOrL4s70Dk2HdE6IxjFSJQkabFcmf1ntuQQ2nF2THGnlAQZkNA/muLNFk7r5Yf6xeQ6JRi1iow2K7u3Y5+ZIzXRaXJ6iqKkPjdBG2KZokGmZTny2o8kMF8F6GYyGo5i4ndSIq8Qvrzn9Hd8Ge4j4ksoCkWyYn1FKCfBYD5fDATFqEfdYL1L0qh9oWqxRNu0uaL9kNeqROgeqDd+87thLqYBcQzE8UABwQiRnRHjpGqjdENRlo1Fi9nXlkJdy3xas70q5U3acVldZD79r3OfYqZUeMgtnqsruE8Lb1qa4cDmrKgYdi+Z5uL+nwmgSr7c52M5Xret/RtOEWYNlGVRBoWUCKiHrXqlizXcvaQaxSPKAlSJFcgHK7NJF5JfG8a2M/VlpUN8BkOdWIoPeO+l3bCpz1XSa5j444SrPg/JoKD1hho7uktanuNh6l/cGCmrf9S6jtzZOgCr79r9/C2RHQ2EDFowSEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cL7rDCjNIesmFSHE1qxDnE7Od08y5U5Kx0QPs4auzMuw8semgquTyYsSp5O5i5XNyEqR5Mh1HKW3IdVNZZBcbcmB8I0vHacsB2lSUdHEeRcWipI1ftxnsSpegWcnHDWy6+n8er5bCuxUJ74G7hr0x5fxqCYF4GagEKZqfo6jG/QcxMUVO2Rw9G0a2Q7//6bn7Kfz9bInrQmgD2H2NZ4bqADcCoXSQcoN+36tF2755yyrMyJX3kUGQXHhUoKV2IEyZmasbygY4tGUIJooMfDdQLYDOyuxSvSIrZ9W1LIEYK+GJ4ngbEt8yFP8Z7aKLjMlvoEdBi9w5W3K5usN3RDyguzMtKyMZWN5/wKRJ2/omPQO+Npk9CljtwMSt7kR9Kpf1mXwGDbDuzDTER6eo/pIkzr+gFDRKBPGDDkyd8lXLElT5BFEkDUQdqfqOsz+8lpl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 17:48:47.3013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df617d11-ba96-4191-5149-08df0dd16f2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6195.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684
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


On 9/2/26 22:48, 안용호 wrote:
> Hi,
>
> I was looking at the hardware-context priority path in amdxdna and
> noticed a difference between AIE2 and AIE4. I'm wondering whether this
> is intentional.
>
> In aie2_message.c, aie2_get_context_priority() maps a qos.priority
> value that matches none of the AMDXDNA_QOS_*_PRIORITY constants to
> PRIORITY_HIGH:
>
> ```
>      default:
>              return PRIORITY_HIGH;
> ```
>
> The function also returns PRIORITY_HIGH unconditionally when
> AIE2_PREEMPT is not enabled.
>
> The XRT/xdna shim zero-initializes amdxdna_qos_info and only sets
> qos.priority when a priority is explicitly specified. Thus, with no
> explicit priority, qos.priority reaches the kernel as 0. Since the
> defined priority values start at 0x100, 0 takes the default branch and
> the resulting firmware context priority is HIGH.
>
> For comparison, aie4_parse_priority_to_dev() in the out-of-tree
> xdna-driver maps an unrecognized priority value to
> AIE4_CONTEXT_PRIORITY_BAND_NORMAL.
>
> Is the AIE2 default intentionally HIGH, or should the fallback be

This is by design. The firmware running on AIE2 and AIE4 are different 
and they would use different default priority.

Lizhi

> PRIORITY_NORMAL, consistent with AIE4? I'd be happy to send a patch if
> the latter is intended.
>
> This is against current linux.git master and amd/xdna-driver main as of
> 2026-09-02.
>
> Thanks,
> Yongho Ahn
