Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D5ECD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82A95112CE8;
	Mon,  1 Jun 2026 02:11:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="MomANC4G";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013057.outbound.protection.outlook.com
 [40.93.196.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E86DD112CE8;
 Mon,  1 Jun 2026 02:10:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2RIKzEITL88cNhd6y60vTLJ2/9WP+n4EFBHrYsng9qCMDwYnr5ib0Tz/pJQsJKIJiXstAtMzKzLZhGvIHZkSVTLmXs1n4tdt2uh2rud9M6Lck9V3B6tcf7HutkPMhAfLUkuYWsLFLd8SKuM10LI1LgyXh+SzCETtEh0eMDomW4pSQcJfaKQkWN98z91EO3AtRfn4nEz4qGz13j8Kj1ouex/UoD8rDJvjed9s9I15/ykHOpJo0UIIgBF0bUUIn0V69fyCZxJJ65lexbOwqyRewno3uDi8zO3w4MMXUXaE1tw0mDVmA5cRNjctY2azetU2nG/9A7KpCggTAG/vB9NEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lK25zEuk3hkRxtcJYLKIoKUbc7RuoYwhAr3cfVhu8pM=;
 b=RlloaudO09L4cQW5o1L0tvVAEsI8ld/hIrBCrtvHZx4G4TFEJuWNWa3kOzY4+WEPN2bt6FduWk2hF8gh8PLS8XbX+QjrGgRSvI74fppjd7RPdnXwQzkI8TWurUUoXUeZle07dW0vIo2EHKU6mSh1Y9V9AbT7I94OjW0QxDFRfVJPJh/VX5OaNHXXW9Ww182OsKZY4YfP+m0GmZquF5LyYTPIpZ2LXL9jjzMDUNwZSByUGLukas7JIMDydcho1x0zEjsVw/SVqMZxS4ZOv+tYOBLIcpQTsQZb+x1yuCOcv7USnnwUQWTN5djr0IpvKAFvheWytjriHCfkR4AHEoqkSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lK25zEuk3hkRxtcJYLKIoKUbc7RuoYwhAr3cfVhu8pM=;
 b=MomANC4GE7Lk87jzXNvUjR0pl7kDASrZhtK3of2rcIOLwqRakuZ03xnA0gysZ6OooDW7qUvuxcZayhC9sK6MEPp/6FSwWZ6DgFZ+vYo94f6Ch4zkvlcLYO0rHCHlHXXuyP4vbU/BM/0xUJkYw6M0cGZ4zVhek6GAfGr82m4CjFdmLLtlmXHJbIx4k8AbGpR9713V6Z0BVf5sV9rJkghyoPwERH/G2RvXmN9uUUnGbiB8nUmHUDlkVAGOxtJeyerZeyypqQrvHDC9Thk4uhB3Mf+k3VDr7v+wEqboQJW0N+ZjfRgFcMqkxOcI9kFYihEuKHtFE3eVEg8c7QI/EnlimQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by LV9PR12MB9781.namprd12.prod.outlook.com (2603:10b6:408:2f6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 02:10:56 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 02:10:56 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 11:10:52 +0900
Message-Id: <DIXCJDV6UQW2.E1SHSJ8KLMFG@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Sashiko" <sashiko-bot@kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH] gpu: nova-core: gsp: tu102: keep unloading if FWSEC-SB
 fails
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260531-nova-unload-fix-v1-1-c8dcdc769b53@nvidia.com>
In-Reply-To: <20260531-nova-unload-fix-v1-1-c8dcdc769b53@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0114.jpnprd01.prod.outlook.com
 (2603:1096:405:4::30) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|LV9PR12MB9781:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e93cdc-f7d8-4a4d-bf50-08debf830429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: nUrQpIUwj1nD43+Fe+Lpo+t7Hqm3pv+wvN4YCEpfVPy8CDz9xiIxjiVkFe/LzjRmhuVq1Yv9W7xjp2RSfN1xYLdpGmKLGU5nq1X6ykeDGw1b8a37gfUCFmXnqOuXFo1Vuc4DUtj6ewA8nIdcDzbuydsR/Oq4NtPpRYyF6ZNYzrZug2pdAK5KNpFBWUjfarEuPi0K0n4Q6uLFlEWgwLS3/f5LWUYU5U0fpg5NHHvpW1CTbibBJpjnejM5gVeiCtyFrh92P+vaJkNK1YtZ3pGqXH+xiNbUBaeCw6/xy4bn/CJ0t1z3GmsyE36ANGGphSNCbdoNDxhjS16Kh8FaoQ7xOLcZhoZCyoOF+ApIJTNfIa5PYVXS3dNt1WiyvBGjYCFDAmdXKA41Y3YR7xJnfcSXXRBlGzazwaqdyyaKtC/eqGw4RQE5vbQkfuou/UCyLa7VjMnSbpaF3nIcVN0rxlU09cObp+6IXRgU1r8rKQY5xZPV87L51j+qAoahT/w42Ln1yqsUC5UdUJuZupK9Nu+0WRO3MjSpgs1p5bqYyVo0oFLBwY0QIN8G1znMaPPM/1jSdrmdAobzdSZcO5t2rmol9KvUx68noNX11dCFhl1JLtRj0UsnfsJS6VyXmHWuRvrw+P9Yyoc1yRdbDjIpNlBYD8cgmrv9Np6ZxqC4mao3YsGS/yiADnY+7xUvXxlZSlxv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1VFNHRxeHNjeXFHS01jSXJUckRoaGNaM3ozaVhKWjRIMERNaVg0VzZQMHdG?=
 =?utf-8?B?TlpEaGZ6MWRCQlhxbVQxTEVMNE4wSHJBaFlUWDg5Ukl4c0Q1WjZZUTY1Q1ZZ?=
 =?utf-8?B?d3EzdHBnT1VUUlgvM2x3c01BRXlXam5RZG5Yc3VoWDlNMVU1YVZxRUxCcEVm?=
 =?utf-8?B?Y0JBODBuQXFGNE12RnJuRTk5czJYbmE4eEJWS1RyQzAyWUFtbTRTZWd4NjBJ?=
 =?utf-8?B?ZzZJb0FSN3BOZCtpdTBYUGxIdXAyM2dGQWF6bVg3RlpqeWlCLzdPMDlmWmlU?=
 =?utf-8?B?OExxUE16T0NsWGdCLzFPNnVNM0I5akxUWU9jMHcwbGJ0cmhGa0pSb2ZiK2NS?=
 =?utf-8?B?VDVVektMd3huRitBTFpUcEhvaGo4cU5DZ2VGTEVjSlFsVEI4M1pPL1VVeG9U?=
 =?utf-8?B?RjhIajUvT2Vkci9Fb0p1bU9Da1Y5aEhHUUMrelFWSmJDUWZWNm0xZmNiNkEr?=
 =?utf-8?B?Q2VkOENhSkQ1cDFIcVROT2dJRU9rUWpNcmNtYk80Zm5wYndRNDdqdUJSaEdW?=
 =?utf-8?B?SnVMbmdJSGZhR0ROb3AwRU9RUFJZeXQ2d3FJOHdSd0I2STJpbFZLYkZ2VUFo?=
 =?utf-8?B?V1RIeTVESFAvUEFBaW8xRW4vY2lVNWZselVKUWtLUTkydWp5b1JybmI3VVRV?=
 =?utf-8?B?dUVXbk5vdHZWbC8vNllZSm9HWUNvRW9qdUs2MnlWN3hYNEtwbS9HMkg3RG9L?=
 =?utf-8?B?b0FHRVR1MEJ3cndBTnBJVFpSazc4a1E5RzQwUTk0M2doamkwRVJ3RnE3SGZX?=
 =?utf-8?B?Ukt6b2gvSUNhZVBaS0pzVEpodGdpM01tRjJQNE1oOWtIbFhaTGVjMTdWZCsw?=
 =?utf-8?B?aGNpRyt4YVN3aDFHekJRWTNYeDNvbmxDRm56WCs4SlUwbForSXlDYjBSN1dK?=
 =?utf-8?B?ZEExUXFOTVlycE1qU3FJUXFEaFZNdVNZTGJENEdPQVVOajBjSEEwQlY2YlVt?=
 =?utf-8?B?bWIyOW9hcThrV2NwWEp6Smp5cURTamlJUkdLUUNpSGp6d3ByTlRjS2hiQytv?=
 =?utf-8?B?SjV1bjJjc1E0R3V4dEd1QlpQeGpIQ0k5NVBRNUZidmlzczVvcDF0OHdSOFJK?=
 =?utf-8?B?T01lUW9JcVBJSjdjZ2FNUHM2WVdxNGl6R29xbGRSK2hjMWYwTHlXbUZoYU9C?=
 =?utf-8?B?ejVWUVV6dG5CRkJJUTBZVVlZVGJyNURDeGlTaHhkZ0RDQTM1YVlJZzFhSCtL?=
 =?utf-8?B?c3BqSEhWa1ZTMEV1NjNyTjkxcnZXOENJaXVXYzNLQWNZUlMyaVB5cEJxb3dD?=
 =?utf-8?B?bzhiTWI3UnBTUWdFQ20rNytpMmk5akkyTW91S3ZtWmlRdkJMVWNBV2JjOEtO?=
 =?utf-8?B?VDF1TENzSGUwcU5vdk55YXBhYytpZmJOMUVweVl6VzF6MkkvTEdXV0pvWk1G?=
 =?utf-8?B?c1VoSnN1R2ZTdzlSR1NwN1U0VVVFN2FxblhESWhZak9jeWx2TTBuU3BnMWpP?=
 =?utf-8?B?UzNLTVZ4NlJlUU5ObWZyREYxZzlZcGM3RHBmNjZZLzY0Rm11UkYyQ0kvVGdn?=
 =?utf-8?B?RENMSjlLbW1nS09PUzBjL0pnNzZEZHVWMVRsc09LMGFUWlRhVFpQZ0ljN1pW?=
 =?utf-8?B?QVdjM1BkSStJbmc4YWZPNHhSdXJIcHhXbVc3R3dxWk1yQkxFaXpLdndUQWVN?=
 =?utf-8?B?T0lLa3daTmpYUC94RVhsNWd4NitnQlRaMjRVMmswQ0tobHF1dFowMy9ZamNt?=
 =?utf-8?B?QlB5b0tkTjdJczNJK0NQSjkyNEpYVjV3b0RRcGF3bkVSK1dpWDMxNFJHMmNy?=
 =?utf-8?B?ZDdmMjJlbUs5eS8xMzQ0amZaTkd2Sk1jSEIyUFdMRmhBYldMR1JaTWdqSk9L?=
 =?utf-8?B?S0Z6bzk0cFAwY012MlBxNEdUWjU4ZDJVMW9qT3FtMXRja1FHTXdnUHE3QWkx?=
 =?utf-8?B?ZnROZ2NNZnorSjNhRGpvcXprbUFUZ0NYY1dLczJ0eE5mMGhqU3JwL1AxUE9w?=
 =?utf-8?B?K1NGUVg1ZnZ0ZlpmOFAwcTNWdlpIMkgxV1JrUjVWTWY3OEk1VlNyWExLVk1p?=
 =?utf-8?B?RmJ0R2U3Q2VQWFhSSlBKNkIxbjhqeDR2RWhxNnI4MUVOcUtVWFFWb3VuTzNs?=
 =?utf-8?B?c1lxTnFBUkdlbkwwTkNGbExuVTZhSzF5RXRGa1B3cXNDUDNteU0vN0d1clNn?=
 =?utf-8?B?b29POWZHWWFDNElDYi9LWmR2bVVhU0lZa0ZCZUpoWEF0eFNmUXg3YzVTa0lR?=
 =?utf-8?B?V20xd2dVS2drSkR1Y0xwV3NKbVlnZGxiai9VeGVnU1I1T04xYjUrclRnV3hZ?=
 =?utf-8?B?UjNVNVpxa002Ni9oSVZzL2xoWmpuU1lvMStzZHlENHRUMGtBTjhVcFU5L3Q4?=
 =?utf-8?B?eEpyQ0ZkNzAzZ0F5VklOSDY3R0xCdjVQbFIyb0F4RWxRcGtEMjkwSUhoT29j?=
 =?utf-8?Q?AK/pxApk7HHHSpFaxJJdMQyALQxm4F9fLYWw9Ep/oEAvT?=
X-MS-Exchange-AntiSpam-MessageData-1: E580vyehkcbpGA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e93cdc-f7d8-4a4d-bf50-08debf830429
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 02:10:56.6401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPU+KgBA1EhZbxs7lsO1a3M96kfvnp3PC6nJlcOWO2ZYyF5sKi88HTKzPrdxGTYA41Lh3Ki6Up5OaiXriDP/pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9781
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
> ---

It seems that in openrm and nouveau AFAICT these two cleanups are both
done regardless if either fails.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

nit: it seems odd to me to log on fwsec-sb failure but not on booter
unloader failure.
