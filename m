Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB7CC88E75
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB89310EF36;
	Mon, 14 Sep 2026 14:46:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lnys3PHb";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A02C10EF32;
 Mon, 14 Sep 2026 14:46:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGr4Q3mxw22w754fRffg293iNekFi8QJjdwSs713G+vrxTElnu6KOjS7NxL7+s4IHkonjDGlAEhGX0t+yQBFqpFy1ndDIvxXyfSdf22Hk7iI9Ztbhvu8UzXLV0N5zLjYK8X2h4S2lFZBtwtLqxd87dPcvsRnWMWN7E0QR1ifxiw5SN5FIKnq4dxHEmJfduRbDeKOb0QxwMgN3xyZf7KxGnxF8HW9oj/ssFB8hopSEkKPs2n689PdVco4uiMx8rBVTyKzQPNhfJGDcY/W7qAfLBtXwclcysXjEEA2PvZ2YJLr28VGHZSnq6DFE+l71Dfm6n6ZeVOzIxjG03OtScZlgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxYOcCyCdle1ZXiywb7YXUMnnCJ6m3gXGeZEO2caC6M=;
 b=FudexCL46Tbt/DcGXM5VGjyTQwKo4rCK/TiT6wM1owjFW3W5SoQ2PaaB6HXaC3uVjcFhM/YWrG4EL/wES0y8TUDznzMhBCTL3SOw0dIQhCPw6+O0M3/WQCF6G6DN/5lNyq/ogLu78SpO+R2yUt46t55Mqno76yZJJn5rpqGDMTV91CaRkbopIzTPzWZYCxxFyFJj1Nh5b/Br5umrHWct22asXs3COoQBNUo89u3mqqOSfsmhyYIdGMqcQ3NLib1egq1cm3vmhHMIZBNiAUVy1WTvi3aLZyCv76tc5wc5yqtHU/WI6sczvOE6oFFtt3S5gGtM4EqPYggVgninEG1tow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxYOcCyCdle1ZXiywb7YXUMnnCJ6m3gXGeZEO2caC6M=;
 b=Lnys3PHbkskQ5YI35io1Duemc9CirT/4jNLhNxBVgz80O6+bxvsn2B8uFZdQ157XMcWo8hSLK+dIIA0AyiA9iKsvHmZ/OThrfiXcd4W3AIZSN7ft8K6rBx2znlzR+JCWyOJ41HYJ/mRK33G8qVDP+8YYtG2jeH7CpoEkQ0XNHDA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SN7PR12MB6715.namprd12.prod.outlook.com (2603:10b6:806:271::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 14:46:17 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 14:46:17 +0000
Message-ID: <59194d11-c21c-40e8-a41b-2d91b31130cc@amd.com>
Date: Mon, 14 Sep 2026 20:16:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: zero reg_state buffer before filling it
To: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>,
 Alexander Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Samuel Zhang <guoqing.zhang@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20260914135650.87591-1-Dmitry.Chumachenko@cyberprotect.ru>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260914135650.87591-1-Dmitry.Chumachenko@cyberprotect.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::10) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SN7PR12MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 67360ddb-b918-4326-e672-08df126eeea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: wPHIpgvlKpPIKtHlAM753rGNz+TgvUuh0PfQ/PObELVA+btIj5kAznWt7bkT63I0AmQS5R5ULBaZ7ZoNK27lO71GIXrdvGmwIWXbpRH8HloPgLbBV+1qwxGiUZXUrRdWPtRX5Ci50ppo6UY9RZ1xwHrGr0iCerHxrst9sKiOl41rtswSmGU4zOYrww1YERp+WQqKzEvrgUoXzgVEOOj7+UVu0Zuj1avUnn3L3mspJdsiHUj6azAm19X5jkRsNukPHCQjdf7EbUyk9H0dCkGPy/N3mEpuYpD8Eu6e3qHyCaQF3ZiYtlef5fQlcY1K1UeTkW0PEVoD8OLJTXwVzTwxPKLEZizQa4++Rtp2L7ZWbCiNLQtAYHIaTxkRW7ZndmJ4Lm3+iUaCOsq9F5LRZHB8F37n7tqrN5Pp5SYkewRxF5YTy9ZP6435mzOLpgwQZPC9TZA+6vmFPaVvvjgZr5JBdYmqtEpOdJ3K+ZahO1/Q/Gq6PrMGkfJtxfc+S/16K/l7kTfalRZt1dNQdJ5Puo8QZBgAGo5Vex7F9VifwM2601mizhoQ542oelBRmdzIyeG4GMR1R5l7zrqfZJZcFpQQvFigbV+jnc3AOoo7gajqE4u8YJ8qlrICm9xpKLynWNnYrUk6EAdz+YMmANF2y/Gy2nA7thREEWnoVPrY80Msebw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enNmNGR6WHFhWU9kT051eVhHSys3eS81RHROekRSbWVWMFVFWDM1aHRGbEJp?=
 =?utf-8?B?ZU9yOW9OSmFVY1U5bGQ1a2VTbjZDYVZWcjhkT2xtaXdva1pWNmxPZlNackNm?=
 =?utf-8?B?YUx5d3VXajZ3M3NBTjdPbTBPZFJsWmQzSHk3eXpYUnh3WE84aDFTa0U0aGow?=
 =?utf-8?B?UndYS0o2akluWXFPeUs4N1FYQzdrMmdPMHFIdDlyeVZpSHVIY3lGbjc3WHhT?=
 =?utf-8?B?NlM3UDczVlBYcVZoNTdReE81SW9mRXNCY3FOZW5UYk9LWUVrWWtQSGZPdUJn?=
 =?utf-8?B?VGV0Y24vdVpyNVA0aEIxNzVrWU8yUnFYdGt0bFNhUU5vTHJXYTVpSTFIcVVr?=
 =?utf-8?B?S2l0V0NWUkNDTXYxbjRFS3lzVExNODBSbkF1ejZYZ0t0ODllNmR5RTdxcTIw?=
 =?utf-8?B?d0FXenRIdWw2SXJEWGFwUHMyTWorNWN1N2pYMjIyT0FzdkhlK0JidWtnc2ho?=
 =?utf-8?B?V0YzSFlkZGZLR3JlVEczUG5TUEZpdGdVVmN0ZHlhYWpqNHFYSjJtcFpNMmsz?=
 =?utf-8?B?WldSWDc3bm9PbW9aSHBKbkE2d0JLd2JmYkFEbmtRcTduSEt2MXB5ckhjNjFF?=
 =?utf-8?B?NDh3VE1aL0lQYzlUdFA5UnVNbFBMK0hiUEYyU3JmTnZLNzBaQkl3L3RDcHYy?=
 =?utf-8?B?amtsNE15Uzk3M1Q5MlJyWlQwZGpwNk1nc0F0NVpwUlRkenJBdWZqOUNZRVhj?=
 =?utf-8?B?N3NUaGhNYWpDVzlaSFJKWWJ4YTN0T2FwSnRFNTNheVhETUp5ekpBSkVuTzBQ?=
 =?utf-8?B?eHNpK2s3dTQyUkxPQUo1ektsQmFEdWVVT0JzZERMZzdFUjVHK3YrSzkyc3o3?=
 =?utf-8?B?Wng4ZE5DZ0VORlNBKy9sNDVsdWJDRmdsYStYc0F3Rlkvd0FWb294QmpIN0JE?=
 =?utf-8?B?ZGR6Zi9tSjJRYjRHOGxMT3kvVTRudXhjOFMrWVRMN21PMDJ6RDI2OVJIM2Zx?=
 =?utf-8?B?YUIwaEJWd2V3MHBicm9FTlFudGEvVXNzNXdJV3hkL1N3OVNUemx6T0Y4Zkk3?=
 =?utf-8?B?N0cyLzA3M0RRcVdvdzREeGVRTjVMWkMvdmpaNEZML2ZSSjZzVnN2bXRrMGdN?=
 =?utf-8?B?dU9TMVlZVUh6ZlR1YktseS9Wd3hVWjQ0RUVxMk5GSDdLZm1pWDNzTnFNYUxo?=
 =?utf-8?B?S2FvSG9IMERsZXozV3VQZkxYMWJBN3JWRDZqVFlkM2VCMm1vbTFweFhLTDI1?=
 =?utf-8?B?SHVkQjBzWUdtb2N1V2NZNWxOMmlab05RWVpjUEFxZTdUOXJoNXQ5SDVCbVFl?=
 =?utf-8?B?UGI5MDFwcFNqb1pRQitwWHgrUzFyeFBoN0huNmFtdG9rWlVtVUloeHFjMVhM?=
 =?utf-8?B?MC9LSS9XMmVPRXN2a0dnVHFBbVBoUTczUSs4cEZyL29WVXVSSTQ5amRRM2JB?=
 =?utf-8?B?VW9hREd2L3lGM3BtMFJWbndBaUZmV2ZQL09CNUorUEhwYWJjaDJmLy94bHA0?=
 =?utf-8?B?VVFOSE1GWU9QV1B5VWt3eWJobmFPUW8zL0VVd2NPdndiV3d0dFdMMHp4WkVY?=
 =?utf-8?B?SEJaYmhXKytxYWsrU2dVekMrTFc0ajBPTnRvS0tWTkRCOU1WNklEOTdOUGcv?=
 =?utf-8?B?dTdCWTAzZEhVemZCN05sa1BWdjhxREhQWU1vS2ptd1hiMk8rRUx6L0lhNVlE?=
 =?utf-8?B?TjVoeEUvRUlQSzdMY1JqbW0wOTdkbWNuZjliY21lT2VUeGdjS1R4dGVmbDZX?=
 =?utf-8?B?UUlDR3RpSm1uU1dWcFJxcFNBTlZwTmtrbnUvNVpnRkM4NHBIN2oyUkVXb0FJ?=
 =?utf-8?B?eDNtUERBSWZXVWhrSXI4RkZOZHJKZmNFSHR6c3F2cVpWZDQ1NERSTERSZVBQ?=
 =?utf-8?B?ZTNRL0hxaVFoSHV0Nm5GVHQ4dVhtTTc5TGFCdWJyc2Q5WXdTYnloRTNyK3F1?=
 =?utf-8?B?b1Zzb2hvU0hyZkh0OWt1aGZqVzFtU054Z2dZaEJTRjVBSFEzNHZXTnVhS1Yx?=
 =?utf-8?B?WTNoQXl4UTJ2TThDdVM3b0djdEIrQkRCL2k1OW5aajhWYzU2dXpzdE5SaXJW?=
 =?utf-8?B?NU1idU1qQ1ZtSGQ2NENzZ2NWd1d3WWtJc1RuYzU0dVhJaE5QL2MxUjlqZlFH?=
 =?utf-8?B?dHozWDZXM2xiK2hJNzA5YmRUTGRqSFhDWDl6US9EU2ljUWF5eVd6VlE3UEZI?=
 =?utf-8?B?cHZSZkJSRFpCTElOeWxwTXpQV0hWNGxLazdaWHFuZkZtSVpMV1R4VzJ1RjVo?=
 =?utf-8?B?SmlhNFZmOGoyYkNNQ1BVSDR3czZvWml2cEpsTkVGVUpYeHpaY3k0N1d5TllN?=
 =?utf-8?B?UjRRMmxkaTZ2b2JDRlNPVHpBaUI0QXQxNHVJL0V2RzAxdThNL2hMdEpzNHFn?=
 =?utf-8?Q?sd7pYiPDIcQRvqc01X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67360ddb-b918-4326-e672-08df126eeea6
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 14:46:17.0417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyvY1boRpDjSHQhuwPr3dg+HUphnu+hpNOICDh8tGpqsNOOX6pc9Dtgu3W/bs59k
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



On 14-Sep-26 7:26 PM, Dmitriy Chumachenko wrote:
> [Some people who received this message don't often get email from dmitry.chumachenko@cyberprotect.ru. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
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

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> index 72ea37dbfea8..0086de0f685d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> @@ -610,6 +610,8 @@ static ssize_t aqua_vanjaram_read_pcie_state(struct amdgpu_device *adev,
>          if (max_size < szbuf)
>                  return -EOVERFLOW;
> 
> +       memset(buf, 0, szbuf);
> +
>          pcie_regs = (struct amdgpu_regs_pcie_v1_0 *)((uint8_t *)buf +
>                                                       sizeof(*pcie_reg_state));
>          pcie_regs->inst_header.instance = 0;
> @@ -702,6 +704,8 @@ static ssize_t aqua_vanjaram_read_xgmi_state(struct amdgpu_device *adev,
>          if (max_size < szbuf)
>                  return -EOVERFLOW;
> 
> +       memset(buf, 0, szbuf);
> +
>          p = &xgmi_reg_state->xgmi_state_regs[0];
>          for_each_inst(i, adev->aid_mask) {
>                  for (j = 0; j < xgmi_inst; ++j) {
> @@ -776,6 +780,8 @@ static ssize_t aqua_vanjaram_read_wafl_state(struct amdgpu_device *adev,
>          if (max_size < szbuf)
>                  return -EOVERFLOW;
> 
> +       memset(buf, 0, szbuf);
> +
>          p = &wafl_reg_state->wafl_state_regs[0];
>          for_each_inst(i, adev->aid_mask) {
>                  for (j = 0; j < wafl_inst; ++j) {
> @@ -902,6 +908,8 @@ static ssize_t aqua_vanjaram_read_usr_state(struct amdgpu_device *adev,
>          if (max_size < szbuf)
>                  return -EOVERFLOW;
> 
> +       memset(buf, 0, szbuf);
> +
>          p = &usr_reg_state->usr_state_regs[0];
>          for_each_inst(i, adev->aid_mask) {
>                  usr_regs = (struct amdgpu_regs_usr_v1_0 *)p;
> --
> 2.49.0

