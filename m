Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B7DC88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:00:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89C6C10EED1;
	Mon, 14 Sep 2026 14:00:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ori51gJz";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011052.outbound.protection.outlook.com
 [40.93.194.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4708B10EEC6;
 Mon, 14 Sep 2026 14:00:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpeF5LS8qIB+zyblQtOq/Po4d3EdbNkX+KhbqZ2mNv15MMACXU3UuM/+gcE12E3RIC3FBKaCZff/Jo2hfIEokKmey29liRR8dyykuz5/ga4PnO9kC+527EHt62QwvxN/aIeNnADEBkVdHgUT5LHT3lT/mPKtcGdLzpa9tsY9wQwpPBA/fjSq9S2ah2cTpkY7S8bqbYSU+a+YGpDbaZfEwMrvbIzYVthkCDb822xtKkjCA1pNluO3cNauYfa+KUg/F9Biyc++bcjrf5+aAiUF0hR7gZXiuwuH/9ZHuifEqU6MlmxPJ1H/ldQz/7fIs6Z7vo9yYkodQuH3aI3RKpMsfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+hNOkDVFhRRxvg7C+kos6VHqJitfihQfY8GrDTZxKg=;
 b=tA8QIc+WGAB/lmb49Q3obu9WcwV8jFGgP3q8/9sqQ1bV4qPnUdh4uWCnPP2bzaYsZf59ZmQymeeBiNBe78QTEf+z7/QwJI2IwffRRpztTn+RGVDeh8dtNnx7YaIauZlsr7qANcDW5N5QNS4V9ya/BqToMWoJr9rHBmV81KT1ll0ie6Fjp6U5Iah/FoJ4FvhkDqAevyHWLd/Hpd8mxWt3mqI1VvnXvof+/KSWZBbrl8zouZaaTmfNp5TLQ2GhhdsSHP7bWlMQfgtwB0pmu1xeFHiRSyaIo9dPj3A+SshefmGGKKdALVqiKdWhfQqRQYkqHCtqbEvyUulCYiuzylxaTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+hNOkDVFhRRxvg7C+kos6VHqJitfihQfY8GrDTZxKg=;
 b=ori51gJzqzu57cxXtDCUdhC8luTSey1DX8AAfYuQbBRks1GIcNBa9r8/tpd0CJl3vmch07+UJxTc6QjB7iwgQsJJXBt2SQUED0GF5T6LelN0okTHcy/42Dd2+JTMyobOcQG+A3KWs31P/1lUOb1bI7kIgjmNOYv9s1h1VkvjBIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN6PR12MB8568.namprd12.prod.outlook.com (2603:10b6:208:471::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 14:00:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Mon, 14 Sep 2026
 14:00:37 +0000
Message-ID: <bc9cf07a-ef97-490a-b98a-a05bc9f5b186@amd.com>
Date: Mon, 14 Sep 2026 16:00:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: zero reg_state buffer before filling it
To: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>,
 Alexander Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20260914135650.87591-1-Dmitry.Chumachenko@cyberprotect.ru>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260914135650.87591-1-Dmitry.Chumachenko@cyberprotect.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P222CA0028.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::30) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN6PR12MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 9da5a203-1878-475d-12c6-08df12688d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2AWE3wGet0ZKzVOKsT+dJhLcNHMUv71gc7dumfSUh+vC1YLhpmVoEWgeRCEENTisERtTmixuFemJiwbijikCLB8AQDsB+SfAr7k2rWuzS8y8krL75ftEPLU3nMLCsk9v1vezWSbOCb17OovWaX8SG6lzo9peXIWnoCCXiwGxklictd0EaKVOI34qHgfgz8P0FiFMDGA2njbFYoNrKEhtdM97+WoknGNmWJXca0a4myktlTRWF50OraCtwOj9vGbLWhMRqHgv+sEhaYrg8UMwKrI1TPWWVadklHmhCtH6jfrcFlc00LbgsXP2Lpe0KEbaEwi3ONZXlf7JHuwvt4/p33BYzLMo6DlhoK8RlH1N5xQr34ortEtU9tNmDp0Oo5z3nK9ou6IFFyaoZEno7wXUgbq2bYvtn3myZfPIzR2JnEClmcvH2SvhiQtLPPO27ILe7vWZL5VbZ7lhVdUi5PPJsegn1MZMLRewxMtBuHVIvx/lMGzd71rIliF31EpnZnYVv6XVFgu3wiDsZdQWBL+2GKHxd6AkCV7UmuzZ9hdQaQpwYL1wNQxo7OJteSi4hoWo9oZWyqvFOYmEYEouqccqCsMxXWz+CSPGb9iL9TFcvvVymxJRXdlRUqqTKGT+9EmV1mGcMNQI0f90KiCrmRjqkcZ0TAltT3/on76l3pnBLOY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzNXUm1aa2Q4TjcxWnhkWm5rZFB5ZEQzQnZkUUpRdUwvM1BKM0hDdGx3UTZZ?=
 =?utf-8?B?WG5KakNacFd1QlRjTW5kNmU0OXBWbjRsZ3FFSkY2a2NSeERzb01hSnBPNlFP?=
 =?utf-8?B?SS9lRGpQSERuNFdZVnoxTUcxUUlZMVhYc3RQV1VOamx0VCtlMmk3V3VET291?=
 =?utf-8?B?RFJTU2swY3NBbDJrb2pzSDREQ0Q5TFh1L2ozNHdGdDYrRC9hdVZHRGVycmJH?=
 =?utf-8?B?TkU2U3c4U0JuUzFYL2ZOL1NtOTF5bzVMQ1N5ZEhLSFdzMVhtZzIzWFBnZllR?=
 =?utf-8?B?Y3JpK2RXckFuQlcwN1RIOW5GYy9ySVFHaXo0aFgvaTltQTFVQy9TcERWUk9o?=
 =?utf-8?B?aHRoMHJ1c25DOCs3c1AwblM0a0FvSWFGOWxIamhRQmgrZWZEaS9iVlkvdm9z?=
 =?utf-8?B?SVVxSFhJODErNWFTWExsYXh0V0VzRDRuWWcwK1dVK1Q4UWtDVkptY1o1Um1s?=
 =?utf-8?B?TzRHdlpCVmRYNDFCcENYQlJPMFpOYkNLaXZEcFJLY09CTGRWNS9XMW41WkFW?=
 =?utf-8?B?SjBRaEdrZnVQL3p0OFdpbHYvaFp6MWtCZU0vYitybXo2SkJOUkt3TFFKUjdW?=
 =?utf-8?B?dUR6TUE0MlZpMHNRd2Q0S1d0eW5Td2g1cUcwVnA1RnpmUzhReXBDWjE3WmFO?=
 =?utf-8?B?MTUvd3p4Y3BRQVdhZ0J1Tk53NkpQK3cvNmx1Wk1RaW5HbU16TUc4cnhLbVNV?=
 =?utf-8?B?dXRvZXJ2dmErbXByZzNwaFA5ZmVuNE9nZGd6b2FNQUE5bGR1cEpmaXArYjha?=
 =?utf-8?B?VTBHWUtqNytaTXBVMFl4Q3VTcCtxK0JOWTFpMk1RU2VSRG5WZW9VcXByTVZq?=
 =?utf-8?B?dWNrM1JVdEVhU0YrV0pGNFBPSjczdkF3WElPNDBYZElRS2tGRUF4NUU3eC9Q?=
 =?utf-8?B?Uk9aSXR0V2xHTXJsUmZZSmVoMk8vclFXR1RQT3hjZkFVUVBKNm1Ua3IyRU13?=
 =?utf-8?B?cjJTMUYya3o0aklVZ2N5bTd3MjhPUDZPd2lENlNSVWlkVEw0b3pSVnBEa1JL?=
 =?utf-8?B?UXhLNkhGSzNIMEhRWjZKOU5IMUN0VlR5cEJNYm4rTjdUZk9lWWdMbkorYkFY?=
 =?utf-8?B?bzMxdE9abmJxYVlVbTZHL0hxOVhTZDBFUTR0WDRoNnVlR210Sm1xVUhMV1ZF?=
 =?utf-8?B?VFBpQUdsV21vRkhuSXdYbVdPREIyaWV5anBjdDMvSk84YVcvVTZ0UitZbDdi?=
 =?utf-8?B?b3dIT0o1c1l3Z2llWVhVb1dpRnN6ZzJDNklKMEdzc0lPU0FoOUQxcDZwSUxt?=
 =?utf-8?B?MDZJeFJrV2xaWlRVVFd0bFQ2QWdTV29mZGg5bSsyU1NTZnk5RTM4K1diWnYz?=
 =?utf-8?B?c2kvSE9GUWxpaDZKYzFQSTc1emZHT0VmeGpqMmZKVFR2ZWdBdUJvWGw2d3Nq?=
 =?utf-8?B?ZTRKSk1JanpoMmxJaG9Scyt2ZWJKemQwQXptMWdwREVDelA0WDVwTXpjVXNp?=
 =?utf-8?B?TFRIUWNOR3RTM0pEN04xR084YlM0REE0b3ZmTWZsYVJvSGZwcXZVNHNBeU1y?=
 =?utf-8?B?WERFZHNUaktONlJWeDUwVDQ4azc0RVhLd082MUY3WTBQNG1POEo2ekNLZi93?=
 =?utf-8?B?RVZHbVpEQURiWGtGQm1vL2hmU2puUlVqN0lvcUlqcW1YMHlLQzZ0NnB4MEpN?=
 =?utf-8?B?bGdtMG1zdkxzajNQUVF2ckNDZlFJS3RVdWV0VVBrUS9lMmRKeEFtcTYyZGND?=
 =?utf-8?B?TE1mSFdDMTE2dkNUSHMyaEVpcklaZkcyV0FjMFlaNWVjRWZmVDZtZUVqcTY4?=
 =?utf-8?B?MkpSN1h1OFpUcUxYUDlmeEpqSURDU2JkZEhmMFRCdE9OVHU3elZXc3dqckF4?=
 =?utf-8?B?dWpmblQ4QXVNcE44N1RGTWZWYmI4eXhDY3FSbXRKTFNWeG9aTlBGWkxIRXpX?=
 =?utf-8?B?NVJqalBudHd6SndtTmZ3MWVtQXZUb3RPVkF4YlpVRHBYeGJDL2FDNW40bWFv?=
 =?utf-8?B?b3JaUEVFNmo4OHRPY0JKWWZDRmRaNWNSeGpvelgwT2tsQThsNTE2bUY0Q082?=
 =?utf-8?B?dXFUT083cmppU2RPOWtPbnEyd01KQVE3aUZxVWJQMWtmMW9lcG9LTm8ySlha?=
 =?utf-8?B?RUdNUzBKN0NXb0RkL1dwaVVETmg1cEtPS3lFWFo1UmVkdDRIeG5vZUg1anZw?=
 =?utf-8?B?Rmh0YkZneUhudEYwRm01ZmQ5Q2dWUXNBYlludlc4cVI0bUZkWFprR0haa3lw?=
 =?utf-8?B?Tkg2TU9tQXRiMU5kbmFpcGhxS0NwTW5qY1kwTzhjQUFkOWt2cGdRUTNHNWdE?=
 =?utf-8?B?UUJDUkx2eVJpakJ0S2hLNzh0WXU3cVhvN1NHMWJPbG1zTGRyeWpaT2hQTjF3?=
 =?utf-8?Q?7C6NeAZ+HZLlsTILIw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da5a203-1878-475d-12c6-08df12688d8f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 14:00:37.3103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKwvn+HmQffXnzklNgkiYK1xI/q1NCUqPGjsL8uqaEdB+zP8S3WoGDPmp3DX6AfZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8568
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

On 9/14/26 15:56, Dmitriy Chumachenko wrote:
> The reg_state readouts return szbuf bytes but never write the pad members
> of the headers and of amdgpu_smn_reg_data (and, for pcie, the fields
> skipped when the upstream port or AER capability is absent). The sysfs
> buffer is a plain kmalloc(), so those bytes leak stale slab data to any
> local user through the 0444 reg_state attribute.
> 
> Zero the buffer once the size is known.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 081a6eda2b25 ("drm/amdgpu: Read aquavanjaram PCIE register state")
> Signed-off-by: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>

Good catch, but stuff like that should be handled by using kzalloc() instead of calling memset it manually.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> index 72ea37dbfea8..0086de0f685d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> @@ -610,6 +610,8 @@ static ssize_t aqua_vanjaram_read_pcie_state(struct amdgpu_device *adev,
>         if (max_size < szbuf)
>                 return -EOVERFLOW;
> 
> +       memset(buf, 0, szbuf);
> +
>         pcie_regs = (struct amdgpu_regs_pcie_v1_0 *)((uint8_t *)buf +
>                                                      sizeof(*pcie_reg_state));
>         pcie_regs->inst_header.instance = 0;
> @@ -702,6 +704,8 @@ static ssize_t aqua_vanjaram_read_xgmi_state(struct amdgpu_device *adev,
>         if (max_size < szbuf)
>                 return -EOVERFLOW;
> 
> +       memset(buf, 0, szbuf);
> +
>         p = &xgmi_reg_state->xgmi_state_regs[0];
>         for_each_inst(i, adev->aid_mask) {
>                 for (j = 0; j < xgmi_inst; ++j) {
> @@ -776,6 +780,8 @@ static ssize_t aqua_vanjaram_read_wafl_state(struct amdgpu_device *adev,
>         if (max_size < szbuf)
>                 return -EOVERFLOW;
> 
> +       memset(buf, 0, szbuf);
> +
>         p = &wafl_reg_state->wafl_state_regs[0];
>         for_each_inst(i, adev->aid_mask) {
>                 for (j = 0; j < wafl_inst; ++j) {
> @@ -902,6 +908,8 @@ static ssize_t aqua_vanjaram_read_usr_state(struct amdgpu_device *adev,
>         if (max_size < szbuf)
>                 return -EOVERFLOW;
> 
> +       memset(buf, 0, szbuf);
> +
>         p = &usr_reg_state->usr_state_regs[0];
>         for_each_inst(i, adev->aid_mask) {
>                 usr_regs = (struct amdgpu_regs_usr_v1_0 *)p;
> --
> 2.49.0
> 

