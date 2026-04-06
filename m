Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29C9E9D814
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 02:30:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C5D610E195;
	Mon,  6 Apr 2026 02:30:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="P4oijPb9";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011033.outbound.protection.outlook.com [40.107.208.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3167A10E195
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 02:30:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPSIRHKAP8pnag5mra3mDsXvMeQnp661I+sR3bGovclro9EN05GkoS2BK4q5f80Cv+GuUAaTjXM6rsqWRmj/qtlaxhN94orSW/v6XP/gVaFnK5myK8XqVy+SJgeEpJWK5lByKI6HUWwpbMGp4j2N8PrttnG1h0FOvIBjVYWStxgv+EVtgHU+F/b1x0bLd4f2/4UKcbcFBE9zsXibzJXlRq84OXPCeANVJHHJZMhkkCaURCb7sLto4jmky8ezT0ByKU0q3flFNTgQPVII3Sw6wAy08lTQT5Yb4SbzlMbSijTNVJ5PoCPwuie+wpZ/2c2EMcvqdzqrAxtlhd7eCAd99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XagUFjq0sziRXmxy39lngoCO40ECJ9t0s6449d8NKQM=;
 b=ax1nMI8gHApv+/uD/WZvIgs2SmX/hmLJzLMTJKu8d83gjzFUPb5JHgJHASOWW6jKfRQOaktHCm3RPF+57CgC90D9ypwB+IiAQwQAD5GzEoDa4gdkylAfII9s2FmVQ8Kwjyw29p1F2qNbW0PBV1MjKmJxCgF7VZzpc6mZSWRxjWHsIa+K6t/y9Bvx+U2TFNCZbqJES4Xaj0oxVn5NWNC8fFychUPpscqLUAHMNVNi0lizM8cUZmU62iDQTBliDvmvh0PRSmtdXxzC3SWsPS3pBpJlwMKwudGCtf11XPXlZDU0NTZAloQqQfgt/DhOkWl/oYIJwcHxgkJw/ZPlS952+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XagUFjq0sziRXmxy39lngoCO40ECJ9t0s6449d8NKQM=;
 b=P4oijPb9ujtqpagtyBpzDodfZ9oeLcCrWnmvRlICjSlfRQDuRY08XFy0TPJAxcTCrpCZZKOPU/NBhP+GiszKvkVf81abcQY4cEKIw2P8yk3GUh04lDvhss++XKqfGdsiqrfZkYt46aaNc7K7PGvePAvYGo+sBEFFtKiy6Nf7ccJ1o/4fQ0zCdUDRXrLnHabDYWPcHfhk2+F/dcZHEiejDW8Vb6ttn5oNtVo3T9gA+09nk4cBycm5fR1P4LiCaKhW8zP/WvH4QaUCKluK8pIlUMJmFSJgJBMKh2lWyDpHqOkneHz9Xa3mH1Z0FGr2rcKktIpi2QVQ54AP9Pq6v7qMtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 02:30:12 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.017; Mon, 6 Apr 2026
 02:30:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Apr 2026 11:30:08 +0900
Message-Id: <DHLPVMCAVZIA.36KO7JBWDATBD@nvidia.com>
Cc: "Alistair Popple" <apopple@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 9/9] gpu: nova-core: gsp: add FaultMethodBufferSize
 RM control command
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
 <20260325-rmcontrol-v3-9-f3101093484e@nvidia.com>
 <fdc13a34-c45f-4cca-a3c9-7a72475b9f70@nvidia.com>
In-Reply-To: <fdc13a34-c45f-4cca-a3c9-7a72475b9f70@nvidia.com>
X-ClientProxiedBy: TY4P301CA0081.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::15) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6f9ffc-8a86-425d-3ecc-08de93846dfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 9u6NyBQEUrT972DQfn/oQFVFXtM2lggGH8DSS+GFu5yWPxnu/PT0fsKht6BthOHC/932nI39MFGLxnsaibkGx3zt3ZcXgjH7q0cYfGtSskfO8iUGlGaJRRMLJ7mTdn+P7LLrIny7/h22hh/XiIdEngX8CoSItYcHZPfoFup7OrW/m19YgEFxsLefi0KJTIUPpnpP6TZGOYSpcOwOm7jfPVuWdmtZhLIEnL462wJGBXfIAghnuIXMEDNcS7ebIxZClM1FSOhLZyJHTIutPrIdJawHloqrkfrli6GPajjl/zftXoousHJGXTocewjmSZzWZIaV92xzNG4CJmZ7sKi5QwSRs99qXKM14Gu1+ZuTNitBTRbG4GAGJ+0W4OJ9NW5KxtjlOv/yDiH3FBtsGG+gdbxE9LJIBXZ9JEEHFI2Rjek398S8MtXleoUcR3g8B1u3uGFBqzPkD9Huf+CxTaezOxts//uKqaeqbpKU+i4Uow5Nn+nHIkVZERYeYQFvh9wVQzqwBr40zLzSQwxFnInZmODu9tzusCQa2gktmD1bAs3dlrTDGGG1miJZj4VklVU0hAzN1nDfrthbVbaLs/qFeo4vhz6FpbPwdoSu5PmykuJlEvFRcIqKWidibTGm9PSScLHh4OedOOpCd0KaG3U9g9zsMwueTOB2+WsvMsIZ4WCqopWMJpSnzTA038R4zjlmVdqiL8lS/aN3p/oG8JmWow5bcZINi+N+J2EIO+Vft0k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVVwc2ROYmlhMGJrSjE1dzlxYkNJcW9LemJoSjJId3MwWG1ET042aGpWeHJT?=
 =?utf-8?B?REdGRG5kMlkxRjZrYW1kZ0RWdk9NeHJNUjR1QnlacjN6eG1laFMxQ3QydEl5?=
 =?utf-8?B?aGxacE1UdFdNNFFncGdYL0dtVXUxdll2cnRuY2dxdGJBTk44dFBKY0VPZjNM?=
 =?utf-8?B?WUN0a0t0Y3UwcE8yeDc5S0R3OFFITWNEU0FYYWpEcjNWd3d1dk94Y05janhH?=
 =?utf-8?B?OVRlMmpQWUtSWkFIZ1A4dmhONm85QjhkemtlSS82dGtGWXgvemcxZmUyUks0?=
 =?utf-8?B?UFdNOXBTeStPZTlzdy9lNGxhM1Fud05LT3dLbUJmOVZwOUY3b21ZUlBQMTJ5?=
 =?utf-8?B?UE1TUUM1TmhPR3BFU0tZNmYyVzZQM0dyRldtVC95dmtuZ094TWRhaTV4ZnV0?=
 =?utf-8?B?cC9KZzh3WkM3TlNUMEFZamtYSGZUa3hzcUtrZUVITDVNNXBacXRwZTBQcmFr?=
 =?utf-8?B?M2lONzJFc1F1c3drWmY1ZHFXbUNGVkNKZDU4L2pyMFNrZDhJeXY2Zlo2UVYr?=
 =?utf-8?B?cmpEbFA2dGJGcjlaajdRRS9LVjRUaFgrZW9IR0xIMHdSVU1LVEQ5aFFUS3FX?=
 =?utf-8?B?WklxTlpUSVh6dGl2c3pkNXN6VHlERElrSVZrRVgzYzVPZ3ppU3BvVFNoRUJz?=
 =?utf-8?B?UDdEaW1makQrY3dabGZuQjJFMWNxVXExQlovR09tNmlrZ0U3TmNUMCtSbnM1?=
 =?utf-8?B?UHZ2RE90MG02b1hkd3NQRlRnaExDY2pIMkhuQ2VUWTFqR0M5UXhsSFVKam9H?=
 =?utf-8?B?NUlGZm1QSS96QTlpKzl4VWQ1MkRwYlBVWTVVbnJPZFpFQVgrc2UwQ0svU3py?=
 =?utf-8?B?dXYvaGpabnRJWGJ4TXZiaUk4aTdlNi9kMCtvcjVVUXh4cDU5MjgweHE3cUZH?=
 =?utf-8?B?anByTDZyTnROM08rQ0dhZkJqTFc5eFlwMDJFWjAxK0ZJRCtnSHg1Tk9hbUNr?=
 =?utf-8?B?bzRQeU1nanFpd0czTzVzamphQVVkVHgwSzlBUnRTZnRmNmRoM051eGZscHpF?=
 =?utf-8?B?K05mNDFqRytTb2lCT1FiRDBjZzZ2TmxDK2hiZENoUDJ3UFpXc3FEbVd6UmZy?=
 =?utf-8?B?eUhZb24yTXpqbmhXMXY3dG5aLzZHenZCdGVSK1QzZnZEaDRyUkJ4SndzZVZo?=
 =?utf-8?B?T2JVT3FvVkVxcmFiUjEvYUdpdmtaSzlEYklSaTlUajNxYm1aWUhRWms0N1Zv?=
 =?utf-8?B?ZTVLV0FxYkx3WDFTRnFkRzhrUkxlc2txcTBnZmdPd2lCSWVGT3lwNW54dWRI?=
 =?utf-8?B?eWdLNUQ4NFlySW04UGpDL1cwRkFzYktxUnZLbjRlcEFUakNYZFdaK3k0clZM?=
 =?utf-8?B?OXp1UWxJeUNJZUYyMmYrQXFXUjlwckJ2cGMybVcwWVpJNGlybUFlbUxFUlNI?=
 =?utf-8?B?SHdLcmpoK0RBT284RE1qQ0RnUHgrVnFuWEJEdnFCWXZmRUQ4cjQ5R2x0MzZ2?=
 =?utf-8?B?T2NSd0htUjJwUG4xeVUrY1B4TEZwOVFlS0N6ZWVUT1RtcXYzSFV3ZTlNVng3?=
 =?utf-8?B?RkU0QW1sWjczd0o4RGtNc0RVSVdhQ2wwb0x0dGwzVFlDZk1EdEtCKzNOQTU0?=
 =?utf-8?B?ekZpU3hBWmRMQWl2eXYrbUdXL2EvdVBmdk1tdGkzU0tVS2pXdDhlRVRlcnBn?=
 =?utf-8?B?bXR2MTlwQ1Z0VU80TjZaM2haeU13cnlKRXh2NjNLTmRPSDZoWFlZd3ZxdHdH?=
 =?utf-8?B?K2RzcE9VdjNOeXk5SHlnOElrT2FEb2VSM2dPa3dQbzNIdytBdUlnS0U2OW5p?=
 =?utf-8?B?dHVkQ3hTZzI3SDBzZkhhR2VUL2YrUnZuZkR4RjUvemRIRklBcTNieXl3R09s?=
 =?utf-8?B?cGhFQ0FCcEtyNXV0Mis1eW5nYUhxc1hFQWxybmM5OUJYODZlYytYanhHN2dj?=
 =?utf-8?B?OHB1UEZLcFFzOXNsYWxTdU9DUng3S0pHbDlUOXNOVDBGZE5TbTlwQzlOenpK?=
 =?utf-8?B?c2hLc3p5RngzR0RWdkhMeWhhTE9CeHN0Ti9vcnBPdFpyOEk0VEcyNUpkRHV5?=
 =?utf-8?B?KzRCYzhLaXhOS3dFUVBKTUovZExCTnhXRmNweVdJK2xBV1cwVmthODU0c08z?=
 =?utf-8?B?cmt4MkhZbkZFcmhZTTNhUTJNdTh4RTk4dThiMXByK2NLYW9XWExWN3ZNZTBj?=
 =?utf-8?B?bXd1MThqV0RzTnc0OW0rQ1lvbFJUVnl3L1JNS3BISWRDWjEwblhjYTYyZWN5?=
 =?utf-8?B?cCtzSnB5bkFRcFlua3NRRGhBTjJNN3pUcHl6TXhLK2NmUGt4L21uNFZxT1pQ?=
 =?utf-8?B?Z0szRVIyMVRyd2tSL200eTIxUDc5K0hGekNMdnFJdTJPSHhYb09TdmYyUkVR?=
 =?utf-8?B?MkNDSEc4ODd1ZE1IZDBZVGcydEVSSmJwU2pEenVxYlNqTkpYSlF6WFdXbjFl?=
 =?utf-8?Q?7PhVbXFKb+V/UQZGRNrHgzQkO/UmHJn6lamVSqnf4/lSs?=
X-MS-Exchange-AntiSpam-MessageData-1: Qf0dCfmELBL+1w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6f9ffc-8a86-425d-3ecc-08de93846dfe
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 02:30:12.5892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQmk+7oIG7rWBzpNPEwRA+uc+NPYQs1y9xOhvPR39kzYy4qCZN3yNx12DQh8SAxETdZQvvTJyPLX3JBHAnuhPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254
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

On Mon Apr 6, 2026 at 5:12 AM JST, John Hubbard wrote:
> On 3/25/26 5:13 AM, Eliot Courtney wrote:
> ...
>>               Err(e) =3D> dev_warn!(pdev, "GPU name unavailable: {:?}\n"=
, e),
>>           }
>>  =20
>> +        match RmControl::new(info.client(), info.subdevice(), FaultMeth=
odBufferSize)
>> +            .send(&self.cmdq, bar)
>> +        {
>> +            Ok(size) =3D> dev_info!(pdev, "Fault method buffer size: {}=
 bytes\n", size),
>> +            Err(e) =3D> dev_warn!(pdev, "Failed to get fault method buf=
fer size: {:?}\n", e),
>
> We are in Gsp::boot(). Errors here should be fatal.
>
> So there are a couple of options: either don't invoke a non-critical RM
> control during boot(), or else if it is critical, then call it from a
> more appropriate place.
>
> thanks,

We should change the code right before this which does the same thing (igno=
ring
errors) to print out general GPU info then, IMO.

I think it would be fine to drop this patch as well, it mostly exists
just to show how the RM control infra is called.

