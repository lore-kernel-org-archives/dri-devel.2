Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA87FF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B4210E332;
	Tue, 28 Apr 2026 13:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="MyCUtIiO";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010025.outbound.protection.outlook.com
 [40.93.198.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FBE710E332
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 13:36:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfBWT2YBFve7CyX0S2hZCaYa7aHYMHsNr3vdPDgHnfnBtSMYMNKU+H3BdcZvrW+Z5RaPo4zYh8LKJ0lzyHkphj70Fn/LcUDCXvsAReG39x9mj9OzXBL4YBGKzsg8xXcnJln02BQen8aC7OWrz56KCvQ81RZGFAxDc0G127tcy6DOnMwZGF21aPUM2GD4d1vAuqGw0oClpdCa7irjivDsIGvIA8FASA8sRYpiSwmu2ccdZrhcJtbPUVEKvf3qJPMN1nbqxtruLhc88P5XM1UHzAIRclNT/GDUwD9FK2oGwe0nkITIsdpPFWIlwfq+0iiJT3D5oiOvtW1T2fnWdWuS6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rANpO7KDVPM/BQncdoa1s801SKltJAphrCAlFdTfkOg=;
 b=sgy/mY9nX/XQrpvngMKVbs8NWz2fkGrg2bPXVhSFzd582pT08aGgHiSdoE0ZAxsdtL9pYE2P9dLi12UxBSVTAoL+dck6TDRr46FydAuVbDCGyTtARmmwElOyjtJeyrdEPvaM1SbaiWYhLgspOmg/52bqzwRabO7YOkZHc4gH2p7cOk2vu2ob8z2vPdV1f63yTgG1J1LRJsJXLWwtUuBQqZytcX5EDbJz0EVKBjvCajGmduy0u3m95GdiUejU46GJlz4u5ZzcCvCRXOc8dCWcf8/J3ccrAtanwAWIIct3JUnz1ag1fLzMqmKkeWpPUvwazSYBvYrtfVJ0XkNjIC3Piw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rANpO7KDVPM/BQncdoa1s801SKltJAphrCAlFdTfkOg=;
 b=MyCUtIiOmkHR8N/atriUxOnym8JGgSQ9A5pUXtJukM5wMEy412fb85sM4RQcWcgNuxn8psT6ZRbSy+D8XniKoIshhT7rsm29A0fioXETN1X5LWKefLLfhfBtbwr4FkYZR+aRVQ28coQ4ynQ6d0xj+kEYRebcp/yigGJi4XX3ek2fWKU6or1sX2eaQ+cUp0sh8K0nmtIyAyzALqayIHyy6VP04OCINcYHXW2EOAfazwTtnuEpjD414yLPYpoYd8msnyI17czxj69CZYXvkv5C5QrWfNLWVUm1OStxdE89vOSKJdViaOdI/Dh6XIJJSTuKnxDZNmlvQErInv5p7IqlXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB8079.namprd12.prod.outlook.com (2603:10b6:208:3fb::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 13:36:28 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 13:36:28 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 22:36:24 +0900
Message-Id: <DI4TTQIJT6KR.25V8A71BT173G@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Dave Airlie" <airlied@gmail.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot
 Courtney" <ecourtney@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v4 6/8] gpu: nova-core: gsp: shuffle boot code a bit to
 keep chipset-specific parts close
References: <20260427-nova-unload-v4-0-e145ccddae66@nvidia.com>
 <20260427-nova-unload-v4-6-e145ccddae66@nvidia.com>
 <CAPM=9tx_QJf1VNh7TDMFuaWoaZqAhte5ybADef7vfroeB5HSew@mail.gmail.com>
In-Reply-To: <CAPM=9tx_QJf1VNh7TDMFuaWoaZqAhte5ybADef7vfroeB5HSew@mail.gmail.com>
X-ClientProxiedBy: OSTPR01CA0063.jpnprd01.prod.outlook.com
 (2603:1096:604:21a::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: bbce19df-1207-4348-c200-08dea52b2630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zOYXHUOBg1CsPpyi1Z5PYeW2j6qERIp3h++NEuI4tqlxf3OVG+CScMvKLeqevQ3/wEgwxg3KeHrR8gi2iD6JlmrNo+DwC0Sahe8z5IPA4uO958Ae8f6/XnlUi2Lgpcy9uPLf8XQwkI/qkQ63pe3rLqO7fcEKxSrSD3UdR155iIaWYnNzl9gITfYNWBU3k5FhPbODUzXOLkUcD5C4mNpPFafTc5OtGSaqb5J2MGCAU3t4Ig8XtxKqtnjv0WZEk+sG8EAYqoKrMjpvKMZZhC3AtNwMH0zoeMT2fai1a1LMQ7q1Nes+s+1kbauXsKYRIyHSHlA15ZkMKaHVqmDYazLIiwTkJEtwQV9BaUcn2dmeAcXaG0d5eaK7Tw4f/ciFA9PYICItfWkLHZQGG9Yfe6AWkAxBuIK86wg5Bi3W2SUPXKCg0VZeqnFTUN7cDUiSQbzrBSge8jqc7Vm39xeZvKiQALM+7+HEr1yuH5ZG8YBJGrWzpmzYJ6bL+SJVAeqWtfcY5kZbsSPIL39PMsRjbNRyczcugr1/6VSJHy9eaJ0YcFBFqhyld+EruTuwesepAmLAr3uneDj336oux1iZCIOeJ8lEFTXxR09JEqNA6U/zJxsjDo4CiofZvipA70Qu0BU1omEpBytWZuSunQARQLr7Q8ttH2Dq9qeru4Q+bjAa4LhEiqezgMeudPq6LteW+cj6PKr8onpZqz1fZMEDkfA7lDwZk8AjcBBlq055Z1BQkiQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXVHd1dsajY3UnFCb0ZveHkvbmJtQ1ZENnhva0NLTlFFK01qaUwvZWY4bEVG?=
 =?utf-8?B?QkYzTmdLKytvWWxqUjJJUWJZS3dmbU5FMk9BUUlja2c2a1dLQ2I5OWtEaEtY?=
 =?utf-8?B?QVNTVWkzWWVQdXN4Y1BoNVJGRmhpV3lReVQzVWVrSUpjUU9NbnV5cVJiaG9G?=
 =?utf-8?B?YkZvNmduYnRSb2MrOHBpdkd3c3RPaUpoYTdwRVplcXFZK1dpcXFMTGxPL3ZJ?=
 =?utf-8?B?Qk54c3hZclRxdlFhcEd6QUxsMHZpNTc0RVlCSFN0KzVhTWdLWjNibWxEamZo?=
 =?utf-8?B?eWx2MXBCMDF1KzAwL0VabFF3VmhWcytoN1A4Mmprc3l4TDVsMmtBL0lRZUZR?=
 =?utf-8?B?RjV3ajR4VURQYWdxaWplMjhZNHF5MGw2czBLRzk5cFVBeFZVTEtUOEU1bW44?=
 =?utf-8?B?dk0xS0hCTzBYU0diUFNCMVk0Y1RqbFQ2TmVJeWxGQWc0SXd1VGRwQ0JoY1N2?=
 =?utf-8?B?bkxNM2lUdGVXM0xCRmVxUUpIbVJsSFhpSmxiUUFtV1BkN1Q0NVJHMm1vUGxG?=
 =?utf-8?B?VTlmRm9JQ3o2cEd6YmxtMnh2WVZmVHdrOHpiZHFtVHNweElRVDdmWmtSS3k5?=
 =?utf-8?B?T2JTaUt1ZTZuem9JMU1lN1I4TXR2Znh2L0krSm9STjBxSG5GU1pIQzhNNU1a?=
 =?utf-8?B?QnZwWk1HclV2ZENBUDFoNzdndHpXTHY5T1VEbjFlcFZPWXBUTkE0aVdyWCt5?=
 =?utf-8?B?WjBIMWNVTGMvZDdibjk2eUI2MWRMa29wbG1nNkhFd2VQUzQ1UE5mV3dZVjNw?=
 =?utf-8?B?WjV6VCtncUdKdGhzU0huMUNUb210VWt4WUxOaE5HbjBUeUVmaHJJQVRJbzBt?=
 =?utf-8?B?eTFmY1FYTEFEMlpvdDRoVXdYOUdhRXQzWkU3SWtSSWUzeXcybU5TcXcwZFpz?=
 =?utf-8?B?TWoxd0FGcjM4Q2lka0sxczVjV3lXK0lsNlIveXFwZWFmb1NhWUZkdTFFZU1P?=
 =?utf-8?B?cTVKS2ErQllVTm1BcVJIOW1ZK2pvVXN5c1RKbHk3dTc1TjNEMHJwNGxJRk9W?=
 =?utf-8?B?TDRvVWx6Mm05QUxSb3JiN0c3cDlwTzFoakFjaXlsSzVYclpUQklUSzg0Tnhs?=
 =?utf-8?B?RndQN0V6cFpjQVRTUzIyZUpOOGFaTTg0MFYvOHMzZTRJdU5vdXFFcGMrNWVQ?=
 =?utf-8?B?WkZDRHpjOW13ZDNYYkxBK3BWMW5nRkdzb085aGVSQWNjeERxQmt5a1RRUkc1?=
 =?utf-8?B?aXRzSUpnK1pjNkRRMFk3aG1mdTlwUUlRZ2l0NEpxeWw5a0dMbnB4OHpFWUdJ?=
 =?utf-8?B?Yk5mbGw3Q2U0R29ObGU0RVpOamRNNGhRZkMwaEVpWTFNeFEybnZIcmNFTVZI?=
 =?utf-8?B?OFBwazl3SWIvTTQyRHd0Y2kxUm9CbkNTekVyVjZQQjlxaS8rY2h4bjY5Wndm?=
 =?utf-8?B?TXFpZ2trRFZhUEpGMWtjZFBSNXQydmY2ZUdHWGhPVTdRenpyWXdSazNKai9H?=
 =?utf-8?B?RFMzSXhpQTBURmNIb29XUElzOUVhK3ZwOFVKdmpBeFZ0cGM5aWJIRGhRMktp?=
 =?utf-8?B?TUwzRHZic2pDa3B6Tm43RDdjMHY0cU9jc0JQNGMzQk4rVUt5TVp1OE9oSDZR?=
 =?utf-8?B?VG91TUJ5ODVDTnhsMDMwQnUvS3ppdkFza3E4ZVFaTFp4cHR0ejlBZTNLK0VV?=
 =?utf-8?B?dndlUnhya0VGMXc5Si84blR6dzdTOG5YeWRmMXg3MTBhN2dlem5Cdkd6VVhK?=
 =?utf-8?B?M2xyZzVVYzAxVjVWUXhMZHJQTHlQckdiNXU0WTB6T0JPMnVSWlFoV2tCR1Vj?=
 =?utf-8?B?aVZNdmx4SXBaVlE3eVNkTlRFejdYZnNBd0kxMXJCMnB5RFBDTnpDUCtscHhh?=
 =?utf-8?B?R0RLU0NXR2o1WEI5Nm1tNWhDaUtvdzhsWkQrYUR6Q1htTXhFeXJtYmFhQnRo?=
 =?utf-8?B?UW9jazQyQmh1VmZQcXhNNGk0aVRwVUVJR29WWEMrZ012TVUxdmZZSmZGbWc4?=
 =?utf-8?B?MXdEeWFKVzdHWUpGVllaVHZzaWwvVkdFV2tQZDl0Y1diaVVQNnFaa1hHQlRa?=
 =?utf-8?B?MHQwSWtzMkVkMkticG5OdUl6dFovUTFaeUh0R3Brd3IrWEVYNjg2WkJIeVNF?=
 =?utf-8?B?V1hSUXJiOENRaVREWnIwMWhxdHpXMEZjRXd1OFg0QlNMM0V4K2RSbU5GdHFF?=
 =?utf-8?B?QU9BZG8zQ0hQcitzMUxveDFuZ0FpTjFPUFROa01weHUvR3VObnlLNGU1VjJv?=
 =?utf-8?B?YzZtZ0IwdmVlbWtqMGxrRUM4Q2xhQ3NKdTFUWEl5d053WHlKSUpndnQ0U2R3?=
 =?utf-8?B?NS9XN2xDUDZUTExnVTdyNUk2WitmcG5WaFJvdGJqb2hhZktFTnVHSnB1QlF5?=
 =?utf-8?B?WktDbWRraTJkaUE4eko3enNiM0pjbk9TVHhmS0VXTHM0UXQ1SnRiME9jYnlW?=
 =?utf-8?Q?K9jrJUkc7XqWs160sIxSWSGclOysaE4EwrZugQvGqKSO0?=
X-MS-Exchange-AntiSpam-MessageData-1: Py2SOEY1Tnm7EQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbce19df-1207-4348-c200-08dea52b2630
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 13:36:27.9760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYp81Gvj9yUlq9Hsuz5jb6+bUsBy71Hcj7zqZ+AqnU8QlkE1WD8NgYrbb9x/Wx8whLqULIezVzS5Dvd5lMpCRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8079
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

On Tue Apr 28, 2026 at 4:13 PM JST, Dave Airlie wrote:
> On Mon, 27 Apr 2026 at 16:57, Alexandre Courbot <acourbot@nvidia.com> wro=
te:
>>
>> Some parts of the GSP boot process are chip-specific actions, whereas
>> others (like sending the initial post-boot messages) deal directly with
>> the working GSP.
>>
>> Reorganize the boot code a bit so the chipset-specific parts are clumped
>> together, which will make their extraction into a HAL easier.
>>
>> This has no effect on the GSP boot process.
>
> So this is something that has changed in open-gpu over firmwares.
>
> Older firmwares pre-595 always queued up the async messages before
> hitting the boot sequence,
>
> on 595 and later you send the async message later in the boot process
> once GSP is booted.
>
> I can't read enough context in this patch to know if that matters, but
> I just thought I'd point it out.

Indeed. I started this after being a bit confused that the code for the
Blackwell series had a conditional to queue the messages *after* the GSP
was booted on chips using the FSP path, but *before* for chips using
SEC2. Looking at OpenRM it indeed seems to be linked to the firmware
version rather than the architecture, meaning that John probably used a
more recent OpenRM for reference when writing the Blackwell code.

In practice, unless GSP-RM does something really funny, it shouldn't
matter whether there already are messages on its message queue when it
boots or whether they arrive a bit later. I tested both options on both
SEC2 and FSP hardware, and they both booted successfully for both cases.

So I opted for the latter since this is what OpenRM currently does, and
the first firmware we will actually support long-term will be post-595.
