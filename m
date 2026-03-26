Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050D4109E52F
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 00:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57EBF10E12A;
	Thu, 26 Mar 2026 00:39:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="WNjdE0PH";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012002.outbound.protection.outlook.com
 [40.93.195.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4107D10E12A;
 Thu, 26 Mar 2026 00:39:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rEG2unWYNVgTSWxyZXBUiZnRmcnEnfD3FzEtiEtTKXN7VoDNtrPdiZj4EyyPxj7JDLJYW+Eqq0yCUvdNw6Sd2EIxjfIsZ+GzlIb3ixWP2Squ64hDCzVhXvgnNUoDtdNsPYAfNh0S57DcfX5NCBHXpuPRcOd1wkGmo6Ww3niJOoZOyfyX78FSSQJqh5Awszre8hY+/Zf5EK5NLHNrO+0C0s3AgWmOPl+JZrAytvHLLsVsg4ZAY7OSb/DcRInf0If04+TusM8amF6yl1hkq++t01lcYaHFl2hzfviUmYuDBVNSREzi3lhtTpckUm8zRojwDnsAa7MreSFFtd89bNj8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNciqP93IVnoXxKIO9WvN/fwJ3XRTgH50+1PZuRMXUQ=;
 b=aC81o82TU98AqH/bsy8gYuhYl4od6xBXuJqTueRL7IS1+WB/q+hQpfLQ03bQVfUFcUJ9M0dXsJszV1338jSdLpUXj8Dsg/xpUVGl7EaEdskRoiCxD7T16Ae9f3WSVc7bFIyabF77Hg9FOqCTqxl4MFrtAmAvZRDAdjhAum1PnQNkzfZ5D2YwaMFItbL3uwSuW7jeHQ9Od0/+HvzFtpgdiYOXAoRK51Q+OK8HSwf28eHjmKfBDY7h6QeGU+xy1yEQFHmzbLUNsHPtrOW/budmIuMlUsmgqesMnSuTy5wb2lCtLnW3STN18DKz02TXlbk8JBIoKMkveCVYe4uUj2e0qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNciqP93IVnoXxKIO9WvN/fwJ3XRTgH50+1PZuRMXUQ=;
 b=WNjdE0PH1GFSxcJbbAHurUURy/yMupXXaB6zIENmien7rSIJW14k1l7DGxkDU3EN1Z/cO5NHy8xHMIex9HiauySFWh+IgEwGHuIMbtCn2S0bNfX+83OoyGPL/v4bIHWTsL2TX+0MZM8GIllYaVD9jxmQ+vxKSFEUb6Tg0T4FLwyi5dYOgIucEriIgYVxYpywETHOEahzd2ZJ6gITXk1BHhZH8kHzTPxF+75eqZBwXVsCt0tmiHRG8eNoODb53NNSTd9nMPevPt+qIGcsED5S2uadSUFE9ctoMWIPxHKv5DNkGJU0NbT21qJHEtfty4XWPGiXsoN+igkBVWLAWuoWuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB7946.namprd12.prod.outlook.com (2603:10b6:8:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 00:39:48 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 00:39:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Mar 2026 09:39:42 +0900
Message-Id: <DHCAN2PHLP6X.26O0FW4ELMYPL@nvidia.com>
Cc: <aliceryhl@google.com>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <a.hindborg@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <tmgross@umich.edu>, <ttabi@nvidia.com>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/3] rust: uaccess: generalize write_dma() to accept any
 Coherent<T>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260325003921.3420-1-dakr@kernel.org>
In-Reply-To: <20260325003921.3420-1-dakr@kernel.org>
X-ClientProxiedBy: OS7PR01CA0112.jpnprd01.prod.outlook.com
 (2603:1096:604:258::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: e94fd9ed-ba83-4282-77b4-08de8ad02edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|10070799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: mM67KTFg0LhEEeZzeROtqigoYPuMv72YPEDkagB9Wg29LB8LV+SYPeTbgStC61V9rMMJ1W+WIlHETzV97pnRsLn1aLj7shsBdzlUh+4ofJRz84c6+JsunqTkB3qg0ZggD+Yw13MBDYgkMCpnhBFSIjr39PjEhHxaGoHPQ1dWRSTv3lQE4kEARIUAbj6X5h3v9kQ0u9EDoypED9KFjduIBx3pbE/IyOV3nprI1LnYhkV/TnfmbGYU9kkMPTDNk4LEL01Gg3/lR+b2+0GwCzAm2KoqDRgAFMgvMrCK1ogEq3G9pW2/GvhpOI6qa8MldmGGNxymC3WhS5oVWtrwrrNYdD4a/d4qYlzaW3tr/GPahc2zrmujwna0P7X03vjThA9pI96vQ+IAIJxbmOeL+z9WDAxjdIKygLLE518H05tmXGWh8y5FfG1Xe9K6SZjZCTEz9y3xt5kyy4DLOP/QBL8ool5VjM8EDOCbB2zdeiCqltJgRGlpGRhsSrASq/XsOE9nnOPNJtiYL4Z/4LqR3vr/7ZPwyNPYoW3SmpemfWPoWR155/fmkBpU3le6m/vQDdXJQx050KA4UtYdSTJgS6lXkuiW3zbKmK/RPzF9HwXDgYQB7Pc7IK5EWLvHPydK3dSkQ/T+ryYSsYq+CoJQWZ0IsYeXVyAAFaTmyrV6bLWz87YiIY4h/xbZOmkKELUNUaw62+k8KmlWJ7Y5oYOBWdsV1XcCLyLrqzTVaCBRmxa4Cow=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm1lSERzKzVETWhYUm9VaUNKNVROcFdqZGd0THVJWUdoK0M5dXZMdE95ZHll?=
 =?utf-8?B?VkVja21uZi91bFBmRXZJaFBZQkxSR0REUGp6ZHRpZDAveTBVTXF5RDRKcC85?=
 =?utf-8?B?a0VBTG85VkU1Y3lTL1ZoWE1GMW1NcFJlYlUxV2EzWUlZajVQQjNZYjFRWDY2?=
 =?utf-8?B?RUlsNDc3aTlKc0Vxdis4YVo2TEhrVHAyZ1JseGI0Q0hUbWs3ZmVrZEpiODcx?=
 =?utf-8?B?M2xRcDYxRzRqYUNyNVlDeUZRQTFPTUtqeXNxd3hydGVFekdkYmpTMlNEUUZZ?=
 =?utf-8?B?NDdYNDhIclNrWm1rekIySFJNTE1WMTNZT1NQV0p5cy9VNkVEVkYvOGY0VjBt?=
 =?utf-8?B?L0VkUUs3cTlPdFRGa1NJUE9pd1ErSG1MMENXN2FGZ1F2a3JaSjA3VzlKUGFF?=
 =?utf-8?B?YnE2RWt5d0o2OFQyTEtnSXZMeU9NQkMxendxUUI3bm8wcEpCOVFFMllLeExy?=
 =?utf-8?B?WC96MlIyd0c3amlnSFJWdVpybmhUT1p3YldmbG5KU1d3SFEyN0Fyby9nbW5p?=
 =?utf-8?B?SmRzdFBpcUw4YXJ2QytFU0xMdUdwc2RaMkhzOW8rNUhmYjV4UEtqUmV2dWtz?=
 =?utf-8?B?NmVUZjlBaC92dE5wZHJPZmJVQUZ4YlNQWVdyRkNWMEUrQ0lsVFBzd1RGTVg5?=
 =?utf-8?B?Vm8wRzhhMWVLeW1keWRaNHFoUWhzSlpWaERtSjgzUWxpWjBCTkxyTVJZaVRP?=
 =?utf-8?B?dW9KUWR0N2dlS0t5UE1UUmtsL25FMVJhUzlBL3NXdkFiUC95azIxY0UyQlZa?=
 =?utf-8?B?UDZ4TDV1YWswdk9zcngvYW52QVBhdUFRNnpobkZhS0d3ZVh1eUEzM3dvZXV0?=
 =?utf-8?B?cHdFbnpVNllrWWpNbkE0Rmh1Yyt1cmVDbm1hK1BtQ0NRanlORUhlNk14VnVs?=
 =?utf-8?B?S1dKUzFZdEZJWE9sMzNjTnYzZGQ2SkNSa0xyY016ZW14QytwaUVNM3QyaXBM?=
 =?utf-8?B?UjJzWFRhUEErUFBmczVsVE8zSHRZVVdFRE1qbW9zbGw4V2Qyemk4aWxQZ1ln?=
 =?utf-8?B?NUJDbVB0ODVJdytPeHVxMWdNQVNFWXhWSEh5U1A4RVZOWmRHaURCcTRDZklF?=
 =?utf-8?B?d1hGR3o2WC9YU25OOTR0M2lNeEppS1VZMUltUE1JVGp4M3c5R1FodzBhSVVj?=
 =?utf-8?B?STBiY3MrYm1wZEN6cFpYMytGY3VoVE9Bd3lqR3RiWE5iV3ljYlpCMEdLOGFB?=
 =?utf-8?B?OVYwOGR4cEFaV0o3Y250YU51WXhTK3Zna05jYWE1NnVvdGRkSGhuUFdBMWVT?=
 =?utf-8?B?azBTTUtadTBzRm8vVk5PTi9pZi9yM3N5d0tHWldVbFZVejdacno3NkJqL1pn?=
 =?utf-8?B?NUFJSXdObnVZM0VCQ29OMXZ0N21mTU54SWt4VEFUM3ZIa1hGYldiWDRtM1BC?=
 =?utf-8?B?MUk2L21LNTkrSkZSaFlNRFFCVzNGRzdtMnVPUC9ESkNYYTJFdHVQcmowdlQ5?=
 =?utf-8?B?MHJpNzJQUDVBMXYwcGtQVTFhSVRhMU1CTk5rbkkvMGlvMGlFaVhvd2V1b1Zt?=
 =?utf-8?B?dnlPbGkrUVRwbkRWQU5STG96TmFJSW9Pa1BJRlFGK3NKMWI4UFhtanVCOWNL?=
 =?utf-8?B?dU1CMm15Z0h3Y2JBQVpwSFcrNTByc0xjalhVbnpJSXdBZGxUUENPd3Q1UU1G?=
 =?utf-8?B?OXNOc1l3eG9neERwTnZTNDRhT1BqMCtCSEcvVmp5RDFrV1pBWWh0Q3h4Y3ZX?=
 =?utf-8?B?czRrMEZZV0pGdUZkaHRKTEZLWmF6eVVWbFpoczRhcXZDRk9xaWYyVXNyYXp0?=
 =?utf-8?B?dzAxaExEK1NOUDEzQm9uSndCTHFjUTQzNmxaNlNrU0ZLRGNic01aZUFQaHJX?=
 =?utf-8?B?Q2doZ3RNUDhOc3Rvc3JoemVZMlJIR0cxUi96ckJZSkZLc1V5ZFZyTzBPQUdG?=
 =?utf-8?B?VnRVRms5SHBSdk9aVUlYVmVUMkZ5ZVlNdDBzN0JuV0hVd2tYd1VqTXlKQzhE?=
 =?utf-8?B?QXduVVZhKzgxVVhYb09TcjdpVitjcm5xUmUyUHNUK3JOU0s0M05qejhxMXlZ?=
 =?utf-8?B?a0dzQ28zOUtDR21lc1dPUk1GT2lJQVhnMXMvZFNEOEl1M2JSWUhNNzJYdGlt?=
 =?utf-8?B?SU1JbkNyZS9YQVEwTUVyZXUzQ3VlSXZNMVg1eGJsN3BHby9yZW9GZDVXMS8x?=
 =?utf-8?B?QytuR0xyenlnR1BSMnJsZ2J5ZGR6U2JvY2ttMEU1QlJGQjVBWGhuV20wYndI?=
 =?utf-8?B?cmNqc0FEc2hFSWlOOGhBMDNib1lyeFdyanY0Y2N4cUlpQ3I3SEpaRFBiVnly?=
 =?utf-8?B?eE94QUVmb3hzRXgrZTQwd1ppVmdrTnZwa1R5LzFqOHVFRzhNb1ptWk1vci9p?=
 =?utf-8?B?cTEwb0syRE1RRGxQc0ZDNXUyTSt3MFZ5d1ZZZFJhSjgxancyOFF2RExjSWNW?=
 =?utf-8?Q?BfdL9EyJGiKPYvqkQL0fkmkEBu0qq6Tjxu/h0dJK8/Fyz?=
X-MS-Exchange-AntiSpam-MessageData-1: y4F9NRhFeyg2IA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94fd9ed-ba83-4282-77b4-08de8ad02edc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 00:39:48.0680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: riJD49OTGLnhbFTpyj9ZRXmMUOmAAGwC6dLOekKOMBqQZLGzVImBo8aqYoAAqGYPiTnmJOiwE1CXnrxB8mbrLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7946
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

On Wed Mar 25, 2026 at 9:39 AM JST, Danilo Krummrich wrote:
> Generalize write_dma() from &Coherent<[u8]> to &Coherent<T> where
> T: KnownSize + AsBytes + ?Sized. The function body only uses as_ptr()
> and size(), which work for any such T, so there is no reason to
> restrict it to byte slices.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

The series,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
