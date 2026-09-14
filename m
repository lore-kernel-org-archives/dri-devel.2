Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAC6C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 269FB10EF30;
	Mon, 14 Sep 2026 14:45:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ADzc3IbR";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2799810EF30;
 Mon, 14 Sep 2026 14:45:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iyc82jxoUL6BKfL4juDPZ+avKiOinUGWd9YFTagUCWWBfLqhMcBkQJysIEsoTzkplEfjH0G8DiXLHavMRxqQPGmxmorAQ+nnv1o8HFG+T82mjKsMZbXFJxrTun6BwTe3cLRcoqaeo75enESMZL5n1BA55smYbCDAqgVCWEqeljSFo+VhjyECRHDFDeQ1DFzalpmsRxBXnNoPik6MdlcL6NGmiu5XxXvNFhhLHqJSWVAXuLcPDjB4ekxmR+AzB8mwVJazGHWhpRGHknXKSWoxodbTOD3GWLpraAOGlmXfU0akq+NS5ztpsIDGFGUd9PJHBDV120VIUlggC3BkUwiAJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rL0RhPGNfGmEoT5BrFKJ/YnMZ5FZU5wEArVgCf4QuwU=;
 b=uRUyUNtCDG6bH4zUKu22KIK5xErW9LlIAiwwF1rVwmrEA+QzV5ZrtvfMLfiMH+UonGtrbry99Rsq4TmewwkHyDl4O3Do4frJRzGud6hhs5rCJjFLtGEBjllmLMbjCKW3QoVYRg96Q8km/tZrlCWFDEFOH+2v6wSLhOmt6e9K7TVI4XVMNo+BIspiLP73kTG5SxbH0wTN5tAqygmmgtwRvKc0+RltHa9XH3ybPcU8NxJxgo+AGBYndmh6ODDZbXqmZl6lFol/5F40lPxjxcgdWmbPZu+HFmEM05IfcF5PeGvSjPbOxbjpaVNjluZ29K3JOeLyZgUJZ+QHXc0NyypInQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rL0RhPGNfGmEoT5BrFKJ/YnMZ5FZU5wEArVgCf4QuwU=;
 b=ADzc3IbRlnascaQ+oShIGNRS1qJ2GmJFfCVxI90oxImBA3+GA+vFL+0DtY2cQA2n/A3nT0JU55psVr0DX0+wzII7vphTwsD0c51EdoiGZoZYYVOX7zKEAb+k+/OWkWYnXb1r/u5hA8AFVrRCZIOyVxIxyOTTnZ/iUxlGB/7I8Ts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SN7PR12MB6715.namprd12.prod.outlook.com (2603:10b6:806:271::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 14:45:31 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 14:45:30 +0000
Message-ID: <05b669e6-1c66-4789-9916-b8030e232385@amd.com>
Date: Mon, 14 Sep 2026 20:15:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: zero reg_state buffer before filling it
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>,
 Alexander Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Samuel Zhang <guoqing.zhang@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20260914135650.87591-1-Dmitry.Chumachenko@cyberprotect.ru>
 <bc9cf07a-ef97-490a-b98a-a05bc9f5b186@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <bc9cf07a-ef97-490a-b98a-a05bc9f5b186@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::20) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SN7PR12MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: ea384b54-7d02-40aa-1fda-08df126ed2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: GaMcDb4yuRMJFDI5KapidTgf64WPoQSzQ3A/V7U6suyD7fCTz15PPgxnYRR6vh8hqaqxFLs1a3AcZTgBm5kddCAM28fbQG2gCZijHEjlKxP1HQCvGBOVta2QSV+Dc/c67gRFQwGDSfpdEMU2wmuRU213qjn2OjKAxSXiZVNsDJEcqRS+rOJPcnmT62qAxTthdzcbAfJaJi0GMx8BjG6Bjzh0KTPZDNKh2y1e9XGvwXI67BLP3PoWlcEuEu6O9mkueZrUnNdN58lFeUUKG8qiPI+Vn4uuH2PS3MWbSmUiSX7FgBhrUWRx1+JtvXhKrly91CbI5WTaqXm4RQSmCJhBVRZGoTlqJ4AVD+9n9EKNtG0bKwncgHMe97HIXLyHqMYomhYuqtVjv3Ha9pI9r/ZCbNqGnjKcBHvng4f/5YbseU8os1CI/9wGrZDSXW0kfh2cxLWMYPV7snA7ZHLQrgHGvVgKBWa122y6EcErmgToPTNsqnDc4YeOfERNXWXpMJ5K7FSO6G8PP6DnU1CVZSl46DFyxJJrQbwyANR4FoQ9zLLRAlJbaI7E34XY/3pb75Mz3jldJ8YUYeYoJOlUa4+cshfARpkUPWdi78Kjka9RiwonRM/YkBDsgjMA+6mzAtRog2/uc4gNYCk3pnwNBhzA5cx30Ymj1t9VDr+5DYuOKl0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDNoQXIreC90a2k0cVExVVBUMWpya1dQY0VXd0dCbUhmSURhUFRGVXc4NGFV?=
 =?utf-8?B?dktRL0NadkpGWGxVMFJhN2dOQWZ4U0xVc0xTa1c2b2VxNG5LRjRXR2swNU91?=
 =?utf-8?B?MGtRQ0VVZHlFV1JXN2RqN2lMSC82UDloS25ZWGJ2MWFGNmtDblROd1Jxd1BQ?=
 =?utf-8?B?UTJxdHJpS1BBNC8zV1J1bDNERWRwaU1Sekp6KzhadXQvdXRBdU9NSndpZVF1?=
 =?utf-8?B?TmtkNlBUZVJIZlQzSjR5NHJzQ21lYmRHMHRIU0ZOSHdtTmhKWGZDWFppZGdy?=
 =?utf-8?B?NGc2NXBlb1FqVm95SHZobzhKMGVCbW1hdU84RFlwc3hFWEN3S25zYmZmNERF?=
 =?utf-8?B?c0dZWW5zZ0RGK3dGcnVMYlc3VWk4dTNMVkp1Z2p6bVM4bktYa3ErNHZQcFlu?=
 =?utf-8?B?cjZGUlVUaFR1eTZTMVdNbXl2WUVjZ2llMEVrSUlGZW1zL2t2c3BaN01ZWFJJ?=
 =?utf-8?B?dzhrRDNVbmV0YS85d2NtNzNseTNRcnR2YzdNa3h2SEVwV1A0MytwNWdnVVJr?=
 =?utf-8?B?ZmszTWtCV3EvNXR2N3lJdkUyY0NWVGd6U1MrWnMyQ3Z1QkdGTCs2WnpVZXdP?=
 =?utf-8?B?aHlib0xJM2dCN2lvOXpqeWdwSkxUZmowNWdkV21nZW5XcUk0c1hVTjQxZmZq?=
 =?utf-8?B?ZW4vZk8zMnJSTE5lTHk1RDhjOUd5Tkt0SUdMc3dqL3Z1QjZiaEVsRFpDOW5p?=
 =?utf-8?B?MCtIYm1BSkxnSDJhWlFiendBWDVxUFVzKy90VS91L241OW41eW1XT1ZvSTA5?=
 =?utf-8?B?eWNmMmFJOXU3QkxKREp3U3hRUFdrdjhHQkJROW9yVXlOaGhuY0ZKZk9DVGI1?=
 =?utf-8?B?UUJmVmt2QTFVR3lVUDA0ZkV4cFJ5Y3QwaHd3bVpyZHRIWTl1U1NSb1Via21W?=
 =?utf-8?B?eWQrNDIrcHNOa1oycWEzVDJSYUp6c1pEUC9vaFJja0c5bWFybVVVZk5QVXdu?=
 =?utf-8?B?TmsrSHZQTFFpUnBDV2MzTXBGSmZVOENIUGIzWW9xWE9CU0lkYjlQV3NZS0hV?=
 =?utf-8?B?R1ZyU1ppWnZFTjFXbTZKcjNiejJXd1h0RjFzUVF2Y3YvbDY2RE9mdlJzNXIr?=
 =?utf-8?B?S29OaExHa2xNWTN2VjR0KzhDbVpacEZ2L2NOalpoVTM5VjdiQ0IxQUFEOWdk?=
 =?utf-8?B?a3I0N01WTHJzUmtTZ2ZVVUpFMlhuTlR4bjZiQzBhbkNXLzA3eVRyS0dFUHhz?=
 =?utf-8?B?S2d0UG82eisySnhaSjk1UndaUlVheDZHd2NwTDBvTGhaa3hQYTgySXZuK2hx?=
 =?utf-8?B?eWZQMFhBVHA1enA3c3VyTkFVNEk5TnBTaml5TDRGRzFSUFBOYVFINHdqVVZp?=
 =?utf-8?B?Y0sxai9TdUFNM2ZBbGZGWmVRTFIybXdhcUtDNTNNdThBTUdFSHY3VDFjdk9Z?=
 =?utf-8?B?QVF6WlNnMW5yNVVBUjdpckN2T0xuZ3ExbWVYdHB5Tk5RL1BmQVBWbStGK0ZC?=
 =?utf-8?B?dUg4b3IwQ0lid21RUitOSTA5K1VEK0ZxM0N6STJhanNLcm5xZFRuY0FsWm4v?=
 =?utf-8?B?WDZEeVVZU1FaTVBXS0dTb1JtRGVrM01qV0RIUjNqdWorb0N6elB0bTkwUTlD?=
 =?utf-8?B?cWNUQW9na2ROdkg3RW9tdDZCZzZBZEl5UjdWdWMvMXdRT2JKcCtwRGtKSTJD?=
 =?utf-8?B?T1ZJajNBS3FNU2J5TEJQTFJpNm1kVmhETEJSQXEwUmZmYzNzYzhnbFFKcmZ3?=
 =?utf-8?B?MG1CR3EzQnJEMFNPSFJkb3M4WUI2YWtpenBWcjBCa3E5K1R5OWdYNU9ZaHVG?=
 =?utf-8?B?K2NqZDVpK0oreHVyTS9PcWRLVVNEZjdPb3FNQ1F3dUJwWnR6NnBkd3ZZOVdX?=
 =?utf-8?B?RVBBdCsvNFVVcThvd3VZZFJ4U1I1R2dsNnZsQmsycUZOWGlxd0NIWkdZUDBI?=
 =?utf-8?B?aEJpeFF4bVZQVTZKY0Rud2VlTStaRzk3NlFFelVVejdVcXZESjlabVJLZjc3?=
 =?utf-8?B?dVJvMDkwY2VyeGdOMWNTbTNVZDE0VFEvNnc4clZFdWhFOXdEVm9vdkhKMzRF?=
 =?utf-8?B?WWg2YTFEdVNUcFk5Y3NkT3QveHUva2ErNVNIbGZvdGxqOW1WTGNxT29iSENW?=
 =?utf-8?B?dmhPQWpaWHZ3YmJVdDZUbEMxYVpoZFNLNE9lemxOMTdxNlZwcVdpNG83elVN?=
 =?utf-8?B?QXRmSm9WcnpNQWNzem5SZ0pNbm1HVXdvR3c2TXI5Q0JxNXpJUklDa01TRktY?=
 =?utf-8?B?ZWZZRlk1VjQzeGhZcGtsT2l4ZlZQbkdjQzJNZ1ZmL0g0ZStEcVFFSmtFblU0?=
 =?utf-8?B?dGliWm1CcFJ1UC9TTVJ4ZEpDWlJJbHpxTmdQdWNFUnpsVFlZd0orOWNCcXI5?=
 =?utf-8?Q?IybPWfSDUfoI6w4Uzl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea384b54-7d02-40aa-1fda-08df126ed2f0
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 14:45:30.6786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SABD9JBRT+NHoTwEeDyNUXLd6lb40HwAXgZvg4JXaUJv452PwoChsccWUOR7jHfe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6715
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



On 14-Sep-26 7:30 PM, Christian König wrote:
> On 9/14/26 15:56, Dmitriy Chumachenko wrote:
>> The reg_state readouts return szbuf bytes but never write the pad members
>> of the headers and of amdgpu_smn_reg_data (and, for pcie, the fields
>> skipped when the upstream port or AER capability is absent). The sysfs
>> buffer is a plain kmalloc(), so those bytes leak stale slab data to any
>> local user through the 0444 reg_state attribute.
>>
>> Zero the buffer once the size is known.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Fixes: 081a6eda2b25 ("drm/amdgpu: Read aquavanjaram PCIE register state")
>> Signed-off-by: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
> 
> Good catch, but stuff like that should be handled by using kzalloc() instead of calling memset it manually.
> 

It's the default sysfs buffer allocation which may not be used entirely 
by all drivers.

The concern in this case is that driver is telling it has written x 
bytes whereas it could have left some fields unfilled in the buffer. I 
think the fix is fine.

Thanks,
Lijo

> Regards,
> Christian.
> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> index 72ea37dbfea8..0086de0f685d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> @@ -610,6 +610,8 @@ static ssize_t aqua_vanjaram_read_pcie_state(struct amdgpu_device *adev,
>>          if (max_size < szbuf)
>>                  return -EOVERFLOW;
>>
>> +       memset(buf, 0, szbuf);
>> +
>>          pcie_regs = (struct amdgpu_regs_pcie_v1_0 *)((uint8_t *)buf +
>>                                                       sizeof(*pcie_reg_state));
>>          pcie_regs->inst_header.instance = 0;
>> @@ -702,6 +704,8 @@ static ssize_t aqua_vanjaram_read_xgmi_state(struct amdgpu_device *adev,
>>          if (max_size < szbuf)
>>                  return -EOVERFLOW;
>>
>> +       memset(buf, 0, szbuf);
>> +
>>          p = &xgmi_reg_state->xgmi_state_regs[0];
>>          for_each_inst(i, adev->aid_mask) {
>>                  for (j = 0; j < xgmi_inst; ++j) {
>> @@ -776,6 +780,8 @@ static ssize_t aqua_vanjaram_read_wafl_state(struct amdgpu_device *adev,
>>          if (max_size < szbuf)
>>                  return -EOVERFLOW;
>>
>> +       memset(buf, 0, szbuf);
>> +
>>          p = &wafl_reg_state->wafl_state_regs[0];
>>          for_each_inst(i, adev->aid_mask) {
>>                  for (j = 0; j < wafl_inst; ++j) {
>> @@ -902,6 +908,8 @@ static ssize_t aqua_vanjaram_read_usr_state(struct amdgpu_device *adev,
>>          if (max_size < szbuf)
>>                  return -EOVERFLOW;
>>
>> +       memset(buf, 0, szbuf);
>> +
>>          p = &usr_reg_state->usr_state_regs[0];
>>          for_each_inst(i, adev->aid_mask) {
>>                  usr_regs = (struct amdgpu_regs_usr_v1_0 *)p;
>> --
>> 2.49.0
>>
> 

