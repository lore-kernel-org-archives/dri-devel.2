Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F513CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 17:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C191810E4E1;
	Thu, 21 May 2026 17:40:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ldRWI1jH";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013029.outbound.protection.outlook.com
 [40.93.196.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F18D10E4E1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 17:40:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UcASjQWA7wVcuZen/OUTdHNWBGDJOAQFabJwngt2ULChD8YfhkA/DmWhbbIRfktMTLjGe/Y0QAP855qaUlxsvhwkrdAqwJxAftkD7HWzCpRB5mMwiL0L9gfXXDSiVqghic4CMyc2peMDIJuF+9DY2h5rbx6IN7pk0u2zsWvzKMocfA8xUFmO7oKvLUUCpaSPgLhzV7OlKwjb2USAJ6JAG7v8HnCzCk/o7VMiClYOblWY3z+QRBX/XxB5V26smz8vLtElOYlR4TksWxvzEcJ3LAIzOFxGJj4IOOnxjaGY/E724exI46nwLT9qClmk8W4PenmJ/AEQQh1/IGOprpQ2bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tPlPuw0+nDEoUPvYkbFXLbiQb5ACAIEIl0kjGjXCbQ=;
 b=kAjqtHhBKgJJdBQACgzFF58hMGxi1Vdlxa9SHnG5HkAexQMcQs2LofnHOioGgZGVTCb+mSJ2qM8Gdh4QHmqOpNYWEbxm5qf3hByzDTsHmwsBqkW8t4eD6K2NVKksbLnt75MeZfLMbBOj7OOHnnaFlX9d2pNnJKpkSua/aYHaMKlQYXrUKOAR01mT8SC9By1j30nDOYvPYoq7b32h9UBP0SdG08whgVvSRQVwlfWGzh3o2FDpk2vhVkkMS24uQApg/9ej6v+MYhyUm92d7vEZpzAUAcCl+rEY+ClQg+DLUy0PKrgqroFBWdK7pK+q1SdrJ0mdm0nKi1440U1nc4b03Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tPlPuw0+nDEoUPvYkbFXLbiQb5ACAIEIl0kjGjXCbQ=;
 b=ldRWI1jHpkO2VmvFBoFZZuX9+/GIC7K9+xtNU9CQ/xtQvst6IsyE71KHXJ9lMVDBSWXTUV4lGMuHzuJRkPVXCLBF0adiFHZdYOkT82roIikMEGnlwouZveEP0GyAKb2rf8NKmHFK8rr1GezvFOyiDIpozMsXit55NpDfgE9eP0M=
Received: from CH2PR08CA0010.namprd08.prod.outlook.com (2603:10b6:610:5a::20)
 by CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 17:40:46 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::a6) by CH2PR08CA0010.outlook.office365.com
 (2603:10b6:610:5a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 17:40:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 17:40:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Thu, 21 May
 2026 12:40:43 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 May
 2026 12:40:43 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 12:40:43 -0500
Message-ID: <5ff41dd5-a583-da76-76be-2b70365a4cbc@amd.com>
Date: Thu, 21 May 2026 10:40:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/accel/amdxdna: add debugfs support -- follow-up
Content-Language: en-US
To: Md Shofiqul Islam <shofiqtest@gmail.com>, <mamin506@gmail.com>
CC: <dri-devel@lists.freedesktop.org>
References: <6a0cce2d.1abec865.8b8c7.cb2a@mx.google.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <6a0cce2d.1abec865.8b8c7.cb2a@mx.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|CYXPR12MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: e780303e-385b-495b-531a-08deb7601587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|13003099007|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 9L9OuZKy8KCBatNAUWKNQyJUZWdC5NipOQHyejO0Dz/JEL6gkrU2NO7pSuV922IosX3Pk+WmvnORKQyHwcaPUc+id+npMh9ZWGn6p+xu+gIYDSBRdi8VlsAfVTQ0JWGOMOp0KsfcIQn7iwniA43H4WctL/f5pH9FXeTbIjisF8CJ4u5SDCkhqLiBWzVKOGguMVkKrkTX1Bo4kGJR27/8M0r3Zf0gIVFflDATKF5NVEDGDag9MLe0zEsNncheYPq2x5LT7dM5PipCCWGrIzgusrJLC+F1jK/oBc6lqVUgU7aXawXHYAn24MUZnMGnXJM0uep9n2RY9Hi1yIAPiwwRN0fjI5lXVsFcZGkeEmKi8TsEgIi8NuZZO8Lz5oy8zGRLHhu9lTnHYCJjjyeIkUcmjiQRMYIbPmcnmIz+TcSZ/qjkkp6k0nC9p4TIquJpFx/Cn7+tC+oDmbicwAzJOXFNezT5mwWfqBrzdwUcmv7rKnd8dYCQzBnJkmFp8YVyCNvbzT4/m4la7bOScZQs+wHS0YXJCAL5DyzaDrBaU5/jM4TdB7BwqbQrlasEJh1ybtx8WusvWqzWP2NPjRUUoUs2mOXdWFRVITzO/GZqh35X/xjhfdK+iF7SQwBzarWebW4+ebOyXNx6uRtBquwYFIFsHDSz73sJnG7ZvfY2dhzzeKiO8rUbOSa9Wk/GESKmXhQkiONyBToQlfg1Bh2631r9Sjkmdt2jw7nke1Igpflo8pY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(13003099007)(56012099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +Kl3s7r+5JgsoMO5JaGibndHAWGzc73YQHX1MTQ6uKROZTJ/lVz1m0biRivkM7vkyUxmw5IwtgQI4zIX66U2ouIgxFZTMFhKYMz6A2vkz189clm9Sgy4JzBvPVkvKy7UQwNfuDWzBJsan3T1M0DaZWPCbESrXd+xM3PN1OgOCMZBm5gIKesIzBmRBpgic5LHHgeDmNseVzop6BSq66uMPAzBgvyVC+PCG/nSQGU13gT33R/00/pTdOE0dTlX2HCupMfRqtrpT6kpc8wPTWNR5FWc2lscVMf8WXX8XL2bIwYrVGrF+1ea32Vrd6Z+Qru5w94aiLBVWMcdp5vxWoHh+btajsNYh6Re4PI5yTDPdIkpXwS2C+6u7n4JoBKwtDWE7bKpdlmM62a5EhmdWign0n4bwWsoE+AlaDeO5tq9bT/2Loxja/OZGw3BysllCKkE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 17:40:43.8588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e780303e-385b-495b-531a-08deb7601587
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277
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


On 5/19/26 13:55, Md Shofiqul Islam wrote:
> Hi Min, Lizhi,
>
> I just sent a patch to dri-devel adding debugfs support to the amdxdna
> driver (subject: "drm/accel/amdxdna: add debugfs support"). It resolves
> the TODO item in drivers/accel/amdxdna/TODO and adds three read-only
> entries: fw_version, device_info, and clients.
>
> I'm a Linux kernel contributor with upstream patches in IIO, ASoC, SCSI,
> SCTP, XFS, and power supply subsystems, and I'm interested in spending
> more time in the accel/NPU space.
>
> A few questions if you have a moment:
>
> 1. Is the debugfs patch heading in the right direction, or are there
>     conventions in amdxdna I should follow more closely?
Thanks for trying and reviewing this driver. I replied your patch.
>
> 2. Are there other known gaps or TODO items in the driver that would be
>     good next contributions?

You are welcome to view the driver repo for the new features, issues and 
discussions.

https://github.com/amd/xdna-driver

>
> 3. Is drm/misc/kernel the correct tree for amdxdna patches?

Usually, the latest upstream patches are in drm-misc-next.

Thanks,

Lizhi

>
> Happy to take on more work in this driver.
>
> Regards,
> Md Shofiqul Islam
> https://lore.kernel.org/all/?q=Md+Shofiqul+Islam
