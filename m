Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45675C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:31:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72D7610E66E;
	Mon, 31 Aug 2026 07:31:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DTf1y5tX";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011062.outbound.protection.outlook.com [40.107.208.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA82210E66E;
 Mon, 31 Aug 2026 07:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlYqx6g8q/pFHXN1JhYWSH+qNS4KrzV121uJa9ouUYgmRwtmBkvgyCIQHqe+CBby4pucrLvUJg0lOIFYP1LxSJXau58sIu0Ej3VDOzgCuLwVpcTjByHRrE+wE3FCst15EIvAx+IZHS2Hq+cDCdrxblyw8swvpb9CQe/n1kAuVg8v0qgo0BcCV9jry68d46MljSfbw+yBRfEqaKZg7YqluRmwRul/lzyRDbJolFn4ul9PHjAl4j1GBnp7FetIhjUnPszzIWqfL8xYjAd7ITjc/yly8grRVKZHIUGCKCb2nYVRu3tvpnrA/o7NjSnk48P8cbqY72HGKZfNVujTbooJlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+CHg8rvDDcappF1RaqRdBqNnzZ356x9fXRMGpR52AI=;
 b=dVrG0FO9ihtdLrSVHZylwXD86rBvunisusOm6yFaL0nQRsqt62Ywzzz/yx3w5ZQ/dElvW1LfkKB3+i136fcf/SsGzqRjSLX+4jVrQCsOvATKfH20IxFuv/3cDUrmuXpaUgJshUcMEmlTNxVC3Xs5UOYbfCnz6oMGVE3MtlpWixQ4RgP+Ykg48Ti41uaIYKaHMlD1tK77lEZT413uKOy8oV9BzEyh/3+nLPuVqCt1fh5+ZUl/sN2lbVuastyRl6zEd63l6R8M4tzw5CIHyguKxTAfQvtw4EgcCxaeEL8BKxdGyrIAFr513PukLUcNAFO/l2yQYIdc/7Z8E7kawZtUlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+CHg8rvDDcappF1RaqRdBqNnzZ356x9fXRMGpR52AI=;
 b=DTf1y5tXlKsfAbDDazpcZaMTywJInsf78449VUpU6qYCET0ZhJxFJPMr4u2J41gUnzZDzzRCqs/JHigMB7SSLufzAvvQoCwd/unH9sMSt4nX06XpsRNJ4fVd1jeRKESUYGOv9GzM1oHQFNg/xOSFpw73MrWA7XRUAViYilHjfGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 07:31:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 31 Aug 2026
 07:31:16 +0000
Message-ID: <317405b4-7076-4c56-85a5-33226f471c5e@amd.com>
Date: Mon, 31 Aug 2026 09:31:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] dma-buf: Add reference counting to dma_resv
To: Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: thomas.hellstrom@linux.intel.com, ecourtney@nvidia.com,
 matthew.brost@intel.com, nat@pixelcluster.dev,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20260827124910.2245-1-christian.koenig@amd.com>
 <20260827124910.2245-2-christian.koenig@amd.com>
 <DL0SABOU2QO9.20AA8OP9CXXA5@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DL0SABOU2QO9.20AA8OP9CXXA5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4093:EE_
X-MS-Office365-Filtering-Correlation-Id: 80db8ff8-6f02-4482-d3e6-08df0731d7bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|1800799024|376014|23010399003|22082099003|18002099003|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: JQfH/HHHBr96RVx2gHPRiv179QKi25LVFRQZdFN9j/gcE1Oa5tJRtvpYKJkkyiPqIm1xUd7p9LrZD9dv6FwaB94uprJffoXIOjAZTmAGm8f4HM0MnDNiYgUBoD5/SZcRXKpMl5KtjyasUjAVS4MHwvloIYiS/k3A6RQ7Th45ppPFO3ik3e5kwb7cOAgy3stD7XZ7ZdOOqCdD4ScbOT3JTT80kmQ26bN0cRDUPfUjUcnoyf/HWiCrOb9/IOHhFfgvw7fu8HAjvBt0tPNyiGsN+fA1/x/unG0yLOSw1GXZZfhmwBEoG2NDv+emgukkKHLlF5NN+m383m3iObIH81yVbi2jjM36VOWLGHozINXXPMpDKf13rVk6rFJUKvmlYISbuYApA2LGPgK3A0tIjqz4+YnuErGenx1j11UlKvs9euLnRdI98cMIK+ObPU9i/4PCJKn8YNNE24ymI1tFR9lPOVRXKm/11FFWD03ZDyIWVcSw+L4crtnk26iy51TgbQqQY9GFXtpB1ZhCgeyZELPe127MWcQ9I/V/+Ht9pJexnjXbKz0Cmz+MWQoUf6CHiUkxD+XlP4Ub8fF3L9adZuj+e9KxQqVm8HoO3m2Ob4L34zB1QNf/gioGtfbpUsGQn6/Xk2MDfMwaImj4m+Qp0dDV5FFyKjiO87ndhisb658Fqd4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVVpN2QyRmxURFNaVmVVODVNM2J1SkFmS1lsNDZSMVJHOGhpZlNubUkxTkdD?=
 =?utf-8?B?OE5DQWx3c0RuSElySkNseVBOT0pna0prNE9kMXNybzVnbTBWdStrSWJPbGpt?=
 =?utf-8?B?aW8vdlpKZHB4Kzl3US9BTFBOQkFmcHZ2WTlKeUtVb1d2UHIydnFFVTVSajZt?=
 =?utf-8?B?UmZaUVQ3UzU2NG9DTXBKSzFhRFN3cGpNYTZQT2RpMC9aVitRL1QxSXZnTk1F?=
 =?utf-8?B?TDc5VTd0YWVMa1gwYWJzeVlwM0pTeHVnU2FjZ2hwNEhRY1luOWM5dXpwUXd4?=
 =?utf-8?B?QVBiRmU4enJqNWVOUmhOaTZjSWp4QkYzYXB1MnR3R2hod1dEVUM2WGZUTExL?=
 =?utf-8?B?VTUwRFQyUk96VFhkM0t4cmFPbit1VjRvdytpeWhkZzNuakg1S1g2V2hMd1ho?=
 =?utf-8?B?bGl4WXBQRWxkZjZ5cGJML2dnWlBEbDVOdzlpQklSdi96VWU0QzhodnI5elBp?=
 =?utf-8?B?Vm1pOWNhN3Z3VklEWFJGZGxId3FaNmJnKzBUaXZkQVpZSW91QUVFYU5BTWFY?=
 =?utf-8?B?VFZTM1hJbEV0ZXF5Y3l5ZEx0RnF6TWxRWnlNd0t4NGtUclY1MUhkanhrazZo?=
 =?utf-8?B?emlLSlRYcFY0a3ZSbkVYeUpabVRYRThCQzZHNzQyUWZNVWJaMExzK3hLSGt6?=
 =?utf-8?B?YTdmNWJwSmdXVTRraHpwbndGakRKbHEyOWtJcmFFR3RsNkQvN1pHNXNJbHBy?=
 =?utf-8?B?SWFXSkl3T2g0QXorSmVDajR6NXJZSzkrVENDNmVZNktIZXNHUHpvWm50bDd0?=
 =?utf-8?B?ZThTdzhzK3hJbWtwQnY0Q1E2ckJISGFyQjdGNTFTZktrdkI0d0FRd0RhbEZT?=
 =?utf-8?B?eE50cjZLRTJIOFJTaHhabU5IQ1ZSb0hNRDM4MXJFUVlldFdQUHY5MW80NVh0?=
 =?utf-8?B?bFZrVDFuRFhDVUl5V0p1cm5CeEpVb05MOWc4cmRrbmM4VHJZbDNmRHJzTVFZ?=
 =?utf-8?B?N3RvaytuaXZGTnozS3hRVjVpeHY3R0dYSkM1b2VuWHU3QWpzSm50aXpKM21K?=
 =?utf-8?B?RDdrSXZDUGJKd2VRcGJiQmVWVTBPUHVzaHFiTmxyYlo1aE12ODBNTU81dEkw?=
 =?utf-8?B?dEtoVG5LL08rVHd2VVlrbDUzcDArMWg0czlhckJQTEhDc1hLQ1NndmdaSFVx?=
 =?utf-8?B?SFF6UGtRN1E4K2ZIU3hTWnJ4L1E3UVhpa3Q4WGRJVW9XQ0VnaDRMY0g1UHpv?=
 =?utf-8?B?NXRlV3VCNW9zSDZWT3dvRDlVZFlxOVBSeUpmcldWaUswSFRZdXJ6L0Jubk81?=
 =?utf-8?B?ZW1USFhZRGsya1BaK1JubldJdkNPQjhnSng4dVRuNmRLR2lWeTRaU053N20w?=
 =?utf-8?B?b3U1aEpWZHZMSVRyL1NhUzIvZU9DdG1JQmVGSjA0b1djZHg1aE5uckkvQ1Vq?=
 =?utf-8?B?YTYyUlJobUIrcXBNUGZ4RVdCYzVqYUFHaVYrZlVFdlpKbytwS1lhUnA1OEl0?=
 =?utf-8?B?ZE85VGlTWVI5b1VlNldyY08rWU42V0w3ZnNIbzdaVE5vZHZzMTFPWllNc2Z6?=
 =?utf-8?B?NWkyV252UHFYYUJSU3dQRnJ6VDJtaFBTek9tWms2bXptVitpcmNnY2Rnd3ov?=
 =?utf-8?B?VEhqNGNaTzFWOUMvZnhIbHZZSlQ0OEIyMGhPVXR2TkU2Y3dCT0hONWRsM05p?=
 =?utf-8?B?MnhEVzNBME93ZHlVamhtN05hUE9aOWhKbFd6VlVEOEMzS1REREJaL2pUQm5p?=
 =?utf-8?B?YU9aQ1JZODhHc2UyTG5BTVdHeDRmK205QkFrRTgySzVzT2xIYVkzeEdPUjNW?=
 =?utf-8?B?K2UyK0lmZitPL0ZiRHVzOEQvem5tSS94RG5sY21iVHpKTE1la2ZyMEw0a0R3?=
 =?utf-8?B?bEVDd0NMRTJ5eC9idmJtL2NrdVFBZmZQekpDV3F3dXpBYzFyZlpwcFlsVjI5?=
 =?utf-8?B?R2VYS3dWcXpmVE54RmVua3pMb0NjQ280TFJ5MW1sOUZZWUkrSFBGMlkrNitS?=
 =?utf-8?B?TGpPU2JDY0lmTDNZU1J0RWFGYklVeVRUdGQraEFYblk1TWVJOHlPdUdnUlRY?=
 =?utf-8?B?aGdjd3FCakgyU28rOVJ3alh1S3V4STF2aTNPQ3E1NW9ieHpqR2F0N0M3eDB6?=
 =?utf-8?B?anYvNWdaK2MwbUxEM1NERmFDaXVtMHlnOVZET3ZUbHkwbTQ5UnNQNFBGU2dL?=
 =?utf-8?B?eC83SVJkNmFSekRMakc4QzlYVGJnRnJ0cDRwUC9tbHdXOVdkdDNDV1M2Y1JE?=
 =?utf-8?B?ZCsvc2VJRS9qZTlGS1pGclFQbWhoL1pSTytJSjFEeCtyWmtnVU9mTWFiVzZC?=
 =?utf-8?B?UlM5R01aOFRiY0VGZzB0d0wxellXc3Fibmx1MkNlbmhHTDZPT2k2bnRmR0NS?=
 =?utf-8?Q?LFjo86LZBv25N9U8G6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80db8ff8-6f02-4482-d3e6-08df0731d7bb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 07:31:16.5963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/3WzhXv17p3k5Qoy+xTseYJjiuTeR65ThBay61o3h4/pTAgGgO/aJybSGmV00KU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093
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

On 8/28/26 20:21, Danilo Krummrich wrote:
> On Thu Aug 27, 2026 at 2:38 PM CEST, =?UTF-8?q?Christian=20K=C3=B6nig?= wrote:
>> This provides clearer ownership semantics and makes the code more
>> maintainable by removing the embedded allocation hack.
> 
> Again, fundamentally disagree; please see [1] for details and reasons.

The dma_resv::allocated field is removed in the last patch of the series after all users have been converted to the new interface.

> Besides that, I don't really know what to expect from the series. The cover
> letter says "Refcounting dma_resv v2", yet there's no changelog telling people
> what has changed since v1. On the other hand, none of the patches has a v2
> prefix, so what is it?

See the cover letter. The patches itself are identical, I only added the missing cleanup to all users and removed the temporary dma_resv::allocated at the end.

Regards,
Christian.

> 
> [1] https://lore.kernel.org/all/DJVRML4G11GZ.Z7FTZH7I1LZN@kernel.org/

