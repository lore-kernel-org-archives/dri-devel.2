Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08317C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:03:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AED8910E14A;
	Mon, 24 Aug 2026 15:03:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0QR1VRv8";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010032.outbound.protection.outlook.com
 [40.93.198.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D027110E14A;
 Mon, 24 Aug 2026 15:03:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OERgVx17vmHeGL3zJ8AI4M+BWjdL7FvV02BxId9bw6Id54AMlb9KrP466gBeANR/BtbE+YKxsiz2VCw5glWGATPIvaVDLr/nJnMWw6kYRk0e6YYLTgioQApiaabdBT+xKxzaAc0H9uhL3z74i2PtbB/fchVHIMHQjaNSGfHX4Eru31RxNSn0aanxFiRTvqHKdgBOiAbopMtzSLdjc5v4/RSTjN9yD686m1+xrHT+VHOtGtJIHYIQNOWjqxGOP2eXQfTrXCNYHkNVp9nfUMPMTyVWJkoZ2EsKnduQ8N5CkvcD+krkZ2QLLHndu/TzBcNXwGsLy603xQ2mZ6ZY6v/W/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpht7hnHwZb5ZPZwoufkFHmbLNXwahUHNbIAMMKo+3U=;
 b=dQ45KblrItkTjtQ0nmeCeAv2y7c6oa8SvwqeXZFzcNte9XGHG9YaL+yaXI0prsSNHIDMm44RfHmkQmee70121UNc9/+lze+N+WkorNMMedz4ED94eTSadXJNlNhaJYsUHkeiVyvkBWS5KYl24dfnIdvazzzZIm2+ZYoCfnSCABKCxieKGen1PPVwCYb5vwAOS9eAtbngu60+iEJ5Q5pxjwzMWABoGMm0cQG+HyCcHvi+Uew8HLKDmPB5jDgOx6DMROo5Cr6r8HxUxJ/lL3jPsAZyuMKebJbpHLzF6cRWFpUthhNMfn03ueOtQ460WMq7A3FvduABO1GDg4ikDFiCaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpht7hnHwZb5ZPZwoufkFHmbLNXwahUHNbIAMMKo+3U=;
 b=0QR1VRv8+a8+XWmkTdEfvYfkAc03NhKK94yafifM9QTNP0ZCNARnxzwl1bahTAACLYf0km8arMVSfHqHkKgR1T7DFCgVppKhMiinE/M8kmjvXDZCettNexeGX3QElbHYfxGVGSJwKKASPBX3QS+34qO8mMKzjAcT++t5Y6FZLmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 15:03:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 24 Aug 2026
 15:03:08 +0000
Message-ID: <b99691b4-e348-4f1e-9cd2-ccbbce329bbe@amd.com>
Date: Mon, 24 Aug 2026 17:03:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Replace deprecated strcpy with strscpy
To: Amin Gattout <amin.gattout@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260818-amdgpu-strcpy-v1-1-3ee9b111fafe@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260818-amdgpu-strcpy-v1-1-3ee9b111fafe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ed0254-4e0e-443a-cf49-08df01f0ce5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: AZJD0IygZ5bThaNgQZuXMAmb17uROVJ28LIx5m7vYiaOEsPtuzRSkMfPB/BP91moui6bB1KdDWmWBxYasULw/1LNMc5MN1iaYpBNGK/HOgWJolHniipYTsaWeoL9PpEMUMjrA/oE5JxD+yJWNfOpPOTRX9H66p3uybYF4Vrg1Gcn/SEbMKaxVHQdOR25386dPaJTdLQa47/lz1+2x/hzUIMJRg1MCzT2lM8+8xk66R5Q+Ck7uh1y2UqTrdoEMUl/vG2EVbJXIcX0/LORU2rXUzdhcPu++HQvn6P5PUa0ch5e/d+K4YdT7fXxLqBTlfQI7eRf5BrLTd7qUBvV3yUbVMJw4Aa0KbzSGbSgIt7C27oifRnQ0VFPCyM2wEcGAL+a0oyfMonyff2jPe+YVjXD2oYCDvFFDko2QACDV762rk6mpI+XzPNIxiQL1hA12gfbeCaMbQ8iTzSoQqnm8kWeGFIhFkMBzU/ElCU2vAwI8TeoviEMJ71/Kr5eQPEKn+L3fAnRG0zoH+T4m8+oEdiZlGzacYR0nmS4Ppg7OPrDX8kUaQWDFp6UOnAvnTBtQhtNzyZfF8CcZoqxhJ1LlxyYY9lEeW0yidD5iRFjz/7CiJT4roxnTdRvFUrL3OWeuryOzcgFRFz9LDr2ngSJo0Dvf/SwIbLsYrZLbzw2x81feuM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGhjTVROWFZwRW5vSlBWQlZldFcrMDdoTkNNRmFiU0dUT24zMVRhcnIrVHNi?=
 =?utf-8?B?NGtnRE5jYUVycXpSTzR2SjNHN1VxaER1Z3E4dHNTajJlUkNLZ0dBT0NyTjlF?=
 =?utf-8?B?VHV2LzNkMlZnSlRDMzE5MTdQaG5lSWs2QkdOeURQcUlpU1lFWExRcDJnMXEy?=
 =?utf-8?B?aTY3TnFoT0hCbHpmVlJtcEpDWkZFaFFLbEJEejRrRVU3RU1SK3dXckxWd0tX?=
 =?utf-8?B?SC9iWmFBenVSMW1Jd1BCcUhyQStlMmNhN2RkZnlZUGhQbGZsdGF6QVE3dmFx?=
 =?utf-8?B?ajI0cFBCNXRmSDJjUmpzaGlYYUxHOGt5WjlNWGk5TEJZbkt0SWt6R1YzL2hY?=
 =?utf-8?B?ODBWSHVmQk9kQ2FHOStrbng1WXdCY25IZ2k5aExXVmhHN1pvZFpZYTJLU0Jz?=
 =?utf-8?B?cVk2Z3FYbzhlWGQ3M0dLcG1leFBGeDdJemlaV1Z0S3kxenV4N1FQZWhYT0kw?=
 =?utf-8?B?SkJVUlJueEpYT215cU9HbWdxTksyV3ZVY09HSnBYaFM1cENuanVrb2RZdHow?=
 =?utf-8?B?MnYzbCtwdUhvSW1XNVkyWkVhRzE0ejg5dUl0bUFMTEZmY1hYQjVPb0VZZ1RY?=
 =?utf-8?B?Y2hHbDViKzhTOHpmVzNKZFkzdVA4azI2UlM4S1pyQUlVUHU0VXBwUkxGQU4x?=
 =?utf-8?B?MTlZdWl5NEVKbmpmV08rMUFVcENwMnVQckJab01kRjhrMGRMLzVxLyt4WVJU?=
 =?utf-8?B?c0tERWZvTURST1Z1ZXIwdFd4SjgxOTNQeDNnVjlKU0dvVWFUeG5Sa2todGZw?=
 =?utf-8?B?VllmaytrWUNuMWtFV2hsSUtYaGdKRzFCYktSUHRBRWM4TTlVOGZhWEhBdjNS?=
 =?utf-8?B?L1VWS0QvOFBINTd5UTJjdjRwaVIxZTQrcjd0eUMrVy95RDJqWmM4Ujg2NXds?=
 =?utf-8?B?S1R1TENqRUhMV2k5MjhlaVpNa3E2OXJDb3IrZnkzcnZUbmluTEk2Y1lkb25p?=
 =?utf-8?B?ZnlUVTJmQjB4WTNVbEZqbXpMVVE2VDgvRVltK1NBeWZNbThXeEhMcnNqRlpo?=
 =?utf-8?B?SGQ4ZFE4QTlpZzAyYnJWZmxSckJpdzZobHVac20relQySENsR3hLMUZKcERZ?=
 =?utf-8?B?WGxTZGNham1ONU1aZ0JlRVM5ZHdqSmdIOVZPMUM4RnhpSzZDdnR4TFcwYzRS?=
 =?utf-8?B?bStESDBURlRwbjdPdklTeE1uUGM0SEFrM0tQUUZVT2N0Nm5VcXdUK1VKVVdo?=
 =?utf-8?B?MjZWcVdjQVp0MERxQjVpbm1KYWZXNVVqd0FkS2Z2Z2VVcTNXc1VwYVh0WlR5?=
 =?utf-8?B?dGptUFFCVXNwSVFUY0lHc1VDV09icnhOd2xuTVB3ZlYzeFQ4RDJLcStrQWtR?=
 =?utf-8?B?VU85UEFxVWlDWm5aMytPRmdySjlQZE4wSnpOb29WTWpQbGhpN3VhT3ZVWlZI?=
 =?utf-8?B?NDgwWFJMKzhCbEU4d1lIQmxXdVJULy96ZkZXbFhqSFd6K0VLemRxR3JNeVlj?=
 =?utf-8?B?MHdJM2ZNQUlmMGZUZzg4Unp6QmFiWDh6OU1QdUxEU1VCejlkOWZISDd5R0tZ?=
 =?utf-8?B?RGd3OHp5RHJlK3BYWlJVK1k2UmhBcVAxc01uZllHbm1Wa1NaeGU2KzdCTHRk?=
 =?utf-8?B?bmpwVzIxQjRZVGxkMGRpNFFwSjBuTzVucURyakk0VlZoaHJnZmpzR25MdDRk?=
 =?utf-8?B?OUpUbVlCVEI4TUtIQjZLZWpiRmswNVNxd2lSaEFZc2pFYmhUTmQ1TWc3N282?=
 =?utf-8?B?bVlaK1pmdDNzWEhMZEZxd3dMVHFkRGRIemFRdlU2VXFHalE0T041cFdNU3Zu?=
 =?utf-8?B?YThmVnlDNDZJYTlpVEtUejgydGhhNmNLc1NjY041VitDQ2N4ejg1aXdML3Ir?=
 =?utf-8?B?bW1QeWdLLytIbUhENDBxaFg2VGxMdlpUYzdwMnNpWXpRcmI5d0RiUkJ3VWZa?=
 =?utf-8?B?cjg1WVZjY0RRaEUzTHlVVHFReUw1S3NPUWcranREWVVzalZSckZ3TkNydFdW?=
 =?utf-8?B?d0pqcFhCTVQ0RUNUenRnc1h3NEttWGlkQi9iM3dBSEptb1BhSUZ3azg0OFlJ?=
 =?utf-8?B?dVlGN2VaUTgySVVsR25sQXJFTk04TFlleWNoZnNjdHNFeWlzR0hxZEZNRnpB?=
 =?utf-8?B?RW9jSllncjNYMUdkWTVvbi9RZHU0SkpzVy9PRXR3a0N0d1AwLytwSi9DQ3Iz?=
 =?utf-8?B?Q1QwSzhqZEp6U2dlZC9OM0VIeUxLL09RQVhsVXlhSTVEVWpXc01Hei9SS3pT?=
 =?utf-8?B?VW95cjd3L1htZW5TUG9kMXhUTEtLMnJReXhGTGVKYmlOU0hsZHhhUHBlVVp1?=
 =?utf-8?B?bHZkaFhyc1VnMG1Hbzh5dmVkdkJ2b1pMMmdNY011YmJ1VjBLWkZhek84N3h2?=
 =?utf-8?Q?T2FiInxTtsk78bv9a8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ed0254-4e0e-443a-cf49-08df01f0ce5f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 15:03:07.9404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GXogC64IXUB7evHJSRw6IccT9dqoNN3PX3rDVZ1UfinzifboEE6a63Xli6eKMLPv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7284
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



On 8/18/26 12:32, Amin Gattout wrote:
> [Sie erhalten nicht häufig E-Mails von amin.gattout@gmail.com. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
> 
> strcpy() has been deprecated because it performs no bounds checking
> on the destination buffer, which can lead to buffer overflows. Replace
> it with the safer strscpy().  No functional changes.
> 
> Signed-off-by: Amin Gattout <amin.gattout@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> index cc6d1a4e4c3a..1caa393c44d5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> @@ -97,7 +97,7 @@ int amdgpu_mca_mp0_ras_sw_init(struct amdgpu_device *adev)
>                 return err;
>         }
> 
> -       strcpy(ras->ras_block.ras_comm.name, "mca.mp0");
> +       strscpy(ras->ras_block.ras_comm.name, "mca.mp0");

Well taking a step back. Why do we use strcpy() here in the first place?

As far as I can see ras->ras_block.ras_comm.name could just we a "const char *", doesn't it?

Regards,
Christian.

>         ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MCA;
>         ras->ras_block.ras_comm.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MP0;
>         ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
> @@ -122,7 +122,7 @@ int amdgpu_mca_mp1_ras_sw_init(struct amdgpu_device *adev)
>                 return err;
>         }
> 
> -       strcpy(ras->ras_block.ras_comm.name, "mca.mp1");
> +       strscpy(ras->ras_block.ras_comm.name, "mca.mp1");
>         ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MCA;
>         ras->ras_block.ras_comm.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MP1;
>         ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
> @@ -147,7 +147,7 @@ int amdgpu_mca_mpio_ras_sw_init(struct amdgpu_device *adev)
>                 return err;
>         }
> 
> -       strcpy(ras->ras_block.ras_comm.name, "mca.mpio");
> +       strscpy(ras->ras_block.ras_comm.name, "mca.mpio");
>         ras->ras_block.ras_comm.block = AMDGPU_RAS_BLOCK__MCA;
>         ras->ras_block.ras_comm.sub_block_index = AMDGPU_RAS_MCA_BLOCK__MPIO;
>         ras->ras_block.ras_comm.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
> 
> ---
> base-commit: 0f23d56f17fdfc7db69d51f64c8b91bbab947aa9
> change-id: 20260818-amdgpu-strcpy-0e92d18299c6
> 
> Best regards,
> --
> Amin Gattout <amin.gattout@gmail.com>
> 

