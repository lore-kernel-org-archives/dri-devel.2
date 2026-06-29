Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB310C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2678D10E831;
	Mon, 29 Jun 2026 11:25:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y4RNCZD9";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013015.outbound.protection.outlook.com
 [40.93.196.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9101D10E831
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 11:25:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHUxaS1FmaUUMiglfR61G08ArchUppVXWSJxWs1rQRP8w6qgkKdsiCjnCGuH2rg8A/Px1M56Rz2eQyIcOy6x5MdULMcYWuq0ACP1kpMQScCcQZVeQUiHyw1OsHKJ/QNL4HcFogQD8MEq1vA1Xubm7FBpPy6ruvWwBhHQg76aUHL5sl01fmVpYYPYE5eO86zc/z7wHUKkdd0eEcruDyAJOlYPPBbbD5QAlycXSrCdDRUJrIKhijo18T6FO1MViw7RKFUO47lbe+2+Kqepn1x1CUWuyR72IB4oOhzV/q1lptdvPPd59n4iPWXIfR4dWEPzj/pyiGNLAXfAWQBlQXBtSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVWLwQ+EPnqwD8LO9mn588btW81hvqv5F9bEHVVG9M4=;
 b=WFnis9dfFaAfYIPwb60EO4mgi8cr4mWcSyQ9KPqSp7pugWChCBfLVTBPdGcCRRvlvyybEQY/plb2etVWrwClGbMHfikh1zJUoDMms3MA8gvxpQ0d513DvkRwZHMAPYPudNu9AnNpxJ3HhUK31NHZe1KZqI8w8Y96JK0t/Hbd7aSl/vY5fStaF2g0jfC8O4OPmK0P0Bcl4zvo+w6q0ROJJWFUB8xtLl1tV3IEuxwhSEx2ydMu9uStjhcUJgie4lv69x2Lk8ZWdew9qV8PVz7lljCZS2dyynptYRLpMPVtc59c5o2be/NuU6CQZ/J4Qk4ExF7YwH42a5WD86OxoV7Dsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVWLwQ+EPnqwD8LO9mn588btW81hvqv5F9bEHVVG9M4=;
 b=Y4RNCZD95z/lXhVbFmF6cCkEZt5rYd+3DAJc29leFxdcc7QReF/ZYCAdKaEybt720QCLNwNnDULzGYfJwGlfHglAIPjUlBeSkKQFYmwyvg5zpYpr7GeXK8nays/quFE3HbOeCXsQpg9dij9iQCR+2JDGMqGrcIBOqOVuPkUmh+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9229.namprd12.prod.outlook.com (2603:10b6:408:191::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 11:25:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 11:25:19 +0000
Message-ID: <06fdbadd-f43f-4d9f-b849-5699b1c7d1c6@amd.com>
Date: Mon, 29 Jun 2026 13:25:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma-buf: dma-fence: Fix potential NULL pointer
 dereference
To: phasta@kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>,
 "Paul E . McKenney" <paulmck@kernel.org>, Boqun Feng <boqun@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260629075636.2513214-2-phasta@kernel.org>
 <688077c3-903d-4cf5-837f-40621175cb30@amd.com>
 <2f4ee171084d82235e23017886662b2d5b3506c0.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <2f4ee171084d82235e23017886662b2d5b3506c0.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0005.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::15)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f1d0f5-551b-4d4c-fad0-08ded5d1199b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: uDPp9P0sdAzBnAAWodb0zOoD9My+AnqIEYlmWJOJigvAYI3QUdBp1SuY0oxNkZJbJ/nCYYGZXEahTjXYeqbYAmriSRyh6N2NfApWD9AGuD+/YkP5IpvP67TYqj7uRcy4r1nOHCh/SyF6lsduixzMgypMuBRqi9fzSkGZYMBVBUAvQT8pcMrCEGs7OSrfFO5n1AAbYTsJGY564HuxsSAAYh4bKOHkMrzVEc16owWQzFIXGOvzY/gzEdPVS34w6ysoy48PGqlXQB76pky79LgFhkHjmNPc4a/r28cxByGkhGqLH9ktQzQ5RxQ1SF+zDSmY4kVOHSt3ALmWal9gZcYXQQUXWu4sKNOWMvX0HaXDPKTGFZGaW41sO24FuKB4tNDPpXHk8fnAS+dvERT4VtZh3SpFLcQH678Kkhx+dfQJx+T4IdNmVHIganD1pr5uLBhbqtfk1d/Hxf4ofAs55xHPmHK/V1yh0HDI+F1HomtcfvHCRU9bNYSID2NmE+3Jmgl3jH8tBdsA88qcLfxUNQbX9XLGdPx0acBQYKHeORR+5eLf5f0pwUj8RfVo2+OZaSaF9RMFEyjXsS4lCnGmqWvb3ItrUwCTCK0q6Y8tudkC4EpFyLcMrkc6LsXvyZ9TmsJLdeQJO3ivDwa1mLcak0JmGtfmoo5CS9GMAx4uSxAVMZc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW9uNlpBYy9lNlhmR25IOWdaZzZyOWFqRVlwQ3hIRXlYbU4zbzV5TVl0ay9n?=
 =?utf-8?B?My9NYTZKUC9Da3pvZ0dYWUk2azByU0RqQXlGQTlUMWJYT2pSZ0liSHk1cURL?=
 =?utf-8?B?ZCswT25UU2VMVFpYYUdoY2ZDQjNEVDlJR0Qra1JyYi84MG4vcWFwTVJSd3RJ?=
 =?utf-8?B?Z3pyWEVKbWY0NFBZYklBbzVZR2l0WjNqcXNhOFNoTWl1VmI1NDdrSDNjaUE2?=
 =?utf-8?B?M21BVHRRdUVpNlBRN0ZMKys3bk9YMXFESkNCaWhCVG9NMy9PcmJyekJzSUtn?=
 =?utf-8?B?Z0Rld1VEaWw0SjJhZFMrUkQwZ2NsMGUxNXlFcmk3L01ycnlWM050dHZSdXVV?=
 =?utf-8?B?b2RZaWh6T05JYkxZSE9jM0xoNGZxY1l0ekkwZzhHQmp2OEY4ZXJscWZjakxO?=
 =?utf-8?B?NzR1UVZSeGlKbGZxRHplWko5b1JjNVhZQ3Q0SWo3NEkrdE9OMFY0b0djNmNh?=
 =?utf-8?B?M3lLR1N3WTNvUzBzUHZKWE9sS3JGY3ZnM0hnSVNZZ3lESVRqYVRDa08xaUJ0?=
 =?utf-8?B?QUJkbjhIcHMvaUxjRHh0OHpLOFQreGJ4SnNpQk1CWHdhNEdSYStFbWNQQSs5?=
 =?utf-8?B?NkV4aU82TU1DR21DeFgrM3VNQjFULzR4Q0F3L1g4MU9tN3pxanZZcFBRbU9L?=
 =?utf-8?B?Z3RTTUtreHcvcDVCQmdCclE3S0twcHI3bmwwdVNyeXhtTjdPOUp5OXJTN3VP?=
 =?utf-8?B?dXA5bm14bEFtTVBXdTEwOWlDRkVwQ295dGdXcFJHWEtycjdJdjNOM05yTVY2?=
 =?utf-8?B?bVN4S3FJclJtMlJYZ240Yk52K2c4dmF3cnlSSE0yMEdQc3ZhcEpMSnpjbVVy?=
 =?utf-8?B?dzBzaVdRT2l4SVZHdklDdzcyK2pKMTh6OE5lck9PajJPT1ZEWmVtWEN1b1dU?=
 =?utf-8?B?RGx5WEhTUnBQSXlTTVZsRnQ4VXVPeTgyS1NSM0JaRGJUL1lvUHJlQm43anBZ?=
 =?utf-8?B?Rk5aQ3g4cUx0djBFd0VHODQvZkFxRnEzbVZjOS9GSlUxZ1FBZVg1V21kRnBE?=
 =?utf-8?B?TGUvWFc2b2EwbzNoZ2l1QjZ3WjM2WVB1a0NYaUpJOWZhRnNtOVBVaTFVc29P?=
 =?utf-8?B?QmplZlB1VkVRZnRhbUZxTzJIN2pNb1NET3ZtaS9SaGk4R3dnVjRFeDdQTGo4?=
 =?utf-8?B?aE9UVk1zeW9KU3o0OFNsYTlMcFVicUtyb3NTNmJGODNUYlRqRkhyN2o4K2V4?=
 =?utf-8?B?Ti9Va0hHM1BvblhPMUcrdXpYWDhBdnRXbS9udnJOdlY1VWFCSEx2M0FWbXBQ?=
 =?utf-8?B?eVZUWWY4NVBuTkU1cExXRGsyZGYzVXlkRFFUenJ6VkdzbzZQTlhnUk1CUmZ5?=
 =?utf-8?B?aGNZTUJVUGNSN1l3NmhpVGNmQTZBVGY1SFNTUWVBYTRWRjh3bGtuQm9QZkNt?=
 =?utf-8?B?cDAzZjQrdlZLMWRxNldBNlFQZXFaeTJZb2RLbkxYd1RVNUFEVUIrNkxPbi9h?=
 =?utf-8?B?Mm5EdUZGR0xRMXUxZE9ERTVYa0tIT25adERzeWJqd0crMC9PV2xjVlNpaUd6?=
 =?utf-8?B?ZVRYcC9jOG0zS0JsL3BMS21jeXdDSVFRUDVPYU8xNk1rVFFmcUFISWx3cUsw?=
 =?utf-8?B?RU4vcWdMKzRMU2UyWjEydnZqWDhoaHRva1pVVURmNmdnTmFPUmxLYStGY3d1?=
 =?utf-8?B?c3Y4cHZoL1A1Rm5mOWJkeDVWNy9ZOFI1SjNvMnNUK09ZdWxtOWkyR2ZBc2ZH?=
 =?utf-8?B?a2dsZUVqcDJzeWs3UDR1dUFrZU5iSjI5SFd4OXB4YnZPWXpzTWQ2YTRBVVpS?=
 =?utf-8?B?VHNFNWx4K25WZElRYUZMQnhaM0N1WG9ZTzdFTXVSUGZaSVJRdWczdHdIL29X?=
 =?utf-8?B?cHZUNWtqamJHRGFxREJ6cEl6dkM4Zkx4N2NFRjlIRG5vazBhSXdNSEl0VWRK?=
 =?utf-8?B?UmowTzBzUkFsdXV1STh2WlJlQ2hYU0Q0TWsxaE1uWUw5eGtqSEJUQmw5Uzk0?=
 =?utf-8?B?SG1FSkU4TmtnYXhmem0yMEVZSHVuQ1BFWTdMaEZiYmhGSnFsell3T0l1dVNE?=
 =?utf-8?B?MnRFNk5HU290M0w4SUtKWHdvekNidUxTNWFqSVlkRTZOMkVxN3MrTXUzRjlL?=
 =?utf-8?B?MXM5VDk4aytFYjRHbFBJMGhXRFZoaVV0M1d4Y09uOStFVVVoOXJPdXB5c0ls?=
 =?utf-8?B?RFR3bFkwQjFQdlVQTmNSRGRJN3dxb3M5R2tGeUI3RVNpT21VQVEvWUNHODVL?=
 =?utf-8?B?dTVFd3Iwck9pWnlDT1NVMW9ubG1YQm1Qb3hmRUlUUmN2c0RnKzFMYngwRkdy?=
 =?utf-8?B?OGo2OGRiMWprSWo5eG9WWDZSZDZreDdacEJ6VEpyN21xM2I4S0xsNWY1YUhZ?=
 =?utf-8?Q?U8niATPe7q1sfq4baZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f1d0f5-551b-4d4c-fad0-08ded5d1199b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 11:25:18.9737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rnf4Ym8Axyd76WM4xEURvcfsdGeFcchdtaNmbnV2D0/krL7ScrUH+zHcv/nhhag
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9229
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

On 6/29/26 12:43, Philipp Stanner wrote:
> On Mon, 2026-06-29 at 10:49 +0200, Christian König wrote:
>> On 6/29/26 09:56, Philipp Stanner wrote:
>>> Cc: stable@vger.kernel.org
>>> Fixes: f4cc3ab824d6 ("dma-buf: protected fence ops by RCU v8")
>>> Signed-off-by: Philipp Stanner <phasta@kernel.org>
>>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
> 
> As the maintainer you push that one, don't you Christian?

Already done so, but you based the patch on the wrong branch and I had to manually rebase it to drm-misc-fixes.

Christian.

> 
> Regards
> P.

