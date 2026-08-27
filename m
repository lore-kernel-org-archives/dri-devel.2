Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA00C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 427EB10EF43;
	Thu, 27 Aug 2026 09:03:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QPuhYlIU";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D21E10EF2A
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 09:03:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pfo0A6yyUif627TW1dbuc3b13yu75lQNEAoMx8dmf8GMoGJldsbDr+MCcM5wgQLpXJFAxMttiJ2qVSaiUJuf6SdFLNE/7S3XgGlXK7HcDZZeTBmFF1vuB/TkwE2Nql/k1x9wXUq8TshWHA79o/FYRXk9V6TB6519ySvtdLJrP6Dyq+iPZx2J3sCrBbqXVRuLVpLFyiBI8PFqOAPsLuUusaxbZiPGMn4eqNiDPHCWtk8NO8gkEmbEjdnl5yQ5IkdSQH0ADhGlPc1J86KzbYnoiDwuxxhch1o7IO3PR3weD01nRYwMD12AIsY+Pnx0B2k5jQCeQnD2y2Yi9dr0icU4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LXNubYlRs/9fnINeoYkwxy6/O28j5oaVn0rgSbQUS0=;
 b=HgX//F6i4B6a3qMDxa/jXJ0UUMaV1K7W2PaXzQi864UuCNZYF6gqRVRBUH2Jee56uH0gq5/47GYen+GqpebMohF4E0DbUBJJmegTnmyNZ+BNb2pI0t8q3LHb2rbF+U/a83uPeJKo4ugQi/oP/oM9vIsSDBnQ2axyY4rTno/phNvHqiggQj/PSOjDgnM/NVyl6lf9iH/CANKfaH47zgY1rIgiq1dVN31nuBJD/86auo6YPsCB817iwckIcpRN619cjRa/TwCu5CqAL8hjt3XIg5uwgUp7kWCL9jAiDwSUpVHu15Q77TUktai6ksj8MXDnki/ckrTkWUMYf6HX8OT/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LXNubYlRs/9fnINeoYkwxy6/O28j5oaVn0rgSbQUS0=;
 b=QPuhYlIUnZvHZ7/dsOwovS72PpUHjm1e+PQJA7ESlAcwhv+vROFE6r7+CcdEx4psK0ZETwwdW+NUbL7lW+sMHPfKnVe4i7HUEPpeU52rz5t3u8lnQ0Nq9SzIwaCCVeK7g45i6qs/77P/bba3CcmhGrt7Gst6GxsE+efKvrfp21U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by CH8PR12MB9765.namprd12.prod.outlook.com (2603:10b6:610:264::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 09:03:18 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%6]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 09:03:17 +0000
Message-ID: <bebea9e6-a658-4559-9e35-14a3c6ecbfc8@amd.com>
Date: Thu, 27 Aug 2026 17:03:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/gpusvm: Assign maintainers to the DRM GPUSVM helpers
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Himal Prasad <himal.prasad.ghimiray@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@redhat.com>, Simona Vetter
 <simona.vetter@ffwll.ch>, Felix Kuehling <felix.kuehling@amd.com>,
 Alistair Popple <apopple@nvidia.com>
References: <20260827075106.2052472-1-matthew.brost@intel.com>
 <b20dc18d-b85c-470e-9eee-f33911b3ce36@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <b20dc18d-b85c-470e-9eee-f33911b3ce36@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|CH8PR12MB9765:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d559c7-ffca-4907-b68b-08df041a08e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: IWqW8v17CBUCkQ+HoMyu1OcZ5TUbhGNS1bkdfeBShP52OFZsO6wvjSzQkpTdZdRVv1UI4PWbntr9XNrqfcCwOvsqL/wBYISJ9EXhPIi80y6NolWnFQ/UId8TMqOy4CV1vAyW1pC4fyj/YdiT51DBsQeBUEdTkw7nGvcRPTGu5risXg0OC9OZ5dcwlEeCR+DMQRQytsEAiDvNHc/alm9N7TIx+nvvYkOW7ShNuO+9D2Uk2zINB9eEMMoWupv0YJ9WYE4Y8agfQFLpzM4Hc9S14bnVEFoFnWiDsK3GdagocQjP0LeWRJS/kHnpZ3y3raNeb/ArntbvnPS0A6BxrmBMONDW7ocUYSORoNSrLF2ZIQFUJcCvdQ006mXfeT8DXXjTT1yv53+G1aR28m0Jtb8cPv8OEuTu6LN8G4gCKkQSPt8ZUCciSlfhCDvV94MMNhXY4L8IlRJlmYGmRKgb0LduLTpoe9NIEFM8tVq4NZnFSK/GWwVVKso/C6ze/m3W89zB8B3M6kK0am0RRFqYgauYFNtFGbiEjPp09aVXMJUSu6ROLuoqkEsZiFvXNLVeJOzFe+KGt7bvsGB1Qy2/UmXwUShxD8TMW6arE3sbzGmevCQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHB2STBKenB2S3I1Qk9GR0lubVpWd2pqcFNyaFAxZUpLL2F5RGhsQThGbGZ5?=
 =?utf-8?B?TUtnVUlmbGVIeG55akVsUEFGK0E1Smpoc20yN20zcUtHVlRXR3gzMnNVdWRM?=
 =?utf-8?B?T1NEZ2ZPcHZSeXlxT1RvMGtzNkMwcDg1RXA4ZTdldG9SVys0OHdxVDAwdEQw?=
 =?utf-8?B?TXdVZGxlMTJCamNzekRXRkhueGl4TnhXQ0xESlFhZHRaVDhWSGNtQ1J5ZVdv?=
 =?utf-8?B?MXlWYnd4QTI5YmZNRHJobmZLZmFkR05rbG12S2o3R0w2MFBadVkvdXI2cmFu?=
 =?utf-8?B?czkxMVdMLy9PWVAydlZoWU8wN3VuVC90dzRXVXBXRnV1eXprQ01Gay96dWRa?=
 =?utf-8?B?Y2xUTDFhaW82THpEOVBUNUJ3V0JjUWJuMHFlUTFJUzhqeTEvMFhBUllTR3Jw?=
 =?utf-8?B?NkVXRmxIV2dKelJSVkxKVTdWNWtFSnlockNXem54QlU4VDY3VjlRbytvOUlv?=
 =?utf-8?B?VnZKdnV3ZHdRT2JZV0RPbVcvcjh4bVcvZGZGSmc0SThqVzYyb1hOaFQwMFBX?=
 =?utf-8?B?T1g3anZkMjE0cmFOWEtFZDcwOVN5djFZbVRTSE5oZWhsYUpXdE5CMm1rM2d4?=
 =?utf-8?B?STAzSTVBUElnYnpVMm54Sy93Uy8yZjRMRTBaZ2tORnBEckhkTURTZzZvUmRQ?=
 =?utf-8?B?K3ZtenY2Sm5FRk1zb21xdVhpOEVDWTBwTWlvTkMxaXdJMmg0R3VZcVhKWEVn?=
 =?utf-8?B?RUdPS0RCTzljOEtlV3FwQ092cXZ6Vzk4RVg3UzVydU1GNnl1b24xcUF5OENN?=
 =?utf-8?B?NVNNTE9WZ2h2MkQxK3c2RndlcVN3SHllbWtjZGJjN1ZLOVRQMWVPbjVVYUlp?=
 =?utf-8?B?YS9CSDZZMUxtbmpLZmM5TjdVend0Vk8wWjZ0V0VWSC9rY0JLYmxTOStUbXI3?=
 =?utf-8?B?UUtFY0E2Y1RXaktWTDg3V1ZUWEs0ejZjc2xURHpWSWVQZTJxdVpicjVkRTY0?=
 =?utf-8?B?OTZ2d29zV3RHNG1EQ1dvemJ0NEtOYUhRRlVwSzFWV0cvRUsxSElQazZ6eG41?=
 =?utf-8?B?MGYzbEN5RFJyMHVNT1F0TGc1ZFZNUFRzUElHQW5KSmFUa202UHR6d2pFK3Za?=
 =?utf-8?B?K3BFZmtOQ0ltY1A1bHJOd251OVZ4QUJERW12L1pSKzk5Q3dnc3NiVjdpVFJC?=
 =?utf-8?B?MWdJbk1QSzRmaC8xVzIwSXc2dVUvNzBJTlpDNmN6YjZhTlUzUmJoMnJwVEJ4?=
 =?utf-8?B?emxQWkxYOE1rMHVSRXBXNDhsbGk2cDM4L1YvVDhmMnYxYlMxV1dLMlhlUE0v?=
 =?utf-8?B?UVltK1BpWitoQVhsRmNjOVZ5RC9Pem90bXh4WHYwc1dyeFFlejkzWWl5YVBP?=
 =?utf-8?B?NXh1ZTkyVk5HY0ppL0JkcHd0MlhvTm9DUVc5Tjh0bHBNT20zTndqMkxHRjJO?=
 =?utf-8?B?UndqWUZIYXFXamJRZFVEenF0MjdWWHZpNVFaVkZkZ3JDK2R6enhkeXQ3Z0JB?=
 =?utf-8?B?aVI4MWFnb1Q0bG5OMWxodzZmTTM3c3NCTWhudnNZdk12VzVXZENzc2dtR09l?=
 =?utf-8?B?RElVMmFaMXlXNjNheTJyL1cwUTVDTlBSVFFVMXlmMEwrc1haWmxKd0pPMm5E?=
 =?utf-8?B?b3FSMGRnamp5L25udWMxZWl0dHIwQzBYa3hhZW5jSUU5dHNoVHViTGFCc0Fn?=
 =?utf-8?B?Y0dIQ0laZG9PQVQvZUJJVEVpMjZWdlhmSzlQSFlsOXhpNVA1SWQveGZ4cEgz?=
 =?utf-8?B?dU9WYWVsZ1J6a1VRbXlvMGlQUmVBYmRPSitHL1o1aGczK2M2UVhVVFhEdlhj?=
 =?utf-8?B?dXlJcXNSNW81clNxZytDbkk5MlNkUVFGNFNHT00rYy8zM21SMEZVY3ZNeUlr?=
 =?utf-8?B?L1JyU1g4aGFaTVhQVFJaZ1hDbk5ROWViVUM5MkFUSTRtVXlDU1o2SWo0L2or?=
 =?utf-8?B?U0taenJsb1R1TlBiY2VMZVhxdGtJeC9ZZ3YzSWpSa1VpNzhrelZhVHNCY1Rp?=
 =?utf-8?B?Y3doV1pHVXhyS2ZYU2ZnQ3JzUlh4UDVlemFiTkhsVnJKeGE5MU5LcDdHeHI1?=
 =?utf-8?B?Q2NJQzQvVFlhUDFLWGVuM0FJYXZwQTR2VmsxcnM2ZjhGKzc3WnQvKzJJdGJ4?=
 =?utf-8?B?WldXZ3gwa0prYk9CZUpFNHZLVUU3UyttK0c2SkplMExxcVNzQldYWVBkaG9E?=
 =?utf-8?B?UEZjSWxBZEhyMU4yaXEyWnhQUkZCVHR0OWJhQzVFTHlLb3Fpb1R1RWlPdS80?=
 =?utf-8?B?V1Mzc1hXc2ZQbWtBc0M2cnZRcW1XYlczcENhVk9aYjZBdmVJTTNxanZISWgz?=
 =?utf-8?B?dFNEWUpsL2N2bWR1VjZxdEFiTHVRb0cwQUM1TGdoUExzcDBiUzRldjFIc01I?=
 =?utf-8?Q?+xteAamsOCyuLWeSpP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d559c7-ffca-4907-b68b-08df041a08e7
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 09:03:17.7971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zj34d7ov100Ux67mAQ7Fbny/fQ8yRv3Ju8v1vf6tpuKbAT98eiI4mWHpDx1ZiUUgfaErRQv0aq5aTmCh+QuOvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9765
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



On 8/27/2026 4:22 PM, Christian König wrote:
> 
> 
> On 8/27/26 09:51, Matthew Brost wrote:
>> From: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>
>> Document maintainers and reviewers of the DRM GPUSVM helpers
>>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Ghimiray, Himal Prasad <himal.prasad.ghimiray@intel.com>
>> Cc: David Airlie <airlied@redhat.com>
>> Cc: Simona Vetter <simona.vetter@ffwll.ch>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Felix Kuehling <felix.kuehling@amd.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Dri Development Mailing List <dri-devel@lists.freedesktop.org>
>> Cc: Honglei Huang <honghuan@amd.com>
>> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>> Acked-by: Matthew Brost <matthew.brost@intel.com>
>> Acked-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> 
> Acked-by: Christian König <christian.koenig@amd.com>


Thanks a lot, Thomas, Matt, Himal, Christian. Happy to help review 
GPUSVM going forward.

Regrds,
Honglei

> 
>>
>> ---
>>
>> v2:
>>   - Add Honglei as reviewer as he is driving AMD efforts on GPUSVM
>> ---
>>   MAINTAINERS | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3c508bda61d5..dfb0d36f0ae2 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8991,6 +8991,21 @@ F:	include/drm/drm_gpuvm.h
>>   F:	rust/helpers/drm_gpuvm.c
>>   F:	rust/kernel/drm/gpuvm/
>>   
>> +DRM GPUSVM
>> +M:	Matthew Brost <matthew.brost@intel.com>
>> +R:	Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> +R:	Ghimiray Himal Prasad <himal.prasad.ghimiray@intel.com>
>> +R:	Honglei Huang <honghuan@amd.com>
>> +L:	dri-devel@lists.freedesktop.org
>> +S:	Supported
>> +T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>> +F:	drivers/gpu/drm/drm_gpusvm.c
>> +F:	drivers/gpu/drm/drm_pagemap.c
>> +F:	drivers/gpu/drm/drm_pagemap_util.c
>> +F:	include/drm/drm_gpusvm.h
>> +F:	include/drm/drm_pagemap.h
>> +F:	include/drm/drm_pagemap_util.h
>> +
>>   DRM LOG
>>   M:	Jocelyn Falempe <jfalempe@redhat.com>
>>   M:	Javier Martinez Canillas <javierm@redhat.com>
> 

