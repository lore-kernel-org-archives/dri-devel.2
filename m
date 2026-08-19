Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4E3C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 18:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D68110E18E;
	Wed, 19 Aug 2026 18:36:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zPWXltDd";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010021.outbound.protection.outlook.com
 [52.101.193.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21EBF10E18E
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 18:36:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgXcwmkhF1cdJopzHJC6aTYLe7nukAbpthZbWewYRlJGEm2n8ph1qHD0D3OQknI2dfzEzfk4547V79nb6NV9ahyCUKBGH9GInM8vNuvRZhT5e8TN7p3pvml8+s4rHbe4kQqP6mJer1f+f2fO/u4ifPVbxm2rQhiOrmdsb3KISPNm2qhwqTyaiRrDHejqb4VpcXPuG992RSpZjObW9BlNvtfE+vvRdR+NOaAo4F56IMKLPi+G1Q3WjCXNOj+Totwv+aikqxgZMqnasQ0//kkngJow+lSVnAf3usOiQh6rU3Pg3VC1nZYedHIpWY5Wc1QswkBC5WqEJX2b/KfeRU29ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TO5+8fJI5dH9/qtiI1/uOO7m5z1XMDLMU6sAlFTolGU=;
 b=INUFY7dF4y5VwPmX+bOUxxDmCh5AjhNMxwQrR5p+wiS6oyJMGYCiKaVswRegB3c12zAeNKumfNgeGkPqA5NR+tYHONDNNnYP3Kl8fhnbNM6dWk0nG0Yhblhemzy21NZm3SLn8qQn7qTsxqnk3DEZk/VAu0SHhauMe8kEQwGQiSLjQw+4/m5FZZa+8ju0zhcqUp78MhqaZZp0i7i+dJhLgGvBZxmU2Z3OTOcVjlDQw676gWwPaFBw8YsvqbBTHG9KJfcBnVuXhDrFj+VFLz/MrfBAkjey13xhOrSBQcZbX+4VG29TkRomIPg5k7e3rX9lFjiYJZI97qF5hMjLrFZ/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TO5+8fJI5dH9/qtiI1/uOO7m5z1XMDLMU6sAlFTolGU=;
 b=zPWXltDdZ1VC7lbb+RZcKRWDWR6aL9ZjjoqA2VMhQ2Nwf8ehHAXJ/+uR4lHTpEZEEEJTY3olpS3r41hbRMX5UHBI0CPiJdAu7+1lGyL7+KKpc3bRAEHfGsMZm8+DH1u2zVWREXEpadzTTqBAa2/c0ATAcbD843cxQgUfmWFAd2E=
Received: from CY8PR12CA0048.namprd12.prod.outlook.com (2603:10b6:930:49::11)
 by LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 18:36:39 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:930:49:cafe::70) by CY8PR12CA0048.outlook.office365.com
 (2603:10b6:930:49::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 18:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 18:36:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 13:36:38 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 19 Aug 2026 13:36:37 -0500
Message-ID: <d0ca9a36-41a3-8a5e-29d3-941cb814e539@amd.com>
Date: Wed, 19 Aug 2026 11:36:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: return early from a zero-length flush
Content-Language: en-US
From: Lizhi Hou <lizhi.hou@amd.com>
To: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>, <mamin506@gmail.com>,
 <ogabbay@kernel.org>
CC: <jacek.lawrynowicz@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
References: <20260817230655.356785-1-taimuraz@kaitmazov.com>
 <a6cc7a11-5ada-cfd6-07dd-df3cad271f5a@amd.com>
In-Reply-To: <a6cc7a11-5ada-cfd6-07dd-df3cad271f5a@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|LV8PR12MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a97b96-4e78-426b-9a41-08defe20ce42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|22082099003|18002099003|56012099006|10067099003|5023799004|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: qvzy3V9xVjwdr1JgG+/wH3Z15pMvKrKXbONvtWnech4R/w/GrTMesbd+XrZqLVj8w+oF6/YjdcK4aqSFlltd05sqnniW0SDBOhDEW05zmkGIMRvsf4h3SGRCQ/3ZwoWzhOEp4DnxSkRiyRZ/OxCKgV/ergVcHpP8izuZ0FnBd+ujKIlYdJrKXFEg60FYS9ShsgTExWc5aClOsOKy4LXt3P1OgFQKhme+UOSnHNtlYpsU9fgqu0q0UP127eBi1Ni6V8LnentSB+4PvJtV15YURAztXXfGGhyWqcE9trhOj2/D2gHE4sV51JpPyDb9aAFfTZOZwCUBdlSXmEF4OIDgxGS9XyvdvbfYSFcPeYB7uUFS2pMQJSsDj3hSgwmkGI1k20CHFKXBd2fRuPJAQTCWKa4re9izvubm7ecC4FfDBKBDj5hrFQ7I8X15G4bqJxuzee/iOqXDYOzurJjMYVU83cRnLtdqj6NXwov7ZEAaYFiU9ujS//WvGkwDYzQKc5p8ABHl2/fIf3oo2hSuYRHnfEdH3Lwnls5DkKYDujlpqQrxWRh+c/1DzoQLEzvrf6QKos1KVkBO8GAAmSuWNm0cu2oXGBJDmxl43i3ENBD8irycSbvxSDazH6DHKZosOK8+/u6XJitwIdSDmh4z7LnLUnRAJXIUyJvir7yEJdGHc9I9Mf2gVEHYho7QGGuYYLJdlZu1TWZcmsgUsWnzmPvqUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(5023799004)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xm7mmX6EVbqJgo82e5sPIAqLPgsCiR3bMpz5JJnY7C8zFwkCROFw8zzreBhkh/uEBbJnya7abvSxnQ0RUCloKhpE3FyllxFIWPi4a2G/Uge1DYk5pjo9HPtZliNaJrAq4rGTUXJalbFLh7+RUO92saud11+NGAz80O9yuKxCozn6NQRh+JhRiiGQ3fTzcaRUWRqarmtEgOJO59gdj9GiAYqRhA+nLUV5KWCuNhGCKczhPAQcLqVPU7OXrGp99LtQH/ELt49GPGlaQF6+1qjxnmGbnKvsof51leE8kvmI096a6vdz9v+rSm4UIsGSslW195lfRgntRJbFxZSZ8w2pgXbot0bN+TBd/Zpodeua7765AzDLgeirJbzPfDbpnntKFZ6VNoub1EhkhS3AmDlgHYgBGkmol5+q/g1/KicmsdAOxkzz8IRuJmtQ6yu/if2O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 18:36:38.5060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a97b96-4e78-426b-9a41-08defe20ce42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408
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

Applied to drm-misc-fixes

On 8/18/26 09:23, Lizhi Hou wrote:
>
> On 8/17/26 16:06, Taimuraz Kaitmazov wrote:
>> SYNC_BO does not constrain its size, so a request for zero bytes reaches
>> drm_clflush_virt_range(), which ends with an unconditional
>> clflushopt(end - 1). For an empty range that is the byte before the
>> mapping, and abo->mem.kva comes from vmap(), so the access lands in the
>> guard page below the vmalloc area and faults:
>>
>>    BUG: unable to handle page fault for address: ffffd16fbbc70fff
>>    #PF: supervisor read access in kernel mode
>>    Oops: Oops: 0000 [#1] SMP NOPTI
>>    CPU: 7 UID: 1000 Comm: sync_bo_probe
>>    RIP: 0010:drm_clflush_virt_range+0x3c/0x70
>>    Call Trace:
>>     amdxdna_drm_sync_bo_ioctl+0x124/0x430 [amdxdna]
>>     drm_ioctl+0x301/0x4c0
>>     __x64_sys_ioctl+0x115/0x2f0
>>     do_syscall_64+0xa6/0x3d0
>>
>> Any process that can open the render node can do this. Reproduced 3 of 3
>> times on a Strix Point NPU (1022:17f0), by calling SYNC_BO with size 
>> 0 on
>> an AMDXDNA_BO_SHARE object. The import arm takes the same request but
>> flushes the whole scatterlist, so it survives it.
>>
>> Nothing needs flushing for an empty range, so answer before choosing a
>> path.
>>
>> Fixes: e252e3f3488a ("accel/amdxdna: Revise device bo creation and 
>> free")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
>> ---
>> Trees before amdxdna_flush_bo() existed carry the same call inline in
>> amdxdna_drm_sync_bo_ioctl(), with args->size passed to
>> drm_clflush_virt_range() unclamped, so a backport wants the guard at 
>> that
>> call site instead.
>>
>>   drivers/accel/amdxdna/amdxdna_gem.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c 
>> b/drivers/accel/amdxdna/amdxdna_gem.c
>> index 1c63eff0a4a8..2a16de96e6a4 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>> @@ -1247,6 +1247,9 @@ static int amdxdna_flush_bo(struct 
>> amdxdna_gem_obj *abo, u64 offset, u64 size)
>>           return -EINVAL;
>>         size = min(abo->mem.size, end) - offset;
>> +    if (!size)
>> +        return 0;
>> +
> Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>>       if (is_import_bo(abo))
>>           drm_clflush_sg(abo->base.sgt);
>>       else if (amdxdna_gem_vmap(abo))
