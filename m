Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54666C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F71D10FA8C;
	Tue, 15 Sep 2026 07:40:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="U3YjFnCG";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013037.outbound.protection.outlook.com
 [40.93.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 675B710FA8C
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 07:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kvflh2tcMVuF6ZxcCXPXKRXE5T0fBk+t+OsJ//7UdgfWFDHlpy3dUMdKuAJcat+HT0uCSLuPiyMbXk9oSAvQDmgyhWCpXsOF9mUytlbMOt8nw79egPVCuNcUlD6mI2ZIiQWD9H6YJ6v0+7VFWYiGt+83uGxV7hmgE3Ayw9ijosTrW7bCwwhiZL7axlkdgxbNXzJxRP7ZO1m2lM5TQ+4jfiKUydjDpe01e1WvGXoiwyUtv3SdYLnCyG5D6wJPF4IUC0B2cuDHCNFprpGVYeCMEi0MAn0mBbhEklUJMyu7MN8DND+tthESMliVJK9Qq8/cEaIkBPaoiHv9uIDDJrm5TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3YEw6fw7TZ1bnVYrHG2KZTnTuIGR684yGfO9JdlAJQ=;
 b=KtixcT9GqNbt42YiPPS0Qud9gI//3EUnzzEw12kip4GYIHdeUuC8C7UcHmnOOV8L/8uOrvwjpig6Zh0wsyPGzf/VAHe31XYl0zQiY8qnlZdS0JbjzCdqis5I/j209hpWq3xFaVIZ3/gD4r1DrJERJ4kV+zZOcE2kfUH/kbcS5svlhLGcKGq4RZLUX/0SGfJWBrpRWXWis/wUfseC+uorRwk4YTdleLZWT6tCYy/MCqBIfhcLK4GmFKRxOZkKfAMwJiOQJEo+9trydce+bzEH+EKlE9U6+6Hfqsa+IlJreMX6TOaJgGkztfLqXcb8ZQG9pE5AqFrbUbKwhSqOxky+uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3YEw6fw7TZ1bnVYrHG2KZTnTuIGR684yGfO9JdlAJQ=;
 b=U3YjFnCGHGj4PJediLtN9iQiZ2xqJflqKOGVze/q/sujos05o12+evOFX4cwl0dZvUuYhmY8B/y09XJQ0GduUmm3jZ0th8dr4s9JIP4qXlD6JAL2qaUNfMp1ZV7E3jgjnwhV8acDW5o7JzKD/ieexRuXeNzbANjEXTAw7+klQpkUww/d1b0voTaT7hPeC5mM9FUAhDmOJJXN69mpPEGBSgPp7Lu83kcYa6V1qTp6Cx7pTRBb/BlMITMgzxMzXDzcX2N96VUS4UtMtUbC1i6EHHI0EY2QvrtxAT2o0oTfBelDatgT1U6fSoosl6DCx5+H5hqXX/QbyJg99M2aURAQfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM3PR12MB9436.namprd12.prod.outlook.com (2603:10b6:8:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 07:40:15 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 07:40:13 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Sep 2026 16:40:10 +0900
Message-Id: <DLFPX99IXAOX.39ZAHT24TBD3O@nvidia.com>
Cc: "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3 2/3] rust: prelude: add `num::cv`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260902-cv-v3-0-0f90659e711d@nvidia.com>
 <20260902-cv-v3-2-0f90659e711d@nvidia.com>
In-Reply-To: <20260902-cv-v3-2-0f90659e711d@nvidia.com>
X-ClientProxiedBy: FR3P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM3PR12MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: e7c48e60-89a7-4fcc-40b5-08df12fc940b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: VwplJvDX9xGBk5t+VTIXtpGC3DGilF7j/1to4ekElK69zg14h2Q+Z2jS+7lOu9w4Z6eJXyFgvkDvMhEFEnRMmb4F1IIkbHGlzQ87YqEwTMW+7LdacV4PHNjHIxd3w/AiqKaYkdKwuAvCU82WycuWyiW8HeLHViPwKK0vHm1WD7NJrxwNN5dxJj5lIcEpMm3ltEy1Ef9DcOs/osFx0C3po/H5Vvzp+3+c7Nl2f/Syx+9wzJ6aqIFA4zSOd/wi5ZgEHSqYi3kb5SExJhJXoOeQVUx97LSHrf2NW3pyo1Qtu+eUosgrmXcjjEmZT72xeZqVxsIleRW+a4fc/iCgDTns73padq3xaVg9vVQDIRkbF1ZAZDLYC8gCbyo1mrKe0xUb4PgjUkeid7hqE2xj+gTp02+QXqUUEf/EIwjIIuAgfNLBSn93rTu6BJvQ42l/evD4IpZ9bgfLuvYF2rPTuabPV3oxGCdjBuxgPPj8M1ZkPm8Yc9WCCkNHL1vsmG32OBKfKBvmif3BGD09jXMYzc+zYKoBytWdxQzUIMlxLJ/aQ1WZLsV/jmy7UaLpubusFNCfpSzMj9nEHyjhYRqt+DLZHFUCXjs1Duv5fgIXgVVvNHiJ4bHyXBDh/8NY5FojZfnN87D2Rl55kGFOT6qQGUdnKqwdBfesJ0jf4XxGc+aSUpw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3RialR2Q0ROd0x1aEJtUUROKzF3VEt0ZERXK2xCMS9CY0RxZXVWUzUvUkJ5?=
 =?utf-8?B?NGpyRytIUE1ncTNiTC9IbTlpN3BaZVNSYU9XWC8vSWRiYWR4bWhWZUlQQjNl?=
 =?utf-8?B?TUhPT0liRTdTQzFZb1k2ZUNvODdESDBDL3dYc29VY0lENk5Bcm1lcjdnL3gw?=
 =?utf-8?B?K3ZvMEVjQXByVDRIakdzZFNQWjhJcG02ZXE2Y2pJbjZDdmJmS2t3VnNyVFZM?=
 =?utf-8?B?enhjT3FKRUFXZVU1T0lRK1FWZlFWdk5KYWFVMjhoSEUwVzd4TWNhdXRNbDNW?=
 =?utf-8?B?STZKYjkzR0hJYVl5VUR5Z1p6TTM5MzdEaEppN09iWFpvdmxIRFhEMnVjd3Ru?=
 =?utf-8?B?OFoyRWhKNG41U0dOdmlpaTNVelVjekRDYkx6SXQwMWlNOW56TUxUdWZld09E?=
 =?utf-8?B?ZTdrZWlCd0prOXFzeUF3NFNDTVpWZ0E2ekhqOUp2NUVjWlpZMHNZZTl1SHhZ?=
 =?utf-8?B?SlJ3T2JEMnhIc0dFR3R2MTBQVnZGcjQxU0ZFeC9uK2JFV1VDMEtxT3VJM05W?=
 =?utf-8?B?RGVwS0pua1RpZHpDVlMxeDZXb0JVNjRQMktNZjJLTThuYkc1ejN6Z25Eb3VF?=
 =?utf-8?B?NTZDcFdZS1ZNWCtsRWliSlRnK2dBSW1aRWxlY1FBeGRVK0UrWHRNTlFia1FX?=
 =?utf-8?B?Rlhxd3VaYXlFMjI0cWY1RDJpSHo4TllFZDdEM3h0ZDdEUEpsbkVVUjQxOWpS?=
 =?utf-8?B?ejh5ZEFtM2ZBYjdqbmdwOUtXY0piNGtJazY1MG51c1pGVjJFc0JvNmp6di81?=
 =?utf-8?B?U3lwQWJBSWdMRnBCVUxvR3VMYXFOK216SlJrODZKaTI4K1lwZVFCclYvNVNu?=
 =?utf-8?B?d3Bac2RoK2FMeFZibDlna2szTmpBb1I2L1hLVDBCN0xOQStSYXJyM0NkdVpO?=
 =?utf-8?B?WWU3aTA0RlhUYlJPYkdITTdPT0dKUUNnbUNpM1BmNXgrNDhlWnV2bTkraTJn?=
 =?utf-8?B?cGRyTGlGT2ZLVElhY0JyTVRxTDRVTndUM24wWVNHWWRpZksvTUpoazExVTlv?=
 =?utf-8?B?OS9uT0hzR092MCtiRTlvcndVTGpwajQvaGR3T0g5d2dRK0s4YXdCQUdsNEd4?=
 =?utf-8?B?OC9xSTdVR2xmdTZ6Nm9pemxYMDdPemtJVnhaelVpMlhDdFBXU0M4Z3pyeUNU?=
 =?utf-8?B?dFpHR1dJQmVaRlRRb2ppazV0WU4rc2tOM3dxc3pyWnFzb0JUWHBTMlVSMmZD?=
 =?utf-8?B?NEtYa2xBWkpGcFNHcnUxcUZvODdHdjZIdzVCMFJkemkwVEszSG1hZWw5YXlt?=
 =?utf-8?B?eUhITHptSE1LOWlTYXhoRXozK05MaVlndGEwbXd6dG5FUm4zeG40Rk9xU285?=
 =?utf-8?B?NmRJWVY2VmNGUTZsSTRIMmFYVDduZUFGMzIrbjdxWVdZWEkrSnRiRnQ1cUIz?=
 =?utf-8?B?d1hpU0JTUFBxY0d5WGdWMXExaFVtaTZyamJZUUJsaHQ1Z0hONjg3eFNIaTJ5?=
 =?utf-8?B?MXR1QnRRNGt3UzBnSWhKbUxpUHVja1NTS3MzaERSOGxBQ3lxZVhrOXR6Wkto?=
 =?utf-8?B?b3BsWXpCYzhheitQWXIwVjIwRWo2QTYzOW5iWjEzYlZ1VUs1SEYrOVlMM3JV?=
 =?utf-8?B?MVZyTEZOUDlsQ0twOHlBS1lRL3VkTjdKOFlBMGp1d2ttZ2dzbUtlZnRYNEtQ?=
 =?utf-8?B?NmpDZElvcVY5NlMvcjVVQmxLd2xNeENDYWduaXY0djNUdjFDYkNZYmFEY2JF?=
 =?utf-8?B?ZU1YNFJvZW80dzkwYXhGc0dvN1I1c25XK2hBY1c4QnEwelFEZkJ3VGNxRzJv?=
 =?utf-8?B?NzlTVnVESFlmVEZ2cUNYYzNWVnNxZ2hrNUliMk1CMmZuQmsyZS9aWkJ3M25T?=
 =?utf-8?B?bnFQbDZCTVZmdGlialB5M1NOWEN6VXF1V0dwWW1qNktqalc5YW8vNTVNdHoy?=
 =?utf-8?B?Y0dKWndtUlJQWDdvM0J5WWNnbnY5QVNEVHh1bDJScVExQ2ppeWhyYThWYkRJ?=
 =?utf-8?B?UVorVVd4SnVPYmo0eXpoSExhbklBNFBWeVhFcC9sc01nSmpKMFFGcTNaTjkr?=
 =?utf-8?B?SUVlYzBPYm5kSnVyVmpUUVI1cG85QXFKcko0eWpPOFQzY2JycjhOV1Zhc3dB?=
 =?utf-8?B?dnpyS293eFNxNlBaYjJZZ2dhRTdKaUx4RnlNOU5ZWG1wM2JrN252c3J0WWJi?=
 =?utf-8?B?YmhZMUExNW0wK3N5N0Q5U2dlSy9KN1Z3M0FiUFNNbVBqbDI5ZjNiN0dwVUIx?=
 =?utf-8?B?dWhxTnoyRDNLMnU3aWpsRXBWcUJrblFnU1l2Z3czeDFmZHFxUWRGcG9uN0lB?=
 =?utf-8?B?bjlyZ05UYWV5VlF6LzY0cElCeEI1RjBUcC90UVVyeFRNWEZ5c3dTdjRRaito?=
 =?utf-8?B?RHM1a2xZQS9LYnhKNkxvcTladlhwYjN6VWxZTTlGdWI3bVYwY2t6UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c48e60-89a7-4fcc-40b5-08df12fc940b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 07:40:13.6125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zW38K5PxePsEtH1yNI+X3UfjDl10yOpSewFxEeV/Wqn0vq5eMRbZusMjnlYP0V+9wi7WB3h2mXVFplOzlfWoZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9436
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

On Wed Sep 2, 2026 at 6:16 PM JST, Eliot Courtney wrote:
> Add the `cv!` macro to the prelude so it doesn't need to be imported
> explicitly to use it.
>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

I believe this can be squashed into patch 1, there is no need for a
state where `cv` exists but isn't in the prelude if we agree it should
be there.
