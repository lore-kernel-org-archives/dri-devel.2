Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B03CD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 14:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B47410E1B0;
	Mon, 25 May 2026 14:11:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="UtqdYxiu";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013001.outbound.protection.outlook.com
 [40.93.201.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7724C10E1B0
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 14:11:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOBOSvRt3YPjHFzHA+Ikgf+VBVwgNVre7HQD2OUnGgKrlr3ANQkXPCsSl25fbANy/5TuuHH6AbLWyQhzeoGuYOioFSRWxNJiucsohJc3yUxsj+CGOxq/AXlSgf7Y+303jWMRiCccpV8428Jod91dvbejwZOc9/eBhJN11M3fEnuY1HNUWGw1QgBeph1up5iPU6IQTF8phHpHQ6SBcQzpm1js7WAOJW1/5iwRUSHCqFapcuUVYaG6il/1YTeNIDjOnDWa1dU07gcoLsbXlRSKlX7w8sVKEXQG9uvgaozj+0ganXdLce430OGSQWZwJI6v+Ao3TMlGShUo9VjK5KQGoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBfgzXRF1K1Rl0Ao1TNh1/5ShcpP7tDAx6Co4GUXayE=;
 b=motM9JLFU3ScczXevbYTvq17FFgwrdIVMUiT1/vNpESyUNjmPWAWn2MpZVf3bZL/izXKnlslBlyZ+QD7fs+i+sbHS0iY6g47KAeSO4862QjRwy0Jgij53C6KaFQ+iBad8vnQphgI7IdQfm9LeRD355wia1uFnLirOb9kjmAmH26aixt6rhJMCNr89tpHOgTLsnIeLCAqIAmDeHxNT6Qy/MvuBtePsfT4GmjLQ1ssePb8GjACMVGlyiJII6o5ijkplzufkU7aVTdZ3zW1Eb3V6fYB7tCPYyOMu6928fIb06X7W5gej1tDIgGTa3EhEZvZPyboyzR4q4q88KArbkTWQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBfgzXRF1K1Rl0Ao1TNh1/5ShcpP7tDAx6Co4GUXayE=;
 b=UtqdYxiu57/x159gnI9TWiwI+D+cwSJsa5yIYkN0WTnMg/IyeZs3ECIkwAJXXnpbL8r9jzxlbZ89Uqr4xtUH8fmj/vhezXuzjgYkw6wm5pjCV6zgCewJNF2xcRfZvxNiRQMihow8ZO5ClU7LJWu+eIvu4aMKagpr2dEuE9gbwKExMxLFcCCi5WPluT/2ZYyY/WaAzdJ8c4NUZ+t6bMDQ40a5IeW/x11ImauvDrPAgn8rGFlFeQ+kSSuGwt7DrLcQgaQPekWSWygiHAnVA1QhLX0NuEhCnwiTmLxmSwGDUugjtEct0UIi7RINLk581VJsNhAuZ5akwfQNj9NOnhirog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY3PR12MB9630.namprd12.prod.outlook.com (2603:10b6:930:101::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Mon, 25 May
 2026 14:11:16 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 14:11:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 23:11:11 +0900
Message-Id: <DIRTH36DHFAD.2M19V1H6FCRUU@nvidia.com>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <aliceryhl@google.com>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v4 20/27] gpu: nova-core: separate driver type from
 driver data
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260521233501.1191842-1-dakr@kernel.org>
 <20260521233501.1191842-21-dakr@kernel.org>
In-Reply-To: <20260521233501.1191842-21-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0108.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY3PR12MB9630:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2b0498-5af5-4450-605d-08deba677c45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|1800799024|366016|4143699003|11063799006|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AuELvSdBWQgD9A0P+3RchuDjG7iHhg5DdpbETQK8obe+r47+mj2OELM5Yyo9hrb12kJeI3Uoc5LhN86FEXIh/wMdJ4fTt+fT4F3Uou7sLRswtLtqcLKsGG66ojAKolHz+XncaKiBJDuwUcqjmsaMOvvgUNrKhqQhppuItadBo/vjyWoyM7RCag5zGcm4xCFYJyveaSnIw0Fi9OE2YMjJZfpSx6dsNQHReMk8lxt7QY64JX9gZ71lUl0XAxgZrVpgaUTwQHGlhVC3g24gjHIHQzo+wYAdeByXOTCT5/UacgB4HupAgdvYccFvU7w1+MsUHjiQoM1I9KhyiOgEp6qb0Piy1zFhyhKm4RRMhF588bylYuW4K8rhYSU56evxH89o7vLRZEXuITSNqDoXisf9BqZq4OVn4c+7qyum5NztslPYZTHd3iFYpYukLmJtnsmUVtELZAn7hLLK4mNOoa/KnPbby7mBJ6yRFFkV5bcgYnajgiRBLLIAEEVC2zhy5aaU8j360YTBnJjXeM4irJX8RUq7f4nejgRbsjfqsxzgZCAgFhAIyQX64Pz6LpUEkM/1il92p9FxbPWlUaIDYgzFBZxyU9FvIXXgCRBI/oYt6lQK1RntO+lmC6UqGyKTi9unQTk0ImqqY/M3OM+PvK99FOyX0cuoxTPJoSnRVJyRoB84sUXD7KwKIaH82X4igDzm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(4143699003)(11063799006)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ti8zYjM5VnI5T3ZEZ09WU3VFSm5aRE1HWURoL2RBMjliZUlUdUFZTmx4UEx4?=
 =?utf-8?B?SFA5dTcvVlVDV3B6bHRrcTBMalltQitrendhcGszSXJ3NEJ2bWlvUlEwOWly?=
 =?utf-8?B?bXE3d2h0SHZic0xiQnRkd242aVR0N2lvQTBwNG1IT0ExUndFUk13VGJHTm0x?=
 =?utf-8?B?K0FVNDRSbVhXOEs4TDJKa0RaZE01MkladTRORFVsSS9JTWpzeTh0cjA4YjFO?=
 =?utf-8?B?K0NUaGU1QTVDM2k0R0RsbGlablZkQ3dXSTZINkJhM0NPS2FZY0RwMHJQcTNW?=
 =?utf-8?B?Y1JnbkdTZWdZcFRVQ3g2WDBvRVJya1BxT0s4Z00yRVBQOU0wRWdpcEFyMTEr?=
 =?utf-8?B?OTNzQXJ1QkpGZzVvZEZsR0hzSW1seEhOTHRCanFEZWFKNmQ4cVJDU0NOSXQy?=
 =?utf-8?B?Q3cyRlVCaEtyeDQ5ZDl3YWxPakl2Y2ZLMjZuMkNYZjVQN0dLZnRnckRkRExi?=
 =?utf-8?B?enpSR05VU2E3S3BtUDJzYXVRUjJCU2ZMRENrUllWUHBjOGljWGc3dFBSRE5s?=
 =?utf-8?B?WDNJUjBKZWdacEhrTVRQT2ZNbGlKS0FLRDZvR3ltZ0J5ak9xOVlOci9NdDJW?=
 =?utf-8?B?cmMrK0Z1MHkxbkhFYXdkeWFXUXNpWlVqUUhaT1MrU0FVL3IyYUhYNGVua25W?=
 =?utf-8?B?aTB0TGxtWXhtaXBld0lYNWFFaWRLWGFGUzVRVk9QOUlOTmF4NGdseVpFcjFP?=
 =?utf-8?B?clcrblVRY1VnM25CWDI0dEpnbTY2Rms3aEZqdUVKRjBUOFBoRlhXY1NWZDBl?=
 =?utf-8?B?cUxGREUwL09ZNmpXMUR4OHl1cXozTVgyL2t4bldVTmFmK2Vjdm5oMURKVCtB?=
 =?utf-8?B?R3Z1RnJaY2liMHZxeFJTTi9pYTBpWnpPL0pXaWFYaVZwMDRIell5M2FJU2tl?=
 =?utf-8?B?ZHFialdIVnVQZ00vc0d2K015Y29Jc244Wm83R0lzOFNkWDlPMUhzL3VNUEp6?=
 =?utf-8?B?RUJYaFRNVTZ0RGJlMUp4cWEyNWpaZ1RkY2JlUkt5Ky95S1RjWjZ5Q1JaVEZX?=
 =?utf-8?B?MUV1UmV0ejg5RDB6NDgxSzBjVlFJZ3dkeDFQMEdMdzR5bVN5ZitCZnA1dFJB?=
 =?utf-8?B?ZzIwYWlpUWNCVERHUmVKNjlTakZkSnBPbnJ6V0pOUkEvSk13VnJ3RENuY00w?=
 =?utf-8?B?ZUhqNXNTNHA2VUxLYW8rMWR4cERBSnhSK05MclRiZHljdld1TWRZSXIwV3Zh?=
 =?utf-8?B?US84VEl1SUZWbGZLRHI5eUpWTW5IYk5SbEszQ3ZEaTZhWk9lVzZOUFpqQlFq?=
 =?utf-8?B?dHByQVUwY2IraGJ6Kzd6UDVWdnBjenJJOGRBeWg1emhLekRZcTE0czdkWjJm?=
 =?utf-8?B?cWFzV2JXTUU0dGx1L3ZienIvL2JRZHB0ZU9IdzF1MVFxSGFxanAvOTRkd1ZT?=
 =?utf-8?B?NThoL09OU1hsdW1CU2FZdHFMc3ZNL0VsOHZ6cmdSaG4zQi83Z1hGS2dJaDV0?=
 =?utf-8?B?ZkNMWjU2ZHltZEIvMERvbVJZVjJSd3p3Z0VGdGRMTzlSbVpIZVNvUlpST1lR?=
 =?utf-8?B?Y21PaXR3VmFyaGY5MWNlejEwbEljdXhxUWtkMCt2Zlh2UTVJcExpcWRYZkNC?=
 =?utf-8?B?bk1UQU1YV0REbUN6d1hNK3ZmS1graXl1dHpHYk10WitwdFoxb1ZQNnZpZkdQ?=
 =?utf-8?B?ejNQb3VPS3U2Z0l4d0I4NWhodzhOSWVUMFJKdEpMSks4dVpNOVFaNTRVUzE4?=
 =?utf-8?B?QXY2SnowNExNS2J0YTJtVkI4S1Fta1U2UlJ2UkhoajBsNzZrOVFMenA5OWFD?=
 =?utf-8?B?UC85R1hZYkRMM1JPZnFWOVlBNWF2dklHcm5aTkxWSFJkOEpzajhxZjUyVDM1?=
 =?utf-8?B?alVGcGlyTE43Tk9sUk03UHJCUjY4OTE1T1NWeWd3V3lhdzNyaHVOVXE5NGQ2?=
 =?utf-8?B?bTBuNkkrWXBSVWJGbXVNSzU3T3hzYWRpSVp3UVdmdnM0YklWR0VBeUE2Z05K?=
 =?utf-8?B?OUhVdE1GOXM3OHZZYjBlZUJkbngxVXp0NFYwNERQZXlrUFNPNWtYeS8vcGFk?=
 =?utf-8?B?N0k2YVhVNDZuWTNSQ0RrSHNjVlJFdmFlbVNPb2o4emx4R2xJcDN4M09PUitj?=
 =?utf-8?B?UmpvUTNIcklTaGQyZlJmVDZIM3Vyd0xGazRWdHFSL0wrb01vNzZkQ1ZQa1Ry?=
 =?utf-8?B?aml3R2s0QVlyNDFBWVBWOTN4UUJIbHl3SXdveWdBQ0F3WDEyV3FiaXkwQS9v?=
 =?utf-8?B?RFVQckpQYWM3WURxbStoKzN5a2Rzc1NOdXlibzNBRnI5UFR2RG1xb1I0ZlhN?=
 =?utf-8?B?MHE2b0hRVUZSck04M3ozbFBZcHo3ak94MDZYSnZJdmZXelFxbTRjeHlmR21R?=
 =?utf-8?B?aTFtNVY1QWl6bnU2V25VNXFuN0txUkpKMFFleGxoWms4T1FWZXFLMng0dVlk?=
 =?utf-8?Q?gb7DKUxgjoYbkCczskb96eCgjp7mImhP/5Q4wi7Rlbs9j?=
X-MS-Exchange-AntiSpam-MessageData-1: eCKUtxrQ/Gag6Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2b0498-5af5-4450-605d-08deba677c45
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 14:11:16.4550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHWCca9tm5nK+dHg9uDodWbfAK5k4dPizGtkPsLBLESQOW2Xqkh7alFIvbizjPvxP4LsWgN7KMx18N7WI2jZGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9630
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

On Fri May 22, 2026 at 8:34 AM JST, Danilo Krummrich wrote:
> Introduce NovaCoreDriver as the driver type implementing pci::Driver,
> keeping NovaCore as the per-device data type. This prepares for making
> NovaCore lifetime-parameterized once auxiliary::Registration requires a
> lifetime for the binding scope.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
