Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F05D35171
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 11:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E54710EC99;
	Wed,  1 Apr 2026 11:28:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ubOToQML";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010054.outbound.protection.outlook.com
 [40.93.198.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8B2A10EC28;
 Wed,  1 Apr 2026 11:28:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BcybBJ7paqYtrNp8fElsItRrXVDBcOLPG83JbiRfjpjb78y/I7uDNjGX2xpGauiToMMaqPEKn3I+Fo4nNFvrDlWOpSjMgYYsKKeD+0B1sD62lQe64MYegzF6fygL0zykqLu9hSxID6EEap0B6HPiY/fi0K9lyZ2zq+66iU+roy9cHXgClEhN9LPOaI0bxlUi+69Ky+x/lElsdgA/chtbxSelY4TtQgHUaees6prGtxEY8mkiQQ65hmQKbla836Hx+z4N7db449pxhG/ilCvDGMCHLmBOlj1YkCq1hToFeAHgOENX5B6oy3c0sg3XRc4mUfmMRa2Ida29UGb0xAjIHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAvZCPobb52rGoO11vxuZhrCltTOTeySCTb+fGJafOU=;
 b=F2JzHTBo+FIkpm7sXjTGSfo0XsSO7t2XTlgmg81Rq73CMAK0OagHXcll4bW/lbFsOwL5x5AoC5JE37Swi2C38qr2j3lSc+mubNepNUhqmBL9PaVyP+BBaZlh2yuKSXpTOnW1nKeHrwWTfMZeoKSN0ow28sBVYLElRdJ+sFefwAmUr7EbWChw4BqKtM5TE7g0zxlyW75Jp7xELJphFkSTBIIMam+HZWuB3CU8RN5tY01JCGN9/K2PQWFhwBcUWGiNN1CYz7a0OYW3PjoPt9mLC8oZjnd43EzD1sFADy2aYzS1D5cazinv5Sgu2qCESADKfKCBu9pkDCtItb7YMscH+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAvZCPobb52rGoO11vxuZhrCltTOTeySCTb+fGJafOU=;
 b=ubOToQMLnJs6riq8ACRyxVfgxFt1iNZ6FJIBRlHaz+UQB4rPRK+o0GbcPPzX96QfmQPAHandU8GvpCBk/Yn3aZI/vlg2C9jAiQW6mSk1HrEp9RsVIwcXN7xTcbYNoldHEsqKAYawrUaoiVMLosnLqY5mmPO15bOy43pnd256XbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 11:27:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 11:27:58 +0000
Message-ID: <6cfe5067-a08a-4477-be57-e635328c0bb4@amd.com>
Date: Wed, 1 Apr 2026 13:27:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: use IRQ-safe xarray API for PASID
 management
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: lijo.lazar@amd.com, Eric Huang <jinhuieric.huang@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260401112540.451773-1-mikhail.v.gavrilov@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260401112540.451773-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a26881-fb68-41a8-29b6-08de8fe1ba29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: FBKweTgdm7Q7eoq8Pzl8DIfUimqfypl3M/quaEu9C/WH4N/2SCWwW1ah6RRz/jowL7K7f7dDRIltzu5b9Vy1mSM+s7pAloQhdIr9UkDEpYyGHwEUgoI44HZk2d7sWPY+DyOgveKPwaa+ZklEQd/X03mvmzsq6DjdWRvF+vEjKQtBX0u1P6dDXCRXIdETrNl5204e2uc8uxWqNiM66ktSabXRH/eS6aPgh/AB+1Y1gm1xNTsvvOdINRZIgvq9DlX3kH5fGbY2JLqQFJMeC5I7tuQL84QWFUEl8oJ4vtIO5DvBrF5abcu9DF2CFc6ztcFi0YkuO4qZs2RdIlWpDq6PfJk4/GJS2NxOeaRZ9gUwFl1tqA3rN42VncOa0E3MQtSSVHsnu1ek5h43FpYoYqipiL7ApbWWf41QJGyewGlh0KP8pas60cWyJ2PuIY/usup3E5kl4sh1uvem3nV3Tm9t7whVwIs8aB318F8HvV/7CkZW7d2+pU7RZ5eYq1i7ryfB9K1dBHUHAa28Pkm00RmzutMkWCGvC8qhXr3LasXDcsr8ExelixT+2OlsN5X7/8JxU/gJ82jYnyKapg7+zOfTDjW5sNJFI7T0bSL185VSlfLza4yqHBlPdrMWNrpBpUdZEUCf2mmyFjHleurN5GMmN+5uFZzAwEvf3UHZxZPFqhQ4iAew1ufArHu8xC+tVH5gZ9LhZtb9MM03VmJAByPYi1vL7QOsqFFhX9HmplAqVKk8RxzqKR40JhLuE/tALxAb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGVwSCtVdXJPNmhieG9pcWtuVW51eUhvVjNpb2x2U3NLLzcwcnNocWhTbmVY?=
 =?utf-8?B?M2VsMVBNQTlRblJRSCt6WExGNHQ4bnBUcnJ1eFFhRE96dGFNTkRidHlkUlQ4?=
 =?utf-8?B?a0h6SGVHOWRMWE9oVmFSYTJHUG92R1VEK29EaHNhSE16ajhmcFV1cFUrWFNO?=
 =?utf-8?B?L2NrLzROVWlMYS84Y1Z6YjRtMUFRdlptT1AvakkvUmsxdnFiQUNSUzdxNjNp?=
 =?utf-8?B?aE4rZTc2Mm5yM0l6cStVUmVaYVIyNDFPd1EzSVpRSDB3dXR2bVlPeWNXRkpx?=
 =?utf-8?B?NXpCMUgzYzMwclU4R0F5MHNndzRBMHRiSlI3cHh5NGt5a09EOWNRNS9NSk45?=
 =?utf-8?B?d3hMd2VPTnRYUHRaa1FDdndJRkJIemtCN29xb2krUzNmdHFmaWdjbzFvNHFH?=
 =?utf-8?B?Y3hGaG5UVHZ5aXkwK01wOGE5dUU2bE9hVzdYZDVnenhIR25KaGsvQlErNThQ?=
 =?utf-8?B?L0M1WHFqVjUzcVBVQU5aSVRRT3RHNkU1bk9mZGo4bVFDMllJSWdXcm92TUJJ?=
 =?utf-8?B?ZWpEWVVlWU9BSHN0YkV0ejUwVFNYY1N1dWd3d0xuUDJ2SEpKQTlyVG1Cdzhk?=
 =?utf-8?B?bkhENk1iclZaQWVUZ0dBY3U2ZWxvNzFtangwdnFNSE5sM3NGaCtsKzRoNEpt?=
 =?utf-8?B?YlpNV1ZiaWRHangwQ1VWcTBWMXArSDBFY3g2VjIzYXNPTjBWQmVMWmtjMStH?=
 =?utf-8?B?ZU1relpmSFlMMkxyUWdUMjA5azY1cDR1K0FpSlg1L0p6SElBS0ZpK1JwZjV5?=
 =?utf-8?B?NTFVeTZGSmpSaW9LZ0FsbmZvb283QkExRTQwK3cwbG1sUE1JRHJXK0RCOWFx?=
 =?utf-8?B?TGtsOWhYOTF2S2g5TWtWWjhxOWU0KzdsVzJqRkdiK3N0OFdHdlo1OGNic2FZ?=
 =?utf-8?B?QTFlcGdIdFZoUVowc2owZnpZOWJIUysxRURJeVNpVzRsRFphN2JCSU1CZFdl?=
 =?utf-8?B?NUhGYU5oNTRSR1BONitHM0xHdXRmMmp4SUpHVnVsb05LQzU4R3RPZDM1M0dw?=
 =?utf-8?B?NkJhUjljKzE2c2lpOVRpQkpYZVhxRlBOS2ExZnRiaUlTcHJ0RWNxWTZmUjZa?=
 =?utf-8?B?WUM0SHpSZFRiZDM4MFBGcHMwOHp4d2VkQlVjb054L3NSUlRFUmVHY2RHeGht?=
 =?utf-8?B?R3pTcTZTRGhnNmJBekpJOFh2dHhtT0pmZ3MrSktQMllzMEh6M2FFbXlvTjhX?=
 =?utf-8?B?OUhmYi9RVCtHa3l0aXE1SVJoNnFTQnRSTVp0WWRHWWRWdTZSQXRXSmdIdlhl?=
 =?utf-8?B?c2VVQmF6MEVQUDF6ZVh2cUhPcURmS0IwbnFXY2FxalJYQk5RSXd4Tk9NOHZM?=
 =?utf-8?B?Q1RlSktLMTUzbTYzelU2bDA2aWQwYVBpT3lRM3ZvVzRZa0FxS1d4TGs3WEJN?=
 =?utf-8?B?RWw5aSt5SndISUNsUTdYVW1wVi82Nk9aRGR0L01LVXR0c2ZBaUJMdUM4RWx6?=
 =?utf-8?B?ajVJbmtFaDRCcGdvRXM0b3poYmpXaWUvWHRKSndEcEkzSUQ0Y1h3VDJ3eWhE?=
 =?utf-8?B?aklpbzh4U0pFbkk3NFFuc2E1RVRDV2tjZVBhbVl4ZzJkMWtTVlpyekIzNnZR?=
 =?utf-8?B?UGZSMHpFOTJ6M0Z1QktvMXZTYmNvcnZGU05lZnR6SGJxcUZRdnNXeVVmblpt?=
 =?utf-8?B?MUg5YjVZRHNFZ1hreENicWdkVE9vaTVQRXRIMmNaRnpZSDJZd1dXNk9CdVU0?=
 =?utf-8?B?bDRRMzU2SkF6REwvdlFEY2JOSldJTXpuc29Zd3IrNTYycXg3K0FvcE52NU40?=
 =?utf-8?B?bHdNYjQ1dUJzTFZCS25Rdy9XdEJnMGhjMVVlYmEvaTE1YWJNQ3podGQwN0J6?=
 =?utf-8?B?dmZoOUZXQnp4Z3ZqM1ZLaUxHM055K1ZvTU50VVNMZFFOVytJOFhjazR2Rnla?=
 =?utf-8?B?V2M3T0VLSEVFTVgwcUREN0RXQ1Ewb05JSXpjZ2lMNkJZeks0NUg3aWVqQ0Fu?=
 =?utf-8?B?cTgxTEVQYi9VOStvYTVjaitid2tuUVFjd0hPNUQyMUZNVklkWVdaSzYyMGZq?=
 =?utf-8?B?WExZMHVzTkFrbUhjUE9JdHplN0psYzRPODNObTNyVHBCRklZcXpBZmhXd3Bp?=
 =?utf-8?B?RVBJeUI1WHU1NzJlWDVDSmlMYWdFLzEvMUc4MSt4SnBJc0M4NStOSEs4RTlz?=
 =?utf-8?B?VlBVZTNJR3BHN0gweXV6VmppU1BxWENYWWJ6aTdaUXdjLzFraGxxOGlsUmxy?=
 =?utf-8?B?MURiVjJta2t4L1oxT2RyNG9kT3lvQThiWmtZZXZkbFRJRHl5SXcwOU52dlk1?=
 =?utf-8?B?L2xYUDNqR1VUc01Wd1I1ZzgwdnRTSmY2dFRVelpXVU54amYyT0dPckFMMGFm?=
 =?utf-8?Q?k1wNFor+Qg8kvX/j0W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a26881-fb68-41a8-29b6-08de8fe1ba29
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 11:27:58.8074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tl0Hf51iVtal2oirjst9758i3w72mFoEK4PRte2HFKMEl1HySiIVIIFzhrMCcTu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650
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



On 4/1/26 13:25, Mikhail Gavrilov wrote:
> xa_alloc_cyclic() and xa_erase() use plain xa_lock()/xa_unlock()
> regardless of XA_FLAGS_LOCK_IRQ — the flag only affects lockdep
> annotations, not runtime locking.
> 
> Switch amdgpu_pasid_alloc() to xa_alloc_cyclic_irq() which uses
> xa_lock_irq/xa_unlock_irq internally.
> 
> For amdgpu_pasid_free(), use explicit xa_lock_irqsave/__xa_erase/
> xa_unlock_irqrestore since this function can be called from hardirq
> context via amdgpu_pasid_free_cb, where xa_erase_irq()'s
> xa_lock_irq/xa_unlock_irq would prematurely re-enable interrupts.
> 
> Fixes: a3c0ee978e16 ("drm/amdgpu: replace PASID IDR with XArray")
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
> 
> v3: Shortened comment per Christian König.
> v2: Use xa_lock_irqsave/__xa_erase/xa_unlock_irqrestore for
>     amdgpu_pasid_free() instead of xa_erase_irq(). (Christian König)
>     https://lore.kernel.org/all/20260401104859.36990-1-mikhail.v.gavrilov@gmail.com/
> v1: https://lore.kernel.org/all/20260401073632.101796-1-mikhail.v.gavrilov@gmail.com/
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index a6ac3b4ce0df..a1f72f5d31d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -68,7 +68,7 @@ int amdgpu_pasid_alloc(unsigned int bits)
>  	if (bits == 0)
>  		return -EINVAL;
>  
> -	r = xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
> +	r = xa_alloc_cyclic_irq(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
>  			    XA_LIMIT(1, (1U << bits) - 1),
>  			    &amdgpu_pasid_xa_next, GFP_KERNEL);
>  	if (r < 0)
> @@ -84,8 +84,14 @@ int amdgpu_pasid_alloc(unsigned int bits)
>   */
>  void amdgpu_pasid_free(u32 pasid)
>  {
> +	unsigned long flags;
> +
>  	trace_amdgpu_pasid_freed(pasid);
> -	xa_erase(&amdgpu_pasid_xa, pasid);
> +
> +	/* Called from IRQ via amdgpu_pasid_free_cb, needs irqsave */

That should probably be in the kerneldoc for the whole function. Something like "Called in IRQ context" should be sufficient.

With that done Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> +	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
> +	__xa_erase(&amdgpu_pasid_xa, pasid);
> +	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
>  }
>  
>  static void amdgpu_pasid_free_cb(struct dma_fence *fence,

