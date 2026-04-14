Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43469ED7B94
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 09:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE9F210E5B7;
	Tue, 14 Apr 2026 09:29:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xlL2dDC9";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011015.outbound.protection.outlook.com
 [40.93.194.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AAA510E166;
 Tue, 14 Apr 2026 09:29:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIFAbZmrKBAGIjYjAYypftoFLNEUcu8kwWIXodhcbxVHm0RvFkoae0l6O5HVkZHSjzt+3+tLyXZgoyok3B/mWKn8kytrisn3vAwqZfeNhN+6QeI87ASedVyXQQJjXByyK0pX+sUSlDW65niHNMYjSL2aVeHffeSIMVSMQ8RyNzelrX0+OXZF/kWbPghcgvk3fRMuBqn5tEolww0Tk59JqEKZbwwaemj9EKYbKfGMsgvLKOwdD7eHvYyCJn8OR/csfaVp13HQlEqLTOwF8hrgJYwxBcwjUDblQX6x0mSHkeJm4WUkFPR+npCAMQJ69O4cqIRV4Q6UASpE00abTIoAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmrMCiN7CWc18IT9a7t0/qXeztiNh+/jz7n9qXDGYZY=;
 b=X07sVujPUTfXRhM001G+B0h3ceOYvdb7z/Ynfayr1eizZgf9RoTYAEm10mzDBLgTi8sjGoD/t7966nmXLwPhoNgU1Q5NerIMws33yxPVc/Fu13RWwevqlvglHdi4z6FDHU1LKrq/UHrwrQlG2VDXmsbnFzwySWjZniUGO4UUWgFbcE7nxRTtT3b3KfQpG4vJbfZSoXhWAw29fHpbV6xt2mpzE3604XMca6O/631FNzG1h4Fx0A0adaDfvK5S0XKp39/5xZZQfV/NJqvvbsEU00TWotk3uiZn0QhIKqja3Xc0mPX3+3gIpLECzF/k1K1/XOKPti1AEDuuzWWKRdvu2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmrMCiN7CWc18IT9a7t0/qXeztiNh+/jz7n9qXDGYZY=;
 b=xlL2dDC9wEiYgX9y5NynlrC2Pbck5pK+33le8xX50F/h0QIaPKEbMelNkF4mNrSHGwygXlzbirAHEPcgATuLdWNnGsLmMov5+ryoLYNZhX69sTraRUhdy5P2UL8pAXt//OB+52xx/6mLxrXyxCJua0oOnacMILpNIw4a7AjOJig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7118.namprd12.prod.outlook.com (2603:10b6:303:213::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 09:28:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 09:28:59 +0000
Message-ID: <e097b12e-6800-40a3-a015-c1b9a52871d8@amd.com>
Date: Tue, 14 Apr 2026 11:28:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/jpeg: Fix sprintf buffer overflow warning in
 jpeg_v2_5
To: Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
 monstr@monstr.eu, git@amd.com
Cc: Alex Deucher <alexander.deucher@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
References: <1be91839e8b3e41003147a8cdc99e6efd1a87442.1776146550.git.michal.simek@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <1be91839e8b3e41003147a8cdc99e6efd1a87442.1776146550.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b4dccf-7f4d-4a83-fe63-08de9a084214
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: o6958LcLQdzWcuOwKDjC+Wg8YpASyruaL/b8kSai9DT33PwmUU5qsBwqWARWQrB7ue69DC+ojRnkSF3h8Qes7XDmXxol4l0dT7Kb3BxemwEdVlsCZ3RX3Z2h0ebv6zc23CVygJmSstSC6j7j5wsfXNeqAijAvFACJK6udFCfytnIxJtscFXKqGXx25N8exrA6XxNY7zhbxsu2yKpEKuNKpm6VZCenxko55Tgatl+Dp+PjKlozZmiovavD8YXD4y4sk6d1v4gvXMrJrmLh/EgikOD7JPQ9m6B+mUhOZ/raesqnVlnhYQgafsIg2vG0zoZK2HeMM4iyIYEsbl2i6bfjQzDpTBavnHl6t9tGgHeZV2UKaQt7YW5a7HL4cS0pvN0/VoUpxYhfRaE5sozO88oWXOOspx9eCLNsAK/6XPGt6aUD0EERsSBlh7O8qKcukL+LShgjkl/X7B2PU2UkJwnPGGges7SOmUq43WwZm2ZcAQTjQqJxva4DWEEosGPiN7P2a3YntAak/zgL2hGCrYblAQJJDaVS2RFEnDhLGn4ZdHV0m9kBZh4qxTbF6PwdPor20zEp14HHxD7miHEEofjYelyTokLipt9WTeBX6H2QoLSCpvyud3mi3VtYcfiJukOXbkVMD1NO4GMd7UI9NeyHcwwPxmDktrnzGgOsphBib+fzNhgGkncPVasoTMK5p12k+wNLVYNkR+1qeH2vDiOKMq5gsx4YEEC2EHYRC+ZJBU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmZray95TUthRWU5NkZsUzBCbmRSWmtzY09JS3NFTkRMS2FjOVRrRjhOKzlH?=
 =?utf-8?B?aGVuZkswL1RreXdQWEx5cGdLQVptdWF3Y3psaytLa3FIZW5jS0NLMXF1STFj?=
 =?utf-8?B?NDk0SGVEdXpVcDY0cUo1NzlwTVNEQnREbWRKVE1FSDd2TEoxRDlLZmY3T2J2?=
 =?utf-8?B?enIvRWFLQllFZTRqRE1mVmFDbThuNk5NdWRqWWJ3MGdJQ0pSNDMrWEpHVkMr?=
 =?utf-8?B?QzROOEJ6UU9VOG5HalMwVmpZRGR5OEhPZzA0NUhyVkhXSUJubTZEMzFXYVk4?=
 =?utf-8?B?L2ZwR0k2czBDY0hXNkZ5T3JFVjZmdDFKekV4cVJFOFFQRlB0bmVtWkwzcXJv?=
 =?utf-8?B?Y3ZYbHM0d0pkaUR1ZGl0R2Z3ampudXhlUGxlTVhwMUhuZHUwOUhiN1pweG9t?=
 =?utf-8?B?LzBYcjhSRjhZaEhHbHdBQXZ0anJ3N0Z1NExXZ21HbzhDa08xbDIvNEFLSmMw?=
 =?utf-8?B?QlFkNDRiaHNvWXNDcTRsTnptOFh6RVNzRkpnNVJ5S1lnbER6MHNYbjFvV2VL?=
 =?utf-8?B?aFY2TVMrSUZ2YXQrcmsvVkVqU1lSd1k1aVVuajNMaVBrWS9uSUxUN3o0N2o5?=
 =?utf-8?B?NGFzTkZLVHUzT0FSbEJ5cWNuZGZLVWRDcUVTNnFjcjFoMVA2QXFJWmRaS05w?=
 =?utf-8?B?M0RyWWpVY3dkZ0R2Zk9WcWhjcHVVZEd2MitoUkNDK3lXTHVxSkFtaTc3bGpn?=
 =?utf-8?B?RHNIck1JaXJWWXFaaWEzelNLRHRuaWViVlBqUHVZZzg1eFlTczA1MzNqeUhW?=
 =?utf-8?B?ckc0TUlrRjZ6by9mRHBQMWgxUXdNRDIyQWVMQkg0NWhSVWQvaUpqR2I1eDNX?=
 =?utf-8?B?ME9iNEN1NHI3eURaaXNaU0NPbkRjdGN0VUc1ZkJ3N2FmUDNoVHVVcTRSakpJ?=
 =?utf-8?B?M0RhZEhWQkZJU2k5SHRLWTJrNUtNNnNuV3VYNHdZYy84dVVFTWpjNjRXVHdE?=
 =?utf-8?B?dUxwMUlFcXdnWmdrcjdQZ0xCM1RmbXRjWjNmVmNFTVc4SU84dVpKdUxaYmll?=
 =?utf-8?B?Ni9adFFhQnlGRlhabS8xMERhVFdBUHFtdlpnMFRFQjh4Q0xvRmFFZ2VzUXE2?=
 =?utf-8?B?NXI4bXNobjJVU2kvU2x6TDllemFoZXMvL2M1aXpjbGhQMHdpWkd2YkRjRGZ6?=
 =?utf-8?B?NE5ueXhmdy8xTkpvNlAzK0lSb21IaW81dDVKRkdTSFRZc2hHa0RuUDg1OGQ3?=
 =?utf-8?B?V3ZXVDFrTkkrak1SWC9ZWk9SNUExekRTclVEOTBuY091bHhOZHZBVm91cVU2?=
 =?utf-8?B?MnJIVThlRkJYUXB0eEMrS1NNOW81ZS9TRWVlcnhNQXoxRVlBa1NGVU0yRUJU?=
 =?utf-8?B?b21NYzRZMVl5T3kzbGpEcWJnZG1uYmZvaHEvc2V2RStGWTV6clJFL0JvTFJt?=
 =?utf-8?B?M2dJdXkwZ1pyaDh5S2NEVGFCcGdjU01pTnk1SG1LdWx5bU8wYjhteEhNUytI?=
 =?utf-8?B?b0tsTStwbFZaVHdZdUJtbEhZTjIxamtia3JVZzVNd1g1VUhUMUtjc0lvaEpD?=
 =?utf-8?B?MmtHRkNTL1dxWVEveEdtbzI3WmhNTDVZMjJtaGh6NFhzc2tsYnZIVGxaVm8y?=
 =?utf-8?B?VUNhM2hZZXpUeE1JcnIwM0cxelBhVUdObkFKT3VUVXhtZDB4VTNWZlFUVEgv?=
 =?utf-8?B?T05FQnU0R3ZNS2pDOXIyOUlQQU5JWVZRV2tKYWJGaEFWRWNEZ2RCUVoyc21s?=
 =?utf-8?B?TnFmd29LSEhycGtMTHVhSGk5NnUyOTFyM25nU3ZmUHpFSFNiZ1RXQ0pJRzNX?=
 =?utf-8?B?bVhyTjdlNVkzYlA2VlloZDVBZm9tc1N0RXdmMUJqMTE0dWVac1d0Vi9oMzhs?=
 =?utf-8?B?cTZQTkIvWFYrajlNM3drVUVLeFVHT1ppVGU0UkNoTy9sVWpvY1EvRlg2NmdN?=
 =?utf-8?B?Uk8zOS9Xa2dObEFpbmJDMGdHckowcjkrY2I2UXg4KzJrTmsyVWVYcDZ4aHhy?=
 =?utf-8?B?NTNjNWxvd0UreUVXN3JqYWI2ZzJ3VTQwRm1weXQ0dnJKUkl3V0t3TDZ0Tjg2?=
 =?utf-8?B?Qk16UERZdmZaWmVxN05WU21relI3UHczV2R4dG1ZTmdMU0Rnd0Y3MlFUMlFX?=
 =?utf-8?B?am1rQyt2eXpVNU43VnZMZjlvcFRJQ0xva2ZiUU9kbHllSUZHWUx4c0NPajVP?=
 =?utf-8?B?N1pVeVVEbVBaWTlwWFpVWkJuWGJyOG03YlJxNVpCbDZkZE5ZY3RUL0d0OGNB?=
 =?utf-8?B?NEhELzg4MWUwbElPVUtjdS9VbEhuU0FWZFlnbW5uUE1DMEhaZVhDMHdGSnhR?=
 =?utf-8?B?dTVSTTRxNUI1QjM1ZzJiZy8xOVVuSStHK3hGMi9pbXpOaFhRZHhTTEp5RXNW?=
 =?utf-8?Q?uXY5qu8eoCdRF0USSK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b4dccf-7f4d-4a83-fe63-08de9a084214
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 09:28:59.4618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0mc4E7NJrxy8lKDrp1CWqRGuvlK/Ffc3uFTmQWQM8q/dBPgaPVrgI05BKTCWRcs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7118
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

On 4/14/26 08:02, Michal Simek wrote:
> Replace sprintf() with snprintf() to fix the -Werror=format-overflow
> warning when building with allmodconfig:
> 
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c:152:47: error: '%d' directive
>   writing between 1 and 11 bytes into a region of size 7
>   [-Werror=format-overflow=]
>     152 |                 sprintf(ring->name, "jpeg_dec_%d", i);
> 
> The ring->name buffer is 16 bytes. Using snprintf() with sizeof()
> ensures the buffer cannot overflow regardless of the integer value.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> 
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 20983f126b49..fe2b049afac3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -149,7 +149,7 @@ static int jpeg_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>  		else
>  			ring->vm_hub = AMDGPU_MMHUB0(0);
>  		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + 8 * i;
> -		sprintf(ring->name, "jpeg_dec_%d", i);
> +		snprintf(ring->name, sizeof(ring->name), "jpeg_dec_%d", i);
>  		r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst[i].irq,
>  				     0, AMDGPU_RING_PRIO_DEFAULT, NULL);
>  		if (r)

