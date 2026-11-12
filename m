Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86348606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 01:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ots14Rbp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97B6A10E497;
	Thu, 12 Nov 2026 01:44:06 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D577510FECD;
 Thu, 12 Nov 2026 01:43:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8uomSnx+lGgxYy6kuy/nWMucf1iOyNygia3ocd27J9ffGLSPZxGU+t7b5Yl30MSwQWA/Fv9KwEWVbPh/sv1GnAU6vKkXUFCUtvu/IEBkSxcaJCSCLFwMKffPCsI09VWOJmXCq8/LLAQ5zh6F5fflykKPnJ0fsIpyKBeDl7jEe77L9ys1fSlSGXYIk/Z1OH7kaRgBGBsO9M9RpaNntq61rZN/4WS7R5cDmyXSwkwPMj2MpQVleozZ5x9r7N+Vtfxk8THk4SdkCkHC38vSHGwLxp69sQhZoHV59BcoiZ673saG9gqbAItgHXLPMsBAdtY6q+SAMt8Ez/zc855GgHjJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yT7pzRpHPiL+E2wuffxx5jRI3ca2DklLZ+5LDXfbEQo=;
 b=Q+12MsokrzhDgiOsrbWHkRG9aDxfYMwvk2jlCwU7jn14Dj8Q3ayp9icCnIGOd8GsqAUwgTCcabRp7cX4o6bg1wnM2tHOOqZ/8fYuZpo/sphqf9U00OTpRv0z8PM3LJSxw8nOc8mgryoNRYbKTEVRZsPvy4FMmybYaM+/odFn6QaPNGSYYKX+thE0s4zD/OlsZZEDyrDq6LJXi5vP9dTalLJ1AUr6nDcTYdt1H6deBV8mUr2inD0OdkMoanxnWjMsQpB3kfaVzzKvS/C9JbdqkHsSkfp+nl6SG5AAGhwy3XRy5Rf/LmPjcpqDlvs/CnxNkh/3T83IrYUbWHBXMZUxlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yT7pzRpHPiL+E2wuffxx5jRI3ca2DklLZ+5LDXfbEQo=;
 b=Ots14Rbp2BBHDc3AOFuFCtvTY2+VlQWDcgtrMaybWYzEbrD+MLlaMmtGuC66dvS08drqYPK3gfyAkSm1E9U2lW9m0tfxS+amy5Cw9v8vaDwLioKwiutUi5R9NgtueejY3jL1dgHDEYl/NKdiuzGoVI1X2z9nXFXW2NJDpN0KLVDGYPUFjUdxIF5PFNhp/2xizDYk+x0KxovaHMusuzt/E2w6aONyoZyx7Zew3sL8AYaoGOl5X+F/l0yt4jBzxbzZFbClVUWLg6qxNCX/wrofyrBSQWsPhMr8En1+dm8DtmlvTagSpX3p285494cZCZwInUprZsI+CBDdAuZC9FnkAQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 IA5PR12MB999324.namprd12.prod.outlook.com (2603:10b6:208:609::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 01:43:05 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 01:43:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 10:43:01 +0900
Message-Id: <DMSUNELHV29J.3P27BLAEVKTAV@nvidia.com>
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] gpu: nova-core: gsp: cmdq: increase MSGQ_NUM_PAGES
 to 64
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261111-msgq-64-pages-v1-0-d8c56b6fdd6c@nvidia.com>
 <20261111-msgq-64-pages-v1-2-d8c56b6fdd6c@nvidia.com>
 <DMSGRDMGTD4J.30PUSSFQMZ4YO@nvidia.com>
In-Reply-To: <DMSGRDMGTD4J.30PUSSFQMZ4YO@nvidia.com>
X-ClientProxiedBy: TYWP286CA0031.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::19) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|IA5PR12MB999324:EE_
X-MS-Office365-Filtering-Correlation-Id: c6cd5f77-22c6-45fd-edec-08df405e4bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|366016|376014|1800799024|22082099003|18002099003|261009223027099003|3023799007|4143699003|11063799006|56012099006|261028144727099003|261021121427099003|261102123227099003|261026121527099003|261026140227099003|261021123027099003|261022105027099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info: PfAMEAlMTXzx+HxEq1zLnZVbAcfoqXpsyOf3ppbKjo5qS94lk99gRfRDisDI4aXDRnUT3a3PveqBZLJDnn+z4iVobC4DR258ucNxdAcuJs0LVQ62y1fjIX2WYaBrO8zl6EN48NyfpyLiV7chQIcOp/vsQ//Von5b4yd5CI46GCTF8SwaR7Or4xqJdnV5rY+GGa+R6tPRIwZBGqon14ochn919+5s0cigWkbk6Z6FAwTv80ylOELc7/exXlVkvRBicPbrfCqXwohG1I673Ofwv3YJY9G28XyDIzCyaEYyQr1Bogo6FLpLba0Cj5rIxIxGOZOSDlEkjWfyy2V9vXH16watHJhM4NU/+A8OXzsG4IP+9017LV5cwSVgH8U2/sAgWa1gjQq1LG37q5YrUCOlBOv6un8b0T1BUA5GmYJS6yZqgcWLcQk15J2nJZ2sT63DnPp5IzqU9/FJW8GJK1tewJd/wcp2zgtnODdmJwUD+O/Acr16qzKQ++DfQAi4oGzP+Pb/A4j2sjN5riVrUjjVoCst6IDZVZOA4/BpkjUbiOHR/WlD3W9w6AMFx0pCMiX++FwOY8C/7BKcOZhdkdQnk6+TGbuukzPUgR9cwZ3SOMMf0/0ahs7MlZRg+BzSnNf3n0hFIovcR9J6ocieX4q8q8GuZck5l2vE3+fInyvaosY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(3023799007)(4143699003)(11063799006)(56012099006)(261028144727099003)(261021121427099003)(261102123227099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022105027099003)(261021135927099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkNlRWxodUdrV0JCN29QMlZlN3YyYmNBUzRkOUNvMjJnalJjZ0RCR01KTjBF?=
 =?utf-8?B?OWtWYmNYamVjeS9sYnNNWnFMZHg3NkpuT1R6NmF2bzlIMkNQcXpOWm5Zbllv?=
 =?utf-8?B?bDJGMWduYVN0UE5SSXBlUGRFTXpqSmZtbXMySE5iNFR4MDIzd0ppVnBwVVY5?=
 =?utf-8?B?RFhIU3phc2NDVTBsWlJUSUdJdjlabFZRY3ZKNWdJbldrbFVlSHluZ1VWZEEr?=
 =?utf-8?B?M1dtLzcxb3JrRnNsYWd4Q01lRUJ5WnBWbVFyRjFvMWRFc1ZzeEhQVFFNbTJr?=
 =?utf-8?B?ZUgyaW5aT00reTJoMWF1VUo1RjJUbUd0OXR3cWx6QXBKd3h1aGlKeU1vOENl?=
 =?utf-8?B?ZDRKbVpzczZiRlpLenRmODV4Z01WMzQrc2R4WmxDSDlPNGhaOXY2MnpveHV2?=
 =?utf-8?B?eU52ZENLWG9LZUo3bkQ0eXFNMEJhUGJLOEkxVHRlR0ozeWFUYXg2K01DRCtX?=
 =?utf-8?B?K0xka2JnaFRDRUQxc3RZYlFaV3V2NHcvRnBVWGREWUw0RXN6dEJUYnlkN0pt?=
 =?utf-8?B?UCtQRU9VWGNyR01JL3dDdklkSE5NWjVDUFFZYW03cjJ5TlJNM2w3eUdHanR3?=
 =?utf-8?B?MFJSUmVTeHovSDcvdkg5QlJvZ3ZUTWlvY2x4L0hIUDNNN2swUHVXSGRsVExQ?=
 =?utf-8?B?ekhsSDBCSmpLdHZ0SlVhQUZ4Z2Q3SEk4Ukl0bVpFaUYyb1N5NDZ4cTkrUmxN?=
 =?utf-8?B?NS8vUGo5WXFENSszejJoN2RDV3ZvUDNTWUcvTEtHUWs5NTBwZFdETWk2MDVS?=
 =?utf-8?B?UXYwbm5oNzllUDFjREVFczBpbVRLRzJCN1IrMGVwRS9rMC80cVZFWmczd1pM?=
 =?utf-8?B?RiswMGs1eHFhQkFNaXE3NkR3SnJOTk5yenB2Y1o5ZFhMWnlqYUhiUUJYUGFv?=
 =?utf-8?B?U3cxbm0vckFFK0hJYWltVndraENncUIvS3poL0JoYWZSRkZpcHBhMy9YRjFj?=
 =?utf-8?B?T2xtTEY5cDVIOVlqWnpXSUlPNExFWTNSM3F0dE1BaXhNSDRvZ3o2ZTN2RE1z?=
 =?utf-8?B?bFBnRGJtN1cwYTBYYTBuZzdlKzNMeWZsRHl0Qi94SU9LSFNFdzM0WG55bWRC?=
 =?utf-8?B?b3M2ZGFEb08xdEt6QkNvZGhyd0xvOW1wTDcwR1J6djdGejZNUGZvcjd1ZXVk?=
 =?utf-8?B?RERmdUdNaUxuQ1N2Q0M5ZGRuODYzOWRTTWd3eTA5MFZFRzk5aGNVaEVaTGVp?=
 =?utf-8?B?ZE43bnI1VFBScUNRaXFMS1FyOXl4ZUJuSStvUzlJRUpsZkFBRFp1dDZ2bzJL?=
 =?utf-8?B?T09MQU5HOE9lYnQ1UTEyTy96eXB1WDE0bWFyWlZzbjB4bmJrcitLbkpDZDU0?=
 =?utf-8?B?dTI4MTQ5MkdOc1p4RU9XeFJkaVBtV3M3ZWlPQTVxZHVLSDBodFQwNitFSVMx?=
 =?utf-8?B?ZFJEWmJvZDlmQ1pMMGFXYlBaeUxGN2hvMnhKNzhEZkdtb0RZbkdhcjVFbEVW?=
 =?utf-8?B?K3hiZVhjQld1YTlrVTkyMUtDTm5SZEVwVTBuWG1ETVFmSHI0MzFTSUpoMUtk?=
 =?utf-8?B?dXRiWTZ0ZFpjMTZHeExGRzJEajN2UjZwellsUW5HMnh2YS9WUUlUVUdZN0V5?=
 =?utf-8?B?cXRUeHpUcWdFc2JFMHBjL0JvOUhGNllhQnQ0NnRLK0xYZTh5dDJ1MVRoa3ZT?=
 =?utf-8?B?ZlhwTTY2M0lWZGtDQTJnMXF2M0RMNENLUHdBSUR4M3VWaUhZRDdadHBEVTZr?=
 =?utf-8?B?ZDNldzdMeDhOSElTVlhqMkhyUTQxYnhIQldaOG5Fa0dUSGxGdmdzKzJTQ1Fq?=
 =?utf-8?B?SjN6L0taTmpMSUVnbXJ6Q2pyZkt0dXpRWGNzU3JBSS9kcERaY3FlSm12OHFO?=
 =?utf-8?B?ZnlDSmd2K2tibGFMbXpsNmxhazcwT2dIWURmY3dhR2lUKytOczRIRmh5cmpT?=
 =?utf-8?B?V3Y1YzJnNlhkaytCUnBGSWM5NEJSY2ZQYy8xTm4rUEpnOTZOazA4THg1bkNi?=
 =?utf-8?B?TkI5dnpKREplUzhTcjVBYTdYZXRONjBOaU84RWJVUWcrcmhWQ0lkSlYvVVFj?=
 =?utf-8?B?c1IzcG1oK2J1L1lISDhkeEtzUThWdGJYTUpZVWlBaDAwRTRTTVlEaGdpd0RJ?=
 =?utf-8?B?dkNxRE9XWHo4NE1pYzlZRDBMZ00yRWRCSTNZTXlKSEJTTFQ0VW5xZlFIdDdh?=
 =?utf-8?B?V252b2FIRThWTHJ0NHIzRlF0dzZYM2RoTklaT1hNejRYZlIwNExRbmVCeWV6?=
 =?utf-8?B?VzNtR3A0VitSVjlma21rdktMWEVBVEdZVll4eTRqTFkzbVl3N3RSVFRUWFZO?=
 =?utf-8?B?d2RQSHNkeU9Vd1QxMTZJZTlHN0tCNGs2N0ltU1RyeFZ6WDFvLzllMytMRTJD?=
 =?utf-8?B?bGhBUDBaYUtJb1FqclV4UStBUkJIcWw2VFZic2JUaXJhTW1MWGtKbnExUWVZ?=
 =?utf-8?Q?P5NUGv2gLjltmVGT2DJTGZ2BN73FskWFS9O6gKfW9cS6X?=
X-MS-Exchange-AntiSpam-MessageData-1: PSYpdWecOs+5rw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6cd5f77-22c6-45fd-edec-08df405e4bcc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 01:43:05.5571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +UikDwvS57nnm3M6eLUKDi1UfWPRT6KzpdH3ZmOfJSrjx/aZVvTugPJUOxlBeqDlHz5LYUBR0yB6qw3wDrIC0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999324
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed Nov 11, 2026 at 11:49 PM JST, Alexandre Courbot wrote:
> On Wed Nov 11, 2026 at 10:37 AM JST, Eliot Courtney wrote:
>> In the msgq v2 protocol, which the r000 firmware uses, the queue
>> pointers are kept in u32 registers and increase monotonically until they
>> wrap at 2^32.
>>
>> `MSGQ_NUM_PAGES` is currently 63 and does not divide 2^32. This means
>> that on msgq v2, the slot can jump backwards when the counters wrap.
>> For example:
>>
>>     (2^32 - 2) % 63 =3D=3D 2
>>     (2^32 - 1) % 63 =3D=3D 3
>>              0 % 63 =3D=3D 0    (slot 0 instead of slot 4)
>>
>> The writer can then overwrite slots before the reader has read them.
>>
>> Increase `MSGQ_NUM_PAGES` to 64 and check at compile time that
>> `MSGQ_NUM_PAGES` divides 2^32.
>
> Have we tested that this was also working on msgq v0?

Yerp I tested boot on turing, ampere, ada, blackwell.

>
>>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gsp/cmdq.rs | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/g=
sp/cmdq.rs
>> index 33074bb53e8c..240ab42db557 100644
>> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
>> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
>> @@ -84,7 +84,15 @@ trait CommandElement {
>>  }
>> =20
>>  /// Number of GSP pages making the [`Msgq`].
>> -pub(crate) const MSGQ_NUM_PAGES: u32 =3D 0x3f;
>> +pub(crate) const MSGQ_NUM_PAGES: u32 =3D 64;
>> +
>> +// From version 2 of the msgq protocol, the queue pointers increase
>> +// monotonically in `u32` counters until they wrap. If `MSGQ_NUM_PAGES`=
 does not
>> +// divide `1 << 32`, then the slot, `counter % MSGQ_NUM_PAGES`, can jum=
p
>> +// backwards when wrapping, which could overwrite slots that still need=
 to be
>> +// read. So, require that the last counter value, `u32::MAX`, maps to t=
he last
>> +// slot.
>
> That's a pretty convoluted way to say the number of slots must be a
> power of 2 representable as a u32. :)
>
>> +static_assert!(u32::MAX % MSGQ_NUM_PAGES =3D=3D MSGQ_NUM_PAGES - 1);
>
> Same here, can't we use `MSGQ_NUM_PAGES.is_power_of_two()`?

I actually had this originally but I think that this form expresses the
condition more directly. The condition/issue is what happens when you
wrap the counter - it should go to the next slot (which necessarily
needs to be zero since a wrapped counter is 0). So you want
MSGQ_NUM_PAGES to divide 2^32. So if you write
MSGQ_NUM_PAGES.is_power_of_two() you are implicitly relying on all
divisors being a power of two, which is an extra logical step.

But in the end I don't really mind, so lmk wdyt.
