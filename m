Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43728CD8C90
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 03:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B33DF10E6D1;
	Wed, 10 Jun 2026 03:39:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="WsLvq+/2";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E975310E6D1;
 Wed, 10 Jun 2026 03:39:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpLT75iepB37iFkOca4cZpk8hU7Bwgp6lJNWxLsUIKa7VufwLLDKfgCYH1ag5KhBrTNeZqz+5+tpyXFaje8S9SINbhWDrmvH3dzeWiCzban8zBXWRDUYM9zSGPB7wcMgiF8cKhKidQ4L8ix4IIPfskLeXwYmdEayOcX5V6HJkrWgX0APC2QCF3mFAWJ8oPQYOhkamU6w8UbdDNYJdSlqm28mJW3q9bXigJQL5uvp9UiQsxXWJ5o/fdMuZs/ZX3N/hJDcs2KzwUnzi9US4E2P+LBmbFdodXZxx8jSjmvvVD2+cvJR8M3Wvg0WJcZ/Uwal+fDlUYaaemzbccBgJxfgzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kn/rR5zt6xa9UkQUZk/37Sq07zIS0A6/SYjxgPoit4U=;
 b=XrxlVJTRbQGkzLEI+aWDb6rBjpiMSH6Trtt8rnNylNWx7lS/NyMwgENAfQwF6eCzMPPPFFPCWuPlDKqNe2/DA9g4tiTjeE36iJQZBj/HrN+NeWQ4Q/dgXY4yOOVteM7hTaHXYlcr4e2Syni98LR6dp+CQUryv0BMu3oiRuY/olR5eaJKS61LnWoPI7/8Rb4QEN/9Hy8zCQGss2pOqAhXRJs10PhIJc/r47/tRpBDh3fI81Wgpf0Gjry388gLA3LoKGns/YcDDJ0/M45SjaJlKEs4WWBei9oP8K1wOj01zuDpsOSHEt3yjIrPUsQREWhOPy9uWDn3+gv+WUU4umqlXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kn/rR5zt6xa9UkQUZk/37Sq07zIS0A6/SYjxgPoit4U=;
 b=WsLvq+/22bTxzIbjHnK9VsGM23Al8HuoGF8H8KTK0CYMJurKXf1uywoA+ABrmJfmNdEmXCAfhxBDBM3GXEix2peg689xPsxBcewWlIsYaKioC6jDTfTrOk+GglqwgkWYyq/J67LN7kihRIjGnGs6SZit9yW9L/DV8O48t+NqJAiLntDAt93onCXGrBwOPToSrpCEoQolWqCFUKLzWeINYiphSEIrfLOh7lUHQw7GAQnvRbg7dcbybqx6KMUNglgN38iR16vy4ueu9L19cQGVPlMpkobLJ7WUJN43HLPbKst036D6adoAA++STV51KfZlPE4wL63ug4Cfqg5ibQFjMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN1PR12MB2368.namprd12.prod.outlook.com (2603:10b6:802:32::23)
 by SA3PR12MB9226.namprd12.prod.outlook.com (2603:10b6:806:396::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Wed, 10 Jun
 2026 03:39:13 +0000
Received: from SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42]) by SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42%7]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 03:39:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 12:39:09 +0900
Message-Id: <DJ521VQRHV4F.2P92H9FP72CF4@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 2/4] gpu: nova-core: move GPU static information
 acquisition to a GSP method
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260609-boot-vram-v1-0-d9382610507a@nvidia.com>
 <20260609-boot-vram-v1-2-d9382610507a@nvidia.com>
In-Reply-To: <20260609-boot-vram-v1-2-d9382610507a@nvidia.com>
X-ClientProxiedBy: TY6P301CA0040.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3ba::15) To SN1PR12MB2368.namprd12.prod.outlook.com
 (2603:10b6:802:32::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2368:EE_|SA3PR12MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: f14b1ff1-378b-48c5-8224-08dec6a1d6f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|10070799003|376014|7416014|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: wD79IrjoWkWjat1YXk/E68xCZhgaHR7ZMpzq0/sj0eMxyI3U0shB7OQlUwiWmAFPPOW/7p0y7j0MJRTNuzD/QsOT8xXBJ5rneSpdsCGX5cjeTQn9TC0G8k+oGUaYoNCfDijmZd+HxjdfqQfbCQWkalrQEum81DxmxxEBu1ZkyPW/tEBc5VOvbUnb7sDk3MXxcW0Bo5BXsJ2gIOieR6babenZfKMPZzrZ0+/arsyAq2UPEO8gGmmtVKJi/VkzSoXC0O6OpqlNTh8+bAyrkCCX6RPY10siEaVSCbC4WCkwgansflWd+fsMHEljhdYTsKG3oPqzxGGQLzZ2Mvs4I6TexyGR2TMqA3RfXYYMAdxQR9l83bze5/8/5S2ToOShDTcfrfZT3Auw/fskV8VncXooFZkpHR4TwdOpfS4sKNQR9N8zREQ6z30/Ro8OUKWWhn8q3cFOuOD986FyeNAWpk+mQgb3Y75wWJnKEDIqreoG1kagS9teUM5tJwZYePRo26szBgas2gLsIkgwoiu1C6WjsaIqwfp3FP+wsoN4a+kTLZDsg8hKBrvuaMbjMhLxWNJgOUlI2ihTmjhoPnGID3XzuGbI73K+Y/XIvdLu/8hQb6JWAUxSABKl7BUK8HCACFTcAlnXB21S1a4HErH7ob+80h9YHhEvTcSk/PyX0CDjOCrU7WN89X7Bt+pKJHa4lCmv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(10070799003)(376014)(7416014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUhDTmNDdGxIaldOdUsxWXFMVWhPNXR4MzNBWUJhelNlM21KV3BRT2MvcDdL?=
 =?utf-8?B?b1Z4UkxoRXdvZVZYOWd2SlRpQ0VDenVQN2NDS1paNkVJTm5wYUgyYVJ1WndL?=
 =?utf-8?B?Uzg4OGZzWlBQVzlRNWduR1MyOWs4dEZRVFVoYml0L21TQ2xER1dyYVdLQ0hZ?=
 =?utf-8?B?OHVDYTBleHhBMzJXa1dOdjJVSjNhR0wzdkFFOUIwV1M5UDFFTE96aGZoMlRX?=
 =?utf-8?B?cFV5SEtDMVlidE1rNXpWUFovZ0Z2b2EyNWt1OXpUZUI5TEoydTNhM3htT1NC?=
 =?utf-8?B?MU5RdmEwT1pWcytzQWRMTWRXazBaRml0TlZRUGh5L0VqYUFQbmFOSE45aXBz?=
 =?utf-8?B?YmFsaU0zZTZRRHpXNkYrL2R5bkp0cWlraWNMdDA2dytTVy9VdVVaWHRsUTRs?=
 =?utf-8?B?UkJSNTVwS1R5dUk5azV3U3h1V0o3amU0RTR3ekYxWDBNY0VzNVVETDNEZXJl?=
 =?utf-8?B?TkMwakhLbFduU0hFN01PU3BoVGhxUW9MeUZ2eFBXbjdlMW1ROFdabVNtdFVP?=
 =?utf-8?B?bWhwYUZFVkFIS20vcWhpTkordC9DblZ2UXdtR3JPWlB4bHpnRkt4ak54dm15?=
 =?utf-8?B?cVNPY2ZpMmJkeWt5OEFNVjlVRDlzUFRrdEZVQ2FFZzUvSlhQM3Vsd3cvM1FF?=
 =?utf-8?B?ZzV2QXpXRDQxUTduRzl0VnRBVXRjVE1OaGsrZTU2N1pUUW0xWE5Ja2pyQmFk?=
 =?utf-8?B?N29iVmo4UTA2cE9pdmE1ZFJJdS9zQTZxa2pyUTE3RHBIR0hqR0xhRXZHcmpN?=
 =?utf-8?B?ZVAxQStzb3dSbXBtNVNNTE5EVXNtc0pDMFdIekZuYlExY2xSbVdOTkF2THRL?=
 =?utf-8?B?OS9XL1pYV0ZPVDhZOTJ3SDZIODhSU2hZREdBek43QVREelg2VmxnTVhqbklX?=
 =?utf-8?B?a3Q3N2s1dlR6bnE4NkEzTUoxUTl3OTllRDJtL0tCOWM5NGFDbEw2Vkl3MElk?=
 =?utf-8?B?dzlwSVdjWjNjNmkvdUY3V1o0NUVGOWozU1g4cDNCQ2ROeEdiTjhJWXZQVGVZ?=
 =?utf-8?B?YnlSR28rdm5scTJERUhnOWsrY1JGNEFoaWpyZHdmRncvNUpPMVF5cCt3VklP?=
 =?utf-8?B?bEVhaGx2NDFCdUNKa2NwU3l0OHQ3RkRXQ2duVDE5dWdHU1ZSQ0ZEVVlTNU9W?=
 =?utf-8?B?R1VIdkdlNkxLd1FVLzNFbFFYYS96QTFaVHlzZVZ1bVFkSlRPanhBNmd3aGFX?=
 =?utf-8?B?VEZZWThJaHB6RkZMendnK05teHcvQXRhQXUydzMwMlNGWUdaWk9USnc2OXBh?=
 =?utf-8?B?NFc5VHY1c2xRWjZXMW4yWVBkMDVoVFFFbkdHWkJmNnZJckVieEZ4NVdYMERX?=
 =?utf-8?B?eDB5Y1A3R2MrdDhEcnNxUCtuL3M3VG4vOFlxN3ZxWkUzUzJaMDJTV1NkRzFE?=
 =?utf-8?B?QjRyUS8xL0s5OWtMVHpFYm1PY21GZ3M2NVlWb1I2aXFCdXlEbHl2akgrb2RQ?=
 =?utf-8?B?QldpVlRzNzBiYSszVFhXZlFzSTRFZlpVWDJ0aXhxS2NCQUJldzNZNDh2YmVQ?=
 =?utf-8?B?dlZnelRQeC9mNG5tdlBOTDErWmNIZG9wUmRJUTB6SGoxZ1hucjlSU2tpUWZ3?=
 =?utf-8?B?SitpMHFuNDVlNVVCNFlXcmdjYzQ3YlBEOEdBM2VqRm5ydGhubWx1QW9OQ3R3?=
 =?utf-8?B?K0UxL010S2hJb2xiS0JEQm9RNXZZUGsxNWpsTFdmUHFDSFhIeWgyN1N3OUR4?=
 =?utf-8?B?Q0s2c2w4RzIxMWVkczNtNzJhZkZ6cVdoSzAxckRONit3R1RoSC9SR0dsVzRq?=
 =?utf-8?B?SnBOY3hocjNYNWo5RjVub25SZUZHU1RNcDJkV0Fab3EzSnZiT004cUU1N0hx?=
 =?utf-8?B?K1lNVm41ZnFDQUNMbWJRVVJNOFVKckUvSWNSajVzdWlGbkdacDRzUkdNTVNT?=
 =?utf-8?B?blJwNE9GY2VWRVRXbEQ0K3lqTFFlUUxCeTd0TlQ2QUpES056OG9UK3FpeGVS?=
 =?utf-8?B?YUdGSVF2OC8ydGoyRml5QWozNHJKQ2p4cmR3UDQ1SGU2NmpaajBXa1NRcmRZ?=
 =?utf-8?B?cENBV2ZQWnRoTWtKazArQTMzNElMcUJ5em1mcS9JMlRmR3VhOWRBZ1A5enhE?=
 =?utf-8?B?bUVMbXd4ekw4WW5KdE9oMFY0Ym5hcDNpS3Y5OTdFekUvWmc0Q1h6cUREZFlT?=
 =?utf-8?B?Qk5ldTNRclB6SUlNZG5icW9pMkUyb0YydW8rLzFWekt1TjY3N3lkMnhRcWJI?=
 =?utf-8?B?ZGhDK1Q0RENLVUoyQnFuQUw2aXdZMWNtSGExNXFsMzd1MllZU3JzZ1B5ekdS?=
 =?utf-8?B?eU5ocnRPTFlQN2RnM3BXdVF6UERWSmNwY3IzWitLWEJLRUFqUCtqUktkWmsz?=
 =?utf-8?B?NUFUTFZzNUUwNldHZURCRmgyRjFKTW5TOG1uS0JnYWU0cW1vckxXd1RuY2py?=
 =?utf-8?Q?7aEm9/rJGcdhmieW6Kbe7S0CTYNI01z6jiZeo7CVWKN93?=
X-MS-Exchange-AntiSpam-MessageData-1: VdvF/DAY6WS93Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14b1ff1-378b-48c5-8224-08dec6a1d6f5
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 03:39:13.5971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ub41odL0zRXvvD8LRWRFpZDbOiKO2QmyGNy6M8SkWmuMDuRAtQ0lCSWlVzj7Y44WMxihVhbzOGqXRuCv3ZhQKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9226
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

On Tue Jun 9, 2026 at 5:04 PM JST, Alexandre Courbot wrote:
> The GSP static information is useful during regular driver runtime;
> however it is currently obtained from `Gsp::boot`, with no elegant way
> to pass it back to the caller.
>
> Solve this by moving the code acquiring it to a dedicated method of
> `Gsp` that can be called as soon as the `Gsp` is booted. This allows us
> to obtain and display the static information from the `Gpu` constructor,
> and to store the static information for later use.
>
> Its location at the end of `Gsp::boot` was a bit out-of-place anyway:
> technically, the GSP is considered booted after we have received the
> `GspInitDone` message, so anything that happens afterwards is not part
> of the boot sequence anymore.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

