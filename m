Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BFDF9934F
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 08:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9062A10EFA5;
	Thu, 23 Apr 2026 08:15:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZyGueEen";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EDC710E333
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 08:15:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZX/KPsdQVwqSglfcoqk3PUI/4k/rg3T05vwnoh+/5OFqEbNawXDcNh/KHw+EnsSvlVpCNxTm2UVIjAsd56ETS9WELv5XvO9nxudwdHLt3eBk5ilHE0K9ePe5hbS9Wu6gD86qGLXMEJW3sELjX1H4cZ3pmgh3fe76kcJcOGAKSt4BTPjNVbncVxdpHxe344rznottTva3SRr65XqsV56nc5h5T4GjBJyLXYBAbQi4FIZLD/huZ8gGfNjXsTDdvFCyJr9VPtzym/nTxcM707pcShwzak019E6Tl5Xo1+5aY9MI1lX5n2ut7wor9WkTb1nRzb80LAS/KYOpmewMHD5Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzZwVOGPGtjDTKy672Tv4MuTd91KcY/G9NYXxrlypTA=;
 b=yKOCR32mTqPO/WoloKY2sZsY6N4zxmh5kLgxmKNK2z5Fe4qP1a0GqVRcquO4JLm7pG6R7UFxwj6B7bJlzjDcjfYNnjv+bKLh19q2YHUxECxEDJ+8kuuRWsp5P4TeAzhfaDG4CNLBLyVwmoaZsnROvgCtw1r73oCwXYbOu74UwGzyyzNDXWJ3r/IIcJ4FFbbxpGrS0qq1SjNcmOsQKtnbDxtZSe8mt6Hv1L888cBTxPsl/yfCCmss/qSRQ7W8EcF+vgHW3f/cZZmHlnTF2Bju5rDzq41TBzdF3++BrLnF9zbs6Mkz6nHoVFsAGEFxULY8kJy1tIq7A5czSj522wyeFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzZwVOGPGtjDTKy672Tv4MuTd91KcY/G9NYXxrlypTA=;
 b=ZyGueEenFr6QbCem1fJx3u2GlIwiAA08Xe2UM78AHerx/HgevlyqheEnDZQ79g6O4qBtTtN4hgXnmNL2pIFMAyuPAe9lJMayIlfsq3l69nvplqa6u/+xBm82pCovCmFbEroHhxq/gqYSkFYNzo+LtZORkbyAkB5nZXY0sMyfX5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Thu, 23 Apr
 2026 08:15:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 08:15:04 +0000
Message-ID: <c99d0439-767e-4a87-b47c-f9d6020c774d@amd.com>
Date: Thu, 23 Apr 2026 10:14:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] DRM Equivalent for top
To: Tvrtko Ursulin <tursulin@ursulin.net>,
 "Francis, David" <David.Francis@amd.com>,
 list DRI developers Maling <dri-devel@lists.freedesktop.org>
Cc: Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@gmail.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>
References: <SA1PR12MB8144E70E3AEE6CF0F54DB090EF2D2@SA1PR12MB8144.namprd12.prod.outlook.com>
 <eabe4e7e-00b4-443a-930c-d838a9aa96e2@ursulin.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <eabe4e7e-00b4-443a-930c-d838a9aa96e2@ursulin.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1f14d7-bd69-42c5-d458-08dea1106c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: cU0IUpSK3GSoZ9lplsTvEuozbEpOq+uVO6IcJZVM7szadwrdiLDMPNHy/lG5ZMHBz8Dimxcz09lScMS1lbYbvTvrj1YHyBz+dOC6ocIoia5IyC+pQDnUMyqXbiRbviH5hYcjRlf0uYT+IsqdNFuoIfI2Vy0Dy88mE7vVIrhnvmS4PRkO4FkNn/h9YnFtbX4LyHUZbZ3wmrbqya61Dn5sytehID0OGBVKjTmmWgVQG4TRB7guahUjaX27D+MweskplLktImnr1r+aR38gvtViiwDPS/dicXZpPEVBYChB0a3Nr8g623Za10FCzc0e5l6Pe11YDvQ3RjlD3POOVaOlDTm1ewl31q4MDODrcp8vR84Cxaos1wjh6PhVePRko++yEQcqyo/KhM/ghQS7fyUzGx4/srMt8UO9SIq71bwDCBsw72MbPJFikO6ppKHBTzsNyisyyGqm1o0v35xIdDNIUnRvbxiUx8xqyJU49/uZ7GXYOuWdD+pVaEZ7xvuFo7h74ov8xH2Q3Tj3xzPcZNIfrdvCbbfcESGs+gcYodVKygc9w04EV20/79WEPDfDOZ5KD/Hil3elxVtF28on75gs0725WS0IaurZxDkvCpKv9wmHmcZfcygg6zUdH0B+nf+MiLl7yWDceqBFEv2YfZ/CrwtMKwHNoABJ5PF4iQj6hjLpWW0NXTT+10B8t2z+yf6H2HjjYq5p+c0i5YHlSYv4yjop4QClmTloPbd1HyDzwm/qT4e6AZ2o76aBBzzk6twI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1N5VnV5d3h4OTBnYmhIcmhKUjRPS3QvN2VJelprMmxmaTY3eXlDb2NOenNG?=
 =?utf-8?B?ZStUdWlNd0xTODVpMElmUWgzaUg4NG9nOVVaOHhHS2FvRTFnb0tLN1dmSk5E?=
 =?utf-8?B?Mlo5WHN0U3cweWpvdWtrbmRMZ2VrOG8vQnl4bllHRWxna0lZQW53TmFvRFRi?=
 =?utf-8?B?cWFLM2FvY05hTStsL3VpQXI5bVFIdGNMaWVGUTZqWExqbFYrVUNQQ2c2ZjM1?=
 =?utf-8?B?TlQvK3JUd2pFZWlVUTMvdStSa05FSHlrbUpqc3NGZEt0WkllZVdGdDZwcGlV?=
 =?utf-8?B?TG9JTTR5NWEydmczVEl2RkFmREdINmVlb3NxVVJyMWRZQlIycmh4d1JJbUZi?=
 =?utf-8?B?VGZHa3pzRFVDYjdXZUxDZU5ZNFBKbk1TKzhXV2h0a0I3ZVY0U3d2cE9WQVdz?=
 =?utf-8?B?MnVVbjZablVybWVvZWZCc01SVkdGdHI3aWs0TFdjRkRneGhjL2diSXZUTkZF?=
 =?utf-8?B?RHpQcUhMQWdYbk8vbFpuZHExM2I4b21sZEp0YnluQ3k3OXd1cXUvQ2kvV1FS?=
 =?utf-8?B?Mis4S1pOZUlhSFRoMG5yZkZTRUZsSnBGazhsZ1k3bEVidys5VHRpM25Ndkxx?=
 =?utf-8?B?RFMzZkZROUp4VEtKWExUdmRzSUU1aDdDUFR5REd4NSt3d05GT1NsdFNnRG9I?=
 =?utf-8?B?MWVKZnpFL2JmL2p5cUg1ckxDMlI0YkZRU0N4QkIxQkxub04ydXRlVnlHeVFo?=
 =?utf-8?B?Szlnd3RPYlhmZStWcWF3RzIxd1VqQ0dvbnNzaFNmdjVqa3NOVGozdnUxbk1G?=
 =?utf-8?B?SU1DY3M0a3N2SDZpcW5IdzZnbEYwRzlnNFVaMHFndm5JblliaHY5UEVYVkQv?=
 =?utf-8?B?YTRFTWQyZTE1bUQwRHc1Qmxna1lkbFk4eFJQU3RpZFpMWnlWS3ZaR2xFd3FO?=
 =?utf-8?B?ZGRiTGVMbzJVOEpOalBJd2VKNDFZenV1dHM4RG93WjJRL3RCNU95S2tuQThl?=
 =?utf-8?B?YnltN1VVRi83dUZkWS9tVlI3SE15N2VKZ2hmRjVIZFJnbVRNaTJ0cVlsMXlo?=
 =?utf-8?B?Y2NOZ0JDeFZiN0prWEovUFZaWStUN0ovSGFOK0lvTUlsaDMxUVNPLzdiaXFX?=
 =?utf-8?B?allJYkJXOFM4WHh1a0pObHlZOFNZNnRMWTFZK0FtU3hXakxSeld0dmo3Q2xL?=
 =?utf-8?B?ZEU2NTlOL2FBeEtzK1luOW54Z2pqZm1XYk1udEl1NmJjalFyd2ZNbDd4ZWIr?=
 =?utf-8?B?YTZBc2hUNXlvNGcxUWFYSFgrd2ZtS0dXU3RkM1dXUU5QTEpkTDZoWmFwV0NQ?=
 =?utf-8?B?bE1idi90c1lJY1kwaUJURm1keVQ3NmlNVEw4ZmJRWFhzOVplMUgrOTZaRUMw?=
 =?utf-8?B?SUx6ajVwTmd3a1NnazlZM0FHMkw2dkEwc0ZUb1RUNFBrT3Yrc2tyZzE1Z0Uy?=
 =?utf-8?B?UHdmRTJBS3FnbXY3YUNUZW9MdC9GdHJpVjBJVnVoUTBCWWlQS1RrT0JnWVhw?=
 =?utf-8?B?cFVDWTNidkVSbHRkVGV5bVNWK3N6WnVubG83Zk5zK1BlZTlyVGVvVit2R2Z5?=
 =?utf-8?B?Tnl2L1lhQjdsMnlwRks0T1FJSEcxeEtqNlJSbzVTK3A3ZWg4V25zejFrdDky?=
 =?utf-8?B?UWtUL0VBUTNnSWFEL3R6K2JQeGszaUw2aE9MQ2NMakNMQ3BJVHNlVDRkYjJ6?=
 =?utf-8?B?Wk9wY1FjL1o1VmErY3RQOTVDQ2toRDN3VjNBaE51bUg3TFJtTDdyK0hvR0lP?=
 =?utf-8?B?SlRvSUVRMC9lOG9CQlNRRVlLNGdMMjZtT1V3NE5wd0NpR1d4TW0rMXVWM3Ur?=
 =?utf-8?B?TlJSODhLMk41ekc4eG9mR1A1RVE0V0RlVFcwWFYyemYvUTNZYTJ3R3NkeE1z?=
 =?utf-8?B?aGZvbThqMHd3VmFYS2I2RXZiSmRRSzc3YWUveVYzREM1Q1V5ajJsOWZ1OGE1?=
 =?utf-8?B?RnpXdVpaYUZ6M295K0U4M1diSzV0WWl0QXhFRUNlTzFCL1NMVU93RzN3di9U?=
 =?utf-8?B?SGVIYU9uTUU2UHVLcWtYSGRJYzM5cTE2dTJIb3lseWpTS0FWVUhMR212dkZ1?=
 =?utf-8?B?VGxoaWZzWmFRZXlFc0VYM09odG13TXQ2RXVpcVJhdDh5YWVKK01JNHh2Q29T?=
 =?utf-8?B?RzZuWE00Nnd5MW9NMEJZQ0xSdk5JVDUrM1BJY2hYVTYzOFpma3MxSTEvZlNz?=
 =?utf-8?B?bk83dnJ4QU5FbjI3ZnoxL3Z3OXRtVkNsYVZUSnBxYUtkYjM3YnVONXpySCsv?=
 =?utf-8?B?Um5kb3BWc2h1bDBkdVdMV0YzY2JzemRSZVBmVTl4YjIrSzY1T0dmZCtVcGNC?=
 =?utf-8?B?UHo2N2FwYkxMM1dOV2hmLzFWUDM3Q01xbk9QTTNKa0ZkYTd5dG1pR3pNVDVD?=
 =?utf-8?Q?D3s8mwvIX0jTqr0fGJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1f14d7-bd69-42c5-d458-08dea1106c0e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 08:15:03.9080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXmhp+9vVY8n6+EgU2KsqpE2DemqSTo+uDjn4X7tylFSN4yn9wkUGjkt5u7wN0F2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365
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

On 4/22/26 17:05, Tvrtko Ursulin wrote:
> 
> On 22/04/2026 15:40, Francis, David wrote:
>> AMD have had some client requests for an equivalent of top that works with our drm driver
>>
>> We're looking for an interface that
>> - Can be used by processes with no particular privileges.
>> - Gives a list of which processes are using a drm device (by pid).
>> - Can give (driver-specific) information about these processes.
>>
>> We'd like to do this in drm, but drm doesn't track the pids of processes that have drm
>> device files open. It only knows which pid opened the file and which pid last touched it.
>> For example, if an X server opens a drm device file, creates some buffers, and then hands
>> that file to a child process, drm might still associate it with the X server.
> 
> Slight correction here - DRM tracks the last ioctl already (so last user) since 1c7a387ffef8 ("drm: Update file owner during use").

Yeah that clearly got better but I think it is still a bit problematic.

We have use cases were one process uses multiple driver connections, so identifying things only by PID is something we try to avoid.

The fundamental problem is that Linux in general doesn't track which file is used by which process, but only which process uses which file. So we don't have the back vector.

>> We would like to do this through fdinfo, which does track by pid, but that would require
>> making part of fdinfo public, and we received negative responses to that.
>> https://lkml.org/lkml/2026/3/16/1816
> 
> Would setcap CAP_PERFMON on the executable be good enough?

I don't think so.

The fdinfo access is currently protected by ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS).

Regards,
Christian.

> 
> Regards,
> 
> Tvrtko
> 
>> Would the public-fdinfo idea be useful to anyone else? More support might help push it
>> to acceptance. Alternately, is there appetite for an alternate interface that could
>> provide what we need?
>>
>> Thanks,
>> David Francis
> 

