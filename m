Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CF560A260F
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sjPAdS/3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8378B112CB7;
	Fri, 20 Nov 2026 18:44:29 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012036.outbound.protection.outlook.com
 [40.93.195.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE290112CA7
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:44:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2kLdzm5uyIZVoo1zK1ea2srziORyiKyMTaVASPvuq7ekh4AzjYIlZf/RGgSs7lkgTSLUL1+OjNbm69vlYYR08eozyNup2+08HuArfiV1ejGVqOCREgJFxFG5TVwOluYLgAA1RsUeLQ/EZj4ee66H/Ewa1BNc9+tMRl/1sR84vIAPZNSMFf0tc0ncaSITqoXgLI8KTJMeFtqune/3+60vxGmUkz0ypGInMszvaKyjvO7x/9SIGIDeWgiCx9D0KrXh8F/SIuWMZA6lel7TGw4WPrq+CWOT10oLGwqsyG0IvTMejqYpVL7gj+yTHWZeYJK8xLq7p8kQVUc8RMRXssbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLAfYDWVDjak8vu2G/LSTZhDqGcC/NWEMSvQZonLANk=;
 b=MTBYjzYfrGaDDGWuvM9sIZwLOml/x7fu88TQx6NdYQj3OcAOeHZ8TVMXWQdlN2tBftP/x1cNDF8rrqcwwlHgIKrK8k/9seJ4DY5d9y2kz7Ccd0IWJXJF5NX1TUobWhOaRf2m5d4xiMx8Jt6RghZXYk35MzsgF156vSYkUxI56YWTuMfp+zNs9qnyF8g9BtkRFO2tuhVOafaNM49B+BlaBA6RnLVID1ojio5xnuKScdJot3evM+jUctv3ZClLhx/STctZxAaoKwohb6zGRmQKG8ByyadQZ1ZFVuOsa+oo6UE16LxkoyZMFlFlSmcpqDUpKCu+bghbcY3YMYgUFpCA6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLAfYDWVDjak8vu2G/LSTZhDqGcC/NWEMSvQZonLANk=;
 b=sjPAdS/33BXxUb/khxPqNC22HmfFEMDjTB5yd3Sf4BghdqW/c5PdklzzZAPc2/EmQSSo3z8sygjb4VEVPtcXsQW6G8+0Vp126p880pg2hJTVcRQEz4M1XWIUxg4Bb0DxDN8d29TSgGdtHI8qxpQkJNSNQZGO7qjAKY8XG150TmY=
Received: from CH2PR14CA0002.namprd14.prod.outlook.com (2603:10b6:610:60::12)
 by MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 18:44:19 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::53) by CH2PR14CA0002.outlook.office365.com
 (2603:10b6:610:60::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 18:44:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Fri, 20 Nov 2026 18:44:18 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 12:44:18 -0600
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Fri, 20 Nov 2026 12:44:17 -0600
Message-ID: <a94437f4-f0e0-dccf-3dac-1bc1f0dda835@amd.com>
Date: Fri, 20 Nov 2026 10:44:11 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Reject a zero sized buffer in
 amdxdna_gem_prime_import()
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>,
 <linaro-mm-sig@lists.linaro.org>
CC: <linux-kernel@vger.kernel.org>, <sonal.santan@amd.com>
References: <20261120023540.888381-1-lizhi.hou@amd.com>
 <48d1dd13-9ec6-402f-8a72-ce417f331332@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <48d1dd13-9ec6-402f-8a72-ce417f331332@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|MW3PR12MB4409:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c84940f-c49d-4792-7b04-08df473648e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|22082099003|18002099003|4143699003|261026121527099003|261102130727099003|56012099006|261028144727099003|261022105027099003|11063799006|261009223027099003|261102123227099003|261022075727099003|261021121427099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info: xfR7OvZKgNs1NyUnAWTqd4zvctPRX7q9nS+WEWonWoS5TlUIAM/W9l0AatYp49xnZaMylMQklgsDF9bwfGZXhS+L7pXjWQzHway2Jj+USAu79WWtXl7/PMTggjx++cP1iSRqZABvlMNNKVuvUMUwwMXERRMnuXbnPUo+NTKCXvM0cNQzgRgnlbgPzjscj+Xa/MhKtaC5Dbnr4pYjzIoWTtgx8C1SiTCbtD8lLaJfGknuXNoDCWFwcWAY/VF2J0NdLHKsWdDqvns+01V8YXKDAmpYps2I21W55mprTYZdbqIiLDcW3DyOyrvzir7oRCB9Pf0JX5s+NPyaQKBZ7WoFoPXXUpq4mbH8H3iRArwZoo+IfRki7apwdfErulmR0uD/8RCfE6iXRAmWxXhh3knCeOknCqd5L1Nz5+EWFiG2SKDyj4vOSZm9af/8zISLnGnR2bgUUvqX2gSYHopTCMlI3yVvKiq6JKOdOora7o9NbC6uuQl0/JfHQP0bWkgu7xNzBpIEfo4wqkgSpxaHGkfi3u0Mp3XfiVKxoINVtpYhptV2SYy+E1PqkJxfdV5fj2+7+UcJ6uwYuvQTNbfHcIeD4bvlbwriMPAYxKUyiMcBHvLdnAkH8PKXggiJLdox5VAkyFgWicMuMswnewr7IQHGiFZf5HWc+d5AAjKymcUPFeZca6B4suvGxZR2YyCHpznN66Q3zUszk/jrdxj4cudhvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(4143699003)(261026121527099003)(261102130727099003)(56012099006)(261028144727099003)(261022105027099003)(11063799006)(261009223027099003)(261102123227099003)(261022075727099003)(261021121427099003)(261026140227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: quTx6Wi2oI9tzACiUO6J8WvUmyjgeN3bmjwGlRld6hWhfxq2FIe5Jj/51sXkZG32KudymdlMqwiSYk7GZddzBsQiedPD7msFH12CiKf7Me5HPOkwQlk0lSm8uDZgpiti3U0Wyr1bYG4Q+//vFHXTmiXa2vUJTW1gxk7LLyWa8PavlNTfIEH3TKnrqpbYkTQHex2hAAWb0wWHtqoO7Q/3ML+IXWuRqQTX7bnCeoVb2at6irj49k0acKGMp0bGAuK0chn94WMUfZq5hVhDi5PaPxLG8jkCQHTxkRi+KJuFMib4LpT25SrBaJwcTuRohVx4rJ3L0BytA2wz634QWlJp5ShsaxCyhNI3Eiim2AIxU6bfX6fJ0kxGmXlJeqVWJFXihKk3a+3ZR+SvsiFRI9pHLisrYQ1mJNZ1iuusyNn/Zo4GQRzbFSQBfGlR2KgmsmWP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 18:44:18.6579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c84940f-c49d-4792-7b04-08df473648e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409
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


On 11/20/26 04:32, Christian König wrote:
> On 11/20/26 03:35, Lizhi Hou wrote:
>> Zero sized buffer is not supported. Check the buffer size and return
>> -EINVAL if the size is zero.
> Oh that is surprising a zero sized buffer shouldn't be supported by DMA-buf in the first place.
>
> Doesn't DMA-buf check that somewhere?

No. I built a local test to reproduce.  The test driver calls 
dma_buf_export() with exp_info.size=0, and it successes. Then, import 
that buffer and get the stack.

It looks other drm drivers check the size as well, e.g. 
drivers/accel/qaic/qaic_data.c, qaic_gem_prime_import().

Maybe it is better to add the check to dma_buf_attach()? Or I can use 
the check in amdxdna for now?

[89432.394897] RIP: 0010:amdxdna_gem_prime_import+0xb/0x120 [amdxdna]
[89432.394905] Code: a2 29 c1 5d 31 f6 31 ff c3 cc cc cc cc 66 90 90 90 
90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 83 3e 00 75 
14 <0f> 0b 48 c7 c0 ea ff ff ff 31 d2 31 f6 31 ff c3 cc cc cc cc 55 b8
[89432.394908] RSP: 0018:ffffd04344fd79d8 EFLAGS: 00010246
[89432.394911] RAX: ffffffffc10b4bb0 RBX: ffff8ddb05863a00 RCX: 
0000000000000000
[89432.394912] RDX: 0000000000000000 RSI: ffff8ddb084ebc00 RDI: 
ffff8dd94b17f000
[89432.394914] RBP: ffffd04344fd7a10 R08: 0000000000000000 R09: 
0000000000000000
[89432.394915] R10: 000000000000000c R11: 0000000000000000 R12: 
ffff8dd94b17f000
[89432.394916] R13: ffffd04344fd7ad0 R14: ffff8ddb05863b20 R15: 
ffff8ddb084ebc00
[89432.394917] FS:  00007f8216e08740(0000) GS:ffff8de0c09bd000(0000) 
knlGS:0000000000000000
[89432.394919] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[89432.394921] CR2: 000055c3644b51e9 CR3: 000000011237f000 CR4: 
0000000000750ef0
[89432.394923] PKRU: 55555554
[89432.394924] Call Trace:
[89432.394926]  <TASK>
[89432.394929]  ? drm_gem_prime_fd_to_handle+0xdb/0x220 [drm]
[89432.394974]  ? __pfx_drm_prime_fd_to_handle_ioctl+0x10/0x10 [drm]
[89432.395003]  drm_prime_fd_to_handle_ioctl+0x37/0x50 [drm]
[89432.395029]  drm_ioctl_kernel+0xb0/0x110 [drm]
[89432.395069]  drm_ioctl+0x2d6/0x580 [drm]


Thanks,

Lizhi

>
> Regards,
> Christian.
>
>> Fixes: e486147c912f ("accel/amdxdna: Add BO import and export")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>>   drivers/accel/amdxdna/amdxdna_gem.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
>> index ffe12a722dfe..4d7f3de88cd3 100644
>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>> @@ -1133,6 +1133,9 @@ amdxdna_gem_prime_import(struct drm_device *dev, struct dma_buf *dma_buf)
>>   	struct sg_table *sgt;
>>   	int ret;
>>   
>> +	if (!dma_buf->size)
>> +		return ERR_PTR(-EINVAL);
>> +
>>   	get_dma_buf(dma_buf);
>>   
>>   	attach = dma_buf_attach(dma_buf, dev->dev);
