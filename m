Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EC0606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=N5xscv2b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEBFA10EDE5;
	Mon, 16 Nov 2026 12:52:01 +0000 (UTC)
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021107.outbound.protection.outlook.com [52.101.95.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A35010EDE5
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 12:51:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hx2GEoS1X5xU6+qN/gJQWl+zYISgmBeeOkRZk5vYrLHvuAgcyEREIw5vUHubn2eRvV7brek9CbA1zXJcdvwt16/EBZKBJZK7nhMIBug/9yu0QZEv+3P3KgoIyiqnA9fcgdsta6ii481hjokyACmPdZkbjboIKUem4+xktvVcdr2KxZcKc2yr8y7EjJhxqpidtisCJhhJ6CBeQ8qTunFbHTT8KRYhNXOkoboXwo2Tk+ypbVpPbc6c8fpRuFhBwZf8kpMiH1cxCkAKpvMB91rGmMzTAgFY7ef9Ngx9xqBq1w0X5HZThTmYjCWR3mF+EU+6ih0SLD4Mrxe48NuaISaA4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeXzS5+inoJu0s9ApXKZcQFxsTE1KT5hPFaqro1z2WY=;
 b=m7VY285BrwM+bj5foS+6m+9c0qm24ZRZ6HK0MDquC2eexB60wu/IAxco8jtwM6o1U1pFW7CZs3X/rxh4sTkM2Ku5Drb6D/x29G5Y5L+ExfZMVTgEIfj3TW0WZYSVGNKdryJxjP5j6fNxp4KzRDsANREVIeTUTF4rgDgOZkK57iEwFMexPbSaF/wZx1v1lxFlZwpIKwHmKE+dkvoFSsc1rCU5cja2AymhSdP3OPED+3rKo29O45f25MsbLe280Vrt6ETFQupg9qPjKXeZRai/qVGKRQzowl+MoJDN9tyg3ISqCUalToIj6Vj6/6DNcnvyaZpo/OwKboN/I2Vq7w7/WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeXzS5+inoJu0s9ApXKZcQFxsTE1KT5hPFaqro1z2WY=;
 b=N5xscv2bsErDe7DdHehq1bdx5dkGniSTwFz8TEBSGJWzJemLkLvqjx3pPRqc6vX0MA/x7+eskFUzsUvZQ+rE9CpMBKgGFwEuaFEjc4ZnMG7K87RMKBCe/RrlcT1M9sQjcPqADnnS6O1VG92L5JFzzAv0LJf9wNrlypEYRzLIp88=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LODP265MB503956.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 12:51:52 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 12:51:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 12:51:52 +0000
Message-Id: <DMWNDOOCMPVS.4384GVS4DMC5@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <lossin@kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] gpu: nova-core: use pin-init self-referential
 support
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20261111161935.750047-1-dakr@kernel.org>
 <20261111161935.750047-2-dakr@kernel.org>
 <DMWH39UWW4KZ.1C5B2M4W1V3CF@nvidia.com>
 <DMWM4KAYL7PT.2ECY3BSNIA2P@garyguo.net>
 <DMWNA84XI432.TJG95PPPMGPR@kernel.org>
In-Reply-To: <DMWNA84XI432.TJG95PPPMGPR@kernel.org>
X-ClientProxiedBy: LO4P265CA0008.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::16) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LODP265MB503956:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e84960-2692-4162-797b-08df43e0633e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|10070799003|10067099003|56012099006|4143699003|261021135927099003|261022075727099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wP52pZrq1Y6lvksyr+5jwWldGlqVrj3WXICT3SMUia52ricbzyOMFE5MZnh9WsJ/JS8KZXzN9c2vc26PMPGps2Pp+ZSs00v9LEPqmXIXU0w/0hA3AvRgSnU9viGTeoMx6s9EdCYH6TXTXGDvG6BdHud+hsj1nyrKG4tIMR0Yn1p9gmIQc2kCVnuimKh0+QfqW7eSTpv1t3Tj3FwbRuHRMOdDczPnxUr6sQmJ87LkM7ZplnWzgwnCcfd07mSQ/v7WZZUdUtwGx06VCv232tXklNROdkNEawtlFHV8nYKqEqer4yIWIBabOoBd8SB8AwqWsiFMYQWPTFwnVbbBhn1UvR1VL4rNatvh7TtrlWV8KOkNaZl7wF2ghH8ArUPQ/pEbBNp4+SBcj/T/GiEWEdyqzthbJQyrP5EFDklk8SGVuGbVh2UQqRg0VJw7gyt+H6HZroD+zoVq0T764LDicJM1hP1qyCcyxcHM1EvtBfEN5lOIrRca6eKz4/d0KVu3HmhOOsiue2nUugntKXME1hrOQTcY57A+tgzANjvKNNgdKN9rlITGebSMW5LZ5DURyMBZpMI/ey8WRy3H5ss4gQ+l7Afo28GxyFtpCl9VV2UL3Tbd+xnMondkJ0l2Ot8yvnY2jZ+8KHweFIaC0ERrwCxhWILG529Gh/wE867FwUKF/E4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10070799003)(10067099003)(56012099006)(4143699003)(261021135927099003)(261022075727099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1d5YUljM2pjUjVMeC9ZZUVpS3ovU2VjUk4ybFFSYzliV2l4UFIxYlp1Z0ZN?=
 =?utf-8?B?amw2UEpPR25KQTlPK2I3WlNwRHZ6Vk5WOUprUHh0SFYzWk5HdTUveW1zaW9C?=
 =?utf-8?B?YjJSMTk0ZDR3RlQxbno5dlVIcDhOZEVTeFRVTUFoZSs4RURmNnVBWU9LVmlj?=
 =?utf-8?B?SGhxNjlhaGdYZWkrQUFIdURYUHB0eHVBTjA2WGFibUpEdFdKUXRMNjRlYVJU?=
 =?utf-8?B?UkNHYXNHWWN3RHNQMTJUeVlzdXhJUXZvVW5zeDVFT2pRY1B3Tk80a0FNa2F1?=
 =?utf-8?B?Mzd3dlhXYW5XQ2hpTFhHQS9JVHR4bWU3Z21kU2RReFBPQmE5VzR1SzBESmkw?=
 =?utf-8?B?c3g4Ymx6UUZNZ3NpTVA3S05PT1hZT1QzWVhEK1BQOHVPdVFFNmdqQWNXNmFR?=
 =?utf-8?B?VERXR3BhZ1ZnbmVJNHBTdlhvTDZXUWsxemhlUHZoWW9MU2VnUVhHNVl3N2Jv?=
 =?utf-8?B?cnU2RnZ6L0xNem5UcWJGbG9TUTQzaC9QM2lXYk9GQ3l4cDRNNFo0MVpRQ1ds?=
 =?utf-8?B?dmxYSytHcGNSNjJlMis5anV2MXJLNERqTldVYmhBbStiTGhwZG00OU5wbGFz?=
 =?utf-8?B?Zzk5b2Exd21HaS9vRkpsWTNYcUhkQXpEbjdwU1I2NThVYTFuUXNyWGpMRDN5?=
 =?utf-8?B?S3dnaXNDbEVCTDNWcmZFUHZuMTdRbTZBRjhJZ2Via3krZVdXOE9rNjdFWDlt?=
 =?utf-8?B?RVAycGRKOFQ2dzBrK3p3a0d1cUtNTnBhcDBYTTZlYXdTS05rVTRYTnRTdDdX?=
 =?utf-8?B?VHN6M1hlcnM4c0ttTC9ydjJkZm1ZMjhES1gweU9yWlF0N21xNVNWRis3Zm9u?=
 =?utf-8?B?aEZWaithcHQ3T2NFNFRsVENwTUxHL1NGOE5HTnNGckphd3lMeVhNNTV0NjF6?=
 =?utf-8?B?QnlhUVNyZ1Nnb1haSjBpbUNLc0tWNFVVT3Z3Y2FHdnUyN0RqZUVUakF2akdr?=
 =?utf-8?B?dGE3dWpaaUxKUm1kaU9rWkI5VXlEaWhLTDdFbFJaSy8zMTQrRWpBTHhsMDdN?=
 =?utf-8?B?bTdicHBPN25PZXlCTVFzNkx3ZVozalcyZUVvTVJqWE8vZldya001WXB3ODFS?=
 =?utf-8?B?QTA4ZnBNQUhvS3RIeXhFMUJqZ2taVkxrWEYxUVZlRXMyQzAzSHJXM2srdHVa?=
 =?utf-8?B?cUhhanJ2Rm9QUzYyMHFnY3ZDUnVMcjI1aUs4ZVB5WTBoUTlCWHZySFdOTWJW?=
 =?utf-8?B?RklabFJ1MHBaeWRkTHgzUTI0SGxLN1h4QmQ2eXp4NWIyZmt3RVNKVGJmZWZT?=
 =?utf-8?B?dERYYUZOKzVBVWp4bXYxN3VXMlpUeGs3c1N4VVoxWm1NV1FqSkJ1eUhnRS94?=
 =?utf-8?B?dW0vS3JsMXVNaElhT2xtM1MvT3lmMWpGVVREWjZHM1BkcVNBZmVmajgvT3ha?=
 =?utf-8?B?QWZiS0F4aU9vQitTK2lMSkRoSWlLbFMxdXh1M1pEVWhYNnlHdllwY0FvTExY?=
 =?utf-8?B?NEVtemlBbldTRjF3OGNQM3Q2YmRMd2xEb3lzdWFzbkRTcnJscHBFd3BFV1Bk?=
 =?utf-8?B?eEpRMmFiNmdFUFRhemRTV0xzK1ZKcTZVdTJpK2ZkYWQ4YU1QcVRyS3ZqcUU0?=
 =?utf-8?B?MTFRR0lDc0JIbmRrVFRpcU1TZnNBSWRPSWFYK1RoYnI2VGFFYXl5Qkg2RE5m?=
 =?utf-8?B?ZE9FczBJdkJ0VVg4TllJc3NoQTN2NXFacDl2bTY2dWd6UlBLM1c0NUlBSVNO?=
 =?utf-8?B?WjY1OXRoYUduaDcwS05NZGoxeXNseXIrVUdvbUo3QnBLUjlvQStGVTd6cUhp?=
 =?utf-8?B?VXlKVlhCR1E0b0dKdFhsOTF1cnhsM3dJM042dGNWWVc1Y0xjNzhNcHNXYU9z?=
 =?utf-8?B?WjVOVDVqMm8yc3VFaGVFbGpWY1R5UHVSMyt0b1l3QytObHcxUXhNdGc5bE02?=
 =?utf-8?B?VHFheTU4aitJc3JXYzNNWlZreDRmdDgwQ21mSmd3czdDNDZDY3pvU0dBVC94?=
 =?utf-8?B?c3J5SG1Ianh2em10cEdhVTlabW1CMDNad2txSDllWllZQVRqUzN4K0JjNDZs?=
 =?utf-8?B?L2V3TjlhNm9MaEFZUEJxWDJ4RXFnQzl6V0ZrNVJTcDB4UlVPNVVyUUJDazlZ?=
 =?utf-8?B?LzYxM3JUNEUzSGVqcmo0TXcrSk1EbktQWVpTdW94Z1VkM25UV3dCeDB2LzhB?=
 =?utf-8?B?dmk4ZVRxWHRnQXgreEJoL1JwVldtMHJ4VWNXY1lrOWtWem9mRDYwOFc5WnRL?=
 =?utf-8?B?YTVrdndzUWF4dnlFclhIamdVNVkvV0hiR25EWXdIVFZBZUlBZk8wdzdPTFRo?=
 =?utf-8?B?TExSZEVpbnArWjU3aThOR2hvQXZEZnVxQXVEWmJnakVCU1EzTFpJaGRJY0Jv?=
 =?utf-8?B?M2V5aytVU3RDNDFkVHJCa1ptVGV1QisyUmFPQTNNTUZZbGVxb2tXQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e84960-2692-4162-797b-08df43e0633e
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 12:51:52.7619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOqMl/vsP0cBLzca6BDMU/ceBML9EhDPn1ka6KopBXcPID1yCzueuZoGtlSSfWty1uueebrbuhEItNLBDOYnnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LODP265MB503956
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 16, 2026 at 12:47 PM GMT, Danilo Krummrich wrote:
> On Mon Nov 16, 2026 at 12:52 PM CET, Gary Guo wrote:
>> On Mon Nov 16, 2026 at 7:56 AM GMT, Alexandre Courbot wrote:
>>> On Thu Nov 12, 2026 at 1:19 AM JST, Danilo Krummrich wrote:
>>> <...>
>>>>  drivers/gpu/nova-core/gsp/cmdq.rs     | 16 ++++++--
>>>>  drivers/gpu/nova-core/gsp/cmdq/gmc.rs |  9 +++--
>>>>  drivers/gpu/nova-core/gsp/cmdq/rpc.rs | 11 +++---
>>>
>>> The changes to these files look like they are a change on their own;
>>> they are not using the self-referential support but rather change how
>>> the queue lock is acquired. It should probably be a separate patch
>>> before the rest (which would be the last patch of the series).
>>
>> This is actually integral due to variances, as the existing code more or=
 less
>> relies on cmdq being covariant unsafely. Pin-init is going to enforce th=
at so it
>> needs to be updated to use existential lifetime to make cmdq actually co=
variant.
>
> Yes, those changes are related to the use of self-referential pin-init. W=
e could
> technically introduce the with_inner_locked() helper separately, but that=
 seems
> excessive and creates unnecessary churn.

Might worth adding a little bit more text into the commit message. The chan=
ge
itself looks good to me, so with commit message elaborated:

Reviewed-by: Gary Guo <gary@garyguo.net>

Best,
Gary
