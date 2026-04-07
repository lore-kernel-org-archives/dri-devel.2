Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99707FF512E
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 18:30:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00F3910E497;
	Tue,  7 Apr 2026 18:30:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="FySNrvvX";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011036.outbound.protection.outlook.com
 [40.93.194.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2B0410E08A
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 18:30:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJwrKJQVBltkbsa1Shh9DDOVAtAIsHyGXEMK+8d2cDvzeoCfDHE3UoXIvGicNLF5FBsgmhHBeEguPsivw+im6RGiFG9XfN9xzeOHeM9yGdHoJKvXPUY4GreUbBrzJJPm72fnx4MGV62FJ0lAlF+XjSu3SIt9m1SWLjiu41shBa023jsQlWAWpM9rX0s6WHiUiZd6sZKLxThqKuWEB/khDKwqXu1+29TBA+jRBgpw/+3yGGBfjht4BgF8y/ccUf6EvCu7TxZ3xDdMbkrIAt5+uUrlHZdP90wsfq7n7MxOv8SOV0mI8E9YhAa/3gCEvr9oGbLBUJlaR+rxAy3C1JFsuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ffe0wwvsZ1GrmH81+uOIX/B0zL93AhDfdze7+HrI37k=;
 b=TcSNxp9SErS6POA2vZ+SmBwzv8jtIblIGnKzQVYk184IHJCGKo9L4bth7UVLhtTBSJLkVuytgTlo0eOHGvc7EuC2EJ9aQO6fpDmUzMdwSaD8zA1sb1mHBX3yc/oPA6m6LuGlWgQNIBvhORncDT8W+YyV/GxXEPRqBl+PdmZbM2/9pbDLhbKsGNqbNng6tjf+EBsuye8GdtD0Gj/iUsVW2j2SLH2AA1kWT1Ya1WGUQwT0YFc+JZ9nEcYf9nBl4cFXa9cbl8x/EbAeJT5ebt3p5qK1PlgGbVcBKrGEO45KO8VAHBbOKA4Zf37mra7Q6h9BFQNYn8UvVm1iQRgrvLl4vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ffe0wwvsZ1GrmH81+uOIX/B0zL93AhDfdze7+HrI37k=;
 b=FySNrvvXVqY0dRI0aY44Dxhuq/zFFZUvCEisIxZM0T3A4ySz/xI9MUUNCIgTglWS5kA9PnVVJ+m+Oo5GoWQMJw0VBxpDn0H4zQ5IGaWO8p4+l/+YLRROGkffXRrKlTy1xcjWudlt+9a9DDtWhg7zfIUT0H0If7M13HlyMumXoUgoYOhngcmtX3jhWVTuW7Opn+5VGd+s+BwtUgmao/RDowBo3Uhq9DOJvh5ZQHKQ6ZEqdfsPWqdcjVwd18UvNqq7LLnxuuDD10/ljk/DeuZOr40hj77dhyxUseOPM9tD6xieoluOljmVoh20iy+vcnERXmGfTDdzs15XyQuD2VMfXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 PH8PR12MB6746.namprd12.prod.outlook.com (2603:10b6:510:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 7 Apr
 2026 18:30:16 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9769.014; Tue, 7 Apr 2026
 18:30:16 +0000
Message-ID: <f8229cdf-77bd-491c-b0ed-bbbe33156f1d@nvidia.com>
Date: Tue, 7 Apr 2026 14:30:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: nova-core: require little endian
To: Timur Tabi <ttabi@nvidia.com>, "dakr@kernel.org" <dakr@kernel.org>,
 John Hubbard <jhubbard@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>, Eliot Courtney <ecourtney@nvidia.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "aliceryhl@google.com" <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>
References: <20260406-fix-kconfig-v1-1-8f634499f7f0@nvidia.com>
 <a66916c8-8e82-4e54-8e21-b312a7badfc4@nvidia.com>
 <DHMVA3S2MZWV.1JN7WUBZLRWLV@kernel.org>
 <6c0ca9e1e574635710ded3816bb9bd429c19dad3.camel@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <6c0ca9e1e574635710ded3816bb9bd429c19dad3.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY8PR19CA0025.namprd19.prod.outlook.com
 (2603:10b6:930:6::22) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|PH8PR12MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: 07927743-6286-493a-324d-08de94d3b6f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: VJWxmgXbgOXGCFs9iWlemRHMiAKfXW5udbDmEqjGr9VFNF9sCSzy/Pxq6616naC+FlfwSMLhyEkpX8tg5b6Bk11zWJ4r4WYKjKVvZZOxmXYGPFNbsMmNPZzpQoyDPSaGtSj0r+tDnaVRQzrWVkYMC92gNcuAhXctt2T/8bHZIZx0fa8gx/JGQCaC+IdgteofQRnBEBn8fOk+HBPVWH2CiIK0p5nVCqprIB506eHPK3Wdio03zjoP0lWIYeqHioEIb9Cy4PpTH7TPUes7JrNwzQIvze9UHD5R230C1OThhHOpygPmqZL/OYj12Q6zfIoLoYEjQYERE35Xqqn1lSbEDLtuAt+pbkbUz1r2hC143Pnyq8XCKNyEqbSOcrpntkCeF83K1mHXpbVL6ARA2pf6U6TbL7PrW62qd/khkQ1IQuv2ORiL5e9uPEFD3Qy189bZTN+NzSG8kUFuOdGX7K2N7TLEcRYQ3Uucon1ZJnvdcOeOH/g0cqpAbvmzJSnrnlrm9QI07KovCYPkzpmv5cNMon04aP4v3dMI4Jj9vdiMG2DDCTR5D1uToWX/lKvYphwsBnTXEErLoTTx4qt1bsA51NF0CS4RobvTCPE3cBV6Cc4x8ykD4UV2GOyKaYaaNB/8WKM0O8xRunVQXmxy7NVTPLiWXcMcYE8JKjOaoc8VbuR98ZmnvzTp73N5fnldaYoEAU7rMTWMRj1EdEllky7kRpllkv+tp9W3dPXv3iiCzUE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTd1Q1RsamRGL3FFem5La2NpaVE5ZU1INmdDSzB1dEwyVnVrZTEyZ2U3aHor?=
 =?utf-8?B?WW54bksxZUhEYjBHS1hKeFpSWFQwcVNRVXp4Z3EzQUI1TWsyZFNXL0lJRVNU?=
 =?utf-8?B?R1k4QlZOMzhkMWNoaXlIUGF6UnJGaFFKMFBWdm1rTnVsSkJkcTU0OVZyazZV?=
 =?utf-8?B?ZnlDRitycjBaWjU2eUlJOXA2RTJCMTFuSFRlNG1VelJWcjZlNUpGeFF2dmdj?=
 =?utf-8?B?S3ZkQjliVEZLeWFlcUlvR3g5STYxdS9xNVhxc0ZpQlFCaDBUYU41RDZWZDJa?=
 =?utf-8?B?TlJoMU5wMGxkTklmdGlFU3ZXWVB4bytmUnNXWnVmOXp4VXdRQTdYOXZuNlEv?=
 =?utf-8?B?OW9GZmpKZ001c2ZPMm9LSlBJdTVwM25yUCtWVDdQME1sK25qcmhuWHdZYjZ4?=
 =?utf-8?B?Nmk0N2l3UGtQNmdrbEtjb1JFcUcvckF0dFplelc2MUc3OU1tSjNsS0RaWjFD?=
 =?utf-8?B?c0R2WkduYW9oM1REMTByMTljR01DYW4razF3bXNyZmlxYzBuMkdxeEpoS242?=
 =?utf-8?B?Q2VBSHRKTEdZVkJxN1ljZ2VqMUZKY2xTK1E4Ti9CS1ZsdHFCa09UT1VUVGpt?=
 =?utf-8?B?U21vcE9mam1lQmdYS2N2SXZSdVlxUWw5WWJYWG1LamRVUyt1OTNJOHc3cGxT?=
 =?utf-8?B?VE5XMjJaMXlYS0NLdTRBMGRsWjRJQUc2alVFVjJXR3IzcFlrbUxHZ1ZKMGxx?=
 =?utf-8?B?S2ZlOWtLKzBYNTBnNENYdkIrSDRXMFVaajBwbWlrL084cEZrbjdzOWNHZjc0?=
 =?utf-8?B?a3loRnlsdWpHRVFoQzU1RHI3N243cGFNdC96eW8wdzZrNkRRNUxtTTJQcFRQ?=
 =?utf-8?B?d3kvN1VHdFhONXpRalVLL1JTbmVQR2FaalhCS2VDM0dEcjdnNm94NmdGV293?=
 =?utf-8?B?UGxxZHRvb2hZcUMzbitDVXZTdkpmaEs2UDNSWmcvNzEwV0dyVUZJQlNJenFE?=
 =?utf-8?B?QlpvSGs2cHg5ODVHb3FiQ0VGY3dVTnJFWVhoOTJ3NldjQVM2alQvY2RXUzNw?=
 =?utf-8?B?amtZdnVVUUhyMjVrMnRuc2hFQXZORkRqdS9SMXUrOW1TZDdTOGpTRHRDVGxt?=
 =?utf-8?B?UW5yN2Vaenluckd3cEx4aXgyek03UTNRbDNDQVZWTm1GNkVYNmZ1QVlxWXpz?=
 =?utf-8?B?dFUwTTF0a0N4cXpMY0dtUTdDTUFlemhsU1ZRYWJxZEs0VXFpdnRobGNkK2dF?=
 =?utf-8?B?LzAvNkpMaEUyZTd0dllvdzloUUxlSUUzNnJFZTdUY3RVUDJ5eUFPeUgrVCs4?=
 =?utf-8?B?L1ZVWkRNb0orSGtCS20zR2ozOTdPeTZNeE5NcVFjZUVQS3Vlek9zQXo5Snds?=
 =?utf-8?B?OTlnTkkyQkJFbVhrY2JJUjRwa05FUlVIVjNCZ0VWZXNhbGU2WmpMOU5BeEFX?=
 =?utf-8?B?MUNXS1FkNytjWFUrc0U2NHJKYTcyVC9Ga2swbEFqVllkNmtJT0ZZZjI1N3c2?=
 =?utf-8?B?Q3JoN3ZMWDVLcEVGU0JscGd0M3h5NFVwcDhpcmpzVlpZemM1VE9WSU1TTzhL?=
 =?utf-8?B?QU15SHArTVczZkdyTHlhMWRGcVJZNUpqWXRQQnlPdVZ0WkR3T1hTanRmaDJQ?=
 =?utf-8?B?K1lqaUFZUWlITUNvMG1ENUlLM0VtRmhZL0ZvbDRvQVNZZUdWT2xPREZ3RUtB?=
 =?utf-8?B?ZVQzcWVUYlhRb3dwcGpGckVodk1YeXdQb2xTVjBJbWJsNEJrTkphVWNGR2lC?=
 =?utf-8?B?dlVKcUIzanlDTjZTWnNVSXQwQ1lkM1I4RWZxaXgwUE9vQ0N5alZ4VEtZRnYv?=
 =?utf-8?B?TmQ0T2ZHdk9FOHJnMDdnckZjN2JBZFBjTHpNajFhQ2x2aVF3a0ZrdHdDc2NN?=
 =?utf-8?B?SDNmRy9xZ0xUbWtpUXhZMGxCNjh6emdpQjlHNkVVYzFjbUpncy8xMUN6NlJt?=
 =?utf-8?B?Zi9PQzFHL05Ib3NNVTJlVTgzNDhNUjMxOHJ2YzhIcko1Q3J5TzlSUWEzYS9r?=
 =?utf-8?B?MVV1cnVVcXNuMVkxU1FqSThZVTlod2tPSHU1R2FXTTBUREsxUTdDV1NZbTAw?=
 =?utf-8?B?VHBBUUprQ1Q2RENZRGVKK0tQVVZXdGtRaW9LendRbDFSZ2JaMWhkcndydjd3?=
 =?utf-8?B?UDhMd1FWQTZFblhreXZMWnFsU3g5a0hmWTZuVFh3VGIwdEJtY2dhOE5wUlBm?=
 =?utf-8?B?STRLUEtwZThCd0dzeW9LdGZrSlRHaUpFRHFwVWx5L1M2VEhvOTdIWlRGaGk4?=
 =?utf-8?B?RDRiUnZiSnQ4Vk95WnpVSng1UWlObk5CMjhBdS9hRDE5cWxMcEhWVEEvSWtO?=
 =?utf-8?B?M21GdHVuZFVkTHM5ckoxVTVWQng0dHZSTVJyU0ZZSW40N0R4MFpLSzZIWFRj?=
 =?utf-8?B?SWtzdC9hVjd3RlYyN0cxZ1BYR2xqb3liS0RLOWp0aWFQSU1oY1JNUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07927743-6286-493a-324d-08de94d3b6f2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 18:30:16.3510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54MaXmK1ZlkiPWN01y6ewNxtbkeF3jQTdGmskWsOJWsR/oRZCFBgMVLfceVdbjPnN27yLCC6yxqonbYZD7zg2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6746
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



On 4/7/2026 2:02 PM, Timur Tabi wrote:
> On Tue, 2026-04-07 at 12:56 +0200, Danilo Krummrich wrote:
>> On Mon Apr 6, 2026 at 6:30 PM CEST, Joel Fernandes wrote:
>>> Nouveau does not do this, and no other GPU driver afaics either.
>>
>> Nouveau has nvkm_device_endianness() [1], which it configured before everything
>> else is done.
>>
>> I assume that's not an option for later GPUs?
>>
>> [1]
>> https://elixir.bootlin.com/linux/v6.19.11/source/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c#L3111
> 
> Pascal is the last GPU to have NV_PMC_BOOT_1_ENDIAN0.  If nvkm_device_endianness() is called on
> Turing, then that might be a bug.

Yes, this was on old/legacy GPUs, not GSP-based ones.

thanks,

--
Joel Fernandes

