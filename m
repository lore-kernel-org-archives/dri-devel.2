Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0675BC5CFCF
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 17:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 404FC10E34D;
	Tue, 11 Aug 2026 17:42:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MJyGxvLq";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011018.outbound.protection.outlook.com [52.101.57.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D78B510E360;
 Tue, 11 Aug 2026 17:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPnrlfLaz8LdCL5fPF25F+rC3Zv0JOWc6Fs7RQ5Y6oReS4K54KiFR0bA70JlXhg8Jvh4Wz3VYdI0msGhWL4ARJqLpcx+zSCwvH+MMkP7g7rHNHeqKX7et8SiONLG6absZ5VD0zbTUo7GVSIL1GOoA44gJ2uGd/H3qFDYBeNFMP5yZQFWxqDj7XLVR70MvfjxjKIl/jraux/yBtq2yHSt2hShJNFboGOvv3XROdLjpcqbI1J77lP1XGbe24tZ8gcy3kL7J4AgHNKjq0gu3hiGR6NbtBYgHt9IeV0vbFjOLXRFFXRBEp+XEfJK14yQqASso8JgY7iW4SmE/1UVNbp6mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1KR3bfRhZeMnhqEnhEDcb2UM17CN6K9myYFUbXG+h8=;
 b=VWfZkPAbJT3+dRGmShXYP91slFdx4mTehwWwCKWcofsL96gIhB8YYgFbNjKBKULtetlTO9VMRwt4I20yImjk4ywj4Vbi2q7mPOQBZ7VuCY21ipnjkY+HiVKHUJbzFWcAQRrAPqRmmvQ1yEnNEB3VMeBKhpQCUFC+3RRlCaC0qop8joTBLNPo9Zt0YC1vmU9dvHmWmNvjU7qRs/jo0rNgMO/KHUpstay5EiLRZIE8KdXRWLD60h+169m7HaIAKad/7JcoxPpVHMKC/AFfGCODSqR3F5TszJAg/elior2QRdbQojlSnYCTXS3BGmRbFKuYHk7X36YB5dWlRIOiHefZMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1KR3bfRhZeMnhqEnhEDcb2UM17CN6K9myYFUbXG+h8=;
 b=MJyGxvLqKE8BavE7xco+aXSz6uSGB4RchXjdS9UAH3r+8pikZkdhKNahCP8fp1Yqp5IFB9JGtC9X2otJ7fALURhjA7Mkc51OMqcSpQKUBbpnb/v5UC1uOZaEkmug/D7hIC28Mu1JaTIUe2RGnh/oqmTGxV0TdV8OW7TpUs1pOwo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by CY5PR12MB9054.namprd12.prod.outlook.com (2603:10b6:930:36::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 17:42:23 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 17:42:21 +0000
Message-ID: <e7bd40e5-b0fb-47da-aae8-fa16838f9185@amd.com>
Date: Tue, 11 Aug 2026 13:42:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] drm/amd/display: Add HDMI ALLM support
To: Daniel Stone <daniel@fooishbar.org>,
 Derek Foreman <derek.foreman@collabora.com>
Cc: Fangzhi Zuo <jerry.zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
References: <20260806205449.16806-1-jerry.zuo@amd.com>
 <20260811003921.1398292-1-jerry.zuo@amd.com>
 <20260811003921.1398292-5-jerry.zuo@amd.com>
 <0102019ff114857a-259b7f40-8202-425a-bfbc-71bb92acf184-000000@eu-west-1.amazonses.com>
 <CAPj87rMSYC0wKP66p5Q5uOL+-Fb04-gYJFcRxdxxZ2-_du89GQ@mail.gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CAPj87rMSYC0wKP66p5Q5uOL+-Fb04-gYJFcRxdxxZ2-_du89GQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::9) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|CY5PR12MB9054:EE_
X-MS-Office365-Filtering-Correlation-Id: e2aa104d-0410-4168-50e2-08def7cfe580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|11063799006|6133799003|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: X/lOnRCb0t7yroXC2qlGcZl7cVaKu6CGlO3MeE4zYN1iMR0G5yf6cG8XSezsogLQyorhND1A9zsRQCBmymsAutMX75rOywJCM2HOFr8XrvWso73Kpqv6tj714sLmclKiGkCxD7qZ3uMjPTc53U8bjCzhKgIyd51PQuSGF6+8os6tBVs0fC2QOAPDyFAnZyc0oSpzpLzLDbzaLpJ6QBSkRgjJRlE/iy/KWV5uPGHFfenx5KC+UIZNe6a5tLvyEBtvGl+RQswB9GaWU7KYa4ld07NwDr5r0htc4Dinikw8/VuQz7tCfTTZiatgG+SsvHPeLTWsA8uAj+GREF/TjMfMEpuAeJxnjYk5RYnoVPU1wwCgNWlfI6WzrSPZXPObEeWUErQ+XIPTHLEtkh3gA/B5huPHjr6lBUY8GC/S36J9nmO0EPwTYUGsZkE9ojZtW3h/BZeusWjIXweFtfOCnCzekTAff4h71gFxSf+sJo3nl2hjgodM/GuLkd6KyykFhmP5QPbfna9FF8M2O3nxy4CfP6F8NFZj/vHUggcgcu8VzMAa0ER4rIi9H4RyVPnVQIfVoXHKaeKOZLWe12eefcW8KgA/zdadk/5gCJBDtnoDAg5KpCgg9Dwv5biKuNfCU+0feROkVOTGdnxCg9Q1gVe9PVdQcwiF+/7csXQ8x/omsxc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0JxWDNtU1Z3RTQ2RlUrVUJFYXNpQmxjbDg5S3JQbkRHb1hDc0xVdlRqeWFH?=
 =?utf-8?B?V0hrelN4b290OFFNdjI5c0JKZEovc3F5anNLRllNYXhrN051RVB1UGd6UnNP?=
 =?utf-8?B?NXhadmVwbGRjTUZybFUyTE1GNU1KTG52TDFvaU85N1JjNXFsNzRDZVZHcGFK?=
 =?utf-8?B?a0xkWVNKb0NYTWxkRFZUZUI3YzBBWDl4YVdMOVoyeUZCbmQ5SktHcGx3eld5?=
 =?utf-8?B?bXh5T3Y3RStDd216SGtKZGpNdFBwQUdxTzdmY014d2xXaFhIdGJPYks0bHBD?=
 =?utf-8?B?eTlacDd2QldYREVUL09xNnhrSTlFUDUyMHVyUlRSekV2WlpMMFh5TDlZM0xQ?=
 =?utf-8?B?Y05ucUx0MTRISWUydFBVa1QwSXlVVVJNZnBJTnlrTFFmTVlBNExkam5FMTlU?=
 =?utf-8?B?R0lORk4yd3h5eTZpY09tWnNhTFNpWllTeEc3NFJsVFNCaCt0OFM2WWUrRnFw?=
 =?utf-8?B?TGtiNVZVN2ppVXFnNEtSRlZzMGlPcHNHU3lLVlBZQWFNOUIyZnpCRFhmUDN6?=
 =?utf-8?B?c2xrUktCeXR1dDcwUExsajlhYUFkVUl3WVAwZzdFdjhBWER4VGZYV3B3Y1JF?=
 =?utf-8?B?a3o4K09WTGdEZXRCYXFOQ3VqelMrZlV6UE5YcEVmRDlHZDZOM3FxNkE5dFk2?=
 =?utf-8?B?b0VST0JQeDJNdVRFeHBBaDVlM1NpcE4zSEE5ZnkwQ2d4YkFxQjllMzU3L1JL?=
 =?utf-8?B?a042RzIvNXhBbEk0dGFxdE9ldEVMcEhLcEVCVVlrZUtwVW9RVHdUbFBBZHAx?=
 =?utf-8?B?eEtraGYrOThXZGZyUzVZbmJhNmZCRkRPTTZwbWhHMnNWZC9rbVBzTXBaVkZ0?=
 =?utf-8?B?dXJPSEx0OXBxYkN2UnlEWW1HcjJLQVpYSFdUWHVkRWZHY3VJbzlJZEdndTBS?=
 =?utf-8?B?N2FMVUg2M0IvTnFHUThRMUJXYTY1dnA1SnljVHp6RnN1MCtJSkxUWExubXJl?=
 =?utf-8?B?V3UzTmhTL2Q2aUhwNmJIcEdkMkoxYXNycnFYdHE5MkFwUFZEUXN5NnU2Z1dw?=
 =?utf-8?B?TEtISVo2K0djRC96cmNXQ0N0NXJBQ2tWcnZGcmQ3THRvenBhSzhVaStIUytU?=
 =?utf-8?B?Z3NNYlBHekU1WEhuczA5NW54U05iOGlmbWF2ZUE0d2V0L2tuKzBBNkFvSnV3?=
 =?utf-8?B?N3N1OVFYRTRBUmRRdS9JbGFoQTNRUStCeDdwclhtS0EvRFc0TGNKcVFDTGFy?=
 =?utf-8?B?aTBDT1NBWjZKaktYRlJoREFmM3NYYW95UDlrY2xtL0tITHBWSWNyU3BlZ2lH?=
 =?utf-8?B?TnVibFRvWW1CMGtlV2srY0RydFdZN29VTVVpMEJwdHdtUll2MnVkcUxCc2Jn?=
 =?utf-8?B?aFA0bU5LNnlDSU5hazRRSzdNZE1laU8xRU1DVm9ZSW5lUW1KSkZYV3R3WUZs?=
 =?utf-8?B?allDVHBURTluWUkyWnhWOFNKVU5vRzNwbG1RTFY5L083dTROYjNpS3pJando?=
 =?utf-8?B?MkhxcG4yampLYkx6UlpzeEl4TTdJdWNIbUV4SExiU1h1eXBWTFV3Rmo5MUdQ?=
 =?utf-8?B?b3dxYzFwTkZWc1BaTjlhOFJFOXhac0Rmc2lZSzRPWUl2OWtSeGJ3Y01zVjdP?=
 =?utf-8?B?cXYrZVR3b1BESFhqUXJ2NEtOeklYZGxBTkJIblZKTGVQN0RzWGJON0lFUFRX?=
 =?utf-8?B?Qkw3UHdZSGVGOTZXcW9uVFBFS1pwSG91YVBoMTRjZkNldWs2NzdOZ0J0amY4?=
 =?utf-8?B?UENZNmxvY3U1Q3VMdy8zc3Iwb1JVdVJ5dFNRaXRPZmhNSzlKdEUwZGU5RDJL?=
 =?utf-8?B?cXBlWHpkajlLcXpKSSsyenFSWldZNDFRN0FEcGNEVXN1UjR2NjV4VFZIN3ZC?=
 =?utf-8?B?QU13R01veWVyOHdLcFZ5SzhlTk1Nd2g3dmNaYTV1TzJ5WTQ2SDRPS3B3WHVk?=
 =?utf-8?B?QzhmVHVQQXNHYmh0UTIzOUFSWnFSemw5Q08zRGpBWk9tL2Eyb0M5ZmxMcjcx?=
 =?utf-8?B?WXFkdXg3Zy9rQ3hGNlpTWW9IZU1tY21YU2Q0T3ZJYWtlRjV5L3Awd0xmbnNQ?=
 =?utf-8?B?b1Era3pjdVZPdGVyUjlaUDhhSEU3azh2R0tNV1k1VjZpMEpBUTkrVy9yZzFt?=
 =?utf-8?B?YTI3aTBMenl5cGR2bzdwc1NoQ1NFaEJMdlRBRXJpNmFZa0ZnUDlQak1HV1ly?=
 =?utf-8?B?Y0JlSktJSEZ5WjhwdWR0OVI4c2RkcENwRkUzTWN4UlBlQU5zSW9LU2hQbWlx?=
 =?utf-8?B?TGN2OWxKME9HbVVub0tWRGtudWhOTDRsMjhUYS9WNEJrd2ZEcmJSZ05hbTU2?=
 =?utf-8?B?UVpXcnBzQVVwVFZYMDBveStqU0E1QzFkS3ZXeFdQZTJrSWgwUVFCQUtwdW9p?=
 =?utf-8?B?elpQTUZzZmltelBMWkZUbENJdW9wcVNrcHdCcG1sV2VaTmpOT0VZdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2aa104d-0410-4168-50e2-08def7cfe580
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 17:42:21.5544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2bVoBEEL1rawYCHnkhaLHw30RknYXpT9tFKCNH95ZLEWhNXGeeoyWbPR4Jt6IgOYEWz6cgWobo7KToHiAkr7Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9054
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



On 2026-08-11 11:23, Daniel Stone wrote:
> Hi,
> 
> On Tue, 11 Aug 2026 at 14:54, Derek Foreman <derek.foreman@collabora.com> wrote:
>> On 8/10/26 7:39 PM, Fangzhi Zuo wrote:
>>> +             /*
>>> +              * Enable HDMI ALLM (Auto Low-Latency Mode) when the sink
>>> +              * advertises ALLM in the SCDS and the content type is Game.
>>> +              * Setting content-type = Game is how userspace requests the
>>> +              * Sink's low-latency mode (HDMI GCTS HF1-56).
>>> +              */
> 
> Is it mandatory for the source to set ALLM when the sink advertises
> ALLM support, and content-type == game?
> 
> Is it allowable for the source to set ALLM when the sink advertises
> ALLM support, and content-type != game?
> 
>>> +     /*
>>> +      * HDMI ALLM: transmit the HF-VSIF with ALLM_Mode=1 when the sink
>>> +      * advertises ALLM in the SCDS and either the content type is Game
>>> +      * (HF1-56) or Gaming-VRR is active (VRR_EN=1, HF1-58 step 8.3.1).
>>> +      * HDMI 2.1 7.6.6.
>>> +      */
> 
> Is it mandatory for the source to set ALLM when the sink advertises
> ALLM support, and game-VRR is active?
> 
> Is it allowable for the source to set ALLM when the sink advertises
> ALLM support, and non-game-VRR is active?
> 
>> Tying this to Gaming-VRR seems potentially surprising. Gaming-VRR
>> doesn't mean we're playing a game. We might be using it to play back
>> judder free video (where we'd like ALLM off to preserve the sink's image
>> enhancement), or we might be at the desktop.
>>
>> I'd imagine some users would still want their sink to use all the image
>> enhancements they saw in the showroom even when playing a game, so I'm
>> not sure any kind of "auto" decision making in the kernel makes sense at
>> all, even based on content type. It's a very subjective trade-off.
>>
>> To me, this seems like something a compositor would want control of with
>> a simple boolean property.
> 
> I strongly agree. I really don't want to see more magic implicit
> semantics unless they're completely necessary for some reason.
> 

Yes, though I wonder what's the point of the content_type property
then. It's another one of those properties that's defined and unused
by all canonical upstream compositors.

Harry

> Someone passed on second-hand that one of the reasons to do this was
> to make it easier to support X11 - however, if X11 needs better ALLM
> control, then it can be exposed as a connector property via RandR,
> just like content-type.
> 
> Cheers,
> Daniel

