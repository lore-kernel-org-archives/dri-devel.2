Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB12C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 14:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C7A010F4F8;
	Fri,  7 Aug 2026 14:03:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="PB9sLp+o";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6A6010F4F8
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 14:03:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwRz5WyMk/URipFt/EcaOw7sfwVE6Agcc3IP/G7Eick+8rf79CJOi7ONWBsUvSDmRV3LNXn/qFI6RGZoHeNQwqnPMCgA1fom0TUWIhIaS915LGk3iETT4JraE5vXxxD7hUweDFAr0crO0RJ5S9I2NnPlF8q1n7awvO0VMMbEbJPblgXCBPYka6Ctp1K4XLV8iZy5jnAdxY8dyRfN7+2HPujwc+521Udxo8h+xGYQLFIISgv0jIlfY7pOmYsf+/XIcfbvfbNthDadY0rNWm9yDSGfuyaL+ZJwCLem2Ky3tOl5E0hIxmpuFSl42llYxOviqNQRP1SMQheogW7vShqpRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXd6ua2+UI0Ob7jv53i7hHf8TXyRw+q3PQJCUqny94Y=;
 b=FCCQNTJoiNdGyyJWMpqfnFfjbHCmCpL94rw0GfEEUJ0tGWXg0Um0r6CkjXxnjk7Tm9K+fui5ywpstyAIOXj6c2W/s8vwSOnXQAl+vzITX0IwuEgdyhRdlCxsQod7Qf8JqucT1eI6UcCmm09UR9Z9IQFmGNmP5f5atl08klz8VhDEwkSEPlxEuVWHgbHob/0MPfG1xO8TOaLZZW5n70H3PpquzJMzdbO8sPJywk7OMCJldElp7/TkcuxCPptDxJEoOO4PuXGvHXcRnnGELYJC0vBkg5iePPEItNK2HXKeZSJsgCixSCYXzDfNQW92cGw4LxSy6avnc2+X9OTRqQ8Fag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXd6ua2+UI0Ob7jv53i7hHf8TXyRw+q3PQJCUqny94Y=;
 b=PB9sLp+olna/u8ahQY2/Y5/FO7V5Q4NA6PR8q65YBKZI8lSii9v2n2kKdWiDSE+8Yr/amVRKEiU+g0eChB6XQotz92iXPcpzdEFi8HIRkVBc7NJo3zF3CSB9XLWDcsobOM5iYu/xcpYr3/QcEXZ2fNIceksnHfxj70zS3DiAN6PLVU4o3nznJvzXoh68CixuSr+FfeCihlcU42W6Pe/SfizD2zp3H1DmDKO1uCaZVKUt0cim0zhRSxcjddh3ysABMnxnUXpf5ye+ZoYF+5nJ4EYZcmzJOWFOG4OPF8Ar9CPeOmk1aLyT8NaeNmIDwsmEbz0mb6CFdcm8OO6OlT4BLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA3PR12MB9157.namprd12.prod.outlook.com (2603:10b6:806:39a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 14:03:31 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0292.018; Fri, 7 Aug 2026
 14:03:31 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Aug 2026 23:03:28 +0900
Message-Id: <DKIRNHGHK4O6.2IRJZGM6W79B@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Tamir Duberstein" <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Yury Norov" <yury.norov@gmail.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 02/12] rust: num: reject Bounded::shr overshifts at
 build time
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
 <20260805-pramin-split-v1-2-ff3e84a75dac@nvidia.com>
In-Reply-To: <20260805-pramin-split-v1-2-ff3e84a75dac@nvidia.com>
X-ClientProxiedBy: TYWPR01CA0037.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA3PR12MB9157:EE_
X-MS-Office365-Filtering-Correlation-Id: ba798b77-7ad7-42b1-e5c9-08def48ca9df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|10070799003|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8Ywk9c3gnrbizGYBmDQJBR1BF4n1pusvP0r4K+3gNWkpJ1n+xPgXNayleFOTpAh5Oy/zsyQu1Z7C5XdPbrlQvGLjC8AH+zlSNamgEKFtosfD4TUlJpxhjeacX/GWfspRXllCiorLDbue37kuiV3mYkSjWpdd0Ll/U9th5B7zRaYTHzRl4gH/RFlGS0rD7BWMpFloz2PbhhtCH1aSCcuUSfW2YmhSDNsUjBiDwT5OVtnaGuiwizKxH0E9o9pYjquStNg3ujsHqIvQlvAJhuw0NsfF5xm36RQOsKfGnnMy0QfYFfG1nX1S/0Lx7GB6VJWqH2jbYAdVIFMosQZd3D3qf/IOwM9e4gM1g9TU0W/FvMBydqWqYNL4XbH1AzAJq/O6v5M5jcgr/9gNtLADYzVOp2R9RKyn9h7DDvpHuM5FaYt88q/1xAq9G7/euXpAqDEa33X1AbftDcI/+FtwCbGTGjrxkWOyX6IDLCDpj/g//L12jP94EiCceU2Y2vGhaT5K3gBmBgouoiT5vJG6uK7xRDiq3HBmSdiv7iF/unWWbRyOqVKy61T2KcI6jWUvp9o/qygQTw5BO+r6EW8vtHQUpRnrNFVGyd1KDys/HQWMKEHv3PkzA61x+IJ1RgfxwNNbbe/lfYe0pJLiMK03qfO+N1PUq6kQbjlCancWQ4jLuuA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(10070799003)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZktZbjJ0bDdlRkhDMElmVUIrRE9aSGRFVi92RktiTTFDRVNwbTRoNTRYYzcr?=
 =?utf-8?B?ZXhZUml1cVprek5hQ3cwdFNGYVNPazVjaGUzVnJ2SmVhY2FnN1BDNmpRNXFs?=
 =?utf-8?B?djBRUUF3c0FyV1hTd3hhWmdxNzlJY1JTWDZ4TjQwbGFIL2tBMElPdjVsMnNn?=
 =?utf-8?B?U0tzSWZIcisxaUpKekwwKzFaT2VUUHZud3JoZHh1VlU2T29JeUhoMUdtcXBL?=
 =?utf-8?B?QmlLZWI0eTdBREQwUXVaNVUxRDNPRXpuc3dPZlJGYndYTlB0SUZKTXkvSk9Z?=
 =?utf-8?B?RFYvTytRUFVLdEhzdWhlUHgvWXVuSVVzODV5V0lMRlo1QVdtaFhTZDVKcmJX?=
 =?utf-8?B?VS80NkE3bEdSYWtSeGFlTkxxL3lHWHltNS9RdUdycEhJanVRQjJpeTVNS1l1?=
 =?utf-8?B?Z1FITzNDVzNXTXVrYWZkdnBFZWR5bnFQMWxUWGNvM0orR1F1VWVRajNRYlZX?=
 =?utf-8?B?UG1lTzhOZFNwaDdwR2YvY1JPLy9xSVZhaE9WSklxZFBMWDRGWVF2azFGODN4?=
 =?utf-8?B?SHJuUnA1Z0pwZWFVUjZSa2NRY0RHOVRWandGUUliYm1qcm5yOXV3S1pyNnlX?=
 =?utf-8?B?bXZ0QlNoVHI3TzlhT2tZMmxpUHlBdHNvUHNZeXU2Wm84YjhqbEpURTZabSs2?=
 =?utf-8?B?NHlBSjl5RUtpVFRVZ2JxSVpRNDFqRGk4bEttc3JOU1RkRklCRGhXZnRwdWE5?=
 =?utf-8?B?SHV4ZnplOFkyTEM3b3RTZnJqTFM4VFk0MDBzVHREbUQ0UFoxUFBCVkRya3VR?=
 =?utf-8?B?VWhHZWM4RllBRllWWFVReE1wYmc2V3hHc2hjV2lZVm11SUJVTzJRbkdkUlRC?=
 =?utf-8?B?UUVLRFZNb0hEMGkvNnMvODZTWDdUWEFoMVBsa3ByK1ZjekZkbmw2aTRKa1lz?=
 =?utf-8?B?dnYwbmlTVnpLZUNYYU50S2NncHBybG9ISGlkZXcwdVdZQVdJeDcyN3RnaG82?=
 =?utf-8?B?YXp0THczUUxMVTgzQjlQWjhxTnRUQmV4TWZiLy81cEx2eWhFcjFpeDZRZUo5?=
 =?utf-8?B?ckEyQlFDVFNXQjI1V09yczVIMjFabXkzSDRFZkI3K2RMbmxIQ09TU0lBZlFR?=
 =?utf-8?B?Q1NtZnZMTlloODZIaHhqRm40MzAxV21qNERTWVlFQkRrRGczb2dldkNRMVBt?=
 =?utf-8?B?WUc1cThyd1J2VW82a2JQbGlpdlJOak92MXNFWXN1amp4L2NveHNmY0MwSHh1?=
 =?utf-8?B?cnk1czdYOSt2VTdTZjRKMWxDWXFBYk9lKzVaRHNJZG5xNzdVNmZtNlNlQVVQ?=
 =?utf-8?B?enBEaHVvVlNGYTJrR1Y3MHhnZ29xYjlMRkhmd0ZMUVZMb3lqZWY0djFYWnRq?=
 =?utf-8?B?aGFYWmJHUXR3M0Y0RDNhK0pZbTZKNnYrMXNZWUZ5KzcyTVBuRWJCcmYyZ0Q3?=
 =?utf-8?B?cUJEaGduM0d4a1VadVBtMjc5Q0RaWXNteFd6SU1UcVdqdkdya0JIbUJ0eXRL?=
 =?utf-8?B?VjhUTVRwTkxHb2loekIxQkRVTVBrVU1BYk12QUJOOXIrRk8xM1A3Z3FsN0NK?=
 =?utf-8?B?TjhvbmJuOGpnYWdhMjdVL0dSOXlDWFpUekFRWDlRbEJxSGhOQVRvb3hqVWxY?=
 =?utf-8?B?ZzFDK1ZyYXZab3NWRlUxN2ZHZTFpOGxrU3NJZlZlOU95cXlzcHZ6a2lLUDNx?=
 =?utf-8?B?NFIxTE1QZ1RNSjZCQkl1b01JZVdjZmphNGx1Tk0wNEltUm03ZmlQTFBEbWhT?=
 =?utf-8?B?ZVJSUnB0alF6cExiaHplRFY5b3VrSFRKWmlveUJ2WnBlNE1OUmF2ZEI3azZW?=
 =?utf-8?B?cXZxdVErVzlCR1VxRDhvd2NhTXpoeFBkemlwYTYzY21WQjJYalU3ZkRZUnh0?=
 =?utf-8?B?ajhaeENscTRNMjBJeEFITVdMd01JQ1lRY2JGUDI4eXhhdzFOSkh2Umx2Z2d4?=
 =?utf-8?B?bWF0TUVXYVh0UEVCVFhYa2g2R1h4NUdiQS94d012R3A5dDNQdVNBL28vbFV2?=
 =?utf-8?B?aHQrcjRWMlpsQUhNdEZFbWM1OVhtbWpNb3JtejBZS2ZDeEJqUW4vY1VvRVA1?=
 =?utf-8?B?TytyM0oxQy9tOFplaHQ4aEN1dUUvZXkzTWxBNlVUUWI1K0pHTkg0UElJeEtx?=
 =?utf-8?B?Si9VejBsbUZNaW5xWk5GYktDWG1qb3hPMG5DT09VdUZTdm1kRnFDcnkyeFpr?=
 =?utf-8?B?OFp5aUZ6UHI4MEk2aC9hZmlIaEJ1UmNnb0R6SDFNdFY0Y2YvVTlyNDlZNjVk?=
 =?utf-8?B?UU1TR1ByUmR2NVFPd3orbEZjSnFXNlIwUTFBM2RZZlF1U0RIeXFkcUxOTkI2?=
 =?utf-8?B?SmlDZ0p3WEFVb3pjMVBhbnl5NXJLYnpxRjZKUU5DWHRrSjRtSEtXRGVoNTJJ?=
 =?utf-8?B?N0dyRkNnNVVQTk5pcklTNUZIY1lVRHF6SGN5Vy9PcWlJWmRpVWo4SkJOaWc2?=
 =?utf-8?Q?YztVgVg2vOmfpemUJZpNgmzX6MZPOQ/+aPCjS3l9H2Wd9?=
X-MS-Exchange-AntiSpam-MessageData-1: 9gtLGeYFTa/zMg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba798b77-7ad7-42b1-e5c9-08def48ca9df
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 14:03:31.7591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUTUGf5N9pVqWT9CPIt8EHcCSU/J9bgz/hSLQ8FZUnnKj7CGndQaSzXC8UNgBadGiAfo1+AFSG/09a40zgMvIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9157
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

On Wed Aug 5, 2026 at 2:44 PM JST, Eliot Courtney wrote:
> Make `shr` reject shifts of at least the type's bit width at build
> time, instead of panicking or masking the shift amount at runtime.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Indeed it looks like this would panic with the kernel build, and can be
easily caught at build-time since `SHIFT` is a constant.

Acked-by: Alexandre Courbot <acourbot@nvidia.com>
