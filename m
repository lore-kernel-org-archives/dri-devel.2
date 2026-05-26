Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F65CD5BC9
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 01:44:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E63010E42F;
	Tue, 26 May 2026 01:44:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XTKfAFLy";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012060.outbound.protection.outlook.com [40.107.209.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E874610E42F;
 Tue, 26 May 2026 01:44:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUYKwPCzADLgthpCcUCORSKy+MrkWERbBoVOaRj1vA0etNGTr2WKT08hN5745trxavu/D12CHFCKh5UX7Z0gAyVzmjahMeX7FiyXgksum4mISjs42tXf1jBzPeAVou08EG5/aLn9zl/qG62U3Do2XlPfzHsKaLG3VZBkKHcK0fA4EOOQiVSVsmFh0JxL9RvWmfNHbVGMRIZlQEZMKshLQavtd0/Hg7HL4rjgFkZ2X/gGV5IX4OtunLz4TJARsGNt+IpTcujx78/ttoCJAeI7Life/2qk1JcyP+i8cNTrO39iass8sI3ofYOui1kZMXnSVf5mdN1y3b9zyJEKV0Ynxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqBw6eK2cnhlpY1SFIP3xbEyIjkCfmVmnsUH9zIvHOI=;
 b=jBo7nYfBcljoQz5Wp5DbfpVuY0HE21hQfQkwGN8ykLPf6UEtmYNa1bRc4FSto/tL4CuBPAzwGifGFcmxsxvq6AbiPrR+N9BkM0vCDON0bFuTUG6eEtopnk3P5lUvOhmtZ64NUrppY9wZqX4klTj9WLfVMK+JzUpJhRYnqNl2gAJBOfT9a9K0iYo9Vq8uRb4i9kdzGEHuWVFEyuEGv8qHKoTedHC5iXPlgErVr2yzIE9dKqHPKV9w5rCic5kfF6Iv+S0CA+jfouvjlJ4tYCiVvu9wyGCa/OqTH8ql6OI2z+7W56SjoA24Np928nATsYBCJWvodTC+WRmeVyZJAj47Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqBw6eK2cnhlpY1SFIP3xbEyIjkCfmVmnsUH9zIvHOI=;
 b=XTKfAFLyTqRi/bXEYHDT+MK0MIeZFZfrCTKG7aQHkShgiWeHpTRbBdYWz6u/EYW/fBLwa7j0cTHXjx6uhWfOjv6Zx/vYu+fL1tMeatLldBBYGzQ3pppei6B1w6rrhdNGwVl0bQjvttxLc67/Wk5rEq6mWrsZ+QOQbBDNxSmFMpEYniPAHDzV11npmdDba2hCKPY2rvE1jt71+wRn3s1tLAKJJnNb0/24+IGj+WBayL6qGa78IukimVc2Ot1D+BWIUl5pKMvO9m6MKp5XOiwRj9uG1KaB/eFjOkRdhDjyZ8lN5EsQquaOZGk1Jafv9AGqUZ7N6iPqx4pfrhSxedt2yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 26 May
 2026 01:44:46 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 01:44:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 May 2026 10:44:41 +0900
Message-Id: <DIS8826TJC8W.2D07LPH921MHC@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 4/5] gpu: nova-core: gsp: replace ARef<Device> with &'a
 Device in sequencer
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <acourbot@nvidia.com>,
 <aliceryhl@google.com>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
 <ttabi@nvidia.com>, <joelagnelf@nvidia.com>, <gary@garyguo.net>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260525225838.276108-1-dakr@kernel.org>
 <20260525225838.276108-5-dakr@kernel.org>
In-Reply-To: <20260525225838.276108-5-dakr@kernel.org>
X-ClientProxiedBy: DUZPR01CA0129.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: ff628559-703c-43a3-c790-08debac85de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|22082099003|18002099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 5X2785P4uGkXUvDFdmJxopVplVVVV3N8nTxxQW26rkdOD+CSLRUkupzSeJ6KJAhdCcEBpy7x0x6MVEg0gL0E4c2gdjD2liEfB3+mGb57VezJW+veMFxEOvxG44wyqroEuEujfJnl4O0rMjD4DGddfi3SayLUBEryD/DUi0NvaJrlCY4UlFnamPRrUmonUgksN741/t7D1njI7+Ec+SXDJIZD8ltVySfokOuVbnAuzSP2Z6kAcaBb4H9s7EZmWYwovZPZp4/DJCoUmlCi4eCJw8t4/7JCW6xsYsEgiBeCUuseJoNDRL+eo2rugJ4kVVzCpvoPj1O3y2GaXAPrHoIMvb37PpWDbcGZ0ZmOWxKPM/FqcAa9svH8fbZYpNuPvTpaxZIFEit6P8zHkTySV+z4TJMvwIamxd5ZMAPtc50jg/ACdTRq7wpAJLhNaRQRzYMCLD2XOANukuNUk4qMMp5+UWrCahyRxmh6LwbJF5nQlgifGf002N0wMOiehoqI44jS6FQ8n+uIlhdv2NIR/6ff1fkK4LxvZoF/j9ICpwt+6x+WY5NFPQusRRSKLxjywH3MPyVip++pN0iD9VTOyEvIafQGlmjTe2kj9Q7vjxTyZmiQNGxS98aHeo1sg7+SnzBbQtEmFcwgvjWXJ43/c8KzTwT8vS63nTC15w4l4SGGEOQXTLT6Tq8NPujFOoLgjkbH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTZ0TUtvUWlZUWhWc2JFelg0QUVOQmwzYjhmRjc0QTdJbkthRkp3dHMzVDFO?=
 =?utf-8?B?KzZRNWR2eXVUODBlN0REYllUYTJTZ3pXM3hnakV3Y0hSTjNoY2VPaW84N1Bs?=
 =?utf-8?B?d2pnUC82M0FvRS94aDVGVjFHTnhPaHhjNHNsTmU4Tk81cUtucjdKZ2hhNEJ6?=
 =?utf-8?B?TlFYVEQ0T212aU9EekVSU0QrMTMwZTcvQWpzaHRxTEpCakt2bEVDU0hveDkx?=
 =?utf-8?B?bUhNMnhTSXo2K25PbHRNQ1VoRlAyVS9jWDdZZ2FsbmN0WTFEYVZ3amxmTGhw?=
 =?utf-8?B?SUt6N2Faa1ZKRklsUXd4RnZMWEZpc3A2Y09GS00rekg2SHNHb1V0aHcxL1or?=
 =?utf-8?B?UkRwMmhyYzlmS1lhc2pxQjFSdkhiNVRTaVc1OWNOQUxNRXFmYlQ1cDA4V1BC?=
 =?utf-8?B?aHkxMnFXR0IzdkRid1E3OXRyanU5K05QQUx6MFR0MG5yWVB3aUU0SzlSeWV0?=
 =?utf-8?B?L1REd1Rpc29IWlNFd1BnOFpyZTlENTUrM0dLUEYxUTYrRUlXUWlaYU9RQ2ky?=
 =?utf-8?B?Vm5FNlVuV1hUWUpXZmwvM0ZoSGlQYkdwa21CK3gyMS92ZkJOMmNEc0E5NjVK?=
 =?utf-8?B?cXRxKzUyMGI0K0RaNzI3U0VuSk1zVDBUUmhtbGlheGNIWkptWjJ0L1AxNmxK?=
 =?utf-8?B?QS8yRVk1U3JxOTYxenhPOXBkNk9TRUxMTFFXQnFQNERjcTgyS3Z6Y3h1ZHhm?=
 =?utf-8?B?Zy9hQ1VmRG9sckRUZHJ0N042U0tIOWhrWVV4WmxtTEd0a0wrYnlGYi9wQ1FC?=
 =?utf-8?B?bG5rWFU1K1JpTThJSnNWc0w2dzBYSFZsdE9LWUQ0bi9RTnQyN1p5MzIxdUw2?=
 =?utf-8?B?Q1oyaElERlZTVHNSTFprUmsrWkMwbTlOMjNISkZCb1VEWUVPV2l4ZzlGd2xn?=
 =?utf-8?B?K2kzNG8wVzZZM2h6Ly9NZ04xSDhSQVFHeGJhbWlFdWQ0c3FyR3MyNjZacDdR?=
 =?utf-8?B?VFlsb1laczJRUWRqNG9uVytBMnEyVmI4dU11Yi85UlgyK2VCRGlrVDU2Y1Uv?=
 =?utf-8?B?VmFJZG5lZzNjMzZxTkduMHhPeHZQY2NCRWhSU0lVUk5DL1Y2eDVTajQyZWVv?=
 =?utf-8?B?YmhaMllPeENMUlFHSTl5aGdtRW9JNFZLWnYxQXk0MmF4aGZHWnpZVGtTaUVw?=
 =?utf-8?B?Y0dvQjErbXUrbm1yYktWMDMzMmtxQzFrQmxGVkJabVE1Tis4NEJ0ZWlCUlJv?=
 =?utf-8?B?MVFuZ3JGMno0M0lQaVdSOFhaR0Z6OHBEcXo5dG4yL0tRWlU5Vmp0b3ArbDY1?=
 =?utf-8?B?Y0IwT2x0OW9vSE52b05ldmt5U201aGhmNU9WZTNKVGh6TWNuQnZEM3d0NGtJ?=
 =?utf-8?B?V05KbXNOY25JU1BxbjhsQUw4RG54bzBRMndQLzI5R3MvUklvd09SeFE3azBK?=
 =?utf-8?B?VjN6cmJsTHk3Zmhwd2JyUmM1MkVkTkl4aUhvMUQxMytoVE9sT285UWhNMk9F?=
 =?utf-8?B?YWllV0l3TGtOVks5WWhVcW5hNStVRHkzUVYwRDY1WlJGQXk3Q3dIZEZ4Um8z?=
 =?utf-8?B?V0VYT0pDbjJBNTdhaGd1VG9saGNXVWZ0TGU0VS9GTDByNXAyK2NnVVRzY0Ja?=
 =?utf-8?B?OGlNMUlod01FU1pEd3B4UUhnbE45NGl3Mk5yR0NXdm9TaW04NGhkb3ZnL1JN?=
 =?utf-8?B?ckptSTd0Rm9ENEF3QkxUNU9XM0JidTJ1UDM4dURuUUYxMjlaQlZjRHhRRmp0?=
 =?utf-8?B?UFlWKy9rbWR4c3pCSzVBaURsZHZVa2dKTzNwbnl6YkszWmg4LzdkS2RieGVa?=
 =?utf-8?B?Ukd5Y2NodXNDakRXWGlJTkFVd1ExTzZFQWh2QjkzWERhVWNsNDZ2dXJlUUxK?=
 =?utf-8?B?ak1aMCtUZ0JiT0RZcEd2WEF2UUJjbEljL0RpL01VZjZxVzJmRzFsUkMxeDRm?=
 =?utf-8?B?aExMU3NNM1owK0FHN1N3YUJRaFpHc2JpN1Fxc0IwS05tNUE3WWVPQVdHSGxa?=
 =?utf-8?B?Z1RoOFZvL0NaY2krU25tTmNvYlRFaHE3aFhGQ1RUTXJxV0ZwSFZRckU3R2Yz?=
 =?utf-8?B?QUhvMmJ2Y1NWZ2VjS04veEtramV0elpVUWhTaitRdmZhN2NiemZwUUIxR0s5?=
 =?utf-8?B?UE1XMFQ2Yyt3cWRPd2owTUgxNWY0Y3B1Tm9Sd2tkNW9RLzNkdWdkWGM0ckpE?=
 =?utf-8?B?TmVOVUhoUWNncVZ1eUVVOE1IK1dsQ3Ewb0VJUnExTlZHQWhmK2tIWi82M1dO?=
 =?utf-8?B?dDIxSnZaNGRjRnBBSDR2T1Z5TVErWFZIUUpZSVh4d212cFlIWXp2eHZUakRL?=
 =?utf-8?B?V043M3lYQUpJV3lnNjFOeUdCaGwrd3gwdloxMkd0Mk9MN2hJeWxyTTRTQ1F6?=
 =?utf-8?B?ajZ4WDY4TEg3alQ0bWZwN2czbHc4V3pVaGYreG5TV0VzUjNEd0JQMDEwNmw1?=
 =?utf-8?Q?oKAqE7TLSrDv0UnvILLGjhJHVPFrvu0V2WcE4g1RqFV0w?=
X-MS-Exchange-AntiSpam-MessageData-1: Iqcu1JXT57XFQg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff628559-703c-43a3-c790-08debac85de4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 01:44:46.5618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdnCt3bD9qoMBquiKHPPCqfzh9cjCGRXx/S4cb2KvDp82NIPNc+x+0DMfT8gdzRL9F2UewBiwTMmkSzibZXV4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185
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

On Tue May 26, 2026 at 7:58 AM JST, Danilo Krummrich wrote:
> GspSequencer, GspSeqIter, and GspSequencerParams are already
> lifetime-parameterized; the ARef<Device> is unnecessary -- a plain
> &'a Device reference suffices.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
