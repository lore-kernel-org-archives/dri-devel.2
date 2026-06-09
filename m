Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF220CD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 13:19:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 422E810E3FC;
	Tue,  9 Jun 2026 13:19:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="F+D3bU+T";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013034.outbound.protection.outlook.com
 [40.107.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7755810E44F
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 13:19:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDeOSPM3eZy7CYYvSL28/WlDUqMgfc76KP7UZwV9WW1zx9qTbDDhxeNzJ0tOonLy/+O2j6F99I446ABEds2Sagp+LazkGXMV79V/GBzofXSUeTziKvkFy3v5xFe4L+MNZ/CveR+1I95CUTtcfuUBj+qJU4FpVYEmL0c8zeVoIeoF/zcQ6A1Tft5UFIpjLpUMcRSEWZjpTxXclUTwZ+9hKfmgNpmOxru7ayIYlqfHNqFMciECO/Hkeg21SN9QUm98fIFgtL1uFiakDKBq2n7kEKnjvXWcZ4TM8k0/TilEZob+OYHecsMymMcFr2t+hHrKwFr2cRhgqsewecCTviY7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9S9V3Y97wUaNbWbbkVY6D8KCy0OT7LBMCZ/Morzj+oY=;
 b=BXiUo8b/V0Er/LQ+1cWoVEnjr+9GASd8YSBuSdh0R5Xjc/P1n8SpT8jEl6nLC52SQJQzeXLGacB/sCeCqHJ6F2+uyb/ag3sJqGiIMofpvNhUDcAWL523EW9lZrTFBuBxMW09EAd2E/k3jOMd6UEqm3w1+klXoFkjj5At8L3ciMMLAwlvH+Crf9IWDjqm7Gc7zcrlY8fq2C6wfMxVrBHyS8Q1z1q1gwIUCzTv0B7LDs3URj8Gzl+oZJ9pOM4F6bJlHBl/J5KF/VbI7bpwgXSWExA2E0u5H4PU9It4ueWUa+bjuHqbN+5/wjr7SeS/KFtCI+z7T10xx4yePC2m4QUXFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9S9V3Y97wUaNbWbbkVY6D8KCy0OT7LBMCZ/Morzj+oY=;
 b=F+D3bU+T/Hish+0VGOrrn1FhTcO6mFQQW61w9iMFa9N0ivppJ+1sXPuhqB3dE/fVoE6/K0d2O7uWBks+66bOgJQe2USya8x+ElQAkR+37JO/xDfxjME3WM+fUtAWg/H45gntdqzUOdgX/Y0TyPd9K7OmS34Q7J6FRIE4P6wWGGjj7NITjG22XOUW4felXHIlTsNipMwZL1+wtuMKIIFbKGENKuX3KIOwCo5tnloQIl5tyQS+4L2tiFd6svcjwu1hR8XwS8R97RUT7xCg+je/PAXUT3u/iXxy5FhC8jdyosN90r1G5+H2cszThduP0qt688xJK6JSvi36LQtkUK054w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 13:18:59 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 13:18:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 22:18:55 +0900
Message-Id: <DJ4JR8FI7QCY.34N1UHF6NARJF@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Sashiko" <sashiko-bot@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>
Subject: Re: [PATCH] gpu: nova-core: gsp: tu102: keep unloading if FWSEC-SB
 fails
References: <20260531-nova-unload-fix-v1-1-c8dcdc769b53@nvidia.com>
In-Reply-To: <20260531-nova-unload-fix-v1-1-c8dcdc769b53@nvidia.com>
X-ClientProxiedBy: OSTP286CA0091.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:219::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB9031:EE_
X-MS-Office365-Filtering-Correlation-Id: 340539ec-ae06-49c1-80c1-08dec629aac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: yosD0Vmv1K90ZChHxaAZs6V7+2b1Ca2YRBMjuMUDMzFEcwkXcQJ0/AEfTOsrD57Si7zFu9PtBu4UrEnTwnZ/sQpBOP3IiOTjqWvGItJBiabAWe5A3v+BiPPxLia4tHf0l+03AErVcSu49KJ6g426AZmeG1Nh36O02X849XtMhlJdeT1TZV9Qcc30yJWCcOBop/H/QyP2nEzYwA7hC9Ugg9jidbuAIkaL+/CEV6558i0R1Gn7HlVXIlvScCw+mgPwCyq+i0AJpRNtCQV6dTfB/vS/HJpvzoO+oLv7ueo8KT/mtBSryqB1odj+Fh7qT7oQnAzKGt10g0jZJVkqZeQfbEAxLVMuAuSnNiHrXsmkJx5CU0l75RveXD0hXCILeVg3WgvL9pAXHKddMF2t5D0X5n4aaIqT8NNOFrsF0s75M4wN96xQj2ROpjQQsuYb1WtFo11oMqy1nRM6XViwrEK0d8a6v1VAlW7ouTAM1/h7V7GHV2CFSYK5KYGrMJWvb71ajP2ugS39y+wP92Mh8x2vbuWr6ZjKE/nYMBHA4den8M/U7EkHqd8F/J5JTZ6/dVAo5z1qH7oZ6IcM+RqTpn/Gfa8Yb6NAyo7gQJiqC2DPZDP6p/DTrhNxQQrxgszGzKWZIADYsuYtwNT/6U8kZDpo94x/OUijP3XneV8rJvkxUPpz4UJFXTmtlaPG/C5MW8ki
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFFWVW9iRUUybTVGZitJTURDaldyMmVaTCtDWXRZUXUvaHhsTk1XY3NzdWx6?=
 =?utf-8?B?OUY0ZjZaeng4ZHBsdFhVY2UyV0pmVkJlbHBuSURHakNFWlp0SFR4SWRlTUF3?=
 =?utf-8?B?NmZBaUducDUzZ215QVc5VmJxVjM3dmhrM09YTTBBd0FvaWdHOTB2ZThvYkNx?=
 =?utf-8?B?RGR0VVNLYVdkaWZNbmpndmNYV3JrZngveFBuM1dnc0hidlhRU3h4SXJ2d3d3?=
 =?utf-8?B?RVh5by80MWw2NXBxc1FNaXJ1VW8zV0QxbTRQeWxuTUNxKzlFQytxbDdhSTVO?=
 =?utf-8?B?WjRISVZyMHdLRTY4dm5ESmh5aFl4WjBlRVBhdXpDWEJSRk1MSWw2MWh0bzBU?=
 =?utf-8?B?bkJDanpxSy9hbUhSRVY5Smw2T05aU1lzaXpBRFJmWDBEL1I4NjJOcGtoZnND?=
 =?utf-8?B?Tjh3SDN0RzQwN3hWU3NqVjFLazdCUWZqRzFESzVnZ2hadW9kVWM1b2FCVFdN?=
 =?utf-8?B?Zm96Y202UFI2RmVsWUkxWUFkREJtSU42Uy9LUHVaV011M3ZPOWUxYzQ1ekJt?=
 =?utf-8?B?NFh6Nkd6c3VLRUlmREJNSVV0MVlZWENqbnZWQ01MR2h0cXVCcnNzbUZ2RVhY?=
 =?utf-8?B?Z1IzMUVmQS92UnFMQ3c1N1EzcVZlVi83L1pDSkpsalZ2bEY2WkdmSVNhYzRM?=
 =?utf-8?B?STJWS3NqZWNET1dReERCQzUvNW5idTlEWWhadXFBSDc0M1hzR2pyWnZsTjBo?=
 =?utf-8?B?WXRWS1FjeXdxRERGQ0xZMkVFaGZjbHQzL3pJZkhMWDJaNUdUV1Z6c1JSNkNR?=
 =?utf-8?B?UEp4d3J4eVp0aExibldULytjRWZPQWtDYXZhZTFGNXQrajh6b3dZV1JCc3E3?=
 =?utf-8?B?UzJxVnNMcGkrcHV3NU8vekJjWXp2Y25jaVpsTXd5WHJoN3ZiU0VWellKSDZl?=
 =?utf-8?B?NzhsZm5KNHZPSWRwUGdaOGlrNnFVajlSWXNPeTBNeU5vYzJwK2FrVllScVVx?=
 =?utf-8?B?anBmTFBqZnJoNW03UTdJSTZ2b0hRYUhWV2pBODVMaVp3a0F6SmZzMHRTTWdr?=
 =?utf-8?B?aFRsMFo0d21QR1ZlcCs5VFhNdy9INWdnd0dkNWVIVWFzL3hHVzYrbnVFc0Zl?=
 =?utf-8?B?WVRxZm1GWnpyV29TYXI3c0UvZHFPaitqaXJ6TzhNQ1NJbjhidWRNdUJmYUJI?=
 =?utf-8?B?SkR2ejFpamw5bVNKSHluc0hwYy9GdDd2djRlSGdpTFVjSXVBV1o0akZ2ZjZT?=
 =?utf-8?B?cDNmb3QyUE1rU2tDdzJLd2hpUE5wT29wN1lpL2J5REYvbjQrVnhLTWdack11?=
 =?utf-8?B?cnlBSmVIQUcwRkc1dVNqelMybEJGbVZuSmxNczVNbTFTeVNsN3FwaldFQlRI?=
 =?utf-8?B?VTEvZ3hqZ3ljenRVY3ZtNWZuWHdjVHczVktkL2NLbW9sc0djRVZxKzE1c3Fn?=
 =?utf-8?B?MFE2UUxGY2NmRVgzRFFOaHJUVjRNaU1WbkpGNTg0eVcwbzNDbFd4VTBFOTYy?=
 =?utf-8?B?NWNzRnFNTy9rSERjZlNLNFFNQWE4USszRXovMDZxTHJleEFXYlpmVGRNanEx?=
 =?utf-8?B?S1hqekduWmxOQ0pQNzlHT3NqMEpxd1VqREliVllacjlXalNOa1hDRE05NWFT?=
 =?utf-8?B?VmpOak1sc2tFQ2ZqdVY0WEU3VFdrc1JqM05ydTVPaG1UWllGd09iUXU3OWcz?=
 =?utf-8?B?dXRLZm1qSmJ4V0RaNzdiQTQza0pLYjdGcmJaUXVQZ2ZzSzdOSkRlRHg0eCtQ?=
 =?utf-8?B?cWd4dFhVbkRUZ3JMWXA3em9kc2ZOQWdKMzVsSm1XQTZlbnpRSmwwbXlGQjA1?=
 =?utf-8?B?NVRYcHJtbnQwNlpTSyswdUdkOE5nRFhsUGowVUFEeVRlNnFTQnNYUG9XSTlN?=
 =?utf-8?B?dzNoaTlHcnB3Z1VpYllhQ2FaN2YzVDVMZ1NLVjBUeUNRdkpxM2R3dW9Iak01?=
 =?utf-8?B?eVZRRGpaeFhlNlZlT1ZQV2tlcGM4UTl1Y1praVZzaHU3YkpydVR2dHIzYzlG?=
 =?utf-8?B?Y24zODROYThMd0MwY1RtZ01CQWEyc1lyeklRQUJHdnhaZE8zUG00MlRIOWor?=
 =?utf-8?B?cWxyMit1Rk80TWYzQzZId0RhTzhMSWs5VDFaZ0xNWWRBa3FpQVpvNHdpK0dr?=
 =?utf-8?B?M1dia1Z5bC91QVcwMTFIR2hUWGx0U0dHeVFiQ2tYeFZMbnBFNnlnYTZ1SjVs?=
 =?utf-8?B?aHEybGNnM0llUTVsOVgvNjV0ZlZUbXJvVXlORTkraVEvcXkwVng0Y2FERXJY?=
 =?utf-8?B?NmVFSFJmaG1qUVR2bHVqclQvbm1FeWRCNEVTZ1dRTTVwSTc4RkEvR0ZoM2Qw?=
 =?utf-8?B?SlVEblk0ZnRHajlqeDFlVDh4RGdMYVk3NDZjaGlOQnBhc3NWVFpsZnFFOWNG?=
 =?utf-8?B?a3QzNHQxaldlT0hOUTh5dW1tUmF4RXlVQkZKWmFQTnZmOVc2YXNBOENzbU9l?=
 =?utf-8?Q?ZAD97k1EJZFLJui+0byGPE8nrsnbpOL6fF29Usoc0/Cbr?=
X-MS-Exchange-AntiSpam-MessageData-1: LzGwWQmbg9jxcg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340539ec-ae06-49c1-80c1-08dec629aac4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 13:18:59.6046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VcBhWUAeBFD4MWQ426u9v2AfSnGb7B77l97dHI/oWSWFdG5TAH522SjgT9iFrqCaj7sp7d971jVsEiQ6Wv2HHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9031
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

On Sun May 31, 2026 at 9:37 PM JST, Alexandre Courbot wrote:
> On Turing and Ampere, resetting the GSP involves running two firmware
> images: FWSEC-SB and Booter Unloader. They are independent from one
> another, and we should do whatever is possible to restore the GSP's
> unloaded state even if a failure occurs along the way.
>
> Thus, keep going and run Booter Unloader even if the execution of
> FWSEC-SB failed.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260529-nova-unload-v7-0-678f3920=
9e00%40nvidia.com?part=3D3
> Fixes: adb99ce3cc78 ("gpu: nova-core: run Booter Unloader and FWSEC-SB up=
on unbinding")
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Pushed to `drm-rust-next`, thanks!

[acourbot: log Booter Unloader errors.]
