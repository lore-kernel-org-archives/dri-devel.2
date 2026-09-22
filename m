Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4B6C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:24:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24A1010E726;
	Tue, 22 Sep 2026 16:24:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="frDPelkB";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013009.outbound.protection.outlook.com
 [40.93.196.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CB4310E726
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 16:24:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJ5zaHcGWH+5lcAqeic+9r+RPTeevSxIv36pX16bucpunLgegBTNDf0O/pd48njFXlkZrHHQas4vvCda4voSrM9XPEyttf0COW6bd6L9Om9CAQ1JrnSb6Iqv0EMkf8EmxuLcB0O3llWnP+0TqcNe7fiJ7WeVzvDSxrJu2EnP6ICfh38eVfjtyHPl1sX4TVmqNcqU15RHIhAE+05pVHb0Ns0CdrHLvpEDw9qRCGA/o4d1yyYlfsJ43KH6WGo8HZBkKGk2sEcDAhdbs8yWKhQBHqbVEC/4a0YapvOO9DHZxZZaIZcM+q2tS6xx+qyfbkAkkeT7hbmEV+CHhcqP/D2PrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnKJbI/PnktWZrztTDPrGX0aCU8ZDlX7I72D2oPkFhk=;
 b=m6BHDE3zYsuODBW+3IDhYMolW0Tmxtn4VXxytnvLz6m1z2okD0NRTP/l+DCloe+B+aoV97JTNkalprKCE7AEx+evXtKdckmw5QcT2egeoY4b2e/f2m7Re3ImBXf/NMgVVYK9duJImO3p1rnamsM4NALrEX7T8NNKuP1EM2R+knxLdA5G8CoxNuHkyrgfL9w7Syw3zypDy8yZR4Yf2drnzndK0AzOtQn4gZKfqw/6ie4yZUqosq/vUZfXUtoBP8NCH158swTLwykFu+BlF+QBLlsLu1DUMpotBiiDA0NRXBSaskENdhtop0YVIAEF9D4lrmbiN0Ujuj569K+LW7Ik5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnKJbI/PnktWZrztTDPrGX0aCU8ZDlX7I72D2oPkFhk=;
 b=frDPelkBmpFXwSQOb3XLdJ15UUxY6d+avX72Llnf6z7HGMfid5kFulB7vs0z2TW5sgb89HgEfW/6UjF3dHHPUHlLfPENsNFdgZtaKbs1XY5K34Nl2iJV+QwqCkMYBGdGs6fmfH2N6Qjw4OJz1j+F2SNFl0ptkCmfQBuRexv7Wwo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21)
 by IA1PR12MB6329.namprd12.prod.outlook.com (2603:10b6:208:3e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 16:24:10 +0000
Received: from DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::9eab:812b:ad20:6087]) by DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::9eab:812b:ad20:6087%6]) with mapi id 15.21.0428.011; Tue, 22 Sep 2026
 16:24:09 +0000
Message-ID: <21f4b63b-1aed-47ca-a766-dcce8fe55203@amd.com>
Date: Tue, 22 Sep 2026 17:24:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/12] drm/fabric: vendor-neutral topology
 infrastructure for scale-up accelerator interconnects
To: Konstantin Sinyuk <ksinyuk@kernel.org>, dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Francois Dugast <francois.dugast@intel.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ilia Levi <ilia.levi@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 pieter.jansen-van-vuuren@amd.com,
 "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
References: <cover.1787552412.git.ksinyuk@kernel.org>
Content-Language: en-GB
From: "Austin, Alex (DCCG)" <alex.austin@amd.com>
In-Reply-To: <cover.1787552412.git.ksinyuk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0157.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:347::8) To DM6PR12MB4283.namprd12.prod.outlook.com
 (2603:10b6:5:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:EE_|IA1PR12MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: 062269ec-3635-437b-d5e1-08df18c5ee0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: E8iCCzEPg6ifgDam/EKIlOo8XMq52CbHkJyrojEUlC6fSPZlBGqZ+BG3YDE3M7yRju8+YZ1okU2Kr8jBZNFwDazChbAj1ZlOv77xLwZwqRvXrtiEWz57fLDeMehNbAjKX7u5jBBEgW1nsis6Z8rrZufDoKva0rTq6oSBWT0uh18kREdLL8IUJ4K1fO4Rt+c1PKmRpyhMzXy0j5vxp7kjY91cZddJRMAJSyogozB8Oeh+vVVd5pWfuRPI3i3AD8MibptO06nTdkhzUtWFGPYDpYCZz4ND9YKWZNmc0s5NbuznY28xwSBnJuy28i9BnF3zXWlEbv2J0hIHI/+bN9MBP29Tcc0klGlwIPRQ62pQeRBiQ4ZLWWI/GC/j3mC8tdq45e8QtR0YB+G6Uv0ALdZthvo50ac7XPGEw39QZu/OVpgEEia7fGzev6LYZ65Zowdkq/M5Xiz18d4f1fyfZdBi2Qhw5iAb5NI/BMFgn7ETR5jk4QH+KhKth5vyzOgveAuKhLAZ4uq7D7PH3iqlYYr9KHY6L6hotc/JGOpWwYw95rKIMq0QYZxMT8XtQLocAsmUgTdv4dImuvNpYYc6rNCP6wacFSBlZlbdVkCj5yhLPyu5A6papPVSLkgcYQ9MbT5HisUamKznf6pUrlXBprGh0kGdysJdysfBEld18NS9SP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4283.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlplRkc0NWllQXNYVFJRaFFZYkV6NXVkV3JiL0llUC9JZWE3Nm9MSEpId1o5?=
 =?utf-8?B?cjJ0Ky9hNklGK3IydmI0UXJvMnFTYjRHbHRIek9iUURVTm01ZmIybi9jVUx2?=
 =?utf-8?B?RnVrWHVSQ21XSVlyMmtTUEhMTUJ6QmdaYlZoZlNvemhWTFN6RzVYNTZQTEZK?=
 =?utf-8?B?RnQ3cHV2NnB3clBKM25ERnpHaGMwT1V1K2RUU0lqMTcrQTdvcVlDNExFYTB1?=
 =?utf-8?B?UldMbUxEM2tKSHc5Z01vRDF2NEZNaFAyS2d0NDZubXBvSzZzVHpJeTRjWU1u?=
 =?utf-8?B?OS80Zlltd2pSS2RYcXBYYmM0VFdnQ1dQb2xrdk9Yb1JHRjFpZFBmUDdCeVha?=
 =?utf-8?B?OXZDaHo3OGhZWXowc0JNRm93OTMzN0xTUW1LMDZXdDVTS3NoSWtuNG5na21C?=
 =?utf-8?B?K2dMWXE4cjFJcVlscG1aamIwaDZHR01QK3FqLzdncDVKWDFVUVN5aHgxc1VS?=
 =?utf-8?B?NXdGUjk1TzI1cXQyU3JEZnVmTmttaHVlbmxreEdwWDR4QjFock1pRjNPNjNm?=
 =?utf-8?B?T0lsT2tlQ25sOEVHQkFjWXF1cVdQVXRBM2QwbE5GemZtY2pMRHE1ZG5RUnNO?=
 =?utf-8?B?TzAxcElTbnJ1Y2RPRTVXSzRzNlk1bFlkMHpFNVlTUnVyRk04T3Q3TjY1UVJ1?=
 =?utf-8?B?alBjOGpJSXB3ZWUzYmFGZG1NWFdhY2pxTEJrQzdybVR5cEt6YTN1SkQ0MnlJ?=
 =?utf-8?B?d3V0SjZBYWNqbEpubTJhVk9vMHo5clA3eXlZRzBFVG0yR3FXM3RrcG5zMkZ2?=
 =?utf-8?B?Qk5aUXFVaFprK0htMTArZ2YzcmhMWU1CVGxCckJkdmszbUN6RGlqK2NRQmdL?=
 =?utf-8?B?TlVxazh4YVJJcDRtdkU1TGZ5SG9DMmVmUVpLZzk1MkhQbmxvSkZSbDBRL2hT?=
 =?utf-8?B?R000dUhnUGRQWDVkb1NuTGZqVDFnbXF1TEE1UCtRYzQrK3BXbXNMZElSUDdL?=
 =?utf-8?B?UDM5L0dsZ2F2bU9rY3hONUE5cEYwb3Y1KzVha25DK1lLVDd5QlBYWU1EM3FQ?=
 =?utf-8?B?M1RwRlFlWVBPZHY4djdMejlyTHZZYTFOR0tvVnZIYmR3WWVmTlRyYnN1U1Vx?=
 =?utf-8?B?S2VlSVh0UGV1SS91aHNpTzQ0VDFzeVVWQzRJK3V4Y2FXMG5mYnAvMlN2cjhw?=
 =?utf-8?B?ZVJFTUpmSGRPa0RYZWU1NkQ4VHZYMi9SNnlteHhYMWNDSFBGaGpJbXVqOHpy?=
 =?utf-8?B?b29HM3VHN2pjOTJjQmhnYXkvU1R5OXRPZCtuU3ZxRTRPemlEUHBOZDFVM0hl?=
 =?utf-8?B?cWo0TXExbysxVUhKd2tNL0JZNnU3dytGZEl0ak15UElsZGs4RXR5RTEyNitU?=
 =?utf-8?B?ejFFc1RsRnFPNnowREI3bFBIUm5zQ2NWMXBwbzN6a29id2M2ZGJxbm1nYno1?=
 =?utf-8?B?ZEVpbUZoMklvR1BjRjVlZm4vTS9qVnRXUXJ0czJPMXpUV3UxK3FjaUptL2dN?=
 =?utf-8?B?Sk4xR2xQcmNQbTAyVldDTUhxN3F5UE05aW9wU0RRZjVsbGNJSDVab3Z0TmdZ?=
 =?utf-8?B?dmdpTHdsYzIzWWRvV0JUQWFGSG55bWMzZFFjeCtkWEU4SWNmOUxDZlF5TlY2?=
 =?utf-8?B?OWNuM25vbi80Skl2M2ZydTBvd0p6NmdJTXByV09qNGlqd3I2TkxVWStteEZQ?=
 =?utf-8?B?ZnZYWmcxSEVtN3NZY1lnSDRpaXlaOHg1T2lxY3hDRmFRc01ERlVMUjR5RFZU?=
 =?utf-8?B?UnM5amIyOTlFTzUrNFdOQW5HbWhZRnUvOGRhTDZzY1lhTmxHOGZ5VE1FWGRi?=
 =?utf-8?B?elNXN2dMaGJwRDJPZ2owdFBUWHlTSnBKMTQxT1BLbklFallndDkzUXRRQWVt?=
 =?utf-8?B?TTZlUXhGSDJ4OHNSeHJRRkxEeUNxZVA0Y3JjU2JxbE4rU0VpYzdsdkNNWStz?=
 =?utf-8?B?KzFLblkxTlgrT21zbXNGMU00MnJ2M1drNGVUVVlYZDZYYk5WMkZObVllVERF?=
 =?utf-8?B?aUEvVVVDa0xpNkZRdTI5ZDFKcXlQcGlacUt0THM2YnJWbEJsOXNoVENlamgx?=
 =?utf-8?B?QnZscEVYN0Z6V3plVWdEa2J3cGdFNUgzWjRCTmlCVjNMZ253UVUxd1FueE9W?=
 =?utf-8?B?dDBMc2prVGRYc01DQWI4WVBxcVo3bkNpSUZ1N2tncWU0WFpTVmN5d0c4cnE2?=
 =?utf-8?B?RVZVWGcrQ3pvcTI2bHdMNUJCWXZ5U1p2RVN1dVVxZksvL2xWRjJOekhzOW83?=
 =?utf-8?B?VHpGT01PWHErUi8yMk1TK3dVTklHSFpZVlBSUXZjYzBaSFpqNnBBZDhKUEhN?=
 =?utf-8?B?ZU5UL2ZWTkRtNm5GVG5tbHc2WGNhQVp4bnFOTFdBOHlNREFKYTZZbHFUWXFO?=
 =?utf-8?B?cG8wZFpsR1ptRFFBSGZNWmtBbEFTMDl2NXZDRUR4azhnSVQwRkRsQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 062269ec-3635-437b-d5e1-08df18c5ee0d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:24:09.2560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9e3R/pNYzjKGUAGYvegow+shhYeiWIe5iZK2qRALGd7aRBFb0Laa8399bnyP1SxEQAQX6T7kr8DTyAi758ttXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6329
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

> Modern GPUs and AI accelerators are increasingly connected through scale-up
> fabrics such as AMD xGMI today and emerging UALink systems [4]. Linux lacks
> common, vendor-neutral infrastructure for reporting which accelerators are
> directly connected, through which ports, and in what state.


Sorry for jumping in late to this discussion. We have hardware that uses
UALoE (https://www.amd.com/en/products/rackscale-solutions/helios.html).
The suggestion from Jason is sensible: a new subsystem for fabrics and
reuse ethernet stuff from networking subsystem where possible. We would
like to continue discussing this -  Alejandro and I will be attending
Plumbers virtually.

Thanks,

Alex

