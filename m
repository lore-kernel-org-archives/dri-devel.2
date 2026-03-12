Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F52F106ACD6
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 18:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55A0910EA8B;
	Thu, 12 Mar 2026 18:54:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Doyy8N2H";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011058.outbound.protection.outlook.com [52.101.57.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A52B10EA8B;
 Thu, 12 Mar 2026 18:54:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0pMXr2ds5SNyS1Aa8pPwdXfTepdrRZqEFUJEO1Y/7WkP5zXb4WtSySwY9HEBU1gz6IW1eldKPpdd2/J20MB8aKLq90k77tDvQDzwvMQ1RmrZcYry52f/wNuV6mNHUFEIO90wCeiDzecY25yB+vBPEKBXVHhkNdhC/2W8o2z7kMuS38Op/t6WyEwgPT1a/Vwrj5Ux1uv4MpuN3e8ty1SSFsHR8z1fcp6yFjTg9ocNeLvVGiQbPYngjqYY/FDZ2E0aQUR4TifF4+n5KLSylmgT+8ztgTAYwWa30//jkMd4DKPTakicmgklxVwcTQbNk5LR8GfPeEpkvf7sIn45/5Hlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1GI6S8Xh3kyZrLAiDGKXYLc2GRi80WlQiv5ixoOoeA=;
 b=vqdeG0M+yZLNpJM8RF41HgBczPEZ4KT3L8EaVoNq7HbR5TXYcgkKlUef+v0hDjzXTwGBL4EaYtkOijnI6hRPdJJ4o9XiLt+59xjGGVuLqLuiXz8tY3lbtDEthp19/GlQOVOh8fEfAe83WXk3BAu5xNqFSpgYXVre2syhYFUdRMOODg04n5oj7HnSYGVhO3kwmsUGqfkJ2RSoMOzExAbx6OJrMyEzJqfyUPgDTq4Mtn8cKBbAOtkLv1sF35ElrQ81/2EkxuxLX4aypPhmo844P5FW6Q5cmVJU2WSyGHUsLSyx5EiH5P6L6xN26qs6pzaU4PSMQKgZ7W5zcCIlUgvD9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1GI6S8Xh3kyZrLAiDGKXYLc2GRi80WlQiv5ixoOoeA=;
 b=Doyy8N2HMgp1YdAF+hDnPo/8ezKxVPF8IurNxO0SmUUspIUJfhqicOfE+TxamEY4Q/mYJoFl5bbtaax4aeP6ra4P3sMu3dRo2GCeNjXlaJWNa5gxETh4b8XkXt+5cpKCm2aLSMGOAM7h0x88/O896ty5uswNUWxpNXYQtR+SecmSQNqk25LwbNyeRkGSNV44dwP2v+BTDSJ6VJphfDqsThNxAY1EfSKRdDXfHRgU1HR2XG7vqdd2YsKSxkIt/pwlQmfqwkyIODNHkx6/+jJ9ZRuytabBKQv72Bm/85nCrM5+scidEYS21c+w6PNi6Qm6tuZCtA/VAO7kUZWskA/0mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.4; Thu, 12 Mar 2026 18:54:15 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%7]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 18:54:13 +0000
Message-ID: <02daf179-d816-4e54-a91a-5f8eeb2a9576@nvidia.com>
Date: Thu, 12 Mar 2026 11:54:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: nova: rename drivers to use kebab-case convention
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Gary Guo <gary@garyguo.net>,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw
References: <20260310062443.2763230-1-yphbchou0911@gmail.com>
 <99af9d88-05a0-4dcd-85f4-9d5fe9ee6744@nvidia.com>
 <abMJsUpvcUrITCVi@eric-acer>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <abMJsUpvcUrITCVi@eric-acer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:217::13) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: c08c99aa-4f44-462b-5cf6-08de8068c074
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: z8FefNK1zBDuU/c8y4vcG4+t/Ig0vpFOoKVeijfJkji66RVGNIWi56cctauVOWVsKm6In54aWfKvy3g/mag3iLfBpsBhXc8T5oCxwCaM1eif5UmPjQ4a+OVTl6+DKtQembIXxtkThi8K6+YQIyNiq61Q7ZYVLvb2rAXRkJG4lRNg74PyS/AVGOMSIcGbjs3KVd7kdAjxPEXGZmhTawDLH44wM7RrIeCkD11B8iI7uriqJEKLfFrU7vZ99O+8Y4IROQGgF37RNii+GGsc0mwrb18MjMj1VlRtorWgEpkaM4VfiGPLIwrrLOI5o5oBaV7vap1+RLOUVEnbOSpyVZbuVBYFRbKpMrkSI3GAmel6RBJwSRTkaJOqzJ9ztCHufzeOfAoZKN3Hd/mWhkQd5SQAgZ7W0xqsfm6nvnUvwB323Qfvym3oOxTjOMiQXZ1MaG0MgT8dD0VbNKWXOJvOxLhoNaCXkXlm4LcTSdsPVHKwvaKO48Tf5AnKf5h7RDmvnrqFZkZyv6UEqxzpywvSwNwDwVWZONK6mUXV1hXqTHFwV/l1xryLaRAqIolHRL4aUuT74eVsGbjJs+Jv12eKahZsiq5DGi9EiTZ2xDCCMRWpR01fd58ZOKTWPAl1fDSQicJHFPs+HVDbt7x2s4GK2071QBXjQy5BC+gpM5WNujcbLLRpaNl+8I5itsMwYiXS9xddKXq038p1jrPkcNNNBzcUajr7F/ux0VONuoeFP8codo0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE9jVDVsWGhibFFKRTRjU01pZU9UamxnSFhIUjVzY1h4TWVzazJEaEJQb2Z1?=
 =?utf-8?B?MEVRWUdwTThxOFpwaSt6ZFV0R3FpakJteHZHbkI0Q1V3WnN6RnVDTlN5UmpZ?=
 =?utf-8?B?N05PWHNwVnlvQ0IrZkFSVjVYR1ZCVXUwcmU4Z2xuUWF5Sms3ejRKazNYN2pp?=
 =?utf-8?B?bEtjQUp4bGxRWVg2UDZVMWZBZGJkUkVhVXhRUi85RnpOblJTaTZTNFBzMXpy?=
 =?utf-8?B?SEhBRVVETmRLSnBSTmUya094bXY3dzZRMVlSQitsV3RoTERXQnZqVm1SOE1k?=
 =?utf-8?B?TkRHUDJpTnBaUTRtbGg3WlhBQU5yQlNSOThMUEVsbmRrNjNQVWU5WGl5dlRv?=
 =?utf-8?B?cUNhcUdpSXJHaGJpVEtGdWtnMXd5ckw2czFzOTAxYVFZbWxaRHZmK0Z4bVJG?=
 =?utf-8?B?bERpbVlabjRjck1lWEVuRndjS2lINm1IYXlLNlp2SFF3dEp3QjAydzF1M1Br?=
 =?utf-8?B?K1dKdjRqbjZlOW9jc0lOZkNqS2dZNmhtRW5Ca0hrU1g1VjFnbGZoL2d4ZHE1?=
 =?utf-8?B?akN3bURZYVUwMU04RzFGQlZrd2JLc0Fvdm01WVFhVlJtcHRrSlFIU1lUc09G?=
 =?utf-8?B?L0Z3cjkya0k4VTM2YkJsRUJXYjFzYXdYQjlTcHErTjE1ZHYwS3NTa3ZHUFZC?=
 =?utf-8?B?TGdXbjJESXJaM2laaEdzNXhzVjRUeWg1SDdaN2RFaXlra2N1aFZKQlRucVdT?=
 =?utf-8?B?TnBJVEs4UFFCUWtXN2dhY2FYanhVU09Ha2JJTkJvTGdGUHlRU1k5OGpYN0Rt?=
 =?utf-8?B?RjFxZjROcVlMYjFSOEh5L1ZtcG45WGtYbmpPanNWSytoNDhPS0J5NUNOSHla?=
 =?utf-8?B?WVplbThSRFRzZzdCazhLRWg4MVNDQWQ3ZDkvWmJ4N2ZiOFF5QkE3QWlidm5M?=
 =?utf-8?B?K1JUaFpHUWVLMXcyelFLZ0cvYnpPNFkzY25RNGUrUTFMTzJTL0d4TWtIbUlu?=
 =?utf-8?B?Z1pORVFvTDNsdk9nSGNLcHhhSXJtRHpkMklrWG9YRjIzY0U0bU9lNnBzZkdM?=
 =?utf-8?B?WUMzUDZYT0hqUWUyeDlVOEJxM2szV3ZXOFMxOEY3SlM2MURtT1FJMGVPelZu?=
 =?utf-8?B?bTc1MTZFT1N4cDhGTTRHOEFTbTJ1dnlEK0ZPR0kxUUFOZmhHaUtZUWxlbnY3?=
 =?utf-8?B?UE0vZ3J5ak5HbXJpVVdKTUttZnlGNEI0TnhjSXBhQWJ6cGpGL0hqNnBmdjF5?=
 =?utf-8?B?Y2EvSlREUUxqUHNLK2p0UTd3eTRENkR5ZndWVk1reDlGY1N3ckxOdXU2d1BU?=
 =?utf-8?B?NklVSk1yOEpHc1hDa1YvK1BtdmZ2bmVHR3VMcHVHMFFkQjgxQUx5cUoycG9P?=
 =?utf-8?B?MW42OUo5MmFLZ0czWkZKUHNid2QyM3NydVRhZFprZWVpMHd2NUdRT1l3Nmd3?=
 =?utf-8?B?OW5JTTBUT3hKa3NwNHFObm1DUjBlVDArUFVtdnZWZEJ1QWdZbXJkbVJOeXh1?=
 =?utf-8?B?Q0tCUE5ZVVZRaXBadFRXbjdKemtUUytxbXZOSjMwbXNVMFBOZW9nd3FrS1ZR?=
 =?utf-8?B?Slp6WEw0ZEZPc3BNRXVsM2JrcEgrMkQvWjh5TzY3L0FCUDhvaE9XKzhmMFNZ?=
 =?utf-8?B?Y1R3VEgwSm84eEhmc2hzbmdFNEQzM3JxQ05ySmJCdGwrZmhoYmVTNUEyVE9w?=
 =?utf-8?B?Z0ExTHhONGN3eVdLakRWbDNGdU5NcXU4N1hkSENZUmhmM2hvTmFkMzVyL2xF?=
 =?utf-8?B?YUtMdjBidTB5SEdsZVV3am9menZ5U2c3TlVzRTZxSHZLUU9tSWtVU3NKWlpF?=
 =?utf-8?B?Y3Q2NmtSKzRWTDY4WEtxNmhUSjljRENmN29acDNad3dJOGZ0RDNiZ3hTdm5G?=
 =?utf-8?B?YkZtN3U5NStZdkZTbFliOEpoWDlTNW0rM3lNVXNzYXZEdzdwa1lqS042T3lY?=
 =?utf-8?B?UXdVYzhCaE91L0pKbDh1ZFlxb1hQa1F3SWdUMTJ1UUlUMS8vOTlpMmlRbEFj?=
 =?utf-8?B?VVBIMHFaTC8wdHN4ZlNtNTRvNDFBYno4UWl2M1BJaEF4RWV5aDFyVXhtWjJh?=
 =?utf-8?B?eVJPbVk3Zy9WcnVBcTVqT0R0TGtCclRrTHIrQUpPQWxaTzFpWkhNODE4aHlL?=
 =?utf-8?B?dDZLaHVtV3owYytDMjZZUHpmSXN2NUh1YTh4ekd2a28zUnJzbmtjemFmMXZv?=
 =?utf-8?B?cTRDV0lJNVQ3V2hNVWNBeEdyQis2NUMycW5OYlVaYnVaR3JvYnZienc5Wm9h?=
 =?utf-8?B?c3lXTmNpTUh1V3B3clZCM0t5MkpKcmdITTBsQ0xDR2duWFZ1UFdYMDgrdytr?=
 =?utf-8?B?ay9ILytQVHBvMXBEQVR4MStQUk1nclJkOC8rR3krazRSa3lXWjhCRmpoaXlF?=
 =?utf-8?B?N2IvRzhuZkgxdm5yOERkSWpGZFo4T3pyU3dWRkF4ekNJSktiNHlKLzZKVmRI?=
 =?utf-8?Q?nizQAlESrmxufVtw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08c99aa-4f44-462b-5cf6-08de8068c074
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 18:54:12.9081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUX0hCKsctHBqKhYCiPHBiHC8CY4UCriNG47nMFvboHEu7xepXVFlMWeesWyJ5au3hlF0JLpxbUB9TCuEl5gfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009
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

On 3/12/26 11:45 AM, Cheng-Yang Chou wrote:
...
>>>   kernel::module_auxiliary_driver! {
>>>       type: NovaDriver,
>>> -    name: "Nova",
>>> +    name: "nova-drm",
>>
>> Well, but now it is out of sync with the file name: nova.rs.
>>
>> You should change both, or neither, I'm thinking.
> 
> I think renaming the file to nova_drm.rs would better reflect the
> driver's identity now that the module name is nova-drm, making it easier
> for readers to associate the source file with the driver.
> 
> Would that work for you?
> 

I'm OK with the name change.

thanks,
-- 
John Hubbard

