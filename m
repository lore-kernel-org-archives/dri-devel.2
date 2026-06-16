Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25023CD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 14:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AFF310E78D;
	Tue, 16 Jun 2026 14:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xruwxpdq";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012033.outbound.protection.outlook.com
 [40.93.195.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABF5A10E78D
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 14:22:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rW/f3Xltc7fPWll6WXMZ+tGyqoWyJNl4ooqqG03Xhqg2SKfimvzIN7Jd6C/NJ70nNwwySq6LwonZW60CPcAtTkBzwiGLXCdMIyAvwKeaV/yqE2+4uZdQj9Xf2CsWyPgHKjP1d5TWsEyk5BOjqvG3Vlrq9sJnMovYKqUfiT0pQSvtaVGAC1QcG3QGmunvVNSMfFeZoocCBuXh/fyKqAoV1U3lXEfueBa57PXuW9c0ZszCA6YZ3KZZu3OPryLLE7WsoBbB9uRXdjMbQj1TMwWd3i7wb4fuoXwhJlBbdnme0xAHkZcE65nPc1TPIDU7Aj3Tc0xKOnNc2nvrYwBpYjx+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwodW0l+JAeOkZg/2wCVfjnxhrOiY1U31XVdNN+R/l4=;
 b=CXzIbCflgue0JtevReaUkYGU/19FFm16rlqhdgGZjM3CvXI/Rc6FKNgziL5ei9xuhdsA9RPydCZzmFwPq2yLBfVhOEsvM980+7MUn59RyxSSWbhT+wS7p8gKy5FwsCwq370Vg9KgP/3PJr9TMioRZoun84hgXOdlX7kVnUNH1cbmJTGPH2PxDcMVEOObEmldJg1txA6tFkTaUduL5FBFuSeQ52z04+Z0Xbx0bfJM0ax/PqcH34cHHivAdpD6iUabJcTP3kZvNW0Z7WGOXnaMSY2DiSZmUkOPh4+6ms6XLQaprFigW77+NUSefV4oeB95WrjN6dq4rOC+wq0WnFyWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwodW0l+JAeOkZg/2wCVfjnxhrOiY1U31XVdNN+R/l4=;
 b=XruwxpdqeaNypLTdbmPK25ncq5RGMdwo7mf4JZs0FeaNyFnG8z57pvEF68Zspvw6RZwT4tJt1iTL61DQH89gbzkdzno7o3FgteYg82F3RNLS9ODINCbljZ5cyl5A59q19P5WnJjG+bqrI+Js9fzEf00ZCltqZnnZ1RK9zQLpX7kp3tmlKv4P6ZsLzW7wtSTlND/NqWCeL/5VmBcaZChRDo8IE8kFW+o+Oy9W6IQscopk31Hfx9oCbjPy7GT1yhtY3S3HRBuRwwvazEjDJyql9hdXOIg9omivC9e9TIETqrzHuDTqX1QSpcqsagNte5v1jMkD9rHi03lvRJk3EDQKrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Tue, 16 Jun
 2026 14:22:54 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 14:22:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 23:22:50 +0900
Message-Id: <DJAJHZFVM1ZM.1MHUSVR891RHK@nvidia.com>
Subject: Re: [PATCH v4 07/20] rust: io: implement `Mmio` as view type
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Danilo Krummrich" <dakr@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-7-1f7224b02dcb@garyguo.net>
 <DJ9PI9NEJ92T.3D0E90RPSCXA2@nvidia.com>
 <DJ9PXYB91UDG.3BV4EJJ10RIC4@garyguo.net>
 <DJA1J6H6Z6CI.3LLUM4T35FXXK@nvidia.com>
 <DJAFGLBC8WQY.L3P1T92AFN45@garyguo.net>
In-Reply-To: <DJAFGLBC8WQY.L3P1T92AFN45@garyguo.net>
X-ClientProxiedBy: TYCP286CA0374.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN2PR12MB4240:EE_
X-MS-Office365-Filtering-Correlation-Id: 996fee0a-08d1-433b-d827-08decbb2c10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|366016|10070799003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: fTwQUs6jX8QQmsrPOY9RtpgmDQHDakvxmdF0p6efAYGxQ7gyM93XrcLZ390Xz2SuJ4M/ySvkZ2D2JBUZddAJgJqJQ8hmlyhCpafbIbS5KPNcncmVGBDSu7QgHMeLzWCoZ9FfxE0sFkDHA1rWNFumkgSWUzjGRcMgLrDGKv5usHcvAUbS7KnEbnQg5UBH4503AfsXv6ftjRBRbzPmg6RN9rCdmov6SdrsPNO5sJMjC/YvpXoOT31Uq4e5ExVAxZO2xXon+H8X9tTN74VrYPUkYu/8Wila+JrRqF2lo5la/JfN+PsUnI2qG3fzA8cahAVnlNaaCg86yu/6xLJGdI2Kk+Gvtbeny1iqqEby4IWPRUi8k27ohPUN0RKrQpe2gUgJC/s8Zcxe9IRPnS0Ud1A0BCbFRCYeife7gLyAfgDT6Y98iQUnRWmGpCvN32B3nCw2cJQ0aT6UQoSTFHpgrg2tMHRgzcZWyeEJQgx92iqUY1dhG3MKoeGbdL31F6J0S8jB3JTrOSA0w3L0FJRk9builA7j9d12UleJTgqyGs8bACIkHv4vq//iEUxa8Ka5krCCtOwLMjOTlAqdj0bCKNlssJflTmZSjvRYF/ukDBhuoa2+TKEeTqbyisPp63mgr2ZLfqgKGqynLZJ2WEwLgGhwt9megL4O4SDBLwir83Wh7U6/QSjkxwrmziCRFlxKpXQ3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10070799003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VStDT05iVTRuVHBvVWM4SitVZnJGUlJ6OFNDQ0x2OFE0anV6eGRpSWJpZ0hK?=
 =?utf-8?B?S1RZWE1IbWF6VzBMakZRK0pmT2s4bTFvU2hiWjUwYXEvdDFvQmdsdklvRm0v?=
 =?utf-8?B?aXU4RFo5VS9yN3NZS09oang4cnZETHV3NkRiK2tQUG11VlR6TzREa0ZNRUs1?=
 =?utf-8?B?blZSTm92dnpuNElEUEZxZnB6d3FFd2hKZDVwSmtVYy82aEVPNjhvUzNMWi9V?=
 =?utf-8?B?cEdCY2lTRGJUNkh6ZEJ3T2huQ3JDWTZwQ0JCa2t6QS83SGprNS9FYkNFOWxq?=
 =?utf-8?B?Z3lpbUFsQ3lSdTR6RklwVW1ySG5zdWIzR1JtUU9lYlR6Z21GbFNsRU1aQWQ0?=
 =?utf-8?B?R3VtWW1VRjVZWjdNRjEyalpJbFVLVk56Z0xvK0ZzSmo0SFErcnlYc1V1UVNl?=
 =?utf-8?B?YmV5UjIrRWhGUlRGME1nb1VMa2Z4bXN3akZURW9XOXYyZFVQblFSZVQrY09U?=
 =?utf-8?B?Y3MyYVV6WDdXcThULy9JZDVVcjhFbDVjRFFheW9MRnR3ZTNIbExOOHZJeGhu?=
 =?utf-8?B?Q0NHbDZDRFN2aXVxZGVQVEt1b2RSbC9WOTJNUURRVGkwZFZFcHdMYmd2Qm5r?=
 =?utf-8?B?N2ltMTlYRkhOSXo2Uk5rUDdrYXkwOGwyRTQ2WU5sZVA5LzBEenR0c2tBUjdU?=
 =?utf-8?B?T1RHbUFyTkFIUUZxUGo5N3h3TG8zOTBCSjMxcnJvUWRJRVRxMktmYXBUenl0?=
 =?utf-8?B?QjhxYjdYK3l2NFNrbXFpVUVvL2ZNdHNjMXE0OTdHZTZKeUpaaHI5aWorcXVU?=
 =?utf-8?B?K2ZzWC9KRmNFbkFqMGg0aFV4ZDR5ZDVaNmZVL1doYXdPZ0ozQi8yeXl0aTRs?=
 =?utf-8?B?a1cxaDZCL2lPMmt6eUZXMm5HRVEwWGw3cW4vYXN6MXhiaVRwbTgrd2JvYlZJ?=
 =?utf-8?B?dHo1enNEQ3NlZk4wVzJISUszemJIUU5RQVpjckp6bHNyU29hMG10NktqeW1B?=
 =?utf-8?B?aUE2S29zelQyaU9QT1k0ckdid20yTk5FL0xxNVF2bXhoSEsvb2hhbjA3VDgz?=
 =?utf-8?B?WmRLRWt6NWRlaVMrS3V3bGpicUJHbDc1RCtGdG5oWmNBUXo1bnMxZEpZSjZv?=
 =?utf-8?B?VGlJTTN5WWhrL2hEQTJIY3NKNk5IR3VOejdrSFVJeUZvVkprd2NrUnVEejdj?=
 =?utf-8?B?d3pWZ2NZZ2dMKzRYeTd5MDRlWWs4bEdWZ05UdVRiVllYWko2aE5Qd25PUG9h?=
 =?utf-8?B?L1pkUTlCdlRiNVBIeWhHZU5xWFdHakFDTHFUTTBQQURlTGpONmhEOG5QN1Uz?=
 =?utf-8?B?SnllRTRBeW5oS1FxSWc5RkxTb2JldlpOM01pNVZBN0FveDI3ZlBQdXh3US9R?=
 =?utf-8?B?VE1ESnRDM25HN3VKUFgvN2FGdXpUYkxDcTlIL3RPdFo3N2pCOFlRNVY3ZWI5?=
 =?utf-8?B?Q1J3RWxFNWowekdvOGs1UzBscnp1OW9vcXBYbjhId2I3VTV4d3NnS0VZR0FY?=
 =?utf-8?B?a2F3T1JQcWozbUlQd08va09uWTJRTER4Rk13eFFDZjhEcDkxVGdVeDd6NlZ1?=
 =?utf-8?B?dGdzUmZpWGlleEY3QXhONWQzdDNReDZJczR2ZjdFZ0tTeU9JYXY2TmpKUFlu?=
 =?utf-8?B?eTV2Qmoza01QeEFVUzA4UC9qMWE1blFrV0lnWHNuZ3VLYWlwL2FwV2pDUEdR?=
 =?utf-8?B?TzJrN3lYY1h1d3Z6c1pRcEkzbk13ZVRFSU5BRnVWYk00alFTYTFnbXcvaU93?=
 =?utf-8?B?VHVyY09lVnBZU1NNbWIwaXV5WHdmelFwQmQxQWp3aWhQMmdhMGh1dXF1MHJm?=
 =?utf-8?B?Q2xueDZkOGREM3NNQzZNSXFGUnRaYWNvaWgzaEVpcnFjWG5Jc2ZFRnZNcUw2?=
 =?utf-8?B?anVxV3ZsampKdEw4ak1vVnl0MmllRTR3TmdmQnlwWkdNbDVucDY3WjBxVVhh?=
 =?utf-8?B?Y2xnMjROUWVqU1huOUVucFlJNG0zRVlJeWJNcnZuK2JiRWJWL3VjUzRGejRn?=
 =?utf-8?B?QlJ1d0l1THhRR1JlMFJVYmpYcThTaEZkZVRZNWM3N3kxQlltM1NGZ0Q2WnZq?=
 =?utf-8?B?NjQ1eTBvczBreUlucWt3bGhPdVNrYW8wWk1zamJjMkhoc0JhTW02cGo4L0R5?=
 =?utf-8?B?TEgxSVRnR3QwaktGUzB6eHRMQ052UGNGRVE0eWZwcDAydkJFMU5MOThCOFp6?=
 =?utf-8?B?dnZ0VVIvaGM5NWZLcmJyYWhWb2FVbk1tbGpNSm55N3UvSVhvR1M2K3NtbU9V?=
 =?utf-8?B?emMzUzlEa290dmZMM0tERkNvRVlIWmIrN3BKdWtxRDB5UG9uVUpISCtFd2JV?=
 =?utf-8?B?MTRWRGc2ZlAvaEpVTXZhU1A5clozNUVzbExqS3NyRUxOd3lpVU1GRTlZUjFk?=
 =?utf-8?B?eGF3VERaUENaNmhHWjRsWExJcC9oZHhMa1ZkR1NaaXRqTnFYaWtKMDNkWWtr?=
 =?utf-8?Q?bUaqb+NM8rIGTh9zkDKmFpV3WwvpFnDrBIsgyU/+5u6GI?=
X-MS-Exchange-AntiSpam-MessageData-1: K3AsAwgvlRoceA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996fee0a-08d1-433b-d827-08decbb2c10a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 14:22:53.9169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIDgzyBdpYGI8QkUovhAePg5gnOsp/KBQLbZKyHKz5aDJbl+TGCqfpXSVPal5Lf/sePoq7d/HmvVf7UOK3BH8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
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

On Tue Jun 16, 2026 at 8:12 PM JST, Gary Guo wrote:
> On Tue Jun 16, 2026 at 1:18 AM BST, Alexandre Courbot wrote:
>> On Tue Jun 16, 2026 at 12:13 AM JST, Gary Guo wrote:
>>>> Is there a reason for not just declaring `RelaxedMmio` as
>>>>
>>>>     #[repr(transparent)]
>>>>     pub struct RelaxedMmio<'a, T: ?Sized>(Mmio<'a, T>);
>>>>
>>>> similarly to what the original code did with `MmioOwned`?
>>>>
>>>> I tried locally and could build. This avoids declaring `Mmio` and
>>>> `RelaxedMmio` as basically identical types, and lets us remove the
>>>> explicit `Send` and `Sync` implementations. IIUC you can also reduce o=
r
>>>> even remove the invariant section as it is enforced by `Mmio`.
>>>
>>> This is what I did originally, but this would cause duplication for
>>> RelaxedMmioBackend, as now you have to do
>>>
>>>      unsafe { bindings::$read_fn(view.0.ptr.cast_const().cast()) }
>>>
>>> and the `.0` causes the macro not being shared with MmioBackend.
>>
>> Since `MmioBackend` and `RelaxedMmioBackend` both implement `IoBackend`,
>> I think using `IoBackend::as_ptr` in the macro should let you avoid the
>> duplication?
>
> Good point. Are you okay with the following diff?

Yes, that looks great, thanks!

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
