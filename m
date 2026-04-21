Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2822F8FA94
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:09:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1903810E8FA;
	Tue, 21 Apr 2026 16:09:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XsY+50GF";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E788710ED0F
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 16:09:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jk5//N+iEh8arHUnfwUlOMQbjcA5yg57D5roqw6TbYxaQiUaDcW6jf7W0l6M42/2sO/7tcC78H0n7ttpjy34GmzH/JpDHuSpz8tosjblCZ1KmtZh0VlQR5B2srg9i9s4c400U9yU3PwL5a+mR00W1UJtqiziDJ8TKA2NfAgiwGvI1hdE35Df6eAaJb4CCUOHzDXDn1ZXnNEWymKr/Ne3cJoNO3qkDLCRY0ZcHHuVojE80M577BRPRtCYP7aZM4UAKFIliNpzXEY2T+1UZZr+uAZigrgsH6yHOy0ihPzEJrVHcR1o4z8FGBrGI8xx4nrd1c1YxVIkP0GJUmyvcRpL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjIXUWFD5PSKh605lzR2CgrPe4qw1pe0BqVGDeXvMAY=;
 b=i0tH+rDkJ8MT0jlFoXK9RngManlJ5l06R7e8JV2tZ64Uq89Fohh1R0JVIdCWspOsgCmBhDKX1wDVltIJ7kN8M5Lqi7w+a7P55lIstFF0lfyu/GN7DDVLa4vST/tLU8yXLe3YyHz9kr1lLd44DWMvz8FnxqOFpharPLYQ8DqsmvnTT/r6/dSsbqCNQjqVtawgVV+YXalnea8UaqsoDg9mw+tZujm7ymy/UDNR8u86xTBZNJL5s84ZZqfHuhvi8zOOrjACXpiG6SlLpdeCoyK6GaWatMn6oclesdIbJBaIManvo6eFNcyIKmyGX3/4Nevk88whpesnw/JtDl8hxMkmwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjIXUWFD5PSKh605lzR2CgrPe4qw1pe0BqVGDeXvMAY=;
 b=XsY+50GF/D7+VwE2uMWTjoVOysxKIAifbHfrgKnCasMWuymkEjB+cpD9O+18zHC/bn2kavp9135Pw9MQMBbc6OWr06+uWs3zWN+Ky0QUvVcuSQZJSgmD/nU73NXKqdoy6tDZM5lzNwQfXd9ccORRCHVGXFKjw0bUAeA0gVxN++THxocMfBt0FQd5r7d5uc8rXjAY8YLLH1uySXiEospAMQNz1t82TSF4hfXmd4W4IRQf//c82DpIHp5GqQzXcRq18W3wSidwXTDYXw12Nl/+0+uNdsLX4VKhgTe1tiQf6QHuFX1gLmmrdvvIGl+TUl/2dA8Qub79aIcjFBlIicbr9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.16; Tue, 21 Apr 2026 16:09:21 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 16:09:21 +0000
Message-ID: <2ad8fcfc-bc49-4163-b259-3b0d4a63a958@nvidia.com>
Date: Tue, 21 Apr 2026 12:09:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] gpu: nova-core: vbios: reject extra PCI-AT and
 FWSEC images
To: Timur Tabi <ttabi@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>, John Hubbard <jhubbard@nvidia.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "dakr@kernel.org"
 <dakr@kernel.org>, "aliceryhl@google.com" <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>
References: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
 <20260414-fix-vbios-v2-11-705d30d16bba@nvidia.com>
 <acf292dad3656790a37f8b2f7b3a21f0cded50ca.camel@nvidia.com>
 <D7532B99-704D-4021-957D-1B50E33D29B3@nvidia.com>
 <DHV2V1WWP7EB.2ZCK3X9RBH9I5@nvidia.com>
 <a536b70d-6d55-480e-8f2e-76b4b70b8916@nvidia.com>
 <b3c76bebd0080c05102747a5ead5f3333f1023d5.camel@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <b3c76bebd0080c05102747a5ead5f3333f1023d5.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:408:141::8) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM6PR12MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c7a94eb-30f1-40b4-9e26-08de9fc058e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18096099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ii5g9/MAs7TdomOfHqshhYVlKKDw25bbOAmJABVdX/k0jgTovz4362wM8PQt4XOov5kMvEYxAkWVyHLlqLk8I5YUaEWK0rxnmI4R+3zUCU3Bx16A1uNiI6ZDU3XzzlnzvqRFHNu/I/086gHy2NZWA8Mae7MCDdbBS7lGV253KRINbtzYv12KURXsMlvw+fYYPsdsval3OyUvbB87lXBt5K2lh+d247TjcSDVCm3M8uw5K0+kUjZeOonRWbzaq9lNqpyAmCLYIAR2sk43quxfJHFFCZ5D3nIVjvq8HON/VXxUYaPEoQzThwurF/J+z4gK7/tgpVOLfEuu4QFpMPyaIlcjunjizLDgSfv2o9PV6GVl3V7XuNJYTDewyOQn3aj3f6ydXfTaRjNJWrZrQ4BVoz2jyCxrTcfmCSroMYVk7qH58hPvIdHxMN6iEPmPap0IDTsbnnGfHpR/tJysaBA+BJaS43ZaHoWoUoz9frgbGmAlj55rB8XR9IBmnz9ULttNM0VT5tTvrOVkW259MdcX8UkfRi/K5+Pew+aOrB3VLWretnwKmGxGER1shCrWsfoD6LnjYn70NGW/hlJtA3KS79mp4UEmaoFJu0IGfFnpfZsKqVya2SZdNpVLNV69TSuIDiiJ3OffuNngLsy9gwcNu/Pxa8qls5lhC5yVW+h9jAqvFVyTdnzuBv89SqdpY525MB06uZqIr1alV2GaSfjBa6YjtZdZNNgydoZj/2YWri8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18096099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGxFNm51L1R5UXY2R2xWSndQK3FNc0VUN1NlVWpkWm1JVkpmQk1RL0dWSmd3?=
 =?utf-8?B?TlY2VThhM0tNNXJrZHBrdU1oc1NMaUdta3RocGM3Unl4eGNwcUw4QzFJNSt6?=
 =?utf-8?B?eDBmYkNaS3NwKzVkdnFWK215aldnTTNZRStkRXVPRWdvQjJnbFBKUVlJZFh1?=
 =?utf-8?B?Yy9meGx4UDFWeE5IdC9vdVo3UFd1cmJheU8rbFJTeTFMVXVURHZ3cTV5OHdk?=
 =?utf-8?B?RUN1UkdOaHR5VEYvWEdqUVpJQ1VMU21lcG95bTNhWUF6M2JTcnhwdS8rUndX?=
 =?utf-8?B?M1hNYlNPUFR2UFlrUVcwK0J0SjdkdFB3ZkU2ZHhFVVdQQU5lS2JJVVVKVDRS?=
 =?utf-8?B?MjdGSFczQkpoVzAxLytlQS9CV0hndnRhWlJtcGUyQm0ydUhIZzUzVFFaRXpR?=
 =?utf-8?B?NE51cWZyN1QyYTMxRlNSckpYSDhYZ1I3NlZYaGowaVJDa0JpVzdpdjcrbnhC?=
 =?utf-8?B?UW84ZjR0bjhCSzh1S0JocEphajRTYnVtOWVMNGpqcnVoaUJ3QnpsRU9JUXZY?=
 =?utf-8?B?Nld0cExTTTFHQ1Y4Mjg5YnlVcjM4UFRkcGFLVXFjYzVaOUQwa3dSTEFaYnBl?=
 =?utf-8?B?NmpYWjViTkJYRWN3NGtFUzR4bFF5cmp1WVROUlNYVVhTVWY2dUpzc08wbm5a?=
 =?utf-8?B?dDhjNjkwdEpwVmNUNGVxVHcvSTVRSGZrQ0JCd0ZqNkx3RzJtcTZrN0pseGZo?=
 =?utf-8?B?SlpCUGVBTDh5eWE3NDl2aDZNdWpEYVJlenRnUnRwclVQZ3RYRXRwWUlnRlpJ?=
 =?utf-8?B?U3R0MWxmQVUyV2k1Unp6WVhGSVZHNGsxODdmNnhpQ2ZITjBKUVhoZ3RIK21O?=
 =?utf-8?B?cEQ2OFNJeTF1YzkyTFlWZ2R5TXJpSjRoQ3dRRVFPUFpYc0R0d1lkL1NHVFBx?=
 =?utf-8?B?WTBadC8xRGZ4STh0cVVuZnhZREhhM211NHVmWDZyQ3pTNU5ybEZPZWFNdDJp?=
 =?utf-8?B?WkpKZVZyWEVlbzJ0T3cxZWVWZjgrNkUweHErTEdkanRINFM5bHpYMU9GU0ZJ?=
 =?utf-8?B?Y2RJYVZSVEpLbEhRMTFZMFRwQlU0WnNZTUY3TEp2USsxWWV5OVp1SnNHbEwz?=
 =?utf-8?B?SGJPQWxOZU1YRTZDWFQzWUtrVzkvUXNMZjhuZllTUVBSTGZCSTRZNkIyYjJZ?=
 =?utf-8?B?TCtIVDNVeUFSMnJtc3UzUHhWdWg0MlJQb2RsVi9BVGVNSWJzUmJIc0IvREx0?=
 =?utf-8?B?bWo2OGs0WGxZYXdwdjNCaU5tQWFDdHpSdjVIMnVHOWRDcTBIcEhnVzlpOWp0?=
 =?utf-8?B?dUFPakErTTdMdGxkQzhtUERWZHJLMHFOZGoyRGRiVHBvNyt6NDU2bm1yb09O?=
 =?utf-8?B?TG5rTVpwcHhjYkxUTkJxNU10ZjhyQ1ZJbkxtVDRkNUFucTllandvRDcrV0RY?=
 =?utf-8?B?eXN0Ykl3Y0tLcXZDSjloUVgwS3A1Sk4vRXdxL2pTZWlBeTdjcHpNcFR1amZM?=
 =?utf-8?B?YTFyN3lqWWh3Yno4TGJ1YSt0TEtnTmF2RGlpb1hZV1B1dWR5TTZYNVdmc0NY?=
 =?utf-8?B?dWxnMVZBZzhqUnA1TEZDTDRTU1dvdzN5bTYwMllscUY0QlJ1YUd2ZUhQSXFS?=
 =?utf-8?B?WFJCM3B5dVJkTU5VeEdYZXFQTDJnM3k1MXdPUEt6bHBSSkpmYXF5YXY0ZUZV?=
 =?utf-8?B?eFo2bVBzcHNHQUhnNFgwS3h0SlpKVVErS2xkZy9PRzJKMDI3SHdmSkhET0lo?=
 =?utf-8?B?dlZ5S0NBWHlUN2hqR2p6eWRPWnNHVVBtM09CejAzTldjbUE1RGI3dlFWNUFt?=
 =?utf-8?B?RGk3c2pVdEhlTkllSHFLemsyZXVnK3dtY1V1ODBvT3hXZUkxZEpWdklSSGc4?=
 =?utf-8?B?WWdUVDhRMm9NVklCMk5IUndYckRtUUJ5L0tVUjByVU1RZnVoWC9MSytySnpm?=
 =?utf-8?B?R2EvR0xEQkM3T2Qzcm00V1FkK01uMkJLRmxrVXpZT1BnMi9uaDFGUXdpTDh5?=
 =?utf-8?B?SlVqK2dpbjlUVDBJT1FMa29uNkxYYjBYNlZOSGtxOFluVUVnYWhPRXRJM0Fh?=
 =?utf-8?B?dHNzdUZzNTZQY2R5bnZKWTVSQS9uR0FvUGJreUNBcWVuV3pBRFlCa0JhL3FB?=
 =?utf-8?B?SDhWdC9lOHNZWlN6L1hmZ0xxdXFzQ25Lajl3R1Y3NEdmLzZIZ0lwUDJVTlRH?=
 =?utf-8?B?NGJFK2hyV2I3YmQzWU1TcEVMQ0VqRVhuWUgxVlBRcWNPbWZXdTFxVm5MNkdT?=
 =?utf-8?B?RUlLVGcreWVjY1RIS0p6SnVjNFc1QzBMbFZvSUlPaFR0Z1dlcjVXK3JVYUt3?=
 =?utf-8?B?dEVIYVlsNm9IeFB0d2toblJ0bk5jVHE3Ry8zZS8yRFFvUmd3RWc3ZUpWTHdF?=
 =?utf-8?B?NkdLMjJHM2srdStJVGZVamJWR0dnOTZMc3JBQWM5UlM3UXpKTDlFdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7a94eb-30f1-40b4-9e26-08de9fc058e9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 16:09:21.1733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+U8/GY8pkRdPzFdKh6MdlHyAzDfFcmZha+Oz8weC/Jc5/fm25rOGhFZONcN0B4x6aWVxNu1u9mvYnRE31GYPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
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



On 4/21/2026 12:01 PM, Timur Tabi wrote:
> On Tue, 2026-04-21 at 10:45 -0400, Joel Fernandes wrote:
>> My opinion is I don't see a benefit of changing it to that because
>> everything including Turing is working with current code.
> 
> Well, we can't really say that, because we've only tested Nova on a handful of systems.  Adding
> code that detects and reports unexpected variations is probably a really good idea at this
> stage.

I mean there are a lot of combinations of variations that are invalid, any
code change should be justified, not random. That said, as I mentioned I am
Ok either way if we want to check for this impossible condition.
