Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334F5F436B9
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 16:18:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 915F810EA54;
	Fri, 17 Apr 2026 16:18:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k8IT/Qow";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9444010EA54
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 16:18:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKrtpLxaraRSODxICWP6vzdCzZyY5BWTQ1+rLBLYN2J5W0l3lFAd5+mszgqDlp1pZWfHvzaEQVp6J5tgSNo+6C+VqaV5/P8Omwld6f0imc1K9zvx8VI3O3Y++rpKIwQY79VYuNxR168iT8QeRht1WUi+rGFrgrzUpPi5wTEY1z7EXbN5vKPmEv0DDwcHgV65gy9G+KJLPW4RS6DPvAHt2JwRf9+FksxEN+P5wU+bCiUpwf5PcbNslO+bseDqbu2YYyacjgMM6QAL3Oi07Qw3zrS82KI9yE6nyKxRtzdfBZrYcW23Fq8P5aG1t/ovsDSZUfAX+YHTPkR7x64Vym1FEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHfMNTv9JtR5GJO0h2sghBnZYUmmQGxA5nY6nvLlnl0=;
 b=Y9zTjbk5WJENcT0u7AUtGVVRxS+n1hArzNFYQngSWXYUnXpuc1Ux/3lJ0mxBAl2gVNvrBT7DDP/gAxHVilJitHeqZxcA8xcGxGU06RdI/8LhopowM5pH5fTdngdtZkpPkSNjk4g2dvG0KmWLrKSj6Q9ICNr0jcPg0wqH6/bNcY+BAAd+PrpJe7yBlZR+c5Yo33kLNjYDbk3P7vE1/HfcXX1stq0eSl40t/rhsvT2g2iHZNemR/Q19ooezH3IG4FQ7ht2egMspOZ8iR9MNEwb0Y2BzFRF1gwTxccCJqgumqopas6HspUBPXZ5r6moxuxDKtbSrJGH1zY1k5EUCWJtSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHfMNTv9JtR5GJO0h2sghBnZYUmmQGxA5nY6nvLlnl0=;
 b=k8IT/Qow3iGgXzc94RbBvJ5bNQRhH6T4yS4DlVn3sfadebtMKLOtSA3rn0LQAKyMJNaPS9xII9OLcTmfa93zKnfR9jHR56BBeTbKQkL0sA9ZPc5nxrYdR+osOxxXcIzvp89/Uu7Er8YVytHzT0jjbA0R6X6ZuZkSK8IOBq+dytA=
Received: from SA1PR04CA0023.namprd04.prod.outlook.com (2603:10b6:806:2ce::27)
 by PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 16:18:09 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::98) by SA1PR04CA0023.outlook.office365.com
 (2603:10b6:806:2ce::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 16:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 17 Apr 2026 16:18:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 17 Apr
 2026 11:18:07 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Apr
 2026 11:18:07 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 17 Apr 2026 11:18:06 -0500
Message-ID: <d804f23b-20e8-966e-6e4c-f71f8f61fe0b@amd.com>
Date: Fri, 17 Apr 2026 09:18:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Guard management mailbox channel
 cleanup against NULL pointer
Content-Language: en-US
To: Mario Limonciello <superm1@kernel.org>, <ogabbay@kernel.org>,
 <quic_jhugo@quicinc.com>, <dri-devel@lists.freedesktop.org>,
 <maciej.falkowski@linux.intel.com>
CC: Max Zhen <max.zhen@amd.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
References: <20260416201106.1046072-1-lizhi.hou@amd.com>
 <be49ee67-ff32-4cbe-9fa8-6a3c626a948d@kernel.org>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <be49ee67-ff32-4cbe-9fa8-6a3c626a948d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 02c272f1-c34e-423a-33d2-08de9c9ce9fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: K1qLq5glJ7N6um9edJR1CGS6Umz3T3/WVOvnvh8ReikEpF98jutWWacjvcfT2G2CKW45d6gc6znLY195J2+gvnhQ2AxIyBcJhE349bz+5SEqkBZw99TQCXZnKar/M3YlszJ3PCQcnBvw1jW21DlqE77gb+wMXNZ1BtpMfb/72vub7iDuByJU85q3Y+YwAkajj9ye25LSCFnfB5mg/NUTJAjxb7jcDGYHbyzicd+cJ3+2YnfOncXtJHfavjBqLBRyFR1bc4lmUTiXZG1j/6NVEsNQLY+GEyjCFTClGY1xuNylrW4AWWfcqrNUtIq5jwev0lZDRC9qcRVRAlxiV5PkdKwcBe0C4nXWMr8BNBnzjoyU9GCgBylnBKVC+Nipbub0Yr6Wr3WVEEq1LSZ080ynYDyoPBAx4NWotC0rzRnzoprrS6c+o0EP9uHNf/otGpXzfI/ipUaU2YbRYqWL1aUArUufeMhbu8UrHlFEq0v1xoyN3Zcw1fbpVwYwMENMesOH0zu4VHWrPMtmQdczWCCSIZejcDLWPUjGNQ6wyHSOQVQhv0ool5PyrEkfzlQLq1njb+QiI/BG6RPL1+OHTmm3sqR+076Sn5NusrNyNc0RrE0X0dSd2fMOHIJuM7r5pYuFjjZLbXLU9clm2kbdnLqY57YNPHwSH6YEwwECiYLuoNvVyUW1rgTsxG8Rx1NFgxAqW7JTFe6MFiYbnm6OSnhkXKAxkR+1gkec+tUG7ZvcRbAW5h+7GUIPG4KMwG0er8jggiYnsKCIprTExhZhWkVozQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0dc+hTUkNHmFdPAWRQ8xVgIYdaIdZX4gowWGuNnYcMHYIBv22j2IOHNqX1qF3gfxATOfeKMQAO34Rhxoc7EAiszsOQj9S7rfvBzA+BVY/fHD1p9DNjoAktQDHioV+XBrMqgFOAsX3lSV2VIGUcGSZhtxLNmR4ypB0UURWysvpTg+j7BVjIPn4Rw/ygpbcYMZznBAJgWmTUsHs+oagIx+FJGcKIyrs3tz+j8E+qqYWuT4tmbMHg1mMBw/r1dlTjioJhVwI5ieH9+oZCAvfR3YOXBvNfg+ULmLzKHCP4VoD+Yy/RzOPDji/ho3Mp4WBeQlah69S4rNrHqssIt58UEvUZwzSz3p7EiiPuICkqd5ZxdMsrjSsr+9BwsFFzk+j6fEZc2RhRWNwlC9weBJQR3YwPkVHOGai/WCI9BKPTxil+GiFOTVeLMR2QKBubmSqt1D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 16:18:08.7032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c272f1-c34e-423a-33d2-08de9c9ce9fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105
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

On 4/16/26 15:46, Mario Limonciello wrote:
>
>
> On 4/16/26 15:11, Lizhi Hou wrote:
>> From: Max Zhen <max.zhen@amd.com>
>>
>> The management mailbox channel cleanup helpers can be called from
>> error handling paths when mgmt_chann has already been destroyed.
>>
>> Add NULL checks to xdna_mailbox_free_channel() and
>> xdna_mailbox_stop_channel() so the cleanup path safely returns instead
>> of dereferencing a NULL mailbox channel pointer.
>>
>> Fixes: b87f920b9344 ("accel/amdxdna: Support hardware mailbox")
>> Signed-off-by: Max Zhen <max.zhen@amd.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>   drivers/accel/amdxdna/amdxdna_mailbox.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c 
>> b/drivers/accel/amdxdna/amdxdna_mailbox.c
>> index 336e5e77f18a..37771bdb24a1 100644
>> --- a/drivers/accel/amdxdna/amdxdna_mailbox.c
>> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
>> @@ -496,6 +496,9 @@ struct mailbox_channel 
>> *xdna_mailbox_alloc_channel(struct mailbox *mb)
>>     void xdna_mailbox_free_channel(struct mailbox_channel *mb_chann)
>>   {
>> +    if (!mb_chann)
>> +        return;
>> +
>>       destroy_workqueue(mb_chann->work_q);
>>       kfree(mb_chann);
>>   }
>> @@ -542,6 +545,9 @@ void xdna_mailbox_stop_channel(struct 
>> mailbox_channel *mb_chann)
>>       struct mailbox_msg *mb_msg;
>>       unsigned long msg_id;
>>   +    if (!mb_chann)
>> +        return;
>> +
>>       /* Disable an irq and wait. This might sleep. */
>>       free_irq(mb_chann->msix_irq, mb_chann);
>
