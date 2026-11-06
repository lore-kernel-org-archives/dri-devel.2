Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D051606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YhrmGdLm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCEBA10E98D;
	Fri,  6 Nov 2026 14:41:18 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22E6D10EA49
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:41:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvzshjaVmdvVGpIjaalHeXtR8s4VhYB5RegRD37VWET1ohhT3MLQ1hArtlI78/E38lKlz8Z+1xF9UZdzgAdA+unUnIxOsXW5Qh1sQbe6teLSkZMychTtkRpvr6n3mFPCyQhLxIoRut5i7IB5aeekS1ucwZcJCGTNPH57GGF6ZErbYCfxGgSOhsY8mrpz+QJlMZcVsnocaHgj/emYB4iWFs4vfGQL+21E19TAuyGbOTrspn+zpoI+ds8SGP9+0zGPFtbztK7n/9JTluSIk/1CFT1fqzTQ1TuWbEd4nf6tuO50AiYmzWaeKQ6ogQQpFIIhgo+6I7expNiVB4s7IpAh2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAFtBVqEaQHB0SnWqZzXafwM38ikEVEqCMfPAMhAo6g=;
 b=ihPpq77dOUDT3O1ZWfkA9Lk+azfzDYVIrE+XrPFZZpkVuo84xG6vO4VAaBq0Td7xgj4mfZfwfvmXc98KEYZnNOAKyW8efZaBjTxmvcyieOpsISEDIK7hHncIaqm8nzCDxswYKFPrFC16f6y+XxgD2N2qzbqRRIlzlZUoFBE2TVsX8RMpemAd0ebPXlCKgDbmHfpZBlJIR0PGWz/ZVUwupZeSAccZTGtCQRa8ILZf38fgQw80au+CajK1qNiwK5FKKxZeVLOKHXr8ZTztmrj+eXGOf3Z3af8Hix8DIIaQa/tJfDNr6iJP3WL7+LW23MoHRA1zbpHbeVh2+1b/WkoLYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAFtBVqEaQHB0SnWqZzXafwM38ikEVEqCMfPAMhAo6g=;
 b=YhrmGdLm1zga6dRe+HyDpfZQmV4hqji5ZWlyMEcaKojoxwPwronxx+W/EwJPVDT2+eRNJ+j/nw3yXloqxIIwowS78pr5BIMSIes/hz8IFpBJ4vQVlBmBElLiBOsdMTU1owMbwgXFkumpOqhVXVoKBQsM9fqwSoV6myx9IqWkHEtA5uRceZ7kZgWG+r5zVePA5OGgfWyJz3usAlqsTR81z/1+TfawcNd44qz/+yY6vkpOUx3ll4ZfahBhs62TozAm2GyDQkQ9I8mG9DRi4c1CKNg+H9Lh0tpDBjALgd//3G1fU3/JePY5pXcw2zu2yGGl/jQZc5HF5m4Hb096ymLlsg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH7PR12MB7138.namprd12.prod.outlook.com (2603:10b6:510:1ee::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 14:41:08 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.007; Fri, 6 Nov 2026
 14:41:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Nov 2026 23:41:05 +0900
Message-Id: <DMO7FUYY05LK.123ZPLIW24C2S@nvidia.com>
Cc: "Dave Airlie via B4 Relay" <devnull+airlied.redhat.com@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Gary Guo" <gary@garyguo.net>, "Alice Ryhl"
 <aliceryhl@google.com>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 2/2] gpu: nova-core: add support for GPU timer block.
 (v4)
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "David Airlie" <airlied@redhat.com>
References: <20261105-nova-timer-v4-0-45a7c121d4de@redhat.com>
 <20261105-nova-timer-v4-2-45a7c121d4de@redhat.com>
 <DMNCVDFYPL3I.3CCYXY4641F13@nvidia.com>
 <CAMwc25rODe5F7MdhWEr80q+eOitKqg-O0LQhEWOMSVWZodfyMg@mail.gmail.com>
In-Reply-To: <CAMwc25rODe5F7MdhWEr80q+eOitKqg-O0LQhEWOMSVWZodfyMg@mail.gmail.com>
X-ClientProxiedBy: TY4P286CA0040.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::19) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH7PR12MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a29128-3252-460d-0dd5-08df3c13fe6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|10070799003|1800799024|22082099003|18002099003|10067099003|4143699003|11063799006|5023799004|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261021135927099003|261021121427099003|261022105027099003|261022075727099003|56012099006;
X-Microsoft-Antispam-Message-Info: 2ez386X4PCqFAMPc7NAS0q5U9SA7QoId5NZ7X2WLoHG4VGyz/dTaHwzsPG1gyKvowCS5U1bt1VFz6lRm8SJoQd98Nbzl/iEJayQvKS4V3VNMZ6sbE6sVmFp0Cz68aBrabbj93z5+fhsbgXwJxXZRO3Gy2Ak128O/qiL/TAc2qUTJYqLuyJYNXaK4zjna1VB7BDUtFrsH2AKmoiBTXIDvgwcHmdx9LOCWqn+YQORYtcYBIaf3iB0Re+MNMxEgDxho45iftT2xMjMS1dWON12KEUqoEpwHwhnpQ3oabexlHzUVr2DLcTRLYk/i5oKruE1+RXeM+MuPYfMBmrEZHYJwysKqRqn+jB+6kxR0mq/U7j6T9m+l5h8j8ejMCXWQdw6plnhLYR2auc1Dan7E9VtCieNcx3AZFjVcTx6hzvXVBFM+sHua1J76/nclzcpD8vXRjZPKdjCtR3V/PI66/YKKF4lXL7WdHn87bohy1tzD1W0XI5iYVNBKhV3iKt+D2gxCR2+6gblMht/pgkjLfrJ5BzM357S0//onzcKwjc8yzg7KgtF2MLnwOVlyhIL4mbMMYyZ2oQCkYAcemXjX5hBJJykUdWjhNUd6UPRygEhPgE7EApqfVZ7ebqSEi6b737Qeg+7WXMYxmaI2jyWIIwjaAQzJMToLLJcGwz/d5plKSrI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(10070799003)(1800799024)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(5023799004)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261021135927099003)(261021121427099003)(261022105027099003)(261022075727099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TituOEkwY0ZCdGlkMndrdWlqZU56L2VGWGlxaUhFaE5BWW5BNnhLT2Z2c3RD?=
 =?utf-8?B?ME85R2VUWkRRbUlNUVRHNjZlUldaZExrbWVJVHIrMGp4ZE9QZDdaR2ZkR3ll?=
 =?utf-8?B?cG5DU2FLM05DS09KWFVScnJMbVVHTlFnN29wUzcvaWo5LzVheldIS1lKdEFN?=
 =?utf-8?B?U3A2WklKdUlZN3lncnRzWEFsb1AzTHNsUlh0YXBXU2gyamhlN0RaVnBBRzRN?=
 =?utf-8?B?akU3S1JSamhkVThFQTlScWt1Q1ZzZlZ3eEtITHN4Z0NqUUpyYUpaUXVKWHNL?=
 =?utf-8?B?aWhUdkZTNWpsUTFlUWNBbEY5UmM0aW0yK0RXeVV5MnR3eHcyb3ZBUEVqU2Zq?=
 =?utf-8?B?VGFjdTA3SEJGRi9YT3dMUHlCdUQvRmNuZEpBeDdvbkxIbWxtQVNJTkdxK0M2?=
 =?utf-8?B?OUNuc3hwdzhyMmhxeFpuUUNUc2xHajFBVWFsaE5mejNSd3JtY2RGWFJmaCtS?=
 =?utf-8?B?RDFxampGZnBiYTY5akJDV3EzY2EvR0JWeFRoeW1FMVUxbFBsVXVqUWp0L3F5?=
 =?utf-8?B?UnQvd1psRGtsaUh6RHVDTFYyRzAzZlBvYjNoMVUvUmVTZW1qZlJIUWM2MFZt?=
 =?utf-8?B?bmZ3cXJyM2tXcEhRd2gvazJaSk9LL1VnQlg5OTUwbjFQUnNhVGs4ZE84WTFH?=
 =?utf-8?B?a3Z5UlR1L2g3Zjl2SkFHVGtJY0liaUJ3NlBIdTc0NTFkNDExSmpyK202dzhO?=
 =?utf-8?B?Q1JybGtiL0ttWlowVWZOT3l1dzViOG11aDIyaGt5aENKTTlsSEt3a3VyL1NR?=
 =?utf-8?B?NnBBWWVWMSsrZ2VkanlzNS91L1NSMUtoK3BHQm10M1k4OUF6TlV2Vk9Od1Ev?=
 =?utf-8?B?MWNFQ0lBM2ZjdXgvNGYwSHlIaGV6OFZydHVORmpwQTRVTzB6bjg0SlQ5M2lQ?=
 =?utf-8?B?R2xRZDl3QmkxeTNpQnZBUHVFeGtiaXpvZldoV3VyS0lIN3pobis5UDBIRmdw?=
 =?utf-8?B?bk1URTJSZUgwclZtbEFmYXpPRTl1ZHBUNHg3bWV1SzR3VnJiVjlTdzl5L056?=
 =?utf-8?B?bHltc1JEY3dvbGlMVnQ0alhZWVMrajhrc0hoWVpkZm00RVFQVXJQRmoySzl6?=
 =?utf-8?B?TEJQbVJRYk1iRHFMOHNMTW5RTWF1Q3F1RHFqTk9BZFRjYTByczc5dmpFVkdS?=
 =?utf-8?B?RWZLQmE4enVMTmZuUHMyejZ6NHN2djJZenFpL0NYMjdBYy9ndWU5VWtvcFZj?=
 =?utf-8?B?Z3FZSFkwdzlvaVRqRG8yUzNBbEpTY0FMVUNSWGtTVVVVUFl5NmxGU1BTOFQv?=
 =?utf-8?B?cnZQenA3RTJYeW83b1ladnAyWEJ4VDlpRExSQ3Mrekg3WUJYVTZCOEljTVZk?=
 =?utf-8?B?dEpNdytDTWI4YkJ1bDlGTnNpcjBsVlNoelBJUmNRd2g0aTA3Z0ZHVmRQT09B?=
 =?utf-8?B?eGZnNmJ5dllsOVI2ZWNNOVhjNlBGSWNBeUtzMFpxRFZPVmlkZkR3MEV0eWVW?=
 =?utf-8?B?T1pYSUlGQTRNL2hic0x6NjB5VXVVbnNkNGliTlMyV2pmN1RqUFZzd2ttMkx0?=
 =?utf-8?B?T0xIOC9YaWFUUlBabks4WFV5WWNpMzhuMlpwVUFDdGdsd2p5VFBBdkNOQUtx?=
 =?utf-8?B?eTBTYXJwK2hKZDdGU2sydWJKb0J1ZUo5ZU1sL0RoNzdYckw3b1JEa1RXQm54?=
 =?utf-8?B?T0xnWVZOWmp2WjcvTEtqT0k1TElJNTVKM2FZajhIK0NGQmZXdWtJQzVIT2tO?=
 =?utf-8?B?a3ZrT2VET2xsUGRkVjlGcUd1RUxaMS9nSlMzRENGTGZaeER5Uis2WWNBRHkx?=
 =?utf-8?B?M1VwUnFia0NxTGtEWFYzdTlTNk1FbFpra2crZGxsb29pdjVWdEhhdXB5TFFB?=
 =?utf-8?B?Ri9FRE83QnljR1lsWTVCWVN2NmFKVWNMdTlRazBCR2NKd3h1a0xsV002dkdS?=
 =?utf-8?B?RXhIZ0NpbVNxblU4cUY3b0hQdXd1YlhxNncvUlRlbEoxZnhRNk5oWHMrVUZM?=
 =?utf-8?B?WFovaytwVWFTOEIyeTFlZTkweWlRdG93WkxraFlSa2Vrem1nRTFianhBTWNz?=
 =?utf-8?B?MkhRbUpWeXMwdWVNWStuUWZDdENHTno1WkNDRDdOOUl1UFdkbG1McGkxdkVa?=
 =?utf-8?B?QVVFdHh1dGtqUkVLR3RUQ1kveGRrcnZ4clQzdVd2akcvYjVSUjM4K1ZHZCtq?=
 =?utf-8?B?RzI0RUFNVjFPN1NJU3ZBSjQ5VVNUU3UxZVhSZGxTTEFZM3EvZDQ3WXVGancx?=
 =?utf-8?B?YWlZTjN5TmprUlVwVkRuVVBwSHdHQnZacE82Z3d1c2RTbW1MbHkzbGlYc3pY?=
 =?utf-8?B?WkdDZSthQzg3ZS8va0pwNkl4UnkwRUdoT0pwL0RkbmJ4R2JOOEdwWm1uanpw?=
 =?utf-8?B?S0Y3TU9uQmJvcEQ4cDJHczhkNjY1WGlRaStGTFI1OHFrZzVOL1FjbTJ5SjFD?=
 =?utf-8?Q?Z29N5lmO6kaUELNzQZeResdz29L4UYkXcQdi/b81ciW+Y?=
X-MS-Exchange-AntiSpam-MessageData-1: Xi1B2tx0/QMRUQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a29128-3252-460d-0dd5-08df3c13fe6e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 14:41:08.2283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +durxcF1drg0hqesx2yCCGXRy5b80Eh3uxKkFloEqrOFI5wP6cZT6RonEZyb2QoemHlt+/llt9f9eLMn3AilcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7138
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Nov 6, 2026 at 2:31 PM JST, David Airlie wrote:
<...>
> I've done nearly everything you requested for v5.

Thanks, took a quick look at it. It's getting late so I'll do a more
in-depth review tomorrow.

>
> I've just stored Chipset in there, is it worth storing hal? It might
> happen later I suppose if needed, but for this I just rederive hal for
> the one entrypoint.

Storing the hal is technically better, because in
`is_bug_3957833_affected` you need to handle the case where `fsp_hal`
returns `None`, even though we have already assessed that the HAL
existed in `Fsp::new`. So it's just a dead branch that can be avoided by
storing a reference to the HAL instead of the Chipset.

If you do that, `FspHal` will need to require `Send + Sync`, but that
won't create any issue.

Now in practice, `is_bug_3957833_affected` is only ever called once, so
it makes little difference. But I expect the FSP HAL will expand
further, so storing it will definitely become the long-term design.

>
>> Maybe also explain that this can program some timer-related registers,
>> otherwise the name `init` isn't justified for someone who believes that
>> this just returns the time without any side-effect.
>
> I used setup, I don't have a good name.
>
> The main thing is I didn't use the NSEC_SHIFT thing, but just write
> nsec_hi and lo wrappers that hardcode the values since to me it looks
> cleaner than trying to infer that from the register definitions,
> especially since I don't see a good way of doing it for nsec_hi. I

Ah yeah, I saw that you used a helper function that is used by both sets
of timer registers. In this case it is not obvious which one should
provide the constant.

In this context I guess we can go with it because this is only used
locally, and `Bounded` will throw a build error if the number of bits
don't match, but generally speaking I would like to avoid repeating
Nouveau's pattern of producing literal values out of a hat and use the
defined constants whenever possible, as they act as documentation on top
of preventing mistakes.

> remove all falling from these paths and just went with truncation
> because that is what actually makes sense.

Do we understand what happens if we truncate though?

>
> nsec_lo/hi are now used in the register from_nsec for both tu102 and
> gh100 registers.
>
>> I'd ignore Sashiko's suggestion as it looks like it is trying to
>> reconcile the code against the comment instead of the other way around.
>
> I just fixed things to truncate and used wrapping_sub, to be honest
> being careful here is probably the wrong answer, my local review bot
> pointed out some wierdness can occur in 2043 with the current scheme,
> so let's just keep it simple, wrapping subtract, and feed the result
> to the hardware which is what the other driver does and what nouveau
> did.

The other drivers do what they do, but here again do we understand what
happens when we write a wrapped value into the timer registers?

>
>>
>> Once we have moved the timer read loop into its own method, I guess the
>> remainder can be nicely folded into `init` directly, and we don't need
>> `timer_time` anymore?
>
> I didn't do this, I think resume support might need to program this
> also, and it didn't look very clean.

No problem, especially if this is expected to be used later.
