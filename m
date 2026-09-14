Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DCEC88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:25:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ABE310EC3F;
	Mon, 14 Sep 2026 15:25:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j4Typ5Gs";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010053.outbound.protection.outlook.com [52.101.61.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 518C610E55B;
 Mon, 14 Sep 2026 15:25:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAZQE6anVUckRqYEzjr8DcJvOqlZ0oo2ALNGAz8hQpG+r68tIGh3BSWKQMaOam1vzL+PqSi1wr5fdD/BfGnPSKONUq1KFhFb81fldPIkf5ujH6MuRcUElxxJpXNc2kzZOlS+O0+65kAFuWTNv+6rwhI2nVCRyFXOtSpDaoU40McHGfPtH6PgkcyqOqHQ75rePk5HXZBFlMBZwsztH5lrYjUFtc70XgNT6lAGy3UKcZFIqkK3DlI3wNZ/0O+1IABmYMIZO3DmkzWM3PsFcwvAFQChZozgo65/ZsJnnx1O5sAfpqNnQYwu3zc03jsbeAA1FpnUwnbeKRTHhpAdctHmzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqO3ywEggk1BpsVUd8A9q7mA95JB8DnMDI6S1MBK9z0=;
 b=EkduE4w6D3d0BifPflSmg0r7HHkKB3uXKmsE4bDMOQ7W/s0DkoHnIqop0VTu+ZECobm56yX/quXC3fvpVjFIs5bj4nPAiz1Gv5Xs1qUZTE9LckAC04e2rkKibBD8SIWwJ7y5U+GWdV3UVRfA8a7rs9Awt/z+xYAHV+7i363yijXoyLB8VIdFPJ0S7IV0ZR9tixJlx78pHIWnVKUuZAGgNF2Gt02pbL7Jt7xY1VTQQfErdtABrDHqdd7fpWWmMAgbAUgpr9OtiPJHNtQVlwdXgNZaOVxSPM6jFkV2a9S1L+4BBBb1cUtQGTncvKcUW504uc15USCMSkHOMx32ptNVkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqO3ywEggk1BpsVUd8A9q7mA95JB8DnMDI6S1MBK9z0=;
 b=j4Typ5Gsgmarw8DTXi5bA9k9fHp4Y6YJxe5rs95zET/13l6aydlbOT0UJyhLnq2LP61UG6lyOPyAj9l31eJGoekaY89BwXmuetS3rAjlpxi3sHruMyaxFmdFxg11hloir19cJqMgB6ePqJHX+BZmApRHA3QA3mqKibbaHG+PbnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Mon, 14 Sep
 2026 15:25:28 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 15:25:28 +0000
Message-ID: <c4f2f082-8956-4f20-af92-119b873c3759@amd.com>
Date: Mon, 14 Sep 2026 20:55:19 +0530
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
 <05b669e6-1c66-4789-9916-b8030e232385@amd.com>
 <aeeff331-8b2e-41d8-acf8-d5d758935d38@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <aeeff331-8b2e-41d8-acf8-d5d758935d38@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0286.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21b::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ecd42b4-d197-4220-9bd4-08df1274683c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ETJQcClLYl3SXGSJbFMuvbNhE+ghao6vtZG8aCeAe3fg3MFdsh19GmOajxIzS6vLNRCiI/wbsbzek4Nqt3U0TpxIGNHIU6DhPQjBS0LqAy5roL2LqyIgMfdzRiZ2ov695JvZktDtf0NBlh9Oh6G7G4FfgGymb4wvYKPs6j8bExYRR8C7y0cSgMWmouV4c/Dw/Pbc1yY22ZxhmqIRXXMEOeDxbtsG2uZ9ZqI0GTnjWdOUMA+i3Pg6Sc42DHcETRmveUVCCi4DHMUbnt4z09t3sMfZWluSX0MPtL0gtWxseW+Z1mV2zoe843/p3zGZ9vkPE6UiTp7DACPflopbMFDr/2Fz1l0uvO+poWNBJXDnfAjac4VtDs3V8NqBN6XFF2gAzWYxBQD1J27HYM2LSQBLhp+SbJAoeGtWq2TwSAZDIDtakbc5PHzYvyBy2Fe7/qn5eh87NfMmrqoLHhwe1S7QII7AfWF2WSqKUEOunDjcE3YMiloEqdeyQrTNOLbi+pLCSocqvcz8idaTiiEfNRUufNc8POOitS6axf01UMikQSgzq9fclL5M7p2bRYqIVcSI6d7lA/TeCCaiy3xDIzlSZbnXlEgVS3UT81N5b7Zh7nunT9lxo0YMT0e65Ud2jgdCIDkt05bOO+iNGb3XpKBhh0uc2YoyYB0/W1lGOiv+zQU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aklUNkxtWHhqZ25uYzVZMk0xY3lBSTQ3NUtOaFBzWno2QlJYWXhyVitwdXo2?=
 =?utf-8?B?eThlMWt1Q0w0WHRQTFpqMHFWS3FKQTFHeWtFNmlFVmFPTW0vMG5KVEZ5N1E4?=
 =?utf-8?B?QlREUmhIZlVjREJWa1FOMklHaXd5ZU4yWTZOQ2JRVC9yMU4zYkFySEhBK1Zt?=
 =?utf-8?B?VVRZTzBSeVBtZnJ2TzBnMEMwcE1MRDluQ05qYlhIbW40MUNBb2FLZ1dSQzhD?=
 =?utf-8?B?Yng5dEcxOHFCSGM4UkpHZThCRnJBQ2VpQTZsOVlBQkRCaXhxdlpQbDIyOXpx?=
 =?utf-8?B?VXdja1lWS1lEeEFyWUFzbGhFZ2l1U0lsU1ZaUG8wMTJNRkhWQ0JWOTRZbG9p?=
 =?utf-8?B?VHVmRGV2N3hHZVdnZzJKMnhmS3VycklMNURBQlV1N2wzNk84UEhqYWVVMjFK?=
 =?utf-8?B?T0lad3VuQzBHUlpTSFVudC9JQ3JGN1dnMVVpQUZsNll6ZTFjb042ajVST0FC?=
 =?utf-8?B?cmhaVVFQU0p0OHlKbEFJcTlURVBiM2ZhN0VDblgwc1J6QU11WHpPd1ltdnVu?=
 =?utf-8?B?YTlzcmRSSWFUYW1PdXdScTNzVGVsZmhwT1RPMUdSTmIrSGpnVW9COUZFOWtB?=
 =?utf-8?B?UXArWmZIcmNreU9PS1BlTGEzQ0FzalpIYnhmTTFnSVRvamYwdlVuSjM5Y3B3?=
 =?utf-8?B?WlgwNWM4WVRrbXNPSVd3YnRFeXF2Y1NQTzBFbEdaSjNhU0hDZGNiVDY2R2FM?=
 =?utf-8?B?TURKZE9sOHZsTzkxcHVOZTYvZnExOFV2OUJINy9NbnBCY2RKUkI4QjJ2VWd4?=
 =?utf-8?B?MmNDNTVOb0hVZUI0aFNUQ2xqV2p3UTB2V3hmYUY5dHF1cUtjdHNOZnNoZ3pr?=
 =?utf-8?B?aE5SWjIvdTNZckp4Z3R1VEZuMTRvKzlCT09lL0Z3MWZSa0ErNjdvdVFmS1VQ?=
 =?utf-8?B?SmV2VTNqZGN1L0tFcUVOSmxrVVRwVllzMG94bFZUNHFPUVVXczZEbEVtYUk0?=
 =?utf-8?B?dnRzUkU3a0tiR0MvY1pUb1c1NUdNSnRXODBmUkc0ZHdkbjZIL01lQ2V4VlAx?=
 =?utf-8?B?TUlEMlZ2dk9rd3NFMUxWU2JDdHNKbXdmSis2ZElpWjQxVUFXWW9GRkNRVTFE?=
 =?utf-8?B?end0cEk2V0NicXZRTlVsNXhDd3RYa01RY2JXQmdiTzdQMHRoblZwcC9MemQz?=
 =?utf-8?B?Qkp6L3VYdFZEMEhjS2lQRG9RZGhhN0VsblBZa1JWRjhneWI0K0krU2JzdDkr?=
 =?utf-8?B?MG1ZQ1R4MGdNOEFzTmNybDlkckhDektrSForaVV4TW0wZWtMUFFuMzRFc21n?=
 =?utf-8?B?cDlQVGJxbkpJR1Y3eTJsMmNMNFg0bEpvQTBQRTN3YXh4UnB6QThSMkNuNVVJ?=
 =?utf-8?B?anFqaWw5eUEzK2c2V3prdlRGQXZyOUVpaVVISS92NjhlMFFQajA2c3pFc0p4?=
 =?utf-8?B?YkNLRG45SlhGZWc4WnlyZkg1eTc5dWNPYVhCWUpBZTFYOVkzTk9pQ2h3a0dI?=
 =?utf-8?B?OHZpcEJQNm5GVEI0VCtEZEZDaUEzWG03V0FYVGtKaU1NOW9Mcnpac3psUkhZ?=
 =?utf-8?B?ZGR4bU9hWDlMdkxMd1gyakl4bENVam9veG4xeDk2Q0xXWVNHanBETVlpNUF6?=
 =?utf-8?B?Y2tMYzdwaE0yTXVMRzBUM0JuMGRyTnVEL2pETTdvS0k0bTlYUXQ2WDcyMXdy?=
 =?utf-8?B?dDMveC8zN3lBRWYrNHVpMGMyWXZaTUdFaFpDS2lJYVJWTUZWclFlSHozVHZQ?=
 =?utf-8?B?NW9uQkZ4RzZFN3pnOTNGdklOZm9DdmV4dlhzdlFBTm9WSDFDZ0tIQ1JidTBT?=
 =?utf-8?B?SlFmUzBSWFVUcEdURHVtS3JYaVN3bEtmL3hWMXBUTnJIa2hyVHRWVURNamQv?=
 =?utf-8?B?cW14ajdFajRSNTYyUm5BU2tpK0xkSUhPbVFTRGJ6R1pRQXZQaWJQUUhPaXY0?=
 =?utf-8?B?Wkt5WUEvSDBQMStKcytmbk5YdlpWNG9HcCtaVXplU20vdXdSdDZFZXNISkli?=
 =?utf-8?B?VjlhbzFRMGM3YzBIL2hKdUo0Y2hFQkNMYkQ3T1Flc20rNUVNNFhCNytkbzVq?=
 =?utf-8?B?VUlmUy9QQURmemhCLzJ6M3MzQVY4Vnp6bjNXRE9pakJ0WFIyV0dNQ2VTYXZH?=
 =?utf-8?B?bkoyRGxOQXRRR25sWW9DWGIranpCYnkwS21zZ3B4RjMwUEFKNkFTR09BRXoz?=
 =?utf-8?B?Mmo3Y0FTcDloQW9Hei94ZEgzTnc5ZWszdTNCc2k3TUw4TWwxdjNsYXN6S3NG?=
 =?utf-8?B?cUt6MXBJdm1tK0FrWW9BSmlaMzdqSkF4NG9hZXZ1b2IxZ01XY2E4d2RUVjBu?=
 =?utf-8?B?N0hNSkxOV3pQM3J2cFQrV2gyZ0RGZG9NZXVrcEdEdjkrdXl1TjZGdEhTUUZx?=
 =?utf-8?Q?O/Gjz1R4POocNyqrwf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ecd42b4-d197-4220-9bd4-08df1274683c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 15:25:28.5669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwtvKPSM0ALuh6C4L0zRZZbrzQajKcgtB7x9WOS8iik4NL2syESMRWnEueVLhLp4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732
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



On 14-Sep-26 8:24 PM, Christian König wrote:
> On 9/14/26 16:45, Lazar, Lijo wrote:
>>
>>
>> On 14-Sep-26 7:30 PM, Christian König wrote:
>>> On 9/14/26 15:56, Dmitriy Chumachenko wrote:
>>>> The reg_state readouts return szbuf bytes but never write the pad members
>>>> of the headers and of amdgpu_smn_reg_data (and, for pcie, the fields
>>>> skipped when the upstream port or AER capability is absent). The sysfs
>>>> buffer is a plain kmalloc(), so those bytes leak stale slab data to any
>>>> local user through the 0444 reg_state attribute.
>>>>
>>>> Zero the buffer once the size is known.
>>>>
>>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>>
>>>> Fixes: 081a6eda2b25 ("drm/amdgpu: Read aquavanjaram PCIE register state")
>>>> Signed-off-by: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
>>>
>>> Good catch, but stuff like that should be handled by using kzalloc() instead of calling memset it manually.
>>>
>>
>> It's the default sysfs buffer allocation which may not be used entirely by all drivers.
>>
>> The concern in this case is that driver is telling it has written x bytes whereas it could have left some fields unfilled in the buffer. I think the fix is fine.
> 
> Wait a second, is that because of messed up padding in sysfs structures? That is usually a really big NO-GO for upstreaming.
> 
> Structures returned to userspace must be padding free, see the tool pahole for how to double check that on different architectures.
> 

It's an explicit padding like below for alignment. Those fields also 
could go unfilled.

struct amdgpu_reg_state_header {
         uint16_t                structure_size;
         uint8_t                 format_revision;
         uint8_t                 content_revision;
         uint8_t                 state_type;
         uint8_t                 num_instances;
         uint16_t                pad;
};

Thanks,
Lijo

> Regards,
> Christian.
> 
>>
>> Thanks,
>> Lijo
>>
>>> Regards,
>>> Christian.
>>>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 8 ++++++++
>>>>    1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>>> index 72ea37dbfea8..0086de0f685d 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>>>> @@ -610,6 +610,8 @@ static ssize_t aqua_vanjaram_read_pcie_state(struct amdgpu_device *adev,
>>>>           if (max_size < szbuf)
>>>>                   return -EOVERFLOW;
>>>>
>>>> +       memset(buf, 0, szbuf);
>>>> +
>>>>           pcie_regs = (struct amdgpu_regs_pcie_v1_0 *)((uint8_t *)buf +
>>>>                                                        sizeof(*pcie_reg_state));
>>>>           pcie_regs->inst_header.instance = 0;
>>>> @@ -702,6 +704,8 @@ static ssize_t aqua_vanjaram_read_xgmi_state(struct amdgpu_device *adev,
>>>>           if (max_size < szbuf)
>>>>                   return -EOVERFLOW;
>>>>
>>>> +       memset(buf, 0, szbuf);
>>>> +
>>>>           p = &xgmi_reg_state->xgmi_state_regs[0];
>>>>           for_each_inst(i, adev->aid_mask) {
>>>>                   for (j = 0; j < xgmi_inst; ++j) {
>>>> @@ -776,6 +780,8 @@ static ssize_t aqua_vanjaram_read_wafl_state(struct amdgpu_device *adev,
>>>>           if (max_size < szbuf)
>>>>                   return -EOVERFLOW;
>>>>
>>>> +       memset(buf, 0, szbuf);
>>>> +
>>>>           p = &wafl_reg_state->wafl_state_regs[0];
>>>>           for_each_inst(i, adev->aid_mask) {
>>>>                   for (j = 0; j < wafl_inst; ++j) {
>>>> @@ -902,6 +908,8 @@ static ssize_t aqua_vanjaram_read_usr_state(struct amdgpu_device *adev,
>>>>           if (max_size < szbuf)
>>>>                   return -EOVERFLOW;
>>>>
>>>> +       memset(buf, 0, szbuf);
>>>> +
>>>>           p = &usr_reg_state->usr_state_regs[0];
>>>>           for_each_inst(i, adev->aid_mask) {
>>>>                   usr_regs = (struct amdgpu_regs_usr_v1_0 *)p;
>>>> -- 
>>>> 2.49.0
>>>>
>>>
>>
> 

