Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E76FC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 026E710E4AD;
	Tue,  7 Jul 2026 11:59:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZvRMj9bc";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010000.outbound.protection.outlook.com [52.101.85.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4D0210E499;
 Tue,  7 Jul 2026 11:59:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QgKHxnVhVLEl+cWocFpEXObHPJEYfnERvXWMkzpqgeqPU2PUpeB6tVd0KhqEfJcTSPJ2s9yxWaFpsPK2aAz9NRmBepRt9LSMxEhNv5PKHV1UwRXmfTpdfLZ8CrgGuIogsLNxZTyb+viMWjedHXhQcMtkgFYSBstgAhbZJlUskKJgXoP1iYM7h3kXwUUGU1NIGfZ9YUi0gPwb/Ib6tbrtgKnfO/RgP2Z404te+sYaFUY15iCU/TZ2pYzHN0H0H31mqxOb8Jd+VhWBFfqVtKCKRqfPMgiEe+59xcA9ETOcyxFbF7PsMGERClpgW17fSnCbtdK5CJmDo3RP4UJdUy0Q0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7s8LtkdXWND95p7R2Kp5RintstWFqnr3jmpRnegkKZo=;
 b=CPsda5ybbI3BCrsxgyaOs4HEGZJO/GT+2dCAzZY6X0HbylD58ebuYUc+nKa9J5mZaegFmmJjVZdyFSB/oaE5SonOP4zBUIcaY+K+9OsJgu2BidAprf8UwYnufnQheDeFvZcM7NA1spzss7kM52orWbx+SHcUN8vZjS6KLFDhRZnt1w15+GE4ShY7v/5DnGOqxgy74ktX6NDazOFJ8YTXQldVAvxngBffts47ESiuovSi/xnCLOEMxsvqI5ZsSZbwmwznPn3bDQj0rlvvhB/5cQxzkeH5oRievJkPD1Vap9RTz3yOGA9I6iophhd7Vl4rZBPHN3/Ip2z527pAfbx9/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7s8LtkdXWND95p7R2Kp5RintstWFqnr3jmpRnegkKZo=;
 b=ZvRMj9bcohe7e3gApx1KuFfdKeQ7TJkRme2FvUGYmuipuEJEsXE6SLReNfOKzltSJjRoZG8YvphQd1eS4n6km05LEllGhIDca7dWsf6itJ5ORf4Tc7S22SgU5VkqrZwDOigflL5xUJtfkh1mWhxObX7JXqOkYKkIUEXWDiHJ/k0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB7085.namprd12.prod.outlook.com (2603:10b6:303:238::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 11:59:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 11:59:38 +0000
Message-ID: <76b6a6c3-f1c7-4e44-957a-3e9cf143aa28@amd.com>
Date: Tue, 7 Jul 2026 13:59:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/drm_exec: avoid indirect goto
To: Dave Airlie <airlied@gmail.com>
Cc: mikhail.v.gavrilov@gmail.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, peterz@infradead.org, jpoimboe@kernel.org,
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>
References: <20260704084133.122053-1-christian.koenig@amd.com>
 <c575453f-d798-4745-b67d-4476825dfa64@amd.com>
 <CAPM=9tz38o_p--FGjgkcDCV43jwmbx_zYDyc8fyHKBteiHDRrQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAPM=9tz38o_p--FGjgkcDCV43jwmbx_zYDyc8fyHKBteiHDRrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: a9691381-a6ba-4866-e56b-08dedc1f38ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|1800799024|23010399003|376014|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mAJIrJfeA76XSUSkNYLKqFDKYhFS0xtjlIuJ4+EzHGZ0B4ECnkCB3A0dzmoOQZ8L4OQnIhXlnoBu59L5wyuI2SzEMXKhl3PEjmvgjFCLfrkD6TIu4Z6tjX0CxmMVOTWqP5+AYXLcwZR9SQNxnHhhmrQsoqpuI1VDZqpHTfREFrdzKjqhIVl3Jxa0H/eZhqVqATpgHDXa8JMI7sqjNHTjAMX4PdEu4o9MFBT+R9xFtdcrsfBPs+HJQeiCWPXU10jGtWkaYW6bkwv+7hRgZsTVW8qHhWz7Qeq0+Kq78pSzLCoIn+V14CFiBmfyrymfmIVPefM/AUwSLsc5G55Vjkg8Y7XvZDeFeoQft5WK7Uf2dld2W6GDR6gFfjGbGgARoEIqJ6knmddOYwSIn+Geto6jQXfeaGsIlZFYWw2r3BwkIoc/HN95XRzP/lV3olAdEkND0mXCpnIYxAcqqhYnyRqQ3CqaXa4jpSdeKzHrQ5jC6swyN6pW013iLhToxPNjjSV4m3fnGuUJ4b8FwLvYYK0KZMUp2Yz2k5ZFVvtEuhqaeSFCAtkZ6cCVr9vOnDKUr9+DfL1yDnHpqDqV6vf2zLo5336tOIKtdU6gLmh8mhoCg8DVcCDPdy7sRXGKcfW9fBVKoZUIQkJ7pr4pJ/uw4WyGdH11GIEJ4vou8zAexNHgACY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmdzKy9yWFc5R1E0eU9lajY1TldUQlgwc3YwOHlaOHVjbnZwMHBGZmlqWE1o?=
 =?utf-8?B?SWh3SUNhZmVHVGIzaTUyN1h5VzBqWDZGNVRQME56OFRDOFpXak5FdTEwb1lO?=
 =?utf-8?B?Ulc4aFVITGFpNUFDTHArU3ZNOXpPbk1qWFo0VXl4WXZtam9jMkNsaWxkazYz?=
 =?utf-8?B?ejlxOHVsR2VtaklHbWFUcmVRTU12Y1UxT2hNU3lvZGdmZFBUaUoyQ2NuWWFp?=
 =?utf-8?B?cFh1ZHc0bzlKZzlzZGxhdGtyWE55MUJkdmg2MytpS1VQY1ZTdm9LNm1lN29S?=
 =?utf-8?B?aGNMbkdCajBQbFM4cXc5N0p6aXQxYVJSRVA2clUxZ0FRTUp0MmpMeG1MaFB2?=
 =?utf-8?B?VUVab1hlK3J1Q3VlOW15UWR6WjZKdG1sa0VUbWtENVZhYWM3U2Y4NW14V2lh?=
 =?utf-8?B?ZVFJdWRlRVl2UmFXdEVGZXFvenhmSlVyYmxzMndwenFXc1NnaHU5amk1VmtX?=
 =?utf-8?B?RnFZVzEzdXhhOFk0dWdqcHd4dEhVWmQ5azBxQVlKc0pWQXFwajVCdXRNQmRO?=
 =?utf-8?B?TG9sVEk5Y2VhVXRuaVpzK0VtdVpZUFRkdEE5ajdtb2VvRDNEWVVPS1ZxVEpq?=
 =?utf-8?B?bCtVa1lJWjJzUDh2WDFtaE50L2tHbk1Md0RKTjJCNzlVdldHWjBiWSt1Ulo2?=
 =?utf-8?B?NzdVcWsxUVhMQ1FOQno5S01NZUFTQ2Rpdk0xVnRETnVwU0VOK3ZkV2Qwejk4?=
 =?utf-8?B?YUNIbGRUK1NreXMwVmJ1dXpjTkNaSU9CZ2t6SW96T29MS2F1NFprUGp3VWZy?=
 =?utf-8?B?d1dVem1pcmYybUJtaXFDbWFaRzFxYTZUT055MzZ2dm5xV0tuVmx0Uk82dXZN?=
 =?utf-8?B?OEF5ZDNRYnM3NGtpa1NYMEFIMktURHNQdmxJVHoybll5Q2t3ZXU0NFdiVG9j?=
 =?utf-8?B?dEtUTTRFNUMvcElyR1E3RGExUTdVeURsM0dmTTQwdDhMZUNwYTdIc0hQTGd4?=
 =?utf-8?B?Zm9OK3oxeFpiSEs2VTJJWEJKY2tDQTd0NlExdUNwOVJqMzZQSGJEcmtlbzVS?=
 =?utf-8?B?bTEyOFR0U0FjaTZxUVRTZkJ6SFA3SGNsdnpEN2lCbTlBR3JaWFFFTFJnZ2l0?=
 =?utf-8?B?MXNsR0M0azJ4SERzVFhjRFBiajUzV21xcFFEREpSV0hDaElKZU1wSGYvUzlv?=
 =?utf-8?B?TnBvTGNSZFpOVWlIN1BmOGJIdzlDODVwanh0ckU4UkxEaENVN2c5bDJnMjRy?=
 =?utf-8?B?eGF6T3VjTTJZNnBlaUl4MmxrMGUyK0VQWHNiRnpGTVFRdWx6WmtuYUh3UXBJ?=
 =?utf-8?B?T3NuYVN6VEpKamdnTzVsUU5NUVdaYll5MTU2cTZlaFB1T2JxM2daWFZmaXIw?=
 =?utf-8?B?ZVZpeUNZbUlyMmtTMkI3ak5sYjVNZnNvR01PeFZLZVNyTHBVS2pQVEdJcDlw?=
 =?utf-8?B?Qk5LbTQ4WWJ1bzBoVHl6dFhBNEc4MjczZmpPazNDZDhxYjk4SUNmS2pPZmlm?=
 =?utf-8?B?VG1sNEsyWDhYUDRacHd5V1dPUlJna1RIT1VQOHdGYTFVYVA1WDM4TUdVWnl4?=
 =?utf-8?B?T21LY2VoZVQ1akRCMSt0cElMNFlFYkNaS0d2c2NKb3NveG5GRWE0SzkwakF3?=
 =?utf-8?B?K0JEUXpEK0ZDOEZ2N2xVN3oraUEybEVqbGpReVpYRDZPakFPcXcvSm9LL0xj?=
 =?utf-8?B?blp1RUJPUnh2WjZ5UFFFMXNzRFJJRFVlUmh1OE0vRWhTSFVQMG5lVE9BWmlY?=
 =?utf-8?B?eFo1aWFxY0svRjdaM1UxOGgxZ0JXUTd6UEZLdlZPRjh2NlR3TnZRcXRmTFhr?=
 =?utf-8?B?Z2FIWWVOem43aTh0VFpYR3lRYnVjTGI4L1krangzRjFva05mU3poNHRjSVJr?=
 =?utf-8?B?MEhJOHRHN3czbEhDNVVBQ1JuSGxWbm5SaE9SWk5ZeG5wblV6VjAyQUR4V1B0?=
 =?utf-8?B?eTVrU0ptZHpTU2VFYjFWQ3M1aExJY09XZ2ZvT2F3dmJrd2RCSi8zbFRDaWJz?=
 =?utf-8?B?S0krWXdpem5MVExwR1RPOW5OSUJMbllYblVwYU9IT0JCcWtlWHlOOEk3elBs?=
 =?utf-8?B?cnFKU25JQVJqMVZ2OTlzdG9oRE42bXpuQm9Hb0UxSzNrYmNVc1JXV0dCTGc1?=
 =?utf-8?B?b1dsa0k2TEdYUHA0WFFSZExjSll2d3BEUEhacWNMUHR1K2tBRlpaUEVuRndr?=
 =?utf-8?B?OEo4NXpkVk5xREJsTW1DbWphWk96QXg4TnFGQ3ZObVVLNk8rNDhJZTZEeHJl?=
 =?utf-8?B?d2ZPME8ydTdpNFErVlh3L3VXeUpkNHBRdWNRN2dZa0JKd3MwTWZPYlhsQkM4?=
 =?utf-8?B?VUJFaXdPbkNqd2xkVkhnUHNMeGxVMVpnRVE2anBtaWFYS0VIYVZZTjVONFZv?=
 =?utf-8?Q?3o5yp+orfo73tosaSx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9691381-a6ba-4866-e56b-08dedc1f38ae
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 11:59:38.7848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: McG4w+4ADqGQBZ//DkPtDbwgunlB2LYGxILj9G3U7V4geeruX9AFk0JA/3/ih3iM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7085
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

On 7/7/26 13:43, Dave Airlie wrote:
> On Tue, 7 Jul 2026 at 19:11, Christian König <christian.koenig@amd.com> wrote:
>>
>> Adding a few more people to comment and review.
>>
>> Thanks Mike for the pointers, going to add them to the patch before pushing it to drm-misc-fixes.
>>
>> @Thomas, Maxime, Simona, Dave can anybody give me an rb or comment?
> 
> I don't like it, but I also don't think the thing it replaces was
> spectacular, so until we can figure out a nicer way let's go with it,

Yeah agree. C is just lacking the functionality to cleanly do this.

> Like I was wondering if putting the label in a macro would make it
> more explainable, but I don't think it would help much.

I was playing with that idea as well, but then decided against it for the simple reason that a __label__ can eventually contain multiple labels unrelated to each other.

> 
> Reviewed-by: Dave Airlie <airlied@redhat.com>

Thanks,
Christian.

> 
> Dave.

