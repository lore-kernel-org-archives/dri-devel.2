Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD229FF8873
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:12:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8827710E227;
	Thu, 30 Apr 2026 15:12:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="HzGo6jlD";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011037.outbound.protection.outlook.com [52.101.57.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F32310E227
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 15:12:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bow7AME3YGQovEPeoStn37OKEN2Fb2axS4vjeEvFhvtHGxpMdcTrDxKZeaa89MIZybSgMEB+E0GbwldYtgRylnwmTOUCiolpm/2yRoG1OHtWUaQd3T6X5IOUqVv9W3TdMvQVV+20Pf6HID69ce0WA7JCrYOEXsE+sx+pdiUn6rmMWigAXFErNIngi21YtT0ITZRuEDPM0Ix8paIkOO7tyQ4KvYUXNj1N+Fl6zizD6+UBfOBo04YJe62xB+UsraljEXsZ0GU5kfHIVYwfKP1V6j4cCMzELxWWKRz4uwPQzVQu2YPmJAhp7oh3V06QdhAT/+e6yzc3vHrHaPBNRD4Y9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7MxO0pW4R5Ebq0NTWVuhr74bI6vCXXyH1VGdvnf8ck=;
 b=tHAm5iBoePXGIAtgynDXDK47fg+ooZVjT3KHVK53WFHR0Byle6Eon63ry9OLwXLxlQpTc10dQWE7UITpM6pb9FTv0H6PxKHhk4olrwrr77WUqxTjMu3pDiqCdgj2/hC6CwXwiyYaaLfFTc1mrR4zEjyU2K2UsLfU3183EsRT5JFFe62/1qU+8Lk6y4Xffsf7B/Y8zZCVYVCIJqNv1Z0FhYq7fdT1cG0r5HapyRNUggLm0TQp82uSeNoj71zmwQpMCp+3cKq6z9sM/yP+s26hOVlPOmGtmxgvWp0bzDTSEwTY9o+bH9bWSqypaHy29eLa6w3GtlM9ki2Rq6z82dbVxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7MxO0pW4R5Ebq0NTWVuhr74bI6vCXXyH1VGdvnf8ck=;
 b=HzGo6jlDX2lR+fmzmonhEIxcjEhZ2LKyOUrL5CjsNGm3q/3GY7pr3UuY+y9InqiOtu5htsCGEdcUBa4aXBKvYCLBAKIY0G4LUCMkLaBXP27yTt0X7+PMmBO9O/8pFTwOEG5tkmvg9kmJu1gAdDSfGUI8JyosdHTa9i+NHpDz39ZwYhARpy6aOK3x57LKspiJoxHov0cq/3L3aSfmwaEe7WqPwkYpQaT88FZvBAUtpVOAutV88dwZ9fMFSbo+G3551ZV9qgMK0VBC4/ENwomX3Ehn9XhrsYGoDXULdMTYIN5pcjywV2euxrAIssp2F3ImSj48X0yLU7NIyHQs5u+jVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Thu, 30 Apr
 2026 15:11:55 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Thu, 30 Apr 2026
 15:11:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 May 2026 00:11:51 +0900
Message-Id: <DI6L3WUV1AX9.20T2183TYVJQR@nvidia.com>
Cc: "Gary Guo" <gary@garyguo.net>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Boqun Feng" <boqun@kernel.org>, "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] rust: add warn_on_err macro
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
References: <20260422-nova-unload-v3-0-1d2c81bd3ced@nvidia.com>
 <20260422-nova-unload-v3-1-1d2c81bd3ced@nvidia.com>
 <CANiq72=7u5O_58b6cnCwGz=j0D1tmf5+9Ntv1mkJZpACWXQpFw@mail.gmail.com>
In-Reply-To: <CANiq72=7u5O_58b6cnCwGz=j0D1tmf5+9Ntv1mkJZpACWXQpFw@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0096.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW3PR12MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: 792c5fc4-1be8-4290-2603-08dea6cad0b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 3tH0Wtx+SaKnF2s/JtX6Z7oVa5c0SPN4YCpXSwiJKurjN0QptD6hGE/9Xg9wA6pw3/FpzCYEouVx/e3mRvogEQNM0iaH5D8oK5+MfQ+HoJp6RJ/EOtEQpsB31STAnSEead/+CxE2Xud3Es0nxB4bRXk089DLiIZvGGUpakbOotKdYnykAMKPNrVMrggZvY7Ucnmvw68B79tRXXKGYnnprSXI0lLupxYATPNi+mbH0Rch+ihEoN2Bbi9qYKZga5ARfQ3peYkXiTNwL+fpEzufqb+daETBbumsfaKaw79Y41/tkDOluH29VCBveTpxNTEEAHmL1tEeJVA4hVxkuhczmgIT/a9F6l1WaHnp01hqvaBihS36Hgl2nOqhnHoFZAN1JfQCoTdbFxbVsh1L/3XcnD2iCoasEzA0+4oKadykyt5MT0v5E4Xi2uy0EpH3YFYmBZwfXU9Qc6D2zoH6tPvXLELAWRKdFBwvdo7U1V5y70MwrOvdI3+cXUViuQIJ+ibh9TR3o77CAJMijKlir5bPI+xfCKTy/pZzLMHYAHHODWSfFmYxejU7UC6YM2wrpYa+g8cyTdvzT690BestxopeQVOkOL2k1slWDim6rNTy8fHqRALeYfRGTK9lITrB2ldIa1hz+JTStSXVy8uVD0XQU17feVieKVZ6g0nQ6TUcPPcN45wT53xfkOMsns/zqcSyHsJpoMQpqN8CJMENK0qLRIDSP5C6rAEdahgvDXre/hk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU1oT0lHdCtEU1VEVC9QQW44VzQxVFAxc29RMSt4OTR1aEREUTkvenVTLzZa?=
 =?utf-8?B?V0d2NU1vYlI4aUJYdEdYWUZhSVF1MlJUaWVyTHRCMlZWMCs3MEVKY2R5TmFJ?=
 =?utf-8?B?MWw0WDVsRXdUcWNZQTUrR2FwSkM2L2xWT2NyWE5QV29YTU5kYzR6YVVwRFVD?=
 =?utf-8?B?Y2x4QjhlKzgwcjBqM2NDY3oweVJMNFNXNTdGNUhPd1NRWDdKNTlsOVJmNUVZ?=
 =?utf-8?B?eGNsKzYrV1lsYXlaZndtd1RzS0JzLzVVUnRZTHhZOHhpWXF5V2kyRUJodEJD?=
 =?utf-8?B?eGxOVWQrSlJxUWVTa1N3MEVSQnNUZ2crVzA3d1ViTEJ6cDVFQTh1WC84OVRp?=
 =?utf-8?B?b0dCWGs5a09TdzBhQW44SEJrQlBWbnVOVk5pcmVBVC94dHdVNHdxYUl2L21L?=
 =?utf-8?B?MVh1Qzd3K081a0FsRFRYeHhBTlUrT0ZKUmZvdlZET0dsU255YVY0cWRmSEJ4?=
 =?utf-8?B?TUExSFAwazZhV1BsVy9BdmtBSWxHSU9lZHdpWnNOamJLWnRRWEZka2M1cDM3?=
 =?utf-8?B?YnlpS1V2T3RucjlwMzQzYzRlQzZlRGkvd0RRK3IyQ1o3NVJ3NVlHWW1qSmwr?=
 =?utf-8?B?L3lJTFZ4VkRNcGs3RTVjekYrTU5RVmhYUUlPOXBVV0Y0bEY4b1FQeDhJMExu?=
 =?utf-8?B?YnQrZWpKaFJ2V2VSQklkMGd6YitNVVlrWTVnL2pwclU5cjJCbmdNT2V0eEZM?=
 =?utf-8?B?eHlyTFR3M1d0b1F6QUM1MXZSaTVwanBYNWdHcWZtRGxHS25hUy9COWVEcDBB?=
 =?utf-8?B?d2grZmxGMXB3U1FDVWcwQXpidUY5WFFZSFVkL0R1eW93K0QvUXpRRE5McHN1?=
 =?utf-8?B?cGpHQVVOQnJEaGtGVG40a1BaeENSRk0yNXVsaFB1cDRIa3hSYTJZMGVxTFoy?=
 =?utf-8?B?SmRpbVJKZWJoRGxMRWxPWFZ4S2syOCs1NTduejBJVFlBNkEyZXNPYjNqQktI?=
 =?utf-8?B?NDdpaFFHUVk3WnAxakJaWjFwNWpPSXBnYWFvYVE2eFppcmRDUEQ4Z1BFbGpi?=
 =?utf-8?B?WW1qZGU2ZytoQU5MbURzUCtiT2RBR0FuK1VOVHlUU1ZwSkdlTEtZZU5YekUz?=
 =?utf-8?B?bkhNaUZtMTRvM1k0dHl0U3d4WFBLK0wxclExR2NyM3R3RWgwNW4vVU1LVG95?=
 =?utf-8?B?TitxNlNpTXl2dmJXWmFOZ2pQWjVuSmhhNVpuVW1tWHo1THo2K0pITnJHNlZ5?=
 =?utf-8?B?RXhmK2hjVmdQUG02eWRuWDBoaDZjRnR1U2JKSkhqeThhODczUkl1N0x4MjhG?=
 =?utf-8?B?U2V2WmwwaWVDK0E3Rnp1Qmtyb1dXS0w1bHVncmdNbzRjOUlBSHU0Nkp1cHJS?=
 =?utf-8?B?L1ljbkw3ZU4xNnlHVlk4VUNyZFB3R1RGZG9LNnE5R0NxU2tUblNmUTN2Y3Q4?=
 =?utf-8?B?Z3FsZkRTWEVhdlRPaUQ5UUZDNC9iSURjUlNiOXF1VFEydjU1MVFsUXNkbG80?=
 =?utf-8?B?Tm9nK2dRL0tKN3VJV1MwakdxQnA4WEF3TEx4bFdQNXlteWxxN2dOaVNoWHhn?=
 =?utf-8?B?WUk4dmIzdVljT0hIbVdsK21yY0tWNW1iUUJiakhJYlVDWWVuTFlSZzJYTnFU?=
 =?utf-8?B?RytnbmYzRlJuL1VlZTQvOE1GYUtkYm8zcjBxMklxQzNvcVhPaENOblFYWHNZ?=
 =?utf-8?B?aEpsejF3VmlJUzJ0ejRqbEFjTEUzczUvTlBLeXJ3UVc0ME8xUW5yY09VUmE1?=
 =?utf-8?B?QnROV1JpRkdZeTBRMG9abEc3WU84TDErRlBPd3dXZmYyRmJpdVRyNk1yNWd2?=
 =?utf-8?B?b3Arckg4bjhGN1VhY3NPQ0h6bXM2YUNHdEt2YlMzSVo0dFFNUVVDbnFsVnFJ?=
 =?utf-8?B?TmJzbHE5Q3VNdndlZjRlZ3UxeTdJVythOFlPUFJQenIrQzZmellscURTcjFV?=
 =?utf-8?B?anZkZ2JQY1BtdVJUVHRjelNXVk5MY2twaUtzbFdjL2pHc3EyQUdURlZLKzQw?=
 =?utf-8?B?WjZRdU5HU2hQc0tMVkRMMzVaTVZlcDdtWnJvdkFDUE9NdnJyTFczS3lqc3I1?=
 =?utf-8?B?Yk1sNVRtaVJJYXlNV2t4Y0Z0c1FoZkRpUDVWV0xkTW9RTVQ0ZDBTTTdvVTh0?=
 =?utf-8?B?Ky9EQVRjTHJYRUF5TGdRNU9wSWhCbFVQWkJ5ZittejJOV3dLL08xRjRYazl2?=
 =?utf-8?B?N3BQd05WbXdpYlM0UGhrU2JpSjAvSnJMWjRFdXNsTUNRV0gyakxXYTJKWDRx?=
 =?utf-8?B?OVEwMTN2U2pvVHhnSURMN0VwOHdPbjA5ZTUxV3V1Rmo4ZTdDNDQxRjlmUTYv?=
 =?utf-8?B?ZkVNTlpuem9zSlFsSldOcXNDQTlnWnBFMmU5K1luYlhjUDFEbE9OZDJobFdp?=
 =?utf-8?B?eWR2ajZQUll4U01remtzbWZxaEtMSWt0UFl1ZEhhYk5VMzZ2V1FRQXJkR1VE?=
 =?utf-8?Q?/pE8LKl4dxPB+LRw+ESbBw/z5+aSoF+iLAPrmlZHnsSm1?=
X-MS-Exchange-AntiSpam-MessageData-1: oAl6fDrxrClMEA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 792c5fc4-1be8-4290-2603-08dea6cad0b2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 15:11:54.9974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emUTgUVG/7l7vwRyd6rVPg2tuSwNpumuVLc6JIIQC4SzyDejGvvt80Xt8zxnj9gvKHsbSLeFkyZpcfYq1Y41NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491
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

On Sun Apr 26, 2026 at 10:30 PM JST, Miguel Ojeda wrote:
> On Wed, Apr 22, 2026 at 3:41=E2=80=AFPM Alexandre Courbot <acourbot@nvidi=
a.com> wrote:
>>
>> While we already have the `warn_on` macro, a common usage pattern in
>> Rust is to check whether a `Result` is an error. Add a helper macro that
>> allows this.
>>
>> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>
> I saw the discussion with Gary in v2 -- not sure if you are still
> putting this in. If so, and assuming Gary is OK with it, I guess it is
> fine as-is for now, but we should probably create at least a (good
> first?) issue:
>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks - I will send a separate patch for this shortly, and take it
alongside the Nova unload series if it can be reviewed quickly.

>
> Not sure about Sashiko's report -- it may be nice to make the macro
> more transparent, even if it would be rare to use it with expressions
> where it would matter.

Gary's proposal [1] looked good, so I think we can use just that.

[1] https://lore.kernel.org/all/DI1IQE7MDV4O.5B2DVIXMX2OT@garyguo.net/
